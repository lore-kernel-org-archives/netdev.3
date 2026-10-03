Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 709F22E7379
	for <netdev@vger.kernel.org>; Sat,  3 Oct 2026 20:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791058595; cv=none; b=lAs17jj8Af78Itq4U2LWffTPvOWyC3ado5/df1yH4BzrKUqgLnPoecMZwycWXP/WpQsJcUqvNZSirAxLoWDWOqSxQWvra7xBdhIc93BmEdRyKuVDocVAUl7Ze9lAOpcgw4zp9Bsnqfrbl6b8HYHxfA5pTrPYCj0qI9HsRfsArUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791058595; c=relaxed/simple;
	bh=SyKBO76ev2NriW6LktGJTb69Uo9mhcn47+zY2SXVJ5k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RKRtLHql5Pfy3SkVIS+DhtXSA3RpD9YfQKoGKKvnjQlZEhldrJrxskyXO+RFeFE+Wx6NsAH+4P8C0hZaiMClek3mcLi6s0Sjlh8Z4KqcjXAP+4R7XOn21ewOR448ySFBJ3kR/NJC6vZAzfjsYKAHBK63uIczkwCwlQAOEFAnxtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gr3qjM2S; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gr3qjM2S"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4a16aaf2067so5027805e9.0
        for <netdev@vger.kernel.org>; Sat, 03 Oct 2026 13:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791058593; x=1791663393; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=xSJHmcS6fdALBnPJ5e4ZZCDQp3UfYu5aUPElGXfZW+Q=;
        b=gr3qjM2SOXIDXZ4oyvPCqdDXnS8Q8BPOE8b6TG+GYQLwCmc+wWac51qM1JTRvgJQ/m
         s8qdQAe8oZxD5NsPCq7TUxSt5wKxZ+nx5VMyA8Z2aBKboSnup2FOxdFnzVfIlAzd3Tnf
         JaDv9u63AlarcYCQ7JZLp6e74T1d+nj+5ZBeacTXfDzMhrZ5yaoj6HDJPCl30Y6+1bha
         tEf3/6tKZvEKgArhWqJ2SqSfsb3yYMiak5MFJvclKK2DrlTwZvzsP0aoBZMN0bZLGjAG
         uykj6B8nWrfdMykWIFgdB2IGpMagMTrd9dVFemn/KxKp5l8tFjKbPLZWDWvIavPpyoc4
         NXtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791058593; x=1791663393;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xSJHmcS6fdALBnPJ5e4ZZCDQp3UfYu5aUPElGXfZW+Q=;
        b=OJFtnkaDwZzLk76G56bhDWH3ycZiCrlzOvnI3SBClk9H6Dg8ykBfdP4mmMn6GqsmQv
         pIRu/uidzL84nbbYVo+o/NTdfzehFATsfeMMs+XUSHA6WATMqSf3jMMt7dby4iTCtm2e
         W41n/mQv1xxnwlzI7Jj0CJPm80/uV4O2XBbtoK0RX1dtIJ2TwegVW22yMhE62v2VQZvu
         0B+80SJLPgphuLPFBhc8JAO288Rw8jbe2Ry98OWaIXkV/gmK9ZXS9jDMmjmDxEsX/szX
         jVZVbhFtemRDTGOSMt3U6q5It8nPqO0F3U4916TqIc5LlcLoBDuwUuKVg3IiyRMF4ba4
         QVQg==
X-Forwarded-Encrypted: i=1; AKwUvBwe2ZqZiNS6/C2J3DcTx0Ie3bS7oy5Ywxx2Rh6U5qCWEy1xsaEQIDYCjodPdcqubPSrGLCQ9xw=@vger.kernel.org
X-Gm-Message-State: AFuF++lECT5jyR1/ZoCdJVz1i2T+uvdKd3ArGhJ16PFS6yqAQTzw6ipJ
	pU1ndqlfx/E2b4G9mluSPGuA2vREGzij9mCyIFKHfX4IAKdMePfpqAJv
X-Gm-Gg: AYBFou0zonjIsvEbcjkWVKqMl0lxeWfQ0/h4Pn0Wo8uN64S9bTio8ctAT8VAKZxzuIK
	fhTU4RdY1aM9CIx25jO3zhlMxJMJpY6xSU1FM2kTJdndk9jWppd6JAZeRU07pdMsAM0IOQpboS+
	hHLbLCLtJbkucVtohBMfxC9SiNXr7R41fBpzuycVKmA7muaCHf13lHmNFRxBw00CAUOthvUcCa/
	qfO6XrC02tg4BdkBJRQp5cOS4qJraQ7q7+2IW27tr8tCOfue4uiknvyyBOogYpa+SFVuZMZFi5M
	QNpQ3sXj4aUk9mNRMzfzIG/dObIIsofedovrS2qk7AOA8jEev23JThe/4e4N/pFcoLU6RdAs6na
	tXKYVQKaZ0Qw/BALxqwtlPP0sMaoopiOT9WsteMpzHBm0aybY92mSGvp8vCxI901R/7WMj+Em+s
	ncQn88/u7zxObGtCaOdo+XFIn6obYOhktGhIlgVLnSXAgCdt/ybLdkRUoV1Z3Ku2D9ipuSXBVzw
	tE=
X-Received: by 2002:a05:600c:c1d7:10b0:4a0:4f6:3dc5 with SMTP id 5b1f17b1804b1-4a1680dd4f4mr34160075e9.7.1791058592594;
        Sat, 03 Oct 2026 13:16:32 -0700 (PDT)
Received: from Mac ([188.163.8.107])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a16d6295f9sm51579145e9.14.2026.10.03.13.16.31
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 03 Oct 2026 13:16:32 -0700 (PDT)
From: Andrii Pasichnyk <apasichnik9@gmail.com>
To: "Jason A . Donenfeld" <Jason@zx2c4.com>,
	netdev@vger.kernel.org,
	wireguard@lists.zx2c4.com
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org,
	Andrii Pasichnyk <apasichnik9@gmail.com>
Subject: [PATCH net] wireguard: peer: free packets left on the per-peer queues on removal
Date: Sat,  3 Oct 2026 23:16:25 +0300
Message-ID: <20261003201625.4572-1-apasichnik9@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

peer_remove_after_dead() flushes the crypt workqueue and then disables
the peer's NAPI. Once a disable is pending, __napi_poll() completes the
instance after the poll returns even if it used its whole budget, so a
peer removed while more than one budget of decrypted packets waits on
rx_queue keeps the rest there. Each entry holds a keypair and a peer
reference, so the peer is never released; the WARN_ON in rcu_release()
that checks for leftovers is never reached either.

Free whatever is left on both per-peer queues once nothing can feed them
any more: receive entries are single packets, transmit entries lists.

Reproduced with the WireGuard selftest VM (x86 KVM, 1 vCPU, net-next):
remove a peer while a UDP flood keeps its receive queue busy, re-add it,
repeat, then run the selftest's created/destroyed object check. Over
2140 removals the unpatched kernel leaked a peer and its keypair 5
times ("wg0: Peer 27: merely created"); with this patch, 0 times in
another 2140.

Fixes: e7096c131e51 ("net: WireGuard secure network tunnel")
Assisted-by: LLM
Signed-off-by: Andrii Pasichnyk <apasichnik9@gmail.com>
---
 drivers/net/wireguard/peer.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/net/wireguard/peer.c b/drivers/net/wireguard/peer.c
index 1cb502a..3e08898 100644
--- a/drivers/net/wireguard/peer.c
+++ b/drivers/net/wireguard/peer.c
@@ -91,6 +91,25 @@ static void peer_make_dead(struct wg_peer *peer)
 	/* The caller must now synchronize_net() for this to take effect. */
 }
 
+/* Each queue entry holds a keypair and a peer reference. Transmit entries
+ * are lists of packets, receive entries single packets.
+ */
+static void peer_purge_queue(struct wg_peer *peer, struct prev_queue *queue,
+			     bool lists)
+{
+	struct sk_buff *first;
+
+	while ((first = wg_prev_queue_peek(queue)) != NULL) {
+		wg_prev_queue_drop_peeked(queue);
+		wg_noise_keypair_put(PACKET_CB(first)->keypair, false);
+		wg_peer_put(peer);
+		if (lists)
+			kfree_skb_list(first);
+		else
+			dev_kfree_skb(first);
+	}
+}
+
 static void peer_remove_after_dead(struct wg_peer *peer)
 {
 	WARN_ON(!peer->is_dead);
@@ -122,6 +141,11 @@ static void peer_remove_after_dead(struct wg_peer *peer)
 	 * here from process context.
 	 */
 	netif_napi_del(&peer->napi);
+	/* A NAPI being disabled completes after at most one more poll, which
+	 * may leave packets on rx_queue that still hold references.
+	 */
+	peer_purge_queue(peer, &peer->rx_queue, false);
+	peer_purge_queue(peer, &peer->tx_queue, true);
 
 	/* Ensure any workstructs we own (like transmit_handshake_work or
 	 * clear_peer_work) no longer are in use.
-- 
2.53.0

