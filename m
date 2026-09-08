Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C674339386
	for <netdev@vger.kernel.org>; Tue,  8 Sep 2026 13:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788873925; cv=none; b=mVP7fLLacG506EZIOID71EOHLtuTEUsSCCnhzokj9S6x4LaYb19nRCB3TwHIsVvU9Dmtnro28Xx2CbGCsqIKjazzt9Pa2U0/+uvmfHERzN+J+GjKck9dmEAopYmCrGQcwoJje2ops6m0vEa0aW6O04LBub0vWvih7MR+LM41a2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788873925; c=relaxed/simple;
	bh=doNjk0yqnNQBRJnnu7Oiv++yMMQ2tJBZJ5rKQaLA95c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CJR1U1CdGgictbfwFw5krXQ45Sua4dJ31Sm9Eae1o2zekSiSVPvRYvzaHQ0MQnjFlRkdttGo2abrijecp9so60ziHt2tWUQuQD9N17kNiAeCEOFgdHjkn7U6NDcHmlZnBSjjPT+YlEIIKyK0xuWIMSyC5XNo7LyMwLlRUUrB5Uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cZZYCvyC; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=WlSJy4nU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cZZYCvyC";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="WlSJy4nU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788873911;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hz/K5P+rC7nHSjFEEEM9b9gZTobWQCboJgLPN/xVSyo=;
	b=cZZYCvyCkQs3Oc0lM9Ay/HapmiTJbZVPwmEkBgtPNVeKdotN7pjoyV9f9e8mOOhlw0ZfBq
	O8LGEb9ga4PZcNiloB/xlfILCLdWqry4yAH+mcWWbp8FMACoNOcHsmRYUNmcIAu2vJ59UE
	CW0ufzUyuopCgPKei4cmoR9LCOqGg/c=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-262-StnBzbF3N3KCzoveRsWVhQ-1; Tue, 08 Sep 2026 09:25:09 -0400
X-MC-Unique: StnBzbF3N3KCzoveRsWVhQ-1
X-Mimecast-MFC-AGG-ID: StnBzbF3N3KCzoveRsWVhQ_1788873909
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-4843313047eso2886619f8f.1
        for <netdev@vger.kernel.org>; Tue, 08 Sep 2026 06:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1788873909; x=1789478709; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hz/K5P+rC7nHSjFEEEM9b9gZTobWQCboJgLPN/xVSyo=;
        b=WlSJy4nUE2ZwoJeud1ZH/6MR7+18OAMj3dtB+4jSuwJQGacrpa0fgVipvLyhhLh7cs
         Yg9o3wiV47HSgzNmopKRpWDJAJvijEF6sCQZVDx5S4r4e+p1WjcOkCulVh5AUXIARbRm
         0VK02cFws5pHE9spuKcJnVCJhuY9NeGN18+NoYzDP72KxUHv4N0zkDHsz/Y1BKm0IsSN
         7YN8rG7ae5CGu4jI3Dt9XDfVf5sfMjVpCRtQXtSpR6HBDbv8w3WNMWHx0y9LkYDM7/MK
         YNfd+FUbHZs8SgE1aXAL/0YKjLWQw5s4O53mQyBCo4CXUY6nKRkNtZhiHtzWJ0yeT79U
         wn1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788873909; x=1789478709;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hz/K5P+rC7nHSjFEEEM9b9gZTobWQCboJgLPN/xVSyo=;
        b=EFmqqzwAz+GQX5lrkjhLO93/SdZ3EN0uDsdcArIS50A//8sMVVh8NDWCm80mGi3X1K
         OuS0Z/8cePxhgNGdyIl4nXhMOSszZzX6VaosrB8OuYDAfIiWq9fsMJsfs1orW09oqJOD
         JfRLKuVRG0gFLzZ8UKr5v8IKM4KE0OwoZK8lljxAeRmuWvxQlO6EW+GQbyLWQUmlGBte
         gW7gOHR7Y3zFibE3JasjmKQsI7ZV1wxgXcjIl3CD7BEKaxB15M5dlNe3gEBCfrpFuPH0
         Upk2QFWE7moaRTgRYUi9jHnYDTbaOqQHNXdA7bysCxXyldUNkVP7S/nbDHhjbqp4npsw
         N3Sw==
X-Gm-Message-State: AFuF++kwCr3gASk17MENqwl8nRSfDBzlPwLLeLi3OkHowiYzh++ER5vF
	aLy3fLAkrXS7qrD80nh+lYnAOHTm3h5U/+mgE8QRipOgdhdGzzx4kRcEitzeUjQvMJS56rwtPna
	eYLhug8MI8FE0aioFsw7UcKZ6GDAhgtqhRGRObvBGh9E9Inki0H12sPP69Q==
X-Gm-Gg: AYBFou1e5iHRjLX8U46psv8egpvpXxJE5qUJWDrHIKdBChaXBighzUixFcINl4quAgw
	Mhtz6POUmx/etDmy+3WCxZnv4jJwi9XTJlm3hWCkQTwUgOHvs7COe/kZokMg2UvNlDFD42wuvmE
	+wvsVpwQ3wV1rdygKufVTZs0o9Mtx2e/x3oZW3VAP7O5YncoYSOw9Qz9ow56t6y8ZtUC9o/G8oa
	dyGg8QeSxUxoF/2IHA5cHVw1KYIimlFiO/HASoG9Qh0OLfI7QCsLq+EsT61qiRx/Lfnu4laDZmz
	4LFG8MqOSRMImv0F9FYSHhvUPogQg5f4DoRoTXsU9d3Pu4PC7TW6U3wnDpgh3QU+BcE9CLn5UTC
	r+MBj23dWHfMc6l/mD1ABAZ2A6jnINZUhOeN1hGDR9FHWtuCE/rjV7LVX492uXkn+3D/o0AFFgg
	==
X-Received: by 2002:a05:600c:4709:b0:49c:fa21:e748 with SMTP id 5b1f17b1804b1-49cfa21e99bmr265389875e9.30.1788873908676;
        Tue, 08 Sep 2026 06:25:08 -0700 (PDT)
X-Received: by 2002:a05:600c:4709:b0:49c:fa21:e748 with SMTP id 5b1f17b1804b1-49cfa21e99bmr265389265e9.30.1788873908208;
        Tue, 08 Sep 2026 06:25:08 -0700 (PDT)
Received: from [192.168.188.218] (ip232-47-231-195.pool-bba.aruba.it. [195.231.47.232])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49d00031c95sm366226895e9.11.2026.09.08.06.25.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Sep 2026 06:25:07 -0700 (PDT)
Message-ID: <c44aaa6a-a06e-4799-872f-909e4520c966@redhat.com>
Date: Tue, 8 Sep 2026 15:25:06 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: phy: dp83867: handle the active-high LED
 polarity mode
To: Donggeun Yoo <donggeunyoo.kernel@gmail.com>, Andrew Lunn
 <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Daniel Golle <daniel@makrotopia.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260903022839.4006614-1-donggeunyoo.kernel@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260903022839.4006614-1-donggeunyoo.kernel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/3/26 4:28 AM, Donggeun Yoo wrote:
> Commit a274465cc3be ("net: phy: support 'active-high' property for PHY
> LEDs") added PHY_LED_ACTIVE_HIGH and made of_phy_led() set the matching
> bit in the modes mask when a LED node carries the 'active-high'
> property. dp83867 was not part of that series.
> 
> dp83867_led_polarity_set() only recognizes PHY_LED_ACTIVE_LOW, so
> PHY_LED_ACTIVE_HIGH falls through to the default case and returns -EINVAL.
> of_phy_led() propagates the error, of_phy_leds() drops the LEDs registered
> so far and passes it on, and phy_probe() fails. A device tree marking a
> DP83867 LED as 'active-high', which leds/common.yaml allows and
> ethernet-phy.yaml references for led@N nodes, thus stops the PHY from
> probing.
> 
> Active high is what the function programs when no polarity mode is
> requested at all, so the initial value of polarity already satisfies the
> request and only the case label is missing.
> 
> The same series updated mxl-gpy in commit eb89c79c1b8f ("net: phy:
> mxl-gpy: correctly describe LED polarity") and aquantia in
> commit 9d55e68b19f2 ("net: phy: aquantia: correctly describe LED
> polarity override").
> 
> Fixes: a274465cc3be ("net: phy: support 'active-high' property for PHY LEDs")
> Signed-off-by: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
> ---
> Compile tested only. I have no DP83867 hardware, so the failure path was
> traced by inspection through of_phy_led(), of_phy_leds() and phy_probe().
> 
> The polarity bit sense assumed here matches the datasheet: LEDCR2 bits
> 2, 6, 10 and 14 are LED_x_POLARITY with 1 = active high, 0 = active low,
> and they reset to 1 (SNLS484J, Table 8-24).
There are more drivers with the same issue, and Sashiko suggests to fix
all of them in the same series. I think instead this fix can be applied
standalone, to avoid more traffic on the ML.

Still an explict ack from someone actually owing the H/W would be nice.
Waiting a little more for that.

/P

