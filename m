Received: from mail-wm2-f11.google.com (mail-wm2-f11.google.com [74.125.225.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C33734A5C25
	for <netdev@vger.kernel.org>; Wed,  2 Sep 2026 20:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788381127; cv=none; b=DhHEzEIC9dxqiNZBPkcqXUkcFlpe3uAOGlI/BtXo+V4Q7Q/E3cROsZ5oJV+QbruhhUh2kgPbjCUpIzPl9x2n2vAJrudhzzVAUZU8Gd1qe2V9XeJDQ5wSNdW1/oVQ1nU36aGt5vwAoUFqBoeAEr4+sz0qND0I5I4RbJ6QtJAyggM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788381127; c=relaxed/simple;
	bh=DZRGi0YkwMmKkDFY82SN6nJfXXcbmLtf6J+0y60/HUA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=M5ERLfVceJ53iF0Pag1Z+IfPlCd5XROTuHiTzCNFxhsGoSy1o/VU62inRBoiTr2hkT+zo7pcWtH6kw/ClqBpllw9Yvp18FlY0Ns9j4ilpqIaIU0jECxC2Hb8vz15anTRgrNoZb4hAgbCzWXFU+a2S0PphH1Kl1Q9QBkwvadr43Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.225.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm2-f11.google.com with SMTP id 5b1f17b1804b1-49ccea58fe3so6156125e9.1
        for <netdev@vger.kernel.org>; Wed, 02 Sep 2026 13:32:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788381124; x=1788985924;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=X4qp6/3DQjm1uYF71HjtKIkBpSfIBgTn2nEvAonfrWQ=;
        b=lTvxv/DG5qOM/UOKdgMfz24dDvhlLQFdlhgCxhTMjoyjaMZaKPGfCVYlEZIKH6MKhW
         UKaFlXPKD/CJqRJw8WgrD/5InT2b26i+t2kE2wKoaG3kN8zQnK17a0Img8MaQTouMhtY
         j6uvaCZE7ljAvY+1/m5PpVCxJgDODV4+9mPFiMlY00zDuFq/IGWHtxvHt0anj1KbXKfb
         Whax9O70EJzekbBlMderC2eEh0MUxmzXRA1loBKoT/FwKvq2gZHcW51I+HA8Sf9yvO/h
         gTYUVfEg4Ok9YVeVw5wW5pOIdzhnqKqmLC/d3dHPpD9X/1Eu8aQMTUViHkwf8fLVKYIi
         0EOA==
X-Gm-Message-State: AFuF++nVNOs8mdfzgATCsQRoV6pzAvDZ2P12PTjS77QdBNM8auCt+oC8
	iopRh2RI8u0GtjBe1TO+Sor3UAa2XEsPs1qBPOrej2ztLzZ1pfp8jLx/EPqNrgo4
X-Gm-Gg: AYBFou3nKE8I5PYiQiyTjJFinzBOT8iBAd5bb2vyt8J2ugIor05W5kcOe6V96TcU9AK
	BvEtSuVacvB0QPJabw9+Fla0Vhhuht3yh5uGqrJ7JKv0XjgGZVL5PFYeSt/FiKL711LO9tac1FX
	Wit/uPOXTtlUjIi8R8Pt5bybk7B08GAGuenGLjSBO2tv9MpPS6OVFiv5Htt1E+VH70uGUq80dPG
	LeqQVVM3CzTlOhnk94NJZuXicZOs9Ydh+nQ49RFzJee7So1rCGqenniRheVe3Hgns2I5frGYjPD
	7CQH4uqtLDfBm2TtK5kY9fOs0q7IrfxAyim0NIpv5iyRHwUM0EaNup6WrS7UF8AeEbjESO5XqJI
	KxFMso7iw34SGvb+Ei/q2BrmY62WQ0sspeGEi5xCo/yGWmSFNEgTwNIj6jnX+l6oxdpu7jL2Hqw
	Rptib1utfyQpJ2vTYWAjC30V3Nt/QW+QJAp12TRClJm0L2Z5O0ZWFoGudUr4i12/fmvl+g0DgF+
	60XvJaetFGe0qmxlos=
X-Received: by 2002:a05:600c:4ed0:b0:499:726a:a017 with SMTP id 5b1f17b1804b1-49ce57ec163mr141464905e9.1.1788381123692;
        Wed, 02 Sep 2026 13:32:03 -0700 (PDT)
Received: from im-t490s.redhat.corp (37-48-53-4.nat.epc.tmcz.cz. [37.48.53.4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49ce47b9817sm69220065e9.1.2026.09.02.13.32.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 13:32:03 -0700 (PDT)
From: Ilya Maximets <i.maximets@ovn.org>
To: netdev@vger.kernel.org
Cc: Aaron Conole <aconole@redhat.com>,
	Eelco Chaudron <echaudro@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	dev@openvswitch.org,
	linux-kernel@vger.kernel.org,
	Ilya Maximets <i.maximets@ovn.org>
Subject: [PATCH net-next] net: openvswitch: don't schedule rebalancing if there are no datapaths
Date: Wed,  2 Sep 2026 22:30:41 +0200
Message-ID: <20260902203200.1416026-1-i.maximets@ovn.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

During namespace initialization the masks rebalancing work is
scheduled and automatically re-scheduled every 4 seconds afterwards.
This is happening in every namespace.  On a large kubernetes node with
500 pods, i.e., 500+ namespaces, this creates a decent amount of
unnecessary churn scheduling 500 jobs every 4 seconds that take the
mutex, check that there are no datapaths in their namespace, release
the mutex, re-schedule themselves and exit.  These 500 unnecessary
mutex locks may hold off operations in a single namespace that
actually has a datapath configured and has real user requests to
handle under this lock.  They can also add delay to removal of other
namespaces as ovs_exit_net() needs to take that lock as well and
synchronously waits for the work to be cancelled.

Let's only fire the job when the first datapath is actually created
and not re-arm it if there are no more datapaths configured in the
namespace.

Another approach would be to make ovs_mutex per-namespace, but it's
a much larger change that should be handled separately, and the
unnecessary work scheduling feels like a waste regardless.

It's safe to check and re-arm outside of the mutex as DP_CMD_NEW
handler will re-arm if the new datapath appears.  The scheduling
attempt also doesn't change the work or delay if it is already queued,
so it's also safe to call multiple times.

Skipping the re-arming is more elegant than canceling on removal of
the last datapath as it allows us to not think about potential race
conditions at a negligible cost of potentially one extra re-scheduling.

msecs_to_jiffies() moved to the macro to save on line length.

Signed-off-by: Ilya Maximets <i.maximets@ovn.org>
---
 net/openvswitch/datapath.c | 14 ++++++++++----
 net/openvswitch/datapath.h |  2 +-
 2 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/net/openvswitch/datapath.c b/net/openvswitch/datapath.c
index 631a03136fa14..2187034143255 100644
--- a/net/openvswitch/datapath.c
+++ b/net/openvswitch/datapath.c
@@ -1921,6 +1921,10 @@ static int ovs_dp_cmd_new(struct sk_buff *skb, struct genl_info *info)
 
 	ovs_unlock();
 
+	/* Start periodic mask rebalancing if it wasn't already. */
+	schedule_delayed_work(&ovs_net->masks_rebalance,
+			      DP_MASKS_REBALANCE_INTERVAL);
+
 	ovs_notify(&dp_datapath_genl_family, reply, info);
 	return 0;
 
@@ -2598,16 +2602,20 @@ static void ovs_dp_masks_rebalance(struct work_struct *work)
 	struct ovs_net *ovs_net = container_of(work, struct ovs_net,
 					       masks_rebalance.work);
 	struct datapath *dp;
+	bool rearm;
 
 	ovs_lock();
 
 	list_for_each_entry(dp, &ovs_net->dps, list_node)
 		ovs_flow_masks_rebalance(&dp->table);
 
+	rearm = !list_empty(&ovs_net->dps);
+
 	ovs_unlock();
 
-	schedule_delayed_work(&ovs_net->masks_rebalance,
-			      msecs_to_jiffies(DP_MASKS_REBALANCE_INTERVAL));
+	if (rearm)
+		schedule_delayed_work(&ovs_net->masks_rebalance,
+				      DP_MASKS_REBALANCE_INTERVAL);
 }
 
 static const struct nla_policy vport_policy[OVS_VPORT_ATTR_MAX + 1] = {
@@ -2713,8 +2721,6 @@ static int __net_init ovs_init_net(struct net *net)
 	if (err)
 		return err;
 
-	schedule_delayed_work(&ovs_net->masks_rebalance,
-			      msecs_to_jiffies(DP_MASKS_REBALANCE_INTERVAL));
 	return 0;
 }
 
diff --git a/net/openvswitch/datapath.h b/net/openvswitch/datapath.h
index b2c2b8da12d40..7a7afaeceee5e 100644
--- a/net/openvswitch/datapath.h
+++ b/net/openvswitch/datapath.h
@@ -23,7 +23,7 @@
 
 #define DP_MAX_PORTS                USHRT_MAX
 #define DP_VPORT_HASH_BUCKETS       1024
-#define DP_MASKS_REBALANCE_INTERVAL 4000
+#define DP_MASKS_REBALANCE_INTERVAL msecs_to_jiffies(4000)
 
 /**
  * struct dp_stats_percpu - per-cpu packet processing statistics for a given
-- 
2.55.0

