Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BB474A92DA;
	Tue, 15 Sep 2026 12:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789475514; cv=none; b=vAMcUW4az+iSExJdrbxhHCg8udqhBz1ouZphpdIcZtw9AUSKokht1Um8F7hLpWmJU3L1DtXgb+RTTrm/L0jg2mlJOTuk/EEvu2bHGvMukXtkzHXbbEuo1R7zoJ5d04au56dlX8Q3/UIQmKqYgrsRgKQRRBE6LyJmQdzVb54PDHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789475514; c=relaxed/simple;
	bh=NotqGt/cwRysV13eB/XwSofHi8mWZEX1MwX3av1vOiM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z5FdcCot2PuXczmAaFA4cW8daqzksBd6W98ugcRgzASA9vUbqIOzHINa0yy0SOTbE3o7s7rL35WttZdP2x/CaKCYDvIcay7ZM+3AOfTkYY+iDyhFcDkQb0JcShR66WxNCG7L6cBRqiLydXcRfoZ1/q7xc9DHFh5wqLPugYSvXOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=MkV1pFmT; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="MkV1pFmT"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=+wwru95lzhHcKNI7tsSUmz6jLQHOkFQw+Fo18okjPSk=; b=MkV1pFmTDYK1sMYTtwT70NM0CD
	gYvRV+8emPMmGGHe3pSHb/HvpRUUSdtrgBHoR+elchL1E48lf8u9fUHpMgP5IJpYeO4gCBDm+0X29
	mFBSqyv9m0/7W29Maij74mCnCt2AEF2rfT1/yzfPdztHZ42l5B11fUEZ2mrymkhUJWyM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x6SK7-005GuK-Kv; Tue, 15 Sep 2026 14:31:43 +0200
Date: Tue, 15 Sep 2026 14:31:43 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Kyle Switch <kyle.switch@motor-comm.com>
Cc: Frank.Sae@motor-comm.com, hkallweit1@gmail.com, linux@armlinux.org.uk,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, ming.xu@motor-comm.com,
	xiaolin.xu@motor-comm.com, jianmin.wang@motor-comm.com,
	jie.han@motor-comm.com
Subject: Re: [PATCH net-next v18 3/3] net: phy: Add driver for Motorcomm Quad
 2.5GbE phy
Message-ID: <46ad6aa9-c71c-4bea-b997-f2ceb57adfa6@lunn.ch>
References: <20260915082152.3104633-1-kyle.switch@motor-comm.com>
 <20260915082152.3104633-4-kyle.switch@motor-comm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260915082152.3104633-4-kyle.switch@motor-comm.com>

> + * yt8824_utp_invalid_test_mode_paged() - config YT8824 to invalid test mode.
> + * @phydev: a pointer to a &struct phy_device
> + *
> + * Returns: 0 or negative errno code
> + */
> +static int yt8824_utp_invalid_test_mode_paged(struct phy_device *phydev)
> +{
> +	int ret;
> +
> +	ret = phy8824_page_write_with_lock(phydev, YT8824_RSSR_UTP_SPACE);
> +	if (ret < 0)
> +		return ret;
> +
> +	return genphy_c45_template_testmode
> +		(phydev, MDIO_PMA_10GBT_TESTMODE_1);

MDIO_PMA_10GBT_TESTMODE_1 is defined by 802.3. How can it be invalid?

Is the description wrong, and this hardware does not support test mode
1?

	Andrew
