Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793723893;
	b=ToMgQ1KOL1PnHeUrhf7d7RyGrBaoQTX/5PugOvDiwAM4OXIzZ37lvnylsF+lZX2R55SF
	 wIg+W158VZeQ+49cM+LkIh+FnrxkXGq/1yr70yS2n2SCwi0AbV86FY+pl8YPnDWOkEAwg
	 zC25Jj2gSSuvcWmdS+hSQI4G6wAa2XxddVkRHmAkSUdywbtdwcVFJQxR/Iva9pAqPPrH7
	 9vdIfreZ9HOg8z2wMwf8tnBjo0kb000MDx66nSs3wChMNyq41vKTT8A0tS/LSKpp0Jk93
	 MfP7C04YjMesSWsJfreQamdiWhrXNIzdeixFoxRDhcINEs/KgXRJ6xd/riqPOQsNg7Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793723893;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:
	 X-Forwarded-Encrypted:X-Received:MIME-Version:References:In-Reply-To:
	 Reply-To:From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=/NZvArZdYg853Maan0dEAeuUTGOiHnQbpO25gEe5B+E=;
	b=K8lzpiFgZkhgo25K7+AHulkDpqhxqMsPTv907nqOIfxpFzqkdgcrGFhBzfrix3wjg6iq
	 8T3mzrIKhRFq21p8GxR8inC6bgesTYzZsqzhf8TlkGxxkDyXaMSKkpMSjYs+ZwiGXKbmK
	 EUPLwLDqEn3V3osvamV8UoJ9YI96YWbrUSb2EBRxijIazKjausZU6M44HYuTx+nFpqyXr
	 3B7faFyFA3rvAlJGQ5Hl4SS117N0mCCSl/3/X9RWuhCEOZvUIjc2ssx4Iui6YaP4yV65i
	 rxLH71VIHUixCmkASvEXTbFf52OGA1hxdslGfaegWmBmhp5MdBS88jouRV829LyiK8A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=linux.com;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.210.50
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E5AB606A324
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 16:38:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5E5AB606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-8253bc5a613so2841485a34.0
        for <netdev@vger.kernel.org>; Tue, 03 Nov 2026 08:38:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793723892; x=1794328692;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/NZvArZdYg853Maan0dEAeuUTGOiHnQbpO25gEe5B+E=;
        b=o2SjAsatGU25dgXJXxTHIoIrpPezwFxCqtK0nIwlPz7BUrI2GHJFpipXMrlTQ31+q/
         vAqqGBEYoMBREhjT3vZkhJy1NOQRNK/h87bjPK42irXg2fOAmE9KLV/27qiAYCAHm9vv
         xZuKRqwI/A3E2ZV0V+gb0rDLdgo/p61KYOCSwMy8nUYb37W3ypf7qgPWGnsPWfrd2loN
         9Pru0gURn/88JaoqwgJ0frzdCMYhy0JxptVuaX1Z6zJG03X9BXuFv5vLE/f86rT4Z1r2
         omS3OB7Jw1IVfO0+Yp6K0mVxFnKFyvKUdDINcrhVF6mTfgnQHYHkGBC3tX3lvhB9J2Sh
         sUYQ==
X-Forwarded-Encrypted: i=1; AKwUvBwSF9d+5sB+c1NDlkoREih4cSd4DJZsbICkAch30/gZcEL5fZq+4F21l5m1AH/i/V6lhqzs45A=@vger.kernel.org
X-Gm-Message-State: APuU4Z8/pZa0K+9FzVPd6GGLy+3pJBXAlc7MTBehLvyjIdIfbEfwX9U3
	c33580KKv71ur4K8ys+68UD7ElBk7Fi8KGKhSM7YswZMPdYJslj9ExCE1Jeco6n0P3g=
X-Gm-Gg: AYBFou0qoicj2ZcvAiH9OYcvkQJuD0PSrQrhacM9TVhZTwRD/qqlxlGKrpRu0gJjxHM
	/7MZBi9mRREFJrBT6k+mN+vN5XmINak/xdEKHTVxg61UQEVcR64pEZ3gcd6Qie4DhvSBguB9npZ
	f4KayBcM67b5hwM1Rov3aFrnGiUk86Ss+4M10c1MnFsFIJXN21RFpwwirqtQPXgE/Vn/bXd3PMB
	/RzZ0ppP+y9uUUKrcZ5ExNBtSwbSj80cTLuAlPwQFEk1zlkQhyosEagfpwLsJomm67RV+Nhgryf
	8CF9lFylIdjJCvrkof7r9hqSfTHnSzOelv4Bxe6wSFeO6G+IBo/G1D4LQBHUCm14jrjrlSeKb96
	Q0w4jvGQsujGHOWlqw7xcfMtk1KwvvwsaFOuFQh+wIiedyyzKV1GV6rxAodzNk9u3PqwxAAxewr
	IjeIw7XGnxZVNpv7hPyEq5qDBr90e2YUDtk9Jny8rcvdC56zOy5Ntlb6I0VZwu0DJSOyaAGwHvl
	DcDMTQ2xqaS7DzwePnP4wbM0gpEw2hInosfdOE7yaiczsDO7EJ0NJJk1vcv3kpSyUXUZiiRiQ8k
	jET04bKTsYoigdABMnKRM7ZoNmRcT19FjKPHCjpFT9PDv409EM8142fhugmNxO9ZOkonqWBzS4k
	6tKPGX1+k7BekuACWG7PDyPyiiLfzS9m+JswrNio6cn0wHzValGeQ9RBq
X-Received: by 2002:a05:6808:1a04:b0:4f6:5279:5c75 with SMTP id 5614622812f47-5640dcb93e5mr8901578b6e.28.1793723892138;
        Tue, 03 Nov 2026 08:38:12 -0800 (PST)
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com. [209.85.167.178])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-5640fa0af12sm10356319b6e.0.2026.11.03.08.38.11
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Nov 2026 08:38:11 -0800 (PST)
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-53aa0802881so2204674b6e.0
        for <netdev@vger.kernel.org>; Tue, 03 Nov 2026 08:38:11 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBxV6tWLt2FFBJNfbaBrnTs7IjDAGYpWdjGV4X9e/sNzX8lLXRZZZnxjVPsymxzsR72D5nTN664=@vger.kernel.org
X-Received: by 2002:a05:690c:e3e1:b0:8b1:3606:65f6 with SMTP id
 00721157ae682-8b2b674a182mr76399327b3.64.1793723531633; Tue, 03 Nov 2026
 08:32:11 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261022200640.3101932-1-tanure@linux.com> <20261022200640.3101932-5-tanure@linux.com>
 <CAFBinCCtfPCsqN5yG7LWDFG=tyJ+aHix6x3yiXfaTAPP_A-hAA@mail.gmail.com>
In-Reply-To: <CAFBinCCtfPCsqN5yG7LWDFG=tyJ+aHix6x3yiXfaTAPP_A-hAA@mail.gmail.com>
Reply-To: tanure@linux.com
From: Lucas Tanure <tanure@linux.com>
Date: Tue, 3 Nov 2026 16:31:58 +0000
X-Gmail-Original-Message-ID: <CAJX_Q+2D8wKuMEgKWdJn4NA0wwuK5e1TuUtbhZbRZmFbVXmdUw@mail.gmail.com>
X-Gm-Features: AclHuK_uB_FU_COonRuR52ADQLZgO7wR8X01b0NCoWbrjac2-TTSlybmTTN1Brw
Message-ID: <CAJX_Q+2D8wKuMEgKWdJn4NA0wwuK5e1TuUtbhZbRZmFbVXmdUw@mail.gmail.com>
Subject: Re: [PATCH v4 4/7] net: stmmac: dwmac-meson8b: follow the generic
 RGMII delay rules on the T7
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: xianwei.zhao@amlogic.com, Andrew Lunn <andrew+netdev@lunn.ch>, davem@davemloft.net, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Kevin Hilman <khilman@baylibre.com>, 
	Jerome Brunet <jbrunet@baylibre.com>, Maxime Chevallier <maxime.chevallier@bootlin.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 1, 2026 at 10:58=E2=80=AFPM Martin Blumenstingl
<martin.blumenstingl@googlemail.com> wrote:
>
> On Thu, Oct 22, 2026 at 10:06=E2=80=AFPM Lucas Tanure <tanure@linux.com> =
wrote:
> [...]
> > +       if (!dwmac->data->init_delays)
> > +               return dev_err_probe(dwmac->dev, -EINVAL,
> > +                                    "missing init_delays callback\n");
> I'd rather let this crash hard to make it obvious to someone adding a
> new SoC that they forgot something.

OK, the NULL check is gone in v5.

> Other than that this looks good.
> It would be great if the netdev maintainers could comment on whether
> this now matches the approach they had in mind.
