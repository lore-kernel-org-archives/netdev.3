Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBE934CE692;
	Sun, 18 Oct 2026 16:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792340499; cv=none; b=kzmBkUatiMnm9JvbnDtZEzuc5D4eI/qo+q5Y5sgUN6ZkatGM7UocpIfMHbJRAn+b7e8g/Is+qwfGUFpGoQuxqlHot4s86Zb8yzz6I3OnHtGxlpbGI1lDnRr6jCXrpciujQzXVxyddtT5yxKYjKgaEH9YaWCt7q/1rzAWwxdyCbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792340499; c=relaxed/simple;
	bh=+UOjlPgqb3SZD7ckwUWzkOrBkVrEnmv/NXmIn6PJ0zA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DIM/Gi2mtGJgkT/TkEDv1YFJ0dlmyPGudrcoUi7hODSlxvGCLPX+Nouqjf7Dw9k6XzBkSS8LduY+E4ZlOvWPXr+OLBMMS7z/+k6Gpdy7rSFLNMKGemx/Cu51E3c5/hWfsQHu8EA4klXSlFayLMtKpJPCVkccA92mbqYPivQt9RM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Q4O6S0V/; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Q4O6S0V/"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=tNJS13q0fNrC6U0K+swsjrGdIQaNvIk1vQAXLrc1VAw=; b=Q4O6S0V/oDLKB3dfh9DiL7s3K+
	oKjGmRJYu/8NhnpPb3RDqlT0Z0Fb2+W7Yqz1/58s5Y0F14W7dLRB2IstOW1lCzj/RqxxLoJq6zmk1
	Vw84q40pcZvW8txVGXN4hcByELw9rfDJI/w/Jnu8hU6z7QMdltzFx+pe/jD3f8cxC9bs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xITde-00BVXR-Gr; Sun, 18 Oct 2026 18:21:34 +0200
Date: Sun, 18 Oct 2026 18:21:34 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Prashant Sengar <prashantsengar25031@gmail.com>
Cc: netdev@vger.kernel.org, Thangaraj.S@microchip.com,
	UNGLinuxDriver@microchip.com, linux-usb@vger.kernel.org
Subject: Re: [PATCH net] net: usb: lan78xx: avoid NULL PHY dereference in WoL
 setup
Message-ID: <b050adae-97b7-4f9a-93cc-5f2f96bf6e3e@lunn.ch>
References: <20261018151830.643511-1-prashantsengar25031@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261018151830.643511-1-prashantsengar25031@gmail.com>

On Sun, Oct 18, 2026 at 08:48:30PM +0530, Prashant Sengar wrote:
> LAN7801 supports fixed-link configurations without an attached PHY.
> However, lan78xx_set_wol() unconditionally passes netdev->phydev
> to phy_ethtool_set_wol(), which dereferences the missing PHY.
> 
> Only call the PHY Wake-on-LAN helper when a PHY is attached.

A MAC driver using phylink_ should not call any phy_ methods
directly. It should always go via the phylink API.

    Andrew

---
pw-bot: cr
