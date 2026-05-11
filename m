Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38C7C21CC51;
	Mon, 11 May 2026 19:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778526940; cv=none; b=JV6cG+3B6sNKpmcrrfjNamBb/X0R/FTvXXesHduEzMM+teaW7raxQR8oVqNpNT7V+KcTv9RNavfRp4ZQt6btFzSuW6P6IDQ+wlSoWqXbvE4k86aXo1Jphs8eAZB8Rbl9Qi9Wmvgnr3NZYmRHay/TS4cgjtkl9zK7DuK8cZhKWzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778526940; c=relaxed/simple;
	bh=/sSkSJWxjxHnnYFGRsYIEuQvNjIc4cP6f987WnLzcmg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xdt1w0/TNw6UF6pJrlyaYQUjhH2v6YbmzHmT17bYBNFeY7IvwXpvVaY2taakr/ty2inubF4vEGHLmQb3qsuxTVwf81WcLVzway6tghYQQMv83ok7qV8FiQm/9y12PE4T2PQxmoYjzmK7HdJMFpLv8lLCcCT/vpyIJi21/+9rm2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=vGeKZDAR; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="vGeKZDAR"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=p2fnzh/9zDePHsEOY6dNmO5mDU+AxcY0IVHc6kCpOyQ=; b=vGeKZDAR41fA7ZZquTd2j4e2OP
	S6odWdVGsJSwwEvUX0TU2GIUWRjEWaLjUJ5dJPTJJUO7WaPp8WAyaMOC9DzfqyrY/6nYu4qYqWWea
	OFr/ws15/mkP9L6Vvf8Lc+mq/wCd0RRQ0nt2/kPPocsCZhlqTV21crgCg/yU7D/6X/4I=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wMW6C-002Qbt-18; Mon, 11 May 2026 21:15:28 +0200
Date: Mon, 11 May 2026 21:15:28 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
Cc: Piergiorgio Beruto <Pier.Beruto@onsemi.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v2 1/9] dt-bindings: net: add onsemi's S2500
 10BASE-T1S MACPHY
Message-ID: <20542d76-6f70-4c2d-9fef-0de620a8d6d1@lunn.ch>
References: <CY8PR02MB924920C8825C7AE5D22EFA4483382@CY8PR02MB9249.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY8PR02MB924920C8825C7AE5D22EFA4483382@CY8PR02MB9249.namprd02.prod.outlook.com>

> +examples:
> +  - |
> +    spi {
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +
> +      ethernet@0 {
> +        compatible = "onnn,s2500";
> +        reg = <0>;
> +        pinctrl-names = "default";
> +        pinctrl-0 = <&eth0_pins>;
> +        interrupt-parent = <&gpio>;
> +        interrupts = <25 2>;

IRQ_TYPE_EDGE_FALLING

But is edge correct? Should it be level?

And i hope this illustrates why you should use the defines.

    Andrew
