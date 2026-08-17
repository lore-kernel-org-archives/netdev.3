Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3F1229AAFA;
	Mon, 17 Aug 2026 16:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786985220; cv=none; b=fPqbLgjp9nyA2H/5bFVZRmL8uBs2PrD+eJ48kj3IrRNCHi3lXbKZe2cVBfGjpBlv/ivbPi3IVqkVAN1s0IlPPjLKHFAYc20GNVSdip64lSxnwxq3lpjfYWpFUdmL8YfrZfoj7RulXNqI/KhJbclD5A8sOdQv1y25E9mk62A3fIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786985220; c=relaxed/simple;
	bh=HngfY1VU8dZNKiHh0Xn/2MSJgN9n3sblgKJ86KNP40s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MER89WbVuUbAOm8QhtAgkifPAC3UgWhFv4eib/CyB55wS6016cLmS+XJwGe6xzy0GACg7NG9yXnFJ8pLqhAM2hu8DcH7DVdxP+m3AV8JZ5+NP043J/AZSWnYw0kdBMmS3uXfoKgV6Q1U5vZXn7eABx3oFz3frgp25IkgqGFFiK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=mUxVZ0w4; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="mUxVZ0w4"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=5s0FsgPQk3fwJVPrDPYGq5MumSuUS3Z/KZj9arse6Hg=; b=mUxVZ0w4ZhlaeuMH0tsClbVr5U
	449d/POQFhmjWcLU46KiMB30DQXuIfcRvRYhil3ZwhRdJUSdkXMkP6YtK8JgVCNYeMR4oq3S3vAJm
	kR1Tap65deLD8PU+cKBgNBZr0ulclYtuL9ltjPbRWDm3F1OmY7wAnoPsRKlKzxKd6zmI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1ww0Tz-000LG4-Jv; Mon, 17 Aug 2026 18:46:43 +0200
Date: Mon, 17 Aug 2026 18:46:43 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Markus Stockhausen <markus.stockhausen@gmx.de>
Cc: hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, chris.packham@alliedtelesis.co.nz,
	daniel@makrotopia.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH net-next v14 05/13] net: phy: add
 (*notify_phy_attach/detach)() hooks to struct mii_bus
Message-ID: <20e0e158-c8fc-4a51-878d-a1c57e0c892e@lunn.ch>
References: <20260817162632.1208891-1-markus.stockhausen@gmx.de>
 <20260817162632.1208891-6-markus.stockhausen@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260817162632.1208891-6-markus.stockhausen@gmx.de>

>  error:
> -	/* phy_detach() does all of the cleanup below */
> -	phy_detach(phydev);
> +	/* cleanup without bus notification */
> +	phy_detach_internal(phydev, false);
>  	return err;

This looses the "does all of the cleanup below".

This code is unusual. You normally don't call the mirror function in
the error path. So i think it would be good to keep the comment.

    Andrew
