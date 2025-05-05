Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6DBF199FAB;
	Mon,  5 May 2025 16:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746462766; cv=none; b=W0Kkyax8GV4+nlf0AkcGC1l83kA1jyvrDwqCthURAsGrhLyywZAnwtbj0QDg4io4+QXvYlcZFo45n04U00QAjgMwSVQTF5eyOoB340CfmaETsDba5n/ngA6AMopWKRTOwoPYpzisGRNevWASa9ln0hDwhRkE34XXNLokOSrKoSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746462766; c=relaxed/simple;
	bh=8QerDb6+LQ5kykEagf//mv6YJYYa27DjcJAakhoL2ek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SOD0VjssaJOQO6SGhdSrQcpHrUoJwB8d4JsEQ+hufRzT0J/3YJJY8F89uOjEOo6ewTgmGMccGxofyFmJbwVylYlXyF1akMEapEs9O+Psd11sqr45AJfDbQtW+BLM5udEEWiLtYl3y6r24LNU5OcEtHc+BAWGo+drxhB9QTD8hoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=KFD+MeuW; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="KFD+MeuW"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=LI63wCPigukzRsXOAQ8hXthpt1mMm/xTU4W1Z7ZfDUQ=; b=KFD+MeuWp4YhjOryiBHY2XooTh
	mkcCZX2BDwUxPMf7nsO3024ZuRw+0mxAfu6p8wP2swqFZBfvZhdL8un+ERLImW7O3ylg3lOBOGXmA
	BDI3hBR4oTlSe7GDwC4aG3ageysLsR0iHiaCuyY7acsSEPm1TSDPCpcPuYQTFDXHJEZE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uByk9-00Bc9n-5Z; Mon, 05 May 2025 18:32:37 +0200
Date: Mon, 5 May 2025 18:32:37 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Stefan Wahren <wahrenst@gmx.net>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH net-next 2/5] net: vertexcom: mse102x: Add warning about
 IRQ trigger type
Message-ID: <14326654-2573-4bb6-b7c0-eb73681caabd@lunn.ch>
References: <20250505142427.9601-1-wahrenst@gmx.net>
 <20250505142427.9601-3-wahrenst@gmx.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250505142427.9601-3-wahrenst@gmx.net>

> +	if (!irq_data) {
> +		netdev_err(ndev, "Invalid IRQ: %d\n", ndev->irq);
> +		return -EINVAL;
> +	}
> +
> +	switch (irqd_get_trigger_type(irq_data)) {
> +	case IRQ_TYPE_LEVEL_HIGH:
> +	case IRQ_TYPE_LEVEL_LOW:
> +		break;
> +	default:
> +		netdev_warn_once(ndev, "Only IRQ type level recommended, please update your firmware.\n");

I would probably put DT in there somewhere. firmware is rather
generic.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
