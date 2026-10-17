Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 650CB288C81;
	Sat, 17 Oct 2026 14:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792245645; cv=none; b=i+W/uVkELzA3dqv33ZN+SnO2k5Me/t5vF9St7J4Zb/znpjlg95xWtz0zDIRKxkANjYX2rTPaV2Dz98S3MdToVcB2SQ2Iqv/0873K4meJLsglvcMv2+Ag+vkFU1Um0dvj4Axsl9RxxAXWhYZjDyEcQSzcl9VtpX7+msglP2+arkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792245645; c=relaxed/simple;
	bh=uKAq/I39DYJpRKZqMq/Uedp2r3VwANBCAaAx9B4Q7Ng=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iL0r85Y5pRI8gdCs+oo1HZa+0Jys0ZtXLYjqB+Kpnhdmi7Vvn6XNblNHwoHVTrxrL8oy12gIQCJFRWcoxeMxviq2weAEKTOs8z+we7Rqb595fNphdaaKcyg9eogTBKRw4o8V4g9vQN0R2MDRQOFcTZp8sEDvQvKiVPsI2gVr6IM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=2AJaWJDC; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="2AJaWJDC"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=kPPCN5mO1w9ljF9Wewa/F05O38JnxffoK9c7OCDPdwI=; b=2AJaWJDCmKW2z+q+w+IGEntZex
	rskd9a5dnoDIOdMUm4q+BnYJHTkH3NQDH0+tjjCpPfLe3TkWq9D24bDIN8OIQUsDaNz/ObcdIo3MX
	Ue0lGo9mnDgom207txtLgENg17p9iUjaxC7PjyEwTADUHoHyASdYMF3GSm7Xmef0vpNU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xI4xY-00BKLE-0O; Sat, 17 Oct 2026 16:00:28 +0200
Date: Sat, 17 Oct 2026 16:00:27 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Andrew Davis <afd@ti.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Richard Cochran <richardcochran@gmail.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net-next v3 4/9] net: stmmac: qcom-ethqos: fix RGMII_ID
 mode to use DLL bypass
Message-ID: <17aea8bf-490f-4006-880f-1999aed1df59@lunn.ch>
References: <20261017-shikra_ethernet-v3-0-26a8beb44b8f@oss.qualcomm.com>
 <20261017-shikra_ethernet-v3-4-26a8beb44b8f@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261017-shikra_ethernet-v3-4-26a8beb44b8f@oss.qualcomm.com>

On Sat, Oct 17, 2026 at 03:15:15PM +0530, Mohd Ayaan Anwar wrote:
> When "rgmii-id" is selected the PHY supplies both TX and RX delays, so
> the MAC must not add its own. The driver currently falls through to the
> generic DLL initialisation path which programs it to add a delay.
> 
> Power down the DLL and set DDR bypass mode for RGMII_ID, then program
> the IO_MACRO via a new ethqos_rgmii_id_macro_init() helper. Also fix
> ethqos_set_clk_tx_rate() to not double the clock rate in bypass mode at
> 100M/10M, and remove RGMII_ID from the phase-shift suppression in
> ethqos_rgmii_macro_init() since RGMII_ID no longer reaches that path.

How many different boards have you tested this on? How confident are
you there will not be regressions?

Since you are adding a new compatible "qcom,shikra-ethqos", you could
limit the change in behaviour to just this.

	Andrew
