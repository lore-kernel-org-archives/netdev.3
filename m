Received: from mail-qk1-f225.google.com (mail-qk1-f225.google.com [209.85.222.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDF7B528453
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 21:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791927325; cv=none; b=bPrgpz/ErIfND8ahjy6f+H8zxb+Kk6DgTlTGnRmPkt712h0SR/FIiCHahNd0sEiTsxystLKpvQ1OkrEbFC7AGnVP8toh66nWtQBpJx1RZq56DTZ4xZYFgUBXedlNi5BNQyeyMzcKHz/UMv25TFHodRSxetXL2groA/0+gk+q8eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791927325; c=relaxed/simple;
	bh=S4G947q0dux77y8qoq1svkAkDJkTGpkNjrqdMM0IiUc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=e3Rcm6j8t0VScVw795224XHOVYPXwvyYrd0F9JCU5Eq/jngESWKmw+LJZdPU/1zsp7uZSZLy3dBzz7bfrwgjD7cn0FIkkmxjz3GZLr2eaFw/JFq5zYsu57DSixtrk3odZo8dVNmYEbKMYt/YO/ginhJTrdspFYL66I8+wVBeGlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=pass smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=LxevU5rl; arc=none smtp.client-ip=209.85.222.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="LxevU5rl"
Received: by mail-qk1-f225.google.com with SMTP id af79cd13be357-93ef9803765so121077985a.2
        for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 14:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1791927322; x=1792532122; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=3QNQ52hhlOnsHaVcy8J7JwRmYgkE+QSykmWrF8yeJ3I=;
        b=LxevU5rlx2uUW+nagflLSYboteThh4OvyLgO4ESu5BAgAUjTno17YPNIKgyV9dLhYC
         Cjnxf1yZFiQNgrr0t7swf3E+VoLuOCcuixlXoMDm2LNhdnPK9/p9A4PcOltdSot+g8rD
         W0xJzItwl9+4Vt8Dscm8+iCJdipddwZ85r+bxSjE354NGpNpvVEvng0l4YXt5vv8J859
         D4hztX2bkFXLBFJr6JuMT+mefDPAK3dPzMBUdYJlMFQ8Q82EWcEPY5VMFlSErV0Avgxw
         J1iUS01a3wCxZAfQ3g3CCIk1nKioGew+UQjIiCHYj2wUbF5kt3tsviEFqJ7JIadU18oF
         U9yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791927322; x=1792532122;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3QNQ52hhlOnsHaVcy8J7JwRmYgkE+QSykmWrF8yeJ3I=;
        b=VtZPvpSXt/V8OnGhY77TdrKIw0xYGEWq3nUVEB9bjX39ScpxIEJcD8k6DHUIOmXvCr
         nAnM2QXxsIlMmif6oRRnZLbzXvFspupR6gbfPAOkDkPTZrxogiTbkEKwgqTL08qSVywD
         B+QEK2+zK+nmLqL3d4xMP3prUV5t5O7NcCD7yWN23tkHu+mSkJ+i/LDsGZ9k0i67c9VI
         Z4+NqFEg2PwI0VI3VLlKFdNNVrymULy2bpFDGDMxt044zKitgIBpuswcCyZUZ9G/VK18
         n+NrJ9YdLR1gaLcJ9nyCCRuaS2X0pPBE+pGvREw91CcSxDe0nmbuhwXlgUvkMKu9YPjS
         7WHQ==
X-Gm-Message-State: AFq9FYJ2RgjrXbNugCD1t8FRhZwiGzElM220YEDopGDgfvixY9deTb5W
	Zq8mCVj5bRsiMyesqAJGp0c5taeqrcn5AAIyZvTsqHSEenA2dfO6IRvuAmKTgBk0e9E2DS5uT7F
	e2v01NXxje5FywZiBuaEEpLgr+zXpyyG71OmNrD0kyBTNgQRZvS+4
X-Gm-Gg: AYBFou20AwENTmsnaMsW5UmBPOWHN2JTEcRKwDc+OKvChZc1AgAOaTevyfSGBEhuqBv
	6Y3UG952wcQGuf0zNKUeR8oRPccvktxT/eGANPhIn34nLhBoIE+T+hHnxC052ximPJavcnU7ZyJ
	02ZeKTF7NbxjdRXDuchwU+K0abssKTsG0M450QTqSVWZGdnRvMbRNqetPNpxLA/l8OCkKL4d8mx
	EiQ4qI5m8pQtLaIAqw53hM2otEgTEZA3qo3UrxJeUUn/awp+XSJ1loFxFJ98I3RcG84ZTiF9ks0
	F0um6r9Ha+Mg7kT9K/mT25u8vM7svUCejqpJoFGPtvjkp+bSoGZk76dRjGmIhCpdSq223p9Rj0T
	+YXFPKft0X5xWTwXvzUBq
X-Received: by 2002:a05:620a:46a0:b0:93e:c12c:f141 with SMTP id af79cd13be357-93ec12d0721mr2328353485a.75.1791927321576;
        Tue, 13 Oct 2026 14:35:21 -0700 (PDT)
Received: from c7-smtp-2026.dev.purestorage.com ([2620:125:9017:12:36:3:6:0])
        by smtp-relay.gmail.com with ESMTPS id af79cd13be357-93ef50b2183sm88272185a.14.2026.10.13.14.35.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 14:35:21 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-rjethwani.dev.purestorage.com (dev-rjethwani.dev.purestorage.com [10.112.16.167])
	by c7-smtp-2026.dev.purestorage.com (Postfix) with ESMTP id C406940162;
	Tue, 13 Oct 2026 15:35:20 -0600 (MDT)
Received: by dev-rjethwani.dev.purestorage.com (Postfix, from userid 1557719937)
	id B5EC7DC0D0D; Tue, 13 Oct 2026 15:35:20 -0600 (MDT)
From: Rishikesh Jethwani <rjethwani@purestorage.com>
To: netdev@vger.kernel.org,
	John Fastabend <john.fastabend@gmail.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: Rishikesh Jethwani <rjethwani@purestorage.com>
Subject: [PATCH net] tls: device: protect async RX resync state during device-down
Date: Tue, 13 Oct 2026 15:35:17 -0600
Message-ID: <20261013213517.2219663-1-rjethwani@purestorage.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

tls_device_rx_resync_new_rec() can run in process context with the
socket lock held, but without an RCU read lock: from the strparser work
item (tls_strp_work()) and from the receive paths (tls_rx_rec_wait(),
tls_rx_rec_done()). The resync_async pointer belongs to the driver RX
context, which tls_device_down() tears down from the netdev notifier
without taking the socket lock; only the softirq entry to the parser is
implicitly inside an RCU section.

If the parser passes the TLS_RX_DEV_DEGRADED check before device-down
sets it, tls_device_down() can complete synchronize_net() and delete the
driver context before the parser accesses resync_async->req or its
record log. In the asynchronous stage the parser also writes the record
log, so this is a write to freed memory, not only a stale read. The RCU
section in tls_device_resync_rx() starts after those accesses and
therefore does not prevent the use-after-free.

Enter an RCU read-side section before checking the RX device state and
keep it through the async resync processing and driver callback. Route
all subsequent early exits through the unlock. Readers that pass the
state checks are then covered by the grace period before driver
teardown; readers that start later skip resync. Keep the callback
helper's existing RCU section for its other callers.

Found by code inspection; not reproduced. Hitting the window requires
the parser to be preempted between the DEGRADED check and the
resync_async access across the device-down grace period and the
driver's teardown.

Fixes: ed9b7646b06a ("net/tls: Add asynchronous resync")
Signed-off-by: Rishikesh Jethwani <rjethwani@purestorage.com>
---
 net/tls/tls_device.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/net/tls/tls_device.c b/net/tls/tls_device.c
index f11d0528fc43..69522aaeb7dc 100644
--- a/net/tls/tls_device.c
+++ b/net/tls/tls_device.c
@@ -783,8 +783,15 @@ void tls_device_rx_resync_new_rec(struct sock *sk, u32 rcd_len, u32 seq)
 
 	if (tls_ctx->rx_conf != TLS_HW)
 		return;
+
+	/* The parser also runs in process context, without an RCU read lock.
+	 * Protect the driver's resync_async state before checking the flags:
+	 * device-down sets DEGRADED and waits for synchronize_net() before
+	 * freeing it, without taking the socket lock.
+	 */
+	rcu_read_lock();
 	if (unlikely(test_bit(TLS_RX_DEV_DEGRADED, &tls_ctx->flags)))
-		return;
+		goto out;
 
 	prot = &tls_ctx->prot_info;
 	rx_ctx = tls_offload_ctx_rx(tls_ctx);
@@ -799,11 +806,11 @@ void tls_device_rx_resync_new_rec(struct sock *sk, u32 rcd_len, u32 seq)
 
 		if (likely(!is_req_pending) || req_seq != seq ||
 		    !atomic64_try_cmpxchg(&rx_ctx->resync_req, &resync_req, 0))
-			return;
+			goto out;
 		break;
 	case TLS_OFFLOAD_SYNC_TYPE_CORE_NEXT_HINT:
 		if (likely(!rx_ctx->resync_nh_do_now))
-			return;
+			goto out;
 
 		/* head of next rec is already in, note that the sock_inq will
 		 * include the currently parsed message when called from parser
@@ -812,7 +819,7 @@ void tls_device_rx_resync_new_rec(struct sock *sk, u32 rcd_len, u32 seq)
 		if (sock_data > rcd_len) {
 			trace_tls_device_rx_resync_nh_delay(sk, sock_data,
 							    rcd_len);
-			return;
+			goto out;
 		}
 
 		rx_ctx->resync_nh_do_now = 0;
@@ -823,16 +830,18 @@ void tls_device_rx_resync_new_rec(struct sock *sk, u32 rcd_len, u32 seq)
 		resync_req = atomic64_read(&rx_ctx->resync_async->req);
 		is_req_pending = resync_req;
 		if (likely(!is_req_pending))
-			return;
+			goto out;
 
 		if (!tls_device_rx_resync_async(rx_ctx->resync_async,
 						resync_req, &seq, &rcd_delta))
-			return;
+			goto out;
 		tls_bigint_subtract(rcd_sn, rcd_delta);
 		break;
 	}
 
 	tls_device_resync_rx(tls_ctx, sk, seq, rcd_sn);
+out:
+	rcu_read_unlock();
 }
 
 static void tls_device_core_ctrl_rx_resync(struct tls_context *tls_ctx,
-- 
2.50.1

