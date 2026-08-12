Received: from alln-iport-1.cisco.com (alln-iport-1.cisco.com [173.37.142.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2177043E092;
	Wed, 12 Aug 2026 12:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.37.142.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786538998; cv=none; b=iQjjkhlHSsTTLMtIw5CS20zqKgz+v3t/BQsPiPuAPqZpwPcx3II0NQYi9TPFtf32FtoI+hXQSxTZRygrtdXX1tBlLJj4zKyEPB/fOUy2gHxeK15kvbbnsuao7+imflQiDCDK+0WAyrPclHG5bFT+UIuaQVsV6Mb2klnuy/phCrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786538998; c=relaxed/simple;
	bh=ravgyTMGoDPlF1ySa8WEOjfx9zHoj7u0Ex/+mOptQy0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EV/yTMNUxyHzNnRoCGhHQ3K2I26ik4w8KSeP7GGiFuqLEzaEHc4KOiiD0vBb+tPXeH7ZYCAHBsJTVdXgOZ+9XvOu8uJtWJpzyq/nu2XAAAJT4g1zsCwufxOIrGNUOmL74k6SR6J/HQ7qKZ4DbONI3bD90aqZVTY2nkOhVYaghV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (2048-bit key) header.d=cisco.com header.i=@cisco.com header.b=QUJOaVUo; arc=none smtp.client-ip=173.37.142.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cisco.com header.i=@cisco.com header.b="QUJOaVUo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=7744; q=dns/txt;
  s=iport01; t=1786538992; x=1787748592;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=HJgeV4SucwlX+7Q6SPcOGzcgU3FJ0DEE3JxVPYWqJJ8=;
  b=QUJOaVUoatCCoDtX4LbsV5AIQ5Y9OkeLuj1Or2X3NXdImGajIDK0yOcN
   y9k3ZCtMH7x/S1fuySt3gncViEJ4C6OqdFo5S9/ROLbnpyhxS8MhHVl0H
   ry+eHYj96HFpUnTkrX0MUkkcKQao/AOn5ZjRNdZSV1kHS0QtrM/+V83an
   Zdt0hkp0MkANoo3/QYZzyOlczw5LdQ3XvshjKXrZQrwtx21Sj/wYXwbQn
   WsCXKOKZx2JjFxEsBEfjSu9BScVKdiclU2P3KAhevUd3AoPIwWJLhZfw5
   IZm5HAOr/h2Xxm7IxjM7pxwFYO4vztmUBW6jTzldlrKY9Gy96iKSWJAVW
   A==;
X-CSE-ConnectionGUID: 0WCiXqKdRjiYhMXfchP04g==
X-CSE-MsgGUID: JC+APdHIR7Cnx+RiuDPCHw==
X-IPAS-Result: =?us-ascii?q?A0A9AABhanxq/5EQJK1aHQEBAQEJARIBBQUBgX0HAQsBg?=
 =?us-ascii?q?laBUkNJhFePUoIhnh4UgWoPAQEBD1EEAQGCEoJzAo1nAiY1CA4BAgQDAgMBA?=
 =?us-ascii?q?QEBAQEBAQEBAQsBAQUBAQECAQcFgQ4ThlyGWwIBAyMEUhAlAiYCAkYQBgESg?=
 =?us-ascii?q?wKCdQPDLHp/M4EB3kaBZgELFAGBCi4BhXCCbAGBcIQIO4RBJxuBSUSBFYNph?=
 =?us-ascii?q?CqDdIJqBIMcEotkhxwJP4ECHANZLAFVEw0KCwcFYVIzAyAKCxISGBUCFBwTD?=
 =?us-ascii?q?wQWMh1wDCcSLBc1WBsGBYEdfRQEE4Q2Ixk2fIEJYYErKmUBEheBCYIkAoJ2g?=
 =?us-ascii?q?SphAgEeCxgNSBEsNwYOGQQ9AW4HjggggVRxATwdNBQSVjMCDFeBDx+Pb4JVg?=
 =?us-ascii?q?36NX2uBNZ9ahCiBZqAPATKXZ5MFmQgjo2pNhGmBagI4gVkzGggbFYMiUxkPj?=
 =?us-ascii?q?i0WHM99JzI9AgcCBw4DC5NmAQE?=
IronPort-Data: A9a23:6+6Yda30KwO0zt+fE/bD5QFwkn2cJEfYwER7XKvMYLTBsI5bp2AEz
 2caDG+OPv7ZajSme4x+PYXn/EoF7J7Rz4IyQFBt3Hw8FHgiRegpqji6wuYcGwvIc6UvmWo+t
 512huHodZ5yFjmH4E/xbtANlFEkvYmQXL3wFeXYDS54QA5gWU8JhAlq8wIDqtYAbeORXUXX5
 Lsen+WFYAX7g24taDpNg06+gEoHUMra6WtwUmMWPZinjHeG/1EJAZQWI72GLneQauF8Au6gS
 u/f+6qy92Xf8g1FIovNfmHTKxBirhb6ZGBiu1IOM0SQqkEqSh8ajs7XAMEhhXJ/0F1lqTzeJ
 OJl7vRcQS9xVkHFdX90vxNwS0mSNoUekFPLzOTWXcG7lyX7n3XQL/pGVH4dPL0B2epNA2B/9
 dkoJjsNVkjfiLfjqF67YrEEasULJc3vOsYb/3pn1zycVaZgSpHYSKKM7thdtNsyrpkRRrCFO
 YxAN3w2MEmojx5nYj/7DLollfupnXn8cxVTqUmeouw85G27IAlZgOG1bYSIJofTLSlTtmSz5
 Uv+80TYOE4xMszc8zuY3kqHpvCayEsXX6pXTtVU7MVCjFSNy2k7BBQIWF6/pvelzEizR7p3L
 0EV5iMphaQ//k2iSJ/6RRLQiHOIoxsVSddMO+I97w6Jx+zf5APxLmsZRDdpa9E8ssIyAzsw2
 TehltXlHzFw87uYVX6Q6J+QsDW0fyMVRUcabCUJSwot+dTvoIgvyBnIS75LFK+zk82wGjzqx
 T2OhDYxiq9VjsMR0ai/u1fdjFqEoJXVQgMrzhvYU3jj7Q5jYoOhIYuy5jDmAe1oJYKdSByF+
 XMDgcXbtLBIBpCWnyvLS+IIdF2028u43PTnqQYHN/EcG/6FohZPoag4DOlCGXpU
IronPort-HdrOrdr: A9a23:GXgreK875SwjyEOuaNluk+AuI+orL9Y04lQ7vn2ZhyYlFvBw8P
 rOoB1773HJYVkqNU3I9errBEDEewK/yXcX2+Ys1MmZPDUO0VHAROpfBMnZsl7d8kbFmtK1u5
 0QFpRWOZncAUd3iMDi7BL9MdoxqeP3iZyAtKPyw2hgSAdyZ7ol1Qd2DQ6HDlZ7LTM2Y6bRbK
 DsgfZvln6HZWkdaNi9Cz0uWujOoMCOqbfdCCR2fyLOLGK1/EmVAHmQKWni4isj
X-Talos-CUID: =?us-ascii?q?9a23=3AyAfPG2mjcO18z4q+5QNreEICWfbXOSXi53bgOmy?=
 =?us-ascii?q?0M2Roeb2weVGb+Js8z8U7zg=3D=3D?=
X-Talos-MUID: 9a23:ENyPZgkiMIRnbG+5Xj4AdnpAH4RB26iOKXpSupMW+POFKABIEBeC2WE=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.25,219,1779148800"; 
   d="scan'208";a="810565431"
Received: from alln-l-core-08.cisco.com ([173.36.16.145])
  by alln-iport-1.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 12 Aug 2026 12:48:40 +0000
Received: from [127.0.0.1] (unknown [10.25.129.245])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by alln-l-core-08.cisco.com (Postfix) with ESMTPS id 5EFD818000453;
	Wed, 12 Aug 2026 12:48:39 +0000 (GMT)
From: Satish Kharat <satishkh@cisco.com>
Date: Wed, 12 Aug 2026 05:48:11 -0700
Subject: [PATCH net-next v13 11/11] enic: re-establish V2 VF admin channel
 and PF registration after reset
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260812-enic-sriov-v2-admin-channel-v2-v13-11-b3809e448aba@cisco.com>
References: <20260812-enic-sriov-v2-admin-channel-v2-v13-0-b3809e448aba@cisco.com>
In-Reply-To: <20260812-enic-sriov-v2-admin-channel-v2-v13-0-b3809e448aba@cisco.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Breno Leitao <leitao@debian.org>, Sesidhar Baddela <sebaddel@cisco.com>, 
 Satish Kharat <satishkh@cisco.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786538908; l=7952;
 i=satishkh@cisco.com; h=from:subject:message-id;
 bh=ravgyTMGoDPlF1ySa8WEOjfx9zHoj7u0Ex/+mOptQy0=;
 b=7KA3IdMmtBViUhg4mi01W3mnVoJffDgRsrwUCCBIlC5ptujVX1/jm5W2Qcc2x2kJCuTrOWCDt
 +kcqKNInmOwAhIGx5l2aGZkoFjkw2Qgcd+2+0+saj5WFgeGXGV3Po7x
X-Developer-Key: i=satishkh@cisco.com; a=ed25519;
 pk=4BxbLoCGvHeIMH/PbpiNVx8/2IcTjFvqcr0AD8K6WLY=
X-Outbound-Client-TLS: ANONYMOUS;unknown [10.25.129.245];TLSv1.3;TLS_AES_256_GCM_SHA384;256
X-Outbound-SMTP-Client: 10.25.129.245, [10.25.129.245]
X-Outbound-Node: alln-l-core-08.cisco.com

The reset paths (enic_reset/enic_tx_hang_reset) tore down and re-opened
the V2 admin/MBOX channel only for the PF: the close/reopen was gated on
enic_sriov_enabled() && vf_type == ENIC_VF_TYPE_V2, which is never true on
a VF (vf_type is set only on the PF; VFs are identified by
enic_is_sriov_vf_v2()).  A VF-initiated reset therefore left the VF admin
QP wiped by the reset but never re-opened, and the VF never re-registered
with the PF, so VF<->PF MBOX traffic (currently link state)
stopped working until the VF was re-probed.

Factor the decision into enic_has_admin_chan() (true for a V2 PF while
SR-IOV is enabled and for every V2 VF) and the reopen sequence into
enic_admin_chan_reopen().  For a VF the helper additionally re-runs the
probe-time handshake (enic_mbox_vf_capability_check() +
enic_mbox_vf_register()) so the PF learns about the VF again; for a PF it
re-pushes the current link state as before.

Before reopening, invalidate the VF's local registration flag.  The reset
only wipes the VF's admin QP, not the PF's software vf_state (that changes
only via the register/unregister MBOX handlers), so the PF may still hold
a stale "registered" until the VF re-registers.  Locally, a failed reopen
or re-handshake must not leave a stale registered state that a later
teardown would try to unregister over a dead channel.

Signed-off-by: Satish Kharat <satishkh@cisco.com>
---
 drivers/net/ethernet/cisco/enic/enic_main.c | 122 +++++++++++++++++++---------
 1 file changed, 82 insertions(+), 40 deletions(-)

diff --git a/drivers/net/ethernet/cisco/enic/enic_main.c b/drivers/net/ethernet/cisco/enic/enic_main.c
index 537ed5ad7800..0baef7a120ec 100644
--- a/drivers/net/ethernet/cisco/enic/enic_main.c
+++ b/drivers/net/ethernet/cisco/enic/enic_main.c
@@ -2181,6 +2181,74 @@ static void enic_set_api_busy(struct enic *enic, bool busy)
 	spin_unlock(&enic->enic_api_lock);
 }
 
+/* The admin/MBOX channel exists on a V2 PF while SR-IOV is enabled and on
+ * every V2 VF.  A reset wipes the admin WQ/RQ/CQ, so such devices must tear
+ * the channel down before the reset and re-establish it afterwards.
+ */
+static bool enic_has_admin_chan(struct enic *enic)
+{
+	return enic_is_sriov_vf_v2(enic) ||
+	       (enic_sriov_enabled(enic) && enic->vf_type == ENIC_VF_TYPE_V2);
+}
+
+/* Re-establish the admin/MBOX channel after a reset has re-created the data
+ * path.  Mirrors the relevant part of the probe / SR-IOV-enable sequence:
+ * reinitialise MBOX and reopen the channel, then for a VF re-run the PF
+ * handshake (the reset wiped the VF's admin QP, so the VF must register
+ * again), or for a PF re-push the current link state to registered VFs.
+ */
+static void enic_admin_chan_reopen(struct enic *enic)
+{
+	int err;
+
+	/* Install the MBOX receive handler and reset the sequence number
+	 * before opening the channel, so the handler is in place before the
+	 * admin interrupt is unmasked and no early completion is dropped.
+	 */
+	enic_mbox_init(enic);
+
+	/* A reset destroys the VF's local admin QP, so the VF can no longer
+	 * rely on its previous registration.  The PF may retain stale software
+	 * registration state until the VF successfully registers again.
+	 * Clear the local flag before reopening so a failed reopen or
+	 * re-handshake cannot leave the VF believing it has a usable PF
+	 * registration over a dead channel.
+	 */
+	if (enic_is_sriov_vf_v2(enic))
+		enic->vf_registered = false;
+
+	err = enic_admin_channel_open(enic);
+	if (err) {
+		netdev_err(enic->netdev,
+			   "admin channel reopen after reset failed: %d\n", err);
+		return;
+	}
+
+	if (enic_is_sriov_vf_v2(enic)) {
+		err = enic_mbox_vf_capability_check(enic);
+		if (err) {
+			netdev_err(enic->netdev,
+				   "MBOX capability check after reset failed: %d\n",
+				   err);
+			enic_admin_channel_close(enic);
+			return;
+		}
+		err = enic_mbox_vf_register(enic);
+		if (err) {
+			netdev_err(enic->netdev,
+				   "MBOX VF re-registration after reset failed: %d\n",
+				   err);
+			enic_admin_channel_close(enic);
+		}
+	} else {
+		/* The link came back up during enic_open() above while MBOX
+		 * sends were still disabled (channel not yet reopened), so that
+		 * link-notify was dropped.  Re-push current link state now.
+		 */
+		schedule_work(&enic->link_notify_work);
+	}
+}
+
 static void enic_reset(struct work_struct *work)
 {
 	struct enic *enic = container_of(work, struct enic, reset);
@@ -2199,8 +2267,7 @@ static void enic_reset(struct work_struct *work)
 	 * DMAs from the about-to-be-reset rings) and frees the admin resources
 	 * so they are cleanly re-allocated afterwards.
 	 */
-	if (enic_sriov_enabled(enic) &&
-	    enic->vf_type == ENIC_VF_TYPE_V2)
+	if (enic_has_admin_chan(enic))
 		enic_admin_channel_close(enic);
 
 	enic_stop(enic->netdev);
@@ -2214,25 +2281,13 @@ static void enic_reset(struct work_struct *work)
 
 	enic_open(enic->netdev);
 
-	/* Re-establish the admin/MBOX channel after the data path is back up,
-	 * mirroring the SR-IOV enable path (channel open + mbox init).  The
-	 * channel was fully torn down by enic_admin_channel_close() above.
+	/* Re-establish the admin/MBOX channel after the data path is back up.
+	 * It was fully torn down by enic_admin_channel_close() above;
+	 * enic_admin_chan_reopen() reopens it and, for a PF re-pushes link
+	 * state, or for a VF re-runs the probe-time PF handshake.
 	 */
-	if (enic_sriov_enabled(enic) &&
-	    enic->vf_type == ENIC_VF_TYPE_V2) {
-		if (enic_admin_channel_open(enic)) {
-			netdev_err(enic->netdev,
-				   "admin channel reopen after reset failed\n");
-		} else {
-			enic_mbox_init(enic);
-			/* The link came back up during enic_open() above
-			 * while MBOX sends were still disabled (channel not
-			 * yet reopened), so that link-notify was dropped.
-			 * Re-push current link state to registered VFs now.
-			 */
-			schedule_work(&enic->link_notify_work);
-		}
-	}
+	if (enic_has_admin_chan(enic))
+		enic_admin_chan_reopen(enic);
 
 	/* Allow infiniband to fiddle with the device again */
 	enic_set_api_busy(enic, false);
@@ -2255,8 +2310,7 @@ static void enic_tx_hang_reset(struct work_struct *work)
 	 * the same reason as the soft reset path: stop the admin QP and free
 	 * the admin resources before the hardware queues are wiped.
 	 */
-	if (enic_sriov_enabled(enic) &&
-	    enic->vf_type == ENIC_VF_TYPE_V2)
+	if (enic_has_admin_chan(enic))
 		enic_admin_channel_close(enic);
 
 	enic_dev_hang_notify(enic);
@@ -2271,25 +2325,13 @@ static void enic_tx_hang_reset(struct work_struct *work)
 
 	enic_open(enic->netdev);
 
-	/* Re-establish the admin/MBOX channel after the data path is back up,
-	 * mirroring the SR-IOV enable path (channel open + mbox init).  The
-	 * channel was fully torn down by enic_admin_channel_close() above.
+	/* Re-establish the admin/MBOX channel after the data path is back up.
+	 * It was fully torn down by enic_admin_channel_close() above;
+	 * enic_admin_chan_reopen() reopens it and, for a PF re-pushes link
+	 * state, or for a VF re-runs the probe-time PF handshake.
 	 */
-	if (enic_sriov_enabled(enic) &&
-	    enic->vf_type == ENIC_VF_TYPE_V2) {
-		if (enic_admin_channel_open(enic)) {
-			netdev_err(enic->netdev,
-				   "admin channel reopen after reset failed\n");
-		} else {
-			enic_mbox_init(enic);
-			/* The link came back up during enic_open() above
-			 * while MBOX sends were still disabled (channel not
-			 * yet reopened), so that link-notify was dropped.
-			 * Re-push current link state to registered VFs now.
-			 */
-			schedule_work(&enic->link_notify_work);
-		}
-	}
+	if (enic_has_admin_chan(enic))
+		enic_admin_chan_reopen(enic);
 
 	/* Allow infiniband to fiddle with the device again */
 	enic_set_api_busy(enic, false);

-- 
2.43.0

