Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.84.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793171448;
	b=zDOV/MDUkSjf+TuqfBpNzPA4hgwlixO+DK5WAG4Ym35giKQM4kSCGG/waOH8D1aeBzak
	 +werMtr7SbWkQgug9ep7LGlKPODTuIKLBbJ0HGCFfaMFes04IPMXzzosALFfSjj/3RE3X
	 xFUCGMrKUi/Fjt+NzWpMB5kFlC2HcDEUYMlXeLvhpnRcHGkDlnE6biD6q5KpCVZ7CHH60
	 TKr2UwBpdd3Z/XG8Li0DHHxBcBesxiKlWWRPLIrPCXwEuwuvHI5rrL0YpVF7b+XwIrvRm
	 RPU15SJYUB/VgVDHQIK9pwhVJqnyDNCgJBMWo/10pahvQv3QeFDRo5SDwYHktTdW0XQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793171448;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
	bh=mVXDNhTKpePvAbfVkDflQLmXiubREs0zcPgQC9SEqXU=;
	b=GcQE0xr5FL9fkH1DTsVw6p0oIhylZQCMJx0Z5YXrol4/BQ/NnrN8J2OmzUTqlGWlCahz
	 oIYGhltIFIZ/XhDSDoPNoH7e6MUbAsUttrU1Dy/a2EVpep39/yupJ8LKSyjlvNNIGOv5Z
	 Az5OybU/vXFUYuNeVhOZ9wi0woRCJYcFoF0tz3rpAHN3caTCHoS6tMuoZCpZkbbbLcGXA
	 /44oCMZ5RrFmL6I4w0z40oTLGJ1oziKy0+CGehObmbcnGB7YEtvYzxOBamv3FcHSkV+Bq
	 lsf60nZ4B0ZAHAZEWZeOz5+5+MbxfLN9zlUhRtSLqTzRfhh8pMhY5SarMHQiusPawtw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	arc=none smtp.remote-ip=185.246.84.56
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC53B606A31E
	for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 07:10:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AC53B606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id B071A1A1372;
	Wed, 28 Oct 2026 07:10:38 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 6576E60769;
	Wed, 28 Oct 2026 07:10:38 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E157C1032906B;
	Wed, 28 Oct 2026 08:10:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1793171437; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=mVXDNhTKpePvAbfVkDflQLmXiubREs0zcPgQC9SEqXU=;
	b=sLEF9R0RDNzj94mlaiGX3kLFC8vDBqXa9MkaM91CyiLp9QKvQ0zj3vVjHB+qIxWs499vEc
	u2aIG0WlfK49GieNuz5L8PeZBMVAd1RgfH4QVotVgOwjtjf6c9oTxdSqix5T5KETjDFcBN
	uJssD8pgYpUlV7z0Udf2Ubvn06la8mshtrfduWw5nS0PtFvyS0LqotvdCLliOO264DAouP
	eGSXlqBgIyB+vrfa0cvujftw+FYOeRZXVur8WpZEzwgZ8hTVdFm0ij4wRCB1YNMP3RVPuI
	HRHHw2d+7GfkngSuJ72jakqfGEak/5t6tVEAyjtI0qZ01iMp+b4y+xkYctuIRw==
Message-ID: <51f5f79a-ed6a-4c7a-809a-f0507ae7a561@bootlin.com>
Date: Wed, 28 Oct 2026 08:10:30 +0100
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: phy: only remove owned topology entries
To: Jiale Yao <yaojiale02@163.com>, Andrew Lunn <andrew@lunn.ch>,
 Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Christophe Leroy <chleroy@kernel.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
References: <20261028050312.126508-1-yaojiale02@163.com>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <20261028050312.126508-1-yaojiale02@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3



On 10/28/26 06:03, Jiale Yao wrote:
> phy_link_topo_add_phy() can fail to insert a PHY when its saved index is
> already occupied.

It's unclear to me how this can happen in real life...

>  Its caller may subsequently run the normal detach
> path.  phy_link_topo_del_phy() then unconditionally removes the entry at
> that index, including its ports, even though the entry belongs to a
> different PHY.
> 
> Look up the topology entry first and only remove the PHY and its ports
> when the entry belongs to the PHY being detached.

Maxime

