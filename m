Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CD3A38D3E2;
	Tue,  4 Aug 2026 17:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785865656; cv=none; b=kpsvOk34nu9bNmhD1DRffOlIKECb5CUVKzH4V4cg9po1E/4AdpjMH30HMY5uGFgmiyTPGjJwfDHZangN+t2Nxr9VAlRMGGAS7ttv5gVoHiTjb4i4WRTNx96BTsYqy5l1z09rhI9DjuvWD1vyW8SozOcNJVgTsrdJRARhTU64PG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785865656; c=relaxed/simple;
	bh=j/hPP8jkbfi3rboQ6Wnz+CDqqpULZUvZIxsVMAuWt2U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=myDdA4pPj+WgFWgeTEQYNzxnVy2QxDS9CHq8N2ZzXHaA1HsA5pwuJDXQPp1U3XOx3JBpE/uaBUDzRSMDVn2Evcp5jISSJJrMyeDQHvSODULurquBam4RnsU67XzwXzhn2h2ikBh3nivtsoOUxsk6Z103iHZSZDXrnCmuAaD6BHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marmottus.net; spf=pass smtp.mailfrom=marmottus.net; dkim=pass (2048-bit key) header.d=marmottus.net header.i=@marmottus.net header.b=NEN801rJ; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marmottus.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marmottus.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marmottus.net header.i=@marmottus.net header.b="NEN801rJ"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 23DFC3ED12;
	Tue,  4 Aug 2026 17:47:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marmottus.net;
	s=gm1; t=1785865651;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7vkceEGEwK/ANQemAF3H6G68yDEuGawBZ5Gr2wXTA6Q=;
	b=NEN801rJQPFCC5TFexQrJp3xyO1W914RbOAdhH08M5LChCS4RnY8SqDO9g+8l4Ioudgdwq
	a4sjNJHp1dOQCEyoB5WBs//wM266653Qq5QDcnU53jYtr3Xn4FcpZbYe/BEu2XQk4CCD09
	BGDfRw1sCQlhRPN12yd8HEC+JR/rGuj/Jp9BjytIM3WeDFfchO9wduEY6llhp5L2UDnMcb
	fvNTkVKN6KU4T/192vi2l4qcRNVnRLXSGH2HdxSioWcd8cHst/amJeZ11ZhRgH8W1lhn3v
	k7y36JjES5lw6FuhQZXWL5kPX07NugGsj8D75hGl9yVBe123rq0x6a7idsRuaA==
Date: Tue, 4 Aug 2026 19:47:20 +0200
From: Arthur =?utf-8?Q?Cr=C3=A9pin?= Leblond <arthur@marmottus.net>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Netdev <netdev@vger.kernel.org>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] w5100: restore GPIO-based link detection
Message-ID: <anIlqILTusVzSefH@pc-du-fromage>
References: <20260804-wiznet-link-gpio-v1-1-b626fd4f7ccb@marmottus.net>
 <75937d1b-8ae9-4daa-bc36-08bdf5a6c5a9@app.fastmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <75937d1b-8ae9-4daa-bc36-08bdf5a6c5a9@app.fastmail.com>
X-GND-Sasl: arthur@marmottus.net
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: dmFkZTFd1G6aU6NpiT96xs0T3HJ4vOA0zeGEzJunf9PVWnVHeLQDFlORYa9HG9rmVmtZUGqcazTsix+7IfhgXF8jIcWYUf0HG3FbFt//r9QBp7TvsBOAhhXtCNL5Wf3hS3CaIeNlMTnswOMVYylUux58OG0A2nHPOLyf5vT7aocApvoIMU3SuDKmsNB1DIM8GDg+YFnml2eOTmzLHaLSM89L64J5MEs3lhPP9Oy6VppRAz/arnOvYkgTns8eDMNY/ENuSjyuze/Ht0SsO8R1ZDsZUcXPSZf6xshZDae56grWENGSl2UfBZxz7A1XJGh8JYxmKPcfCnDFC5Kieoj71t8ZXX2TES14mnMR7Ncn/0f3IaNXeQInX3eFZcatupKTmXM3FviUM18cNbWteQUqKn5Sgu0vBYWSKQs9/yGOHCmDnHEp23zSD9JPaeA0MSa67e4WLGpTHTLfUx9vdtVpDA0g2mgQYUXgfXy2FX7oHl3/V8VsFpxqsaq4878U2AT7MJlgr04UTAv2+KzG8Yk2N4TxIOwkbB2XcA6A07fk/+LFApRPylWGaWfun5LVIqlOXQ+7I0oV8tqiNlxxTFWCXk0kYBr4E7nDAMR1UdyGCMh/RQwP4QH9YPduZoZ7/UAkJ2QbIs5LC700QQmtu247Ygh8ikTkJ5FsMSMvVY8GCZpobO6UZQ

On Tue, Aug 04, 2026 at 05:02:48PM +0200, Arnd Bergmann wrote:
>On Tue, Aug 4, 2026, at 16:38, Arthur Crépin Leblond wrote:
>> Commit dacf281771a9 ("w5100: remove unused gpio link detection")
>> dropped the link_gpio/link_irq handling on the grounds that no
>> devicetree user passed a "link" GPIO at the time.
>>
>> Signed-off-by: Arthur Crépin Leblond <arthur@marmottus.net>
>
>Hi Arthur,

Hi Arnd,

Thanks for the reply and the review!

>
>The patch description could use some more explanation here, and
>a clarification that you don't just bring back the original
>broken code but add devicetree support for it.
>
>>  .../devicetree/bindings/net/wiznet,w5x00.txt       |  8 ++-
>>  drivers/net/ethernet/wiznet/w5100.c                | 84 ++++++++++++++++++++++
>>  2 files changed, 89 insertions(+), 3 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/net/wiznet,w5x00.txt
>> b/Documentation/devicetree/bindings/net/wiznet,w5x00.txt
>> index e9665798c4be..e97ce3cb9183 100644
>> --- a/Documentation/devicetree/bindings/net/wiznet,w5x00.txt
>> +++ b/Documentation/devicetree/bindings/net/wiznet,w5x00.txt
>> @@ -25,6 +25,7 @@ Optional properties:
>>    According to the w5500 datasheet, the chip allows a maximum of 80
>> MHz, however,
>>    board designs may need to limit this value.
>>  - local-mac-address: See ethernet.txt in the same directory.
>> +- link-gpios: a GPIO line used for the link detection interrupt
>>
>>
>>  Example (for Raspberry Pi with pin control stuff for GPIO irq):
>> @@ -38,13 +39,14 @@ Example (for Raspberry Pi with pin control stuff
>> for GPIO irq):
>>  		interrupt-parent = <&gpio>;
>>  		interrupts = <25 IRQ_TYPE_EDGE_FALLING>;
>>  		spi-max-frequency = <30000000>;
>> +		link-gpios = <&gpio 4 GPIO_ACTIVE_HIGH>;
>>  	};
>>  };
>
>Ok, so you are using the binding I suggested originally,
>which I think is fine here, but note that Rob asked for
>the binding to be converted to yaml format in
>https://lore.kernel.org/all/20260427145010.GA2502144-robh@kernel.org/
>
>I avoiding touching it by just removing the broken implementation,
>but it would be good if you could do this now.

Yes, I started to reintroduce the driver link GPIO code from the 6.18 tree
and converted to gpiod_ and noticed that you already had a patch
(20230127095839.3266452-1-arnd@kernel.org) so I reused most of your code.

>
>> +
>> +		priv->link_irq = gpiod_to_irq(priv->link_gpio);
>> +		if (priv->link_irq < 0) {
>> +			err = priv->link_irq;
>> +			goto err_gpio;
>> +		}
>> +
>> +		err = request_any_context_irq(priv->link_irq, w5100_detect_link,
>> +					      IRQF_TRIGGER_RISING |
>> +						      IRQF_TRIGGER_FALLING,
>> +					      link_name, priv->ndev);
>
>I think you can just use a hardcoded link name here, and
>an open-coded gpiod_to_irq(priv->link_gpio) for simplicity. My
>previous version kept this from the original code, but if you
>reintroduce it, you can improve it further (as you did elsewhere
>already)
>
>I would probably also use devm_request_threaded_irq()
>
>> @@ -840,6 +918,7 @@ static int w5100_suspend(struct device *dev)
>>
>>  	if (netif_running(ndev)) {
>>  		netif_carrier_off(ndev);
>> +
>>  		netif_device_detach(ndev);
>...
>>  		w5100_hw_close(priv);
>>  	}
>> +
>>  	return 0;
>
>The whitespace changes should not be part of the patch.
>
>     Arnd

I took your changes into account and made a v2.

Thanks!

-- 
Arthur Crépin Leblond
