Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793219562;
	b=tKYNEGNZfkOdZ31Qjhu6DyzITYdmOANlaXK80R2o7Dhy3hsZDiwJp9jpmHrGNLGx+rmo
	 rB5l7TRqBmgc/Aen2MS2FAw3tQTE7lvZqwlDPsplfGZEmXYpPqT0TKlmwiHvxp7Un8Q6H
	 Asi1LNhl6dWjD/G0mVwlOb4huGgJ9q80e2RXw3ns7n5NnLX7/GSCk0Tqb3tpd+/PeA6GM
	 C4wXkd/0Wn/G9w/5Th8xUp0hilBkpn8+lwU6hkxH6k7ihXgRCpmzOoZuyB05+f4n3XMej
	 NQ3s82niH35+IKib1iKY6X6vBxXhGpsBwq4IAWfTfyyeZUH4RdijJcY92qbSc1AaYvA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793219562;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition;
	bh=1/IJkARZ+jkwU3nmNNgce1ZnNSxTNp4A2AYmF4Q7YPU=;
	b=nc4fI+u5o7qA0xx4HYo5SBB6KCdJpl6MHcacK1j6krRQlU0QOJlWfPCqHtnf+LsvPyb3
	 +dspn08Q7C2ZeMKar59vIZcSzdQhPQdnamaoXwYeI0NASTNYNyRqmyCdiG16pHdWisftI
	 IdwEd2r1/OWB2JaBcLQba3xrzvb2AnrZOHpdFDWZvscvA2o3pESdU0H4oK1RWvgJd0INh
	 eRCjp8/4gbYIIV+TmuvGiaQIwAvo2IOkD3pcI56PxyuSM2oajrNwzfK9C5JbPs7Lu8Wnd
	 MljOfFIfivnPFIZH0WK584O0HN1kL0fwS9FccDoK4iCgHZff4QA3rQf5zJIIJ865GuQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=cSxHyBOe;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=KtxwfD+6;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C42E606A31A
	for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 20:32:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4C42E606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=cSxHyBOe;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=KtxwfD+6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793219561;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=1/IJkARZ+jkwU3nmNNgce1ZnNSxTNp4A2AYmF4Q7YPU=;
	b=cSxHyBOefU4Op24p7ki02yY6G9RTbX1diuDy9hk3JuC+SuRUn/MJLTSPGshtgM50iSEiUo
	hEakk4a7XrE/FyXz8F/kjNwD9m9mRpYIGFM99TCBZf5CMYf75ARnDBNBpkEXBVVVD22p9/
	fLKvftKESYjvTEpBIUsodHsN/VMpE9s=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-259-jFO5YtEnP6y-Enp-8VOU5g-1; Wed, 28 Oct 2026 16:32:39 -0400
X-MC-Unique: jFO5YtEnP6y-Enp-8VOU5g-1
X-Mimecast-MFC-AGG-ID: jFO5YtEnP6y-Enp-8VOU5g_1793219558
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4a204ac318aso8422185e9.2
        for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 13:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793219558; x=1793824358; darn=vger.kernel.org;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1/IJkARZ+jkwU3nmNNgce1ZnNSxTNp4A2AYmF4Q7YPU=;
        b=KtxwfD+6PsKCmumYIdE0JNjHgGwIeF0oioiCo5WJtzCDG5Vbpyi2KTjSwjjZakwu4b
         c2YV1NfWTpGBZEr9vNkUgdYcd+IEvIO25wvIR72FxBzWHTeYjQj5r0W/3POvcDXmpaue
         dhYq8J1l4Bv2Gpo0qSgTAkjetkb2405nh3NKL7PBxrKQys8abGXR1Xl7yBlD9ecQwYL5
         Kf7ZRDo7k49bxFYMF6YpDGsmDUWQJIoUSBTNA3WesZlTv4gZHKPbDlLObIuqXQATvgwF
         +X64PBaVElktUqyW49HsaWszAlhui78xz04Ih/Sku4FGaxXyzsqHnB/r9bBZNw4T5lF0
         YLlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793219558; x=1793824358;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1/IJkARZ+jkwU3nmNNgce1ZnNSxTNp4A2AYmF4Q7YPU=;
        b=UVGzBFBmiOYxT33sjWiItqMjUNecRuXO3O6cn4BbpnnbjZcWdL0THrkr+Xxc2qfkxZ
         4Ly9r6AyAZY+CH1UstnwXDBPbZuHy683ntKaRpEU+7/3QA7jpU5275DjlfRM46BdDNUw
         5D9MeQ8ZwapDxywQIa2FEyxMCKlk1aznI3fPOJi7tn7grsgW6hW5emiXTJ3mpGjHXUT4
         0Ea+tbN1S/cCeIex6LEPBBEFsNbmf9H8b3h/GjuHSAONg/1JT21rFiQcdQ9ynMmjk0Zj
         TEHzSnZ9w3nV7d7eUSkLmBMVJspMejc+/ay40Z66ahAEMl9cwQZCVyWNdgt5mmTcDX6A
         MF9A==
X-Gm-Message-State: AFq9FYKLEeb6m7N/6LuQgJwJGoeZJK4LwL637CHbGpLmGSAg5f2HpNbX
	Pn4YHVChn6eITOVJ2cDDAemZR8pFeKhcnOcB5pnI6b6g3WvCdZCN4GaOAQY0FMTWLyTY1EPQUt9
	gGk32D7AhqbT0EYMDEJs+3JQwBEDXVKrV/yml6fT2fY5n9eSaRBDCSWDUsA==
X-Gm-Gg: AYBFou287Z+bLPAS6ebjubNEeY397UVzdesRqX6/MvxUKifRIzVbQx9hdIVjfiV8Xdl
	kSPDZbnYLlSVLTypF1rMaAiyIJq/KvTUlrHj6ZUkwJGYd1FF070wrsSdiws511w8SnuKViGhS+R
	cObI5O7PnW2kbyHgPChUzNtBxxFbUngN14jgpKy6Qk0HzllhQ/+l2dS0BiyEYhXUFbnQzSoPsgx
	BXfQKGEBG43zF1V74dBNyCYWDuAdjTFH5dFzFbtCbwLKw9ojCy16E+HjaYkAwu7CPotc6SbgJNb
	sQe9cjghXjX1UvYz5hYYk7A4XF/sm5J0pQRnjNP6HBDRKEO5nSrT3WdKf0zPJQ3VfvmKvyWJ4xI
	gNJMumWhJyZnL1M/RzsIVmthSCLiz4fr3QMNYG6nuXEF9Ascbl9Q6IhEiKGMmKgMJMPIZGDITYE
	sIj7enWsSkJcX4plnjWjQ8ZGHq
X-Received: by 2002:a05:600c:4593:b0:4a7:76fa:87e9 with SMTP id 5b1f17b1804b1-4a966d361dcmr78589555e9.21.1793219558396;
        Wed, 28 Oct 2026 13:32:38 -0700 (PDT)
X-Received: by 2002:a05:600c:4593:b0:4a7:76fa:87e9 with SMTP id 5b1f17b1804b1-4a966d361dcmr78589155e9.21.1793219557912;
        Wed, 28 Oct 2026 13:32:37 -0700 (PDT)
Received: from debian (2a01cb05923c9a00005ce1bcb3793264.ipv6.abo.wanadoo.fr. [2a01:cb05:923c:9a00:5c:e1bc:b379:3264])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a94fce50a8sm55512765e9.4.2026.10.28.13.32.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 13:32:37 -0700 (PDT)
Date: Wed, 28 Oct 2026 21:32:35 +0100
From: Guillaume Nault <gnault@redhat.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@kernel.org>
Cc: netdev@vger.kernel.org, Simon Horman <horms@kernel.org>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Tom Williams <Tom.D.Williams@morganstanley.com>
Subject: [PATCH net v2] tcp: Fix dup-ack detection on non-SACK bidirectional
 data transfer.
Message-ID: <6426d558e45fc6ab724c40af62e4a8793215dd8a.1793219189.git.gnault@redhat.com>
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

The "DUPLICATE ACKNOWLEDGMENT" definition of RFC 5681, section 2,
says that lack of window update is a necessary condition for a dup ack:
"(e) the advertised window in the incoming acknowledgment equals the
advertised window in the last incoming acknowledgment.". Spurious
window updates can thus prevent dup ack detection and, in the end, fast
retransmit.

Avoid this scenario by setting FLAG_WIN_UPDATE only when a window
update actually occurs. Pure acks with SEG.SEQ > SND.WL1 can now
be detected as dup-ack and trigger fast retransmission.

Also, stop setting FLAG_WIN_UPDATE in tcp_ack()'s header prediction
path. One of the conditions for header prediction to happen is that
received segments don't trigger a window update. This flag update was
thus wrong to begin with. Now that tcp_ack_update_window() sets
FLAG_WIN_UPDATE only if a window update actually occurred, we need the
header prediction path to stop reporting spurious window updates too.
Otherwise BPF programs would get inconsistent window update information
(CA_ACK_WIN_UPDATE) between fast an slow paths.

Finally, add FLAG_SND_UNA_ADVANCED to the definition of FLAG_NOT_DUP.
This is necessary for the case where an incoming segment acknowledges
less than a full segment of the retransmit queue. Such segments were
not considered dubious by tcp_ack_is_dubious() because of the spurious
FLAG_WIN_UPDATE flag, which prevented the segment from being seen as a
duplicate ack. Now that FLAG_WIN_UPDATE doesn't cover this scenario
anymore, we need another way to mark these acks as non-duplicate.
Adding FLAG_SND_UNA_ADVANCED to FLAG_NOT_DUP is the natural way of
doing this, since, by definition, a segment advancing SND.UNA, even by
a small amount, cannot be a duplicate ack.

A side effect of this patch is that repeated zero window acks received
from peer can now be considered duplicate acks (because of the the
"|| !win" condition in tcp_may_update_window()). Therefore, they can
now trigger fast retransmission and fast recovery, including congestion
window reduction, when the peer is stalled. This is RFC compliant and
shouldn't have any negative effect.

Add packetdrill selftest. Before this patch, the 1001:2001 segment was
retransmitted upon RTO, now it's sent right after reception of the
third duplicate ack.

Thanks to Tom Williams for the investigation help and initial
reproducer.

Reported-by: Tom Williams <Tom.D.Williams@MorganStanley.com>
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Guillaume Nault <gnault@redhat.com>
---
v2:
  - Quote RFC 5681 about dup ack definition (Eric Dumazet).
  - Remove FLAG_WIN_UPDATE from tcp_ack() header prediction (Eric
    Dumazet).
  - Describe behaviour change for the repeated zero window ack case
    (Eric Dumazet).
  - Add FLAG_SND_UNA_ADVANCED to the definition of FLAG_NOT_DUP (Neal
    Cardwell)
v1: https://lore.kernel.org/netdev/2ab9dc5f5b5e9f50d7a4aa02a6b6759fc86314c7.1792658454.git.gnault@redhat.com/

 net/ipv4/tcp_input.c                          |  6 +--
 .../tcp_bidir_fast_retransmit_nosack.pkt      | 42 +++++++++++++++++++
 2 files changed, 45 insertions(+), 3 deletions(-)
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_bidir_fast_retransmit_nosack.pkt

diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 1ddce9c4b7e8..050f2a26f834 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -107,7 +107,8 @@ int sysctl_tcp_max_orphans __read_mostly = NR_FILE;
 #define FLAG_TS_PROGRESS	0x40000 /* Positive timestamp delta */
 
 #define FLAG_ACKED		(FLAG_DATA_ACKED|FLAG_SYN_ACKED)
-#define FLAG_NOT_DUP		(FLAG_DATA|FLAG_WIN_UPDATE|FLAG_ACKED)
+#define FLAG_NOT_DUP		(FLAG_DATA|FLAG_WIN_UPDATE|FLAG_ACKED|	\
+				 FLAG_SND_UNA_ADVANCED)
 #define FLAG_CA_ALERT		(FLAG_DATA_SACKED|FLAG_ECE|FLAG_DSACKING_ACK)
 #define FLAG_FORWARD_PROGRESS	(FLAG_ACKED|FLAG_DATA_SACKED)
 
@@ -3959,11 +3960,11 @@ static int tcp_ack_update_window(struct sock *sk, const struct sk_buff *skb, u32
 		nwin <<= tp->rx_opt.snd_wscale;
 
 	if (tcp_may_update_window(tp, ack, ack_seq, nwin)) {
-		flag |= FLAG_WIN_UPDATE;
 		tcp_update_wl(tp, ack_seq);
 
 		if (tp->snd_wnd != nwin) {
 			tp->snd_wnd = nwin;
+			flag |= FLAG_WIN_UPDATE;
 
 			/* Note, it is the only place, where
 			 * fast path is recovered for sending TCP.
@@ -4354,7 +4355,6 @@ static int tcp_ack(struct sock *sk, const struct sk_buff *skb, int flag)
 		 */
 		tcp_update_wl(tp, ack_seq);
 		tcp_snd_una_update(tp, ack);
-		flag |= FLAG_WIN_UPDATE;
 
 		NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPHPACKS);
 	} else {
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

