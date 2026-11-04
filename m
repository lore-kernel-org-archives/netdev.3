Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793764752;
	b=Wxcyot+XUnB237dCVdAQd6w2nmd8f9aIQfc09Rdbn9uxcpVKqWNwsGpYLrqMv4LglFia
	 4GEnobaz372scHbXUC90ki2INjfgpbAU4L4Tuz317jxbD7FECbFR6+kCKRqu3s1EchLlm
	 tEJPSq3JANvRMbVWBc9m2047J17WwZWNpd+s56PHPW1Ni2fKi9uuUaHGTWfFvPUKDcc1b
	 v9muL9/UKzldG6vT2yE0PN5JdshxgR5mY+PfgvdhjSMkff3A1bYiCFUUDpiIKvayFRgXY
	 XeMvyxmFqBZBp6YoqWyRA0q9/bQkzJpMSfwx5D8lpmNfTUCwkMftk1TNsImHduf307Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793764752;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=Gk9BZfsJtLkT8YYFnf4pmohI/7bu4ZfvS3Dm7QuEGqo=;
	b=M190rYqF2WofhncoRuq41WAxIF4zsozTY0FSgy25I8nFvbIE5nsCP0dAbJExFnwU6EtX
	 GB5mUyhMUS80hPCLRvhbjuLo+eKOWo7bOQ0x/OgN5FC7t8fUdWTrY9u2SMPFoL21D5x0Q
	 HF913W/dtslu1hvzS28Oi/9YfmbVb0Yn16BbSQSAjJT3dTyP9+eFy2xE5P0JBtadwRtF+
	 LZ8tRai+fjNz9mu+Mz6fDWCFygqH8Ee25ECuPEvjVzrwN9obvCnyb1YkI+uvvRhgs+3F2
	 CoEdn3KYFw9r2VHF01GcSH+VBQ2kzhHJYa/lVUu3oDfr0K3K5EKQJEegXeWZS1CCJng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lunn.ch;
	spf=pass smtp.mailfrom=lunn.ch;
	dkim=pass header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=FOl9NUOZ;
	arc=none smtp.remote-ip=156.67.10.101
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84671606A31B;
	Wed,  4 Nov 2026 03:59:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 84671606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=FOl9NUOZ
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Gk9BZfsJtLkT8YYFnf4pmohI/7bu4ZfvS3Dm7QuEGqo=; b=FOl9NUOZ3JL9dPnDmGvRLtFE1a
	mBRE2rgn8rOLb1OOwwsjUZoHU+LtUAI4onBj1pu1YlDJP7cXMH2erasnXA+PnXN3Atuxnz2gTeYmL
	xY0wU3LRReVDStpF8MesUKS+dgCgHeQ727UnGAlsKSyrCeLr4pIdRezyEOHoYUsxP2ZA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xOS9R-00EEav-Ct; Wed, 04 Nov 2026 04:59:05 +0100
Date: Wed, 4 Nov 2026 04:59:05 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: David Yang <mmyangfl@gmail.com>
Cc: netdev@vger.kernel.org, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 2/6] net: dsa: motorcomm: Rely on port isolation
 for CPU port
Message-ID: <84089fcc-0150-4464-970a-09400f3ec5ca@lunn.ch>
References: <20261102155641.3682626-1-mmyangfl@gmail.com>
 <20261102155641.3682626-3-mmyangfl@gmail.com>
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
In-Reply-To: <20261102155641.3682626-3-mmyangfl@gmail.com>

> -	ctrl = ~priv->cpu_ports_mask;
> -	res = yt921x_reg_write(priv, YT921X_PORTn_ISOLATION(port), ctrl);
> -	if (res)
> -		return res;
> +	if (!(BIT(port) & priv->cpu_ports_mask)) {

	if (!dsa_is_cpu_port(ds, port) ?

