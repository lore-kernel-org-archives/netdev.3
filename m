Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87C344DD3D1
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 17:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790617548; cv=none; b=Ul6HEG3+8JAOK8+fiOJvrI9/dLr3yFGjZBb0BJI3a/NEaUWYZdle0fjp2sFJRGCY+OzAW2hLrRaJyRnCzr3lMl5Sx3xWAA5KbxnWvJejTwl3Z3yz/zI20KIxgxq01tLvm+vWY1BhoJeFarBNZCikKAlYwo+aFeWoisAmCVn5zjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790617548; c=relaxed/simple;
	bh=RsVbnR0UtECwZn1WfCNNpKAP7w5m36r3ODk/PEWCa4I=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fli+tmK1OXhu9J+KfufM+BTNe9wJplCurUR8Oik73WMIvm22/gUqzig93ox/1FfFAbJj4np93dlNZt0Lbwz1H/WtmKDzxXTjO11c/tp6u6CSyfPqxdyddH8LSZZYppktw02HpSSsorObi5NLNqKLYtFPXryopuR/0bsXLZpQfHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=s8t4jzFA; arc=none smtp.client-ip=209.85.216.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="s8t4jzFA"
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-39af92138f9so132863a91.0
        for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 10:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790617547; x=1791222347; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/WI+uqjCP32lvx9Hh4Cxb0Uvk0Dah2pSWZwhm+yPsGk=;
        b=s8t4jzFAYIORKUOMxQbGy3KmgwGz0kKxP6tOgKmDIlHmUQ9oy7gMeTm7qFfDPdaPNm
         oV5D5FsStlp1M5kSnXP3lp8iRgvZQ7ATxAD6d8UPhzCthJKC5zwfbBz4RvoT+NC0VkUW
         rIGRMKh7mJukjTQuV6uVoh6eBH9mNPFZkFJGfwFQCNvhjLyleGLnVV7SPwEDnEy/dqnY
         5s8lZ7nIZcHTF+vm2mFGtFvmSm2CrwOlBHDB4WL8Mjl2vrviVshBT2zu8gRp9FVLqgg4
         ev1doXpkVBv0yuBDPRF/+538ec/lZ0Hp6kcGg0yNwKW3yFAlV0x68vel/dMwlX5cjSDS
         berw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790617547; x=1791222347;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/WI+uqjCP32lvx9Hh4Cxb0Uvk0Dah2pSWZwhm+yPsGk=;
        b=judREFRsEzalClhWcB4SwNw+q2zrv+qbXcSGpHQSI6ewmSJaubswcaYcxcQzSW8sSO
         Tdl1OjfgXfiCXw/Y9s294SIs17wiPzM3z+wQz/clTpe908wVSMtxQRYiFzH5WzVzJFOE
         imRM9Cee+S/fKDOxEGvP70xfuUVNgNLuf3hHsvEZoC4WmFMsNS3eJiBud3InrqLm4jck
         4cGPngXhVNpEzR9dp09C1mS1Gon/It/I5g62QcZ0q+Nxr/BE41TZm+lo07LyJ3ONGgn7
         sMYuooHczfmvzUjC+sbyusP1HpkNdo2AWa+m1n/+htXF1puQQ35QQoo01pTTNyRXrYL5
         ESPg==
X-Forwarded-Encrypted: i=1; AKwUvByzZlIClEkihVOYD+9HP+RVdg4MbfecO5Ujf+MOaJsg23ADKAN/BYcOabanogyjKAVx9Htir3k=@vger.kernel.org
X-Gm-Message-State: AFq9FYJieFA7xTRWvi4gUpzNgypqEjO/7w+QrLCfFeUb4lfyO3H+NMyo
	gJpzlsLao5vUYJzdvYDdUWydYUAVsMFfsvnLyO8Urxtv0rEatY5Iwpq/hoII5ddM6lOBh8K1lm7
	Xy1MssQ==
X-Received: from pjbhs10.prod.google.com ([2002:a17:90b:200a:b0:3a0:e233:a080])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:37cf:b0:3a0:cca0:4a8c
 with SMTP id 98e67ed59e1d1-3a49ab4ecd1mr69880a91.7.1790617546538; Mon, 28 Sep
 2026 10:45:46 -0700 (PDT)
Date: Mon, 28 Sep 2026 17:45:04 +0000
In-Reply-To: <6E4F8645-9453-45F1-B068-52E1B14E8B0C@doyensec.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <6E4F8645-9453-45F1-B068-52E1B14E8B0C@doyensec.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260928174546.4022833-1-kuniyu@google.com>
Subject: Re: [PATCH net] soreuseport: Fix use-after-free when a socket is
 added to socks[] twice
From: Kuniyuki Iwashima <kuniyu@google.com>
To: norbert@doyensec.com
Cc: daniel@iogearbox.net, davem@davemloft.net, edumazet@kernel.org, 
	horms@kernel.org, kuba@kernel.org, kuniyu@google.com, 
	linux-kernel@vger.kernel.org, martin.lau@linux.dev, netdev@vger.kernel.org, 
	pabeni@redhat.com, willemb@google.com
Content-Type: text/plain; charset="UTF-8"

From: Norbert Szetei <norbert@doyensec.com>
Date: Mon, 28 Sep 2026 19:22:38 +0200
> reuseport_stop_listen_sock() moves a shutdown()ed listener from the
> listening section of reuse->socks[] to the closed section: it removes the
> socket with __reuseport_detach_sock() and adds it back with
> __reuseport_add_closed_sock(). The return value of the removal is
> discarded and the add runs unconditionally.
> 
> The socket need not be in the listening section. inet_unhash() calls
> reuseport_stop_listen_sock() for a listener whenever sk->sk_reuseport_cb
> is set, but inet_hash() enters the reuseport path only when
> sk->sk_reuseport is set, and SO_REUSEPORT can be cleared in any state.

This has long been a known problem, and I think it's time
to fix it instead of working around it:

diff --git a/net/core/sock.c b/net/core/sock.c
index 2948dffcc3e1..a33cdf99368d 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -1324,6 +1324,8 @@ int sk_setsockopt(struct sock *sk, int level, int optname,
 	case SO_REUSEPORT:
 		if (valbool && !sk_is_inet(sk))
 			ret = -EOPNOTSUPP;
+		else if (!valbool && rcu_access_pointer(sk->sk_reuseport_cb))
+			ret = -EBUSY;
 		else
 			sk->sk_reuseport = valbool;
 		break;


> Clearing it between shutdown() and listen() makes that listen() skip
> reuseport_add_sock(), and with it reuseport_resurrect(), so the socket is
> hashed as a listener while it is still in the closed section. On the next
> shutdown() __reuseport_detach_sock() does not find it in the listening
> section, returns false, and __reuseport_add_closed_sock() adds a second
> copy of it to socks[].
> 
> sk_destruct() calls reuseport_detach_sock(), which removes one of the two
> entries. reuseport_grow() then dereferences the other one, because its
> loop runs over every slot up to reuse->max_socks:
> 
>   BUG: KASAN: slab-use-after-free in reuseport_grow (net/core/sock_reuseport.c:291)
>   Write of size 8 at addr ffff888132359988 by task poc/621
> 
>    reuseport_grow (net/core/sock_reuseport.c:291)
>    reuseport_add_sock (net/core/sock_reuseport.c:350)
>    inet_hash (net/ipv4/inet_hashtables.c:810)
>    inet_csk_listen_start (net/ipv4/inet_connection_sock.c:1359)
>    __inet_listen_sk (net/ipv4/af_inet.c:225)
>    inet_listen (net/ipv4/af_inet.c:247)
>    __sys_listen (net/socket.c:2014)
> 
>   Allocated by task 621:
>    sk_prot_alloc (net/core/sock.c:2246)
>    sk_alloc (net/core/sock.c:2308)
>    inet_create (net/ipv4/af_inet.c:333)
> 
>   Freed by task 0:
>    slab_free_after_rcu_debug (mm/slub.c:6570)
>    rcu_core (kernel/rcu/tree.c:2919)
> 
>   The buggy address is located 904 bytes inside of
>    freed 2624-byte region [ffff888132359600, ffff88813235a040)
> 
> Only move the socket to the closed section when __reuseport_detach_sock()
> reports that it was removed from the listening section.
> 
> Fixes: 333bb73f620e ("tcp: Keep TCP_CLOSE sockets in the reuseport group.")
> Assisted-by: LLM
> Signed-off-by: Norbert Szetei <norbert@doyensec.com>
> ---
>  net/core/sock_reuseport.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/net/core/sock_reuseport.c b/net/core/sock_reuseport.c
> index 29948cb44b7d..031b641be317 100644
> --- a/net/core/sock_reuseport.c
> +++ b/net/core/sock_reuseport.c
> @@ -479,8 +479,8 @@ void reuseport_stop_listen_sock(struct sock *sk)
>  			 */
>  			bpf_sk_reuseport_detach(sk);
>  
> -			__reuseport_detach_sock(sk, reuse);
> -			__reuseport_add_closed_sock(sk, reuse);
> +			if (__reuseport_detach_sock(sk, reuse))
> +				__reuseport_add_closed_sock(sk, reuse);
>  
>  			spin_unlock_bh(&reuseport_lock);
>  			return;
> -- 
> 2.55.0
> 
