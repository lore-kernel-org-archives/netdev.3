Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E56BD26FA5A
	for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 12:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769085130; cv=none; b=rM0Vm32xqz/eEy4Ob3tgBOwpcVQ9XIghJA2IC10Pa4As7ViMdLJkpG7YqJ+GTTX+9KEUvgFqadvtBGI2nU+KAq2NA77G//bd1EfNE+6LtMic0rYJla4SEVK4fB3V4KzdpAq720503Y9286ZpjEG6/QD66rB6yNDaNCMUyIv+mA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769085130; c=relaxed/simple;
	bh=T0B4Aysngk9AYB4KDOXAjX7IYn1+hFLLAhtwfY5VegM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l3d9NHb54u8E1uyhnirL/hx6+ypQzubjYZg1e/FCljV3Ctqe3S+vVLUFDt69TylpMGqZ1TTmtkLSlgDQdnd2HZairNWPySmC3kB+oAyzDbsxgeUmz7sEx4ewXltCpC4v4tzn8Tvy4fsUSLetS3dfQjN8KZyd8Uf9RC2/CAvoCl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=dCzstjUZ; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="dCzstjUZ"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 29A011A2A54;
	Thu, 22 Jan 2026 12:32:03 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id D223C606B6;
	Thu, 22 Jan 2026 12:32:02 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 82C1D119B818B;
	Thu, 22 Jan 2026 13:31:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1769085122; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=T0B4Aysngk9AYB4KDOXAjX7IYn1+hFLLAhtwfY5VegM=;
	b=dCzstjUZ64RDTZX168ppsHBo2JzipVo67yFaYYdRRcqgN1F1/a8NNC3XJjtzPGiiHhxyLT
	lLLyvrwbO4bQJpR/Y7YI0qnBp6ZTzSU+HTXtLMZnG4RHBZCzH+ohmytAKmuRlmzHKNLu8x
	YzjeJR+yBuxgHfwwi3CMxBqGsuvnZWVA46mRjGns0SEkrsF3LUmYqQ7WjSG1JpZAffjyKy
	itpTyWzmaleEJs81ObP6ePO2IEX+7IW3gWIL0iHPz5nfa4vuDEpv2sQr0oXjJEzLsGXgsP
	PpsllGLLV8P/+p5oosBNdDRF4SpAtDrqq8njrQH0fTJV1qujYUGoIk4gKhYz7A==
Message-ID: <697e05a3-9ae0-4a84-88ed-9efba98316b1@bootlin.com>
Date: Thu, 22 Jan 2026 13:31:56 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC net-next v2 1/2] net: phy: marvell: 88e1111: define
 gigabit features
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Josua Mayer <josua@solid-run.com>, Andrew Lunn <andrew@lunn.ch>,
 Heiner Kallweit <hkallweit1@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260101-cisco-1g-sfp-phy-features-v2-0-47781d9e7747@solid-run.com>
 <20260101-cisco-1g-sfp-phy-features-v2-1-47781d9e7747@solid-run.com>
 <aVe-SlqC0DfGS6O5@shell.armlinux.org.uk>
 <b8cafe50-c87b-4bd4-a47e-d11c11c16f7c@bootlin.com>
 <aXDreiHjK06lHY9h@shell.armlinux.org.uk>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <aXDreiHjK06lHY9h@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

On 21/01/2026 16:06, Russell King (Oracle) wrote:

> If you want to try and work out what the media side should be, then
> I think we're basically going to end up needing our own database for
> every transceiver out there... which leads us towards the model that
> vendors use: only accepting transceivers we know about (which leads
> to claims of "vendor lock-in" for this technology.)

Does the current model of applying the fixups/quirks fits that bill of
having some internal database ?

Thing is, from my tests there are modules (e.g. Prolabs GLC-GE-100FX-C)
where neither the eeprom nor the integrated PHY's reported capabilities
are correct. The only reliable thing we have then is the SFP module's
vendor_name + vendor_pn.

From then on, we may say "We trust whatever comes out of reading the
eeprom + applying the quirks" ?

Or am I relying too much on the quirks ?

Maxime
