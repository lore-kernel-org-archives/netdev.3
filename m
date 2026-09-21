Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC0954FC8D9
	for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 18:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790016493; cv=none; b=EQNV4Gl6VZSQK2327ZIlLBTqr3sY0qzKPdh+20cYm5UW2Rx1xnxYVQA5GGOMsDDqp5kUo82w8QPqpuLzlBynda9npPI/v/lfG+VslyuQ0QzGVtEeAOssVkFylN3gAshJ0J4/SXFJrJghjIcBSnYw3JhtXZM4BxYVNJBmDUXaNjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790016493; c=relaxed/simple;
	bh=2hGY69VuBDCF30s8Vt5mIlLLEtl5Hf3VWu3oBJeUXpQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VlLZHT25MBBGGXRFAr/rFuQk5Swu1/DBlfKoMDfn7SostvLFMabk4nycy7PxIvv3/9Ad0OdvD+Iah9BzDv305kqfQgUp+Zi/s1ewCJp9WLCdubf6D5AYItJXHQ1amuwbfYeE0hi+liMyfSuBSC9FC1yjlzZhEsc+Rk0bJNDQCQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=3yFC5D+O; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="3yFC5D+O"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=KSilyG+p+BKjOS1wdNqTqiLWCfOfL9JUAaSNMJZrOa4=; b=3yFC5D+O3LkmzKINTbftn6okwj
	uVTnDs9bgiJV8ZR3LabV27G/lTkPEnz8wtxW7R1VWQLrtWxckevsrOYHJI1tm9zWsKjY5E+ZGwCa8
	HLe2Xo8OT8HEZQh8/XivaydJ/B5dLprK1uHzw/iZFShurgcgGhBbqOIKC7+Ttm+d7tsg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x8j3f-006PK1-Iy; Mon, 21 Sep 2026 20:48:07 +0200
Date: Mon, 21 Sep 2026 20:48:07 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Pei Lee Ling <pei.lee.ling@intel.com>
Cc: netdev@vger.kernel.org, shubham.das@intel.com, siddaraju.dh@intel.com,
	balaji.chintalapalle@intel.com
Subject: Re: [RFC PATCH net-next 0/1] Add Clear fec-stats ethtool handler
Message-ID: <ecf9f5c5-d1f2-4012-be6b-b65616360e4c@lunn.ch>
References: <20260921154637.2376544-1-pei.lee.ling@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260921154637.2376544-1-pei.lee.ling@intel.com>

On Mon, Sep 21, 2026 at 10:46:36AM -0500, Pei Lee Ling wrote:
> ethtool: Add Clear fec-stats ethtool handler 
> 
> During optical cable re-seating, transceiver swaps, or Bit Error Rate (BER) 
> troubleshooting on 25G/100G/400G+ links, operators need to establish 
> a clean baseline for physical-layer FEC error counters (corrected/uncorrectable blocks).
> 
> Introduce a standardized netlink fec-clear operation using the ETHTOOL_MSG_FEC_SET 
> message type with an ETHTOOL_A_FEC_STATS_CLEAR attribute. 

What makes FEC statistic counters special? As far as i know, no other
network statistic can be set back to zero.

Because no other statistic can be reset, user space already has the
code to handle delta in counters when needed.

	Andrew

