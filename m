Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7AC54508F8
	for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 07:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790752523; cv=none; b=l7932H6ltju8VE3cOcrzL1mYkz7eY5PdMZErdIy0AlxfAPBIQb9kRAiXCcuOES6AYqf9pPNv9IJ+40qUcm765o+6tf8pRMaTZSzPa5y+ini+BObDkEbdpigN58J+iKjo4GHBpS8kWZV0ChcH54Et7lnald2JORDgFpRoekuLO/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790752523; c=relaxed/simple;
	bh=xxXEeXkvcEwxnUeZhrJu2dzaEWIRjp8xQ89BUbavJfg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e3fhwmWNSlycPaWvH1MxtVivq0A62jrot9k0cTmgdwTe6Fxn0cJL9h/Jd+f0TzDt21V/TMTg9TYWKfpC/fnJo5VkHnuluCLN/d4wdB3ZcSym4vhQp7JueqH6AQFfMAI1Bm4xFqLBzQ9J/ApT8I8wHYwO90t8oZNP7jGW5BJoQls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=Pc/K7xlf; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="Pc/K7xlf"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49e8185e037so28275505e9.3
        for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 00:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1790752514; x=1791357314; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=w/O5QqqONnfye5Y1P+NsqZXcnQbGQUU705R8ScoL53A=;
        b=Pc/K7xlfUxRuVb1i40+WivBlzEwakxM/8U7xaao/3BYZc+587O1UPsEheiNZT9ZW/z
         Et6U/zrY39M8ITmnu0smRVHRtmaO9CSLBQZEDlQfS9lkfSrXoA0BQ+ToUiGztcW1GlOR
         eK91jeGgoCvc++gndi2bzr8Zi4RSHlrzicZ/yy5dRrhSKApNtRhTnRKvWHLrLTzTo/+G
         5slBKIRhioOgtSS3cAuEHuGg3v0oqPPmXW/xYR9z+dqpBoe33v1X2rnuvZwkDuMcyUbC
         8OYPuMoX9uo3ezj2+a5oWADsVc3gMIJMCr9LNLEcitrPoIcT5ETUFjncgE5Cv9SI808I
         W9NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790752514; x=1791357314;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=w/O5QqqONnfye5Y1P+NsqZXcnQbGQUU705R8ScoL53A=;
        b=UzebZzz6S5JASqSXSLKubq/NFCGhryZJcI1LwhCTsuvd5ztPzoXyswtcyZQuebHT6P
         pqSRpQAI6OS1kUO+0iFhS3rGotuKE+1AIBfJuXAH6Y9ts5EWRbh0uIYi6ihxaoaf43kI
         niE7TNbPOd6gXuJs12POPjQ19tnrQ/fghMUmNcwHLXHxMd41lQ2kgoaUQcldN1xkU+Ti
         Tt4q8wO3DCA3nKbwKYGzrt6IEfVWFfQpRk0z4ocbqUt06AKUNsB8fIWNlIMwBj6EOdAW
         jX8AdG6z/aGhS2ZL17tm3d/HsiM1CEWYNATkCc0ID4GQmkfogKuAgMivujQcwS5RRrlh
         pnZw==
X-Gm-Message-State: AFuF++ktf4T/7iA0XPNBX0btmm83h1HoeD8P7aFsWsRDlLRDIsimQdI8
	qSv19LoZnVh+RUGQArI+x6Xc3ky4QEC5M8yq29pooDUVCR1dJuPsrZKoSpr6c0TxfUnuDvUewOm
	x1wOy
X-Gm-Gg: AYBFou1QpK3ZRC4Ufum6E3xLrKVt2U+1p71eO8QBfh33FxgpfcDoBIeJ9lINekXpTVC
	vz+LuEmjHpueNmD5N3ow7Bk7qjRUqQkD43R8Wb+MIZtL4NeH7d7XVL6ZJ3l4Hb3gNnUNvzerk41
	gQXYGUO+oaASh/vK6wjLwZbBdLsh9BsNhoq9hcDDVADQYAAL1LWy2tn33wxeYNGCUh1ceyGi+io
	MUBZA7txRCtQAGth2iFq+kaw8Uh2sfZB5+OcrZpflDJE5yaZ2/d1bJu9GkW+N89IpKRCC/9Rc/d
	o+JFo80GRYKwgcb29Bg6qybD6oDJVjpRQVux2X3IZWumR2T5pVl/0CvFhcrGeQFHaKiyEHs1N41
	nKR9Sh2v/y130WvFmQr0dr/zYEtMTt5aAaQZ37gN33Vkji5hoOfAZjXwOX/hNb6Oy5nwMFhCnIW
	MeU1+L6t8IpBILZ92odqGqZb2yJk7hUCJ5G3pjoaSW/OUParSkKU+bFf+07jLuq9tOgbkiJIK5k
	6On5qftf4/bX0zOuMHg
X-Received: by 2002:a05:600d:82e7:b0:49f:c199:e1e2 with SMTP id 5b1f17b1804b1-4a01b0190cemr7814595e9.28.1790752513516;
        Wed, 30 Sep 2026 00:15:13 -0700 (PDT)
Received: from localhost (78-154-14-127.ip.btc-net.bg. [78.154.14.127])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4a0175208e0sm29645355e9.7.2026.09.30.00.15.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 00:15:13 -0700 (PDT)
From: Nikolay Aleksandrov <razor@blackwall.org>
To: netdev@vger.kernel.org
Cc: idosch@nvidia.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	bridge@lists.linux.dev,
	Nikolay Aleksandrov <razor@blackwall.org>
Subject: [PATCH net-next 10/12] net: bridge: fdb: cache port VLANs in learned entries
Date: Wed, 30 Sep 2026 10:14:09 +0300
Message-ID: <20260930071411.2786201-11-razor@blackwall.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260930071411.2786201-1-razor@blackwall.org>
References: <20260930071411.2786201-1-razor@blackwall.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Store the resolved port-VLAN as the destination of dynamically learned FDB
entries. Roaming updates the destination directly, while an existing raw
port destination is conditionally upgraded without generating a spurious
notification. Conditional replacements prevent both this upgrade and a VLAN
deletion fallback from overwriting a concurrent roam.

Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: Nikolay Aleksandrov <razor@blackwall.org>
---
 net/bridge/br_fdb.c     | 57 ++++++++++++++++++++++++++---------------
 net/bridge/br_private.h | 18 +++++++++++++
 2 files changed, 55 insertions(+), 20 deletions(-)

diff --git a/net/bridge/br_fdb.c b/net/bridge/br_fdb.c
index b87c6f8875da..5664f3d649fa 100644
--- a/net/bridge/br_fdb.c
+++ b/net/bridge/br_fdb.c
@@ -385,7 +385,7 @@ void br_fdb_find_delete_local(struct net_bridge *br,
 }
 
 static struct net_bridge_fdb_entry *fdb_create(struct net_bridge *br,
-					       struct net_bridge_port *source,
+					       struct net_bridge_dst dst,
 					       const unsigned char *addr,
 					       __u16 vid,
 					       unsigned long flags)
@@ -409,7 +409,7 @@ static struct net_bridge_fdb_entry *fdb_create(struct net_bridge *br,
 		return NULL;
 
 	memcpy(fdb->key.addr.addr, addr, ETH_ALEN);
-	br_fdb_dst_write(fdb, br_port_to_dst(source));
+	br_fdb_dst_write(fdb, dst);
 	fdb->key.vlan_id = vid;
 	fdb->flags = flags;
 	fdb->updated = fdb->used = jiffies;
@@ -448,7 +448,7 @@ static int fdb_add_local(struct net_bridge *br, struct net_bridge_port *source,
 		fdb_delete(br, fdb, true);
 	}
 
-	fdb = fdb_create(br, source, addr, vid,
+	fdb = fdb_create(br, br_port_to_dst(source), addr, vid,
 			 BIT(BR_FDB_LOCAL) | BIT(BR_FDB_STATIC));
 	if (!fdb)
 		return -ENOMEM;
@@ -907,8 +907,8 @@ void br_fdb_cleanup_by_dst(struct net_bridge *br,
 				 * back to the raw port destination
 				 */
 				if (vlan && br_dst_vlan(dst) == vlan)
-					br_fdb_dst_write(f,
-							 br_port_to_dst(p));
+					br_fdb_dst_replace(f, dst,
+							   br_port_to_dst(p));
 				continue;
 			}
 		}
@@ -997,9 +997,12 @@ static bool __fdb_mark_active(struct net_bridge_fdb_entry *fdb)
 static void __fdb_update(struct net_bridge *br,
 			 struct net_bridge_fdb_entry *fdb,
 			 struct net_bridge_port *source,
+			 struct net_bridge_dst dst,
 			 const unsigned char *addr, u16 vid,
 			 unsigned long flags)
 {
+	struct net_bridge_port *old_port;
+	struct net_bridge_dst old_dst;
 	bool fdb_modified = false;
 	unsigned long now;
 
@@ -1017,18 +1020,30 @@ static void __fdb_update(struct net_bridge *br,
 		fdb_modified = __fdb_mark_active(fdb);
 	}
 
+	old_dst = br_fdb_dst_read(fdb);
+	old_port = br_dst_port(old_dst);
 	/* fastpath: update of existing entry */
-	if (unlikely(source != br_fdb_dst_port(fdb) &&
-		     !test_bit(BR_FDB_STICKY, &fdb->flags))) {
-		br_switchdev_fdb_notify(br, fdb, RTM_DELNEIGH);
-		br_fdb_dst_write(fdb, br_port_to_dst(source));
-		fdb_modified = true;
-		/* Take over HW learned entry */
-		if (unlikely(test_bit(BR_FDB_ADDED_BY_EXT_LEARN, &fdb->flags)))
-			clear_bit(BR_FDB_ADDED_BY_EXT_LEARN, &fdb->flags);
-		/* Clear locked flag when roaming to an unlocked port */
-		if (unlikely(test_bit(BR_FDB_LOCKED, &fdb->flags)))
-			clear_bit(BR_FDB_LOCKED, &fdb->flags);
+	if (unlikely(!br_dst_equal(dst, old_dst) &&
+		     (source == old_port ||
+		      !test_bit(BR_FDB_STICKY, &fdb->flags)))) {
+		if (source != old_port) {
+			br_switchdev_fdb_notify(br, fdb, RTM_DELNEIGH);
+			br_fdb_dst_write(fdb, dst);
+			fdb_modified = true;
+			/* take over HW learned entry */
+			if (unlikely(test_bit(BR_FDB_ADDED_BY_EXT_LEARN,
+					      &fdb->flags)))
+				clear_bit(BR_FDB_ADDED_BY_EXT_LEARN,
+					  &fdb->flags);
+			/* clear locked flag when roaming to an unlocked port */
+			if (unlikely(test_bit(BR_FDB_LOCKED, &fdb->flags)))
+				clear_bit(BR_FDB_LOCKED, &fdb->flags);
+		} else {
+			/* raw port-to-VLAN promotion shouldn't overwrite a
+			 * concurrent roam to another port
+			 */
+			br_fdb_dst_replace(fdb, old_dst, dst);
+		}
 	}
 
 	if (unlikely(test_bit(BR_FDB_ADDED_BY_USER, &flags))) {
@@ -1047,6 +1062,8 @@ void br_fdb_update(struct net_bridge *br, struct net_bridge_port *source,
 		   struct net_bridge_vlan *vlan, const unsigned char *addr,
 		   unsigned long flags)
 {
+	struct net_bridge_dst dst = vlan ? br_vlan_to_dst(vlan) :
+					   br_port_to_dst(source);
 	struct net_bridge_fdb_entry *fdb;
 	u16 vid = vlan ? vlan->vid : 0;
 
@@ -1056,10 +1073,10 @@ void br_fdb_update(struct net_bridge *br, struct net_bridge_port *source,
 
 	fdb = fdb_find_rcu(&br->fdb_hash_tbl, addr, vid);
 	if (likely(fdb)) {
-		__fdb_update(br, fdb, source, addr, vid, flags);
+		__fdb_update(br, fdb, source, dst, addr, vid, flags);
 	} else {
 		spin_lock(&br->hash_lock);
-		fdb = fdb_create(br, source, addr, vid, flags);
+		fdb = fdb_create(br, dst, addr, vid, flags);
 		if (fdb) {
 			trace_br_fdb_update(br, source, addr, vid, flags);
 			fdb_notify(br, fdb, RTM_NEWNEIGH, true);
@@ -1213,7 +1230,7 @@ static int fdb_add_entry(struct net_bridge *br, struct net_bridge_port *source,
 		if (!(flags & NLM_F_CREATE))
 			return -ENOENT;
 
-		fdb = fdb_create(br, source, addr, vid,
+		fdb = fdb_create(br, br_port_to_dst(source), addr, vid,
 				 BIT(BR_FDB_ADDED_BY_USER));
 		if (!fdb)
 			return -ENOMEM;
@@ -1564,7 +1581,7 @@ int br_fdb_external_learn_add(struct net_bridge *br, struct net_bridge_port *p,
 		if (locked)
 			flags |= BIT(BR_FDB_LOCKED);
 
-		fdb = fdb_create(br, p, addr, vid, flags);
+		fdb = fdb_create(br, br_port_to_dst(p), addr, vid, flags);
 		if (!fdb) {
 			err = -ENOMEM;
 			goto err_unlock;
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index 951b6ac5f484..a1c5b1abc1ef 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -694,6 +694,13 @@ static inline void br_dst_write(struct net_bridge_dst *dst,
 		   ACCESS_PRIVATE(&src, value));
 }
 
+static inline bool br_dst_equal(struct net_bridge_dst dst1,
+				struct net_bridge_dst dst2)
+{
+	return ACCESS_PRIVATE(&dst1, value) ==
+	       ACCESS_PRIVATE(&dst2, value);
+}
+
 static inline struct net_bridge_dst
 br_port_to_dst(const struct net_bridge_port *p)
 {
@@ -768,6 +775,17 @@ static inline void br_fdb_dst_write(struct net_bridge_fdb_entry *fdb,
 	br_dst_write(&fdb->dst, dst);
 }
 
+static inline bool
+br_fdb_dst_replace(struct net_bridge_fdb_entry *fdb,
+		   struct net_bridge_dst old,
+		   struct net_bridge_dst new)
+{
+	unsigned long old_value = ACCESS_PRIVATE(&old, value);
+
+	return cmpxchg(&ACCESS_PRIVATE(&fdb->dst, value), old_value,
+		       ACCESS_PRIVATE(&new, value)) == old_value;
+}
+
 static inline struct net_bridge_port *
 br_fdb_dst_port(const struct net_bridge_fdb_entry *fdb)
 {
-- 
2.47.3

