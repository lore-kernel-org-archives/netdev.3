Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C0D630C35F
	for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 22:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786572394; cv=none; b=Zs6pZnsgmLKblsijqWxCV8qUQ0M8hYLh76uWyVr91RrEKKWjkaPadOzMA2E0vhILm2U3HpROiOPVr4Vhnj7rv5/BzhzgjxLLIxM1ulbdDsl/eWdAtqEwQn3b13RpFOajOH80SSDq9ZlyH72ldMBaL9UyC9uCPZ8xZHrpiufLxiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786572394; c=relaxed/simple;
	bh=X7HIgkaLifJ7WbR8ThQH7BkEeoT/ljYKLvL7ifBOMv8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eyeFXboHzEJkb78HchhPz/8r8I2d+Kby/oRvsUIw+u9K7XYfxnfKpY1wchWXQpShqbYuhxT5GcN8RyFeHiuRM5GWfr9ADgo+70wgKT3XPwa2ypI024vQPq3tvEICO6mvouUlZAdjXn9lgEcahEiNWYhN/4Ist6gqH8NKJDqJBE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pRDBZx4O; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pRDBZx4O"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-47f5d5dbf80so58649f8f.2
        for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 15:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786572391; x=1787177191; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gycqGURb6RcPySIhCipoHXd74YJ+idCVrbRkPRx4R0g=;
        b=pRDBZx4OVBCmbP0b854dJtDqNsxulP9UaPmxiFwY3dIOBfvNSqX+Y+Je5PW4L6aUoG
         rMXPv4hzM9dnaODUI4zk+UP145EAzO3onwtze0RWXRuatu4bP1ErXk9bEJqbAz4JrHkx
         iKRCWTVtR0T4voZiPvhVYrktlPA/MOhcbg4ByCpC7NIE4eECLMzWi80yZGgcmwaFXE5k
         iZpOORVTEctkhzm9puMK9d8QgarS/Ce4+ewRtLGMABhXJPcxkMHOhCP6m9bZFcJUFjRa
         TSXlTtNVZbTLkAOK2PPxhhjtZra6nWdM+91k13mRRDBAkiOIDNeAiGriB6QTKhlFPzou
         bNLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786572391; x=1787177191;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gycqGURb6RcPySIhCipoHXd74YJ+idCVrbRkPRx4R0g=;
        b=mkhWb/RH6fnGD3XiFXz/J/bWbNsnygn1p1ZuidBxu9BTjT2a87DnbHS4fUsRrfhZvO
         ouH9p0YBJ8tuFN8JkJ+/2vPEbI5DyadwK3SRrcsx22P6970p5CD/8VBWd6ihujKytMoD
         gmzinBj8I14XH0zTLZBDy8FLrmr0/6c4WO8D6TThqyUiDvYz5kmg9MDdERBf4Jx0HjtA
         rEakxVqtx1/A3+dXoOInKjaY5tQcjLTC7y3i4OhfCum7l5TWYHU2KAp77p/WBP8k1z9L
         ZmB47KG9Pj/hD163sWlq9qPOk8BkpBJ8wz/hXK3XMw4N246YYEz0GuFiXy4vnTLIACZg
         IPmw==
X-Forwarded-Encrypted: i=1; AHgh+Rpi8xIkVKSt6KPkhNaCfYDqnoLHtVUZciJcFQZKJ1xHkM5xmzOAHXRO2RlJ//qmedmgjK0KHS8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxI82m59o5rvUp315n/Fbq5jDhqjs+b81Sbqz90PofJyLXxcvBa
	kVlPtlZd0mmgPTQr/XtwaHcUo3C9dAH2qssTgf9LsKvsXsdKavQRXwZx5HdZmg==
X-Gm-Gg: AR+sD12GLA04j3ybcsSJUeKOYnwgx+Uvdh1mahfj9BuUC7tMF2Jheeb9T7/fTd3UxoM
	FKc0GTY0rEVWASEUAaK0cVJ/ypX62ijvkoQI13o9ISgnLLsZjkaHkd1uBnebkH5jqrJB/IHQ95e
	P9t9hSnjMPrTN2dRcN4uwXlVymer8WdSQPPBIZh0GF/Qtf5SJ0xDvZVkgcK6Yw0FnpmwRrHn0Jp
	vgHR+u5xZhFK5cWLC+IFJMTC0R/OH4onPzWYlhwrJEHVFLFKXwSXK8xFk9F/FYtTGXemff62BkM
	fsAG8vWvyeZ7H6xQNTq/AaPk2rfd9POPW0iQzmEhsuNt8dqkrBiQWBZG2RHBUB/XyFwcBJnEjir
	mOysFiI46Crg7Kzert7HuRgEHRhx6RfJ0scfX1zn7+jay4JtSiJVCH6U7BvMdVo2/7RvRwcZY3S
	fmZ1IpxDroK+t+nb5N6TPewB5sdmH8/ZeqtrtpLR0jbsNaQSif
X-Received: by 2002:adf:e193:0:b0:47f:dfc1:6907 with SMTP id ffacd0b85a97d-4815a0005c0mr737263f8f.3.1786572391345;
        Wed, 12 Aug 2026 15:06:31 -0700 (PDT)
Received: from skbuf ([86.127.220.200])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4815a5af6b3sm835849f8f.20.2026.08.12.15.06.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 15:06:30 -0700 (PDT)
Date: Thu, 13 Aug 2026 01:06:27 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Jonas Gorski <jonas.gorski@gmail.com>
Cc: Semih Baskan <strst.gs@gmail.com>, florian.fainelli@broadcom.com,
	andrew@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, vladimir.oltean@nxp.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: dsa: b53: be VLAN unaware when not filtering
Message-ID: <20260812220627.r6gesugv2q3s6x2o@skbuf>
References: <20260805072641.402-1-strst.gs@gmail.com>
 <CAOiHx==-d_nzO+TQO+4UD4GfoLSOBUyfLuO+hfj8rQ1if4sZ4A@mail.gmail.com>
 <20260812205047.ojq2yyjtmoe5gjot@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260812205047.ojq2yyjtmoe5gjot@skbuf>

On Wed, Aug 12, 2026 at 11:50:47PM +0300, Vladimir Oltean wrote:
> 1. This looks implementable with some complexity isolated within the b53
>    driver:
>    - on any .port_fdb_add(), .port_fdb_del(), .port_mdb_add(), .port_mdb_del(),
>      compare the VID of the entry with the dev->vlan_enabled state.
>      - if VID != 0 and dev->vlan_enabled, or if VID == 0 and !dev->vlan_enabled,
>        commit the operation directly to the ARL, as is currently done
>      - if VID == 0 and !dev->vlan_enabled, or if VID != 0 and dev->vlan_enabled,
>        operate on a software list, allocating, deleting or modifying a
>        local representation of the ARL entry
>    - on vlan_filtering toggles from 0 to 1 or from 1 to 0, acquire
>      dev->arl_mutex and flush out all static and dynamic ARL entries
>      across the entire switch, commit the static ones from the software
>      list and clear the software list
>    - dev->vlan_enabled will probably need to be merged with
>      dev->vlan_filtering, since the vlan_enabled=1 vlan_filtering=0 case
>      is broken

Actually this algorithm is too simplistic as I specified it. In this sequence:

ip link add br0 type bridge vlan_filtering 0 && ip link set swp0 master br0
bridge fdb add swp0 00:01:02:03:04:05 master static
ip link set br0 type bridge vlan_filtering 1
ip link set br0 type bridge vlan_filtering 0 # the 00:01:02:03:04:05 address would be lost here

Furthermore, the ARL is limited in size (1024, 2048 or 4096 entries),
and we could mistakenly end up queuing more than we can commit.

I'm not yet sure what are reasonable amendments that would keep the
complexity in check. Currently the most obvious would be to do a one-time
allocation of dev->num_arl_bins * dev->num_arl_buckets, to always keep
all entries in software, and only the active ones in hardware. But I
need to think about this some more, as I'm aware OpenWrt typically
doesn't operate with huge memory budgets.

I'm not sure that avoiding local copies is possible, because the ARL
entries don't come from a single source - we have bridge FDB, bridge
MDB, ndo_dflt_fdb_add(), dev->uc, dev->mc, dev->dev_addr, sometimes
replicated per VLAN, etc. They all only converge at driver level.
