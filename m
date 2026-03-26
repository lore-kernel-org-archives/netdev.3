Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F7CC34752A;
	Thu, 26 Mar 2026 12:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774528256; cv=none; b=qrTtwuUL1KYC+hSiV7mDkinBQD+fxz525rz1W/IcR227CEUCZ4RFQj0vAk4IHQcGWVnksTVKC2/FrDYmujHT/cJc5GJ/QGwTdc+4hIfov7Jgv96hu6UP0kfMZ3YXRNtUqZyzR20mifQuwHqWWcd1jGmhiHJhR+jc8qJ2j2cya60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774528256; c=relaxed/simple;
	bh=RjvDQC1oQ3UHHvEXuIIMU37RbORV6qF9eWHDoq3G4rg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q4OfreDVc+VeT/GdPsdsJeYJZx20NrLm6bMrGKi6+WQc3Abdm3W9w8fd/n21yTg0XBtz09skGxRCO4QNslLsGd6rVSTaRCkiYLpBXwoUC3ZMJK+BXD03TKuAV4oLwBKbbu6NVKTnly17nsdRp4NV4ilIP/FeqXhBGQOOOE6KsVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=12yVv4kb; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="12yVv4kb"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=TgolnSBH+ynVMNrVf0h58DK/Vli52VqvQ0ctg5iB3tA=; b=12yVv4kblc0T+US3oSZ8Iw2Sc+
	zzOYDPXwgygaj4SI9XH2A9BM27TKLWQjkyX6ik6BrxGnQCEM2oQ8Z4YsOEOlN4ehs9ap0E+3aTk/k
	nwsySW0RLKl5ByWluBh3kOG34Sc+Cu0YcK6GnsKFkM1VGxsSAF/5770zRFbI3Me/NVRs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1w5jrD-00DTWt-6Q; Thu, 26 Mar 2026 13:30:39 +0100
Date: Thu, 26 Mar 2026 13:30:39 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, kevin-kw.huang@airoha.com,
	macpaul.lin@mediatek.com, matthias.bgg@gmail.com,
	kernel@collabora.com, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 3/4] net: phy: air_phy_lib: Factorize
 BuckPBus register accessors
Message-ID: <3bd7803d-4c4a-4f61-9434-a6bf25627b58@lunn.ch>
References: <20260326-add-airoha-an8801-support-v2-0-1a42d6b6050f@collabora.com>
 <20260326-add-airoha-an8801-support-v2-3-1a42d6b6050f@collabora.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260326-add-airoha-an8801-support-v2-3-1a42d6b6050f@collabora.com>

> @@ -480,8 +287,8 @@ static int en8811h_wait_mcu_ready(struct phy_device *phydev)
>  {
>  	int ret, reg_value;
>  
> -	ret = air_buckpbus_reg_write(phydev, EN8811H_FW_CTRL_1,
> -				     EN8811H_FW_CTRL_1_FINISH);
> +	ret = air_phy_buckpbus_reg_write(phydev, EN8811H_FW_CTRL_1,
> +					 EN8811H_FW_CTRL_1_FINISH);

Is a rename required? Is the namespace air_buckpbus_ used somewhere
else?

	Andrew
