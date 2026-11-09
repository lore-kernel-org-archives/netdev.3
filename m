Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794239513;
	b=FN2A3ygfwe8/eOwdkKlhbSAKYsJKJt7SDL6jMrEP3WG2sAvs5wKRbKtNFA5vzWyW19jo
	 rgz4NkFe0rgc/P8B9a7JQzdUPk20YRnMxp5qcRcUBfDaVYbGT9ta+FhJRlAEZ1Gv1SI4V
	 fA1BJoOepliTh37elY9a0aYULw6iYxZfFmJaCmiRyF+gXCjJP5P8lqHM6pxIA9kRiD96p
	 ZCXiw04belP5+jRpMPEubxRqvgC9a4bVGKSUNPl0x08xeav64E3lqsl/eifw6U6Oi3UvB
	 aWJpyalntX7VMvClRx1KoOC6L5eySwxrcEUyCuOfgg6A6irvxUR84+0Ovbh68Ser2Cw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794239513;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:Cc:References:
	 Content-Language:To:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=GqcUVOE8YZm1FPDzDze4+rCKgn8rK0xiBVztztTok30=;
	b=zWL4JSf98Rb3E5s8b3grcO9bnrlbbf07w+SztAdtVb4BokDOrNd2dHbbzNRCDAeaBJmx
	 rbhGIdGQDKBQH2xfGfgq7IFu8I80azRBpcz4Fc45cZzir7ADuvsa5rYgXKOdbu6LX3JKp
	 Od4ZXv+yIjrvo6KWK7qtzNazxURiqqPX61MvRahWJZHDiJn+thrD2QsxDIwdWbYpCHpXL
	 MY/Jp7Fvzcs33xz7Cq3aXmc4tp98ZQ0tLaANU+0CL0XVvgP0z627niR14ANNbUcVJ/vqq
	 5jaijZSW/qjxYcUnsf3Zg4/xeGshOvgZQGk2oaAY4qLX7WMWv7v+k88e+YGl7CY+dww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.com;
	spf=pass smtp.mailfrom=suse.com;
	dkim=pass header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=I6Gf+TJ+;
	arc=none smtp.remote-ip=209.85.221.50
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3D5F606A335
	for <netdev@vger.kernel.org>; Mon,  9 Nov 2026 15:51:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E3D5F606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=I6Gf+TJ+
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-48e10a70540so647612f8f.1
        for <netdev@vger.kernel.org>; Mon, 09 Nov 2026 07:51:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1794239511; x=1794844311; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:to
         :content-language:references:cc:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=GqcUVOE8YZm1FPDzDze4+rCKgn8rK0xiBVztztTok30=;
        b=I6Gf+TJ+xx28C6M6wGa7IriJIxP64CATq5xKa5KY4/dVEF70L68u8oNbC3qDhkhEI7
         7ia14iP5TbkPq0pUWtgTMNnR57unFzAtVelBZ6VlJdQ4CrgVYgxw4RobiXpnUn7hkB+D
         nzTyACD0+MFjBaqWPAWXlFUgKFrj/LJmZ6fQQvFA0wYX9Z+YdDx7xP/wSzXM8J7jhI3Y
         cnv1opUi8bNDC5CGiUC5RyhE5sufSwg94ps4g0+w/MIT3GHEM+nHtCTD6yBD+zcjVMzC
         KM6SnUFC/LBhWAJoh5/3RAr1pEMN+dTTDdPPEWzL92kIaF0QNP3pX9QYFDhi6xIlcLq5
         xWjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794239511; x=1794844311;
        h=content-transfer-encoding:content-type:in-reply-to:from:to
         :content-language:references:cc:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GqcUVOE8YZm1FPDzDze4+rCKgn8rK0xiBVztztTok30=;
        b=r2WmMeIW7bGilwnjNeLY4cpHs0wzNWtBtebkWBFgt8doyYI9WZIsfgSKnHbVB9qCYR
         xgoPbqpdblISQQBQKessdB/FlK0gla/UZyVmnNbuIb2qLjSE751qzlM3UjS8ZDueVHv0
         QJfFx2jrVyGgjJv3iaJRFCQoIIVp0UXx0j+sKcuICSsvO5rto6QG9aPlP3CgcZSeoGW/
         XUe44BxkaOzkjEuJvNbYhA4cZlnfcuwfe5XlO7JZuLZaVl0U+n1upa4iEquqEk/AM3A/
         cU7w/52kUkVQgJKhynoOrHn48Yspr+EeaZRdvvmT8U3RxLvBt8zuDikxTVuG6p7YFyYa
         pknw==
X-Forwarded-Encrypted: i=1; AL+hErGJDoUpnTp0qbC4wte2NvKjKiSOWSNInHn3tPIOeyJ+6iLzLmLNqLTXPdnMZdMTOXumrkHn1tI=@vger.kernel.org
X-Gm-Message-State: APuU4Z+qCay2GZTrsrtSnSJuNLGU57sVMLFlwXTbC5CC8m1qPId61sz3
	V3Ab+wu7iYjk/gckp+9bVsGU0lWWewgAn2jR9Y3Aj8YBqvNtY5nqZI15//AkLKFazxE=
X-Gm-Gg: AYBFou1Dg1RWNinYDR1H13qNHpTZAyVWFz8RWZ1O+rGx1Ou9Q8px7V43mzPnoI1Sfek
	yCozqutXCWo5eDPhQmrEB16lXqOLrKuqOUO0GGxURGlSRnJGbZo48Ob3vVkFkNXCab/IsiER94M
	jtRAeaHH3imp/HriwK3l/FfUCCAkNWRwCyAXWX1BsoEMqZOY9a1HhK6BVFD2n4AfpOnx2aI1HLS
	UTGCMiho9Z6bMfMWRprwKHwEoQks/rRIf5XeoM58rs4jX4Bq6+4zr9+JFrBPhlRdbU0088XBDq7
	DRKL+nOsU0QfDlDf9SLgTQTVXA9CMNl0bWwulAjwYaQaZUs0tNSTFydB1AUJjTdXkFXhJmtfmEb
	jBbPqa60HX79MhPf6KR50uayvsQuefZWFs0qaiqRU0yCjytadEKc3ltedYpgRJI648OmkOM3M+C
	mjGGtjWjRexCG2WJmynS6ziJY7S9hFR4MUSONbpAUoOLlgyxCb8BKHqYKrK5ECy2kdanJlqIryp
	5/VK9GRiMUQsaoEf9YamiOLV4du+nQdCOLLL220x6uopb4jMFeao3zET08Ux0rD8tSdVfW5iMWi
	+01o6wq2HPOpzdF6RCqfXXkYm/yTuwXv6Wz8cAnCQwCI/gl7+2uvno83c4b2U4J1
X-Received: by 2002:a05:6000:25f5:b0:492:e1a6:90eb with SMTP id ffacd0b85a97d-49582e8e516mr8245452f8f.10.1794239511204;
        Mon, 09 Nov 2026 07:51:51 -0800 (PST)
Received: from ?IPV6:2a07:de40:8100:0:89a9:fd0e:583d:4a53? ([2001:af0:8000:1409:193:86:92:181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49597186eb9sm10435718f8f.35.2026.11.09.07.51.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Nov 2026 07:51:50 -0800 (PST)
Message-ID: <a190f981-d668-4208-8148-f4e50adb31a6@suse.com>
Date: Mon, 9 Nov 2026 16:51:48 +0100
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
Subject: Re: [PATCH v2 0/3] Remove obsolete __MODULE_STRING()
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
 Guenter Roeck <linux@roeck-us.net>, Ian Abbott <abbotti@mev.co.uk>,
 H Hartley Sweeten <hsweeten@visionengravers.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rudolf Marek <r.marek@assembler.cz>, Andi Shyti <andi.shyti@kernel.org>,
 Chris Snook <chris.snook@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 =?UTF-8?Q?Marek_Beh=C3=BAn?= <kabel@kernel.org>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Andreas Noever <andreas.noever@gmail.com>,
 Mika Westerberg <westeri@kernel.org>, Yehezkel Bernat
 <YehezkelShB@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, Duncan Sands <duncan.sands@free.fr>,
 Chas Williams <3chas3@gmail.com>, Luis Chamberlain <mcgrof@kernel.org>,
 Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>,
 Aaron Tomlin <atomlin@atomlin.com>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>,
 linux-watchdog@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-hwmon@vger.kernel.org, linux-i2c@vger.kernel.org,
 netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
 linux-rtc@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-serial@vger.kernel.org, linux-atm-general@lists.sourceforge.net,
 linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261002-module-string-v2-0-fc7438acaf4d@suse.com>
 <2e88806e-57dd-47e0-a9ef-a8507d22aa3e@suse.com>
Content-Language: en-US
To: Petr Pavlu <petr.pavlu@suse.com>
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <2e88806e-57dd-47e0-a9ef-a8507d22aa3e@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/14/26 11:36 AM, Petr Pavlu wrote:
> On 10/2/26 10:31 AM, Petr Pavlu wrote:
>> __MODULE_STRING() has been an alias for __stringify() since "[PATCH]
>> MODULE_PARM support for older modules" [1] in 2002-12. That change also
>> moved it to the graveyard section at the end of linux/module.h
>>
>> Replace the remaining uses of __MODULE_STRING() with __stringify() and
>> remove the macro.
>>
>> Apologies for the wide distribution. Acked-bys are appreciated.
>>
>> [1] https://git.kernel.org/tglx/history/c/136839a1b4
> 
> I've queued the second patch ("drivers: Replace __MODULE_STRING() with
> __stringify()") on modules-next for v7.4-rc1. Thanks for the Acked-byes
> and reviews.
> 
> The first patch ("hwmon: Replace __MODULE_STRING() with __stringify()")
> should go through the hwmon tree. Once these changes are in mainline,
> I plan to pick up the final patch ("module: Remove obsolete
> __MODULE_STRING()").

v7.4-rc1 no longer contains any __MODULE_STRING() calls, so I've queued
the final removal in patch 3 on modules-next for 7.5-rc1.

-- Petr
