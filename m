Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EA253F8230
	for <netdev@vger.kernel.org>; Fri, 17 Jul 2026 12:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784291488; cv=none; b=Fx79HB8Eklim2iugO06bOk4FbUZajBjP+LQpUk1HDGHKLYyXXC4pR/u44do0yfZ0nhqhIIJzFTuUSd82UU+3Z/fUAWtmK89Jqo6OCnBKkyKpUemLuBB6twqtu3zUWi5h8fb/IV3OouPPNXSANZOTWnLK7aayqFO1MBs4ylgbEe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784291488; c=relaxed/simple;
	bh=9ihkX96AEO3E4UL3DxCH/YX9FZjIWFO5pZ+n6t1PKvY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WDVyfBn30/vOyKgserCI11SMrNyNTA5sg6lIAG+R/Gfl1VWT21UikvjXpFgB3fr/rfMSPIb3sgP+ns2zBi7K0oXHDdm2P7wjum8+3/tYgMt9ykOK94Z9veaUU9GcZfRyLHMfHye/k8HOX/BUht/o5bQ0cmJIFKJ8F2v+bNsSERc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=TFGYsAzL; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="TFGYsAzL"
Message-ID: <e4820c25-7598-472a-9c85-57335a382e32@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784291483;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lNHNxFFwUQ+jQpBtBP2dwYsADgS4XCDnMNgzBkbdK7Q=;
	b=TFGYsAzLyU3qgH70zufklpAa9QjsFsGU5AXaDN21BAMoUWZwd9L4VEhkGNkxJz4b5BH8Jq
	zxw0RYVi090P6do9CTQnVBDIOJCoB3T60oTgX4ocPS51pDCnVWazNUPwT8Sa0Skcx6l1Ht
	/WxDPH1qR18bStzXwiGxyxG1h0u3BZE=
Date: Fri, 17 Jul 2026 13:31:17 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] net: use sync wakeups for socket error reports
To: Breno Leitao <leitao@debian.org>, Eric Dumazet <edumazet@google.com>,
 guohua.yan@unisoc.com, xuewen.yan@unisoc.com
Cc: davem@davemloft.net, horms@kernel.org, kuba@kernel.org,
 kuniyu@google.com, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 pabeni@redhat.com, willemb@google.com, shakeel.butt@linux.dev,
 hannes@cmpxchg.org, riel@surriel.com, kernel-team@meta.com
References: <20260708133815.3419465-1-usama.arif@linux.dev>
 <ak5rH-SWjiqR6MVe@gmail.com> <bc16e45e-32ef-45d8-99af-14f088733ab3@linux.dev>
 <CANn89iLc1Bv_wmKvr_9mtGRM3gL7kgoy2Prr2SgtHY4C=ZgfBg@mail.gmail.com>
 <alodxQoCH5A5iVGG@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Usama Arif <usama.arif@linux.dev>
In-Reply-To: <alodxQoCH5A5iVGG@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 17/07/2026 13:20, Breno Leitao wrote:
> On Wed, Jul 08, 2026 at 06:32:02PM +0200, Eric Dumazet wrote:
> 
>> Perhaps this SYNC heuristic should be a per-socket choice so that
>> applications can decide what is best for them.
> 
> Something like this?
> 
>     net: add SO_ERR_WAKE_SYNC for sync error-report wakeups
>     
>     sock_def_error_report() wakes EPOLLERR waiters with
>     wake_up_interruptible_poll(), while sock_def_readable() and
>     sock_def_write_space() already pass the sync hint. A socket with
>     SO_TIMESTAMPING enabled delivers every TX and ACK timestamp through
>     sk_error_queue and raises EPOLLERR, so the error path wakes a sleeping
>     consumer very often.
>     
>     Without the sync hint the scheduler often places the woken consumer on a
>     remote CPU, which costs a rescheduling IPI. Usama Arif measured 16,326
>     such IPIs/min on a 176-core host running a production workload with
>     SO_TIMESTAMPING enabled. [1]
>     
>     Switching the error path to a sync wakeup unconditionally is not the
>     right fix, as there are different requirements for it to be async, see
>     [2].
>     
>     Eric suggested that an options is to add SO_ERR_WAKE_SYNC so
>     applications choose per socket, so a consumer draining a high-rate error
>     queue can opt in to keep the wakeup local and drop the IPI, using socket
>     flag SO_ERR_WAKE_SYNC.
>     
>     Link: https://lore.kernel.org/all/CANn89iLc1Bv_wmKvr_9mtGRM3gL7kgoy2Prr2SgtHY4C=ZgfBg@mail.gmail.com/ [1]
>     Link: https://lore.kernel.org/netdev/20260526063650.952-1-xuewen.yan@unisoc.com/ [2]
>     Suggested-by: Eric Dumazet <edumazet@google.com>
>     Signed-off-by: Breno Leitao <leitao@debian.org>
> 
> diff --git a/arch/alpha/include/uapi/asm/socket.h b/arch/alpha/include/uapi/asm/socket.h
> index 5ef57f88df6b3..2a3c27aaf4e95 100644
> --- a/arch/alpha/include/uapi/asm/socket.h
> +++ b/arch/alpha/include/uapi/asm/socket.h
> @@ -155,6 +155,8 @@
>  #define SO_INQ			84
>  #define SCM_INQ			SO_INQ
>  
> +#define SO_ERR_WAKE_SYNC	85
> +
>  #if !defined(__KERNEL__)
>  
>  #if __BITS_PER_LONG == 64
> diff --git a/arch/mips/include/uapi/asm/socket.h b/arch/mips/include/uapi/asm/socket.h
> index 72fb1b006da93..00f31c74a63df 100644
> --- a/arch/mips/include/uapi/asm/socket.h
> +++ b/arch/mips/include/uapi/asm/socket.h
> @@ -166,6 +166,8 @@
>  #define SO_INQ			84
>  #define SCM_INQ			SO_INQ
>  
> +#define SO_ERR_WAKE_SYNC	85
> +
>  #if !defined(__KERNEL__)
>  
>  #if __BITS_PER_LONG == 64
> diff --git a/arch/parisc/include/uapi/asm/socket.h b/arch/parisc/include/uapi/asm/socket.h
> index c16ec36dfee6b..db5b6cad17d49 100644
> --- a/arch/parisc/include/uapi/asm/socket.h
> +++ b/arch/parisc/include/uapi/asm/socket.h
> @@ -147,6 +147,8 @@
>  #define SO_INQ			0x4052
>  #define SCM_INQ			SO_INQ
>  
> +#define SO_ERR_WAKE_SYNC	0x4053
> +
>  #if !defined(__KERNEL__)
>  
>  #if __BITS_PER_LONG == 64
> diff --git a/arch/sparc/include/uapi/asm/socket.h b/arch/sparc/include/uapi/asm/socket.h
> index 71befa109e1cf..5e9ff3634265c 100644
> --- a/arch/sparc/include/uapi/asm/socket.h
> +++ b/arch/sparc/include/uapi/asm/socket.h
> @@ -148,6 +148,8 @@
>  #define SO_INQ                   0x005d
>  #define SCM_INQ                  SO_INQ
>  
> +#define SO_ERR_WAKE_SYNC         0x005e
> +
>  #if !defined(__KERNEL__)
>  
>  
> diff --git a/include/net/sock.h b/include/net/sock.h
> index 51185222aac29..d8ee1dae8ecaf 100644
> --- a/include/net/sock.h
> +++ b/include/net/sock.h
> @@ -1022,6 +1022,7 @@ enum sock_flags {
>  	SOCK_RCVMARK, /* Receive SO_MARK  ancillary data with packet */
>  	SOCK_RCVPRIORITY, /* Receive SO_PRIORITY ancillary data with packet */
>  	SOCK_TIMESTAMPING_ANY, /* Copy of sk_tsflags & TSFLAGS_ANY */
> +	SOCK_ERR_WAKE_SYNC, /* Sync wakeup on error report, %SO_ERR_WAKE_SYNC */
>  };
>  
>  #define SK_FLAGS_TIMESTAMP ((1UL << SOCK_TIMESTAMP) | (1UL << SOCK_TIMESTAMPING_RX_SOFTWARE))
> diff --git a/include/uapi/asm-generic/socket.h b/include/uapi/asm-generic/socket.h
> index 53b5a8c002b1e..5527c9318b40e 100644
> --- a/include/uapi/asm-generic/socket.h
> +++ b/include/uapi/asm-generic/socket.h
> @@ -150,6 +150,8 @@
>  #define SO_INQ			84
>  #define SCM_INQ			SO_INQ
>  
> +#define SO_ERR_WAKE_SYNC	85
> +
>  #if !defined(__KERNEL__)
>  
>  #if __BITS_PER_LONG == 64 || (defined(__x86_64__) && defined(__ILP32__))
> diff --git a/net/core/sock.c b/net/core/sock.c
> index 498a57f34f5b5..59caab6a7223a 100644
> --- a/net/core/sock.c
> +++ b/net/core/sock.c
> @@ -1557,6 +1557,10 @@ int sk_setsockopt(struct sock *sk, int level, int optname,
>  		sock_valbool_flag(sk, SOCK_SELECT_ERR_QUEUE, valbool);
>  		break;
>  
> +	case SO_ERR_WAKE_SYNC:
> +		sock_valbool_flag(sk, SOCK_ERR_WAKE_SYNC, valbool);
> +		break;
> +
>  	case SO_PASSCRED:
>  		if (sk_may_scm_recv(sk))
>  			sk->sk_scm_credentials = valbool;
> @@ -2064,6 +2068,10 @@ int sk_getsockopt(struct sock *sk, int level, int optname,
>  		v.val = sock_flag(sk, SOCK_SELECT_ERR_QUEUE);
>  		break;
>  
> +	case SO_ERR_WAKE_SYNC:
> +		v.val = sock_flag(sk, SOCK_ERR_WAKE_SYNC);
> +		break;
> +
>  #ifdef CONFIG_NET_RX_BUSY_POLL
>  	case SO_BUSY_POLL:
>  		v.val = READ_ONCE(sk->sk_ll_usec);
> @@ -3641,8 +3649,12 @@ static void sock_def_error_report(struct sock *sk)
>  
>  	rcu_read_lock();
>  	wq = rcu_dereference(sk->sk_wq);
> -	if (skwq_has_sleeper(wq))
> -		wake_up_interruptible_poll(&wq->wait, EPOLLERR);
> +	if (skwq_has_sleeper(wq)) {
> +		if (sock_flag(sk, SOCK_ERR_WAKE_SYNC))
> +			wake_up_interruptible_sync_poll(&wq->wait, EPOLLERR);
> +		else
> +			wake_up_interruptible_poll(&wq->wait, EPOLLERR);
> +	}

Not just in report, but sock_def_write_space() and sock_def_readable() as well?


>  	sk_wake_async_rcu(sk, SOCK_WAKE_IO, POLL_ERR);
>  	rcu_read_unlock();
>  }

