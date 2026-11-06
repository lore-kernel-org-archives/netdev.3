Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793927755;
	b=lLVgjWLJEXD5rx1et7ylYkj361562he+kwKoJCduS8yGX9Hg2rFHsn+Fmz8wmAPJctQp
	 0SltrKKSebV30i0ruMVowfWWh6bPeZZ6ItXOUNFxx8MXI0MPs247oMCVXmxFT2IeZpvPM
	 tzMD2AVy7Xma/mGmTWcuTcWd/dvYnPPIWRGj9HYruutbXxi/RPF1LmpUhewfdNPGhggHu
	 x7PqSXrtAUzoZehCSTWxpvNjQOKVCl5QPqwTo8zyOFQ+F0rwk6jASlydeY+GFPtOgMc0I
	 /Z3Y951htTFBNr0fijJ6ycMeos923+guiT9yKeMzpRzu8BP3aIoAOqtglmRHMw3DqMA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793927755;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=alLL1aRZfj6wt40HSFYb5SB8NlHrXFN4c0xYy1pcLT8=;
	b=BYB03fZIlTEEoG+dS00gGaX8kxLlSA+ixa0p51L0tIWWLS6hTQfC6nlOkDvRcA0uN0E7
	 wZLQ2dNm+zeWqyfMsZsZ1coREwLR/fG6RLFRiiDnahx/Z+xL9qRUKWok7xTIpLr7g6dk6
	 ZcQSkkXxQbLRgJz9VJfvHwxRFjx3llzE1UNFKj25RTXkLChxSKBinYpSKMVtJ9IjsGDXg
	 mlswW/Y7ISaP0Ehg97IntDoX1f3ikbn29MwtXHZsxzmUwbDAeFEEhuJ6HVDNfeIwABK/a
	 K4039fkSBp46/geAL6Yj43c8i6xTYTWnbp1+7HDwNc75r9ZWhbhOwxASMgr6rOWeVYw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=P8IFIrWJ;
	arc=none smtp.remote-ip=209.85.128.172
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2F27606A326
	for <netdev@vger.kernel.org>; Fri,  6 Nov 2026 01:15:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A2F27606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=P8IFIrWJ
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-8b3299aed39so365397b3.1
        for <netdev@vger.kernel.org>; Thu, 05 Nov 2026 17:15:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793927754; x=1794532554; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=alLL1aRZfj6wt40HSFYb5SB8NlHrXFN4c0xYy1pcLT8=;
        b=P8IFIrWJKzcIslrm1VEd1vQmHhWOwjik1vgKMosMn2cVAasyQLrSdQOCyWtd6A5AgJ
         l2Ix/ysD3Bjrv6ONnAGyTawfQ104cCSJuxF6MOOiEOlnM2jvtmGzUTCu1g8iGYGCGmoO
         7ssKSX2Z49ZqQXHf5uzA71r4AXg5yVy8+whe8RfuKr28ol/Gx6ziV9QqgoVvTJyGH+Wd
         IL6j/kRtk+WxECFfS2ypGBEtvaZ/Ju8fsCBq1zyfT4Ag+BdZOO9epNGmojJwYQ2+WY2i
         qaaZwfLSPnIHuScJQyWHCTqWFM2cM6B4JnM41zrSFL5ryl1yYY5JQeCCpezXSIJldnFG
         zf/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793927754; x=1794532554;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=alLL1aRZfj6wt40HSFYb5SB8NlHrXFN4c0xYy1pcLT8=;
        b=EJxHOl7ZJxlbBtRvaINdbSMwHg2tBZCvdvK1KgiCHtWvppqNeIGDhU+xHCsD3QC6in
         QxOLb81aLXvQ98t12XLO0TP/pygsMOHOuNuJ8yM5mqs3W61HAFBywNhtPRuRMMOBzZSX
         x4+BM7EwCMxZiOJFcagqoekD9lBJJVFmnSKdXxHTVj79ZBXeXJNQ3GlnZGL8rRwfQZbu
         hctxabScBCxoxIA7OpQgqFKKJ2P+/cXiXhH18Pd0Fmyk0e1P4toj4N5NVt0zL1wpbP3e
         zIwi+/vP9BDUkAQwx9nAKd+LyiU5/LyEwc2Bhyv7rlKq9BRWNVgzQyCtTeJIQwtE7SeW
         0tVw==
X-Gm-Message-State: APuU4Z9QTfkvyB5+KhSrm4Z4tCyvsk5u1c59cWaBg4jVq3giQ3FEO1fO
	Kycngp95cfwUJDLYZWKTEOyMzn+qhY1TI/5I1yLNslBqn/+XLisn1F6ZNMgpa+oLVeI=
X-Gm-Gg: AYBFou2d9Ijj2HIDVX5H6HilZy6n/yKNHWx0viYq5kt0QdKKC231COO9VNqxuC9jZhS
	VkPw4u/b1xHKnqYZP/iBHM9mbLi07413ZeZttaFwpgKPG6JRluULjDBCHsKsGoIOtRxjjM4wFdn
	z/jcs3T1AtDP9jREr20Pgahac0ogkN9NjAmxam60r9XP6rCZ9CJpySX8yp5GuVqsa3HpvcIHkri
	cytDnt4qROOqLfotDUjMe3xfutrZ4UjM2W+gzb8NjsArybRUCOQecq35xe08R54biUXReYW25VB
	Agi+1OVkC6uzWwgESEMc8kjiAdWu2pOn3gjniQDPzn8zIIjKXDfmWfplXdBD7uq5krCk5kG4kdk
	VByDErN4vM+g7dGCCFHUphZ6h7X+7G4M+tBRRjtb0x/bSPaVbyRndub6tSTrtOLbIoma6GCFyAe
	IXDX/kisRyBr9xYZKQiTmYL1cwI8OsrI27KgMq94XhCPpwqeyZVRicoT1xLMHE7L1qUVFbgVhBM
	LxzIqjJQy95zez6vB4ASpk1nnFA08/4QetTNc2na/f2pxZNan9Xi7ci6VK/Z/Z9z4z9ntjUvZBz
	L0DxrrxvTQd9xLSD+bi37ARoN4kRXgeim53SqDwKOLNovznnJvTDuA==
X-Received: by 2002:a05:690c:f03:b0:8b0:db26:88be with SMTP id 00721157ae682-8b341921355mr4114727b3.19.1793927753513;
        Thu, 05 Nov 2026 17:15:53 -0800 (PST)
Received: from VPN-156-173.vpn.usf.edu ([2607:fe50:0:f802::4046])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b33f7721ddsm8307427b3.7.2026.11.05.17.15.51
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 05 Nov 2026 17:15:53 -0800 (PST)
From: Juan Agustin Niccolini <juanagusnicco@gmail.com>
To: netdev@vger.kernel.org,
	linux-afs@lists.infradead.org
Cc: dhowells@redhat.com,
	marc.dionne@auristor.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@kernel.org,
	davem@davemloft.net,
	horms@kernel.org,
	jaltman@auristor.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] rxrpc: Fix rxrpc_sock UAF caused by missing poke in rxrpc_abort_eproto()
Date: Thu,  5 Nov 2026 20:15:50 -0500
Message-ID: <20261106011550.59902-1-juanagusnicco@gmail.com>
X-Mailer: git-send-email 2.53.0
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

Since commit 03fc55adf876 ("rxrpc: Only disconnect calls in the I/O
thread"), only the I/O thread disconnects a call from its connection
channel, and hence, code that completes a call elsewhere must poke it
with rxrpc_poke_call(), which queues the call for the I/O thread.

rxrpc_abort_eproto(), which aborts a call when a DATA packet fails
security verification in recvmsg() or rxrpc_kernel_recv_data(), marks
the call as complete but doesn't poke it.  The call is then never
disconnected, not even when its socket is closed, because
rxrpc_propose_abort() skips calls that are already complete.  It stays
in conn->channels[], and its call->socket pointer, which holds no
reference on the socket, dangles once the socket is closed and freed.

If the peer then sends an rxgk CHALLENGE on that connection,
rxrpc_post_challenge() finds the call and reads the freed socket's
flags.  If the socket had enabled RXRPC_MANAGE_RESPONSE, the call is
then passed to rxrpc_notify_socket_oob(), which takes the freed
socket's lock:

  BUG: KASAN: slab-use-after-free in rxrpc_input_conn_packet+0x3b2/0x820
  Read of size 8 at addr ff1100011b343328 by task krxrpcio/21029/1030
  ...
  BUG: KASAN: slab-use-after-free in _raw_spin_lock_irq+0x72/0xe0
  Write of size 4 at addr ff1100011b343308 by task krxrpcio/21029/1030
  Call Trace:
   _raw_spin_lock_irq+0x72/0xe0
   rxrpc_notify_socket_oob+0x54/0x3f0
   rxrpc_input_conn_packet+0x682/0x820
   rxrpc_input_packet_on_conn.part.0+0x5f4/0xc30
   rxrpc_input_packet.constprop.0+0x8a2/0xea0
   rxrpc_io_thread+0x944/0x1570

rxrpc_post_challenge() doesn't appear in the reports because the
compiler inlined it into rxrpc_input_conn_packet().

Depending on the freed socket's contents, rxrpc_notify_socket_oob()
can also call a function pointer obtained from it (sk->sk_data_ready()
or rx->app_ops->notify_oob()).  The use-after-free is deterministic, an
unprivileged process can trigger it, and since the attacker controls
when the CHALLENGE is sent, they can reclaim the freed memory first.
These conditions make the bug reliably exploitable to hijack kernel
control flow and escalate privileges.

Note that without rxgk the stranded call still leaks.  A client call
pins its connection, so destroying the local endpoint hits the BUG()
in rxrpc_destroy_client_conn_ids(); and for any stranded call, netns
teardown hangs in rxrpc_destroy_all_calls() waiting for it to be
freed.

Fix this by poking the call from rxrpc_abort_eproto(), as
rxrpc_abort_calls() already does.

Fixes: 03fc55adf876 ("rxrpc: Only disconnect calls in the I/O thread")
Cc: stable@vger.kernel.org
Signed-off-by: Juan Agustin Niccolini <juanagusnicco@gmail.com>
---
A deterministic reproducer for the KASAN report above is available on
request.  A working privilege escalation exploit was sent to
security@kernel.org on 20 October, and I can share it with the rxrpc
and netdev maintainers upon request.  The bug was first reported to
the rxrpc maintainers and the security team on 11 October.  rxrpc
autoloads on Ubuntu, Fedora, and Arch when any process opens an
AF_RXRPC socket.

 net/rxrpc/ar-internal.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/rxrpc/ar-internal.h b/net/rxrpc/ar-internal.h
index 865f05fe37ab..31528b5e34cb 100644
--- a/net/rxrpc/ar-internal.h
+++ b/net/rxrpc/ar-internal.h
@@ -1455,6 +1455,7 @@ static inline int rxrpc_abort_eproto(struct rxrpc_call *call,
 	struct rxrpc_skb_priv *sp = rxrpc_skb(skb);
 
 	rxrpc_abort_call(call, sp->hdr.seq, abort_code, -EPROTO, why);
+	rxrpc_poke_call(call, rxrpc_call_poke_abort);
 	return -EPROTO;
 }
 

base-commit: fafbc4051123d5459ea6950899cec08ed946e278
-- 
2.53.0

