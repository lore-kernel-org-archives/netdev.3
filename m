Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AFBA3D0BE9
	for <netdev@vger.kernel.org>; Mon, 20 Jul 2026 22:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784588010; cv=none; b=SyjD+qOt52Cnl1jElWBtou6sZHym6xoURrsOnKvXD8TcPwCvmoKN0fuvDRKEz8bhlpxXXgye2jxKz8tcW41A6ZkGSoirGSknt/NCM2WLSH2p4rXraAoB1YiM1zlnD36ma2x9d3MN63l8I7kRYy/VcdTD3rKUA6+zTRipR/PYWsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784588010; c=relaxed/simple;
	bh=bu9MxjR9PrOS7jFoOtI1kzXfsfiOmCRm8agej7/N0eo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rTpqldXsDCj/hlmJOdWaB1o/x4v88PVo9M3/Bnh40g/IJsp3qG0qoCeqAwcePIOVfAO3+EnmL0NupcI/j477r/rlVOiU+TE1S3qiDSrubo4uYn4QU9ptZVKML23x+8hOjmYuMNioYU5UbzC5qTU0hMwt7IS9ppgdyHDYufJJxo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qYSw80KT; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qYSw80KT"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-49547fc63a0so17102605e9.2
        for <netdev@vger.kernel.org>; Mon, 20 Jul 2026 15:53:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784588007; x=1785192807; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xaOVkEmI94bSxjGZP8o0unCsarNml6GU1QHwiTIhRTw=;
        b=qYSw80KTcXhIsJmoJ5JfON/ZxwRG+mIFCHhz0GXnMIKkdeasNRh7vNze6MBfOEposa
         ++dLmsCTry0xU1SjRxFQe/iefs90QH8vaVGsdmKmiW3R4joATlDAIFNEbw88Xf/wrEVK
         BeGSGKoV3E5Ss9F+q875gSOhct7T82AS1x33wgxoVTnPag58GrSmvjOWWGMFb2a4c2cZ
         OAGg4nZEDCbZcwLpwHcsqxtJmoqJEdjkeNCDpadXX/Jk3ctlqFBq1aGZTGtKRVJjJTw+
         IR9cahOCrpScwJ+O+vuWNNQ13+OQJCWftAnL7Ys9zFKwo43UERC1T9RVOHG4+v8UHgD7
         pYZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784588007; x=1785192807;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xaOVkEmI94bSxjGZP8o0unCsarNml6GU1QHwiTIhRTw=;
        b=l2+JsEYGAcEFBQWDeus4wSbMfBXiSIeGrXYn8EMI2Ah45sv9S9Pog7FYj673Hwjwer
         Yc0+P24lZcGr9J49WkTVzj3DKcX550wO5tGuNytICWPxSNhLQwdGNlDTr2Y9HN+Tap4b
         pKEl3nmGE9oJd7cSxiQjVgg1eOYUxzuws+1AD7RSJPBOOzptj/vbmBt2NI7lqGu+VbaE
         loejQFatj1kTIRQYnb21lDnd3wOxeau+RK3tCxGkgx4j3uFg+nvZOqgcq0rEucS8e8ln
         flBQKr1O1wJWq0iIPi1F2jC2aXOqaSQKkYzn3o/6NZwuFJcwlyfhzPCPup2au7kOWhlU
         t3eg==
X-Forwarded-Encrypted: i=1; AHgh+RoVQ5fI7bnEFveOTQKZGmQMmwhKVAP7rKS0j0CI1ygWQGwlj3EJtjv3wk8tNyY1s/E8tSViwqI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzB4cDrIQwI2458vOPHkZXsWBSw3Jqh7TrhgIxLYAwq/D0ZdE51
	qawbp9Eya3UPKyli7hKkdayaDGUR/3funYZF5hRcPnucFCcCaVSeBbcQ
X-Gm-Gg: AfdE7clc/Z2c5UAwG0BbKGFk+ic4RLXirqFMPeHwsdvKDESZl+HbAhRHxT3MzDFRUJx
	ZApQxMyxnO0k7aDVtcRGDNHCAiKlCTcuhgqX+zqoUdF8boG6xNnJPBYiPMqNPk7PjiR/Db+7sNk
	9B4THECweQ9yzno+4XAmQVER+pe2Viz0iObGkF3jMfMD0KUk4iUdaLjTWHGoOg9JWQZ06R3kdJX
	uCAobalbHK3rbpyFdjGlPxYfUKY9UsKQnAAsxDP5KtrzA9c8v/lb5tj1e71ac9u+b8u0UmSOyBv
	kmMxscDJ+qULtrfjkaVMQSS3xXXUkqb3rfrq6iUu6oev6GKSs98wi47pYTAXQbnhgLzfOMEJDLj
	tZIFt1z1C1tIZ2kTOYyUOHhLqLY2lhKBNgZJ5h4kpd1+3+Bs+5pWqk7LyGL0RbiT7n8xFd0MqyI
	+/48V35QfDbNw4BE+jLxmp2uyRPktT9vrlkchRW/Poniopjf1+f0GUH/Hak2ntesuA47zx3pv16
	o7/
X-Received: by 2002:a05:600c:1f82:b0:495:607e:5ee7 with SMTP id 5b1f17b1804b1-495607e635amr51345645e9.17.1784588006289;
        Mon, 20 Jul 2026 15:53:26 -0700 (PDT)
Received: from localhost.localdomain (host86-153-201-25.range86-153.btcentralplus.com. [86.153.201.25])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f63e499c2sm31525849f8f.4.2026.07.20.15.53.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 15:53:25 -0700 (PDT)
Date: Mon, 20 Jul 2026 23:53:23 +0100
From: Nnamdi Onyeyiri <nnamdio@gmail.com>
To: Emil Tsalapatis <emil@etsalapatis.com>
Cc: bpf@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	horms@kernel.org, jakub@cloudflare.com, jiayuan.chen@linux.dev, 
	john.fastabend@gmail.com, kuba@kernel.org, kuniyu@google.com, ncardwell@google.com, 
	netdev@vger.kernel.org, pabeni@redhat.com, sashiko-reviews@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 1/2] bpf, sockmap: handle spurious tcp_msg_wait_data()
 wakeup
Message-ID: <al6iBv_Yn4YSCmWc@localhost.localdomain>
References: <20260720171535.67867-1-nnamdio@gmail.com>
 <20260720171535.67867-2-nnamdio@gmail.com>
 <DK3PKY6RN5FI.4DKPSHWNEBHM@etsalapatis.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DK3PKY6RN5FI.4DKPSHWNEBHM@etsalapatis.com>

On Mon, Jul 20, 2026 at 05:16:08PM -0400, Emil Tsalapatis wrote:
> On Mon Jul 20, 2026 at 1:15 PM EDT, Nnamdi Onyeyiri wrote:
> > recvfrom()/recv() are documented as only returning EAGAIN for blocking sockets
> > when they have a receive timeout configured.  However, adding a blocking
> > ipv4 tcp socket without a receive timeout to a sockmap will cause EAGAIN errors
> > sporadically.  A socket with a receive timeout may return EAGAIN before the
> > timeout expires.
> >
> > There are 2 code paths affected by this:
> >
> >   1. tcp_bpf_recvmsg() - Used when the socket has been added to a sockmap
> >      that has no verdict program attached.
> >
> >   2. tcp_bpf_recvmsg_parser() - Used when the socket has been added to a
> >      sockmap that has a verdict program.  To reproduce this issue, it is
> >      enough for the verdict program to do nothing but return SK_PASS.
> >
> > In both cases this happens when tcp_msg_wait_data() wakes spuriously
> > (returning 0).  To fix it, we now loop back to msg_bytes_ready instead
> > of returning -EAGAIN on spurious wakeup.
> >
> > To ensure the looping does not cause sockets with a SO_RCVTIMEO set to
> > wait excessively long, tcp_msg_wait_data() now takes a pointer to timeo,
> > allowing sk_wait_event() to update it as appropriate.
> >
> > The logic in tcp_bpf_recvmsg_parser() that allow it to handle signals,
> > socket errors and closuers in its loop was also added to tcp_bpf_recvmsg().
> >
> > Signed-off-by: Nnamdi Onyeyiri <nnamdio@gmail.com>
> > ---
> >  net/ipv4/tcp_bpf.c | 69 ++++++++++++++++++++++++++++++++++++++++------
> >  1 file changed, 60 insertions(+), 9 deletions(-)
> >
> > diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
> > index cc0bd73f36b6..aa5c5d741599 100644
> > --- a/net/ipv4/tcp_bpf.c
> > +++ b/net/ipv4/tcp_bpf.c
> > @@ -179,7 +179,7 @@ EXPORT_SYMBOL_GPL(tcp_bpf_sendmsg_redir);
> >  
> >  #ifdef CONFIG_BPF_SYSCALL
> >  static int tcp_msg_wait_data(struct sock *sk, struct sk_psock *psock,
> > -			     long timeo)
> > +			     long *timeo)
> >  {
> >  	DEFINE_WAIT_FUNC(wait, woken_wake_function);
> >  	int ret = 0;
> > @@ -187,12 +187,12 @@ static int tcp_msg_wait_data(struct sock *sk, struct sk_psock *psock,
> >  	if (sk->sk_shutdown & RCV_SHUTDOWN)
> >  		return 1;
> >  
> > -	if (!timeo)
> > +	if (!*timeo)
> >  		return ret;
> >  
> >  	add_wait_queue(sk_sleep(sk), &wait);
> >  	sk_set_bit(SOCKWQ_ASYNC_WAITDATA, sk);
> > -	ret = sk_wait_event(sk, &timeo,
> > +	ret = sk_wait_event(sk, timeo,
> >  			    !list_empty(&psock->ingress_msg) ||
> >  			    !skb_queue_empty_lockless(&sk->sk_receive_queue), &wait);
> >  	sk_clear_bit(SOCKWQ_ASYNC_WAITDATA, sk);
> > @@ -229,6 +229,7 @@ static int tcp_bpf_recvmsg_parser(struct sock *sk,
> >  	int copied_from_self = 0;
> >  	int copied = 0;
> >  	u32 seq;
> > +	long timeo;
> >  
> >  	if (unlikely(flags & MSG_ERRQUEUE))
> >  		return inet_recv_error(sk, msg, len);
> > @@ -262,6 +263,8 @@ static int tcp_bpf_recvmsg_parser(struct sock *sk,
> >  		}
> >  	}
> >  
> > +	timeo = sock_rcvtimeo(sk, flags & MSG_DONTWAIT);
> > +
> >  msg_bytes_ready:
> >  	copied = __sk_msg_recvmsg(sk, psock, msg, len, flags, &copied_from_self);
> >  	/* The typical case for EFAULT is the socket was gracefully
> > @@ -280,7 +283,6 @@ static int tcp_bpf_recvmsg_parser(struct sock *sk,
> >  	}
> >  	seq += copied_from_self;
> >  	if (!copied) {
> > -		long timeo;
> >  		int data;
> >  
> >  		if (sock_flag(sk, SOCK_DONE))
> > @@ -299,7 +301,6 @@ static int tcp_bpf_recvmsg_parser(struct sock *sk,
> >  			goto out;
> >  		}
> >  
> > -		timeo = sock_rcvtimeo(sk, flags & MSG_DONTWAIT);
> >  		if (!timeo) {
> >  			copied = -EAGAIN;
> >  			goto out;
> > @@ -310,13 +311,15 @@ static int tcp_bpf_recvmsg_parser(struct sock *sk,
> >  			goto out;
> >  		}
> >  
> > -		data = tcp_msg_wait_data(sk, psock, timeo);
> > +		data = tcp_msg_wait_data(sk, psock, &timeo);
> >  		if (data < 0) {
> >  			copied = data;
> >  			goto unlock;
> >  		}
> >  		if (data && !sk_psock_queue_empty(psock))
> >  			goto msg_bytes_ready;
> > +		if (!data && timeo > 0)
> > +			goto msg_bytes_ready;
> >  		copied = -EAGAIN;
> >  	}
> >  out:
> > @@ -355,6 +358,7 @@ static int tcp_bpf_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
> >  {
> >  	struct sk_psock *psock;
> >  	int copied, ret;
> > +	long timeo;
> >  
> >  	if (unlikely(flags & MSG_ERRQUEUE))
> >  		return inet_recv_error(sk, msg, len);
> > @@ -371,14 +375,59 @@ static int tcp_bpf_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
> >  		return tcp_recvmsg(sk, msg, len, flags);
> >  	}
> >  	lock_sock(sk);
> > +
> > +	timeo = sock_rcvtimeo(sk, flags & MSG_DONTWAIT);
> > +
> >  msg_bytes_ready:
> >  	copied = sk_msg_recvmsg(sk, psock, msg, len, flags);
> >  	if (!copied) {
> > -		long timeo;
> >  		int data;
> >  
> > -		timeo = sock_rcvtimeo(sk, flags & MSG_DONTWAIT);
> > -		data = tcp_msg_wait_data(sk, psock, timeo);
> > +		if (sock_flag(sk, SOCK_DONE)) {
> > +			ret = 0;
> > +			goto unlock;
> > +		}
> > +
> > +		if (sk->sk_err) {
> > +			if (!sk_psock_queue_empty(psock))
> > +				goto msg_bytes_ready;
> > +			if (!skb_queue_empty(&sk->sk_receive_queue)) {
> > +				release_sock(sk);
> > +				sk_psock_put(sk, psock);
> > +				return tcp_recvmsg(sk, msg, len, flags);
> > +			}
> > +			ret = sock_error(sk);
> > +			goto unlock;
> > +		}
> > +
> > +		if (sk->sk_shutdown & RCV_SHUTDOWN) {
> > +			if (!sk_psock_queue_empty(psock))
> > +				goto msg_bytes_ready;
> > +			if (!skb_queue_empty(&sk->sk_receive_queue)) {
> > +				release_sock(sk);
> > +				sk_psock_put(sk, psock);
> > +				return tcp_recvmsg(sk, msg, len, flags);
> > +			}
> > +			ret = 0;
> > +			goto unlock;
> 
> These two error handling routines above look identical. Can you refactor
> them?
>

Will do.  My understanding is the same logic is needed to address the
issue Sashiko raised with the SOCK_DONE check as well.

> > +		}
> > +
> > +		if (sk->sk_state == TCP_CLOSE) {
> > +			ret = -ENOTCONN;
> > +			goto unlock;
> > +		}
> > +
> > +		if (!timeo) {
> > +			ret = -EAGAIN;
> > +			goto unlock;
> > +		}
> > +
> 
> Since this handling (which Sashiko flags by the way, correctly AFAICT) 
> are taken from tcp_bpf_recvmsg, there is obvious overlap between the two
> functions. Please factor those out so that they share the logic between
> them.
> 
> pw-bot: cr
> 

Sashiko highlighted the "if (!timeo)" and signal_pending early returns
when MSG_DONTWAIT is set, but I think I'm missing part of the picture.
By the time we reach these branches, haven't we already checked for data
in sk_receive_queue (line 372, after the patch is applied to 7.2-rc2)
[copied below for ease of viewing]:

    if (!skb_queue_empty(&sk->sk_receive_queue) &&
        sk_psock_queue_empty(psock)) {
        sk_psock_put(sk, psock);
        return tcp_recvmsg(sk, msg, len, flags);
    }

and in the psock (line 382) [again copied below for viewing]:

    copied = sk_msg_recvmsg(sk, psock, msg, len, flags);

> > +		if (signal_pending(current)) {
> > +			ret = sock_intr_errno(timeo);
> > +			goto unlock;
> > +		}
> > +
> > +		data = tcp_msg_wait_data(sk, psock, &timeo);
> >  		if (data < 0) {
> >  			ret = data;
> >  			goto unlock;
> > @@ -390,6 +439,8 @@ static int tcp_bpf_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
> >  			sk_psock_put(sk, psock);
> >  			return tcp_recvmsg(sk, msg, len, flags);
> >  		}
> > +		if (!data && timeo > 0)
> > +			goto msg_bytes_ready;
> >  		copied = -EAGAIN;
> >  	}
> >  	ret = copied;
> 
