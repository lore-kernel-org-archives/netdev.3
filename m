Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.33
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792506656;
	b=ba+HETFUkUY5LcKJeUjjBtUpsqP+DJqR67xQsbLWz7I2/qqLBhfByT9YYRelcX07FERf
	 VDxu+sJu1Ct7PCn+8PEo08kJ++BBaJPutSc/fgWS8rtM/9iDNby1vdnlDEb2ONFG2RDw6
	 ok6sShK2MNoHZ3AH49brnovJjwzxNsiDO1r7oPn1rX9I/0mEcsAXaFHIZMk5FEW/ShEu5
	 qF9oGs9N7oH3GbfKBO211yRIt2Jt/NzDH7giou3usMrSGpI3nZ3zF49T0I59fpRaa9lEV
	 rykkLAiKGOwbRsiJmu48uAkuzd59AWyy3sLzrdp0/KME8eKqrwf8YfHY5KBn8ADTxlA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792506656;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=Kjv9P6jh7n80KmQTVviZB7f96Of0OPau+dzZLCspckQ=;
	b=W90C5Xi/Xmo7P8EDWfVH6dD4WFAb2h2NN03kSRpFJg9QkZ6NAX283Z/9VkoA0Y4sENCa
	 He7mUt5hJH7vkFrNBmfc4szQi6RbfKDd8t2bLc9MWnmsgNlrQoOAzB8dADlQ11yhkfeCZ
	 INsvNXlzo/c3q32hDAC+1eqq4x7FFR8k+Rui2hSk85LwJAoayKJYHPp4R8w386+7dcYxJ
	 pQZCExPcs8hhUaZ/svnOlagLumwbcsXaU4Us0WaxP8huBdk9FDMzQ6q959S/QheaSk0q8
	 Oe85Z1NCv0BTEf1RLGa6yW+8tRDy15g5JCk1Ee7mG8v5/bumrbz/E5oD9PvZZ1/O3ng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=V9KmQD36;
	arc=none smtp.remote-ip=91.218.175.33
Received: from mta0.migadu.com (out-33.mta0.migadu.com [91.218.175.33])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FB97606A31F
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 14:30:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0FB97606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=V9KmQD36
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=Ym7fuUE5bda8YR8vTMQIuvc+NuQU+bNetmk10VNyjek=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792506653; v=1; x=1793111453;
 b=V9KmQD36F+81Q1izwnngyc8XLeKXqVKHzeaol2Bdwh7IuqEMffVjJ529g0q7ue6k6oL9TNCC
 a0T4Di4UTY4xMZ2SZh24A7LweMmy/samdGxgC7Oyx6tuRCCtUbZ4unKqiGGcbAS/kK8iuhT6LXi
 o8VDieIOZ3XLGff2/4szLtNE=
X-Envelope-To: netdev@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 7487264007fe2945;
	Tue, 20 Oct 2026 14:30:38 +0000
X-Mizu-Trace-ID: 7487264007fe2945
X-Migadu-Flow: FLOW_OUT
From: Qingfang Deng <qingfang.deng@linux.dev>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Stanislav Fomichev <sdf.kernel@gmail.com>,
	Hangbin Liu <liuhangbin@gmail.com>,
	Martin Karsten <mkarsten@uwaterloo.ca>,
	Felix Fietkau <nbd@nbd.name>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Pablo Neira Ayuso <pablo@netfilter.org>
Subject: [RFC net] net: force software segmentation of PPPoE packets
Date: Tue, 20 Oct 2026 22:30:30 +0800
Message-Id: <20261020143031.1829-1-qingfang.deng@linux.dev>
X-Mailer: git-send-email 2.34.1
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

Ordinary TSO does not update the PPPoE payload length. A PPPoE GRO packet
forwarded by a bridge can retain hardware GSO features and reach the
driver without software segmentation, if the egress Ethernet interface
advertises TSO.

To force software segmentation, clear the GSO feature mask for
ETH_P_PPP_SES in harmonize_features().

Fixes: 55a5d8fca836 ("net: pppoe: implement GRO/GSO support")
Signed-off-by: Qingfang Deng <qingfang.deng@linux.dev>
---
 net/core/dev.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/core/dev.c b/net/core/dev.c
index a6951ea08961..27483a2ad747 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -3831,6 +3831,10 @@ static netdev_features_t harmonize_features(struct sk_buff *skb,
 	type = skb_network_protocol(skb, NULL);
 	features = net_mpls_features(skb, features, type);
 
+	/* Ordinary TSO does not update the PPPoE payload length. */
+	if (IS_ENABLED(CONFIG_PPPOE) && type == htons(ETH_P_PPP_SES))
+		features &= ~NETIF_F_GSO_MASK;
+
 	if (skb->ip_summed != CHECKSUM_NONE &&
 	    !can_checksum_protocol(features, type)) {
 		features &= ~(NETIF_F_CSUM_MASK | NETIF_F_GSO_MASK);
-- 
2.34.1

