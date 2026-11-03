Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793723866;
	b=BxlEW/PIrcNX0KwRwq0u+GDo/MhV+E0WJAoUAz8i0m9uoWA9CXTjCST/dg1E2n4CHDNX
	 OXhkU3qLkNEFSJG4bEiqox5mPlWenQJwJ2mhrh8dFlPzmK9KSiuRTgxTSHSfnZX+a7gf3
	 +NEmFNfkKfltTCCZ6N8lK5x1c7U+zGat6/msc0YPhBln/rvxIUDIhdaYSqCClxCZiG20p
	 e/fcEbHmGdZhUIGoNjXo507r3K9czWAYijUNWsZenDqZz+WbEjKRWQZOfq+BiDf7EY8LR
	 TXzQODgT3X5z+vWzmIc9i4oGBcjEAg2D8Z4ggB62c8o3W1B7+mPD6zzKy2iCp27ebig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793723866;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:
	 X-Forwarded-Encrypted:X-Received:MIME-Version:References:In-Reply-To:
	 Reply-To:From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=lM5wLY70mAhEd66eVg7LK8p6PaCJhmOslbKIqWnTrnc=;
	b=0ufsrxiclLXvMj/AfTbPwW9LG6eSrkkYqJxgiPUB2zDhIcgKckKY5PnGes0OYNyZ1d8l
	 BSWws2ulFpK1yZtYlVAwC6KFjrhqCnA1NKctl6isIAHaz+wj2X9k+NMi3pFIK4AGofUB5
	 ijQ3wCAOSvm0nzmr690+Lr6TNeNahTlEmKBa/NPHayLCJ7UvmDb1yXvTdh/zVBEIpCBRs
	 vz+OjQ58etW86EQbM5oLYirzpq7Yp7UDSUFeat45RsML841kdnmZHjgqK8HAzTYJ7rStT
	 P7Xr2dQxQVdOF+23Z9dWpSP4K38X5ahfpdW+jy0cooOZ4fPPivb95fZfDpysCbZXSYQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=linux.com;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.214.173
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 256FE6083631
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 16:37:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 256FE6083631
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2ea94541adbso19283555ad.2
        for <netdev@vger.kernel.org>; Tue, 03 Nov 2026 08:37:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793723865; x=1794328665;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lM5wLY70mAhEd66eVg7LK8p6PaCJhmOslbKIqWnTrnc=;
        b=TqPuCMdTwwSbvNKe0NGWCreiNaSXPz2u0BvqSe05tSF8p2AxQ/MzFnBgJYcjoX7q6d
         jfpMVi3OXMZv0DWkywHjf7PC7spz6geHNQD9zsXf61E0IgXGVWUR7I76yRFrBUNKIqSw
         DTtd0Kso4AN8LK1HdYR1UCG5Va1ExFbuN7iMEVjuJHQjzD/PXReImgKAkplW/C261fb7
         ebwbgnrESFUV1dCe+nBDZPOsjmCBQKGPB+cSCVN+1h0n+vzxa4RJqHtmie6112Nn7mEq
         hBSsHk/VBOqvwPCht9Cmd0/V+NcpxP95D02r+gpM6hKySGvgcCWkzRUfrahVibZvdUZF
         oDjA==
X-Forwarded-Encrypted: i=1; AKwUvBwN0xATLppTVuyIfGfbkVtL5ZbMIAAT8ZK+q9IPDgajjCOEz+F0vEkVg7jzjbQt4uYQvrnqQpQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z+kg/y2o4SECdKeKBdHqNNn2Pvn/BNso0KXJtBmSiOq9Man90ju
	RBqO5rEdXG+oY8GnQME9BSXfgNPpKjejv0YEO8H7FeW4aH6vJw4tOsDRF+jjWWhadXa2wQ==
X-Gm-Gg: AYBFou2ZTbvGxxs+i1QpQsB5ntcRkow/Gfpd5C+oNC3XEO0u6RyGoIVCucvEV/yxT2H
	+/xBevyGe8+ePD0w/s86iUiVemyh6QQZvvGg08EYtSOPKZWqjMb8i7budd15WuILtjLbVYdtxdw
	mEGVV6SRu0pJdCd3W+fCK9sQzrmPkpXBnRbJY1hXsJgK4A4QlY0fdOfnU1VMHiu6V8RiqA2dDZD
	9OOgBW+sBiRF1qmcepvqtIWytdaxtZUg7gTlDyQn5bkY6eFqA8Y/sEaWBpwbm5eZlZaKnunTxMf
	dY2gt1Nup74EG8xdoTYez9YBuhKHJZXcopNDX9XdKb4J771mOeX9VFqw3UYnk+9lEdoKiP7z5mV
	ocEwWr6pO9rJPkf6r0RfHHHBFfJHmfl+ncPDe8p6juseiEuskhw3RZAyyEqhC9HoOOrmuxTG0t1
	NC8qU2CBYOYz6mYFVKP38JQsn1I5VfMiUXpRTKbz+mqnW2/uG52b2Ik3LWKw/5VKhdZjNMHPDa3
	x8KQ7ACOPy8uYLoE1h7qgjsFIBofCyrqGiwEOScYm//z7AgUHpGWfsnQ7yuLtx50BMMbzNcDk0a
	ePjqywgl1W1C9hWrH3Uf6NYZICzGsBYYPL3QOrrY9k08PrG23FM+HbIRVqwHR53Ky+qat88pR1J
	f1ETPmFtS9NA0WF4jmUToZFK5dyMWZAPDWwhPzM5tZMYF05AfQc8=
X-Received: by 2002:a17:902:c947:b0:2e9:61bf:6591 with SMTP id d9443c01a7336-2eb364d13ccmr131205235ad.45.1793723865492;
        Tue, 03 Nov 2026 08:37:45 -0800 (PST)
Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com. [74.125.82.47])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ecef10a99fsm11496205ad.75.2026.11.03.08.37.45
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Nov 2026 08:37:45 -0800 (PST)
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-15943c9c005so3659876c88.1
        for <netdev@vger.kernel.org>; Tue, 03 Nov 2026 08:37:45 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBwaOYIR2M16pVz5ryyNmjH5IEtSnwaDA3s0DDkf95+6WRhDGk36Q/GxOBMtJFWym9LBIUi+fWM=@vger.kernel.org
X-Received: by 2002:a05:690c:6b12:b0:8b1:2b64:6fbd with SMTP id
 00721157ae682-8b2b68290bbmr97956117b3.65.1793723494365; Tue, 03 Nov 2026
 08:31:34 -0800 (PST)
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
 <ce7d357b-8990-49bb-94c5-5491496f3ba8@lunn.ch>
In-Reply-To: <ce7d357b-8990-49bb-94c5-5491496f3ba8@lunn.ch>
Reply-To: tanure@linux.com
From: Lucas Tanure <tanure@linux.com>
Date: Tue, 3 Nov 2026 16:31:23 +0000
X-Gmail-Original-Message-ID: <CAJX_Q+38UPjtAxz6EsxWDaWTZFz-jTQ67WKFSLGrxmOeMaOLNA@mail.gmail.com>
X-Gm-Features: AclHuK8EDS_pThzfN9kbbX2pgEiup5lgKQS3IQZ5CGTtBeqTGSuccPA6dHYQQPQ
Message-ID: <CAJX_Q+38UPjtAxz6EsxWDaWTZFz-jTQ67WKFSLGrxmOeMaOLNA@mail.gmail.com>
Subject: Re: [PATCH v4 4/7] net: stmmac: dwmac-meson8b: follow the generic
 RGMII delay rules on the T7
To: Andrew Lunn <andrew@lunn.ch>
Cc: xianwei.zhao@amlogic.com, Andrew Lunn <andrew+netdev@lunn.ch>, davem@davemloft.net, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Kevin Hilman <khilman@baylibre.com>, 
	Jerome Brunet <jbrunet@baylibre.com>, 
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
	Maxime Chevallier <maxime.chevallier@bootlin.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, netdev@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 2, 2026 at 1:25=E2=80=AFAM Andrew Lunn <andrew@lunn.ch> wrote:
>
> > +/*
> > + * Delay handling of the SoCs up to the G12A. It reads phy-mode as the
> > + * list of delays this glue has to add, falls back to a 2ns TX delay a=
nd
> > + * takes the vendor delay properties, all of which ethernet-controller=
.yaml
> > + * rules out. The boards in the tree depend on it, so it stays, but a =
new
> > + * SoC must not use it.
> > + */
> >  static int meson8b_init_rgmii_delays(struct meson8b_dwmac *dwmac)
> >  {
> >       u32 tx_dly_config, rx_adj_config, cfg_rxclk_dly, delay_config;
> > +     struct device_node *np =3D dwmac->dev->of_node;
> > +     u32 tx_delay_ns, rx_delay_ps =3D 0;
> >       int ret;
>
> Does this code need to change?
>
> It would be better if you did not need to change the old code, so you
> don't need to worry about breaking other SoCs. Just don't call it for
> the T7, use you new function in its place.

OK. In v5 the old code is untouched: the parsing stays in probe and
meson8b_init_rgmii_delays() is as it was. The T7 gets a callback of
its own, and the only change to probe is calling the callback instead
of the function directly. The T7 keeps has_prg_eth1_rgmii_rx_delay,
so the existing probe code already validates its RX value.

>
>         Andrew
