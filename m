Received: from mail-pj2-f9.google.com (mail-pj2-f9.google.com [74.125.227.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECD81313E03
	for <netdev@vger.kernel.org>; Sat,  3 Oct 2026 14:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791037054; cv=none; b=GjXE589D2pq2Z1wjx6bm90XhzJPJV6L7BHK9a/CDJ1VIDGq6mPiEzKSjEDf0LemcaopBxYOrG0MS7/tYZ/XBUAFhfOu2ItVB9cdzILeNG0YsH0KZIe3S0dQuFmdYPI11LCAJ12nNetc90TpxYobob8AQvVANZ8yHMnSDDyN84tQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791037054; c=relaxed/simple;
	bh=4zLo0UbKSEICGkFKan5yv8Z26l3uVHBjePen8rFMVm8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=q7NtG/DgNK7frz9FLJYw/nUPNy2wFdU6wjmHYHV8WDYASkmbyAvLS1k1QKQOCWVTduoPP8QBJS7F0buIxa5OzWMHRsExMiK9umT1aoPo3MDTP0XmSvFxCYm+sTglFHKlzva/6fdB4Le8m8t7daIkQ/AFEtoyxisi27J2uLAJzSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HC3qb5X6; arc=none smtp.client-ip=74.125.227.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HC3qb5X6"
Received: by mail-pj2-f9.google.com with SMTP id 98e67ed59e1d1-3a51696a650so305278a91.1
        for <netdev@vger.kernel.org>; Sat, 03 Oct 2026 07:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791037052; x=1791641852; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=XE7zmJjii7x1F8lw11kuc/7tPw1OpeRSYZ1+GJGjbo8=;
        b=HC3qb5X6TcW/BWkOmLcEHVBQoq4xrh/3P0kEsEbeIW+M92gPIbi3sHkHQyG21A590J
         4CbCWUSj07ZhzJTBK6OpBplS+zh4KIHoVhDCf5kdRgccSesZfG19rqbLfycEmx+/0k98
         raQpYwXs78lqLva3gwt2CDwcMYfDm10+tsCiNuDYhVT++y/iokFZrg29y2J4gIIgm4FV
         M9aP/S9v2Kmuk+/Bd/q6+lmRGXeURNSIMDatqYRZ5BHeiyIRDk9xq+hkjSBdGztxfKZs
         5MBoYwe73BdclOz1rHw5WgiMUKALtOHlIhl0grVRd9cxbrh7bKSXnBP38siWX3wCdAnR
         3S5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791037052; x=1791641852;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XE7zmJjii7x1F8lw11kuc/7tPw1OpeRSYZ1+GJGjbo8=;
        b=oNUOOdcgM+qVBHSUBoL3IOgvK97axi+NkGOwmf8kcR2Ri9oDyG05AVFJvd1FOMKzG3
         MWRhuKO1j6RQEliG56lqBP3Hen+YRpdLe99Hc6fDIRdOJG3xoMVbviaNX83byosSPCUl
         5e9fnRWb6TFdq8MfxrajmkTRqvFRkFfpRSYoXJu9dU/xLYE9aEGBKFAVbpZvwDWjmCVH
         aUyLDcz/+3ZeZuZwGhZdybr3wbeZ7cYhcnuiFoJCy2zV0rnmfUxrglEKgMo/Nsx6VchZ
         yOpyJSb5gVYyEoAlBN85lDSusrN/bZGaJA6AT/ThE6bkw8QaxjZ7vtG/wDftFXChW1pS
         pbfA==
X-Gm-Message-State: AFq9FYIRFwyGtxSt2Wr83UObXF04AmQCWXuxEW4ZKhxwss/VMIu6Yca/
	wwcvnx/H6LXstbqHE1bjZ4oMPwqBPPrhNtSvYAzHNXwDNG3LLDj97gPL/9tpx51TpkAO0A==
X-Gm-Gg: AYBFou16SChH1WL2dnCnss2kY+Zg2sOxFX/ddLDlDrZDiMLfldF9s9WdcZ3/0LZqwgt
	f2xdRaInbaTcNPpgAX5UHPwXjCfhORXGnHGXJXe5uQjLgw7Qj9sRLuCadPptZmyVgyoEmYY7T0k
	eydfITut3jEWuk68oLWmszP/qgczYVTCH7u7kjWEz13Ieay0/ryyepWnAZ9ZJNL6xqi9EqHYZp/
	vaLFbQVfp8ZGsiDXvIxfjlvpl0jiVJmATlPPFApORHQO/Dg7IE7Ts7sL6RAQTVBA/Pmo3DzeMP6
	9Up3w5xz6iqMK116O6d3T/XbTVpKwGIhYeZo5N7WeL0ttEm5bnrvR1iQHJthaNhiUtJmjtsMDPc
	/MswKcER+1PdYIf2MSwqJ4c3jl4Hg4UHwNz1emPfAraL+gfHSlU+ZXVbD8naP4EzjN6J2Y9e2Ne
	Lz4tR4SBjFEp7vCU5lJUPAe3/A+9VtJ3n0JqstpbTUJk1ZlN+Wr/qF3+mL8dqyq+iN/NXEJXPBO
	xwGWfbi2p1gRZvK7n4E0qIZ
X-Received: by 2002:a17:90b:3b8a:b0:3a2:b4a6:92a7 with SMTP id 98e67ed59e1d1-3a7a356ccb2mr829218a91.47.1791037052058;
        Sat, 03 Oct 2026 07:17:32 -0700 (PDT)
Received: from localhost.localdomain ([112.49.112.188])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a78e4c6135sm3043715a91.13.2026.10.03.07.17.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Oct 2026 07:17:31 -0700 (PDT)
From: xiaoshoukui@gmail.com
To: netdev@vger.kernel.org
Cc: jmaloy@redhat.com,
	tung.quang.nguyen@est.tech,
	edumazet@google.com,
	w@1wt.eu,
	xiaoshoukui <xiaoshoukui@gmail.com>
Subject: [PATCH net v2] tipc: fix memory leaks in bundle and fragment paths
Date: Sat,  3 Oct 2026 14:16:35 +0000
Message-Id: <20261003141635.33711-1-xiaoshoukui@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: xiaoshoukui <xiaoshoukui@gmail.com>

In tipc_data_input(), recognized internal control message users (such
as MSG_BUNDLER, TUNNEL_PROTOCOL, MSG_FRAGMENTER, and BCAST_PROTOCOL)
return false WITHOUT releasing the skb via kfree_skb().

However, callers in the bundle extraction and fragment reassembly
receive paths currently ignore the return value of tipc_data_input().
This leads to memory leaks in the following scenarios:

1. Nested Bundle Path:
   When an outer MSG_BUNDLER message contains a structurally valid
   inner MSG_BUNDLER payload, tipc_msg_extract() allocates and
   extracts the inner skb. tipc_data_input() inspects the inner
   header, sees MSG_BUNDLER, and returns false without consuming or
   freeing the skb. Because the extraction loop ignores the return
   value, the inner skb is leaked.

2. Fragment Reassembly Path:
   When reassembly completes in tipc_buf_append(), the reassembled
   skb may carry msg_user == MSG_FRAGMENTER. tipc_data_input()
   inspects the reassembled skb, sees MSG_FRAGMENTER, and returns
   false without consuming or freeing it. The fragment completion path
   ignores the return value, leaking the reassembled skb.

Fix this by checking the return value of tipc_data_input() with
unlikely() in both receive paths and dropping unhandled skbs via
kfree_skb().

Hot-path disassembly verification confirms that adding unlikely()
preserves ideal branch layout. Benchmark evaluations under strict CPU
core isolation show no statistically significant throughput variation.

Fixes: c637c1035534 ("tipc: resolve race problem at unicast message reception")
Signed-off-by: xiaoshoukui <xiaoshoukui@gmail.com>
---
v1 -> v2:
 - Added unlikely() annotations to low-probability error paths.
 - Reverted to kfree_skb() to align with existing TIPC module conventions
   and avoid 80-column line wrapping / checkpatch warnings.
 - Re-evaluated benchmarks with strict CPU affinity (taskset).

Link: https://lore.kernel.org/netdev/20260916061220.798324-1-xiaoshoukui@gmail.com/

 net/tipc/link.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/net/tipc/link.c b/net/tipc/link.c
index 49dfc098d89b..dec72a2b113e 100644
--- a/net/tipc/link.c
+++ b/net/tipc/link.c
@@ -1306,15 +1306,18 @@ static int tipc_link_input(struct tipc_link *l, struct sk_buff *skb,
 		skb_queue_head_init(&tmpq);
 		l->stats.recv_bundles++;
 		l->stats.recv_bundled += msg_msgcnt(hdr);
-		while (tipc_msg_extract(skb, &iskb, &pos))
-			tipc_data_input(l, iskb, &tmpq);
+		while (tipc_msg_extract(skb, &iskb, &pos)) {
+			if (unlikely(!tipc_data_input(l, iskb, &tmpq)))
+				kfree_skb(iskb);
+		}
 		tipc_skb_queue_splice_tail(&tmpq, inputq);
 		return 0;
 	} else if (usr == MSG_FRAGMENTER) {
 		l->stats.recv_fragments++;
 		if (tipc_buf_append(reasm_skb, &skb)) {
 			l->stats.recv_fragmented++;
-			tipc_data_input(l, skb, inputq);
+			if (unlikely(!tipc_data_input(l, skb, inputq)))
+				kfree_skb(skb);
 		} else if (!*reasm_skb && !link_is_bc_rcvlink(l)) {
 			pr_warn_ratelimited("Unable to build fragment list\n");
 			return tipc_link_fsm_evt(l, LINK_FAILURE_EVT);
-- 
2.34.1

