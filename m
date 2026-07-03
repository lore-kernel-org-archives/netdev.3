Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A44D43A7582
	for <netdev@vger.kernel.org>; Fri,  3 Jul 2026 11:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783076558; cv=none; b=K49ELEAYPqew59oNQWsHHavOz+tx4P8znu92zQysLzBmzJ0EEX6cgvF1GNfC5Dh8cHtCpZecwa12+mrfjzT8B81vsQ8KGmSbjv2vhFXo5phiS2k66WBYj4xyuiXZSMI+xBgzcKtVFU1epgh9TIZzD3qna31UrsnMseW74LxU4Yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783076558; c=relaxed/simple;
	bh=TGEuF42PDykQ9EjGMEr2FOOzgezsc2JoIq5jewYchZI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=OOkIcTJA42UZPoq/nSm8Wo6XdrXbGeozX/hWGpYvUaEWEsBdP7OXW6uZNSHryyJ+6VDhqNMOo2VzZjD/toqlCWGWbhsGSMvSiXEUgepu7ITGjS3BGSaAXcUoG1GEj0uLhyTjjF4K+r89Ez+PWEIy+KKq6Y6bppvE5kTDUT2Svh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LCStCaPn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LCStCaPn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C79C1F000E9;
	Fri,  3 Jul 2026 11:02:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783076556;
	bh=VWY2Crs2joWjAQwhRFf+Tu4H97AY31GvwuXuYsgMjIs=;
	h=From:Date:Subject:To:Cc;
	b=LCStCaPn43su3iXeUQzmDLqFuQZ4oM0kJD2nJAu3aU0wVEKqYwevTzcilprZaa6cr
	 H3xX63A8ilzSfrH/+mjCbQZ48UmflToCkPX//KbVdJM22GnWJoPY4VSJ20ynhvHLE5
	 pYBkH0LoFs6KlytUbhi7HqPqGKoUS1ah4eclgRroLt3i3LpPdRjdTP5cF4iwSTDBfj
	 V8ofktig5E80kpRPUDiuOsZ6vaWt1I5yFMc3twWuFpkHUy0NTv09y44N5tYTj5fjBM
	 WyE//yoFUu7gS2wfIlGgWIbibF3EqCmiO5Lvsxkv/JKJO0/y9RPqp/mDwP/Sk7E3OQ
	 anBQVc9KC1Muw==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Fri, 03 Jul 2026 13:02:17 +0200
Subject: [PATCH net-next] net: airoha: add preliminary support to configure
 tx hw QoS queue during flowtable offloading
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260703-airoha-hw-qos-queue-stub-v1-1-ef253ffdd093@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MQQ7CIBBG4as0s3YSCsaKVzEuUP/KbMAyoE2a3
 l3i8lu8t5GiCJQuw0YFH1HJqWM8DPSIIb3A8uwma+zJTMZxkJJj4PjlJSsvDQ2std3ZOz+NR+f
 8bM/U83fBLOt/faWEyglrpdu+/wAEbzSbdAAAAA==
X-Change-ID: 20260703-airoha-hw-qos-queue-stub-939714339f28
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org, 
 Lorenzo Bianconi <lorenzo@kernel.org>
X-Mailer: b4 0.14.3

Add the plumbing to program the AIROHA_FOE_QID field in the PPE FOE
entry with a per-flow priority value during flowtable offload. This
allows the hardware to steer offloaded flows to a specific QoS queue
on the egress QDMA block for traffic forwarded between two interfaces
via hardware acceleration, bypassing the kernel forwarding path.
The priority parameter is currently always zero because netfilter does
not yet provide a mechanism to pass the skb priority field to the
flowtable offload driver. Once that support is added in the netfilter
subsystem, the driver will be able to extract the priority from the
flow rule and map it to the appropriate hardware queue.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/airoha/airoha_ppe.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/airoha/airoha_ppe.c b/drivers/net/ethernet/airoha/airoha_ppe.c
index e7c78293002a..fdb973fc779c 100644
--- a/drivers/net/ethernet/airoha/airoha_ppe.c
+++ b/drivers/net/ethernet/airoha/airoha_ppe.c
@@ -331,7 +331,7 @@ static int airoha_ppe_foe_entry_prepare(struct airoha_eth *eth,
 					struct airoha_foe_entry *hwe,
 					struct net_device *netdev, int type,
 					struct airoha_flow_data *data,
-					int l4proto)
+					int l4proto, u8 priority)
 {
 	u32 qdata = FIELD_PREP(AIROHA_FOE_SHAPER_ID, 0x7f), ports_pad, val;
 	int wlan_etype = -EINVAL, dsa_port = airoha_get_dsa_port(&netdev);
@@ -386,7 +386,9 @@ static int airoha_ppe_foe_entry_prepare(struct airoha_eth *eth,
 			 */
 			channel = dsa_port >= 0 ? dsa_port : port->id;
 			channel = channel % AIROHA_NUM_QOS_CHANNELS;
-			qdata |= FIELD_PREP(AIROHA_FOE_CHANNEL, channel);
+			priority = priority % AIROHA_NUM_QOS_QUEUES;
+			qdata |= FIELD_PREP(AIROHA_FOE_CHANNEL, channel) |
+				 FIELD_PREP(AIROHA_FOE_QID, priority);
 
 			val |= FIELD_PREP(AIROHA_FOE_IB2_PSE_PORT, pse_port) |
 			       AIROHA_FOE_IB2_PSE_QOS;
@@ -1079,10 +1081,10 @@ static int airoha_ppe_flow_offload_replace(struct airoha_eth *eth,
 	struct airoha_flow_data data = {};
 	struct net_device *odev = NULL;
 	struct flow_action_entry *act;
+	u8 l4proto = 0, priority = 0;
 	struct airoha_foe_entry hwe;
 	int err, i, offload_type;
 	u16 addr_type = 0;
-	u8 l4proto = 0;
 
 	if (rhashtable_lookup(&eth->flow_table, &f->cookie,
 			      airoha_flow_table_params))
@@ -1177,7 +1179,7 @@ static int airoha_ppe_flow_offload_replace(struct airoha_eth *eth,
 		return -EINVAL;
 
 	err = airoha_ppe_foe_entry_prepare(eth, &hwe, odev, offload_type,
-					   &data, l4proto);
+					   &data, l4proto, priority);
 	if (err)
 		return err;
 

---
base-commit: 9507d09b2b8fc775652f5c5670028daa9d83a2bd
change-id: 20260703-airoha-hw-qos-queue-stub-939714339f28

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>

