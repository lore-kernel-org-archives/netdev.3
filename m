Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB90F28152A;
	Thu, 22 Jan 2026 13:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769088467; cv=none; b=uJb5cpvXLHbfkbxLjFB/v/vG5S09rFmj4BBo1GOr8onf6DC0BGv/HQ1SrclMVC8UKz3Mo8DoZMDxQAGnLAufao+zL2ANUkxS+QZXFOEciA6s68iOFSyOPix/JhWx9NGggnAXYxnBnw79VOe0WE2uzvs3jVZchpquoAyS0WaW4xA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769088467; c=relaxed/simple;
	bh=qHWIKvktZ7GubooQCjzwR3k+LdNHiwNtsHB9mTP1QEM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nnJRF61BijUohoTsKUk7kinL1dcl5+QjAYz5diIUJXbpsUI8I/RdVcMSvhdDgpT5TOF/597KmE+U0hTk/wugXoLeIPCTN32JURDAH/A5hrrFBhbE6tUL737sfs7SGDVD+6o3UcZQ4WDrqeuv+JWh7srvTp/P5Cb0oaFf2uOG890=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=DTgN+E4L; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="DTgN+E4L"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=9xQMmLN25d6ur0MTNMIKH54ukh9v7HDdPbHa10LtFlg=; b=DTgN+E4LZE+5v7wLy4BmQ6YXn5
	i8sydyP9uyRp/c6HvlX3Nho7/GKYJ4oR2R6GeF1y4Ru3btI417hOhvvf3UKPl9yZ5Fc3bm32CWUKL
	Q+miUq5DI2M0joGjRO4V4Sstu7HxTFogBP6X/AcnfSCIS1CQelSupxLvRwgQANzmNM1Y=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1viuik-003yWn-KU; Thu, 22 Jan 2026 14:27:34 +0100
Date: Thu, 22 Jan 2026 14:27:34 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: =?utf-8?B?5p2O5b+X?= <lizhi2@eswincomputing.com>
Cc: Bo Gan <ganboing@gmail.com>,
	"Russell King (Oracle)" <linux@armlinux.org.uk>,
	devicetree@vger.kernel.org, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	netdev@vger.kernel.org, pabeni@redhat.com,
	mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	ningyu@eswincomputing.com, linmin@eswincomputing.com,
	pinkesh.vaghela@einfochips.com, weishangjuan@eswincomputing.com
Subject: Re: Re: [PATCH v1 1/2] dt-bindings: ethernet: eswin: add clock
 sampling control
Message-ID: <d010a6b8-5bf0-40ff-8e76-18362a238d50@lunn.ch>
References: <20260109080601.1262-1-lizhi2@eswincomputing.com>
 <20260109080859.1285-1-lizhi2@eswincomputing.com>
 <00b7b42f-2f9d-402a-82f0-21641ea894a1@lunn.ch>
 <aWKZvEW7rKFFwZLG@shell.armlinux.org.uk>
 <0d54ddca-9270-40a5-aa82-d8a7b65027ff@gmail.com>
 <1a622916.2d28.19bb105feab.Coremail.lizhi2@eswincomputing.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1a622916.2d28.19bb105feab.Coremail.lizhi2@eswincomputing.com>

> We also intend
> to upstream complete DTS files for EIC7700 so the bindings can be validated
> against real hardware.

I suggest you prioritise this. ARM-SOC is pretty flexible for
accepting work in progress support for new SoCs. All you really need
is for the board to boot to a login prompt on a serial port using an
initramsfs. So the .dtsi and .dts file can be very slim, CPUs, memory
and UARTs.

Once you have that merged you can work on the other drivers, their
bindings, etc.

As Russell pointed out, at the moment, most of the code you have in
the kernel is unusable, so it is a candidate for being thrown out.

       Andrew
