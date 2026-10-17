Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F777384CCB
	for <netdev@vger.kernel.org>; Sat, 17 Oct 2026 01:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792201298; cv=none; b=eMQwhbOwzkwQyPCV3/xpFhAIefwkEtotQfrs/Hu7434vHGvM//0DD2t4gQU8qy+FCQl7r5f03+qDOsMNCueuUNBqHemSEjOfJW1vyotXkC+j11zl+HJ73Q4uAPb61jesRYtT0RQU8NzvTqjj0SlcQx+HYsABPu3kps9GHXWiNSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792201298; c=relaxed/simple;
	bh=e6X+D5c/Tv+Ez0yFoodFngWklvLeykaCU8B+V7wc9tg=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=o7UG3KLbKPwUWXgqrvW7F8wWV+d69EtxhqauJEOckSF2fTq6abVVDXIDc1zihtV6j7FblpHLlnuwuGA0RZWy0hp9sJgCG/qDnMVUpPwfmJmre+4MV0gnj3bPlcmx4NOXlRvZseACo2J+jRqwDICr6+x5f5/U7OQaI5FkhHvumVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AsvPzqB2; arc=none smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AsvPzqB2"
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-5e9239c772cso390321e0c.2
        for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 18:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792201295; x=1792806095; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=yKsSek1QBLZx4VbISQM48zQ9ZZju16PuBgR+zu138+g=;
        b=AsvPzqB2AMkAUnOgBySfx+Hw3l8yEXPYIW92JNpxIa+hu8PoWZZgLJd84RKbyoTOsX
         dXc57wYZN9LWkOiMpj3KutBOgcxjqzwVq1a3V5jMH0lrnqImMdl0Sfp772LYYEjcObGL
         ee5ZPCddT96Qnr7lVb1p98Qljv7TC1F9hDw+WyDhsYnAj0sGro10wFOCF4Br9+f1x++M
         mVmBCMy87nrXJQFgB6BUh66flTlUvm9y/kbaRWUG/XLqHRhZ8iaNYFlcGBUKGfTNNlSc
         OpIPntJ8baS7C5VtEPgkuUIcnYkDr/qTnOH9Qrrvvsrs0mgllEgvtVxNaVspwByeSELv
         e/aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792201295; x=1792806095;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yKsSek1QBLZx4VbISQM48zQ9ZZju16PuBgR+zu138+g=;
        b=Rf2x068/zBuS+4gjdK29xFSptjywh9X1D7F+KbMVhn09qV54hS2wS45Eta8ZfAI0x6
         wc88z//Q5BCbvOQW1E+2hJOs4MIsviB6fea/+cyAmqZwV8Ct4I0PVjaaQf7xmgmDYpIq
         MO/yYP3c457WM6Z0UHDqxQse16WAwwSL2ckpfW3GCI1KsfTmA84zvbho4XOIsW3B8irm
         zgAZI80rd6RE5tQI981nSQqDpqjygnE/rKLjgc8yQabZF3Kf+exI4OjEvYNmntdhInS4
         wHYQooVfR6KQbXudSDV7kkKkYnjPj7dh4vnHNZuDThkxrVkFS2cWHwzrZ2aFuzK8hqEV
         Nl5w==
X-Forwarded-Encrypted: i=1; AKwUvBzI2sfdMgQijFjEbZFaSiftOL+r3F+Vaw7Ml0sJsKvUtc1yo21wrcWJifuhfFH0O156IP0Ahcs=@vger.kernel.org
X-Gm-Message-State: AFq9FYIYtecfArHuPb/+qppCQ+5lrb0PqxY6xSCAIvJTjCLPlUtL9aUN
	tccUEDn+xzQSPFhA802Hw25A7vz9jpZfYHS2dojqVezeY6qwNzJGTBP2
X-Gm-Gg: AYBFou1PKM7aMZQpX52zf1jqUU/OQtENRv24f6Qynw8RiTAlb0wzXDuP135iIsvCY59
	DnjTQTnE0nTtm0Jrg4ZuQw8iv9LSOL/IRDj1TB2B718SMcuIxs5X13eoTgfwmR2aM9VvvdNLFPp
	R3FSGKsvOMcmlp3kbjIhib3DcqgJ8bn4wZ70ktCa3IZEP4J5/av2pwgNSMYUfD94FHPAA0aJ+Fb
	EwRdz90CcLsTJyD/Hp80zlA8vLX3JCNO8bKiw/wYl2Qq1j/GZdy6rZLAbrbmDjcd89rGjV7aztF
	OSfIGYHQD9QDu3wsDU3IWmN5jbrHOhWBpR1D/sgVBIQOjBU3QGi4pSLY4IoNj4oSkSz6sFuwXmf
	GOMsw+FMENCbmGE38tA2OnxXjcVqAf2jh3skWrnCP7Mh+0gVTAoYbiDCBG/049/bkRkLdsYcj+/
	8mezomMI9PuPYF8Wuam3iRCLh1cBzT7+HFq8KGCh5KhG+vRd4qimQ2/1NFbJvafFdUB60Tk6wZr
	NjAPHLPDfTkxT7kiON/T73SLjQBanORoRECPXtX9DIk09OMJ/b9dZa4leebPWG4kVCBgirrY8OI
	ntcpicGqyXmqNz/y6CbJAiEYJ4jaU+lCXgpUBBn+qYoPPMXc
X-Received: by 2002:a05:6102:1612:b0:7a6:b18e:6d24 with SMTP id ada2fe7eead31-7cc36a38330mr415620137.23.1792201295404;
        Fri, 16 Oct 2026 18:41:35 -0700 (PDT)
Received: from gmail.com (111.46.245.35.bc.googleusercontent.com. [35.245.46.111])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-990836389b0sm2847007241.11.2026.10.16.18.41.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 18:41:34 -0700 (PDT)
Date: Fri, 16 Oct 2026 21:41:34 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Boyan Liu <yymhvert@gmail.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, 
 co+98d7de09cd94fec5@bugs.sh, 
 andrea.mayer@uniroma2.it, 
 dsahern@kernel.org
Message-ID: <willemdebruijn.kernel.ddaa3b8e2bca@gmail.com>
In-Reply-To: <20261016090526.2497-1-yymhvert@gmail.com>
References: <willemdebruijn.kernel.2a345d6bd54c5@gmail.com>
 <20261016090526.2497-1-yymhvert@gmail.com>
Subject: Re: [PATCH net] udp: Fix out-of-bounds read with unset mac header in
 unexpected GSO path
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Boyan Liu wrote:
> Hi Willem,
> 
> On Thu, Oct 15, 2026 at 10:49 AM, Willem de Bruijn wrote:
> > I wonder if the right fix here is to not call skb_unset_mac_header in
> > the first place.
> >
> > There are plenty of L3 device type with no L2 header. They still have
> > a valid skb_mac_header.
> >
> > This fix may be papering over a tunnel doing something non-standard.
> 
> You're right, and after digging into it I agree the seg6local side is
> the real offender.
> 
> I checked every skb_unset_mac_header() call site in the tree. There
> are exactly two: net/ipv6/seg6_local.c (end_dt_vrf_rcv) and
> net/core/filter.c (BPF egress, unrelated to the rx path). Every other
> receive path delivers packets with a valid mac header: NIC drivers set
> it in eth_type_trans(), and L3 tunnels without an L2 header (ipip,
> sit, gre, tun, loopback) reset it to the network header after
> decapsulation. seg6local is the only producer that lets a packet
> continue up the stack with mac_header unset, which is also the state
> skb_mac_header() warns about with DEBUG_NET_WARN_ON_ONCE().
> 
> One complication: the unset in end_dt_vrf_rcv() is not gratuitous.
> vrf_l3_rcv() -> vrf_add_mac_header_if_unset() relies on it to
> synthesize a fake Ethernet header when a sniffer (e.g. tcpdump) is
> attached to the VRF device. Dropping the unset entirely would change
> what sniffers see on VRF devices.
> 
> So instead of removing it, I restore a valid mac header once the VRF
> rx handler returns:
> 
>         if (!skb_mac_header_was_set(skb))
>                 skb_reset_mac_header(skb);
> 
> The sniffer rebuild happens inside the handler while the header is
> still unset, so tap behavior is unchanged; when no rebuild happened,
> the packet now carries the same mac header state as any packet
> received on an L3 device.
> 
> Tested under QEMU with the original reproducer:
> - unpatched kernel: KASAN slab-out-of-bounds in inet_gso_segment,
>   same stack as the original report;
> - patched kernel: no crash, the re-segmented datagrams are delivered
>   intact, and the unexpected GSO path is confirmed taken;
> - with a sniffer attached to the VRF device, the fake Ethernet header
>   presented to the tap is identical before and after the patch.
> 
> I'll send this as v2 with the fix moved to seg6_local.c. If you'd
> rather drop the skb_unset_mac_header() altogether and accept the
> sniffer behavior change, I'm happy to do that instead.

Thanks Boyan. This sounds good to me too.

