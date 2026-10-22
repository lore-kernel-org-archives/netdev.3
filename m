Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.226
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792707462;
	b=tYSunin6jw74vKk4U717u4Ucm4KP6ZlmuL5vfcS3Y0FZ1nBNezXkAB3GmlP/eRqXhdC0
	 42OuaqXNZuoueFgckLjZpWoKDb1oHAlnyeIBLuromm8EfUIrwSSCZ2qw68osj0gd1TfcA
	 TmIbfqmbpP2wK325Im7EiQjJPYqYqGWqaZhx2Fd292fIeX/dylDXnTdrmbI4VXZOsWPr1
	 Iz6E5sbkT3W87Nb2SDFtJiFJ3mpOkzUeSpHm7AbkoG6lebLDSde24g2vdoJrkeoacfzJe
	 HRreZb5MxTzT1tbHRWG5Vre/1N5QbAkw82KCcmmXYA1FarZTSbHQJkB5LzvSiDmBLfA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792707462;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:X-Relaying-Domain:
	 Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=0R7rE+XCksbEQAe/OwXOT+2nY0iz6MsHRCIFnvTH3No=;
	b=G6MZpXUBKYRtEiwfi/bqPFEoLZxJBxHwL8ruynzT73ZC3AcSDjdPbJazbwm2p8r5u7Bf
	 SyUM+l/Lh8sY0WcirF8tIeMK6vGTZ+KSvEPj3lL3qYsoYQHlrtRnPbF6N6wxXTzzsqS4K
	 LgFwZJKib95cDTlRtPRzRebiZAR1wYERqvy7hn03C03Pk+0OfRs4h1f+j5pxTW+Ii4089
	 68xpJdp+roJKCsSWFIHSIsXSsnqmjG5Czo44zKTbOuGdk/uR5s6sYhuaEZg026ygnjCol
	 1Qm0htdOREwbXMyJFxaJvmwSOA5FHYhM1oVpKKHwIXbSr1QBYgeGo0h2IY+ymIja3ag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=purestorage.com;
	spf=pass smtp.mailfrom=purestorage.com;
	dkim=pass header.d=purestorage.com header.i=@purestorage.com header.a=rsa-sha256 header.s=google2022 header.b=ZgZMNMw+;
	arc=none smtp.remote-ip=209.85.215.226
Received: from mail-pg1-f226.google.com (mail-pg1-f226.google.com [209.85.215.226])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4D1B606A329
	for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 22:17:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D4D1B606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=purestorage.com header.i=@purestorage.com header.a=rsa-sha256 header.s=google2022 header.b=ZgZMNMw+
Received: by mail-pg1-f226.google.com with SMTP id 41be03b00d2f7-cd69954c755so205235a12.3
        for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 15:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1792707461; x=1793312261; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0R7rE+XCksbEQAe/OwXOT+2nY0iz6MsHRCIFnvTH3No=;
        b=ZgZMNMw+BxZSQVUaLTjV8OT7YDViZ/mW0pBn0m29kyYPV8feUICu2x5DiG6dd1hMM1
         30SdQ7bBsXQreyr9B50WSzAwrG1Phn0294CjnAIInNe+VYIwRwzWKAJg04ndcOL1uRhO
         LewgZ4Gqra1wgEPRiVl+t2+mokkuYjAZQykNQ1ihWx/O+WsQG3KX/ey9YRInE90JHs/T
         5RU01+41nPqnHQthun2PQ2JvoQw4A0sR4tVzL6xoJtp59jGaSkLD3LO0iYndLphKLMFp
         Hz5up95lq6l9BxJNZMtpeTck4TzWQ0vY1BkkzCWPu9qJSnT3Pl5o3OixgKDxLoTeXQLn
         8LOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792707461; x=1793312261;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0R7rE+XCksbEQAe/OwXOT+2nY0iz6MsHRCIFnvTH3No=;
        b=kHGNGSRrckahe7a6pF5UMP7qAHoqg+1dUiIW9VJVEYD49+15yuvpYN7xmcWjVR5P44
         ZQR98ivClyRjSM2RpSR/lxGcnREMcI+rlkiIy7fgzy4qFlzyYeAjYtFzXmdWa7L3rsGC
         k1hhV2qIzOAowD1quP7Szrm9MaZtcN5JTvPuacQO6czEUdAcEFdzkFMVv1Cl5W0d8A2e
         w/8GMBJtbEcyNPZkEGKRA+GACpSbdP0r6+KqcDZaV+9c9U9BkRhkKZgSVdEYoUbajK5J
         tRNVTuwquLCnDxmssA5fE2b2AnUFCf6J9EupX8Nxh+HdzgwFghP8tO0PmwBeFdtYRJ2j
         MLew==
X-Gm-Message-State: AFq9FYKuxZTl2qlqdOgcRdH00aN6QxKpZUfxu0VhJwrgxPtR3rNvRtAq
	Kjypbt8TVUDYzthi89HLA4IgW8T7KEEwerrGq9e/pC2Z4k4qxizYgr8M8XvkaVbbpHH+Rnxam4T
	mEbRsZnL+vtIT9Z7vHFmOnpou/HYem+5AJrJz
X-Gm-Gg: AYBFou2PZo01TRZjhXbaRp/0O3gegmVB2/3toBX/5DR3Lw5pIrJl2rrQXVYk1GnUHNb
	XELXnarXnBFcOdzCFKYDlEt8FNOlWlJ32hrs3bqllSm5BRrV1iYFop0uRYy6TAJlsYp1O6vf3Mr
	XAWGRFgeBc8052vrs8kUmkTAu2Bd32QehFkHkhvRzcGAnIjK/W4RGp23tMwS+dI4DuEyGFVhN4l
	8XDxZZDTU9enJoRsNawJ5zw6k+3aheWupPiqz5V9OqTsGHaD0RRmkksn2MWC61fY+AtSalwXzeC
	Nm7E62eqlxCr5RhAYndo11rNN3YaJyR56mWZ4/GXf2ZcK+fLIt5JS34BnB0dUB1btJmcM2/MyTd
	HZa2nhF/5n2NCUxn26Msduc4CiI77+LF81mY=
X-Received: by 2002:a17:90b:3c8b:b0:3a8:185:cf40 with SMTP id 98e67ed59e1d1-3adcdfaab13mr261184a91.10.1792707461243;
        Thu, 22 Oct 2026 15:17:41 -0700 (PDT)
Received: from c7-smtp-2026.dev.purestorage.com ([208.88.159.128])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3adcb1ea2a2sm362551a91.8.2026.10.22.15.17.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 15:17:41 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-rjethwani.dev.purestorage.com (dev-rjethwani.dev.purestorage.com [IPv6:2620:125:9025:23::2ea])
	by c7-smtp-2026.dev.purestorage.com (Postfix) with ESMTP id 260834029F;
	Thu, 22 Oct 2026 16:17:40 -0600 (MDT)
Received: by dev-rjethwani.dev.purestorage.com (Postfix, from userid 1557719937)
	id 236CBDC48A1; Thu, 22 Oct 2026 16:17:40 -0600 (MDT)
From: Rishikesh Jethwani <rjethwani@purestorage.com>
To: netdev@vger.kernel.org
Cc: Rishikesh Jethwani <rjethwani@purestorage.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sabrina Dubroca <sd@queasysnail.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Dirk van der Merwe <dirk.vandermerwe@netronome.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v2 4/4] tls: device: fix next-record queued checks in core-driven RX resync
Date: Thu, 22 Oct 2026 16:15:00 -0600
Message-ID: <20261022221732.1397620-5-rjethwani@purestorage.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261022221732.1397620-1-rjethwani@purestorage.com>
References: <20261022221732.1397620-1-rjethwani@purestorage.com>
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

TLS_OFFLOAD_SYNC_TYPE_CORE_NEXT_HINT resync tells the device where the
next record starts. That is only useful if the device has not yet seen
the next record's header, so both places that send the hint first check
whether any of the next record is already queued on the socket, using
tcp_inq(). tcp_inq() counts from copied_seq, so the checks are only
right if they know how much of the current record has been consumed.

tls_device_core_ctrl_rx_resync() runs when a record is entirely
encrypted and checks tcp_inq() > rxm->full_len. With the original
strparser the record had already been read out, so this asked for more
than a whole record beyond the current one instead of any data at all,
contrary to the intent stated in the commit that added it. Since the
TLS-specific strparser the check is correct in its normal mode, where
the record is still queued, but copy mode has consumed the record and
keeps the original error. The hint can then be sent immediately for a
boundary the device has already passed.

tls_device_rx_resync_new_rec() runs when a new record header is parsed
and checks tcp_inq() > rcd_len, relying on the queue still holding the
record being parsed. That does not hold once part of the record has
been consumed: in copy mode, and with the original strparser, which
also consumed incomplete headers before parsing them. The check then
underestimates what is queued and can send the hint after the next
header has arrived, too late for the device to use it.

In both cases the attempt is wasted and the next try is made only after
backoff, keeping the stream on software decryption longer.

Count from the record start instead of copied_seq. With the record
start now tracked by the strparser in both modes, rcv_nxt minus that
start is the number of bytes received for this record and beyond,
regardless of how much has been consumed. The
tls_device_rx_resync_nh_delay tracepoint now reports received sequence
space from the record start, including data already consumed in copy
mode. A FIN right after the record now counts as queued data, which
only defers a hint that could not be used, since no record can follow
it.

Only drivers using TLS_OFFLOAD_SYNC_TYPE_CORE_NEXT_HINT are affected.

Found by code inspection while working on TLS 1.3 hardware offload
support.

Fixes: f953d33ba122 ("net/tls: add kernel-driven TLS RX resync")
Signed-off-by: Rishikesh Jethwani <rjethwani@purestorage.com>
---
 net/tls/tls_device.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/net/tls/tls_device.c b/net/tls/tls_device.c
index a6c4d0cc54c7..8181564600c1 100644
--- a/net/tls/tls_device.c
+++ b/net/tls/tls_device.c
@@ -805,10 +805,10 @@ void tls_device_rx_resync_new_rec(struct sock *sk, u32 rcd_len, u32 seq)
 		if (likely(!rx_ctx->resync_nh_do_now))
 			return;
 
-		/* head of next rec is already in, note that the sock_inq will
-		 * include the currently parsed message when called from parser
+		/* head of next rec is already in, count from the record start
+		 * since copy mode may have consumed part of it already
 		 */
-		sock_data = tcp_inq(sk);
+		sock_data = READ_ONCE(tcp_sk(sk)->rcv_nxt) - seq;
 		if (sock_data > rcd_len) {
 			trace_tls_device_rx_resync_nh_delay(sk, sock_data,
 							    rcd_len);
@@ -841,6 +841,7 @@ static void tls_device_core_ctrl_rx_resync(struct tls_context *tls_ctx,
 {
 	struct tls_sw_context_rx *sw_ctx = tls_sw_ctx_rx(tls_ctx);
 	struct strp_msg *rxm;
+	u32 next_seq;
 
 	/* device will request resyncs by itself based on stream scan */
 	if (ctx->resync_type != TLS_OFFLOAD_SYNC_TYPE_CORE_NEXT_HINT)
@@ -866,9 +867,10 @@ static void tls_device_core_ctrl_rx_resync(struct tls_context *tls_ctx,
 		ctx->resync_nh.decrypted_tgt += TLS_DEVICE_RESYNC_NH_MAX_IVAL;
 
 	rxm = strp_msg(skb);
+	next_seq = tls_strp_msg_seq(sw_ctx) + rxm->full_len;
 
 	/* head of next rec is already in, parser will sync for us */
-	if (tcp_inq(sk) > rxm->full_len) {
+	if (after(READ_ONCE(tcp_sk(sk)->rcv_nxt), next_seq)) {
 		trace_tls_device_rx_resync_nh_schedule(sk);
 		ctx->resync_nh_do_now = 1;
 	} else {
@@ -878,9 +880,7 @@ static void tls_device_core_ctrl_rx_resync(struct tls_context *tls_ctx,
 		memcpy(rcd_sn, tls_ctx->rx.rec_seq, prot->rec_seq_size);
 		tls_bigint_increment(rcd_sn, prot->rec_seq_size);
 
-		tls_device_resync_rx(tls_ctx, sk,
-				     tls_strp_msg_seq(sw_ctx) +
-				     rxm->full_len, rcd_sn);
+		tls_device_resync_rx(tls_ctx, sk, next_seq, rcd_sn);
 	}
 }
 
-- 
2.50.1

