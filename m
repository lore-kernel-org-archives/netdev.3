Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF9C2D661C;
	Wed, 22 Jul 2026 07:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784703864; cv=none; b=iYstNw91F4EYCnnRIipLUuBUdAwTK3j6U4rFQwR6vYbajrb6jvfwplBjvPElikoziv26PcdHCLErGiqVfvbP4umy90BUiWTMVwvydF9ePozKDJARjtGM2mU0g2cVe3uU811oOqloB55aRDRNvHcJ0bN8XJjkNu6mD7T3YLRx9T8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784703864; c=relaxed/simple;
	bh=992XARYHlviuhS9cRMWyEBx5BE5vBCVhQEXAtrSiQlY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MHbCp/M6jSlnZZlGGAt+G4OucS+pImvunOfAyZ82YlQuArRJYgBDzCGU43yccb4t9IQGcJvsACYgfxNGPpnQ/mHd/9oP4I73rFdrigMXRA6ml5jPx4X1+Vb/8uAIc8Jzb2sobKY9iMGQhPNOrHXm/2UWc1goM3R6hY+/M50g0L8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=CQSiu3+u; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="CQSiu3+u"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 257321A10F2;
	Wed, 22 Jul 2026 07:04:18 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id EB01060388;
	Wed, 22 Jul 2026 07:04:17 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8203C11BD39DA;
	Wed, 22 Jul 2026 09:04:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1784703857; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=/WnWMJSX3S/QCfTaWmtOlrrrcy9ZboBNOwRmC9TNFGc=;
	b=CQSiu3+uiNaIqssP8fC+MH2FPdc+lgHHMxLkBhmNv5g2yvsP9MaOLo9yXbX6H/1wCQYp68
	5HsHYS/ok/XYRpT+PTBwtojP2vxRCRbwYYFW3wCweumYL+u61bThgjvq01sPpDyektSfBv
	U4WURPL4bGTsTKTHd9LPPs50dg6AJcuseCZlsCA75UPmOOGbi6ULVx1f6lQT31NGVYa/ZU
	psKcrcxvA71yarYc0CSKQ9Z9piQpgBcRe9CUxoujceUotVQeMc/hO4wOkTTuTo2bULRJrh
	TchVK+xGOgizB/sYj0bRc/PYkFtL4lQ9uyiYwkrz3bW+LXWGp8zslNYR/rVhYg==
Message-ID: <e2ab85a7-2ddc-4ea0-a004-c5319b846b3e@bootlin.com>
Date: Wed, 22 Jul 2026 09:04:10 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 0/2] Add DAPU Telecom DAP8211R(I) Gigabit
 Ethernet PHY driver
To: Artem Shimko <a.shimko.dev@gmail.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
 Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Zhi Li <lizhi2@eswincomputing.com>,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20260716173325.653164-1-a.shimko.dev@gmail.com>
 <77f1cc14-cc5f-4f32-a972-f0350a60931b@bootlin.com>
 <CAOPX746tZcytWVq-LqE166j8hoVNrndZfZGAgnhiE6Ry_BY8+w@mail.gmail.com>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <CAOPX746tZcytWVq-LqE166j8hoVNrndZfZGAgnhiE6Ry_BY8+w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Artem,

On 7/17/26 12:50, Artem Shimko wrote:
> Hi Maxime,
> 
> I could suggest a couple options for how I should handle the driver:
> 1. Recognizing that this is a problem with the PCS layer, I can remove
> the inversion from the patch
> (but add it to my working project as a separate, non-upstream patch).
> This way, we'll just leave the delays setting in the driver, which is
> fairly common among driver users.
> 2. Leave the inversion in the driver until some future common
> framework solution is developed, and
> then adapt this part of the driver to that solution. I'd be happy to
> help develop/modify that framework =).
> A packet generator could also be added to it.

I'd say, you can send the patch without the clock inversion for now, to
keep it simple and generic. If the clock inversion is something that
you really need we can assess that in a second time.

The rest of the driver looks fairly simple and nice :)

Maxime

