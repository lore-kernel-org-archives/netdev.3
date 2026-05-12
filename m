Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE5903AB5D4;
	Tue, 12 May 2026 12:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778589860; cv=none; b=mOJ0D97cbeAshUHUB5szn4MQDq1MtjE9mwWvdtFQtQlTxxtl9h5IqDkNmaYIdxx13DOQJ1/TcE2ORIQFMnPzGOxk6e7CXTz2aOqFsJRsMUFT7PYTZaJZcMXJcySeWDVJwD0cGkGc9NPFW7CbGWBnwd9+lUCZZoo0lgmnVrjCc3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778589860; c=relaxed/simple;
	bh=ynnjv97wfx/V36rrNYcpM4Ajjb87ua0e4tF3T4P8P70=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pMP1XoC6YGt9ZV/iYUTfCO7AbUUCT05jGR4BT/iUvt4nv8dEWTEyekmtp5ku0KZlZsLJmwSCQTNnWNKm9+nKXH+ZBEd4F1Ppfa7i2PYy43CGiRO2LDbxyG/O1qB+JWFuE54oZBekWjPjWS9KDji+oRRvEMCHOOHz1iXbFFIWS3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=EdIWecXn; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="EdIWecXn"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=lYPN7aWKZlgH0kIpN2gEWZFs4l/E1/Sd8KYgxMgHv9I=; b=EdIWecXn9FLmtKOpxElIumvSN7
	0f8evQ8X7XV6zr+MFoBSJYHWegzcQUYPf9v99yioakDL5ynkBLYtQE2XW0BWMHsnKL+AWEk4vDYoi
	HegdKl7bVr4rYFS4F3bD6rSstwk+P6xV0qZ9Vm8vt534o18Lt3fPMIsScVyy3TB/E43s=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wMmSo-002XrU-Pa; Tue, 12 May 2026 14:43:54 +0200
Date: Tue, 12 May 2026 14:43:54 +0200
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
Subject: Re: [PATCH net-next v3 2/6] net: phy: Add Airoha phy library for
 shared code
Message-ID: <e8820956-7f75-41f4-80ab-a0fca1637072@lunn.ch>
References: <20260512-add-airoha-an8801-support-v3-0-1edb34e363ae@collabora.com>
 <20260512-add-airoha-an8801-support-v3-2-1edb34e363ae@collabora.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260512-add-airoha-an8801-support-v3-2-1edb34e363ae@collabora.com>

On Tue, May 12, 2026 at 06:33:19AM +0200, Louis-Alexis Eyraud wrote:
> In preparation of Airoha AN8801R PHY support, split out the interface
> functions that will be common between the already present air_en8811h
> driver and the new one, and put them into a new library named
> air_phy_lib.
> 
> Signed-off-by: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
