Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD10E426408;
	Tue,  1 Sep 2026 16:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788278578; cv=none; b=jEaHneDDPJrHFZBfGXs8WSK8F5ReAFrQgzteAPDgwM0UAGGlqvbxso1GeNwBetKxy6DjR05EU/YAO5Ugc9k2reZXZUYFzb/5cJ/KPF46W8b7U84TFddh03tl2PnmrjyIVD3RflT8cAmGmkKYSqqey19WV2d717q/hvMtmnVOEt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788278578; c=relaxed/simple;
	bh=n7PcZtnAIhoDLcRBOJLdU1Xqtxkmqe6yDdLKxA6l8XI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LPykOXFGoyAaNLnzez62iXO4opWI07zoA2Jhjz5ixLP2DXn5XHOsuxrF3dTZ+gcFc4zHQ512hOMwClLiYqBMAppEyuHASija6FD7GDiMDERkOn0N85LW2gw/kIDn9VBcEeTSx4LOJ9qQRHGLzJ33fTCpjx580KKhXne5zSF1fyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=ldiDGEM0; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ldiDGEM0"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=eMtktqeeVL5VzhmP9fhR09ZZUGJKhcG515js72rP3tE=; b=ldiDGEM0x35iM4j2KLCdxxVD2j
	urbcs6Dtbvrfmd4LwW7kabk1KJwspiEganHPCv+kHu6+5TN2xURGUyfghK+JNfs9EURvVKy495kA/
	goCFoqj/Zr7l+yfTlX1g4N+3rL8dFv+W8hT0ZO7q1EeFK79iy5dMcKfEQ7NgVhJEe7ck=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x1Qwh-002NyJ-Ra; Tue, 01 Sep 2026 18:02:47 +0200
Date: Tue, 1 Sep 2026 18:02:47 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: khendry@reliablecontrols.com
Cc: =?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <clement.leger@bootlin.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-renesas-soc@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] net: pcs: rzn1-miic: Fix config array
 initialization
Message-ID: <343012c6-c3cb-467c-b2fa-285dc6ba8b83@lunn.ch>
References: <20260901-rzn1-miic-fix-array-v2-0-3e907049e770@reliablecontrols.com>
 <20260901-rzn1-miic-fix-array-v2-1-3e907049e770@reliablecontrols.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260901-rzn1-miic-fix-array-v2-1-3e907049e770@reliablecontrols.com>

On Tue, Sep 01, 2026 at 08:25:13AM -0700, Kyle Hendry via B4 Relay wrote:
> From: Kyle Hendry <khendry@reliablecontrols.com>
> 
> Fix memset parameters to initialize the entire DT value array
> 
> Signed-off-by: Kyle Hendry <khendry@reliablecontrols.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
