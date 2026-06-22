Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91E7918CC13;
	Mon, 22 Jun 2026 10:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782124421; cv=none; b=SmMcOv7/xDRWzC10RRWShXeIeWBSNgpKsDOPNCAdSuXbe0erET+7o1unnC5VkWdmAuulzVmQf0YzJUoLrlDN5Z+qs8628i1aUIKpPFiXn+cuYK/4OS1ak8xGcQActxWQPnBoJ5YoeIBsXuYrXScQ4+IhoACumyGPqMF9C3JZYWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782124421; c=relaxed/simple;
	bh=T9G7mlaPE/Jpx7DNSORZN87efJWKlQFTaZK+U+h7wjk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DxL1LRRcJBYjTSK4aLyp0M5ub0wX3PGrRiP4Ue+WHTH7EoBADNtIoKXOdJqVeNX+R2WAUVyEEDVKBrfMSRimybSZR4dhNVlU8DZ68z7jeb0RBI0aUj+n8F2ya7WHemET8ZwGvG0gqVJ6aN/FTsCsMpjJL/kY1x1776bnPjfni+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=kvvjeB09; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="kvvjeB09"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=fNEFYzBhteuuQ9nZfErdE9JBskYS1cNAw/Y1EZYHGgQ=; b=kvvjeB09b0cuI/cnqmgJSqefZL
	KkHRZKLngQ17v1ioRxebOgwnvgwU/ISVrNGrA63fTLPLjLhS3oVkltOCE1rsmkzZcgJgSkIc0XwYZ
	3v794vL8S8cpq8yb44lliPVoC/FzXf+vxlaS42WxWPd/DgcrY7hauSTaNmnwoNV9nyzk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wbby0-008oP4-D5; Mon, 22 Jun 2026 12:33:24 +0200
Date: Mon, 22 Jun 2026 12:33:24 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: ZhaoJinming <zhaojinming@uniontech.com>
Cc: horms@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, linux-kernel@vger.kernel.org,
	madalin.bucur@nxp.com, netdev@vger.kernel.org, pabeni@redhat.com,
	sean.anderson@linux.dev
Subject: Re: [PATCH v2 1/2] net: fman: fix clk reference leak in
 read_dts_node()
Message-ID: <daeff8c2-9c1f-4d02-9bce-649c2fba74e8@lunn.ch>
References: <20260619121328.922138-3-horms@kernel.org>
 <20260622090505.2418478-1-zhaojinming@uniontech.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260622090505.2418478-1-zhaojinming@uniontech.com>

On Mon, Jun 22, 2026 at 05:05:04PM +0800, ZhaoJinming wrote:
> of_clk_get() returns a reference that must be released with clk_put()
> when the clock is no longer needed. The current code never calls
> clk_put(clk), leaking the reference on both the success path and the
> clk_rate == 0 error path.
> 
> Add clk_put(clk) after the clock rate is consumed on the success path,
> and jump to a new clk_put label on the error path to properly release
> the clock reference.

"When the clock is no longer needed": So once you know the rate the
clock ticks at, you no longer need the clock? It is O.K. for it to
disappear, since there is no reference to it?

    Andrew

---
pw-bot: cr
