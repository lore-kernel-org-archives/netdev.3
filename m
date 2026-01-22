Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB68F4D2EEA;
	Thu, 22 Jan 2026 16:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769098029; cv=none; b=GV42G8larMWqxGSaDJYEJIXDB/3OXobe1BRwd63UDHng+0TsPsfQjYVVcjXGou4mmgVM+F2J3xtr8W4ogyPlovuz9ApS1E7odDRPL2tPSCPcWRt2JR4ZypRoraKj7jzZ+IuhBFGw0nwHzdxRdX06KT5jdMI7n+Vqh+txE+0NywE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769098029; c=relaxed/simple;
	bh=jL+8Oq/TlekPAgsQGzQteQHAVfM4j4PN6HEzQUiJ+BM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KI3b9hPkWeugAdaHvN7TIiOyfvOlsCZ8NpGpTS4ET5D4LJNN/380m/M4U7SgupQ6PnbMcZD/mli/gP8+/eyept6hYYiHBE7QLB5tMMfSACCg8eBGt2yLOtuZG1ugXba4psm4l4+wh1okcU6PQCzAuwRNlOXqBYLtujctjE41hYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1vixCx-000000001Dx-0C9w;
	Thu, 22 Jan 2026 16:06:55 +0000
Date: Thu, 22 Jan 2026 16:06:51 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jonas Jelonek <jelonek.jonas@gmail.com>,
	Markus Stockhausen <markus.stockhausen@gmx.de>
Subject: Re: [RFC PATCH v2 2/2] net: mdio: rtl9300: setup PHY polling
 registers
Message-ID: <aXJLG8cPKqseTbDK@makrotopia.org>
References: <cover.1769053496.git.daniel@makrotopia.org>
 <680696024a8648535ce6dee771fe4de67802e0e8.1769053496.git.daniel@makrotopia.org>
 <aXITnCLt945xHqaP@shell.armlinux.org.uk>
 <aXIke6nASlCSJVuF@makrotopia.org>
 <8663bcdb-4c53-45f5-88fc-1f01f816e8b0@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8663bcdb-4c53-45f5-88fc-1f01f816e8b0@lunn.ch>

On Thu, Jan 22, 2026 at 02:46:58PM +0100, Andrew Lunn wrote:
> > Only a small subset has been seen in the wild inside RealTek switches
> > for now. Most, of course, come with RealTek switches. However, it is
> > only very recently that RealTek offers 10G PHYs, so before vendors
> > were using 10G PHYs of other vendors, in practise I've only seen
> > Aquantia.
> 
> ...
> 
> > Yes, that does sound better, especially with your concern about
> > ->supported mask not necessarily being correct at probe time in mind.
> 
> FYI: The Aquantia PHYs are particularly bad with ->supported.

Yes, but the PHY driver takes care of that and implements fixes via a
custom .get_features op. That's precisely why I'd like the MDIO polling
controller to rely on what the PHY driver has "discovered" and set in
->supported, instead of doing all that in duplicate open-coded MDIO bus
scanning and PHY probing in the MDIO driver, which is exactly why I
believe we should have API for that.
