Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC1982DCBFA
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 12:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790599194; cv=none; b=U+KKuVfQNKJx21zfcMJ1tIksA22KyaV/iLHgmdMyx/Qg054PrYzaozBlSFkkpF0Z6NvPgB7FakZiljXNoXDBa3/DfJ8YzQSPQHV9cUidVBJv/4TQtxShqokGF6XTaVqhzyYncsIlLpMrZKdDoEaBu6FeGfnNrwz/rL1I+KRIkdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790599194; c=relaxed/simple;
	bh=UyAyzavieMdg0lS3gk3bI+okGpB+dx8RpRe0h2EgdXc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a/awtk8GKSfy3D3Pj7wfS6YMzJTg0Z9fYJt240nh09QD6gW+KTt3DqEXFDx5jt12pZzuUZdKeEHegVKCD9ZL27JyuDBCjvVViR4L2gs6Z2uITK/o8CNTLynvTIwJ5KXSbgcW/iVrI1IqmHdfUANKFH3Q5Qu8ybIWxjbBdu7stEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=X6Sea2X8; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lK5GhCHU; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="X6Sea2X8";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lK5GhCHU"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1790599191;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=isdmlxt9+quv1NVZ9LI7vPzqMCT/HxLYck2xupik0HI=;
	b=X6Sea2X84FLXQlXAXTWA7ONTV3KDE659gdUs9J3wc7FpNTOa4QPuGWWBEFHyTa+2ZA8MZs
	u09GzPZaDs5n72Rx4jM5Tq0SvvFWAlaQjc9KnhKyODghiMPLtaE4EacOBq22bL+hK5FZK2
	ZWOt6Mbo478IYUqzN7KgOLVDMQ4MWb2/wLyNFHdHO+3o3Tq8bdbStFpLjgkxc8fHPkf03B
	Ng34ivRCxenMFuIW641FH361VaePs1kWE36P2pvdRFvhckA+wpLYgkx6aTrOHIY1z+ZTnO
	6L8J5UicWkfUF+1kq+7ee09jtoMwVWlGdumZTaNo/z86odG1MCpEIV5siCNWgA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1790599191;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=isdmlxt9+quv1NVZ9LI7vPzqMCT/HxLYck2xupik0HI=;
	b=lK5GhCHUP4kltoLC5CivtYYu2TokypS0CTG7/l4OYBVg8yW4ZNZZtJ0wha3Cmod5W9duvR
	LRJQTJSF7jbYUMCQ==
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
Subject: [PATCH net-next v7 7/8] hsr: Move struct hsr_ethhdr to a global header
Date: Mon, 28 Sep 2026 14:39:41 +0200
Message-ID: <20260928-hsr_ptp-v7-7-d55d304d9a7e@linutronix.de>
In-Reply-To: <20260928-hsr_ptp-v7-0-d55d304d9a7e@linutronix.de>
References: <20260928-hsr_ptp-v7-0-d55d304d9a7e@linutronix.de>
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
index 7b6b60ef592db..0d58559724fc9 100644
--- a/include/linux/if_hsr.h
+++ b/include/linux/if_hsr.h
@@ -39,6 +39,11 @@ struct hsr_tag {
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

