Received: from us.padl.com (us.padl.com [216.154.215.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 746AC36E493;
	Fri,  3 Jul 2026 07:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.154.215.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783064836; cv=none; b=HDJ7q8R4LwCGWYrJUPFWWrgBBDLmOs9cCO36FSLd1CLv7zPL1N5iIe+dnsrWHjIrEVn0Ds26MxCLHKckm29x/UsCfQcnueVti1a9PqyCYieAv7ECLvAzHA3wwlL/K9L+3FSLBIsrmtv4iXEGHq0jCd+Qy0uSYMTL6mgJDt/w4N4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783064836; c=relaxed/simple;
	bh=UtX+rnVxCFQjBJAeDBA77t0nlZ5Yl2mdZFKHUOYt9bQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Z1trNv7FXj5uTlHendXtOvCxNnoRHHQoqDV2sbVVfrwnZ7A1j2g6MBcSfab88HUmyQH+MW+JqiLWLfZKu/dJllhf0I21T9+RToTWLoah86JN5GH1JteD8y70WDmxzPydRVK6x4J0tJ96N6yD7H67fqTPahSPPLC0zsIwoLukKsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com; spf=pass smtp.mailfrom=padl.com; dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b=QREQeZRm; arc=none smtp.client-ip=216.154.215.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=padl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b="QREQeZRm"
Received: from [127.0.1.1] (border.lukktone.com [139.130.100.52])
	by us.padl.com (Postfix) with ESMTPSA id B7A0960C04;
	Fri,  3 Jul 2026 03:47:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=padl.com; s=default;
	t=1783064834; bh=mKhbLXywwOD2VGYD12Jk5gTk2yEHSOolJGcEBp5BAtE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=QREQeZRmJvKPzPfL7OIa7iQfhlcTdfomaHH8WJBV/1VGgi7B+qjQdn+xGg8XBONKw
	 nADrmxhWlcOCu+rr6jse+QWHydqqlPd2+BhBSq8W0jfPJFQY6Yd1GF/YEvp8e979F4
	 zgcSn74OHEbsi13hCRfEGUpWHWBCLe1jwnlell95ydWcSIJDEnoi1CAZsbIOzmN2h7
	 df6/cBSNj89KGD8Z+3UXLY0SYJz/cN1iLbjIzBGvjrjNGRAwiPpnNsWFlwN+HhNDlx
	 +OpEbUORHNWw2WNS8H/zz9OeawCnG+ojrjZyGWUjaCouSOGNY9avzI+PS8/tP3wA0d
	 l0L1wp6sunVAQ==
From: Luke Howard <lukeh@padl.com>
Date: Fri, 03 Jul 2026 17:46:41 +1000
Subject: [PATCH net-next 07/17] net: dsa: mv88e6xxx: Add
 connect_tag_protocol handler
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260703-net-next-mv88e6xxx-rmu-v1-7-991a27d78bca@padl.com>
References: <20260703-net-next-mv88e6xxx-rmu-v1-0-991a27d78bca@padl.com>
In-Reply-To: <20260703-net-next-mv88e6xxx-rmu-v1-0-991a27d78bca@padl.com>
To: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Russell King <linux@armlinux.org.uk>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Florian Fainelli <f.fainelli@gmail.com>
Cc: Cedric Jehasse <cedric.jehasse@gmail.com>, 
 Max Holtmann <mh@rme-audio.de>, Max Hunter <max@huntershome.org>, 
 Kieran Tyrrell <kieran@sienda.com>, 
 Ryan Wilkins <Ryan.Wilkins@telosalliance.com>, 
 Mattias Forsblad <mattias.forsblad@gmail.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Luke Howard <lukeh@padl.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783064798; l=2891;
 i=lukeh@padl.com; s=20260701; h=from:subject:message-id;
 bh=RQETTvt3i6TyYXYwmalAOn2+jY5l3ulKJa1Vr+1qbmA=;
 b=cRVX46GejgSKmrmdukgWE7AlfYBQ6E9+k7hK2S7kT5yoISikZ76FPp/VooAenYk/oFj9l2E3U
 uWVjI++txY4CdJGPFflXTeLob+5n6EJYWyCxpKY+sWqHWuzOsx5dafa
X-Developer-Key: i=lukeh@padl.com; a=ed25519;
 pk=D6YgUnH9/OzSZsduYm9XDbvXn1IHDwKwI1hLTsKNRLw=

From: Andrew Lunn <andrew@lunn.ch>

When the tagging protocol handler is attached to the DSA driver, it
can validate it is a supported tagging protocol. It can also setup
data shared between the tagger and the switch driver. Ensure a Mavell
DSA tagger is being connected, and setup the handler from RMU in the
shared data. At this point, the handler is just an empty stub, but
later patches will add the needed functionality.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/dsa/mv88e6xxx/chip.c | 18 ++++++++++++++++++
 drivers/net/dsa/mv88e6xxx/rmu.c  |  6 ++++++
 drivers/net/dsa/mv88e6xxx/rmu.h  |  3 +++
 3 files changed, 27 insertions(+)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index 72c93cb84b7e1..fe0d0eb8f0813 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -7183,6 +7183,23 @@ static int mv88e6xxx_crosschip_lag_leave(struct dsa_switch *ds, int sw_index,
 	return err_sync ? : err_pvt;
 }
 
+static int mv88e6xxx_connect_tag_protocol(struct dsa_switch *ds,
+					  enum dsa_tag_protocol proto)
+{
+	struct dsa_tagger_data *tagger_data = ds->tagger_data;
+
+	switch (proto) {
+	case DSA_TAG_PROTO_DSA:
+	case DSA_TAG_PROTO_EDSA:
+		tagger_data->rmu_frame2reg = mv88e6xxx_rmu_frame2reg_handler;
+		break;
+	default:
+		return -EPROTONOSUPPORT;
+	}
+
+	return 0;
+}
+
 static const struct phylink_mac_ops mv88e6xxx_phylink_mac_ops = {
 	.mac_select_pcs		= mv88e6xxx_mac_select_pcs,
 	.mac_prepare		= mv88e6xxx_mac_prepare,
@@ -7255,6 +7272,7 @@ static const struct dsa_switch_ops mv88e6xxx_switch_ops = {
 	.crosschip_lag_join	= mv88e6xxx_crosschip_lag_join,
 	.crosschip_lag_leave	= mv88e6xxx_crosschip_lag_leave,
 	.conduit_state_change	= mv88e6xxx_rmu_conduit_state_change,
+	.connect_tag_protocol	= mv88e6xxx_connect_tag_protocol,
 };
 
 static int mv88e6xxx_register_switch(struct mv88e6xxx_chip *chip)
diff --git a/drivers/net/dsa/mv88e6xxx/rmu.c b/drivers/net/dsa/mv88e6xxx/rmu.c
index 64e93e2eaf550..bae0ca6564f7a 100644
--- a/drivers/net/dsa/mv88e6xxx/rmu.c
+++ b/drivers/net/dsa/mv88e6xxx/rmu.c
@@ -48,3 +48,9 @@ void mv88e6xxx_rmu_conduit_state_change(struct dsa_switch *ds,
 out:
 	mv88e6xxx_reg_unlock(chip);
 }
+
+void mv88e6xxx_rmu_frame2reg_handler(struct dsa_switch *ds,
+				     struct sk_buff *skb,
+				     u8 seqno)
+{
+}
diff --git a/drivers/net/dsa/mv88e6xxx/rmu.h b/drivers/net/dsa/mv88e6xxx/rmu.h
index 71c4fc1d4113f..c60f32480e317 100644
--- a/drivers/net/dsa/mv88e6xxx/rmu.h
+++ b/drivers/net/dsa/mv88e6xxx/rmu.h
@@ -12,4 +12,7 @@
 void mv88e6xxx_rmu_conduit_state_change(struct dsa_switch *ds,
 					const struct net_device *conduit,
 					bool operational);
+void mv88e6xxx_rmu_frame2reg_handler(struct dsa_switch *ds,
+				     struct sk_buff *skb,
+				     u8 seqno);
 #endif /* _MV88E6XXX_RMU_H_ */

-- 
2.43.0

