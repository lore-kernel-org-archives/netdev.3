Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1E9E442FBE;
	Mon, 14 Sep 2026 17:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789406126; cv=none; b=jKVRKRZypSeC+CSERmBWU5trpzuhHVSSuQ3aQpkKLL4NXrcB8pWK5DVmGHvkcI+4x9je2FL0sYtCZTVoNvMxhZo9Jbx83uKXpgXE8penDV7wrliQIjVW3btM111SXS0bDhZhtNo/T309JARGq4DgcTULIAhnRx8gkxmB1MX9p24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789406126; c=relaxed/simple;
	bh=BaY099pQnb8RcVVcB1iD6IsIJCTPfTBjyaqEiiftcw4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s7ao58ryxA0ttmNBIGf9MLU+HgrekZJGiImUJSAf4mVaQpb8J0Zlc9HBzwR54XIS1l9IgUrlClbQ9RPSiSsrH+2Y01euWWSnZoGgpL820mEjWZgXLnW3Zu1CZ09VC8rTZhI9/DaawwX70352v7kqtBKPOoqc/H6hzPX0z3pklj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=xF/7IzY7; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="xF/7IzY7"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=kO1Phuy3HB401WykWQcheLZAPaTS/ITcEYR8FM8rne4=; b=xF/7IzY77TSGpaf3wupO7PL3ZF
	tEqIS7E70Hrb5GnrIUKGKHIdbDNY07cF/Bou+CdDK7Ik3MK54SrzEjF8GXXmX8VJTsgYu5VDP51eI
	JD6XSd8hQJgudaVHO5tQOWawLV46lPYR70II4MFdr62vFnzpPmhRlsQYQupsmsHdcF24=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x6AGx-0057NB-B6; Mon, 14 Sep 2026 19:15:15 +0200
Date: Mon, 14 Sep 2026 19:15:15 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: khendry@reliablecontrols.com
Cc: =?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <clement.leger@bootlin.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	linux-renesas-soc@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] net: pcs: rzn1-miic: Verify port number from dtb
Message-ID: <363ffea9-b3f5-43be-a39b-fe2108a213ac@lunn.ch>
References: <20260914-rzn1-miic-fix-array-v4-0-069112feec86@reliablecontrols.com>
 <20260914-rzn1-miic-fix-array-v4-2-069112feec86@reliablecontrols.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260914-rzn1-miic-fix-array-v4-2-069112feec86@reliablecontrols.com>

On Mon, Sep 14, 2026 at 09:41:01AM -0700, Kyle Hendry via B4 Relay wrote:
> From: Kyle Hendry <khendry@reliablecontrols.com>
> 
> Add check to make sure port number is in range before writing
> to dt_val array
> 
> Signed-off-by: Kyle Hendry <khendry@reliablecontrols.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
