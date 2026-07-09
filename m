Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E3143815D4
	for <netdev@vger.kernel.org>; Thu,  9 Jul 2026 13:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783605425; cv=none; b=j7hVZgmvgAQbnr3sNtsHZsfykT29jCRzLwks8bAhfRgUR3MgdKhPedxEfeXrSGb9deBwRNvTBg5DXUdx+FFtzbDR2LmUmW+pNuTQVgRyWbHtSRedptG+RnSKRNBriGRpEiYE68A3F4hnyTWHYfTdXs/R6B+/wWRkxENONmDyEMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783605425; c=relaxed/simple;
	bh=K5fH2IKrnfPEIkySIrvu/rBHR4F+hmoycCCFpOEaZ0g=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Sgkxv1h16PyUvMLE6rOLgj1BcALbyywvKFQtY+KH0d0FvY+xOAu17LM2lpTHBbkTpnNsQ3co6gO9r6j2bkQFgKH5u6EmBdEeP65zxHo6sukOr5OtqbRrBCnPVS2RG97Fnb9CimQZeCyuPn+1vpguWyyrIQUNyXVy5TDkX+e7Xi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Qq8JyF9c; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=k0Fb5U7K; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qq8JyF9c";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="k0Fb5U7K"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783605423;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cANH06pZ/zI+QIWpTjNeANK2N/N1qkbVAiixYLvi4Ts=;
	b=Qq8JyF9c9vt0uA8hb+rlLg4rHF5nEes4H9F0N4P2IM4P+NUr11izklYniMXDCYsq9tLmA1
	PpHfC1dOeAOFPX5pu6SLuyt+LIyn56FTh3hZRoD1tzd2TyftXYv4jnnqQRAooxl6dJ9Hej
	raDKtj/ZsQf99xApSbNznqS3nNdF29g=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-12-CioxNIjkPIuCAtaHmIaJvA-1; Thu, 09 Jul 2026 09:56:59 -0400
X-MC-Unique: CioxNIjkPIuCAtaHmIaJvA-1
X-Mimecast-MFC-AGG-ID: CioxNIjkPIuCAtaHmIaJvA_1783605419
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-47df02a953dso1010864f8f.0
        for <netdev@vger.kernel.org>; Thu, 09 Jul 2026 06:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1783605418; x=1784210218; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=cANH06pZ/zI+QIWpTjNeANK2N/N1qkbVAiixYLvi4Ts=;
        b=k0Fb5U7KBiMFLWgwptO+qsLyUWS2GnmsqHy+rQ4y0phnQo9A1c8IslS5Y32YKnPJ5y
         4wfQyLoGjcvT2Q4oFHlpYd/oadAxBTNGNVnh0BnHKdwAX3YuU8jO+D1yRIh+cjTBaGFJ
         LmFLj8f7Qpk0t3RMUCcclR/H8Y71gFwyfeqnyA6/jaqEo4RMDEOKJunEeIBmH33x/xXX
         MS0zaL/gl93mNtcIHc4nPLmDA34U3Zw9GwHg18dV+ExGmqAu4hYc1QRDiPXDIfeWdXed
         w1oU1j8nbMsMsd6x5cKojVKThEcMPBIt9zBBXlICrM9xID62lsdURiNvq5OlWWKw3LxX
         QmaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783605418; x=1784210218;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cANH06pZ/zI+QIWpTjNeANK2N/N1qkbVAiixYLvi4Ts=;
        b=iJVrxOCgw9kma+dT1qgtTJSY6BpaBZHDUJl9xh0cr7A8kWOxUnbVnOyGZhZSHLNodY
         zSvc82xqVoXRZzKj2xCl1vkbXrtGFXgFTx6YZDhwzVwcZ6m//zNpauAETsbmn/kzkjj3
         vVvUxXz42yUSzGA8tieizEIVpHKO+3EdF1e5VsFIRQJ8FmigeX4qtPFNPK6Eoip8Ag8w
         YZFRv2IpXzQIJqHX9I+QFhvLJBhlzhUhaelTB2u3gLp/sDC1jdk2qFdW91jCo/sVbsbQ
         W0Znyg9Y86xdSq/Wf0c0niHTIPDOERhZhJQl7weLYPS6rZdMKsVZlPqE1FadCd7+2SaU
         HA7w==
X-Forwarded-Encrypted: i=1; AHgh+RoMeuCLqXfiBu858/99P2izWduz2GYPkC9MOwCcPK6V4fFHjrBMLHqhnmHgb0N1qP0iBoO8MlE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+mZoqX5NvneliPThgexceryIgXnzyEtPOTBYU3wiG+34PCc/B
	tGm9VMJx3A4tzpZkYUf7+HvEh7+CsoZqs7nkr60zQwY7d6NEuBp2rFr9KneolqYgVnN2mm4dccO
	W75GmFmxO7E5ZRRyekYLxo2UsNFPjqFSye4GpX1Dd8GSsWrhH8oDbx3LYkQ==
X-Gm-Gg: AfdE7clyJsBiU9tiXPFkJZrUxD0whNmC7ZPyN3e03BnfTdatLAr1xbiBc4W8N5M8LeS
	5jQHq6mef2Oq0G24+JosfRB5jZ/JCU85S1RXj0zfPnuMbvWrFseUrBa9yWYBKhEIB0iqpQK5wQL
	ki2AmGoLwyd4/cjKgikELf/7ouRo/1c4SwO2NGBRHZpBp8gU3ThhP0KWmyieFF7jnRfm1EovC8o
	xJvxz4LqtUJBiFt/gX6d41vPSQyDg7zJBTycNSiZrhyPMk2HvqslCXe9xjzK4ltncsbHr3dnJso
	ZTDwYOklAdD9qeMbgkCKeu4AgN3BecNfVPdskaX2tTTfKPiXljbruRxadq4dlS26Zd0mPE6AyL5
	tMYlUkc1fzzJpWEbRTuprrYVtx7TG/vholW+2oe4sQthTuBV0AOPpCaZlyeZNHgdv9jZo/5vPaP
	dUIe4GmyN5tHzQ
X-Received: by 2002:a05:6000:4711:b0:474:c3a5:4132 with SMTP id ffacd0b85a97d-47df754a4admr3518320f8f.9.1783605418670;
        Thu, 09 Jul 2026 06:56:58 -0700 (PDT)
X-Received: by 2002:a05:6000:4711:b0:474:c3a5:4132 with SMTP id ffacd0b85a97d-47df754a4admr3518275f8f.9.1783605418184;
        Thu, 09 Jul 2026 06:56:58 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:5521:6b10:58fd:68f:7756:389d? ([2a0d:3344:5521:6b10:58fd:68f:7756:389d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47aa09608d4sm53167952f8f.25.2026.07.09.06.56.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jul 2026 06:56:57 -0700 (PDT)
Message-ID: <56be707f-3f3e-4e5f-8379-3305c864c9d4@redhat.com>
Date: Thu, 9 Jul 2026 15:56:55 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/4] net: usb: centralize usbnet_cdc_zte_rx_fixup
 in usbnet
To: Oliver Neukum <oneukum@suse.com>, Manuel Ebner <manuelebner@mailbox.org>,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, shaoxul@foxmail.com, netdev@vger.kernel.org,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260702143142.890654-1-oneukum@suse.com>
 <20260702143142.890654-3-oneukum@suse.com>
 <ebfe837b7d4ef61442822105c3d71ca306106c14.camel@mailbox.org>
 <cbb51e43-ad79-4b6f-b38b-3ec2221de814@suse.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <cbb51e43-ad79-4b6f-b38b-3ec2221de814@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 7/6/26 2:00 PM, Oliver Neukum wrote:
> On 02.07.26 20:19, Manuel Ebner wrote:
>> On Thu, 2026-07-02 at 16:25 +0200, Oliver Neukum wrote:
> 
>>>
>>> diff --git a/drivers/net/usb/usbnet.c b/drivers/net/usb/usbnet.c
>>> index 5544af1f4aa5..7beea6d0e731 100644
>>> --- a/drivers/net/usb/usbnet.c
>>> +++ b/drivers/net/usb/usbnet.c
>>> @@ -2347,6 +2347,25 @@ void usbnet_cdc_status(struct usbnet *dev, struct urb *urb)
>>>   	}
>>>   }
>>>   EXPORT_SYMBOL_GPL(usbnet_cdc_status);
>>> +
>>> +/* Make sure packets have correct destination MAC address
>>     /*
>>      * Make sure packets have the correct destination MAC address
> 
> This sort of puts me into a conundrum. Does networking code use
> the short style of comments or not? The documentation says that it does.
> I am fine either way, but I need a clear rule.
Networking code used to require

/* for
 * multiline comments
 */

but somewhat recently we switched to accept also the more common

/*
 * multiline comment
 */

Checkpatch accepts both; it's not a deal breaker either ways.

/P

