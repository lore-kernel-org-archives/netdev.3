Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A70C3451CE
	for <netdev@vger.kernel.org>; Sat,  8 Aug 2026 16:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786206023; cv=none; b=qbEjuBEi0AH/OKVnPLNQNqFe9Zfjq93B8brzrQ9qFy4pyM7vDjFg0K8Uf6dwVa+iZGPv7r3MdYNcGZr6PCpYTckc6xSZnzPY8VQhLAMaSZRP9nCE7BHpQimpCznI3CIin514trcrrKWixuttj3cmAcg3kbOdspy/Vu+YtW1woUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786206023; c=relaxed/simple;
	bh=D+rhCRJkkQV2sRPdOif6mAHzNMmECUtngYC2owbabqE=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=duD7Z24+L0V13naxht0c4iqS3cWZCnv81rhJ1YIDxQxdcxH5din1NbM0KQv1ijb1mZ81wWY7x5Ew1/ui3G4Sg66Vm6sd9VlkA53KikwFGASBFSxtXLaMskODIoq1l3iZPxbJhTPaveH3VbHqWr24jZosfU1eXuD9bewjOTBHYx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=abpwwcPK; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="abpwwcPK"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-8114a4542b2so8074407b3.1
        for <netdev@vger.kernel.org>; Sat, 08 Aug 2026 09:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786206020; x=1786810820; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=6ITP9fd8RqxxGpRZKFscH/cTUNK8qEytmhE9ixfnYCA=;
        b=abpwwcPKV4QBUJfXu4zWXkQrdyNX5BYHVZbeoQv18ko8y8Az+YDp4XfpR/OGinNspt
         Dl92URpKQTEqOgZTYCd5305BeZY0SgJqNMOrw4SdXh33ZGpSwq7etB9rZpZoOOPY4ooW
         qpFVK7gore2dsofuDve4GGZK6Hzl7VvZ3yR57W+9I9fuZQI5sG0vhn6t/Po4lBpsNrOo
         AX4AKv2ALWFN7XisPa0Rpevn4zXt5mf7rUWDzLjkSqpQzEEqMBcbf5s/7xlQG/Aw1LQJ
         AkaAUTHrexZIyFkoOfeS+bHf48eALi/KtDgbIWgUrpSvhy9U9GnDuHcdeij72vHtoQIH
         2ydg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786206020; x=1786810820;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6ITP9fd8RqxxGpRZKFscH/cTUNK8qEytmhE9ixfnYCA=;
        b=pZYxu2nIyDXhMSSyaEKMSOEZcR64kaJTee2nqwpFqFh7LT+t41FKwc7wyrIgAYQDGl
         d8WxYAl6OlLyaui/4eooNyATmg/DB789iGTQ/oVqum+IJCSY8ySmmrAP96VcMFrFKNSa
         hv9FkC4JR+KBvtZEECEgCPza4006bBuvyHeEaXEkRmFRlm1XgytWT3iDfood9ZNDtGbn
         KC+NOtEBvmbbB0I2jJc54S59dX3ex3ODAoCM/TxzFpiZZeYYaUxM6A9PhRLjYziXv7Rf
         S59S4It1/2u2AoTPpBHmNr0+3dwwv+/zsxW6nmL2tjHD7gtsW3BrHnDLap4O1l2tJV1e
         7rWw==
X-Gm-Message-State: AOJu0Yz7fdls3rKxHJlpiMMjW5kNxWqeO+xyaKa8TZTktge5FdoUdPfo
	Y0N70xstfMmk/BdtjpqeC6W0Ij8tQhL/MhrgFD+IU+gK9LtuWMF0vQua
X-Gm-Gg: AR+sD11DWGyKxedhO/EmJI9i0wt6FRQwNwLhhHWGe8LeISYiM7pJ/TB7hAVbAk2CD9y
	MftF35qjUBGZM+Qn+/moSuDC6DJTD4zBY7guwsasocK37izVkAVB5Ve8HVpY/sKWPV91xL/sROl
	dGPY6dnldBT6bQruuMIh+cuw6n0apb5ZyCIA3rug7gHpGPmaglVOG3ZLqH3kZJXPsaiA+cdoiht
	FvMxqrjBqgfSCIO7IurjvniZTnUU9rn4EJQzfB3aWRxUxKqD1aWSd5iwh4qWo3mgKgZ3pCBQhsU
	iBK64ENbfCjqb2gCzQq58R8RNmb2tc+C2Gmg4hJ8h91VAYIa2whb/xS0kADmBLlUgfYcMADKT2c
	NgbQGWUY/a/Z1AKzw14FtHLd2XmMmO0XYhJ5g0PfBGYUtc7YXvdZwHMMXER347iQw5qxoO6BX+o
	lJbY81lcw7wy1QcieN5Uk9C8J0P3qMNStpEZdODGPKB1BYXYM6ln8Xo2+vwJ6A8fX14h3HLJk2y
	dyXCl6afZQ1B6IF9GBV3Bm48O5N+A+egCsb
X-Received: by 2002:a05:690c:6b12:b0:81e:ac09:c89d with SMTP id 00721157ae682-825721f9af0mr49101657b3.4.1786206020499;
        Sat, 08 Aug 2026 09:20:20 -0700 (PDT)
Received: from gmail.com (250.4.48.34.bc.googleusercontent.com. [34.48.4.250])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8268d7f4caasm10762057b3.45.2026.08.08.09.20.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Aug 2026 09:20:18 -0700 (PDT)
Date: Sat, 08 Aug 2026 12:20:17 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Dave Seddon <dave.seddon.ca@gmail.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org
Message-ID: <willemdebruijn.kernel.288bf34c49865@gmail.com>
In-Reply-To: <20260807233151.4036252-1-dave.seddon.ca@gmail.com>
References: <20260807233151.4036252-1-dave.seddon.ca@gmail.com>
Subject: Re: [PATCH net-next v1 00/11] net: flow_dissector: opt-in
 byte-identical fast paths for common shapes
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Dave Seddon wrote:
> Thanks Willem, for the quick response and the feedback.
> 
> I think your point about where to draw the protocol boundary is a good one.
> 
> Eth + IPv4/IPv6 + TCP/UDP is clearly the common case. Beyond that, choosing
> what belongs in-kernel becomes increasingly subjective: VLAN/QinQ, PPPoE,
> MPLS, GRE, GTP-U, etc. all have substantial deployments, but that's also an
> argument for leaving those cases to the BPF flow dissector rather than
> continuing to grow a parallel parser.
> 
> On the +2500 lines, most of that isn't actually the fast-path parser:
> 
>     01  +75    gate BPF lookup behind a static key
>     02  +302   Eth + IPv4/IPv6 + TCP/UDP fast path
>     03  +180   + VLAN / QinQ
>     04  +95    + PPPoE
>     05  +103   + MPLS
>     06  +134   + IP-in-IP (4in4 / 6in4 / 4in6)
>     07  +121   + GRE
>     08  +270   per-shape counters (/proc/net)
>     09  +37    bound tunnel recursion
>     10  +1102  KUnit fast/slow-path equivalence test
>     11  +137   Documentation
>         ------
>         ~+2500
> 
> The KUnit test is therefore a large fraction of the diff. I don't want to
> dismiss that as "just tests" -- it is code that has to be maintained -- but
> its purpose is specifically to make maintaining two implementations safer:
> the same corpus is dissected through both paths and the resulting flow_keys
> are compared byte-for-byte.
> 
> More importantly, if I take your protocol-selection concern to its logical
> conclusion, most of this series disappears.
> 
> A v2 could contain only:
> 
> 1. the static-key optimization for the existing BPF lookup; and
> 2. one fast path for Eth + IPv4/IPv6 + TCP/UDP.
> 
> That is roughly:
> 
>     +377 / -50 across 5 files
> 
> plus whatever reduced KUnit coverage we decide is appropriate for that one
> shape.
> 
> I think there is a useful distinction between that case and the less common
> protocols. A network operator or vendor with a specialized encapsulation can
> reasonably deploy a BPF flow dissector. Requiring BPF in order for ordinary
> hosts to optimize the overwhelmingly common Ethernet/IP/TCP/UDP case is a
> higher bar, especially since users of RPS/RFS, fq/fq_codel/cake and bonding
> benefit indirectly through skb_get_hash() without necessarily knowing that
> the flow dissector is involved.
> 
> The performance result is also fairly consistent across architectures. In
> the isolated Eth + IPv4 + TCP benchmark the straight-line path reduced
> dissection time by 47-55% across x86, ARM and RISC-V. With all shapes
> compiled in, the Eth/IP path still improved the tested CPUs, although by a
> wider 4.7-31.6% range.
> 
> I agree that duplicating parsing logic has a maintenance cost. The reason I
> think the single common shape may still be a reasonable trade is that the
> surface is small, the fast path is deliberately allowed to bail out to the
> generic dissector whenever the packet doesn't match, and equivalence with the
> generic path can be continuously tested rather than assumed.
> 
> For the other protocols, I've implemented the same idea as a loadable BPF
> flow dissector:
> 
> https://github.com/randomizedcoder/flow_dissector_ebpf
> 
> That seems like a better home for experimenting with specialized shapes
> without growing the in-kernel parser.
> 
> So rather than trying to justify seven in-kernel fast paths, I'd propose
> shrinking v2 to the static-key BPF lookup optimization plus the single
> Eth + IPv4/IPv6 + TCP/UDP fast path, with a correspondingly smaller
> equivalence test.
> 
> Would that reduced series be worth posting for review?

Mine is just one opinion and not the most important one at that.

Existing non-linear code can also be optimized quite well, e.g., with
direct-call optimizations to indirect calls, FDO, etc. That may be a
more promising path than logic duplication.

That said, showing a significant performance benefit end-to-end for a
representative workload benchmark may help. Say, a on a TCP_RR
transport test. It is harder to judge the real world impact of the
flow dissection micro-benchmark on its own. With transport level
improvement, a single fast patch could warrant a look.

And same independently for the BPF static-key. BPF hooks have been
highly optimized by default, I'm a bit skeptical without data that
is worthwhile.

But I think the bar would be high.

In my ideal world we would ship a BPF program with the kernel,
deprecate the whole C parser and have the BPF parser be autoloaded at
boot.
