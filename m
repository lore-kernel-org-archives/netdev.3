Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 000A9368D7C;
	Thu, 11 Jun 2026 20:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781211302; cv=none; b=mg5tbLV2fJ/zKo7r4coAtpMjJ4nBIDq6U+ejEtvYt1pqNuKiri0DZhQJcMXOKsQCnYFfPpyxFHT9cVL8CjmCztR+lZmd7Uw7/zaZRSkN/FwIpp7nVLR1MKP32wKNtI1HTcfHChV+1JYLRKrcPSnYB6zhW61D2qq0fjGHx/y3t2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781211302; c=relaxed/simple;
	bh=4e4xpoRpVaK53TWComet50Ms3ZbOdzjKrRy87qvwAPc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QsM8aDZyJSiMqO7ZLMNfxzNR3pENLBSjPvECxXIN8lpCiqgG9LIMEUhvftvcs90TnNtDHahEiCJQY9EUehaKPsMVapcSB9U443ZFG2ULN0517ClRLAFTI5I7RdyK/Ehdaa32zdV3KwZ90tVeWVOMUqLHuPEXjs8wok3/FQwS8Gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=eHXrEETy; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="eHXrEETy"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Ro9VRaxqnpZjOWZQhcQkBrJNsT8ppT8UuCTCvAy/sWM=; b=eHXrEETynmdVcNLwvS4Q/JmBwG
	g1YFwlYFYsA3u5PWqOCMnGzPttqs6Iz4KgJR5Sjv4SN8mPAS1HbgSLv7geiEyQSYp0ES8BFBaskgd
	PoLMh6BZE4dkrZUQ1ZwRv11+FKknYk/B55dVmSnvVxuE8zpITgPAR6E83AxFzGIDZvPk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wXmQ9-007EUi-JR; Thu, 11 Jun 2026 22:54:37 +0200
Date: Thu, 11 Jun 2026 22:54:37 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Russell King <linux@armlinux.org.uk>, linux-arm-msm@vger.kernel.org,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH RFC 3/9] net: stmmac: qcom-ethqos: fix RGMII_ID mode to
 use DLL bypass
Message-ID: <42355330-c22a-4fce-98ab-dc22b321ff16@lunn.ch>
References: <20260612-shikra_ethernet-v1-0-f0f4a1d19929@oss.qualcomm.com>
 <20260612-shikra_ethernet-v1-3-f0f4a1d19929@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260612-shikra_ethernet-v1-3-f0f4a1d19929@oss.qualcomm.com>

On Fri, Jun 12, 2026 at 12:06:59AM +0530, Mohd Ayaan Anwar wrote:
> When "rgmii-id" is selected the PHY supplies both TX and RX delays, so
> the MAC must not add its own.  The driver currently falls through to the
> generic DLL initialisation path which programs it to add a delay.
> 
> Power down the DLL and set DDR bypass mode for RGMII_ID, then program
> the IO_MACRO via a new ethqos_rgmii_id_macro_init() helper.  Also fix
> ethqos_set_clk_tx_rate() to not double the clock rate in bypass mode at
> 100M/10M, and remove RGMII_ID from the phase-shift suppression in
> ethqos_rgmii_macro_init() since RGMII_ID no longer reaches that path.

I'm curious how this works at the moment? Do no boards make use of
RGMII ID? Are all current boards broken?

      Andrew
