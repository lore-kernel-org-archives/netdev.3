Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05BAB271A94;
	Fri, 16 Oct 2026 20:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792184391; cv=none; b=rvRVcmEyzt9rMG3gmfHSRT3UvrdsfAlnEUc/dEazcvTFiSXXxZzP52es9nTrlKBf8w3NvfNbHqOF8ZrGMDRjgfwzic17tG5OCGbivw9ksvsOClUYLYjyrED/mo4vZt8hKZflEOp7L5yCwJrmN03AH5aUTzrFmI9bkU1o1yywD08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792184391; c=relaxed/simple;
	bh=bMeL6tHlQ6inzNnfaRqcSOiSvbtkoDQrWgNDJ3ZEPno=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ohZyF6YgfrQvslsTWRGAztdWZGpfNSn0bEvPhlmdBRShG0Fx+iIFe9KB/sRe/IH85TNU5mhxNk9WK9bzU8NljhEj4a9nN/FEbpDROng5QySQ6cxpdE/iDd5bHTmmyRG8zTmuV71okaiwG13J2QkX1D6EBZV0jaWvCVj22qMsk3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=PQIUNC0c; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="PQIUNC0c"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=vtJqI8YsdfW+gxZii/Z1VxgXOvJbDlTlvuwqPo5TN7o=; b=PQIUNC0cBfW3xjCJn68w+s6Mu9
	7UVTgRDCwAq5q5Arp2OOnFwHbgt+dzVnbbuPvzO87RJJLzD7RwR9uZPrRc6VNDX6rS3aoIFjE5E+y
	UB8vktCQsOT6lvsEpXyhvuHkcZfwvPrSQa2Xs1XTXBv2SBTSDIPYfxjLyAvSSk8OMsAU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xHp1S-00BDxQ-DV; Fri, 16 Oct 2026 22:59:26 +0200
Date: Fri, 16 Oct 2026 22:59:26 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Marek Vasut <marex@nabladev.com>
Cc: netdev@vger.kernel.org, Vladimir Oltean <vladimir.oltean@nxp.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Clark Wang <xiaoning.wang@nxp.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Eric Dumazet <edumazet@kernel.org>, Frank Li <Frank.Li@nxp.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
	UNGLinuxDriver@microchip.com, Wei Fang <wei.fang@nxp.com>,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: Re: [net-next,PATCH 2/2] enetc: Make eMDIO MDC rate configurable
 from DT
Message-ID: <725fe351-bdd0-4b53-b551-0f638d02f98a@lunn.ch>
References: <20261016193344.115518-1-marex@nabladev.com>
 <20261016193344.115518-2-marex@nabladev.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261016193344.115518-2-marex@nabladev.com>

> +	div = ((clk_get_rate(enet_clk) / mdc_freq) - 1) / 4;
> +	if (div < 5 || div > 0x1ff)
> +		return dev_err_probe(dev, -EINVAL,
> +				     "Requested MDC frequency is out of range, ignoring\n");

Returning -EINVAL is not really 'ignoring' the invalid value. Since
these are optional properties which are present, if they are not valid
returning an error is good. So please fix the message.

Why is dev < 5 an issue?

	Andrew
