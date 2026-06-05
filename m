Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14D4817C211;
	Fri,  5 Jun 2026 14:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780668236; cv=none; b=u/zba0TDo679KWlQ/QO3ameE3z3lC71Putyc7srd081e+ObNhm40F5Q/VzFi4OGiswTnXxEMd6wWSRzVdkOKlM+zuRcNTvUZVBiS6zBsG7GsSFeTyZR8FvWAohSKrL/TP+5juAXW0upOl5c9zhCBMtqTksxaNLeaTiStgxGB0pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780668236; c=relaxed/simple;
	bh=P+oBBbWfPSZxy+LD5MvkYeicwdU102OQDnAKIlD2n58=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f5XajSmQixwkKYHriH0qqYXIeCILCptf8dQQh6GJf69Ru5N95E56DCd4E5D8eJlR4HxgO1Ea9+1n/D7XUMo9kvFOtiMaIDOYNUNR39dPZ7ApILb1L/KOhxlYsmiCoD+4BEUnP0G5k2FAXoViEtyIbkhnDeImrZPgvyWCScvF4Ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=tAwGn3C7; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="tAwGn3C7"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=OTJvxf/jbQXoxNh715eN/OTiKIJrGsPOhm3F7zukjxE=; b=tAwGn3C7iyVjOB6T4m1/RhOb5c
	JtO3Kz4/G6yoEw4m+b8qPDWDXiCL4WiUsKasrdGD6xDOulWG9TCQcq/vC9hJ1rBEMmbzS0a0owdHY
	M3MZ/6fV8ZccuEnYEXLPUS2CiIvYevXmcdZwOdfK8XLhu8zoFZGZIXc1tQGIxGYsINUE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wVV92-006EzK-NC; Fri, 05 Jun 2026 16:03:32 +0200
Date: Fri, 5 Jun 2026 16:03:32 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jakub Kicinski <kuba@kernel.org>
Cc: devnull+george.moussalem.outlook.com@kernel.org, hkallweit1@gmail.com,
	linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, f.fainelli@gmail.com, andersson@kernel.org,
	konradybcio@kernel.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	konrad.dybcio@oss.qualcomm.com, linux-arm-msm@vger.kernel.org,
	george.moussalem@outlook.com
Subject: Re: [PATCH v2 4/4] net: phy: at803x: add RX and TX clock management
 for IPQ5018 PHY
Message-ID: <cf699ef5-aa9f-46bb-a071-4d7db889967d@lunn.ch>
References: <20260602-ipq5018-gephy-clocks-v2-4-65a1f1d881f3@outlook.com>
 <20260605013305.3533509-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260605013305.3533509-1-kuba@kernel.org>

> +	priv->rx_clk = devm_clk_get_enabled(dev, "rx");

This should probably use an _optional_ version of the API, in order to
keep backwards compatibility with older blobs.

     Andrew
