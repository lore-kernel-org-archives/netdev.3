Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3CBD3F9F26;
	Fri, 11 Sep 2026 11:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789127959; cv=none; b=u6kO8nbizPN5rPE1C4V9VX/0Uqfr5yO8T3J6xwpFgX/vQJ+Gpu+w9XfyzgTSxIc4jVv7ghrKr9M18RJ+KHSWi2CVxPliZyYSGaZwuhgFvWh2BKA14b6UNt3wx/0IsCYB6poxoWQU/jqihL9QKdaezewRQDfGW9a0a50lVYlz/zI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789127959; c=relaxed/simple;
	bh=uF3FKeS2JNFmSu18cVTe8HrTelad3+e2GFJwuwfT5/U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sMTlhfnV+ifBsTMO64c9VOj6jMJN1DsMT9uEHghpawkrC5/h3KiRyXPe/b2xCRNC8ziGZl4qorENFSEMM+InCLWEvm2jn8/h5i2n0NIKtWTfuAIkT/ubotz5bufsdE1jcKHLLbaXEQguplEx1iTR8c2IK9L6m90iqDOa4jy4Wsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=LJWkaAIS; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="LJWkaAIS"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Kohi64dQ4DmaEMK+ZD5A/ULUjFhzKM3yV198CkL0Eeo=; b=LJWkaAISz58qWqwN3J5USwTBy0
	nDqz9tMtZPPWdDv+LNbrzfhJylQzHihUh3HHb7tR7Vt3HWLVor+DQa1CmlhdqLtKLV9T3fvw8DUMQ
	qkeNdc05QS9115NWIPVLpEPp/Au8Hgs6+uho90r7lWTapEEht0LE+Uozb9d1CxZBZuCU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x4zuC-004gRj-Iw; Fri, 11 Sep 2026 13:58:56 +0200
Date: Fri, 11 Sep 2026 13:58:56 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Caleb James DeLisle <cjd@cjdns.fr>
Cc: netdev@vger.kernel.org, daniel@makrotopia.org, dqfext@gmail.com,
	SkyLake.Huang@mediatek.com, hkallweit1@gmail.com,
	linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Matheus Sampaio Queiroga <srherobrine20@gmail.com>
Subject: Re: [PATCH v2 net-next] net: phy: mediatek: support MT7530 PHYs on
 EN71221 MCM
Message-ID: <8396aeb6-c43e-453e-a7d3-52349b93c528@lunn.ch>
References: <20260909213250.3184238-1-cjd@cjdns.fr>
 <20260911103910.4123567-1-cjd@cjdns.fr>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260911103910.4123567-1-cjd@cjdns.fr>

> +	/* Clause 22 local data. */
> +	ret = phy_write(phydev, MII_CTRL1000, 0x1e00);

Didn't i ask for 0x1e00 to be replaced with standard macros?

> +	/* Vendor profile disables 100/1000BASE-T EEE advertisement. */
> +	ret = phy_write_mmd(phydev, MDIO_MMD_AN, 0x003c, 0x0000);
> +	if (ret < 0)
> +		return ret;

And didn't i ask if EEE is broken? We have infrastructure for that,
please use it.

Also, please start a new thread for every version of a patch
series. The CI tools don't always pick up replies to previous patch
versions, it thinks it is just ongoing discussion.

    Andrew

---
pw-bot: cr
