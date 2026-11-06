Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793971812;
	b=Z9g4XtslQXV8FfnEJeCrmpB+AB9/kGI+x1KLcKxLWjbNlCjz09Hc3J3kfW/T0jzwKIEH
	 REvKyuieGIdtpRDuC+qfr8f5xMLGF+hPkYAIMOwKNbi/ndf7uRdp28wU/B1Qyjf2Gn/ku
	 sg5PGebJNicIxChEZiDUKxLoKNk3CEC9Llhj6946IdX3EUmPJQT5mMCnsS0ynkZ+lPgVT
	 EvubyovcCuVLWkmDz1ZvE3IPWlgtC4RoYxnJbuBulVc17JByEm/WVKvw/u1F+T0mKRrik
	 Tfp4hzQVha5sZYIkGt6D5/j5QBG3CmlUssRWBkoxJt0aiivgg3AFWkqMeeOdmXR3ghw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793971812;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=8Z00acB9Vymz6mYsGI03MQwd0xqs9x+gv6dFEhayj3Q=;
	b=lWuvuqjqGFnsu0+p61IeSaGb3l12iAm3hGdipU4S7pr4nMP9ccp5kzgr3ONzWluI1tai
	 XflXk+bl+Abdu4YOyZzmeBC9GeBPX1bJW9YnHUuM3Ub1Cswbol19fDYMCY0OkZtrK+qjX
	 cGa84mBV26gAzoO89lFectfQfloXXdyPYFdoD0ElKCWGPQCDq8ijjIpdlYMyymtbE6v1g
	 xIzVIxtsiwo8UvlrYKyg1acqJRnuoUCJBzbF+RvLG6+KAsIliSTZK6S4XrOtlQVWfK0yl
	 iim4fJki82ALb4kqfGM/H1DkCSUVWPzjCJBMP3zIH1ckV9XAMlCSKMbnUJaNLkoJSPQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lunn.ch;
	spf=pass smtp.mailfrom=lunn.ch;
	dkim=pass header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=SY5AWf3d;
	arc=none smtp.remote-ip=156.67.10.101
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 534FB606A32E;
	Fri,  6 Nov 2026 13:30:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 534FB606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=SY5AWf3d
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=8Z00acB9Vymz6mYsGI03MQwd0xqs9x+gv6dFEhayj3Q=; b=SY5AWf3dgVsZtdjRExSYJyozIR
	1HvhjB1cx03bK2x+Exh3+aM7M1XNNcjIm66cabpATg5eynC9FWOOAtbjVyx8AB65cwDFwNdY808gT
	//pD40mY/NRLB8z9LFadR6OIJA91aT/EUMa9yzVjViViy7Yhq+HYKdP0vh8eHGmng3vU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xPK17-00Em3z-Tq; Fri, 06 Nov 2026 14:30:05 +0100
Date: Fri, 6 Nov 2026 14:30:05 +0100
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
Subject: Re: [PATCH net-next 3/3] net: dsa: forget the port ageing time when
 the port leaves the bridge
Message-ID: <ac9079a2-a197-4572-9771-c04d4bba438f@lunn.ch>
References: <20261104-ksz-stp-ageing-v1-0-2c2bc7217dea@pengutronix.de>
 <20261104-ksz-stp-ageing-v1-3-2c2bc7217dea@pengutronix.de>
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
In-Reply-To: <20261104-ksz-stp-ageing-v1-3-2c2bc7217dea@pengutronix.de>

On Wed, Nov 04, 2026 at 12:48:30PM +0100, Oleksij Rempel wrote:
> A port that leaves the bridge keeps its cached dp->ageing_time, and it
> still counts for dsa_switch_fastest_ageing_time(). A port that leaves
> during an STP topology change keeps the switch at the short value until
> the port joins a bridge again.
> 
> Clear the cached value when the port leaves the bridge. The switch is
> not reprogrammed on leave. If the leaving port held the shortest ageing
> time, for example during a topology change, the switch keeps that value
> until the next ageing time change or bridge join in the DSA tree.

Does the software bridge trigger an ageing time change soon
afterwards? Does a port leaving the software bridge trigger a topology
change?

I'm just trying to understand how long the fast ageing value will be
left in place.

	Andrew
