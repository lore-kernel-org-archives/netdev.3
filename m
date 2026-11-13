Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794608226;
	b=VgZZjrOEFQaSyUUVDa3jnn4yht/tGiDUnaHf+sXceRfe+W271POoLqRGFthTm2utoi8l
	 20/3XLBOwoQztpKD9UN9LfsSGQNuKaHSA3UawxZ7umNhQzAEUQbJwlGdrfPgpLG6Cl7JB
	 gPZvXifTLz/2xxUG3eN/b8lu4Mu/9/DNnDlO+3HXUY46rIK4vbSyfiGULeMDwTdH5PaW0
	 AUWsmgxTo4bvOsN1ustvIsyxEUUCo09mWrMDWFsoUOEyQnTwT/eBGbrvoWgTnsFEaQQVz
	 U7V53tjul4Zbku2X1MxVXlIoUwiL3M1tUojiyeRnujxZSLurXHBQCRVnmREC9H4aphw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794608226;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:
	 X-Forwarded-Encrypted:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type;
	bh=N6FCMFLhgSC1KzmMhu82bNQqBAWEEyHIeJ3mRCaIM5o=;
	b=exE7euf0D6tSelFGvmIoMfN5He6qDBXzQVT0DAIi2CUcZ3YG6tJztU/8iigF0eZicORb
	 FPAFm+rtJUHEYyXlOoM1mj+fuIc7u7ZDc4STa0JBb6QB+M5S0ecvIbDAvnJ2XFaP7dkV1
	 lZpkwKQKszsKouh8gQsTV8QHmZ9PE9JevblgGeV8RRzrfv99m9n7xrdZlw4Guu8h1/yR5
	 2m/EPVGGUlMQvcsHetLXWoMiDJj4L+bbksy7VxkHnG4STPR+7HFH/uAdxGM+3cJEN0C4b
	 jin0wRO4FP9g3ZXxygkqvt2qE63Qo+doW7YMquMZo8sa36T2O9WVaaylggvd3dQE5Nw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=telaak.dev;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.210.176
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28549606A33A
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 22:17:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 28549606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=telaak.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-8a058315c79so1146664b3a.3
        for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 14:17:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794608225; x=1795213025;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=N6FCMFLhgSC1KzmMhu82bNQqBAWEEyHIeJ3mRCaIM5o=;
        b=kW2wNzeYfWEKdzVk0ZEtOIrqrYkSSOtWlyA9kIDHWqteDSozbJIUETkxZE3FeS1laS
         5YZ+d28H4zQVFjXGdI7+8EKrwiO4yqommdORsDKl3BU9j2xm4eHr9uA+yNjSygdh0alY
         A32MbXJ1U50QbkKaeYvnN4jDVPeFlJxnHuxJ/7cmJWeGwLn7ha3WUTkNTQTC+O+XgcHc
         HZi+PxYGFv7wI8zD+fCQ/LVuE+qV/tzncFhNoxwbNsqYAt1jjcKPCfrcIIX4WUZUlJts
         tmynQfdM0E60pnpYDLgHGPqeI/Tchgfli+p3kN/BOh1W19Z7y34teLABHlMXjGOu7lya
         iEjg==
X-Forwarded-Encrypted: i=1; AL+hErEoU5H0wubD8wLIU4qsMW2qNNHhgE81AlfGV3N19KDCQcr2qZX94xT7luSFuALEJLtcwpDY+VE=@vger.kernel.org
X-Gm-Message-State: APuU4Z+F9qRNHyGlKzRR5dzJ5laGkJnCNbBQ0k07wDCRZrNNUe6Mir+j
	6C8gXxpoaZQBmFAdAR9/wCO7pu9C+x3bcI51574jBHhaiEY07A9Z7D06tA+/xkwh
X-Gm-Gg: AYBFou3GqF5PWqYd3xsvqzbnbJnCLEXa8YZITSqR+NCCpVp9JnMjHbXlIyCw1LGaHu/
	/0ZCs35vdzOvoPV2NrbYpFYwzB0hL6tvgMiHeG0n/Cnjcj8tjGvXi6R7KICrS3S9t71ugIhbCt3
	j5YT9su+0TSJ0JUMxg8tEcplg9nmiwR6SZlToPDBD4lRU7JzOkgo+a1VPnmNUtBeuQvqUm1XWb5
	0VyFHWmb7Twz9jqG8oT75iEsHqJ69Otkk1vgHq8fS9Fs6AfKuF9VU9jMZEHyvqqYPrNPCyFbUIa
	A7d6YAXQdRX4lN9yru+vHN/1dXkLOySeboBeiB6xoPR//5duON5S6r5AtyWQEgAluCEL+Z6eP8W
	dEOQcB9GB5OS/hq7sEn+PE4JFVx5f7vsK2Oo9O4gTRRVEepZE+bF6c6cczgxrGEOhamxZOq4TDv
	ZZanc8W/Qdkw7jVAl4gLhUFM4xPMMepBFlzqfPrwVatQhAPkle3VU7jPFJwQrT1Pm0ePXbHkMn+
	TIHMctSCcAiwFI3KVpqqAktGs+ZiiRqCZtN+1VD6As3Oj5N/kZ1noZwKaWbj2bm7YDCgD5JKVo/
	lUc/ySKL/Nb18lG3C/h2cyOvMau3vrxvl+KUo8TCGd96UnV3vZUM8Gd1xFOzBEXn7yYc796L3Bj
	eVs+8AdFnu2F9uk//bZKA0BDrr6OzEE4xbMMpKoZjmzVb
X-Received: by 2002:a05:6a00:94c3:b0:8b6:54c2:a760 with SMTP id d2e1a72fcca58-8beb56c959emr4385424b3a.13.1794608225440;
        Fri, 13 Nov 2026 14:17:05 -0800 (PST)
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com. [74.125.82.177])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8bececce013sm1686016b3a.6.2026.11.13.14.17.03
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Nov 2026 14:17:03 -0800 (PST)
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-36f8cdd30beso740229eec.1
        for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 14:17:03 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErExSfaVlfiMetVuIm+01jNhNRBnEJiGBI4mad0PDyKz2PnEAMwg3AvPuU8FB7Ii4KVAMEnAmxA=@vger.kernel.org
X-Received: by 2002:a05:7300:c8c5:b0:379:e0a2:1a1 with SMTP id
 5a478bee46e88-379e0a20687mr2633403eec.35.1794608223266; Fri, 13 Nov 2026
 14:17:03 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261112-mxl-gsw1xx-reset-v3-0-863e82074893@telaak.dev>
 <a2f45802-b75b-4a19-9508-2d1b5ebe473a@lunn.ch> <avcoghKd4CU13QI_@makrotopia.org>
 <9804b024-236a-4791-aa55-d83a71b2598c@lunn.ch>
In-Reply-To: <9804b024-236a-4791-aa55-d83a71b2598c@lunn.ch>
From: Joseph Telaak <joseph@telaak.dev>
Date: Fri, 13 Nov 2026 17:16:51 -0500
X-Gmail-Original-Message-ID: <CAPY4CJ6jQTNE=ZtyBysaxuOxG1Pb9zFsYcyas8isfXte2=OiKw@mail.gmail.com>
X-Gm-Features: AclHuK_vNnHnvyeLRTaZ6xyALhnUZh809k3x2d0i8tHEQBpPdhifZW5Gb_-9a4A
Message-ID: <CAPY4CJ6jQTNE=ZtyBysaxuOxG1Pb9zFsYcyas8isfXte2=OiKw@mail.gmail.com>
Subject: Re: [PATCH net-next v3 0/2] net: dsa: mxl-gsw1xx: reset the switch
 through reset-gpios
To: Andrew Lunn <andrew@lunn.ch>
Cc: Daniel Golle <daniel@makrotopia.org>, Hauke Mehrtens <hauke@hauke-m.de>, 
	Vladimir Oltean <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, Nov 13, 2026 at 11:05:55PM +0100, Andrew Lunn wrote:
> > The driver does what is described in the device tree. Ie. boot firmware
> > applying a non-default PHY addresses should just say so in the DT passed
> > to Linux imho.
>
> And this is what i was wondering about. Is it the DT which is wrong,
> or the driver?

The DT. The driver assumes nothing about the addresses; the board's
device tree described the PHYs at their power-on addresses, 0 to 2.

The bootloader is GL.iNet's U-Boot, which is only available as a binary,
so I can't say why it moves them. On every boot it pulses the switch's
reset GPIO, sets up the switch, and leaves the GPHY of port N at MDIO
address N + 1, through the PHY_ADDR registers Daniel listed.

GL's own firmware deals with it the same way this series does: its
Linux driver pulses the reset GPIO at boot, and under that firmware
PHY_ADDR_0 to PHY_ADDR_3 read back 0 to 3.

I'm testing the other way now, with the PHYs described at 1 to 3 and no
reset from Linux. If that works on warm and cold boots, this series
isn't needed and I'll drop it. You were also right that 82e2c7db0830
had no place in the cover letter.

pw-bot: cr
