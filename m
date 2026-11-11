Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.181
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794419371;
	b=4pUohFX6zUw6XumVek7YE2ZPtwvRgUUdRYQv00Tq3GsrzzcgaBNz1kBLZ4IKjU4b06b3
	 mphtV8QiNucGT8uptRiNHqxLQtN6VKyZPxRjNoiideDTXLlkSgc8SJdfTrd1B5V/zLdv5
	 d0f4hmzvfxZNu/v3r1w7WJZzEwUYfY6/lLjE2DW++8YTwywNvSvYaCt/EG7mp2HacC1h3
	 pbSFDOcUGKGm2yQj7n9A8NWl2A17PD/UQyM+Csw4tfQYXcvmSxEEtZ+fSyMJPqcElv4rG
	 8soMpGYmuvYap6F2kC7MW7fTCzrCwruUvpxPeP0tLpbUaXmHindXXMnHnUASleqBUgQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794419371;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=P0LlEVmtKbYkhBHowVJUvrAVEwB7x6mCjbop+wAsjGs=;
	b=U/NeOWeQbbpujdmT1L5HUdw+A2PvDf2h4QVAWrZLzs0V+8yWo8rtzB37wGYJ6hSiLUry
	 7NgMiQUCzqDOEm5MB+PMXd1x1gKP1XFKOZ6c4hTuZWK4mOnmMZg1mvTqcUvrKXohpRw3L
	 jAnjHoQvPiFHsgE2LY6CeFzUeKq7YW7PASCn/oYe0FNz5F7boKelt/BN8AR4IouK4mbMk
	 5DbXbbly/0oYjmrf0T3CSmT91yYldnFDikY/HC0Ow4WqrBppWQk6/KVH/Jia39hRXoQ+i
	 ki4qMtfBL+wxU8D3yJSSa0wL4Z5fDoMd6attxU7vLRCSjiyZZNRH7vVXNCx7uPi9qMA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WmWdrLTA;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.181
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB380606A326
	for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 17:49:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DB380606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WmWdrLTA
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-36f8cdd30beso6052480eec.1
        for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 09:49:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794419370; cv=none;
        d=google.com; s=arc-20260327;
        b=OgVwjLvWPMFy7o904n0rQKRqrQQWLbKAEQKWaPUAOhahjVeqBfkzGHXNkdIqba/IYG
         cZuMazrJJ68u5jJ0qXw1NYv8A3cUW3K1oI7Wvp02Q6L8kTs0Fk42k8OgANSHnFFf+FxA
         JWdFuM3UEhYpnA2AclzyrYvnLCz+LM3FFAzfmn3klfWbTz3IXrSQSIo+w/xqFlz1fWSP
         jJuepfcBisHPAPKSz+j4b1QzwZ+NimxoJhBLeuFKgWsxiyJbMBXWLBw4+WE6+rddz6Qz
         QP/hy/rBWnpTBcBI19pBwnHGJa7D0HSXgrIhATFBD1P225W8c0BkvjOTocZwVCtBFT7g
         yEmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=P0LlEVmtKbYkhBHowVJUvrAVEwB7x6mCjbop+wAsjGs=;
        fh=8TervKm/UygvXj/lqpXNyeI3EFOp1Xl0VH3IJy6lsjo=;
        b=JgsMHDFGAEHsdo8d59/Q2zAaR63hwQmRGFSL1RCXgfJ5FzzFs1V40alCEYvmUukbrK
         F90hFK7hHdx9teCyY5oVvklctdBGAJ1Oe5hWNYDGMFYohl7xhTWPzKUqzv2jAgIito5K
         KD2LSttY3I4tPH4xp0q+Eq0Xx/UD1SeL4KfYIbIl+GC2lb6olTqCkU8+dpyqhn0IpS/t
         iqAepWZiyC9yVHREbkEMbQYnf+Y/HCs6RqHwZboWsOaXwSA33GcJ20cE0JWtSSfGLhgM
         XBYKYf4X99jDxc5El019vWGat1UXKmQnvYF2rgUBRrPrlVBJ32DTNR4rENP8o8tMkRCX
         0zFw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794419370; x=1795024170; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=P0LlEVmtKbYkhBHowVJUvrAVEwB7x6mCjbop+wAsjGs=;
        b=WmWdrLTAMz51OJvfqBlkxREe8w5ZZlX9pq5Mjk5ePhW52XUz38wj54Wyp/6Cr+DzGx
         JE+M3cZnUA7GzUAg9Mh11pxcBWfvK8CNRumwG+ZBobsrVgMVIhNFrioxpuuNf611MGW7
         M/9qJ5zDbvTzNUbDPk5V4iaDpMjLnici/uUiv5ZleuEg0UHmdhIDV2GKxkU8+12wPyr5
         E5xPiVS+YqxcGj9LWIPoOdIkVgnjzm4LBAupubZHdmjcSeDd6e4k4H00WJsHnKyUW8Qu
         7L6pqAG2oymoUQuCLLlGG4XYXywN7E4TsjOwfyhs0yMcG1W1y9TlGPeW6JUpjOVrSddl
         M79Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794419370; x=1795024170;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=P0LlEVmtKbYkhBHowVJUvrAVEwB7x6mCjbop+wAsjGs=;
        b=NV+Y1IfTpkAmrAW75ocz/KVW1N7mXJT77bqaP4LV0KhHSMJYbjq/XkTsCdQ9OXJrbx
         jRqiVhmAGFODKvo9PtifTInwoxrYVxJz3elcV3NsvnHA7xNajgUOxjs9o+JIwH+pmQJp
         j88k1UqFEmn/0oAhhjUoOOj8JOcEbHfi5bII/63qOL3Ep2EyjT3FuLubekCcktctXjcG
         atcYBRK1Nw+IADQML4Ed/3ZRsSFwQk95mk37xVZU9ADSLxJjLsE39EiCmaIthlA6qO7H
         ErCsoxMZAID5zVWmkTI8WssDY4uPxwTGPoiAqWjz4vEMAK8/UcDuTbNxeknAhjmx1+hI
         vSdw==
X-Forwarded-Encrypted: i=1; AL+hErHtlR7AVOiqdHC+7WwZ7B/FCzTIpSjaFdtUDGSGsUMt/VknYncfYoT5WSclme6lS3LAOvRp1sI=@vger.kernel.org
X-Gm-Message-State: APuU4Z9gxHQ6kuc8U+G7eMIOtiAl+2z96qTLKI7f0znUSCblE+lQbEhk
	ZoEj3fAIUtUk0GWHEUkitcvsRNUMhDCuDwtBv+r0OuruE7PfScnK9KRGDLe03Znf07tBCfxj1Hc
	OXSPcKJgW76z0Z8c3byO87pW6sE63LBk=
X-Gm-Gg: AYBFou2ZvZvIcE4zz6lWo+05yu36NViRQRLidA7uHebP9up0P+hMVqdp0autcxcIskX
	copXimOffzMrQXTaOJGxp2mWta3UWWQc96KbQbu1liOOnstr9UeZoCpdN+wiJU3BbhDBreaHS0q
	Pp7u03DBhUtCPsyJiAgEc0T5HHLnBSeL9RE1lJtNQirl5hhZFmnBVMAdVLrIkAPBPq3Um+asK4s
	1L+QRyZg6nJwBkdWRF26RgPOhLjloffai/a8MCEXrYzy30AawruubDHVBEnPeucobwU66K0BoUE
	rh5RhWef+QwAlsPM/gXsy0LoAB26G8anzZ+fhtlUm7DeisuHWUeZA8c/AFnziPrl4DU7WP5RRD7
	chPSKe/ohSvdu2IzeTWo89/ZrNkS/c0A4nBsPYRXpFejhXt0S49DmhdKG8O64Il6MABXyFUouBh
	/SIZzD2BGRdimhGt/pN2d1UxJQ5w==
X-Received: by 2002:a05:693c:65cf:b0:375:fb27:2c59 with SMTP id
 5a478bee46e88-376861744d2mr3628461eec.20.1794419369880; Wed, 11 Nov 2026
 09:49:29 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261111-smsc75xx-rx-fcs-v2-1-216a5f26842a@gmail.com> <e4a20579-2576-4c2e-9120-b675a175a1da@lunn.ch>
In-Reply-To: <e4a20579-2576-4c2e-9120-b675a175a1da@lunn.ch>
From: Joas Antonio <joasantonio108@gmail.com>
Date: Wed, 11 Nov 2026 14:49:17 -0300
X-Gm-Features: AclHuK9J4PRZYynpn60Trwp0oScnHBsKAesx94T00Mrc6mS2wm4jqy4_tDb4sVM
Message-ID: <CAOCBhwE84F8ZTAVXwxKEpZz06q3KvD12FkeXp6Nn+MXoUYOWfg@mail.gmail.com>
Subject: Re: [PATCH net v2] net: usb: smsc75xx: reject frames without a full
 header and FCS
To: Andrew Lunn <andrew@lunn.ch>
Cc: steve.glendinning@shawell.net, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> What is the value of FLAG_RX_ASSEMBLE in flags?

It is not set, smsc75xx_info has

        .flags = FLAG_ETHER | FLAG_SEND_ZLP | FLAG_LINK_INTR,

so usbnet counts rx_errors when smsc75xx_rx_fixup() returns 0.

> Should rx_length_errors also be incremented?

Yes, I will add that to the new check in v3.

Thanks for the review,
Joas
