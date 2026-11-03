Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793723409;
	b=mcKeBaSfC2B14RxCM/929mAqAyWFzF/gDilfb+RSo3HpaLzYMx0Cl1t95MCIw4b12Wnj
	 8t7IUdkco6XiyPtRE4gycsqqXzDF8dwnASTKNWXhSD+KujTzG4tq3csHP4ney54AjYSUr
	 uljvHj6YC4LCO4N9XIrozMJuax+5PUA1xGWaxtkaNTFtNcS8pm3AP7B8Yuv3dhfUMf2kA
	 2mcIkadBAQQ6c9pU5r80Webih1CNkEtPrToBFqFSX/1Q7LIzhDEWGDpwgVoslQ/7rFhYi
	 cSlcuZdTb03veEpnNhEoTRan9wxajChzgu9egaqJsb00xT9mNpVuVbBL2n6NeyEx8tQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793723409;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:
	 X-Forwarded-Encrypted:X-Received:MIME-Version:References:In-Reply-To:
	 Reply-To:From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=2BAabvEd6vL4y9BLf5sVKsYhFFT7p2yobeyEnKOJ5A4=;
	b=oEfgI6573MoEUsFigrwLFB1skCAOk15YgDKJNNz/X7oNVm4DSbXNW+vO2sueMs+LyXqo
	 z/UL93FO+0sHoD+Nh4H0shnivuIYsU5klKcgiOJ4Q3uK87egjE3zgQNx8+prGxTWJj5YN
	 9V+GilE5/Zr7tnrmVPczWU/Pw9NMsWB+rb3LIstKHjtmo05I43YtJVTE3NJHC2T70pMU/
	 LTX0FT/c9WOu6lkILVWwYSkbh6OxrWyLFY2gjw3UQTcKmY5IshdraQZKxLpWaoM0wuaht
	 Tvd+svB3wIxUqr5TuQVhpZpdFB2DeUWF75MuEtlo/G6zOlfCI002Va4/swSnEQYuy5Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=linux.com;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.128.178
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 429A0606D802
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 16:30:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 429A0606D802
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-8b305d38bafso3414597b3.3
        for <netdev@vger.kernel.org>; Tue, 03 Nov 2026 08:30:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793723408; x=1794328208;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2BAabvEd6vL4y9BLf5sVKsYhFFT7p2yobeyEnKOJ5A4=;
        b=EJsm2F2j94Nb4aAG973ahTtqwBiE4+0QnIES4z77HXJEpaJhPG/bk5Ao27dDs6CGHq
         kWbsuBJC9/j40zdZzIuaGEfhKtNnug076jcmv2PXTG3VnB+Q57CfIMq94mgq8aj8eBhZ
         wYk4eb2B0Xv//R67j7mzhrDfU0n3GvtSxvKQmDLT7X6Nwb9SXeJBrstoHpY4K9Q5M4+q
         Ux3tkf00HG9KwNIXNlJtOOOTPCThGQW8SaqtZY8QlrBmMcRwIdS1ANihG4Rh6z9TKbEB
         oGAfg3Sxspm/oN8g7D4qJ9lWN6cF2R0b2Qi+y0gHwmVm5gMSfSAefYwh+/yDDKz0DcnX
         9/Kw==
X-Forwarded-Encrypted: i=1; AKwUvBxs/3RSl+tVeacmpUiIfyZu4MCqL9ePfg+9zXhOoQnfHZy8ard335KnQiCf4RAcFjWqQS2GU2c=@vger.kernel.org
X-Gm-Message-State: APuU4Z/o2RndN1+bxVkQuZbeRC7fll72ZViC2VdxZeYjgedfslJHH6GR
	8DGczBJeO2C0QY83Y3p4WqxrVC01VrTmoVlpAcfy9JPQkV8lJJq74wup4619pTB6m/g=
X-Gm-Gg: AYBFou27gEMQchAqEIIFxrI7NLUsPgW+/VRrNwq07mm7TdBFqVkUxkcvj7k/F55yu6W
	+G+ENtHQ3kqo9bj0nlLMIjYVAsEU2O+jfbq3DgosRhBClYLWZRBeZjlnfW4VPjFJxsX+5+v7dfD
	qIn/o6JtWUpGc2bgQkmBDzwWDkrlDdQ1tJegJ17z3YQJ9aEo5weVgB3IlyFeYlvn450taszJEv+
	6l54mDdM/2byTgg0A8GBriMhzjetEz37/2QyQOWaSEjeFzSKtgcW7FOhbwhf19joVMXUiXpkdEO
	zURm42vAmMRppIcQODqfc1ztvlM76gjs2+yMaqhhLojU3gITJ6IHhHNQSGN55RrZCqCoXEUjxT0
	d8OJhUGXigAcY/rWIXKB4HW8j56cEGVb8BBM2a54Xi4t3jDYTqSo1hYRROG8uYXYoTo2PK3KcLu
	FdXdjNoGXTNCFRZHvvjQ92GcW+4IgipxUo1YhEJgWaNVjbxQkSBamLx7pfYneRe8Cw1FuYZaJxz
	5/9NJqylt4YhGtVlmNw8tOLCceOUT5zpD2zGkX3KBRfWWJ8NOJfDYPFC/JPnC1WtC/THG+wQjTw
	B9KFZhpD9aa9lI3p5NwstomFSj519a2uUdVVl8Ld6C/c+KcuP5uVoeh3Q7NYu8PEKp8tKjQFQOp
	j9EiYqrZwyfiJ9GPZnYa2/v7K+CJpCxZzFK/RyA==
X-Received: by 2002:a05:690c:e:b0:8b0:c673:9958 with SMTP id 00721157ae682-8b2b65aafb7mr104796217b3.3.1793723408317;
        Tue, 03 Nov 2026 08:30:08 -0800 (PST)
Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com. [74.125.224.43])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b309711412sm354487b3.3.2026.11.03.08.30.07
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Nov 2026 08:30:07 -0800 (PST)
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-679a2297c55so4725123d50.1
        for <netdev@vger.kernel.org>; Tue, 03 Nov 2026 08:30:07 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBxyrUqLt1xf9RSQ09CsOWEQr8WDWpTISmyWqpPNFMa+oHxZLPkQlhbOtUVSPqmhoMmOBDdw/Lc=@vger.kernel.org
X-Received: by 2002:a05:690e:4810:b0:67b:9051:e32a with SMTP id
 956f58d0204a3-67ba50e0ademr6918680d50.93.1793723407281; Tue, 03 Nov 2026
 08:30:07 -0800 (PST)
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
 <95418d50-a83f-47da-819b-de04eab449e2@lunn.ch>
In-Reply-To: <95418d50-a83f-47da-819b-de04eab449e2@lunn.ch>
Reply-To: tanure@linux.com
From: Lucas Tanure <tanure@linux.com>
Date: Tue, 3 Nov 2026 16:29:55 +0000
X-Gmail-Original-Message-ID: <CAJX_Q+1jAYu-0XjUqmNsR4hbSPTWT+JzsBK+PNqPg_yxCKy8YA@mail.gmail.com>
X-Gm-Features: AclHuK9mStYKxlMFWLlexMhXND4q5zYuU5C_HQS0PBE7THFUZlCXo6CxCqTl6Rk
Message-ID: <CAJX_Q+1jAYu-0XjUqmNsR4hbSPTWT+JzsBK+PNqPg_yxCKy8YA@mail.gmail.com>
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

On Mon, Nov 2, 2026 at 1:18=E2=80=AFAM Andrew Lunn <andrew@lunn.ch> wrote:
>
> > +        rx-internal-delay-ps:
> > +          enum: [200, 400, 600, 800, 1000, 1200, 1400, 1600, 1800, 200=
0,
> > +                 2200, 2400, 2600, 2800, 3000]
>
> Is 0 possible with the hardware? If so, i would accept it.
Yes, 0 is the delay line switched off. v5 accepts it, and the T7 joins
the existing G12A list in the binding instead of carrying its own.

>
>    Andrew
