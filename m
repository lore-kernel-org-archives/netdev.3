Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A7DD403E8A
	for <netdev@vger.kernel.org>; Thu, 27 Aug 2026 08:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787820748; cv=none; b=RfkSs8EfeNjtowjPIHrawiiyFFnannfvNjWBKOqLbVltagrps/Qg4hXdY4iJ81UdCKfLBmlUhihTyv9MCPgFlHzQ6/uzzc9C1Wi653bPri1Cuzxoxc/kM0E704RuYmVIK5KxXTY3zPqQ1DvWQiyOGz30n5OFReUfag4xWGRheLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787820748; c=relaxed/simple;
	bh=5hJ7mZeypVJLmhRFxJYm9bHOTFShVm8RTGv547/GiLI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W880xO/h7ZJOVHnqCj1Z1y7bK3u3/GTPxX/uXCcUIBK5c9cRBaNifLTzlN9MgWH+5OS3q9S9bmeaz5t5K2F5LTUIqL+2cl7bjhH4igiDKJKBGUfaLHOyKlawkHhf4k8MKiKlC3HHYmTMpJuWjjMZsvysedsl3oOw5sqX8pjM+58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SpUVYlGC; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ti0mge+2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SpUVYlGC";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ti0mge+2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787820745;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5hJ7mZeypVJLmhRFxJYm9bHOTFShVm8RTGv547/GiLI=;
	b=SpUVYlGCsEByTOdBb3BL+i55+BzMpz/T4cdRoKtFy1Zh1KsUdcePG6K+XzhyFNNW2gEY2k
	1ut8Xk9eLqjmyJLE5RLdGclFqOqqVY1kmS6J37xnci/41gxQcoh35dXEAyIxQj3XiMw21j
	Zm/1Rugy3vC1ljpGJ2rRyBIbKQhb6EM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-634-2cMPo-MdMOOijBJMUGrrGQ-1; Thu, 27 Aug 2026 04:52:23 -0400
X-MC-Unique: 2cMPo-MdMOOijBJMUGrrGQ-1
X-Mimecast-MFC-AGG-ID: 2cMPo-MdMOOijBJMUGrrGQ_1787820742
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-47fecbb7f88so1162512f8f.0
        for <netdev@vger.kernel.org>; Thu, 27 Aug 2026 01:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1787820742; x=1788425542; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=5hJ7mZeypVJLmhRFxJYm9bHOTFShVm8RTGv547/GiLI=;
        b=ti0mge+2wPefxvEtLhEKK4dracbWY5JUUyqz18gA50kWQA5lSzOzWy3OBw9wFCQRS2
         iD3BpvnlsfDFU1p5Wtdyt45OvtH5KNMprYb1CE9WsliASizBqPCPrRgNJnZ/z7MDCimw
         FrxWmBgB3V8+t8PrdLKBGTiXZfBMW+mrkaQA8qSdRe+nvGQ+ZuiW7TwP6y+Zet0eE1gk
         Dh7LX7F9IpMKALcCV2Wt1ZBy9hi+xa0VvTSmumBVPtzb3JxyzU5IeW4XIvXQEe3gngIY
         a2qZQasE/xhKX5tvZbZf014dlkRqFRHHkiLOeWDLJGURgJsNXJYsAAhXoaCH7OCzaSJs
         V1Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787820742; x=1788425542;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5hJ7mZeypVJLmhRFxJYm9bHOTFShVm8RTGv547/GiLI=;
        b=McbTMIxtaFRNJ19gTPBtmhk7kYwGjUr5p/b2DzDIRxG/zBMUVGj3NU7n3B3ROA0JeL
         MxD3Q41Ak+bYT/9aRZYJwHCtCsxfotCOk9lFmI8Lhd662XEWOiD16HoUfguVmrxZv3Ks
         hrgS5TGyMVgQ9sgGtU1AC97sVXn7Y9rt2pRlh1KBs8baNw0KoW8cMmrYW0hA6RdQd75g
         iFowA9/4TMIhXY+qe9uBYD2/+jxrxWBtWhefJlv3Z0d3ZKVKhb5hExay4LWDaiefU3jS
         ZTcAZowqpxSGNxfz6fcgrCG+T64M2cQZex263iwtEqd+Rw/yXsSjBiLt/cdQwGmTcHfN
         mOIQ==
X-Forwarded-Encrypted: i=1; AHgh+Rr7YKEwnXI2f4Zxz1BjjUcZsToeOgDCiTyhT4uHphb+k/RCtjcO/jN6vICFs3PvEzHI9fzqzF4=@vger.kernel.org
X-Gm-Message-State: AFuF++nA7qPcDBVUfbmplGdVG39sutzfnvp/cdtaSdBzbdMSdB/RrO0v
	m0z1XhbePtEe9Aa7Q+oC7J/VpsdW6IrIzOIN6E5FTmWdBwebIwr1bkQB50Qlky1jyEP+6YMxzZM
	oTRGSc573oMqvSwBwylBNLyeuDCkCRdvCSI24SYoN7JeACYmAAIFv1vYT9A==
X-Gm-Gg: AR+sD11dnbWslu4l2wjEwMK0WABV7aka5PemGjSPm9mcd5R2qh+I4w0Qddicup+uqO8
	43FpPdEo+6+prFln9ad6l2r9KUgcxC0nq7hASRaN+2j1zFn40GgrHwN/IvQtmlLpF4r0hV8NhLw
	U2SZcbvGEhQ0HopYeFB+8TaVWWoIVOEDsf9AkZKX9528G1e+Mwx9Aj1gxnsBWoivw8PZGi3fxIn
	GeC7DGF7akZ/kQWjim5x06QGirvxoyr9KD2nYbtm931C7a/0T3UhpbZ9NFtiWNHrIy2fAYOVKoX
	/KHeGK9vh4YvY5Xy2r6D3LoczzriXtdPWN5jnzQIvmRHHCngCfIneyOYLgmZ37XOS/oFzi+BoyN
	XFjN3FkF2YOtmt96hOVtTI+QBCLv9lGAxDS2sPuOXG74RK8hAfUtjvhFVGUB6HK3wiZ4+eHY=
X-Received: by 2002:a5d:4f82:0:b0:482:e263:2c7e with SMTP id ffacd0b85a97d-482e26de754mr13993877f8f.13.1787820742493;
        Thu, 27 Aug 2026 01:52:22 -0700 (PDT)
X-Received: by 2002:a5d:4f82:0:b0:482:e263:2c7e with SMTP id ffacd0b85a97d-482e26de754mr13993819f8f.13.1787820742077;
        Thu, 27 Aug 2026 01:52:22 -0700 (PDT)
Received: from [192.168.188.103] (ip46-47-231-195.pool-bba.aruba.it. [195.231.47.46])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482e279ecaesm7707204f8f.6.2026.08.27.01.52.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Aug 2026 01:52:20 -0700 (PDT)
Message-ID: <18d43f38-ad3c-4e1e-b313-dd3b64fe02c3@redhat.com>
Date: Thu, 27 Aug 2026 10:52:19 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/2] net: macb: exclude software FCS from TX byte
 statistics
To: Nicolai Buchwitz <nb@tipi-net.de>, =?UTF-8?Q?Th=C3=A9o_Lebrun?=
 <theo.lebrun@bootlin.com>
Cc: Conor Dooley <conor.dooley@microchip.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 Jonathan Bell <jonathan@raspberrypi.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Richard Cochran <richardcochran@gmail.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260824134703.766708-1-nb@tipi-net.de>
 <20260824134703.766708-2-nb@tipi-net.de>
 <d1f02ab923c0464fa73cafa75a21943d@tipi-net.de>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <d1f02ab923c0464fa73cafa75a21943d@tipi-net.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/25/26 5:04 PM, Nicolai Buchwitz wrote:
> Replying to netdev's sashiko
> https://netdev-ai.bots.linux.dev/sashiko/#/message/20260824134703.766708-2-nb%40tipi-net.de:

It looks like you instead replied to the comments from:

https://sashiko.dev/#/patchset/20260824134703.766708-1-nb%40tipi-net.de

Note that our reference saskiko instance is actually the one you
pointed to above, even if the comments are at as slightly different
URL:

https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260824134703.766708-1-nb%40tipi-net.de

Also note that pre-existing issue should (usually) not be addressed
in the same patchset (unless really bad/exploitable).

Finally I have some concerns WRT patch 2/2: it should bring a
significant performance regression, and the frames transmitted ATM are
still valid (even if 'downgraded' csum wise). It would probably be good
to provide some priv flag to enable/disable such behavior.

I guess some/most users would prefer send 1 frame out of 64K with csum
validation unexpectedly disabled than hit a huge slowdown.

/P

