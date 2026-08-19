Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F347A25D53B;
	Wed, 19 Aug 2026 06:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787119722; cv=none; b=H/haN4CZUihZEnLBzHrfqo/tyNSLU6tw9aiKYNe84EJtFjfq7oQ7kaHWdmbuxfT5y/pyY6vVuXOKDtQW6AICFG0GyJPIDqb8UD4y0f+hPIZeKizPtgKufJLp4RpLniG87zGOA2Fz8J+Hdl7tgcGfDEhNhxQYcvLGT4htOAlWnJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787119722; c=relaxed/simple;
	bh=G1xcxX4RuE4Scq9JmhNWc3FTctl+24/QHS0H10hQ/lA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bpLN826JbQlwNcHwy39+3JrMpiBPtQb6CsoRlbEdsoc2P3nNoJp7TRX4SaAAqsXWwQG/ZD8quWdN4ud/CXw3LU2LLNo4cHu8VmyutfUwic6iWIdX5dgiaco+1tdNFEDoVjZiULCHFg20L8al26LaVI0vr/bRk4E2+tIEXQ+r9JU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Vm6suSSl; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Vm6suSSl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787119720; x=1818655720;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=G1xcxX4RuE4Scq9JmhNWc3FTctl+24/QHS0H10hQ/lA=;
  b=Vm6suSSleKbIaBofv0+jcl+Ofe2Bi+3L7PPrFUSQ+RLrCXUzseJEl1/J
   /RsTWFnu+xR+HG5y9MBk7XK7pLsjhBxAHNiAO6Sv879uh0J+zjHzXH0dj
   3nbEusITlyFyz4H+bWjHGBXIq24r8HdQxU662yiy6xAR9S293yfmVxZCo
   DGspNtCZe7+NtLg8feFYwX2ZDUFZ9GMkYt1qdnrUVGfE6edHne5TNRT9m
   q3DZaSYCb8Ve7ehDSlWaCYnfOoWAuEx0vc5r25PT9CvvcFZN4UBPdxWh+
   SFDqdganWO6nNkpd8C5OxHIe6trfmLsUb0q3uikBUBpGs9jLmD6NB0acZ
   w==;
X-CSE-ConnectionGUID: p89X1xupRIyoXKlYUtlyUQ==
X-CSE-MsgGUID: iEmT4R3dTXCN0m3fxihwtw==
X-IronPort-AV: E=McAfee;i="6800,10657,11879"; a="98289524"
X-IronPort-AV: E=Sophos;i="6.25,231,1779174000"; 
   d="scan'208";a="98289524"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2026 23:08:39 -0700
X-CSE-ConnectionGUID: j8i4MSvQQsK58oBAHNrFvQ==
X-CSE-MsgGUID: HFH+tLKGSi+wpf7EKsn/+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,231,1779174000"; 
   d="scan'208";a="266065481"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa009.jf.intel.com with ESMTP; 18 Aug 2026 23:08:37 -0700
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id 7A0B499; Wed, 19 Aug 2026 08:08:35 +0200 (CEST)
Date: Wed, 19 Aug 2026 08:08:35 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: fy15309206903@gmail.com
Cc: Mika Westerberg <westeri@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Yehezkel Bernat <YehezkelShB@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net] net: thunderbolt: Count delivered packets in
 rx_packets and rx_bytes
Message-ID: <20260819060835.GZ893316@black.igk.intel.com>
References: <20260815-tbnet-rx-stats-v1-1-8da375c2cd09@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260815-tbnet-rx-stats-v1-1-8da375c2cd09@gmail.com>

On Sat, Aug 15, 2026 at 10:21:52AM +0000, Fan Ye via B4 Relay wrote:
> From: Fan Ye <fy15309206903@gmail.com>
> 
> tbnet_poll() increments rx_packets once per received frame because that is
> the NAPI work unit, and then adds the same number to stats.rx_packets. An
> skb is handed to the stack only when the last frame of a packet arrives,
> so once the MTU exceeds TBNET_MAX_PAYLOAD_SIZE the statistic reports
> frames. tx_packets is bumped once per skb, so the two ends of a link
> disagree: at MTU 65330 the receiver reports 16 times the packets its
> sender sent.
> 
> rx_bytes has the matching problem: frames of a packet that is later
> dropped mid-assembly are already accounted, so it does not correspond to
> rx_packets as documented. Account for both where the packet is completed,
> and leave the NAPI work counter alone.
> 
> Fixes: e69b6c02b4c3 ("net: Add support for networking over Thunderbolt cable")
> Assisted-by: Claude:claude-opus-5
> Signed-off-by: Fan Ye <fy15309206903@gmail.com>

Acked-by: Mika Westerberg <westeri@kernel.org>
