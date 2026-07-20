Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB40D266B46
	for <netdev@vger.kernel.org>; Mon, 20 Jul 2026 21:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784583671; cv=none; b=FAA1UFTcyUCqKbGv93ly8jE4jdvWV8kwCmtqSY+Qm9OlB85NWxZVmkiG/cxX9KMnUGoiiyHShuLYy3rgYEC4pbA04Hk6DofK/o6xo117a6bNLoxfaAxLiF3+6zCJGN5NGFf662UN5ERgPUI1SOxfcRT5DlKRyN3USK5ZdQP7OfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784583671; c=relaxed/simple;
	bh=ZxOla4PUkwrGsQoJ95HmUogsyOS0//ZL/7wMUGSDSBo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TElH01genLvtF2ucMcZ/saxixIhxTD7LtaE8rIDPcehu+aN8/V5ZuDmrEIYYOg/g7+OMcYC6rZG2Q3jdyJqBj8AY2Eq/B2zGhnqEBMBpmYuZHyAv9UoQAbRYBiflOCaRyboWCAykKRIwSiAqMwcV9k5hTGeC25wtaI9YNt7YBTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B+uGnqVH; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B+uGnqVH"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-84862b0d5aeso11534505b3a.2
        for <netdev@vger.kernel.org>; Mon, 20 Jul 2026 14:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784583669; x=1785188469; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=dGuueZd+28Z7YCvzKzUVauz3+3ckWEEDBGdYS+SB/Ko=;
        b=B+uGnqVHmpVhJM6kI/zGlQ/X+BfahmZoa2qaVukPiK9B/d/Jxu8jIOnYRUQIXDiNTH
         X5KkQS+Nmbza6pWqndaLAqBQYHquuIr66oE3e0v/C6kirs3tAJfu0iPf0/fRRACZ8aGk
         sMQXVBL/zmm+WMIoGd2ebzk+x6Iszroh1Ueqx6DPyrNKYQihNYCzXYNQiF0tvF0euQ+O
         JmkKdhLPxFcse6jlu+bgsPrlPmJPDOF0FgVFHHQk20SrbBHLtSVjSE2ftfDGBgxGT20p
         ev2PjzlLCRuSoXtdoFeAy8ikYa/jZBQwi/COIfijkS9CixATfSrgNa2x5fWqm8dmLaXM
         CcMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784583669; x=1785188469;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dGuueZd+28Z7YCvzKzUVauz3+3ckWEEDBGdYS+SB/Ko=;
        b=He7P9dDVrA/8rIztmMzlcPiaU0s0GIx03qLTzO/BPEJiI+kZA6Ld8DiIQqXoxSn/zQ
         D92ARUTuOo/LdmJbxIH8S8eEw2fZ5EXoyTeY03bydnWYxfoAgHTJFlXKOTp7q8Y1V04o
         bKvTkCUsN4ZNsJn6fsvLNK9lYjgY3do5Y8+Nup4+EJeBemZECD8gDjWC1gHFXI7Ytk6A
         PcjmgyhoAl4gtQURYMdatbBb2zULWJ5rsEaA5FMt68TKri7OcSk3EsDphZm2bwFbhGS3
         R0VopKmHQkz3isQrRpLuBMy5KvnwZ4om8mqY5vHelZqXmCtSDePQupiTuLg5iavdCIQL
         PfBQ==
X-Gm-Message-State: AOJu0YwUaTMWARaRTD302boaYdEb8SBNnJ4wqX8GtSzhqRJtgwTOQTrL
	n4dsPh1bqvXqCk08RwJ8Ah/D9hPfjE2KnAs5BUMWSWbrMqWqfPaN2YvR
X-Gm-Gg: AfdE7ckIAqYQrmLA3VEogUmi0/P2f56eNlNd4D4o2yVvdZiAv4equNgbSu+lzrqTpyp
	IjC1drzZYXdqsDUmqkyp6CN9J+W8Y251ZqXfKSTsjYEamF3KwVckY+TjRq/g7ksQ0h519VeB+qs
	Ug7YOW2k+OstwBz/+3gd8RweBLRWR1vVJZQ4zR03rKGNV0RaBOmESeHTOVvPuLv/i3pzhK/MOLW
	bHXrGUxR0sLtWX9DeFFPDqB9xwAvtY/y197IOiKkC0g2QkYzwb/cU7WLDlx36JVXYTMAgZLV13e
	dWgTI/BvJtUUOQvhCRSikKUcwALLs835K0nZ+EvepJX5DkkZfh7giwk/ZBKM9JUY1zvEJhCV86R
	AE04uJqun0YvSi9aI9yzWCIYl5MKllsyNfLDkW0BfQ/JEIbZJ4UNcglP9X8vmyUmIif96Nc7WEQ
	fzpVMX3XLFYdlA5D/7N5JvY4GlJtx4ttHBVIUPjCtpgCeIl0x+5VzsOmITovXMsBScaz1bDHBGw
	uUCOXanIV4Slfv0Q86PdVKHJdLF
X-Received: by 2002:a05:6a00:9509:b0:845:48be:b046 with SMTP id d2e1a72fcca58-84c294d0870mr16342453b3a.36.1784583668999;
        Mon, 20 Jul 2026 14:41:08 -0700 (PDT)
Received: from LAPTOP-83ECOPAB.f7a5e5c3-cab1-4810-bdbb-207cdd06de9e.globalsecureaccess.local ([2001:4898:a800:1012:e4ac:299c:3d12:cc91])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cb519aeb676sm5115423a12.19.2026.07.20.14.41.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 14:41:08 -0700 (PDT)
From: "Cen Zhang (Microsoft)" <blbllhy@gmail.com>
To: jmaloy@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	tipc-discussion@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	AutonomousCodeSecurity@microsoft.com,
	tgopinath@linux.microsoft.com,
	kys@microsoft.com,
	blbllhy@gmail.com
Subject: [PATCH net] tipc: fix integer overflow in tipc_recvmsg() and tipc_recvstream()
Date: Mon, 20 Jul 2026 17:41:03 -0400
Message-ID: <20260720214103.47732-1-blbllhy@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In tipc_recvmsg(), the copy length is computed as:

  copy = min_t(int, dlen - offset, buflen);

buflen is size_t but min_t(int, ...) casts it to int. When buflen
exceeds INT_MAX (e.g. 0xFFFFFFFF via io_uring provided buffers), it
wraps negative, wins the comparison, and the negative copy length
propagates to simple_copy_to_iter() where int-to-size_t promotion
makes it SIZE_MAX, triggering a WARN_ON. tipc_recvstream() has the
same pattern.

  Kernel panic - not syncing: kernel: panic_on_warn set ...
  RIP: 0010:simple_copy_to_iter+0x9e/0xd0 (net/core/datagram.c:521)
  Call Trace:
   __skb_datagram_iter+0x123/0x8b0 (net/core/datagram.c:402)
   skb_copy_datagram_iter+0x77/0x1a0 (net/core/datagram.c:534)
   tipc_recvmsg+0x3d7/0xe80 (net/tipc/socket.c:1934)
   io_recvmsg+0x47e/0xda0

Fix by changing min_t(int, ...) to min_t(size_t, ...) in both
functions. The result is always <= (dlen - offset), which is bounded
by TIPC maximum message size (0x1ffff bytes), so the implicit
narrowing on assignment to int copy is always safe.

Fixes: e9f8b10101c6 ("tipc: refactor function tipc_sk_recvmsg()")
Fixes: ec8a09fbbeff ("tipc: refactor function tipc_sk_recv_stream()")
Reported-by: AutonomousCodeSecurity@microsoft.com
Signed-off-by: Cen Zhang (Microsoft) <blbllhy@gmail.com>
---
 net/tipc/socket.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/tipc/socket.c b/net/tipc/socket.c
index e564341e0216..ff858727344e 100644
--- a/net/tipc/socket.c
+++ b/net/tipc/socket.c
@@ -1935,7 +1935,7 @@ static int tipc_recvmsg(struct socket *sock, struct msghdr *m,
 	if (likely(!err)) {
 		int offset = skb_cb->bytes_read;
 
-		copy = min_t(int, dlen - offset, buflen);
+		copy = min_t(size_t, dlen - offset, buflen);
 		rc = skb_copy_datagram_msg(skb, hlen + offset, m, copy);
 		if (unlikely(rc))
 			goto exit;
@@ -2067,7 +2067,7 @@ static int tipc_recvstream(struct socket *sock, struct msghdr *m,
 		/* Copy data if msg ok, otherwise return error/partial data */
 		if (likely(!err)) {
 			offset = skb_cb->bytes_read;
-			copy = min_t(int, dlen - offset, buflen - copied);
+			copy = min_t(size_t, dlen - offset, buflen - copied);
 			rc = skb_copy_datagram_msg(skb, hlen + offset, m, copy);
 			if (unlikely(rc))
 				break;
-- 
2.53.0

