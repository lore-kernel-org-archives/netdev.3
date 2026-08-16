Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F15A127442
	for <netdev@vger.kernel.org>; Sun, 16 Aug 2026 11:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786879622; cv=none; b=cQPDP5XuIz+2CJWZF9bXu9Ir1U/XxccRLKX2ol8jy6UNyCE/Tq3U/gxzA4Lv5z6R+t2R2I6zTLjWI9HaBuQ3yXBuFMYzjgAEKdXpermnkWf7CAluA7pp9eiSosKmeIu6BXa1rODhV9qUs33TxK6XaWhCUurJ3psR2lxWl9q5YFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786879622; c=relaxed/simple;
	bh=GJQxoOEI82kYZgbkA2M3DWUOfXbIzfMVlcW5bXPgOoE=;
	h=From:To:Cc:Subject:Message-ID:In-Reply-To:References:MIME-Version:
	 Content-Type:Date; b=NV4UqGLjHGLOBS61BvmXlUxUz87+kqUR/VQlIz2Pg/gAK9PuYI4eIwO1vFxSngZjE2BW5u9HYmS4GsbFUcx01hUa99CFjRc91bKmiMkpV+Eo4Dfer3JP3rtPS2FZi+teI3S1vXRJrrwQX2fc2nLIeAgdFocg/ZknKEyH8U5zZoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LXTI9sd4; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=DS1WzV3u; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LXTI9sd4";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="DS1WzV3u"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786879619;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RG/0CkmnfI4ubU5H6lTIDt7bAjkJ/SgtQ01dx0rQ568=;
	b=LXTI9sd4h3HywKaY+l1Mkn71BRu/KAiR89U+G7utXNrszoEe4qmKy1LjBYNsntF4KAOqbb
	yQIIQQvNeiBvJTJFNIzrJojfdV7lMHi9eSSrmxznN418JkzkzJkEK5E5xVqkz+IVEhRAt+
	apUrwPGa7RWoxqPU9vWyv7XOHc0Repg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-166-0CDKUNHRPKmzdK3d-0rf7Q-1; Sun, 16 Aug 2026 07:26:57 -0400
X-MC-Unique: 0CDKUNHRPKmzdK3d-0rf7Q-1
X-Mimecast-MFC-AGG-ID: 0CDKUNHRPKmzdK3d-0rf7Q_1786879616
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-493bfc3b84aso13278005e9.0
        for <netdev@vger.kernel.org>; Sun, 16 Aug 2026 04:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1786879616; x=1787484416; darn=vger.kernel.org;
        h=date:content-transfer-encoding:content-type:mime-version
         :organization:references:in-reply-to:message-id:subject:cc:to:from
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=RG/0CkmnfI4ubU5H6lTIDt7bAjkJ/SgtQ01dx0rQ568=;
        b=DS1WzV3uRBZy1D1eGa6oezneZuwMXWRrl2QWys0rSx7Cp9ytTJyJh4XqNVowe654P0
         nNcGn1/Q0eaDcNb0YtHQ2rsQxsIsbHEpMUTHqG5KF9okne3u50cr/bQwMe0+2Yf2CcuF
         WParIzZtX/7HbdrHRUg03w6sT9Ufv7tTUHLN51v3P2FBqv/P0mCkh99PivwMy8Ap8f1i
         aNOALadMT6r4QvgNEWwBj3XYSFN2c9m6/wjAkpubs8Fc2b8OpPkntop4ZXCw4gjWGrbF
         DEwxNzoodlIG8sl7AF6LAjUbhFPY3QrXIdRQ+XFEiZ2VXH8knq8ls+yARsjjiWlH/Cu4
         1SxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786879616; x=1787484416;
        h=date:content-transfer-encoding:content-type:mime-version
         :organization:references:in-reply-to:message-id:subject:cc:to:from
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=RG/0CkmnfI4ubU5H6lTIDt7bAjkJ/SgtQ01dx0rQ568=;
        b=qsDknvs9p7UQAhFdzM06piB7Nng5UlalUggpUdhVTf49S2jzKu9+92QyhYWkOe/02z
         /l2DpGG5GuexeD0QOSdzxpEraDILA7awYvvQDtPDWelMNfaVki/nCAbvx/nXcC5oANWh
         R8qpPe4Z+wlstwKFyh+d7N4+gbo36GSLbUkedGA2GC5cLfrYoWqbY/YTJ1Akjo+BjvlT
         /mn2nuQYBCOYL8uk9ifqf1DQFclbUrZY3aSUUpHAPG2IYbs4sukKznzWDGPcUFtL77c6
         WaovOChhTU67LceslFlPXF4VBh/Q1JnEA/FStBKsngsqnALoxT3GMI4tHX3BM3fs7qyu
         bbTA==
X-Forwarded-Encrypted: i=1; AHgh+RraT3n+CclhZYaEJLMIHWkJSQ2V/Lj++Oiql40UFEcKbP3et9Ulspof5xGA9gcex0KkS3AC1Zo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6nEpEG330cuB5kSWnMLzKhhiU+HEkXqKYBlhkLrsv0YZ+esWN
	G3eD2W2fVvrXYni0mBsyQKJ2u4cDxpCiX0dlvObiwmitGVdrw3Rr9nyMQ9uRp+GCpldvbgRnLGR
	jFtgP+qmJjC3Njvjvsy3yJf4WEYcZNvUTSGMpu0pTqatRksS4OPgv1vYbqg==
X-Gm-Gg: AR+sD12qLZjwciik/kjtevkrUAwKehPZAelMqmR2KE8S62zsKWTn08/OVPPxzYspkpS
	12MECM4sFWwFP5BuTpeVahb9b2Q2tDL68MhDsCJ8UnUtpX2vAxWosG3sN42jWaHDPE60mraA/70
	YHmnqsLF3rXhbGqkc/gFdLKROwoClDmorj14uz3Rn3lMewWxb57Ck3zvmRf3UC9tmsnujjqtZzN
	rbUVvTchh3fTPWf7aL9w7Lzi6ZOPoF0xv18dLDlclw0F8/RlPm+vu2EEkwPKgYQHA7NBRvMaiyG
	0KvBAc4jIPBp+SIvi9VLGYAUgk+r9tDMhMbWaBCrA7AKtx10y/lCZKPEBroTcg0m+pBdkWCCrl6
	lyCKPMD4s/InzobU1DB0ejGuRh/nG
X-Received: by 2002:a05:600c:6986:b0:499:79ba:ed92 with SMTP id 5b1f17b1804b1-49988c5efe7mr311028165e9.13.1786879616275;
        Sun, 16 Aug 2026 04:26:56 -0700 (PDT)
X-Received: by 2002:a05:600c:6986:b0:499:79ba:ed92 with SMTP id 5b1f17b1804b1-49988c5efe7mr311027455e9.13.1786879615824;
        Sun, 16 Aug 2026 04:26:55 -0700 (PDT)
Received: from maya.myfinge.rs (ifcgrfdd.trafficplex.cloud. [176.103.220.4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499960fef95sm47627815e9.1.2026.08.16.04.26.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Aug 2026 04:26:55 -0700 (PDT)
From: Stefano Brivio <sbrivio@redhat.com>
To: Yuyang Huang <sigefriedhyy@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, David Ahern
 <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>, Ido Schimmel
 <idosch@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH net] ipv6: use RCU iterator to dump route exceptions
Message-ID: <20260816132653.1fa1b16f@elisabeth>
In-Reply-To: <20260815084651.69477-1-sigefriedhyy@gmail.com>
References: <20260815084651.69477-1-sigefriedhyy@gmail.com>
Organization: Red Hat
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Date: Sun, 16 Aug 2026 13:26:54 +0200 (CEST)

On Sat, 15 Aug 2026 17:46:51 +0900
Yuyang Huang <sigefriedhyy@gmail.com> wrote:

> rt6_nh_dump_exceptions() uses hlist_for_each_entry() to iterate over
> RCU-protected exception lists. The caller holds rcu_read_lock(), but does
> not hold rt6_exception_lock, so rt6_insert_exception() can concurrently
> add an entry with hlist_add_head_rcu().

Ah, right, I didn't consider that, thanks for fixing this.

> 
> KCSAN reports this race (irrelevant details omitted):
> 
>   ==================================================================
>   BUG: KCSAN: data-race in rt6_insert_exception / rt6_nh_dump_exceptions
> 
>   write (marked) to 0xffff8a7c44c59620 of 8 bytes by interrupt on cpu 5:
>     rt6_insert_exception+0x3bb/0x760
>     __ip6_rt_update_pmtu+0x4fe/0x750
>     ip6_sk_update_pmtu+0x19a/0x3b0
>     udpv6_err+0x3ff/0x800
>     icmpv6_notify+0x1e1/0x440
>     icmpv6_rcv+0x8c0/0xab0
>     ip6_protocol_deliver_rcu+0x616/0x840
>     ip6_input_finish+0xb9/0x160
>     ...
>     entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
>   read to 0xffff8a7c44c59620 of 8 bytes by task 549 on cpu 14:
>     rt6_nh_dump_exceptions+0xb3/0x260
>     rt6_dump_route+0x53e/0x5f0
>     fib6_dump_node+0x6d/0xf0
>     fib6_walk_continue+0x290/0x2d0
>     fib6_dump_table+0x28d/0x360
>     inet6_dump_fib+0x37d/0x620
>     rtnl_dumpit+0x7b/0xd0
>     netlink_dump+0x3ae/0x7e0
>     ...
>     entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
>   4 locks held by dumper/549:
>     ...
>     #1: (rcu_read_lock){....}-{1:3}, at: inet6_dump_fib+0x88/0x620
>     #2: (&tb->tb6_lock){+.-.}-{3:3}, at: fib6_dump_table+0x1e9/0x360
>     #3: (rcu_read_lock){....}-{1:3}, at: rt6_dump_route+0x483/0x5f0
> 
>   value changed: 0xffff8a7c44e05700 -> 0xffff8a7c45d60100
> 
>   Reported by Kernel Concurrency Sanitizer on:
>   CPU: 14 UID: 0 PID: 549 Comm: dumper Not tainted
>   7.2.0-rc7-virtme #38 PREEMPT(lazy)
>   ...
> 
> Use hlist_for_each_entry_rcu() to safely iterate over the exception list.
> 
> Fixes: 1e47b4837f3b ("ipv6: Dump route exceptions if requested")
> Cc: stable@vger.kernel.org
> Signed-off-by: Yuyang Huang <sigefriedhyy@gmail.com>
> ---
>  net/ipv6/route.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/ipv6/route.c b/net/ipv6/route.c
> index 16dfac54a259..526535387512 100644
> --- a/net/ipv6/route.c
> +++ b/net/ipv6/route.c
> @@ -6046,7 +6046,7 @@ static int rt6_nh_dump_exceptions(struct fib6_nh *nh, void *arg)
>  		return 0;
>  
>  	for (i = 0; i < FIB6_EXCEPTION_BUCKET_SIZE; i++) {
> -		hlist_for_each_entry(rt6_ex, &bucket->chain, hlist) {
> +		hlist_for_each_entry_rcu(rt6_ex, &bucket->chain, hlist) {
>  			if (w->skip) {
>  				w->skip--;
>  				continue;

Reviewed-by: Stefano Brivio <sbrivio@redhat.com>

-- 
Stefano

