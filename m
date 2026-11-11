Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=68.232.154.123
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794407510;
	b=esjUjIlFTGzavq7etdc7yTogj+ggcv0f5r3dtMO0mxSf4y5T2rSp7wPt1aS7bHvvyX0T
	 cQJycTPs1LWeuA4v1jCIHw7Wui0emOW8wym42cEewAr+vrpu5hE8NKhFguzlk/9bGw6gR
	 5jZbyq954u1gSkzTY51ZM+LodI8SUP64szZxRILG/igNdZqFM67wMOPrMiW+LQRRQrEIC
	 W/39hO52yctw3Ymn5vhidg+9NPdKVeYJs3Unr1msVTaf6GxFovB5Nf6uu73siTPhTCUD2
	 ugJzYQXXHXn1L3OyuMH5Il0wBQSzbGeykYlTNw2u3Uj4ZU6uG8jMG4NkC+iE8MEDZmg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794407510;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-Amp-Result:Received:Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-ID:References:In-Reply-To:To:CC:X-Mailer;
	bh=FpqThEAQq884gGkXUq0nZfGLBOXswodMtHb28S6gKq8=;
	b=kxqhiI+qDRa2y12BVmCNM0jZCaIkOSmBYWMUxMT2oUI2s71zC0JL2MVpidG/YXT1Yju2
	 BQ3V2h+pUI2jmXCzcPbk/g1Yc6muSLpJ6owKgk+aCY4sBDFSnBKC43NdyJssET1uwXEoG
	 IGXUeD2ThhpcONsgItqE8qbnQUo9V/cjXznas1oGng/V9CSbjJOJeMEipipW9T84We4te
	 8b1cND864cVQx39pyJnhtGidT6yUDv2h8VdbTbRivsoFo7T2imde+z+m6cfLyRdvlhjMg
	 CYUR4VBvDAnotHRzssHv1eizJhkRrzc2l8ducNQsxtgikLc0ERAHYsjLbHeB4lsYHLg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=microchip.com;
	spf=pass smtp.mailfrom=microchip.com;
	dkim=pass header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=cxOCjnpd;
	arc=none smtp.remote-ip=68.232.154.123
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 073A160A6F5A;
	Wed, 11 Nov 2026 14:31:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 073A160A6F5A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=cxOCjnpd
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1794407517; x=1825943517;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=63C2l/35fgXhbv9pkZTuopuvnN7R8G2katEZp0sbTQ8=;
  b=cxOCjnpd7S+0hE4zEZi3RswCk4SToTCy1mi315mPjPUv9iRyKQfP6XaO
   jTYQH0Z7Oppcjxr6hDEOePWX6S2Ms6j0JgUWGx1rLKRPlgYIcZFAaTORH
   GWZpZTP8/n2mWAJVp/X/K0pwyx8E7+ajg2pWr+gBaMziU8ERtwgT3oAhY
   8/YurG09ztXihDEvo3xNpe8YtCOGPOkQ3/zDtJY1BYkeeJL8d8hvl5t8C
   HqpDh0lUpKINDi/RjGqgVLXiBo4qP+j7hDYsVSLsHrapIJyEx9y5ReCmo
   cLY+7dLHJGUZw9dM9FlwrCvs28/0J1AX5HZiwG0LIIgUcbfoB46PphqXu
   A==;
X-CSE-ConnectionGUID: Y/6r8e8iQM6KjuVKGsvmtg==
X-CSE-MsgGUID: KU6b1T8PR+W3dpXWkxJmDQ==
X-IronPort-AV: E=Sophos;i="6.27,208,1787036400"; 
   d="scan'208";a="65390788"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Nov 2026 07:31:56 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Wed, 11 Nov 2026 07:31:48 -0700
Received: from DEN-DL-M70577.microsemi.net (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Wed, 11 Nov 2026 07:31:46 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Date: Wed, 11 Nov 2026 15:31:18 +0100
Subject: [PATCH net-next v2 8/9] net: sparx5/lan969x: scale the TAS guard
 band with the MTU
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261111-sparx5-mtu-change-v2-8-59c91357e8f6@microchip.com>
References: <20261111-sparx5-mtu-change-v2-0-59c91357e8f6@microchip.com>
In-Reply-To: <20261111-sparx5-mtu-change-v2-0-59c91357e8f6@microchip.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Steen Hegelund
	<Steen.Hegelund@microchip.com>, <UNGLinuxDriver@microchip.com>, "Richard
 Cochran" <richardcochran@gmail.com>, Russell King <linux@armlinux.org.uk>
CC: <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, Robert Marko <robert.marko@sartura.hr>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	=?utf-8?q?Jens_Emil_Schulz_=C3=98stergaard?=
	<jensemil.schulzostergaard@microchip.com>
X-Mailer: b4 0.14.3

The TAS guard band (QMAXSDU_VAL, in units of 64 bytes) is how long
before a gate closes the scheduler stops starting frames of a traffic
class, so that a frame started just before the close still finishes in
time. The driver leaves it at the reset value of 24 x 64 = 1536 bytes,
so with a larger MTU, a frame started inside the guard band would
overrun the gate close.

The MAC maximum frame length only limits the frames a port receives, so
a port can transmit frames of the largest MTU of all ports, for example
when forwarding from a port with a larger MTU. Therefore, size the guard
band of all ports for a frame of the largest MTU, plus the Ethernet
header, FCS and two VLAN tags, rounded up to 64 bytes. Add the
HSCH_TAS_QMAXSDU_CFG register, program the guard band at init, and add
sparx5_tas_gb_update() for use when the MTU changes.

With the default MTU of 1500 the guard band is unchanged. As the
scheduler does not start a frame inside the guard band, a gate window
shorter than the guard band at the link speed cannot transmit, as is
already the case for the default 1536 byte guard band.

Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
---
 .../net/ethernet/microchip/sparx5/sparx5_main.h    |  1 +
 .../ethernet/microchip/sparx5/sparx5_main_regs.h   | 12 ++++++
 drivers/net/ethernet/microchip/sparx5/sparx5_tas.c | 43 +++++++++++++++++++++-
 3 files changed, 54 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_main.h b/drivers/net/ethernet/microchip/sparx5/sparx5_main.h
index 59deeb91ad921..9bd3f7827b1f2 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_main.h
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_main.h
@@ -746,6 +746,7 @@ int sparx5_tas_enable(struct sparx5_port *port,
 		      struct tc_taprio_qopt_offload *qopt);
 int sparx5_tas_disable(struct sparx5_port *port);
 void sparx5_tas_speed(struct sparx5_port *port, int speed);
+void sparx5_tas_gb_update(struct sparx5 *sparx5);
 
 /* sparx5_mirror.c */
 int sparx5_mirror_add(struct sparx5_mall_entry *entry);
diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_main_regs.h b/drivers/net/ethernet/microchip/sparx5/sparx5_main_regs.h
index 5302c7686e207..8a6de30042b5d 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_main_regs.h
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_main_regs.h
@@ -5424,6 +5424,18 @@ extern const struct sparx5_regs *regs;
 #define HSCH_TAS_STATEMACHINE_CFG_REVISIT_DLY_GET(x)\
 	FIELD_GET(HSCH_TAS_STATEMACHINE_CFG_REVISIT_DLY, x)
 
+/* HSCH:TAS_PROFILE_CFG:TAS_QMAXSDU_CFG */
+#define HSCH_TAS_QMAXSDU_CFG(g, r)                                             \
+	__REG(TARGET_HSCH, 0, 1, regs->gaddr[GA_HSCH_TAS_PROFILE_CFG], g,       \
+	      regs->gcnt[GC_HSCH_TAS_PROFILE_CFG],                              \
+	      regs->gsize[GW_HSCH_TAS_PROFILE_CFG], 0, r, 8, 4)
+
+#define HSCH_TAS_QMAXSDU_CFG_QMAXSDU_VAL         GENMASK(7, 0)
+#define HSCH_TAS_QMAXSDU_CFG_QMAXSDU_VAL_SET(x)\
+	FIELD_PREP(HSCH_TAS_QMAXSDU_CFG_QMAXSDU_VAL, x)
+#define HSCH_TAS_QMAXSDU_CFG_QMAXSDU_VAL_GET(x)\
+	FIELD_GET(HSCH_TAS_QMAXSDU_CFG_QMAXSDU_VAL, x)
+
 /* HSCH:TAS_PROFILE_CFG:TAS_PROFILE_CONFIG */
 #define HSCH_TAS_PROFILE_CONFIG(g)                                             \
 	__REG(TARGET_HSCH, 0, 1, regs->gaddr[GA_HSCH_TAS_PROFILE_CFG], g,       \
diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_tas.c b/drivers/net/ethernet/microchip/sparx5/sparx5_tas.c
index ec80bc69371ab..32e502bc4f18f 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_tas.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_tas.c
@@ -29,6 +29,9 @@ enum sparx5_tas_link_speed {
 /* Maximum supported cycle time in nanoseconds */
 #define TAS_MAX_CYCLE_TIME_NS ((1 * NSEC_PER_SEC) - 1) /* 999.999.999 nsec */
 
+/* HSCH_TAS_QMAXSDU_CFG.QMAXSDU_VAL, the guard band, counts 64 byte units */
+#define TAS_QMAXSDU_UNIT 64
+
 /* STARTUP_TIME in units of 256 ns, must be non-zero for a list to start */
 #define TAS_STARTUP_TIME_DEFAULT 8
 
@@ -48,8 +51,8 @@ enum sparx5_tas_link_speed {
  * We use 1 TAS profile per port, shared by both of its lists:
  * index = portno;
  *
- * We do not yet support frame preemption and the default guard band
- * of 1536 bytes is always used on all queues.
+ * We do not yet support frame preemption. All queues of all ports use a
+ * guard band that fits the largest frame that can be forwarded.
  *
  * The gate mask of each entry is written as is to the port's 8 queues,
  * where bit n gates queue (QoS class) n. The mqprio parameters of the
@@ -718,6 +721,40 @@ int sparx5_tas_disable(struct sparx5_port *port)
 	return err;
 }
 
+/* Size the guard band of all ports for a frame of the largest MTU of all
+ * ports, as a port can transmit frames forwarded from any port.
+ */
+void sparx5_tas_gb_update(struct sparx5 *sparx5)
+{
+	u32 max_mtu = 0, gb;
+	int i, tc;
+
+	for (i = 0; i < sparx5->data->consts->n_ports; i++) {
+		if (sparx5->ports[i])
+			max_mtu = max_t(u32, max_mtu,
+					READ_ONCE(sparx5->ports[i]->ndev->mtu));
+	}
+
+	gb = DIV_ROUND_UP(SPX5_HW_MTU(max_mtu) + 2 * VLAN_HLEN,
+			  TAS_QMAXSDU_UNIT);
+
+	mutex_lock(&sparx5->tas_lock);
+
+	/* Each port uses the TAS profile of its own number */
+	for (i = 0; i < sparx5->data->consts->n_ports; i++) {
+		if (!sparx5->ports[i])
+			continue;
+
+		for (tc = 0; tc < SPX5_PRIOS; tc++)
+			spx5_rmw(HSCH_TAS_QMAXSDU_CFG_QMAXSDU_VAL_SET(gb),
+				 HSCH_TAS_QMAXSDU_CFG_QMAXSDU_VAL,
+				 sparx5,
+				 HSCH_TAS_QMAXSDU_CFG(i, tc));
+	}
+
+	mutex_unlock(&sparx5->tas_lock);
+}
+
 int sparx5_tas_init(struct sparx5 *sparx5)
 {
 	const struct sparx5_consts *consts = sparx5->data->consts;
@@ -764,6 +801,8 @@ int sparx5_tas_init(struct sparx5 *sparx5)
 		}
 	}
 
+	sparx5_tas_gb_update(sparx5);
+
 	return 0;
 }
 

-- 
2.34.1

