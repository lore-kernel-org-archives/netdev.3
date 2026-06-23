Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A42A37B011
	for <netdev@vger.kernel.org>; Tue, 23 Jun 2026 01:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782179542; cv=none; b=Rd+EpgxrvgLTZVp4v+vdxk27h2bmEj46GD97oaFoaVy0IG/LmRFVlLYo8N88OBSsUvhxH6IZAjAy+5oM7ubTkLlYw+FveNf/16jtqmRXuQnJWhl4HwZ5sEpUCgTxUX9lQEKBeOk16pm97QKnVZ16T48AOORk6pDMAMC7iqPeXIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782179542; c=relaxed/simple;
	bh=yo9XuHELrVnO688wjCRiC4G+3rpu4p0EG0QZEywX50w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ay+Eeo2vksdgFtq+mm1KPR/KwbuecSyAhWY1TC9lMH0nwJOVhebcmLdSR/3QR7vLbgNxSwwGqo3n6ObySuxSba7TUnmJiIXJrUG1bLm9gFh0XuNmRwoT1gftOuBSBp2NLZKlrIUc5vYDqpNLlCsEQaYznMKNTaPqdYQAtb6E80M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qKRsk3F0; arc=none smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qKRsk3F0"
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-30bc5fa5a2aso687730eec.0
        for <netdev@vger.kernel.org>; Mon, 22 Jun 2026 18:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782179540; x=1782784340; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3/CC8d2SAj+Z99gw5iWPt5xPwSjZn6V/0j7+lMhcsWQ=;
        b=qKRsk3F0IEVUc+zaS1AkXHqgd0aarETL7OE9bcDfS16AdXxHXrFBY0SUqmddh8Od7K
         H8uGahM/I6E+20m2UZIcNUAvC/xQEsyczsJYJsbT1vxLT4xTZUu6XOv/nS2k4I3GFoe8
         pjJdJ02NfP7+bNVhiqZQbfTPWktn6nOnySt53wPtkh3oz4trJd+vtTtXazTdtaNfaQSS
         2o3nhgjV2VJ5yRTgm6WiF6WT463jK9FF/j4VwWNwhOS5BY43YkvysrV2sOG/z+y6XV7K
         qBx/cm2r2mgafYQf4n0IjCA6TTtAepQMbf9Kjeh0MjzOHd+IMJ6mYlfVUBsidch2yycm
         nOqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782179540; x=1782784340;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3/CC8d2SAj+Z99gw5iWPt5xPwSjZn6V/0j7+lMhcsWQ=;
        b=JZMGXw4jz2H/LSYfA6LQnbuWr2eNjTIrCfNxwZQ7RUG2B8nEQYCKNJKiMiv87pW2TC
         z3lyA9DT7cRVNyGMd8tpD4/XbE9wja4jKJdfNsE6EMMDhuuiqq4d9HtrtiitupdyRUgT
         ch+PZkn96Q1Nxki32gnDxUimkndCDNBy+vFQ+WnAlNZGz1nA4PUU5XuQ5zLYb292cR5z
         t8FqWo4DTVrGCM68BlPk0xZW2RskzocK2iGiPRsgzanqcm44vM/nI+zg6MopUX5FgnJG
         xjn5Psrjbu6JgP/URz/lOQDEn4kuZW9mfUBOYhRy+JvjIXNm1R1Qdnm8VZBRKiHefnkV
         5YtA==
X-Gm-Message-State: AOJu0Yy9/+j4Bq7/2hx+1q+we0veAMDI/0lJedsvA9CbzV9oxyf7u8Kt
	jKbDSYVzE6qOpAelTmoWR5RX64ZAjXg3ZbdN23I+GDkYPbbpKw2zDmM5hhdY6kHK
X-Gm-Gg: AfdE7clw3cK06v7UKURoGyiYORQ6iBrBYciIfaafVjsQzr5/J+DLKWBDVweWYe/wp2Y
	OrMTUL1V5GgG5eZLXL8kte9gQSsE+oKgWtN/GCcmqinzupkULEEcpqdeomVOvfv3UX4hhmNrC91
	4rHp3x5LxmPUztgE2UEKUpWQ16V4W6Ua4fv4R2Taxwf5jBe/wA+NNo1h+PH2mhiQv0064uo8yqy
	EhlEHg4V/YRQDEBSQ9d/HBHobWVVGiFH9kH0n64MiskpR/hwDmZ86jjd8ODqp1VMm1TSZ89cLu/
	Mw77036kRqHpaKYECLSv8zav2Pb0pi4YtOqPpAFwWCdlu1Dx7wuh0AeYJdZgUw4ckiPfbzHcAcy
	M44oTxdI5Dl7UhiCPrNycZMOviOf9n4TQCZoR02Jr5rld24gIGRvFlkNCh3V5WMiuj7Sl965mOJ
	nLIme7Jjr/bXM0KZiE+gtYlK17GcCWSBLPuXd40fQU0w0SrfxZtwVgsU17xkQ8rPUQHyoZu3p/6
	qdylJ+u296c8+ZrNMkXbg==
X-Received: by 2002:a05:7300:acae:b0:30b:c021:5045 with SMTP id 5a478bee46e88-30c5232edd4mr687534eec.5.1782179540152;
        Mon, 22 Jun 2026 18:52:20 -0700 (PDT)
Received: from localhost.localdomain ([47.246.98.82])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c1bdffa83sm16056703eec.23.2026.06.22.18.52.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 18:52:19 -0700 (PDT)
From: HanQuan <eilaimemedsnaimel@gmail.com>
To: netdev@vger.kernel.org
Cc: edumazet@google.com,
	ncardwell@google.com,
	HanQuan <eilaimemedsnaimel@gmail.com>
Subject: [PATCH] net/tcp-ao: fix use-after-free of key in del_async path
Date: Tue, 23 Jun 2026 01:52:08 +0000
Message-ID: <20260623015208.1191687-1-eilaimemedsnaimel@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In tcp_ao_delete_key(), the del_async path skips the current_key
and rnext_key validity checks present in the synchronous path,
assuming these pointers are always NULL on LISTEN sockets.  However,
if a key was added with set_current=1/set_rnext=1 while the socket
was in CLOSE state, current_key and rnext_key will be non-NULL
after listen() transitions the socket to LISTEN.

When such a key is deleted with del_async=1, hlist_del_rcu() and
call_rcu() free the key without clearing the dangling pointers.
After the RCU grace period, getsockopt(TCP_AO_INFO) dereferences
current_key->sndid and rnext_key->rcvid from freed slab memory.

Clear current_key and rnext_key in the del_async path when they
reference the key being deleted.

Fixes: d6732b95b6fb ("net/tcp: Allow asynchronous delete for TCP-AO keys (MKTs)")
Signed-off-by: HanQuan <eilaimemedsnaimel@gmail.com>
---
 net/ipv4/tcp_ao.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/ipv4/tcp_ao.c b/net/ipv4/tcp_ao.c
index 2f69bcecae78..a56bb79e15e0 100644
--- a/net/ipv4/tcp_ao.c
+++ b/net/ipv4/tcp_ao.c
@@ -1747,6 +1747,10 @@ static int tcp_ao_delete_key(struct sock *sk, struct tcp_ao_info *ao_info,
 	 * them and we can just free all resources in RCU fashion.
 	 */
 	if (del_async) {
+		if (ao_info->current_key == key)
+			WRITE_ONCE(ao_info->current_key, NULL);
+		if (ao_info->rnext_key == key)
+			WRITE_ONCE(ao_info->rnext_key, NULL);
 		atomic_sub(tcp_ao_sizeof_key(key), &sk->sk_omem_alloc);
 		call_rcu(&key->rcu, tcp_ao_key_free_rcu);
 		return 0;
-- 
2.43.0

