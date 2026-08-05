Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7670A471242;
	Wed,  5 Aug 2026 12:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785933667; cv=none; b=FlgLQm1keypEmRSvzwUBEEYkDAJBykEB9mBw6jRZRDUGV28bhK23z6TCB2yH+UtPa1tnfeVjkIulzTpufa3JFGlRBj1szsIcKqqTncDrROiniotfE2nWtcQeX7Awc2UyKKe9tS1+pNemGbohaar2n8J8YX6xEvYfcwQQG67V30k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785933667; c=relaxed/simple;
	bh=dszTrzLYmlAoLMXba4JfyDPzaho/78IJxDV+E58BXus=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X/SQv+QP6Uef71jezPd93j0w1MXSUGfNSu5dMTlqC+Nyzh73ZAHnypTB0J6WewJ3K29336wHv1E3KWUsSuGpGJFCoVm7QOc5cjAqESx7EXy0Ldo7llj5OhjvCFXgzmg2FWujwLp4cSdZ7lRA7akOEgxivFbKiDj1pnV+WAf3if4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=FPS7fyjI; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="FPS7fyjI"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=lgTiJmv4uwpwNRu5pNYdAS50aAZIc/Ys+f5aHnOFOF4=; b=FPS7fyjIKkvknkuuhhMMqYpLyJ
	/ai0X/1UzvS/lY73hAesMOAosLmBO5UQ69v2rUjomSGocgRijH45WuagHIv+9+8WbSBYEJY7o0Swo
	QoNL5P6myFZ7AOX51BXMMllWxgQEngdTSD+dIX88jkk8QdjCy4I6249qdDIS5hqH+OE0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wrava-00GARH-F2; Wed, 05 Aug 2026 14:40:58 +0200
Date: Wed, 5 Aug 2026 14:40:58 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Artem Shimko <a.shimko.dev@gmail.com>
Cc: netdev@vger.kernel.org, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH net-next v6 3/3] net: phy: add DAPU Telecom DAP8211R(I)
 Gigabit Ethernet PHY driver
Message-ID: <64da17b5-2ba2-4dcc-9b8b-251b208e555a@lunn.ch>
References: <20260805085540.452260-1-a.shimko.dev@gmail.com>
 <20260805085540.452260-4-a.shimko.dev@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260805085540.452260-4-a.shimko.dev@gmail.com>

On Wed, Aug 05, 2026 at 11:55:40AM +0300, Artem Shimko wrote:
> Add a new PHY driver for the DAPU Telecom DAP8211R(I) Gigabit
> Ethernet PHY, which is commonly used in enterprise and industrial
> networking applications.
> 
> The driver implements extended register access via indirect addressing
> through corresponding registers, and provides comprehensive device tree
> support for RGMII delay configuration. The rx-internal-delay-ps and
> tx-internal-delay-ps properties allow precise tuning of clock delays in
> 150 ps steps from 0 to 2250 ps.
> 
> Signed-off-by: Artem Shimko <a.shimko.dev@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
