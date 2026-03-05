Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABC4C334685
	for <netdev@vger.kernel.org>; Thu,  5 Mar 2026 13:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772717389; cv=none; b=GBPHQMiL09JSVT8RjlaMxrkMCghQVpKGY5BmYl8I7ZjydIm0G90291zKhAU8Lv8e63OibasLybvqsDiHr9zGZcZeZC95UFA9550eg88qx+doS2/YE0ZUREJmenzOK72QBhr5VabaEp0N1j0LqEjJ1/wln76IU5K8bbe8fc0E1U4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772717389; c=relaxed/simple;
	bh=2O9r9LDXDJj803X3puSuwhl3cSUwWHVBg3YhINrdJqw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tMJuOl45CLLdstnWNkeh4qrlwFzZmkkycnUaaiFwZPit2fUQMtRptfYoqKsb8QoNGuHGnoDAAtZmiEGN4Wh8O+8Hwwwi7MqkT3yZ0X7FrogUHk6Nrt2oaTmy7ZOEdpV3XdPOkM/7kGM4S13N5ZOA3jETqjNmpZLe+rTA3grXnnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=MaxfacQn; arc=none smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="MaxfacQn"
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-2b4520f6b32so9193137eec.0
        for <netdev@vger.kernel.org>; Thu, 05 Mar 2026 05:29:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1772717388; x=1773322188; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=W2UUm8R+QueyEkOcuCPbcorlCWNYx0VuCk3zns3tCYI=;
        b=MaxfacQnfqdoIx1iarKZnziKdw22HNLeA3zPFpRxCgU70yBkAyjOsrdl3Sbnee3wYg
         V2muop6c1Zru0C1lZalypILaRiS1sY4uxX8L/hActIfpL/CPo7PFKR6Wwypqe7+/8O4b
         ty7Md5iKC1uLEcmP3g99zppXzMOJO3EjGtXQI+c72qPdYFCSCuxWSxXpGVvJjvyIOvYF
         pEkvMV/zRxQfVEaFt/oIWZEuCT0mPudMWRSobmb8718fW10T2DHoa4qtIcwYhiilTlcA
         s2QD/i76vOPGfL7UCl94Cc2tByf0Su+2UWzMK6s9kF+RTUKu8JH1+o2gSqQEopHMYjtN
         ba7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772717388; x=1773322188;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W2UUm8R+QueyEkOcuCPbcorlCWNYx0VuCk3zns3tCYI=;
        b=PQS6PNnvOvMT/fOeZgxtZRxjz3EmGZ6sjj+eBw/Chiqr1n3A9qFRMtyu3vxsjT6Sqp
         70fRR5LgOCaxM5O5H2JUc5oOXzANWuVb8OIaM+RPV8fMAi94I/WwZkJj2DZzXwIEti2s
         wvmrKS0vCt4JnpZENmkHPtVlKo9DEie16SEpufJPz0LqajXoy3hzCoMELgyrA8gzUSFA
         JnvIuvQQF67JKCjCw1ExBJmxdH83C0SyBZBwp/vKI+mkKz8JCsaRjf5F/Yio+d/69zDx
         +KZpunYU8tDXhNCn/geDBNCicjV8hGk4LSGj9wuZ6mGpDTytiARu1H/LMcstld3C+rg+
         RN/A==
X-Gm-Message-State: AOJu0YxfjT7kUx7lK6EufFp03J9Lq8QwAJ/kIosLlhjmqF7rRASkbJfx
	N3kT32261l9o4G/L9cmaFlOdhmZe1z+OrksUW/FExIC+9T2kwfvTcQuzCm7NQIaU17qhf1x/Krs
	pyu58lEWWZZ2IT0E=
X-Gm-Gg: ATEYQzx9F2+6pcpdSlOeVNZFs4x5KMeHNf0F6Hs2mqBzqjEUQwXY/9ElU4QVu9g4FMu
	ChrU7TxwuBSh0ws9eKG/9F9PCo1VuulaSghK6nFaUkqYfQgvI9Mh4D3J0o/rxGskFoZfeFsM+2Z
	p/SOewgtE5b3Lg3AgFRK8a9eZZyMM4bRyA9nx5Vzu9RjLiObh+PO5yDqMaEDWpfvbvCIEcIrekC
	xad57QmaqVuBu8Sfzk4rOrz0J/JpSmuNER8v3AuWczjJnqClsdR+unaVzD1lPbHBGME5t2bOz1u
	6awi8c1cRKghA/+RA+vNNuGTruRy6fmyJ4hmyqj2jMdQg9bwL/KAioJ2RUJCodZcpJVclPVSDwY
	ILOIYX0lPD6LFmjg51vJU/+ipndiodNT3sicXOS0c+puEZ1usSnx7E+TDaagOjVP2S/iV1LCEJO
	+1D01tnhpgBcOZumFZ0Rsy
X-Received: by 2002:a05:7300:e12a:b0:2ba:9835:1113 with SMTP id 5a478bee46e88-2be311c7211mr2339685eec.36.1772717387580;
        Thu, 05 Mar 2026 05:29:47 -0800 (PST)
Received: from localhost ([216.228.127.129])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2be1281ff70sm10108869eec.14.2026.03.05.05.29.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 05:29:46 -0800 (PST)
Date: Thu, 5 Mar 2026 15:29:41 +0200
From: Nikolay Aleksandrov <razor@blackwall.org>
To: Fernando Fernandez Mancera <fmancera@suse.de>
Cc: netdev@vger.kernel.org, bridge@lists.linux.dev,
	roopa@cumulusnetworks.com, sdf@fomichev.me, petrm@nvidia.com,
	horms@kernel.org, idosch@nvidia.com, pabeni@redhat.com,
	kuba@kernel.org, edumazet@google.com, davem@davemloft.net,
	andrew+netdev@lunn.ch, Guruprasad C P <gurucp2005@gmail.com>
Subject: Re: [PATCH 1/2 net v3] net: bridge: fix nd_tbl NULL dereference when
 IPv6 is disabled
Message-ID: <aamFRR3rfa1TlHEF@penguin>
References: <20260304120357.9778-1-fmancera@suse.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260304120357.9778-1-fmancera@suse.de>

On Wed, Mar 04, 2026 at 01:03:56PM +0100, Fernando Fernandez Mancera wrote:
> When booting with the 'ipv6.disable=1' parameter, the nd_tbl is never
> initialized because inet6_init() exits before ndisc_init() is called
> which initializes it. Then, if neigh_suppress is enabled and an ICMPv6
> Neighbor Discovery packet reaches the bridge, br_do_suppress_nd() will
> dereference ipv6_stub->nd_tbl which is NULL, passing it to
> neigh_lookup(). This causes a kernel NULL pointer dereference.
> 
>  BUG: kernel NULL pointer dereference, address: 0000000000000268
>  Oops: 0000 [#1] PREEMPT SMP NOPTI
>  [...]
>  RIP: 0010:neigh_lookup+0x16/0xe0
>  [...]
>  Call Trace:
>   <IRQ>
>   ? neigh_lookup+0x16/0xe0
>   br_do_suppress_nd+0x160/0x290 [bridge]
>   br_handle_frame_finish+0x500/0x620 [bridge]
>   br_handle_frame+0x353/0x440 [bridge]
>   __netif_receive_skb_core.constprop.0+0x298/0x1110
>   __netif_receive_skb_one_core+0x3d/0xa0
>   process_backlog+0xa0/0x140
>   __napi_poll+0x2c/0x170
>   net_rx_action+0x2c4/0x3a0
>   handle_softirqs+0xd0/0x270
>   do_softirq+0x3f/0x60
> 
> Fix this by replacing IS_ENABLED(IPV6) call with ipv6_mod_enabled() in
> the callers. This is in essence disabling NS/NA suppression when IPv6 is
> disabled.
> 
> Fixes: ed842faeb2bd ("bridge: suppress nd pkts on BR_NEIGH_SUPPRESS ports")
> Reported-by: Guruprasad C P <gurucp2005@gmail.com>
> Closes: https://lore.kernel.org/netdev/CAHXs0ORzd62QOG-Fttqa2Cx_A_VFp=utE2H2VTX5nqfgs7LDxQ@mail.gmail.com/
> Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
> ---
> v2: use ipv6_mod_enabled() instead of a null check and replace the check
> on the caller
> v3: no changes
> ---

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>
