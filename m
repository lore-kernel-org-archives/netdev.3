Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 799DD240611;
	Fri,  5 Jun 2026 14:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780669428; cv=none; b=QqZqR6DE4oAQc6qS26rqEgW6fHX3YAxS8LiUIUatf2+zstOd4iT54P+p/+0+ktNlOomC5o/3Ly7b/Ae0bK7iRG+0w8tyM3JWWDw7f7f8gve5J2ns3iB0CPJuSR6/jAhzwRdHhFkl4u3jNxy7+zXWQ5U8n7+DGuSwxFA/9HSsufk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780669428; c=relaxed/simple;
	bh=zL/lzmmfDWFwKDK6wayFDCPYUxjUxgUjqtCDO63UrME=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PvK0DqU4RjyR2Ql+as78ToyVLTnJuLLPRgthQBnr855hjyDXlpWcHVnh4fpoN4tMJx0g/1kfFCHV49HGbelwQkNX8c3ZlJEXHJzh/oBB8DKHiRzIoiy8/IWNj/6IZh+7ArX74g5NYAwVZ/xZiuzjuPKmzyEaHOFSUitt3LWSbHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=tqii02+1; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="tqii02+1"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=+UiFjH/LSoAAZHIka7f4lJYjS+IOQfYaLPHOaPjIJ8I=; b=tqii02+1PtEivWqPu92L/19Quo
	YKVckFRAaKjOfz/TcXF27THNktSd1r0boIOdIWlznzydn+yMJbZps5DsJCbmNGuKRs2ELkS/RjoKc
	poLGldVHwd/E6T3VXZtBtfEAbNtUcT4i9/0IC6fXnsiMas7AEkISnuIpculFtONbbcEg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wVVSR-006F80-Ut; Fri, 05 Jun 2026 16:23:35 +0200
Date: Fri, 5 Jun 2026 16:23:35 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: george.moussalem@outlook.com
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v3 4/4] net: phy: at803x: add RX and TX clock management
 for IPQ5018 PHY
Message-ID: <36cd63f4-749e-4b09-b8a6-cbf6924dea88@lunn.ch>
References: <20260605-ipq5018-gephy-clocks-v3-0-f232d9ca0966@outlook.com>
 <20260605-ipq5018-gephy-clocks-v3-4-f232d9ca0966@outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260605-ipq5018-gephy-clocks-v3-4-f232d9ca0966@outlook.com>

On Fri, Jun 05, 2026 at 04:41:29PM +0400, George Moussalem via B4 Relay wrote:
> From: George Moussalem <george.moussalem@outlook.com>
> 
> Acquire and manage the RX and TX clocks for the IPQ5018 PHY.
> These clocks are required for the PHY's datapath to function correctly.
> Gate the clocks upon link state changes for improved power management.

>  static void ipq5018_link_change_notify(struct phy_device *phydev)
>  {
> +	struct ipq5018_priv *priv = phydev->priv;
> +	int ret;
> +
> +	if (phydev->link) {
> +		if (!__clk_is_enabled(priv->rx_clk)) {

Using __ methods is usually a bad sign.

The logical also seems a bit odd. In order to get link, you need to Rx
and Tx. Or is this device able to perform autoneg, send link pulses,
without these clocks?

Maybe when we have a better understanding of the requirements, we can
find a better way to use the CCF without needing to go to its insides.

     Andrew
