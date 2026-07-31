Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54FFF356778;
	Fri, 31 Jul 2026 18:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785524094; cv=none; b=AjL+gHNWQybslIQoYdK8ktc7QnTsMm+KOneLlr1tYjbU8f97/VWGCarbywJjy0eAhGf7hwFuUWt9UYHxHfK9BJ1024nubku0cxEqYiJk2HGNdBuddE0IvjC836ea731VJllSza8UcJMmhBxR6bgCMqLsZM35c0LqjzeOGayT5BU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785524094; c=relaxed/simple;
	bh=4yc/dVdPRFhI77Lm2Uxhikbv84Q8wCVWko+F2/OyKkQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PTLt17vyW3jLKis+1qK5rrDOk7g+edHrH5f016uFB3FVpwTnfBUHsTUY8NNSoa6/oOiKKWwh70c1F2JC2s7gWQTjzgey/wR2Dol1Dz8YUCkSbIvnu2UOurTuG/NkWyOwKOEI6UvTM6XW2MZCDCQdRg6AzHWaeEjkiXZULkePUB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=Nb21d5l+; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="Nb21d5l+"
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66VIgXFO1936949;
	Fri, 31 Jul 2026 11:54:43 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pps82601-s2048-2026-q3; bh=JeaZANGzy
	G/v8IojDVe6pwHuEnZOUnuI7+ku64sFIZk=; b=Nb21d5l+GalHYZCLt+HG3vUqp
	t7H3rZ8iC+Ugj4PKpsoCk2klknqezgcVZJi07zDuv3HiaYZ/q6ksj7YctcCx1QnV
	Rhy9e2OVKzrEqgUo5yzSznbiX/UiN5BG51AQUesGEsk34blkRQIW/ma1NaMbTxmF
	43ffcTF44IoQ3wp7B9t7J6AZEr0JLPRZAEyufpIdYsTPcJw/G5s/+2TzOqniLE81
	S4IUrv2HHlR2nzE+13lkAQ0nyQddQl6Kki8743kv2ZXL3eg1oylcVCKMxJAcm52k
	HoR9XuPvwJclUUrrsfbRYxmtMXcNSLnJMBmwEP7FIKsz+zuoyAN/albCN4s9A==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4fqrkpy5dw-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Fri, 31 Jul 2026 11:54:43 -0700 (PDT)
Received: from localhost (2620:10d:c0a8:1b::2d) by mail.thefacebook.com
 (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.45; Fri, 31 Jul
 2026 18:54:41 +0000
From: Glenn Judd <gmj@meta.com>
To: "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Simon Horman <horms@kernel.org>, Willem de Bruijn <willemb@google.com>,
        Kuniyuki Iwashima <kuniyu@google.com>,
        Richard Gobert
	<richardbgobert@gmail.com>,
        Kees Cook <kees@kernel.org>, Jiayuan Chen
	<jiayuan.chen@linux.dev>,
        <linux-kernel@vger.kernel.org>, Glenn Judd
	<gmj@meta.com>
Subject: [RFC PATCH net-next] net: gro: coalesce padded small IPv4 TCP segments
Date: Fri, 31 Jul 2026 11:54:31 -0700
Message-ID: <20260731185431.2777685-1-gmj@meta.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=E639Y6dl c=1 sm=1 tr=0 ts=6a6cef73 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=tpM8CJlwf7uhpglF1g9U:22 a=VabnemYjAAAA:8 a=wpjR9CCaN7eNxJLqrP4A:9
 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-ORIG-GUID: Oxm0XKeas_E_4j2A_WIRZleF6d5lr0xu
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMxMDE0NCBTYWx0ZWRfXxgZQd1oZhV6/
 WbKHySwWyRuN2TXZ+bTYYu58m6AK0wHOs9/iDORUYR9uWApLG8HO5dKXtMs2N4C5GPK6S2xGHI5
 1TPzuJriT56a/kIn5Ar9OiZahq1/Fk0=
X-Proofpoint-GUID: Oxm0XKeas_E_4j2A_WIRZleF6d5lr0xu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMxMDE0NCBTYWx0ZWRfXxjDCHpLYv2Io
 dqOc7yNr9L/UgL+sSGAbWBlDQe/uZdxzTf8JgiQh5rPMZnSfdgofwD1JKMBQ+YhX2Xf0e2fgXDO
 qw7M+CKgueUbuy2KY2eT7Z7dt1YKoqqjXluwddT8cS17ehSo1IQjLeEN49LJ47cmPkMIL7VRaeX
 U1s56Cs+qYrA0fTk7yB093VTrSBsBQ1VpFTAToDr3upZjNnFQOgdo6zgW9pZdB1AFCA6A/pWuHs
 0Hal9Na2CmKRod+eDyzwttFSuMYTfyWC+22lndyJL7MRsoHMQdmS74NcZcTspjUxJ5jDoSDIoMh
 Zurg4luS3SQGFEG34IolO1v/uDUfGoyiVBYpdYlonmdFeXRfS7dv3V9UtzhOWQqEpl1haCDYk9l
 iAPokYBfy/ZefOJAEG5xN+wjcoMCuM3hjCeii0tuDFtTGc//VQCy3aIYhSdeXPp6H57jBHjNyr6
 +6w/HFTXkA1uM2X7EMg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_06,2026-07-30_01,2025-10-01_01

Software GRO fails to coalesce small IPv4/TCP segment that was
padded up to the 60-byte minimum Ethernet frame.

The selftest tools/testing/selftests/drivers/net/hw/gro.py subtest
sw_ipv4_data_lrg_1byte sends {100, 1} expecting to receive {101}.
In current code, it receives {100, 1} (no coalescing) instead.

Cause: inet_gro_receive() computes its flush term from
tot_len ^ skb_gro_len() before skb_gro_pull(), while skb_gro_len()
still includes trailing Ethernet padding. A small IPv4/TCP segment
padded up to the 60-byte minimum frame has tot_len != skb_gro_len(),
so flush is set and the runt never coalesces.

Assisted-by: Claude:claude-opus-4-8
Assisted-by: Codex:gpt-5.6
Assisted-by: Meta:internal-AI-tooling
Signed-off-by: Glenn Judd <gmj@meta.com>
---

Notes:
    RFC notes
    ---------
    Per Jakub Kicinski, the open question is fast-path cost: this adds two
    operations to the common IPv4 GRO path for every packet -- reading
    iph->tot_len and the skb_gro_len() comparison.  Everything expensive
    (linear check, trim, pointer refresh, csum recompute) is behind unlikely()
    on the slow path.  Is that per-packet cost worth the coalescing win for
    padded runts?
    
    Testing: netdevsim cannot reproduce this -- it never pads short frames to
    ETH_ZLEN -- so sw_ipv4_data_lrg_1byte passes trivially there.  Reproduced
    and fixed on a real NIC (cx7): baseline FAIL -> patched PASS.  Also
    validated locally under KASAN + CONFIG_FAIL_SKB_REALLOC (no UAF).

 net/ipv4/af_inet.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
index 32d006c1a8ee..998ff77fd7b9 100644
--- a/net/ipv4/af_inet.c
+++ b/net/ipv4/af_inet.c
@@ -1470,6 +1470,7 @@ struct sk_buff *inet_gro_receive(struct list_head *head, struct sk_buff *skb)
 	const struct net_offload *ops;
 	struct sk_buff *pp = NULL;
 	const struct iphdr *iph;
+	unsigned int tot_len;
 	struct sk_buff *p;
 	unsigned int hlen;
 	unsigned int off;
@@ -1498,6 +1499,25 @@ struct sk_buff *inet_gro_receive(struct list_head *head, struct sk_buff *skb)
 		goto out;
 
 	NAPI_GRO_CB(skb)->proto = proto;
+
+	tot_len = ntohs(iph->tot_len);
+	if (unlikely(skb_gro_len(skb) > tot_len)) {
+		if (!skb_is_nonlinear(skb)) {
+			if (tot_len < sizeof(*iph) ||
+			    pskb_trim_rcsum(skb, off + tot_len))
+				goto out;
+
+			NAPI_GRO_CB(skb)->frag0 = skb->data;
+			NAPI_GRO_CB(skb)->frag0_len = skb->len;
+			iph = skb_gro_header(skb, hlen, off);
+			if (unlikely(!iph))
+				goto out;
+			if (skb->ip_summed == CHECKSUM_COMPLETE)
+				NAPI_GRO_CB(skb)->csum =
+					skb_checksum(skb, off, tot_len, 0);
+		}
+	}
+
 	flush = (u16)((ntohl(*(__be32 *)iph) ^ skb_gro_len(skb)) | (ntohl(*(__be32 *)&iph->id) & ~IP_DF));
 
 	list_for_each_entry(p, head, list) {

base-commit: 2fbade66245059c78daeaccfce13ecf499fffb51
-- 
2.53.0-Meta

