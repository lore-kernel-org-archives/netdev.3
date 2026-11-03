Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793723865;
	b=xEVp/oDJlXts/5ysOFBC0IUvgDH6vu47jNn8XegF08d/+lFqVYaGit6KatqxE5kmm6Js
	 renvc1v+b9kYMfytXVWWohsSrN/zQGMFvGJtT3wNcWGEcPxdI5cqsQLByxhV8n32D/4pN
	 nuhImgHdst3p15JmbtuBifmr1DO3ADeDQPBl5/cXd8XU7v1/wDDcSQbd0aGsCj+FSuiI9
	 YmKp7lveS+3nxI98hSFqWo3icCvsdGUE1Z8gWsQRnZt3gCIDsNUX5w7kbTbjDqPS1YPvf
	 ZnktHmUO8Rd7mdsBYG5HwwxAzF6Leed8ukxO7WQ65zjLYTu1lgFZNQF/Mgbdoc6Vr1Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793723865;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:
	 X-Forwarded-Encrypted:X-Received:MIME-Version:References:In-Reply-To:
	 Reply-To:From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=YNY6h4Csi0xCblDGgiFLCrE5yAWsa766ysMezcggLVQ=;
	b=Qe5PSUl+nncdmoHjTulex/79jZO0/3XHemD3n5g3gHh6y2X3QSP1/cpnrBqjvv6NbtXW
	 86ZZ13t8wCMuuYsgBaOh5LBEisEjrbJ6YeR6gVG8ivA0JBKmlMC/6P4IHX4bj3cqUPqIR
	 Pxfade86L/JGfmPfMbstZ547qxHnKwlkqILGJLv9ORSuRU9L18ZmuSXNzL+OsNR8NVtL1
	 QtBM3b6bpSOADYoOXaIDYFBoJtoCfvokHtjCEfk6WOCBp8n8L+UJXc/MTrsgiFZ3VudDz
	 ufXWbhOQzWAujWHTZXb73Fp9k0BUOveQXAXXsstE5Q+xEov4LL7v+g9Buugij/1hVbQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=linux.com;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.215.172
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC736606D83F
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 16:37:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BC736606D83F
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-cd623dfe420so3365845a12.0
        for <netdev@vger.kernel.org>; Tue, 03 Nov 2026 08:37:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793723864; x=1794328664;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YNY6h4Csi0xCblDGgiFLCrE5yAWsa766ysMezcggLVQ=;
        b=DsEagHlMAq58IMEdoPAY9ItPJ3WY2OOJFKXB1M/VZaejDxNj2HnDXTIxC2OWLYQMlK
         Vr2A0ioaW8kKDH8cH5Iujd9rygtiNTfh+SCrl6r0wDFF18noAxUjQ7X9dal0NUHtGlPG
         8ZDfMO20yRpe/Pp8g57xjrb4QdswswxtprdgiSP8kUXiK8rPSH49kYEBcTgfVSbuJzRm
         pIDfEdCtho6ZCTZ1eSIXDdAaRESkXv/B0jmNHjPpy/tbstiknqGoqbSgeDcKuolGyxiy
         Jh7DBzF/J67mBDjwcBM6AUaSXUdBXFMTDbA+mNBhiIaon910q7kviS1/99x20VhcODC5
         uJIg==
X-Forwarded-Encrypted: i=1; AKwUvBxcxNlcJom/AUSGw8A68Rf8Bs4s+k2fC3/zfsqJvButIALWIDh8h3gMADK92/HIDVT9mi4Z4P4=@vger.kernel.org
X-Gm-Message-State: APuU4Z+q+Ij0/JjG1b0QNW5VVcdaus6PYYMK7tkG00/0Y0xGf6DjKdw6
	nWgss055dj/wjGakChON7tVu495mKBFtOFCOfj+xlow6q81k/5hvoFFhXUqUKuGjfyIGEQ==
X-Gm-Gg: AYBFou1zdOqauDxiJBIHEctePSsEPmEYxy9QpTDbUG/svWnhrT5OculiyFtB6KuQLKF
	ehKnS2/CnyJRIfjfVS9jHiFk7bTHMz9+RTlaZ7aeAwVMiWH6SR/SkYI14g21YgZWRmjCmqD4NPt
	J1RRHBmVY43ZTp+b6+mPEMi+b+9tCau+TmWJU6PcE++heSpQvjOqpwksXpzPwDCaOeOE15l3O0o
	QjB4mSmgkuhXTT713KZjtJXdsB7/01ctEa1/gKI7Ye1musw3QWN8fq1dRMGBHptm4/tBUtjtIAz
	i+AdpB+RFjVWize3ByFQqmSpdsaCgS8UPkXFrU/xgb9njXlwLzIatErjMQHJtgaNG49ahjmLYVB
	5nlAk78Lspv7w05cBRZuzULkIDyqZkw/mkCyteGsAHRYKagLF5sKSH+ZT/A8tOuIT15rRGidnJL
	luKD0Xff7nwGBBoDfuvh/gQdAIIkimXTuppA3w2jpG12W+eEikGUJnK3AeKs9EXUhT8YhgfaU0D
	33BrC63wcB68e8nh6BZ0tPAucdEmHxjpEJDtpZFrxVg7gIRbONQwdwBYw2/E3H7kzUIkHp67kfz
	rBJEAKXBDtLvjwETqZInBo/BXYAPFMJBKr3uqZGi6giCFx2opINCsljcP+4QST1cC7GQ3rFSiBH
	r9VEbZJ3ByylPOgbbXmCjOZIcPk+5k/qx+E1xI7AmPzA1wyiT7Mc=
X-Received: by 2002:a05:6a21:8905:b0:3e2:8c83:6824 with SMTP id adf61e73a8af0-3e928a7e5aemr9766075637.10.1793723864184;
        Tue, 03 Nov 2026 08:37:44 -0800 (PST)
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com. [74.125.82.50])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8aad9d047d2sm3548855b3a.25.2026.11.03.08.37.43
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Nov 2026 08:37:43 -0800 (PST)
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-1931ff67a29so9083935c88.1
        for <netdev@vger.kernel.org>; Tue, 03 Nov 2026 08:37:43 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBwnetPBYXBo0aiAoMQpIc/Jhihxupqg7+fbAo0MwDz2m0UNaJ+BRd6ebyQVVZPrNYA7bJMjayk=@vger.kernel.org
X-Received: by 2002:a05:690e:1c07:b0:676:8974:9795 with SMTP id
 956f58d0204a3-67ba50e5d1emr10529834d50.92.1793723366247; Tue, 03 Nov 2026
 08:29:26 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261022200640.3101932-1-tanure@linux.com> <20261022200640.3101932-3-tanure@linux.com>
 <f8da1842-bdc0-4bf7-8f15-46b57a9eedc9@lunn.ch>
In-Reply-To: <f8da1842-bdc0-4bf7-8f15-46b57a9eedc9@lunn.ch>
Reply-To: tanure@linux.com
From: Lucas Tanure <tanure@linux.com>
Date: Tue, 3 Nov 2026 16:29:14 +0000
X-Gmail-Original-Message-ID: <CAJX_Q+3hxekJn1FiDJjYqDoCFyczxzvCuQJwWQ1DbH_WXjihOQ@mail.gmail.com>
X-Gm-Features: AclHuK9_PvSlgVJNQpbckdVoDA5-AvRndijSeKC1Bujpf2P-dAJH6DOiVyEau-s
Message-ID: <CAJX_Q+3hxekJn1FiDJjYqDoCFyczxzvCuQJwWQ1DbH_WXjihOQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/7] dt-bindings: net: amlogic,meson-dwmac: add amlogic,t7-dwmac
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

On Mon, Nov 2, 2026 at 1:27=E2=80=AFAM Andrew Lunn <andrew@lunn.ch> wrote:
>
> > +        # The PHY adds the 2ns RGMII delays, see ethernet-controller.y=
aml.
> > +        # The RX delay line of this glue is fine tuning in 200ps steps=
,
> > +        # added on top of what phy-mode describes. The TX side has no =
fine
> > +        # tuning: its only step is a quarter of the clock period, the =
full
> > +        # 2ns at 1Gbit/s, so the TX property is not accepted.
> > +        tx-internal-delay-ps: false
> > +
> > +        rx-internal-delay-ps:
> > +          enum: [200, 400, 600, 800, 1000, 1200, 1400, 1600, 1800, 200=
0,
> > +                 2200, 2400, 2600, 2800, 3000]
>
> This is good, thanks.
>
> > +
> > +        amlogic,tx-delay-ns: false
> > +        amlogic,rx-delay-ns: false
>
> Maybe add a comment that these are deprecated in new SoCs favour of
> the standard {rx|tx}-internal-delay-ps properties.
Done in v5.

>
>     Andrew
>
