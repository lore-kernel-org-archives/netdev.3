Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51766392C28;
	Thu, 20 Aug 2026 18:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787250294; cv=none; b=IJX1hkR8+/z/dB6b2dYPL998p8IUJnvTEUAbICErVrDp2rwfuESpMslhOhKRaX9nCF4P6oB3CU8xWpxY3NxXbV3WNjZhxLh/AZ9JB9O4/7aYuRtyAONGm66x0R7iwPa+YdhlhXYY3thpX9KqMLQBMVkw72rXYFvKK2J2BpJI+Qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787250294; c=relaxed/simple;
	bh=FtAqSkxI1TL6V3GHh0TbeAE9oXleFbUYq/ZwQzBIE28=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ho62dTXaXXsPV5SuenjRJJjtr4x9ue9kFaO64NEssXoNj9Oy6ZTV/oM92zNK2fdJUeg+XGNyUPBqC3Zunm2tQtw54UdBimtdwx8jIyOf9pAJZmJWOUiVIYCRZHJ/EdIZvTp96qv6fMMe5K2wE4jv7eeerq1QT04bVNOxa1nBNI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=0eFTG2lo; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="0eFTG2lo"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=L+LXEthcrKG+/dxAw/OipLYEwVkLQuVKHCtJz6ejk4Q=; b=0eFTG2lo8KkyftcdwgjGsUHnoE
	iUI/+K+ALSKV9KZDIiIj6dWcXD/pkYXV8gzdzOaeK/JmkfNSO+kKNs2yPjCICSJkHkJIQ46XxZxzV
	iUZ8QbC68NbmJEUiI/QiPj0FoNc+FXHGSNaaeX9xrDkqAuAf0Fvp84tB+kCbyzP/oMPc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wx7RV-000pTB-3t; Thu, 20 Aug 2026 20:24:45 +0200
Date: Thu, 20 Aug 2026 20:24:45 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Patryk Biel <pbiel7@gmail.com>
Cc: Ioana Ciornei <ioana.ciornei@nxp.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Vladimir Oltean <vladimir.oltean@nxp.com>
Subject: Re: [PATCH] net: pcs: enable autonegotiation for 10g-usxgmii
Message-ID: <e7b87ff9-1ea2-412e-8418-89141b2a106a@lunn.ch>
References: <20260820-b4-fix-pcs-lynx-an-v1-1-62d66391eaff@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260820-b4-fix-pcs-lynx-an-v1-1-62d66391eaff@gmail.com>

> @@ -154,6 +157,7 @@ static int lynx_pcs_config_usxgmii(struct mdio_device *pcs,
>  				   const unsigned long *advertising,
>  				   unsigned int neg_mode)
>  {
> +	int ret;
>  	struct mii_bus *bus = pcs->bus;
>  	int addr = pcs->addr;

Reverse Christmas tree. Please sort the lines longest to shortest.
	
    Andrew

---
pw-bot: cr
