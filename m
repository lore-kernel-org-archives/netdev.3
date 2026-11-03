Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=124.126.103.232
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793687900;
	b=NmQuj38NZTo6ekXwp4Q5ijVxw9IdsRRwUs6H+Vmty2E7OA4N5oxabHC6FMnsF4FSl+Q5
	 UhzuSstJj67aGPK1pkYE40VI+lcvDDdfEu2cUsLCSoopXbbMw0iB/TWmisOZ6Qw71ySdf
	 8zuwvVwQdtiZBCvZLqNtR5tvBOPNGlXo0dwieD8+IJOYgNjmY/8P0UoXDO32Myse3FGf+
	 hAISaFPSS3qyChtz5Ak8rtiqvUhnAFC9evi5jxSJk8fxP26/QZ9kNzQ3L/gmUAyKlM6D4
	 a6we9aYn/wDzjPajw+3DyzgX3NzxqqbV7b3sfGU/RvGI7ms5xtWj0D4UgduXeuCTslQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793687900;
	h=DMARC-Filter:X-UUID:X-CID-P-RULE:X-CID-O-INFO:X-CID-META:X-CID-BVR:
	 X-CID-BAS:X-CID-FACTOR:X-CID-RHF:X-UUID:X-User:Received:From:To:Cc:
	 Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=YlkXOgY7FLTmwO6B7gfUyRfCRIiIrQERZY594ByRBbM=;
	b=rhJ47qn+1L8QJiAEvOt3wG+MDCIgJkhT3S82tk29SdTTGsA1O9mDzctx0txWtKr2FkWv
	 lS27CJIaJ4FjRtMpjNWcUAY/+y1DAkqJHLAw5WOP20DSytrAFLnRdpSpZKn49AzAhBu/8
	 SwE/cpBH6M3uj0HHPnpE0XwTz6WsBCBNT2luh8cvWdDeSDdtHzetLEU1Ph9avONgkB/Cx
	 dxiIXpqJYY5wMHncyPXgbZo4eL+ZrW+ByK1RwPjjYrE0RmMOt3cXdeD9hy5UDSALAdiJ4
	 MPFyI0qfpvrh8JUePOm7P2hsIiZpsBDAfF7g8+1AAqN+U22ZMxvJAzYugz7vKweGm5Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kylinos.cn;
	spf=pass smtp.mailfrom=kylinos.cn;
	arc=none smtp.remote-ip=124.126.103.232
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E199606A32C;
	Tue,  3 Nov 2026 06:38:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2E199606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 2402afc2d75111f19a56ed5b684f684d-20261103
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:5395de8c-30f3-43f0-9e2d-de9c4cd831a8,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:7db8b62,CLOUDID:48962d0519032c45037a939ee45e9188,BulkI
	D:nil,BulkQuantity:0,SF:81|82|102|136|850|865|898,TC:nil,Content:0|15|50|9
	9,EDM:-3|-100,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,O
	SI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 2402afc2d75111f19a56ed5b684f684d-20261103
X-User: heminhong@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <heminhong@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1127997084; Tue, 03 Nov 2026 14:38:12 +0800
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
Subject: [PATCH net-next 2/3] seg6_local: support USD flavor for decap behaviors
Date: Tue,  3 Nov 2026 14:38:05 +0800
Message-Id: <20261103063806.132152-3-heminhong@kylinos.cn>
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

RFC 8986 defines the USD (Ultimate Segment Decapsulation) flavor for
the SRv6 End behaviors that perform the decapsulation of the packet
(i.e., End.DX4, End.DX6, End.DT4, End.DT6, End.DT46).

Since these behaviors already remove the outer IPv6 header (and, as a
consequence, the SRH too) as part of the decapsulation process, the
USD flavor requires no additional processing on the data plane with
respect to the "standard" behaviors.

For this reason, the USD flavor is only supported at the control
plane level: this way, the behaviors accept the SEG6_LOCAL_FLAVORS
attribute carrying the USD flavor, making the kernel fully compliant
with the control planes (e.g., IS-IS, BGP-LS) which can advertise
SIDs with the USD flavor.

Note that the USD flavor does not appear in the
SEG6_LOCAL_FLV8986_SUPP_OPS bitmask since it is not processed through
the flavor action table. Instead, a new bitmask
(SEG6_LOCAL_END_DECAP_FLV_SUPP_OPS) is defined and used to report the
set of flavor operations supported by the decap behaviors.

Signed-off-by: Minhong He <heminhong@kylinos.cn>
---
 net/ipv6/seg6_local.c | 52 ++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 46 insertions(+), 6 deletions(-)

diff --git a/net/ipv6/seg6_local.c b/net/ipv6/seg6_local.c
index bb5a0ccc3532..2126a79b1e0c 100644
--- a/net/ipv6/seg6_local.c
+++ b/net/ipv6/seg6_local.c
@@ -116,6 +116,7 @@ struct bpf_lwt_prog {
 #define SEG6_F_LOCAL_FLV_NEXT_CSID	SEG6_F_LOCAL_FLV_OP(NEXT_CSID)
 #define SEG6_F_LOCAL_FLV_PSP		SEG6_F_LOCAL_FLV_OP(PSP)
 #define SEG6_F_LOCAL_FLV_USP		SEG6_F_LOCAL_FLV_OP(USP)
+#define SEG6_F_LOCAL_FLV_USD		SEG6_F_LOCAL_FLV_OP(USD)
 
 /* Supported RFC8986 Flavor operations are reported in this bitmask.
  *
@@ -124,6 +125,11 @@ struct bpf_lwt_prog {
  * data plane. For this reason, it contains only the Flavor operations
  * (i.e., PSP and USP) that are supported by the SRv6 End behaviors
  * which rely on such a table for the processing of the packets.
+ *
+ * The USD Flavor does not appear in this bitmask since it applies to
+ * SRv6 End behaviors that perform decapsulation. Such behaviors do not
+ * make use of the action table: see SEG6_LOCAL_END_DECAP_FLV_SUPP_OPS
+ * for more details.
  */
 #define SEG6_LOCAL_FLV8986_SUPP_OPS	(SEG6_F_LOCAL_FLV_PSP | \
 					 SEG6_F_LOCAL_FLV_USP)
@@ -132,6 +138,18 @@ struct bpf_lwt_prog {
 					 SEG6_LOCAL_FLV8986_SUPP_OPS)
 #define SEG6_LOCAL_END_X_FLV_SUPP_OPS	SEG6_F_LOCAL_FLV_NEXT_CSID
 
+/* The USD Flavor applies to the SRv6 End behaviors that perform the
+ * decapsulation of the packet (e.g., End.DX4, End.DX6, End.DT4, End.DT6,
+ * End.DT46).
+ * In this case, the removal of the SRH is carried out as part of the
+ * decapsulation process and, therefore, no additional processing is
+ * required on the data plane with respect to the "standard" behaviors.
+ * The Flavor is reported to user space only for completeness and to
+ * ease the interoperability with control planes (e.g., IS-IS, BGP)
+ * which can advertise SIDs with the USD Flavor.
+ */
+#define SEG6_LOCAL_END_DECAP_FLV_SUPP_OPS	SEG6_F_LOCAL_FLV_USD
+
 struct seg6_flavors_info {
 	/* Flavor operations */
 	__u32 flv_ops;
@@ -573,6 +591,22 @@ static int seg6_flv_supp_ops_by_action(int action, __u32 *fops)
 	case SEG6_LOCAL_ACTION_END_X:
 		*fops = SEG6_LOCAL_END_X_FLV_SUPP_OPS;
 		break;
+	case SEG6_LOCAL_ACTION_END_DX4:
+	case SEG6_LOCAL_ACTION_END_DX6:
+	case SEG6_LOCAL_ACTION_END_DT4:
+	case SEG6_LOCAL_ACTION_END_DT6:
+	case SEG6_LOCAL_ACTION_END_DT46:
+		/* the USD flavor applies to the SRv6 End behaviors that
+		 * decapsulate the packet. Since such behaviors already
+		 * remove the outer IPv6 header (and, as a consequence, the
+		 * SRH too) as part of the decapsulation process, the USD
+		 * flavor requires no additional processing on the data
+		 * plane. The flavor is supported for completeness and to
+		 * ease the interoperability with control planes that may
+		 * advertise SIDs with the USD flavor.
+		 */
+		*fops = SEG6_LOCAL_END_DECAP_FLV_SUPP_OPS;
+		break;
 	default:
 		return -EOPNOTSUPP;
 	}
@@ -1694,19 +1728,22 @@ static struct seg6_action_desc seg6_action_table[] = {
 	{
 		.action		= SEG6_LOCAL_ACTION_END_DX6,
 		.attrs		= SEG6_F_ATTR(SEG6_LOCAL_NH6),
-		.optattrs	= SEG6_F_LOCAL_COUNTERS,
+		.optattrs	= SEG6_F_LOCAL_COUNTERS |
+				  SEG6_F_LOCAL_FLAVORS,
 		.input		= input_action_end_dx6,
 	},
 	{
 		.action		= SEG6_LOCAL_ACTION_END_DX4,
 		.attrs		= SEG6_F_ATTR(SEG6_LOCAL_NH4),
-		.optattrs	= SEG6_F_LOCAL_COUNTERS,
+		.optattrs	= SEG6_F_LOCAL_COUNTERS |
+				  SEG6_F_LOCAL_FLAVORS,
 		.input		= input_action_end_dx4,
 	},
 	{
 		.action		= SEG6_LOCAL_ACTION_END_DT4,
 		.attrs		= SEG6_F_ATTR(SEG6_LOCAL_VRFTABLE),
-		.optattrs	= SEG6_F_LOCAL_COUNTERS,
+		.optattrs	= SEG6_F_LOCAL_COUNTERS |
+				  SEG6_F_LOCAL_FLAVORS,
 #ifdef CONFIG_NET_L3_MASTER_DEV
 		.input		= input_action_end_dt4,
 		.slwt_ops	= {
@@ -1720,20 +1757,23 @@ static struct seg6_action_desc seg6_action_table[] = {
 		.attrs		= 0,
 		.optattrs	= SEG6_F_LOCAL_COUNTERS		|
 				  SEG6_F_ATTR(SEG6_LOCAL_TABLE) |
-				  SEG6_F_ATTR(SEG6_LOCAL_VRFTABLE),
+				  SEG6_F_ATTR(SEG6_LOCAL_VRFTABLE) |
+				  SEG6_F_LOCAL_FLAVORS,
 		.slwt_ops	= {
 					.build_state = seg6_end_dt6_build,
 				  },
 #else
 		.attrs		= SEG6_F_ATTR(SEG6_LOCAL_TABLE),
-		.optattrs	= SEG6_F_LOCAL_COUNTERS,
+		.optattrs	= SEG6_F_LOCAL_COUNTERS |
+				  SEG6_F_LOCAL_FLAVORS,
 #endif
 		.input		= input_action_end_dt6,
 	},
 	{
 		.action		= SEG6_LOCAL_ACTION_END_DT46,
 		.attrs		= SEG6_F_ATTR(SEG6_LOCAL_VRFTABLE),
-		.optattrs	= SEG6_F_LOCAL_COUNTERS,
+		.optattrs	= SEG6_F_LOCAL_COUNTERS |
+				  SEG6_F_LOCAL_FLAVORS,
 #ifdef CONFIG_NET_L3_MASTER_DEV
 		.input		= input_action_end_dt46,
 		.slwt_ops	= {
-- 
2.25.1

