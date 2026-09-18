Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A688547070
	for <netdev@vger.kernel.org>; Fri, 18 Sep 2026 08:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789718905; cv=none; b=pJBin+0boiCcjUtBKnLhObEsz72zOaRo9kN5UFEi9KOemD/WtpjRM3dkpITM3tmNPEXQ6MVLUgK3SyTJ49brWl25FAJDmWtRdip3CnVE64qlcisCUlerPIqrQKuJhXMB0LJgXnvoePKcGDKi/hpJyBuiNNaVmpKtT7gzSZvBa0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789718905; c=relaxed/simple;
	bh=szW65OGngIrVZHSZp2aEQxc71UJrXouv/4OEN7SWrbc=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=YR+v7iobQ3HJefZ2TnktreFYm68B6oYmeAuVHd6YW70tVJGVo7QUU5kygEk1rK7d5WtWbnvdBxYynRHI9Khd2sZNoWrlpqDKgDodEEHincPVDHyuXsy19Tehg81XOfdC/VVUOnHUK94F4/I+bzH+ivsY0S23Qh2g8RoohH+a/uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=a04/KION; arc=none smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="a04/KION"
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c254f56039dso51878366b.3
        for <netdev@vger.kernel.org>; Fri, 18 Sep 2026 01:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1789718901; x=1790323701; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=zunp2CFFOV00BN1XGKfmZnDU8vHJVhqp2O/gTm8fQpA=;
        b=a04/KIONQos8BjkANIi94spNF+fH3cNdY6znpdkMoAfkKmE6CAPrl6kKJrWKjwSIur
         BPbtDHotW0a+znEgU3IBj+UtkcToQDKUutEOhdunldKYVOemKFONnP0aBqw6zDxmtVk5
         tM01VHi+tajgfEvGiNuFX9rMKYhh3YL6w2XzGXttRqBOwO3bH2esCE550DSyEvQX/Hqt
         MIcgiJkaO8c/JHJVLSy3fqD18i54sK7aVc2r1BKrdIRjiDY0sGjrR+OCYtwWGgScqX/T
         B5XQ+9HEm+m+2WJl3Xe/kLOEPZ8jGn8eE4bEKAWgbUZxpOV8p7Oc0/jblbEElhZM2F9c
         f5mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789718901; x=1790323701;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zunp2CFFOV00BN1XGKfmZnDU8vHJVhqp2O/gTm8fQpA=;
        b=X4p5gS/AL4VLxCWBN3mKbix/TAUbiip4R2g5sTZ4L90JG7S0ckmfjJWDFG3KoHrtVc
         u7BkkpBX3Y3LxgeFGZbMNBcOFUJi6cYDhcb9VtN+ydM8E1aop7Y01otxI9SQ0wZdLsu0
         ou4+CXl7K4AG4+FLPLr5aMoNbDu/aD9obimRrkwbunQsqBtCv8gyzcsQ0jjKA9CMJhGb
         c43Mez3pkcvmHcl7TgCocOUoTSfwnws8aU6htqPSdo8wMsue7BJ/SOzpyRexFgOpYXpa
         cFZougVskY1nEb1v2LGHfgl2XsNbB5IJh16ovAzHH0iVVKPQ4As+/BHEoQ9vLCKlQ/Ja
         uwNw==
X-Forwarded-Encrypted: i=1; AKwUvBx4Y4cbyNU/vak7dRXGke+hgqICiJY3PsuDl7IzZ60xnOr8yZFIu6mbsMBIUR+WCW7Dp/H6XUc=@vger.kernel.org
X-Gm-Message-State: AFuF++l3Cux7fW6VpfFooB334EhAeCwXhlk6YphfJ8ajZH85zCKiJBhu
	cBbnpYa38v9ddxanCtaSHGbqJgB5a25GJZz3GCCh/8UWVHecRFb/+7GkU97i2gzrtZs=
X-Gm-Gg: AYBFou1y2KUQ5D0B3uwTD3tSC87rom+wy4BhEI+yPo1iaiyOWthLxWdXYx3jKZ7T868
	VEfmqhK3kYWOLbrp0zLSp6F/cRpSdVTGgNm+HFFF9PX3CYoEbGEqYVHsDJ4awAknogl83WKdtW8
	THjnhiCosg/QYWXB49kiKXzgK6+IuEoYJNCIYbCNlOYq/Jsob0WA0mQKRC9erBtwgOEQb6INMmu
	dLtuRHI9v3GduDrBmd5HjZg7As246oxKEz+YgL0ZJ7na6B9iv2agCTE1eXQZgmWBtke+1mFae1j
	9Xg4XMe7o2ZoEkUYpwM2uN4fysBmPmQZHzSUlZ9TFABzJhMqXZndfqc15Gwpk4qfLIwSbZE7XZ8
	KR5TXf2RwNah9F3WyI7awRaLPlakEyckZB/oOeJ0rhIxte4CIkLvi207dbTw8ev1I/mlGY3qEb4
	s+6Oj5q0LNgeLoEX9nIZ1tYxgJss48O8Gt3oHKUvWb989uLiN/M8PpptVxTvFJaYTPm/M0Bt/65
	UFB1q8dmMu7KRt+VYUNoj9bTjRlzHx4Dy/3K+DoltZY
X-Received: by 2002:a17:906:9fcd:b0:c1c:2007:298e with SMTP id a640c23a62f3a-c2a15b33c9dmr191756766b.24.1789718901566;
        Fri, 18 Sep 2026 01:08:21 -0700 (PDT)
Received: from localhost (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2a1bb06bcbsm31932566b.12.2026.09.18.01.08.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Sep 2026 01:08:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 18 Sep 2026 10:08:20 +0200
Message-Id: <DLIAEGGE6ON6.TF50P7IWGBZO@fairphone.com>
Cc: "Krzysztof Kozlowski" <krzk@kernel.org>, "Konrad Dybcio"
 <konrad.dybcio@oss.qualcomm.com>, "Luca Weiss" <luca.weiss@fairphone.com>,
 "Dmitry Baryshkov" <dmitry.baryshkov@oss.qualcomm.com>,
 <oe-linux-nfc@lists.linux.dev>, <netdev@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-arm-msm@vger.kernel.org>
Subject: Re: [PATCH v4 0/3] nfc: st-nci: Fairphone 5 NFC bring-up (ST21NFCD)
From: "Luca Weiss" <luca.weiss@fairphone.com>
To: "Kristian Brox" <isyourbrainfoss@proton.me>, "David Heidelberg"
 <david@ixit.cz>, "Andrew Lunn" <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>, "Rob
 Herring" <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>,
 "Conor Dooley" <conor+dt@kernel.org>, "Bjorn Andersson"
 <andersson@kernel.org>, "Konrad Dybcio" <konradybcio@kernel.org>
X-Mailer: aerc 0.22.0-0-gc2f86b7abde3-dirty
References: <20260902-fp5-st21nfcd-v4-v4-0-ded2f1c501be@proton.me>
In-Reply-To: <20260902-fp5-st21nfcd-v4-v4-0-ded2f1c501be@proton.me>

Hi Kristian!

On Wed Sep 2, 2026 at 11:22 PM CEST, Kristian Brox wrote:
> This adds NFC on the Fairphone 5 (qcm6490). The board uses an ST21NFCD
> on I2C. That part speaks raw NCI; the current st-nci driver always
> wraps NDLC, so using st,st21nfcb-i2c leaves the adapter unusable.
>
> The series adds a st,st21nfcd compatible for the raw-NCI path and the
> Fairphone 5 DT node. Boards that already use st21nfcb / st21nfcc keep
> the NDLC path.
>
> Patches are against linux-nfc/for-next (Linux 7.3-rc1). Hardware test
> was on a Fairphone 5 running postmarketOS:
>
> - 7.1.2 sc7280, earlier raw-NCI modules: nfctool Powered: Yes;
>   initiator poll / neard: NTAG 215, NDEF URI read OK
> - 7.2.0-nfc-test+ (sc7280-mainline), this v4 st-nci as modules:
>   10x initiator poll finds Type 2 in 0.13-0.14 s, no
>   "unsupported ntf opcode 0xf02". Repeat poll with a Type 2 tag
>   in the field stays Powered: Yes. Empty-field poll SIGINT
>   (nfctool -p, no tag) also stays Powered: Yes.
>
> The ndlc: hexdumps are pr_debug. SIGINT during CORE_RESET (nfctool -0
> then Ctrl-C during -1) wedges stock nci core; that is not this series.
>
> ese-present and uicc-present follow the public schematic (NFC_SWP1/SWP2:
> SWP_SE to SIM1, SWP_UICC to SIM2). SE/HCE is not tested.
>
> CLK_REQ (GPIO 39) is omitted, as on Fairphone 6 NFC. VBAT and VDD_TX sit
> on VPH_PWR and are not modelled. VCC_UICC_IN (L4C) is not modelled;
> UICC SWP is untested.

Thanks for sending this revision!

Unfortunately I can still fairly easily reproduce to break scanning:

[  211.682211] nci: __nci_request: wait_for_completion_interruptible_timeou=
t failed 0
[  211.682246] nci: nci_start_poll: failed to set local general bytes
[  224.483009] nci: __nci_request: wait_for_completion_interruptible_timeou=
t failed 0
[  224.483033] nci: nci_start_poll: failed to set local general bytes

I enabled polling with neard, scanned the tag a bunch of time. Then
disable polling, and afterwards the errors above appeared and starting
polling again does not work anymore - until I reboot.

In fact, I can reproduce this just be enabling polling, disabling
polling and enabling polling again. No need to scan a tag inbetween.

Can you please share how you've been testing these patches?

Regards
Luca

>
> Signed-off-by: Kristian Brox <isyourbrainfoss@proton.me>
> ---
> Link to v3:
> https://lore.kernel.org/oe-linux-nfc/20260820-fp5-st21nfcd-v3-v3-0-5ee0a7=
f44d04@proton.me/
>
> Changes in v4:
> - Driver: consume ST proprietary RF NTF 0xf02 (Luca)
> - Driver: set raw_nci before nci_register_device (Sashiko / David)
> - Driver: enable vdd-io and SYS_CLK before driving reset
> - Driver: keep named i2c/acpi id initializers; do not add trailing
>   commas on existing of_match entries (David)
> - Driver: reset pulse uses gpiod_is_active_low so new DT can be
>   GPIO_ACTIVE_LOW without breaking old nfcb DTS (Krzysztof)
> - Binding: ST21NFCD is not I2C-only (data brief lists SPI); do not
>   put st,st21nfcd in the I2C-only spi-max-frequency:false enum
> - Binding: SPI $ref only in the non-I2C else (not a global allOf item)
> - Binding: clocks/vdd-io-supply on the existing I2C example; drop the
>   extra example (Krzysztof)
> - DTS: reset-gpios GPIO_ACTIVE_LOW (Krzysztof). Physical GPIO 38 HIGH
>   is the run level. Konrad R-b not carried (polarity changed).
>
> Changes in v3:
> - Binding: new compatible is a different ST part (not a driver-sharing no=
te)
> - Binding: drop NDLC/raw-NCI description on compatible
> - Binding example uses interrupts-extended
> - DTS: one nfc_default pinctrl group, pins sorted, no output-high
> - Fresh series (not a reply to v1/v2)
>
> Changes in v2:
> - Compatible is st,st21nfcd (no -i2c suffix)
> - Sent without PGP/MIME
> - DTS: interrupts-extended and pinctrl for IRQ/reset
> - DTS: ese-present / uicc-present (schematic)
> - DTS: SYS_CLK from LN_BB_CLK2, VPS_IO from L18B
> - Binding: optional clocks and vdd-io-supply
> - Driver: optional clk / vdd-io enable
>
> ---
> Kristian Brox (3):
>       dt-bindings: net: nfc: add st,st21nfcd
>       nfc: st-nci: add raw NCI path for ST21NFCD
>       arm64: dts: qcom: qcm6490-fairphone-fp5: add ST21NFCD NFC
>
>  .../devicetree/bindings/net/nfc/st,st-nci.yaml     | 49 +++++++++----
>  arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts | 34 ++++++++-
>  drivers/nfc/st-nci/core.c                          | 22 ++++++
>  drivers/nfc/st-nci/i2c.c                           | 82 ++++++++++++++++=
++++--
>  drivers/nfc/st-nci/ndlc.c                          | 27 +++++--
>  drivers/nfc/st-nci/ndlc.h                          |  5 +-
>  drivers/nfc/st-nci/se.c                            |  3 +
>  drivers/nfc/st-nci/spi.c                           |  2 +-
>  drivers/nfc/st-nci/st-nci.h                        |  2 +
>  9 files changed, 197 insertions(+), 29 deletions(-)
> ---
> base-commit: cee9395acd8043be0644b25c34bfa86623f2b935
> change-id: 20260902-fp5-st21nfcd-v4-1685be1d7c52
>
> Best regards,
> -- =20
> Kristian Brox <isyourbrainfoss@proton.me>


