Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0244838399A
	for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 21:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788210103; cv=none; b=UYXq1M8oKOKK6bnhm0qq0fpkXfh8+hIXsuwofvp0JCNS8WieDviPNVp1z04wMAxXPKBM9r+pGMEXN7Ihqnkt2UOE8XHAOs26u9D6Seu0YjPCASUOGvr18ncXaJhVkl/hvOmnQ7+bP7vTuvoW2GtfoONjd2Ee+DMgT+TgQNlLFVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788210103; c=relaxed/simple;
	bh=0eTCPLGUMKlpiwgW5xNdX+fHOISCOT3c4nyXTCafW0s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aNeR2mHiSba4rA3usR1ojjkJK3utfJrbG4AjAQ+6/hC+t/zmpP8cTL+C5ABXWnkF531mX9BUxgRXth+IZvQjWN3Dt7T1RfIka4FodYuAJfTuRMZrnfpjklzaMIcSCwu91XX45vv7qTEKWajoeKkdKxTwFydjfdWEJZ4UV2fukgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GeTQxrIs; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GeTQxrIs"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-861f30636f9so30007927b3.0
        for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 14:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788210101; x=1788814901; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=JpMLFP66XwStzGb+FjoQT89DvlrGxwIbqnFlE8RyomU=;
        b=GeTQxrIs/DDPNyttn34lAICgWLeNF1zZg56xSfIRHw1mtQGPmtBe3/ns4wcDUkqSv6
         Vb1l15J965v8wSfPkds7xqqk7HlzgmJqj5zl1HkH4TYkNrB9qfjHLlZ2JOvlIgIav84l
         tLR9ApQVWRmMk+jyjjrCh0LPhvnxSlwlmXmXVk4oN53/FFVM1qXx59oUiki57wckTk7F
         cTpUQ8KlwxNfjl6s7MYZOSdvVSqYl9Q0ahnPDXQkBspLhzr4x+DbJsHpWVGQ7TQbtC5o
         P1YA3rUbEFOtYQvz6MZi7tDPBQuNlAeCVnNCzxXqgI7PRMkMTxFwASAX3mm3xtvfc7hj
         c3pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788210101; x=1788814901;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JpMLFP66XwStzGb+FjoQT89DvlrGxwIbqnFlE8RyomU=;
        b=VzfavtAK6/OBysN0PJZrW2GoUi50QCq7MZ/BvOmIAN+kERSdSJV7Qdc3i/CIQMbUd+
         /b8IOO2uOvE0kByjkQfIccjtMWP+ccnWgsdSOv/9c3TrFvHWYB2PM6OhoeQlNtkVgTUV
         TjA8XdIKPShyz3VYx/wTfFrCVJYLvEIaSTkIt+RN0o2jVw5uLOYZrY87JvPSpMcGJZFw
         eD/zqvquNHcMM75C0pO/4RzUrMXrhNEaa5AQadi1NSDuNKjP81MW5Gc6cRHVWkPdOqH2
         d43kMSi/5Zi299C1u0zylbRYtICRXXHsf8qSUw504TgXT81inu4ly/RDH0n0ezuo6a2s
         08EQ==
X-Gm-Message-State: AFuF++nnCI05AgzT6rc2jJaXGKKm5CZpqlR+BUNVMgOzVEF1DGDEbBtS
	LtSQmOQNA9o9g5cSupkoY53SyrtKBIRdZRQsalO2yQVuM0IiWu6C+/PafAKQ1w==
X-Gm-Gg: AYBFou2aBJrr+QwFDT2S/KAkDsHXmwuJ5ODfwr0iViPnOnjxz18WoBKrs5ewlohgt7H
	7JGy14L5X5su/IMnHgjOborX1ACJ8sld+o2zudz6WOmmaUw15I/PkoNxgUvJxovZ+IBF68A/cWa
	fDZ688R74Jf96Y5g9JeOAkzTYqGrFnRk1quQz08lGccT5hZUPo+xuasWtB4BHlZWJYJwDtPDW7q
	A26+zGuA7PFkirqux2TXIJ/8n503vY1xOG8YOGDRrJIQMH6cA+ficnQaWbBlwnhWVQQYQtXQv7b
	7gFZ+k+sz7c1IfttDnN7s1rqVQ/I0aFlUKV/fU4/6B3HDXvMHTLQOLmc1AEmctxT4xdmDi/bEy3
	ua2v1MdbxjLLLmUh1H3enTauRhRIe/GhK1l7wjD1NU0WqblXKjM1FHlLngxrUYww6M5VHeZqdDw
	SWc/J5b0wM8MtFiYvwzpqSaGu6iT9yVWiX7QsWmcK1WQgG7z2Zg1Y5fICYPw3LtIYDe17dcMlGJ
	2e+5SGTNcq53os/l8ebIR4Ujbokkuai+W4kCEjaG2EPrFCDuE4maKbQSi+pFSov
X-Received: by 2002:a05:690c:60c1:b0:81e:7dfa:b799 with SMTP id 00721157ae682-85d6b179defmr101761427b3.24.1788210096102;
        Mon, 31 Aug 2026 14:01:36 -0700 (PDT)
Received: from willemb.c.googlers.com.com (234.207.85.34.bc.googleusercontent.com. [34.85.207.234])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-85e65f146f8sm60528687b3.29.2026.08.31.14.01.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 14:01:35 -0700 (PDT)
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH net-next] selftests: net: csum: filter packets by source address and port
Date: Mon, 31 Aug 2026 17:01:12 -0400
Message-ID: <20260831210128.1359978-1-willemdebruijn.kernel@gmail.com>
X-Mailer: git-send-email 2.55.0.897.gb25b4bd76c-goog
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Willem de Bruijn <willemb@google.com>

The receiver process uses a PF_PACKET socket to verify incoming packets
and test hardware checksum offload. While the socket filter matches the
protocol and destination port, packet verification did not validate the
packet source address or source port.

If background traffic arrives at the destination port from an unrelated
sender, the receiver attempts to verify it. During tests expecting an
invalid checksum (-E), any legitimate background packet with a valid
checksum causes the receiver to report a checksum error and fail the test.

Add source address and source port verification in recv_verify_packet_*:
Non-matching packets return -1 and are skipped.

Also
- add an inter-packet delay to avoid drops from bursts.
- remove a comment that is no longer correct.

Fixes: 91a7de85600d ("selftests/net: add csum offload test")
Signed-off-by: Willem de Bruijn <willemb@google.com>
---
 tools/testing/selftests/net/lib/csum.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/lib/csum.c b/tools/testing/selftests/net/lib/csum.c
index e28884ce3ab3..139465054f85 100644
--- a/tools/testing/selftests/net/lib/csum.c
+++ b/tools/testing/selftests/net/lib/csum.c
@@ -2,8 +2,7 @@
 
 /* Test hardware checksum offload: Rx + Tx, IPv4 + IPv6, TCP + UDP.
  *
- * The test runs on two machines to exercise the NIC. For this reason it
- * is not integrated in kselftests.
+ * The test runs on two machines to exercise the NIC.
  *
  *     CMD=$((./csum -[46] -[tu] -S $SADDR -D $DADDR -[RT] -r 1 $EXTRA_ARGS))
  *
@@ -620,6 +619,9 @@ static int recv_verify_packet_tcp(void *th, int len)
 	if (len < sizeof(*tcph) || tcph->dest != htons(cfg_port_dst))
 		return -1;
 
+	if (tcph->source != htons(cfg_port_src))
+		return -1;
+
 	return recv_verify_csum(th, len, ntohs(tcph->source), tcph->check);
 }
 
@@ -647,6 +649,9 @@ static int recv_verify_packet_udp(void *th, int len)
 		return recv_verify_packet_udp_encap(udph + 1,
 						    len - sizeof(*udph));
 
+	if (!cfg_zero_sum && udph->source != htons(cfg_port_src))
+		return -1;
+
 	return recv_verify_csum(th, len, ntohs(udph->source), udph->check);
 }
 
@@ -659,6 +664,9 @@ static int recv_verify_packet_ipv4(void *nh, int len)
 	if (len < sizeof(*iph) || iph->protocol != proto)
 		return -1;
 
+	if (iph->saddr != cfg_saddr4.sin_addr.s_addr)
+		return -1;
+
 	ip_len = ntohs(iph->tot_len);
 	if (ip_len > len || ip_len < sizeof(*iph))
 		return -1;
@@ -680,6 +688,9 @@ static int recv_verify_packet_ipv6(void *nh, int len)
 	if (len < sizeof(*ip6h) || ip6h->nexthdr != proto)
 		return -1;
 
+	if (memcmp(&ip6h->saddr, &cfg_saddr6.sin6_addr, sizeof(ip6h->saddr)))
+		return -1;
+
 	payload_len = ntohs(ip6h->payload_len);
 	if (payload_len > len - sizeof(*ip6h))
 		return -1;
@@ -940,6 +951,9 @@ static void do_tx(void)
 			cfg_payload_len = rand() % MAX_PAYLOAD_LEN;
 			buf = build_packet(_buf, sizeof(_buf), &len);
 		}
+
+		/* avoid bursting */
+		usleep(20);
 	}
 
 	if (close(fd))
-- 
2.55.0.897.gb25b4bd76c-goog

