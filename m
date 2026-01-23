Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4600262FC1;
	Fri, 23 Jan 2026 08:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769158662; cv=none; b=CkBwjFAIrmhr7KnjysFZDKeQboDi2L73ruPVSbjkd1yp4hi3F9oukZ1cuKIS1QkEKeNWkRn41rYEnbUHeV6CjQaLQ7fOecVEJcYMBhN9Kb87OifeRU+YcsNP9br2uYEENLnkf47AUtcrQ2K09Ei59amjQJWQqsLfajXYa9QjwkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769158662; c=relaxed/simple;
	bh=aYJnsW24NcHiZLmUtSbBYZsqBH63QQK/EUkpG2QP3C4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FPTGeZ6GjuwWqg9MmwOX1CPQrbb5yzxpxD5AltMh8R6nNx7Km0QcXOSsFJzJHzpsFqHM90WnZ9UhyDKgvPfAHcJWnfgiKBcUp7+CzdpKwwEuMvmssuqyy9H3vqh+IjCPZ+FySqoqY7ht5h3TYciC8KAzQQ9IKRih+ehUDmvUGbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=FQ3UQ6I5; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="FQ3UQ6I5"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 571B71A2AEA;
	Fri, 23 Jan 2026 08:57:38 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 2AB256070A;
	Fri, 23 Jan 2026 08:57:38 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 112EB119A8790;
	Fri, 23 Jan 2026 09:57:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1769158657; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=z+JHSGN23hsX+cVo1mrcC79xpDEwkF6f8jxXDpevJ5w=;
	b=FQ3UQ6I58yofLejpjcad3q+pSTycJZ1ejA5OlKxkkS7QMDvry45L5TI1ObmuGQUawpB3P7
	RH2RljkXv4R+MhCdy9UrA7Vz8/NX4igduLPrPXsnThEHtHdXln+AP1JGC0HI42aWWxtLHJ
	7yMIrxQ4Ja2H11S5Iiqb7d/WDxIs/YRd+Un4rGKj3oqeZHzRK9UiikPeXMiDOTpgJLtLpl
	ivPl/uuIX2y8fgZ1V8B9/k59E41nMeKgDoqkMXx2Z8HtMzqRSEUMCVfsa7CgcRL5AQE3MH
	8hfnBtQYpP1eQivE05ebinw1paPZ3/PgWmnu2iyd1NOtvqclaAqD2Jj47ifyRQ==
Message-ID: <d5177d67-7b61-4459-befe-999dc052ca2b@bootlin.com>
Date: Fri, 23 Jan 2026 09:57:32 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: phy: micrel: Add support for lan9645x
 internal phy
To: =?UTF-8?Q?Jens_Emil_Schulz_=C3=98stergaard?=
 <jensemil.schulzostergaard@microchip.com>, Andrew Lunn <andrew@lunn.ch>,
 Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Horatiu Vultur <horatiu.vultur@microchip.com>, o.rempel@pengutronix.de,
 Steen Hegelund <Steen.Hegelund@microchip.com>,
 Daniel Machon <daniel.machon@microchip.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260123-phy_micrel_add_support_for_lan9645x_internal_phy-v1-1-8484b1a5a7fd@microchip.com>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <20260123-phy_micrel_add_support_for_lan9645x_internal_phy-v1-1-8484b1a5a7fd@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Jens,

On 23/01/2026 08:50, Jens Emil Schulz Østergaard wrote:
> LAN9645X is a family of switch chips with 5 internal copper phys. The
> internal PHY is based on parts of LAN8832. This is a low-power, single
> port triple-speed (10BASE-T/100BASE-TX/1000BASE-T) ethernet physical
> layer transceiver (PHY) that supports transmission and reception of data
> on standard CAT-5, as well as CAT-5e and CAT-6 Unshielded Twisted
> Pair (UTP) cables.
> 
> Add support for the internal PHY of the lan9645x chip family.
> 
> Reviewed-by: Steen Hegelund <Steen.Hegelund@microchip.com>
> Reviewed-by: Daniel Machon <daniel.machon@microchip.com>
> Signed-off-by: Jens Emil Schulz Østergaard <jensemil.schulzostergaard@microchip.com>
> ---

[...]

> +static int lan9645x_config_intr(struct phy_device *phydev)
> +{
> +	int err;
> +
> +	/* enable / disable interrupts */
> +	if (phydev->interrupts == PHY_INTERRUPT_ENABLED) {
> +		/* This is an internal PHY of lan9645x and is not possible to
> +		 * change the polarity of irq sources in the OIC (CPU_INTR)
> +		 * found in lan9645x. Therefore change the polarity of the
> +		 * interrupt in the PHY from being active low instead of active
> +		 * high.
> +		 */
> +		phy_write(phydev, LAN8804_CONTROL,
> +			  LAN8804_CONTROL_INTR_POLARITY);
> +
> +		/* By default interrupt buffer is open-drain in which case the
> +		 * interrupt can be active only low. Therefore change the
> +		 * interrupt buffer to be push-pull to be able to change
> +		 * interrupt polarity.
> +		 */
> +		phy_write(phydev, LAN8804_OUTPUT_CONTROL,
> +			  LAN8804_OUTPUT_CONTROL_INTR_BUFFER);

Small nit from me, you're missing error checks on the 2 above reads.

Thanks,

Maxime

