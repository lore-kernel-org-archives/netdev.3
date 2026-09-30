Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5672650AC0E;
	Wed, 30 Sep 2026 17:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790789022; cv=none; b=ieeIZlNwL846ccgOLR+PVN/dcG7x2VReAGmcWMgTCpbfWRS/ZVooo/fRZnq22k5bwMYs710uiN+CMXhX1EXbPV9t2VtE06hPAUmuR7nsdcwjDltg/5D7QRru+VHCg7frCp6Aln6WQWOY7bEnh7O8tryk+8g782T9eF5K6j8q/9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790789022; c=relaxed/simple;
	bh=R5LanrnPNGM9adp6GAp2YNkPnKVEeuPfLVmOUuhLk5k=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=l/iyXaTjFhRbKnCtnA93S9SGV6ahVqkJpK/6p02gw9jbbUpuroLaHN776O0PKuxjh229Ylxq6on+wM6T9a9/HiJv4sh58I/sfDbuScKljmpKHyhidW5z6YRAJ3HkFz/BkqZwBeZdYavRWcIPLKOeWt+iswThE6Tr9JxiViwhbSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TM3It2xb; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aOPkZgaR; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TM3It2xb";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aOPkZgaR"
Message-ID: <2c0a9d5f183cb9537b3f89016800247bb7b673c3.camel@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1790789019;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B6W8wYUuNF+9KH8wiriFXCa8qGDy8H8gBzB8t+V9+Dc=;
	b=TM3It2xb8wd64B0E8QNfdisnTvhiC0zMBQ9dVYTw/CmcvvndOW+dVJd5OOh6yuha08O+rB
	P3R86zYifRls6wQR7drgP8d24hJ4swWofUnCGul2IJwjtppymysiyHnh1nS33TD7/1PFDd
	vI01pTmqqJARSJPyjurhCoEMoktUCzp2f4oDSlXvBRBLY1Ns+Dj6Wfgz5M/GD/o1bVbURy
	BTUc2HF6t1HrlIWZeyZ2GnvM/JOqmhgHjJ+JE1HXVu+voUrhKbGk4S5x7/ebUQQJkC6WD9
	EbSridqwxuQayUD/TuTmvcYL6yfCUqX39V4aOAXEMe+kq16newGGftXYtMuOGQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1790789019;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B6W8wYUuNF+9KH8wiriFXCa8qGDy8H8gBzB8t+V9+Dc=;
	b=aOPkZgaRgqA2lTa7KLLEOMuRQnFMhkO9KO2Wt3Jt4TgMMDT3SXjs5ecsWO/WNVdLe6uKkI
	BRBjgP9sxyETsiDA==
Subject: Re: [PATCH net-next v3 5/8] net: mdio: Add SoC-e SWIP MDIO
 controller driver
From: Vasilij Strassheim <v.strassheim@linutronix.de>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
  Conor Dooley <conor+dt@kernel.org>, Vladimir Oltean <olteanv@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Russell King
 <linux@armlinux.org.uk>, Andrew Lunn <andrew+netdev@lunn.ch>, Heiner
 Kallweit <hkallweit1@gmail.com>,  devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,  Martin Kaistra
 <martin.kaistra@linutronix.de>, Benedikt Spranger <b.spranger@linutronix.de>
Date: Wed, 30 Sep 2026 19:23:38 +0200
In-Reply-To: <e4440c27-5551-482c-95ae-9b75481bcf7b@lunn.ch>
References: 
	<20260923-devel-vstrassheim-soce-dsa-ml-v3-0-ddebafcb9ba7@linutronix.de>
	 <20260923-devel-vstrassheim-soce-dsa-ml-v3-5-ddebafcb9ba7@linutronix.de>
	 <e4440c27-5551-482c-95ae-9b75481bcf7b@lunn.ch>
Organization: Linutronix GmbH
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2026-09-26 at 01:10 +0200, Andrew Lunn wrote:
> > diff --git a/drivers/net/mdio/Makefile b/drivers/net/mdio/Makefile
> > index 048586746026..079b46dea25f 100644
> > --- a/drivers/net/mdio/Makefile
> > +++ b/drivers/net/mdio/Makefile
> > @@ -23,6 +23,7 @@ obj-$(CONFIG_MDIO_OCTEON)		+=3D mdio-octeon.o
> > =C2=A0obj-$(CONFIG_MDIO_PIC64HPSC)		+=3D mdio-pic64hpsc.o
> > =C2=A0obj-$(CONFIG_MDIO_REALTEK_RTL9300)	+=3D mdio-realtek-rtl9300.o
> > =C2=A0obj-$(CONFIG_MDIO_REGMAP)		+=3D mdio-regmap.o
> > +obj-$(CONFIG_MDIO_SOCE)			+=3D mdio-soce.o
> > =C2=A0obj-$(CONFIG_MDIO_SUN4I)		+=3D mdio-sun4i.o
>=20
> Maybe the indentation is wrong here?

This looks fine in code.

>=20
> Otherwise:
>=20
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>

Thanks, but I can not use it yet. Need to fix an issue with
devm_ioremap() return value check in the next version.

>=20
> =C2=A0=C2=A0=C2=A0=C2=A0Andrew

Vasilij
