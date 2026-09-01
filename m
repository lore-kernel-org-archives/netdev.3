Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 561DE37F8C0
	for <netdev@vger.kernel.org>; Tue,  1 Sep 2026 11:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788262385; cv=none; b=C5+kH6X29Bg/JhIqBwc/emFe8ghKFbwjmiDQeixI4+wRL57rPzEKF3sIfMgu4TQr6V5U6eo/Ah2EwKImP9Vjebr49JBFcvuTBtu/pkmgTsy/r52vBK1KEEaXJWaY3h3LC/x2O9PfSksU50wrgQd3FClMtBcpzV8kA2RZmeUHXcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788262385; c=relaxed/simple;
	bh=+degF2fG4kbEZJpwCbtWQYac6d6B2qdwLshy93wUrSg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YobZAPGPiZG8vrg5o0Q8EjHBfxHAQfhQy/h6HT3kC4rkOGWnGYlZ3j/AgvenCxPDSSEcA997ZjZJwVn4G4KHdgowNNt1b2cfDv3ak/WuwHDG7NUKvOXP3h+KhnRtLAmb9OM0/f7kZ7tIR+XqVMv2Ora/l5oymQwyIbIBQy926wI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IhqMVdwC; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=dASPBjcU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IhqMVdwC";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="dASPBjcU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788262382;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wKo+DaVauZ3fVgazDutWnp8zHgSVU2BXU1e8fqBAUO8=;
	b=IhqMVdwC06z06RcU8GNL+48FMDLvC58c1GaADJvBP0FICVXSRp0oGIV7EqeeXPPxhEhgwy
	dsE8yLaVMe4Iml8kBfxvyQRGdncNHP4tM1+aAOmXKONjyRgyJJwucqG0Cbknpo8W+Itv6d
	lIE0J0zrnf0xqG9/Q3/VDFd/Rtlr1QQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-314-c8fP72DWOLyt05RDsYJfPw-1; Tue, 01 Sept 2026 07:32:59 -0400
X-MC-Unique: c8fP72DWOLyt05RDsYJfPw-1
X-Mimecast-MFC-AGG-ID: c8fP72DWOLyt05RDsYJfPw_1788262378
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-499913d1a79so26383935e9.0
        for <netdev@vger.kernel.org>; Tue, 01 Sep 2026 04:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1788262378; x=1788867178; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=wKo+DaVauZ3fVgazDutWnp8zHgSVU2BXU1e8fqBAUO8=;
        b=dASPBjcUY5xZg6s07pYnZY78WYn8/QkH0MTO4dpeZNf8Pgh4/ly8DyFUI6uYkrSBHd
         ChNwj7ktj15KPV3pvLvzYuwaTRcXptbuPZoKnpwsj1HGNoxIYRg8PoE73nQYEe8YVLOv
         oDfgVsHI6a2KhKZtHr231gR0tfPtybdTV274UEgLXXBSUTwIFYOVlliAmEdSQu9jdSy1
         2ax3KdxlC+bdonSJ+k/KX99qj6idxnnOkzCDxJkyhZDKIZUdMYjnt/YJc3QsMzBcE2/X
         bqAE9l82+jlgWOh6VX0O4ukExsqr1mdpX/8V2xdydAh00fhK/U+w+Qgze88ngvHl9xgM
         vndQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788262378; x=1788867178;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wKo+DaVauZ3fVgazDutWnp8zHgSVU2BXU1e8fqBAUO8=;
        b=PxBCLTXFANjC1KkhixVw4PUxG6bgFcFa5lzY7s5Nvh0BpvrGslz5QZieTuAuD6kFJ6
         qEoVFx3mA+FO6bH0TIAPiEJOlX65Qb1strkCgAwBSqvHay3OEd9wTHMC75m9p7t52p22
         EqUFjuZzdL4GmPkumSrItyFZL8gVBO9y7093D3pC+tk3Pp8aQFJjDe9QNTFLlkTv6JkO
         qb1LUdsN5QkBkzdlJ2vUNNSx0m8JPZ4s28WNw64uxTFuJBypeJP8hI02431fMGVVrV3+
         JRZ6JAcXWO1RyAEJyyu7LALmUY6pl0JPjbG8rKCvJjBLspEgi9UqTyBoFbvIMyejWrBg
         otlw==
X-Forwarded-Encrypted: i=1; AHgh+RoFYw9QElYsPt42ql8kNK5pWoLPDmrYJGKteWIIqFHF23y8TvGJVIFDz2v4Gu3X0nb63EK+THs=@vger.kernel.org
X-Gm-Message-State: AFuF++lS4djbTqXUisIpJWadL7PbAtXERfuJMNTMGmIqHxzTJaAKpfem
	A3hvdkhlJ8O0rFLYsAKXyqVzypycbenEhFN4MvT2YJ2o7CflC60bZ59uy8SS6pbaVc1yCLQB8XQ
	IZ40CtPk0kTg6lnXftCMNzaGx5B007xYH25A9lxchugfHNExXulSgzCBmUTHjXZLz5Q==
X-Gm-Gg: AR+sD111YeE6BxzCVgVS2Kr3zneVjp3mM2RlwP7OdObp+S86PjfKo1bGo0z9DIGTAPe
	cxLbUlAwohl2Tlla5yxsImX9b9NtT5a29MdUKhC3u6xuCo31Hdc3zit3VEmJe95iPLxE+hRT5L/
	WTP9S39uQkk9CxkMdDviXBV6dOis5cnF8NPCBfwiw5nFGFEJQ291cXEo1IxMf6o6xbUiG6pE89x
	66SfL99o+CMQ/bn3BZHmP2wlbZczB6aihCyS2c/XgQQsDd1ekyCDsVpZ0tSrBDaHuFbLJ1ck36C
	wTSJP+0EyDC05u7Qq5JogOO9mw05DXnF0vY2k0N9NTYZtLJvl7TLkBsa5bHwC2vwcciGfNgNrqr
	UYlCskyON6Fwm8PjtcZGKapurFSwOtsZ8i6Gm3zxLpNtbhsIndD9QmOMvEuYpDkzESx8XwoCJvA
	==
X-Received: by 2002:a05:600c:6215:b0:499:593b:a15b with SMTP id 5b1f17b1804b1-49cdc422c50mr151671195e9.1.1788262377102;
        Tue, 01 Sep 2026 04:32:57 -0700 (PDT)
X-Received: by 2002:a05:600c:6215:b0:499:593b:a15b with SMTP id 5b1f17b1804b1-49cdc422c50mr151668675e9.1.1788262376096;
        Tue, 01 Sep 2026 04:32:56 -0700 (PDT)
Received: from [192.168.188.218] (ip245-45-231-195.pool-bba.aruba.it. [195.231.45.245])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49ccd1e19desm322712395e9.1.2026.09.01.04.32.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Sep 2026 04:32:55 -0700 (PDT)
Message-ID: <06d2e605-6d3d-40f0-b247-031756c0d752@redhat.com>
Date: Tue, 1 Sep 2026 13:32:54 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] bonding: avoid ARP flood on RTNL contention in
 active-backup mode
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Jay Vosburgh <jv@jvosburgh.net>
Cc: Simon Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 netdev@vger.kernel.org, eric.dumazet@gmail.com,
 Tonghao Zhang <tonghao@bamaicloud.com>, Hangbin Liu <liuhangbin@gmail.com>
References: <20260831090937.3342052-1-edumazet@google.com>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260831090937.3342052-1-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/31/26 11:09 AM, Eric Dumazet wrote:
> Commit f1986b3a9f2e ("net: bonding: skip the 2nd trylock when first one
> fail") changed bond_activebackup_arp_mon() to reschedule arp_work in
> 1 tick if the second rtnl_trylock() fails (for sending peer/slave
> notifications).
> 
> However, by the time bond_activebackup_arp_mon() reaches this second lock
> check, bond_ab_arp_probe() has already been executed and sent an ARP probe.
> If RTNL remains contended, rescheduling every 1 tick causes
> bond_activebackup_arp_mon() to re-execute bond_ab_arp_probe() every jiffy,
> flooding the network with ARP probes at HZ frequency (e.g. 1000 pkts/sec)
> instead of respecting the configured arp_interval.
> 
> If rtnl_trylock() fails at the second check, do not change delta_in_ticks
> to 1 so that the next ARP monitor execution is scheduled according to the
> configured arp_interval, matching the behavior in
> bond_loadbalance_arp_mon().
> 
> Fixes: f1986b3a9f2e ("net: bonding: skip the 2nd trylock when first one fail")
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
> Cc: Tonghao Zhang <tonghao@bamaicloud.com>
> Cc: Hangbin Liu <liuhangbin@gmail.com>
> Cc: Jay Vosburgh <jv@jvosburgh.net>
> ---
>  drivers/net/bonding/bond_main.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
> index ef9eb0c53c66..c23cf18a996a 100644
> --- a/drivers/net/bonding/bond_main.c
> +++ b/drivers/net/bonding/bond_main.c
> @@ -3871,10 +3871,8 @@ static void bond_activebackup_arp_mon(struct bonding *bond)
>  	rcu_read_unlock();
>  
>  	if (READ_ONCE(bond->send_peer_notif) || should_notify_rtnl) {
> -		if (!rtnl_trylock()) {
> -			delta_in_ticks = 1;
> +		if (!rtnl_trylock())
>  			goto re_arm;

Sashiko noted this should cause a regression, with notifications
potentially delayed for an unbounded time:

https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260831090937.3342052-1-edumazet%40google.com

That was also the behavior prior to f1986b3a9f2e, so I guess is 
a reasonable trade-off, but a 2nd opinion would help :)

/P

