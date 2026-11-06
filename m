Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793970983;
	b=4SWVzGO4z0Pir4MCrt8t4kXHc+Fj14aZvJjkJ1Vh8I8z8saH9oR62DhxKKyxa+p1ZZoq
	 VdxO6Lvx+cijm16u/tgQzltmR7ENjIyMmn0uUAYUXHUF58q3PJKYT5gXiLDDqvFFf4pKz
	 9PjGx04Y6mXtnl4Fn2m8PHJFWk4n5mtnxH9cga8HM8uN9FrdjYq7ZdBcvl99dVPcNg5j/
	 GteBfkZTkAS9WYKJAvHU6sIEXPcwSBCr87BVYhBAO8wR6xvfH0buQ9ddHp6C56pZl3Ofq
	 QpukleqaShDfULTm0mnZqtdM4YmY3AXvzso4FTw0a+D2Ohx8UknvAMPreHjbByrP6Mg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793970983;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=54/+rHQFMYvpuWYFEAf46nqywk/lWRkyCTOs1SPupfE=;
	b=tc/PHVPcbGTcSPp/ZqRQnfxbs959bl137Jzb6pYzVf1hfNpHvYlvhgrC3UCHR1WvACRI
	 k4Rl/mAKpVpqbDLAEnQcfYyqkXm9JhHLbChJmo8lqVsAHR4GQiYzpS7VsGFKXnmBl6PTm
	 OLvVDeNSi3SkRLTo3Sw/x8tPkYktKIjOISQBVW9ZI+XFUjcex3WYK72oPJEN7ABGAjmJB
	 dhNtcwi5GTbcg6ReLEGByR1hD5AVs4xQFIV2NQgqdxFbts4Ld5U3fpWaIFFZsuNo2bUh4
	 lWQMCddrW2cDNsHTEMIv/SS7qDbQZKghYs5ier3TgZP8tipp0VGYMjK4RQwWjZaSqIg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lunn.ch;
	spf=pass smtp.mailfrom=lunn.ch;
	dkim=pass header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=gtrtT3f7;
	arc=none smtp.remote-ip=156.67.10.101
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4364E606A326;
	Fri,  6 Nov 2026 13:16:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4364E606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=gtrtT3f7
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=54/+rHQFMYvpuWYFEAf46nqywk/lWRkyCTOs1SPupfE=; b=gtrtT3f7dWuXt+w/aww8AhVVBL
	wAv1YnSmmC0EWAmfyfsO0pItJaixnOL2/M4L860NwcVyt7gfkmSmedZs6g/tTrwGWtI7c8rPhppfG
	6jrCLT1SaqgZOuQhOnx0Ol/XEnTERl/uXCRPfXnAovOLFHX4i5ImAQBFTJaE7h+PkHcM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xPJnf-00Elui-KS; Fri, 06 Nov 2026 14:16:11 +0100
Date: Fri, 6 Nov 2026 14:16:11 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel@pengutronix.de,
	Jens Emil Schulz =?iso-8859-1?Q?=D8stergaard?= <jensemil.schulzostergaard@microchip.com>
Subject: Re: [PATCH net-next 1/3] net: dsa: microchip: ksz9477: apply a
 shorter ageing time at once
Message-ID: <fcf99993-fdc3-4563-a93a-d5b5298b3302@lunn.ch>
References: <20261104-ksz-stp-ageing-v1-0-2c2bc7217dea@pengutronix.de>
 <20261104-ksz-stp-ageing-v1-1-2c2bc7217dea@pengutronix.de>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261104-ksz-stp-ageing-v1-1-2c2bc7217dea@pengutronix.de>

> +	/* On a KSZ9893 a new period applies only when the running one ends,
> +	 * and entries keep the Age Count they were stored with. If the total
> +	 * time or the Age Count got smaller, pulse Fast Aging; on a KSZ9893
> +	 * that removed the dynamic entries and started the new period.

The tenses are wrong here.

    On a KSZ9893 that removes the dynamic entries and starts the new
    period.

Otherwise the logic seems sensible.

	  Andrew
