Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 315764A3865
	for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 12:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789474292; cv=none; b=Fqh2iDVfWyFDG5SDHX3RTz45IFqllob3kvkSbbbu1YUYVm6+B/iwlnQSOp/D37ysWkkFC2jc5weH5bDZLsXSK+sQf8OqjkPIlBaQIW1jHvJyqocRHYE4ipKtOAKxNcpMxCoDpyINQUTIFPfcNGuEptrlhG99bylPkoZBpny4Grc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789474292; c=relaxed/simple;
	bh=zg+K1ULOa1qTckKgzNNcVD/JsPDLkhFEQauN/7UbjZY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ah2oFY6qlCi2XnvjC2jS6emt4EpNnlIRGdaZufAy4Ml1F/OX5z9qR3X6ZbOETFqz0PJoec4cdRlzYbvr7Z/3SG6wX/d16XA0+m85eaNlh9VfIhvhU43uipa21O5JWbFeGjab34T3EhO6p1SCngIubusVnxOxx1V9pEvnPXB4hWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=0gF4qNwM; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="0gF4qNwM"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=ygea/cZNuGxLYzulBt7F13XNlN8Z9qXYemhRj+pLsLo=; b=0gF4qNwM2c3wYHPZObyBsPzpiV
	vsZrkI7qfBYZOFcllLZGlEGJ6OGfMVzO+mzlNK+1JXrlniiTP/9/pk8TOWneol3aQCWS163ANzRdw
	b+uC7Yb4Wxy5yehw+zQzEFafEAdLt21tcY22fOEkZSDrqYza6pB4HWiRxLtnwmZfylXA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x6S0V-005Gi9-5M; Tue, 15 Sep 2026 14:11:27 +0200
Date: Tue, 15 Sep 2026 14:11:27 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Julien Blanc <julien.blanc@sprinte.eu>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"o.rempel@pengutronix.de" <o.rempel@pengutronix.de>,
	"hkallweit1@gmail.com" <hkallweit1@gmail.com>,
	"kuba@kernel.org" <kuba@kernel.org>
Subject: Re: [PATCH v3] Add config phase for dp83td510e phy
Message-ID: <beec6f91-48cf-4bfe-9315-f7f3e94082c6@lunn.ch>
References: <370d52b3f5da403b5a92226a92cb23cd92c4b4a4.camel@sprinte.eu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <370d52b3f5da403b5a92226a92cb23cd92c4b4a4.camel@sprinte.eu>

On Tue, Sep 15, 2026 at 07:15:09AM +0000, Julien Blanc wrote:
> Add a config phase for the Texas Instruments DP83TD510E ethenet PHY
> 
> The config phase currently sets the following properties from the
> device tree:
>   * RMII / RGMII mode (note : RMII master / slave can only be set
>     by straps and cannot be changed at runtime)
>   * RGMII delays. These delays can be enabled on the phy side, only
>     as a boolean. Delays are enabled if phy-mode is rgmii-id, or
>     rgmii-[rx|tx]id which enables only the corresponding delay.
>   * In case another mode is encountered, do nothing and return
>     success (keep old behavior)
> 
> Signed-off-by: Julien Blanc <julien.blanc@sprinte.eu>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
