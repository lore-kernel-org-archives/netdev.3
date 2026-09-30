Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 309D633F399;
	Wed, 30 Sep 2026 07:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790753437; cv=none; b=GjRbp/rHc4rnTpegbfz4gWdz+bY1tZmwVmNASIxpBWpFc90nD0T+0fNtLT6dOMfXwJNf+ADpuXTToAfQbsa0GHUqShb7NqWPgnR81qLIQ+hTFJE6zDBRY42UmQREg0nk22TasTdUPx6zPMsVNXn8OTp01KOvB+WezKE+3y7MmQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790753437; c=relaxed/simple;
	bh=gnJwIWZ0OaiusvOZEGyA6fB0xtNjxn+x6S35GGfFP5k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bw6wTJjjrmWealQ1aoVlVyPWM44GLCWipZxEKVVbUw6IFzn4fYMyhbbSD5BvwnabXE4dnqUhOfLCtljXaipxaVD8eal6w4kPP5QgjKzP+7V/rEzVlsf+WXSQzhGhDikhPAce652HQTFVBhVI7/7vxZNObOPFX+Qbsr6fNU3f6Xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=f/gUxUXo; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="f/gUxUXo"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 5A7334E410D4;
	Wed, 30 Sep 2026 07:30:33 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 2CD8760749;
	Wed, 30 Sep 2026 07:30:33 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 00423103294FD;
	Wed, 30 Sep 2026 09:30:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1790753431; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=V3G3ceyW26tN5FPIC2tk9DLejAJ+HGX06qzLwQTysr4=;
	b=f/gUxUXolvh8eWiue5bAu55n1GQNeRg8u+QkBZ30JkUoTYKnkfAonnsM1S3a7LM3TggjrK
	YRJT6G3l5J+Iw1wKtT38rsVACAZSMWr3cWXBZHa5TvJTwz+bOVwuWyaDSUqrqY79Y3iIR/
	meA7OAzqcsUwn7iHNpZZw/b/l+mKRfQTmmBn9Ae8BXcSYn17OmHc+iTg6Ink3j/OVT9O5r
	VQqRIiXMxZ9pg3ShPw+dqSd2NF4PyKbzBdQYpWuUrq26g0x9Gxs1BA2pMMcWoXTHh8BsQR
	rtZC4LvbCMSprTkWmi7psnD8QWqPjJvhCxpYnuAleSIzVgwlH28b1N3DwXDOHw==
Message-ID: <c19df0e5-7edc-4e68-aa4e-36753066e945@bootlin.com>
Date: Wed, 30 Sep 2026 09:30:23 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 2/2] net: stmmac: Don't set or get RSS
 parameters when not supported
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev-bot+sashiko@kernel.org, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 horms@kernel.org, mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
 linux@armlinux.org.uk, nb@tipi-net.de, jitendra.vegiraju@broadcom.com,
 thomas.petazzoni@bootlin.com, alexis.lothore@bootlin.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, pbrobinson@gmail.com
References: <20260928145043.1228968-3-maxime.chevallier@bootlin.com>
 <179067171307.434549.1093187286398187440@kernel.org>
 <71adb267-2dd9-4225-91e5-19848a87eb49@bootlin.com>
 <20260929180928.546f23af@kernel.org>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <20260929180928.546f23af@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Jakub,

On 9/30/26 03:09, Jakub Kicinski wrote:
> On Tue, 29 Sep 2026 10:57:10 +0200 Maxime Chevallier wrote:
>>>> @@ -943,6 +949,9 @@ static int stmmac_get_rxfh(struct net_device *dev,
>>>>  	struct stmmac_priv *priv = netdev_priv(dev);
>>>>  	int i;
>>>>  
>>>> +	if (!stmmac_rss_is_supported(priv))
>>>> +		return -EOPNOTSUPP;
>>>> +  
>>>
>>> [Severity: Medium]
>>> Does this -EOPNOTSUPP break namespace-wide ETHTOOL_MSG_RSS_GET dumps?  
>>
>> This was reported by Nicolai already, and other drivers report -EOPNOTSUPP
>> here.
>>
>> If we address that, I'd say we do that in the RSS ethnl code.
> 
> Let's get this in the same series, cause I'm not 100% convinced.
> My instinct is that returning 0 size for indir table and key
> would be correct and less hairy for the core to handle.
> All pieces of RSS are optional so returning 0 size for everything
> should be equivalent to having no RSS.

Ok no problem, I'll also give it a test on mvpp2 as well then.

Thanks,

Maxime
