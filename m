Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF3CF3ACF1E;
	Wed, 10 Jun 2026 08:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781080276; cv=none; b=prSgfS/MQY5JbXXsIMEPxTdPUTZKrPYaKCaEmscBEiV4i9FEPPPqgq0FlFEFlYcF13fXVXAswDC1GDpmxZJ/+bYDb9u35OotCGMLQlP27kbRG/9V+PfkULA3vV7VRAgYuNcdqCd4VERwyt75OQvG+Wqcpj2Ww4m8TMq1ZwcsLYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781080276; c=relaxed/simple;
	bh=PK40UC0Cuwdj+kNKlzd4w4ysQSjORd+ABlzoa2ZGCxY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NZHml5C91+Jcxdmn3K/eYLPdyRR7ueDFQby3l60Ya+nATcp4p0l6pCkU9Ei85epZ00Od8STy45dKax5qlac4YZLFYiRtSkCNmFoUH1aJ61S17olFsUiQV1dgxGoZyc7lsVGYZE4VpRAzXRKs6Wehr1Kgg0QTDKqSp8xT9pTFyVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=ODK2XDIq; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ODK2XDIq"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=8UN9oOsVv2qY70YnR1nWnUx9vc4hSaMSPCT1GPSh1VU=; b=ODK2XDIqxkUJqdW3q1VuQqQddk
	f+Jn4zURB9xRTBhq2BK0Gi8ALnGoXpQ9Srz3At2gjtQr5H9zwUBIc4mrUPhFRllL7ImT8UYP1zzsR
	EiqLa8bUDAopimpCLGT9NkopHgPlSyEK8Zhdv4TY1uIqVFzfQMjRo687R1pFoo4IecW0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wXEKy-006wnb-W9; Wed, 10 Jun 2026 10:31:00 +0200
Date: Wed, 10 Jun 2026 10:31:00 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Minda Chen <minda.chen@starfivetech.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	devicetree@vger.kernel.org
Subject: Re: [net-next v1 6/6] net: stmmac: ethtool: Do NOT call phylink
 function in NCSI mode.
Message-ID: <a4c1c716-572b-4fb2-8d01-9842d559063e@lunn.ch>
References: <20260610072420.64699-1-minda.chen@starfivetech.com>
 <20260610072420.64699-7-minda.chen@starfivetech.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260610072420.64699-7-minda.chen@starfivetech.com>

> @@ -424,6 +436,9 @@ stmmac_get_pauseparam(struct net_device *netdev,
>  {
>  	struct stmmac_priv *priv = netdev_priv(netdev);
>  
> +	if (priv->plat->use_ncsi)
> +		return;
> +
>  	phylink_ethtool_get_pauseparam(priv->phylink, pause);
>  }
>  
> @@ -433,6 +448,9 @@ stmmac_set_pauseparam(struct net_device *netdev,
>  {
>  	struct stmmac_priv *priv = netdev_priv(netdev);
>  
> +	if (priv->plat->use_ncsi)
> +		return -EOPNOTSUPP;
> +
>  	return phylink_ethtool_set_pauseparam(priv->phylink, pause);
>  }

Why is pause not supported with NCSI? There are two modes for
Pause. It can be negotiated, or it can be forced. Negotiation cannot
be used, there is not a link peer as such, but it should be possible
to force the configuration.

I am however assuming that pause frames do get forwarded by the other
end of the link. Does the NCSI standard say anything about that?

	Andrew
