Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=124.126.103.232
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793687900;
	b=dkaIDjquoeRVnk8Nfl8+heUgsGWWfLNRUFCF7maD8iaOPrzNPYZnr70o/9FuGrw0Hnlz
	 7DaUKvU47sDfXBVjKZ8ei7F50tycKpOBgux00QDtSealrMgLXPq7+P0hUKYC4IXRtis/G
	 jHEo5BMYno/DdccGNjU61SjxHuY0WeuYVNXHWUboYJrxKx/wuLekY164f/nO7Rn3Cfd2q
	 4Zr1gxKd/MMvVilVEx3F5ixsHHk6yc0mY3QaZ1GdfPBoGE1RPI9hViKpxrvNN9LKl18GD
	 C/5nCgZawGesQqS19GvvE8SXMtzH2rT+lz7Nr99ThNI+eFQh7L1plXXzwV7HyX8T3SQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793687900;
	h=DMARC-Filter:X-UUID:X-CID-P-RULE:X-CID-O-INFO:X-CID-META:X-CID-BVR:
	 X-CID-BAS:X-CID-FACTOR:X-CID-RHF:X-UUID:X-User:Received:From:To:Cc:
	 Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=U10Lg3Uuj9HDiKgG+muoyrZLbcDR5HLVLlJY1XHbmHg=;
	b=CA28FJk+eDpgaG8ZC6pjnKvIgft7i8oizuspOZZOVrIQWT6dP9na2VJH3jQgG6lmTp9b
	 C+7/aNXp0Dc7oGNtiwxr8bgfWGSK1/QBHpHJNW5TW33mPTcde92cESSkbrAjXPnbKzvGp
	 nA3m4iPNO65vq1Nn0IFp5eTrk/TsdlEJzOnLtQLSxcu6Zph8bydUT20nl94x0VQQWMC/T
	 s0DjVmS8ANuTd829x4GH8DKWiRn1Ki29nW5llLsvdKL50H4wURRau+HmTrsstC3VvXQJy
	 MoEM31hgeZMOv/NVxpnCSZFJjQubYKGv1iYot0gxCufnXOKVObR/XwhxC/VsCXaCMow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kylinos.cn;
	spf=pass smtp.mailfrom=kylinos.cn;
	arc=none smtp.remote-ip=124.126.103.232
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAF13606A329;
	Tue,  3 Nov 2026 06:38:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BAF13606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 248174b0d75111f19a56ed5b684f684d-20261103
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:5a87363f-e55e-43e7-9100-5d3e3f144f73,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:7db8b62,CLOUDID:7f1c787a1e9b287f4390f79cddc4a0f1,BulkI
	D:nil,BulkQuantity:0,SF:81|82|102|136|850|865|898,TC:nil,Content:0|15|50|9
	9,EDM:-3|-100,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,O
	SI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 248174b0d75111f19a56ed5b684f684d-20261103
X-User: heminhong@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <heminhong@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 286969116; Tue, 03 Nov 2026 14:38:12 +0800
From: Minhong He <heminhong@kylinos.cn>
To: andrea.mayer@uniroma2.it,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Cc: horms@kernel.org,
	linux-kernel@vger.kernel.org,
	Minhong He <heminhong@kylinos.cn>
Subject: [PATCH net-next 3/3] seg6_local: add USP flavor support to End.X and End.T
Date: Tue,  3 Nov 2026 14:38:06 +0800
Message-Id: <20261103063806.132152-4-heminhong@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261103063806.132152-1-heminhong@kylinos.cn>
References: <20261103063806.132152-1-heminhong@kylinos.cn>
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

RFC 8986 states that the End.X and End.T behaviors support both the
PSP and USP flavors.

The End.X behavior can now take advantage of the flavor action table
mechanism introduced by the previous patch: the 'finish' callback is
set to input_action_end_x_finish() so that the packet is forwarded to
the precomputed L2 adjacency once the SRH has been processed
according to the flavors and the packet info.

The End.T behavior is restructured in the same way as the End.X
behavior:
  - input_action_end_t_finish() takes care of the lookup in the
    routing table specified for the End.T behavior;
  - input_action_end_t_core() implements the "standard" End.T
    behavior;
  - input_action_end_t() routes the packet to the flavor-based
    processing (i.e., end_flv8986_core()) when the PSP and/or USP
    flavors are configured.

Finally, the End.T behavior now accepts the SEG6_LOCAL_FLAVORS
attribute and reports the PSP and USP flavors as supported
operations.

Signed-off-by: Minhong He <heminhong@kylinos.cn>
---
 net/ipv6/seg6_local.c | 52 +++++++++++++++++++++++++++++++++++++------
 1 file changed, 45 insertions(+), 7 deletions(-)

diff --git a/net/ipv6/seg6_local.c b/net/ipv6/seg6_local.c
index 2126a79b1e0c..d14b84571e4f 100644
--- a/net/ipv6/seg6_local.c
+++ b/net/ipv6/seg6_local.c
@@ -136,7 +136,11 @@ struct bpf_lwt_prog {
 
 #define SEG6_LOCAL_END_FLV_SUPP_OPS	(SEG6_F_LOCAL_FLV_NEXT_CSID | \
 					 SEG6_LOCAL_FLV8986_SUPP_OPS)
-#define SEG6_LOCAL_END_X_FLV_SUPP_OPS	SEG6_F_LOCAL_FLV_NEXT_CSID
+#define SEG6_LOCAL_END_X_FLV_SUPP_OPS	(SEG6_F_LOCAL_FLV_NEXT_CSID | \
+					 SEG6_F_LOCAL_FLV_PSP | \
+					 SEG6_F_LOCAL_FLV_USP)
+#define SEG6_LOCAL_END_T_FLV_SUPP_OPS	(SEG6_F_LOCAL_FLV_PSP | \
+					 SEG6_F_LOCAL_FLV_USP)
 
 /* The USD Flavor applies to the SRv6 End behaviors that perform the
  * decapsulation of the packet (e.g., End.DX4, End.DX6, End.DT4, End.DT6,
@@ -591,6 +595,9 @@ static int seg6_flv_supp_ops_by_action(int action, __u32 *fops)
 	case SEG6_LOCAL_ACTION_END_X:
 		*fops = SEG6_LOCAL_END_X_FLV_SUPP_OPS;
 		break;
+	case SEG6_LOCAL_ACTION_END_T:
+		*fops = SEG6_LOCAL_END_T_FLV_SUPP_OPS;
+		break;
 	case SEG6_LOCAL_ACTION_END_DX4:
 	case SEG6_LOCAL_ACTION_END_DX6:
 	case SEG6_LOCAL_ACTION_END_DT4:
@@ -993,14 +1000,31 @@ static int input_action_end_x(struct sk_buff *skb, struct seg6_local_lwt *slwt)
 	const struct seg6_flavors_info *finfo = &slwt->flv_info;
 	__u32 fops = finfo->flv_ops;
 
+	if (!fops)
+		return input_action_end_x_core(skb, slwt);
+
 	/* check for the presence of NEXT-C-SID since it applies first */
 	if (seg6_next_csid_enabled(fops))
 		return end_x_next_csid_core(skb, slwt);
 
-	return input_action_end_x_core(skb, slwt);
+	/* the specific processing function to be performed on the packet
+	 * depends on the combination of flavors defined in RFC8986 and some
+	 * information extracted from the packet, e.g. presence/absence of SRH,
+	 * Segment Left = 0, etc.
+	 */
+	return end_flv8986_core(skb, slwt, input_action_end_x_finish);
 }
 
-static int input_action_end_t(struct sk_buff *skb, struct seg6_local_lwt *slwt)
+static int input_action_end_t_finish(struct sk_buff *skb,
+				     struct seg6_local_lwt *slwt)
+{
+	seg6_lookup_nexthop(skb, NULL, slwt->table);
+
+	return dst_input(skb);
+}
+
+static int input_action_end_t_core(struct sk_buff *skb,
+				   struct seg6_local_lwt *slwt)
 {
 	enum skb_drop_reason reason = SKB_DROP_REASON_NOT_SPECIFIED;
 	struct ipv6_sr_hdr *srh;
@@ -1016,15 +1040,28 @@ static int input_action_end_t(struct sk_buff *skb, struct seg6_local_lwt *slwt)
 		goto drop;
 	}
 
-	seg6_lookup_nexthop(skb, NULL, slwt->table);
-
-	return dst_input(skb);
+	return input_action_end_t_finish(skb, slwt);
 
 drop:
 	kfree_skb_reason(skb, reason);
 	return err;
 }
 
+static int input_action_end_t(struct sk_buff *skb, struct seg6_local_lwt *slwt)
+{
+	const struct seg6_flavors_info *finfo = &slwt->flv_info;
+	__u32 fops = finfo->flv_ops;
+
+	/* The End.T behavior supports the PSP and USP flavors. In all the
+	 * cases where these flavors do not apply (i.e., SRH with SL > 1),
+	 * the packet is processed as the "standard" End.T behavior.
+	 */
+	if (fops & (SEG6_F_LOCAL_FLV_PSP | SEG6_F_LOCAL_FLV_USP))
+		return end_flv8986_core(skb, slwt, input_action_end_t_finish);
+
+	return input_action_end_t_core(skb, slwt);
+}
+
 /* decapsulate and forward inner L2 frame on specified interface */
 static int input_action_end_dx2(struct sk_buff *skb,
 				struct seg6_local_lwt *slwt)
@@ -1716,7 +1753,8 @@ static struct seg6_action_desc seg6_action_table[] = {
 	{
 		.action		= SEG6_LOCAL_ACTION_END_T,
 		.attrs		= SEG6_F_ATTR(SEG6_LOCAL_TABLE),
-		.optattrs	= SEG6_F_LOCAL_COUNTERS,
+		.optattrs	= SEG6_F_LOCAL_COUNTERS |
+				  SEG6_F_LOCAL_FLAVORS,
 		.input		= input_action_end_t,
 	},
 	{
-- 
2.25.1

