Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5C243EBF3B;
	Fri, 23 Jan 2026 23:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769209303; cv=none; b=uyO2nh3mbqph2Npqc0GKBz+NCKcDoH2PHKkcIRhQPkOuvcY4RjMRvzy2yUWPSWK3lDo264icTb5byEApY57DGxVtamOkCLGr3bEeVi3PzcoqusDc7M/dRaF1GAAXqTGfF9JTYGvEf3oS/ULTHDrvSpccSywYldx8OPpBTHVBrW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769209303; c=relaxed/simple;
	bh=5w4ORdFCYlw0uGHn4m4rcttlMWZ0imyq7RefzwLMA6s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KiSHUe/JYOJp+QWVrQZ+3HQMNDow8Rn23wIpiRsdx8Ey6/IboxmLUIssrsW7A9hQilOYXPSMDB3xVlNs6lqxXZR8iTBgI8swUuvRCH7Q0KFi5xOu5HPlX2er4Ecf+Gu9COgVAfLXWb6jvdTZOXooYFMHOrPNk4QYpPRx7GF0Dr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Ru9ETQoC; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Ru9ETQoC"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=MzgvAs/RGwn0okuLp07Is/WXK2iHShLRRWk8QzbODeM=; b=Ru9ETQoC6w9F0TW+QnFcJPRY1e
	gsaFY/S3EcSWXcgiIBmRFXapjmHfLp6wNBEk8vvpitTlw6jA2eoXa4u+0CampXOsmzVah0K5/8nPs
	nG3aatAC/PInJC159imxWj0d98LAyh/cH2E4v64hXf7fgma0aDVxgaWYNcN6PCtbjDxA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vjQ9h-004MGA-Ke; Sat, 24 Jan 2026 00:01:29 +0100
Date: Sat, 24 Jan 2026 00:01:29 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: =?iso-8859-1?Q?Bj=F8rn?= Mork <bjorn@mork.no>
Cc: netdev@vger.kernel.org, "Lucien.Jheng" <lucienzx159@gmail.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 2/3] net: phy: air_en8811h: add Airoha
 AN8811HB support
Message-ID: <4a3430cc-5a9a-414e-9dbf-cbc34c8fd019@lunn.ch>
References: <20260123075817.1162068-1-bjorn@mork.no>
 <20260123075817.1162068-3-bjorn@mork.no>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260123075817.1162068-3-bjorn@mork.no>

> +#define AN8811HB_GPIO_OUTPUT		0x5cf8b8
> +#define   AN8811HB_GPIO_OUTPUT_345		(BIT(3) | BIT(4) | BIT(5))

> +	/* Configure led gpio pins as output */
> +	ret = air_buckpbus_reg_modify(phydev, AN8811HB_GPIO_OUTPUT,
> +				      AN8811HB_GPIO_OUTPUT_345,
> +				      AN8811HB_GPIO_OUTPUT_345);

The code/comment probably does not describe what is actually happening
here. My _guess_ is you are setting a pinmux, disconnecting the pins
from the GPIO controller and connecting them to the LED controller.

I assume there is no open data sheet for this device?

	Andrew
