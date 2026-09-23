Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CDDD37F313;
	Wed, 23 Sep 2026 22:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790203799; cv=none; b=SpxzNeH3QAH3W9m6Yj4QZ6VqyI029rZoCJP4hlWJ9KHshkcrsQCc+m/QZjkb0BCF1GfLEKj02fHpCKW5KlrgwxeU7mxyo4CK4+Z8KPlqS1QUhJsi3N+AO4UAcVwdC6isgF6iupC6mwaEgSRnP34ezbBHBC6luHQrdwreCs8JfNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790203799; c=relaxed/simple;
	bh=7N+PHYhwYb4DDxIKQU9bG1rsHVF5yIkzKWglWZwr0YE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FWr2n/sYMMBmdxkuwdQcn+/GoCEUIr30rb+WBcfjVUC8V5ZqSAYVO0CZcnGYunn0IthqKj+httqNuHshtVC+v1dOeNROcRDvaO86t6fY4Epgvpmu9fan7i0luCVf6AStR1N/bhIPsOGQ5w1zFJmA7YkFgq/R+VkF7zGxjK7k+LQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=l8as964Z; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="l8as964Z"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=+L5gxY5rh4nIH2Gf98GBghWlzuQmbFzFgvb3CQBZaFY=; b=l8as964ZT6nGCW65whU2xXAnqD
	oXPLOPtXKMZ+QK8B4o9CEuIpg/98nkGFvLCUehUS/Q3lAiiqkdyH/5YT4kXNXnCzzkTXDMBYi6tPC
	lf0qnh2TfnUFhU1CIfkHjVQ7CAkk9QVA0AhP9wrRQxqCRQC+Wm8IXjqBVk/uFH8ienYM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x9VmY-006tGu-UH; Thu, 24 Sep 2026 00:49:42 +0200
Date: Thu, 24 Sep 2026 00:49:42 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Andre Przywara <andre.przywara@arm.com>
Cc: Liu Changjie <liucj1228@outlook.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
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
Subject: Re: [PATCH net-next v2 0/2] net: phy: Add Maxio MAE0621A support
Message-ID: <2ecfaee1-921b-4d2a-bac3-ce2467b24ea7@lunn.ch>
References: <MN0PR19MB609154F210DF84DCB29D3696ACC62@MN0PR19MB6091.namprd19.prod.outlook.com>
 <2635661d-4be2-4abf-84aa-c3024941f787@arm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2635661d-4be2-4abf-84aa-c3024941f787@arm.com>

> https://www.lcsc.com/datasheet/C49308069.pdf

Cool, thanks for the link.

24.13 1: A broadcast from MAC (A command with PHY address = 0) is
valid. MDC/MDIO will respond to this command.

Please ensure this is disabled. Doing that now before anything is
merged will make life easier in the future.

I don't see any way to control the RGMII delays, or know how it has
been strapped. So this PHY is going to be a real problem. DT
developers make a mess of RGMII delays even when the MAC and PHY do
the right think.

Unless a way is found to either control the delays, or at least know
what it is doing, the only phydev->interface accepted should be
PHY_INTERFACE_MODE_NA. This means 'don't touch'. We have to assume
something else has correctly set the delays in a consistent way. That
is likely to be strapping.

	  Andrew
