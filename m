Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFFCB3D9050
	for <netdev@vger.kernel.org>; Mon, 17 Aug 2026 08:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786954874; cv=none; b=LMkjjOTgT9jMuBCFbmvsfJ82UUHH3hwVCy6CNSI08oAsEtlDV3psDKPJ9t9C4o+GjSoEc8FwFgpuE0rPiia3t9R4HpTJV/O3fyAq7k98C2g+yf0d1vSdJjrRpahoclf4r7LOAQt3As27xVhh5crOr+qGZnY+l1DeBw74UlKpc88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786954874; c=relaxed/simple;
	bh=ASE85MObxgv33CAZwZHrFZhs23Vhx87GVpWO/9wIlnM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R705uaMqIkv4gSge+T0aGx9a0e0HV1CHBDU/2UwvqDwf9pYMveLjqa+pdZY2tIWP3jQxh99F7KXqYVpopZN6JQbBJlVbKJaNEZrYG5ibhcj/a7pVgW14IAiH2+eWgUOG3FqrXmmnlvYHyUKITK5RQALBo3M686t0fUAyc97wJsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GdCES8dv; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GdCES8dv"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-49802c418b5so32439545e9.1
        for <netdev@vger.kernel.org>; Mon, 17 Aug 2026 01:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786954863; x=1787559663; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=R+Yb0fAGEG2nxfuIt5iRsu1umQAMNOTgBSq+i037kXs=;
        b=GdCES8dvc6biabhDEyZwLNMeKNkuFBDOFiR65a0YjdLcCHerl8RJHxPaQWhEmEPREg
         denwj5gKvCAdjMdIhs1TczWYz10ZOHAU3l1tRx8ed+/pgMvL0I59IzNS+QdIsq0Pk8qN
         D4quRrKgbl6vfudGpn0P0WWiV8F3IOX+sbmQhWRjwMI2abOg07Yz85iH1K/NwSfS+DZr
         QBixr4/baAkLvXfj2WcNztC/dicX15Itk9yExkHZgfD+kKloULDyWC0S9aIpWNsglFpr
         ArKu1Tro3nM0UaGEoYGwcwoxe7JnQUrci7U41T04Y4+M9SRMvt+SivWAhPl+dLKzMoTd
         rpVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786954863; x=1787559663;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=R+Yb0fAGEG2nxfuIt5iRsu1umQAMNOTgBSq+i037kXs=;
        b=fucezbMKSoBTfETu9KQ/1GE22tbHp6Ky7quXjzAm/HxUMLRCSKzV2mfE4AqnwnD2Gf
         0in482mk93s5uNjjkPLLSDUMHzGrmc58y+h76RCylIasyp2cdE3OLD8A6SiO/6G0gfpg
         qun4zPlsJ+I8MuOc+k4a9hHKE7VM8U3ywFrjAC8bZyl3M359kEvlLqcEv7/d4Ke4emos
         3AAm917I4NsjCAMexq9VWwdz9S14QqQYXxwdSL7M9OB5A15v1PO073dBOpA+LJgnWDtt
         3Mbg3TNZqPvGNPd6mDJdM7e+7dwI737JjNtoDTwF2KgL25C/48x2tRfEUnKYWyO5RhWY
         DlRA==
X-Forwarded-Encrypted: i=1; AHgh+Rp2uFAmRsoxDFGtbV6/b+0o+FLTO+tSeamf1tZFzBRjlamORlDruJzQwD3fqtjPmSwqZc0XP48=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsJAB5f1it9NkEpzEN2awcO5BobB0ELGVrwupBSfM5t6leeuGc
	z/mjtOLVcDvtNPv0uhGvv5VR4RdZQpET2j1UqTRhRShSJIHIWc8k+CSt
X-Gm-Gg: AR+sD12H/BDJz1w2U4tXbxeF38B5E+zjtLS32TkW5WJrJqsDGLWP/ehp3GuC66IQuua
	fqrSonTuc0/DfCwltuUjDD9fWZQ+SMY42MgmBrzVGELFDdDHDhXvAaXI0pjndKGWEJVIlyT2tuj
	YGgL2E6mK2Mar/rM2abgjuFiY8J1WqXUEOUo5z7ZGPlnnbPHFWVgeCfBXNNNFk1SD/1Sr6azDuT
	WVFsTPyevKt76j9Q31Ur3ED0sM8n9jxbtz7J+14ZpOXh2ulJP0UgDm0/SQJrxFrgP4VqbTCuI2P
	kOAwtlQ3vVXvepKT+slpC0q8j3F/iFU3VEiq39/uHJ+tdBksBbYgjvwHiszjxcKNBUsnoZpzQbT
	mee6SCq2LF1oPf7JpMAnJnDUdZr2uko+MAoyltn8x7J/M0km9a4skk1nsB/znduZlKukFfb2SAw
	e8mp8rOc/0cra1LNf6OJ9bg0AxgNFcsVcukr8wpEDquQnt7V99XRKu+HU4FcRN7n5iibw3S3Y6z
	AmXjk2PP+j1qnKacZOI+hq/Cu8bqjmGdOinaw7S9kpHEcWifiqPNgPHr9mdikIfLVA=
X-Received: by 2002:a05:600c:6089:b0:499:86ce:465e with SMTP id 5b1f17b1804b1-49987941e38mr407076815e9.4.1786954861448;
        Mon, 17 Aug 2026 01:21:01 -0700 (PDT)
Received: from Ansuel-XPS24.localdomain (host-79-40-190-175.business.telecomitalia.it. [79.40.190.175])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4999d078517sm19684195e9.5.2026.08.17.01.20.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 01:21:00 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Christian Marangi <ansuelsmth@gmail.com>,
	Lee Jones <lee@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"Chester A. Unal" <chester.a.unal@arinc9.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Simon Horman <horms@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	netdev@vger.kernel.org,
	mfd@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v20 09/10] net: dsa: mt7530: generalize and move common function to lib module
Date: Mon, 17 Aug 2026 10:20:31 +0200
Message-ID: <20260817082034.20326-11-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260817082034.20326-1-ansuelsmth@gmail.com>
References: <20260817082034.20326-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In preparation of support of DSA Switch from Airoha, create a mt7530
library module and move there all the common function.

Function are generalized to use the reg_field regmap API but still apply
the same exact logic. Every function is renamed to mt7530_lib prefix to
better identify it.

Minimum modification are needed to the register header and common enum and
macro are moved to the mt7530 library header to permit reuse.

A library struct is introduced with everything required for the common
functions.

The generalization and the introduction of reg_field regmap API have the
side effect of permitting to clean the mirror functions that required
special handling for MT7530 and MT7531 based switch that had different
registers. This is done by declaring a common MT7530 reg_field and a
specific one in the Switch match table.

No behaviour change is expected by this change as it's just a code move and
reimplementation.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/net/dsa/Kconfig       |    4 +
 drivers/net/dsa/Makefile      |    1 +
 drivers/net/dsa/mt7530-lib.c  | 1106 +++++++++++++++++++++++++++
 drivers/net/dsa/mt7530-lib.h  |  385 ++++++++++
 drivers/net/dsa/mt7530-mdio.c |    4 +
 drivers/net/dsa/mt7530-mmio.c |    4 +
 drivers/net/dsa/mt7530.c      | 1322 ++++++++-------------------------
 drivers/net/dsa/mt7530.h      |  258 ++-----
 8 files changed, 1871 insertions(+), 1213 deletions(-)
 create mode 100644 drivers/net/dsa/mt7530-lib.c
 create mode 100644 drivers/net/dsa/mt7530-lib.h

diff --git a/drivers/net/dsa/Kconfig b/drivers/net/dsa/Kconfig
index 4ab567c5bbaf..7e0952dfc9ac 100644
--- a/drivers/net/dsa/Kconfig
+++ b/drivers/net/dsa/Kconfig
@@ -28,8 +28,12 @@ source "drivers/net/dsa/hirschmann/Kconfig"
 
 source "drivers/net/dsa/lantiq/Kconfig"
 
+config NET_DSA_MT7530_LIB
+	tristate
+
 config NET_DSA_MT7530
 	tristate "MediaTek MT7530 and MT7531 Ethernet switch support"
+	select NET_DSA_MT7530_LIB
 	select NET_DSA_TAG_MTK
 	select REGMAP_IRQ
 	imply NET_DSA_MT7530_MDIO
diff --git a/drivers/net/dsa/Makefile b/drivers/net/dsa/Makefile
index d2975badffc0..77e4ab5b3944 100644
--- a/drivers/net/dsa/Makefile
+++ b/drivers/net/dsa/Makefile
@@ -4,6 +4,7 @@ bcm-sf2-objs			:= bcm_sf2.o bcm_sf2_cfp.o
 obj-$(CONFIG_NET_DSA_LOOP)	+= dsa_loop.o
 obj-$(CONFIG_NET_DSA_KS8995) 	+= ks8995.o
 obj-$(CONFIG_NET_DSA_MT7530)	+= mt7530.o
+obj-$(CONFIG_NET_DSA_MT7530_LIB) += mt7530-lib.o
 obj-$(CONFIG_NET_DSA_MT7530_MDIO) += mt7530-mdio.o
 obj-$(CONFIG_NET_DSA_MT7530_MMIO) += mt7530-mmio.o
 obj-$(CONFIG_NET_DSA_MV88E6060) += mv88e6060.o
diff --git a/drivers/net/dsa/mt7530-lib.c b/drivers/net/dsa/mt7530-lib.c
new file mode 100644
index 000000000000..01ed941efc89
--- /dev/null
+++ b/drivers/net/dsa/mt7530-lib.c
@@ -0,0 +1,1106 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <linux/device.h>
+#include <linux/if_bridge.h>
+#include <linux/module.h>
+#include <linux/regmap.h>
+#include <net/dsa.h>
+
+#include "mt7530-lib.h"
+
+void mt7530_lib_mib_reset(struct mt7530_lib_priv *priv)
+{
+	regmap_field_write(priv->fields[MT7530_CCR_MIB_ENABLE], 0);
+	regmap_field_write(priv->fields[MT7530_CCR_RX_OCT_CNT_GOOD], 0);
+	regmap_field_write(priv->fields[MT7530_CCR_RX_OCT_CNT_BAD], 0);
+	regmap_field_write(priv->fields[MT7530_CCR_TX_OCT_CNT_GOOD], 0);
+	regmap_field_write(priv->fields[MT7530_CCR_TX_OCT_CNT_BAD], 0);
+	regmap_field_write(priv->fields[MT7530_CCR_MIB_ENABLE], 1);
+}
+EXPORT_SYMBOL_GPL(mt7530_lib_mib_reset);
+
+/* In Clause 5 of IEEE Std 802-2014, two sublayers of the data link layer (DLL)
+ * of the Open Systems Interconnection basic reference model (OSI/RM) are
+ * described; the medium access control (MAC) and logical link control (LLC)
+ * sublayers. The MAC sublayer is the one facing the physical layer.
+ *
+ * In 8.2 of IEEE Std 802.1Q-2022, the Bridge architecture is described. A
+ * Bridge component comprises a MAC Relay Entity for interconnecting the Ports
+ * of the Bridge, at least two Ports, and higher layer entities with at least a
+ * Spanning Tree Protocol Entity included.
+ *
+ * Each Bridge Port also functions as an end station and shall provide the MAC
+ * Service to an LLC Entity. Each instance of the MAC Service is provided to a
+ * distinct LLC Entity that supports protocol identification, multiplexing, and
+ * demultiplexing, for protocol data unit (PDU) transmission and reception by
+ * one or more higher layer entities.
+ *
+ * It is described in 8.13.9 of IEEE Std 802.1Q-2022 that in a Bridge, the LLC
+ * Entity associated with each Bridge Port is modeled as being directly
+ * connected to the attached Local Area Network (LAN).
+ *
+ * On the switch with CPU port architecture, CPU port functions as Management
+ * Port, and the Management Port functionality is provided by software which
+ * functions as an end station. Software is connected to an IEEE 802 LAN that is
+ * wholly contained within the system that incorporates the Bridge. Software
+ * provides access to the LLC Entity associated with each Bridge Port by the
+ * value of the source port field on the special tag on the frame received by
+ * software.
+ *
+ * We call frames that carry control information to determine the active
+ * topology and current extent of each Virtual Local Area Network (VLAN), i.e.,
+ * spanning tree or Shortest Path Bridging (SPB) and Multiple VLAN Registration
+ * Protocol Data Units (MVRPDUs), and frames from other link constrained
+ * protocols, such as Extensible Authentication Protocol over LAN (EAPOL) and
+ * Link Layer Discovery Protocol (LLDP), link-local frames. They are not
+ * forwarded by a Bridge. Permanently configured entries in the filtering
+ * database (FDB) ensure that such frames are discarded by the Forwarding
+ * Process. In 8.6.3 of IEEE Std 802.1Q-2022, this is described in detail:
+ *
+ * Each of the reserved MAC addresses specified in Table 8-1
+ * (01-80-C2-00-00-[00,01,02,03,04,05,06,07,08,09,0A,0B,0C,0D,0E,0F]) shall be
+ * permanently configured in the FDB in C-VLAN components and ERs.
+ *
+ * Each of the reserved MAC addresses specified in Table 8-2
+ * (01-80-C2-00-00-[01,02,03,04,05,06,07,08,09,0A,0E]) shall be permanently
+ * configured in the FDB in S-VLAN components.
+ *
+ * Each of the reserved MAC addresses specified in Table 8-3
+ * (01-80-C2-00-00-[01,02,04,0E]) shall be permanently configured in the FDB in
+ * TPMR components.
+ *
+ * The FDB entries for reserved MAC addresses shall specify filtering for all
+ * Bridge Ports and all VIDs. Management shall not provide the capability to
+ * modify or remove entries for reserved MAC addresses.
+ *
+ * The addresses in Table 8-1, Table 8-2, and Table 8-3 determine the scope of
+ * propagation of PDUs within a Bridged Network, as follows:
+ *
+ *   The Nearest Bridge group address (01-80-C2-00-00-0E) is an address that no
+ *   conformant Two-Port MAC Relay (TPMR) component, Service VLAN (S-VLAN)
+ *   component, Customer VLAN (C-VLAN) component, or MAC Bridge can forward.
+ *   PDUs transmitted using this destination address, or any other addresses
+ *   that appear in Table 8-1, Table 8-2, and Table 8-3
+ *   (01-80-C2-00-00-[00,01,02,03,04,05,06,07,08,09,0A,0B,0C,0D,0E,0F]), can
+ *   therefore travel no further than those stations that can be reached via a
+ *   single individual LAN from the originating station.
+ *
+ *   The Nearest non-TPMR Bridge group address (01-80-C2-00-00-03), is an
+ *   address that no conformant S-VLAN component, C-VLAN component, or MAC
+ *   Bridge can forward; however, this address is relayed by a TPMR component.
+ *   PDUs using this destination address, or any of the other addresses that
+ *   appear in both Table 8-1 and Table 8-2 but not in Table 8-3
+ *   (01-80-C2-00-00-[00,03,05,06,07,08,09,0A,0B,0C,0D,0F]), will be relayed by
+ *   any TPMRs but will propagate no further than the nearest S-VLAN component,
+ *   C-VLAN component, or MAC Bridge.
+ *
+ *   The Nearest Customer Bridge group address (01-80-C2-00-00-00) is an address
+ *   that no conformant C-VLAN component, MAC Bridge can forward; however, it is
+ *   relayed by TPMR components and S-VLAN components. PDUs using this
+ *   destination address, or any of the other addresses that appear in Table 8-1
+ *   but not in either Table 8-2 or Table 8-3 (01-80-C2-00-00-[00,0B,0C,0D,0F]),
+ *   will be relayed by TPMR components and S-VLAN components but will propagate
+ *   no further than the nearest C-VLAN component or MAC Bridge.
+ *
+ * Because the LLC Entity associated with each Bridge Port is provided via CPU
+ * port, we must not filter these frames but forward them to CPU port.
+ *
+ * In a Bridge, the transmission Port is majorly decided by ingress and egress
+ * rules, FDB, and spanning tree Port State functions of the Forwarding Process.
+ * For link-local frames, only CPU port should be designated as destination port
+ * in the FDB, and the other functions of the Forwarding Process must not
+ * interfere with the decision of the transmission Port. We call this process
+ * trapping frames to CPU port.
+ *
+ * Therefore, on the switch with CPU port architecture, link-local frames must
+ * be trapped to CPU port, and certain link-local frames received by a Port of a
+ * Bridge comprising a TPMR component or an S-VLAN component must be excluded
+ * from it.
+ *
+ * A Bridge of the switch with CPU port architecture cannot comprise a Two-Port
+ * MAC Relay (TPMR) component as a TPMR component supports only a subset of the
+ * functionality of a MAC Bridge. A Bridge comprising two Ports (Management Port
+ * doesn't count) of this architecture will either function as a standard MAC
+ * Bridge or a standard VLAN Bridge.
+ *
+ * Therefore, a Bridge of this architecture can only comprise S-VLAN components,
+ * C-VLAN components, or MAC Bridge components. Since there's no TPMR component,
+ * we don't need to relay PDUs using the destination addresses specified on the
+ * Nearest non-TPMR section, and the proportion of the Nearest Customer Bridge
+ * section where they must be relayed by TPMR components.
+ *
+ * One option to trap link-local frames to CPU port is to add static FDB entries
+ * with CPU port designated as destination port. However, because that
+ * Independent VLAN Learning (IVL) is being used on every VID, each entry only
+ * applies to a single VLAN Identifier (VID). For a Bridge comprising a MAC
+ * Bridge component or a C-VLAN component, there would have to be 16 times 4096
+ * entries. This switch intellectual property can only hold a maximum of 2048
+ * entries. Using this option, there also isn't a mechanism to prevent
+ * link-local frames from being discarded when the spanning tree Port State of
+ * the reception Port is discarding.
+ *
+ * The remaining option is to utilise the BPC, RGAC1, RGAC2, RGAC3, and RGAC4
+ * registers. Whilst this applies to every VID, it doesn't contain all of the
+ * reserved MAC addresses without affecting the remaining Standard Group MAC
+ * Addresses. The REV_UN frame tag utilised using the RGAC4 register covers the
+ * remaining 01-80-C2-00-00-[04,05,06,07,08,09,0A,0B,0C,0D,0F] destination
+ * addresses. It also includes the 01-80-C2-00-00-22 to 01-80-C2-00-00-FF
+ * destination addresses which may be relayed by MAC Bridges or VLAN Bridges.
+ * The latter option provides better but not complete conformance.
+ *
+ * This switch intellectual property also does not provide a mechanism to trap
+ * link-local frames with specific destination addresses to CPU port by Bridge,
+ * to conform to the filtering rules for the distinct Bridge components.
+ *
+ * Therefore, regardless of the type of the Bridge component, link-local frames
+ * with these destination addresses will be trapped to CPU port:
+ *
+ * 01-80-C2-00-00-[00,01,02,03,0E]
+ *
+ * In a Bridge comprising a MAC Bridge component or a C-VLAN component:
+ *
+ *   Link-local frames with these destination addresses won't be trapped to CPU
+ *   port which won't conform to IEEE Std 802.1Q-2022:
+ *
+ *   01-80-C2-00-00-[04,05,06,07,08,09,0A,0B,0C,0D,0F]
+ *
+ * In a Bridge comprising an S-VLAN component:
+ *
+ *   Link-local frames with these destination addresses will be trapped to CPU
+ *   port which won't conform to IEEE Std 802.1Q-2022:
+ *
+ *   01-80-C2-00-00-00
+ *
+ *   Link-local frames with these destination addresses won't be trapped to CPU
+ *   port which won't conform to IEEE Std 802.1Q-2022:
+ *
+ *   01-80-C2-00-00-[04,05,06,07,08,09,0A]
+ *
+ * To trap link-local frames to CPU port as conformant as this switch
+ * intellectual property can allow, link-local frames are made to be regarded as
+ * Bridge Protocol Data Units (BPDUs). This is because this switch intellectual
+ * property only lets the frames regarded as BPDUs bypass the spanning tree Port
+ * State function of the Forwarding Process.
+ *
+ * The only remaining interference is the ingress rules. When the reception Port
+ * has no PVID assigned on software, VLAN-untagged frames won't be allowed in.
+ * There doesn't seem to be a mechanism on the switch intellectual property to
+ * have link-local frames bypass this function of the Forwarding Process.
+ */
+void mt7530_lib_trap_frames(struct mt7530_lib_priv *priv)
+{
+	/* Trap 802.1X PAE frames and BPDUs to the CPU port(s) and egress
+	 * them with the EG_TAG attribute set to disabled (system default)
+	 * so that any VLAN tags in the frame are not modified by the
+	 * switch egress VLAN tag processing. This preserves VLAN tags
+	 * for reception on VLAN sub-interfaces.
+	 */
+	regmap_field_write(priv->fields[MT7530_BPDU_EG_TAG],
+			   MT7530_VLAN_EG_DISABLED);
+	regmap_field_write(priv->fields[MT7530_BPDU_PORT_FW],
+			   TO_CPU_FW_CPU_ONLY);
+	regmap_field_write(priv->fields[MT7530_PAE_BPDU_FR], 1);
+	regmap_field_write(priv->fields[MT7530_PAE_EG_TAG],
+			   MT7530_VLAN_EG_DISABLED);
+	regmap_field_write(priv->fields[MT7530_PAE_PORT_FW],
+			   TO_CPU_FW_CPU_ONLY);
+
+	/* Trap frames with :01 and :02 MAC DAs to the CPU port(s) and
+	 * egress them with EG_TAG disabled.
+	 */
+	regmap_field_write(priv->fields[MT7530_R01_BPDU_FR], 1);
+	regmap_field_write(priv->fields[MT7530_R01_EG_TAG],
+			   MT7530_VLAN_EG_DISABLED);
+	regmap_field_write(priv->fields[MT7530_R01_PORT_FW],
+			   TO_CPU_FW_CPU_ONLY);
+	regmap_field_write(priv->fields[MT7530_R02_BPDU_FR], 1);
+	regmap_field_write(priv->fields[MT7530_R02_EG_TAG],
+			   MT7530_VLAN_EG_DISABLED);
+	regmap_field_write(priv->fields[MT7530_R02_PORT_FW],
+			   TO_CPU_FW_CPU_ONLY);
+
+	/* Trap frames with :03 and :0E MAC DAs to the CPU port(s) and
+	 * egress them with EG_TAG disabled.
+	 */
+	regmap_field_write(priv->fields[MT7530_R03_BPDU_FR], 1);
+	regmap_field_write(priv->fields[MT7530_R03_EG_TAG],
+			   MT7530_VLAN_EG_DISABLED);
+	regmap_field_write(priv->fields[MT7530_R03_PORT_FW],
+			   TO_CPU_FW_CPU_ONLY);
+	regmap_field_write(priv->fields[MT7530_R0E_BPDU_FR], 1);
+	regmap_field_write(priv->fields[MT7530_R0E_EG_TAG],
+			   MT7530_VLAN_EG_DISABLED);
+	regmap_field_write(priv->fields[MT7530_R0E_PORT_FW],
+			   TO_CPU_FW_CPU_ONLY);
+}
+EXPORT_SYMBOL_GPL(mt7530_lib_trap_frames);
+
+static void mt7530_update_port_member(struct mt7530_lib_priv *priv, int port,
+				      const struct net_device *bridge_dev,
+				      bool join) __must_hold(priv->reg_mutex)
+{
+	struct dsa_port *dp = dsa_to_port(priv->ds, port), *other_dp;
+	struct mt7530_port *p = &priv->ports[port], *other_p;
+	struct dsa_port *cpu_dp = dp->cpu_dp;
+	u32 port_bitmap = BIT(cpu_dp->index);
+	int other_port;
+	bool isolated;
+
+	dsa_switch_for_each_user_port(other_dp, priv->ds) {
+		other_port = other_dp->index;
+		other_p = &priv->ports[other_port];
+
+		if (dp == other_dp)
+			continue;
+
+		/* Add/remove this port to/from the port matrix of the other
+		 * ports in the same bridge. If the port is disabled, port
+		 * matrix is kept and not being setup until the port becomes
+		 * enabled.
+		 */
+		if (!dsa_port_offloads_bridge_dev(other_dp, bridge_dev))
+			continue;
+
+		isolated = p->isolated && other_p->isolated;
+
+		if (join && !isolated) {
+			other_p->pm |= BIT(port);
+			port_bitmap |= BIT(other_port);
+		} else {
+			other_p->pm &= ~BIT(port);
+		}
+
+		if (other_p->enable)
+			regmap_fields_write(priv->fields[MT7530_PCR_MATRIX],
+					    other_port, other_p->pm);
+	}
+
+	/* Add/remove the all other ports to this port matrix. For !join
+	 * (leaving the bridge), only the CPU port will remain in the port matrix
+	 * of this port.
+	 */
+	p->pm = port_bitmap;
+	if (priv->ports[port].enable)
+		regmap_fields_write(priv->fields[MT7530_PCR_MATRIX],
+				    port, port_bitmap);
+}
+
+void mt7530_lib_read_port_stats(struct regmap_field *low,
+				struct regmap_field *high,
+				int port, uint64_t *data)
+{
+	u32 val = 0;
+
+	regmap_fields_read(low, port, &val);
+	*data = val;
+
+	if (high) {
+		val = 0;
+		regmap_fields_read(high, port, &val);
+		*data |= (u64)val << 32;
+	}
+}
+EXPORT_SYMBOL_GPL(mt7530_lib_read_port_stats);
+
+void mt7530_lib_get_eth_mac_stats(struct mt7530_lib_priv *priv, int port,
+				  struct ethtool_eth_mac_stats *mac_stats)
+{
+	/* MIB counter doesn't provide a FramesTransmittedOK but instead
+	 * provide stats for Unicast, Broadcast and Multicast frames separately.
+	 * To simulate a global frame counter, read Unicast and addition Multicast
+	 * and Broadcast later
+	 */
+	mt7530_lib_read_port_stats(priv->fields[MT7530_MIB_TX_UNICAST], NULL, port,
+				   &mac_stats->FramesTransmittedOK);
+
+	mt7530_lib_read_port_stats(priv->fields[MT7530_MIB_TX_SINGLE_COLLISION], NULL, port,
+				   &mac_stats->SingleCollisionFrames);
+
+	mt7530_lib_read_port_stats(priv->fields[MT7530_MIB_TX_MULTIPLE_COLLISION], NULL, port,
+				   &mac_stats->MultipleCollisionFrames);
+
+	mt7530_lib_read_port_stats(priv->fields[MT7530_MIB_RX_UNICAST], NULL, port,
+				   &mac_stats->FramesReceivedOK);
+
+	mt7530_lib_read_port_stats(priv->fields[MT7530_MIB_TX_BYTES_LOW],
+				   priv->fields[MT7530_MIB_TX_BYTES_HIGH], port,
+				   &mac_stats->OctetsTransmittedOK);
+
+	mt7530_lib_read_port_stats(priv->fields[MT7530_MIB_RX_ALIGN_ERR], NULL, port,
+				   &mac_stats->AlignmentErrors);
+
+	mt7530_lib_read_port_stats(priv->fields[MT7530_MIB_TX_DEFERRED], NULL, port,
+				   &mac_stats->FramesWithDeferredXmissions);
+
+	mt7530_lib_read_port_stats(priv->fields[MT7530_MIB_TX_LATE_COLLISION], NULL, port,
+				   &mac_stats->LateCollisions);
+
+	mt7530_lib_read_port_stats(priv->fields[MT7530_MIB_TX_EXCESSIVE_COLLISION], NULL, port,
+				   &mac_stats->FramesAbortedDueToXSColls);
+
+	mt7530_lib_read_port_stats(priv->fields[MT7530_MIB_RX_BYTES_LOW],
+				   priv->fields[MT7530_MIB_RX_BYTES_HIGH], port,
+				   &mac_stats->OctetsReceivedOK);
+
+	mt7530_lib_read_port_stats(priv->fields[MT7530_MIB_TX_MULTICAST], NULL, port,
+				   &mac_stats->MulticastFramesXmittedOK);
+	mac_stats->FramesTransmittedOK += mac_stats->MulticastFramesXmittedOK;
+	mt7530_lib_read_port_stats(priv->fields[MT7530_MIB_TX_BROADCAST], NULL, port,
+				   &mac_stats->BroadcastFramesXmittedOK);
+	mac_stats->FramesTransmittedOK += mac_stats->BroadcastFramesXmittedOK;
+
+	mt7530_lib_read_port_stats(priv->fields[MT7530_MIB_RX_MULTICAST], NULL, port,
+				   &mac_stats->MulticastFramesReceivedOK);
+	mac_stats->FramesReceivedOK += mac_stats->MulticastFramesReceivedOK;
+	mt7530_lib_read_port_stats(priv->fields[MT7530_MIB_RX_BROADCAST], NULL, port,
+				   &mac_stats->BroadcastFramesReceivedOK);
+	mac_stats->FramesReceivedOK += mac_stats->BroadcastFramesReceivedOK;
+}
+EXPORT_SYMBOL_GPL(mt7530_lib_get_eth_mac_stats);
+
+void mt7530_lib_get_rmon_stats(struct mt7530_lib_priv *priv, int port,
+			       struct ethtool_rmon_stats *rmon_stats,
+			       const struct ethtool_rmon_hist_range **ranges,
+			       const struct mt7530_rmon_hist *ranges_info)
+{
+	int i;
+
+	mt7530_lib_read_port_stats(priv->fields[MT7530_MIB_RX_UNDER_SIZE_ERR], NULL, port,
+				   &rmon_stats->undersize_pkts);
+	mt7530_lib_read_port_stats(priv->fields[MT7530_MIB_RX_OVER_SZ_ERR], NULL, port,
+				   &rmon_stats->oversize_pkts);
+	mt7530_lib_read_port_stats(priv->fields[MT7530_MIB_RX_FRAG_ERR], NULL, port,
+				   &rmon_stats->fragments);
+	mt7530_lib_read_port_stats(priv->fields[MT7530_MIB_RX_JABBER_ERR], NULL, port,
+				   &rmon_stats->jabbers);
+
+	for (i = 0; i < ranges_info->num_ranges; i++) {
+		unsigned int field = ranges_info->ranges_fields[i];
+		unsigned int field_tx = ranges_info->ranges_tx_fields[i];
+
+		mt7530_lib_read_port_stats(priv->fields[field], NULL, port,
+					   &rmon_stats->hist[i]);
+		mt7530_lib_read_port_stats(priv->fields[field_tx], NULL, port,
+					   &rmon_stats->hist_tx[i]);
+	}
+
+	*ranges = ranges_info->ranges;
+}
+EXPORT_SYMBOL_GPL(mt7530_lib_get_rmon_stats);
+
+void mt7530_lib_get_eth_ctrl_stats(struct mt7530_lib_priv *priv, int port,
+				   struct ethtool_eth_ctrl_stats *ctrl_stats)
+{
+	mt7530_lib_read_port_stats(priv->fields[MT7530_MIB_TX_PAUSE], NULL, port,
+				   &ctrl_stats->MACControlFramesTransmitted);
+	mt7530_lib_read_port_stats(priv->fields[MT7530_MIB_RX_PAUSE], NULL, port,
+				   &ctrl_stats->MACControlFramesReceived);
+}
+EXPORT_SYMBOL_GPL(mt7530_lib_get_eth_ctrl_stats);
+
+int mt7530_lib_fdb_cmd(struct mt7530_lib_priv *priv, enum mt7530_fdb_cmd cmd,
+		       u32 mat, u32 *rsp)
+{
+	u32 val;
+	int ret;
+
+	ret = regmap_field_write(priv->fields[MT7530_ATC_MAT], mat);
+	if (ret)
+		return ret;
+
+	ret = regmap_field_write(priv->fields[MT7530_ATC_CMD], cmd);
+	if (ret)
+		return ret;
+
+	ret = regmap_field_write(priv->fields[MT7530_ATC_BUSY], 1);
+	if (ret)
+		return ret;
+
+	ret = regmap_field_read_poll_timeout(priv->fields[MT7530_ATC_BUSY],
+					     val, !val, 20, 20000);
+	if (ret < 0) {
+		dev_err(priv->dev, "reset timeout\n");
+		return ret;
+	}
+
+	regmap_field_read(priv->fields[MT7530_ATC_INVALID], &val);
+	if (cmd == MT7530_FDB_READ && val)
+		return -EINVAL;
+
+	if (rsp)
+		regmap_field_read(priv->fields[__MT7530_ATC], rsp);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(mt7530_lib_fdb_cmd);
+
+static void mt7530_lib_fdb_write(struct mt7530_lib_priv *priv, u16 vid,
+				 u8 port_mask, const u8 *mac,
+				 u8 aging, u8 type)
+{
+	regmap_field_write(priv->fields[MT7530_ATWD_CVID], vid);
+	regmap_field_write(priv->fields[MT7530_ATWD_IVL], 1);
+	regmap_field_write(priv->fields[MT7530_ATWD_FID], FID_BRIDGED);
+	regmap_field_write(priv->fields[MT7530_ATWD_AGE_TIMER], aging);
+	regmap_field_write(priv->fields[MT7530_ATWD_PORT_MAP], port_mask);
+	/* STATIC_ENT indicate that entry is static wouldn't
+	 * be aged out and STATIC_EMP specified as erasing an
+	 * entry
+	 */
+	regmap_field_write(priv->fields[MT7530_ATWD_ENT_STATUS], type);
+	regmap_field_write(priv->fields[MT7530_ATWD_MAC_BYTE_5], mac[5]);
+	regmap_field_write(priv->fields[MT7530_ATWD_MAC_BYTE_4], mac[4]);
+	regmap_field_write(priv->fields[MT7530_ATWD_MAC_BYTE_3], mac[3]);
+	regmap_field_write(priv->fields[MT7530_ATWD_MAC_BYTE_2], mac[2]);
+	regmap_field_write(priv->fields[MT7530_ATWD_MAC_BYTE_1], mac[1]);
+	regmap_field_write(priv->fields[MT7530_ATWD_MAC_BYTE_0], mac[0]);
+}
+
+void mt7530_lib_fdb_read(struct mt7530_lib_priv *priv, struct mt7530_fdb *fdb)
+{
+	u32 val;
+
+	regmap_field_read(priv->fields[MT7530_ATRD_CVID], &val);
+	fdb->vid = val;
+	regmap_field_read(priv->fields[MT7530_ATRD_AGE_TIMER], &val);
+	fdb->aging = val;
+	regmap_field_read(priv->fields[MT7530_ATRD_PORT_MAP], &val);
+	fdb->port_mask = val;
+	regmap_field_read(priv->fields[MT7530_ATRD_MAC_BYTE_5], &val);
+	fdb->mac[5] = val;
+	regmap_field_read(priv->fields[MT7530_ATRD_MAC_BYTE_4], &val);
+	fdb->mac[4] = val;
+	regmap_field_read(priv->fields[MT7530_ATRD_MAC_BYTE_3], &val);
+	fdb->mac[3] = val;
+	regmap_field_read(priv->fields[MT7530_ATRD_MAC_BYTE_2], &val);
+	fdb->mac[2] = val;
+	regmap_field_read(priv->fields[MT7530_ATRD_MAC_BYTE_1], &val);
+	fdb->mac[1] = val;
+	regmap_field_read(priv->fields[MT7530_ATRD_MAC_BYTE_0], &val);
+	fdb->mac[0] = val;
+	regmap_field_read(priv->fields[MT7530_ATRD_ENT_STATUS], &val);
+	fdb->noarp = val == STATIC_ENT;
+}
+EXPORT_SYMBOL_GPL(mt7530_lib_fdb_read);
+
+int mt7530_lib_port_fdb_add(struct mt7530_lib_priv *priv, int port,
+			    const unsigned char *addr, u16 vid,
+			    struct dsa_db db)
+{
+	u8 port_mask = BIT(port);
+	int ret;
+
+	mutex_lock(priv->reg_mutex);
+	mt7530_lib_fdb_write(priv, vid, port_mask, addr, -1, STATIC_ENT);
+	ret = mt7530_lib_fdb_cmd(priv, MT7530_FDB_WRITE,
+				 ATC_MAT_MACTAB, NULL);
+	mutex_unlock(priv->reg_mutex);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(mt7530_lib_port_fdb_add);
+
+int mt7530_lib_port_fdb_del(struct mt7530_lib_priv *priv, int port,
+			    const unsigned char *addr, u16 vid,
+			    struct dsa_db db)
+{
+	u8 port_mask = BIT(port);
+	int ret;
+
+	mutex_lock(priv->reg_mutex);
+	mt7530_lib_fdb_write(priv, vid, port_mask, addr, -1, STATIC_EMP);
+	ret = mt7530_lib_fdb_cmd(priv, MT7530_FDB_WRITE,
+				 ATC_MAT_MACTAB, NULL);
+	mutex_unlock(priv->reg_mutex);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(mt7530_lib_port_fdb_del);
+
+int mt7530_lib_port_mdb_add(struct mt7530_lib_priv *priv, int port,
+			    const struct switchdev_obj_port_mdb *mdb,
+			    struct dsa_db db)
+{
+	const u8 *addr = mdb->addr;
+	u16 vid = mdb->vid;
+	u8 port_mask = 0;
+	u32 val;
+	int ret;
+
+	mutex_lock(priv->reg_mutex);
+
+	mt7530_lib_fdb_write(priv, vid, 0, addr, 0, STATIC_EMP);
+	if (!mt7530_lib_fdb_cmd(priv, MT7530_FDB_READ,
+				ATC_MAT_MACTAB, NULL)) {
+		regmap_field_read(priv->fields[MT7530_ATRD_PORT_MAP],
+				  &val);
+		port_mask = val;
+	}
+
+	port_mask |= BIT(port);
+	mt7530_lib_fdb_write(priv, vid, port_mask, addr, -1, STATIC_ENT);
+	ret = mt7530_lib_fdb_cmd(priv, MT7530_FDB_WRITE,
+				 ATC_MAT_MACTAB, NULL);
+
+	mutex_unlock(priv->reg_mutex);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(mt7530_lib_port_mdb_add);
+
+int mt7530_lib_port_mdb_del(struct mt7530_lib_priv *priv, int port,
+			    const struct switchdev_obj_port_mdb *mdb,
+			    struct dsa_db db)
+{
+	const u8 *addr = mdb->addr;
+	u16 vid = mdb->vid;
+	u8 port_mask = 0;
+	u32 val;
+	int ret;
+
+	mutex_lock(priv->reg_mutex);
+
+	mt7530_lib_fdb_write(priv, vid, 0, addr, 0, STATIC_EMP);
+	if (!mt7530_lib_fdb_cmd(priv, MT7530_FDB_READ,
+				ATC_MAT_MACTAB, NULL)) {
+		regmap_field_read(priv->fields[MT7530_ATRD_PORT_MAP],
+				  &val);
+		port_mask = val;
+	}
+
+	port_mask &= ~BIT(port);
+	mt7530_lib_fdb_write(priv, vid, port_mask, addr, -1,
+			     port_mask ? STATIC_ENT : STATIC_EMP);
+	ret = mt7530_lib_fdb_cmd(priv, MT7530_FDB_WRITE,
+				 ATC_MAT_MACTAB, NULL);
+
+	mutex_unlock(priv->reg_mutex);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(mt7530_lib_port_mdb_del);
+
+int mt7530_lib_port_mirror_add(struct mt7530_lib_priv *priv, int port,
+			       struct dsa_mall_mirror_tc_entry *mirror,
+			       bool ingress, struct netlink_ext_ack *extack)
+{
+	int monitor_port;
+	u32 val;
+
+	/* Check for existent entry */
+	if ((ingress ? priv->mirror_rx : priv->mirror_tx) & BIT(port))
+		return -EEXIST;
+
+	regmap_field_read(priv->fields[MT7530_MIRROR_EN], &val);
+	regmap_field_read(priv->fields[MT7530_MIRROR_PORT], &monitor_port);
+
+	/* MT7530 only supports one monitor port */
+	if (val && monitor_port != mirror->to_local_port)
+		return -EEXIST;
+
+	regmap_field_write(priv->fields[MT7530_MIRROR_EN], 1);
+	regmap_field_write(priv->fields[MT7530_MIRROR_PORT],
+			   mirror->to_local_port);
+
+	if (ingress) {
+		regmap_fields_write(priv->fields[MT7530_PCR_PORT_RX_MIR], port, 1);
+		priv->mirror_rx |= BIT(port);
+	} else {
+		regmap_fields_write(priv->fields[MT7530_PCR_PORT_TX_MIR], port, 1);
+		priv->mirror_tx |= BIT(port);
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(mt7530_lib_port_mirror_add);
+
+void mt7530_lib_port_mirror_del(struct mt7530_lib_priv *priv, int port,
+				struct dsa_mall_mirror_tc_entry *mirror)
+{
+	if (mirror->ingress) {
+		regmap_fields_write(priv->fields[MT7530_PCR_PORT_RX_MIR], port, 0);
+		priv->mirror_rx &= ~BIT(port);
+	} else {
+		regmap_fields_write(priv->fields[MT7530_PCR_PORT_TX_MIR], port, 0);
+		priv->mirror_tx &= ~BIT(port);
+	}
+
+	if (!priv->mirror_rx && !priv->mirror_tx)
+		regmap_field_write(priv->fields[MT7530_MIRROR_EN], 0);
+}
+EXPORT_SYMBOL_GPL(mt7530_lib_port_mirror_del);
+
+int mt7530_lib_port_change_mtu(struct mt7530_lib_priv *priv, int port, int new_mtu)
+{
+	int length;
+
+	/* When a new MTU is set, DSA always set the CPU port's MTU to the
+	 * largest MTU of the user ports. Because the switch only has a global
+	 * RX length register, only allowing CPU port here is enough.
+	 */
+	if (!dsa_is_cpu_port(priv->ds, port))
+		return 0;
+
+	/* RX length also includes Ethernet header, MTK tag, and FCS length */
+	length = new_mtu + ETH_HLEN + MTK_HDR_LEN + ETH_FCS_LEN;
+	if (length <= 1522) {
+		regmap_field_write(priv->fields[MT7530_GMACCR_MAX_RX_PKT_LEN],
+				   MAX_RX_PKT_LEN_1522);
+	} else if (length <= 1536) {
+		regmap_field_write(priv->fields[MT7530_GMACCR_MAX_RX_PKT_LEN],
+				   MAX_RX_PKT_LEN_1536);
+	} else if (length <= 1552) {
+		regmap_field_write(priv->fields[MT7530_GMACCR_MAX_RX_PKT_LEN],
+				   MAX_RX_PKT_LEN_1552);
+	} else {
+		regmap_field_write(priv->fields[MT7530_GMACCR_MAX_RX_JUMBO],
+				   DIV_ROUND_UP(length, 1024));
+		regmap_field_write(priv->fields[MT7530_GMACCR_MAX_RX_PKT_LEN],
+				   MAX_RX_PKT_LEN_JUMBO);
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(mt7530_lib_port_change_mtu);
+
+void mt7530_lib_stp_state_set(struct mt7530_lib_priv *priv, int port, u8 state)
+{
+	u32 stp_state;
+
+	switch (state) {
+	case BR_STATE_DISABLED:
+		stp_state = MT7530_STP_DISABLED;
+		break;
+	case BR_STATE_BLOCKING:
+		stp_state = MT7530_STP_BLOCKING;
+		break;
+	case BR_STATE_LISTENING:
+		stp_state = MT7530_STP_LISTENING;
+		break;
+	case BR_STATE_LEARNING:
+		stp_state = MT7530_STP_LEARNING;
+		break;
+	case BR_STATE_FORWARDING:
+	default:
+		stp_state = MT7530_STP_FORWARDING;
+		break;
+	}
+
+	regmap_fields_update_bits(priv->fields[MT7530_SSP_FID_PST],
+				  port, FID_PST_MASK(FID_BRIDGED),
+				  FID_PST(FID_BRIDGED, stp_state));
+}
+EXPORT_SYMBOL_GPL(mt7530_lib_stp_state_set);
+
+int mt7530_lib_port_bridge_flags(struct mt7530_lib_priv *priv, int port,
+				 struct switchdev_brport_flags flags,
+				 struct netlink_ext_ack *extack)
+{
+	struct dsa_switch *ds = priv->ds;
+
+	if (flags.mask & BR_LEARNING)
+		regmap_fields_write(priv->fields[MT7530_PSC_SA_DIR],
+				    port, !!(flags.val & BR_LEARNING));
+
+	if (flags.mask & BR_FLOOD)
+		regmap_field_update_bits(priv->fields[MT7530_UNU_FFP],
+					 BIT(port),
+					 flags.val & BR_FLOOD ? BIT(port) : 0);
+
+	if (flags.mask & BR_MCAST_FLOOD)
+		regmap_field_update_bits(priv->fields[MT7530_UNM_FFP],
+					 BIT(port),
+					 flags.val & BR_MCAST_FLOOD ? BIT(port) : 0);
+
+	if (flags.mask & BR_BCAST_FLOOD)
+		regmap_field_update_bits(priv->fields[MT7530_BC_FFP],
+					 BIT(port),
+					 flags.val & BR_BCAST_FLOOD ? BIT(port) : 0);
+
+	if (flags.mask & BR_ISOLATED) {
+		struct dsa_port *dp = dsa_to_port(ds, port);
+		struct net_device *bridge_dev = dsa_port_bridge_dev_get(dp);
+
+		priv->ports[port].isolated = !!(flags.val & BR_ISOLATED);
+
+		mutex_lock(priv->reg_mutex);
+		mt7530_update_port_member(priv, port, bridge_dev, true);
+		mutex_unlock(priv->reg_mutex);
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(mt7530_lib_port_bridge_flags);
+
+int mt7530_lib_port_bridge_join(struct mt7530_lib_priv *priv, int port,
+				struct dsa_bridge bridge, bool *tx_fwd_offload,
+				struct netlink_ext_ack *extack)
+{
+	mutex_lock(priv->reg_mutex);
+
+	mt7530_update_port_member(priv, port, bridge.dev, true);
+
+	/* Set to fallback mode for independent VLAN learning */
+	regmap_fields_write(priv->fields[MT7530_PCR_PORT_VLAN],
+			    port, MT7530_PORT_FALLBACK_MODE);
+
+	mutex_unlock(priv->reg_mutex);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(mt7530_lib_port_bridge_join);
+
+void mt7530_lib_port_bridge_leave(struct mt7530_lib_priv *priv, int port,
+				  struct dsa_bridge bridge)
+{
+	mutex_lock(priv->reg_mutex);
+
+	mt7530_update_port_member(priv, port, bridge.dev, false);
+
+	/* When a port is removed from the bridge, the port would be set up
+	 * back to the default as is at initial boot which is a VLAN-unaware
+	 * port.
+	 */
+	regmap_fields_write(priv->fields[MT7530_PCR_PORT_VLAN],
+			    port, MT7530_PORT_MATRIX_MODE);
+
+	mutex_unlock(priv->reg_mutex);
+}
+EXPORT_SYMBOL_GPL(mt7530_lib_port_bridge_leave);
+
+static void mt7530_port_set_vlan_unaware(struct mt7530_lib_priv *priv, int port)
+{
+	struct dsa_switch *ds = priv->ds;
+	bool all_user_ports_removed = true;
+	int i;
+
+	/* This is called after .port_bridge_leave when leaving a VLAN-aware
+	 * bridge. Don't set standalone ports to fallback mode.
+	 */
+	if (dsa_port_bridge_dev_get(dsa_to_port(ds, port)))
+		regmap_fields_write(priv->fields[MT7530_PCR_PORT_VLAN],
+				    port, MT7530_PORT_FALLBACK_MODE);
+
+	regmap_fields_write(priv->fields[MT7530_PVC_VLAN_ATTR],
+			    port, MT7530_VLAN_TRANSPARENT);
+	regmap_fields_write(priv->fields[MT7530_PVC_EG_TAG],
+			    port, MT7530_VLAN_EG_CONSISTENT);
+	regmap_fields_write(priv->fields[MT7530_PVC_ACC_FRM],
+			    port, MT7530_VLAN_ACC_ALL);
+
+	regmap_fields_write(priv->fields[MT7530_PPBV1_G0_PORT_VID],
+			    port, G0_PORT_VID_DEF);
+
+	for (i = 0; i < priv->ds->num_ports; i++) {
+		if (i == port)
+			continue;
+		if (dsa_is_user_port(ds, i) &&
+		    dsa_port_is_vlan_filtering(dsa_to_port(ds, i))) {
+			all_user_ports_removed = false;
+			break;
+		}
+	}
+
+	/* CPU port also does the same thing until all user ports belonging to
+	 * the CPU port get out of VLAN filtering mode.
+	 */
+	if (all_user_ports_removed) {
+		mutex_lock(priv->reg_mutex);
+		mt7530_lib_setup_vlan0(priv);
+		mutex_unlock(priv->reg_mutex);
+	}
+}
+
+static void mt7530_port_set_vlan_aware(struct mt7530_lib_priv *priv, int port)
+{
+	struct dsa_switch *ds = priv->ds;
+
+	/* Trapped into security mode allows packet forwarding through VLAN
+	 * table lookup.
+	 */
+	if (dsa_is_user_port(ds, port)) {
+		regmap_fields_write(priv->fields[MT7530_PCR_PORT_VLAN],
+				    port, MT7530_PORT_SECURITY_MODE);
+		regmap_fields_write(priv->fields[MT7530_PPBV1_G0_PORT_VID],
+				    port, priv->ports[port].pvid);
+
+		/* Only accept tagged frames if PVID is not set */
+		if (!priv->ports[port].pvid)
+			regmap_fields_write(priv->fields[MT7530_PVC_ACC_FRM],
+					    port, MT7530_VLAN_ACC_TAGGED);
+
+		/* Set the port as a user port which is to be able to recognize
+		 * VID from incoming packets before fetching entry within the
+		 * VLAN table.
+		 */
+		regmap_fields_write(priv->fields[MT7530_PVC_VLAN_ATTR],
+				    port, MT7530_VLAN_USER);
+		regmap_fields_write(priv->fields[MT7530_PVC_EG_TAG],
+				    port, MT7530_VLAN_EG_DISABLED);
+	} else {
+		/* Also set CPU ports to the "user" VLAN port attribute, to
+		 * allow VLAN classification, but keep the EG_TAG attribute as
+		 * "consistent" (i.o.w. don't change its value) for packets
+		 * received by the switch from the CPU, so that tagged packets
+		 * are forwarded to user ports as tagged, and untagged as
+		 * untagged.
+		 */
+		regmap_fields_write(priv->fields[MT7530_PVC_VLAN_ATTR],
+				    port, MT7530_VLAN_USER);
+	}
+}
+
+int mt7530_lib_port_vlan_filtering(struct mt7530_lib_priv *priv, int port, bool vlan_filtering,
+				   struct netlink_ext_ack *extack)
+{
+	struct dsa_switch *ds = priv->ds;
+	struct dsa_port *cpu_dp, *dp;
+
+	dp = dsa_to_port(ds, port);
+	cpu_dp = dp->cpu_dp;
+
+	if (vlan_filtering) {
+		/* The port is being kept as VLAN-unaware port when bridge is
+		 * set up with vlan_filtering not being set, Otherwise, the
+		 * port and the corresponding CPU port is required the setup
+		 * for becoming a VLAN-aware port.
+		 */
+		mt7530_port_set_vlan_aware(priv, port);
+		mt7530_port_set_vlan_aware(priv, cpu_dp->index);
+	} else {
+		mt7530_port_set_vlan_unaware(priv, port);
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(mt7530_lib_port_vlan_filtering);
+
+static int mt7530_vlan_cmd(struct mt7530_lib_priv *priv, enum mt7530_vlan_cmd cmd,
+			   u16 vid)
+{
+	u32 val;
+	int ret;
+
+	ret = regmap_field_write(priv->fields[MT7530_VTCR_FUNC], cmd);
+	if (ret)
+		return ret;
+
+	ret = regmap_field_write(priv->fields[MT7530_VTCR_VID], vid);
+	if (ret)
+		return ret;
+
+	ret = regmap_field_write(priv->fields[MT7530_VTCR_BUSY], 1);
+	if (ret)
+		return ret;
+
+	ret = regmap_field_read_poll_timeout(priv->fields[MT7530_VTCR_BUSY],
+					     val, !val, 20, 20000);
+	if (ret < 0) {
+		dev_err(priv->dev, "poll timeout\n");
+		return ret;
+	}
+
+	regmap_field_read(priv->fields[MT7530_VTCR_INVALID], &val);
+	if (val) {
+		dev_err(priv->dev, "read VTCR invalid\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static void mt7530_hw_vlan_add(struct mt7530_lib_priv *priv,
+			       struct mt7530_hw_vlan_entry *entry)
+{
+	struct dsa_port *dp = dsa_to_port(priv->ds, entry->port);
+	u8 new_members;
+	u32 val;
+
+	new_members = entry->old_members | BIT(entry->port);
+
+	/* Validate the entry with independent learning, create egress tag per
+	 * VLAN and joining the port as one of the port members.
+	 */
+	regmap_field_write(priv->fields[MT7530_VAWD_IVL_MAC], 1);
+	regmap_field_write(priv->fields[MT7530_VAWD_VTAG_EN], 1);
+	regmap_field_write(priv->fields[MT7530_VAWD_PORT_MEM],
+			   new_members);
+	regmap_field_write(priv->fields[MT7530_VAWD_FID],
+			   FID_BRIDGED);
+	regmap_field_write(priv->fields[MT7530_VAWD_VLAN_VALID], 1);
+
+	/* Decide whether adding tag or not for those outgoing packets from the
+	 * port inside the VLAN.
+	 * CPU port is always taken as a tagged port for serving more than one
+	 * VLANs across and also being applied with egress type stack mode for
+	 * that VLAN tags would be appended after hardware special tag used as
+	 * DSA tag.
+	 */
+	if (dsa_port_is_cpu(dp))
+		val = MT7530_VLAN_EGRESS_STACK;
+	else if (entry->untagged)
+		val = MT7530_VLAN_EGRESS_UNTAG;
+	else
+		val = MT7530_VLAN_EGRESS_TAG;
+	regmap_field_update_bits(priv->fields[MT7530_VAWD_ETAG],
+				 ETAG_CTRL_P_MASK(entry->port),
+				 ETAG_CTRL_P(entry->port, val));
+}
+
+static void mt7530_hw_vlan_del(struct mt7530_lib_priv *priv,
+			       struct mt7530_hw_vlan_entry *entry)
+{
+	u8 new_members;
+	u32 val;
+
+	new_members = entry->old_members & ~BIT(entry->port);
+
+	regmap_field_read(priv->fields[MT7530_VAWD_VLAN_VALID], &val);
+	if (!val) {
+		dev_err(priv->dev,
+			"Cannot be deleted due to invalid entry\n");
+		return;
+	}
+
+	if (new_members) {
+		regmap_field_write(priv->fields[MT7530_VAWD_IVL_MAC], 1);
+		regmap_field_write(priv->fields[MT7530_VAWD_VTAG_EN], 1);
+		regmap_field_write(priv->fields[MT7530_VAWD_PORT_MEM],
+				   new_members);
+		regmap_field_write(priv->fields[MT7530_VAWD_VLAN_VALID], 1);
+	} else {
+		regmap_field_write(priv->fields[__MT7530_VAWD1], 0);
+		regmap_field_write(priv->fields[__MT7530_VAWD2], 0);
+	}
+}
+
+static void mt7530_hw_vlan_update(struct mt7530_lib_priv *priv, u16 vid,
+				  struct mt7530_hw_vlan_entry *entry,
+				  mt7530_vlan_op vlan_op)
+{
+	u32 val = 0;
+
+	/* Fetch entry */
+	mt7530_vlan_cmd(priv, MT7530_VTCR_RD_VID, vid);
+
+	regmap_field_read(priv->fields[MT7530_VAWD_PORT_MEM], &val);
+
+	entry->old_members = val;
+
+	/* Manipulate entry */
+	vlan_op(priv, entry);
+
+	/* Flush result to hardware */
+	mt7530_vlan_cmd(priv, MT7530_VTCR_WR_VID, vid);
+}
+
+int mt7530_lib_port_vlan_add(struct mt7530_lib_priv *priv, int port,
+			     const struct switchdev_obj_port_vlan *vlan,
+			     struct netlink_ext_ack *extack)
+{
+	bool untagged = vlan->flags & BRIDGE_VLAN_INFO_UNTAGGED;
+	bool pvid = vlan->flags & BRIDGE_VLAN_INFO_PVID;
+	struct mt7530_hw_vlan_entry new_entry;
+	struct dsa_switch *ds = priv->ds;
+
+	mutex_lock(priv->reg_mutex);
+
+	/* VID 0 is managed exclusively by mt7530_lib_setup_vlan0() for
+	 * VLAN-unaware bridge operation. Don't let the bridge overwrite
+	 * its EG_CON flag with VTAG_EN and corrupt PORT_MEM.
+	 */
+	if (vlan->vid == 0)
+		goto skip_vlan_table;
+
+	mt7530_hw_vlan_entry_init(&new_entry, port, untagged);
+	mt7530_hw_vlan_update(priv, vlan->vid, &new_entry, mt7530_hw_vlan_add);
+
+skip_vlan_table:
+
+	if (pvid) {
+		priv->ports[port].pvid = vlan->vid;
+
+		/* Accept all frames if PVID is set */
+		regmap_fields_write(priv->fields[MT7530_PVC_ACC_FRM],
+				    port, MT7530_VLAN_ACC_ALL);
+
+		/* Only configure PVID if VLAN filtering is enabled */
+		if (dsa_port_is_vlan_filtering(dsa_to_port(ds, port)))
+			regmap_fields_write(priv->fields[MT7530_PPBV1_G0_PORT_VID],
+					    port, vlan->vid);
+	} else if (vlan->vid && priv->ports[port].pvid == vlan->vid) {
+		/* This VLAN is overwritten without PVID, so unset it */
+		priv->ports[port].pvid = G0_PORT_VID_DEF;
+
+		/* Only accept tagged frames if the port is VLAN-aware */
+		if (dsa_port_is_vlan_filtering(dsa_to_port(ds, port)))
+			regmap_fields_write(priv->fields[MT7530_PVC_ACC_FRM],
+					    port, MT7530_VLAN_ACC_TAGGED);
+
+		regmap_fields_write(priv->fields[MT7530_PPBV1_G0_PORT_VID],
+				    port, G0_PORT_VID_DEF);
+	}
+
+	mutex_unlock(priv->reg_mutex);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(mt7530_lib_port_vlan_add);
+
+int mt7530_lib_port_vlan_del(struct mt7530_lib_priv *priv, int port,
+			     const struct switchdev_obj_port_vlan *vlan)
+{
+	struct mt7530_hw_vlan_entry target_entry;
+	struct dsa_switch *ds = priv->ds;
+
+	mutex_lock(priv->reg_mutex);
+
+	/* VID 0 is managed exclusively by mt7530_lib_setup_vlan0(). */
+	if (vlan->vid == 0)
+		goto skip_vlan_table;
+
+	mt7530_hw_vlan_entry_init(&target_entry, port, 0);
+	mt7530_hw_vlan_update(priv, vlan->vid, &target_entry,
+			      mt7530_hw_vlan_del);
+
+skip_vlan_table:
+	/* PVID is being restored to the default whenever the PVID port
+	 * is being removed from the VLAN.
+	 */
+	if (priv->ports[port].pvid == vlan->vid) {
+		priv->ports[port].pvid = G0_PORT_VID_DEF;
+
+		/* Only accept tagged frames if the port is VLAN-aware */
+		if (dsa_port_is_vlan_filtering(dsa_to_port(ds, port)))
+			regmap_fields_write(priv->fields[MT7530_PVC_ACC_FRM],
+					    port, MT7530_VLAN_ACC_TAGGED);
+
+		regmap_fields_write(priv->fields[MT7530_PPBV1_G0_PORT_VID],
+				    port, G0_PORT_VID_DEF);
+	}
+
+	mutex_unlock(priv->reg_mutex);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(mt7530_lib_port_vlan_del);
+
+int mt7530_lib_setup_vlan0(struct mt7530_lib_priv *priv)
+{
+	regmap_field_write(priv->fields[MT7530_VAWD_IVL_MAC], 1);
+	regmap_field_write(priv->fields[MT7530_VAWD_VTAG_EN], 0);
+	regmap_field_write(priv->fields[MT7530_VAWD_EG_CON], 1);
+	regmap_field_write(priv->fields[MT7530_VAWD_PORT_MEM],
+			   MT7530_ALL_MEMBERS);
+	regmap_field_write(priv->fields[MT7530_VAWD_FID],
+			   FID_BRIDGED);
+	regmap_field_write(priv->fields[MT7530_VAWD_VLAN_VALID], 1);
+	regmap_field_write(priv->fields[__MT7530_VAWD2], 0);
+
+	return mt7530_vlan_cmd(priv, MT7530_VTCR_WR_VID, 0);
+}
+EXPORT_SYMBOL_GPL(mt7530_lib_setup_vlan0);
+
+MODULE_AUTHOR("Christian Marangi <ansuelsmth@gmail.com>");
+MODULE_DESCRIPTION("Library Driver for Mediatek MT7530 Based Switch");
+MODULE_LICENSE("GPL");
diff --git a/drivers/net/dsa/mt7530-lib.h b/drivers/net/dsa/mt7530-lib.h
new file mode 100644
index 000000000000..bab68ff745fb
--- /dev/null
+++ b/drivers/net/dsa/mt7530-lib.h
@@ -0,0 +1,385 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef __MT7530_LIB_H
+#define __MT7530_LIB_H
+
+#define G0_PORT_VID_DEF			0
+#define MT7530_ALL_MEMBERS		0xff
+
+#define MTK_HDR_LEN	4
+#define MT7530_MAX_MTU	(15 * 1024 - ETH_HLEN - ETH_FCS_LEN - MTK_HDR_LEN)
+
+/* MT7530_ATA1 */
+#define  STATIC_EMP			0
+#define  STATIC_ENT			3
+
+#define  ATC_MAT_MACTAB			0
+
+enum mt7530_fdb_cmd {
+	MT7530_FDB_READ	= 0,
+	MT7530_FDB_WRITE = 1,
+	MT7530_FDB_FLUSH = 2,
+	MT7530_FDB_START = 4,
+	MT7530_FDB_NEXT = 5,
+};
+
+enum mt7530_max_rx_pkt_len {
+	MAX_RX_PKT_LEN_1522 = 0,
+	MAX_RX_PKT_LEN_1536 = 1,
+	MAX_RX_PKT_LEN_1552 = 2,
+	MAX_RX_PKT_LEN_JUMBO = 3,
+};
+
+#define  FID_PST(fid, state)		(((state) & 0x3) << ((fid) * 2))
+#define  FID_PST_MASK(fid)		FID_PST(fid, 0x3)
+
+enum mt7530_stp_state {
+	MT7530_STP_DISABLED = 0,
+	MT7530_STP_BLOCKING = 1,
+	MT7530_STP_LISTENING = 1,
+	MT7530_STP_LEARNING = 2,
+	MT7530_STP_FORWARDING  = 3
+};
+
+/* Egress Tag Control */
+#define  ETAG_CTRL_P(p, x)		(((x) & 0x3) << ((p) << 1))
+#define  ETAG_CTRL_P_MASK(p)		ETAG_CTRL_P(p, 3)
+
+enum mt753x_to_cpu_fw {
+	TO_CPU_FW_SYSTEM_DEFAULT,
+	TO_CPU_FW_CPU_EXCLUDE = 4,
+	TO_CPU_FW_CPU_INCLUDE = 5,
+	TO_CPU_FW_CPU_ONLY = 6,
+	TO_CPU_FW_DROP = 7,
+};
+
+enum mt7530_port_mode {
+	/* Port Matrix Mode: Frames are forwarded by the PCR_MATRIX members. */
+	MT7530_PORT_MATRIX_MODE = 0,
+
+	/* Fallback Mode: Forward received frames with ingress ports that do
+	 * not belong to the VLAN member. Frames whose VID is not listed on
+	 * the VLAN table are forwarded by the PCR_MATRIX members.
+	 */
+	MT7530_PORT_FALLBACK_MODE = 1,
+
+	/* Security Mode: Discard any frame due to ingress membership
+	 * violation or VID missed on the VLAN table.
+	 */
+	MT7530_PORT_SECURITY_MODE = 3,
+};
+
+enum mt7530_vlan_port_acc_frm {
+	MT7530_VLAN_ACC_ALL = 0,
+	MT7530_VLAN_ACC_TAGGED = 1,
+	MT7530_VLAN_ACC_UNTAGGED = 2,
+};
+
+enum mt7530_vlan_port_eg_tag {
+	MT7530_VLAN_EG_DISABLED = 0,
+	MT7530_VLAN_EG_CONSISTENT = 1,
+	MT7530_VLAN_EG_UNTAGGED = 4,
+};
+
+enum mt7530_vlan_port_attr {
+	MT7530_VLAN_USER = 0,
+	MT7530_VLAN_TRANSPARENT = 3,
+};
+
+enum mt7530_fid {
+	FID_STANDALONE = 0,
+	FID_BRIDGED = 1,
+};
+
+enum mt7530_vlan_egress_attr {
+	MT7530_VLAN_EGRESS_UNTAG = 0,
+	MT7530_VLAN_EGRESS_TAG = 2,
+	MT7530_VLAN_EGRESS_STACK = 3,
+};
+
+enum mt7530_vlan_cmd {
+	/* Read/Write the specified VID entry from VAWD register based
+	 * on VID.
+	 */
+	MT7530_VTCR_RD_VID = 0,
+	MT7530_VTCR_WR_VID = 1,
+};
+
+enum mt7530_regmap_field {
+	MT7530_MIRROR_EN,
+	MT7530_MIRROR_PORT,
+
+	MT7530_UNU_FFP,
+	MT7530_UNM_FFP,
+	MT7530_BC_FFP,
+
+	MT7530_CCR_MIB_ENABLE,
+	MT7530_CCR_RX_OCT_CNT_GOOD,
+	MT7530_CCR_RX_OCT_CNT_BAD,
+	MT7530_CCR_TX_OCT_CNT_GOOD,
+	MT7530_CCR_TX_OCT_CNT_BAD,
+
+	MT7530_BPDU_EG_TAG,
+	MT7530_BPDU_PORT_FW,
+	MT7530_PAE_BPDU_FR,
+	MT7530_PAE_EG_TAG,
+	MT7530_PAE_PORT_FW,
+	MT7530_R01_BPDU_FR,
+	MT7530_R01_EG_TAG,
+	MT7530_R01_PORT_FW,
+	MT7530_R02_BPDU_FR,
+	MT7530_R02_EG_TAG,
+	MT7530_R02_PORT_FW,
+	MT7530_R03_BPDU_FR,
+	MT7530_R03_EG_TAG,
+	MT7530_R03_PORT_FW,
+	MT7530_R0E_BPDU_FR,
+	MT7530_R0E_EG_TAG,
+	MT7530_R0E_PORT_FW,
+
+	MT7530_VAWD_IVL_MAC,
+	MT7530_VAWD_EG_CON,
+	MT7530_VAWD_VTAG_EN,
+	MT7530_VAWD_PORT_MEM,
+	MT7530_VAWD_FID,
+	MT7530_VAWD_VLAN_VALID,
+	__MT7530_VAWD1,
+
+	MT7530_VAWD_ETAG,
+	__MT7530_VAWD2,
+
+	MT7530_VTCR_BUSY,
+	MT7530_VTCR_FUNC,
+	MT7530_VTCR_VID,
+	MT7530_VTCR_INVALID,
+
+	MT7530_ATWD_CVID,
+	MT7530_ATWD_IVL,
+	MT7530_ATWD_FID,
+	MT7530_ATWD_AGE_TIMER,
+	MT7530_ATWD_PORT_MAP,
+	MT7530_ATWD_ENT_STATUS,
+	MT7530_ATWD_MAC_BYTE_5,
+	MT7530_ATWD_MAC_BYTE_4,
+	MT7530_ATWD_MAC_BYTE_3,
+	MT7530_ATWD_MAC_BYTE_2,
+	MT7530_ATWD_MAC_BYTE_1,
+	MT7530_ATWD_MAC_BYTE_0,
+
+	MT7530_ATRD_CVID,
+	MT7530_ATRD_AGE_TIMER,
+	MT7530_ATRD_PORT_MAP,
+	MT7530_ATRD_ENT_STATUS,
+	MT7530_ATRD_MAC_BYTE_5,
+	MT7530_ATRD_MAC_BYTE_4,
+	MT7530_ATRD_MAC_BYTE_3,
+	MT7530_ATRD_MAC_BYTE_2,
+	MT7530_ATRD_MAC_BYTE_1,
+	MT7530_ATRD_MAC_BYTE_0,
+
+	MT7530_ATC_BUSY,
+	MT7530_ATC_MAT,
+	MT7530_ATC_INVALID,
+	MT7530_ATC_CMD,
+	__MT7530_ATC,
+
+	MT7530_SSP_FID_PST,
+
+	MT7530_PCR_PORT_TX_MIR,
+	MT7530_PCR_PORT_RX_MIR,
+	MT7530_PCR_PORT_VLAN,
+	MT7530_PCR_MATRIX,
+
+	MT7530_PSC_SA_DIR,
+
+	MT7530_PVC_EG_TAG,
+	MT7530_PVC_VLAN_ATTR,
+	MT7530_PVC_ACC_FRM,
+
+	MT7530_PPBV1_G0_PORT_VID,
+
+	MT7530_GMACCR_MAX_RX_JUMBO,
+	MT7530_GMACCR_MAX_RX_PKT_LEN,
+
+	MT7530_MIB_TX_DROP,
+	MT7530_MIB_TX_CRC_ERR,
+	MT7530_MIB_TX_UNICAST,
+	MT7530_MIB_TX_MULTICAST,
+	MT7530_MIB_TX_BROADCAST,
+	MT7530_MIB_TX_COLLISION,
+	MT7530_MIB_TX_SINGLE_COLLISION,
+	MT7530_MIB_TX_MULTIPLE_COLLISION,
+	MT7530_MIB_TX_DEFERRED,
+	MT7530_MIB_TX_LATE_COLLISION,
+	MT7530_MIB_TX_EXCESSIVE_COLLISION,
+	MT7530_MIB_TX_PAUSE,
+	MT7530_MIB_TX_PKT_SZ_64,
+	MT7530_MIB_TX_PKT_SZ_65_TO_127,
+	MT7530_MIB_TX_PKT_SZ_128_TO_255,
+	MT7530_MIB_TX_PKT_SZ_256_TO_511,
+	MT7530_MIB_TX_PKT_SZ_512_TO_1023,
+	MT7530_MIB_TX_PKT_SZ_1024_TO_MAX,
+	MT7530_MIB_TX_BYTES_LOW,
+	MT7530_MIB_TX_BYTES_HIGH,
+	MT7530_MIB_RX_DROP,
+	MT7530_MIB_RX_FILTERING,
+	MT7530_MIB_RX_UNICAST,
+	MT7530_MIB_RX_MULTICAST,
+	MT7530_MIB_RX_BROADCAST,
+	MT7530_MIB_RX_ALIGN_ERR,
+	MT7530_MIB_RX_CRC_ERR,
+	MT7530_MIB_RX_UNDER_SIZE_ERR,
+	MT7530_MIB_RX_FRAG_ERR,
+	MT7530_MIB_RX_OVER_SZ_ERR,
+	MT7530_MIB_RX_JABBER_ERR,
+	MT7530_MIB_RX_PAUSE,
+	MT7530_MIB_RX_PKT_SZ_64,
+	MT7530_MIB_RX_PKT_SZ_65_TO_127,
+	MT7530_MIB_RX_PKT_SZ_128_TO_255,
+	MT7530_MIB_RX_PKT_SZ_256_TO_511,
+	MT7530_MIB_RX_PKT_SZ_512_TO_1023,
+	MT7530_MIB_RX_PKT_SZ_1024_TO_MAX,
+	MT7530_MIB_RX_BYTES_LOW,
+	MT7530_MIB_RX_BYTES_HIGH,
+	MT7530_MIB_RX_CTRL_DROP,
+	MT7530_MIB_RX_INGRESS_DROP,
+	MT7530_MIB_RX_ARL_DROP,
+
+	MT7530_FIELD_MAX,
+};
+
+struct mt7530_fdb {
+	u16 vid;
+	u8 port_mask;
+	u8 aging;
+	u8 mac[6];
+	bool noarp;
+};
+
+struct mt7530_hw_vlan_entry {
+	int port;
+	u8  old_members;
+	bool untagged;
+};
+
+static inline void mt7530_hw_vlan_entry_init(struct mt7530_hw_vlan_entry *e,
+					     int port, bool untagged)
+{
+	e->port = port;
+	e->untagged = untagged;
+}
+
+#define MIB_DESC(_fl, _fh, _n)	\
+	{			\
+		.field_low = (_fl),	\
+		.field_high = (_fh),	\
+		.name = (_n),	\
+	}
+
+struct mt7530_mib_desc {
+	int field_low;
+	int field_high;
+	const char *name;
+};
+
+struct mt7530_rmon_hist {
+	unsigned int *ranges_fields;
+	unsigned int *ranges_tx_fields;
+	const struct ethtool_rmon_hist_range *ranges;
+	unsigned int num_ranges;
+};
+
+struct mt7530_reg_field {
+	unsigned int id;
+	const struct reg_field field;
+};
+
+/* struct mt7530_port -	This is the main data structure for holding the state
+ *			of the port.
+ * @enable:	The status used for show port is enabled or not.
+ * @pm:		The matrix used to show all connections with the port.
+ * @pvid:	The VLAN specified is to be considered a PVID at ingress.  Any
+ *		untagged frames will be assigned to the related VLAN.
+ * @sgmii_pcs:	Pointer to PCS instance for SerDes ports
+ * @stats:	Cached port statistics for MDIO-connected switches
+ */
+struct mt7530_port {
+	bool enable;
+	bool isolated;
+	u32 pm;
+	u16 pvid;
+	struct phylink_pcs *sgmii_pcs;
+	struct rtnl_link_stats64 stats;
+};
+
+struct mt7530_lib_priv {
+	struct device *dev;
+	struct dsa_switch *ds;
+	struct regmap *regmap;
+	struct regmap_field *fields[MT7530_FIELD_MAX];
+
+	u8 mirror_rx;
+	u8 mirror_tx;
+
+	struct mt7530_port *ports;
+	struct mutex *reg_mutex;
+};
+
+typedef void (*mt7530_vlan_op)(struct mt7530_lib_priv *,
+			       struct mt7530_hw_vlan_entry *);
+
+void mt7530_lib_mib_reset(struct mt7530_lib_priv *priv);
+void mt7530_lib_trap_frames(struct mt7530_lib_priv *priv);
+
+void mt7530_lib_read_port_stats(struct regmap_field *low,
+				struct regmap_field *high,
+				int port, uint64_t *data);
+void mt7530_lib_get_eth_mac_stats(struct mt7530_lib_priv *priv, int port,
+				  struct ethtool_eth_mac_stats *mac_stats);
+void mt7530_lib_get_rmon_stats(struct mt7530_lib_priv *priv, int port,
+			       struct ethtool_rmon_stats *rmon_stats,
+			       const struct ethtool_rmon_hist_range **ranges,
+			       const struct mt7530_rmon_hist *ranges_info);
+void mt7530_lib_get_eth_ctrl_stats(struct mt7530_lib_priv *priv, int port,
+				   struct ethtool_eth_ctrl_stats *ctrl_stats);
+int mt7530_lib_fdb_cmd(struct mt7530_lib_priv *priv, enum mt7530_fdb_cmd cmd,
+		       u32 mat, u32 *rsp);
+void mt7530_lib_fdb_read(struct mt7530_lib_priv *priv, struct mt7530_fdb *fdb);
+int mt7530_lib_port_fdb_add(struct mt7530_lib_priv *priv, int port,
+			    const unsigned char *addr, u16 vid,
+			    struct dsa_db db);
+int mt7530_lib_port_fdb_del(struct mt7530_lib_priv *priv, int port,
+			    const unsigned char *addr, u16 vid,
+			    struct dsa_db db);
+int mt7530_lib_port_mdb_add(struct mt7530_lib_priv *priv, int port,
+			    const struct switchdev_obj_port_mdb *mdb,
+			    struct dsa_db db);
+int mt7530_lib_port_mdb_del(struct mt7530_lib_priv *priv, int port,
+			    const struct switchdev_obj_port_mdb *mdb,
+			    struct dsa_db db);
+void mt7530_lib_port_mirror_del(struct mt7530_lib_priv *priv, int port,
+				struct dsa_mall_mirror_tc_entry *mirror);
+int mt7530_lib_port_mirror_add(struct mt7530_lib_priv *priv, int port,
+			       struct dsa_mall_mirror_tc_entry *mirror,
+			       bool ingress, struct netlink_ext_ack *extack);
+int mt7530_lib_port_change_mtu(struct mt7530_lib_priv *priv, int port, int new_mtu);
+void mt7530_lib_stp_state_set(struct mt7530_lib_priv *priv, int port, u8 state);
+int mt7530_lib_port_bridge_flags(struct mt7530_lib_priv *priv, int port,
+				 struct switchdev_brport_flags flags,
+				 struct netlink_ext_ack *extack);
+int mt7530_lib_port_bridge_join(struct mt7530_lib_priv *priv, int port,
+				struct dsa_bridge bridge, bool *tx_fwd_offload,
+				struct netlink_ext_ack *extack);
+void mt7530_lib_port_bridge_leave(struct mt7530_lib_priv *priv, int port,
+				  struct dsa_bridge bridge);
+int mt7530_lib_port_vlan_filtering(struct mt7530_lib_priv *priv, int port, bool vlan_filtering,
+				   struct netlink_ext_ack *extack);
+int mt7530_lib_port_vlan_add(struct mt7530_lib_priv *priv, int port,
+			     const struct switchdev_obj_port_vlan *vlan,
+			     struct netlink_ext_ack *extack);
+int mt7530_lib_port_vlan_del(struct mt7530_lib_priv *priv, int port,
+			     const struct switchdev_obj_port_vlan *vlan);
+
+int mt7530_lib_setup_vlan0(struct mt7530_lib_priv *priv);
+
+#endif /* __MT7530_LIB_H */
+
diff --git a/drivers/net/dsa/mt7530-mdio.c b/drivers/net/dsa/mt7530-mdio.c
index 422f785d2143..b94de106ff54 100644
--- a/drivers/net/dsa/mt7530-mdio.c
+++ b/drivers/net/dsa/mt7530-mdio.c
@@ -215,6 +215,10 @@ mt7530_probe(struct mdio_device *mdiodev)
 	if (IS_ERR(priv->regmap))
 		return PTR_ERR(priv->regmap);
 
+	ret = mt7530_setup_lib_priv(priv);
+	if (ret)
+		return ret;
+
 	if (priv->id == ID_MT7531)
 		priv->create_sgmii = mt7531_create_sgmii;
 
diff --git a/drivers/net/dsa/mt7530-mmio.c b/drivers/net/dsa/mt7530-mmio.c
index fd68b1cd0630..3304d1b1a06d 100644
--- a/drivers/net/dsa/mt7530-mmio.c
+++ b/drivers/net/dsa/mt7530-mmio.c
@@ -61,6 +61,10 @@ mt7988_probe(struct platform_device *pdev)
 	if (IS_ERR(priv->regmap))
 		return PTR_ERR(priv->regmap);
 
+	ret = mt7530_setup_lib_priv(priv);
+	if (ret)
+		return ret;
+
 	return dsa_register_switch(priv->ds);
 }
 
diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
index d01772cfe3a2..f313a7a7bfef 100644
--- a/drivers/net/dsa/mt7530.c
+++ b/drivers/net/dsa/mt7530.c
@@ -24,10 +24,159 @@
 #include <net/pkt_cls.h>
 
 #include "mt7530.h"
+#include "mt7530-lib.h"
 
 #define MT7530_STATS_POLL_INTERVAL	(1 * HZ)
 #define MT7530_STATS_RATE_LIMIT		(HZ / 10)
 
+static const struct mt7530_reg_field mt753x_fields[] = {
+	{ MT7530_BC_FFP, REG_FIELD(MT753X_MFC, 24, 31) },
+	{ MT7530_UNM_FFP, REG_FIELD(MT753X_MFC, 16, 23) },
+	{ MT7530_UNU_FFP, REG_FIELD(MT753X_MFC, 8, 15) },
+
+	{ MT7530_CCR_MIB_ENABLE, REG_FIELD(MT7530_MIB_CCR, 31, 31) },
+	{ MT7530_CCR_RX_OCT_CNT_GOOD, REG_FIELD(MT7530_MIB_CCR, 7, 7) },
+	{ MT7530_CCR_RX_OCT_CNT_BAD, REG_FIELD(MT7530_MIB_CCR, 6, 6) },
+	{ MT7530_CCR_TX_OCT_CNT_GOOD, REG_FIELD(MT7530_MIB_CCR, 5, 5) },
+	{ MT7530_CCR_TX_OCT_CNT_BAD, REG_FIELD(MT7530_MIB_CCR, 4, 4) },
+
+	{ MT7530_BPDU_EG_TAG, REG_FIELD(MT753X_BPC, 6, 8) },
+	{ MT7530_BPDU_PORT_FW, REG_FIELD(MT753X_BPC, 0, 2) },
+	{ MT7530_PAE_BPDU_FR, REG_FIELD(MT753X_BPC, 25, 25) },
+	{ MT7530_PAE_EG_TAG, REG_FIELD(MT753X_BPC, 22, 24) },
+	{ MT7530_PAE_PORT_FW, REG_FIELD(MT753X_BPC, 16, 18) },
+	{ MT7530_R01_BPDU_FR, REG_FIELD(MT753X_RGAC1, 9, 9) },
+	{ MT7530_R01_EG_TAG, REG_FIELD(MT753X_RGAC1, 6, 8) },
+	{ MT7530_R01_PORT_FW, REG_FIELD(MT753X_RGAC1, 0, 2) },
+	{ MT7530_R02_BPDU_FR, REG_FIELD(MT753X_RGAC1, 25, 25) },
+	{ MT7530_R02_EG_TAG, REG_FIELD(MT753X_RGAC1, 22, 24) },
+	{ MT7530_R02_PORT_FW, REG_FIELD(MT753X_RGAC1, 16, 18) },
+	{ MT7530_R03_BPDU_FR, REG_FIELD(MT753X_RGAC2, 9, 9) },
+	{ MT7530_R03_EG_TAG, REG_FIELD(MT753X_RGAC2, 6, 8) },
+	{ MT7530_R03_PORT_FW, REG_FIELD(MT753X_RGAC2, 0, 2) },
+	{ MT7530_R0E_BPDU_FR, REG_FIELD(MT753X_RGAC2, 25, 25) },
+	{ MT7530_R0E_EG_TAG, REG_FIELD(MT753X_RGAC2, 22, 24) },
+	{ MT7530_R0E_PORT_FW, REG_FIELD(MT753X_RGAC2, 16, 18) },
+
+	{ MT7530_VAWD_IVL_MAC, REG_FIELD(MT7530_VAWD1, 30, 30) },
+	{ MT7530_VAWD_EG_CON, REG_FIELD(MT7530_VAWD1, 29, 29) },
+	{ MT7530_VAWD_VTAG_EN, REG_FIELD(MT7530_VAWD1, 28, 28) },
+	{ MT7530_VAWD_PORT_MEM, REG_FIELD(MT7530_VAWD1, 16, 23) },
+	{ MT7530_VAWD_FID, REG_FIELD(MT7530_VAWD1, 1, 3) },
+	{ MT7530_VAWD_VLAN_VALID, REG_FIELD(MT7530_VAWD1, 0, 0) },
+	{ __MT7530_VAWD1, REG_FIELD(MT7530_VAWD1, 0, 31) },
+
+	{ MT7530_VAWD_ETAG, REG_FIELD(MT7530_VAWD2, 0, 15) },
+	{ __MT7530_VAWD2, REG_FIELD(MT7530_VAWD2, 0, 31) },
+
+	{ MT7530_VTCR_BUSY, REG_FIELD(MT7530_VTCR, 31, 31) },
+	{ MT7530_VTCR_INVALID, REG_FIELD(MT7530_VTCR, 16, 16) },
+	{ MT7530_VTCR_FUNC, REG_FIELD(MT7530_VTCR, 12, 15) },
+	{ MT7530_VTCR_VID, REG_FIELD(MT7530_VTCR, 0, 11) },
+
+	{ MT7530_ATWD_CVID, REG_FIELD(MT7530_ATA2, 0, 11), },
+	{ MT7530_ATWD_IVL, REG_FIELD(MT7530_ATA2, 15, 15), },
+	{ MT7530_ATWD_FID, REG_FIELD(MT7530_ATA2, 12, 14), },
+	{ MT7530_ATWD_AGE_TIMER, REG_FIELD(MT7530_ATWD, 24, 31), },
+	{ MT7530_ATWD_PORT_MAP, REG_FIELD(MT7530_ATWD, 4, 11), },
+	{ MT7530_ATWD_ENT_STATUS, REG_FIELD(MT7530_ATWD, 2, 3), },
+	{ MT7530_ATWD_MAC_BYTE_5, REG_FIELD(MT7530_ATA2, 16, 23), },
+	{ MT7530_ATWD_MAC_BYTE_4, REG_FIELD(MT7530_ATA2, 24, 31), },
+	{ MT7530_ATWD_MAC_BYTE_3, REG_FIELD(MT7530_ATA1, 0, 7), },
+	{ MT7530_ATWD_MAC_BYTE_2, REG_FIELD(MT7530_ATA1, 8, 15), },
+	{ MT7530_ATWD_MAC_BYTE_1, REG_FIELD(MT7530_ATA1, 16, 23), },
+	{ MT7530_ATWD_MAC_BYTE_0, REG_FIELD(MT7530_ATA1, 24, 31), },
+
+	{ MT7530_ATRD_CVID, REG_FIELD(MT7530_TSRA2, 0, 11), },
+	{ MT7530_ATRD_AGE_TIMER, REG_FIELD(MT7530_ATRD, 24, 31), },
+	{ MT7530_ATRD_PORT_MAP, REG_FIELD(MT7530_ATRD, 4, 11), },
+	{ MT7530_ATRD_ENT_STATUS, REG_FIELD(MT7530_ATRD, 2, 3), },
+	{ MT7530_ATRD_MAC_BYTE_5, REG_FIELD(MT7530_TSRA2, 24, 31), },
+	{ MT7530_ATRD_MAC_BYTE_4, REG_FIELD(MT7530_TSRA2, 16, 23), },
+	{ MT7530_ATRD_MAC_BYTE_3, REG_FIELD(MT7530_TSRA1, 0, 7), },
+	{ MT7530_ATRD_MAC_BYTE_2, REG_FIELD(MT7530_TSRA1, 8, 15), },
+	{ MT7530_ATRD_MAC_BYTE_1, REG_FIELD(MT7530_TSRA1, 16, 23), },
+	{ MT7530_ATRD_MAC_BYTE_0, REG_FIELD(MT7530_TSRA1, 24, 31), },
+
+	{ MT7530_ATC_BUSY, REG_FIELD(MT7530_ATC, 15, 15), },
+	{ MT7530_ATC_INVALID, REG_FIELD(MT7530_ATC, 12, 12), },
+	{ MT7530_ATC_MAT, REG_FIELD(MT7530_ATC, 8, 11), },
+	{ MT7530_ATC_CMD, REG_FIELD(MT7530_ATC, 0, 2), },
+	{ __MT7530_ATC, REG_FIELD(MT7530_ATC, 0, 31), },
+
+	{ MT7530_SSP_FID_PST, REG_FIELD_ID(MT7530_SSP, 0, 15, MT7530_NUM_PORTS, 0x100) },
+
+	{ MT7530_PCR_PORT_TX_MIR, REG_FIELD_ID(MT7530_PCR, 9, 9, MT7530_NUM_PORTS, 0x100) },
+	{ MT7530_PCR_PORT_RX_MIR, REG_FIELD_ID(MT7530_PCR, 8, 8, MT7530_NUM_PORTS, 0x100) },
+	{ MT7530_PCR_PORT_VLAN, REG_FIELD_ID(MT7530_PCR, 0, 1, MT7530_NUM_PORTS, 0x100) },
+	{ MT7530_PCR_MATRIX, REG_FIELD_ID(MT7530_PCR, 16, 23, MT7530_NUM_PORTS, 0x100) },
+
+	{ MT7530_PSC_SA_DIR, REG_FIELD_ID(MT7530_PSC, 4, 4, MT7530_NUM_PORTS, 0x100) },
+
+	{ MT7530_PVC_EG_TAG, REG_FIELD_ID(MT7530_PVC, 8, 10, MT7530_NUM_PORTS, 0x100) },
+	{ MT7530_PVC_VLAN_ATTR, REG_FIELD_ID(MT7530_PVC, 6, 7, MT7530_NUM_PORTS, 0x100) },
+	{ MT7530_PVC_ACC_FRM, REG_FIELD_ID(MT7530_PVC, 0, 1, MT7530_NUM_PORTS, 0x100) },
+
+	{ MT7530_PPBV1_G0_PORT_VID, REG_FIELD_ID(MT7530_PPBV1, 0, 11, MT7530_NUM_PORTS, 0x100) },
+
+	{ MT7530_GMACCR_MAX_RX_JUMBO, REG_FIELD(MT7530_GMACCR, 2, 5) },
+	{ MT7530_GMACCR_MAX_RX_PKT_LEN, REG_FIELD(MT7530_GMACCR, 0, 1) },
+
+	{ MT7530_MIB_TX_DROP, REG_FIELD_ID(MT7530_PORT_MIB_TX_DROP, 0, 31, MT7530_NUM_PORTS, 0x100) },
+	{ MT7530_MIB_TX_CRC_ERR, REG_FIELD_ID(MT7530_PORT_MIB_TX_CRC_ERR, 0, 31, MT7530_NUM_PORTS, 0x100) },
+	{ MT7530_MIB_TX_UNICAST, REG_FIELD_ID(MT7530_PORT_MIB_TX_UNICAST, 0, 31, MT7530_NUM_PORTS, 0x100) },
+	{ MT7530_MIB_TX_MULTICAST, REG_FIELD_ID(MT7530_PORT_MIB_TX_MULTICAST, 0, 31, MT7530_NUM_PORTS, 0x100) },
+	{ MT7530_MIB_TX_BROADCAST, REG_FIELD_ID(MT7530_PORT_MIB_TX_BROADCAST, 0, 31, MT7530_NUM_PORTS, 0x100) },
+	{ MT7530_MIB_TX_COLLISION, REG_FIELD_ID(MT7530_PORT_MIB_TX_COLLISION, 0, 31, MT7530_NUM_PORTS, 0x100) },
+	{ MT7530_MIB_TX_SINGLE_COLLISION, REG_FIELD_ID(MT7530_PORT_MIB_TX_SINGLE_COLLISION, 0, 31, MT7530_NUM_PORTS, 0x100) },
+	{ MT7530_MIB_TX_MULTIPLE_COLLISION, REG_FIELD_ID(MT7530_PORT_MIB_TX_MULTIPLE_COLLISION, 0, 31, MT7530_NUM_PORTS, 0x100) },
+	{ MT7530_MIB_TX_DEFERRED, REG_FIELD_ID(MT7530_PORT_MIB_TX_DEFERRED, 0, 31, MT7530_NUM_PORTS, 0x100) },
+	{ MT7530_MIB_TX_LATE_COLLISION, REG_FIELD_ID(MT7530_PORT_MIB_TX_LATE_COLLISION, 0, 31, MT7530_NUM_PORTS, 0x100) },
+	{ MT7530_MIB_TX_EXCESSIVE_COLLISION, REG_FIELD_ID(MT7530_PORT_MIB_TX_EXCESSIVE_COLLISION, 0, 31, MT7530_NUM_PORTS, 0x100) },
+	{ MT7530_MIB_TX_PAUSE, REG_FIELD_ID(MT7530_PORT_MIB_TX_PAUSE, 0, 31, MT7530_NUM_PORTS, 0x100) },
+	{ MT7530_MIB_TX_PKT_SZ_64, REG_FIELD_ID(MT7530_PORT_MIB_TX_PKT_SZ_64, 0, 31, MT7530_NUM_PORTS, 0x100) },
+	{ MT7530_MIB_TX_PKT_SZ_65_TO_127, REG_FIELD_ID(MT7530_PORT_MIB_TX_PKT_SZ_65_TO_127, 0, 31, MT7530_NUM_PORTS, 0x100) },
+	{ MT7530_MIB_TX_PKT_SZ_128_TO_255, REG_FIELD_ID(MT7530_PORT_MIB_TX_PKT_SZ_128_TO_255, 0, 31, MT7530_NUM_PORTS, 0x100) },
+	{ MT7530_MIB_TX_PKT_SZ_256_TO_511, REG_FIELD_ID(MT7530_PORT_MIB_TX_PKT_SZ_256_TO_511, 0, 31, MT7530_NUM_PORTS, 0x100) },
+	{ MT7530_MIB_TX_PKT_SZ_512_TO_1023, REG_FIELD_ID(MT7530_PORT_MIB_TX_PKT_SZ_512_TO_1023, 0, 31, MT7530_NUM_PORTS, 0x100) },
+	{ MT7530_MIB_TX_PKT_SZ_1024_TO_MAX, REG_FIELD_ID(MT7530_PORT_MIB_TX_PKT_SZ_1024_TO_MAX, 0, 31, MT7530_NUM_PORTS, 0x100) },
+	{ MT7530_MIB_TX_BYTES_LOW, REG_FIELD_ID(MT7530_PORT_MIB_TX_BYTES_LOW, 0, 31, MT7530_NUM_PORTS, 0x100) },
+	{ MT7530_MIB_TX_BYTES_HIGH, REG_FIELD_ID(MT7530_PORT_MIB_TX_BYTES_HIGH, 0, 31, MT7530_NUM_PORTS, 0x100) },
+	{ MT7530_MIB_RX_DROP, REG_FIELD_ID(MT7530_PORT_MIB_RX_DROP, 0, 31, MT7530_NUM_PORTS, 0x100) },
+	{ MT7530_MIB_RX_FILTERING, REG_FIELD_ID(MT7530_PORT_MIB_RX_FILTERING, 0, 31, MT7530_NUM_PORTS, 0x100) },
+	{ MT7530_MIB_RX_UNICAST, REG_FIELD_ID(MT7530_PORT_MIB_RX_UNICAST, 0, 31, MT7530_NUM_PORTS, 0x100) },
+	{ MT7530_MIB_RX_MULTICAST, REG_FIELD_ID(MT7530_PORT_MIB_RX_MULTICAST, 0, 31, MT7530_NUM_PORTS, 0x100) },
+	{ MT7530_MIB_RX_BROADCAST, REG_FIELD_ID(MT7530_PORT_MIB_RX_BROADCAST, 0, 31, MT7530_NUM_PORTS, 0x100) },
+	{ MT7530_MIB_RX_ALIGN_ERR, REG_FIELD_ID(MT7530_PORT_MIB_RX_ALIGN_ERR, 0, 31, MT7530_NUM_PORTS, 0x100) },
+	{ MT7530_MIB_RX_CRC_ERR, REG_FIELD_ID(MT7530_PORT_MIB_RX_CRC_ERR, 0, 31, MT7530_NUM_PORTS, 0x100) },
+	{ MT7530_MIB_RX_UNDER_SIZE_ERR, REG_FIELD_ID(MT7530_PORT_MIB_RX_UNDER_SIZE_ERR, 0, 31, MT7530_NUM_PORTS, 0x100) },
+	{ MT7530_MIB_RX_FRAG_ERR, REG_FIELD_ID(MT7530_PORT_MIB_RX_FRAG_ERR, 0, 31, MT7530_NUM_PORTS, 0x100) },
+	{ MT7530_MIB_RX_OVER_SZ_ERR, REG_FIELD_ID(MT7530_PORT_MIB_RX_OVER_SZ_ERR, 0, 31, MT7530_NUM_PORTS, 0x100) },
+	{ MT7530_MIB_RX_JABBER_ERR, REG_FIELD_ID(MT7530_PORT_MIB_RX_JABBER_ERR, 0, 31, MT7530_NUM_PORTS, 0x100) },
+	{ MT7530_MIB_RX_PAUSE, REG_FIELD_ID(MT7530_PORT_MIB_RX_PAUSE, 0, 31, MT7530_NUM_PORTS, 0x100) },
+	{ MT7530_MIB_RX_PKT_SZ_64, REG_FIELD_ID(MT7530_PORT_MIB_RX_PKT_SZ_64, 0, 31, MT7530_NUM_PORTS, 0x100) },
+	{ MT7530_MIB_RX_PKT_SZ_65_TO_127, REG_FIELD_ID(MT7530_PORT_MIB_RX_PKT_SZ_65_TO_127, 0, 31, MT7530_NUM_PORTS, 0x100) },
+	{ MT7530_MIB_RX_PKT_SZ_128_TO_255, REG_FIELD_ID(MT7530_PORT_MIB_RX_PKT_SZ_128_TO_255, 0, 31, MT7530_NUM_PORTS, 0x100) },
+	{ MT7530_MIB_RX_PKT_SZ_256_TO_511, REG_FIELD_ID(MT7530_PORT_MIB_RX_PKT_SZ_256_TO_511, 0, 31, MT7530_NUM_PORTS, 0x100) },
+	{ MT7530_MIB_RX_PKT_SZ_512_TO_1023, REG_FIELD_ID(MT7530_PORT_MIB_RX_PKT_SZ_512_TO_1023, 0, 31, MT7530_NUM_PORTS, 0x100) },
+	{ MT7530_MIB_RX_PKT_SZ_1024_TO_MAX, REG_FIELD_ID(MT7530_PORT_MIB_RX_PKT_SZ_1024_TO_MAX, 0, 31, MT7530_NUM_PORTS, 0x100) },
+	{ MT7530_MIB_RX_BYTES_LOW, REG_FIELD_ID(MT7530_PORT_MIB_RX_BYTES_LOW, 0, 31, MT7530_NUM_PORTS, 0x100) },
+	{ MT7530_MIB_RX_BYTES_HIGH, REG_FIELD_ID(MT7530_PORT_MIB_RX_BYTES_HIGH, 0, 31, MT7530_NUM_PORTS, 0x100) },
+	{ MT7530_MIB_RX_CTRL_DROP, REG_FIELD_ID(MT7530_PORT_MIB_RX_CTRL_DROP, 0, 31, MT7530_NUM_PORTS, 0x100) },
+	{ MT7530_MIB_RX_INGRESS_DROP, REG_FIELD_ID(MT7530_PORT_MIB_RX_INGRESS_DROP, 0, 31, MT7530_NUM_PORTS, 0x100) },
+	{ MT7530_MIB_RX_ARL_DROP, REG_FIELD_ID(MT7530_PORT_MIB_RX_ARL_DROP, 0, 31, MT7530_NUM_PORTS, 0x100) },
+};
+
+static const struct mt7530_reg_field mt7530_fields[] = {
+	{ MT7530_MIRROR_EN, REG_FIELD(MT753X_MFC, 3, 3) },
+	{ MT7530_MIRROR_PORT, REG_FIELD(MT753X_MFC, 0, 2) },
+};
+
+static const struct mt7530_reg_field mt7531_fields[] = {
+	{ MT7530_MIRROR_EN, REG_FIELD(MT7531_CFC, 19, 19) },
+	{ MT7530_MIRROR_PORT, REG_FIELD(MT7531_CFC, 16, 18) },
+};
+
 static struct mt753x_pcs *pcs_to_mt753x_pcs(struct phylink_pcs *pcs)
 {
 	return container_of(pcs, struct mt753x_pcs, pcs);
@@ -35,15 +184,15 @@ static struct mt753x_pcs *pcs_to_mt753x_pcs(struct phylink_pcs *pcs)
 
 /* String, offset, and register size in bytes if different from 4 bytes */
 static const struct mt7530_mib_desc mt7530_mib[] = {
-	MIB_DESC(1, MT7530_PORT_MIB_TX_DROP, "TxDrop"),
-	MIB_DESC(1, MT7530_PORT_MIB_TX_CRC_ERR, "TxCrcErr"),
-	MIB_DESC(1, MT7530_PORT_MIB_TX_COLLISION, "TxCollision"),
-	MIB_DESC(1, MT7530_PORT_MIB_RX_DROP, "RxDrop"),
-	MIB_DESC(1, MT7530_PORT_MIB_RX_FILTERING, "RxFiltering"),
-	MIB_DESC(1, MT7530_PORT_MIB_RX_CRC_ERR, "RxCrcErr"),
-	MIB_DESC(1, MT7530_PORT_MIB_RX_CTRL_DROP, "RxCtrlDrop"),
-	MIB_DESC(1, MT7530_PORT_MIB_RX_INGRESS_DROP, "RxIngressDrop"),
-	MIB_DESC(1, MT7530_PORT_MIB_RX_ARL_DROP, "RxArlDrop"),
+	MIB_DESC(MT7530_MIB_TX_DROP, -1, "TxDrop"),
+	MIB_DESC(MT7530_MIB_TX_CRC_ERR, -1, "TxCrcErr"),
+	MIB_DESC(MT7530_MIB_TX_COLLISION, -1, "TxCollision"),
+	MIB_DESC(MT7530_MIB_RX_DROP, -1, "RxDrop"),
+	MIB_DESC(MT7530_MIB_RX_FILTERING, -1, "RxFiltering"),
+	MIB_DESC(MT7530_MIB_RX_CRC_ERR, -1, "RxCrcErr"),
+	MIB_DESC(MT7530_MIB_RX_CTRL_DROP, -1, "RxCtrlDrop"),
+	MIB_DESC(MT7530_MIB_RX_INGRESS_DROP, -1, "RxIngressDrop"),
+	MIB_DESC(MT7530_MIB_RX_ARL_DROP, -1, "RxArlDrop"),
 };
 
 static void
@@ -225,100 +374,6 @@ mt7530_clear(struct mt7530_priv *priv, u32 reg, u32 val)
 	mt7530_rmw(priv, reg, val, 0);
 }
 
-static int
-mt7530_fdb_cmd(struct mt7530_priv *priv, enum mt7530_fdb_cmd cmd, u32 *rsp)
-{
-	u32 val;
-	int ret;
-
-	/* Set the command operating upon the MAC address entries */
-	val = ATC_BUSY | ATC_MAT(0) | cmd;
-	ret = mt7530_write(priv, MT7530_ATC, val);
-	if (ret)
-		return ret;
-
-	mt7530_mutex_lock(priv);
-
-	ret = regmap_read_poll_timeout(priv->regmap, MT7530_ATC, val,
-				       !(val & ATC_BUSY), 20, 20000);
-	if (!ret)
-		ret = regmap_read(priv->regmap, MT7530_ATC, &val);
-
-	mt7530_mutex_unlock(priv);
-
-	if (ret < 0) {
-		dev_err(priv->dev, "reset timeout\n");
-		return ret;
-	}
-
-	/* Additional sanity for read command if the specified
-	 * entry is invalid
-	 */
-	if ((cmd == MT7530_FDB_READ) && (val & ATC_INVALID))
-		return -EINVAL;
-
-	if (rsp)
-		*rsp = val;
-
-	return 0;
-}
-
-static void
-mt7530_fdb_read(struct mt7530_priv *priv, struct mt7530_fdb *fdb)
-{
-	u32 reg[3];
-	int i;
-
-	/* Read from ARL table into an array */
-	for (i = 0; i < 3; i++) {
-		reg[i] = mt7530_read(priv, MT7530_TSRA1 + (i * 4));
-
-		dev_dbg(priv->dev, "%s(%d) reg[%d]=0x%x\n",
-			__func__, __LINE__, i, reg[i]);
-	}
-
-	fdb->vid = (reg[1] >> CVID) & CVID_MASK;
-	fdb->aging = (reg[2] >> AGE_TIMER) & AGE_TIMER_MASK;
-	fdb->port_mask = (reg[2] >> PORT_MAP) & PORT_MAP_MASK;
-	fdb->mac[0] = (reg[0] >> MAC_BYTE_0) & MAC_BYTE_MASK;
-	fdb->mac[1] = (reg[0] >> MAC_BYTE_1) & MAC_BYTE_MASK;
-	fdb->mac[2] = (reg[0] >> MAC_BYTE_2) & MAC_BYTE_MASK;
-	fdb->mac[3] = (reg[0] >> MAC_BYTE_3) & MAC_BYTE_MASK;
-	fdb->mac[4] = (reg[1] >> MAC_BYTE_4) & MAC_BYTE_MASK;
-	fdb->mac[5] = (reg[1] >> MAC_BYTE_5) & MAC_BYTE_MASK;
-	fdb->noarp = ((reg[2] >> ENT_STATUS) & ENT_STATUS_MASK) == STATIC_ENT;
-}
-
-static void
-mt7530_fdb_write(struct mt7530_priv *priv, u16 vid,
-		 u8 port_mask, const u8 *mac,
-		 u8 aging, u8 type)
-{
-	u32 reg[3] = { 0 };
-	int i;
-
-	reg[1] |= vid & CVID_MASK;
-	reg[1] |= ATA2_IVL;
-	reg[1] |= ATA2_FID(FID_BRIDGED);
-	reg[2] |= (aging & AGE_TIMER_MASK) << AGE_TIMER;
-	reg[2] |= (port_mask & PORT_MAP_MASK) << PORT_MAP;
-	/* STATIC_ENT indicate that entry is static wouldn't
-	 * be aged out and STATIC_EMP specified as erasing an
-	 * entry
-	 */
-	reg[2] |= (type & ENT_STATUS_MASK) << ENT_STATUS;
-	reg[1] |= mac[5] << MAC_BYTE_5;
-	reg[1] |= mac[4] << MAC_BYTE_4;
-	reg[0] |= mac[3] << MAC_BYTE_3;
-	reg[0] |= mac[2] << MAC_BYTE_2;
-	reg[0] |= mac[1] << MAC_BYTE_1;
-	reg[0] |= mac[0] << MAC_BYTE_0;
-
-	/* Write array into the ARL table */
-	for (i = 0; i < 3; i++)
-		mt7530_write(priv, MT7530_ATA1 + (i * 4), reg[i]);
-}
-
 /* Set up switch core clock for MT7530 */
 static void mt7530_pll_setup(struct mt7530_priv *priv)
 {
@@ -501,15 +556,6 @@ mt7531_pll_setup(struct mt7530_priv *priv)
 	usleep_range(25, 35);
 }
 
-static void
-mt7530_mib_reset(struct dsa_switch *ds)
-{
-	struct mt7530_priv *priv = ds->priv;
-
-	mt7530_write(priv, MT7530_MIB_CCR, CCR_MIB_FLUSH);
-	mt7530_write(priv, MT7530_MIB_CCR, CCR_MIB_ACTIVATE);
-}
-
 static int mt7530_phy_read_c22(struct mt7530_priv *priv, int port, int regnum)
 {
 	return mdiobus_read_nested(priv->bus, port, regnum);
@@ -748,34 +794,25 @@ mt7530_get_strings(struct dsa_switch *ds, int port, u32 stringset,
 		ethtool_puts(&data, mt7530_mib[i].name);
 }
 
-static void
-mt7530_read_port_stats(struct mt7530_priv *priv, int port,
-		       u32 offset, u8 size, uint64_t *data)
-{
-	u32 val, reg = MT7530_PORT_MIB_COUNTER(port) + offset;
-
-	val = mt7530_read(priv, reg);
-	*data = val;
-
-	if (size == 2) {
-		val = mt7530_read(priv, reg + 4);
-		*data |= (u64)val << 32;
-	}
-}
-
 static void
 mt7530_get_ethtool_stats(struct dsa_switch *ds, int port,
 			 uint64_t *data)
 {
 	struct mt7530_priv *priv = ds->priv;
 	const struct mt7530_mib_desc *mib;
+	struct mt7530_lib_priv *lib_priv;
 	int i;
 
+	lib_priv = &priv->lib_priv;
 	for (i = 0; i < ARRAY_SIZE(mt7530_mib); i++) {
+		struct regmap_field *high = NULL;
 		mib = &mt7530_mib[i];
 
-		mt7530_read_port_stats(priv, port, mib->offset, mib->size,
-				       data + i);
+		if (mib->field_high != -1)
+			high = lib_priv->fields[mib->field_high];
+
+		mt7530_lib_read_port_stats(lib_priv->fields[mib->field_low],
+					   high, port, data + i);
 	}
 }
 
@@ -793,54 +830,7 @@ static void mt7530_get_eth_mac_stats(struct dsa_switch *ds, int port,
 {
 	struct mt7530_priv *priv = ds->priv;
 
-	/* MIB counter doesn't provide a FramesTransmittedOK but instead
-	 * provide stats for Unicast, Broadcast and Multicast frames separately.
-	 * To simulate a global frame counter, read Unicast and addition Multicast
-	 * and Broadcast later
-	 */
-	mt7530_read_port_stats(priv, port, MT7530_PORT_MIB_TX_UNICAST, 1,
-			       &mac_stats->FramesTransmittedOK);
-
-	mt7530_read_port_stats(priv, port, MT7530_PORT_MIB_TX_SINGLE_COLLISION, 1,
-			       &mac_stats->SingleCollisionFrames);
-
-	mt7530_read_port_stats(priv, port, MT7530_PORT_MIB_TX_MULTIPLE_COLLISION, 1,
-			       &mac_stats->MultipleCollisionFrames);
-
-	mt7530_read_port_stats(priv, port, MT7530_PORT_MIB_RX_UNICAST, 1,
-			       &mac_stats->FramesReceivedOK);
-
-	mt7530_read_port_stats(priv, port, MT7530_PORT_MIB_TX_BYTES, 2,
-			       &mac_stats->OctetsTransmittedOK);
-
-	mt7530_read_port_stats(priv, port, MT7530_PORT_MIB_RX_ALIGN_ERR, 1,
-			       &mac_stats->AlignmentErrors);
-
-	mt7530_read_port_stats(priv, port, MT7530_PORT_MIB_TX_DEFERRED, 1,
-			       &mac_stats->FramesWithDeferredXmissions);
-
-	mt7530_read_port_stats(priv, port, MT7530_PORT_MIB_TX_LATE_COLLISION, 1,
-			       &mac_stats->LateCollisions);
-
-	mt7530_read_port_stats(priv, port, MT7530_PORT_MIB_TX_EXCESSIVE_COLLISION, 1,
-			       &mac_stats->FramesAbortedDueToXSColls);
-
-	mt7530_read_port_stats(priv, port, MT7530_PORT_MIB_RX_BYTES, 2,
-			       &mac_stats->OctetsReceivedOK);
-
-	mt7530_read_port_stats(priv, port, MT7530_PORT_MIB_TX_MULTICAST, 1,
-			       &mac_stats->MulticastFramesXmittedOK);
-	mac_stats->FramesTransmittedOK += mac_stats->MulticastFramesXmittedOK;
-	mt7530_read_port_stats(priv, port, MT7530_PORT_MIB_TX_BROADCAST, 1,
-			       &mac_stats->BroadcastFramesXmittedOK);
-	mac_stats->FramesTransmittedOK += mac_stats->BroadcastFramesXmittedOK;
-
-	mt7530_read_port_stats(priv, port, MT7530_PORT_MIB_RX_MULTICAST, 1,
-			       &mac_stats->MulticastFramesReceivedOK);
-	mac_stats->FramesReceivedOK += mac_stats->MulticastFramesReceivedOK;
-	mt7530_read_port_stats(priv, port, MT7530_PORT_MIB_RX_BROADCAST, 1,
-			       &mac_stats->BroadcastFramesReceivedOK);
-	mac_stats->FramesReceivedOK += mac_stats->BroadcastFramesReceivedOK;
+	return mt7530_lib_get_eth_mac_stats(&priv->lib_priv, port, mac_stats);
 }
 
 static const struct ethtool_rmon_hist_range mt7530_rmon_ranges[] = {
@@ -853,53 +843,41 @@ static const struct ethtool_rmon_hist_range mt7530_rmon_ranges[] = {
 	{}
 };
 
+static const struct mt7530_rmon_hist mt7530_rmon_hist_info = {
+	.ranges_fields = (unsigned int []){
+		MT7530_MIB_RX_PKT_SZ_64,
+		MT7530_MIB_RX_PKT_SZ_65_TO_127,
+		MT7530_MIB_RX_PKT_SZ_128_TO_255,
+		MT7530_MIB_RX_PKT_SZ_256_TO_511,
+		MT7530_MIB_RX_PKT_SZ_512_TO_1023,
+		MT7530_MIB_RX_PKT_SZ_1024_TO_MAX,
+	},
+	.ranges_tx_fields = (unsigned int []){
+		MT7530_MIB_TX_PKT_SZ_64,
+		MT7530_MIB_TX_PKT_SZ_65_TO_127,
+		MT7530_MIB_TX_PKT_SZ_128_TO_255,
+		MT7530_MIB_TX_PKT_SZ_256_TO_511,
+		MT7530_MIB_TX_PKT_SZ_512_TO_1023,
+		MT7530_MIB_TX_PKT_SZ_1024_TO_MAX,
+	},
+	.ranges = mt7530_rmon_ranges,
+	.num_ranges = ARRAY_SIZE(mt7530_rmon_ranges) - 1,
+};
+
 static void mt7530_get_rmon_stats(struct dsa_switch *ds, int port,
 				  struct ethtool_rmon_stats *rmon_stats,
 				  const struct ethtool_rmon_hist_range **ranges)
 {
 	struct mt7530_priv *priv = ds->priv;
 
-	mt7530_read_port_stats(priv, port, MT7530_PORT_MIB_RX_UNDER_SIZE_ERR, 1,
-			       &rmon_stats->undersize_pkts);
-	mt7530_read_port_stats(priv, port, MT7530_PORT_MIB_RX_OVER_SZ_ERR, 1,
-			       &rmon_stats->oversize_pkts);
-	mt7530_read_port_stats(priv, port, MT7530_PORT_MIB_RX_FRAG_ERR, 1,
-			       &rmon_stats->fragments);
-	mt7530_read_port_stats(priv, port, MT7530_PORT_MIB_RX_JABBER_ERR, 1,
-			       &rmon_stats->jabbers);
-
-	mt7530_read_port_stats(priv, port, MT7530_PORT_MIB_RX_PKT_SZ_64, 1,
-			       &rmon_stats->hist[0]);
-	mt7530_read_port_stats(priv, port, MT7530_PORT_MIB_RX_PKT_SZ_65_TO_127, 1,
-			       &rmon_stats->hist[1]);
-	mt7530_read_port_stats(priv, port, MT7530_PORT_MIB_RX_PKT_SZ_128_TO_255, 1,
-			       &rmon_stats->hist[2]);
-	mt7530_read_port_stats(priv, port, MT7530_PORT_MIB_RX_PKT_SZ_256_TO_511, 1,
-			       &rmon_stats->hist[3]);
-	mt7530_read_port_stats(priv, port, MT7530_PORT_MIB_RX_PKT_SZ_512_TO_1023, 1,
-			       &rmon_stats->hist[4]);
-	mt7530_read_port_stats(priv, port, MT7530_PORT_MIB_RX_PKT_SZ_1024_TO_MAX, 1,
-			       &rmon_stats->hist[5]);
-
-	mt7530_read_port_stats(priv, port, MT7530_PORT_MIB_TX_PKT_SZ_64, 1,
-			       &rmon_stats->hist_tx[0]);
-	mt7530_read_port_stats(priv, port, MT7530_PORT_MIB_TX_PKT_SZ_65_TO_127, 1,
-			       &rmon_stats->hist_tx[1]);
-	mt7530_read_port_stats(priv, port, MT7530_PORT_MIB_TX_PKT_SZ_128_TO_255, 1,
-			       &rmon_stats->hist_tx[2]);
-	mt7530_read_port_stats(priv, port, MT7530_PORT_MIB_TX_PKT_SZ_256_TO_511, 1,
-			       &rmon_stats->hist_tx[3]);
-	mt7530_read_port_stats(priv, port, MT7530_PORT_MIB_TX_PKT_SZ_512_TO_1023, 1,
-			       &rmon_stats->hist_tx[4]);
-	mt7530_read_port_stats(priv, port, MT7530_PORT_MIB_TX_PKT_SZ_1024_TO_MAX, 1,
-			       &rmon_stats->hist_tx[5]);
-
-	*ranges = mt7530_rmon_ranges;
+	return mt7530_lib_get_rmon_stats(&priv->lib_priv, port, rmon_stats, ranges,
+					 &mt7530_rmon_hist_info);
 }
 
 static void mt7530_read_port_stats64(struct mt7530_priv *priv, int port,
 				     struct rtnl_link_stats64 *storage)
 {
+	struct mt7530_lib_priv *lib_priv = &priv->lib_priv;
 	uint64_t data;
 
 	/* MIB counter doesn't provide a FramesTransmittedOK but instead
@@ -907,38 +885,40 @@ static void mt7530_read_port_stats64(struct mt7530_priv *priv, int port,
 	 * To simulate a global frame counter, read Unicast and addition Multicast
 	 * and Broadcast later
 	 */
-	mt7530_read_port_stats(priv, port, MT7530_PORT_MIB_RX_UNICAST, 1,
-			       &storage->rx_packets);
-	mt7530_read_port_stats(priv, port, MT7530_PORT_MIB_RX_MULTICAST, 1,
-			       &storage->multicast);
-	storage->rx_packets += storage->multicast;
-	mt7530_read_port_stats(priv, port, MT7530_PORT_MIB_RX_BROADCAST, 1,
-			       &data);
+	mt7530_lib_read_port_stats(lib_priv->fields[MT7530_MIB_RX_UNICAST],
+				   NULL, port, &storage->rx_packets);
+	mt7530_lib_read_port_stats(lib_priv->fields[MT7530_MIB_RX_MULTICAST],
+				   NULL, port, &data);
+	storage->rx_packets += data;
+	mt7530_lib_read_port_stats(lib_priv->fields[MT7530_MIB_RX_BROADCAST],
+				   NULL, port, &data);
 	storage->rx_packets += data;
 
-	mt7530_read_port_stats(priv, port, MT7530_PORT_MIB_TX_UNICAST, 1,
-			       &storage->tx_packets);
-	mt7530_read_port_stats(priv, port, MT7530_PORT_MIB_TX_MULTICAST, 1,
-			       &data);
+	mt7530_lib_read_port_stats(lib_priv->fields[MT7530_MIB_TX_UNICAST],
+				   NULL, port, &storage->tx_packets);
+	mt7530_lib_read_port_stats(lib_priv->fields[MT7530_MIB_TX_MULTICAST],
+				   NULL, port, &data);
 	storage->tx_packets += data;
-	mt7530_read_port_stats(priv, port, MT7530_PORT_MIB_TX_BROADCAST, 1,
-			       &data);
+	mt7530_lib_read_port_stats(lib_priv->fields[MT7530_MIB_TX_BROADCAST],
+				   NULL, port, &data);
 	storage->tx_packets += data;
 
-	mt7530_read_port_stats(priv, port, MT7530_PORT_MIB_RX_BYTES, 2,
-			       &storage->rx_bytes);
+	mt7530_lib_read_port_stats(lib_priv->fields[MT7530_MIB_RX_BYTES_LOW],
+				   lib_priv->fields[MT7530_MIB_RX_BYTES_HIGH], port,
+				   &storage->rx_bytes);
 
-	mt7530_read_port_stats(priv, port, MT7530_PORT_MIB_TX_BYTES, 2,
-			       &storage->tx_bytes);
+	mt7530_lib_read_port_stats(lib_priv->fields[MT7530_MIB_TX_BYTES_LOW],
+				   lib_priv->fields[MT7530_MIB_TX_BYTES_HIGH], port,
+				   &storage->tx_bytes);
 
-	mt7530_read_port_stats(priv, port, MT7530_PORT_MIB_RX_DROP, 1,
-			       &storage->rx_dropped);
+	mt7530_lib_read_port_stats(lib_priv->fields[MT7530_MIB_RX_DROP],
+				   NULL, port, &storage->rx_dropped);
 
-	mt7530_read_port_stats(priv, port, MT7530_PORT_MIB_TX_DROP, 1,
-			       &storage->tx_dropped);
+	mt7530_lib_read_port_stats(lib_priv->fields[MT7530_MIB_TX_DROP],
+				   NULL, port, &storage->tx_dropped);
 
-	mt7530_read_port_stats(priv, port, MT7530_PORT_MIB_RX_CRC_ERR, 1,
-			       &storage->rx_crc_errors);
+	mt7530_lib_read_port_stats(lib_priv->fields[MT7530_MIB_RX_CRC_ERR],
+				   NULL, port, &storage->rx_crc_errors);
 }
 
 static void mt7530_stats_refresh(struct mt7530_priv *priv)
@@ -994,11 +974,7 @@ static void mt7530_get_eth_ctrl_stats(struct dsa_switch *ds, int port,
 {
 	struct mt7530_priv *priv = ds->priv;
 
-	mt7530_read_port_stats(priv, port, MT7530_PORT_MIB_TX_PAUSE, 1,
-			       &ctrl_stats->MACControlFramesTransmitted);
-
-	mt7530_read_port_stats(priv, port, MT7530_PORT_MIB_RX_PAUSE, 1,
-			       &ctrl_stats->MACControlFramesReceived);
+	mt7530_lib_get_eth_ctrl_stats(&priv->lib_priv, port, ctrl_stats);
 }
 
 static int
@@ -1117,214 +1093,6 @@ static void mt7530_setup_port5(struct dsa_switch *ds, phy_interface_t interface)
 	mutex_unlock(&priv->reg_mutex);
 }
 
-/* In Clause 5 of IEEE Std 802-2014, two sublayers of the data link layer (DLL)
- * of the Open Systems Interconnection basic reference model (OSI/RM) are
- * described; the medium access control (MAC) and logical link control (LLC)
- * sublayers. The MAC sublayer is the one facing the physical layer.
- *
- * In 8.2 of IEEE Std 802.1Q-2022, the Bridge architecture is described. A
- * Bridge component comprises a MAC Relay Entity for interconnecting the Ports
- * of the Bridge, at least two Ports, and higher layer entities with at least a
- * Spanning Tree Protocol Entity included.
- *
- * Each Bridge Port also functions as an end station and shall provide the MAC
- * Service to an LLC Entity. Each instance of the MAC Service is provided to a
- * distinct LLC Entity that supports protocol identification, multiplexing, and
- * demultiplexing, for protocol data unit (PDU) transmission and reception by
- * one or more higher layer entities.
- *
- * It is described in 8.13.9 of IEEE Std 802.1Q-2022 that in a Bridge, the LLC
- * Entity associated with each Bridge Port is modeled as being directly
- * connected to the attached Local Area Network (LAN).
- *
- * On the switch with CPU port architecture, CPU port functions as Management
- * Port, and the Management Port functionality is provided by software which
- * functions as an end station. Software is connected to an IEEE 802 LAN that is
- * wholly contained within the system that incorporates the Bridge. Software
- * provides access to the LLC Entity associated with each Bridge Port by the
- * value of the source port field on the special tag on the frame received by
- * software.
- *
- * We call frames that carry control information to determine the active
- * topology and current extent of each Virtual Local Area Network (VLAN), i.e.,
- * spanning tree or Shortest Path Bridging (SPB) and Multiple VLAN Registration
- * Protocol Data Units (MVRPDUs), and frames from other link constrained
- * protocols, such as Extensible Authentication Protocol over LAN (EAPOL) and
- * Link Layer Discovery Protocol (LLDP), link-local frames. They are not
- * forwarded by a Bridge. Permanently configured entries in the filtering
- * database (FDB) ensure that such frames are discarded by the Forwarding
- * Process. In 8.6.3 of IEEE Std 802.1Q-2022, this is described in detail:
- *
- * Each of the reserved MAC addresses specified in Table 8-1
- * (01-80-C2-00-00-[00,01,02,03,04,05,06,07,08,09,0A,0B,0C,0D,0E,0F]) shall be
- * permanently configured in the FDB in C-VLAN components and ERs.
- *
- * Each of the reserved MAC addresses specified in Table 8-2
- * (01-80-C2-00-00-[01,02,03,04,05,06,07,08,09,0A,0E]) shall be permanently
- * configured in the FDB in S-VLAN components.
- *
- * Each of the reserved MAC addresses specified in Table 8-3
- * (01-80-C2-00-00-[01,02,04,0E]) shall be permanently configured in the FDB in
- * TPMR components.
- *
- * The FDB entries for reserved MAC addresses shall specify filtering for all
- * Bridge Ports and all VIDs. Management shall not provide the capability to
- * modify or remove entries for reserved MAC addresses.
- *
- * The addresses in Table 8-1, Table 8-2, and Table 8-3 determine the scope of
- * propagation of PDUs within a Bridged Network, as follows:
- *
- *   The Nearest Bridge group address (01-80-C2-00-00-0E) is an address that no
- *   conformant Two-Port MAC Relay (TPMR) component, Service VLAN (S-VLAN)
- *   component, Customer VLAN (C-VLAN) component, or MAC Bridge can forward.
- *   PDUs transmitted using this destination address, or any other addresses
- *   that appear in Table 8-1, Table 8-2, and Table 8-3
- *   (01-80-C2-00-00-[00,01,02,03,04,05,06,07,08,09,0A,0B,0C,0D,0E,0F]), can
- *   therefore travel no further than those stations that can be reached via a
- *   single individual LAN from the originating station.
- *
- *   The Nearest non-TPMR Bridge group address (01-80-C2-00-00-03), is an
- *   address that no conformant S-VLAN component, C-VLAN component, or MAC
- *   Bridge can forward; however, this address is relayed by a TPMR component.
- *   PDUs using this destination address, or any of the other addresses that
- *   appear in both Table 8-1 and Table 8-2 but not in Table 8-3
- *   (01-80-C2-00-00-[00,03,05,06,07,08,09,0A,0B,0C,0D,0F]), will be relayed by
- *   any TPMRs but will propagate no further than the nearest S-VLAN component,
- *   C-VLAN component, or MAC Bridge.
- *
- *   The Nearest Customer Bridge group address (01-80-C2-00-00-00) is an address
- *   that no conformant C-VLAN component, MAC Bridge can forward; however, it is
- *   relayed by TPMR components and S-VLAN components. PDUs using this
- *   destination address, or any of the other addresses that appear in Table 8-1
- *   but not in either Table 8-2 or Table 8-3 (01-80-C2-00-00-[00,0B,0C,0D,0F]),
- *   will be relayed by TPMR components and S-VLAN components but will propagate
- *   no further than the nearest C-VLAN component or MAC Bridge.
- *
- * Because the LLC Entity associated with each Bridge Port is provided via CPU
- * port, we must not filter these frames but forward them to CPU port.
- *
- * In a Bridge, the transmission Port is majorly decided by ingress and egress
- * rules, FDB, and spanning tree Port State functions of the Forwarding Process.
- * For link-local frames, only CPU port should be designated as destination port
- * in the FDB, and the other functions of the Forwarding Process must not
- * interfere with the decision of the transmission Port. We call this process
- * trapping frames to CPU port.
- *
- * Therefore, on the switch with CPU port architecture, link-local frames must
- * be trapped to CPU port, and certain link-local frames received by a Port of a
- * Bridge comprising a TPMR component or an S-VLAN component must be excluded
- * from it.
- *
- * A Bridge of the switch with CPU port architecture cannot comprise a Two-Port
- * MAC Relay (TPMR) component as a TPMR component supports only a subset of the
- * functionality of a MAC Bridge. A Bridge comprising two Ports (Management Port
- * doesn't count) of this architecture will either function as a standard MAC
- * Bridge or a standard VLAN Bridge.
- *
- * Therefore, a Bridge of this architecture can only comprise S-VLAN components,
- * C-VLAN components, or MAC Bridge components. Since there's no TPMR component,
- * we don't need to relay PDUs using the destination addresses specified on the
- * Nearest non-TPMR section, and the proportion of the Nearest Customer Bridge
- * section where they must be relayed by TPMR components.
- *
- * One option to trap link-local frames to CPU port is to add static FDB entries
- * with CPU port designated as destination port. However, because that
- * Independent VLAN Learning (IVL) is being used on every VID, each entry only
- * applies to a single VLAN Identifier (VID). For a Bridge comprising a MAC
- * Bridge component or a C-VLAN component, there would have to be 16 times 4096
- * entries. This switch intellectual property can only hold a maximum of 2048
- * entries. Using this option, there also isn't a mechanism to prevent
- * link-local frames from being discarded when the spanning tree Port State of
- * the reception Port is discarding.
- *
- * The remaining option is to utilise the BPC, RGAC1, RGAC2, RGAC3, and RGAC4
- * registers. Whilst this applies to every VID, it doesn't contain all of the
- * reserved MAC addresses without affecting the remaining Standard Group MAC
- * Addresses. The REV_UN frame tag utilised using the RGAC4 register covers the
- * remaining 01-80-C2-00-00-[04,05,06,07,08,09,0A,0B,0C,0D,0F] destination
- * addresses. It also includes the 01-80-C2-00-00-22 to 01-80-C2-00-00-FF
- * destination addresses which may be relayed by MAC Bridges or VLAN Bridges.
- * The latter option provides better but not complete conformance.
- *
- * This switch intellectual property also does not provide a mechanism to trap
- * link-local frames with specific destination addresses to CPU port by Bridge,
- * to conform to the filtering rules for the distinct Bridge components.
- *
- * Therefore, regardless of the type of the Bridge component, link-local frames
- * with these destination addresses will be trapped to CPU port:
- *
- * 01-80-C2-00-00-[00,01,02,03,0E]
- *
- * In a Bridge comprising a MAC Bridge component or a C-VLAN component:
- *
- *   Link-local frames with these destination addresses won't be trapped to CPU
- *   port which won't conform to IEEE Std 802.1Q-2022:
- *
- *   01-80-C2-00-00-[04,05,06,07,08,09,0A,0B,0C,0D,0F]
- *
- * In a Bridge comprising an S-VLAN component:
- *
- *   Link-local frames with these destination addresses will be trapped to CPU
- *   port which won't conform to IEEE Std 802.1Q-2022:
- *
- *   01-80-C2-00-00-00
- *
- *   Link-local frames with these destination addresses won't be trapped to CPU
- *   port which won't conform to IEEE Std 802.1Q-2022:
- *
- *   01-80-C2-00-00-[04,05,06,07,08,09,0A]
- *
- * To trap link-local frames to CPU port as conformant as this switch
- * intellectual property can allow, link-local frames are made to be regarded as
- * Bridge Protocol Data Units (BPDUs). This is because this switch intellectual
- * property only lets the frames regarded as BPDUs bypass the spanning tree Port
- * State function of the Forwarding Process.
- *
- * The only remaining interference is the ingress rules. When the reception Port
- * has no PVID assigned on software, VLAN-untagged frames won't be allowed in.
- * There doesn't seem to be a mechanism on the switch intellectual property to
- * have link-local frames bypass this function of the Forwarding Process.
- */
-static void
-mt753x_trap_frames(struct mt7530_priv *priv)
-{
-	/* Trap 802.1X PAE frames and BPDUs to the CPU port(s) and egress
-	 * them with the EG_TAG attribute set to disabled (system default)
-	 * so that any VLAN tags in the frame are not modified by the
-	 * switch egress VLAN tag processing. This preserves VLAN tags
-	 * for reception on VLAN sub-interfaces.
-	 */
-	mt7530_rmw(priv, MT753X_BPC,
-		   PAE_BPDU_FR | PAE_EG_TAG_MASK | PAE_PORT_FW_MASK |
-			   BPDU_EG_TAG_MASK | BPDU_PORT_FW_MASK,
-		   PAE_BPDU_FR | PAE_EG_TAG(MT7530_VLAN_EG_DISABLED) |
-			   PAE_PORT_FW(TO_CPU_FW_CPU_ONLY) |
-			   BPDU_EG_TAG(MT7530_VLAN_EG_DISABLED) |
-			   TO_CPU_FW_CPU_ONLY);
-
-	/* Trap frames with :01 and :02 MAC DAs to the CPU port(s) and
-	 * egress them with EG_TAG disabled.
-	 */
-	mt7530_rmw(priv, MT753X_RGAC1,
-		   R02_BPDU_FR | R02_EG_TAG_MASK | R02_PORT_FW_MASK |
-			   R01_BPDU_FR | R01_EG_TAG_MASK | R01_PORT_FW_MASK,
-		   R02_BPDU_FR | R02_EG_TAG(MT7530_VLAN_EG_DISABLED) |
-			   R02_PORT_FW(TO_CPU_FW_CPU_ONLY) | R01_BPDU_FR |
-			   R01_EG_TAG(MT7530_VLAN_EG_DISABLED) |
-			   TO_CPU_FW_CPU_ONLY);
-
-	/* Trap frames with :03 and :0E MAC DAs to the CPU port(s) and
-	 * egress them with EG_TAG disabled.
-	 */
-	mt7530_rmw(priv, MT753X_RGAC2,
-		   R0E_BPDU_FR | R0E_EG_TAG_MASK | R0E_PORT_FW_MASK |
-			   R03_BPDU_FR | R03_EG_TAG_MASK | R03_PORT_FW_MASK,
-		   R0E_BPDU_FR | R0E_EG_TAG(MT7530_VLAN_EG_DISABLED) |
-			   R0E_PORT_FW(TO_CPU_FW_CPU_ONLY) | R03_BPDU_FR |
-			   R03_EG_TAG(MT7530_VLAN_EG_DISABLED) |
-			   TO_CPU_FW_CPU_ONLY);
-}
-
 static void
 mt753x_cpu_port_enable(struct dsa_switch *ds, int port)
 {
@@ -1373,7 +1141,7 @@ mt7530_port_enable(struct dsa_switch *ds, int port,
 	if (dsa_port_is_user(dp)) {
 		struct dsa_port *cpu_dp = dp->cpu_dp;
 
-		priv->ports[port].pm |= PCR_MATRIX(BIT(cpu_dp->index));
+		priv->ports[port].pm |= BIT(cpu_dp->index);
 	}
 	priv->ports[port].enable = true;
 	mt7530_rmw(priv, MT7530_PCR_P(port), PCR_MATRIX_MASK,
@@ -1422,36 +1190,8 @@ static int
 mt7530_port_change_mtu(struct dsa_switch *ds, int port, int new_mtu)
 {
 	struct mt7530_priv *priv = ds->priv;
-	int length;
-	u32 val;
 
-	/* When a new MTU is set, DSA always set the CPU port's MTU to the
-	 * largest MTU of the user ports. Because the switch only has a global
-	 * RX length register, only allowing CPU port here is enough.
-	 */
-	if (!dsa_is_cpu_port(ds, port))
-		return 0;
-
-	val = mt7530_mii_read(priv, MT7530_GMACCR);
-	val &= ~MAX_RX_PKT_LEN_MASK;
-
-	/* RX length also includes Ethernet header, MTK tag, and FCS length */
-	length = new_mtu + ETH_HLEN + MTK_HDR_LEN + ETH_FCS_LEN;
-	if (length <= 1522) {
-		val |= MAX_RX_PKT_LEN_1522;
-	} else if (length <= 1536) {
-		val |= MAX_RX_PKT_LEN_1536;
-	} else if (length <= 1552) {
-		val |= MAX_RX_PKT_LEN_1552;
-	} else {
-		val &= ~MAX_RX_JUMBO_MASK;
-		val |= MAX_RX_JUMBO(DIV_ROUND_UP(length, 1024));
-		val |= MAX_RX_PKT_LEN_JUMBO;
-	}
-
-	mt7530_mii_write(priv, MT7530_GMACCR, val);
-
-	return 0;
+	return mt7530_lib_port_change_mtu(&priv->lib_priv, port, new_mtu);
 }
 
 static int
@@ -1464,78 +1204,8 @@ static void
 mt7530_stp_state_set(struct dsa_switch *ds, int port, u8 state)
 {
 	struct mt7530_priv *priv = ds->priv;
-	u32 stp_state;
-
-	switch (state) {
-	case BR_STATE_DISABLED:
-		stp_state = MT7530_STP_DISABLED;
-		break;
-	case BR_STATE_BLOCKING:
-		stp_state = MT7530_STP_BLOCKING;
-		break;
-	case BR_STATE_LISTENING:
-		stp_state = MT7530_STP_LISTENING;
-		break;
-	case BR_STATE_LEARNING:
-		stp_state = MT7530_STP_LEARNING;
-		break;
-	case BR_STATE_FORWARDING:
-	default:
-		stp_state = MT7530_STP_FORWARDING;
-		break;
-	}
 
-	mt7530_rmw(priv, MT7530_SSP_P(port), FID_PST_MASK(FID_BRIDGED),
-		   FID_PST(FID_BRIDGED, stp_state));
-}
-
-static void mt7530_update_port_member(struct mt7530_priv *priv, int port,
-				      const struct net_device *bridge_dev,
-				      bool join) __must_hold(&priv->reg_mutex)
-{
-	struct dsa_port *dp = dsa_to_port(priv->ds, port), *other_dp;
-	struct mt7530_port *p = &priv->ports[port], *other_p;
-	struct dsa_port *cpu_dp = dp->cpu_dp;
-	u32 port_bitmap = BIT(cpu_dp->index);
-	int other_port;
-	bool isolated;
-
-	dsa_switch_for_each_user_port(other_dp, priv->ds) {
-		other_port = other_dp->index;
-		other_p = &priv->ports[other_port];
-
-		if (dp == other_dp)
-			continue;
-
-		/* Add/remove this port to/from the port matrix of the other
-		 * ports in the same bridge. If the port is disabled, port
-		 * matrix is kept and not being setup until the port becomes
-		 * enabled.
-		 */
-		if (!dsa_port_offloads_bridge_dev(other_dp, bridge_dev))
-			continue;
-
-		isolated = p->isolated && other_p->isolated;
-
-		if (join && !isolated) {
-			other_p->pm |= PCR_MATRIX(BIT(port));
-			port_bitmap |= BIT(other_port);
-		} else {
-			other_p->pm &= ~PCR_MATRIX(BIT(port));
-		}
-
-		if (other_p->enable)
-			mt7530_rmw(priv, MT7530_PCR_P(other_port),
-				   PCR_MATRIX_MASK, other_p->pm);
-	}
-
-	/* Add/remove the all other ports to this port matrix. For !join
-	 * (leaving the bridge), only the CPU port will remain in the port matrix
-	 * of this port.
-	 */
-	p->pm = PCR_MATRIX(port_bitmap);
-	if (priv->ports[port].enable)
-		mt7530_rmw(priv, MT7530_PCR_P(port), PCR_MATRIX_MASK, p->pm);
+	mt7530_lib_stp_state_set(&priv->lib_priv, port, state);
 }
 
 static int
@@ -1557,34 +1227,8 @@ mt7530_port_bridge_flags(struct dsa_switch *ds, int port,
 {
 	struct mt7530_priv *priv = ds->priv;
 
-	if (flags.mask & BR_LEARNING)
-		mt7530_rmw(priv, MT7530_PSC_P(port), SA_DIS,
-			   flags.val & BR_LEARNING ? 0 : SA_DIS);
-
-	if (flags.mask & BR_FLOOD)
-		mt7530_rmw(priv, MT753X_MFC, UNU_FFP(BIT(port)),
-			   flags.val & BR_FLOOD ? UNU_FFP(BIT(port)) : 0);
-
-	if (flags.mask & BR_MCAST_FLOOD)
-		mt7530_rmw(priv, MT753X_MFC, UNM_FFP(BIT(port)),
-			   flags.val & BR_MCAST_FLOOD ? UNM_FFP(BIT(port)) : 0);
-
-	if (flags.mask & BR_BCAST_FLOOD)
-		mt7530_rmw(priv, MT753X_MFC, BC_FFP(BIT(port)),
-			   flags.val & BR_BCAST_FLOOD ? BC_FFP(BIT(port)) : 0);
-
-	if (flags.mask & BR_ISOLATED) {
-		struct dsa_port *dp = dsa_to_port(ds, port);
-		struct net_device *bridge_dev = dsa_port_bridge_dev_get(dp);
-
-		priv->ports[port].isolated = !!(flags.val & BR_ISOLATED);
-
-		mutex_lock(&priv->reg_mutex);
-		mt7530_update_port_member(priv, port, bridge_dev, true);
-		mutex_unlock(&priv->reg_mutex);
-	}
-
-	return 0;
+	return mt7530_lib_port_bridge_flags(&priv->lib_priv, port, flags,
+					    extack);
 }
 
 static int
@@ -1594,150 +1238,8 @@ mt7530_port_bridge_join(struct dsa_switch *ds, int port,
 {
 	struct mt7530_priv *priv = ds->priv;
 
-	mutex_lock(&priv->reg_mutex);
-
-	mt7530_update_port_member(priv, port, bridge.dev, true);
-
-	/* Set to fallback mode for independent VLAN learning */
-	mt7530_rmw(priv, MT7530_PCR_P(port), PCR_PORT_VLAN_MASK,
-		   MT7530_PORT_FALLBACK_MODE);
-
-	mutex_unlock(&priv->reg_mutex);
-
-	return 0;
-}
-
-static int
-mt7530_vlan_cmd(struct mt7530_priv *priv, enum mt7530_vlan_cmd cmd, u16 vid)
-{
-	u32 val;
-	int ret;
-
-	val = VTCR_BUSY | VTCR_FUNC(cmd) | vid;
-	ret = mt7530_write(priv, MT7530_VTCR, val);
-	if (ret)
-		return ret;
-
-	mt7530_mutex_lock(priv);
-
-	ret = regmap_read_poll_timeout(priv->regmap, MT7530_VTCR, val,
-				       !(val & VTCR_BUSY), 20, 20000);
-	if (!ret)
-		ret = regmap_read(priv->regmap, MT7530_VTCR, &val);
-
-	mt7530_mutex_unlock(priv);
-
-	if (ret < 0) {
-		dev_err(priv->dev, "poll timeout\n");
-		return ret;
-	}
-
-	if (val & VTCR_INVALID) {
-		dev_err(priv->dev, "read VTCR invalid\n");
-		return -EINVAL;
-	}
-
-	return 0;
-}
-
-static int
-mt7530_setup_vlan0(struct mt7530_priv *priv)
-{
-	u32 val;
-
-	/* Validate the entry with independent learning, keep the original
-	 * ingress tag attribute.
-	 */
-	val = IVL_MAC | EG_CON | PORT_MEM(MT7530_ALL_MEMBERS) | FID(FID_BRIDGED) |
-	      VLAN_VALID;
-	mt7530_write(priv, MT7530_VAWD1, val);
-	mt7530_write(priv, MT7530_VAWD2, 0);
-
-	return mt7530_vlan_cmd(priv, MT7530_VTCR_WR_VID, 0);
-}
-
-static void
-mt7530_port_set_vlan_unaware(struct dsa_switch *ds, int port)
-{
-	struct mt7530_priv *priv = ds->priv;
-	bool all_user_ports_removed = true;
-	int i;
-
-	/* This is called after .port_bridge_leave when leaving a VLAN-aware
-	 * bridge. Don't set standalone ports to fallback mode.
-	 */
-	if (dsa_port_bridge_dev_get(dsa_to_port(ds, port)))
-		mt7530_rmw(priv, MT7530_PCR_P(port), PCR_PORT_VLAN_MASK,
-			   MT7530_PORT_FALLBACK_MODE);
-
-	mt7530_rmw(priv, MT7530_PVC_P(port),
-		   VLAN_ATTR_MASK | PVC_EG_TAG_MASK | ACC_FRM_MASK,
-		   VLAN_ATTR(MT7530_VLAN_TRANSPARENT) |
-		   PVC_EG_TAG(MT7530_VLAN_EG_CONSISTENT) |
-		   MT7530_VLAN_ACC_ALL);
-
-	/* Set PVID to 0 */
-	mt7530_rmw(priv, MT7530_PPBV1_P(port), G0_PORT_VID_MASK,
-		   G0_PORT_VID_DEF);
-
-	for (i = 0; i < priv->ds->num_ports; i++) {
-		if (i == port)
-			continue;
-		if (dsa_is_user_port(ds, i) &&
-		    dsa_port_is_vlan_filtering(dsa_to_port(ds, i))) {
-			all_user_ports_removed = false;
-			break;
-		}
-	}
-
-	/* CPU port also does the same thing until all user ports belonging to
-	 * the CPU port get out of VLAN filtering mode.
-	 */
-	if (all_user_ports_removed) {
-		mutex_lock(&priv->reg_mutex);
-		mt7530_setup_vlan0(priv);
-		mutex_unlock(&priv->reg_mutex);
-	}
-}
-
-static void
-mt7530_port_set_vlan_aware(struct dsa_switch *ds, int port)
-{
-	struct mt7530_priv *priv = ds->priv;
-
-	/* Trapped into security mode allows packet forwarding through VLAN
-	 * table lookup.
-	 */
-	if (dsa_is_user_port(ds, port)) {
-		mt7530_rmw(priv, MT7530_PCR_P(port), PCR_PORT_VLAN_MASK,
-			   MT7530_PORT_SECURITY_MODE);
-		mt7530_rmw(priv, MT7530_PPBV1_P(port), G0_PORT_VID_MASK,
-			   G0_PORT_VID(priv->ports[port].pvid));
-
-		/* Only accept tagged frames if PVID is not set */
-		if (!priv->ports[port].pvid)
-			mt7530_rmw(priv, MT7530_PVC_P(port), ACC_FRM_MASK,
-				   MT7530_VLAN_ACC_TAGGED);
-
-		/* Set the port as a user port which is to be able to recognize
-		 * VID from incoming packets before fetching entry within the
-		 * VLAN table.
-		 */
-		mt7530_rmw(priv, MT7530_PVC_P(port),
-			   VLAN_ATTR_MASK | PVC_EG_TAG_MASK,
-			   VLAN_ATTR(MT7530_VLAN_USER) |
-			   PVC_EG_TAG(MT7530_VLAN_EG_DISABLED));
-	} else {
-		/* Also set CPU ports to the "user" VLAN port attribute, to
-		 * allow VLAN classification, but keep the EG_TAG attribute as
-		 * "consistent" (i.o.w. don't change its value) for packets
-		 * received by the switch from the CPU, so that tagged packets
-		 * are forwarded to user ports as tagged, and untagged as
-		 * untagged.
-		 */
-		mt7530_rmw(priv, MT7530_PVC_P(port), VLAN_ATTR_MASK,
-			   VLAN_ATTR(MT7530_VLAN_USER));
-	}
+	return mt7530_lib_port_bridge_join(&priv->lib_priv, port, bridge,
+					   tx_fwd_offload, extack);
 }
 
 static void
@@ -1746,18 +1248,7 @@ mt7530_port_bridge_leave(struct dsa_switch *ds, int port,
 {
 	struct mt7530_priv *priv = ds->priv;
 
-	mutex_lock(&priv->reg_mutex);
-
-	mt7530_update_port_member(priv, port, bridge.dev, false);
-
-	/* When a port is removed from the bridge, the port would be set up
-	 * back to the default as is at initial boot which is a VLAN-unaware
-	 * port.
-	 */
-	mt7530_rmw(priv, MT7530_PCR_P(port), PCR_PORT_VLAN_MASK,
-		   MT7530_PORT_MATRIX_MODE);
-
-	mutex_unlock(&priv->reg_mutex);
+	return mt7530_lib_port_bridge_leave(&priv->lib_priv, port, bridge);
 }
 
 static int
@@ -1766,15 +1257,8 @@ mt7530_port_fdb_add(struct dsa_switch *ds, int port,
 		    struct dsa_db db)
 {
 	struct mt7530_priv *priv = ds->priv;
-	int ret;
-	u8 port_mask = BIT(port);
-
-	mutex_lock(&priv->reg_mutex);
-	mt7530_fdb_write(priv, vid, port_mask, addr, -1, STATIC_ENT);
-	ret = mt7530_fdb_cmd(priv, MT7530_FDB_WRITE, NULL);
-	mutex_unlock(&priv->reg_mutex);
 
-	return ret;
+	return mt7530_lib_port_fdb_add(&priv->lib_priv, port, addr, vid, db);
 }
 
 static int
@@ -1783,15 +1267,8 @@ mt7530_port_fdb_del(struct dsa_switch *ds, int port,
 		    struct dsa_db db)
 {
 	struct mt7530_priv *priv = ds->priv;
-	int ret;
-	u8 port_mask = BIT(port);
-
-	mutex_lock(&priv->reg_mutex);
-	mt7530_fdb_write(priv, vid, port_mask, addr, -1, STATIC_EMP);
-	ret = mt7530_fdb_cmd(priv, MT7530_FDB_WRITE, NULL);
-	mutex_unlock(&priv->reg_mutex);
 
-	return ret;
+	return mt7530_lib_port_fdb_del(&priv->lib_priv, port, addr, vid, db);
 }
 
 static int
@@ -1806,13 +1283,14 @@ mt7530_port_fdb_dump(struct dsa_switch *ds, int port,
 
 	mutex_lock(&priv->reg_mutex);
 
-	ret = mt7530_fdb_cmd(priv, MT7530_FDB_START, &rsp);
+	ret = mt7530_lib_fdb_cmd(&priv->lib_priv, MT7530_FDB_START,
+				 ATC_MAT_MACTAB, &rsp);
 	if (ret < 0)
 		goto err;
 
 	do {
 		if (rsp & ATC_SRCH_HIT) {
-			mt7530_fdb_read(priv, &_fdb);
+			mt7530_lib_fdb_read(&priv->lib_priv, &_fdb);
 			if (_fdb.port_mask & BIT(port)) {
 				ret = cb(_fdb.mac, _fdb.vid, _fdb.noarp,
 					 data);
@@ -1822,7 +1300,8 @@ mt7530_port_fdb_dump(struct dsa_switch *ds, int port,
 		}
 	} while (--cnt &&
 		 !(rsp & ATC_SRCH_END) &&
-		 !mt7530_fdb_cmd(priv, MT7530_FDB_NEXT, &rsp));
+		 !mt7530_lib_fdb_cmd(&priv->lib_priv, MT7530_FDB_NEXT,
+				     ATC_MAT_MACTAB, &rsp));
 err:
 	mutex_unlock(&priv->reg_mutex);
 
@@ -1835,25 +1314,8 @@ mt7530_port_mdb_add(struct dsa_switch *ds, int port,
 		    struct dsa_db db)
 {
 	struct mt7530_priv *priv = ds->priv;
-	const u8 *addr = mdb->addr;
-	u16 vid = mdb->vid;
-	u8 port_mask = 0;
-	int ret;
-
-	mutex_lock(&priv->reg_mutex);
-
-	mt7530_fdb_write(priv, vid, 0, addr, 0, STATIC_EMP);
-	if (!mt7530_fdb_cmd(priv, MT7530_FDB_READ, NULL))
-		port_mask = (mt7530_read(priv, MT7530_ATRD) >> PORT_MAP)
-			    & PORT_MAP_MASK;
 
-	port_mask |= BIT(port);
-	mt7530_fdb_write(priv, vid, port_mask, addr, -1, STATIC_ENT);
-	ret = mt7530_fdb_cmd(priv, MT7530_FDB_WRITE, NULL);
-
-	mutex_unlock(&priv->reg_mutex);
-
-	return ret;
+	return mt7530_lib_port_mdb_add(&priv->lib_priv, port, mdb, db);
 }
 
 static int
@@ -1862,130 +1324,19 @@ mt7530_port_mdb_del(struct dsa_switch *ds, int port,
 		    struct dsa_db db)
 {
 	struct mt7530_priv *priv = ds->priv;
-	const u8 *addr = mdb->addr;
-	u16 vid = mdb->vid;
-	u8 port_mask = 0;
-	int ret;
 
-	mutex_lock(&priv->reg_mutex);
-
-	mt7530_fdb_write(priv, vid, 0, addr, 0, STATIC_EMP);
-	if (!mt7530_fdb_cmd(priv, MT7530_FDB_READ, NULL))
-		port_mask = (mt7530_read(priv, MT7530_ATRD) >> PORT_MAP)
-			    & PORT_MAP_MASK;
-
-	port_mask &= ~BIT(port);
-	mt7530_fdb_write(priv, vid, port_mask, addr, -1,
-			 port_mask ? STATIC_ENT : STATIC_EMP);
-	ret = mt7530_fdb_cmd(priv, MT7530_FDB_WRITE, NULL);
-
-	mutex_unlock(&priv->reg_mutex);
-
-	return ret;
+	return mt7530_lib_port_mdb_del(&priv->lib_priv, port, mdb, db);
 }
 
 static int
 mt7530_port_vlan_filtering(struct dsa_switch *ds, int port, bool vlan_filtering,
 			   struct netlink_ext_ack *extack)
 {
-	struct dsa_port *dp = dsa_to_port(ds, port);
-	struct dsa_port *cpu_dp = dp->cpu_dp;
-
-	if (vlan_filtering) {
-		/* The port is being kept as VLAN-unaware port when bridge is
-		 * set up with vlan_filtering not being set, Otherwise, the
-		 * port and the corresponding CPU port is required the setup
-		 * for becoming a VLAN-aware port.
-		 */
-		mt7530_port_set_vlan_aware(ds, port);
-		mt7530_port_set_vlan_aware(ds, cpu_dp->index);
-	} else {
-		mt7530_port_set_vlan_unaware(ds, port);
-	}
-
-	return 0;
-}
-
-static void
-mt7530_hw_vlan_add(struct mt7530_priv *priv,
-		   struct mt7530_hw_vlan_entry *entry)
-{
-	struct dsa_port *dp = dsa_to_port(priv->ds, entry->port);
-	u8 new_members;
-	u32 val;
-
-	new_members = entry->old_members | BIT(entry->port);
-
-	/* Validate the entry with independent learning, create egress tag per
-	 * VLAN and joining the port as one of the port members.
-	 */
-	val = IVL_MAC | VTAG_EN | PORT_MEM(new_members) | FID(FID_BRIDGED) |
-	      VLAN_VALID;
-	mt7530_write(priv, MT7530_VAWD1, val);
-
-	/* Decide whether adding tag or not for those outgoing packets from the
-	 * port inside the VLAN.
-	 * CPU port is always taken as a tagged port for serving more than one
-	 * VLANs across and also being applied with egress type stack mode for
-	 * that VLAN tags would be appended after hardware special tag used as
-	 * DSA tag.
-	 */
-	if (dsa_port_is_cpu(dp))
-		val = MT7530_VLAN_EGRESS_STACK;
-	else if (entry->untagged)
-		val = MT7530_VLAN_EGRESS_UNTAG;
-	else
-		val = MT7530_VLAN_EGRESS_TAG;
-	mt7530_rmw(priv, MT7530_VAWD2,
-		   ETAG_CTRL_P_MASK(entry->port),
-		   ETAG_CTRL_P(entry->port, val));
-}
-
-static void
-mt7530_hw_vlan_del(struct mt7530_priv *priv,
-		   struct mt7530_hw_vlan_entry *entry)
-{
-	u8 new_members;
-	u32 val;
-
-	new_members = entry->old_members & ~BIT(entry->port);
-
-	val = mt7530_read(priv, MT7530_VAWD1);
-	if (!(val & VLAN_VALID)) {
-		dev_err(priv->dev,
-			"Cannot be deleted due to invalid entry\n");
-		return;
-	}
-
-	if (new_members) {
-		val = IVL_MAC | VTAG_EN | PORT_MEM(new_members) |
-		      VLAN_VALID;
-		mt7530_write(priv, MT7530_VAWD1, val);
-	} else {
-		mt7530_write(priv, MT7530_VAWD1, 0);
-		mt7530_write(priv, MT7530_VAWD2, 0);
-	}
-}
-
-static void
-mt7530_hw_vlan_update(struct mt7530_priv *priv, u16 vid,
-		      struct mt7530_hw_vlan_entry *entry,
-		      mt7530_vlan_op vlan_op)
-{
-	u32 val;
-
-	/* Fetch entry */
-	mt7530_vlan_cmd(priv, MT7530_VTCR_RD_VID, vid);
-
-	val = mt7530_read(priv, MT7530_VAWD1);
-
-	entry->old_members = (val >> PORT_MEM_SHFT) & PORT_MEM_MASK;
-
-	/* Manipulate entry */
-	vlan_op(priv, entry);
+	struct mt7530_priv *priv = ds->priv;
 
-	/* Flush result to hardware */
-	mt7530_vlan_cmd(priv, MT7530_VTCR_WR_VID, vid);
+	return mt7530_lib_port_vlan_filtering(&priv->lib_priv, port,
+					      vlan_filtering,
+					      extack);
 }
 
 static int
@@ -1993,92 +1344,18 @@ mt7530_port_vlan_add(struct dsa_switch *ds, int port,
 		     const struct switchdev_obj_port_vlan *vlan,
 		     struct netlink_ext_ack *extack)
 {
-	bool untagged = vlan->flags & BRIDGE_VLAN_INFO_UNTAGGED;
-	bool pvid = vlan->flags & BRIDGE_VLAN_INFO_PVID;
-	struct mt7530_hw_vlan_entry new_entry;
 	struct mt7530_priv *priv = ds->priv;
 
-	mutex_lock(&priv->reg_mutex);
-
-	/* VID 0 is managed exclusively by mt7530_setup_vlan0() for
-	 * VLAN-unaware bridge operation. Don't let the bridge overwrite
-	 * its EG_CON flag with VTAG_EN and corrupt PORT_MEM.
-	 */
-	if (vlan->vid == 0)
-		goto skip_vlan_table;
-
-	mt7530_hw_vlan_entry_init(&new_entry, port, untagged);
-	mt7530_hw_vlan_update(priv, vlan->vid, &new_entry, mt7530_hw_vlan_add);
-
-skip_vlan_table:
-
-	if (pvid) {
-		priv->ports[port].pvid = vlan->vid;
-
-		/* Accept all frames if PVID is set */
-		mt7530_rmw(priv, MT7530_PVC_P(port), ACC_FRM_MASK,
-			   MT7530_VLAN_ACC_ALL);
-
-		/* Only configure PVID if VLAN filtering is enabled */
-		if (dsa_port_is_vlan_filtering(dsa_to_port(ds, port)))
-			mt7530_rmw(priv, MT7530_PPBV1_P(port),
-				   G0_PORT_VID_MASK,
-				   G0_PORT_VID(vlan->vid));
-	} else if (vlan->vid && priv->ports[port].pvid == vlan->vid) {
-		/* This VLAN is overwritten without PVID, so unset it */
-		priv->ports[port].pvid = G0_PORT_VID_DEF;
-
-		/* Only accept tagged frames if the port is VLAN-aware */
-		if (dsa_port_is_vlan_filtering(dsa_to_port(ds, port)))
-			mt7530_rmw(priv, MT7530_PVC_P(port), ACC_FRM_MASK,
-				   MT7530_VLAN_ACC_TAGGED);
-
-		mt7530_rmw(priv, MT7530_PPBV1_P(port), G0_PORT_VID_MASK,
-			   G0_PORT_VID_DEF);
-	}
-
-	mutex_unlock(&priv->reg_mutex);
-
-	return 0;
+	return mt7530_lib_port_vlan_add(&priv->lib_priv, port, vlan, extack);
 }
 
 static int
 mt7530_port_vlan_del(struct dsa_switch *ds, int port,
 		     const struct switchdev_obj_port_vlan *vlan)
 {
-	struct mt7530_hw_vlan_entry target_entry;
 	struct mt7530_priv *priv = ds->priv;
 
-	mutex_lock(&priv->reg_mutex);
-
-	/* VID 0 is managed exclusively by mt7530_setup_vlan0(). */
-	if (vlan->vid == 0)
-		goto skip_vlan_table;
-
-	mt7530_hw_vlan_entry_init(&target_entry, port, 0);
-	mt7530_hw_vlan_update(priv, vlan->vid, &target_entry,
-			      mt7530_hw_vlan_del);
-
-skip_vlan_table:
-	/* PVID is being restored to the default whenever the PVID port
-	 * is being removed from the VLAN.
-	 */
-	if (priv->ports[port].pvid == vlan->vid) {
-		priv->ports[port].pvid = G0_PORT_VID_DEF;
-
-		/* Only accept tagged frames if the port is VLAN-aware */
-		if (dsa_port_is_vlan_filtering(dsa_to_port(ds, port)))
-			mt7530_rmw(priv, MT7530_PVC_P(port), ACC_FRM_MASK,
-				   MT7530_VLAN_ACC_TAGGED);
-
-		mt7530_rmw(priv, MT7530_PPBV1_P(port), G0_PORT_VID_MASK,
-			   G0_PORT_VID_DEF);
-	}
-
-
-	mutex_unlock(&priv->reg_mutex);
-
-	return 0;
+	return mt7530_lib_port_vlan_del(&priv->lib_priv, port, vlan);
 }
 
 static int mt753x_port_mirror_add(struct dsa_switch *ds, int port,
@@ -2086,60 +1363,16 @@ static int mt753x_port_mirror_add(struct dsa_switch *ds, int port,
 				  bool ingress, struct netlink_ext_ack *extack)
 {
 	struct mt7530_priv *priv = ds->priv;
-	int monitor_port;
-	u32 val;
-
-	/* Check for existent entry */
-	if ((ingress ? priv->mirror_rx : priv->mirror_tx) & BIT(port))
-		return -EEXIST;
-
-	val = mt7530_read(priv, MT753X_MIRROR_REG(priv->id));
-
-	/* MT7530 only supports one monitor port */
-	monitor_port = MT753X_MIRROR_PORT_GET(priv->id, val);
-	if (val & MT753X_MIRROR_EN(priv->id) &&
-	    monitor_port != mirror->to_local_port)
-		return -EEXIST;
 
-	val |= MT753X_MIRROR_EN(priv->id);
-	val &= ~MT753X_MIRROR_PORT_MASK(priv->id);
-	val |= MT753X_MIRROR_PORT_SET(priv->id, mirror->to_local_port);
-	mt7530_write(priv, MT753X_MIRROR_REG(priv->id), val);
-
-	val = mt7530_read(priv, MT7530_PCR_P(port));
-	if (ingress) {
-		val |= PORT_RX_MIR;
-		priv->mirror_rx |= BIT(port);
-	} else {
-		val |= PORT_TX_MIR;
-		priv->mirror_tx |= BIT(port);
-	}
-	mt7530_write(priv, MT7530_PCR_P(port), val);
-
-	return 0;
+	return mt7530_lib_port_mirror_add(&priv->lib_priv, port, mirror, ingress, extack);
 }
 
 static void mt753x_port_mirror_del(struct dsa_switch *ds, int port,
 				   struct dsa_mall_mirror_tc_entry *mirror)
 {
 	struct mt7530_priv *priv = ds->priv;
-	u32 val;
 
-	val = mt7530_read(priv, MT7530_PCR_P(port));
-	if (mirror->ingress) {
-		val &= ~PORT_RX_MIR;
-		priv->mirror_rx &= ~BIT(port);
-	} else {
-		val &= ~PORT_TX_MIR;
-		priv->mirror_tx &= ~BIT(port);
-	}
-	mt7530_write(priv, MT7530_PCR_P(port), val);
-
-	if (!priv->mirror_rx && !priv->mirror_tx) {
-		val = mt7530_read(priv, MT753X_MIRROR_REG(priv->id));
-		val &= ~MT753X_MIRROR_EN(priv->id);
-		mt7530_write(priv, MT753X_MIRROR_REG(priv->id), val);
-	}
+	mt7530_lib_port_mirror_del(&priv->lib_priv, port, mirror);
 }
 
 static enum dsa_tag_protocol
@@ -2542,10 +1775,10 @@ mt7530_setup(struct dsa_switch *ds)
 	if ((val & MT7530_XTAL_MASK) == MT7530_XTAL_40MHZ)
 		mt7530_pll_setup(priv);
 
-	mt753x_trap_frames(priv);
+	mt7530_lib_trap_frames(&priv->lib_priv);
 
 	/* Enable and reset MIB counters */
-	mt7530_mib_reset(ds);
+	mt7530_lib_mib_reset(&priv->lib_priv);
 
 	for (i = 0; i < priv->ds->num_ports; i++) {
 		/* Clear link settings and enable force mode to force link down
@@ -2581,7 +1814,7 @@ mt7530_setup(struct dsa_switch *ds)
 	mt7530_set(priv, MT753X_AGC, LOCAL_EN);
 
 	/* Setup VLAN ID 0 for VLAN-unaware bridges */
-	ret = mt7530_setup_vlan0(priv);
+	ret = mt7530_lib_setup_vlan0(&priv->lib_priv);
 	if (ret)
 		return ret;
 
@@ -2639,7 +1872,8 @@ mt7530_setup(struct dsa_switch *ds)
 #endif /* CONFIG_GPIOLIB */
 
 	/* Flush the FDB table */
-	ret = mt7530_fdb_cmd(priv, MT7530_FDB_FLUSH, NULL);
+	ret = mt7530_lib_fdb_cmd(&priv->lib_priv, MT7530_FDB_FLUSH,
+				 ATC_MAT_MACTAB, NULL);
 	if (ret < 0)
 		return ret;
 
@@ -2658,10 +1892,10 @@ mt7531_setup_common(struct dsa_switch *ds)
 	ds->ageing_time_min = 2 * 1000;
 	ds->ageing_time_max = (AGE_CNT_MAX + 1) * (AGE_UNIT_MAX + 1) * 1000;
 
-	mt753x_trap_frames(priv);
+	mt7530_lib_trap_frames(&priv->lib_priv);
 
 	/* Enable and reset MIB counters */
-	mt7530_mib_reset(ds);
+	mt7530_lib_mib_reset(&priv->lib_priv);
 
 	/* Disable flooding on all ports */
 	mt7530_clear(priv, MT753X_MFC, BC_FFP_MASK | UNM_FFP_MASK |
@@ -2709,12 +1943,13 @@ mt7531_setup_common(struct dsa_switch *ds)
 			     CPORT_SW2FE_STAG_EN | CPORT_FE2SW_STAG_EN);
 
 	/* Flush the FDB table */
-	ret = mt7530_fdb_cmd(priv, MT7530_FDB_FLUSH, NULL);
+	ret = mt7530_lib_fdb_cmd(&priv->lib_priv, MT7530_FDB_FLUSH,
+				 ATC_MAT_MACTAB, NULL);
 	if (ret < 0)
 		return ret;
 
 	/* Setup VLAN ID 0 for VLAN-unaware bridges */
-	return mt7530_setup_vlan0(priv);
+	return mt7530_lib_setup_vlan0(&priv->lib_priv);
 }
 
 static int
@@ -3450,6 +2685,8 @@ static const struct phylink_mac_ops mt753x_phylink_mac_ops = {
 const struct mt753x_info mt753x_table[] = {
 	[ID_MT7621] = {
 		.id = ID_MT7621,
+		.reg_fields = mt7530_fields,
+		.num_reg_fields = ARRAY_SIZE(mt7530_fields),
 		.pcs_ops = &mt7530_pcs_ops,
 		.sw_setup = mt7530_setup,
 		.phy_read_c22 = mt7530_phy_read_c22,
@@ -3461,6 +2698,8 @@ const struct mt753x_info mt753x_table[] = {
 	},
 	[ID_MT7530] = {
 		.id = ID_MT7530,
+		.reg_fields = mt7530_fields,
+		.num_reg_fields = ARRAY_SIZE(mt7530_fields),
 		.pcs_ops = &mt7530_pcs_ops,
 		.sw_setup = mt7530_setup,
 		.phy_read_c22 = mt7530_phy_read_c22,
@@ -3472,6 +2711,8 @@ const struct mt753x_info mt753x_table[] = {
 	},
 	[ID_MT7531] = {
 		.id = ID_MT7531,
+		.reg_fields = mt7531_fields,
+		.num_reg_fields = ARRAY_SIZE(mt7531_fields),
 		.pcs_ops = &mt7530_pcs_ops,
 		.sw_setup = mt7531_setup,
 		.phy_read_c22 = mt7531_ind_c22_phy_read,
@@ -3483,6 +2724,8 @@ const struct mt753x_info mt753x_table[] = {
 	},
 	[ID_MT7988] = {
 		.id = ID_MT7988,
+		.reg_fields = mt7531_fields,
+		.num_reg_fields = ARRAY_SIZE(mt7531_fields),
 		.pcs_ops = &mt7530_pcs_ops,
 		.sw_setup = mt7988_setup,
 		.phy_read_c22 = mt7531_ind_c22_phy_read,
@@ -3493,6 +2736,8 @@ const struct mt753x_info mt753x_table[] = {
 	},
 	[ID_EN7581] = {
 		.id = ID_EN7581,
+		.reg_fields = mt7531_fields,
+		.num_reg_fields = ARRAY_SIZE(mt7531_fields),
 		.pcs_ops = &mt7530_pcs_ops,
 		.sw_setup = mt7988_setup,
 		.phy_read_c22 = mt7531_ind_c22_phy_read,
@@ -3503,6 +2748,8 @@ const struct mt753x_info mt753x_table[] = {
 	},
 	[ID_AN7583] = {
 		.id = ID_AN7583,
+		.reg_fields = mt7531_fields,
+		.num_reg_fields = ARRAY_SIZE(mt7531_fields),
 		.pcs_ops = &mt7530_pcs_ops,
 		.sw_setup = mt7988_setup,
 		.phy_read_c22 = mt7531_ind_c22_phy_read,
@@ -3570,6 +2817,47 @@ mt7530_remove_common(struct mt7530_priv *priv)
 }
 EXPORT_SYMBOL_GPL(mt7530_remove_common);
 
+int mt7530_setup_lib_priv(struct mt7530_priv *priv)
+{
+	struct mt7530_lib_priv *lib_priv = &priv->lib_priv;
+	int i;
+
+	lib_priv->dev = priv->dev;
+	lib_priv->ds = priv->ds;
+	lib_priv->regmap = priv->regmap;
+	lib_priv->ports = priv->ports;
+	lib_priv->reg_mutex = &priv->reg_mutex;
+
+	for (i = 0; i < ARRAY_SIZE(mt753x_fields); i++) {
+		const struct mt7530_reg_field *reg_field;
+		struct regmap_field *field;
+
+		reg_field = &mt753x_fields[i];
+		field = devm_regmap_field_alloc(priv->dev, priv->regmap,
+						reg_field->field);
+		if (IS_ERR(field))
+			return PTR_ERR(field);
+
+		lib_priv->fields[reg_field->id] = field;
+	}
+
+	for (i = 0; i < priv->info->num_reg_fields; i++) {
+		const struct mt7530_reg_field *reg_field;
+		struct regmap_field *field;
+
+		reg_field = &priv->info->reg_fields[i];
+		field = devm_regmap_field_alloc(priv->dev, priv->regmap,
+						reg_field->field);
+		if (IS_ERR(field))
+			return PTR_ERR(field);
+
+		lib_priv->fields[reg_field->id] = field;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(mt7530_setup_lib_priv);
+
 MODULE_AUTHOR("Sean Wang <sean.wang@mediatek.com>");
 MODULE_DESCRIPTION("Driver for Mediatek MT7530 Switch");
 MODULE_LICENSE("GPL");
diff --git a/drivers/net/dsa/mt7530.h b/drivers/net/dsa/mt7530.h
index 5f1e841f42c0..006a604f5274 100644
--- a/drivers/net/dsa/mt7530.h
+++ b/drivers/net/dsa/mt7530.h
@@ -6,13 +6,11 @@
 #ifndef __MT7530_H
 #define __MT7530_H
 
+#include "mt7530-lib.h"
+
 #define MT7530_NUM_PORTS		7
 #define MT7530_NUM_PHYS			5
 #define MT7530_NUM_FDB_RECORDS		2048
-#define MT7530_ALL_MEMBERS		0xff
-
-#define MTK_HDR_LEN	4
-#define MT7530_MAX_MTU	(15 * 1024 - ETH_HLEN - ETH_FCS_LEN - MTK_HDR_LEN)
 
 enum mt753x_id {
 	ID_MT7530 = 0,
@@ -133,18 +131,8 @@ enum mt753x_id {
 #define  R03_EG_TAG(x)			FIELD_PREP(R03_EG_TAG_MASK, x)
 #define  R03_PORT_FW_MASK		GENMASK(2, 0)
 
-enum mt753x_to_cpu_fw {
-	TO_CPU_FW_SYSTEM_DEFAULT,
-	TO_CPU_FW_CPU_EXCLUDE = 4,
-	TO_CPU_FW_CPU_INCLUDE = 5,
-	TO_CPU_FW_CPU_ONLY = 6,
-	TO_CPU_FW_DROP = 7,
-};
-
 /* Registers for address table access */
 #define MT7530_ATA1			0x74
-#define  STATIC_EMP			0
-#define  STATIC_ENT			3
 #define MT7530_ATA2			0x78
 #define  ATA2_IVL			BIT(15)
 #define  ATA2_FID(x)			(((x) & 0x7) << 12)
@@ -160,15 +148,6 @@ enum mt753x_to_cpu_fw {
 #define  ATC_SRCH_HIT			BIT(13)
 #define  ATC_INVALID			BIT(12)
 #define  ATC_MAT(x)			(((x) & 0xf) << 8)
-#define  ATC_MAT_MACTAB			ATC_MAT(0)
-
-enum mt7530_fdb_cmd {
-	MT7530_FDB_READ	= 0,
-	MT7530_FDB_WRITE = 1,
-	MT7530_FDB_FLUSH = 2,
-	MT7530_FDB_START = 4,
-	MT7530_FDB_NEXT = 5,
-};
 
 /* Registers for table search read address */
 #define MT7530_TSRA1			0x84
@@ -199,14 +178,6 @@ enum mt7530_fdb_cmd {
 #define  VTCR_FUNC(x)			(((x) & 0xf) << 12)
 #define  VTCR_VID			((x) & 0xfff)
 
-enum mt7530_vlan_cmd {
-	/* Read/Write the specified VID entry from VAWD register based
-	 * on VID.
-	 */
-	MT7530_VTCR_RD_VID = 0,
-	MT7530_VTCR_WR_VID = 1,
-};
-
 /* Register for setup vlan and acl write data */
 #define MT7530_VAWD1			0x94
 #define  PORT_STAG			BIT(31)
@@ -225,21 +196,7 @@ enum mt7530_vlan_cmd {
 #define  PORT_MEM_SHFT			16
 #define  PORT_MEM_MASK			0xff
 
-enum mt7530_fid {
-	FID_STANDALONE = 0,
-	FID_BRIDGED = 1,
-};
-
 #define MT7530_VAWD2			0x98
-/* Egress Tag Control */
-#define  ETAG_CTRL_P(p, x)		(((x) & 0x3) << ((p) << 1))
-#define  ETAG_CTRL_P_MASK(p)		ETAG_CTRL_P(p, 3)
-
-enum mt7530_vlan_egress_attr {
-	MT7530_VLAN_EGRESS_UNTAG = 0,
-	MT7530_VLAN_EGRESS_TAG = 2,
-	MT7530_VLAN_EGRESS_STACK = 3,
-};
 
 /* Register for address age control */
 #define MT7530_AAC			0xa0
@@ -267,40 +224,16 @@ enum mt7530_vlan_egress_attr {
 #define  EGR_BC_CRC_IPG_PREAMBLE	0x18	/* crc + ipg + preamble */
 
 /* Register for port STP state control */
-#define MT7530_SSP_P(x)			(0x2000 + ((x) * 0x100))
-#define  FID_PST(fid, state)		(((state) & 0x3) << ((fid) * 2))
-#define  FID_PST_MASK(fid)		FID_PST(fid, 0x3)
-
-enum mt7530_stp_state {
-	MT7530_STP_DISABLED = 0,
-	MT7530_STP_BLOCKING = 1,
-	MT7530_STP_LISTENING = 1,
-	MT7530_STP_LEARNING = 2,
-	MT7530_STP_FORWARDING  = 3
-};
+#define MT7530_SSP			0x2000
+#define MT7530_SSP_P(x)			(MT7530_SSP + ((x) * 0x100))
 
 /* Register for port control */
-#define MT7530_PCR_P(x)			(0x2004 + ((x) * 0x100))
+#define MT7530_PCR			0x2004
+#define MT7530_PCR_P(x)			(MT7530_PCR + ((x) * 0x100))
 #define  PORT_TX_MIR			BIT(9)
 #define  PORT_RX_MIR			BIT(8)
 #define  PORT_VLAN(x)			((x) & 0x3)
 
-enum mt7530_port_mode {
-	/* Port Matrix Mode: Frames are forwarded by the PCR_MATRIX members. */
-	MT7530_PORT_MATRIX_MODE = PORT_VLAN(0),
-
-	/* Fallback Mode: Forward received frames with ingress ports that do
-	 * not belong to the VLAN member. Frames whose VID is not listed on
-	 * the VLAN table are forwarded by the PCR_MATRIX members.
-	 */
-	MT7530_PORT_FALLBACK_MODE = PORT_VLAN(1),
-
-	/* Security Mode: Discard any frame due to ingress membership
-	 * violation or VID missed on the VLAN table.
-	 */
-	MT7530_PORT_SECURITY_MODE = PORT_VLAN(3),
-};
-
 #define  PCR_MATRIX(x)			(((x) & 0xff) << 16)
 #define  PORT_PRI(x)			(((x) & 0x7) << 24)
 #define  EG_TAG(x)			(((x) & 0x3) << 28)
@@ -309,11 +242,13 @@ enum mt7530_port_mode {
 #define  PCR_PORT_VLAN_MASK		PORT_VLAN(3)
 
 /* Register for port security control */
-#define MT7530_PSC_P(x)			(0x200c + ((x) * 0x100))
+#define MT7530_PSC			0x200c
+#define MT7530_PSC_P(x)			(MT7530_PSC + ((x) * 0x100))
 #define  SA_DIS				BIT(4)
 
 /* Register for port vlan control */
-#define MT7530_PVC_P(x)			(0x2010 + ((x) * 0x100))
+#define MT7530_PVC			0x2010
+#define MT7530_PVC_P(x)			(MT7530_PVC + ((x) * 0x100))
 #define  PORT_SPEC_TAG			BIT(5)
 #define  PVC_EG_TAG(x)			(((x) & 0x7) << 8)
 #define  PVC_EG_TAG_MASK		PVC_EG_TAG(7)
@@ -321,30 +256,13 @@ enum mt7530_port_mode {
 #define  VLAN_ATTR_MASK			VLAN_ATTR(3)
 #define  ACC_FRM_MASK			GENMASK(1, 0)
 
-enum mt7530_vlan_port_eg_tag {
-	MT7530_VLAN_EG_DISABLED = 0,
-	MT7530_VLAN_EG_CONSISTENT = 1,
-	MT7530_VLAN_EG_UNTAGGED = 4,
-};
-
-enum mt7530_vlan_port_attr {
-	MT7530_VLAN_USER = 0,
-	MT7530_VLAN_TRANSPARENT = 3,
-};
-
-enum mt7530_vlan_port_acc_frm {
-	MT7530_VLAN_ACC_ALL = 0,
-	MT7530_VLAN_ACC_TAGGED = 1,
-	MT7530_VLAN_ACC_UNTAGGED = 2,
-};
-
 #define  STAG_VPID			(((x) & 0xffff) << 16)
 
 /* Register for port port-and-protocol based vlan 1 control */
-#define MT7530_PPBV1_P(x)		(0x2014 + ((x) * 0x100))
+#define MT7530_PPBV1			0x2014
+#define MT7530_PPBV1_P(x)		(MT7530_PPBV1 + ((x) * 0x100))
 #define  G0_PORT_VID(x)			(((x) & 0xfff) << 0)
 #define  G0_PORT_VID_MASK		G0_PORT_VID(0xfff)
-#define  G0_PORT_VID_DEF		G0_PORT_VID(0)
 
 /* Register for port MAC control register */
 #define MT753X_PMCR_P(x)		(0x3000 + ((x) * 0x100))
@@ -422,55 +340,54 @@ enum mt7530_vlan_port_acc_frm {
 #define  MAX_RX_JUMBO(x)		((x) << 2)
 #define  MAX_RX_JUMBO_MASK		GENMASK(5, 2)
 #define  MAX_RX_PKT_LEN_MASK		GENMASK(1, 0)
-#define  MAX_RX_PKT_LEN_1522		0x0
-#define  MAX_RX_PKT_LEN_1536		0x1
-#define  MAX_RX_PKT_LEN_1552		0x2
-#define  MAX_RX_PKT_LEN_JUMBO		0x3
 
 /* Register for MIB */
-#define MT7530_PORT_MIB_COUNTER(x)	(0x4000 + (x) * 0x100)
+#define MT7530_MIB_COUNTER		0x4000
+#define MT7530_PORT_MIB_COUNTER(x)	(MT7530_MIB_COUNTER + (x) * 0x100)
 /* Each define is an offset of MT7530_PORT_MIB_COUNTER */
-#define   MT7530_PORT_MIB_TX_DROP	0x00
-#define   MT7530_PORT_MIB_TX_CRC_ERR	0x04
-#define   MT7530_PORT_MIB_TX_UNICAST	0x08
-#define   MT7530_PORT_MIB_TX_MULTICAST	0x0c
-#define   MT7530_PORT_MIB_TX_BROADCAST	0x10
-#define   MT7530_PORT_MIB_TX_COLLISION	0x14
-#define   MT7530_PORT_MIB_TX_SINGLE_COLLISION 0x18
-#define   MT7530_PORT_MIB_TX_MULTIPLE_COLLISION 0x1c
-#define   MT7530_PORT_MIB_TX_DEFERRED	0x20
-#define   MT7530_PORT_MIB_TX_LATE_COLLISION 0x24
-#define   MT7530_PORT_MIB_TX_EXCESSIVE_COLLISION 0x28
-#define   MT7530_PORT_MIB_TX_PAUSE	0x2c
-#define   MT7530_PORT_MIB_TX_PKT_SZ_64	0x30
-#define   MT7530_PORT_MIB_TX_PKT_SZ_65_TO_127 0x34
-#define   MT7530_PORT_MIB_TX_PKT_SZ_128_TO_255 0x38
-#define   MT7530_PORT_MIB_TX_PKT_SZ_256_TO_511 0x3c
-#define   MT7530_PORT_MIB_TX_PKT_SZ_512_TO_1023 0x40
-#define   MT7530_PORT_MIB_TX_PKT_SZ_1024_TO_MAX 0x44
-#define   MT7530_PORT_MIB_TX_BYTES	0x48 /* 64 bytes */
-#define   MT7530_PORT_MIB_RX_DROP	0x60
-#define   MT7530_PORT_MIB_RX_FILTERING	0x64
-#define   MT7530_PORT_MIB_RX_UNICAST	0x68
-#define   MT7530_PORT_MIB_RX_MULTICAST	0x6c
-#define   MT7530_PORT_MIB_RX_BROADCAST	0x70
-#define   MT7530_PORT_MIB_RX_ALIGN_ERR	0x74
-#define   MT7530_PORT_MIB_RX_CRC_ERR	0x78
-#define   MT7530_PORT_MIB_RX_UNDER_SIZE_ERR 0x7c
-#define   MT7530_PORT_MIB_RX_FRAG_ERR	0x80
-#define   MT7530_PORT_MIB_RX_OVER_SZ_ERR 0x84
-#define   MT7530_PORT_MIB_RX_JABBER_ERR	0x88
-#define   MT7530_PORT_MIB_RX_PAUSE	0x8c
-#define   MT7530_PORT_MIB_RX_PKT_SZ_64	0x90
-#define   MT7530_PORT_MIB_RX_PKT_SZ_65_TO_127 0x94
-#define   MT7530_PORT_MIB_RX_PKT_SZ_128_TO_255 0x98
-#define   MT7530_PORT_MIB_RX_PKT_SZ_256_TO_511 0x9c
-#define   MT7530_PORT_MIB_RX_PKT_SZ_512_TO_1023 0xa0
-#define   MT7530_PORT_MIB_RX_PKT_SZ_1024_TO_MAX 0xa4
-#define   MT7530_PORT_MIB_RX_BYTES	0xa8 /* 64 bytes */
-#define   MT7530_PORT_MIB_RX_CTRL_DROP	0xb0
-#define   MT7530_PORT_MIB_RX_INGRESS_DROP 0xb4
-#define   MT7530_PORT_MIB_RX_ARL_DROP	0xb8
+#define   MT7530_PORT_MIB_TX_DROP	(MT7530_MIB_COUNTER + 0x00)
+#define   MT7530_PORT_MIB_TX_CRC_ERR	(MT7530_MIB_COUNTER + 0x04)
+#define   MT7530_PORT_MIB_TX_UNICAST	(MT7530_MIB_COUNTER + 0x08)
+#define   MT7530_PORT_MIB_TX_MULTICAST	(MT7530_MIB_COUNTER + 0x0c)
+#define   MT7530_PORT_MIB_TX_BROADCAST	(MT7530_MIB_COUNTER + 0x10)
+#define   MT7530_PORT_MIB_TX_COLLISION	(MT7530_MIB_COUNTER + 0x14)
+#define   MT7530_PORT_MIB_TX_SINGLE_COLLISION (MT7530_MIB_COUNTER + 0x18)
+#define   MT7530_PORT_MIB_TX_MULTIPLE_COLLISION (MT7530_MIB_COUNTER + 0x1c)
+#define   MT7530_PORT_MIB_TX_DEFERRED	(MT7530_MIB_COUNTER + 0x20)
+#define   MT7530_PORT_MIB_TX_LATE_COLLISION (MT7530_MIB_COUNTER + 0x24)
+#define   MT7530_PORT_MIB_TX_EXCESSIVE_COLLISION (MT7530_MIB_COUNTER + 0x28)
+#define   MT7530_PORT_MIB_TX_PAUSE	(MT7530_MIB_COUNTER + 0x2c)
+#define   MT7530_PORT_MIB_TX_PKT_SZ_64	(MT7530_MIB_COUNTER + 0x30)
+#define   MT7530_PORT_MIB_TX_PKT_SZ_65_TO_127 (MT7530_MIB_COUNTER + 0x34)
+#define   MT7530_PORT_MIB_TX_PKT_SZ_128_TO_255 (MT7530_MIB_COUNTER + 0x38)
+#define   MT7530_PORT_MIB_TX_PKT_SZ_256_TO_511 (MT7530_MIB_COUNTER + 0x3c)
+#define   MT7530_PORT_MIB_TX_PKT_SZ_512_TO_1023 (MT7530_MIB_COUNTER + 0x40)
+#define   MT7530_PORT_MIB_TX_PKT_SZ_1024_TO_MAX (MT7530_MIB_COUNTER + 0x44)
+#define   MT7530_PORT_MIB_TX_BYTES_LOW	(MT7530_MIB_COUNTER + 0x48) /* 64 bytes */
+#define   MT7530_PORT_MIB_TX_BYTES_HIGH	(MT7530_MIB_COUNTER + 0x4c)
+#define   MT7530_PORT_MIB_RX_DROP	(MT7530_MIB_COUNTER + 0x60)
+#define   MT7530_PORT_MIB_RX_FILTERING	(MT7530_MIB_COUNTER + 0x64)
+#define   MT7530_PORT_MIB_RX_UNICAST	(MT7530_MIB_COUNTER + 0x68)
+#define   MT7530_PORT_MIB_RX_MULTICAST	(MT7530_MIB_COUNTER + 0x6c)
+#define   MT7530_PORT_MIB_RX_BROADCAST	(MT7530_MIB_COUNTER + 0x70)
+#define   MT7530_PORT_MIB_RX_ALIGN_ERR	(MT7530_MIB_COUNTER + 0x74)
+#define   MT7530_PORT_MIB_RX_CRC_ERR	(MT7530_MIB_COUNTER + 0x78)
+#define   MT7530_PORT_MIB_RX_UNDER_SIZE_ERR (MT7530_MIB_COUNTER + 0x7c)
+#define   MT7530_PORT_MIB_RX_FRAG_ERR	(MT7530_MIB_COUNTER + 0x80)
+#define   MT7530_PORT_MIB_RX_OVER_SZ_ERR (MT7530_MIB_COUNTER + 0x84)
+#define   MT7530_PORT_MIB_RX_JABBER_ERR	(MT7530_MIB_COUNTER + 0x88)
+#define   MT7530_PORT_MIB_RX_PAUSE	(MT7530_MIB_COUNTER + 0x8c)
+#define   MT7530_PORT_MIB_RX_PKT_SZ_64	(MT7530_MIB_COUNTER + 0x90)
+#define   MT7530_PORT_MIB_RX_PKT_SZ_65_TO_127 (MT7530_MIB_COUNTER + 0x94)
+#define   MT7530_PORT_MIB_RX_PKT_SZ_128_TO_255 (MT7530_MIB_COUNTER + 0x98)
+#define   MT7530_PORT_MIB_RX_PKT_SZ_256_TO_511 (MT7530_MIB_COUNTER + 0x9c)
+#define   MT7530_PORT_MIB_RX_PKT_SZ_512_TO_1023 (MT7530_MIB_COUNTER + 0xa0)
+#define   MT7530_PORT_MIB_RX_PKT_SZ_1024_TO_MAX (MT7530_MIB_COUNTER + 0xa4)
+#define   MT7530_PORT_MIB_RX_BYTES_LOW	(MT7530_MIB_COUNTER + 0xa8) /* 64 bytes */
+#define   MT7530_PORT_MIB_RX_BYTES_HIGH	(MT7530_MIB_COUNTER + 0xac)
+#define   MT7530_PORT_MIB_RX_CTRL_DROP	(MT7530_MIB_COUNTER + 0xb0)
+#define   MT7530_PORT_MIB_RX_INGRESS_DROP (MT7530_MIB_COUNTER + 0xb4)
+#define   MT7530_PORT_MIB_RX_ARL_DROP	(MT7530_MIB_COUNTER + 0xb8)
 #define MT7530_MIB_CCR			0x4fe0
 #define  CCR_MIB_ENABLE			BIT(31)
 #define  CCR_RX_OCT_CNT_GOOD		BIT(7)
@@ -769,45 +686,6 @@ enum mt7531_xtal_fsel {
 #define  REG_GSWCK_EN			BIT(0)
 #define  REG_TRGMIICK_EN		BIT(1)
 
-#define MIB_DESC(_s, _o, _n)	\
-	{			\
-		.size = (_s),	\
-		.offset = (_o),	\
-		.name = (_n),	\
-	}
-
-struct mt7530_mib_desc {
-	unsigned int size;
-	unsigned int offset;
-	const char *name;
-};
-
-struct mt7530_fdb {
-	u16 vid;
-	u8 port_mask;
-	u8 aging;
-	u8 mac[6];
-	bool noarp;
-};
-
-/* struct mt7530_port -	This is the main data structure for holding the state
- *			of the port.
- * @enable:	The status used for show port is enabled or not.
- * @pm:		The matrix used to show all connections with the port.
- * @pvid:	The VLAN specified is to be considered a PVID at ingress.  Any
- *		untagged frames will be assigned to the related VLAN.
- * @sgmii_pcs:	Pointer to PCS instance for SerDes ports
- * @stats:	Cached port statistics for MDIO-connected switches
- */
-struct mt7530_port {
-	bool enable;
-	bool isolated;
-	u32 pm;
-	u16 pvid;
-	struct phylink_pcs *sgmii_pcs;
-	struct rtnl_link_stats64 stats;
-};
-
 /* Port 5 mode definitions of the MT7530 switch */
 enum mt7530_p5_mode {
 	GMAC5,
@@ -839,6 +717,9 @@ struct mt753x_pcs {
 struct mt753x_info {
 	enum mt753x_id id;
 
+	const struct mt7530_reg_field *reg_fields;
+	unsigned int num_reg_fields;
+
 	const struct phylink_pcs_ops *pcs_ops;
 
 	int (*sw_setup)(struct dsa_switch *ds);
@@ -896,8 +777,6 @@ struct mt7530_priv {
 	bool			mcm;
 	enum mt7530_p5_mode	p5_mode;
 	bool			p5_sgmii;
-	u8			mirror_rx;
-	u8			mirror_tx;
 	struct mt7530_port	ports[MT7530_NUM_PORTS];
 	struct mt753x_pcs	pcs[MT7530_NUM_PORTS];
 	/* protect among processes for registers access*/
@@ -909,24 +788,10 @@ struct mt7530_priv {
 	spinlock_t stats_lock; /* protects cached stats counters */
 	struct delayed_work stats_work;
 	unsigned long stats_last;
-};
 
-struct mt7530_hw_vlan_entry {
-	int port;
-	u8  old_members;
-	bool untagged;
+	struct mt7530_lib_priv lib_priv;
 };
 
-static inline void mt7530_hw_vlan_entry_init(struct mt7530_hw_vlan_entry *e,
-					     int port, bool untagged)
-{
-	e->port = port;
-	e->untagged = untagged;
-}
-
-typedef void (*mt7530_vlan_op)(struct mt7530_priv *,
-			       struct mt7530_hw_vlan_entry *);
-
 struct mt7530_hw_stats {
 	const char	*string;
 	u16		reg;
@@ -947,6 +812,7 @@ static inline void INIT_MT7530_DUMMY_POLL(struct mt7530_dummy_poll *p,
 
 int mt7530_probe_common(struct mt7530_priv *priv);
 void mt7530_remove_common(struct mt7530_priv *priv);
+int mt7530_setup_lib_priv(struct mt7530_priv *priv);
 
 extern const struct mt753x_info mt753x_table[];
 
-- 
2.53.0

