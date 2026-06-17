Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C4713264D5;
	Wed, 17 Jun 2026 13:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781701227; cv=none; b=Jm137u3uiY8VpQ71iB9f9Htht8HnaYzknnetXnGyFxVgesZtMvxb/FozPptWbZVV/sgMivAHCdl260pG1R4/uHLETVYvx4ko+wayBugk/OW4cPQ/b/PDDRnWzUa5/dlx02nF8QnRhkJV1iSIZnHQMW9ihtZKtSSSOj9UxKL/0Oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781701227; c=relaxed/simple;
	bh=y6Dqi9UxNvE6RkI4EhLvKgItndGU0TyobxhD2LW9TmY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LkHBt9XzLdH+uMN9hAimTwrMHfvhRL0fpo0UsHj7Ahtfj1VGUbj0twZFxVd96EsRt82GNuTdlSW8RSUwI4K/F20nALcUOqkxoF4PdnXdheWy18Lxln4RVgQ+oj+qMLMthVn0VPBzhw1gdoAi2JjdF1x0s+v54PDrW01DiwVfIKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FvA62Z6m; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FvA62Z6m"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781701226; x=1813237226;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=y6Dqi9UxNvE6RkI4EhLvKgItndGU0TyobxhD2LW9TmY=;
  b=FvA62Z6mZTxMvS6Pol7yj5r/h17IQFsdQAM7CPrnVhqBFy/mPtjR5k+Z
   95d4Qz1j0eIdDLxTTCGAQyeTEgAT52oWQCBfhyfKnpeFopc7340BwpZSJ
   l1ve+9AwjzIS5Sk0Sn4LiAPJctfvvWWdPbhj15ojuGyyrORXPfdqkMLxy
   cMMGFl/a3JeuujJHFfVLjVi6ab8BDfAGq8nJ4p47dNxjA04YP6ZDeVJmY
   oc0vfTMbDw38kzFVHgRQsHlNH2vrbPnk3V6ZPopeoKtvJqffB2HxKKuy5
   TwUP/VbR2oUlVpO62uEuD1EVQYhJqVRFtBwoc0wP2pLP+iEwCTm1X4Y3I
   w==;
X-CSE-ConnectionGUID: d0G/hZ/dRRu1E9RtmV/5fg==
X-CSE-MsgGUID: frT1fBhVRhOWwuIbvaoiAw==
X-IronPort-AV: E=McAfee;i="6800,10657,11819"; a="82500579"
X-IronPort-AV: E=Sophos;i="6.24,209,1774335600"; 
   d="scan'208";a="82500579"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2026 06:00:25 -0700
X-CSE-ConnectionGUID: 1BXEr8fLTUidgtP3+4ZvTA==
X-CSE-MsgGUID: WOw5S8TjQqKPGP5Bg7kX0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,209,1774335600"; 
   d="scan'208";a="252365785"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa004.jf.intel.com with ESMTP; 17 Jun 2026 06:00:22 -0700
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id EBEC095; Wed, 17 Jun 2026 15:00:21 +0200 (CEST)
Date: Wed, 17 Jun 2026 15:00:21 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Maoyi Xie <maoyixie.tju@gmail.com>
Cc: Yehezkel Bernat <YehezkelShB@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: thunderbolt: Fix frags[] overflow by bounding
 frame_count
Message-ID: <20260617130021.GG2990@black.igk.intel.com>
References: <178163152194.2486768.14724194232649760778@maoyixie.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <178163152194.2486768.14724194232649760778@maoyixie.com>

On Wed, Jun 17, 2026 at 01:38:41AM +0800, Maoyi Xie wrote:
> tbnet_poll() assembles a multi-frame ThunderboltIP packet into one skb. The
> first frame goes into the skb linear area and every further frame is added as
> a page fragment.
> 
> 	skb_add_rx_frag(skb, skb_shinfo(skb)->nr_frags,
> 			page, hdr_size, frame_size,
> 			TBNET_RX_PAGE_SIZE - hdr_size);
> 
> A packet of frame_count frames therefore ends up with frame_count - 1
> fragments. tbnet_check_frame() only bounds the peer supplied frame_count to
> TBNET_RING_SIZE / 4 (64), which is far above MAX_SKB_FRAGS (17 by default). A
> peer that sends a packet of 19 or more small frames pushes nr_frags past
> MAX_SKB_FRAGS, so skb_add_rx_frag() writes past skb_shinfo()->frags[] and
> corrupts memory after the shared info.
> 
> Tighten the start of packet bound to MAX_SKB_FRAGS + 1 so a packet can never
> produce more fragments than frags[] can hold. This matches the recent skb
> frags overflow fixes in other receive paths, for example f0813bcd2d9d ("net:
> wwan: t7xx: fix potential skb->frags overflow in RX path") and 600dc40554dc
> ("net: usb: cdc-phonet: fix skb frags[] overflow in rx_complete()").
> 
> Fixes: e69b6c02b4c3 ("net: Add support for networking over Thunderbolt cable")
> Cc: stable@vger.kernel.org
> Signed-off-by: Maoyi Xie <maoyixie.tju@gmail.com>
> ---
> Mika preferred the bound in tbnet_check_frame() over the nr_frags <
> MAX_SKB_FRAGS guard in tbnet_poll() that I first floated on the list, so this
> rejects the oversized packet up front. Reproduced under KASAN with a harness
> that mirrors the per-frame skb_add_rx_frag() loop.

Yeah the maximum size of "jumbo" packet over USB4NET is 64k == 16 frames,
so this should be fine. Thanks!

Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
