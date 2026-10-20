Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792499956;
	b=sBnbanJfASEOYsFxu1M96laoM+Uknyx8A34GLUsyX9mk8WUEmAxbolfXPzTTT+Z1z5dX
	 25X1bvULC6zBLA5yz1uyl4NxXzBryEOEvMsc0tMIDBQQUkwp9qU2ol1+Ps1p8pHCg9UEC
	 gwFSR02KhBkDPPEDgoeWEqy53infDd5rM4/Vf7g97r1q4ygsUqGujWSaHaaMIS8GRlxlQ
	 G8w0ynS64+GM2bspD5T+henxF6hZbq5SFvWpDjYtTHlsQez+0ri6fB3YLMrZtmIB3YfRh
	 N54A8iZL1cvBkOQuxQwP2bdby8gAoGxH9VCitoYldWLUuApFrbvqLhC0OHyLIJoAQMw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792499956;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=JLmey6vTW/mNkI6LBb9V72fov8t1ucTEDkNnab6G6Tc=;
	b=KUNJ1Ul5kIP2clqDTQnclY2aWfwGDGwIxbrvG9fnc0VFFIFIPxLZMjYo63q9foGxU2Vw
	 +bnvSrYSuPHG78tIbrG6AMVRmiQS7AqnJNtrlZ8hga7wiMMLqH8kBDgPDcNAhPEhsCjxf
	 cz2XgDaF5JAwFZPdMhvSLWkJ/wnSRtLGlc7o+56DzAE4ACUgmxmDNfBSo6oaV3CU/Dts9
	 P7380VzcAJ4LLC081jmC9pemUidu6oeFTKXqIzZ44lLhTi96qjZme7Eo4piCxY3wzvs2V
	 tH2o/M6GgH+GtgYXzca3t0cPxlFI6kbClbKPqIsi19wsjFsh5C3zKewnHEKMbvXoLzA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lunn.ch;
	spf=pass smtp.mailfrom=lunn.ch;
	dkim=pass header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=Dk+zRStm;
	arc=none smtp.remote-ip=156.67.10.101
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76166606A31F;
	Tue, 20 Oct 2026 12:39:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 76166606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=Dk+zRStm
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=JLmey6vTW/mNkI6LBb9V72fov8t1ucTEDkNnab6G6Tc=; b=Dk+zRStmNvbT5M+E7hPCAH+iGZ
	s2Vn6hdU+TXYy7R6Q12Xo3lxbAjv9G2y4Xpy3VW6r9S5cTjsARudah6gKMI83JhlCV1bb6N+Yo8Xh
	Lq/9q3LWPwVHUU8liphUj15ybMvVNyaAARQ317Zod5AGY1dya8XbaEF1yTn7i6G2p7pg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xJ97R-00Bqf8-AZ; Tue, 20 Oct 2026 14:39:05 +0200
Date: Tue, 20 Oct 2026 14:39:05 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Robert Marko <robert.marko@sartura.hr>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
	kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, lxu@maxlinear.com,
	hkallweit1@gmail.com, linux@armlinux.org.uk, lgirdwood@gmail.com,
	broonie@kernel.org, michael@walle.cc, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	lrosu@maxlinear.com, luka.perkov@sartura.hr
Subject: Re: [PATCH net-next v3 2/5] net: phy: mxl-gpy: add MxL86211C VDDP
 supply
Message-ID: <554ff2eb-af27-434f-be62-17246c7a302a@lunn.ch>
References: <20261020093655.344585-1-robert.marko@sartura.hr>
 <20261020093655.344585-2-robert.marko@sartura.hr>
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
In-Reply-To: <20261020093655.344585-2-robert.marko@sartura.hr>

> +/* Packet Manager Control */
> +#define VSPEC1_PM_CTRL		0x0c
> +#define VSPEC1_PM_CTRL_MDIO_VOL	BIT(14)

Is this Packet or Power?

	Andrew
