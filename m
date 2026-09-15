Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37502386C12;
	Tue, 15 Sep 2026 12:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789475601; cv=none; b=ZWPavElBQUfhol+TYaZooXH4R8WpRnwMy2mDBn+ceqTdZRfnfOp/eM5HamTwzgrgYPHe/oIujLmNoFMFnXGsVBhKQjqkAnysXh5KLtupmzjpqgj5yhpheWam/wXnWSmL0U/hRG0qFOGobNkRAm6lyoma28yCjusFaDlC+TK5Pkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789475601; c=relaxed/simple;
	bh=PEdC9lUTtTiy2Z9U5c3/mMH1KhlSdoWVq+Jq6NpvPtw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nWTUd27vxlSJWWS6alPjQcz2PUp8+HcutmFViG245GCWf08Vr4jLtm/OduOFYXtfB+12lThBDrmGFm5mNXQnUFn3f1DlRB1jU45xip/2ziUW8+0grjoEtQya5eNxAT2IahWLQcFK6bsmWj02oaJANm3at2DyZNyVTr5bf1DLrlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=hrYUC0Ua; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="hrYUC0Ua"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=T7/OcNgwFxHkq9ta9WPinQOw3Opc1nnVp+ZFlRvoxuw=; b=hrYUC0UaA8pMJIfPeFaXe9oc5O
	D1PlZSP6U96blhaIfX645wa8Xphz0z4qBzAzx5P7BArUW2i+DTH0kaHoG1GdpTRO9n+HIUgrl6DXd
	vb2Q8QF7aqpH1hYbEwvTt6m68q2kojpDwUDMq7Injj9wLFoN3caHfGf/Z7vEp1CSGsDs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x6SLY-005Gvx-Nt; Tue, 15 Sep 2026 14:33:12 +0200
Date: Tue, 15 Sep 2026 14:33:12 +0200
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
Message-ID: <c1b1409e-c01e-4074-8e38-73e630deb751@lunn.ch>
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

> +	res = of_get_phy_mode(np, &priv->interface_mode);
> +	if (res < 0) {
> +		phydev_warn(phydev, "%s, phy-mode missing in DTS.\n", __func__);
> +		priv->interface_mode = PHY_INTERFACE_MODE_INTERNAL;

In the binding you say phy-mode is a required property. So if it is
missing, it should be a fatal error.

	 Andrew
