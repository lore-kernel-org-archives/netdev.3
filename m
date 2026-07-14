Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 842FA429CDB;
	Tue, 14 Jul 2026 22:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784067891; cv=none; b=pVWp+u1TzgoQ7TzvrGqgTNi9iUGutP9R8uiJOChi5o9mesl1sSkmItFfBG8inV2G2n+ZF6brysT5nk1k6xeanqkyCg7TIEFzup7DcvknYg5icaIocANiS4zcKyCVgApTU4keFjLC/UZo3DsCMmq2vk+xBgFMi3E1gobPOBSGbXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784067891; c=relaxed/simple;
	bh=WjUdsnmG6kJaY94oopJ7Nrt6XW/SIghlloJr/hDquGs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tlMIhO+PPY2fm27rsnPUZQkOcNpT2xmPqUoeZslEIJKhrHjPsRu/Lxx4WSxbGKziH4y0TsgYqP/wsYbQfyLmWcNUh3uaqufkxFw2A7U0j536V/MgHdXpV4i4OfiPlOnx3E7xMgXQ4qPh68IYPwv0KC91JD9lhkrjw+TpDcqyx4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=h0HxpOTr; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="h0HxpOTr"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=MjgjLQLPa3I+YHzOEV/tl0iAWkyyC//E5T/+Ys4ev38=; b=h0HxpOTr+/43BhbJ8GIjoW+j3R
	UUn7g0diAfMQxHt2l8mqpg+oDFsquBX62N3OrNM84w5Jf/Pdux88kIJuKokAaknIzRyVW4tzrugaY
	qrKclFRzuj+flAuZDcJWUpKJ6OqCM0/KZCV/m6KG/+eFGRvLXc12D8qZqh+1ywZfq49A=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wjlYO-00CGEU-Fa; Wed, 15 Jul 2026 00:24:40 +0200
Date: Wed, 15 Jul 2026 00:24:40 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Heiner Kallweit <hkallweit1@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com
Subject: Re: [PATCH net-next] net: mdio: Kconfig: Group mdio controller
 drivers in a submenu
Message-ID: <88337510-c471-4adf-af5c-bace6ebcb867@lunn.ch>
References: <20260712201739.260742-1-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260712201739.260742-1-maxime.chevallier@bootlin.com>

On Sun, Jul 12, 2026 at 10:17:27PM +0200, Maxime Chevallier wrote:
> Currently in menuconfig, all individual drivers for MDIO bus controllers
> are directly listed under Device drivers -> Network device support.
> 
> Let's group them altogether in a submenu, while keeping the dependency
> on PHYLIB.
> 
> All options under the new submenu match the drivers and infrastructure
> listed under drivers/net/mdio/Kconfig.
> 
> No intended functional change besides the menuconfig ordering.

Looks good to me.

Maybe also move the MDIO MUX drivers into a submenu? There are nearly
as many muxes and MDIO drivers.

   Andrew
