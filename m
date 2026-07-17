Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 961A0325494;
	Fri, 17 Jul 2026 15:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784301360; cv=none; b=iQP5uYP2RFNopHdxNEVdfEsjTWQZ4gAUTdLLs+K6LISDV+ejV/WEgevHK12rbTiMN1epl7K1LAEM7QZMnbGDGfgvRmE4YDNCaZX3qhx+pMf54vgUZ/Dq9aVdvFlGOt8iMRTk/CC8Tahrb1S07/P2TrvxYiWwV4/iXnT/6J4LVes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784301360; c=relaxed/simple;
	bh=ejAiFtPfqvoU0cHxCN0O1MnsvxFJwWaamocYAYroLGo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ScgBfvIiSObV0yPTbW3+EtR3FmWB3+etQB1Blu3X4ZDyDRDIdQ9WtyEZBCcXBIgGoO5TjNu4U6yWJw/qWYjnEuEQEq9zndYUMvoM19azseMDYnt7ta8x5QRC3ULdD+Bhw7wcQm6obLBvFWQRw4P/bQ/4+aaf/+DRkzvDfrEXFPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=CxF+dhqN; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="CxF+dhqN"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=6Z7vJicvsx8yhLtOQMr4scBeET28BhC52LGcdrsnXbY=; b=CxF+dhqNEyHd6bjwhGqyTTPxQx
	VTTxqLnTXbbaI3PYEC5FSD59huZaF5nlNsqfh/aXPNWU/bKipPbGySraKepE7N9NMvTj7s6G+a/5R
	b3QWluamoZiP/V9+EiAR8jOerjaF4T9R+0SrACNULhbAfsXB0I6qA7ga/ap3VELWy1Z8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wkkHw-00CpXV-Q1; Fri, 17 Jul 2026 17:15:44 +0200
Date: Fri, 17 Jul 2026 17:15:44 +0200
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
Message-ID: <9b604f00-701f-4194-9002-304c4d93003a@lunn.ch>
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

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
