Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EA15352C34;
	Wed, 23 Sep 2026 22:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790202640; cv=none; b=qOb+0oYau7pbQ6nIDTHzDMjf+UOLtBcojBf5y6VENl8gFo5ruypWyLSEQl0QcItLg8wrqR1l/w+E17bUl8eC52iB641R+f0BZLvufZoPbpLI86WPUsYCwWgLweWgMiU0YotnOpl9MnHj6OezckKNpBliCEKUOJ3rqYGsFSJORkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790202640; c=relaxed/simple;
	bh=8xiYObyMEcq1Fykp/tkD0dEEJQOsTwGkWOBCkd9/jWc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IXnmLBHh+Ymih2486EpeBQHprRemqrhhzJgibzkr/4sKt0dbsSUBeBbStE4/6j41E3lO65EBGxvHOLwqu/WP6GgE5KOZX4XOtagJ1iTU2wPNqlBIJE+wrlzB0t8kRtwgQb9bh7I1X7XusNVbSU/aZ6J3OhWBOT4PfDZXGu5xRns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=QfmOZ8W7; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="QfmOZ8W7"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=oID3liBFdIyTSGmV0vyfKcgZpY+lfMHJz1T6fFJ15BA=; b=QfmOZ8W7WlbVRwzSBUirCaHZDl
	P0dUIUwU6IyPbpAejBilnke4XNGAZnNjHGS97ez5awgw+GoYKbcUxAaaYSZ8q9dk3DfRFwY7eNm4e
	wiYJino8Nf1Bzz+MZ/2NoXxYZc9WcCtpbcDyM3U4dEzo/NNPo/bGRuUwi5bI6iEJL7Go=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x9VTq-006tAG-5w; Thu, 24 Sep 2026 00:30:22 +0200
Date: Thu, 24 Sep 2026 00:30:22 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Liu Changjie <liucj1228@outlook.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Luo Jie <jie.luo@oss.qualcomm.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 2/2] net: phy: Add support for the Maxio
 MAE0621A
Message-ID: <485d6e8e-2097-4a45-9d1e-0041c7bb3980@lunn.ch>
References: <MN0PR19MB609154F210DF84DCB29D3696ACC62@MN0PR19MB6091.namprd19.prod.outlook.com>
 <MN0PR19MB609153A4A590C66241B8A3CDACC62@MN0PR19MB6091.namprd19.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MN0PR19MB609153A4A590C66241B8A3CDACC62@MN0PR19MB6091.namprd19.prod.outlook.com>

On Fri, Jul 17, 2026 at 11:44:03AM +0800, Liu Changjie wrote:
> Add exact PHY ID matching and optional 125 MHz CLKOUT configuration
> for the Maxio MAE0621A Gigabit Ethernet PHY. Preserve the existing
> hardware configuration when the firmware property is absent.
> 
> Signed-off-by: Liu Changjie <liucj1228@outlook.com>

Sorry, but i need to withdraw my Reviewed-by

pw-bot: cr

Discussions about the Cubie A7A indicate this is an RGMII PHY. You
need to respect the phydev->interface settings of
PHY_INTERFACE_MODE_RGMII*. This driver cannot be merged until this is
fixed.

     Andrew
