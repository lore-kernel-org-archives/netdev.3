Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1075F33030F;
	Thu,  6 Aug 2026 13:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786022852; cv=none; b=rL+ePb6RjC84UMBiuh4FCrc41fZhsVjgqKAWWS93rY9eAdJwE/x1gxqn+UjshAxJhjqxOs3837cxVusZeAv909hDhM+6RLJngpoLFAtLbwp0rjKDzo4nVyv9hBqODu3Su1zS1VvEU8wHWgt9XKZY7qrUoVLrIoIsq5R17dzUcXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786022852; c=relaxed/simple;
	bh=eTRIMskQg2oV0hASFiFKqVu+LLV2Oo+YZo0jthUhzZk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qmzxp8krL8egO8yb8KkprTU97VgyuDQMJBwPBv61hilUww75YKgMCqkeRThsoLwaNlpq6C3JC6udq1RpUpK2ABJPiwxzoFyqVElMGqOkAx/q8Azf+ELStE98rwiffpjok9ckjmYCaERq+cRS6dhIvtk1sW4BWKV5qTrnBTKHN+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=1prnVgoe; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="1prnVgoe"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=tBIueTiaiDCSkX846VrHbsAVcgGOQl+L6fP/gNrYafQ=; b=1prnVgoevE1WahsP2bx5/uTvAu
	31UYsh1ZDffw6lZ6lqryHTiZYvVohpMRZIeA4EEMVmbdfklmsGh4CVaxJoEZcf7mwBTDHE3LrUOck
	/X+Ix3yaEsAi85mzTLJn1HAY1zBW3sqFmVJG4+R5nHIZO5BPKOubqX/WTIPmrdlhz9Qc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wry2K-00GNho-67; Thu, 06 Aug 2026 15:21:28 +0200
Date: Thu, 6 Aug 2026 15:21:28 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Andrew Davis <afd@ti.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: dp83867: add binding for
 output-impedance
Message-ID: <3e6e663b-8903-4330-8a04-f244d094bf68@lunn.ch>
References: <20260804-v7-2-topic-dp83867-v1-0-1ca79eb54eef@pengutronix.de>
 <20260804-v7-2-topic-dp83867-v1-1-1ca79eb54eef@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260804-v7-2-topic-dp83867-v1-1-1ca79eb54eef@pengutronix.de>

> +  ti,output-impedance:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: |
> +      MAC Interface Impedance control to set the programmable output impedance
> +      to a value between minimum (35 ohms) and maximum (70 ohms).

Please could you express this min/max in yaml, so .dts files can be
verified.

>    ti,min-output-impedance:
>      type: boolean
>      description: |
> @@ -53,10 +59,11 @@ properties:
>        MAC Interface Impedance control to set the programmable output impedance
>        to a maximum value (70 ohms).
>        Note: Specifying an io_impedance_ctrl nvmem cell or one of the
> -        ti,min-output-impedance, ti,max-output-impedance properties
> -        are mutually exclusive. If more than one is present, an nvmem
> +        ti,min-output-impedance, ti,max-output-impedance or ti,output-impedance
> +        properties are mutually exclusive. If more than one is present, an nvmem
>          cell takes precedence over ti,max-output-impedance, which in
> -        turn takes precedence over ti,min-output-impedance.
> +        turn takes precedence over ti,min-output-impedance. Both take precedence
> +        over ti,output-impedance.

You should also be able to express this mutual exclusion in yaml.


    Andrew

---
pw-bot: cr
