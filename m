Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E72FD3DDB0A
	for <netdev@vger.kernel.org>; Wed,  2 Sep 2026 15:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788361898; cv=none; b=BgTSsXlAnicaZNo93dYchHuPCt+dI2Esx8jo32vPMVuZG6Jmk0cG397ibNKgs3jUZqJR6Itm9V+sTf6o2iGjRh9hijWrPabWP5uAZV2WsiinaitXmx5VD5Ph76bYzGzWyjC8EYkMfYxEWo/3AUadEbL+v126nlvCXPVCXE4nDyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788361898; c=relaxed/simple;
	bh=gasmKhY5QdVetN3HDkPDfGtkZpKw5F4W6g75o0Q/i88=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=fL/LpER2u0rQmc9D7ct096U0ZXGmbnlCNI1N0h+zzKtjWS68vtBD7fcYnUEO0vffLdKFAkYd2+pbSFDrdiqUQE7y8b1Dh080tJ2qlOfcx5sKkfSFTsyjDcf+fZiuWQp5H3pMvbSZ2tY0Gp/SJvxkZSRx9MsPtSDd6l6/DPNLaiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=NO5yNFam; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="NO5yNFam"
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-4b3a61bdf22so585996b6e.3
        for <netdev@vger.kernel.org>; Wed, 02 Sep 2026 08:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1788361894; x=1788966694; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=6d93cyMkw6EMFToYvRlpelXx7oHrvV3y/wNVC9ldZm0=;
        b=NO5yNFamOQ6Pttf0nW7mE8+rKgtxV0qy1bbOpsBroOmKjhBIYtm5t8iH/EzHb8FBUB
         qro1YIOd7fYbhpLFdiM3Z8uIPoETf5KGM025b6X9HrfvYaYy97DlnaXcpUUd3aVTkpq+
         iWrnFwPguea8q+2v3P488gDhjRan/nds+VhMBMzBwoSA6yz8Ueo/ceiAThA8mZF0fKfd
         47Fi0N39qDeIdaCxdCa7g94C2hmKZAswah3++YFi2u95fPLfjZE1JJMXn8106hqhZOCH
         pCDG0shvMMdyUanAVm4fHAUFva5XhAnoj1uF9RoRxixDjK3pp5b0jQ8of20/L2vXDJ4Y
         j/Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788361894; x=1788966694;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=6d93cyMkw6EMFToYvRlpelXx7oHrvV3y/wNVC9ldZm0=;
        b=biqFwlCbdTLaqHxfuPj3cmiuHgATdc2cVZd5vPloL7FustntidU5JoNIKdqCt3Xn69
         E0T/bS7uy7WO7uHwCmI4uXcqr2gshWoV22wG4peKVR0ukI586rVaJ9i7qxk3u+uPoaYL
         cD274nxs6b85cj0jdttcpMb474XOsOTyj7tVWyrRxoyZLwifoProWFOrIo+ACS27OzV1
         FNrKyZiXV7qliGLqG8jjtH9chYvRAEgE+XVXjFTnm3Vc0c+MJi9Obtgncgqd480hYc1M
         SOFJ4VOPXw3xrQZjmw4yVNzXg68zfvd5GLW3oQ/gP0afSGcxlYyjXJP005ABeH5j0jII
         RaDg==
X-Forwarded-Encrypted: i=1; AHgh+RrSl8Okuwxmwc17hLNyXS21kClwBhHz6SCr1WvhnkgsNgK4Ta0ZSwsswoP6/5YZ8xWfqNLEwsw=@vger.kernel.org
X-Gm-Message-State: AFuF++mMeG+LqB392hlX+IdQV7m9xpDygp1haD+J+5cS9951rZI6egj6
	K5c+hO6k/WASj4xIbF8xUNXX1cHj2oFePNlkolGK7E4WftDphIsCK921EQ80o5k6u8M=
X-Gm-Gg: AR+sD103o3LtHibEGc9d4k2u/xjudNSsaYFCU2NpJJWrJKpxqbS01sCPn1c7QkFBHDS
	034sfssW/7Rp76R3qWk9jl39hCY7jrDusjDByI9g83l/jwkVsWx7hfuZCayCskvqOseGxCFudM5
	pjJT874Y2TrURXlwmNoCs1Mu2pZmVz0F1lX5MpHF9wZA1fWWcamLuxi/d2GkansCl9q72fg5tif
	6zkDwaYWrUqF3NckMaI1XCcQlmDrWB2b1WV5qsrjHUdTj5Or5SfWgTXDqwG+GSMzEST7e1ZyOXu
	6qJSRi7PnHIQ195jLDqjcESwRyvV/guw8ra7UpJ1qaf6MCkBN4HngBps4RgpSb/PXBi3znaDQtb
	QihmrMUnJ1A9h36HQ8g4KI7iJTHa3rcMGI8M1iBmHDnI+JGoFxazj5L1erBVK+CZHWfNWQ2e2Mb
	W7Rdf4XGtXa/4l8LdKecQUp8v2lH4F/um0rWWZINChxjq3trdFJw==
X-Received: by 2002:a05:6808:1982:b0:4ae:f5be:fe29 with SMTP id 5614622812f47-4b6bc45eb12mr4432026b6e.5.1788361894525;
        Wed, 02 Sep 2026 08:11:34 -0700 (PDT)
Received: from [127.0.1.1] ([2a09:bac6:bf21:2e28::499:53])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4b698a38f62sm2044063b6e.7.2026.09.02.08.11.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 08:11:32 -0700 (PDT)
From: Chris J Arges <carges@cloudflare.com>
Date: Wed, 02 Sep 2026 10:11:25 -0500
Subject: [PATCH net] wireguard: wait for per-peer crypto during removal
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260902-fix-wg-peer-removal-v1-1-7a0190f5cdb1@cloudflare.com>
X-B4-Tracking: v=1; b=H4sIAJw8mGoC/yWM0Q6CMBAEf4Xcs5dcqTGBXzE+YFnwDBZyrWhC+
 HerPs5mZzZKMEWittrIsGrSORZwh4rCrYsjWPvCVEt9kkYcD/rm18gLYGx4zGs38dEPwTfSi3e
 OirkYyu1XPVNEpst/TM/rHSF/e7TvH90glU58AAAA
X-Change-ID: 20260901-fix-wg-peer-removal-43fc390d0311
To: "Jason A. Donenfeld" <Jason@zx2c4.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: wireguard@lists.zx2c4.com, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, kernel-team@cloudflare.com, 
 Chris J Arges <carges@cloudflare.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1788361892; l=5927;
 i=carges@cloudflare.com; h=from:subject:message-id;
 bh=gasmKhY5QdVetN3HDkPDfGtkZpKw5F4W6g75o0Q/i88=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgaxY1IIT5oTohBZJmhnVgJo2HsM7Sv
 9I0LdJCgpeGX6gAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QKpZG43U/VRAV+Prr2sW0jg3cNIEuCbnlX7R7/cMb4Ldr5itEqZVxNPbqMC463wRbQvSqRslVYr
 rxLj1VgRkpgE=
X-Developer-Key: i=carges@cloudflare.com; a=openssh;
 fpr=SHA256:Cun99EBiH0EV7wvmfTBF9eDrld2NJx+aD4ScWZ45Q5M

Calling peer_remove_after_dead() currently flushes device-wide packet
crypto and handshake workqueues while holding RTNL. This is problematic as
unrelated peers can continue adding work onto those queues blocking other
tasks that want to take the RTNL lock.

Instead, this patch proposes tracking pending crypto handoffs for each
peer using a counter. After marking the peer dead, synchronize_net()
prevents new submissions; wait for pending crypto workers to schedule TX
work or RX NAPI. Then flush only the peer's transmit packet and handshake
work.

This scopes teardown synchronization to the removed peer and prevents
unrelated peers from extending the RTNL hold time.

Fixes: e7096c131e51 ("net: WireGuard secure network tunnel")
Signed-off-by: Chris J Arges <carges@cloudflare.com>
---
 drivers/net/wireguard/peer.c     | 30 ++++++++++++++++--------------
 drivers/net/wireguard/peer.h     |  1 +
 drivers/net/wireguard/queueing.h |  6 ++++++
 3 files changed, 23 insertions(+), 14 deletions(-)

diff --git a/drivers/net/wireguard/peer.c b/drivers/net/wireguard/peer.c
index 1cb502a932e0..f7a9c437b5b8 100644
--- a/drivers/net/wireguard/peer.c
+++ b/drivers/net/wireguard/peer.c
@@ -14,6 +14,7 @@
 #include <linux/lockdep.h>
 #include <linux/rcupdate.h>
 #include <linux/list.h>
+#include <linux/wait_bit.h>
 
 static struct kmem_cache *peer_cache;
 static atomic64_t peer_counter = ATOMIC64_INIT(0);
@@ -49,6 +50,8 @@ struct wg_peer *wg_peer_create(struct wg_device *wg,
 	INIT_WORK(&peer->transmit_packet_work, wg_packet_tx_worker);
 	wg_prev_queue_init(&peer->tx_queue);
 	wg_prev_queue_init(&peer->rx_queue);
+	/* Keep this above zero until teardown prevents new packet handoffs. */
+	atomic_set(&peer->packet_crypt_pending, 1);
 	rwlock_init(&peer->endpoint_lock);
 	kref_init(&peer->refcount);
 	skb_queue_head_init(&peer->staged_packet_queue);
@@ -105,28 +108,27 @@ static void peer_remove_after_dead(struct wg_peer *peer)
 	 */
 	wg_timers_stop(peer);
 
-	/* The transition between packet encryption/decryption queues isn't
-	 * guarded by is_dead, but each reference's life is strictly bounded by
-	 * two generations: once for parallel crypto and once for serial
-	 * ingestion, so we can simply flush twice, and be sure that we no
-	 * longer have references inside these queues.
+	/* Lookup removal and is_dead prevent new packets from entering the
+	 * parallel crypto queues after synchronize_net() waits for pre-existing
+	 * submission paths. Drop the initial count and wait for existing packets
+	 * to finish scheduling their serial TX work or RX NAPI processing.
 	 */
+	atomic_dec(&peer->packet_crypt_pending);
+	wait_var_event(&peer->packet_crypt_pending,
+		       !atomic_read_acquire(&peer->packet_crypt_pending));
+
+	flush_work(&peer->transmit_packet_work);
 
-	/* a) For encrypt/decrypt. */
-	flush_workqueue(peer->device->packet_crypt_wq);
-	/* b.1) For send (but not receive, since that's napi). */
-	flush_workqueue(peer->device->packet_crypt_wq);
-	/* b.2.1) For receive (but not send, since that's wq). */
 	napi_disable(&peer->napi);
-	/* b.2.1) It's now safe to remove the napi struct, which must be done
+	/* It's now safe to remove the napi struct, which must be done
 	 * here from process context.
 	 */
 	netif_napi_del(&peer->napi);
 
-	/* Ensure any workstructs we own (like transmit_handshake_work or
-	 * clear_peer_work) no longer are in use.
+	/* clear_peer_work was flushed by wg_timers_stop(). Ensure the remaining
+	 * peer-owned handshake work is no longer in use.
 	 */
-	flush_workqueue(peer->device->handshake_send_wq);
+	flush_work(&peer->transmit_handshake_work);
 
 	/* After the above flushes, a peer might still be active in a few
 	 * different contexts: 1) from xmit(), before hitting is_dead and
diff --git a/drivers/net/wireguard/peer.h b/drivers/net/wireguard/peer.h
index 718fb42bdac7..64412c67f413 100644
--- a/drivers/net/wireguard/peer.h
+++ b/drivers/net/wireguard/peer.h
@@ -37,6 +37,7 @@ struct endpoint {
 struct wg_peer {
 	struct wg_device *device;
 	struct prev_queue tx_queue, rx_queue;
+	atomic_t packet_crypt_pending;
 	struct sk_buff_head staged_packet_queue;
 	int serial_work_cpu;
 	bool is_dead;
diff --git a/drivers/net/wireguard/queueing.h b/drivers/net/wireguard/queueing.h
index 79b6d70de236..fdd34f0f15a6 100644
--- a/drivers/net/wireguard/queueing.h
+++ b/drivers/net/wireguard/queueing.h
@@ -11,6 +11,7 @@
 #include <linux/skbuff.h>
 #include <linux/ip.h>
 #include <linux/ipv6.h>
+#include <linux/wait_bit.h>
 #include <net/ip_tunnels.h>
 
 struct wg_device;
@@ -161,6 +162,7 @@ static inline int wg_queue_enqueue_per_device_and_peer(
 	 */
 	if (unlikely(!wg_prev_queue_enqueue(peer_queue, skb)))
 		return -ENOSPC;
+	atomic_inc(&PACKET_PEER(skb)->packet_crypt_pending);
 
 	/* Then we queue it up in the device queue, which consumes the
 	 * packet as soon as it can.
@@ -182,6 +184,8 @@ static inline void wg_queue_enqueue_per_peer_tx(struct sk_buff *skb, enum packet
 	atomic_set_release(&PACKET_CB(skb)->state, state);
 	queue_work_on(wg_cpumask_choose_online(&peer->serial_work_cpu, peer->internal_id),
 		      peer->device->packet_crypt_wq, &peer->transmit_packet_work);
+	if (atomic_dec_and_test(&peer->packet_crypt_pending))
+		wake_up_var(&peer->packet_crypt_pending);
 	wg_peer_put(peer);
 }
 
@@ -194,6 +198,8 @@ static inline void wg_queue_enqueue_per_peer_rx(struct sk_buff *skb, enum packet
 
 	atomic_set_release(&PACKET_CB(skb)->state, state);
 	napi_schedule(&peer->napi);
+	if (atomic_dec_and_test(&peer->packet_crypt_pending))
+		wake_up_var(&peer->packet_crypt_pending);
 	wg_peer_put(peer);
 }
 

---
base-commit: 70f3995830d3f1e79faa14eb0605914f778feca9
change-id: 20260901-fix-wg-peer-removal-43fc390d0311

Best regards,
--  
Chris J Arges <carges@cloudflare.com>

