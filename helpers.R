if (!exists(".inflation")) {
  .inflation <- getSymbols('CPIAUCNS', src = 'FRED', 
     auto.assign = FALSE)
}  


adjust <- function(data) {

      latestcpi <- last(.inflation)[[1]]
      inf.latest <- time(last(.inflation))
      months <- split(data)               
      
      adjust_month <- function(month) {               
        date <- substr(min(time(month[1]), inf.latest), 1, 7)
        coredata(month) * latestcpi / .inflation[date][[1]]
      }
      
      adjs <- lapply(months, adjust_month)
      adj <- do.call("rbind", adjs)
      axts <- xts(adj, order.by = time(data))
      axts[ , 5] <- Vo(data)
      axts
}

ma <- function(arr, n=15){
  res = arr
  for(i in n:length(arr)){
    res[i] = mean(arr[(i-n):i])
  }
  for(i in 1:n-1){
    res[i] = 0  
  }
  res
}
