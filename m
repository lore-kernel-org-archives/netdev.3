Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E13A56E043;
	Thu, 10 Sep 2026 18:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789063991; cv=none; b=rqUhe8Nr3nhcCTLLES7d25YktldhCwRA7juX660MFREeL0V3+zIrJwcdqo+B8W2mrzQrBQuAVA/z3X++u66kE02E7/iKobLcHWtOhi2HdDlFXBneWifHAn7Bcm8/uXEOLF+kQUMZ02DgKBtNzjHkFPX3994JS1yjvNDLrsVksKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789063991; c=relaxed/simple;
	bh=D8n65ikXZz2paF2tes+xcYTC/bM0Dvz67W4Xt/I+XF4=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=Rw4kddl5RRHvZbzvATbqkwu1LFGVKI5vGjX8n8bjmjEZpvtDFd2fwxYpWI9behjvwVDJflfU4kzYViKlENQ++/CZ2TrZMgKEo5jGbPl4TrR3hsSCqJEFt8p3YLnfyghnzv8YgJ4Mm3VcVJgcPYtsIyOd5uyaSIaviSVwgtFjudU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=cr69UKyB; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="cr69UKyB"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D6306A561B;
	Thu, 10 Sep 2026 20:12:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1789063980; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=4CaEfw1iqgEa+C7dVfyRUqNDVvrpugZEtCfu0akm+So=;
	b=cr69UKyB6Yusde/ckElSBYTgezjbN7b9OLuyvAsZFZ6zuNl79sDgAOMb9/oSPBI+Ns3vFx
	bLPzDGWPZNpFHJg3Og0D89uvVu/7Br59Zeh45zK333fycwlxBjxiX1wd/E2LtEMQYBowLo
	DsNQDXWtHYJrvJajPfRD5RECEOhNg4mFf1SmppEM5BnqOCysZZK7wtZ3xfXPnpRi0AZ6hA
	hhfv1ubKOGSlrjW5XHDbGMH9G4UWf3iPg+5eAjPd4aP43hWe6NrLfrI9amnrzuBfkracnT
	Cw/Jy0Y4Drrz9g4ALWqrzOJRJmdyhlL8i5IqDJ/gDnq7lACn8vm/fdgR4XSorA==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 10 Sep 2026 20:12:51 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, davem@davemloft.net, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Russell King <linux@armlinux.org.uk>, Heiner Kallweit
 <hkallweit1@gmail.com>, =?UTF-8?Q?Alexis_Lothor=C3=A9?=
 <alexis.lothore@bootlin.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>, Emil Renner Berthing
 <kernel@esmil.dk>, Minda Chen <minda.chen@starfivetech.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, Kevin Hilman <khilman@baylibre.com>, Jerome
 Brunet <jbrunet@baylibre.com>, Martin Blumenstingl
 <martin.blumenstingl@googlemail.com>, Jan Petrous <jan.petrous@oss.nxp.com>,
 Ovidiu Panait <ovidiu.panait.rb@renesas.com>, Jose.Abreu@synopsys.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 thomas.petazzoni@bootlin.com, linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, PKneuper@dspace.de, David Laight
 <david.laight.linux@gmail.com>
Subject: Re: [PATCH net v2 1/6] net: stmmac: selftests: Support running
 selftests on DSA conduits
In-Reply-To: <20260910151404.976753-2-maxime.chevallier@bootlin.com>
References: <20260910151404.976753-1-maxime.chevallier@bootlin.com>
 <20260910151404.976753-2-maxime.chevallier@bootlin.com>
Message-ID: <fd9dc3cf645b4a78d28846d7d6e1fc81@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

On 10.9.2026 17:13, Maxime Chevallier wrote:
> Most stmmac selftests rely on dev_add_pack() to add custom handlers,
> that validate the packets sent to ourselves through MAC loopback.
> 
> However, when the stmmac-driven interface is a DSA CPU conduit, all
> frames that are received have ETH_P_XDSA as a protocol, even though 
> they
> don't actually contain any tag as they come from the loopback and not
> the switch.
> 
> This will prevent any incoming packet to match our packet handlers.
> 
> Let's register a ETH_P_ALL packet handler when we detect that we're a
> DSA conduit, and use a proxy packet handler to filter the h_proto.
> 
> Note that we may still receive incoming packets from the switch, but
> these frames shouldn't interfere with the very specific frames used for
> selftests, and stmmac selftests in general aren't safe against external
> traffic interferences.
> 
> This was validated on a WPQ864 devkit for IPQ8064, that has the SoC
> connected to a QCA8k switch.
> 
> The ARP offload's packet handler is left alone, this feature is just 
> not
> implemented in stmmac and due for removal.
> 
> Fixes: 091810dbded9 ("net: stmmac: Introduce selftests support")
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
> ---

> [...]

Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>

Thanks,
Nicolai
