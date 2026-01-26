Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74AD633B979;
	Mon, 26 Jan 2026 14:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769436826; cv=none; b=E4MLb5JfgKlWqUOoHlCSw/zQd4j7r+zafO5mvAO8AJ7rYuIsMvYw1VdX/NFITo1BavbaZoQzt8ZGqBFOxLOEU3Dhc0SmFEdvM1O/UQ9/AFTp87PTHmyldEHnKVXJbZo5vo/aTTyn0NKvuetIkYP6D+qFeR54x2KUKJufLpnZKxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769436826; c=relaxed/simple;
	bh=c8wHS1GSDT/p7+BB9QJ+uPyVPlyARHIFJQOIjLEpzsM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wqd+uhzBskQbPHb1t6kLqJ7NR16VP8WaRg8LBgwZFCWA8vsVXGxcIe//WVihQpzgha3gjhqC1tkYCxIBxrkZLKvfyGk35/rM/A4ctNEw9kg8WHFssjFSoEpvepCK+aID7oq3qoYZTtYZqm9xcZTn6qml4Tq6JZI5uBPhowtVRwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=qy/ZK3AK; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="qy/ZK3AK"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Si7F027L4MHkHl6W8g2C1ydhbQv99XYtueMfjkYDZqk=; b=qy/ZK3AKQMpij9zi3RjCOr/C4F
	ALnwB/uPmNV13sdSWjpXYuEuOjkJUKcoLtkGqVsyQIj674vpmj/Qg+WMGqh3QBruCfD3BWcu7ioSy
	eHQ4rEpC/+cHxLMpSSyknH8fCuSFUqBzimbvOvADBdqDB4tTOeKTDQ1k6zcLflyMPdtI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vkNLK-004nBB-B5; Mon, 26 Jan 2026 15:13:26 +0100
Date: Mon, 26 Jan 2026 15:13:26 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Wei Fang <wei.fang@nxp.com>
Cc: hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	florian.fainelli@broadcom.com, xiaolei.wang@windriver.com,
	maxime.chevallier@bootlin.com, quic_abchauha@quicinc.com,
	quic_sarohasa@quicinc.com, imx@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: phy: add device link between MAC device and
 MDIO device
Message-ID: <2344001a-08c4-42f9-b4e6-116e39fbf1a3@lunn.ch>
References: <20260126104409.1070403-1-wei.fang@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260126104409.1070403-1-wei.fang@nxp.com>

> The commit bc66fa87d4fd ("net: phy: Add link between phy dev and mac
> dev") has created a device link between the MAC and the PHY if the MAC
> uses a shared MDIO bus (The MDIO and the MAC are two separate devices).

> Sarosh Hasan tried to change the DL_FLAG_STATELESS flag to
> DL_FLAG_AUTOREMOVE_SUPPLIER to fix the issue [1]. However, the solution
> does not take into account the hot-swappable PHY devices (such as SFP).
> so when the PHY device is unplugged, the MAC driver will automatically
> be removed, which is not the expected behavior.
> 
> Therefore, to solve this issue of the shared MDIO bus, we create the
> device link between the MAC device and the MDIO device, rather than
> between the MAC device and the PHY device. And when the shared MDIO bus
> is removed, all MAC drivers that depend on it will also be removed.

Shouldn't there be a full chain here? MAC->MDIO->PHY?

For the case of the SFP, maybe it should be

MAC->SFP Cage and I2C MDIO->PHY

So if the PHY inside an SFP disappears, the I2C MDIO bus is
removed. But there is no link upwards from that, so the SFP cage and
the MAC are left alone?

    Andrew
