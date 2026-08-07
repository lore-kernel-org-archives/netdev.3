Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FA7247A898
	for <netdev@vger.kernel.org>; Fri,  7 Aug 2026 13:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786109894; cv=none; b=DSFVpm4+4E+opJECfov9hfYz48Ahrz1iNqy7XWygjBHBrWODL0Kf4ErtBVGx8VBcjdpTZ0YIbiLNXzoFsSSUPNRF5JEUNiWvKerxHui9Igue4ox3RkrkMK7kc+lYHTi+60C3wdAjNs9JCzR0SzslcYbufik95XMGbRFydQz9aBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786109894; c=relaxed/simple;
	bh=fI/jbZ5oJ59C1xLcHgIcvz35jR9e4KaM4inI7WIK84E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NDoCsCIaW3g6aPWRffqmmSY+lB7JiUWNPhiZY8cx/f73VIs0WsGYPHyyeWS2+nMx/fH6fCCjAjYywCQZyrp/muhcpWxAF18wfDpQROuJrkV0GFscHMNgmOvE6ATnGjA8Xg7xMnY/SEBMq2Gc73KICnrGa6E79XFJMKjmc2gvYPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=poqd1vDO; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="poqd1vDO"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=yNnI3dhqyo6NGFAkxQLF/xC91TRFZOMklu0GNCCo41E=; b=poqd1vDOhi3oX8Pc9pDAK9tnmm
	xfQ+kWjGbIT5cbeOcVlcdDrU17VUNurFTS31wfM3R0U2Xp75l6LvBZAKc4tb+k9SSRlIfQgs2ywHI
	QAQG0/o8ro92Te9hUHy1+qsR5yE/kdVnrBoCaRh9XWyQhAGqM+9JbGbOk36LTXPhvWJE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wsKlx-00GZma-Rw; Fri, 07 Aug 2026 15:38:05 +0200
Date: Fri, 7 Aug 2026 15:38:05 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: xuanqiang.luo@linux.dev
Cc: netdev@vger.kernel.org, kuba@kernel.org, richardcochran@gmail.com,
	hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
	edumazet@google.com, pabeni@redhat.com,
	maxime.chevallier@bootlin.com, luoxuanqiang@kylinos.cn
Subject: Re: [PATCH net v4 2/4] net: phy: dp83640: embed pin configuration in
 clock
Message-ID: <a14ac28c-daad-4fd2-8356-a042bb27a27f@lunn.ch>
References: <20260807070729.12545-1-xuanqiang.luo@linux.dev>
 <20260807070729.12545-3-xuanqiang.luo@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260807070729.12545-3-xuanqiang.luo@linux.dev>

On Fri, Aug 07, 2026 at 03:07:27PM +0800, xuanqiang.luo@linux.dev wrote:
> From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
> 
> The DP83640 has a fixed number of PTP pins, and its pin configuration
> has the same lifetime as the per-bus clock. Allocating the configuration
> separately adds an allocation failure path and requires a separate free.
> 
> Embed the pin configuration in struct dp83640_clock and point the PTP
> clock information at the embedded array. This changes only the storage;
> the pin functions remain configurable at runtime. It also allows all
> per-bus clock storage to be managed as one allocation.
> 
> Signed-off-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
