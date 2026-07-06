Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B01F541DEF1
	for <netdev@vger.kernel.org>; Mon,  6 Jul 2026 12:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783340833; cv=none; b=Mo54MBYcwbrYFIkuZ+dN/PiTt+NFEXi6yISW5ZcRakz6ZSZ+t6sDx88oVZimIlaJ2nZts2MCNMieTR1Uj1goTy9JP1suQqw2eyWlx5dzzzmW/jQMf0R2Gm/IZBkqbmo1Bne3r+ZxqwMj3mzw4Q0yZdUMDp+hEgMUK6jMgoHbcBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783340833; c=relaxed/simple;
	bh=GYBRNSjz3OdSb2ELO7IL8xynR9ALBL6qnGbeKbCzgWI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R+TfaUkG4SDN6slY++xWGqMYiZzPwkLHtFKNpd+mI+bMBEHBVD/lCT/QLSuW4AUS6yMN4KRzs//dvmoM6QyHWxtYhT3Y8Nb64HR8eB52t+hWT2w9M/n4YqSnTSCwHfoYHkWhbXW4pdNN14+sRiDOKkIMizi5ehte4qT7p54t4Ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=rDUbzx+H; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="rDUbzx+H"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id D5AE01A0E90;
	Mon,  6 Jul 2026 12:27:05 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 9A047601A2;
	Mon,  6 Jul 2026 12:27:05 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1481411BB9449;
	Mon,  6 Jul 2026 14:27:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1783340824; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=cGVGDuJCdmFJ1OjdrAmvYRmMZfqzXNF0maWxj9gHZ8U=;
	b=rDUbzx+HW3OhhygxR4nvC2NMrSYqpX/WbaaaqN4ekOegneG1w+KDjzY7myOF+uW+lqKMok
	XPdUq6fyaoGt7FIc5jGDqL8ZmZfU5vBEv2hAwulI6x3ejsjbkibvTsRbYg82OrSDXUbMZO
	DbT60DYun1zQeb48W57jTo/yhUbkwKIJx3bbbAJcHYKdYdgx+kkI7m0VV1Vz1ZVncOiLg6
	82WTsxfEHgbPBxXEuqMtNm8bUzEudX9Xyql3OnoVp6iNkrq01DR2RX8SCosF7Rqp9ZOTKB
	yqYi5gOg+HsxCtqkOpqpfEapYpPu7J6gmz5LDAtiSWhHf57kbQo/7sqBrkLuNA==
Message-ID: <cfd666a3-0851-449d-9627-285f5b48d475@bootlin.com>
Date: Mon, 6 Jul 2026 14:26:59 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: phy: marvell: fix return code
To: Michael Walle <mwalle@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
 Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Russell King <rmk+kernel@armlinux.org.uk>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260706120637.1947685-1-mwalle@kernel.org>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <20260706120637.1947685-1-mwalle@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi,

On 7/6/26 14:06, Michael Walle wrote:
> Return the correct error code, not the value written to the register.
> 
> Fixes: a219912e0fec ("net: phy: marvell: implement config_inband() method")
> Signed-off-by: Michael Walle <mwalle@kernel.org>

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Maxime


