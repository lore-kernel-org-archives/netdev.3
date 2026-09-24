Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F1F73FD946;
	Thu, 24 Sep 2026 08:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790237014; cv=none; b=Z47I0FYhMVmfjt4nr8IWS6p2nm0ojw+/VVYdNp1o9h+WGz5bYrgADnkhviL5FJahoO7giQYhvjhLayBPQch2Pjnd6t0zxQ9UVR7OlucE5R48C7L9VfbFek7JrWoh6nfokvO+AkYBfMbUwP4ZBgFWqhhbupV+DLPQzDyOrqfbv9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790237014; c=relaxed/simple;
	bh=0TEMwLgDZiirOQlHfdV9eI4QD39znHiJ1dBbJXOj0rg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=drep19rw0xU2ayO5bao2KnW7ZjnqqJTZpWhZRBhGFuf9DNHwoz04BEqjruw6usybKkayzU0tpkwOFIUEGcMeb8PTrUYY/KjWeUwEVpiZeqsQdmb20ThVqWg8kfF+KJRih6Ae8U3hzcT5B2NtW4uqdUSvRz1qgsI70+XIbqtpKLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=nnmlteqO; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="nnmlteqO"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 5B1D14E41055;
	Thu, 24 Sep 2026 08:03:29 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 201175FB45;
	Thu, 24 Sep 2026 08:03:29 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id F0B15103294B3;
	Thu, 24 Sep 2026 10:03:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1790237006; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=QOUtcT8Q4eTri6qdv3OSDlm4evmWQaxgCXIcuTn8yMA=;
	b=nnmlteqO1wYSHSaN+gcwEtmzcjW62gS3diRemNWhNQ/Xn1ndq6P4TeTNgbY4o2CIuut3eg
	/KZTomI0oNnSHY3aboBikRLDopRrIuWuGOchdhTP30Vu3H/22HoGvrXomEN6R+VwY0YpS2
	TVgxn6IFuGZFp5W2nKAapvyHdhn9f68KDNeRNNIINaVSnvMa5oD2I0kxRBn4f37PtaHCWP
	Ec+zXldDL77Wlee6bg0QA+KHp6loQLb5uBsssBvaUMidxQ5SdvWJF8hGGlYI/crojBKI1f
	iNXZxA0fidr1Thpw7F5xxz6HqSL69Q+6bbFwAdxs5fCPnra9P7TtE0CRtOeR0g==
Message-ID: <56a9c5f0-55af-4547-89cb-c966423ee12c@bootlin.com>
Date: Thu, 24 Sep 2026 10:03:12 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v16 00/12] net: pcs: Introduce support for fwnode
 PCS
To: Jakub Kicinski <kuba@kernel.org>,
 "Christian Marangi (Ansuel)" <ansuelsmth@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Simon Horman <horms@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>, Lorenzo Bianconi <lorenzo@kernel.org>,
 Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, Philipp Zabel <p.zabel@pengutronix.de>,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling
 <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 llvm@lists.linux.dev
References: <20260916235200.20712-1-ansuelsmth@gmail.com>
 <20260921135933.7e8857ba@kernel.org>
 <CA+_ehUwy9RUKCCHDnqoED3AMVnErgGr9RCrCR4ceg5QONq1wOQ@mail.gmail.com>
 <20260922172514.7feb6e7c@kernel.org>
 <CA+_ehUyFKZzd0uP4akgZxaLLJTwcvGGKz5ppCYsB++fn92Dn9w@mail.gmail.com>
 <20260923201158.3552915a@kernel.org>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <20260923201158.3552915a@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi,

On 9/24/26 05:11, Jakub Kicinski wrote:
> On Wed, 23 Sep 2026 10:31:49 +0200 Christian Marangi (Ansuel) wrote:
>> Il giorno mer 23 set 2026 alle ore 02:25 Jakub Kicinski
>>> On Tue, 22 Sep 2026 12:12:56 +0200 Christian Marangi (Ansuel) wrote:  
>>>> The remark on the fwnode patch are invalid. The driver is expected
>>>> to return those error as probe defer is not supported.
>>>> (a notifier and late attach/detach is used to align to phylink logic)
>>>>
>>>> For the specific Airoha PCS driver it's really speculation from the AI
>>>> but HW doesn't work as described by AI.
>>>>
>>>> The only real comment that is valid is about the alternative way
>>>> to give supported interface with the .get_capabilites OP.
>>>>
>>>> This is currently not supported as there isn't any user and it will
>>>> be implemented as soon as there will be one. It's really to limit
>>>> the patch delta of this change and to progress further.
>>>>
>>>> Maybe FIXME might be suitable?  
>>>
>>> FWIW no preference here, I defer to the human reviewer.
>>> We can treat the AI review as a hint if human reviewer thinks the code
>>> is fine as is.  
>>
>> Soo should I send v17 to fix AI that failed review?
>> I think I didn't got this detail.
> 
> Sounded like Maxime was planning to take v16 for a spin.

I gave it a quick run this morning, it still works fine with the mvpp2 porting
I made last time, as well as on dwmac-socfpga :)

My tests doesn't cover the entirety of the patches though, I haven't stressed
at all the fwnode path.

But this is starting to look good to me, I think you can send V17 with the sashiko
fixes :)

Maxime
