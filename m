Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793825829;
	b=i89AU0aqfb1P5+OPkbLUc1JcSHu5bV2DCLFBjQhV3Z+WJ0PW32GUIksPZ67S8BudxJlY
	 PNt62wkLGyoWtUJ4J+twYnVYXhqz2Pr/rkNT3y9jWXpLM4UR2h/iE/4MdxKrpASXCfjXo
	 t7jJp0q1vuTvnm7bOjoxvueD0XmB76neZspJFZi/JU7mrbOtwgB5e+/1vsFJjuoWXKurk
	 5ZZTo4d0Kb+t9zfIPZuas11+QPt5J2zVXBuCK1Xz2BLL0xqd8FYykwPzeKezmytnQ5OeM
	 vWsfdjoHFUMf0nd0Fzdmt6uGVPqpfxeidI5xHTpaHicRy4N5fhcZIJFG7Nr8veIXLpA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793825829;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=L6s4TTDFhNuhrsnjNiQdR7CRo6Dzt3ANt515Ib4703k=;
	b=CsfXChdSkqCgjC7zm8yDQQAs3WnXdztvzrb0FlAujlfXCnVvXy2f99/U7u6/x6r960NI
	 EU/t34XjYKQIWhimFfoXR1y3LsGtiGqlMHZiSp7JfHZc2sz3uBS7q6pp2e19ylXr+3JRu
	 YpME34Sc1RXVG0gD3JNqcIGpBEdHij1BywEmRPjp+d9vG8QbHvMGCN/ao8OxiDYmM7zAt
	 zYMUnqpMxiaS3BBkMy8G/nUpAVOYRdZ104iXTiQ/ixxjGmRYtpbc81q3TynZbBmepypIn
	 XWPNAxu3VexaaqCqQTGsPFz+9i24/R28e4kKuBEBapRC4AYuKoad0pn6lw1NWIV+MFw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=JpQXbB51;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b="XSX/+KDj";
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38B77609C040
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 20:57:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 38B77609C040
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=JpQXbB51;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=XSX/+KDj
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793825828;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L6s4TTDFhNuhrsnjNiQdR7CRo6Dzt3ANt515Ib4703k=;
	b=JpQXbB51eC4YbxGNr9rbAouwt3QYNfrCjZ/I/rBkSNiPGjHTFm3CUkzLCkVs8B4SAI3TW/
	zS50odUCKCLHEmB+ula1gQyqX0QWOnbNt9NAuNCUpODBvYO04vEt59E4b6dyFznJBVwxeJ
	w28ISCMVVJ3IB5HVk1GTTBL8ZrvTgF8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-140-CYCa8vCzOma5f2k98KfLyg-1; Wed, 04 Nov 2026 15:57:04 -0500
X-MC-Unique: CYCa8vCzOma5f2k98KfLyg-1
X-Mimecast-MFC-AGG-ID: CYCa8vCzOma5f2k98KfLyg_1793825823
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4ae2756fa7aso8344105e9.0
        for <netdev@vger.kernel.org>; Wed, 04 Nov 2026 12:57:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793825823; x=1794430623; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=L6s4TTDFhNuhrsnjNiQdR7CRo6Dzt3ANt515Ib4703k=;
        b=XSX/+KDj/myjMKCt2zt9+q5XUkJPNGNbEYPReBac0xi4QN/9krLLkG6WmCr8vG4ul/
         j8HcJRcZkfGP20Y7nxlFEbUQAOpkfzwDNYvkrtjkzdmvcnwPb0i3NCmRN55yE3CPUdqX
         OGvpn9ShgiEuPmfOc7nXiV+YpnVZrmdv04IqqlrU0s4Wxlk3ruUtvCNKgeN0nHZQ94P9
         VIRjdf+2CEheb/ypMc+13Qawscq/kgtL/dwI1Us72aC0BlIgKin+KlFy7T7wi0quhNLW
         zEaL28CtRdFvROdLKe3w+M0JHWUJ5JohBgl23zl92CQOT2xlqm1gtQBnFGUuOi2AYtHd
         IwDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793825823; x=1794430623;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=L6s4TTDFhNuhrsnjNiQdR7CRo6Dzt3ANt515Ib4703k=;
        b=yF/Ooy8YWd/iWJIojCAN26W6hv/eA0aVTNzhUEj/YOOuFcIU+LjdeeyEtjLyj8neEC
         iPvg0jscGuIcUq09nWEUbN8iIl40XcgTOd13NfQKatnTI8iNl066cWdxtWq8ze1v6zEk
         sRHDIZ+i2Dx2d3SAjkkL60rUrFzv6FxT9Y99/DHPUcYrnc/zsZPONJs8D4OvnTXRPC8z
         r+XgYFGTch8iNeoOX3s0Q1jVjfvbF0tUHrxQRxBS9z9W2xzm9CJNVvliWynvqnXYFuaL
         YB7ZujdJZ6JKgYjjYUlpM4LkRsd1N5gZuL5G8tAIvA9B3Y00zgDBFmJxypdm2lgzOuAw
         6K+w==
X-Forwarded-Encrypted: i=1; AKwUvBy1st07ozNIoJLEU0b56NjsNIklbVpDbsMCVjZdNTvtceXAQRHt3ZAKLZ6W1g+OYEH+1mhwpCY=@vger.kernel.org
X-Gm-Message-State: APuU4Z8PQcJcQdZPRNEBc4NEsPJBmUVnEGt/sT9pbJjQfzFk/oQIdJ29
	7wYUXsPdHqP5bwsO2rlGnRoFIoKyHwPmNnbBIfFyll3Pxdt1mX0kLz7vIf8WfcoyVj6c/KqwWhM
	Oopgbfz7XnFl1WwMXOgbxCxzfuelw5ACYkuV21FaP/lOVOJSqi6TUokepvA==
X-Gm-Gg: AYBFou3nyiyh4AFk2PUeRqYvnhTfPjH0ef4zm2k0bCeV1UJ//lnBdKCArEs8mSs577I
	Ietq/Ep1/ebtnz9CPEbHpSq1Vv2UJ6zB6491A7SqJgxkH0W3dYuPJCXnQx6xuYjizK/IXDi7xa3
	FnDQjPgNh9Dbz660bDoDA/ab0QmDPiLjCjm+J4HO87vNIqwh3Jelur8w+dJ7sl6R9+1CX4j1Ruz
	UIUCY3qLUSOz1itD+1MPv+ep6ko/G+ZbzEtpF1r5AKasHqnqKF50zAA4jBYBX+v2X/+t/vlLC10
	t2LTkJgW1vNDqmO48BGTtoBDn1rehXD6u1/0EghRETOq7IeVyglfAGsY+zxVw0V+Dd6IvNggLMf
	gyGnj+TOQWmbzdlFDDG9wPq4eytAPbFrVr4ymJCyLn4ewCRvI+RDae+HmrRz7d6knvBRxSZ0LjE
	9jWfpcUTE6uEL5+Ty3W2DTIu1cuRen89JMkbWfnSz5nXI=
X-Received: by 2002:a05:600c:8b55:b0:4a1:f736:79f3 with SMTP id 5b1f17b1804b1-4ac17ffb30fmr374653945e9.5.1793825823519;
        Wed, 04 Nov 2026 12:57:03 -0800 (PST)
X-Received: by 2002:a05:600c:8b55:b0:4a1:f736:79f3 with SMTP id 5b1f17b1804b1-4ac17ffb30fmr374653795e9.5.1793825823110;
        Wed, 04 Nov 2026 12:57:03 -0800 (PST)
Received: from [192.168.88.30] (ip231-128-192-82.pool-bba.aruba.it. [82.192.128.231])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b56b78d656sm12312525e9.0.2026.11.04.12.57.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Nov 2026 12:57:01 -0800 (PST)
Message-ID: <c9ef3133-856f-4554-8c7f-0f49d364c617@redhat.com>
Date: Wed, 4 Nov 2026 21:57:00 +0100
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3] net: usb: cdc_ncm: reject short
 GET_NTB_PARAMETERS responses
To: Xinsheng Zhu <xinsheng.zhu.ny@gmail.com>, netdev@vger.kernel.org
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, oliver@neukum.org
References: <20261102001114.38144-1-xinsheng.zhu.ny@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20261102001114.38144-1-xinsheng.zhu.ny@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/2/26 01:11, Xinsheng Zhu wrote:
> usbnet_read_cmd() returns the actual transfer length, but cdc_ncm_init()
> only checks for negative errors when reading the NTB parameters. A short
> response therefore leaves the missing bytes zero-filled, and
> initialization continues with parameters that were not supplied by the
> device.
> 
> CDC NCM 1.1, section 7.2.1, Table 7-3 defines a 28-byte NTB parameter
> structure. The pre-errata structure also contains 28 bytes: NCM 1.0
> Errata 1, Issue K.
> 
> Require GET_NTB_PARAMETERS to return the complete structure before
> continuing initialization. Return -EIO for short responses, including
> zero-length responses, and preserve negative errors from
> usbnet_read_cmd().
> 
> The issue is theoretical and was found by manual inspection of
> usbnet_read_cmd() callers with LLM assistance.
> 
> Signed-off-by: Xinsheng Zhu <xinsheng.zhu.ny@gmail.com>
Sashiko noted on v2 that this may cause regression:

https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261011035150.53315-1-xinsheng.zhu.ny@gmail.com

Since thei issue is theoretical I think we are better off without
this change.

/P

