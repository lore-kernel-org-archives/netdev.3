Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794317578;
	b=LYlrO9mmZXmAwHBCfIkwNJG5O3HAcMEt4BeO6WY6zNEp7NCejjnOOxIKquUFMCxx9BWl
	 YgAlnF1m/+i1Zy4v8Q0ixNvTY/J4fFhjMGYnbHXz0pT2rpGjJ93Fjubw4cqZro1j0zDZl
	 yWIAm7Tno0ccvsVwKn+wI2VJCw9exjZWSBP751LTxEfGFdScaqvxMG3fhyosVOjEYL3Gq
	 qOwZr0vou+uBQgp+7utsv5UedIGvPzHuaqZdQzWoirLvh8uB9crGNCQs3DHxg1bHQOzV0
	 tGvI0WH1JupkTBZ7Oi1aaVV2OETDmFx/NKaEje+PKLLEOWAl0s3Ah3IavzLzRRtgwOw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794317578;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=3/mf0SRV350UmZ8hanOhyBFIHxRh67bc2+JwqbB9XCw=;
	b=A0+nj+HSYz89CGdyjqqIenpVjyse7xrZj3UwcTI1rXAoaXsALYfJWdX2M0PCcx6mvgif
	 CgkH1FlmuVifryKlij9VJSCUB9cBX3H1cc1XAd3tUe3JZVVLmcPGccI1p2POJ+2y+jQlu
	 4WvcOZaeZAf3SuEEKfVpvhPHz+lll0py8n6/MnSSlwsQwh1pEuwIUYhLC59DW9rZgrSFN
	 VZ4ze9oaIXJRtli/x710Dxj5QsU1iACIVxfs5/SLPq6VozT9fonT6gnZgsv6Vdj/SDX9y
	 mlmnmalfIiEJvHGeAOcALhNrfpLQmn6r0h/+6T3dFzI+OmTtgTt26Sm15gRum5/F1pQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lunn.ch;
	spf=pass smtp.mailfrom=lunn.ch;
	dkim=pass header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=D6TWGP88;
	arc=none smtp.remote-ip=156.67.10.101
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D88F606B2CE;
	Tue, 10 Nov 2026 13:32:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0D88F606B2CE
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=D6TWGP88
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=3/mf0SRV350UmZ8hanOhyBFIHxRh67bc2+JwqbB9XCw=; b=D6TWGP88zCOoyKtnyVoXn12hy3
	tOZSNKdTP0gCTSPKgmc6mTMCQFPlhjuLv2j+nqcfG322mpvJJSleWt244f6sqZ/KOiDv0/d+9tQ26
	AQSU8sBiaUNTAiYH/VB3LB6YWh0StvKPmjYOV6+QTpWl4UL/XNfr7n1uYZBKsnBlzMu0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xQly0-00FUJp-C0; Tue, 10 Nov 2026 14:32:52 +0100
Date: Tue, 10 Nov 2026 14:32:52 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: David Yang <mmyangfl@gmail.com>
Cc: netdev@vger.kernel.org, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 2/2] net: dsa: motorcomm: Add devlink info
 and resources
Message-ID: <ce9730d3-29eb-4d8e-98bd-371be7179806@lunn.ch>
References: <20261108094512.1285796-1-mmyangfl@gmail.com>
 <20261108094512.1285796-3-mmyangfl@gmail.com>
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
In-Reply-To: <20261108094512.1285796-3-mmyangfl@gmail.com>

> +int
> +yt921x_dsa_devlink_info_get(struct dsa_switch *ds, struct devlink_info_req *req,
> +			    struct netlink_ext_ack *extack)
> +{
> +	struct yt921x_priv *priv = dsa_to_yt921x_priv(ds);
> +	int res;
> +
> +	if (!priv->info)
> +		return -ENODEV;

Can that happen?

	Andrew
