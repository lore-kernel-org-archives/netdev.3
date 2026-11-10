Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794332835;
	b=UTPnyYBScVKxg2TgnsnHB1vD3GvuY9XOsQsDzgCB5I2/OtevKovucCVK78g7outZXoUz
	 EEgkDhcHAUTVx/o9ENkPGxbUxfUs9lppZZZhiDi5X1+vHPzgXQRysi8y3L2syo5JNkxIP
	 qJly7O7OOXCIsgFGH/qw/+AI4cfVS4ZMLzqeWcH67JG6DM4EJHoqWexDLHqjKduh3EaSN
	 c8kSEJlLjwyVjIWiUqmUl6bVDZtvNV9lx6FWxCqwvq8XWHVkLki/Jk6wqhlyVYK23uqJw
	 Q2yQKJl8eZ9Ssg3tgMoA+5/1qvHKJP2Dyb9of5bqJkv/46206HULJ+fZ8Dz3JGevFww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794332835;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=P40Na334w0uQYACP5NK4jK9I/hXvmLNFBq+y6dmR07w=;
	b=Drx3IUBjLQJQTmv3VGwbo6Xth0FHZhMJtemcGsLjycts487m3ZAl82w85vpNq8mjJXVT
	 P7pSCrawnDq+Jfm6xpL+avA9cuSWN8y0YIHW64iPnfHJmAYlbbIrlRVcDOT8zfXH+AxpD
	 oegpuK6nCPAy59C5PP+LYZ1bBN3nmatbBqfMNPJf//uEJ9cG0DDe5lrWYeLhw1rmnnBpe
	 1o9L5ksZEsohWgG2utfpJ/K+b59BBcvxSwx34IXfSPf/P/4WthUBYcyvOGORORl5hsjck
	 KBD8aq5HWNbkQoXN4VwrrayVlDkAvMGvVU8FpINGB+9u/KInzXKxQupWQYVUW3y8xYg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hwNhSm4G;
	arc=none smtp.remote-ip=209.85.160.45
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 772BF606A327
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 17:47:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 772BF606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hwNhSm4G
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-4ad5b52f0a7so1483813fac.1
        for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 09:47:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794332834; x=1794937634; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=P40Na334w0uQYACP5NK4jK9I/hXvmLNFBq+y6dmR07w=;
        b=hwNhSm4GoKeEhLmtS44qIWv3kVen0pk0vuI/DI7tMyVyHTzFqzWo5aktshZcY4i9X5
         zNjtGH/i2ZccxmT8k/VI3Lwm7rwPZdFfVmTBK6ei1F5RU4ISccypBWHCQvELyz3aXQ1s
         HzzrqCv6XUF16AlKjXA1q8NzVZ/ZRCaUIIjsi4pzXZ/20/zwKE53uF8FiicVFO/kt09E
         w0vajP/sAA2T5MWQdjaqk2KJPTK4ArWsCf5SArtBfB3iPncD7dGyxKLzuhsXpsu7qEUg
         XPiQMjZZZAGvUhhLBOfT+bsUfKZ7FGqaBATDijeqo+MzBHeBwKaZrltgHl+zy55JPP2q
         dPwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794332834; x=1794937634;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=P40Na334w0uQYACP5NK4jK9I/hXvmLNFBq+y6dmR07w=;
        b=usfx4b4TFNxo0k4wh7sfeTKRlztFWoTkRv7cFN0v9lS8VrYNYWjbf1hp4LyXGBscOR
         W6eqUtSuOFOSm80+cZooPe7dsiMQgUnRYWckjIRLEwlMJ756Wzwx96nRG/90xzxOGzlC
         RM09oSXxc2eJIf6XQ4tSArR++oVlLUnoqXagFZ7jiotyAWoF5WKu582HENZMR/8nDkQu
         dwUQ7GsiV58J18YJOE1cASkLcB2RCtqSXoJKai3SP9s9OAxB8m9DqbwlloTFk8d1l1Ye
         qeyfGsB8F4kQp7vWPbVqPS1dn7cdbtWNLuodPVrJe2NwHidT2GmwBHYVMU8p1ImuaHlg
         KaTA==
X-Gm-Message-State: APuU4Z9PK+iw/SDPjPZfYgi9aqlbf02PRGypwiCi3FO5cbb7K+AkR+IV
	YVYrKFAJN+qNXCZCrEIs6xfpxZTf8Uv03DbPLYzndDfOlMS+kTEnSx2xyfbb1MJ0
X-Gm-Gg: AYBFou2GERKqA+smebmPDcf1p+SSmacc9lnMsTY5YuFQ+Jd6Vx5ZptKOMFOgh7+ePYL
	VA9z/k6/xB7ujXWHaRJs0Au3dbNeePYTrvAkPCF4HG5IcSznr9P56pwNAekO0yfCT4yzbKA0cVS
	Z23oorJCLgliOA9Mp9SHHsk0vgGHbRB5/AgIygEPqA2ngdfC6QOw7lmLmBTHBcCSBqghTjuD6x7
	p5L5XVg9WtPkCFPnpne298LowcWq8bCf/7gQzBVI8Yr38AkOlQ3ZQnAUyl/Al7/SlwlPHBpSEUF
	F7uULfWtNr3jvkTbni9x9/A5cUPh/Mxw/54EMeFzO/oQ1FYbGMjZZPy/XrOo+KlkPxxu50VSpn6
	nYmAbQVYknxPRG49wr5llU4wyUDeLo9I7D3o38A57FqHQBJo2UeKbwIl1Gd/FuTL4i1vS62cd13
	RMmHGvwyTXHF+En6UoCgjfikQ50ry7q5dV2SWayVarLanp+tlOoWZWkH+msFT5HDipHUwwMPtys
	lTI17jz0rMURwuxS4JHRJ7RKFi+s1xPnnJtocgBxW5ZdsJ8CWZ9YwfxPNDJgwjmeBydz9hdv/rB
	3C4QChriYdMM/xAYDCl8QpjF
X-Received: by 2002:a05:6808:30a5:b0:4f5:4780:582 with SMTP id 5614622812f47-5683ca748c2mr3186518b6e.50.1794332834099;
        Tue, 10 Nov 2026 09:47:14 -0800 (PST)
Received: from houminxi ([61.170.225.237])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-56905f2faf5sm2667315b6e.13.2026.11.10.09.47.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 09:47:12 -0800 (PST)
From: Minxi Hou <houminxi@gmail.com>
To: netdev@vger.kernel.org
Cc: Aaron Conole <aconole@redhat.com>,
	Eelco Chaudron <echaudro@redhat.com>,
	Ilya Maximets <i.maximets@ovn.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Paul Blakey <paulb@nvidia.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Shuah Khan <shuah@kernel.org>,
	dev@openvswitch.org,
	linux-kselftest@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net v3 1/2] net: openvswitch: do not record user features when the change fails
Date: Tue, 10 Nov 2026 12:46:50 -0500
Message-ID: <20261110174651.972936-2-houminxi@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261110174651.972936-1-houminxi@gmail.com>
References: <20261110174651.972936-1-houminxi@gmail.com>
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

ovs_dp_change() stores the new features in dp->user_features before it
updates the per-cpu upcall port IDs, and that update fails when the
per-cpu-pids attribute is empty or its length is not a multiple of four.
The request returns -EINVAL with the new features already recorded, while
the code that enables or disables the tc skb extension key never ran.

The datapath then claims TC_RECIRC_SHARING without holding the reference
the bit stands for. A later request that clears the bit drops a reference
that was never taken, and a datapath destroyed with the bit clear never
drops the one it did take.

tc_skb_ext_tc is one static key for the whole host. cls_flower and OVS
take and drop references to it; the bridge, the flow dissector and the
OVS flow path only read it, and they depend on the key staying on while
they do. A count that is one short reaches zero while cls_flower still
holds a reference, so recirc sharing in every datapath goes off with it,
and so does the skb extension allocation the readers above depend on. A
disable on a count of zero warns in static_key_dec_not_one() in
kernel/jump_label.c, which panics a host that runs with panic_on_warn.

The request only needs CAP_NET_ADMIN, which a user namespace that owns a
network namespace provides. datapath_policy has no entry for
OVS_DP_ATTR_PER_CPU_PIDS and the operation skips strict validation, so an
empty attribute reaches the check that fails.

Record the features last, in one setter that takes and drops the
reference along with them, and call it from the places that change or
clear the bit. Two of those places leaked a reference: a datapath that
fails after ovs_dp_change() enabled the key was freed without a disable,
and ovs_dp_reset_user_features() cleared the bit without one. The reset
runs when an outdated user space instance sends OVS_DP_CMD_NEW for a
name that already exists, and after it the datapath's packets no longer
share the tc skb extension, which is what the warning it prints already
announced.

Fixes: 35d39fecbc24 ("net/sched: Enable tc skb ext allocation on chain miss only when needed")
Cc: stable@vger.kernel.org
Signed-off-by: Minxi Hou <houminxi@gmail.com>
---
 net/openvswitch/datapath.c | 34 +++++++++++++++++++++-------------
 net/openvswitch/datapath.h |  5 ++++-
 2 files changed, 25 insertions(+), 14 deletions(-)

diff --git a/net/openvswitch/datapath.c b/net/openvswitch/datapath.c
index b2a0b09fd4a5..8fcb9f2c8ece 100644
--- a/net/openvswitch/datapath.c
+++ b/net/openvswitch/datapath.c
@@ -1704,6 +1704,20 @@ static struct datapath *lookup_datapath(struct net *net,
 	return dp ? dp : ERR_PTR(-ENODEV);
 }
 
+/* Called with ovs_mutex. */
+static void ovs_dp_set_user_features(struct datapath *dp, u32 features)
+{
+	bool was = dp->user_features & OVS_DP_F_TC_RECIRC_SHARING;
+	bool now = features & OVS_DP_F_TC_RECIRC_SHARING;
+
+	if (now && !was)
+		tc_skb_ext_tc_enable();
+	else if (!now && was)
+		tc_skb_ext_tc_disable();
+
+	dp->user_features = features;
+}
+
 static void ovs_dp_reset_user_features(struct sk_buff *skb,
 				       struct genl_info *info)
 {
@@ -1716,7 +1730,7 @@ static void ovs_dp_reset_user_features(struct sk_buff *skb,
 
 	pr_warn("%s: Dropping previously announced user features\n",
 		ovs_dp_name(dp));
-	dp->user_features = 0;
+	ovs_dp_set_user_features(dp, 0);
 }
 
 static int ovs_dp_set_upcall_portids(struct datapath *dp,
@@ -1773,7 +1787,7 @@ u32 ovs_dp_get_upcall_portid(const struct datapath *dp, uint32_t cpu_id)
 
 static int ovs_dp_change(struct datapath *dp, struct nlattr *a[])
 {
-	u32 user_features = 0, old_features = dp->user_features;
+	u32 user_features = 0;
 	int err;
 
 	if (a[OVS_DP_ATTR_USER_FEATURES]) {
@@ -1801,9 +1815,7 @@ static int ovs_dp_change(struct datapath *dp, struct nlattr *a[])
 			return err;
 	}
 
-	dp->user_features = user_features;
-
-	if (dp->user_features & OVS_DP_F_DISPATCH_UPCALL_PER_CPU &&
+	if (user_features & OVS_DP_F_DISPATCH_UPCALL_PER_CPU &&
 	    a[OVS_DP_ATTR_PER_CPU_PIDS]) {
 		/* Upcall Netlink Port IDs have been updated */
 		err = ovs_dp_set_upcall_portids(dp,
@@ -1812,12 +1824,7 @@ static int ovs_dp_change(struct datapath *dp, struct nlattr *a[])
 			return err;
 	}
 
-	if ((dp->user_features & OVS_DP_F_TC_RECIRC_SHARING) &&
-	    !(old_features & OVS_DP_F_TC_RECIRC_SHARING))
-		tc_skb_ext_tc_enable();
-	else if (!(dp->user_features & OVS_DP_F_TC_RECIRC_SHARING) &&
-		 (old_features & OVS_DP_F_TC_RECIRC_SHARING))
-		tc_skb_ext_tc_disable();
+	ovs_dp_set_user_features(dp, user_features);
 
 	return 0;
 }
@@ -1939,6 +1946,8 @@ static int ovs_dp_cmd_new(struct sk_buff *skb, struct genl_info *info)
 err_destroy_portids:
 	kfree(rcu_dereference_raw(dp->upcall_portids));
 err_unlock_and_destroy_meters:
+	/* The datapath is freed here and never reaches __dp_destroy(). */
+	ovs_dp_set_user_features(dp, 0);
 	ovs_unlock();
 	ovs_meters_exit(dp);
 err_destroy_ports:
@@ -1961,8 +1970,7 @@ static void __dp_destroy(struct datapath *dp)
 	struct flow_table *table = &dp->table;
 	int i;
 
-	if (dp->user_features & OVS_DP_F_TC_RECIRC_SHARING)
-		tc_skb_ext_tc_disable();
+	ovs_dp_set_user_features(dp, 0);
 
 	for (i = 0; i < DP_VPORT_HASH_BUCKETS; i++) {
 		struct vport *vport;
diff --git a/net/openvswitch/datapath.h b/net/openvswitch/datapath.h
index 7a7afaeceee5..e94b77261b95 100644
--- a/net/openvswitch/datapath.h
+++ b/net/openvswitch/datapath.h
@@ -76,7 +76,10 @@ struct dp_nlsk_pids {
  * ovs_mutex and RCU.
  * @stats_percpu: Per-CPU datapath statistics.
  * @net: Reference to net namespace.
- * @user_features: Bitmap of enabled %OVS_DP_F_* features.
+ * @user_features: Bitmap of enabled %OVS_DP_F_* features.  A datapath
+ * that has %OVS_DP_F_TC_RECIRC_SHARING set holds one reference to the tc
+ * skb extension, so this field is written last, through
+ * ovs_dp_set_user_features(), with ovs_mutex held.
  * @max_headroom: The maximum headroom of all vports in this datapath; it will
  * be used by all the internal vports in this dp.
  * @meter_tbl: Meter table.
-- 
2.56.0

