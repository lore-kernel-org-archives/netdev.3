Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9636B36A033
	for <netdev@vger.kernel.org>; Fri, 11 Sep 2026 15:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789140176; cv=none; b=LYM14pp0GQy7vEwoiYVfgrV+k+TCciIHsZnFmkiaDcfHjv8JvcJ5SEk5KD0L5OfAabhvlpGb43QvK+7mC9CDludRAiL+RewE1RNpPVlX1LEdR3qNW7a85AsHPspQOJjJEw2nz7qwbc0zpo4YNR1b74Z7ANrX+x3rfYHUB8leKrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789140176; c=relaxed/simple;
	bh=XvBFvoj3NtxLfiq/QPGad++OX0rfUzOCIFlG+2oc4js=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VVhc1nojlwouxQEqdBc2V264xUgjtKTtNziqaMKcxsf3yakIvKbTCF4U59jgNlM9ukuvFtDsZ34T6wTPEoQhkIqVEePtd1BKsFzW17xFVsgYoAKNHuOww2QY/9+tRFVjXcMgTZgHWRwQiV2wuN3R2/7BI64wRBO4xBPosInLpCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=cpre2c2Y; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="cpre2c2Y"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-48434392b02so804286f8f.3
        for <netdev@vger.kernel.org>; Fri, 11 Sep 2026 08:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1789140173; x=1789744973; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=uPVHK0UKh13XuzvPAq0t2DICkCsJRRtiu4q34ZJGYJA=;
        b=cpre2c2Y2Ms1Xfs1w/w+FsbQlM4oPFoEr5zCN4nNrDizwjARIxlrRZmjEPnQRxqSbP
         pog35KOSQ0HGyXNWXnmSIlXhcGd2LWivZBEQq1Ur+rfJHfp/a41XRZYXlnUQln6N8tbI
         ES6oTqpdt1x8XDfAuRH71ydAiAlLqJIFBrjk5dDSh+cuSrzPe+3T7BGcQ06Vo04V+ScV
         e1+b3ltOA908Gqro9JBmZxT+BDH5dRNEmAe2Khcp4REOKf/4nlXzZ7gnuvTSjrffvjmV
         3ewESIOd1ICDR3syKEsPZLXSnCMa5LJSgOdbmJmVmQKlI2vFJMc4ICnx/FbB2mgl062r
         QOtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789140173; x=1789744973;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uPVHK0UKh13XuzvPAq0t2DICkCsJRRtiu4q34ZJGYJA=;
        b=kTn7/rkvTzRLeSpoMoZ5u989B/NsB5AnAz34Ku8WX7o/hOlzLkfAm3qO1OeVS46uY5
         FRZg/1KB8GxHRiQuFYVbN0ToPDztPjp9u8INXj39nTnxA3Os2mh2yq0mmh4owdLyCCMl
         oQs/arKjSD6jICbQ+2lIaNxMqOkvyeU7OfzUw9lXhuswFX6GH0XqwsT8vFusAGu7I8rm
         e6bP7daFUlPifNCECD27YfBFWQd9lraFsFcXzpWhghgLlUIAWn00lrnvwcv9fl/ga4gX
         CNTexfsxpKu9HMjTB1dOIUj0nLr4Tz1vNw5K9CBHLzsDaAFrOBK9FKdXkU6OGhbFw5c0
         RMnA==
X-Gm-Message-State: AFuF++naEp6S6tBXPz5ktOctbnIFLa+oMvzLpSUzAiyaS1k8c5bSnlnF
	SDyiSArvP8nVcLjXuWOmnCxnUxo2H2vjSYyTPts0sfqPwch8mjqMmplzTbU1rATvyrI8UzvesU7
	Z/VMcFXE=
X-Gm-Gg: AYBFou3nFQIeTcVUDEdZKJ8mmTzMYJRfBtZFvYajE03M858fW3LcLLW6miakglfYMMz
	AkvKLRhT/9CdMgXFJZ3KwC8Norzg57IAY9oNwM8Tpaa7EDyi78yKr5vFaCU5RjomX5OoQpkDIsY
	N/YRMVgvxkx2mVrb+NAX5NAWFkbAe7AfAkDFeUaGVzMBUIYrUWlPQgGskCi3yiZ+mrsOQoBu9VP
	PA9jcQgiwt6s1NwQeJURlJjirXfz4bxFvcc5ObjrFKMbgrHeOq1GHDS2UUJM9cEINIF7aDUbwBk
	1ubQ2ZshsByZ8Fmg/HhkPYPpTb+BrIXJQfV9YH22NfFtcc1jO5MmB9mxhd7o3L6Hk5AF0bSXM4s
	CSNO2rJ8B13+5koP3YQQ4H30o2vjmNEIS+W4mmwoZBepAz8hNL+TKUMBMsRfzFNSv6yIZFdfCik
	+s3+Suu93UHt2+xGwZtygf2icLWki5tRw6SzZSSbosmhbTbtVbukDfRKpdCYSH2dSJzzDtKAOs8
	sXldLjPi4du+zNdul0Opg==
X-Received: by 2002:a05:6000:4b1d:b0:484:3312:f127 with SMTP id ffacd0b85a97d-486eb35fc9cmr11591303f8f.27.1789140172622;
        Fri, 11 Sep 2026 08:22:52 -0700 (PDT)
Received: from localhost (78-154-14-127.ip.btc-net.bg. [78.154.14.127])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-486eb34e608sm6815862f8f.23.2026.09.11.08.22.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 08:22:51 -0700 (PDT)
From: Nikolay Aleksandrov <razor@blackwall.org>
To: netdev@vger.kernel.org
Cc: idosch@nvidia.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	tobias@waldekranz.com,
	bridge@lists.linux.dev,
	Nikolay Aleksandrov <razor@blackwall.org>
Subject: [PATCH net] net: bridge: mst: move switchdev call outside rcu
Date: Fri, 11 Sep 2026 13:50:21 +0300
Message-ID: <20260911105021.1385934-1-razor@blackwall.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is a follow-up of one of sashiko's pre-existing bug reports.
br_mst_set_state() calls switchdev_port_attr_set() for nonzero MSTIs
while holding rcu_read_lock() which invokes the blocking switchdev
notifier chain and may sleep. Nonzero MSTI changes come from netlink
with rtnl held. Move the switchdev call before entering the rcu section and
assert that rtnl is held.

The call cannot be deferred because netlink needs its error and extack.
Also DSA reads the old bridge MST state during the callback and checks it.
A deferred callback will be late and will see the updated state.

Fixes: 7ae9147f4312 ("net: bridge: mst: Notify switchdev drivers of MST state changes")
Signed-off-by: Nikolay Aleksandrov <razor@blackwall.org>
---
 net/bridge/br_mst.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/net/bridge/br_mst.c b/net/bridge/br_mst.c
index 43a300ae6bfa..ce537cb71fe8 100644
--- a/net/bridge/br_mst.c
+++ b/net/bridge/br_mst.c
@@ -107,21 +107,24 @@ int br_mst_set_state(struct net_bridge_port *p, u16 msti, u8 state,
 	struct net_bridge_vlan *v;
 	int err = 0;
 
-	rcu_read_lock();
-	vg = nbp_vlan_group_rcu(p);
-	if (!vg)
-		goto out;
-
 	/* MSTI 0 (CST) state changes are notified via the regular
-	 * SWITCHDEV_ATTR_ID_PORT_STP_STATE.
+	 * SWITCHDEV_ATTR_ID_PORT_STP_STATE. All other MSTIs are handled via
+	 * netlink with RTNL held
 	 */
 	if (msti) {
+		ASSERT_RTNL();
+
 		err = switchdev_port_attr_set(p->dev, &attr, extack);
 		if (err && err != -EOPNOTSUPP)
 			goto out;
+		err = 0;
 	}
 
-	err = 0;
+	rcu_read_lock();
+	vg = nbp_vlan_group_rcu(p);
+	if (!vg)
+		goto out_rcu_unlock;
+
 	list_for_each_entry_rcu(v, &vg->vlan_list, vlist) {
 		if (v->brvlan->msti != msti)
 			continue;
@@ -129,8 +132,9 @@ int br_mst_set_state(struct net_bridge_port *p, u16 msti, u8 state,
 		br_mst_vlan_set_state(vg, v, state);
 	}
 
-out:
+out_rcu_unlock:
 	rcu_read_unlock();
+out:
 	return err;
 }
 
-- 
2.47.3

