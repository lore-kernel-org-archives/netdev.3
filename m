Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C425486E43;
	Mon, 28 Sep 2026 10:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790589799; cv=none; b=tFEaJCvxpTXTmgsxgDXKB5Q1YupDV7VGlnOTQlYL7ELvZYvMVXsxWXq9QBFAQ60WK6ykvKnMewosbYGaHh9X2Uo9l55Ofq4tZYexZwL8JbCYq1On2M4Em1nSZBxqfqUYXQADdMhK+eAaMn811m+xH1gjCwUpk/xDQqS6V6e/nuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790589799; c=relaxed/simple;
	bh=xwltgeZuIFA1I8/KesOK5vZWkR2IGXcwT7KCRHsc90I=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=IcCAaMi6ZJGZ2CdYUAf1tjGimnDFwknQqgZkXP8e5azfOSk5ST2NmPSupKS5kW3cjUCnH+v2HFmCiHtQwbYIDMKiWm1BOBqody3+yutYSMWYImEn9z3Q+HgyQ/fBUtRclKYP+8bpf7Y8RbVA8PZmUp1oE3kqJMG4Ixy8+6WnCPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=miX2/bfW; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="miX2/bfW"
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4htcLw0x9lz8sxG;
	Mon, 28 Sep 2026 12:03:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1790589784;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1sXVg7Ci5V2jdH/wH02K/kcVeH6gXtwmRVxLnDSbfFw=;
	b=miX2/bfWYEr/utLcZu9QUFElKWoFBEPyHKjT5rKGKHd+6NPQBQIIgP+FjiSKvZN+5ew20G
	AXxQrfENlN9/Rh8Y7VjrsBag03uLZ0JWamd5ePpTZy3yJEST349gO9WNreoCJuggVH5eZS
	mWQ+zu5j9BN4C29lvftqZpfdSF+XSqYsrGT8wnGhUyZizD52ZClnmpXsU2ZHvCAXY7p+Pc
	MB6H+an1qxOjwzSRs2y0sucfcJJnqyofYRvPAkNk1iRkXUz2AHMsYZrMRyKj08lXumbfbT
	L7j7JFWBc+AAK0h6XkXc9xCSW8PkGt6wS3IvrFjX7jtf2o8RwfFRBSMX+NY8Rw==
Date: Mon, 28 Sep 2026 12:02:56 +0200
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
Subject: =?US-ASCII?Q?RE=3A_=5BPATCH_net-next_2/3=5D_net=3A_phy=3A_realtek?=
 =?US-ASCII?Q?=3A_apply_SerDes_lane_polarity_on_RTL8261C/D?=
In-Reply-To: <8d7917660a9c4718ad1efe8b3e8e1f80@realsil.com.cn>
References: <20260921161817.565185-1-spolack+git@mailbox.org> <20260921161817.565185-3-spolack+git@mailbox.org> <8d7917660a9c4718ad1efe8b3e8e1f80@realsil.com.cn>
Message-ID: <C3E32A3E-1837-45C1-918B-734579E66D53@mailbox.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-MBO-RS-META: 8a8rwpeegprbikzuyyqrtk9ah6dtja6k
X-MBO-RS-ID: 2870141ed4e034f1ed2

Resending text-encoded:

Hi Javen,

Thanks for reviewing=2E

On scope: this patch only affects the parts the driver binds, PHY IDs
0x001cc898, 0x001cc899 and 0x001cc89a=2E The RTL8261N (0x001ccaf3) isn't
supported upstream and isn't touched=2E

Understood on the revision dependence=2E The problem remains that the
W1700K routes the lanes inverted, and without programming the polarity
its 10G ports never link=2E How should such a board be supported?

If there is a supported way to set lane polarity - a register the
driver writes and the PHY firmware acts on, so the control flow stays
with the hardware - I'd gladly use that instead of the direct SerDes
access=2E Otherwise the alternative I see is restricting the patch to
the verified variant (0x001cc899, sub-model 0x00) and leaving every
other part untouched=2E

Simon

Am 28=2E September 2026 09:17:00 MESZ schrieb Javen <javen_xu@realsil=2Eco=
m=2Ecn>:
>>
>>Boards such as the Gemtek W1700K (Airoha AN7581) route the USXGMII lanes
>>between the SoC and the PHY inverted and describe that in the device tre=
e with
>>the generic tx-polarity/rx-polarity properties=2E
>>Nothing in the RTL8261C/D driver reads them and the Airoha PCS has no
>>polarity handling of its own, so the inversion is never programmed=2E
>>The copper side negotiates normally while the SerDes never trains and th=
e
>>netdev stays NO-CARRIER=2E
>>
>>Lane polarity on this part lives behind the same VEND1 SerDes command
>>window the RTL822x code already uses for in-band autoneg, in SerDes regi=
sters
>>0x0000 (bits 9:8) and 0x00c2 (bits 14:13)=2E The register at
>>VEND1 0xc1 that some other Realtek 10G PHYs use for the same purpose is =
not
>>implemented on this die and reads back as zero after a write=2E
>>
>>Add a read side and a read-modify-write helper to the command window,
>>move rtl822x_serdes_write() up next to them so all three are visible fro=
m the
>>RTL8261 code, apply the polarity from config_init() and select
>>PHY_COMMON_PROPS for the property helpers=2E Only lanes actually describ=
ed
>>in the firmware node are touched; a board without the properties keeps
>>whatever the boot loader and the PHY firmware left in place=2E
>>
>>The bit assignment has been verified on an RTL8261CE (sub-model 0x00, PH=
Y
>>ID 0x001cc899): on the W1700K, SerDes register 0x0000 goes from
>>0x1403 to 0x1703 and 0x00c2 from 0x0000 to 0x6000, after which VEND1
>>0x758d reports the SerDes linked (0x0010 -> 0x001e) and the link comes u=
p at
>>1G and 10G and passes traffic=2E The RTL8261C, RTL8261D and RTL8261D_VM
>>share rtl8261x_config_init() and get the same treatment, but have not be=
en
>>tested with inverted lanes=2E
>>
>>Assisted-by: LLM
>>Signed-off-by: Simon Polack <spolack+git@mailbox=2Eorg>
>>---
>> drivers/net/phy/realtek/Kconfig        |   1 +
>> drivers/net/phy/realtek/realtek_main=2Ec | 174 +++++++++++++++++++++---=
-
>> 2 files changed, 148 insertions(+), 27 deletions(-)
>>
>>diff --git a/drivers/net/phy/realtek/Kconfig b/drivers/net/phy/realtek/K=
config
>>index a741b34d193e=2E=2Ea9272aebe26d 100644
>>--- a/drivers/net/phy/realtek/Kconfig
>>+++ b/drivers/net/phy/realtek/Kconfig
>>@@ -1,6 +1,7 @@
>> # SPDX-License-Identifier: GPL-2=2E0-only  config REALTEK_PHY
>>        tristate "Realtek PHYs"
>>+       select PHY_COMMON_PROPS
>>        select PHY_PACKAGE
>>        help
>>          Currently supports RTL821x/RTL822x and fast ethernet PHYs diff=
 --git
>>a/drivers/net/phy/realtek/realtek_main=2Ec
>>b/drivers/net/phy/realtek/realtek_main=2Ec
>>index 1e670638dd1c=2E=2E04d397f0a2d8 100644
>>--- a/drivers/net/phy/realtek/realtek_main=2Ec
>>+++ b/drivers/net/phy/realtek/realtek_main=2Ec
>>@@ -13,9 +13,11 @@
>> #include <linux/firmware=2Eh>
>> #include <linux/of=2Eh>
>> #include <linux/phy=2Eh>
>>+#include <linux/phy/phy-common-props=2Eh>
>> #include <linux/pm_wakeirq=2Eh>
>> #include <linux/netdevice=2Eh>
>> #include <linux/module=2Eh>
>>+#include <linux/property=2Eh>
>> #include <linux/delay=2Eh>
>> #include <linux/clk=2Eh>
>> #include <linux/string_choices=2Eh>
>>@@ -164,6 +166,7 @@
>> #define   RTL822X_VND1_SERDES_INBAND_DISABLE   0x71d0
>> #define   RTL822X_VND1_SERDES_INBAND_ENABLE    0x70d0
>> #define RTL822X_VND1_SERDES_DATA               0x7589
>>+#define RTL822X_VND1_SERDES_RDATA              0x758a
>>
>> #define RTL822X_VND2_TO_PAGE(reg)              ((reg) >> 4)
>> #define RTL822X_VND2_TO_PAGE_REG(reg)          (16 + (((reg) & GENMASK(=
3,
>>0)) >> 1))
>>@@ -271,6 +274,18 @@
>> #define RTL8261X_INT_ALDPS_CHG         BIT(9)
>> #define RTL8261X_INT_JABBER            BIT(10)
>>
>>+/* SerDes lane polarity, behind the VEND1 SerDes command window=2E This
>>+is not
>>+ * the global inversion bit that other Realtek 10G PHYs use; the bit
>>+ * assignment below has only been verified on an RTL8261CE reporting
>>+PHY ID
>>+ * 0x001cc899=2E
>>+ */
>>+#define RTL8261X_SERDES_POL_REG0       0x0000
>>+#define  RTL8261X_SERDES_POL_REG0_TX   BIT(8)
>>+#define  RTL8261X_SERDES_POL_REG0_RX   BIT(9)
>>+#define RTL8261X_SERDES_POL_REGC2      0x00c2
>>+#define  RTL8261X_SERDES_POL_REGC2_TX  BIT(14) #define
>>+RTL8261X_SERDES_POL_REGC2_RX  BIT(13)
>>+
>
>Hi,
>
>Thanks for submitting this patch=2E
>
>The serdes registers modified in this patch are not unified across RTL826=
1 family=2E This patch will lead to undefined behaviors on other IC=2E And =
operating these SerDes registers requires a specific hardware control flow=
=2E The direct manipulation used in this patch will introduce unknown risk=
=2E
>
>Therefore, we kindly suggest drop this patch=2E
>
>BRS,
>Javen
>
