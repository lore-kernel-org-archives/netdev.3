Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5AF33ED5DB
	for <netdev@vger.kernel.org>; Wed,  6 May 2026 13:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778073540; cv=none; b=rm8quto3GfGJg79dlaioH209RKKg15NpC3kbaFqGHw+IIqC7bcgWu1VZAIKTqWYnHeFbe2Lwso2fBwcbrg1Hof11vyOdci60VWgQZ358RwgMXac5N9NzdIXFkRnXBSOx7Qdurq5lxJDV3Qt4naOBpzZL4gkGEXNftrFUeqBLt+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778073540; c=relaxed/simple;
	bh=Te8iS31aRN7ekU4dd4OwyidmIsQfc2BPjBnd6crZ66M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=me8z4Hu/R4tL/Kr4JYwxqKfFLrboTq58FPf6ULD9YaGWzDdJIauI5OIxhxMKqbe28OkD8mV8qRKafzUTxDVYuwJe5jtkztbc9a25QxL97D2p2pBdfCIdbkVjaxCUpAZTOmfmZG7SRCqs4TIRnstzsCEuJHHf8pITLflJvQD2KGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=iv80cOR4; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="iv80cOR4"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=vz3X3eta1IiSJY+7oVvLp9p9/Ff4G0CsduoWUS4/7dA=; b=iv80cOR4j2e5HMldf7g5DX6mxm
	hg1YsjFoKckwBwUcXZwMzIUnwgTACWG/z+zGOKSZsZxGEvogJTNAhkZgzEI3K3Y/RtVrFwa2n73oh
	aZ69GxaNr0124bkqzvM2M5/CizelQviSqCrELshrlrGT7u/yrMvwRgOatsfAxR/pBHGk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wKc9P-001doI-M4; Wed, 06 May 2026 15:18:55 +0200
Date: Wed, 6 May 2026 15:18:55 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Sven Schuchmann <schuchmann@schleissheimer.de>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: assert in phylink.c with lan7801 and dp83tc811 since kernel 6.18
Message-ID: <eba96f21-78e6-42bf-938a-6d4037d0a305@lunn.ch>
References: <BEZP281MB224533D524B27CFC6E47B447D93E2@BEZP281MB2245.DEUP281.PROD.OUTLOOK.COM>
 <57fb63c2-7a05-4bbe-ba2d-fc61ce1e3ba1@lunn.ch>
 <BEZP281MB22458F571CC8251C141D933CD93F2@BEZP281MB2245.DEUP281.PROD.OUTLOOK.COM>
 <7778cd41-cf36-4524-a347-408a8fb0bde0@lunn.ch>
 <f9b8840d-94ba-4bde-9ace-fb81eb733ff9@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f9b8840d-94ba-4bde-9ace-fb81eb733ff9@bootlin.com>

On Wed, May 06, 2026 at 03:04:42PM +0200, Maxime Chevallier wrote:
> 
> 
> On 06/05/2026 14:39, Andrew Lunn wrote:
> >> So for me it somewhere happens in phylink_validate_mac_and_pcs()
> > 
> > I was expecting to see more debug output, but reading the code, i was
> > also thinking we need to look at phylink_validate_mac_and_pcs().
> > 
> > You are going in the correct direction putting lots of printk() in the
> > code. We need to find where it returns EINVAL:
> 
> [...]
> 
> > 
> > In the end, we are probably going to find that what the MAC says its
> > capabilities are don't match what the PCS says it can do.
> > 
> > Thinking about that, it says phy mode RGMII. You generally don't use a
> > PCS with RGMII, so that is suspicious.
> > 
> 
> Another thing to consider is that in this case, we're attaching to a
> dp83tc811, so a 100BaseT1 PHY. Does the PHY driver correctly populates
> the supported features ?

Using RGMII to connect to a 100BaseT is also odd. It does happen, but
it is a bit of a corner case, and something could be going wrong here.

   Andrew
