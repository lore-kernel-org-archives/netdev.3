Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6495E357D17
	for <netdev@vger.kernel.org>; Fri, 22 May 2026 04:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779425727; cv=none; b=ZqHPcV+nRtffsiapKay4Pgl7CWMPmUQobHKKOHt7L6xBXlDu4itJbTMXan4aspqKK4JwHA60kq+egPWXz3ptljjSqTBkFoLkMeH01/KrDsEVd3GBswTHh2eC4UbPINDySJ74GurVZ9Fm2+gteekF6DoXiyy0/bQ5zBnnfw6wSjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779425727; c=relaxed/simple;
	bh=B9CAhNAdGTp5Zt5LCmbUDLKXezoz9dQvKZMGvVbfxrs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V9+gCVj4IoPXGGKmhNTXcSI9mQSHhoVm54Rd4TQuHpE2sT+01IouSh4gDBjXkET8B4afYhAs2jlOEXHxazUf3yxdclCc7kraeRGUOuykgP0sCYNfFnfa7ViXsP9C3PvuctTBtacOyC/bvLa7GDWc77AmlMdLplIUYRL/Lyh+oQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GbeIv5MT; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GbeIv5MT"
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5aa2d5a1d51so1060197e87.3
        for <netdev@vger.kernel.org>; Thu, 21 May 2026 21:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779425724; x=1780030524; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2uaBSQpnXDZ0Lr2vqL2X8w5SaBUCpNSkuNqugybr2/A=;
        b=GbeIv5MTw2u/PaO2jrKBK2QR0+f6vbEfqatUpYeF/bCRKRhpq6G8Yn6bHVqyKbI1nO
         6aflGJoaJ4FzfLZN2vCoCXevRZkYXwZ0ohRvtIJXvxt2FB4+k9M4FpvxB9W3y197bLcX
         jzZOqcdFQ6HV/axNzl0q6d65TSOGZM1FYwEzSzmHuAQfon6HxozChLLd9/L69PZ6wO+o
         BkUjjOuiW5GpBTuadz6fKqNuP3bZ2aGwkn2/iHq1LfFsfqp/JKOnGWjKayLekJ9Bk1L2
         iKO/ICx3ULCTvLSVIqiJXbMEUeDgTJ6tlBe24etov6zbxICSiBCXgQ+LB7PjnK3fwgt5
         V9lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779425724; x=1780030524;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2uaBSQpnXDZ0Lr2vqL2X8w5SaBUCpNSkuNqugybr2/A=;
        b=lks8YfQ0pJuPgKHCPapj1r/oc7YM7LigkShKh5NQP62vlwHJoQ34Er1B7M8phdKlqL
         FmV4BKRyrNnZwdD5Xjr9vMs9XDJQeD6ggKiIrAbd6mdtlz5g7FLGixc+OaWjkDGdKuEX
         ZjIVulPaUu5mQLvB/lLUaP+bDfFk4i5xVICc0uWP70xWXlM90AhtnDN97wTPP2uSUqnQ
         OKcf9FMPqG5AVJ1baO7M1uMh+YXGphfoYJQEldpeG7yoEBBhvkEP+WcU2mQkdI+bu7nl
         i6ArPd2BB84b4TfP4NGxQU3zkkpc8aunl6apKXhoVhXpK9/rZbgk4RXjjLh7irtgO0SQ
         LHuw==
X-Forwarded-Encrypted: i=1; AFNElJ9uQLUnNBx2EYz71TzxFkM6M4JCcoCLdxUxjaVwY1xT8piesTl2qmMgmBLetMzWXRPM3TPllMo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRJ+zMpr9B84i8LCxuAU3EdY3eGyKmPRPd1YfqIv5hRS4kWXOx
	F5YUUNJd+SDx3FdLFN6Y5yYn1Mz36rnBcrPKubXH6TydlwXxOw1/TRLV
X-Gm-Gg: Acq92OEHMAzm1/4nv7mX1xlqJJqjxVUc/3k3hwo/gkpnOfIb4/nTgWA5aisOhGxggsM
	HcKYZbAzPv+j26EtOE8lAlXSOOjHiZpaF1sMgYKeuRlEYiD/RQheuNVFefOJsb7QL8+g93GM8eg
	EkY5FO6hU7/2jttZJRHeJLv13eZWScNkL1obcIBsmg/gF98B/kG7A0KJOPOAdXz4xLbaJVGXbFL
	kI5Fb4ZNp4S8WHCuBi9ufKKJlrcXiEl44vCryslCqZUNdFN+ZIY8OoPuSjadm0qXa/Y09C+C4lA
	EJaBrI6aFrzysxD6Cyw+L5ai4u1EvFV6oWX4l+f9T5igWVFfiskwKX7ZtHWKIKsAeYxtV1RLsUH
	UtiFofIplvXor6k3huenPZ6iFqW8/kLnvvzIiLSyylJEWpJ4dUamf1mNtq/OxxlTt1uCiFBRp5V
	aOECDtL6erG2WapOUDDk555yz/0t4laJehlYxMqrHP4hA5hXdQF/aNexVnOHHV/ssp/2EIfE6S1
	pJ1mU7EDnMjtNVBx0g=
X-Received: by 2002:a05:6512:2552:b0:5a8:9988:f1d5 with SMTP id 2adb3069b0e04-5aa323bc03emr387730e87.24.1779425723236;
        Thu, 21 May 2026 21:55:23 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aa32cb36d2sm144533e87.13.2026.05.21.21.55.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 May 2026 21:55:22 -0700 (PDT)
Message-ID: <b79d8ad9-f36e-4769-9dc2-58baefe23000@gmail.com>
Date: Fri, 22 May 2026 07:55:19 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/10] [v3] input: gpio-keys: make legacy gpiolib optional
To: Arnd Bergmann <arnd@kernel.org>, linux-gpio@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
 Christian Lamparter <chunkeey@googlemail.com>,
 Johannes Berg <johannes@sipsolutions.net>,
 Aaro Koskinen <aaro.koskinen@iki.fi>, Andreas Kemnade
 <andreas@kemnade.info>, Kevin Hilman <khilman@baylibre.com>,
 Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Lee Jones <lee@kernel.org>,
 Pavel Machek <pavel@kernel.org>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Jonas Gorski <jonas.gorski@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
 Vladimir Oltean <olteanv@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 linux-wireless@vger.kernel.org, linux-omap@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
 linux-sh@vger.kernel.org, linux-input@vger.kernel.org,
 linux-leds@vger.kernel.org, netdev@vger.kernel.org
References: <20260520183815.2510387-1-arnd@kernel.org>
 <20260520183815.2510387-3-arnd@kernel.org>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20260520183815.2510387-3-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 20/05/2026 21:38, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Most users of gpio-keys and gpio-keys-polled use modern gpiolib
> interfaces, but there are still number of ancient sh, arm32 and x86
> machines that have never been converted.
> 
> Add an #ifdef block for the parts of the driver that are only used on
> those legacy machines.
> 
> The two Rohm PMIC drivers use a gpio-keys device without an actual GPIO,
> passing an IRQ number instead. In order to keep this working both with
> and with CONFIG_GPIOLIB_LEGACY, change the gpio-keys driver to ignore
> the gpio number if an IRQ is passed.
> 
> Link: https://lore.kernel.org/all/b3c94552-c104-42e3-be15-7e8362e8039e@gmail.com/
> Link: https://lore.kernel.org/all/afJXG4_rtaj3l2Dk@google.com/
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> v3: resend
> v2: skip the fake GPIO number passing from mfd
> 
> The removal of the arm platforms using this is not yet going to happen
> for 7.2, and Dmitry's changes for the Rohm drivers have not yet
> made it into linux-next as of 2026-05-20, so for the moment I
> would still like to see this patch get merged, even if we are
> closing in on completely removing the legacy gpio support in
> the gpio_keys driver, so we can make CONFIG_GPIOLIB_LEGACY
> default-disabled sooner.

I am (still) all fine with this, even though I like Dmitry's set. I 
suppose you already have a plan for merging this, but I still have to 
ask - why the MFD changes aren't in own patch? I feel it would have 
simplified merging, backporting, reviewing and reverting if needed.

Well, other than that:

Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>

Yours,
	-- Matti

---
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~
