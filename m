Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2A8735A385
	for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 05:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789969708; cv=none; b=tHaG92RYbrAexczyfuoGvvLal56byXftJPR7CnLIcxk65S4xQo23SW/cHK4xb7Ron+ZpN8S2dli49LOnrg7WTanaKTZHmNcFB6tQo3d+Warzypr+lr83pLUy8OC6Uvp64n5a48NNZCOHbiOTTwKpt9vE3x6aRKN1n5dRU/RZshE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789969708; c=relaxed/simple;
	bh=4q3x0VjUvsd6BIdKh4dxjcXadLqLQxFM6mQepQJSzUg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ok4KjrsfNr2+m12+6DglLz0M0hrz7d6f9ydtKQwohUJATYQYB55jeNM2J0A0QFPtWCM29+jjDtwGbnzcWNqSG14FzXQb+r/A50PPKuo2wKm6CgVcaXN5ULnwrWmqiBaYKStNHzYupmmYDPepUPclW+2WH+015mKqZitOi5DxGDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M0LzBUAG; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M0LzBUAG"
Received: by mail-pz2-f12.google.com with SMTP id 41be03b00d2f7-cc1cea34f01so2192139a12.1
        for <netdev@vger.kernel.org>; Sun, 20 Sep 2026 22:48:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789969705; x=1790574505; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zNJYOwH68Um+gj+JHkyQ06KZcoI1X6BYrC4IoaU244U=;
        b=M0LzBUAG+E4ngoiMV65MDhbsgox3K5+3ta+tx0gZLyief7igIKdaivLhXEZIGM5THM
         uak4iiZmRUCazbzM5IxILqWedfH3/y1upy4ozmebhGzuCpiMHxtuM/scMRE6MYBdxvIW
         3Y0YkYL630tMhi1Vq8VsoPv4i9lQUzabffeoNI/bFzMz5ytD9FBV3RxxduS21Mnq9Aox
         UQCvJp3qLGc1vLsazcgt01vOZXs4KnQbI7O8HdcpFNwrDP8YwsYOiJQWajl2IgCvjAza
         n1kDLJKvSCZXpiB7I+7VHk4Ql3wG/qxqaSy/ybu5F2c+1+SYDYNkfYRPvdRcGMoJiyUh
         2dXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789969705; x=1790574505;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=zNJYOwH68Um+gj+JHkyQ06KZcoI1X6BYrC4IoaU244U=;
        b=Yu6bgVc23IhwEOMB7oa1223/kNxixmbJuiyy9SxAyXDDJC/b6cBLCabfjJOxYbJTYc
         S2Xv42lJrQLU+v1LCXahQik/7OXozazK0rey/1pH0+dIRCohWNa6Y1Kzu4iByRu2DWoj
         9tknZ9N0MWxVyqNqdeuL8TN3ecDgojS8a+u1bguktq+HYSyjN/7xH+FXciK0eY78KIQ4
         qHleO0NXTThq3w2/FUBGcU+JNLnvOPaTUyMwyF6be+xug9jFqLvNwOBxGf1rQ5ezRGCw
         XfiBlxqxNU3gRPvEqAF7xnS7zw+W3jc1iVHiDVAGN9bDlRf5I8EEFI5n4ceD9II5G7Jr
         haFA==
X-Forwarded-Encrypted: i=1; AKwUvBy1xzZ27Yrh8/UW2jNU5mdPZiCxHgGx7mtPEDmKAJ1zbqi80tqdINVw8Wj4zPjm6FAta6N2jd8=@vger.kernel.org
X-Gm-Message-State: AFuF++nzgWy8IruM97XB0hqfTjM9hs46UPuQ7NVG175WQW1TFhaaM8xb
	jBD5vm/9yX/0MK9ZUGp1BfPM+ba0zTTY8OfdN6i1WqPLWIMM1UZo97j5
X-Gm-Gg: AYBFou1BT6wlxtUQL9h/0PxnkSmgG+aTs/W2sIfEVUbmL6YWjjaQgkuxFlKOfWYsX2l
	GhFaMBMnlWD73FpB4F62qFW9ir8h/geyIeSar+dgE7kVweYxO7o3OpVNHrdOxamAbZ9lp0rsr/4
	Rf62Z4lnqt1t6kcftHHdbDjA90+gHBBcMd0pKqQT03+1Wgdu1SPr4aalkJtlLEy9uGbGd6HcdtK
	Au+L5Sk6Jp78LLB7/94LvfCsUoV0QC5M8wJKQlcCWJQUWrQrtCeDGOt0WiQgoUvbWBEKls/AA0a
	O8wKJwfsPwJAZm/j9IfRWuybTZG2r2RKY74+thDfLoaqRP/0EPlsUy0El6KZjEgWdEkE00baS5x
	n8Jct1BZwVrj0Cn8e9bq5hyP7QMoYH6sLSO4IwxSBxDBfvi3OASwqdyLpgiQsrCPcSMB+aEtli1
	sF50Pyo8xz26MuX4gavbI67xl2+B91MxUYtgWzvGLYGl+bWLLEARXRpx7ATYdQVN3mFSAvgD7Dm
	qB5l/NVVq6t9oqgEq6zU2PSxDbbpMqoIokU/4YOI1f4SCDZEGWUrXju9Og28kwpmi0Dd/X97yVF
	RyBrtsNryw==
X-Received: by 2002:a17:90b:4c50:b0:39d:fd60:caba with SMTP id 98e67ed59e1d1-39e54d21a31mr14881297a91.14.1789969705254;
        Sun, 20 Sep 2026 22:48:25 -0700 (PDT)
Received: from phui-2.c.googlers.com.com (78.123.83.34.bc.googleusercontent.com. [34.83.123.78])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e6cb372b7sm12640514a91.15.2026.09.20.22.48.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2026 22:48:24 -0700 (PDT)
From: Hui Peng <benquike@gmail.com>
To: kuniyu@google.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: horms@kernel.org,
	willemb@google.com,
	mhal@rbox.co,
	jakub@cloudflare.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	benquike@gmail.com
Subject: [PATCH net v2 1/2] af_unix: decrement u->inq_len when skipping unread OOB skb in manage_oob()
Date: Mon, 21 Sep 2026 05:48:22 +0000
Message-ID: <20260921054823.1822122-1-benquike@gmail.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
In-Reply-To: <CAAVpQUARH-vecUojrXJWHp_C_rCpyxkB-HMBhryfxB-S76BAiw@mail.gmail.com>
References: <CAAVpQUARH-vecUojrXJWHp_C_rCpyxkB-HMBhryfxB-S76BAiw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a normal in-band read on an AF_UNIX stream socket (without MSG_PEEK
and without SO_OOBINLINE) encounters an unread u->oob_skb in manage_oob(),
manage_oob() clears u->oob_skb, unlinks the 1-byte skb from
sk->sk_receive_queue, and drops it with SKB_DROP_REASON_UNIX_SKIP_OOB
without decrementing u->inq_len. Because queue_oob() incremented
u->inq_len by 1 when queuing the OOB skb, u->inq_len remains permanently
inflated by 1 byte for each skipped unread OOB skb, causing SIOCINQ /
FIONREAD to report a stale positive byte count on an empty socket.

Decrement u->inq_len by 1 when unlinking the unread OOB skb in
manage_oob().

Tested in QEMU against Linux 7.3.0-rc3 by sending three 1-byte MSG_OOB
packets interleaved with normal stream data on an AF_UNIX SOCK_STREAM
socketpair and draining all in-band data via recv(): on the unfixed
kernel, ioctl(SIOCINQ) reports 3 on the empty socket; with this patch
applied, ioctl(SIOCINQ) reports 0.

Fixes: f4e1fb04c123 ("af_unix: Use cached value for SOCK_STREAM in unix_inq_len().")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Hui Peng <benquike@gmail.com>
---
Changes in v2:
- Split the manage_oob() and unix_stream_read_skb() fixes into a 2-patch
  series as requested by Kuniyuki Iwashima.
- Update Fixes: tag to f4e1fb04c123 ("af_unix: Use cached value for
  SOCK_STREAM in unix_inq_len().") and clarify the commit message as
  noted by Sashiko.

 net/unix/af_unix.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 42cffeafc8c1..1770af3c2684 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -2849,6 +2849,7 @@ static struct sk_buff *manage_oob(struct sk_buff *skb, struct sk_buff **last,
 		WRITE_ONCE(u->oob_skb, NULL);
 
 		if (!sock_flag(sk, SOCK_URGINLINE)) {
+			WRITE_ONCE(u->inq_len, u->inq_len - 1);
 			__skb_unlink(skb, &sk->sk_receive_queue);
 			unread_skb = skb;
 			skb = skb_peek(&sk->sk_receive_queue);
-- 
2.49.0
