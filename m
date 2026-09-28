Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFC363CFF49;
	Mon, 28 Sep 2026 10:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790589969; cv=none; b=o60qwyCY9blpwg3B63KW9OrHC2wI8qokwHw8+qlrSx9XT2W1QFE++KHYGhHEVMMCeoMarWpf8L+MezLtkDfKCVXqQFS1zKnnKrmFeJOjvxTFL28/S42Y/OyXyDHHZRZyget8DugXuldoL8AD+tQsnaLyTwtS6BO65Sij0a5KNzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790589969; c=relaxed/simple;
	bh=iyBg90rhNYMZ0lF7n77ILrmLoyNV4kWTKC6W6If7KH4=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=JHMhLhwH8AaCO/P80vH3K4eI0UfbuVYhUlVEzfuytJgFUBmHXI8W16Q4A26xhH/NaKubnIVlJiR6Bp/UmbTWXPCJG7NTx9GAF0AFlnCdKs89qmg8uhtNT4DKF6GN8sb/9W7sSxQ6xlrjwN8iTPlHH01uvYYwgp2kgypvRM2Ft6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=LfWe9CuT; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="LfWe9CuT"
Received: from smtp1.mailbox.org (unknown [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4htcQM4mNwzMlsr;
	Mon, 28 Sep 2026 12:06:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1790589963;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tGFurVbP493N/490Fhb5Hr/4heTMTyQicZ3pYUAmPTQ=;
	b=LfWe9CuTfOynItHAvtusxGosYzct2Hkmwp3DG70G6uT13/0UYJEAkMHfFlorz2rNhM0HOT
	XcHRkA99rrXtS+/nKUj+jPIQxxVUFtXQZEw9cUwni1WF/3LJF6AoK2kwLwIv0Nv3+8Qv4c
	oqz1ZcLjMmHiaymYWPxmKFci+OTkjMGoYJwwzXCWx0odnX36Jzf1YEq04ToLKkjqaMpvv1
	FbirJZKNJb/7MEwqFl37yhKTFphY00cQRFgnL36VrjJlrgOvnc+I5gxIKokI1NJeQZEe9t
	Ey8T7b5j7GVz1oNZ1H4L5Zu3yvyeSiDxUR3di4/9OzeuV0FwrS+jhAEN0XgZiA==
Date: Mon, 28 Sep 2026 12:05:57 +0200
From: Simon Polack <spolack+git@mailbox.org>
To: Javen <javen_xu@realsil.com.cn>,
 "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
 "hkallweit1@gmail.com" <hkallweit1@gmail.com>,
 "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
 "davem@davemloft.net" <davem@davemloft.net>,
 "edumazet@google.com" <edumazet@google.com>,
 "kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
 "robh@kernel.org" <robh@kernel.org>,
 "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
 "conor+dt@kernel.org" <conor+dt@kernel.org>
CC: "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
 "chad@monroe.io" <chad@monroe.io>,
 "vladimir.oltean@nxp.com" <vladimir.oltean@nxp.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: =?US-ASCII?Q?RE=3A_=5BPATCH_net-next_3/3=5D_net=3A_phy=3A_re?=
 =?US-ASCII?Q?altek=3A_add_LED_support_for_RTL8261C/D?=
In-Reply-To: <ee6ee488e3884540a82cfab11fb36ba3@realsil.com.cn>
References: <20260921161817.565185-1-spolack+git@mailbox.org> <20260921161817.565185-4-spolack+git@mailbox.org> <ee6ee488e3884540a82cfab11fb36ba3@realsil.com.cn>
Message-ID: <DA7B6920-B0DF-4B27-A3B3-719FFBF86002@mailbox.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-MBO-RS-META: 5kk4dr5pnjzgyakceec5gixr6kabb1dj
X-MBO-RS-ID: 7a1d4e9d2e044f8e8ee

Resending text-encoded:

Hi Javen,

Thanks for reviewing=2E

Could you clarify "configured via firmware"? Neither rtl8261c=2Ebin nor
rtl8261d=2Ebin in linux-firmware writes the LED block (0xd032 + 2 *
index, 0xd040, 0xd044), directly or through the 0xa436/0xa438 window=2E

The driver already configures LEDs from the kernel on the RTL8211E/F
and RTL8221B, and the RTL8221B uses the same VEND2 block this patch
drives=2E

The layout was confirmed on an RTL8261CE here, and Chad (CC'd) reports
it working on RTL8261C and RTL8261D boards=2E If it differs on a variant
the driver binds, which one? I'll restrict the callbacks accordingly=2E

Simon

Am 28=2E September 2026 09:23:37 MESZ schrieb Javen <javen_xu@realsil=2Eco=
m=2Ecn>:
>>The RTL8261C/D use the same LED register block as the RTL8221B: one cont=
rol
>>register per LED at VEND2 0xd032 + 2 * index selecting the link speeds t=
hat light
>>it, activity blink bits in LCR6 and per-LED polarity and enable bits in =
LCR7=2E
>>Compared to the RTL8221B there are four LEDs instead of three, and two m=
ore
>>speed bits for 5G and 10G=2E
>>
>>Reuse the existing RTL822X_VND2_* definitions and add the two speed bits
>>and the enable bit=2E The callbacks follow rtl822xb_led_*() closely, wit=
h two
>>additions:
>>
>> - led_polarity_set() honours active-low LEDs=2E The polarity bit in LCR=
7
>>   doubles as the manual on/off level in led_brightness_set(), so the
>>   configured polarity is cached in the private data and restored by
>>   led_hw_control_set()=2E
>>
>> - led_hw_control_set() and led_brightness_set() set the output enable
>>   bit, which firmware normally leaves set already=2E
>>
>>The callbacks duplicate most of rtl822xb_led_*(), differing only in the =
LED
>>count, the speed mask and the LCR7 handling=2E Making the RTL8221B code
>>table-driven and sharing it would be the right end state, but that touch=
es a
>>working driver and wants testing on an RTL8221B, so it is left for a fol=
low-up
>>series=2E
>>
>>The callbacks are wired to the RTL8261C_CG and RTL8261CE_CG entries, whi=
ch
>>between them cover the parts this was tested on=2E RTL8261D_VM is left o=
ut for
>>lack of hardware=2E
>>
>>Tested on a Gemtek W1700K (Airoha AN7581) with an RTL8261CE: index 2
>>drives a yellow and index 3 a green LED on each 10G port=2E Under hardwa=
re
>>control the link speed bits, the activity blink and the combined
>>TRIGGER_NETDEV_LINK all take effect and offloading is confirmed through =
the
>>netdev trigger=2E The polarity bit was verified to be active-high when c=
lear on that
>>board=2E Also tested on AN7581 and MT7988A boards with an RTL8261C and
>>RTL8261D=2E
>>
>>Signed-off-by: Chad Monroe <chad@monroe=2Eio>
>>Co-developed-by: Simon Polack <spolack+git@mailbox=2Eorg>
>>Signed-off-by: Simon Polack <spolack+git@mailbox=2Eorg>
>>Assisted-by: LLM
>>---
>> drivers/net/phy/realtek/realtek_main=2Ec | 228
>>+++++++++++++++++++++++++
>> 1 file changed, 228 insertions(+)
>>
>>diff --git a/drivers/net/phy/realtek/realtek_main=2Ec
>>b/drivers/net/phy/realtek/realtek_main=2Ec
>>index 04d397f0a2d8=2E=2Eb1f020aa7760 100644
>>--- a/drivers/net/phy/realtek/realtek_main=2Ec
>>+++ b/drivers/net/phy/realtek/realtek_main=2Ec
>>@@ -183,12 +183,15 @@
>> #define RTL822X_VND2_LCR_LINK_100              BIT(1)
>> #define RTL822X_VND2_LCR_LINK_1000             BIT(2)
>> #define RTL822X_VND2_LCR_LINK_2500             BIT(5)
>>+#define RTL822X_VND2_LCR_LINK_5000             BIT(6)
>>+#define RTL822X_VND2_LCR_LINK_10000            BIT(4)
>>
>> #define RTL822X_VND2_LCR6                      0xd040
>> #define RTL822X_VND2_LED_ACT(x)                        BIT(x)
>>
>> #define RTL822X_VND2_LCR7                      0xd044
>> #define RTL822X_VND2_LED_POLAR(x)              BIT(x)
>>+#define RTL822X_VND2_LED_EN(x)                 BIT((x) + 4)
>>
>> #define RTL8224_MII_RTCT                       0x11
>> #define RTL8224_MII_RTCT_ENABLE                        BIT(0)
>>@@ -305,6 +308,7 @@
>> #define FW_SUB_MAGIC_8261D             0x32363144
>> #define RTL8261X_POLL_TIMEOUT_MS       100
>> #define RTL8261X_MAX_MMD_DEV           31
>>+#define RTL8261X_LED_COUNT             4
>
>Hi,
>
>We kindly suggest dropping this patch for the same reason as in Patch 2/3=
=2E
>
>LED config is related to HW config and will be configured via firmware=2E
>
>BRs,
>Javen
