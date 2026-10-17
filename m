Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C062737B018
	for <netdev@vger.kernel.org>; Sat, 17 Oct 2026 04:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792212657; cv=none; b=SSfgTbGVT+rDDapCV2KBN1q7Fiju9XH2LpJLGs0rYmFtiA3OZ7SKMzsSQ77mJtaO0Rpe6auG/kUmNkUaZpq0cL+dj3ClURjqKsEBto3QKq5nGV3czBose/7Hryn0nCmxHaH9TpFzfo85KLE3krATRQqGrsfuMNVAMWDWjh1Kxss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792212657; c=relaxed/simple;
	bh=7Ir8gVL2LT4Hq/1oM42Dh+FUvuDYGifIxm+uHvXkIP8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YP+vsr9XbUlJ7ON833zee0Xp7R1ve+x0I1LbA059vJaFT1Wlsk+kpn67XghFhvfGD7btEPolXievcYz/qH9CFiL3GCZSH1WMSAZcRWM9jBillxI8ug2yQfZhe3Rdhqg+T1HUDDxrmM/LlraPU5qOvwbirKFE4Qn09113pufSVVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hhMj9NNT; arc=none smtp.client-ip=209.85.215.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hhMj9NNT"
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cca35cf9f77so346534a12.2
        for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 21:50:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792212656; x=1792817456; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mSyJBWDi4nx9CLru9f0Dqe09kF4d35e/bLqWVltauo8=;
        b=hhMj9NNT0tdMvuCayHRm6fpmuzTfYh9glcqsC1VCNztLWbu4JotKm1/+XtoBw1+C3K
         WxVsKU1fc23w4xmm/jo1qyaQ1CK+USqsVyZJloOxLd3XcZsyZeOwI3aF4d8eu+Gp465X
         QpS+AZGaxehRzm5/rGczbWU1dM0hb6n6lUaWSJC2hgM11PCyDwcuDn5rcRiAc/qp40Gp
         MRZA1+UhvJtSmNrA9tBsU7Imgy/0oEYrvawldhwHR0ul0/O9dVkWeBBjFEl8RmErSahb
         rMGbwrGTXJoXKgUYlZhoglTAL3n31Xz/OSLBH3gdl+LzA09X08+yB3xWJLtn8GkORPNk
         pFGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792212656; x=1792817456;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mSyJBWDi4nx9CLru9f0Dqe09kF4d35e/bLqWVltauo8=;
        b=yYQLsLE1gLXMd/4TQu8Mjtg5SH4xeLiBClJdNp0qzl4m+SpkkmLEBjFQrUZ1C1yoyr
         fJvIfPLkGo58eYfoE8BYUfFk8+nOSBAGY5eEWdrMeWRAPRcKmfe9HrKV/XSsmxiNxqsp
         irW6PjGvnglQrLEXiwwVfthuzguRXi/8Mgw/IlLXbZedS8Upzg24mwRRzhhOGSIyL2CD
         h6b5H19zWjpmpeQIwwZoAy74ygDHY2NuJS9krb9vmVBMfCeYeLWRsUCw3u7IFd/ON2XZ
         2UPzFGiC47cQoqWiFDLeyxCGJm6FD8G4zPag5REVXjBgjFjWRmPN9Z28puqtkogLZ4PA
         W3vg==
X-Forwarded-Encrypted: i=1; AKwUvByXsX4gOMofHysyFRaEyhSLxI8DYx1s8jU/mA4d9yfB6Yb29rKWZWkM6btJEmxQ0X3V/iXMRwk=@vger.kernel.org
X-Gm-Message-State: AFq9FYK5114yGlT8RVmIT4EuNm35Ao9X2YS2IirjgI7AQeU5F7vl/HRN
	wybd6ldGeOC7uQZPaPwnzxEPOsDGcj5SP1RlBip95hSK8jdwQSFn+0TypxGrLiAiCTxiL++8v3c
	wwCyqtw==
X-Received: from pgbj24-n1.prod.google.com ([2002:a05:6a02:61d8:10b0:cc1:bda2:d0a3])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:d705:b0:3dd:a195:dd5d
 with SMTP id adf61e73a8af0-3e226105ef9mr1057865637.63.1792212655907; Fri, 16
 Oct 2026 21:50:55 -0700 (PDT)
Date: Sat, 17 Oct 2026 04:50:55 +0000
In-Reply-To: <20261016-bug-net-netns-move-rcu-barrier-v1-3-4157d798658f@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261016-bug-net-netns-move-rcu-barrier-v1-0-4157d798658f@gmail.com>
 <20261016-bug-net-netns-move-rcu-barrier-v1-3-4157d798658f@gmail.com>
Message-ID: <atL-iSu113pPS7zm@google.com>
Subject: Re: [PATCH net-next 3/3] net: remove rcu_barrier() from __dev_change_net_namespace()
From: kuniyu@google.com
To: Qiliang Yuan <odys.yuan@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>, 
	Nikolay Aleksandrov <razor@blackwall.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Fri, 16 Oct 2026 14:09:55 +0800, Qiliang Yuan wrote:
> Commit 6549dd43c043 ("net: dev: fix the incorrect hold of net
> namespace's lo device") added rcu_barrier() before
> NETDEV_UNREGISTER_FINAL in dev_change_net_namespace(), so that dst
> entries released by RCU callbacks were on the dst garbage list before
> dst_ifdown() moved them to the loopback device of the old netns.
> Commit 070f2d7e264a ("net: Drop NETDEV_UNREGISTER_FINAL") removed the
> event but kept the barrier, and dead dst entries now point to
> blackhole_netdev instead of a loopback device.
> 
> The barrier waits for the RCU callbacks pending on every CPU while RTNL
> is held, which takes a full grace period on each netns move. Container
> and sandbox managers move one end of a veth pair for every new network
> namespace, so this limits how fast such namespaces can be created on the
> whole system, regardless of how many threads create them.
> 
> Remove the barrier. The RCU callbacks queued by NETDEV_UNREGISTER
> handlers free memory and drop device references, which the move does not
> wait for. Cached IPv4 and IPv6 routes through the moved device are
> rejected once its netns changes, since rt_genid and fib6_sernum are now
> unique across netns.
> 
> Creating 400 netns, each with a veth pair whose host end is moved back
> to the initial netns, a tap device, addresses and routes, in a 16 vCPU
> guest, median of 5 runs:
> 
>                    before      after
>   1 thread        68 /s      440 /s
>   4 threads       74 /s      409 /s
>   16 threads      77 /s      283 /s
> 
> Signed-off-by: Qiliang Yuan <odys.yuan@gmail.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

Thanks !
