Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794136604;
	b=Lzfvsu6TNrmV2hcw80A/YOPgL/NqA6xH1hEIN/QyClwVr4JU4g83f9/C7QIkZ4+1Wx7r
	 l2Ww4709I9xgHc98ElPvSH4IvuVzzfLfuBBQ76a+q+rDGf3zGOb0sf5DRs5mIt3wnon3w
	 dh/dM+VQDFWlnYEC0ny/VUg3QRDISAiA2JcECAM0roI0jnWR9vRRnjHq4gqxponT03FPN
	 AkyxQ4Hm4lnjHELLFqE3cxRc/sJqgHbY/jYIaD7FAbPKbwqEj0eYNagQ9aMH0G5Z8ePXt
	 cd079JfkClZ4XkeBDzpTuCJr9D60EU++IS0LmGRd/qzCtsnwwdTZUg/Gz+0WF0l8KRA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794136604;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=/SKSEfqQS8Igvwe99KeR8tpkRTehrw2nZcZ5AJN4mk4=;
	b=Y810PJdY6XLy8C9hMuQpHG4eo/iyMibv19e+YkxoZTTsNZicGM+SyDf46feSi0qf6etc
	 S84uUw9bZ6pnLDveyeLIVYKZgJ/vfJ+9dK6VMyJFxBFVGa1flwg8IDL9SbXRRdJqWJ57B
	 5WBFSdGHU+TshsCmsoi9XdrdAcweUJnp+S27VWdayXyJ69ZD1rdlcblX+t1u8Fn8cFt4V
	 kbCmy58uVnwlOkHlQjJGAhrwsJiMKkgySgaxhwUp4jZXcq3PPZEZsLB7lgncADLHlrsQm
	 XpjKL8RosQmt7ItnKreRp1U0r1GWqxGb6AQERDxQ3EH/+gJIrHiHFktiDaNpy5FuJaw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bairaktaris.de;
	spf=pass smtp.mailfrom=bairaktaris.de;
	dkim=pass header.d=bairaktaris.de header.i=@bairaktaris.de header.a=rsa-sha256 header.s=google header.b=geqvbnxP;
	arc=none smtp.remote-ip=209.85.218.50
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24434606A333
	for <netdev@vger.kernel.org>; Sun,  8 Nov 2026 11:16:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 24434606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bairaktaris.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bairaktaris.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bairaktaris.de header.i=@bairaktaris.de header.a=rsa-sha256 header.s=google header.b=geqvbnxP
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c4cdc606b47so6496466b.0
        for <netdev@vger.kernel.org>; Sun, 08 Nov 2026 03:16:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bairaktaris.de; s=google; t=1794136602; x=1794741402; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/SKSEfqQS8Igvwe99KeR8tpkRTehrw2nZcZ5AJN4mk4=;
        b=geqvbnxPs3AidMY6uP0W2MeXX/vqHwXFGhK0I1IEAI/zZJ231XAmcMSwgQzqT5Fbzb
         t/iS3y6m+aKgpK4DmJvOSXHchZVT80MEHslnnFMUm7Lkc/cqBfciygj0HmbZeQuoCKby
         Fdu9V+8s83AmYbCQCXefRxNKJZO7x4a1oHSS73RiomHm9opg27AUs/tUr9SXQE9IOABV
         bY0MHxSH1XQfKjWwmzcQJWi4imNSxs4Iq1e1Fiu+Wxj+OJgkACpClAHKlLI5CieUFG4O
         Zr+860WG//a4HRdbyP059WI111EjV0rFyC49SQ3oal19ZxC90/KL8CALsXhW8gYhCT7x
         iA4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794136602; x=1794741402;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/SKSEfqQS8Igvwe99KeR8tpkRTehrw2nZcZ5AJN4mk4=;
        b=WZXlRygJi0JBygU9iDvaTS4ySiG3ZbU4C5IT14sr4lyp0J7IGjXUdsL4EgSRfmpjvu
         1q7DqnUvrqs/X/taA07wfV4HGWA2i5BaPQ0HXvyF8WvVRjAKRNwPscoCzg+L41zxA/Pc
         myHP8dSlaBdqSHASaqTJfqiM584dSwZijKD7yX64pJF8ZBfeG977zJED2swlFNIttR/s
         niNVWV7lXhKcKt7TUfTaoxivdbd1o8eT8qAghenAeqboze2q3g1d80hGXw7Cq6cA30uG
         0F5zTObHyJAvWndDX6QkreHsCueYv+MVZaE6UZ0cSpCMEVGDAWVYQpJc8WhdRIFo/oYU
         MQXw==
X-Gm-Message-State: APuU4Z/YVuNiDLAWpJ3xG+rq25R8ZtR8X1TwfaGv46vA4ktozjVVkC6H
	MfkPc+3koAQltbOE11bkP9dE9e/xmoYWsa9yQAxdj/rJuz6DDJeGUlPXIvFHtMY8AQ==
X-Gm-Gg: AYBFou3ppw/Ttflfjf6x7PnE9Efk8Vre+mSzyZ1AU3bnE65APs0SeFpCDbI2GRRhjJZ
	cZfjY11NWwYu5rtcH9ek5AhisUF1je28Bu+DeWkuQ+Wvs5g+E9PY8QW/mh9rvUy9tJ+3e0JFopW
	CFTe4nfRJwwlMl060/xqtiR5s40tcZ9+vOd/Qicpt5RvSrim0oEXNx23twJkbuOHdcqhFVYmy5i
	oJ/YntvUM8JzQGDPahKluFJrhFXN2n4Fn1pVbzhdvf2EyEz4xqYjVKuO8kxA4aVVrTFYXODNzSD
	Vy62ciYGwoqs4kVlAgAAupzF5hyJ8bpHlczbWDmNm8tJtnXozna5wO3fRGx4tqC8j02LDwuSeqO
	Y8KW8NKMO/gIAwQTXHFDHoBp3v3UP979oCcOhr9Al6gJXaIauIKraNKPQwJeCrF5J14G8cvFwVM
	TXm3oc0rMgdOjySVLgO4qdbmRgKo3bMmp6yDXu0vgVOWbkGEN+9yZ2caCxMZsoFNT1j7D5ucGie
	g7Ozk1MrrxTOtlkCj25uDaUI83nCr/jyX0H7iuQvvRC43j7OtugLx+QqF0KByG9JDSq5KSZLsSf
	On2C8+7+Q1+UGnpcB9iboFurKQajUG2uBXeQZWKnvKGJqMETEvO+a/rvibI0r96VVcWiXMtWFmt
	8N/miPN65SjAGocJd8WU88XnDCaQ01Tv7WLjH+GiZ2LxhKiIhD8BawqkAStFntq8+WyG55BQSbQ
	dgzrzX2us9T3wn+Ujx/fMP7FGflZaOeRRp5ER/nCB6O6+gHZOeaCy1tShBbyfcLAOnoLGt1Ti1+
	/dutZCVJoRExEzWsVgEeL3govLRdMb4KRTv2xLPVp7BeD5Jk14n99Ab5J3nA7w61z31QtpUM+Qb
	cjS4KojkXKQQjuv4bA==
X-Received: by 2002:a17:906:7953:b0:c3e:34fa:611d with SMTP id a640c23a62f3a-c4d6db15eecmr83366466b.35.1794136602388;
        Sun, 08 Nov 2026 03:16:42 -0800 (PST)
Received: from Desktop (p54afff19.dip0.t-ipconnect.de. [84.175.255.25])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4d6a99320bsm54261166b.67.2026.11.08.03.16.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 03:16:41 -0800 (PST)
From: Julius Bairaktaris <julius@bairaktaris.de>
To: Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>
Cc: netdev@vger.kernel.org,
	bridge@lists.linux.dev,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 1/2] net: bridge: switchdev: add br_switchdev_fdb_find_port()
Date: Sun,  8 Nov 2026 12:16:38 +0100
Message-ID: <92a9adba8020449a269bb8941698ea6849b4c372.1794134495.git.julius@bairaktaris.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1794134495.git.julius@bairaktaris.de>
References: <cover.1794134495.git.julius@bairaktaris.de>
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

Add an RCU lookup that returns the port of a non-local FDB entry that
switchdev is notified of: not locked, not added by the user as a
dynamic entry, and not learned by a switchdev driver.

A switchdev driver that handles FDB events from a workqueue cannot take
RTNL for br_fdb_find_port(), and has to ignore the entries whose
deletion it will not be notified of. The filter of
br_switchdev_fdb_notify() moves into a helper that both use, with no
functional change; the learning path does not change.

Signed-off-by: Julius Bairaktaris <julius@bairaktaris.de>
---
 include/linux/if_bridge.h | 13 ++++++++
 net/bridge/br_switchdev.c | 63 +++++++++++++++++++++++++++++++++------
 2 files changed, 67 insertions(+), 9 deletions(-)

diff --git a/include/linux/if_bridge.h b/include/linux/if_bridge.h
index 75673b8bffcb8..e050b7e698fc9 100644
--- a/include/linux/if_bridge.h
+++ b/include/linux/if_bridge.h
@@ -201,6 +201,19 @@ static inline int br_mst_get_state(const struct net_device *dev, u16 msti,
 }
 #endif
 
+#if IS_ENABLED(CONFIG_BRIDGE) && IS_ENABLED(CONFIG_NET_SWITCHDEV)
+struct net_device *br_switchdev_fdb_find_port(const struct net_device *br_dev,
+					      const unsigned char *addr,
+					      u16 vid);
+#else
+static inline struct net_device *
+br_switchdev_fdb_find_port(const struct net_device *br_dev,
+			   const unsigned char *addr, u16 vid)
+{
+	return NULL;
+}
+#endif
+
 #if IS_ENABLED(CONFIG_BRIDGE)
 struct net_device *br_fdb_find_port(const struct net_device *br_dev,
 				    const unsigned char *addr,
diff --git a/net/bridge/br_switchdev.c b/net/bridge/br_switchdev.c
index 10f3aea6a1f82..02ca1cbcfede0 100644
--- a/net/bridge/br_switchdev.c
+++ b/net/bridge/br_switchdev.c
@@ -141,14 +141,10 @@ static void br_switchdev_fdb_populate(struct net_bridge *br,
 	item->info.ctx = ctx;
 }
 
-void
-br_switchdev_fdb_notify(struct net_bridge *br,
-			const struct net_bridge_fdb_entry *fdb, int type)
+static bool br_switchdev_fdb_notifies(const struct net_bridge_fdb_entry *fdb)
 {
-	struct switchdev_notifier_fdb_info item;
-
 	if (test_bit(BR_FDB_LOCKED, &fdb->flags))
-		return;
+		return false;
 
 	/* Entries with these flags were created using ndm_state == NUD_REACHABLE,
 	 * ndm_flags == NTF_MASTER( | NTF_STICKY), ext_flags == 0 by something
@@ -156,9 +152,58 @@ br_switchdev_fdb_notify(struct net_bridge *br,
 	 * Drivers don't know how to deal with these, so don't notify them to
 	 * avoid confusing them.
 	 */
-	if (test_bit(BR_FDB_ADDED_BY_USER, &fdb->flags) &&
-	    !test_bit(BR_FDB_STATIC, &fdb->flags) &&
-	    !test_bit(BR_FDB_ADDED_BY_EXT_LEARN, &fdb->flags))
+	return !test_bit(BR_FDB_ADDED_BY_USER, &fdb->flags) ||
+	       test_bit(BR_FDB_STATIC, &fdb->flags) ||
+	       test_bit(BR_FDB_ADDED_BY_EXT_LEARN, &fdb->flags);
+}
+
+/**
+ * br_switchdev_fdb_find_port - find the port of an entry switchdev knows of
+ * @br_dev: the bridge device
+ * @addr: the MAC address of the entry
+ * @vid: the VLAN of the entry
+ *
+ * Must be called under RCU; the device is valid until the read-side critical
+ * section ends.
+ *
+ * Return: the port of the non-local entry for @addr and @vid, or NULL if
+ * there is none or switchdev is not notified of it.
+ */
+struct net_device *br_switchdev_fdb_find_port(const struct net_device *br_dev,
+					      const unsigned char *addr,
+					      u16 vid)
+{
+	const struct net_bridge_port *p;
+	struct net_bridge_fdb_entry *f;
+
+	RCU_LOCKDEP_WARN(!rcu_read_lock_held(), "suspicious use outside RCU");
+
+	if (!netif_is_bridge_master(br_dev))
+		return NULL;
+
+	f = br_fdb_find_rcu(netdev_priv(br_dev), addr, vid);
+	if (!f || test_bit(BR_FDB_LOCAL, &f->flags) ||
+	    !br_switchdev_fdb_notifies(f))
+		return NULL;
+
+	/* learned by a switchdev driver, which is not notified back */
+	if (test_bit(BR_FDB_ADDED_BY_EXT_LEARN, &f->flags) &&
+	    !test_bit(BR_FDB_ADDED_BY_USER, &f->flags))
+		return NULL;
+
+	p = br_fdb_dst_port(f);
+
+	return p ? p->dev : NULL;
+}
+EXPORT_SYMBOL_GPL(br_switchdev_fdb_find_port);
+
+void
+br_switchdev_fdb_notify(struct net_bridge *br,
+			const struct net_bridge_fdb_entry *fdb, int type)
+{
+	struct switchdev_notifier_fdb_info item;
+
+	if (!br_switchdev_fdb_notifies(fdb))
 		return;
 
 	br_switchdev_fdb_populate(br, &item, fdb, NULL);
-- 
2.53.0

