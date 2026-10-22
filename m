Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792690122;
	b=lmVMowJS+LWiNUQKQLgORFefbDZ/iJPM0XQScyW8PWiD6lA5aDErG6MB5Co0cNWDohJd
	 lptw0ETS7eU9M51YweLOGd7uTnZc758egfDJLJICjzR4jn0d1/TdNj38CXHVdkHySlhNq
	 63aUK0XulXUQKC0sSsXmGwNuo3ioXEK0QA+tR1wiIF4iQUaszhl02zr7P9Owtr0qZ4xgW
	 +wfOnk25vR0d96T9ksbIXNx60tg763nIGqD2i/ZHGxhTttRmMl/RACKAcSyWU+CSMxjmb
	 sWjVBaqnG/AfsY4pgkmFIFD4BtbGQI82KKRgWnldRZesqkfIx1FrvTYrVtszwk583HQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792690122;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=aIigL8Htvs1Eri4VcHQ6P7by4WWQ9ht1cFwpEUONgJM=;
	b=nKzbu7lKXICKah3T1MUrji2KScqciqpmt1DVeNyi5xZcsfc1pi/rOemTrJXjUj5T5s0r
	 Xd+oMjNqn3+GU1fjxz9M2gB6Ep1NCWWpJEgLdI78uCkNUbYYZcNi/9fKCPwCCeFxozpd0
	 BHN4B5wYeqmYYbRw/L1AcstNcKCccYkyEySFVPb7Oj0sW6HNVMWwbqSE/wzuAZ7oRCwmN
	 eNs9TeWDXGri8Kqq7RPiwqVfeMIQkQ4+/Bfi40E+0qDYBPkPv4pdq/RX910QjzzRNFKaS
	 rE6potKqb/L0RfrQ6Nrw0Abjp5BCnUVgUQvlvo0FwMtqXRK4dTqPljKnOYXZn4k5xoQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=linux.com;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.128.51
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2466F606A31A
	for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 17:28:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2466F606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4a2069b9710so349255e9.2
        for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 10:28:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792690120; x=1793294920;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aIigL8Htvs1Eri4VcHQ6P7by4WWQ9ht1cFwpEUONgJM=;
        b=vKYhCPwHcVfVbkf6BrtFGDFKRbW5lD1eFH1owwZUIU1ttVJp2MJbxblKxPh9QYrV4I
         mcEeo813Hlp6cfNjmIs2+KFkFarxPmfn3OL2Ye0xW7TMSk0ph7aky1xGqOLwofSsdPHa
         Wv5xvPilseQCcFSdNRmSBtdKIHJEudkO9oKnjx2m1mqM4tvhoU64rlQGFp01oiorGkqY
         G3bLH9JO3HRIeJNEX2pEyIpbBear5Y4YWl9vCs9Ar/fBSDS7ldVvAERpNtJUdFzWDp88
         difbPF83OUw/ny1SzUr/a3/1bL748J6gZYj/DEQE+oIjcR0ZJCcDlyOdzt2fTteUg82D
         9xgw==
X-Forwarded-Encrypted: i=1; AKwUvBxOjdoAeSfEF/m92hp0I3+ekQ8SsxqiI6Yx4Lz8upxNQdX+0pXQ+3MyszTpNKYCFAQ+9UqB1x0=@vger.kernel.org
X-Gm-Message-State: AFq9FYK9QC3fEiI/ub8sDn5NC/Cw6CWxqrpFjG25LXd4L6vcNGRLho4y
	yDF+9tYZf+e5zwInynGA8pv7+5DGywnywHy0REn/xivoO7ZeNNifH5tS
X-Gm-Gg: AYBFou0jU4QFkuR2Mhl87/7cOYxLZdSPoNnH9UgjwJ6EuJR4nsVD1cJf4NE7f8A04Hl
	nPjzHKa8TFSfynqJsYF5abDNiGQ8d9axFydrlUQtLWfdxqmi+cjDbKePo6ddCmXODBd2y3t5b62
	uO5fIehsOtON83Q2ZRQEvpPkSZXVTBsxXREr3mATfE0pMNXz4zZuDMioQgxUMSP+lRt2GFURUOj
	GJPIH5mXN9YjUwDP6RsKjUwACYLITND+Xzhw0BdwKsmdIL6jdSTQ2NtliVn/l27R/O8AAVSgnI6
	M6zj4mELHt0ugzWIRBi9cteJMcg1jq/siIvbS3Xeqq9J7GiXFZzLg3Qf+v4LIWwzQ0C8pGHiUzb
	IhCLuk1uprFTqtOpeEiql+oCzMOQMEKkUPULn10aTkls9/drxuvLeC9G/9HBdbozxK5hSQf1dPg
	QiDrjr6jKhHi75Stq6fUR/FtqHl36enAzhlCZ5Eja/zTGeeF+nlp49Exn2XZpLYOKgXnFJ1Vjp4
	kmIpwzvPRsF5HvELZm9X/o6kQNEM2mN60chX8jg4qFYaCzcJEkcfsspl1EeRpdZzEDf7cImGVGh
	+6Qlm6HKnw==
X-Received: by 2002:a05:600c:8b4c:b0:4a2:729:f7ce with SMTP id 5b1f17b1804b1-4a20729f92bmr52278535e9.8.1792690120279;
        Thu, 22 Oct 2026 10:28:40 -0700 (PDT)
Received: from [192.168.1.135] ([81.79.62.202])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a210361ad6sm11491635e9.7.2026.10.22.10.28.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Oct 2026 10:28:39 -0700 (PDT)
Message-ID: <1ca9d46b-02aa-41bf-b184-2a62f8a284bb@linux.com>
Date: Thu, 22 Oct 2026 18:28:39 +0100
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
Subject: Re: [PATCH v3 4/8] net: stmmac: dwmac-meson8b: apply the RGMII delays
 the T7 way
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: xianwei.zhao@amlogic.com, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20261010105900.247342-1-tanure@linux.com>
 <20261010105900.247342-5-tanure@linux.com>
 <CAFBinCCpo28jZkQnup2=iofwh02GOMzxJ82hGHWctiWzcKTxUw@mail.gmail.com>
Content-Language: en-US
From: Lucas Tanure <tanure@linux.com>
In-Reply-To: <CAFBinCCpo28jZkQnup2=iofwh02GOMzxJ82hGHWctiWzcKTxUw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/10/2026 22:49, Martin Blumenstingl wrote:
> Hi Lucas,
> 
> $subject caught my eye because I didn't understand why there's a "T7
> way" for adding RGMII delays since we should be following a standard.
> Patch 8/8 in this series documents the standard. Can you please find a
> more suitable $subject for this patch?

Ok.
> 
> On Sat, Oct 10, 2026 at 12:59 PM Lucas Tanure <tanure@linux.com> wrote:
> [...]
>>   static int meson8b_init_rgmii_delays(struct meson8b_dwmac *dwmac)
>>   {
>>          u32 tx_dly_config, rx_adj_config, cfg_rxclk_dly, delay_config;
>> @@ -411,32 +455,34 @@ static int meson8b_dwmac_probe(struct platform_device *pdev)
>>          dwmac->dev = &pdev->dev;
>>          dwmac->phy_mode = plat_dat->phy_interface;
>>
>> -       /* use 2ns as fallback since this value was previously hardcoded */
>> -       if (of_property_read_u32(pdev->dev.of_node, "amlogic,tx-delay-ns",
>> -                                &dwmac->tx_delay_ns))
>> -               dwmac->tx_delay_ns = 2;
> The 2ns default value in case "amlogic,tx-delay-ns" is absent hasn't
> been necessary since commit 093d23db4fff ("ARM64: dts: amlogic: add
> the ethernet TX delay configuration").
> That commit is part of v4.12. So boards using RGMII and a .dtb without
> that property haven't been updated in more than 9 years.
Ok, so for v4 the code is moved probe into the function only the older 
SoCs use, so it is isolated there and the T7 path never sees it. We can 
drop it future patch.

> 
> [...]
>> -       ret = meson8b_init_rgmii_delays(dwmac);
>> +       if (dwmac->data->mac_applies_dt_delays)
>> +               ret = meson_dwmac_init_dt_delays(dwmac, plat_dat);
>> +       else
>> +               ret = meson8b_init_rgmii_delays(dwmac);
>  From the discussion in v2 I couldn't understand the overall way forward.
> I get that new compatible strings should not rely on old, incorrect
> behavior. But what's the path forward for the other SoCs?
> 
> [...]
>>   static const struct meson8b_dwmac_data meson_t7_dwmac_data = {
>>          .set_phy_mode = meson_axg_set_phy_mode,
>> -       .has_prg_eth1_rgmii_rx_delay = true,
>>          .has_pipeline_clk = true,
>> +       .mac_applies_dt_delays = true,
> This should be a callback function pointer (apply_delays or similar,
> to match set_phy_mode) unless there's a way to make older SoCs also
> follow the "correct" RGMII delay specification.

Agreed. V4 will do it.>
> 
> Best regards,
> Martin
Thanks
Lucas

