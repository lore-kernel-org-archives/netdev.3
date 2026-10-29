Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793235494;
	b=yhJnfzChWqqqdypdWMO3s/iV0g2MvlyuOCwNY+Qpthi4mFI+OUMOGpCu9k1i7IrXhZ74
	 P2lhzibHTWG6bH6DR+3CHunPCC+NDADg+W2WYggnUeCEOQ2yFA7FiGYy4WbI2hZzWk+Hf
	 KCX42iq2mpcTg+DK3jvGzhZ4hLXuDdc/BOVGAgRuWP+3TnnxYRHr/j16AlIFJoAtGj6Yt
	 LxFBkOoMz/rBE9ffLLf1jqtRyDte/86tWxUMdpZmPQ3eCWYJgsptZr2latRNUvU5KV7Bz
	 fuW3eiXJbseLbR1e8R51JJbrhNtlCxnKTp6uJIncIL//6FWb6HbWrw8GDRkUkZxZ8bA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793235494;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=MGY0Rqt9U0dIYToocgg3kUF7zpT8f/idrVBwF/VTivU=;
	b=dNK7zpIzKp1+Hzd/RzPUCGpwgha8f1sMjQZV0PH5qO9CWvEoPHG476b6Rgde7BXlenoh
	 M6HyWdFhuVURT3oZLXcfsisPtywBw6I65Ndv4juiK14pEB+lPmQbPE0UYVWxzpG+K8CM3
	 lBLJEczS3TenUZNuJNm5BdGsaOzAhCN8TMDhexFABGHkyIxwOXd3kNC29CBin4sKIwNAx
	 3f2BohUVsi+CzXR0QGiE0bTG3mtJjES5gGpFjlAdCSsVDv8j2VTCP1XwM6mwMRoWkkKiS
	 JIbbxlV2ldixWsams0Ldopge5zN8qBMoxR/6gDB3MEYGAjmp7zT3pgut99bynpsFF/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rs8xIkAo;
	arc=none smtp.remote-ip=209.85.218.48
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62D22606A31C
	for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 00:58:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 62D22606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rs8xIkAo
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-c423b145922so224819966b.3
        for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 17:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793235492; x=1793840292; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MGY0Rqt9U0dIYToocgg3kUF7zpT8f/idrVBwF/VTivU=;
        b=rs8xIkAouFHDsph5jR746myyk7Bx0+LNv1CR/Wt5X62T+524n9QPun1aakHOpK2TdZ
         5DmzpUBHkUlXiNI8zoV3Jytk7K2OWDFUQhiOuU78cfX7QMlMKIHxNBXbgZaKhdp49oX8
         pkp5USBEg0p1Ghwcx97bwqO4oCdxJdXvL3rx+pSMQpObjrsh0L6Lj4/CPHRzcx1k3nxH
         EbLADyELT7y9w1Bq7jo/QwVDBh6MC4C2l7r18PKZEtpziPOgWjlOc89CK8C/aS85wJWV
         D4BBWo98f6KzussDciaxsvQAYYxC3a9GZucuChxfUz1pT0Mt6z7rio//7ffN6Li5zHY+
         WscA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793235492; x=1793840292;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=MGY0Rqt9U0dIYToocgg3kUF7zpT8f/idrVBwF/VTivU=;
        b=KAqgOLHBj+IX9xoVSeLmFaI135ZrU2ywmZY0jOkehuITmHBMqBVJYFyyao8BtD8P6n
         yGuBlIiO2pUp6+rY0/6v4oSnhOKFOg13BGW6iHy/azlI+ElsKGlGgRyCVyTcpCYtZZ6E
         12pctfKRznAPywLfzsDHplA9BL7HUumBTSzcYaEOqIFHLhMRLC5T2tigofXz0UpVtWIB
         8nAyygL4aIm++az3l/JgHy1B4Z6T/kev1dxraJVQv7ZDDqGTsmql0q0IVnWYz0f23meg
         t5A6elQyAoVwDQ4U83+QGMIxBpmGukZYWKPTLS0EEZhx0mGOmqFGSZJsj/plxlXUVAJT
         pioA==
X-Forwarded-Encrypted: i=1; AKwUvByXDx+BC5m3BIZMJ48hRcQMg+/30ch8r7+sslhv57P+wEGfAg/zJ9MypsFNCqelXysbzG8lADE=@vger.kernel.org
X-Gm-Message-State: AFq9FYJp/6xa7+vozr8v4HgVjYvi1XXFdoiUW1nmrVxocJFJiqqHT4uS
	EXKfBJ9sMCpUlmG2c54RqpHJe1wOzQxMxvgPElDgRNRafflh4ZChu0zq
X-Gm-Gg: AYBFou3N6AWWcQdHVqV4bgdNdZbKIzgBkLWfcD4BT2mX08Fd7Sie/fX9iTQU9M7745Z
	yWcBDLb6GwPk0r0PBvkRqYf5FkpgNlmwguvCeDJGYaGH6i0ek2zb6ApIHrzOKcniN2wra3/F3Q/
	Ev6a6NPSrk3Tkko/nvEL798zzttA8H4EFR0gy6tzTHbCPqp1zs2bqyruEPdxTjGH4Cb2U/DY156
	XRnclFlqyq0jsP7Urj5gDg9O4eYzXGIF/vhQ00+JoxvzulXQU96DQY3J1wVN/1EUO4Qz35Mwdcz
	4G4OZzHOJwevp8wzzCWTrxEEMCxiiJrRU3K513StacV9c7yeUtpikZC/j/IhZ0899BpnzMmKblb
	PcDnlAv7t3/55EGgGJ+hqbll55s7ypY6y+r0uvjz7qeN6XX+jcckheuDRhma6Ni9h3JGf2BkC6e
	bekZD3ad1M66s1KcZWlQaXABCgWmY8kJWsL9fMbjLbwam+/E35501Wj65i5tzbbxBQsBc564J3u
	BKDVn28ha5Xw5YAUxHn+azR0h7BnMFGx769j0nWoF2B26Dec+AfH4cAA17f/jKfhJRQtDoEzm8m
	y8OgnV9YQYjIb2LPKNYVhKn9JNvsSMz6G7lAqQD9ILjlzXo52gF9hW7l2D9ckC+VI+h+V4ay94v
	LMVhXVpMsSXBLlYWEvRNUZxvS7VkWzeIoVou93mnCdiPW48RJsLjyUDVJBMEQTiPfABowUi7ZXY
	shSHRr2WMhBJkmWtdNVaLzLe6pMsqnWymYOaFK
X-Received: by 2002:a17:907:72c3:b0:c49:b90a:988b with SMTP id a640c23a62f3a-c49bdf89bc9mr328062966b.49.1793235491600;
        Wed, 28 Oct 2026 17:58:11 -0700 (PDT)
Received: from localhost.localdomain (249-172-21-31.ftth.glasoperator.nl. [31.21.172.249])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c46bd66bd3asm668971966b.56.2026.10.28.17.58.09
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 28 Oct 2026 17:58:10 -0700 (PDT)
From: Emir Beganovic <beganovic.emir@gmail.com>
To: Birger Koblitz <mail@birger-koblitz.de>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Eric Dumazet <edumazet@kernel.org>,
	Jianhui Xu <neuromoments@gmail.com>,
	Nicolai Buchwitz <nb@tipi-net.de>,
	linux-usb@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev
Subject: Re: [PATCH net-next v19 00/13] ax88179_178a: Add support for AX88179A-based chips
Date: Thu, 29 Oct 2026 01:58:09 +0100
Message-ID: <20261029005809.19405-1-beganovic.emir@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261010-ax88179a-v19-0-7475173cfb56@birger-koblitz.de>
References: <20261010-ax88179a-v19-0-7475173cfb56@birger-koblitz.de>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Birger,

I tested v19 on a Dell DA305 USB-C adapter. It has an AX88179A
(0b95:1790, bcdDevice 0x0200, FW 1.0.7.131) behind a VIA VL822 hub,
plugged into a Dell XPS 16 (Panther Lake). The peer is an Intel I225-V
behind a switch.

I built ax88179, libphy, phylink and ax88796b as modules for a 7.2.8
kernel. v19 needed two things on that base: a4e22e9253e7 and a backport
of genphy_{read,write}_mmd_c45() from the adin1140 series.

With the current driver in configuration 1 this adapter never gets a
link ("Failed to read reg index 0x0040: -32"). With v19:

- 1000/full link with flow control
- download 940-941 Mbit/s in nine runs. Upload was 937-941 in five of
  nine and lower in the other four, and I couldn't find why. Eight
  later runs with tracing on all averaged about 932.
- 1-byte TCP request/response around 190-200 us, against about 1.46 ms
  with cdc_ncm on the same port (its default 400 us TX timer)
- switching itself to configuration 1 when the device comes up in the
  CDC configuration
- 100M and 10M links
- VLAN with rx-vlan-offload on and off, and rx-vlan-filter dropping a
  VID that isn't configured
- multicast filtering and allmulti
- suspend/resume (s2idle) and wake-on-LAN with a magic packet

Two small things I noticed:

- "Switching to vendor mode" is printed twice, once per CDC interface,
  and before the netdev is registered, so it shows up as
  "(unnamed net_device) (uninitialized)".
- After a WoL wake the link goes down and up twice within about 2.5 s,
  where a normal resume shows a single link up. It comes back fine
  either way.

I only have this one adapter, so nothing on the other chips.

Tested-by: Emir Beganovic <beganovic.emir@gmail.com>

Thanks,
Emir
