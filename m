Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B53409266;
	Sun,  4 Oct 2026 20:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791145062; cv=none; b=PL9xuVtEDPZtf951THArl6FOzvlR9BHA7OUsn2ILOo5NRtOkczxeTpHWvXvHcSMJ5xZ8ihqatIolzcGrrCvfMH6wkUjszbBGdXE9fjha2msnMRJeISWRrktfwRS9mQsdCqF11SZr4V7kPTOB4/XQafJVq4yrbvk/Yl2aaewbjso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791145062; c=relaxed/simple;
	bh=u1qwHVsKJGZlVjTIpJIv+s1rcfyxFJLvXNW59VgQcC0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SCpmaAXI+64jcs55yFm3LpJr8MtUh1Ls3XWxjbO6p2EGYcle5kj9y5S0HdHVtlnphI/6NSwtMxzUOZIXADBXqzCrdeN9sQJDFkeCuFXIQCnur8NVOhzHLSHprZ6x6p16Dja81nyjsdoKpUkAhQ6pEVF0Zxvu0dGImcLluVxHNKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=IZazm4Xy; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="IZazm4Xy"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=bR3SRhKCmzmX9coE4hC/OPg+4S7sEFFbseBqUid8HSI=; b=IZazm4XySWJtW7yktdM/0v0t+A
	2XyfJmVCt/otVf+cvgdDLNdvNdGyUf0EFX57mUlG30Ugi2+MJQZ2YIuCTlIt4PLwYpOGWhI8AhfLd
	wC3EdwEn7ZBD8P37dMdDBQEcdptBr3u8k/zyhF6NpvS6NN2dK1SA7EF5RvHurD127lxU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xDSe8-008w3J-9Z; Sun, 04 Oct 2026 22:17:20 +0200
Date: Sun, 4 Oct 2026 22:17:20 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: David Yang <mmyangfl@gmail.com>
Cc: netdev@vger.kernel.org, Frank <Frank.Sae@motor-comm.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: phy: motorcomm: Add cable test support for
 internal YT861x PHYs
Message-ID: <8a9ec69b-0823-48b1-aac1-f40cb4713f23@lunn.ch>
References: <20261004184246.1260426-1-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261004184246.1260426-1-mmyangfl@gmail.com>

On Mon, Oct 05, 2026 at 02:42:43AM +0800, David Yang wrote:
> The YT921x switches integrate GbE PHYs of the YT861x family (PHY ID
> 0x01e04281) on the switch-internal MDIO bus exposed by the yt921x DSA
> driver. Without a specific driver they bind to the generic PHY driver
> and lack the cable diagnostic facility. Add a driver entry for them
> with cable test support.

Since this does two different things, it should be two patches.

Does the cable test code apply to other devices this driver drive?

> @@ -18,7 +19,9 @@
>  #define PHY_ID_YT8522		0x4f51e928
>  #define PHY_ID_YT8531		0x4f51e91b
>  #define PHY_ID_YT8531S		0x4f51e91a
> +#define PHY_ID_INT861X		0x01e04281

Is this the ID of the switch itself? It does not match the pattern.

>  #define PHY_ID_YT8821		0x4f51ea19

	Andrew
