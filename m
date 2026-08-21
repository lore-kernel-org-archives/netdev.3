Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECD0846C830
	for <netdev@vger.kernel.org>; Fri, 21 Aug 2026 09:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787304517; cv=none; b=Sb87nNN05vNwcqBBI6LMghepPUfof0XAj5vE1qKyALZtjMiTpQXbVpDXZx3qnojVwpSDX95r3GEozV3ypyF01h7bzaCc6j7Lbe6QIkRG/iMWmgyaDqnibZ1V0D9/QLNPfspq2BN27N1obyET3WzrhZEGgVwKSvD2PxMyud0XcKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787304517; c=relaxed/simple;
	bh=WAufh72lblmlbrc/jJjjNeihtv2Y1ow86BPrCYh8M/o=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=rnOSrKffjnBPBfE7PZ8cnUqwH8xEaVMWnlcqXPC/2dKrNygrXuvkrZ/wp2qtfmgmEPgzOe+b2JN2SXpnX0uJTblCkPuuKxdHpASbn/GillnuF6IKDbNNrIYNDqqMpGxffMjeY5C62/JLnJ9vXbycbqpAi+6afQ7aA8qy79bifdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=eglJmDfM; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="eglJmDfM"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-c1600d040e4so118466166b.1
        for <netdev@vger.kernel.org>; Fri, 21 Aug 2026 02:28:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1787304504; x=1787909304; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=q5vpbeop/A9Sj3kOt1ydYSMTNnRoxXgWkRv8uWD/3es=;
        b=eglJmDfMIAJtqTtXJgPsupbJqigrC7M7YH2H+f3x63Hdefm9pClDMrKI6k66FpX9hw
         Jeke288jQvfp7nVAVcKopnZXg86vD3NaF1BQEpMrHG1nCZt+dAUCabMu/tKJVZDkBBp1
         OQrMEdxuQYPfkx/j+bVvnLNmWwGSMG0CtelZJgPOc6WaHGA99Yh93rcehlyP5Ac6EZrU
         4yt1AwOl/aum/FS9yBJodwhMruEQtRHQRKuBuPNHcg7XyozbXr6c5Hik5rq8AwUYZuxt
         sJgWXjmFrfMiOIdkzJCOx/tIbnxGBudYVLdL+ZFE7ySfPSXS7AML//L5nMlM+R1Q19CB
         9QgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787304504; x=1787909304;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=q5vpbeop/A9Sj3kOt1ydYSMTNnRoxXgWkRv8uWD/3es=;
        b=POU60xolW/dX2QX493ImM01k8XGO6yGLiWS66Lsi/D5S2wLKQUo3wVo7MP8/eXdl7V
         tTGWFH3sKytui9dbSShgDUyB3ZYQVeU09X74acPq3tIPDUcNpjkTHo/uHUxinnGTymBE
         Lpoh9+P5Jz7wtCwql7w17qT/KQBzFbXm3PpWgdSD5yuJK3pCt6NYFmd/uMQJoUgJUvnA
         ljdXVd1BWvS6VW4dLBahKu3oTCNacq3Sw8KJW9ysOFbQBXz+6rRc9EYGZg2MFjtrESsO
         2YVU768p3i6aSG5HxSthAODlvERhMw5tG5TEz9tsrfw+7GMt9dZDfdaW94D/Ff0X2G+a
         tVWQ==
X-Forwarded-Encrypted: i=1; AHgh+RoYyzbKhdcY6drZ7lETbsBan/0AORPkjdqXNmXN3lQTagg+Xi18DOqMSTaX3bIv9nUNZWaNSbw=@vger.kernel.org
X-Gm-Message-State: AFuF++mcj26lzh/HMupZhIB0P1jIurasoq/WuRd4XCXDvQopBrBvA04I
	WRQKd67XDVvj7RODEcMoDkS9nWm2/91JqHlGbnKhp9evEGgwFhnqId+/vr5qpTS8Sfk=
X-Gm-Gg: AR+sD11R9IHGm5u0kjAxyhZIkGmyCkA86b8NSAceUVPz7bUx60XMGyY+vCAmiyNEHfk
	+w/e18EmIofrfowPz16kchHDdzjDTlr/s2MBF+TzegwwO8wyfT4yYRU1OE34RRU429yTXQyfbgm
	OCUEGX1iBk8WiaBbOrunUZS2+chX5Wytm7s1rJ3+EE2K3mFLGCqKG7LO6Dt5NtRRE37Ki/YGYfE
	d05znW5Naz3lP8Jqw5K7Oy9DL7U03FJ73bKFidb4iusORDMSHfJEIWBCfcBmECAbz5I3gii7hEE
	q/IhJv7eY5h6jhhg706h9ltT31BjeC7V7XQU8IhC/+WYJbunMOiLxGlu9d+R+sLKqoxpuBdBoB0
	y8I/mgdFywBA6XsQ2Ap/dxL0Zcmrh8NF9G50j9JDOB35m1jEahG5VCQLK5NLJGmxYqPnfb9tjjO
	tR1hboma0fogrTJmXgTrahslLCjQHJ60qJRkRT+8XXDcy1AsNnt6Mv/6FMa0WBjT3Z1FbzRNR9g
	gQ56WxHUhT76GzbG0zpQ0Orc43OUbjFyg==
X-Received: by 2002:a17:906:fe0e:b0:c15:c323:36e5 with SMTP id a640c23a62f3a-c244d7194bfmr930680866b.10.1787304503694;
        Fri, 21 Aug 2026 02:28:23 -0700 (PDT)
Received: from localhost (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2458b096d9sm442131366b.20.2026.08.21.02.28.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Aug 2026 02:28:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 21 Aug 2026 11:28:22 +0200
Message-Id: <DKUIKHDS44LA.10CHEGZHLQSNS@fairphone.com>
Cc: "Krzysztof Kozlowski" <krzk@kernel.org>, "Luca Weiss"
 <luca.weiss@fairphone.com>, "Dmitry Baryshkov"
 <dmitry.baryshkov@oss.qualcomm.com>, <oe-linux-nfc@lists.linux.dev>,
 <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>
Subject: Re: [PATCH v3 0/3] nfc: st-nci: Fairphone 5 NFC bring-up (ST21NFCD)
From: "Luca Weiss" <luca.weiss@fairphone.com>
To: "Kristian Brox" <isyourbrainfoss@proton.me>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260820-fp5-st21nfcd-v3-v3-0-5ee0a7f44d04@proton.me>
In-Reply-To: <20260820-fp5-st21nfcd-v3-v3-0-5ee0a7f44d04@proton.me>

Hi Kristian,

On Thu Aug 20, 2026 at 10:56 PM CEST, Kristian Brox wrote:
> This adds NFC on the Fairphone 5 (qcm6490). The board uses an ST21NFCD
> on I2C. That part speaks raw NCI; the current st-nci driver always
> wraps NDLC, so using st,st21nfcb-i2c leaves the adapter unusable.
>
> The series adds a st,st21nfcd compatible for the raw-NCI path and the
> Fairphone 5 DT node. Boards that already use st21nfcb / st21nfcc keep
> the NDLC path.
>
> Patches are against linux-nfc/for-next (v7.2-rc7). Hardware test was on
> a Fairphone 5 running postmarketOS, with these changes as modules on a
> 7.1.2 sc7280 kernel:
>
> - nfctool: Powered: Yes
> - initiator poll / neard: NTAG 215, NDEF URI read OK
>
> ese-present and uicc-present follow the public schematic (NFC_SWP1/SWP2:
> SWP_SE to SIM1, SWP_UICC to SIM2). SE/HCE is not tested.
>
> CLK_REQ (GPIO 39) is omitted, as on Fairphone 6 NFC. VBAT and VDD_TX sit
> on VPH_PWR and are not modelled. VCC_UICC_IN (L4C) is not modelled;
> UICC SWP is untested.

Thanks for working on NFC!

Unfortunately it doesn't really seem to work for me, based on v7.2
kernel.

When running "sudo nfctool -d nfc0 -1 -p", the dmesg gets a bunch of
spam:

[   29.097978] ndlc: 00000000: 20 00 01 01
[   29.100953] ndlc: 00000000: 60 00 1f 01 01 20 02 1a 04 04 01 20 92 80 02=
 03
[   29.100969] ndlc: 00000010: 01 59 c0 cf fd 59 c0 89 7f 00 00 00 01 00 00=
 6d
[   29.100974] ndlc: 00000020: 3b 02
[   29.103348] ndlc: 00000000: 6f 02 0c 11 20 00 07 07 02 cf fd 00 00 01 03
[   29.103470] nci: nci_ntf_packet: unsupported ntf opcode 0xf02
[   29.104136] ndlc: 00000000: 40 00 01 00
[   29.104308] ndlc: 00000000: 20 01 02 00 00
[   29.107831] ndlc: 00000000: 60 00 1f 02 01 20 02 1a 04 04 01 20 92 80 02=
 03
[   29.107866] ndlc: 00000010: 01 59 c0 cf fd 59 c0 89 7f 00 00 00 01 00 00=
 6d
[   29.107871] ndlc: 00000020: 3b 02
[   29.110353] ndlc: 00000000: 6f 02 0c 11 20 00 07 07 02 cf fd 00 00 4b 6b
[   29.110474] nci: nci_ntf_packet: unsupported ntf opcode 0xf02
[   29.113292] ndlc: 00000000: 40 01 18 00 1a 7e 06 00 02 00 02 ff ff 00 0c=
 01
[   29.113307] ndlc: 00000010: 05 01 00 02 00 03 00 00 00 90 00
[   29.113471] ndlc: 00000000: 21 00 01 00
[   29.114311] ndlc: 00000000: 60 06 03 01 01 01
[   29.115856] ndlc: 00000000: 41 00 01 00
[   29.115937] ndlc: 00000000: 22 00 01 01
[   29.117507] ndlc: 00000000: 42 00 02 00 02
[   29.117599] ndlc: 00000000: 20 02 14 01 29 11 46 66 6d 01 01 11 04 01 96=
 03
[   29.117603] ndlc: 00000010: 02 00 01 02 02 07 ff
[   29.118976] ndlc: 00000000: 62 00 08 81 01 00 01 03 01 02 00
[   29.122709] ndlc: 00000000: 62 00 08 83 01 00 01 03 01 02 00
[   29.123604] ndlc: 00000000: 40 02 02 00 00
[   29.124294] ndlc: 00000000: 20 02 14 01 61 11 46 66 6d 01 01 11 04 01 96=
 03
[   29.124305] ndlc: 00000010: 02 00 01 02 02 07 ff
[   29.127697] ndlc: 00000000: 40 02 02 00 00
[   29.128139] ndlc: 00000000: 21 03 09 04 00 01 01 01 02 01 06 01
[   29.130378] ndlc: 00000000: 41 03 01 00
[   29.133173] ndlc: 00000000: 6f 02 09 11 20 00 16 04 00 00 63 6b
[   29.133247] nci: nci_ntf_packet: unsupported ntf opcode 0xf02
[   29.143965] ndlc: 00000000: 6f 02 13 11 20 00 12 04 00 00 65 5b 0a 08 01=
 00
[   29.143989] ndlc: 00000010: 01 52 00 00 6a 6d
[   29.144936] nci: nci_ntf_packet: unsupported ntf opcode 0xf02
[   29.153545] ndlc: 00000000: 6f 02 0f 11 20 00 0a 0a 07 00 03 05 00 08 00=
 00
[   29.153634] ndlc: 00000010: 70 74
[   29.154439] nci: nci_ntf_packet: unsupported ntf opcode 0xf02
[   29.182777] ndlc: 00000000: 6f 02 11 11 20 00 0a 0c 19 00 05 00 ff ff 00=
 03
[   29.182801] ndlc: 00000010: 00 00 8f 10
[   29.182868] nci: nci_ntf_packet: unsupported ntf opcode 0xf02
[   29.196213] ndlc: 00000000: 6f 02 0a 11 20 00 0a 05 0a 00 00 9b 4b
[   29.196414] nci: nci_ntf_packet: unsupported ntf opcode 0xf02
[   29.206067] ndlc: 00000000: 6f 02 09 11 20 00 13 04 00 00 9d 47
[   29.206740] nci: nci_ntf_packet: unsupported ntf opcode 0xf02
[   29.586059] dw9719 17-000e: Error writing reg 0x0002: -6
[   30.100584] ndlc: 00000000: 6f 02 09 11 20 00 12 04 00 03 a7 f5
[   30.100662] nci: nci_ntf_packet: unsupported ntf opcode 0xf02
[   30.110815] ndlc: 00000000: 6f 02 0d 11 20 00 0a 08 01 00 01 52 00 03 ad=
 07
[   30.111019] nci: nci_ntf_packet: unsupported ntf opcode 0xf02
[   30.120807] ndlc: 00000000: 6f 02 0f 11 20 00 0a 0a 07 00 03 05 00 08 00=
 03
[   30.120828] ndlc: 00000010: b3 0d
[   30.120899] nci: nci_ntf_packet: unsupported ntf opcode 0xf02
[   30.149554] ndlc: 00000000: 6f 02 11 11 20 00 0a 0c 19 00 05 00 ff ff 00=
 03
[   30.149574] ndlc: 00000010: 00 03 d1 a8
[   30.149649] nci: nci_ntf_packet: unsupported ntf opcode 0xf02
[   30.163030] ndlc: 00000000: 6f 02 0a 11 20 00 0a 05 0a 00 03 dd e2
[   30.163100] nci: nci_ntf_packet: unsupported ntf opcode 0xf02
[   30.172938] ndlc: 00000000: 6f 02 09 11 20 00 13 04 00 03 df df
[   30.172998] nci: nci_ntf_packet: unsupported ntf opcode 0xf02
[   31.065969] ndlc: 00000000: 6f 02 09 11 20 00 12 04 00 06 e9 b2
[   31.066050] nci: nci_ntf_packet: unsupported ntf opcode 0xf02
[   31.076104] ndlc: 00000000: 6f 02 0d 11 20 00 0a 08 01 00 01 52 00 06 ee=
 c4
[   31.076513] nci: nci_ntf_packet: unsupported ntf opcode 0xf02
[   31.086223] ndlc: 00000000: 6f 02 0f 11 20 00 0a 0a 07 00 03 05 00 08 00=
 06
[   31.086273] ndlc: 00000010: f4 cb
[   31.086933] nci: nci_ntf_packet: unsupported ntf opcode 0xf02
[   31.114930] ndlc: 00000000: 6f 02 11 11 20 00 0a 0c 19 00 05 00 ff ff 00=
 03
[   31.114962] ndlc: 00000010: 00 07 13 69
[   31.115044] nci: nci_ntf_packet: unsupported ntf opcode 0xf02
[   31.128340] ndlc: 00000000: 6f 02 0a 11 20 00 0a 05 0a 00 07 1f a4
[   31.128410] nci: nci_ntf_packet: unsupported ntf opcode 0xf02
[   31.138209] ndlc: 00000000: 6f 02 09 11 20 00 13 04 00 07 21 a0
[   31.138278] nci: nci_ntf_packet: unsupported ntf opcode 0xf02
[   32.031735] ndlc: 00000000: 6f 02 09 11 20 00 12 04 00 0a 2a cf
[   32.032139] nci: nci_ntf_packet: unsupported ntf opcode 0xf02
[   32.041357] ndlc: 00000000: 6f 02 0d 11 20 00 0a 08 01 00 01 52 00 0a 2f=
 e1
[   32.041713] nci: nci_ntf_packet: unsupported ntf opcode 0xf02
[   32.051198] ndlc: 00000000: 6f 02 0f 11 20 00 0a 0a 07 00 03 05 00 08 00=
 0a
[   32.051227] ndlc: 00000010: 35 e7
[   32.051575] nci: nci_ntf_packet: unsupported ntf opcode 0xf02
[   32.080201] ndlc: 00000000: 6f 02 11 11 20 00 0a 0c 19 00 05 00 ff ff 00=
 03
[   32.080221] ndlc: 00000010: 00 0a 54 88
[   32.080603] nci: nci_ntf_packet: unsupported ntf opcode 0xf02
[   32.093508] ndlc: 00000000: 6f 02 0a 11 20 00 0a 05 0a 00 0a 60 c4
[   32.093893] nci: nci_ntf_packet: unsupported ntf opcode 0xf02
[   32.103180] ndlc: 00000000: 6f 02 09 11 20 00 13 04 00 0a 62 c0
[   32.103507] nci: nci_ntf_packet: unsupported ntf opcode 0xf02
[   32.995129] ndlc: 00000000: 6f 02 09 11 20 00 12 04 00 0d 6b f2
[   32.995544] nci: nci_ntf_packet: unsupported ntf opcode 0xf02
[   33.005468] ndlc: 00000000: 6f 02 0d 11 20 00 0a 08 01 00 01 52 00 0d 71=
 04
[   33.005574] nci: nci_ntf_packet: unsupported ntf opcode 0xf02
[   33.015571] ndlc: 00000000: 6f 02 0f 11 20 00 0a 0a 07 00 03 05 00 08 00=
 0d
[   33.015591] ndlc: 00000010: 77 0a
[   33.015684] nci: nci_ntf_packet: unsupported ntf opcode 0xf02
[   33.044216] ndlc: 00000000: 6f 02 11 11 20 00 0a 0c 19 00 05 00 ff ff 00=
 03
[   33.044237] ndlc: 00000010: 00 0d 95 ac
[   33.044606] nci: nci_ntf_packet: unsupported ntf opcode 0xf02
[   33.057961] ndlc: 00000000: 6f 02 0a 11 20 00 0a 05 0a 00 0d a1 e8
[   33.058351] nci: nci_ntf_packet: unsupported ntf opcode 0xf02
[   33.067653] ndlc: 00000000: 6f 02 09 11 20 00 13 04 00 0d a3 e4
[   33.068030] nci: nci_ntf_packet: unsupported ntf opcode 0xf02
[   33.476119] ndlc: 00000000: 21 06 01 00
[   33.479380] ndlc: 00000000: 41 06 01 00
[   33.481131] ndlc: 00000000: 6f 02 09 11 20 00 17 04 00 0f 0e e1
[   33.481217] nci: nci_ntf_packet: unsupported ntf opcode 0xf02

Sometimes my simple NFC tag seems to be detected, but it sometimes takes
quite a while. And starting and stopping (Ctrl-C) the nfctool process
doesn't make it any better, it quickly gets into an error state.

Can you please confirm how you tested this on your side, and if I'm
maybe missing some parts?

Regards
Luca

> To/Cc from scripts/get_maintainer.pl via b4 prep --auto-to-cc on this tre=
e.
>
> Changes in v3:
> - Binding: new compatible is a different ST part (not a driver-sharing no=
te)
> - Binding: drop NDLC/raw-NCI description on compatible
> - Binding example uses interrupts-extended
> - DTS: one nfc_default pinctrl group, pins sorted, no output-high
> - No In-Reply-To; To/Cc from get_maintainer.pl on linux-nfc/for-next
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
> Signed-off-by: Kristian Brox <isyourbrainfoss@proton.me>
> ---
> Kristian Brox (3):
>       dt-bindings: net: nfc: add st,st21nfcd
>       nfc: st-nci: add raw NCI path for ST21NFCD
>       arm64: dts: qcom: qcm6490-fairphone-fp5: add ST21NFCD NFC
>
>  .../devicetree/bindings/net/nfc/st,st-nci.yaml     | 31 ++++++++
>  arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts | 34 ++++++++-
>  drivers/nfc/st-nci/core.c                          |  5 ++
>  drivers/nfc/st-nci/i2c.c                           | 87 ++++++++++++++++=
+++---
>  drivers/nfc/st-nci/ndlc.c                          | 23 ++++--
>  drivers/nfc/st-nci/ndlc.h                          |  2 +
>  drivers/nfc/st-nci/se.c                            |  3 +
>  7 files changed, 166 insertions(+), 19 deletions(-)
> ---
> base-commit: 9f69d05b5a85c417c73fa2d5c7a2d507ac81cf4b
> change-id: 20260820-fp5-st21nfcd-v3-bde6c248beed
>
> Best regards,
> -- =20
> Kristian Brox <isyourbrainfoss@proton.me>

