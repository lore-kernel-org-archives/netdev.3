Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF5D63921C8;
	Mon,  7 Sep 2026 19:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788807867; cv=none; b=c3Erq0wkldVVRc6q6LlRd/yA+IPJEXhDHKJ85E7kMSM1IPm2lX3EPddWbVp+PIxaMI14PaUu84uhDwD1kQegTwG7LgnrKvkkSKFsTXk4x0kJHg9ljmJZCM1t0SPJuFaDq6PbK9o3NqsvMfyHKfrd/HfdWia54E8Ws13IJn61V3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788807867; c=relaxed/simple;
	bh=P4EmWZsQfZyC8ozoX3V049PvOhSSl1W/xNiQOKeid+k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U3dyhJQ66Um0k7F5blIxcJPCYzLlGsgN7pBrFa1nmi0PgQPTFkdcgKKeP55hvFtrLqjOUTkhEVNIFCKhCn+Wf84d+LwCVW1SSTcN5PwJcKLfwBDvX7QsFpeljDdOzvhCXZmgLfJ2RkE3nweQVKd6jE+1H2boHbv1ALJmol5Km1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=dT1ywwsK; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="dT1ywwsK"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=TDuPvi+4XC0BZFKNBPyhRrSPyHuyANHAgtzkQHWJ9GM=; b=dT1ywwsKA0v6cYYxLDltiU0be3
	vgh/i6REw6f7J1v8YR5fs0SJjLK4TDvYtuT76PhsC8zDtz8Uc45uIvgaJFpIF6k4CCklBlANM5G4N
	aJQH/LwL6nHao3uYhbA3jMwTTL7i/CHzWBAB/Lconp4k1JcN2qvLUBBLvfEdOieqtwm4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x3edd-003bab-6P; Mon, 07 Sep 2026 21:04:17 +0200
Date: Mon, 7 Sep 2026 21:04:17 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Vasilij Strassheim <v.strassheim@linutronix.de>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	Martin Kaistra <martin.kaistra@linutronix.de>,
	Benedikt Spranger <b.spranger@linutronix.de>
Subject: Re: [PATCH net-next v2 2/4] dt-bindings: net: dsa: Add SoC-e SWIP
 switch
Message-ID: <28f8ec21-162a-4c2c-8e01-6586f39f06f8@lunn.ch>
References: <20260903-devel-vstrassheim-soce-dsa-ml-v2-0-fb0587cb466b@linutronix.de>
 <20260903-devel-vstrassheim-soce-dsa-ml-v2-2-fb0587cb466b@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260903-devel-vstrassheim-soce-dsa-ml-v2-2-fb0587cb466b@linutronix.de>

> +    patternProperties:
> +      '^mdio@[0-9a-f]+$':
> +        $ref: /schemas/net/mdio.yaml#
> +        unevaluatedProperties: false
> +
> +        properties:
> +          reg:
> +            maximum: 30
> +            description:
> +              MDIO controller output index, which must be lower than the
> +              number of implemented switch ports.

Is there a relationship between an MDIO bus and a port?

I'm just wondering if the MDIO bus should be a property of the
port. There are switch which have an MDIO bus per port.

> +patternProperties:
> +  '^(ethernet-)?ports$':
> +    patternProperties:
> +      '^(ethernet-)?port@[0-9a-f]+$':
> +        $ref: dsa-port.yaml#
> +        unevaluatedProperties: false
> +
> +        properties:
> +          reg:
> +            maximum: 30
> +            description:
> +              Switch port index. Supported switch configurations have
> +              up to 31 ports, numbered from 0 through 30.

30 seems odd. Is 31 something special? 

> +examples:
> +  - |
> +    ethernet-switch@80020000 {
> +        compatible = "soce,swip-00-04-0c-10";
> +        reg = <0x80020000 0x10000>;
> +
> +        ports {
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +
> +            port@0 {
> +                reg = <0>;
> +                label = "lan0";

label is another thing in DSA which is today not best practice. I
would drop this.

	Andrew
