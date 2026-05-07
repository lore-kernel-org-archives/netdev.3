Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B86123A7F61;
	Thu,  7 May 2026 12:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778157725; cv=none; b=UwUDuJFuS+Pe40rJJFoxjlCXyBW4ByagF20+1OHWX95WGlrLFGK0rQLLlV4YLJxu4kfn/xGXyeOg8Vs6DFifsDKDRDIM45srMtyTSmyoNeKmuG6z6lZejeghR25WNcKTyeN3vYMpWpJZiihpB5PQHTpcnxgk1GDmQbvDlRmqTGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778157725; c=relaxed/simple;
	bh=cbpgXTlPDgOORnL7fG7oMI6SUvH4DCI0M5HF0Tt/bdw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nctoTXxYkSIVtinNnKWzwenzZVmNp03zENJj4kUwPHEOJkwOKF5B252xjpWueL03oZwtietoTn2axDZVDCnINW1x27DR7f8Lhd6vC/6OPQh9FQRNc3UJJUZhn+jmqOvIhVBRr8bSFYPpnqk6CSeIggr7dZP3jSENNluQ9k5Bymw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=WF7qQ0Dt; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="WF7qQ0Dt"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=suAbZsGxaGCtsebVoYqOWspXqWgKFY5vkNIOYTGshL4=; b=WF7qQ0DtMnBAxYbasHDFY/cUcA
	NLpqsN4kXi3tXI797o0WkmnnH5EbFxUWHVB4N041hMHlJGu9hvu1apLOZZyjSVVDK4fl/FTEZRsTp
	9G/1KU9NApkHFJBZCYqoNXAhnVslBz1pYs8ke4RO3eLG/O5reMPayBjLL/Mh2gdlk6Og=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wKy30-001oMv-Cs; Thu, 07 May 2026 14:41:46 +0200
Date: Thu, 7 May 2026 14:41:46 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Minda Chen <minda.chen@starfivetech.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Emil Renner Berthing <emil.renner.berthing@canonical.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	devicetree@vger.kernel.org
Subject: Re: [net-next v3 4/5] net: stmmac: starfive: Add jhb100 SGMII
 interface
Message-ID: <98266e3a-a23b-4283-a493-65deb8c2a1e7@lunn.ch>
References: <20260507094115.8355-1-minda.chen@starfivetech.com>
 <20260507094115.8355-5-minda.chen@starfivetech.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260507094115.8355-5-minda.chen@starfivetech.com>

> +static int stmmac_starfive_sgmii_set_clk_rate(void *bsp_priv, struct clk *clk_tx_i,
> +					      phy_interface_t __maybe_unused interface,
> +					      int speed)
> +{
> +	struct starfive_dwmac *dwmac = (void *)bsp_priv;

Why (void *) when it is already a void *?

    Andrew

---
pw-bot: cr
