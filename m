Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC85A3B27C5
	for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 16:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785169182; cv=none; b=F+C4GfI2giLRf9YniHkws1Vc284jL9d8GzJTGnMxJdu2prA4iQWosQmpfuQ5dP0eJ8B2M13XQe5BwSxKSkfERqWDupVQLN5i6whEbxl+dpJrWeyRFDo9arktkENhH2GkiSR6LoUgYbJy1Pe/fEvYevBZ/TnRGUNbf+IuoGAL5Pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785169182; c=relaxed/simple;
	bh=MYwBhT/Dahs4w16kRLn+ikjE3vAgpDC+FJiK/U9s8IA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BhfpriA2PD7+Z2aMPH4XaD6Nb5A7PpwqmwWzSfulTNhAJTSHAmUww0+2Bv6rdDo2q+YwDp43een/t/uENFkSTRD773HkKWGcHvPEidR5NrjOqfMxyKbMxTk5hWEQU694vv79A/MXGGFcnEVb1K51iQiBkFONU+gJTp7z4tTNRWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hvMncokS; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hvMncokS"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-848743155bcso1068165b3a.0
        for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 09:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785169180; x=1785773980; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=qece4mfxI+rG/jlFkSRi25zb0se8QF8ltUksimJ3W/I=;
        b=hvMncokSYFzlQID0cvMhugyUPIyFrcvPfI+YCr3Gc0HeGSimkj2vyfdcxhwajhpw71
         4kYVf/kkytEhpkrH964FUOozlJAnKpbe2gtvQUK2ORtg9tDzXtGpcto+creDs7+7loJe
         MBkvRUFWVBwmAL8oBr48p0nQeUigjl7L95ZGBWaHNf/c/1JG6WxzxSLRQhxO6l8KXQUj
         Bfon8z9uGxcCIvqTFIMr6OFpZwf9mF6aJEIzsxq6WBkvIPbKVOm5WD73Rd38jV2Rmu/U
         AAHUVb1NC08Pj/o+Lg8Pqbx6kjVP6STdudDvYc7r9h5tWz/UtjYActnC+nToRIy/RBRU
         52uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785169180; x=1785773980;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qece4mfxI+rG/jlFkSRi25zb0se8QF8ltUksimJ3W/I=;
        b=aUXgvYLb/e/6MB7XP/5AJaGxnR80sz1EVEkRog8EXpNUf4jxtg30DV4cjzl7QwgIH0
         7nUsYjpA3FX8//CuDBo2UzkCkVjSNkNOsPh4x3M4QBfGvUwyfe5U5IGHRP2k2abHA+zu
         JRgm0bDAZjtmxOvySaX6O5Rgx8rTJRuFm+X5nWmc1P+2Mh04ML98ETfeA6uN7O0kBNuY
         AkPBP4JypoTbrNpyqhPOzkTiPqP0YSlYE9PalL2OcHi9qbF4zxqwD12173VDE8HKF26F
         d1+mIoxvqNTqjM8EhokgSM01CqLjNye6krtHSbvEIW96zjf9Eb/waBybn6UKUSdazjm2
         ncGA==
X-Gm-Message-State: AOJu0YzZgUmwW4QyN6ZjXXllL7ymPPHlBXsQf/EHxvzuQTB4VkdmHrgP
	rmumN44Mpp0gm26MKHN88HJJmnaYb/xH7YIKdIdgPv93Ui8qcXCMKiU+SVajOoSczuQ=
X-Gm-Gg: AR+sD11Jufh8N6yJYa9msTdHCARwe9CYTC9tVc6WLG1qhtgbqepYO8Zd8OVy+l92IkX
	kTe2tDa1LdkN4UuTsGVAL7196RdvC8BA8Q3uc+CaXPyh+WOYaRe+zg1XTKSpq7QH1VIhOOV9kif
	KVeV4Hgmw+ibw9MOl8vyMvoQOSe9rC9NzO2GQ5DXqXgwzeHrNncat37Ds1AKon5ANaIvMSOAQWv
	ztwCAQUTDI+A/eWqSQI9WVzgLjRBfvWxolvyy1droNIyUsGflKiQPqwUH4+2jFUiN7beWHNzyN1
	A6QEV01apymZD4Th6NGjJk7cnaiBnlSv8W01sXHTuI5KM7LWm6d7dHu7btUFOALrmF77607XWCC
	o0NABULZDV4nAn7wmvQzy4w/inOdwokPfftZySWJeLYY2Eo8qsfJm96A/zr/Z57pIayo44YdYYj
	O/GFUd0z+mSZAHJzD4pwQ3
X-Received: by 2002:a05:6a00:800f:b0:845:45b5:9825 with SMTP id d2e1a72fcca58-84e595752d4mr7205090b3a.37.1785169179958;
        Mon, 27 Jul 2026 09:19:39 -0700 (PDT)
Received: from enjou-Legion-Y7000P-2019 ([219.141.235.82])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84e532585edsm3281628b3a.4.2026.07.27.09.19.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 09:19:39 -0700 (PDT)
From: Ren Wei <enjou1224z@gmail.com>
To: netdev@vger.kernel.org
Cc: willemdebruijn.kernel@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	vega@nebusec.ai,
	zihanx@nebusec.ai,
	enjou1224z@gmail.com
Subject: [PATCH net v2 1/1] packet: synchronize pressure clearing with ring reconfiguration
Date: Tue, 28 Jul 2026 00:19:33 +0800
Message-ID: <f1cd534481c2397a36850ad039dcbfd38c3233ce.1784551898.git.zihanx@nebusec.ai>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zihan Xi <zihanx@nebusec.ai>

packet_set_ring() updates the RX ring state under sk_receive_queue.lock,
but publishes the tpacket receive mode through po->prot_hook.func after
releasing that lock. packet_poll() and packet_recvmsg() can therefore run
the pressure clearing path after the ring has been cleared while still
seeing tpacket_rcv, causing __packet_rcv_has_room() to dereference stale
or NULL ring storage.

Serialize pressure clearing with RX ring reconfiguration and update the
receive hook while holding the same queue lock when changing the RX ring.
Keep packet_poll() on the unlocked helper, and let packet_recvmsg()
take the queue lock only when PACKET_SOCK_PRESSURE is already set so the
fix avoids an unconditional extra lock acquisition on the normal recv
path.

Fixes: 2ccdbaa6d55b ("packet: rollover lock contention avoidance")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Assisted-by: Codex:gpt-5.4
Signed-off-by: Zihan Xi <zihanx@nebusec.ai>
Signed-off-by: Ren Wei <enjou1224z@gmail.com>
---
changes in v2:
  - only take sk_receive_queue.lock in packet_recvmsg() when
    PACKET_SOCK_PRESSURE is already set
  - keep packet_poll() on the unlocked helper under its existing queue lock
  - v1 Link: https://lore.kernel.org/all/24f7311aed0c9ff06b8ea982647b82bf543ec369.1784454542.git.xizh2024@lzu.edu.cn/

 net/packet/af_packet.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index 8e6f3a734ba0..0107e55de6ff 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -1315,13 +1315,25 @@ static int packet_rcv_has_room(struct packet_sock *po, struct sk_buff *skb)
 	return ret;
 }
 
-static void packet_rcv_try_clear_pressure(struct packet_sock *po)
+static void __packet_rcv_try_clear_pressure(struct packet_sock *po)
 {
 	if (packet_sock_flag(po, PACKET_SOCK_PRESSURE) &&
 	    __packet_rcv_has_room(po, NULL) == ROOM_NORMAL)
 		packet_sock_flag_set(po, PACKET_SOCK_PRESSURE, false);
 }
 
+static void packet_rcv_try_clear_pressure(struct packet_sock *po)
+{
+	struct sock *sk = &po->sk;
+
+	if (!packet_sock_flag(po, PACKET_SOCK_PRESSURE))
+		return;
+
+	spin_lock_bh(&sk->sk_receive_queue.lock);
+	__packet_rcv_try_clear_pressure(po);
+	spin_unlock_bh(&sk->sk_receive_queue.lock);
+}
+
 static void packet_sock_destruct(struct sock *sk)
 {
 	skb_queue_purge(&sk->sk_error_queue);
@@ -4304,7 +4316,7 @@ static __poll_t packet_poll(struct file *file, struct socket *sock,
 			TP_STATUS_KERNEL))
 			mask |= EPOLLIN | EPOLLRDNORM;
 	}
-	packet_rcv_try_clear_pressure(po);
+	__packet_rcv_try_clear_pressure(po);
 	spin_unlock_bh(&sk->sk_receive_queue.lock);
 	spin_lock_bh(&sk->sk_write_queue.lock);
 	if (po->tx_ring.pg_vec) {
@@ -4544,14 +4556,15 @@ static int packet_set_ring(struct sock *sk, union tpacket_req_u *req_u,
 		rb->frame_max = (req->tp_frame_nr - 1);
 		rb->head = 0;
 		rb->frame_size = req->tp_frame_size;
+		if (!tx_ring)
+			po->prot_hook.func = po->rx_ring.pg_vec ?
+						tpacket_rcv : packet_rcv;
 		spin_unlock_bh(&rb_queue->lock);
 
 		swap(rb->pg_vec_order, order);
 		swap(rb->pg_vec_len, req->tp_block_nr);
 
 		rb->pg_vec_pages = req->tp_block_size/PAGE_SIZE;
-		po->prot_hook.func = (po->rx_ring.pg_vec) ?
-						tpacket_rcv : packet_rcv;
 		skb_queue_purge(rb_queue);
 		if (atomic_long_read(&po->mapped))
 			pr_err("packet_mmap: vma is busy: %ld\n",
-- 
2.43.0
