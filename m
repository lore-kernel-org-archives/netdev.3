Received: from mail-oa2-f35.google.com (mail-oa2-f35.google.com [74.125.231.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4350F1AAE28
	for <netdev@vger.kernel.org>; Sat, 26 Sep 2026 00:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790382350; cv=none; b=nRUUG/oZlkPr4AdHVU+8qgkwmDZC68jzxJRg/udRJAFRsXz7DcxWdV7Wg+oycESIC6MXd5h2m7H5mY4YyHrgronGiTi/OlK0u8Va/l+Qsd3N21L25/szLW+Y4avTf+biFqubZ41NlliLVGvJwTKGTXLLyPMo42O08daOMadGfOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790382350; c=relaxed/simple;
	bh=Czb4sIeAbCCJPF95/qE643OUrS4vUh4CAZV+iCONE3U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B4I+qv9AaARd+3yRPMuSR/dUVy4OJzspmow4JMsSHX3NOl3Mf65IbpmDzj5SBrErT569A1aRB8FjKrOSzwVAfSRZCUoJv6t9bVKYTMhiCierLRulicwP3W7KWfaU5os/tbR6HzNTCgwzZ7eBPgXK2eP/D1wN9rQ0LMNyNiKJDn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=JYfsMQ4a; arc=none smtp.client-ip=74.125.231.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="JYfsMQ4a"
Received: by mail-oa2-f35.google.com with SMTP id 586e51a60fabf-493cf6d8e60so523900fac.3
        for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 17:25:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1790382348; x=1790987148; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WA0WVQvWxa6M/4pweserwp/q0hJsmxeiVcQuaxUpfX0=;
        b=JYfsMQ4aUDaELLvEHtLIJ0TUC6b6M9ZNxmpIuW0RL9xagjEL6bZfJ2WdY3ca7dBAX1
         StrRHGwi1wzLWTsKqIcnQBk4bLz6r+zB9pIgHE0KJ72PfmvJpNqsb0mKXANz+tnlMyvG
         CwoIpfmSSwe5fkk35yg0W8y/6RT426JTmO3Vk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790382348; x=1790987148;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=WA0WVQvWxa6M/4pweserwp/q0hJsmxeiVcQuaxUpfX0=;
        b=R5LHlx8VXPcUjKuf/AXIr6c2O0iZezSMCDwhSoDeEE3ROhDpMeYphWSkKL35VXc+aw
         vbX53qb3UGC8LgZDb1bPiwe7rUimBTdiJzFpAjIucZe7BTec52YlVxTrmaYkg4bGP5Wn
         vh+7L/Aga/kBh9wsts19DjG3IZTcHCSIl8RWyUXuiz4CmQdUdxwt5AgsO33qTpga/l1D
         bJZWtAbzIR/+sT6vRlbaZSlfV0H7ktITLYe4yCxGdE/W0IZq8qpMPD7KqpIIsPdvKgfJ
         CsIeGlWLyqIz1lJRUknPnAr7ncjqO24IdzTWuoU67ObZ6ixpGcOT32bwVxokkxClkwsC
         y9lA==
X-Gm-Message-State: AFuF++kmD4hcQK29vglZnrFcn65ZuSdOo/JGJU0jPHynRMZVD2xCnARp
	ZkBmdkMB8BsTJPBOR8YxtrDQktxl6IPar1tgiTKjK7Hq8KtR15GMhr79RqTJWq8jnxpjJr/nJgi
	wOyHMMfE=
X-Gm-Gg: AYBFou3iiUjijPPn12M3TVOginoFKB5YwNpbSAB/hqV5zTYd8r714fIiPdh6DE54igI
	gcdcfNqrRnsiWzsjPDL+M40jbr/jzd7q0J/SvgQP+rXOoKXz4EWCt0HYTyQfQxSwt/qcL0oKIMC
	fJ9eFvnzmi84Q+szvf/CFmUn5kvBIRq2PbELjYs/UzCQGtx2X1v2eiHZafoDGEmBOJRTyPBvxaU
	kr1GleN9y9G5g/ZRvP27HBMZLBy6w0iHNqcFVmmY1KRM1t8CphR7F2JbmD6SsG+UM8KjPzkGnYd
	s4Vda5Ojlki9RdYS6YHyA4AYxTmUgoi/QRXKlK+/lEUeXzBQrkMUJTZ9X1rLaAs6EjJLg9Ps1nZ
	fJ+7mIEFEkfEkVWs/fO9IFaHycnPUmMFObZcBHwxVS3ONJfhpOuxjOJs4ks3LR2Zcn8Pi+nJgoB
	Z7wHQQmC1X8uxshsuZItLU5fv0f3vVhWwxlu8zYlZ0rH59mgMqjFYeFHjdMkCGXMO3jWYPG+UNp
	6ETViytmVegidNxLMYP7iD4QY+jx16gGT/xBMQilaBz7ffKZSFrFdd4pWiAl2nyuDBFpsVRJNew
	IlPdvIfHSB+zGA==
X-Received: by 2002:a05:6808:138a:b0:4d6:90f3:74b7 with SMTP id 5614622812f47-4dc6778f3eamr4812920b6e.55.1790382348024;
        Fri, 25 Sep 2026 17:25:48 -0700 (PDT)
Received: from com-68297.corp.openai.org ([199.47.143.7])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4dbf6209b83sm3357499b6e.10.2026.09.25.17.25.47
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 25 Sep 2026 17:25:47 -0700 (PDT)
From: nramaswamy@openai.com
To: netdev@vger.kernel.org
Cc: Neil Ramaswamy <nramaswamy@openai.com>
Subject: [PATCH net 1/2] tcp: restore RACK list membership when undoing loss
Date: Fri, 25 Sep 2026 17:25:22 -0700
Message-ID: <20260926002520.42955-5-nramaswamy@openai.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260926002520.42955-4-nramaswamy@openai.com>
References: <20260926002520.42955-4-nramaswamy@openai.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Neil Ramaswamy <nramaswamy@openai.com>

Partial undo can clear the TCPCB_LOST flag on segments already removed from
RACK's list, which prevents subsequent RACK loss detection and can lead to
long retransmission delays. Restoring them to the RACK list allows them to
be reconsidered for fast retransmission in the future. To do this, we first
sort the segments whose lost flag is being cleared, and reinsert them into
the RACK list (which is sorted by transmission time).

Fixes: 043b87d7599e ("tcp: more efficient RACK loss detection")
Signed-off-by: Neil Ramaswamy <nramaswamy@openai.com>
Assisted-by: LLM sparse
---
 net/ipv4/tcp_input.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 92bc60716f33..38ac07c8b38f 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -69,6 +69,7 @@
 #include <linux/module.h>
 #include <linux/sysctl.h>
 #include <linux/kernel.h>
+#include <linux/list_sort.h>
 #include <linux/prefetch.h>
 #include <linux/bitops.h>
 #include <net/dst.h>
@@ -2840,16 +2841,48 @@ static void DBGUNDO(struct sock *sk, const char *msg)
 #endif
 }
 
+static int tcp_rack_skb_cmp(void *priv, const struct list_head *a,
+			    const struct list_head *b)
+{
+	const struct sk_buff *skb_a = list_entry(a, struct sk_buff,
+					       tcp_tsorted_anchor);
+	const struct sk_buff *skb_b = list_entry(b, struct sk_buff,
+					       tcp_tsorted_anchor);
+
+	return tcp_skb_sent_after(tcp_skb_timestamp_us(skb_a),
+				  tcp_skb_timestamp_us(skb_b),
+				  TCP_SKB_CB(skb_a)->end_seq,
+				  TCP_SKB_CB(skb_b)->end_seq);
+}
+
 static void tcp_undo_cwnd_reduction(struct sock *sk, bool unmark_loss)
 {
 	struct tcp_sock *tp = tcp_sk(sk);
 
 	if (unmark_loss) {
+		LIST_HEAD(restored);
 		struct sk_buff *skb;
 
 		skb_rbtree_walk(skb, &sk->tcp_rtx_queue) {
+			if ((TCP_SKB_CB(skb)->sacked & TCPCB_LOST) == TCPCB_LOST)
+				list_move_tail(&skb->tcp_tsorted_anchor, &restored);
 			TCP_SKB_CB(skb)->sacked &= ~TCPCB_LOST;
 		}
+		if (!list_empty(&restored)) {
+			struct list_head *pos = &tp->tsorted_sent_queue;
+
+			/* Ensure lost skbs are added in transmission order */
+			list_sort(NULL, &restored, tcp_rack_skb_cmp);
+			while (!list_empty(&restored)) {
+				struct list_head *entry = restored.next;
+
+				while (pos->next != &tp->tsorted_sent_queue &&
+				       !tcp_rack_skb_cmp(NULL, pos->next, entry))
+					pos = pos->next;
+				list_move(entry, pos);
+				pos = entry;
+			}
+		}
 		tp->lost_out = 0;
 		tcp_clear_all_retrans_hints(tp);
 	}
