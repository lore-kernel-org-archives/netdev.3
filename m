Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDBF438E12D;
	Fri, 25 Sep 2026 08:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790324482; cv=none; b=JYsz1CiRlA7Nlb3q0MelDq+WmrzwpdWOMdkwC5DADyHxD9vA1TLF9GAk4trJBxclnhO+UVb29SgpiXcqF9GoV8ghvQYG5h9WmGoauwEQoJSqioNcuAw+yaUJakQP2300oJz+6wMVN4GyQcswjX6Z9fHBcJSCpughlUwwlHlBYrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790324482; c=relaxed/simple;
	bh=VwzEUOqgcHwAeMaOMCFun6YeXj5Y8ZrgAbTTUV1MMj0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Fb3K451oYzMWN8HRqtgPeiA02XNENdfLc5toj+QaqG/00pTTXrt3TJtYHmtUkBuesMmq1QjqHsenWDcjz5eHfHj+UnWEHBFaDLkSS9rduCEuS45kpr0oYncMlQFNU61KLsqth7+N2tpmgmh2GmsHuzh/lOStDrLLUVoJuez3dd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=duqAEeCH; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="duqAEeCH"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 770C64E4083B;
	Fri, 25 Sep 2026 08:21:19 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 452506073B;
	Fri, 25 Sep 2026 08:21:19 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C13E3103294AF;
	Fri, 25 Sep 2026 10:21:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1790324477; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=sJa6N/GzykXQ82C/0kl9ZKXv34ovu/9qaIOQC1R2/8A=;
	b=duqAEeCH9IFXoRNfqumO2lC2Xy2TTY11sXerBkjGu6tAQpgrVfEshA3afCWU1+DeH0BCJu
	88xCQ9Fn/PapNnDRjHPcWqxtiVIS3Q1jGcOTfelc3YR/mP4hddOPH/liRm4mJb1dA90WqM
	qDcQNpxvQgYSanCE6Qy6alUgVdi/gQfmF7X1Y+dR7K1aw+SppzrWT3g/9UYGP6D6hD3Rhe
	P74Td7LbkgGf6q+y3ugM0FIXqTL37JVnWJvfHEWTPEywCN0ryzc/5enFWPZPsk5+ZKKiW7
	r+oX2f1ihaXuui9FVJZSaYK8K44hqjQ5M6sFsvagCRTXFB2Wf6g0CjAodttg3w==
Message-ID: <f8fc89b7-15ff-4915-8f1c-49c3b2357699@bootlin.com>
Date: Fri, 25 Sep 2026 10:20:59 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v4 0/7] net: stmmac: More selftest-related fixes
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, davem@davemloft.net,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Russell King <linux@armlinux.org.uk>, Heiner Kallweit
 <hkallweit1@gmail.com>, =?UTF-8?Q?Alexis_Lothor=C3=A9?=
 <alexis.lothore@bootlin.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Emil Renner Berthing <kernel@esmil.dk>,
 Minda Chen <minda.chen@starfivetech.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Jan Petrous <jan.petrous@oss.nxp.com>,
 Ovidiu Panait <ovidiu.panait.rb@renesas.com>, Jose.Abreu@synopsys.com,
 Nicolai Buchwitz <nb@tipi-net.de>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
 linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, PKneuper@dspace.de,
 David Laight <david.laight.linux@gmail.com>
References: <20260917215339.2022523-1-maxime.chevallier@bootlin.com>
 <20260921152202.64d4c67a@kernel.org>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <20260921152202.64d4c67a@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi,

On 9/22/26 00:22, Jakub Kicinski wrote:
> On Thu, 17 Sep 2026 23:53:31 +0200 Maxime Chevallier wrote:
>> This is V4 of stmmac selftest fixes, addressing Sashiko's issues over
>> the MTU patch. This lead to the introduction of a new one. The
>> dev_add_pack races have been addressed, however the double-vlan issue
>> stayed there. Ovidiu is actively working on it, let's wait for his work
>> to land before fixing that.
>>
>> Nicolai, I took the liberty of keeping your review tags on affected
>> patches, let me know if this isn't ok.
>>
>> This is another round of stmmac selftest fixes, mostly about the selftests
>> themselves but a few things were discovered w.r.t MTU and buffer size
>> handling, see patch 5 anf 6.
>>
>> After this is merged, I consider the selftests to be now reliable enough
>> to run them nightly on every stmmac series that's sent, and I'll be requiring
>> clean selftests for new glue drivers.
> 
> This got to the top of the stack for me, LMK if none of the AI feedback
> is legit. You mentioned the VLAN one, not sure about the rest.
> The EEE complaints look like nit picks but also some are easily
> addressable? LMK..

Thanks for applying :)

Much greener now :

https://minimaxwell.github.io/stmmac-ci/

Maxime
