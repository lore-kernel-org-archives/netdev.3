Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792658971;
	b=gt13wsv4x/WJFiuLr07vLyWAStc2J3hmqH1jds5yxf2wceC99LUfrZkcbRGKkbY2Hba3
	 b+eG4Q59ZKd/lRuTIzoNsegzQQ3XI/zH9o0xeHZZ3pJWG8tMPiF2d7ZSHF26DB9ErC7Ya
	 FPvkoHcR3ddfm8lex8S1IM93W8mNp2b9idDTNlAiTaiVZ2JjUBXLYzqHL9eF1+vlzufSc
	 24iWvKUvjZSj0y6OLxlz0tyGU1CtYHBnB5VuDwukflY8SE5qSlKiREah0D5gmhBIU3zUu
	 ZRz+wugpzrl0epZCZgjdzGHk4v/BPd6mzNibYHj4tRU4ig1pI7Rsfff9W9uLRbt3SVQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792658971;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition;
	bh=BX8XtwUSVcpbq9kDR3EqD3C23IHf4802hljAOQURif4=;
	b=Cn4zXCGJGyrvf8MHI+C9HO0tyQsrD5kQkwwUKzpSHKCTlz8tf+lU6uLj9dPn+N3cSdqj
	 cUq6txkL6bZFEn9UhOlzSKnm68gynybn5V4jC/MV3mujGtaltA7cSBVAcPaphCU8uw64r
	 y8GB6CdilGP5MiJbyPgqCQ4aDHAcVawn3yGGDY3KqxZ92HNqyMpH1tEcdLTjNAKX2rJhh
	 Dj0fmAgJPfbOoUYtN+3hvo7TprJlozKyO64vCE+ueu1Y5BXRxmiCkrHBuc5GTvIeI9kYK
	 ebYnU8oi0mTOERj5RYYwt4lwersvYRlXfxKnXCKYO7AGy+gHYfCIEFMoEwB4vKlNE/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Ft8EaYkL;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=Bm8+e81K;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72E3D606A319
	for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 08:49:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 72E3D606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Ft8EaYkL;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=Bm8+e81K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792658969;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=BX8XtwUSVcpbq9kDR3EqD3C23IHf4802hljAOQURif4=;
	b=Ft8EaYkLK/h2xnMTtOOD2SSWy64dGpkMEIpxYJfT424D9nxg1M3YzhWHFYum02MiWKUFfw
	OD+bNAI0JCJJUo2N6vjKezgwrwL5i/oXbWclFs3HZDK+xLNPlt52EzJgeVw9dHB637xPTM
	sAJPuYzP0RnhaSzEcs5T8prUyxGjqG4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-74-XbeeKPPgOdiXD-nEPlVOcw-1; Thu, 22 Oct 2026 04:49:28 -0400
X-MC-Unique: XbeeKPPgOdiXD-nEPlVOcw-1
X-Mimecast-MFC-AGG-ID: XbeeKPPgOdiXD-nEPlVOcw_1792658967
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-48e1d839ddaso1083480f8f.3
        for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 01:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792658967; x=1793263767; darn=vger.kernel.org;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BX8XtwUSVcpbq9kDR3EqD3C23IHf4802hljAOQURif4=;
        b=Bm8+e81KI4PwYTO2i9QPubqb7W45r83CrmHZWJY+LjJP0puQq1JgTKDAUgPVjS9Glv
         VU9izlkfFp/OuDWYT3LwN0Y3HBmW+oPV87+VQGbaIUrZMFs7A1siLMV5zd9a35Ilul1k
         spxmkvhsvPYDN6Exj+6idUIKNMGzZ2D9rOJ5wN3/fMDPYW8P183AM1Cn4NSU3ngBc23K
         OorSrp7q/LQUKFvWOsPmZdbb5bX4Yo96ZhtFrvnkmpvmrhQ0aFP3gyVZySMMrTbDj4cd
         Mt8IcHEUHb0Z0fLUw7DDQ82JcyArf5cEwEfIQ8LRc9L3ZEaDYIvyqnXql+QAiUapIsLO
         xz5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792658967; x=1793263767;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BX8XtwUSVcpbq9kDR3EqD3C23IHf4802hljAOQURif4=;
        b=cj1ypRg9e+/foSh0JoCWsr/jOh/+1YQwquA5ve+ito12NmJvrzwpAKeh7X11FPLnzd
         ww1TspHAwQJnCyjJf0wUQyabZ5YW8sRcbdtIH1bJEsYH+DaE/3zzIPSAQRCfYPaB5HfM
         B4VxPnYOs4BO2hHorIBUOYG9ntg1iAFg5Vy1mqjYtdAbElMkZp/OMHjVZ5YvueFUFuG1
         iLqzAk0MMH6KfEL2ysMTKCUS8I5Q7xUKS80frW/p6R4dmnse46ytGkqYuPOyDJM0NvTw
         mybl7ASEt5uvD/zNjAGPtoqPYnZAH7IZdA6w7v891LYVT/vfX7ud+IM+mSjEMv283biW
         nmog==
X-Gm-Message-State: AFq9FYJMO2hQidyIigOnqZgL1txew54uiK+n8JkOk8eWr49S1VUDGNL5
	Vx3xTiMuOrIP71tPI+nQRGVly8TF5jl8FU8NVgINZVpu9M6I9EoEyPeAo19svQnPoziWqLdZm0q
	78Q/tvkY84w2vFbgxLRchyZoRUHwXhCN/f6JY8dKv0qfxG6Do6vsho9zNpQ==
X-Gm-Gg: AYBFou0HYiKG/PKK2xyhVZoAriFxJCdJlKJfI/tRKDjyLDLH5+zvI+rd2VJ79BYjGHZ
	PflbH5AnLjn25hZZNvfhw3Aa3OsHk14a/gqdK0lxuCLMKma/AOqdvJSDEdQyCeAoVt4mv88oXpl
	U9zUvQg2mRGOA7/jEH9NiAUoJRARMax1cP+vZTZPIiAd8qGfb1O0lt9d1i3ABTyDsOM0JB+FKWC
	BEKwjoy0WqOk8pzr7RmOgKNHzwuE8HTiDMO/yCCVhdF2vDQjFeLmArlAPT7+oRnsU5uegCFykvr
	LkPwxfaxX0WYbm7tTxhxFXrL1uY9PRhkxmMI3W3768ocDXK7I81q1POE6RGt+VSpzWWZC8ZN7mG
	hNdAUakY1FsJC4g5/qmjHJUipT1DsnozTdfPoczBTve3vJh9WwIAc6A==
X-Received: by 2002:a05:6000:310c:b0:48d:faf4:54a8 with SMTP id ffacd0b85a97d-48e26493bedmr9865761f8f.11.1792658966832;
        Thu, 22 Oct 2026 01:49:26 -0700 (PDT)
X-Received: by 2002:a05:6000:310c:b0:48d:faf4:54a8 with SMTP id ffacd0b85a97d-48e26493bedmr9865713f8f.11.1792658966443;
        Thu, 22 Oct 2026 01:49:26 -0700 (PDT)
Received: from debian (2a01cb0580324c00de816f482c506a42.ipv6.abo.wanadoo.fr. [2a01:cb05:8032:4c00:de81:6f48:2c50:6a42])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e2581f412sm11282686f8f.16.2026.10.22.01.49.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 01:49:25 -0700 (PDT)
Date: Thu, 22 Oct 2026 10:49:23 +0200
From: Guillaume Nault <gnault@redhat.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@kernel.org>
Cc: netdev@vger.kernel.org, Simon Horman <horms@kernel.org>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Tom Williams <Tom.D.Williams@morganstanley.com>
Subject: [PATCH net] tcp: Fix dup-ack detection on non-SACK bidirectional
 data transfer.
Message-ID: <2ab9dc5f5b5e9f50d7a4aa02a6b6759fc86314c7.1792658454.git.gnault@redhat.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

When receiving a pure ack from a peer that also sends data, we can
have SEG.SEQ > SND.WL1, even though the segment contains no data. This
makes tcp_may_update_window() return true (because of the
"after(ack_seq, tp->snd_wl1)" condition), and tcp_ack_update_window()
then adds FLAG_WIN_UPDATE to the segment set of flags, even when
there's no window update.

Since FLAG_WIN_UPDATE prevents the segment from being considered as
dup-ack (as it's part of FLAG_NOT_DUP), this can inhibit fast
retransmit on non-SACK connections, making recovery very slow as it
now entirely relies on RTO.

Avoid this scenario by setting FLAG_WIN_UPDATE only when a window
update actually occurs. Pure acks with SEG.SEQ > SND.WL1 can now
be detected as dup-ack and trigger fast retransmission.

Add packetdrill selftest. Before this patch, the 1001:2001 segment was
retransmitted upon RTO, now it's sent right after reception of the
third duplicate ack.

Thanks to Tom Williams for the investigation help and initial
reproducer.

Reported-by: Tom Williams <Tom.D.Williams@MorganStanley.com>
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Guillaume Nault <gnault@redhat.com>
---
 net/ipv4/tcp_input.c                          |  2 +-
 .../tcp_bidir_fast_retransmit_nosack.pkt      | 42 +++++++++++++++++++
 2 files changed, 43 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_bidir_fast_retransmit_nosack.pkt

diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 99baf14afdfd..ef20bb5a0523 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -3959,11 +3959,11 @@ static int tcp_ack_update_window(struct sock *sk, const struct sk_buff *skb, u32
 		nwin <<= tp->rx_opt.snd_wscale;
 
 	if (tcp_may_update_window(tp, ack, ack_seq, nwin)) {
-		flag |= FLAG_WIN_UPDATE;
 		tcp_update_wl(tp, ack_seq);
 
 		if (tp->snd_wnd != nwin) {
 			tp->snd_wnd = nwin;
+			flag |= FLAG_WIN_UPDATE;
 
 			/* Note, it is the only place, where
 			 * fast path is recovered for sending TCP.
diff --git a/tools/testing/selftests/net/packetdrill/tcp_bidir_fast_retransmit_nosack.pkt b/tools/testing/selftests/net/packetdrill/tcp_bidir_fast_retransmit_nosack.pkt
new file mode 100644
index 000000000000..5c66b7171d22
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_bidir_fast_retransmit_nosack.pkt
@@ -0,0 +1,42 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// Verify that non-SACK connections properly detect duplicate acks when mixed
+// with other data segments from peer.
+
+`./defaults.sh`
+
+    0     socket(..., SOCK_STREAM, IPPROTO_TCP) = 4
+   +0...0 connect(4, ..., ...) = 0
+
+   // Three-way handshake, SACK not supported by peer
+   +0 > S  0:0(0) <mss 1460,sackOK,TS val 0 ecr 0,nop,wscale 8>
+   +0 < S. 0:0(0) ack 1 win 65535 <mss 1000>
+   +0 > .  1:1(0) ack 1
+
+   // Send 1000 bytes, peer acks everything
+   +0 send(4, ..., 1000, 0) = 1000
+   +0 > P. 1:1001(1000) ack 1
+   +0 < .  1:1(0) ack 1001 win 65535
+
+   // Send 4000 more bytes
+   +0 send(4, ..., 4000, 0) = 4000
+   +0 > P. 1001:5001(4000) ack 1
+
+   // Receive first dup-ack (considering segment 1001-2001 was lost)
+   +0 < .  1:1(0) ack 1001 win 65535
+
+   // Receive unrelated data segment from peer and ack it
+   +0 < P. 1:11(10) ack 1001 win 65535
+   +0 > .  5001:5001(0) ack 11
+
+   // Receive second dup-ack
+   +0 < .  11:11(0) ack 1001 win 65535
+
+   // Receive another data segment from peer and ack it
+   +0 < P. 11:21(10) ack 1001 win 65535
+   +0 > .  5001:5001(0) ack 21
+
+   // Receive third dup-ack, which should trigger fast retransmit (without
+   // waiting for RTO)
+   +0 < .  21:21(0) ack 1001 win 65535
+   +0 > .  1001:2001(1000) ack 21
-- 
2.47.3

