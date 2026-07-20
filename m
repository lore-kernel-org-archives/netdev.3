Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A38D3233943
	for <netdev@vger.kernel.org>; Mon, 20 Jul 2026 05:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784524601; cv=none; b=T5UC//n4O7aNPDG2BNZdOAl/7grUclRcoJQWH8bKeSzXpkWa5irAxvpVJbwew2Vu6+m/DE4cO1bo6lNbgSTWj/LKZpaEU2U8yYNbhF6lQS90pDQLBInOEvnitgO6aH/IzsiWLh8n87L2vQJaCMcq5ypKlHlg1IaiUxd1EvchyhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784524601; c=relaxed/simple;
	bh=a0i1t46TqtQBoF34AjwioQnWQimN/qjKoe99yOhUqH4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fC+WkMGK1VtjOedm3sGgcqmvwB0sc8Bd5edIM5YunyK/pRlFrt/8Ot8CLvtZ4J1tGjdvQb3bvLoSuUFIKDcwqkRgqRuwR39Ccp7fHX15NC+L4yXS5Ov0CPOjzfuh5sXk4EZOoHreKtFOqobdVvnOttgdcdDkXZVOEBnquSnCMnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B7STUsoQ; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B7STUsoQ"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2ccdb73f0e1so56207305ad.3
        for <netdev@vger.kernel.org>; Sun, 19 Jul 2026 22:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784524599; x=1785129399; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DGioerEBNVcfod0ZCwemUPuUtnSkx03OFUP0RKn5JUQ=;
        b=B7STUsoQUTM4RoBjvS33ZWMMO9FQBzcp1yWbxHeduDWAULjkhDEJVlsKExpF4tpdoS
         UDEAfsUyQ+jfMlkw9DHuiK1V8SwNo7jU8Mci0hXPepwhActxnLm+MQTJu2L8i1jOtWvB
         mioKpbQ4S2D0y1b9AVY17+9cNwbxzeKm17UANfZ+dE1/kah0VzHo7g31VMfXwXIMdTS0
         can6/kG31BDE6hKdIMnnavEDbXonu1H+/rtiPyd7B3PTGKRDNldiHV7navlJSMwuNTqL
         RP5BvvbKdrLDYj4nYCJ5WH2xGnyagEsaamzNLk2u8/CEKCOlXp4O1dMKiu8vw7n6v4RP
         VJ2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784524599; x=1785129399;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=DGioerEBNVcfod0ZCwemUPuUtnSkx03OFUP0RKn5JUQ=;
        b=TFgLCb4pwjXeOlSlYe1uL1N2eG+Q99pBfRuErrJP2rUldo/5F05Cys3tziMXjFRdms
         4I7W2otYgsjTIZLRxEIoCrdK9s1NhKBotLIVgO+n/8LX2WCbWwNw4vI1g0tNmF8s160L
         1PIJrIue/rvX/y0Or41fGd9XupHvcQklsGqKKq/NOC9x9xfMOtURxcDIIfYd1Qjos/2U
         p6ngySwnqaqRR4ojIfOa4Qi8kV02CUI4yC/YK8f/njTtSE/+/3rAQp8m9UbWIgTkGCTK
         25aMnNOJHncNCmfF2YlYGyTbu3daUEfj1mR2YIs8MfHaPjlF8AbM6TYO8zO/bOgqggX8
         Rhiw==
X-Gm-Message-State: AOJu0YyonK6HfKSQWsI14cklltZzL8P4EpB1JXJTE9Aq1pH9UwkXTS4U
	R9VxiCNFd+xiSiSXBb7zXxxaqW6O5vhXIwNaqg6O4GjDK+BW6hFIe9HeQIHk6ZHK3/0=
X-Gm-Gg: AfdE7cmRsTC9ZA6vpLjIA++N2DZ5vOxHI1+ONzfys+xCQoxUCOPU5AtwmIp5D3unVu5
	8Wrk2bmUVoJCcdL6T0SDtRFVoBkWAYVi53EqaZdTX29mTqQdULU4laiCCOrlRV5vnoNdC0OjreD
	XVKfxCAOQRkUEs2QP+K/8PFCaR01EYs6Zx3YDQm81GFBKJwvu2Xikl488ncpPN9fa/mOOK06DwS
	y5Cl4jFH0Zf38jr6Lj/JDiQ94e1/iNj9Qoj4pjFHNS/drEk367mNSGQ55LVDcoUJHd1E2/5e8Qx
	QcPLbTztXtYeTQKQ99IfeGynuwhEK3K3DKgy9iJQ6aIDmAps0BXFMMvPbbzlqZdlRtO4xMylSFY
	SEHFl/7HXCiOG3WlcdriLUmL26GJI2YgB+6vTKKLlUddgt60JXo8SRtPs75xd75R/9Lg+/7dBGh
	JdMmeaRv6Hp4NHsyLiCIS0RN6VGLGv
X-Received: by 2002:a05:6a21:7d06:b0:3bf:7498:9cd1 with SMTP id adf61e73a8af0-3c3ad963e8emr12133440637.45.1784524598947;
        Sun, 19 Jul 2026 22:16:38 -0700 (PDT)
Received: from enjou-Legion-Y7000P-2019 ([144.48.80.242])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cb519de2fb2sm3988938a12.24.2026.07.19.22.16.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jul 2026 22:16:38 -0700 (PDT)
From: Ren Wei <enjou1224z@gmail.com>
To: netdev@vger.kernel.org
Cc: willemdebruijn.kernel@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	vega@nebusec.ai,
	xizh2024@lzu.edu.cn,
	enjou1224z@gmail.com
Subject: [PATCH net 1/1] packet: synchronize pressure clearing with ring reconfiguration
Date: Mon, 20 Jul 2026 13:16:18 +0800
Message-ID: <24f7311aed0c9ff06b8ea982647b82bf543ec369.1784454542.git.xizh2024@lzu.edu.cn>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1784454541.git.xizh2024@lzu.edu.cn>
References: <cover.1784454541.git.xizh2024@lzu.edu.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zihan Xi <xizh2024@lzu.edu.cn>

packet_set_ring() updates the RX ring state under sk_receive_queue.lock,
but publishes the tpacket receive mode through po->prot_hook.func after
releasing that lock. packet_poll() and packet_recvmsg() can therefore run
the pressure clearing path after the ring has been cleared while still
seeing tpacket_rcv, causing __packet_rcv_has_room() to dereference stale
or NULL ring storage.

Serialize pressure clearing with RX ring reconfiguration and update the
receive hook while holding the same queue lock when changing the RX ring.
This keeps the receive hook decision consistent with the ring state used
by the tpacket room checks.

Fixes: 2ccdbaa6d55b ("packet: rollover lock contention avoidance")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Assisted-by: Codex:gpt-5.4
Signed-off-by: Zihan Xi <xizh2024@lzu.edu.cn>
Reviewed-by: Ren Wei <enjou1224z@gmail.com>
---
 net/packet/af_packet.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index 8e6f3a734ba0..b369f44b4065 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -1315,13 +1315,22 @@ static int packet_rcv_has_room(struct packet_sock *po, struct sk_buff *skb)
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
+	spin_lock_bh(&sk->sk_receive_queue.lock);
+	__packet_rcv_try_clear_pressure(po);
+	spin_unlock_bh(&sk->sk_receive_queue.lock);
+}
+
 static void packet_sock_destruct(struct sock *sk)
 {
 	skb_queue_purge(&sk->sk_error_queue);
@@ -4304,7 +4313,7 @@ static __poll_t packet_poll(struct file *file, struct socket *sock,
 			TP_STATUS_KERNEL))
 			mask |= EPOLLIN | EPOLLRDNORM;
 	}
-	packet_rcv_try_clear_pressure(po);
+	__packet_rcv_try_clear_pressure(po);
 	spin_unlock_bh(&sk->sk_receive_queue.lock);
 	spin_lock_bh(&sk->sk_write_queue.lock);
 	if (po->tx_ring.pg_vec) {
@@ -4544,14 +4553,15 @@ static int packet_set_ring(struct sock *sk, union tpacket_req_u *req_u,
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
