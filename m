Received: from mail-yx2-f42.google.com (mail-yx2-f42.google.com [74.125.224.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27225481FCE
	for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 16:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790181794; cv=none; b=DpXoxVJlNodbWeuRW6n6E2p8QwtJ/qupDKbI1zYz0Za9c1CdeKxloaFjTZ5VBrk9+UsMzq/Niin0rpD0iZ5g112qMvZ/0buLa/lHcXxPqlSOeIhlMjHQ79P7+SlvWcaRDyUTgYa7aCSjbuPbzfMDx60wYpql/3yb8Dzn33iuVzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790181794; c=relaxed/simple;
	bh=/ahzXPbP/8DZf7NXTQcvwkH04Q+Yl4SAdeO4yp5rUqE=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=Rb19cgpHYL8akIXQ/9UqTmNv7PNXngUC5CTYyGaNJN/GJN2I8rziOFaxcn5t9fWxADK4eOnEZlcugv/2CFymo5omT9ss0rURtRNASpjtpTzASTv4bMlBC3q3lGC2BgH5PZ5nzQhSV4xYb196tcmUmalEjTldlIG3zRSMFEuqFBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XayK/llv; arc=none smtp.client-ip=74.125.224.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XayK/llv"
Received: by mail-yx2-f42.google.com with SMTP id 00721157ae682-89666ee9b3bso14352737b3.0
        for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 09:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790181780; x=1790786580; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=UPnt11W+5wjdu0wkVU47rvuijLvJzmyTF42JLKYmmDA=;
        b=XayK/llvBbkmUZ83laoXstTdgLHhZjDDT6XM7nUftjK3hLRhQ2V41Oo6XGdttdpMtT
         C2OJcFFrrKQ4FXcF2j9y6g0XNXs+qPYNXgVIg1yKSNzNM+f1kmJFWvMQTpivaeej3iXm
         qlEYCI9odsGjrwdc9GDK1cFqGzRP2f2XAXm7AN5Fzunw6cW5ST52p2vubfp7aYesJYdE
         dKrodqExW6dDWQEBlt2JPkO8zxsfVnFoGfTWUB5wCAT5J9O7QIUN1Xan/Cz7/REcIc0L
         xmRXyr8cL7FC+TJ8ncOLp3v0T83Fw7aUGxh3zxLYut/AmVpBmJzNYUtldG2tNnPdnlMR
         m2rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790181780; x=1790786580;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UPnt11W+5wjdu0wkVU47rvuijLvJzmyTF42JLKYmmDA=;
        b=ZR45WurX/cZbUFZ///lhTJYxqYDkUlYgq2Gi+O+S8URY091sEMQQu2LYJt96sT68D4
         KFutOf93Q4s/HxNLPlG/jjrctEaCOX/5eABbo3A8v+ZGuDs6Ofv4npB3ZCWVfPfFvTt0
         eB9W0KoVO8j1LVdJU24aBu6YkV3np/vtULop4X6LQhMGhh3e5EG4sDJmfNzgF2jMV71H
         xJUZBD6XbhQjy+2cvf+m8dv2H/mhA/SxhlAZv8vjBKvTMzECA8Xots3+gUwXD5r8TSLn
         aw9dltIfTk2rtpS0H6mWzir8sqN9pL16n2/Rsgf8u4L/Wllaia8AOO8udPZTXLS1KZ8X
         I2Ag==
X-Forwarded-Encrypted: i=1; AKwUvBxXq5pQspgk5QwZLDAiJcuonBSvfBzvQW4X+G5h09Cb88JLh+wGHNX7xB4vy721JninzX7U3vQ=@vger.kernel.org
X-Gm-Message-State: AFuF++kK9dOzyQU+q3lQgtapY8xXIwWRLYYRVocSmLzV+kIa0Ufpp65J
	/WXvE0B77Bg6jnQYAonxhSuwF/rwtU/wAGBFVSwiwzsOcoStL11VqB28
X-Gm-Gg: AYBFou1twEpkgOA1pYp+zHhVfARXkYIkSaditA7ZHL5n5uKaoIpMr09NZuKxMMr3S+L
	LIBS+9lkwPzz14kZMcjrJ5X/M6TxYPwnctEjOVwEAGf2nIp6U5CekvBqAtAL4L+RwyGoCVgYTgN
	SxvPCH1HsxLuOO2tdw72yj4ENWw8CT4Za6KytvY/3xub9Bzh6TxRliBCRXyUrF7/lq1qiV/SU1F
	OpF1k/mIU085v0BGRCfMWD/ou2h3IiInURJdbInkBEC7ckaea8xW1fY9/qXxkj9Mxp4xdpjNHla
	ij549t66eS5uBVpMkPo1+ud72Ua3bT30aTU4fIINz0BfKMBASIe41GQDs5OmL8Hx7h7qzwpOGsP
	2GetotxPDCNmxfRJL1TcNEZPAt0tkbiNbTcf/E+gr3RzZgUV8H+DGPjTMk7osa8dOxMWucrfUki
	VawrEt5IVx1jpXh2eLbs2LVndHGHJgJ8lQz3wKQXxDJXV1stBFxwHbgI+XwFhlJ8ATsq/a4HWAG
	oerSloK1TTkp/9nokBLsVFwfdjIIGJUwLMMqQaKdYh7kIfrUV0d
X-Received: by 2002:a05:690c:9988:b0:8a5:208a:d928 with SMTP id 00721157ae682-8a5208add36mr17090337b3.42.1790181780465;
        Wed, 23 Sep 2026 09:43:00 -0700 (PDT)
Received: from gmail.com (111.46.245.35.bc.googleusercontent.com. [35.245.46.111])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8a46147e3d5sm12902897b3.1.2026.09.23.09.42.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 09:42:59 -0700 (PDT)
Date: Wed, 23 Sep 2026 12:42:59 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Wang Zhan <wang.zhan@smartx.com>, 
 netdev@vger.kernel.org, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 horms@kernel.org, 
 keyong.sun@smartx.com, 
 Wang Zhan <wang.zhan@smartx.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 Jason Wang <jasowangio@gmail.com>, 
 Neal Cardwell <ncardwell@google.com>, 
 Kuniyuki Iwashima <kuniyu@google.com>, 
 Alice Mikityanska <alice@isovalent.com>, 
 Ilya Maximets <i.maximets@ovn.org>, 
 Aaron Conole <aconole@redhat.com>, 
 Eelco Chaudron <echaudro@redhat.com>, 
 dev@openvswitch.org
Message-ID: <willemdebruijn.kernel.c1280e613430@gmail.com>
In-Reply-To: <20260923094517.3998941-1-wang.zhan@smartx.com>
References: <20260918084651.3022878-1-wang.zhan@smartx.com>
 <20260918084651.3022878-3-wang.zhan@smartx.com>
 <willemdebruijn.kernel.7b2e4c8d0d45@gmail.com>
 <20260920131231.3610688-1-wang.zhan@smartx.com>
 <willemdebruijn.kernel.2984a0c37a5cf@gmail.com>
 <20260923094517.3998941-1-wang.zhan@smartx.com>
Subject: Re: [PATCH net-next v2 2/4] net: gso: support bounded TCP
 segmentation
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Wang Zhan wrote:
> On Mon, 21 Sep 2026 16:36:37 -0400 Willem de Bruijn wrote:
> > Wang Zhan wrote:
> >> I tried it: https://github.com/zwtop/linux/pull/3
> >>
> >> It does read better, but whether to resegment is the caller's choice: the
> >> qdiscs strip the GSO bits to get one packet per segment (sch_netem.c:443),
> >> and a device-derived limit groups that output instead - which sch_netem then
> >> drops, because skb_checksum_help() on the first segment rejects a GSO skb
> >> (sch_netem.c:538, net/core/dev.c:3626).
> >
> > So this is a rare netem edge case we need to handle.
> 
> That is only one example.  I have not checked every caller, but at least tc
> sched tbf/cake and the OVS upcall are as well.
> 
> > In the hot path, we should be able to defer the decision whether to
> > segment entirely or segment to the capabilities of the device to
> > skb_segment itself.
> 
> Deciding it entirely inside skb_segment(), without passing extra
> information, is difficult: the oversize case overlaps with the cases above.
> And the features we pass in may also have had NETIF_F_GSO_MASK cleared, so
> it would have to take the device from skb->dev (that should not be much of a
> problem if we only handle the TX path).
> 
> >> The features cannot tell the two
> >> cases apart either: gso_features_check() clears the same bits for an
> >> over-limit skb (net/core/dev.c:3843).
> >
> > I wonder if we can refine this instead.
> 
> Maybe we can add a bool to skb_gso_cb saying whether GSO output is allowed,
> and leave it to skb_segment() to decide whether a GSO packet is actually
> emitted, and the max-segs.

Precomputing in the caller, as the current series does, is fine too,
if some caller-specific context is needed.

I'm mostly concerned about duplicating logic and the number of
functions touched in this series. But skb_segment itself is too
complex already, so preferable to minimize complication there.
(The reuse of partial for this purpose is very neat.)

If only validate_xmit_skb allows this, because all other segmentation
callers do want full segmentation (not checked, but I can believe
that), the current approach is fine. If we can clean up the repeated
tests and simplify the code in general.
