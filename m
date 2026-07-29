Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A45F63E0C6F
	for <netdev@vger.kernel.org>; Wed, 29 Jul 2026 09:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785316645; cv=none; b=JqRa543mreNM57V2Ni3TH29zt0/6y9YpYh7zg9uAXrUPFavDYT/OKi3/O4cT0FT2N0zMqI0rpbbQDVdVFmioNu4wsB3ocMeuCUT1dqT9ll2BrxrsYGqjah9BqGiFV9ZgXNjeu4tqItBYLCkVplFepC533YQGurOq6I0N9t/RuAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785316645; c=relaxed/simple;
	bh=PckiOY9RHo5x8fUrajaHmUAcVrltZcBsuARPCuXptEw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d9UdLqpm63Q/1getxSjtbUK8l5FUPcNWW4cgaTlDEbCwMhA2Oj1dY+bzZX2B0Fah2SFkTWa4RfQXauDmXdT6Kat4+5g+OI6w0I6cRBLvL4p/MWkuPqfgYDU1F3MHnKPPeu/lhKRow1sPf70Ge2VkPZAPFxa2qtda/cmcPEHsh4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=YG2AXNCr; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="YG2AXNCr"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2cc61541f8cso26966055ad.0
        for <netdev@vger.kernel.org>; Wed, 29 Jul 2026 02:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1785316643; x=1785921443; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GPnXxIAR62w94YivLBzSewcL05MVL/SEbQCzrgkVRqA=;
        b=YG2AXNCrmyV+EVHDkrjS2XVJ9KVMDx0YsdB2HoMs1tLcTc8YsmHWEaQ4V3h/67PVnc
         C0IS4VqFE5Lbr24tadJny4tBlz5LWAvYn2TmEEdUoVYTPBf9Fa8/VIldPC2OMTKL/JnM
         VqD3DmsGcrgdvCZi/y0qLHJJbL1o89+1qcGv387Uu60vcjJjptLBkk2Fsb9G4W/oASh8
         Dlmbz7uEghlkGAu/PlEmC7KbAHGITnUAoPlKjTGJ00Euy6K9j7FjZBPrGGvRTiDmBc/l
         86tYn68t5a3AfcGHUKyV8NoiEh8jpYHw6TkDmRlImq3vUDzrNOVP0jxxQ50ivqAuzgeL
         boKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785316643; x=1785921443;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=GPnXxIAR62w94YivLBzSewcL05MVL/SEbQCzrgkVRqA=;
        b=YcNvChSOQFqLSHCIYx2DCpC1o3fGuxjLl7Nf6O6kfoouc9SkYwrktaqsPCTp0yA2T+
         x6gyv0vINGh7hSAptGAT/NVDN29pBeyUSMNeltnacvl7YLEePYEHgSaGNyRgWJLhjgHt
         jccuIirI91BE8npzUMWWENVCtcxaWCN2tmWUCxM5306wS410ILQnu4Ca79LI5wyClCpP
         c5OR7gx7xYl9DCGmfw46g40gtchpwU6BtXt7h+9RDHesS4E2HPwnoR8ggENkjeyR4GVp
         cOwHIR9DaKxIEN/pfZcPVlrCzTz8Q3Xa6fwW+oSs6tpknBSg6xhGMJqvpUJMz73iz83G
         2MvA==
X-Gm-Message-State: AOJu0Yx55/FqEVOfFvFZ/ZQel5GNXVZcPaXoRKppksfSyOeQyrENEhxV
	9c984OPMSpuw3cj3JYnwUMRALRxa5ovKIJWAcn6bW0M4lroS8n85cgf5cWxRntLcdEcXVHphCtI
	hvp7sm39x25mj2Q==
X-Gm-Gg: AR+sD121Cbzk6r8NBkI1Wm/mTDE/8YrzSQ9re7xTgeATUjdtyUQ3yQwnAqnaydyQKac
	PvOAPiOjGaGl4dUVB12gHg2K0pKryAyFjua/sSJsvMvn/8iCEmK1026AGmstOCzkOpHoGkm5gKv
	TU5eLcNuhLTpf5ohFARFE9u4TTwo3UBWl10sz9+eL3xa7EeJ+vbQSE9d3npM2MzO8JIZum+bqWv
	rtd+cgU5LBRmo8menMKcfAKMl8akTFEcf3QZoK5EhlFWAvUivS3HQZvjLnzghDIFojZdkfysyd5
	Kzdg8GnY/3MndTd2D0v7IcAoKqtYCKFYMgKfgrQCszzy7Dg1QEy4RXnTiySG7qpoAVrKexhrKiC
	1zN7rfJevledBHxqrMyvHndaiVx2Ay4/bCN/yEL+M0cYrwl7ehJ31vvOPS5eRg145jrAiC6Orde
	+4kOq8fpbD19fY7Ve11CFtE3MqTi6WMx/NEnR9Eph486qGM19quzDM8E7lPeexO7aBWpLtk0Y=
X-Received: by 2002:a17:903:4b4b:b0:2c9:fc0d:165b with SMTP id d9443c01a7336-2d026783a22mr16140475ad.23.1785316642868;
        Wed, 29 Jul 2026 02:17:22 -0700 (PDT)
Received: from localhost.localdomain ([115.192.250.185])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d022a15885sm8390685ad.15.2026.07.29.02.17.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 02:17:22 -0700 (PDT)
From: Zihan Xi <zihanx@nebusec.ai>
To: netdev@vger.kernel.org
Cc: edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	vega@nebusec.ai,
	zihanx@nebusec.ai
Subject: [PATCH net v3 1/1] packet: synchronize pressure clearing with ring reconfiguration
Date: Wed, 29 Jul 2026 09:16:53 +0000
Message-ID: <f90b5688311fa278d1361ea8c6be0bf25967d591.1785247446.git.zihanx@nebusec.ai>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1785247446.git.zihanx@nebusec.ai>
References: <cover.1785247446.git.zihanx@nebusec.ai>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

packet_set_ring() updates the RX ring state under sk_receive_queue.lock,
but used to publish the tpacket receive mode through po->prot_hook.func
after releasing that lock. packet_poll() and packet_recvmsg() can then
run the pressure clearing path after the ring has been cleared while
still seeing tpacket_rcv, causing __packet_rcv_has_room() to dereference
stale or NULL ring storage.

Move the existing receive hook assignment into the same
sk_receive_queue.lock section as the ring state update. Keep the
assignment otherwise unchanged, including on TX ring reconfiguration, to
avoid adding behavior changes that are not required for the fix.

Serialize packet_recvmsg() pressure clearing with the same queue lock
only after PACKET_SOCK_PRESSURE has been observed. If the flag is clear
and the socket has moved away from tpacket_rcv, packet_set_ring() has
already detached the socket and waited for synchronize_net(), so no new
packet input can set the flag again.

packet_poll() already holds sk_receive_queue.lock, so it uses the new
unlocked helper directly.

Fixes: 2ccdbaa6d55b ("packet: rollover lock contention avoidance")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Assisted-by: Codex:gpt-5.4
Signed-off-by: Zihan Xi <zihanx@nebusec.ai>
---
changes in v3:
  - keep the original po->prot_hook.func assignment unchanged and only
    move it under sk_receive_queue.lock
  - document why the packet_recvmsg() pressure fast path is sufficient
  - v2 Link: https://lore.kernel.org/all/f1cd534481c2397a36850ad039dcbfd38c3233ce.1784551898.git.zihanx@nebusec.ai/
changes in v2:
  - only take sk_receive_queue.lock in packet_recvmsg() when
    PACKET_SOCK_PRESSURE is already set
  - keep packet_poll() on the unlocked helper under its existing queue lock
  - v1 Link: https://lore.kernel.org/all/24f7311aed0c9ff06b8ea982647b82bf543ec369.1784454542.git.xizh2024@lzu.edu.cn/

 net/packet/af_packet.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index 8e6f3a734ba0..edf3bcf7bd73 100644
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
@@ -4544,14 +4556,14 @@ static int packet_set_ring(struct sock *sk, union tpacket_req_u *req_u,
 		rb->frame_max = (req->tp_frame_nr - 1);
 		rb->head = 0;
 		rb->frame_size = req->tp_frame_size;
+		po->prot_hook.func = (po->rx_ring.pg_vec) ?
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
