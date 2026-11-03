Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=124.126.103.232
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793687902;
	b=qH9V5Wtzd1AH8Cvq9QhiKG+nrMiXXNqDkzWLS8WBVyai+dPrvPBAI0qRXA3rZVa8wtfW
	 tX49iWDJbhw8kANzFtgWJ+1+wSA7kXjZgk81bjOdbFJiCeTyF3FkeJYpIeq9+xE+kTVka
	 DjuCpQtN3sArX+RW8cc16+puU9fprqueOrqzedvAwU7MsfnxENfccMgsGAeExOo2VrO9G
	 FWzZeo24kxzNDgiysvB/omcPCCmXhFUUk8i15ldoJkXOShIYO94rOGLpg6U77XLxcmGB7
	 MK5o249xVEHHSoFSr8ZpgCRKD4LHg7vqrLeUbxkhFqeOO1BmWAcyRKOO4Cg88WElttA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793687902;
	h=DMARC-Filter:X-UUID:X-CID-P-RULE:X-CID-O-INFO:X-CID-META:X-CID-BVR:
	 X-CID-BAS:X-CID-FACTOR:X-CID-RHF:X-UUID:X-User:Received:From:To:Cc:
	 Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=u0PQ3X1QFqSWXGwTEIM5D7bk3EdGps2VFuR1BteCo1o=;
	b=DlpKolHYpPtgSsuZLSCyQceAm+IYydNAci6IHbsFeX46+VKfDSXyeqQHUSXImJxeTFOp
	 Fd3tl8SHfBogdoHmXErZ36FnUAitcOcT2NSKq2VawQajnmVIRnIovicCGS72YgMxGauru
	 0BpqsnmUkH/pm8peN4zpk/eLz5o4nTE4dfRreK9xgv5S5RSa7G5vQR6lteoEtfn20hG0l
	 RT/Uliula7JAFpRWFHoSkg+knIvZP3TNSngX8xpA1ligpzPbVGG0XGSrYnuAuk2A+acqJ
	 pCqhAxPPTZYpPFYcNzWRwZAT4/gYLPH/FtVGq/y2XOmxP3VVIVBr+N7VG1R7ea9Z0gw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kylinos.cn;
	spf=pass smtp.mailfrom=kylinos.cn;
	arc=none smtp.remote-ip=124.126.103.232
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D73B606A334;
	Tue,  3 Nov 2026 06:38:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8D73B606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 23cad3c2d75111f19a56ed5b684f684d-20261103
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:2374e1c7-1df1-402a-8c43-53481bd1cd1a,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:7db8b62,CLOUDID:c58d9c0f5773b524a6ab41106628816c,BulkI
	D:nil,BulkQuantity:0,SF:81|82|102|850|865|898,TC:nil,Content:0|15|50|99,ED
	M:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:
	0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 23cad3c2d75111f19a56ed5b684f684d-20261103
X-User: heminhong@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <heminhong@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 453821182; Tue, 03 Nov 2026 14:38:11 +0800
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
Subject: [PATCH net-next 1/3] seg6_local: implement USP flavor for the End behavior
Date: Tue,  3 Nov 2026 14:38:04 +0800
Message-Id: <20261103063806.132152-2-heminhong@kylinos.cn>
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

RFC 8986 defines the USP (Ultimate Segment Pop of the SRH) flavor
which requires the SRH to be removed by the ultimate segment of the
SRv6 path, i.e., the segment identified by the DA of the packet with
Segments Left == 0.

Currently, the End behavior only supports the PSP flavor. Let's add
support for the USP flavor by:

  - extending the set of supported RFC 8986 flavor operations with
    the USP flavor (SEG6_F_LOCAL_FLV_USP);

  - enriching the flavor action table with the entries required to
    process the combinations of packet info (i.e., SRH with SL=0,
    SL=1, SL>1) and the USP flavor (either alone or combined with
    the PSP flavor).

The processing of the USP flavor is carried out by extending the
end_flv8986_core() function with a new 'finish' callback, which
performs the "final" processing of the packet depending on the
specific End* behavior (e.g., nexthop lookup for the End behavior).
This also allows the function to be reused by other End* behaviors
in follow-up patches.

Signed-off-by: Minhong He <heminhong@kylinos.cn>
---
 net/ipv6/seg6_local.c | 59 ++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 52 insertions(+), 7 deletions(-)

diff --git a/net/ipv6/seg6_local.c b/net/ipv6/seg6_local.c
index 0d952514d095..bb5a0ccc3532 100644
--- a/net/ipv6/seg6_local.c
+++ b/net/ipv6/seg6_local.c
@@ -115,9 +115,18 @@ struct bpf_lwt_prog {
 #define SEG6_F_LOCAL_FLV_OP(flvname)	BIT(SEG6_LOCAL_FLV_OP_##flvname)
 #define SEG6_F_LOCAL_FLV_NEXT_CSID	SEG6_F_LOCAL_FLV_OP(NEXT_CSID)
 #define SEG6_F_LOCAL_FLV_PSP		SEG6_F_LOCAL_FLV_OP(PSP)
+#define SEG6_F_LOCAL_FLV_USP		SEG6_F_LOCAL_FLV_OP(USP)
 
-/* Supported RFC8986 Flavor operations are reported in this bitmask */
-#define SEG6_LOCAL_FLV8986_SUPP_OPS	SEG6_F_LOCAL_FLV_PSP
+/* Supported RFC8986 Flavor operations are reported in this bitmask.
+ *
+ * The bitmask is used as a mask for the RFC8986 Flavor operations that
+ * can be processed through the action table (flv8986_act_tbl) on the
+ * data plane. For this reason, it contains only the Flavor operations
+ * (i.e., PSP and USP) that are supported by the SRv6 End behaviors
+ * which rely on such a table for the processing of the packets.
+ */
+#define SEG6_LOCAL_FLV8986_SUPP_OPS	(SEG6_F_LOCAL_FLV_PSP | \
+					 SEG6_F_LOCAL_FLV_USP)
 
 #define SEG6_LOCAL_END_FLV_SUPP_OPS	(SEG6_F_LOCAL_FLV_NEXT_CSID | \
 					 SEG6_LOCAL_FLV8986_SUPP_OPS)
@@ -664,6 +673,7 @@ enum seg6_local_flv_action {
 
 /* shorthand for improving readability */
 #define F_PSP	SEG6_F_LOCAL_FLV_PSP
+#define F_USP	SEG6_F_LOCAL_FLV_USP
 
 /* The table contains, for each combination of the pktinfo data and
  * flavors, the action that should be taken on a packet (e.g.
@@ -674,13 +684,32 @@ enum seg6_local_flv_action {
  * discarding the processed packet.
  */
 static const u8 flv8986_act_tbl[FLV8986_ACT_TBL_SIZE] = {
-	/* PSP variant for packet where SRH with SL = 1 */
+	/* PSP flavor: the penultimate segment pops the outer SID
+	 * (i.e., the Segment Left pointer) from the SRH.
+	 */
 	tbl_cfg(PSP, SL_ONE, F_PSP),
-	/* End for packet where the SRH with SL > 1*/
 	tbl_cfg(END, SL_MORE, F_PSP),
+
+	/* USP flavor: the ultimate (i.e., final) segment of the SRv6 path
+	 * removes the SRH from the packet. In all the other cases, the
+	 * packet is processed as the "standard" End behavior.
+	 */
+	tbl_cfg(END, SL_ONE, F_USP),
+	tbl_cfg(END, SL_MORE, F_USP),
+	tbl_cfg(USP, SL_ZERO, F_USP),
+
+	/* When the PSP and USP flavors are combined, the PSP operation
+	 * takes place if SL=1 (i.e., the node is the penultimate segment),
+	 * while the USP operation is applied when SL=0 (i.e., the node is
+	 * the final segment of the SRv6 path).
+	 */
+	tbl_cfg(PSP, SL_ONE, F_PSP | F_USP),
+	tbl_cfg(END, SL_MORE, F_PSP | F_USP),
+	tbl_cfg(USP, SL_ZERO, F_PSP | F_USP),
 };
 
 #undef F_PSP
+#undef F_USP
 #undef tbl_cfg
 
 /* For each flavor defined in RFC8986 (or a combination of them) an action is
@@ -823,8 +852,15 @@ static bool seg6_pop_srh(struct sk_buff *skb, int srhoff)
 
 /* process the packet on the basis of the RFC8986 flavors set for the given
  * SRv6 End behavior instance.
+ *
+ * The @finish callback takes care of the "final" processing of the packet,
+ * which depends on the specific End* behavior. For instance, the End
+ * behavior performs a nexthop lookup in the default routing table, while
+ * the End.X behavior forwards the packet to the precomputed L2 adjacency.
  */
-static int end_flv8986_core(struct sk_buff *skb, struct seg6_local_lwt *slwt)
+static int end_flv8986_core(struct sk_buff *skb, struct seg6_local_lwt *slwt,
+			    int (*finish)(struct sk_buff *skb,
+					  struct seg6_local_lwt *slwt))
 {
 	enum skb_drop_reason reason = SKB_DROP_REASON_NOT_SPECIFIED;
 	const struct seg6_flavors_info *finfo = &slwt->flv_info;
@@ -871,6 +907,15 @@ static int end_flv8986_core(struct sk_buff *skb, struct seg6_local_lwt *slwt)
 		if (unlikely(!seg6_pop_srh(skb, srhoff)))
 			goto drop;
 		break;
+	case SEG6_LOCAL_FLV_ACT_USP:
+		/* the node is the final segment of the SRv6 path: remove
+		 * the SRH from the packet without updating the IPv6 DA,
+		 * which is already pointing to the last SID (i.e.,
+		 * Segments[0]).
+		 */
+		if (unlikely(!seg6_pop_srh(skb, srhoff)))
+			goto drop;
+		break;
 	case SEG6_LOCAL_FLV_ACT_UNSPEC:
 		fallthrough;
 	default:
@@ -880,7 +925,7 @@ static int end_flv8986_core(struct sk_buff *skb, struct seg6_local_lwt *slwt)
 		goto drop;
 	}
 
-	return input_action_end_finish(skb, slwt);
+	return finish(skb, slwt);
 
 drop:
 	kfree_skb_reason(skb, reason);
@@ -905,7 +950,7 @@ static int input_action_end(struct sk_buff *skb, struct seg6_local_lwt *slwt)
 	 * information extracted from the packet, e.g. presence/absence of SRH,
 	 * Segment Left = 0, etc.
 	 */
-	return end_flv8986_core(skb, slwt);
+	return end_flv8986_core(skb, slwt, input_action_end_finish);
 }
 
 /* regular endpoint, and forward to specified nexthop */
-- 
2.25.1

