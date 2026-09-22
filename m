Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 272E35437CC;
	Tue, 22 Sep 2026 12:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790081420; cv=none; b=N89CR0kylh4DLKZXCO9fLRKpT8OZHhj2N8sdFMyWoFkolNE2z2KWsCLuD9NvN4jyF7oK1Rx2jP2f884bth9dGk2O2nO8V0K4tl1tb3wPO/CpI1tOO5bCDy4MQq6SDh+TwH42pmRugf9dgucoCV3wx4oz8kO3SYe2cqNCgUYeXiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790081420; c=relaxed/simple;
	bh=3GHTJrgcGpWkQfsap4SwWOsGxwKhu+V/arurGwl6nIU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Rfx2OmWaYsik9sYCgBfulzi25O0M4sIDb6Cy2r3oYIMcqW9or2rp06cP+uIf955zhIfpf7QQk6MW1rgzs85ZvwIotwH+XhNbFN0T1150BdRS7IDvit1QyGi/QRacrhU9TztaJNm/bm9/rkkm0jL16tZKLiz+c7JgviTQjy4t0ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=SMWmOhVc; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="SMWmOhVc"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 70E931A0FC8;
	Tue, 22 Sep 2026 12:50:15 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 20F0160580;
	Tue, 22 Sep 2026 12:50:15 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 645F4103289FC;
	Tue, 22 Sep 2026 14:49:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1790081409; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=Pp7mzsLIsbavEPfem5dhuoLyc27UEuONp1Ueoff5SSI=;
	b=SMWmOhVcC5GkK+X8WZA70hvKKa1Ea1wfG8B8tKZVFCR7esnlKTgnDlY00+AKd/7poPloHR
	lR4szN4Oz0HMmVM7SP1/j32iV/h2Uq917H6w8dkEjAohMivLHrGDR8Fw+6fUzrnnKNxdjQ
	4xhNMo2FEdhN08NkltOWX+XkLxiMMc7ufK5UWQhsAdd6lR3tGFmyCoD2TZgRrFK+0I1xcn
	TURJ6ab/JM9OX1x7Ch01AlIaPajCgUzc6U1MwPCAnwjSMPy8y4AEVW2IeKXCqscj2IIPXj
	vEq7eaXP0k8jH2rJO/Cw8oKlRfsmb2MZuRrwyqrTY9XcfRn6NR8FbuDvLmERog==
Message-ID: <033fc935-c37a-4b0f-8b79-68248e45da8f@bootlin.com>
Date: Tue, 22 Sep 2026 14:49:57 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v16 00/12] net: pcs: Introduce support for fwnode
 PCS
To: "Christian Marangi (Ansuel)" <ansuelsmth@gmail.com>,
 Jakub Kicinski <kuba@kernel.org>
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
 llvm@lists.linux.dev, Coia Prant <coiaprant@gmail.com>
References: <20260916235200.20712-1-ansuelsmth@gmail.com>
 <20260921135933.7e8857ba@kernel.org>
 <CA+_ehUwy9RUKCCHDnqoED3AMVnErgGr9RCrCR4ceg5QONq1wOQ@mail.gmail.com>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <CA+_ehUwy9RUKCCHDnqoED3AMVnErgGr9RCrCR4ceg5QONq1wOQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi,

On 9/22/26 12:12, Christian Marangi (Ansuel) wrote:
> Il giorno lun 21 set 2026 alle ore 22:59 Jakub Kicinski
> <kuba@kernel.org> ha scritto:
>>
>> On Thu, 17 Sep 2026 01:51:26 +0200 Christian Marangi wrote:
>>> This series introduce a most awaited feature that is correctly
>>> provide PCS with fwnode without having to use specific export symbol
>>> and additional handling of PCS in phylink.
>>>
>>> At times there were 2 different implementation (this and the one
>>> from Sean) but Sean agreed that this can be picked and used in favor
>>> of his implementation as long as his case with race condition is
>>> correctly handled.
>>
>> Looks like the review for one of the patches failed so it won't be
>> emailed out:
>> https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260916235200.20712-2-ansuelsmth@gmail.com
>>
>> Are all of the issues invalid?
> 
> Only one is relevant, but expected.
> 
> The remark on the fwnode patch are invalid. The driver is expected
> to return those error as probe defer is not supported.
> (a notifier and late attach/detach is used to align to phylink logic)
> 
> For the specific Airoha PCS driver it's really speculation from the AI
> but HW doesn't work as described by AI.
> 
> The only real comment that is valid is about the alternative way
> to give supported interface with the .get_capabilites OP.
> 
> This is currently not supported as there isn't any user and it will
> be implemented as soon as there will be one. It's really to limit
> the patch delta of this change and to progress further.
> 
> Maybe FIXME might be suitable?
> 
>>
>> Once the AI review is cleared, some human will have to review this
>> and vouch for you as a maintainer. Better still be your co-maintainer.
> 
> I think some revision ago there was Andrew that reviewed some code.
> Anyway thank a lot for checking this once in a while, I feel it's a pretty
> important change but I understand it's complex to handle as it does
> introduce a whole new subsystem.

I'm attending a Rust training until thursday, I'll see if I can squeeze in some
time to re-test on mvpp2 :(

There're a few series pending for rockchip and S32 on stmmac that deal with
PCS support and their PCS handle. It would be nice to have some stmmac glue
maintainers that are using complex PCS to help with maintainance or at least
testing, maybe Coia can help with the tests ?

Maxime


