Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0045330BB9B;
	Tue, 16 Jun 2026 09:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781601957; cv=none; b=V8Ql1W8AO2vnBCz0xLLUZWdqBwnN+npZ91lFSA6i/lKeFJLz7gPf74FJTJuqXg05aecDA8jncLOdIUrziy5QRVjHwLEHD0Lo77n/0dU3L8GOIf8YRcR1LVzill77VHl+NZuDTCAzkTeGLuIpZlZzHwPQIBxVrTj9Uwdjua8v6qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781601957; c=relaxed/simple;
	bh=TtifNOYPVhoMafVwpVEQep+EfwNSl6WGJi3e7DdtEnA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WFMNZl9K5ebcVwQKfLwPhT/RkADJN7628eEmwZC/K1Pg3PIoC2J/5q64jKOfowBlEcLKnBoUlnQMeXoKWSCRng0jkqEvTRL1TwO73ac3JjfYFpPYRS4PycYDaEWp3xDIu/P8XejgVqcZs0hiKm8NTPs1XV01Cv/BrRoNuYEYync=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iHjsBn6Z; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iHjsBn6Z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781601956; x=1813137956;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=TtifNOYPVhoMafVwpVEQep+EfwNSl6WGJi3e7DdtEnA=;
  b=iHjsBn6Ze0Li9invDyQvlKiUf+6VVhzuIH6SXYBOcOStsc91e+1zTuio
   bP2KmJo81PTTrhg280Zo62vl0dyjN/NEe9kJHYoWAHhuMMlx7FyhaGvxE
   haMB554bmD5d0zbRUP8EkY1P72V7/vUURoKNXgwpeF+YyrpBAGZ+ZEcnA
   G/dYo0hV6smlOgN1PP8FjGNKwgpwK3ZL4s9QXs0KlBYjYJ/u2dwTKEwT/
   hGFo4zKp6u7/eUiCaQUU0gbm71q0ANzbkHsSAuyUEYlCI0eqJsdW8QF7p
   UOBJ6wzA4tw8HXCU+vr66dkjLMbd3CTiO4NV35uazRObb/4Lv0m+q8g7e
   w==;
X-CSE-ConnectionGUID: mVtjsGSSTvCGOs3L4Xacbg==
X-CSE-MsgGUID: btLDClT1TzK0HJlVyn3z5g==
X-IronPort-AV: E=McAfee;i="6800,10657,11818"; a="84926129"
X-IronPort-AV: E=Sophos;i="6.24,208,1774335600"; 
   d="scan'208";a="84926129"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2026 02:25:55 -0700
X-CSE-ConnectionGUID: ztESuGFPRGKTrZ2x9Uo0jQ==
X-CSE-MsgGUID: vWQndoUdTdaQYAYMNv8a/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,208,1774335600"; 
   d="scan'208";a="246606342"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa006.jf.intel.com with ESMTP; 16 Jun 2026 02:25:53 -0700
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id 3229395; Tue, 16 Jun 2026 11:25:52 +0200 (CEST)
Date: Tue, 16 Jun 2026 11:25:52 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Maoyi Xie <maoyixie.tju@gmail.com>
Cc: Mika Westerberg <westeri@kernel.org>,
	Yehezkel Bernat <YehezkelShB@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: net: thunderbolt: tbnet_poll() can overflow skb_shinfo()->frags[]
Message-ID: <20260616092552.GB2990@black.igk.intel.com>
References: <178159529251.2170936.1136950368069628844@maoyixie.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <178159529251.2170936.1136950368069628844@maoyixie.com>

Hi,

On Tue, Jun 16, 2026 at 03:34:52PM +0800, Maoyi Xie wrote:
> Hi all,
> 
> After the recent skb frags[] overflow fixes (t7xx, cdc-phonet, f_phonet), I
> went looking for the same pattern. I think tbnet_poll() in
> drivers/net/thunderbolt/main.c has it too. I would appreciate it if you could
> take a look.
> 
> tbnet_poll() reassembles a ThunderboltIP packet that spans several frames into
> one skb. It adds one rx fragment per frame.
> 
> 	skb = net->skb;
> 	if (!skb) {
> 		skb = build_skb(...);
> 		...
> 		net->skb = skb;
> 	} else {
> 		skb_add_rx_frag(skb, skb_shinfo(skb)->nr_frags,
> 				page, hdr_size, frame_size,
> 				TBNET_RX_PAGE_SIZE - hdr_size);
> 	}
> 
> Nothing checks skb_shinfo(skb)->nr_frags against MAX_SKB_FRAGS here. The frame
> count comes from the peer, in the frame header. tbnet_check_frame() only bounds
> it at the start of a packet.
> 
> 	if (frame_count == 0 || frame_count > TBNET_RING_SIZE / 4) {
> 		net->stats.rx_length_errors++;
> 		return false;
> 	}
> 
> TBNET_RING_SIZE is 256, so frame_count can be as large as 64. MAX_SKB_FRAGS is 17
> by default. Frame 0 builds the skb and every frame after it adds a fragment, so
> nr_frags can reach 63. Once nr_frags hits MAX_SKB_FRAGS, skb_add_rx_frag() writes
> one entry past skb_shinfo()->frags[]. The frame_size and MTU checks do not stop
> this. With small frames, 64 fragments stay well under TBNET_MAX_MTU.
> 
> So a malicious or buggy peer can send a packet with frame_count between 19 and
> 64. The frames only need to increment the way tbnet_check_frame() wants. That
> drives nr_frags past frags[] and overruns skb_shared_info.

I agree this can happen.

> The fix I had in mind mirrors f0813bcd2d9d ("net: wwan: t7xx: fix potential
> skb->frags overflow in RX path") and 600dc40554dc ("net: usb: cdc-phonet: fix
> skb frags[] overflow in rx_complete()"). Add the fragment only while there is
> room, and drop the packet otherwise.
> 
> 	-	} else {
> 	+	} else if (skb_shinfo(skb)->nr_frags < MAX_SKB_FRAGS) {
> 			skb_add_rx_frag(skb, skb_shinfo(skb)->nr_frags,
> 					page, hdr_size, frame_size,
> 					TBNET_RX_PAGE_SIZE - hdr_size);
> 	+	} else {
> 	+		net->stats.rx_length_errors++;
> 	+		__free_pages(page, TBNET_RX_PAGE_ORDER);
> 	+		dev_kfree_skb_any(net->skb);
> 	+		net->skb = NULL;
> 	+		continue;
> 		}
> 
> I do not have two Thunderbolt hosts, so this is from reading the code. I can put
> together a focused reproducer if that helps.
> 
> Does this look like a real overflow? And is the MAX_SKB_FRAGS guard the right
> place, or would you rather tighten the frame_count bound in tbnet_check_frame()?
> It has been there since the driver was added (e69b6c02b4c3), so it is a stable
> candidate. Happy to send a proper patch once you confirm.

I would prefer do this in tbnet_check_frame(). Thanks!
