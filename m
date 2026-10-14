Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B00254DAC4
	for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 14:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791989064; cv=none; b=F4WqEe3LXcSad0nxuzo0YUqFHzFmQd2P8n/4n1GtPQYcQRluN7SYO7z0Ke+xgTBKuBnXHE/64sWGgMfX8i8uf0K0dr8cawNsyYg7xrwaQB5PDhdauO1FmE/X8CbQ23N6gshMo8gPU25CBcoOZO7LvZOZwQ3t6PAgZymeXuEd1BE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791989064; c=relaxed/simple;
	bh=xeHpX0Li+qHXSKmyMhrnyX4YOBZg1CRaj4sU526PBk0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YZqKZFqxwgEebiHhMc0zTKwl0OF0H2/zhaaP0mAwdVCgiBlFx392IEIZUdyA2PrW2rhAPMB+uKV3dGOb7w502RLdz2jfUPXqua8hm1luwzpaF1KoWevdoK0JZaTaPfPHC5O7OhHEHDAVqpS5Rmz27WYjm+IosWuWWxTXCOy33is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4n3ez8SH; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0sndJWbB; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4n3ez8SH";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0sndJWbB"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1791989049;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8SfjCTNulstCnb+ATnynlMKFxq4zbs90a8gq/kFcWDs=;
	b=4n3ez8SHxvi/UEfwEBXrBvn7Hrs183/azUIW/pkuaxftKMtyewgkXZijPROX5+EidDvTIF
	lqhrrRBDOC5VBR4k4qTc4afi7dtPoOHhXoRbpFeUMKekYtho6ogTmmvACxUc1D3gVi0L6/
	7rPxKbztN2zZiC44UAGIq0FVvVCELAZf3S1xdk2la6O/yweUK55WAfraspeMSGxN09PdiN
	sV9oeC7l1zn+qBpmjGTaL7B60jaub+SOGRn1JOPzq4yAPPzhjmRXtUj+lUyqvt9sH0HA1O
	1MH3p9Qj4185VhRTbj6/XjqRmh6RvsufsiwzQq49ZeV5c6bqEd3neKgieBsHVQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1791989049;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8SfjCTNulstCnb+ATnynlMKFxq4zbs90a8gq/kFcWDs=;
	b=0sndJWbBdzeYsYCU54nrAtxEVWA4wkYkMVrBVWLE0aON+gUUdLwIYkAaYWOzf7r9RL+OU0
	7ufiYqUzEzISvVDA==
To: netdev@vger.kernel.org
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	"(JC), Jayachandran" <j-rameshbabu@ti.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Chintan Vankar <c-vankar@ti.com>,
	Danish Anwar <danishanwar@ti.com>,
	Daolin Qiu <d-qiu@ti.com>,
	"David S. Miller" <davem@davemloft.net>,
	Felix Maurer <fmaurer@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Neelima Muralidharan <neelima@ti.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Praneeth Bajjuri <praneeth@ti.com>,
	Pratheesh Gangadhar TK <pratheesh@ti.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Daniel Machon <daniel.machon@microchip.com>,
	Eric Dumazet <edumazet@kernel.org>
Subject: [PATCH net-next v9 7/8] hsr: Move struct hsr_ethhdr to a global header
Date: Wed, 14 Oct 2026 16:44:01 +0200
Message-ID: <20261014-hsr_ptp-v9-7-2d20a2a0f816@linutronix.de>
In-Reply-To: <20261014-hsr_ptp-v9-0-2d20a2a0f816@linutronix.de>
References: <20261014-hsr_ptp-v9-0-2d20a2a0f816@linutronix.de>
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

