Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CF3C40EB91
	for <netdev@vger.kernel.org>; Tue, 28 Jul 2026 08:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785228089; cv=none; b=mkjRdZ8dIli8Mj7e4qXVmqgQJ6FHB/a4YjTI2EzdfgxNrdyToY+mvIkmDHiUf5KLOzxAkyqW/wHtRMXwrof7VPhvNiVUzP7zGRiy8XP6iylmKUh+3YYYNVSuivKemyne6fGiLpoPXdG0tWaJyvzy+ygNi5XUyektiYWVsFfptDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785228089; c=relaxed/simple;
	bh=q63MzO2+9QcsW/0wiHj208E8TUZp2Z/r75aPWU+SvCk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SwlSQBrhriOwc8QIvNM11ZiHJG0eljvZpMy/C9xS9Ai5GAIrtJ5Ha8WU0t5aj8nVbeXHaTJI0dMQN5awmVKKgXDh2Hp34ZA8QwaWO09m1tW3SnBEXrCk2mShiSdk9MrvtvGHeQITS5DK3itQ8ORVZTUKUfQ5HPsWWLg6n2aH8mM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=AinXWGwX; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="AinXWGwX"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id BBA771A12C3;
	Tue, 28 Jul 2026 08:41:24 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 8748E601BF;
	Tue, 28 Jul 2026 08:41:24 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0336911C13E89;
	Tue, 28 Jul 2026 10:41:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1785228079; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=gUsBndRwmc1hZjQd9pJ5nwb3nA74hWaZOuUDifXoGHE=;
	b=AinXWGwXvCvlk7dT15nWX8YgneTLXKLjZjEV2bU1lfxDG3N0XQ+MyhZWbHXhEoEiWGAQ8e
	qUXn/Un1nSldg5d3R2zqAkQgQPweFDwYufgzSzf4xOm8k0wOElY4rALF1xe8+NJYMBxRD6
	egn0JjwaKx7aQmfTIUkMAQmPpo2c7OECHsbOGjwrVTApnmQNURvxIZxaJojDI7qyLLGmlP
	+cy6/avrJNJq+1GN3EKdXoWQvPztjm3rTX+2mcbbTU4MKl2sZGN2AEDcI2eCVETPOEQ77S
	QkeGO3D3tuW9L69oTKbZqEbdTW/Nduxls3xjHYhiuQpVib3goOnbrmo5WeQMgA==
Message-ID: <2c0c6864-99ea-48d6-a889-c886bb91c351@bootlin.com>
Date: Tue, 28 Jul 2026 10:41:12 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] net: phylink: add phylink_pcs_loopback()
 method for PCS loopback support
To: Zxyan Zhu <zxyan0222@gmail.com>, andrew+netdev@lunn.ch,
 rmk+kernel@armlinux.org.uk, alexandre.torgue@foss.st.com
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, hkallweit1@gmail.com, mcoquelin.stm32@gmail.com,
 netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Oleksij Rempel <o.rempel@pengutronix.de>
References: <20260727120704.2319467-1-zxyan0222@gmail.com>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <20260727120704.2319467-1-zxyan0222@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi,

On 7/27/26 14:07, Zxyan Zhu wrote:
> Some Ethernet MAC drivers (such as stmmac) need to perform PCS-level
> loopback for selftest purposes when no external PHY is present. Add a
> new phylink_pcs_loopback() method that allows MAC drivers to request
> PCS loopback mode through the phylink framework.
> 
> Implement the pcs_loopback callback in the stmmac integrated PCS
> using the GMAC_AN_CTRL_ELE register bit. Add a helper function
> stmmac_selftest_get_pcs() in stmmac selftests to unify PCS lookup
> across glue driver PCS and integrated PCS. Update the selftest
> enable/disable paths to use the new helper.
> 
> Signed-off-by: Zxyan Zhu <zxyan0222@gmail.com>

I'm actually seriously wondering if we shouldn't just stick to MAC loopback only
for stmmac selftests. I even have a patch ready to send for that, as I've
been struggling with selftests in the past days because some PHYs will
either stop their RXC while in loopback, or bring the carrier down which
makes the dev_xmit drop the packets we're sending to ourselves.

Using an external loopnback (in PCS, in PHY, somewhere else...) doesn't
bring anything to the table given what we are testing today, which is
internal stmmac behaviour. The MAC loopback (on dwmac1000 and dwmac4 at
least) happends at the GMII level, so everything we are currently testing
happens before that.

If the goal is to validate what comes after (RGMII, PCS behaviour and so on),
I think we should instead add some other, more generic selftests that aren't
stmmac specific, that we could run on any netdev, such as the ones Oleksij
has added in:

  3e1e58d64c3d net: add generic selftest support

Maxime


