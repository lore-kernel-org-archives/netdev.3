Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793878752;
	b=1jbfrQWL6TuN1Sq83TJfbfaKrnDPaTAHRBTvV5OoLA8UKVcARIWWlah+bnw4BFXYPp2G
	 BSiP2VytUFcNBhdkKp0kN/DyfZRw6SQkRdv/+WC8M/WKD6J9pZFVdHh2keO7ItHnZxpD0
	 zGiBAlKS0WPJrsuyjWrVAIziJPoDGekrsKGd5SH9SbWOOhIrRd3WeLA98hY+vXi+SEf4N
	 U+uvbNA6UOhr3tCMJybhVBjjWxOqQkJtlzYLLQcFdZRlJcgC7U6DhyFqWTYfDDgHrywNy
	 hMD33EMRW7PE9ipemdEHLYTNvovR4UF/C+dtn3mSWRQmf2cOFyac7ifCSdHi3LREYKw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793878752;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=wLy/MC5U/srGzmiqFOFPlUlx6h4GbJbOkj3ViR+QLTs=;
	b=EuXo1rGe625IxAhR9D0wvl/TJK631Jpa91MBp3jvvLvt8vgrQAdexuDf33TzrrAzRe2G
	 4U5nAj3NVI4xfnDQBmtsSX9EXAWu1mImRpAumVz60ExlKX1pCsnt4NG10tFxni9Nxoaci
	 YG6tK5CvzZnGoZS1KrYNxDt4ueAkaTXYj6MRpHcj8IGuzoxEfkMjkaycd3KXxhcoW/v9q
	 dKyL47Rh/8s+3j/c0eYvxXFcCwYiu1lgznjOlz4djcNh3G+LfoC4OS4AsPxiUei46w4Au
	 LPwyN/SBdJP1xL4lC7T8dLH21lp2l4D3gSw6bDE3Q43olPSQoIF2lCB2Z5quJruRr9Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NMcfvhUV;
	arc=none smtp.remote-ip=74.125.82.173
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8485A606A329
	for <netdev@vger.kernel.org>; Thu,  5 Nov 2026 11:39:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8485A606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NMcfvhUV
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-36a18fc7a38so1852537eec.1
        for <netdev@vger.kernel.org>; Thu, 05 Nov 2026 03:39:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793878751; x=1794483551; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=wLy/MC5U/srGzmiqFOFPlUlx6h4GbJbOkj3ViR+QLTs=;
        b=NMcfvhUVqPBalavljOq3AdNC7tJsJBv+ug0t2CLiNqpmrU2AJNud3XXIMeJZF1rnOC
         pwureEM5btmrTMJvCLOk5ptu0BLvxUbiDQ/o3Bflr7+msvseP1z73Yc1Uln4l+a7Zfmq
         zYFYG4rFEdklLdFOLn7TL1v/Xcz0OhNeszy6COYhjuCmbF9CYHx6lPFnmfxOkjlwFzEu
         EAzlsMYY2UtA1VHKFFGTsBuzjUdycHOFqijPRKvoZm210mvOBEaf5E2xoUJ1eBGiTZYU
         D1WLug9kwHBatTqrkmXEKkT8/HWf+mjJVNdgrxkLvAadIbVG5c6iOtmNpG99GapzGoHL
         BsTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793878751; x=1794483551;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wLy/MC5U/srGzmiqFOFPlUlx6h4GbJbOkj3ViR+QLTs=;
        b=i0nBHZVInzxre24bB6eN7v8IQwPKfbTytLORAcPAc8hyCNfBeUVWH1+6hIxi0WUVvQ
         MYp5xi5/+gcTScUgkg43ElgV2WISBiDXrtSrr96OT8iIAJp8EJK9lQ9+D9G/pE0T5enx
         jZZY19DZfFkhDnU6ibZ/5gE89r1osH1G5EVjEAKwyngSCCCZ+2zxHoTKK35Z5WWhhLag
         FLCK8PkuWs04f+pPZfolCSIlZ0SlQXIDR7U4bnd+IHePpF8w3IXyzOVtxQp3ektOHfPk
         srKMww/prZWr1APHvmlQdIv10obrp0nWlKsK4J//+K4w7FW3nwVVunPKw9zab46xTj9f
         MRQA==
X-Gm-Message-State: APuU4Z94xs0OS2qIm5H+qRjbLDn3s5zzApwhQHX/poy2Yx9tI5NCfgl0
	IpWzskZb3VWk5R1NdR3KIdbHoy2t+tkL8Oc7DIAFLdsZuQYyOb1dD34qGfsiimwqfxQ=
X-Gm-Gg: AYBFou1G4a1Mky8U+JiHO0wNYfZDiD9nB1EpQIB5kM5gCG0l70FkpkigGXW+PfMsrJ8
	IjmqkQG8zkiO9yNRbzXErH+NiWOL12c+TPfU5baf0UM/z/rQXbSISmmRKDj8SviLIqi6gw0inzS
	RY7r+eIeWnwG3Fs4qXCBXmbQ+jYFY6fKaYj6B3Bn6OPgW6fo7gt//M+I0kal4xagmK7a1tk1lLZ
	3dDZS2CUQGV+NEWhfb2mC0gQJoYyqdm9uw1/9agIlqLyPHw0evIWw+G+lHbOEoGsFVn8Q7ONu4r
	pKhkiGB68H8CnaEcTuFzdPlSJTFS+4i8ynz/7sUEjRUn7+WCWwgy3osXomveNbiwqVb+3QMQiFr
	tMPA18tgn8bSmP5S9W/nIJPoqrGS4DzJmxrbDcKxD9sbU4a5WbWdOV+4+yA+LH36BvSlPMCHv8p
	rS3/85s+elSxmeHQq/cLvstpqkNqjyUsUPjqeqLwopXI8+x4V3ljADbzvJ/17G1rzsccu9XEjZC
	KJRAxUzbWUXt7auA6pvDyGY5rO0AQxIoLXJhOHxRGq7U+u5utd2F0y7MVKMn2WVAKXm2OJuNjkI
	EQ5n7VGXRk9UvOJ1vB3fyYpI6SdhzNq94uAETLYCtu0BdHJtGbEr6V3yeZ944Qk/WcFIMw2eY+s
	ffQXMGmiY7009To8ucJ1sC4BiZN1Mnhc=
X-Received: by 2002:a05:7300:a943:b0:36c:991e:c9b with SMTP id 5a478bee46e88-36c991e288dmr14652570eec.14.1793878751259;
        Thu, 05 Nov 2026 03:39:11 -0800 (PST)
Received: from lwq-System-Product-Name.. ([23.247.137.158])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36ca38f53a6sm15089493eec.15.2026.11.05.03.39.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 03:39:10 -0800 (PST)
From: Yaohan Li <shunsheng1218@gmail.com>
To: netdev@vger.kernel.org,
	david@ixit.cz,
	davem@davemloft.net,
	kuba@kernel.org
Cc: edumazet@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	oe-linux-nfc@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net v2] nfc: rawsock: serialize SEND_SHUTDOWN with the TX work requeue
Date: Thu,  5 Nov 2026 19:38:12 +0800
Message-Id: <20261105113812.969651-1-shunsheng1218@gmail.com>
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

rawsock_release() sets SEND_SHUTDOWN before cancelling tx_work, but it
updated the shutdown flag without the write-queue lock that
rawsock_data_exchange_complete() holds while it tests the flag and
re-queues tx_work.  A deferred completion could pass that check before
the flag was set and still schedule the work after cancel_work_sync()
had returned; the worker then ran on a socket that was freed right
after release dropped its reference.  KASAN reports the
slab-use-after-free in rawsock_tx_work().

Set SEND_SHUTDOWN under the write-queue lock, so the completion either
queues the work before the flag becomes visible (and cancel_work_sync()
then covers it) or observes the flag and does not queue.  The
completion-side check from the previous submission is kept.

The remaining requeue window after the cancel-based teardown was
previously raised in review of that change (CVE-2026-23372): an
asynchronous NFC completion can queue tx_work after
cancel_work_sync() has returned.  This change closes that window and
does not claim to be the first report of a rawsock teardown
use-after-free.

This issue was found during an AI-assisted source review of the socket
release, TX work and deferred data-exchange completion paths.  It was
reproduced on a KASAN kernel with a deterministic timing-injection
harness for a deferred NFC completion callback: with only the
completion-side check, stalling the completion between its shutdown
check and schedule_work() while release ran produced seven
slab-use-after-free reports in rawsock_tx_work(); with this change the
same sequence and the original purge-window injection produce no
reports.  The tests run in QEMU with a virtual NFC device; no NFC
hardware is involved.

Link: https://lists.openwall.net/netdev/2026/03/24/271
Fixes: d793458c45df ("nfc: rawsock: cancel tx_work before socket teardown")
Cc: stable@vger.kernel.org
Signed-off-by: Yaohan Li <shunsheng1218@gmail.com>
---

v2:
- Set SEND_SHUTDOWN under the write-queue lock, so a completion that
  tested the flag before it was visible can no longer requeue tx_work
  after cancel_work_sync() returned (v1 only added the completion-side
  check, which left this ordering window open).
- Added deterministic A/B testing of that window: stalling the
  completion between its shutdown check and schedule_work() while
  release runs reproduces the use-after-free on the v1 code and is
  clean with this change.
- Corrected the Fixes tag to the cancel-based teardown commit and
  linked the earlier review thread for the remaining window.

v1: https://lore.kernel.org/r/179378590950.74297.14503648624087894519@gmail.com/
 net/nfc/rawsock.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/net/nfc/rawsock.c b/net/nfc/rawsock.c
index f7d7a599fade7..dd8401e3402d3 100644
--- a/net/nfc/rawsock.c
+++ b/net/nfc/rawsock.c
@@ -68,12 +68,23 @@ static int rawsock_release(struct socket *sock)
 		nfc_sock_unlink(&raw_sk_list, sk);
 
 	if (sk->sk_state == TCP_ESTABLISHED) {
-		/* Prevent rawsock_tx_work from starting new transmits and
+		/*
+		 * Prevent rawsock_tx_work from starting new transmits and
 		 * wait for any in-progress work to finish.  This must happen
 		 * before the socket is orphaned to avoid a race where
 		 * rawsock_tx_work runs after the NCI device has been freed.
+		 *
+		 * Set SEND_SHUTDOWN under the write-queue lock so it is
+		 * ordered against rawsock_data_exchange_complete(), which
+		 * tests the flag and re-queues tx_work under the same lock:
+		 * either the completion queued the work before we take the
+		 * lock (cancel_work_sync() below then covers it), or it
+		 * sees SEND_SHUTDOWN and does not queue.
 		 */
+		spin_lock_bh(&sk->sk_write_queue.lock);
 		sk->sk_shutdown |= SEND_SHUTDOWN;
+		spin_unlock_bh(&sk->sk_write_queue.lock);
+
 		cancel_work_sync(&nfc_rawsock(sk)->tx_work);
 		rawsock_write_queue_purge(sk);
 	}
@@ -168,7 +179,14 @@ static void rawsock_data_exchange_complete(void *context, struct sk_buff *skb,
 		goto error_skb;
 
 	spin_lock_bh(&sk->sk_write_queue.lock);
-	if (!skb_queue_empty(&sk->sk_write_queue))
+	/*
+	 * Once the release path has set SEND_SHUTDOWN, do not requeue
+	 * tx_work: the socket may be freed right after cancel_work_sync()
+	 * returns.  The flag is checked under the same lock that the
+	 * release path uses to set it.
+	 */
+	if (!skb_queue_empty(&sk->sk_write_queue) &&
+	    !(sk->sk_shutdown & SEND_SHUTDOWN))
 		schedule_work(&nfc_rawsock(sk)->tx_work);
 	else
 		nfc_rawsock(sk)->tx_work_scheduled = false;

base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
-- 
2.34.1

