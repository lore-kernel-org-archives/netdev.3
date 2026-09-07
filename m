Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80BC93C2D;
	Mon,  7 Sep 2026 05:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788760451; cv=none; b=CR4QJ1779T4aT7umQvW8ZrYMUL1TikzIHTu6lt61pRak+wGV6khB6D03PyZIsMkl37JFn3zvTalWbr28PNYCbHFaK8Yr//opEyowj12e+/UuCth71LateV/SjWYWkmFQhLST3oa9cG7wXjO3cHdpsiu7uj3nSLbwY5s5/15bDaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788760451; c=relaxed/simple;
	bh=HYO47MED8T4RGl6wnRvdHbjBI4VMKHn4Bpj3NDC4w2k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SH9G5EY7SbMCbSYCjXM9px+zE5Dp2lhywqu55aYNF98uHLT30bI5g+7CTqjy3chgvD01/8YkHtyEpaOHU+ZE+aWdKh/RhdFYnsSNCUj2uJ5Cg1HcjuzNZexwANj3+PHBGG0ESOiDotsNN2CAfs5cJqYub0rtBFzE4kg5JxKgfn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ktJ+wzmo; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ktJ+wzmo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788760448; x=1820296448;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HYO47MED8T4RGl6wnRvdHbjBI4VMKHn4Bpj3NDC4w2k=;
  b=ktJ+wzmoZzvV+mO80XkQKZihvwXUoti+bCVsRZisSNIcg5dbbbXSIdo+
   ji79m6DMWZF9IU3cS9OwC51mUd0aC2qljbExRS7ooE1atctQa+l28l4Bq
   +IEIxg6k/zKto4364r+A2EQSC2Sqle523heSvWdpUjb5TYROpYzRlQHAc
   iDRFy+p99jRcEgAoDltT0v/NV4bj3f3NKa0Dn7Sx7PyXNo1mEtPM9DMZ6
   uTYXnL6QN0EGETFB4dyaluio8hnjj42Aw3GTgWwWJLqlf0aBwCVuDysF1
   HEsQiAjODWIlvcrPDuHKA8ES9jwUe/DMIaDUDYt83VzMj/drYmOiFOIS6
   Q==;
X-CSE-ConnectionGUID: OywGyYRMT16GPjP/Bte/Gg==
X-CSE-MsgGUID: KTDV+VaVQhmsbsCPXToYEQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11898"; a="88093680"
X-IronPort-AV: E=Sophos;i="6.25,266,1779174000"; 
   d="scan'208";a="88093680"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2026 22:54:03 -0700
X-CSE-ConnectionGUID: MzgUNYR6TC+bo+S3usQyvA==
X-CSE-MsgGUID: oQWRJlIuTq2l/IY5vpHxyg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,266,1779174000"; 
   d="scan'208";a="274772243"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa005.jf.intel.com with ESMTP; 06 Sep 2026 22:54:01 -0700
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id 6903699; Mon, 07 Sep 2026 07:53:59 +0200 (CEST)
Date: Mon, 7 Sep 2026 07:53:59 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: linux-usb@vger.kernel.org, netdev@vger.kernel.org,
	Yehezkel Bernat <YehezkelShB@gmail.com>,
	Lukas Wunner <lukas@wunner.de>,
	Andreas Noever <andreas.noever@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH 2/2] net: thunderbolt: Update ring indices only after all
 frames are queued
Message-ID: <20260907055359.GS106095@black.igk.intel.com>
References: <20260902082128.1148463-1-mika.westerberg@linux.intel.com>
 <20260902082128.1148463-3-mika.westerberg@linux.intel.com>
 <20260905135702.1af66dde@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260905135702.1af66dde@kernel.org>

Hi,

On Sat, Sep 05, 2026 at 01:57:02PM -0700, Jakub Kicinski wrote:
> On Wed,  2 Sep 2026 10:21:28 +0200 Mika Westerberg wrote:
> > Take advantage of the new API and update the ring producer/consumer
> > indices only after the frames have been queued. This reduces the number
> > of doorbell register writes from one per frame to one per batch.
> > 
> > Measured using iperf3 over a Thunderbolt/USB4 net connection between
> > Arrow Lake and Panther Lake systems (average of three runs):
> > 
> >   before         after
> >   ~14.3 Gbit/s   ~15.3 Gbit/s
> 
> Acked-by: Jakub Kicinski <kuba@kernel.org>

Thanks!

I applied these two to thunderbolt.git/next.

> but Clashiko (sort of) hints at lack of proper handling of transient
> memory allocation failures. Indeed the NAPI path seems to call
> tbnet_alloc_rx_buffers() which flushes the ring completely on
> any sign of trouble. (a) aren't we freeing buffers already handed
> to HW; (b) if we flush Rx free list and there's no Tx won't the driver
> wedge Rx and never schedule NAPI?
> 
> I'd suggest fixing that first before making any optimizations :S

I would have fixed these prior had I known they existed ;-) I will look
into these.
