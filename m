Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4A2726FDAC;
	Wed, 30 Sep 2026 00:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790729181; cv=none; b=W7Z/uSTKbcThgKB/pvgCoJe+/KTqD8oiNY/9VriKwBQRYI+0FEAmEbkHmxXtbgKIae5zZIiBwXwmFePeyNyRzs/42sBmJw+aQ6b72TuwfjXBR/aSe8H0qmqdhlKOLXFBkSsyyjKsd+XxIZqt/5YbCei7KRjE+XcqUFB8tYWKLio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790729181; c=relaxed/simple;
	bh=mcX16sDDyCgjbEIG8Tcymfhinh9CGJOxDXqn4a3//ks=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TT9s3KPW2W6IKEHjpWIXj6nvkHyvAdMP96Lqu03939Z866Iy09D5eDxZ91yBnNej3KhTr8wa+/ORAyc/VPn1zJYWKD27zp8xAxwA+6gW3opBoI4f33zpK0pdPqoD+yB+YJCAA23HLOI21m9p0ithtEvpUzPzIxNiy/lNZHiXDGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bY2n8mle; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bY2n8mle"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3B871F000FF;
	Wed, 30 Sep 2026 00:46:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790729180;
	bh=I1wp2w7jbrzbMc1zJBdAx7aeGz/N3loNYrnXTOwBT+w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=bY2n8mlecSkR1Wmo3kQq5b7XcH0BkHI1bUpNrb7YCJ00olWHrai2gyei2LfJqicw0
	 RiA5TYhN5a/y9E4IIAQwL9QgTbHTan/DsmS7EfFscRAHtHifgszAcOwEmenUduLfw5
	 0Ucllw8qLlRyK+eKPP4DQxCRT4BXsHyqLbW3CwCwViSIfBV+YQZ5Ei1OZjU4aGCgAV
	 o+1TK1Gi0EL6M2khJRC/Q5JrAyUWoFkniDCyFMh5LNLW5kqbvnV+r9NCO8ViGM8kZX
	 OBvsCXaFgdGO/3k4sQDTT0m9837Y7IdQTfgpbDa5kmzK89C/1faQEADOWoaMRZv/qI
	 WWTDzo+KpmZEw==
Date: Tue, 29 Sep 2026 17:46:19 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Aleksei Sviridkin <f@lex.la>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org, Florian Fainelli
 <f.fainelli@gmail.com>, Mao Wenan <maowenan@huawei.com>, Woojung Huh
 <woojung.huh@microchip.com>, Vladimir Oltean <vladimir.oltean@nxp.com>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH net v3 3/4] net: phy: serialise attach and detach with
 PHY driver bind and unbind
Message-ID: <20260929174619.727bde40@kernel.org>
In-Reply-To: <20260924215951.2127682-4-f@lex.la>
References: <20260924215951.2127682-1-f@lex.la>
	<20260924215951.2127682-4-f@lex.la>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 25 Sep 2026 00:59:49 +0300 Aleksei Sviridkin wrote:
>  /**
> - * phy_probe - probe and init a PHY device
> + * __phy_probe - probe and init a PHY device
>   * @dev: device to probe and init
>   *
>   * Take care of setting up the phy_device structure, set the state to READY.
>   */
> -static int phy_probe(struct device *dev)
> +static int __phy_probe(struct device *dev)

You're touching it, you need to make the kdoc fully valid:

Warning: drivers/net/phy/phy_device.c:3709 No description found for return value of '__phy_probe'

> +static int __phy_probe(struct device *dev);

the forward declaration is unavoidable? we can't reorder?
-- 
pw-bot: cr
