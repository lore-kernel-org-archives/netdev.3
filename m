Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 283384E534A
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 15:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791473498; cv=none; b=D2tXDI9sJfD+L7i61NdRX6QRBWPMxYgCndnn1cITTDDTIgo3NalZXx+4x0JVuSRZuehWkiPPThm7Gajk6nUTMyvn8heAMEJ3BjXetQIJevwyfQhanj6W7QE3CcHogVZqcy8Om4Y+kMvoZzz+xW1rxQ6f0ZDTmSL3colJJL0M3d8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791473498; c=relaxed/simple;
	bh=HFvTJwDmAn+TXH8HyVkJOIjEbUDFBFuINyH6StAGw3Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KJMFlfRNkBhO1LB/4btWkb/VrqYAJiTi7m1WDWob07i3OkToVjVpI2Xvz9w2CUqUktkoD2RfkVIemtz7cd9qZ/qB7bwnUfiukvvEnC9tjMG8IawU/ITvq+k5WoNNNThVu+Gky5Tvo3z0FPPZWc9HeT3sesUXgLjs7pOok0IJ1N8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b=sY6uUaJ+; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="sY6uUaJ+"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4a161d9b8c7so23589605e9.3
        for <netdev@vger.kernel.org>; Thu, 08 Oct 2026 08:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1791473494; x=1792078294; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hmRkJrFy7UYNSRUq22nOk7LyP+X+ALUnS3ucJY6ilFU=;
        b=sY6uUaJ+nLxk9DyH39nhdwGNGP8yOpwEJ11SdFVLT3h5gf1MuWCAPj5qU7QGUGPhRI
         h/TrT2BDuFoHG6jKKiC+hBqksBe7a9nD5x0WHpkb/PzRCll3KjJKOnUU31lNeiMR8Y2x
         05Vmshl63IzOYT6xQgu4AUVGWq9a8uYMNJAajLtFkvbvXV2Y0BP9EliuXPAo17vLdzhz
         B7ARDMEMpreSCUkQCQX3/BWjVUWc1cvOiDVwqNJePs9lR010IwwzAQWJcWMmeykBfdXo
         n9s6pLvq4GlU1ZdB08/AuRezA7Qk76ap2YLI/sHnbfE1VfCp1TMYKMcZ0QwulytqPPpk
         5AIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791473494; x=1792078294;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hmRkJrFy7UYNSRUq22nOk7LyP+X+ALUnS3ucJY6ilFU=;
        b=PhDLo/voVgWU9vHcqx6m2Yk+Cxr93c+xy7jERUMzWt6sCdUIiDYzXAN0ojHVGgffak
         ub6jiC4tvc6G5wrUU0BTKn4nGXIQ2JRvRdimHUmWrjbfJWqAGxManOCUtLhXRyxSxYab
         0swXn4TpIt3hqdiQ4zfJ/nQTqIEFZJj5pRVrh2jYQ1WrOyHzCz9t+t2duJLh3ov2CF/k
         sey/lpzi983wR3zrKlRyrjWFgCZZwkl8dQq1r0IAAESvO9ZPaGGpsb3vJkqYAgwr71UK
         zdf0dGIgUL5Gm0SAfmZPPP2etq1EiNV5qV9b5lUd/QkB05poGpKRorZjx5Y9cOddHE5R
         NMXA==
X-Forwarded-Encrypted: i=1; AKwUvBwDLl5Hjb15iZTlhV1LouCSlJW5zcNh6cAoH8w7J2KhHb/1e9VkHQPUHjA+U132BVr2wmC54qc=@vger.kernel.org
X-Gm-Message-State: AFuF++mtVuIp3aLX91JQioKCVTvoCPLXAH8h6T0E3MoD+we3sAWuufpg
	P/Psnk2l3t/RIsSLFJfmNnYK6ACjC5RpRN+EzuGahF6ZatQY4Vhq6nCLwTRzQ3obDXU=
X-Gm-Gg: AYBFou3aUnAKVJluVwt0NaL+q7obgTInoM7nGIUC9Pwfi7gKmFGH2jDB7zzVAucfiex
	D6qqctC0ERaIQ26EVkGcNQEHRok1n94Mh1zgYBCA3YKyzsyCPgZjvVC9+nc2T1oiJyjRsBzX2Mv
	yqkbfKgneYcZAJTTRZPCOmz35MgaFavmo3gYqDEMAh9PiUceQH4/pGjIGyxXzO0EVUr7qSYt7vR
	Jl4Hvm1otHBVcs/TJWQx5tADP6SPfYAgKu09h4JPLehT1hKRPWRQoOeg9VAh1e6WPcqgTKl1Q2p
	ur1NH+wSSgnhJINrQtjM6aExzltJgpKpvL7oXNN7RIbTKDIJGioUN0+mteXvmpGbVs/U8+NZhTK
	fGn26ba6/CHIrD+IlzwTCjBmtvzR5/GQkYfj+rl99Mqc3+8Y5mMOFvrzyaF88qhp0yvh7HoDH7w
	PMfaVT2eSM0+yBpSz4AqBFDe59HShvzmltOBVdvqQyWSJYIGZ56wtEtOfgt0PEkbI48oqdkcFiV
	YH1bKvE7GcdsxUVjvwQ8IUuL6cWijqtLmsLC01MXXlUnEs8G6Pv3Ad/X33mfsOlwp4Qlf6/CwcY
	3/F+nC2C/53iC7COBsEGOAX0QTO8wxALXzQCB0EGD59aYczIqvz4MoCGIX4=
X-Received: by 2002:a05:600c:810c:b0:4a1:7e76:d02f with SMTP id 5b1f17b1804b1-4a180424680mr108117585e9.14.1791473493755;
        Thu, 08 Oct 2026 08:31:33 -0700 (PDT)
Received: from aspen.lan (aztw-33-b2-v4wan-169864-cust3247.vm26.cable.virginm.net. [92.239.204.176])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1842abfbdsm74991645e9.4.2026.10.08.08.31.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 08:31:33 -0700 (PDT)
Date: Thu, 8 Oct 2026 16:31:30 +0100
From: Daniel Thompson <daniel@riscstar.com>
To: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Vladimir Oltean <olteanv@gmail.com>, Furong Xu <0x1207@gmail.com>,
	netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	Davide Caratti <dcaratti@redhat.com>
Subject: Re: [PATCH net-next v5 3/3] net: stmmac: add tc mqprio hw queue
 priority offload
Message-ID: <ase3UrUehtLY6b_5@aspen.lan>
References: <20261006-stmmac-mqprio-prio-offload-v5-0-d7da93419784@oss.qualcomm.com>
 <20261006-stmmac-mqprio-prio-offload-v5-3-d7da93419784@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261006-stmmac-mqprio-prio-offload-v5-3-d7da93419784@oss.qualcomm.com>

On Tue, Oct 06, 2026 at 12:46:27PM +0200, Lorenzo Bianconi wrote:
> Implement the offload of the tc mqprio hw queue priority in the stmmac
> driver. When the mqprio qdisc is configured in channel mode, the MTL TX
> scheduler is switched to strict priority, and the PSTQX/PSTC priority
> bitmask of each TX queue is programmed from the set of frame priorities
> mapped to the owning traffic class (qopt->prio_tc_map).
>
> The channel mode offload requires the DCB hw feature and a 1:1 TC to TX
> queue mapping, with a single queue per TC. Configurations with AVB queues
> are rejected, since forcing strict priority conflicts with the CBS
> algorithm. The CBS offload is refused while the strict-priority scheduler
> is active, and so is a channel count change that would enable an AVB
> queue.

I don't think these CBS offload checks are necessary. It's quite reasonable
to mix strict priority on low priority queues with CBS on higher
priority queues.

In fact on the hardware I have (TC956x) the lower priority queues don't
implement CBS so mixing AVB and DCB queuing (whether SP or ETS) isn't
just reasonable, it's pretty much unavoidable when using CBS!

As a concrete example of combining mqprio and CBS, the following works well on
TC956x (when I tested an older version of your patch):

--- cut here ---
tc qdisc replace dev eth0 handle 100 parent root mqprio num_tc 4 \
    map  0  0  0  0  0  1  2  3  0  0  0  0  0  0  0  0 \
    queues 1@0 1@1 1@2 1@3 mode channel hw 1

# No CBS for TxQ1 means we can't offload this (h/ware stays in SP mode)
tc qdisc replace dev eth0 parent 100:2 handle 102: cbs \
    idleslope 800000 sendslope -1700000 hicredit 494 locredit -1049 \
    offload 0

tc qdisc replace dev eth0 parent 100:3 handle 103: cbs \
    idleslope 400000 sendslope -2100000 hicredit 247 locredit -1296 \
    offload 1

tc qdisc replace dev eth0 parent 100:4 handle 104: cbs \
    idleslope 200000 sendslope -2300000 hicredit 124 locredit -1419 \
    offload 1
--- cut here ---


Daniel.
