Received: from mail-pj2-f10.google.com (mail-pj2-f10.google.com [74.125.227.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E22EB36BCDE
	for <netdev@vger.kernel.org>; Wed, 29 Jul 2026 19:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785354735; cv=none; b=ffXRnMvF/+oXfVPhqMWYsM4aCTdk4ZFFxgDXzfHo/h93lcu/MFO59fzZmZX1fdEejRS9evYmfX6+Aq9EV4jnDvaf08Aklwuu3zKEfq2Y8n7jaijoFmV9P5XqL8AmC2OhiAV3LVaQQqhNYejkB6Csp9QKnMm5hFAqkqVAZVBW9gQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785354735; c=relaxed/simple;
	bh=zlie80FpoFWEUm9KoMhU9WjytZpxVUrR/g2l1Lwd5dE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RonV5Df22qmHeJm6fbmvoZoIVUMqqteGaf5WlZtyPlEMTehEDnN+PwBdZEWzVPut1u6d9pwz4oSIYg1JAwQ3y5jzh7YiC3St5JHaVKq66R4YRtm7eXSKKy3rjrdS/M4/8PbIfFmOQFIiZfXzAzqVdffOZ1UV5YyYArhmMKElsyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=eS5Rt7E/; arc=none smtp.client-ip=74.125.227.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="eS5Rt7E/"
Received: by mail-pj2-f10.google.com with SMTP id 98e67ed59e1d1-38e8adc1d70so622363a91.1
        for <netdev@vger.kernel.org>; Wed, 29 Jul 2026 12:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1785354731; x=1785959531; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YX5wgRbly6ErxCYdshsizmb/aCRtTRJ7D/BrtLVy2Q8=;
        b=eS5Rt7E/ynnguNcrRurMXQWL1s3EO9tYZ7535IK5C9HPtgFCjc8r4X57PKHfCz67JH
         cdXLBtNT8D1YDQ2oPUn8bQU3GKQb75rbUxWsv9ZI6X9q4xh2mGgzvbByjkWh88LrIiPg
         SJ0WlYsxOobtHSyUP3cO/fbIptFRAe2aQFeyk6bmqnL1+dRp7W5jm+T/SKJkEbAdujpN
         JnPiu6/j619a8iBTZ2qemSowWDEzlIqnq5xb8GQ+xG2Ss8ymaNlqtaJr0HC08iKV6gFp
         ++j0Bfg+kyeNHPNnSZNECWvFgkigJ4aGzJnhpCmgSh2fEAEjthApkrcvPFYMgYxEsAx0
         cezw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785354731; x=1785959531;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=YX5wgRbly6ErxCYdshsizmb/aCRtTRJ7D/BrtLVy2Q8=;
        b=oL1YghYSfLyc0NFd2TQIPYHCsa8+MLnAy3xxhy4KuBHTPu2CfTsgESOd3xf6ynUAnl
         1Zmy5rHuTDwzRApiwqWlkAsalLip5QTYoCusajQOeHu25/lloU5uX4r0CKB+3/uhxeGe
         20JBvTK75GGbgVSRixM50LMUi5P8rEIWEr/Vqxor+rD+NeFu7wLOMIyj7U6P8lgpSkXw
         w4lQSg9pnE+iunsum3seYCWAAbHvG6XOmx7laEzFvARQbW2LJ9qH+Kx24zrCq9Rc1PXP
         jvb57ze+P3GoYV29TpsKYb2/F84FtQjeHEpUVMc0FxnA95a7WShzbZy20w/AePsK3r6f
         CyPg==
X-Forwarded-Encrypted: i=1; AHgh+RqGvi0yL4g6Ylqy//woIonCxeLb40u6u6w192ZyDl0kEUEqflZsSYEBO6OOXJG20OqVNBGmLUk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXpSUFAJBkNpOrO4QUKS9gAB3BZdIHmFO+zhRcRaB37bgsQYX8
	n0EtItpAYZnf4Hoj535aZQh4+ew2A4AqIY0X+Co+0CaoJDFt5L/Wa+5xJroT33frb7Zb
X-Gm-Gg: AR+sD11yN/8L+09KuWhYZe9ItU6SGa2aDjK0rNm2wwGZZDJ0UeFT2CpFdjAZcbF6tWW
	TGeIqQkuo+QlEMD7w/LKRwZR1g/ftaFhH0YsX0hi4uuDKc1d/eWvhVbdzSFlKGkA+2KaA10joPd
	G2mri+VKohMiV8X/baxJ74Rj8y0sedVSAiNhoPxd/noyEyna6ngrlWiR5p2G3hwg3x2u3OXAp2L
	ArDHPDBOX1yM9mZ6zcQOgXxMnyCH1SrlXSvgmf/wfq8wAoXHpTmW1C7HYmEAb9wTbuEtE/dbcaM
	n8vSqgqBZT1pZmgDHKTpoImwv14ahBGI+d5ZaZWJHtX7a0m/n/H80zxDZU0tNPW0JrcmmbLrcL1
	WfiUgXldyEDnqAA2Hq3HkxfLs9daj+WqH1H/DHfk1kEfQsxDTPT0FQm9rqMjP+jjKEIXC7nnu8k
	oPMd/JkmyB98HFUy2wirzlnC8XFO0VFC+O62AKK6iAM5Fh3tTy3N4sdiPENreW0+jxaOozdtY=
X-Received: by 2002:a17:90b:5483:b0:38e:b400:a854 with SMTP id 98e67ed59e1d1-38f9939d1c0mr187162a91.37.1785354731484;
        Wed, 29 Jul 2026 12:52:11 -0700 (PDT)
Received: from localhost.localdomain ([115.192.250.185])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38f7f0edc1csm1816958a91.3.2026.07.29.12.52.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 12:52:10 -0700 (PDT)
From: Zihan Xi <zihanx@nebusec.ai>
To: linux-afs@lists.infradead.org,
	netdev@vger.kernel.org
Cc: dhowells@redhat.com,
	marc.dionne@auristor.com,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	vega@nebusec.ai,
	zihanx@nebusec.ai
Subject: [PATCH net v2 1/1] rxrpc: fix encap_rcv skb accounting exhaustion
Date: Wed, 29 Jul 2026 19:50:26 +0000
Message-ID: <316c9ffce7bab04013464347251edf4be9545519.1785339953.git.zihanx@nebusec.ai>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1785339953.git.zihanx@nebusec.ai>
References: <cover.1785339953.git.zihanx@nebusec.ai>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

rxrpc_encap_rcv() moves encapsulated UDP packets onto the local
RxRPC queue without preserving UDP receive-buffer accounting. A local
AF_RXRPC service such as the AFS callback listener can therefore be
flooded with RxRPC-shaped UDP packets until the local queue grows
without bound and consumes large amounts of memory.

Reaccount encapsulated packets against the UDP socket before queueing
them on the RxRPC local queue and drop packets once the socket rcvbuf
limit is reached. Clear sk_user_data under RCU protection and release
the socket only after queued skbs are purged so the new skb ownership
does not outlive the UDP socket.

Fixes: 446b3e14525b ("rxrpc: Move packet reception processing into I/O thre=
ad")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>=0D
Assisted-by: Codex:gpt-5.4=0D
Signed-off-by: Zihan Xi <zihanx@nebusec.ai>=0D
Link: https://lore.kernel.org/all/cover.1784742007.git.zihanx@nebusec.ai/
---
changes in v2:
  - switch the drop path from atomic_inc(&udp_sk->sk_drops) to
    sk_drops_inc(udp_sk)
  - retarget Fixes to 446b3e14525b, the queue-to-I/O-thread boundary
    identified in the latest public review discussion
  - add a canonical Link: trailer for the public v1 posting
  - state explicitly that the cover crash log is decode_stacktrace.sh output
  - explain in the cover why packetdrill was not used
  - reroll as v2 of the public v1 thread
  - v1 Link: https://lore.kernel.org/all/cover.1784742007.git.zihanx@nebuse=
c.ai/

 net/rxrpc/io_thread.c    | 15 +++++++++++++--
 net/rxrpc/local_object.c |  8 ++++++--
 2 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/net/rxrpc/io_thread.c b/net/rxrpc/io_thread.c
index dc5184a2f..a41cf094e 100644
--- a/net/rxrpc/io_thread.c
+++ b/net/rxrpc/io_thread.c
@@ -41,8 +41,6 @@ int rxrpc_encap_rcv(struct sock *udp_sk, struct sk_buff *=
skb)
 	if (skb->tstamp =3D=3D 0)
 		skb->tstamp =3D ktime_get_real();
=20
-	skb->mark =3D RXRPC_SKB_MARK_PACKET;
-	rxrpc_new_skb(skb, rxrpc_skb_new_encap_rcv);
 	rx_queue =3D &local->rx_queue;
 #ifdef CONFIG_AF_RXRPC_INJECT_RX_DELAY
 	if (rxrpc_inject_rx_delay ||
@@ -52,6 +50,19 @@ int rxrpc_encap_rcv(struct sock *udp_sk, struct sk_buff =
*skb)
 	}
 #endif
=20
+	if (atomic_read(&udp_sk->sk_rmem_alloc) >=3D READ_ONCE(udp_sk->sk_rcvbuf)=
 ||
+	    !sk_rmem_schedule(udp_sk, skb, skb->truesize)) {
+		sk_drops_inc(udp_sk);
+		kfree_skb(skb);
+		return 0;
+	}
+
+	skb->dev =3D NULL;
+	skb_set_owner_r(skb, udp_sk);
+	skb_dst_force(skb);
+
+	skb->mark =3D RXRPC_SKB_MARK_PACKET;
+	rxrpc_new_skb(skb, rxrpc_skb_new_encap_rcv);
 	skb_queue_tail(rx_queue, skb);
 	wake_up_process(io_thread);
 	return 0;
diff --git a/net/rxrpc/local_object.c b/net/rxrpc/local_object.c
index 169f9dfda..6604f9f95 100644
--- a/net/rxrpc/local_object.c
+++ b/net/rxrpc/local_object.c
@@ -437,8 +437,8 @@ void rxrpc_destroy_local(struct rxrpc_local *local)
 	if (socket) {
 		local->socket =3D NULL;
 		kernel_sock_shutdown(socket, SHUT_RDWR);
-		socket->sk->sk_user_data =3D NULL;
-		sock_release(socket);
+		rcu_assign_sk_user_data(socket->sk, NULL);
+		synchronize_rcu();
 	}
=20
 	/* At this point, there should be no more packets coming in to the
@@ -448,6 +448,10 @@ void rxrpc_destroy_local(struct rxrpc_local *local)
 	rxrpc_purge_queue(&local->rx_delay_queue);
 #endif
 	rxrpc_purge_queue(&local->rx_queue);
+
+	if (socket)
+		sock_release(socket);
+
 	rxrpc_purge_client_connections(local);
 	page_frag_cache_drain(&local->tx_alloc);
 }
--=20
2.43.0

