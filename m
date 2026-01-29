Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2573B37C111
	for <netdev@vger.kernel.org>; Thu, 29 Jan 2026 08:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769676347; cv=none; b=hlsQhrBtZ1ZVgXd5XS4F84ZtH8vWy7wn6Le0LYMnD6dr41qOjGDO5Ox2MlIpUZeD/Gyf499/vlWP9oCVXh69q+3evrM1TBC7J0zJSwhzotka6+HJdDmTZ9B8xJx4XBpTGok+wMOqFc2aGs7VJV5SoLBMJRr0j9K18cGXWcknk48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769676347; c=relaxed/simple;
	bh=vCM6OQOvJs5WSt+9iieMhZP3WhgJYd4K/csM+xoRSNk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YWyShrc9UA0vA9xahwbTSJK4LM4Fuo4XmW9QLjBpbTeWGhvHMCGXP+JtUEhTGJ7v47pdu9Li0IKaGk4rfjbBx80xNpYS9uUA0bHrP5JxHZ88Twwh22Qnv+OaCCxq1nC+bYqZ2SlYdFJ5z0pb//AnfW4iBb42Bzso5XVVOdEC+r4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=RdD+2KK5; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="RdD+2KK5"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 59FD74E42312;
	Thu, 29 Jan 2026 08:45:42 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 15FA3606B6;
	Thu, 29 Jan 2026 08:45:42 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 75D45119A868D;
	Thu, 29 Jan 2026 09:45:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1769676341; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=d/l3TbjoYhdgkglTb6IDQq8GQZaFfOlIjIUn/T6qpWQ=;
	b=RdD+2KK5nEuxFcbrA3BlrEEj0OtBfqtX0C2vnqEEaiGX/wQDitQjyBnTy+sf10t3JVP+b8
	tVsRAwyQobgcAVvaxRe2Sc8B3wBF2z6Km/PcsUwUL0fm/+Dj5QhJZ0t3R05FhCVHzd9CTH
	5HTN+N0qJ7kjvdkvwpBO3o+aJlebPXL4pFxQ8wkAJvCybKF1MNZ5OgT7CnmvY4xeMLTHEC
	oJNO14uThFnyTIReLmbdSBI759WRriYUnUvj+TXCQdW0JJOreJUgtzASPEdo0Lg8qeJJKU
	hUDXOo6fqFp5YVBk7py/lIAw9LNAnKG4TfykRGlI7FBDvBk3YyxhELiJ1rl/XQ==
Message-ID: <d8d6b779-358a-4d70-90f8-eba74b5a4092@bootlin.com>
Date: Thu, 29 Jan 2026 09:45:36 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] net: sfp: Fix quirk for Ubiquiti U-Fiber Instant
 SFP module
To: =?UTF-8?Q?Marek_Beh=C3=BAn?= <kabel@kernel.org>, netdev@vger.kernel.org,
 Russell King <linux@armlinux.org.uk>
Cc: Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 Eric Dumazet <edumazet@google.com>, "David S. Miller" <davem@davemloft.net>,
 Heiner Kallweit <hkallweit1@gmail.com>, Andrew Lunn <andrew@lunn.ch>
References: <20260129082227.17443-1-kabel@kernel.org>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <20260129082227.17443-1-kabel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Marek,

On 29/01/2026 09:22, Marek Behún wrote:
> Commit fd580c9830316eda ("net: sfp: augment SFP parsing with
> phy_interface_t bitmap") did not add augumentation for the interface
> bitmap in the quirk for Ubiquiti U-Fiber Instant.
> 
> The subsequent commit f81fa96d8a6c7a77 ("net: phylink: use
> phy_interface_t bitmaps for optical modules") then changed phylink code
> for selection of SFP interface: instead of using link mode bitmap, the
> interface bitmap is used, and the fastest interface mode supported by
> both SFP module and MAC is chosen.
> 
> Since the interface bitmap contains also modes faster than 1000base-x,
> this caused a regression wherein this module stopped working
> out-of-the-box.
> 
> Fix this.
> 
> Fixes: fd580c9830316eda ("net: sfp: augment SFP parsing with phy_interface_t bitmap")
> Signed-off-by: Marek Behún <kabel@kernel.org>

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Maxime
