Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 786C4481643;
	Tue, 21 Jul 2026 12:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784635202; cv=none; b=rYyiBfd7ca2Z6qoe65dFGpaTzlWKEvN9EYBla/HSLxRNuEa5Wk585ErfBqbIuQmDNEDXg4mzoj6GhNZOwNGA6+keJO3ot4NMtqSXlH2Wk/UL7+AupYHxYahs9C0gX6S9uFnLrf5yzmB/SEhTd9W0CnjWvn/GuNACMdZgnpJ6sW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784635202; c=relaxed/simple;
	bh=0r/J/TPcmPXos8QDRaYftYm09GfGl7QoHws3x2ma1yw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=KZ8FRnBHWB6DyluWCI90zKehsyDc6UfxoJK1SPMX8P5f78ckIi6n4uSj5JvPV0cF/Mbaiz8aBFdrP4z4cmNc4RBKTjBmJT5e/darhQHpU4lX+7fyT55NyRCczqajj1B5mUPBcKSBV8fQ15pZTbjvzWocaVAJWTkUQV0H4KaRR1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=JsHQ0f4k; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="JsHQ0f4k"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 0CB0A4E40E9D;
	Tue, 21 Jul 2026 11:59:59 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id D32F760368;
	Tue, 21 Jul 2026 11:59:58 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 31D0211BD2635;
	Tue, 21 Jul 2026 13:59:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1784635197; h=from:subject:date:message-id:to:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=EjyF/vs1ryZrBaWGdOYQs1NrOsZ5qM4QXFKV7tTAusM=;
	b=JsHQ0f4ki+RiNcdLaiRsxJNbER3ByMdcL6G/Osw1wC1GyA979giPzZwX25/1+AXSJZASez
	jc2P/4znLTl9iSASeu5XIvgCulT5m31Tu2yBUsCuhSJ4/so/85qfL3Ge75kIhkf3rnDCmP
	ICorpfbzpHkhjyZTYECBfQxuTKNlObpxFURvybWaXdcdfxJ/MorIFZrZG+CGhOhMI1VYsp
	sNOeV29wBAJegHHlqyyDCz8PcKzA+U+cOs8Ov9wcZWf5kzfDlGgU7MJo9FwbSoaRVe4Wtr
	dogji0At/FTkT7K3Mwei6IveClwFUAEWMBdd29FcX9VDVGEokCwsJfGuq/asqA==
Message-ID: <5c270acc-7cbe-4d23-a687-35440b43a9df@bootlin.com>
Date: Tue, 21 Jul 2026 13:59:52 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v9 02/12] net: phylink: introduce internal
 phylink PCS handling
To: Christian Marangi <ansuelsmth@gmail.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Simon Horman <horms@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Lorenzo Bianconi <lorenzo@kernel.org>, Heiner Kallweit
 <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>,
 Saravana Kannan <saravanak@kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <20260717065448.1498335-1-ansuelsmth@gmail.com>
 <20260717065448.1498335-3-ansuelsmth@gmail.com>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <20260717065448.1498335-3-ansuelsmth@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi,

On 7/17/26 08:54, Christian Marangi wrote:
> Introduce internal handling of PCS for phylink. This is an alternative
> way to .mac_select_pcs that moves the selection logic of the PCS entirely
> to phylink with the usage of the supported_interface value in the PCS
> struct.
> 
> MAC should now provide a callback to fill the available PCS in
> phylink_config in .fill_available_pcs and fill the .num_possible_pcs with
> the number of elements in the array. MAC should also define a new bitmap,
> pcs_interfaces, in phylink_config to define for what interface mode a
> dedicated PCS is required.
> 
> On phylink_create(), an array of PCS pointer is allocated of size
> .num_possible_pcs from phylink_config and .fill_available_pcs from
> phylink_config is called passing as args the just allocated array and
> the number of possible element in it.
> 
> MAC will fill this passed array with all the available PCS.
> 
> This array is then parsed and a linked list of PCS is created based on
> the allocated PCS array filled by MAC via .fill_available_pcs().
> 
> Every PCS in phylink PCS list gets then linked to the phylink instance
> by setting the phylink value in phylink_pcs struct to the phylink instance.
> Also the supported_interface value in phylink struct is updated with
> the new supported_interface from the provided PCS.
> 
> On phylink_destroy(), every PCS in phylink PCS list is unlinked from the
> phylink instance by setting the phylink value in phylink_pcs struct to NULL
> and removed from the PCS list.
> 
> phylink_validate_mac_and_pcs(), phylink_major_config() and
> phylink_inband_caps() are updated to support this new implementation
> with the PCS list stored in phylink.
> 
> They will make use of phylink_validate_pcs_interface() that will loop
> for every PCS in the phylink PCS available list and find one that supports
> the passed interface.
> 
> phylink_validate_pcs_interface() applies the same logic of .mac_select_pcs
> where if a supported_interface value is not set for the PCS struct, then
> it's assumed every interface is supported.
> 
> A MAC is required to implement either a .mac_select_pcs or make use of
> the PCS list implementation. Implementing both will result in a fail
> on phylink_create().
> 
> A MAC defining .num_possible_pcs in phylink_config MUST also define a
> .fill_available_pcs or phylink_create() will fail with an negative error.
> 
> phylink value in phylink_pcs struct with this implementation is used to
> track from PCS side when it's attached to a phylink instance. PCS driver
> will make use of this information to correctly detach from a phylink
> instance if needed.
> 
> phylink_pcs_change() is also changed to verify that the PCS that triggered
> a link change is the one that is currently used by the phylink instance.
> 
> The .mac_select_pcs implementation is not changed but it's expected that
> every MAC driver migrates to the new implementation to later deprecate
> and remove .mac_select_pcs.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>

Tested-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Maxime

