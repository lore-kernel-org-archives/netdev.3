Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794607488;
	b=kcclVKY8bbxKFmrXBEbkUXVnK2YmjJ+/PzgiC5jHNoQLnIKpObLPoObzSaIL3C42PO8b
	 jw/nxNeFHbtd7Hrwlwjekq9jdtm+AOJawXAcylFoAawtpBg4cEP+yrvYcRF+FFNnqu03a
	 8ezMVxcMXz2jsN4u6fNoAdidb2vzH8PX3LvG1tGONNnzMkfk3gGH88gXO6m89WUXKvmJu
	 D9RmV4ejuPkBAcePhmnk2hft6h2bOMPRyJvYYY2XSvV8vZ6yLo88m4uniehS31BtpaT+f
	 a5pGyMQfpysjmS9JTotJ6puRFPzR+/wL4bmeqeXw5gJscBtgmo/6d/8LPA3JOtoUcpA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794607488;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=rKxcqwDCc8YSQZaViD5Eexs1w3IH6V9O5T4AQU6d5A0=;
	b=dc/7V2a6GRlV5lgPxQvjMDOfyLPVNmEtsy7lAPucZ0uJnHfIxw2tQcy3tOoGQuaxR88h
	 XSrPRbsADwhgBiWsRZQJXTpqamqxpNyhqNXxQn9mYi/s9kfKLRJnYnfASmntRtSH0HS8V
	 he+haOioJEfQTrMclFfv8GO6HWK0Dv+oZs3ytiF4Yf9rcBE0MqNEZJiGyqo6Gktl9zBYp
	 VF0qfcNPWFtlY4RdQvOgwUevxPlveDAuLJwyi0djMTuZyXbW2dKFh1v53arLpUaGZAXGb
	 eUmgCQD47p7zxZHa6ioRJD8flEMXwnmpP1m8mRi1e2kcM0v8p/Vq88chTnKWt5YammQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lunn.ch;
	spf=pass smtp.mailfrom=lunn.ch;
	dkim=pass header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=WcCwCPyL;
	arc=none smtp.remote-ip=156.67.10.101
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE449606A329;
	Fri, 13 Nov 2026 22:04:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CE449606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=WcCwCPyL
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=rKxcqwDCc8YSQZaViD5Eexs1w3IH6V9O5T4AQU6d5A0=; b=WcCwCPyLSAYwf4LhU38k2PzlZk
	/SdK4omqo0Hj6rQmCM9+AcsL42+6XWoIOG+2lD6BFSJVnvb2pgUSuAlJs5yr6Z64Qm1E/lYD0uSWO
	Rg9W9RDvbYQ7l1Gix2Yc/yhauufuD0tEFQoytQCkdCVK2As90ejMPAM3MIcXhNu2cJjc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xRzNu-00GNCy-Sk; Fri, 13 Nov 2026 23:04:38 +0100
Date: Fri, 13 Nov 2026 23:04:38 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: netdev@vger.kernel.org, Carlos Soto <carlos.soto@broadcom.com>,
	Justin Chen <justin.chen@broadcom.com>,
	Doug Berger <opendmb@gmail.com>, Nicolai Buchwitz <nb@tipi-net.de>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	open list <linux-kernel@vger.kernel.org>,
	Mlody12 mlody12 <kudzo51@gmail.com>
Subject: Re: [PATCH net-next 3/3] net: mdio: mdio-bcm-unimac: Add Clause 45
 support
Message-ID: <e4f0d156-a7ef-48d6-a034-955e01ef90a6@lunn.ch>
References: <20261113211554.2058181-1-florian.fainelli@broadcom.com>
 <20261113211554.2058181-4-florian.fainelli@broadcom.com>
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
In-Reply-To: <20261113211554.2058181-4-florian.fainelli@broadcom.com>

> +static void unimac_mdio_set_clause(struct unimac_mdio_priv *priv, bool is_c45)
> +{
> +	u32 cfg = unimac_mdio_readl(priv, MDIO_CFG);
> +	u32 new_cfg = cfg;
> +
> +	if (is_c45)
> +		new_cfg &= ~MDIO_C22;
> +	else
> +		new_cfg |= MDIO_C22;
> +
> +	if (new_cfg != cfg)
> +		unimac_mdio_writel(priv, new_cfg, MDIO_CFG);

Is the write expensive? The bus is not faster, so is this optimisation
even noticeable?

Andrew
