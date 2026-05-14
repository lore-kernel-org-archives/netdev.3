Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A955B3DD869;
	Thu, 14 May 2026 14:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778767486; cv=none; b=ofETAeq9r6+liKdAaVjCG1efNnXlZaKI4508nSzHikLJkl8ftN796t/QiGKnDD8yuuLDidLr8+byUh4I9SMs5chv//V5H8dcJP9kZREcL5JSbBi9Vb+drUbsdlLGeMpCT+vjHgC55eV8aMq5fpLoFvv74C0mCDuf861GcQMaeJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778767486; c=relaxed/simple;
	bh=mgmrGkMmkg4rIpzuSqS91hW715bU8o3FJ978wP4umwM=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RxUUrGDGY6cYD10clKxX5uEsL1FWwpu5PQkCxTlKpakBny2kDE2/nxX1S7/GdGm43vH9RS/PzNno5f+nRP0ktuHq5pleQLYO3s8dkikLJA72WsnCI3f32SzO9EoZxRUJ9C0C1c1eyfmVsu9786Of1shqVJlR4ED18S95XROKHl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1wNWg2-0000000044u-40oN;
	Thu, 14 May 2026 14:04:39 +0000
Date: Thu, 14 May 2026 15:04:35 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: "Chester A. Unal" <chester.a.unal@arinc9.com>,
	Daniel Golle <daniel@makrotopia.org>, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	DENG Qingfang <dqfext@gmail.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	=?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
	Sean Wang <sean.wang@mediatek.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH net v2 2/5] net: dsa: mt7530: preserve VLAN tags on trapped
 link-local frames
Message-ID: <891e0cd34db2a5fe20ceb73283a81fb5f71427ca.1778766629.git.daniel@makrotopia.org>
References: <cover.1778766629.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1778766629.git.daniel@makrotopia.org>

The BPC, RGAC1 and RGAC2 registers control the handling of link-local
frames with reserved MAC DAs (01:80:C2:00:00:0x). These frames are
correctly trapped to the CPU port, but the egress VLAN tag attribute was
set to MT7530_VLAN_EG_UNTAGGED which causes the switch to strip any
VLAN tags from trapped frames before they reach the CPU.

This causes VLAN-tagged link-local frames (STP BPDUs, LLDP, PTP Peer
Delay Requests) to arrive at the CPU without their VLAN tag, so they
are delivered to the base network interface instead of the VLAN
sub-interface. The DSA local_termination selftest confirms this: all
link-local protocol tests on VLAN upper interfaces fail.

Set the EG_TAG attribute to MT7530_VLAN_EG_DISABLED (system default)
so that the switch does not modify VLAN tags in trapped frames. This
way VLAN-tagged frames retain their original tag and are delivered to
the correct VLAN sub-interface, matching the behavior of non-trapped
frames which pass through without VLAN tag modification.

Fixes: 69ddba9d170b ("net: dsa: mt7530: fix handling of all link-local frames")
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
Acked-by: Chester A. Unal <chester.a.unal@arinc9.com>
---
v2: no changes

 drivers/net/dsa/mt7530.c | 27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
index cd311dfd3600..4f657ef6aa65 100644
--- a/drivers/net/dsa/mt7530.c
+++ b/drivers/net/dsa/mt7530.c
@@ -1300,37 +1300,40 @@ static void mt7530_setup_port5(struct dsa_switch *ds, phy_interface_t interface)
 static void
 mt753x_trap_frames(struct mt7530_priv *priv)
 {
-	/* Trap 802.1X PAE frames and BPDUs to the CPU port(s) and egress them
-	 * VLAN-untagged.
+	/* Trap 802.1X PAE frames and BPDUs to the CPU port(s) and egress
+	 * them with the EG_TAG attribute set to disabled (system default)
+	 * so that any VLAN tags in the frame are not modified by the
+	 * switch egress VLAN tag processing. This preserves VLAN tags
+	 * for reception on VLAN sub-interfaces.
 	 */
 	mt7530_rmw(priv, MT753X_BPC,
 		   PAE_BPDU_FR | PAE_EG_TAG_MASK | PAE_PORT_FW_MASK |
 			   BPDU_EG_TAG_MASK | BPDU_PORT_FW_MASK,
-		   PAE_BPDU_FR | PAE_EG_TAG(MT7530_VLAN_EG_UNTAGGED) |
+		   PAE_BPDU_FR | PAE_EG_TAG(MT7530_VLAN_EG_DISABLED) |
 			   PAE_PORT_FW(TO_CPU_FW_CPU_ONLY) |
-			   BPDU_EG_TAG(MT7530_VLAN_EG_UNTAGGED) |
+			   BPDU_EG_TAG(MT7530_VLAN_EG_DISABLED) |
 			   TO_CPU_FW_CPU_ONLY);
 
-	/* Trap frames with :01 and :02 MAC DAs to the CPU port(s) and egress
-	 * them VLAN-untagged.
+	/* Trap frames with :01 and :02 MAC DAs to the CPU port(s) and
+	 * egress them with EG_TAG disabled.
 	 */
 	mt7530_rmw(priv, MT753X_RGAC1,
 		   R02_BPDU_FR | R02_EG_TAG_MASK | R02_PORT_FW_MASK |
 			   R01_BPDU_FR | R01_EG_TAG_MASK | R01_PORT_FW_MASK,
-		   R02_BPDU_FR | R02_EG_TAG(MT7530_VLAN_EG_UNTAGGED) |
+		   R02_BPDU_FR | R02_EG_TAG(MT7530_VLAN_EG_DISABLED) |
 			   R02_PORT_FW(TO_CPU_FW_CPU_ONLY) | R01_BPDU_FR |
-			   R01_EG_TAG(MT7530_VLAN_EG_UNTAGGED) |
+			   R01_EG_TAG(MT7530_VLAN_EG_DISABLED) |
 			   TO_CPU_FW_CPU_ONLY);
 
-	/* Trap frames with :03 and :0E MAC DAs to the CPU port(s) and egress
-	 * them VLAN-untagged.
+	/* Trap frames with :03 and :0E MAC DAs to the CPU port(s) and
+	 * egress them with EG_TAG disabled.
 	 */
 	mt7530_rmw(priv, MT753X_RGAC2,
 		   R0E_BPDU_FR | R0E_EG_TAG_MASK | R0E_PORT_FW_MASK |
 			   R03_BPDU_FR | R03_EG_TAG_MASK | R03_PORT_FW_MASK,
-		   R0E_BPDU_FR | R0E_EG_TAG(MT7530_VLAN_EG_UNTAGGED) |
+		   R0E_BPDU_FR | R0E_EG_TAG(MT7530_VLAN_EG_DISABLED) |
 			   R0E_PORT_FW(TO_CPU_FW_CPU_ONLY) | R03_BPDU_FR |
-			   R03_EG_TAG(MT7530_VLAN_EG_UNTAGGED) |
+			   R03_EG_TAG(MT7530_VLAN_EG_DISABLED) |
 			   TO_CPU_FW_CPU_ONLY);
 }
 
-- 
2.54.0
