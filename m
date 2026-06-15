Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85CEA3F8EBE
	for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 14:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781534661; cv=none; b=SkYg9gzj2WT3rnzE2yJGuNbn5wnH2FfUkvN2P456LBc2RXiaveoWwAfIbMBwBuX+4GbG+M7ZD8rvJmjKuORBOvrSgONTgyaDzpyMBh5ksCtTaWW2lIdGvIhzZlDFDShIKvl7p6u4gb2matz4X5VCg0WwhnOl0u7MqL63dC+Zw0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781534661; c=relaxed/simple;
	bh=0uLKTvbEAK+Dn2jOLZxPcDA5FGg6UyplCkgx7XgWTI0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nlqh/jAGm1Bo8w9X1G7VLazOKo6twXzIEFSAr/JkWq/u59erl2uSa+uJl8zny7yI3YaNvBV0Eg80MPnYaHBycx8HCtdmdEUqkXdKdPbSJ2H8UojdQ0y77B6pdXkgLJHrFV7AzghOnovy9OI1xuYKjECwQ/HKA0fKKF6un/FC49M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=YFbbhTW9; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="YFbbhTW9"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id EC1F81A37EE;
	Mon, 15 Jun 2026 14:44:17 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id A343460015;
	Mon, 15 Jun 2026 14:44:17 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 528B2106C96A2;
	Mon, 15 Jun 2026 16:44:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1781534656; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=LNQ/A2/WUxw1qFzNZc5VEP3z3YtNzDc9swfW+wlF7i8=;
	b=YFbbhTW99y38MgG/y6VAC2apnTEuaqt6BDTPv9X3YLQtVK46ALfjRfM6dV6JqDaRUgaKv1
	Tl5JwKrF2HGbLIpA6BkSC+2OBNkydc3UsTtL6Qs1bij61KpbHSUaB2I5zj/9vHwdAslEjc
	yxZ/sIka+VFvbfErdSPCAyXCr80uUYXDzHyhezFO2fiMGOdftv0vfRyoisP1Znms6bOc1U
	NQDEJ6nnFnCxASwF6fHXoT0tny4ZJWkthBI6iRizavgRM6f8jvKuT39ZEl6DBL7M5T8xMu
	5tP6/dIn7nfxVoVcmwa83SjNCEK9mT6utIwt+jm/qpxSMjTSRqDlNigCOg/iIQ==
Message-ID: <0355da28-d3d7-41ee-ad85-632cc2e03951@bootlin.com>
Date: Mon, 15 Jun 2026 16:44:08 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v7 05/12] net: phylink: support late PCS provider
 attach
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Simon Horman <horms@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Lorenzo Bianconi <lorenzo@kernel.org>, Heiner Kallweit
 <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>,
 Saravana Kannan <saravanak@kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>, Nathan Chancellor
 <nathan@kernel.org>, Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 llvm@lists.linux.dev
References: <20260615122950.22281-1-ansuelsmth@gmail.com>
 <20260615122950.22281-6-ansuelsmth@gmail.com>
 <867a39de-ccc2-4dcf-be24-ab2542d20ab6@bootlin.com>
 <6a3007ce.73de60af.3a056d.d903@mx.google.com>
 <7702ac09-75fd-49de-8ad2-fceaa122b627@bootlin.com>
 <6a300da0.d5af3cef.1ca29d.19c4@mx.google.com>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <6a300da0.d5af3cef.1ca29d.19c4@mx.google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3



On 6/15/26 16:35, Christian Marangi wrote:
> On Mon, Jun 15, 2026 at 04:29:04PM +0200, Maxime Chevallier wrote:
>>
>>
>> On 6/15/26 16:10, Christian Marangi wrote:
>>> On Mon, Jun 15, 2026 at 04:07:03PM +0200, Maxime Chevallier wrote:
>>>> Hi Christian,
>>>>
>>>> On 6/15/26 14:29, Christian Marangi wrote:
>>>>> Add support for late PCS provider attachment to a phylink instance.
>>>>> This works by creating a global notifier for the PCS provider and
>>>>> making each phylink instance that makes use of fwnode subscribe to
>>>>> this notifier.
>>>>>
>>>>> The PCS notifier will emit the event FWNODE_PCS_PROVIDER_ADD every time
>>>>> a new PCS provider is added.
>>>>>
>>>>> phylink will then react to this event and will call the new function
>>>>> fwnode_phylink_pcs_get_from_fwnode() that will check if the PCS fwnode
>>>>> provided by the event is present in the pcs-handle property of the
>>>>> phylink instance.
>>>>>
>>>>> If a related PCS is found, then such PCS is added to the phylink
>>>>> instance PCS list.
>>>>>
>>>>> Then we link the PCS to the phylink instance and we refresh the supported
>>>>> interfaces of the phylink instance.
>>>>>
>>>>> Finally we check if we are in a major_config_failed scenario and trigger
>>>>> an interface reconfiguration in the next phylink resolve.
>>>>>
>>>>> In the example scenario where the link was previously torn down due to
>>>>> removal of PCS, the link will be established again as the PCS came back
>>>>> and is now available to phylink.
>>>>>
>>>>> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
>>>>> ---
>>>>
>>>> [...]
>>>>
>>>>> @@ -2151,6 +2204,10 @@ void phylink_destroy(struct phylink *pl)
>>>>>  	if (pl->link_gpio)
>>>>>  		gpiod_put(pl->link_gpio);
>>>>>  
>>>>> +	/* Unregister notifier for late PCS attach */
>>>>> +	if (pl->fwnode_pcs_nb.notifier_call)
>>>>> +		unregister_fwnode_pcs_notifier(&pl->fwnode_pcs_nb);
>>>>
>>>> I wanted to try this out, but I get :
>>>>
>>>> drivers/net/phy/phylink.c:2218:17: error: implicit declaration of function ‘unregister_fwnode_pcs_notifier’; did you mean ‘register_fwnode_pcs_notifier’? [-Werror=implicit-function-declaration]
>>>>  2218 |                 unregister_fwnode_pcs_notifier(&pl->fwnode_pcs_nb);
>>>>       |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>>>       |                 register_fwnode_pcs_notifier
>>>>
>>>> I guess you either need to stub this, or there's a missing Kconfig
>>>> dependency somewhere
>>>>
>>>
>>> Hi yes if you want toi test just enable CONFIG_FWNODE_PCS. I forgot to add
>>> the static declaration for unregister_fwnode_pcs_notifier. 
>>
>> I'll give it a go with this yeah, I have a few devices here I'd like to
>> try this on.
>>
>> Can you CC me for the next rounds ?
>>
> 
> Sure, if you can would be good to check also the other commit if everything
> is logically correct.

Absolutely, I'm planning on doing this :) This is quite the series though,
I'll try to give it some deeper look in the upcoming days, I expect net-next
to close soon anyways, so that's as good as it gets for reviewing this :)

Also, it's probably a good idea to have Sean in CC as well, I know a few people
interested in the Xilinx PCS his series brought, hopefully he can follow-up on
this series with the other new PCS drivers.

> 
> BTW by checking test from patchwork I can see also another fix is needed if
> you want to test this revision.
> 
> phylink_create()
> 
> -if (config->num_possible_pcs && pl->mac_ops->mac_select_pcs) {
> +if (config->num_possible_pcs && mac_ops->mac_select_pcs) {

Ack, I'll test it with this change, thanks :)

Maxime

> 
> Aside from these change I expect the current legacy code to be not
> affected by these change.

I'll probably have things to say about this "legacy" naming :)

Thanks for driving this work forwards anyway, that's 

> 

