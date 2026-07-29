Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49D347263B
	for <netdev@vger.kernel.org>; Wed, 29 Jul 2026 03:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785294799; cv=none; b=sKaOzoKWj3GHr9KdrGDaHYqwzgzZATP/PscWJbdzK6S4il8k+bJOJ4yQZm6fKYJ9ggf+uJPsU0zRogG1/cTIsa4BP/bsziFZ8+Pf282Ddc/ua4KeCqx+4xWwissmB4oZPjmtHhxKqUY8J1JDfYIY0N6LI7ffdU9QVvE3K3KJzYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785294799; c=relaxed/simple;
	bh=+nXoE1JWimzLvKI33iYfZhwEL7/w5aGwIMdK9C1RKfs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lj3vSG367fCu4tV9bB08Rkeo58kn6ddv1qJgf2KOHNU9gukaLjZbxHm00okUMlmWXqQqUW1hxM+x5AqHR0s5uvOzwc2rX3I4RlXgY9KSAx99qx/e+20/EPC1a6DgvxZED5aCYu3UWcsb+WVlxsZ8ZpzMf1UKiUr7Q+gdSEN3+4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cxeAV1MQ; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cxeAV1MQ"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-8423f236418so369492b3a.1
        for <netdev@vger.kernel.org>; Tue, 28 Jul 2026 20:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785294797; x=1785899597; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=67fzthwbCndyMuuC4hWnqiqs2nS3TAADY1dtDD/lCeQ=;
        b=cxeAV1MQOkuN73Qvm5DgsYuRuLpc5hymuqmBL+I/UJV/g2z3aUueZuyY3qT9kUj0Ug
         T61uZl2xrTuBl5rGqVounYcaLNNdZRgmMRcspG/HiZvku5yU5jJw4ZgDUNhr8ERnzCiJ
         Yw2xuGtjoAzA7XDQc2Kqp1ekZywFKVALAblH0ZOvxiOP6jHreBNCb55IlGdTT1SkB0ey
         Jlv7FgkJ85NNRnPO0Xf5J76H+roopau5s9CZDXRCWuLRURaPO9/Ri8tgkp8sSwuXvDjw
         vs9itxlLYJNZ2svZYo3k+GdN2N7Zc9jrx+r+RQQfbVAiR9C2J6y+rTYdGzRdlfLmfQRu
         MqvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785294797; x=1785899597;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=67fzthwbCndyMuuC4hWnqiqs2nS3TAADY1dtDD/lCeQ=;
        b=HrfP7P6fDILFC2xIrawdLbb/5g+Vf+CDgoZBCvCXoI++e+xOTlf6QdYfBlreclSNG7
         uW98jhGCAMP0iySTMArJcMrY4lLt6fCFMk+KxAjpfUgNDRgJGXNVhibYwpbec53yjM22
         K+JcosnAPuTfHaauXqRd2nRHFz+aXQudei2Mi7lzea5S/EtNPfyyM1WkoZSCe5faMy9A
         XzdJBmgVVoIdeGGvfKd55xn71TrYwJ4tHYXJbVOBgXpiS7oGGBrZzlWohBzGl0a23+c+
         PP0eS4R5B1Dethne6aNJE7UosRkXRNxm+F8IJT6ndTprRUOP83txgep0I2QpkeI/lCWo
         yztw==
X-Gm-Message-State: AOJu0YyMkjaTIa4EBHJpWbb1lc18HAOO/6Q5OlUfbDk/jh1TkCj0fT+9
	Xq+c18ufd8vbJXWuSOvm4LbfxrnnLz+dtjTWw1Do5ZYgdxnwI1mNlChV
X-Gm-Gg: AR+sD13eVFvo+KpjQVYouFcCn91zdXGZAP8Y2HXTkxeKNCfAnMdnt4+hkDIteJahdqL
	cf0tb8geNnQbxQzkAvpwpHZhtfvS2tVEBL5CQYXBRY56mhOkbqB188+E9gg4+O2qyRAu6ltzZ7N
	2I88pqdiQn1lMXO57hGl9xz4/mfWdtC7aZR4bsUM4wVy0mlz9wf6NRmtK9th5dugY6cL5BD7hYf
	CG724JztvV8iT3XrO1/pLUVjOOmMz6drGj25Ur/mjPM6a1/ctBkqQ+GICUVzbeFWNRwzu6M8X8q
	uhxTPnG4U3mJ4KutdwC2E8OnHiF3QV6YGIRVqzzg+CEpybhv2TW1IpYSxngipGHoqmqqhG3MIQ0
	cfHM9KOKW3cInFdgHUJ3N1AhtPhUvoV+1XD8s4cUW8LN94XsPM0KvpW9X15N+q9s2XUa6A8wsng
	b7Gt54RStV8p8lOpaWl3XeXHqjC3Cn6an5rNnMVmeF1Lp0tZNVQfDruPtzWhtEUdSa6dSmHYQv7
	luLVubsYA==
X-Received: by 2002:a05:6a00:3992:b0:848:7f8a:8d0e with SMTP id d2e1a72fcca58-84e932c5f3emr4770346b3a.55.1785294796609;
        Tue, 28 Jul 2026 20:13:16 -0700 (PDT)
Received: from localhost.localdomain ([116.105.227.66])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84e9fe1d07dsm667639b3a.8.2026.07.28.20.13.13
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 28 Jul 2026 20:13:15 -0700 (PDT)
From: Yuejie Shi <syjcnss@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yuejie Shi <syjcnss@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net] net: pktgen: fix out-of-bounds write in pktgen_finalize_skb()
Date: Wed, 29 Jul 2026 11:12:52 +0800
Message-ID: <20260729031252.54476-1-syjcnss@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pktgen_finalize_skb() spreads `datalen` bytes over `frags` page
fragments, but the loop that fills skb_shinfo(skb)->frags[] is bounded
only by `datalen > 0` -- there is no `i < frags` check.  The
per-fragment length is computed once with a truncating division:

	frag_len = min_t(int, datalen / frags, PAGE_SIZE);

The code just above has already capped datalen at frags * PAGE_SIZE, so
a valid partition does exist, but the truncation means the first
frags - 1 fragments can leave more than PAGE_SIZE behind, and the
last-fragment branch only consumes min(datalen, PAGE_SIZE).  Writing
datalen as q * frags + r with q = datalen / frags, the loop overruns
whenever

	q + r > PAGE_SIZE

because q + r bytes are still outstanding after frags - 1 iterations and
the final fragment can take only PAGE_SIZE of them.  The loop then runs
once more, with i == frags, and writes one element past the array.

frags is clamped to MAX_SKB_FRAGS (17) and frags[] is the last member of
struct skb_shared_info, which sits at the very end of the skb head
allocation, so writing frags[17] writes 16 bytes past that allocation.
With PAGE_SIZE == 4096 every pkt_size in [69675, 69689] hits it
(datalen = pkt_size - 58, giving q = 4095 and r >= 2):

  modprobe pktgen
  echo "add_device dummy0" > /proc/net/pktgen/kpktgend_0
  echo "frags 17"          > /proc/net/pktgen/dummy0
  echo "pkt_size 69675"    > /proc/net/pktgen/dummy0
  echo start               > /proc/net/pktgen/pgctrl

  BUG: KASAN: use-after-free in pktgen_finalize_skb+0x1e8/0x4a4 [pktgen]
  Write of size 8 at addr ffff0000c6b40000 by task kpktgend_0/97
   __asan_store8+0xe0/0xe4
   pktgen_finalize_skb+0x1e8/0x4a4 [pktgen]
   pktgen_thread_worker+0x1f3c/0x2d50 [pktgen]
   kthread+0x1c4/0x1e0
  The buggy address belongs to the physical page:
  page: refcount:0 mapcount:0 mapping:0000000000000000 pfn:0x106b40

nr_frags ends up at 18 as well, so skb_release_data() later walks one
entry past the array too.

Compute the fragment length with DIV_ROUND_UP() instead.  datalen is
still <= frags * PAGE_SIZE so the result cannot exceed PAGE_SIZE, but
the fragments now cover datalen exactly and the loop always terminates
on the last one.  As a side effect pktgen stops emitting zero-length
fragments when datalen < frags.  Bound the loop with `i < frags` as
well, so that a future arithmetic mistake cannot walk off the array
again.

Reaching this needs real root: pktgen creates its /proc/net/pktgen
entries with proc_mkdir()/proc_create_data() at mode 0600 owned by
global root, so unlike /proc/net itself they are not remapped to the
owner of a user namespace, and the module has to be loaded first.  It is
still a plain heap overflow behind a documented interface.

Fixes: 7d36a991e8d3 ("pktgen: create num frags requested")
Cc: stable@vger.kernel.org
Signed-off-by: Yuejie Shi <syjcnss@gmail.com>
---
 net/core/pktgen.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/core/pktgen.c b/net/core/pktgen.c
index 8e185b318288..2dbb7caacd0d 100644
--- a/net/core/pktgen.c
+++ b/net/core/pktgen.c
@@ -2843,8 +2843,8 @@ static void pktgen_finalize_skb(struct pktgen_dev *pkt_dev, struct sk_buff *skb,
 		}
 
 		i = 0;
-		frag_len = min_t(int, datalen / frags, PAGE_SIZE);
-		while (datalen > 0) {
+		frag_len = min_t(int, DIV_ROUND_UP(datalen, frags), PAGE_SIZE);
+		while (datalen > 0 && i < frags) {
 			if (unlikely(!pkt_dev->page)) {
 				int node = numa_node_id();
 
--
2.51.0
