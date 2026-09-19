Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 520BE360EF6
	for <netdev@vger.kernel.org>; Sat, 19 Sep 2026 14:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789828755; cv=none; b=A9YV3gyhwW55w//SqLHBZ8jeJyHHiyhDFCUfvIYtmczG/cVc9hahLwYVYOZee3DMzS7kgSOM1YauNimmATOLsAY7FBKpYef7riaNiHoNeZb347L/40TGRoOS8ohJHmsWp6mi/x+DAJ7Ao1eAUc5WzXi0LTEu8+4vdh8Xb0+NHO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789828755; c=relaxed/simple;
	bh=Mhp9R0MCJnTDusbMi0FJ0eO35srlQlW9YSNrSMYga/U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=utDqiP2c7Tp5dpOFR+P6lSC3mOMpxzERs0nZXigB8wEGVAJQOTQ7br5nD+iQM7mDZGIg84tv4+4l8eHD+tD2qx8R2U/nDNB+Zks3jON97jJnGkqzKVwbvzdoZSyphrI7emNR4wbn+AfxyktTMdhSLedOlGABF/S+61m0iqV+rSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TeCerQc5; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TeCerQc5"
Received: by mail-pj2-f13.google.com with SMTP id d9443c01a7336-2d8fdc579daso18904705ad.1
        for <netdev@vger.kernel.org>; Sat, 19 Sep 2026 07:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789828753; x=1790433553; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9LRQZ57qeaendWDYofTy5iNhQaGS0Bdj4+bJU5zeKFs=;
        b=TeCerQc5TmVIsPH4E306TqildhkF7hx/cjv2m+dPqRE4FvBaofUVvTovVhviubO9uE
         2rbMZEi7vouYQpGgUKHco5qdLl8axLjXfjKjDzOCYukEXK1tTwBfp/QJfHJo/7sQHYLv
         KR+IAO5Ur8qqo3X8IfNNl0UeN0XMeDhY+A4X3OIqN+MpXHEIngtRM7ZpBAmwL/n62Hc/
         FAWoQTEFNkNhbKRgJIg+HcXYOg8gLC/ZOFVHY0DyR2jiI68OvO06SDNDsT5kvLNDBKKu
         h1ZOvxU+T0H3pd0piaBESAZTvn+Y77aOu6+wTB2CBfRhPgr93R8sbz77mbCVGNMzf9pX
         dY+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789828753; x=1790433553;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=9LRQZ57qeaendWDYofTy5iNhQaGS0Bdj4+bJU5zeKFs=;
        b=IxwIbDTc5gW+LPAaTAojToP2MgK0DrwQvuL37eiIrHwuaRo8C126KV4nMXiYM7SGB7
         4P1J1BPMbc53zxeY1kvNt+L5SxJrFelI+v7ievwIfxHxo0c3ENKG2K6hZ3jTTSyqxz3X
         mYPDauTWJ0pUbAks53PA7giQkOQtnt7tMVDloklpY1VyVoENDxgGBD6VmpqvvhI6yLee
         jFhTQCoruN1+lqZlWzWJGEyb4dVBeJ59V/3vqJ1HQ4Cm7GtR6eAXBLOYhDEV5I0Skczv
         dUFsJe0DeD5J5EuqiRbPR5Cd1WQ1ILznWpd/1cA2WVwpyGa9m/uOX8BeoD5xzeqB2+Y2
         TcGw==
X-Gm-Message-State: AFuF++ln8X+zW+IJMnT68BYHhBfoBDUreX5eSVRZ3Ohp6Yv/Bqg9ED2F
	JQRLVjEp8jXXD3XX2OQrwBAmv2H0zCh1HZtDfYdNjIooHDJqewL52FaV
X-Gm-Gg: AYBFou25oRD/iQbSUF1OI7Q5ipJJtuOvEfSUu75aD7zzDBR2yXcs29tRCfSb1UiG9tu
	FV+Nvv4pCvrqTiP3HKX7oi0xoTFd2O6qoyrspZyS3ZPmhOMQv4DwO1xgiqqE8rJSlkDEFxflbR6
	xqm4++e+1Eomw7w0AXV/vTbTqSWfeV9lrdX/lPRZ4fjdDSxWru3NNbgomzu7IjnOpUz1WIYiN2a
	z5gEvrJ4O6YXXWYhuP/0zUhMRxu01cJAcE7SSLDbcuwqQ1YlJK04mkDUrs2lcfnIhw5AVpMp7aS
	Wwc7mTp7OcFLLRZxyOv4rKdyzJ7guXXuAMbfTRuEYjoDizG7UIpD0ezkzE/OZr+gzo3e9/cM8+O
	gMv0b96SExkOUUQj4EbOS+bxlM0yqYU96xbx9Gqu3LQjSgNpIoRl+jGPazlmghC/NWFtatWjwID
	QuHXJy/+1QDHKdlcm8JRxpErLZyEd3Ow1+i7++tWcyAAGSEqKz5sLdlphhUHS+1NGHXD/FvQQO6
	50oGKsvz1GDLusJfM8cQYxgAXToswH63xVijPk74o7MLTvuhu/kdp9t93GTUmhgANHHXHJxgJIW
	QpW0ADvC8UtVbvDbqbsZG+ec6+KuylGCwM+2VZi+a7cBXVzpJHGXEHgcVz0=
X-Received: by 2002:a17:903:1b45:b0:2dd:c100:3142 with SMTP id d9443c01a7336-2ddc1003253mr39175395ad.62.1789828752736;
        Sat, 19 Sep 2026 07:39:12 -0700 (PDT)
Received: from KERNELXING-MC1.tencent.com ([43.132.141.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ddc179ed79sm10711715ad.43.2026.09.19.07.39.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2026 07:39:11 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	willemb@google.com,
	kuniyu@google.com
Cc: netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	Jason Xing <kerneljasonxing@gmail.com>
Subject: [PATCH RFC net-next 7/9] tcp: propagate the start time onto every skb in the tx path
Date: Sat, 19 Sep 2026 22:37:30 +0800
Message-Id: <20260919143732.11772-8-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20260919143732.11772-1-kerneljasonxing@gmail.com>
References: <20260919143732.11772-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that sendmsg() records a start time in sk->sk_start_time within
the socket lock protection, copy that value into the shared hwtstamps
of each skb.

The timing is tcp_skb_entail() runs once per newly allocated skb
in the sendmsg() loop, every segment produced by a single sendmsg()
carries the same start time.

Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
---
 net/ipv4/tcp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 28730a3e4473..85e3bae3569d 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -702,6 +702,9 @@ void tcp_skb_entail(struct sock *sk, struct sk_buff *skb)
 	tcb->tcp_flags = TCPHDR_ACK;
 	__skb_header_release(skb);
 	psp_enqueue_set_decrypted(sk, skb);
+	if (static_branch_unlikely(&bpfts_v2_needed_key) &&
+	    SK_BPF_CB_FLAG_TEST(sk, SK_BPF_CB_TIMESTAMPING_V2))
+		skb_hwtstamps(skb)->start_time = sk->sk_start_time;
 	tcp_add_write_queue_tail(sk, skb);
 	sk_wmem_queued_add(sk, skb->truesize);
 	sk_mem_charge(sk, skb->truesize);
-- 
2.43.7

