Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1650E392C46;
	Wed,  7 Oct 2026 20:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791403484; cv=none; b=AvQgDmt/dtUkWSNRxAGb7plyuX98LFbBtznduzCNo30HZ37RAbHtGTTFrAo7F+IT6tKCxypJ03qn38tFYLjrZkvfQs/u59dckMITLlOXd4cz3gW+brbQapNDDVm7+zQ0Cz9rqaumshvpFzFepujgya2gBv6iFAIIMp0Y69ZVh70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791403484; c=relaxed/simple;
	bh=4GuT3G+f9RGBCTuY5S5heo6Yoo51fUCD7bHS4S+2H+8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W2EKsh8j++sF7a1BBBZ7dRvV0ogRcAzMltGLIYyWb9pBmaHMLqNmMFJXhUrCsV1v+2n+n+LQIQ878tIybGZwiTfGJuGpiPnsh39kDRaEoGtH7W/xXGavY2xjLiNS2b0BsxAyuj0qYi/cn/z+SGgjXpz3X+h9hq2j/02c1esLuuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=3elzQlMu; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="3elzQlMu"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=uyQIoWdNsuVLAGmnhw2jru27GXxRa4ZSnYvz5HvRN78=; b=3elzQlMuhm1DqayD1zNdrq5+OX
	w/9qSYFjjnRvqnwdJnd6orwbOIsYKQ99pM4KotHoms8hmYUp7ZKzOREOqThnPPj+whbI3m+jvoMeu
	p6mQKaAgzdBWbBlbcj2EnqTqMlVf/aaYJg7c+CuoY8Y5NZKpTfEvNJl+HnpK/Kr9qKn4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xEXsG-009Vhf-Df; Wed, 07 Oct 2026 22:04:24 +0200
Date: Wed, 7 Oct 2026 22:04:24 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Piergiorgio Beruto <Pier.Beruto@onsemi.com>,
	Parthiban Veerasooran <parthiban.veerasooran@microchip.com>,
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Richard Cochran <richardcochran@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	Jerry Ray <jerry.ray@microchip.com>
Subject: Re: [PATCH net-next v8 09/11] net: phy: ncn26000: Support for
 loopback
Message-ID: <f9a4b628-d07d-496c-89c3-f986e3a90ada@lunn.ch>
References: <20260928-s2500-mac-phy-support-v8-0-7e011aacc309@onsemi.com>
 <20260928-s2500-mac-phy-support-v8-9-7e011aacc309@onsemi.com>
 <7723127b-a713-4e96-bb63-fb2dc5367560@lunn.ch>
 <CH0PR02MB786718710AA0CD5A00D17D0683942@CH0PR02MB7867.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CH0PR02MB786718710AA0CD5A00D17D0683942@CH0PR02MB7867.namprd02.prod.outlook.com>

> Also interesting to note that among the two vendors who have OA TC6 PHY driver, 
> one is supporting MAC level loopback (adin1140-phy.c) and while the other (microchip-t1s.c)
> is yet to add loopback support . We are using MII level loopback. May be, we could get this
> aligned later.

There is a slowly evolving bit of work going on to help address this,
allow you to enumerate where loopback can happen in the stack and
which loopback you want to enable, when there are multiple choices.
If you just follow the usual scheme in phylib, it hopefully should
just work, when it gets implemented.

	Andrew
