Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC4DB78F29;
	Tue, 26 May 2026 20:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779825702; cv=none; b=hk9HDCAOl3cbVkATHEy7xcPrTeNpF3Rxle9qLwyTb6VoMJd+CNfEgn+d2i4meAYLgk9IWLp5oSazhlkiaxRMjqGH3RBIU7n6VrpBeDeWClKy/mUD/wVffJHSHq2N2RVz9k1nxue+HHsIjFi1nenVo1X5grzIiNgjemAeu46FGR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779825702; c=relaxed/simple;
	bh=EWeYygjlxL6KyEBUVWUn+gT2zvpNxEN5Cn6tnKd6LK0=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=qVynH/ryKmWFGQl7j652aHMcsDq7ld+FR+xKBuPoaXzemE60iZHL8oe1mYmJ/oCwBoOIpBSUTSzUuSHAGmJ4tXzqGlw8DjCCLdPUE/Q4pskq5KW1Ss1ZVWpfe0QXw7FIQqTAR4gVm8hD06Vh2g9YJQrLp58GLbepoXFXVd+KB1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=W8MdF+32; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="W8MdF+32"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 962A6A4B47;
	Tue, 26 May 2026 21:59:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1779825547; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=jOrchRnk366irtCmn98ATNtNR02m9R8pA0+cw+MMDHM=;
	b=W8MdF+32/ZiAdVuVekmZdnnvy3s2jbVBCRzwaQiEozI511pqI7dWe+1gLI/CkN7TpCyKlR
	hXT8qfZYIehSb42VulCr+mlRFBIGR7bfanpxsRhYI4kcobUj7UTof492OdEGVQ1+U9rtrQ
	2LFuGdcjAK9sdFfQwKPqwFsNFTSe1RQnBWNiZOxEqJFo/Vvnoks9dBGff2vMC2To8Ab3Oc
	rsUU7diu5wjm8M3VDH5TGLcwjfqK1OoTLTGAvMqylyMajRzz8uohHrZZQ7XatXcMUj4DqP
	cNTQwgNagAu58SMJio+O9DIzRTco+VojhieYDTN2B/CmQLkRx4VCXpf/8sZCUw==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 26 May 2026 21:59:06 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Thangaraj Samynathan <thangaraj.s@microchip.com>,
 netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 bryan.whitehead@microchip.com, UNGLinuxDriver@microchip.com,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 2/2] net: lan743x: add support for RMII
 interface
In-Reply-To: <48510d22-bc14-427a-b12e-17655ca95ad5@lunn.ch>
References: <20260526154054.19829-1-thangaraj.s@microchip.com>
 <20260526154054.19829-3-thangaraj.s@microchip.com>
 <48510d22-bc14-427a-b12e-17655ca95ad5@lunn.ch>
Message-ID: <b24c34f91726681ef5797af10b3d1e9a@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Andrew

On 26.5.2026 18:49, Andrew Lunn wrote:
> On Tue, May 26, 2026 at 09:10:54PM +0530, Thangaraj Samynathan wrote:
>> Enable RMII interface in the lan743x driver for PHY and MAC
>> configuration.
>> 
>> - Select RMII interface in lan743x_phy_interface_select().
>> - Update phylink supported_interfaces and MAC capabilities.
>> - Enable RMII via RMII_CTL in lan743x_hardware_init().
>> - Define RMII_CTL register and enable bit in lan743x_main.h.
> 
>> +	case PHY_INTERFACE_MODE_RMII:
>> +		__set_bit(PHY_INTERFACE_MODE_RMII,
>> +			  adapter->phylink_config.supported_interfaces);
>> +		adapter->phylink_config.lpi_capabilities = 0;
> 
> So EEE is not supporting with RMII? This is not mentioned in the
> commit message.
> 
> Humm, is this an 802.3 limitation, or a limitation of this hardware?

I do not think this is specific to the lan743x. Linux drives EEE from
the MAC side, so mac_enable_tx_lpi() has to signal "assert LPI" to the
PHY across the xMII. On MII and GMII the MAC signals LPI using TX_ER,
and AFAICT RMII has a reduced pin set with no TX_ER, so the MAC has no
standard way to request LPI over RMII. So IMHO EEE does not really
apply to RMII in general, not only on this controller. Please correct
me if I am missing something here.

Today drivers seem to express this themselves through lpi_interfaces.
stmmac is the clearest example I found, in stmmac_phy_setup():

	/* The GMAC 3.74a databook states that EEE is only supported
	 * in MII, GMII, and RGMII interfaces.
	 */
	__set_bit(PHY_INTERFACE_MODE_MII, config->lpi_interfaces);
	__set_bit(PHY_INTERFACE_MODE_GMII, config->lpi_interfaces);
	phy_interface_set_rgmii(config->lpi_interfaces);

It deliberately leaves RMII out, and phylink_activate_lpi() then
refuses LPI when cur_interface is not in lpi_interfaces.

> If this is 802.3, then this should be in phylink, not drivers.

Since this seems generic, I agree it belongs in phylink rather than
each driver. I can send a patch excluding RMII (and probably REVRMII)
from EEE centrally, so drivers do not need to special-case it.

> 
> 	Andrew

Nicolai
