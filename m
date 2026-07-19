Received: from rcdn-iport-2.cisco.com (rcdn-iport-2.cisco.com [173.37.86.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A426B378806;
	Sun, 19 Jul 2026 08:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.37.86.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784450598; cv=none; b=d5q4Xlqm9brqpxwO8hCMoEBH5V7JPoSSlb1592nLpqeK22b1EUVIjQINEchLYi6Gq/hrWciTWVwCwhyZpwUsn0/euef/Hi9q4B0bit1od+s3AK5DGNG9F7h/xHO8xJXRrtfIbRmcZ5ePxWGgrQtPlFDFdevNY4vZ72EDs6Kl7Sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784450598; c=relaxed/simple;
	bh=FdWRKYYtk0FuUUegGgtNhjQIkPVlYiHEZ4/j6/h3dCk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iO7Z2UzDJiPdhU9ZJwAdvdhHuTWfaCasFpwrAX6/tNGJrYPEz2JcSQXyl7D2pksZ/IRDaHpI5Gl54OD7qUTaC1PmAMNpHEMtGcSeMkbiXcOIUJbOxbTOXpGiYN/gbJ/+GX/qczeUBIwkjHIpYjBQxmWQTeAeoVp5vePYO5t6RuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (2048-bit key) header.d=cisco.com header.i=@cisco.com header.b=eatJrW9Z; arc=none smtp.client-ip=173.37.86.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cisco.com header.i=@cisco.com header.b="eatJrW9Z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=6579; q=dns/txt;
  s=iport01; t=1784450596; x=1785660196;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=r7xz+wdOM2LeRCY3jPvIhQ2Pkga6rs6A23prvlcG3s0=;
  b=eatJrW9ZDoU6w2w/piY+gwQAoCIDb8uYiRZ7kNiaIHhcr+2TnQcwxmty
   TOLNNYZalhL960nDV42n6Urqw9SOWXo9jL2SwowXlfJ4fas7JtCvJzxCw
   VdIzqoRe0QH41JMiurwLuqA6ZDrjVVcHWrbQN+btEgyH4DyMk0xv/BI2m
   M+m9Qy7SZcgc2Or2ctKw5Qzbe5J20SgKui8+hVV+vq+Mb60Zq987eKQDd
   9KdobMBDUTOKkey83LL/PpnrKBycKyqqWONSw5qt5fttpR12lJ7sSD7Oq
   9jUyOCPje53ZZyVdeXIQXee44ISlXPxDcMuQMav7wjNTiRq5rsIeHdB9L
   w==;
X-CSE-ConnectionGUID: bM0ql58iSLaPOCmKVZhi/Q==
X-CSE-MsgGUID: xQ1IrfExQYKSnCSeiUR+PQ==
X-IPAS-Result: =?us-ascii?q?A0BFAgBUjFxq/5H/Ja1aHgEBCxIMggULgleBUkNJhFePU?=
 =?us-ascii?q?oIhnh4UgWoPAQEBD1EEAQGFBQKNUwImNAkOAQIEAwIDAQEBAQEBAQEBAQELA?=
 =?us-ascii?q?QEFAQEBAgEHBYEOE4ZchlsCAQMjBFIQJQImAgJGEAYBEoMCgnUDvQl6fzOBA?=
 =?us-ascii?q?d5FgWYBCxQBgQouhXGCawGBcIQHO4RBJxuBSUSBFYNphCqDdIJqBIMcEpFsC?=
 =?us-ascii?q?T+BAhwDWSwBVRMNCgsHBWFSMwMgCgsSEhgVAhQcEw8EFjIdcAwnEiwXNFgbB?=
 =?us-ascii?q?wWBHX8WBCGBAoR2Ix8DOX+BMHVKdy1pARIXgS+CFIE6AgcDCxgNSBEsNwYOG?=
 =?us-ascii?q?QQ9AW4HjUAjgU5xATwdNBRoMw6BZh+SRBGDbY1fa4E1n1qEJ4FmoA8BMpdnk?=
 =?us-ascii?q?wWZCCOkN4RpgWg8gVkzGggbFYMiUxkPji0WHNIeJzI9AQEHAgcOAwuBaJF+A?=
 =?us-ascii?q?QE?=
IronPort-Data: A9a23:JZUai64Kovv/FEqtB2sWYQxRtOXGchMFZxGqfqrLsTDasY5as4F+v
 mVMWm2PbPeJZmXyeIp1a4W/900OvMWAzYVhTgNqpX9gZn8b8sCt6fZ1gavT04J+CuWZESqLO
 u1HMoGowPgcFyGa/lH2dOC98RGQ7InQLpLkEunIJyttcgFtTSYlmHpLlvUw6mJSqYDR7zil5
 5Wo/qUzBHf/g2Qqaj1NuvrawP9SlK2aVA0w7wRWic9j5Dcyp1FNZLoDKKe4KWfPQ4U8NoaSW
 +bZwbilyXjS9hErB8nNuu6TnpoiG+O60aCm0xK6aoD66vRwjnVaPpUTaJLwXXxqZwChxLid/
 jniWauYEm/FNoWU8AgUvoIx/ytWZcWq85efSZSzXFD6I0DuKxPRL/tS4E4eN6hA4+IqUWB10
 fUgDxsITS6xh+Px+efuIgVsrpxLwMjDJogTvDRkiDreF/tjGcCFSKTR7tge1zA17ixMNa+BP
 IxCNnw1MUmGOkESUrsUIMpWcOOAnXDjciZYq1K9rqss6G+Vxwt0uFToGIaEKoTXH5UFxi50o
 ErWxj3YGB83JOWu6gGD2Umhh9L13hvCDdd6+LqQs6QCbEeo7mAaFhATfVeyv/S8jkmwR5RZJ
 lB80i4jrLQ782SnQ9P8Vhv+p2SL1jYRV8dVGv839CmCza3b5wvfDW8BJhZCddYvnMw7Xzon0
 hmOhdyBLTVpvKeYVjGb+6uYoC2aPTUTKykJZUcsVQIP7t/iiJs+ghLGUpBoF6vdptn0Hyzgh
 jOHti4zg50NgsMRkaa251bKh3SrvJehZgg4+gnaQEq74Q5jIo2ofYql7R7c9/koEWqCZkOKs
 H5Bn42V6/oDSMnd0ieMW+4KWrqu4p5pLQHhvLKmJLF5nxzFxpJpVdk4DO1WTKuxDvs5RA==
IronPort-HdrOrdr: A9a23:G8TDZaPXaBIOhsBcTjejsMiBIKoaSvp037Dk7TEUdfUzSK2lfq
 GV8sjzuiWYtN98YhsdcJW7Scu9qBDnmqKdn7NwAV7KZmCP01dAbrsSjrcKqAeNJ8SRzJ856Y
 5QN4VzF9H0C0F3loLZ7BnQKadY/PC3tI2lmuvayW5gVkVRa69m5xpkEQrzKDwReOA/P+tfKL
 OsouxaujGnZXMbKu6/BnUDQqz/guejruOfXfbDbCRXkjVnSliTmcXHLyQ=
X-Talos-CUID: 9a23:84WsdGOPWSXs1O5DUgw/7UpJSsEeVnTl61zVAHGKCWcucejA
X-Talos-MUID: 9a23:3Dbgawr6eFZiI7MlIiUezyFbbeZy7Ym+MXEuqpMtgMSFCBYzAw7I2Q==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.25,172,1779148800"; 
   d="scan'208";a="498052880"
Received: from rcdn-l-core-08.cisco.com ([173.37.255.145])
  by rcdn-iport-2.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 19 Jul 2026 08:42:14 +0000
Received: from [127.0.0.1] (unknown [10.25.130.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by rcdn-l-core-08.cisco.com (Postfix) with ESMTPS id 96E5A18000595;
	Sun, 19 Jul 2026 08:42:13 +0000 (GMT)
From: Satish Kharat <satishkh@cisco.com>
Date: Sun, 19 Jul 2026 01:41:56 -0700
Subject: [PATCH net-next v12 12/12] enic: re-establish V2 VF admin channel
 and PF registration after reset
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260719-enic-sriov-v2-admin-channel-v2-v12-12-6ff2c617001d@cisco.com>
References: <20260719-enic-sriov-v2-admin-channel-v2-v12-0-6ff2c617001d@cisco.com>
In-Reply-To: <20260719-enic-sriov-v2-admin-channel-v2-v12-0-6ff2c617001d@cisco.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Breno Leitao <leitao@debian.org>, Sesidhar Baddela <sebaddel@cisco.com>, 
 Satish Kharat <satishkh@cisco.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784450523; l=6769;
 i=satishkh@cisco.com; h=from:subject:message-id;
 bh=FdWRKYYtk0FuUUegGgtNhjQIkPVlYiHEZ4/j6/h3dCk=;
 b=Ys4Vzd3hyOGUlc1pJsPpice2f3un797gaRPkn5Q1XDbUd2jEKBR9bhGavaySBS8nLJUMGRV2N
 zjxnTgUO4nVAyMMe5ey2SE5rvTMEc5wyR6gbrYJZDt/kQgP+1f0sS4A
X-Developer-Key: i=satishkh@cisco.com; a=ed25519;
 pk=4BxbLoCGvHeIMH/PbpiNVx8/2IcTjFvqcr0AD8K6WLY=
X-Outbound-Client-TLS: ANONYMOUS;unknown [10.25.130.254];TLSv1.3;TLS_AES_256_GCM_SHA384;256
X-Outbound-SMTP-Client: 10.25.130.254, [10.25.130.254]
X-Outbound-Node: rcdn-l-core-08.cisco.com

The reset paths (enic_reset/enic_tx_hang_reset) tore down and re-opened
the V2 admin/MBOX channel only for the PF: the close/reopen was gated on
enic_sriov_enabled() && vf_type == ENIC_VF_TYPE_V2, which is never true on
a VF (vf_type is set only on the PF; VFs are identified by
enic_is_sriov_vf_v2()).  A VF-initiated reset therefore left the VF admin
QP wiped by the reset but never re-opened, and the VF never re-registered
with the PF, so VF<->PF MBOX traffic (link state, MAC, packet filter)
stopped working until the VF was re-probed.

Factor the decision into enic_has_admin_chan() (true for a V2 PF while
SR-IOV is enabled and for every V2 VF) and the reopen sequence into
enic_admin_chan_reopen().  For a VF the helper additionally re-runs the
probe-time handshake (enic_mbox_vf_capability_check() +
enic_mbox_vf_register()) so the PF learns about the VF again; for a PF it
re-pushes the current link state as before.

Signed-off-by: Satish Kharat <satishkh@cisco.com>
---
 drivers/net/ethernet/cisco/enic/enic_main.c | 105 +++++++++++++++++-----------
 1 file changed, 65 insertions(+), 40 deletions(-)

diff --git a/drivers/net/ethernet/cisco/enic/enic_main.c b/drivers/net/ethernet/cisco/enic/enic_main.c
index 99c06a049800..be3ae0a57af3 100644
--- a/drivers/net/ethernet/cisco/enic/enic_main.c
+++ b/drivers/net/ethernet/cisco/enic/enic_main.c
@@ -2171,6 +2171,57 @@ static void enic_set_api_busy(struct enic *enic, bool busy)
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
+ * reopen the channel and reinitialise MBOX, then for a VF re-run the PF
+ * handshake (its admin QP and PF-side registration were torn down by the
+ * reset), or for a PF re-push the current link state to registered VFs.
+ */
+static void enic_admin_chan_reopen(struct enic *enic)
+{
+	int err;
+
+	err = enic_admin_channel_open(enic);
+	if (err) {
+		netdev_err(enic->netdev,
+			   "admin channel reopen after reset failed: %d\n", err);
+		return;
+	}
+
+	enic_mbox_init(enic);
+
+	if (enic_is_sriov_vf_v2(enic)) {
+		err = enic_mbox_vf_capability_check(enic);
+		if (err) {
+			netdev_err(enic->netdev,
+				   "MBOX capability check after reset failed: %d\n",
+				   err);
+			return;
+		}
+		err = enic_mbox_vf_register(enic);
+		if (err)
+			netdev_err(enic->netdev,
+				   "MBOX VF re-registration after reset failed: %d\n",
+				   err);
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
@@ -2189,8 +2240,7 @@ static void enic_reset(struct work_struct *work)
 	 * DMAs from the about-to-be-reset rings) and frees the admin resources
 	 * so they are cleanly re-allocated afterwards.
 	 */
-	if (enic_sriov_enabled(enic) &&
-	    enic->vf_type == ENIC_VF_TYPE_V2)
+	if (enic_has_admin_chan(enic))
 		enic_admin_channel_close(enic);
 
 	enic_stop(enic->netdev);
@@ -2204,25 +2254,13 @@ static void enic_reset(struct work_struct *work)
 
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
@@ -2245,8 +2283,7 @@ static void enic_tx_hang_reset(struct work_struct *work)
 	 * the same reason as the soft reset path: stop the admin QP and free
 	 * the admin resources before the hardware queues are wiped.
 	 */
-	if (enic_sriov_enabled(enic) &&
-	    enic->vf_type == ENIC_VF_TYPE_V2)
+	if (enic_has_admin_chan(enic))
 		enic_admin_channel_close(enic);
 
 	enic_dev_hang_notify(enic);
@@ -2261,25 +2298,13 @@ static void enic_tx_hang_reset(struct work_struct *work)
 
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

