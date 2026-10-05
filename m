Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C721A4AB3C3
	for <netdev@vger.kernel.org>; Mon,  5 Oct 2026 14:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791211218; cv=none; b=SJOONyGXMDDeSGUTU5XBVxY3k0Bckdt5LDxjUSJGas3pEzrwerIuFLvJH68CT4/x/TllqB1ULQbHl5muLWvUQH+T3DqFh9zVRGJ2SbdhEFEUKWyLWULIb3I2mdN83/xpCxbe/nmCOEUKzBeT/ZITIYfaverj4BanGeUmT8tL4Mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791211218; c=relaxed/simple;
	bh=Cj6glqTNouog2ShibjfR8Itq6jaQXXZtdrXbWGVCdvs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=af2C/N0vkrQcT2s4N4LRAalPNQWJ74fkRrOJRlgqbOAD/j1JeSfC+c6TMaLdpUneebD0v45Cb7ovNmiVNcycROssMtzSr68C6/R+ANl3Pj4N8o/7/DghjPDqF1SwuZZovz7Hh+cb404vGkc7Ptsug+LpJMxY8Hb4tkL6djEAzyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=AGBTGZkT; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="AGBTGZkT"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4a1728d8dfcso9522915e9.1
        for <netdev@vger.kernel.org>; Mon, 05 Oct 2026 07:40:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1791211200; x=1791816000; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5bSt5R41K3yP75EtFUWEkcQ6TleKOOF2+mrl49XIVdM=;
        b=AGBTGZkTYl5mnchA/XalE2uQTc/vWiF9WHZpTFXeicUBWW+5tbleApOGAL6yXI5oh+
         bc52VxBR0dY3tfHIwdUZlUokrDh3NtfDm/BfrgsxK+aoBKJOAL8Jo5QYza3fd0Qhlku/
         fGrhpVBJJVx4HkxZicR4DktrfJ9MX+Do0s7kK5ApM86/5tfNC6GbB7iookTysJAv2B9m
         S57oQ0V5FbVvkvi0Xw4fG/JbkhAnHLuXDaGVUmup4ki3CncGyRWCB5vmj1UxudC8I+Pe
         wMVMSqVATJimbv6Ht5K6+suiXXJfO/DQ1CzvEgZgAbke3JOQV59cDGEEYYdTkM4NSrR+
         cNIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791211200; x=1791816000;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=5bSt5R41K3yP75EtFUWEkcQ6TleKOOF2+mrl49XIVdM=;
        b=ur5rusFD2qbNE6VFes3lJTZfVbkpo4z0f1OVdwxI/TzVX2UB1EvSMu1WHJXj4ACmSN
         v9Y6XoL7W7G56Fy7y6J6VXpDGT0bTed0Qj6bF0JCjDBd/OGxvS9lNx0FZoHnloANk5mj
         fwggMUEFHMWPeJm5cjADEwpjzPp1DC+TJtK8eY0tVJpha8+pbZy3qM0auGiASUtCjiHY
         BV786C8zjEGjv1FVmq3zz+a4wcgNJXYvfij+fU4K/qqWup0J8ewg7exM36mJkULJ3Cu6
         JlWRQHe5tmHXgwrvYSP40OqRRP994uSsMjy0CrMK/yCTlVCByAQ/IrgtI9qdFLE2JWry
         ZezA==
X-Gm-Message-State: AFuF++l6MV2Gn2dZWERpWcp0I6uh96pCVDk50I8L4DK9RYcHnVY3wZ9E
	9Z78qYCUj5KHxjd7b4jTq/5VrpByTH3smYEpKjCXEosK6KkGl3Q4Ies8BIEczJXebHjPpaQBOXb
	A6BzF
X-Gm-Gg: AYBFou1Ds3pCmheIu6K+gcJ9QBCnxVEScqsemUq3cCvC1xchkQZPw/CGPyk3YaHetdC
	MVRCCk6Zw+VGa4o5VrHTVUl0J2MKr7rCNK0Wi1AwAoKTqq1XjUaJCB3C8lpZAIPtAYYq2uQgCxS
	VWFRJT71i7A083F/TlM90DSZ84Tl0q5M9KIAYh0SPbOM+cf4Rne5h6UaWXDZx7mGf3BfD1rGYuh
	KWfy6zym0JGqP8XWuh5Hioa88h7JX6z6VrAubFhn59+ZcC7RS1FXTQ8DaOl0nF4rsQcc9QwM03h
	nnA/z/gQCLGjb44wsb0qgxZJJBBvPVsDjUpCrHdSPYRvfJadxgRytIIFJy7cgKnzRpC9hB7JHoz
	R6UkfVO+YiyT++Lrrk2/15RvgcSu3NDC1Y3zdL0eCMsUw7A6tpvAQH6PvwnWXVtHv7Mq3JuQc60
	0KMGwv8hLD5mgmdkQk2CeH296oN98KfSt6u2uaox0CX2ugg3qHXU336I2TLgioVBaufCBWMrL/V
	TPRXx8t9GOBWh7jcrmZ
X-Received: by 2002:a05:600c:a116:b0:49b:9202:6f80 with SMTP id 5b1f17b1804b1-4a1680dd3dbmr90880685e9.6.1791211199889;
        Mon, 05 Oct 2026 07:39:59 -0700 (PDT)
Received: from localhost (78-154-14-127.ip.btc-net.bg. [78.154.14.127])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4a166bfaf73sm174234765e9.4.2026.10.05.07.39.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 07:39:59 -0700 (PDT)
From: Nikolay Aleksandrov <razor@blackwall.org>
To: netdev@vger.kernel.org
Cc: idosch@nvidia.com,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	bridge@lists.linux.dev,
	Nikolay Aleksandrov <razor@blackwall.org>
Subject: [PATCH net-next 5/6] net: bridge: fdb: factor out configured entry destination updates
Date: Mon,  5 Oct 2026 17:39:36 +0300
Message-ID: <20261005143937.877466-6-razor@blackwall.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261005143937.877466-1-razor@blackwall.org>
References: <20261005143937.877466-1-razor@blackwall.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Share the destination update logic used by user configured and ext learned
entries. Report a modification only when the port changes.

Signed-off-by: Nikolay Aleksandrov <razor@blackwall.org>
---
 net/bridge/br_fdb.c | 34 ++++++++++++++++++----------------
 1 file changed, 18 insertions(+), 16 deletions(-)

diff --git a/net/bridge/br_fdb.c b/net/bridge/br_fdb.c
index ce09e3fbc58b..927e5f23df5b 100644
--- a/net/bridge/br_fdb.c
+++ b/net/bridge/br_fdb.c
@@ -1193,6 +1193,22 @@ static bool fdb_handle_notify(struct net_bridge_fdb_entry *fdb, u8 notify)
 	return modified;
 }
 
+static bool fdb_update_dst(struct net_bridge_fdb_entry *fdb,
+			   struct net_bridge_dst old_dst,
+			   struct net_bridge_dst dst)
+{
+	if (br_dst_equal(old_dst, dst))
+		return false;
+
+	if (br_dst_port(old_dst) == br_dst_port(dst)) {
+		br_fdb_dst_replace(fdb, old_dst, dst);
+		return false;
+	}
+
+	br_fdb_dst_write(fdb, dst);
+	return true;
+}
+
 /* Update (create or replace) forwarding database entry */
 static int fdb_add_entry(struct net_bridge *br, struct net_bridge_dst dst,
 			 const u8 *addr, struct ndmsg *ndm, u16 flags, u16 vid,
@@ -1246,14 +1262,7 @@ static int fdb_add_entry(struct net_bridge *br, struct net_bridge_dst dst,
 			return -EEXIST;
 
 		old_dst = br_fdb_dst_read(fdb);
-		if (!br_dst_equal(old_dst, dst)) {
-			if (br_dst_port(old_dst) != source) {
-				modified = true;
-				br_fdb_dst_write(fdb, dst);
-			} else {
-				br_fdb_dst_replace(fdb, old_dst, dst);
-			}
-		}
+		modified = fdb_update_dst(fdb, old_dst, dst);
 
 		set_bit(BR_FDB_ADDED_BY_USER, &fdb->flags);
 		if (test_and_clear_bit(BR_FDB_DYNAMIC_LEARNED, &fdb->flags))
@@ -1634,14 +1643,7 @@ int br_fdb_external_learn_add(struct net_bridge *br, struct net_bridge_port *p,
 
 		WRITE_ONCE(fdb->updated, jiffies);
 
-		if (!br_dst_equal(old_dst, dst)) {
-			if (br_dst_port(old_dst) != p) {
-				modified = true;
-				br_fdb_dst_write(fdb, dst);
-			} else {
-				br_fdb_dst_replace(fdb, old_dst, dst);
-			}
-		}
+		modified = fdb_update_dst(fdb, old_dst, dst);
 
 		if (test_and_set_bit(BR_FDB_ADDED_BY_EXT_LEARN, &fdb->flags)) {
 			/* Refresh entry */
-- 
2.47.3

