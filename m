Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 950614A8A13;
	Thu,  8 Oct 2026 18:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791482643; cv=none; b=Tz9t9WvqaaozmIJEt+z+VNbqIe+8r6DMRDa7JNzxE3tN9sYcrHapioRP+OoEnYbCfBrZkOFkW4TFoAd9E0BupcnR7giIEcK4CX6eAUC+9S6Js/04zmMGcOowM+RopuxjebL4Y+QfWjUbEac/blhNSqvKwZ+A4uYzIHo/co825xU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791482643; c=relaxed/simple;
	bh=33Z5WPnPb0fZVymC4Jp+dUAXaJ04gtLshTE7xB57lo0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XELTct+RuSJF2kG28N5bI0UOHJEplZkrrh+HvNVj7UBteU8+N6luWtXp00cgsRYCIy4umZEK51s0iPHTMCR6KwFdnF2F82mQ5jIVfxgyHvUNN/dvxr7+haCU6Kwq78cHTQ8KzDKRqMk0b/kchMVfp0cC/3sut7mS0mHFE8E0x/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=JK35rt4h; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="JK35rt4h"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=6gmuge9IOAnkOJ/dm51hgQtAJL50M2OXr621hk447gg=; b=JK
	35rt4hZpr/Mm2MMSYi39ZOkXFQ/bRhB7hfD9VsJkJ+Yf1EUbfo/swoWIO9FHw7FSFWKwHarzeueQk
	OhkHZzLt3vLnKh9iXyOjp4o0GOFngKuoSTHuCzDi/D1HDufpcytcYacc/wuRD3t12z43XSkus/LRa
	yuNaJgSQvpvcd5c=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xEsSJ-009fgH-3N; Thu, 08 Oct 2026 20:02:59 +0200
Date: Thu, 8 Oct 2026 20:02:59 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Oskari =?iso-8859-1?Q?Lemmel=E4?= <oskari@lemmela.net>
Cc: netdev-bot+sashiko@kernel.org, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
	pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, hkallweit1@gmail.com, daniel@makrotopia.org,
	javen_xu@realsil.com.cn, vladimir.oltean@nxp.com, olek2@wp.pl,
	o.rempel@pengutronix.de, ih@simonwunderlich.de, amadeus@jmu.edu.cn,
	jan@3e8.eu, f.fainelli@gmail.com, linux@armlinux.org.uk,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, mensi@mensi.ch
Subject: Re: [PATCH net-next v2 2/2] net: phy: realtek: support unaligned
 RTL8224 PHY packages
Message-ID: <3e5adea3-72e9-41e4-bd59-3aabb9835e07@lunn.ch>
References: <20261005201540.913977-3-oskari@lemmela.net>
 <179144751562.434549.8240253139319713521@kernel.org>
 <2562030d-2508-4131-a27f-fe161961f627@lemmela.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2562030d-2508-4131-a27f-fe161961f627@lemmela.net>

On Thu, Oct 08, 2026 at 08:12:24PM +0300, Oskari Lemmelä wrote:
> 
> On 10/8/26 11:18, netdev-bot+sashiko@kernel.org wrote:
> > Thank you for your contribution! Sashiko AI review found 2 potential
> > issue(s) to consider.
> > 
> > Critical: 0 · High: 0 · Medium: 1 · Low: 1
> > 
> > If you believe none of the issues are legitimate, please reply to each
> > issue of Medium severity or higher and explain why the AI is wrong.
> > If any of them are legitimate and you plan to respin, please let patchwork
> > know by including "pw-bot: cr" as a separate line at the end of your reply
> > (one such reply per series is enough).
> > 
> > - [Medium] The RTL8224 text added to realtek,rtl82xx.yaml (preceding
> >    commit "dt-bindings: net: realtek,rtl82xx: document RTL8224 packages")…
> > - [Low] The new RTL8224 package example in realtek,rtl82xx.yaml
> >    (preceding commit "dt-bindings: net: realtek,rtl82xx: document RTL8224…
> > 
> > --
> > 
> The aligned-address fallback is retained for existing device trees
> without package nodes. Without an explicit package description, the
> driver cannot reliably distinguish aligned and unaligned layouts from
> individual PHY addresses.
> 
> Would clarifying that a package node is required for unaligned RTL8224
> layouts be sufficient to address the medium finding, while preserving
> the fallback for existing aligned layouts?

Probably. This is the AI being a bit picky. 

> 
> For the schema-coverage concern, would adding a dedicated RTL8224
> package binding with a compatible such as "realtek,rtl8224-package"
> be the preferred approach? This could follow the QCA807x package-binding
> pattern and provide explicit validation of the package and child PHYs.

A dedicated realtek,rtl8224-package binding probably does make
sense. You need some documentation anyway.

       Andrew
