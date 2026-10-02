Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 353BA489886
	for <netdev@vger.kernel.org>; Fri,  2 Oct 2026 13:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790946088; cv=none; b=oGiJk6pKYIAQAEvrwdu6TvOxjIp/c4wYPMb34Y6CpncAl2Mw112LmtzU+PqPEymmMIKbu4S/yYyv47PsCysmpJ+DKwYhwuwNQXwO0nk9kFZFB/lCT245Xulm4fg8ayNdyua6sltwUwPNbDVeOzsuOrV35ysH8l95I7aD1Q0rh60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790946088; c=relaxed/simple;
	bh=xeHpX0Li+qHXSKmyMhrnyX4YOBZg1CRaj4sU526PBk0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Cf1Sc+ffHjFzpw6OGHouwKEjItF56udUi/7zaW+k11bBJrYaumCMN/tnmi7YlETMlqqV6h6yDEC3xNqKuw///M5e6XhePt7gc0z9GYW951DvYL/MQBENtVJZpPy6+aR86LfWTXvCCw5hQ/IbRjznipszWyLW2vrMJ6ZXanDwo04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uX3ialHX; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=5MUMkBt7; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uX3ialHX";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="5MUMkBt7"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1790946082;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8SfjCTNulstCnb+ATnynlMKFxq4zbs90a8gq/kFcWDs=;
	b=uX3ialHXlnamAcdIpBvK8QnP+4UpjRKf23cJgk7/TIqFQfCRLGMkVf0VGBOKZBj6G6J2Fr
	gp7nCRxyARTcjV+8qXVcFEvfj4hMjqkRPCCbJV4BE3QuvNFJDRnpKF4lGOsNcJ7W6kW6yS
	Spb5EMYiammT9mDl4LI8tEnCBgP5KVvFG3lTMMmA2OpJnWQyw76xhkmx71xDGygH29Rn2P
	eT4AosgRokkS3Rr5UfUvTn8EFs0yhtHWbWpxqv9CaQH9U43lyb2kn4E4pwJ4UyP/z7nglL
	FCcQEktRDr7VtS4REl83SXcG5Erf5fUGOb5AociVOFR2SkyPDwVgOxPdNsOB/w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1790946082;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8SfjCTNulstCnb+ATnynlMKFxq4zbs90a8gq/kFcWDs=;
	b=5MUMkBt7oQktgjeMDqBGKEqdsyYdZyOqQgm+X25pBMvM+sJOxGObHn79WVapqnTiwMEMqf
	t/WhrcyNzvNKtiCA==
To: netdev@vger.kernel.org
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	"(JC), Jayachandran" <j-rameshbabu@ti.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Chintan Vankar <c-vankar@ti.com>,
	Danish Anwar <danishanwar@ti.com>,
	Daolin Qiu <d-qiu@ti.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Felix Maurer <fmaurer@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Neelima Muralidharan <neelima@ti.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Praneeth Bajjuri <praneeth@ti.com>,
	Pratheesh Gangadhar TK <pratheesh@ti.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Subject: [PATCH net-next v8 7/8] hsr: Move struct hsr_ethhdr to a global header
Date: Fri,  2 Oct 2026 15:01:13 +0200
Message-ID: <20261002-hsr_ptp-v8-7-60dabc07e554@linutronix.de>
In-Reply-To: <20261002-hsr_ptp-v8-0-60dabc07e554@linutronix.de>
References: <20261002-hsr_ptp-v8-0-60dabc07e554@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

In the offloading case the network driver needs to inspect the HSR
header to find out if the encapsulated type is a PTP packet where it
needs suppress offloading of the packet.

Move the header so it can be included the driver.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 include/linux/if_hsr.h | 6 ++++++
 net/hsr/hsr_main.h     | 5 -----
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/include/linux/if_hsr.h b/include/linux/if_hsr.h
index 7b6b60ef592db..f81323f10eecc 100644
--- a/include/linux/if_hsr.h
+++ b/include/linux/if_hsr.h
@@ -3,6 +3,7 @@
 #define _LINUX_IF_HSR_H_
=20
 #include <linux/types.h>
+#include <linux/if_ether.h>
 #include <uapi/linux/hsr_ptp.h>
=20
 struct net_device;
@@ -39,6 +40,11 @@ struct hsr_tag {
=20
 #define HSR_HLEN	6
=20
+struct hsr_ethhdr {
+	struct ethhdr	ethhdr;
+	struct hsr_tag	hsr_tag;
+} __packed;
+
 #if IS_ENABLED(CONFIG_HSR)
 extern bool is_hsr_master(struct net_device *dev);
 extern int hsr_get_version(struct net_device *dev, enum hsr_version *ver);
diff --git a/net/hsr/hsr_main.h b/net/hsr/hsr_main.h
index 53e95bae0ee27..36eb82774000c 100644
--- a/net/hsr/hsr_main.h
+++ b/net/hsr/hsr_main.h
@@ -72,11 +72,6 @@ static inline void set_hsr_tag_LSDU_size(struct hsr_tag =
*ht, u16 LSDU_size)
 				       0xF000) | (LSDU_size & 0x0FFF));
 }
=20
-struct hsr_ethhdr {
-	struct ethhdr	ethhdr;
-	struct hsr_tag	hsr_tag;
-} __packed;
-
 struct hsr_vlan_ethhdr {
 	struct vlan_ethhdr vlanhdr;
 	struct hsr_tag	hsr_tag;

--=20
2.55.0

