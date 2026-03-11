Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B3FA327C00;
	Wed, 11 Mar 2026 00:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773188405; cv=none; b=sJIDRrU/SmXLDkDNQWR73NbWB0j6/8CunnC59Bwy/iOKVV+hWskQpD+k0gBTghqqaUDqB6YFezYCUZAKLsdVA6lX6mrugf0zCk4EBVKGIpknx9hRcRa0R7YyL6/7F7/34YWV10q7U1i1LCFQsMsKgyVq+Frec8BvQj3hsJq62eA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773188405; c=relaxed/simple;
	bh=h9dCFH8NELjKaOFTGeQYX/mAVP2bGkak7gdByzwjbKc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Aat5B5bQitXKuL8buXukiIu/5W2OVtO/45eIx4PdMiwrXGIUtF0nYeovG3CBbi6E5kqRVed+QSEIi0zSTnNPSYtf3tNlm7OPt49y/ZfqX1GKbovs2W5uxUThudktrZ4UVAIdNofPGdreuupXcEzuxKyjV5Gk3UjGQwIy6k5yX9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sbkxrJRF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sbkxrJRF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77008C2BC87;
	Wed, 11 Mar 2026 00:20:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773188405;
	bh=h9dCFH8NELjKaOFTGeQYX/mAVP2bGkak7gdByzwjbKc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sbkxrJRFQsLeEpIvemgn0rNi4yDIOSo4HWdT+VTVJJ018NJMFjZkCdPA0FzmrybDb
	 ffDlLSFm+8S7IAcfWNVqNXQJoulCuvySxarrz54drVilRzX50oclUBDzbBsoJ8BxdL
	 AkIsGz0Uv7zKvMqruhzCvCQbWag4YjTnGOmBIhusTANmov4Bk59LwNnlIeFJtKXRod
	 hlhnDgQVAtCa6WEfcnge7fIbcCtSbJ8rnRcrombNiDl0yaAHsNxxbHgpbik3zzgyOs
	 ZtXdNSK/SKi/D+yR4ebCCw3L2sNU67GcMm8Fc4FUZb9g1yGr3GGczpwaA7pUtNrO4F
	 yRKEKWdGo8g7Q==
From: Chuck Lever <cel@kernel.org>
To: john.fastabend@gmail.com,
	kuba@kernel.org,
	sd@queasysnail.net
Cc: netdev@vger.kernel.org,
	kernel-tls-handshake@lists.linux.dev,
	Chuck Lever <chuck.lever@oracle.com>,
	Alistair Francis <alistair.francis@wdc.com>,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH v2 6/8] tls: Flush backlog before tls_rx_rec_wait in read_sock
Date: Tue, 10 Mar 2026 20:19:50 -0400
Message-ID: <20260311001952.57059-7-cel@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260311001952.57059-1-cel@kernel.org>
References: <20260311001952.57059-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

While lock_sock is held during read_sock, incoming TCP segments
land on sk->sk_backlog rather than sk->sk_receive_queue.
tls_rx_rec_wait() inspects only sk_receive_queue, so backlog
data remains invisible until release_sock() drains it, forcing
an extra workqueue cycle for records that arrive during
decryption.

Calling sk_flush_backlog() before tls_rx_rec_wait() moves
backlog data into sk_receive_queue, where tls_strp_check_rcv()
can parse it immediately. The existing tls_read_flush_backlog
call after decryption is retained for TCP window management.

Acked-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/tls/tls_sw.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index 006e0a955b3f..644a65ff9964 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -2386,6 +2386,11 @@ int tls_sw_read_sock(struct sock *sk, read_descriptor_t *desc,
 		} else {
 			struct tls_decrypt_arg darg;
 
+			/* Drain backlog so segments that arrived while the
+			 * lock was held appear on sk_receive_queue before
+			 * tls_rx_rec_wait waits for a new record.
+			 */
+			sk_flush_backlog(sk);
 			err = tls_rx_rec_wait(sk, NULL, true, released);
 			if (err <= 0)
 				goto read_sock_end;
-- 
2.53.0

