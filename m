Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 537D82D97A6
	for <netdev@vger.kernel.org>; Sat,  8 Aug 2026 00:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786149934; cv=none; b=CVu2rLv5laqVHwo+PfWw8NzDCUrqcOfN0Q2M1PgMg5ZjNTFx0LBjFFBkEjVKAjMUCSAfgTtCyp8IYZLJy4gKnaeN0uRb/5ys3P8QzkRoLeBrpxOBXXgAVYGD2OKQ57hv/vcahtg396O17kPg9uJGrg/K7K5G9BZLKxKb143ca1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786149934; c=relaxed/simple;
	bh=6XbOhdGtoYorijn1bwCuPREme17HZ4ND274Mp20Jq54=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b2xpDPFEnygv9Z3H3MtW/3tGlR3awyGgjC7eZweUU3zAsrH/bGvZTPV/PN3kkN2WvCIq/oHovk28SfEzM+hb+tJJCAcSBDWstWuWszNjlbWadyAoQfnt9UV4rPNJ51I7R8IcD/DmkNcuj5BPiw/jZpiVPw2+RAmQzwXiBPl5H0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bwCqAkNm; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bwCqAkNm"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-47df6a5655aso7297f8f.1
        for <netdev@vger.kernel.org>; Fri, 07 Aug 2026 17:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786149930; x=1786754730; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sZmsxbEn8gGwWlSp95ETF3tYcP1n/Ez2wBMWCCigdGs=;
        b=bwCqAkNmdjFs/A82C+gLlQkDNvQO709br1jRfcLsNndAlf3A/QO0dPOLjfnZm9mlHf
         eQoZXx39CyNka9LKf1Mf1FuaxkgzsZ4/MMjpzNAPa0MRxvTYhyaGlFNqd4S4gn3UNb90
         jYSNNLFG7odD1NBOglYlkq/Est/xR7FU03QV7xLg6ynwIO0udJy7ACMlu0EbqhMbwJtV
         JiZinwmBz4X7HreVjb6Q7qbQs2E1s1pJL1f1NmJtYTgBDWgsVyAP+zzcgV/14OPQ606L
         inYXsWjqI5QJsamZEj4YZQMzMMfpgwkhqZR6Ut5TX7J9P1Y16o5R2jMoplj9oQ3mzdW4
         oBNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786149930; x=1786754730;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=sZmsxbEn8gGwWlSp95ETF3tYcP1n/Ez2wBMWCCigdGs=;
        b=oFdWNw8UYf1ZOYELFAQ5nJ65jfBRH1jXEiRpUsPpuBSgrrUnz/KG7RWR4NulGeXPsv
         Il82t1TRmlrzibwcoG+EQjSPEMr1b9JGAX/KlIu5Qd6tj/lNUFCESWF1fD9lBHGSJ9Hm
         wrh+aW8HUW7ajPAcX4ZBxbR9xrNFJ/60l9g24pE9RYkUb8m4/9+i3SzlGq6D7Jej8UUX
         FMbhr2EpoxK6c5Cmx10UThiSmelQDf9/qlzCgbk9YV5Tv7K+wiDILrtXMbG4HrMjoHV6
         DQdAajZr0wuQekK+eIY5KVZN5Kgw//B8Up79YJpAmh6G2FZR7e2RixsA0zz2suMXRpTw
         AQFQ==
X-Forwarded-Encrypted: i=1; AHgh+RqdUD0PQUQ4eKLm7pP/3UZZkRy+5USQDpU0IIT87FdpzrzkI4qDNCXGfxofSWUK82+9jtKCF2g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYQGe0M3VTA57KhBPSJ+uT+SzxgWc6wuX8/eD2UmfkfQKXzR7P
	QNVquRkjfY0sSzNOEdcCycckaFzAsVUPmoHcPp3uui0kCPS+VtP6X7Vv
X-Gm-Gg: AR+sD13jhS6Wfun07FYvc03qdDJQSFDT+MRno8LINQEz8rdsoaOT6Dt372HtFJDSoKA
	OcWDGZJdtG2dMFfR13XL+k9YEgbnZdHjfYkzL2gqfUOQ5ycpY4Yksgv1elVHf8MlGAZkDC5qgZa
	Y424sOsSspOMQ0KBecxr5KlpWv82p+VoLG3SQxJZzYwBxZdtSDAiLy4wUhmY9REQ7ROJEMbRrXn
	2oKjhOvP/l/7avFgrVemuI3kJ8DDkdcilN8G7QVHhxqQkSK6jXF2YpQFwWYTNNRxnUWKfkrkm3+
	Xk1m+Ml+DL5K1LtI3+MbiM8r65iNaYknosZWwwq55/0h9YjkbxjvZmczn74OTtK/Z/Tc/rwoeEX
	nA8h41fCPtAz7TpSoxtuxVMyEx0vbAxoMYJrj7uLQaPVtnCyshzF31lRBO922NUaS4GWHd83Vaw
	3gcckmXJApCDdkH5WJ7gD0Rf+R1YAhAGIEPlWYWLnJpZc0y739WWy8NmGDlT24FudCs5Pfo/P6c
	E/bhOvaAYzSX6+5VDWy4vRLl6zXxa+nPQzoFI8KB+HTLYwAldblqCvbr8U+TAkllakjr6mJ1/pK
	HqBw6pFx9ed35TtAZnnBU64=
X-Received: by 2002:a05:6000:410e:b0:47f:e8af:7687 with SMTP id ffacd0b85a97d-47fec4ea9f6mr14197185f8f.1.1786149930304;
        Fri, 07 Aug 2026 17:45:30 -0700 (PDT)
Received: from L-022584.energy.envision.com (dynamic-077-179-201-133.77.179.pool.telefonica.de. [77.179.201.133])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4800220aa83sm8848170f8f.36.2026.08.07.17.45.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 17:45:29 -0700 (PDT)
From: Xin Xie <xiexinet@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: edumazet@google.com,
	horms@kernel.org,
	shuah@kernel.org,
	lukma@denx.de,
	m-karicheri2@ti.com,
	fmaurer@redhat.com,
	luka.gejak@linux.dev,
	bigeasy@linutronix.de,
	ali@iusegentoo.com,
	qingfang.deng@linux.dev,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Xin Xie <xiexinet@gmail.com>
Subject: [PATCH net v3 1/3] net: hsr: privatize interlink-bound skbs before address mutation
Date: Sat,  8 Aug 2026 02:45:22 +0200
Message-ID: <20260808004525.1551-2-xiexinet@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260808004525.1551-1-xiexinet@gmail.com>
References: <20260808004525.1551-1-xiexinet@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

An skb sent to a RedBox interlink can share data with master delivery
or the original TX skb. hsr_deliver_master() and hsr_xmit() then write
different source addresses, so one consumer can observe the other's
address.

Use skb_cow() before interlink address substitution when those paths
can share the data. Drop that egress on COW failure. Other interlink
traffic keeps its zero-copy behavior.

Fixes: 5055cccfc2d1 ("net: hsr: Provide RedBox support (HSR-SAN)")
Reviewed-by: Ali Ahmet Memis <ali@iusegentoo.com>
Tested-by: Ali Ahmet Memis <ali@iusegentoo.com>
Signed-off-by: Xin Xie <xiexinet@gmail.com>
---
 net/hsr/hsr_forward.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/net/hsr/hsr_forward.c b/net/hsr/hsr_forward.c
index 0774981a65c1..67aaf5a8622b 100644
--- a/net/hsr/hsr_forward.c
+++ b/net/hsr/hsr_forward.c
@@ -420,6 +420,22 @@ static void hsr_deliver_master(struct sk_buff *skb, struct net_device *dev,
 static int hsr_xmit(struct sk_buff *skb, struct hsr_port *port,
 		    struct hsr_frame_info *frame)
 {
+	/* An interlink-bound skb from get_untagged_frame() can still alias
+	 * another live consumer: for master-originated frames the clone
+	 * shares the original TX skb (which taps or the TX path may still
+	 * hold); for ring frames the master also consumes them when they
+	 * are destined to the local node without being exclusive to it.
+	 * Privatize before any address mutation.
+	 */
+	if (port->type == HSR_PT_INTERLINK &&
+	    (frame->port_rcv->type == HSR_PT_MASTER ||
+	     (frame->is_local_dest && !frame->is_local_exclusive)) &&
+	    skb_cow(skb, 0)) {
+		frame->port_rcv->dev->stats.rx_dropped++;
+		kfree_skb(skb);
+		return NET_XMIT_DROP;
+	}
+
 	if (frame->port_rcv->type == HSR_PT_MASTER) {
 		hsr_addr_subst_dest(frame->node_src, skb, port);
 
-- 
2.43.0

