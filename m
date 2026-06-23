Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A55D35201B;
	Tue, 23 Jun 2026 11:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782213742; cv=none; b=NSnCwXdCH27yB2KPp3fZb6udKNzRzttofxjXSV2XK1wDJxh+qLEbcG5TMTYneNAYnRzXNwONOEyLRyuCTMzroLAeBf2sowR/8qrBAKuVeNV5T3e7XfN171ZkM+Pw4rXJul4W3J/pn2ucD93eAfQhHNbNxWIYyGGQvsykp+Hmv/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782213742; c=relaxed/simple;
	bh=Ac0PCETedxkC44FI7n46efIbI3KVwGVQr5l+d/rR0tU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=otghejjaBK+iHemlPfytFpdodBLfs0q5fxhY+jkGnZHGu0XMFKHFvKljbPJr3dtFVAvDyBVcJI7kwj/q/+aJDSjaw3ioh0RxMl98RhRhF90cOI5axA+2/bHYzcGcq2T97rKxUvsmE34fbZfeeK4y+XQksKHgzgUlxzzEouQviPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=UZLnO+mW; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="UZLnO+mW"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=/Vj+0Lwkf/zlKrbtC5fB9KE6Lv4N7rFR6YHiUjsKwLw=; b=UZ
	LnO+mWceivMlB1WzCEMpPFlRnUTntCzhikWATdpVSn203GxNaaWF1gpafHeORw2bfxnnIq6ysywcW
	VAeheLXNM+UK79rtFOaa5Q9OGQbUYgTx2KjiCj+ET+PL2GfisVm+eBwCyBX2Hrd/NFOFP8Nchcwq5
	s5I5PKAljwbRS1k=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wbzCk-008wag-MA; Tue, 23 Jun 2026 13:22:10 +0200
Date: Tue, 23 Jun 2026 13:22:10 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: =?utf-8?B?6LW16YeR5piO?= <zhaojinming@uniontech.com>
Cc: horms <horms@kernel.org>, andrew+netdev <andrew+netdev@lunn.ch>,
	davem <davem@davemloft.net>, edumazet <edumazet@google.com>,
	kuba <kuba@kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>,
	"madalin.bucur" <madalin.bucur@nxp.com>,
	netdev <netdev@vger.kernel.org>, pabeni <pabeni@redhat.com>,
	"sean.anderson" <sean.anderson@linux.dev>
Subject: Re: [PATCH v2 2/2] net: fman: use devm_kzalloc() for fman and rely
 on devres
Message-ID: <f0a6fd09-2fab-4bb4-85ae-82f8d383452c@lunn.ch>
References: <20260619121328.922138-3-horms@kernel.org>
 <20260622090505.2418478-1-zhaojinming@uniontech.com>
 <20260622090505.2418478-2-zhaojinming@uniontech.com>
 <4692dda4-657a-4c00-9e65-cff4b79d19be@lunn.ch>
 <823580887DE24145+2026062314162397367012@uniontech.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <823580887DE24145+2026062314162397367012@uniontech.com>

On Tue, Jun 23, 2026 at 02:16:25PM +0800, 赵金明 wrote:
> Hi Andrew,
> 
> Thank you for pointing me to the netdev maintainer documentation. I have
> read section 1.7.4 and I understand the concern about standalone
> cleanup conversions.
> 
> I would like to clarify the actual motivation behind the
> devm_kzalloc() change. While it may appear to be a simple devm_
> conversion on the surface, it is in fact fixing a use-after-free race
> condition in the IRQF_SHARED error paths. Let me explain the problem
> in detail.

Please make the commit message explain what the fix is, rather then
saying converting to devm_.

But i also hope you also see why we don't like devm_ conversions,
because developers get them wrong like this. And all too often, they
do the conversion without actual hardware to test it with. So it
results in more bugs, not less.

	   Andrew
