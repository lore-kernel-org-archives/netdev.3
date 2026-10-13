Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A54B3CFF53;
	Tue, 13 Oct 2026 02:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791857610; cv=none; b=hBSEybSkPMOM583oaH0fi1Zx8MgAzGrUaBPmQ+xRz4DL9zobIe+19AWt9G1XqJIhHxRY6N6JswnbGka/ZD8keAgcr7PQc18V4zxJ+gZeyVOQ2kGvZUP6IawmDs7nLiuGxYXjU6WguLpk3JiGrW6BDM7Xkv5e7h1z4cVY/nsNBkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791857610; c=relaxed/simple;
	bh=Jn0SDeD1V+avjVmnUWydyHBaO6cE6AHA/uNev54tFZY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B52t3MIgS4ug0FLrXPg1ZO06YVf2OlsxOCwfcYAbNZ9MUT149kzKq4rxQ7TUvCZfORw7zljmjE410rW4ngQKLF5HltuAPKf6R76aRhQ2OZNEEYXX5nzAKChZ99JQ9Mddu/gZqDBfId4mykz+kwZA01QlMW67q+kpQtn3ycRTgYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=JnqbYjKl; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="JnqbYjKl"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=frTjziEXsjPkehw6ldEyzomZwjttuXVfGetNc64iGcU=; b=JnqbYjKlggvC7W6EEy6UvKDwV6
	cIaApNG0drWOBw9CKatsWDf7wpXk+y0IelHbd09AzFYL0Uj3dNHLssEsbfk4iCW/GJsjBlzC6JXfs
	d9Li8kSQkjZZ9bEENLrMDpzimgrZ3LH/ncdVgxbjgHqhUTx0WZYeAjrM+9bFsPxO4g+M=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xGS12-00AQyq-Dq; Tue, 13 Oct 2026 04:13:20 +0200
Date: Tue, 13 Oct 2026 04:13:20 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Kyle Switch <kyle.switch@motor-comm.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, hkallweit1@gmail.com,
	linux@armlinux.org.uk, Frank.Sae@motor-comm.com,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, ming.xu@motor-comm.com,
	xiaolin.xu@motor-comm.com, jianmin.wang@motor-comm.com
Subject: Re: [PATCH net-next v23 3/3] net: phy: Add driver for Motorcomm Quad
 2.5GbE phy
Message-ID: <174750c5-0ded-4c26-a103-4d905f8c6dc6@lunn.ch>
References: <20260930194513.663575-1-kyle.switch@motor-comm.com>
 <20260930194513.663575-4-kyle.switch@motor-comm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260930194513.663575-4-kyle.switch@motor-comm.com>

> +static int yt8824_config_utp_init_paged(struct phy_device *phydev)
> +{
> +	/* enable nibble */
> +	ctrl = FIELD_PREP(YT8824_U0_U1_ENABEL_ODD_PREAMBLE, 3);
> +	mask = YT8824_U0_U1_ENABEL_ODD_PREAMBLE;

ENABLE.

> +	/* 2.5G template tone */
> +	ctrl = FIELD_PREP(YT8824_POWER_SAVIE, 0x83);
> +	mask = YT8824_POWER_SAVIE;

Is this meant to be SAVE?

	Andrew
