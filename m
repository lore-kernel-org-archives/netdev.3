Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FB3A4A7C81
	for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 12:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790165672; cv=none; b=EA1w/Vq4QTwLdB6xTkb5HGlfZoDLsDROY5yuexQN4Nb6z+2hMVpKcW0v8IDlUcYBzYZVupfalqRhQ4qXKpYzaXdI1Od3cKBs05zL2407SjIfMIB2xuYHCO7LXIWu3bnVzkRP/LVyVj5zoQZHIRXQ48hj6ETQhpe+udXoYUbaE3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790165672; c=relaxed/simple;
	bh=HLr9T1JxEdTtNQ5qsMkuSpKIU9b1S7MVYY0kqmPxQ3E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dHvZowtC5BhxtadKFuUB6vhauEOsMP0NcaR/xjkWWh3H1SUQJ1g9E+HAErISvRrxewWfN0sF74DIxsEi3AoywgaShiyaBs2kYBq9fisybURb0bfwfyDAvZZHKDjWP4/LftTVVQRW7P+LV7ryzKhqbvFyP0hR3MqdomuSV7mE+Is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yeOFF0rr; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=b2Ebc0va; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yeOFF0rr";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="b2Ebc0va"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1790165662;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QyUPtFTlDRhYbAd4ru2kxcx9JJGVvw5NAuAKtl15ZpA=;
	b=yeOFF0rrrKLLkTSrA4OzlW/YU80BG5g8fjsiWqXCYyJb5QkZ30CybSQAm838biIXL/3NYS
	H+EfHYcuF30OzxI6eWytqLIYZmuOT5xCckBZ3SWnVGfgFbXZ2TzTb2o5a1GGbkHRRvQF3t
	LaMIY+Ptf1oSWldeeMipsl2a609uXUbVHqQyIho48kfzqeJOi7gkFnd1IAz+qkzTiT03YZ
	tgdnBHtHmFUE+WQleO+t/09gZ2jBgaUzzy1hvm6VEvX7QKwXOzmb5D04gnBeMXJ5aR6NuW
	qk+oh/BYMdteWWsQ9bu/DPhPofFZLvaXS0BmW3FzQL9pDV7x3Etvsz75ErJXaA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1790165662;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QyUPtFTlDRhYbAd4ru2kxcx9JJGVvw5NAuAKtl15ZpA=;
	b=b2Ebc0vayhwXNmFh9T8Oy2ogB7VH9mb/xb/KuECIsvT3+iE62C/eyqR9MfkEFq233n7E4k
	Y4IToUdt3ARt++CA==
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
Subject: [PATCH net-next v6 7/8] hsr: Move struct hsr_ethhdr to a global header
Date: Wed, 23 Sep 2026 14:14:08 +0200
Message-ID: <20260923-hsr_ptp-v6-7-6ea07b3fb8a8@linutronix.de>
In-Reply-To: <20260923-hsr_ptp-v6-0-6ea07b3fb8a8@linutronix.de>
References: <20260923-hsr_ptp-v6-0-6ea07b3fb8a8@linutronix.de>
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
 include/linux/if_hsr.h | 5 +++++
 net/hsr/hsr_main.h     | 5 -----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/linux/if_hsr.h b/include/linux/if_hsr.h
index 1db1bd0fa181d..bdcfe88e023fc 100644
--- a/include/linux/if_hsr.h
+++ b/include/linux/if_hsr.h
@@ -49,6 +49,11 @@ struct hsr_tag {
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

