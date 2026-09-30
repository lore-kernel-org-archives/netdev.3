Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21CCE43E9E0
	for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 07:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790752520; cv=none; b=hx4jZ3ldqYPekRWwO4FKkkvT1nBPbaFw2uGJJfAzMPrDBx/cKbsF4InJo1vRNpHNc556HNNglMHBzg9p+rniYnuLQCqvaXTULSdD6p/EraSCLlqAKn8nWCLowOPZzAiyyvqQU7gZj3AAMQ05TTyK5ZBxWgd7DZ1pEKZu1jPFLOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790752520; c=relaxed/simple;
	bh=BXgyI4sCufuWZa1tjU2lRPagslaBlnEl5OkvEVWRzdY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pss6spzgLZhoY61VaJFYfqQSfWKzbr3RldixNu99yiLRYxzjNoih/WDJWxWDNpRwdMzIvsj03IYgEREDuDkCu4/0n3JYMnkQ7/x8H5cUyASnbe3x7jzoVpIfaVzfTj1vpyrYs00T6VXEzzcE+xR18Yv7n0PDfe4jA+Ys2/R8Ics=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=DWoGvtRg; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="DWoGvtRg"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49d1fb0cf5eso46417065e9.3
        for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 00:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1790752512; x=1791357312; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pnbeeE69kzQwgxg+/slWEMlra8y40s8hQbt41pBeHaM=;
        b=DWoGvtRgHuDcXvaV3t3KG390szG2RX7hPSLHWKZBdza5Xzl3gyYSBctxlofOMfPkgJ
         emIuFUnaZsrIP822ZWFQ4wcN+TP0n19N/csPrbDX5UgZoltSVT+upwGsShJtH1964jt+
         wiHVKyPf5Brh7HLcKuqQPIIlX5Ke+533APk+7AmjyYjYwqKJNlosop5II6H3+UHa7vDP
         qtnXOU4MH9tkNoGCkSXOxoTN4x4bOdJcIjfvMDRFeXx/ta0L34DDzmkXVgjTD5jZ+k8s
         MS39Or2IMJx2j+w33Y1t979mJYqH29mC8MrwCvlm/KMh9SoQJYdIgGZ5et3YNqnHYJO1
         Cwnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790752512; x=1791357312;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=pnbeeE69kzQwgxg+/slWEMlra8y40s8hQbt41pBeHaM=;
        b=mmXL6tGSvd8Yo5rBl3nDRyDUDIL+LQpplcawgSI9UUkxN1bopKd3d8ioAek/FjFZzi
         42tZ481WTdir66SbEmt3lD3/2IzxFU4HWyQ3lBwkMPs/H2Vp2/IGYuFzHiNAnMtTNS8X
         xauMYNmLibwzwSeicQxQw9E90BdAO8Molv3UoSLCeodTdTNYCId1dpGpyaZfMzqSxGqy
         66QGGPUEmF57HRMxkM2VP38wyIOH3XBL8nCdSXF4CZF8cuHOLLiOOsdvQhEivB1BdnNM
         qCVUp5YoE4qJ2M6RXUYgpyjrSw7PIxlktS63uV58yHwzg1STAhmhjceQmHg/dbNesu2K
         tHXA==
X-Gm-Message-State: AFuF++kJPColhCG31jh6gYk8aMHQbJ7lJ/G252QOrGzrhs3vBTf9yToC
	e6xIfr8e/NYE0ABJdGQwtHEPJCytH9jyq+Q9OYLW4wvxEWiwMnB02i6YNuNvXp+9vECARPSQf8w
	thCz8
X-Gm-Gg: AYBFou00GTBaVY9+sze7BlIsT93hic9zbrs0OwqROSgkZ1EEkwlij66jl4OxxTaKG6x
	zU9DUO14rXPSb+3hgA0ALFrJnX2CFTDjpJ3XoADlRFxv91jMYFQPdS//8IefGDG4nugTdI4OviA
	ED/fJtg+cqRm/VfJckSUTxx/OrPqbl9CYc5FHY1MaBQe05OhqPGSlIoBxlSry7hlwIKAZOAES+Q
	mTVSv6eBulzrSuVwV2XWN6duj33E0a7qO0k3ocq8Ui+JMhPRj1z27ihU33acVpVYnZ41jxKaC/1
	oEy9KIhmW9eyuqlQIAFVFX9LnlhLQzCvChKR+KsQnOB1ZJTNTDin4DCAEMBJzE1WSj53zESMKiO
	ATx6Ctjva1cdHIadZi03p7jWrNmUBAorzJjzg7m3+v2EkCyu9AxDDGP3/QUPf98mE+YviL8ueSI
	c+hyRouFxpmlClP5QrXM/qHWi41cLy836K5wU+kONgrDI+PN+17zf0+/RFRn83z61pPqEFOBQLt
	il2QSQ14J5UDamjRMIC
X-Received: by 2002:a05:600c:3b95:b0:4a0:37b:5c05 with SMTP id 5b1f17b1804b1-4a01ab4e8a0mr8749865e9.0.1790752512344;
        Wed, 30 Sep 2026 00:15:12 -0700 (PDT)
Received: from localhost (78-154-14-127.ip.btc-net.bg. [78.154.14.127])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4a017520f98sm27869305e9.8.2026.09.30.00.15.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 00:15:11 -0700 (PDT)
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
Subject: [PATCH net-next 09/12] net: bridge: fdb: factor out existing entry updates
Date: Wed, 30 Sep 2026 10:14:08 +0300
Message-ID: <20260930071411.2786201-10-razor@blackwall.org>
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

Move the existing fdb entry update path out of br_fdb_update() into
__fdb_update(). This reduces nesting in br_fdb_update() and keeps the
lookup and creation flow separate from updates to an entry that was found.
No functional changes intended.

Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: Nikolay Aleksandrov <razor@blackwall.org>
---
 net/bridge/br_fdb.c | 96 +++++++++++++++++++++++----------------------
 1 file changed, 50 insertions(+), 46 deletions(-)

diff --git a/net/bridge/br_fdb.c b/net/bridge/br_fdb.c
index 307f9c12914e..b87c6f8875da 100644
--- a/net/bridge/br_fdb.c
+++ b/net/bridge/br_fdb.c
@@ -994,6 +994,55 @@ static bool __fdb_mark_active(struct net_bridge_fdb_entry *fdb)
 		  test_and_clear_bit(BR_FDB_NOTIFY_INACTIVE, &fdb->flags));
 }
 
+static void __fdb_update(struct net_bridge *br,
+			 struct net_bridge_fdb_entry *fdb,
+			 struct net_bridge_port *source,
+			 const unsigned char *addr, u16 vid,
+			 unsigned long flags)
+{
+	bool fdb_modified = false;
+	unsigned long now;
+
+	/* attempt to update an entry for a local interface */
+	if (unlikely(test_bit(BR_FDB_LOCAL, &fdb->flags))) {
+		if (net_ratelimit())
+			br_warn(br, "received packet on %s with own address as source address (addr:%pM, vlan:%u)\n",
+				source->dev->name, addr, vid);
+		return;
+	}
+
+	now = jiffies;
+	if (now != READ_ONCE(fdb->updated)) {
+		WRITE_ONCE(fdb->updated, now);
+		fdb_modified = __fdb_mark_active(fdb);
+	}
+
+	/* fastpath: update of existing entry */
+	if (unlikely(source != br_fdb_dst_port(fdb) &&
+		     !test_bit(BR_FDB_STICKY, &fdb->flags))) {
+		br_switchdev_fdb_notify(br, fdb, RTM_DELNEIGH);
+		br_fdb_dst_write(fdb, br_port_to_dst(source));
+		fdb_modified = true;
+		/* Take over HW learned entry */
+		if (unlikely(test_bit(BR_FDB_ADDED_BY_EXT_LEARN, &fdb->flags)))
+			clear_bit(BR_FDB_ADDED_BY_EXT_LEARN, &fdb->flags);
+		/* Clear locked flag when roaming to an unlocked port */
+		if (unlikely(test_bit(BR_FDB_LOCKED, &fdb->flags)))
+			clear_bit(BR_FDB_LOCKED, &fdb->flags);
+	}
+
+	if (unlikely(test_bit(BR_FDB_ADDED_BY_USER, &flags))) {
+		set_bit(BR_FDB_ADDED_BY_USER, &fdb->flags);
+		if (test_and_clear_bit(BR_FDB_DYNAMIC_LEARNED, &fdb->flags))
+			atomic_dec(&br->fdb_n_learned);
+	}
+
+	if (unlikely(fdb_modified)) {
+		trace_br_fdb_update(br, source, addr, vid, flags);
+		fdb_notify(br, fdb, RTM_NEWNEIGH, true);
+	}
+}
+
 void br_fdb_update(struct net_bridge *br, struct net_bridge_port *source,
 		   struct net_bridge_vlan *vlan, const unsigned char *addr,
 		   unsigned long flags)
@@ -1007,49 +1056,7 @@ void br_fdb_update(struct net_bridge *br, struct net_bridge_port *source,
 
 	fdb = fdb_find_rcu(&br->fdb_hash_tbl, addr, vid);
 	if (likely(fdb)) {
-		/* attempt to update an entry for a local interface */
-		if (unlikely(test_bit(BR_FDB_LOCAL, &fdb->flags))) {
-			if (net_ratelimit())
-				br_warn(br, "received packet on %s with own address as source address (addr:%pM, vlan:%u)\n",
-					source->dev->name, addr, vid);
-		} else {
-			unsigned long now = jiffies;
-			bool fdb_modified = false;
-
-			if (now != READ_ONCE(fdb->updated)) {
-				WRITE_ONCE(fdb->updated, now);
-				fdb_modified = __fdb_mark_active(fdb);
-			}
-
-			/* fastpath: update of existing entry */
-			if (unlikely(source != br_fdb_dst_port(fdb) &&
-				     !test_bit(BR_FDB_STICKY, &fdb->flags))) {
-				br_switchdev_fdb_notify(br, fdb, RTM_DELNEIGH);
-				br_fdb_dst_write(fdb, br_port_to_dst(source));
-				fdb_modified = true;
-				/* Take over HW learned entry */
-				if (unlikely(test_bit(BR_FDB_ADDED_BY_EXT_LEARN,
-						      &fdb->flags)))
-					clear_bit(BR_FDB_ADDED_BY_EXT_LEARN,
-						  &fdb->flags);
-				/* Clear locked flag when roaming to an
-				 * unlocked port.
-				 */
-				if (unlikely(test_bit(BR_FDB_LOCKED, &fdb->flags)))
-					clear_bit(BR_FDB_LOCKED, &fdb->flags);
-			}
-
-			if (unlikely(test_bit(BR_FDB_ADDED_BY_USER, &flags))) {
-				set_bit(BR_FDB_ADDED_BY_USER, &fdb->flags);
-				if (test_and_clear_bit(BR_FDB_DYNAMIC_LEARNED,
-						       &fdb->flags))
-					atomic_dec(&br->fdb_n_learned);
-			}
-			if (unlikely(fdb_modified)) {
-				trace_br_fdb_update(br, source, addr, vid, flags);
-				fdb_notify(br, fdb, RTM_NEWNEIGH, true);
-			}
-		}
+		__fdb_update(br, fdb, source, addr, vid, flags);
 	} else {
 		spin_lock(&br->hash_lock);
 		fdb = fdb_create(br, source, addr, vid, flags);
@@ -1057,9 +1064,6 @@ void br_fdb_update(struct net_bridge *br, struct net_bridge_port *source,
 			trace_br_fdb_update(br, source, addr, vid, flags);
 			fdb_notify(br, fdb, RTM_NEWNEIGH, true);
 		}
-		/* else  we lose race and someone else inserts
-		 * it first, don't bother updating
-		 */
 		spin_unlock(&br->hash_lock);
 	}
 }
-- 
2.47.3

