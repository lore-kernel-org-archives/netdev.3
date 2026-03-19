Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FDA93E556F;
	Thu, 19 Mar 2026 16:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773939426; cv=none; b=Pd1oLNe8OqOUC0I27tKfihGnInHjpPwPe8OuasvI2bEhnS0hZFm3xj+8B7Irfcz8O+joUKCk3m2dLj0XJi4HruhUJ4HYCJ8NwqKATAZd0uxBtbABpW9hM5LnFMR0DZppNoNeR8meP7JztdmKrzGe1TwbpjjWroV+C3nv5kYf7V4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773939426; c=relaxed/simple;
	bh=dmW9WqFvwhUu1VOtdSOeX9ekitRyEKIKaTGRG9fzWqg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ptmNTJmncalHtNzj6Kjj6SeR6G0j8ljJVp1LrB9Tqf5juUCdIodf2/Fk9VHTKLbJIUOatR7ODT3zJ7ig71j1Q8jGuCxllgwe9PES3teaxHQzktBeSk52FkzOMvLoAHljbL0/iGsGYJmqsPilYQqVzYZYt2R61P7D8aKYIhWWFCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=dIb0lK+r; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="dIb0lK+r"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=eC7w47KyLrSBoqllN2X7GojlCOx3Ln213vP9L+i5G9g=; b=dIb0lK+rR1XHCsCF6n8ECgqmwC
	tqYpgi0m7P/urKxDDKxYJgf9M+1yDpd+iQil88fCFUqEhgF9sVVJxH+ewu3mLjSGIfW0US3MoltBo
	R3Ck7PQI+WfXqFe8ZJjzBhoRvk1NoMOEFZm1AclIwv5oUqc29RXTpTqCYqiaKxQIA5eU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1w3Gg3-00CQ6G-1H; Thu, 19 Mar 2026 17:56:55 +0100
Date: Thu, 19 Mar 2026 17:56:55 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Charles Perry <charles.perry@microchip.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 2/2] net: mdio: add a driver for PIC64-HPSC/HX
 MDIO controller
Message-ID: <dd0e5738-81a9-41a3-a872-76c2e3383770@lunn.ch>
References: <20260317184610.315852-1-charles.perry@microchip.com>
 <20260317184610.315852-3-charles.perry@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260317184610.315852-3-charles.perry@microchip.com>

> +	platform_set_drvdata(pdev, bus);

Does not seem necessary.

	Andrew
