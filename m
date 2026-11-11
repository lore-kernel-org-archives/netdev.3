Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=23.88.38.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794392861;
	b=YyDOZ9zez9swtVqhh12NB8qkrSDAKeUb3anN3V+7lulnJuyXZ34rW/Ct/Zj2+aPdCatz
	 xsdVD+wG1Cl4J0ZfowtYh4TznjCvkhAxC5dKItoIkHkxYfh/FikjkGtpMQSLm6H7AJNAP
	 8HTURupa0B8NIye1hLCHlC9DOsqjABmPW1pam7DuDad4c/q3SbIuS7ID+CTjOGOH4SL3P
	 9iradcK68lHscRl/8r2bN6l0t4aRuBjoCsRAsZXLSq9C6bP/yY2yfBEA4BkP2nsPRIlgu
	 Zy7eIKXsVArzuOObu18V0Wv4BB5MNA2FwGI+m/mSxE1tgyizUlBmolTo3Sv3DyD/7tw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794392861;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=i3zqzKOviMB/7i3MMVHu6vwKrbi96jH7wX2hwfL9yZs=;
	b=Iyrs8oHMMg5xE939X0327EV8H8T8YTxl8oBV1+yHZzVzsuwq5rVZK0ZpqRh4ksmImnMK
	 RpukVgxdt4AOoZvTwT2WMbYp1VYi2Rbxhn5EvE0UryOO0yNMSf1Eu46qDMyS9wWGvLjgI
	 qKNBHiWs5gHtmHQLcG4PGVtVlS+8EhnwykX87+IJPvLaASqtdVaKQK63IFXQl1SKeCV0h
	 q7m/N0cT6leQVwhnFhdt2l6eLDJxcsIxRdbCk1c3uPmNKS8nuWPSd9xrdnIsA3Gl6XrBB
	 lwC5pugaY8uLx2nr6Boi2dajcpaPaXdhsuHxpgJSneT095/7OnnnUrsRa5+/rX9xesw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=simonwunderlich.de;
	spf=pass smtp.mailfrom=simonwunderlich.de;
	dkim=pass header.d=simonwunderlich.de header.i=@simonwunderlich.de header.a=rsa-sha256 header.s=09092022 header.b=ketxwRrp;
	arc=none smtp.remote-ip=23.88.38.48
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 538D6606A883
	for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 10:27:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 538D6606A883
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.a=rsa-sha256 header.s=09092022 header.b=ketxwRrp
Received: from kero.packetmixer.de (p200300c59740DeD843BE7E4A980e9C65.dip0.t-ipconnect.de [IPv6:2003:c5:9740:ded8:43be:7e4a:980e:9c65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with UTF8SMTPSA id F21CBFA1BF;
	Wed, 11 Nov 2026 11:27:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1794392856;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i3zqzKOviMB/7i3MMVHu6vwKrbi96jH7wX2hwfL9yZs=;
	b=ketxwRrpYj6dSTh62/2AwYyFHwCu+GS0t11cfu1psnbF3zyXjQ4YOf+ZpEF0OgFdCPEsN1
	26Bv9IkBo9EVXgeYtd+bfM8mmHwvSUB6OplPpQpe98MnpfLDrnjZlWQWWFoq/XS2knsrcK
	ZeAHCW5bQtvNn5KFomqMB/Uxrd4dQtwOiAKk0Ozm6MgO5ObbFVq4abYvDE2JCW3dyEBKv3
	igrzzyZZVrcTj0OGijtVAdrPJoPas+6Lr7Yj22tT7qEgqfJcvKXLnOPGqzY+djxyhv2uW0
	yPT4mXLZAKzVSo8SRah8WsYDkgYds8tXdxu9O+1qb2zuyGAy105ijhNfBq7q8g==
From: Simon Wunderlich <sw@simonwunderlich.de>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	b.a.t.m.a.n@lists.open-mesh.org,
	Sven Eckelmann <sven@narfation.org>,
	Sashiko <sashiko-bot@kernel.org>,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH net-next 06/15] batman-adv: dat: annotate last_update with READ/WRITE_ONCE
Date: Wed, 11 Nov 2026 11:27:20 +0100
Message-ID: <20261111102729.2096241-7-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261111102729.2096241-1-sw@simonwunderlich.de>
References: <20261111102729.2096241-1-sw@simonwunderlich.de>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sven Eckelmann <sven@narfation.org>

The last_update field for batadv_dat_entry tracks the jiffies value of
the most recent activity and is used to detect timeouts. These accesses are
not consistently protected by a lock, so READ_ONCE/WRITE_ONCE must be used
to prevent data races caused by compiler optimizations.

To avoid an underflow due to an non-strict order read of jiffies vs
last_update, use jiffies_delta_to_msecs instead of jiffies_to_msecs to
evaluate the delta.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/bug/linux-4933a0a0-367e-43b3-8da5-29ae37dfdff3
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/distributed-arp-table.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/net/batman-adv/distributed-arp-table.c b/net/batman-adv/distributed-arp-table.c
index 0260ed7e828b2..7e82c154c13f8 100644
--- a/net/batman-adv/distributed-arp-table.c
+++ b/net/batman-adv/distributed-arp-table.c
@@ -11,6 +11,7 @@
 #include <linux/bitops.h>
 #include <linux/bug.h>
 #include <linux/byteorder/generic.h>
+#include <linux/compiler.h>
 #include <linux/container_of.h>
 #include <linux/err.h>
 #include <linux/errno.h>
@@ -206,7 +207,7 @@ static void batadv_dat_entry_put(struct batadv_dat_entry *dat_entry)
  */
 static bool batadv_dat_to_purge(struct batadv_dat_entry *dat_entry)
 {
-	return batadv_has_timed_out(dat_entry->last_update,
+	return batadv_has_timed_out(READ_ONCE(dat_entry->last_update),
 				    BATADV_DAT_ENTRY_TIMEOUT);
 }
 
@@ -453,7 +454,7 @@ static void batadv_dat_entry_add(struct batadv_priv *bat_priv, __be32 ip,
 	if (dat_entry) {
 		atomic64_set(&dat_entry->mac_addr, u64_mac);
 
-		dat_entry->last_update = jiffies;
+		WRITE_ONCE(dat_entry->last_update, jiffies);
 		batadv_dbg(BATADV_DBG_DAT, bat_priv,
 			   "Entry updated: %pI4 %pM (vid: %d)\n",
 			   &dat_entry->ip, mac_addr,
@@ -468,7 +469,7 @@ static void batadv_dat_entry_add(struct batadv_priv *bat_priv, __be32 ip,
 	dat_entry->ip = ip;
 	dat_entry->vid = vid;
 	atomic64_set(&dat_entry->mac_addr, u64_mac);
-	dat_entry->last_update = jiffies;
+	WRITE_ONCE(dat_entry->last_update, jiffies);
 	kref_init(&dat_entry->refcount);
 
 	kref_get(&dat_entry->refcount);
@@ -940,6 +941,7 @@ batadv_dat_cache_dump_entry(struct sk_buff *msg, u32 portid,
 			    struct batadv_dat_entry *dat_entry)
 {
 	u8 mac[ETH_ALEN] __aligned(2);
+	unsigned long last_update;
 	u64 u64_mac;
 	int msecs;
 	void *hdr;
@@ -952,7 +954,8 @@ batadv_dat_cache_dump_entry(struct sk_buff *msg, u32 portid,
 
 	genl_dump_check_consistent(cb, hdr);
 
-	msecs = jiffies_to_msecs(jiffies - dat_entry->last_update);
+	last_update = READ_ONCE(dat_entry->last_update);
+	msecs = jiffies_delta_to_msecs(jiffies - last_update);
 	u64_mac = atomic64_read(&dat_entry->mac_addr);
 	u64_to_ether_addr(u64_mac, mac);
 
-- 
2.47.3

