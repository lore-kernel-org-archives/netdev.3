Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B89C2D5408
	for <netdev@vger.kernel.org>; Thu, 30 Jul 2026 09:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785402346; cv=none; b=ltZ66G7Sd9NJOOBESTzhrBaxIY3sOhWLmoD1R3llghZ1A7hukIiTn8+N6h6GyesCzVUVrMxl4LGb7/qTKKEnVmpBhj5Qz2ouJrhPxwn8EQojcmRRJ/lKePZ5fybZ1FYEWtYMH2WjizLyKX0wSLBHkwkOAAVt13wc6fzfiaNHx7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785402346; c=relaxed/simple;
	bh=kL3IVIOe1ALgbrOXk8HHOMTEE77ThONwsjZG93CgMo4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mArb89kI1svMXx0GvbHKCJic8I/Itbi0pHYS+B4qyPZo4wI81OzJ1CpBtsNkZYdr5SKS0Kvv2Rqo7LMaqj+N/MMVBaRkmWzbyB+sUcPvxNiJxSOzAMokpKlp0z6+Xs3gN6vDwXMnss8ad2Zsq7qWMLiJRloGFo4bndnauU+MoIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nBvVYFHF; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nBvVYFHF"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2cc7ef7ec27so24608975ad.1
        for <netdev@vger.kernel.org>; Thu, 30 Jul 2026 02:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785402345; x=1786007145; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=CpKlGxNrk83Ii+YIm4YNlRDoPzJNOT0xfV5KNDUW93I=;
        b=nBvVYFHFbjYQTnCofCA9ks75kdDzRumkvCh9rWUEPgwpuconZFERRu1m1cA320yIvs
         4LMgNPTkaY4QT4d6kYcEGyRV0eNXeElR21szhtVlBZK8pwk0izYer/+LDf+lAShJK30+
         ReR8Oc0rIE/9mdSKJTGg0c8WX6SpugumR3679LhELayb4FIph6sRciGQCPLLpvrpd97/
         bUAe0S2nG1MYsMM910VUZ/YUB3p7nm0ZfljtCVm/KGlu6B7u5wpa8rSdDr+G79pnpAPh
         OXKyuUj51Q5DxVbdKqrZA24NWVzgTnCjb56hqM3B6PflIl3X/KzBiTEs0rGSP9bJmuoQ
         x7mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785402345; x=1786007145;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CpKlGxNrk83Ii+YIm4YNlRDoPzJNOT0xfV5KNDUW93I=;
        b=FV+8N7qjvMCVa5hVDhWW9ZB5EeteSgIeZ9arfeEhH/P0FPi3aBMWjh9LCSYQqkbcG6
         +8w3yn55gsytrzgjHE4DQylTdz2MdmnA/3X1XNBO0QyP4FovBs2NcEcEpyb4J5SYF8PF
         A0/7vMVOc9YFP9S0YC6I2CdNKMaM+IcBrpqH3hc9McPuuhVwRsGNihpc9u2hOof1qvYS
         DzUfRVuTx/PQAbxZxOFSm5t/HF9elptYGphxVwZ/hGdfiy2Z7hCHKmEelts8vgXfGV1T
         qsZ103cDwod2GQpmznDknu0QRKMdNLaupKs+Sqb/GTqEtCa3gnKej/7IFEnK0cmbCWv+
         OWug==
X-Gm-Message-State: AOJu0YxnASaUh5eRTFr4U0RjnHVnkSxmBKBORwzSHNkKd3svxoRTz8Hb
	n1mnCCwP9LaEvjme9lhV6/fwq1AV02PZpIbW07TjWyrsiV8e9BDsnrRuILTTjds8OQsOkMC8
X-Gm-Gg: AR+sD13ulX1ftO5Y9pwwSC5+xerJpPwAYVYovEsQq5p58x6X6geroEKKvvSPI4YhKnm
	aI24+NO8PtniRFQ9PH/6fMAIJyhR6o+cIi+go+TD+cNRXL6gtIKU2BLlL5c5YHMhF+P6ysJGvgd
	0obxTajxYtCL54F53isT1HhN1700U9sW47Vdg3R1be09f6WSInrhaJw3H1EBDsivpPhSY+AqHGn
	cJVz1KoIc7qICw5X/iGrkJnVje5BQyQpU/8d89CqXMLOlYkuK98DXNE7n8mB7gx5zEThpfaswrn
	tJl7SvSdunXef3VclRCbLu++poqNYxM9Zz8VqX6O2joV448AoTshpyNHyNtY2KXqAfKPDlOH2dV
	fQuvYTXTcwG/SC4TiNjB+0mz75fRuVJrTlUyyOVtBHiParx27OXchX9cZ3qlnbWOxVgyoI7dMiQ
	zPS9Ymh8HHUgBCQDFkP5kxSQJz4pD9oOdbfTA46f+gD2s7YI14DUtP4B2qdTjdr/Ns1ROZnUQu/
	MRq6cQ4sPDZIuhwpFpA7jxQP/kDlZHRQS3H
X-Received: by 2002:a17:902:d983:b0:2cc:a977:4260 with SMTP id d9443c01a7336-2d035bdf26amr19397505ad.21.1785402344493;
        Thu, 30 Jul 2026 02:05:44 -0700 (PDT)
Received: from JUNVYYANG-MC1.tencent.com ([43.132.141.24])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d0228417adsm23387555ad.0.2026.07.30.02.05.41
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 30 Jul 2026 02:05:44 -0700 (PDT)
From: Jun Yang <juny24602@gmail.com>
To: netdev@vger.kernel.org
Cc: Jun Yang <junvyyang@tencent.com>,
	stable@kernel.org,
	TencentOS Corvus AI <corvus@tencent.com>,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	Xin Long <lucien.xin@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-sctp@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] sctp: re-point retained control chunks on association migration
Date: Thu, 30 Jul 2026 17:05:25 +0800
Message-ID: <20260730090537.27629-1-juny24602@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jun Yang <junvyyang@tencent.com>

sctp_control_set_owner_w() records the owning socket in a control chunk's
skb->sk as a bare pointer.  sctp_sock_migrate() re-owns the association's
DATA chunks via sctp_for_each_tx_datachunk(), but that walk keys off
chunk->msg and so skips control chunks: any control chunk the association
still holds (for example the saved stream-reset request
asoc->strreset_chunk, the ASCONF request/ack lists, or
asoc->addip_last_asconf) keeps pointing at the old socket after the
association is moved to the new one.

Once the old socket is freed, a later retransmit reaches
sctp_packet_transmit() -> skb_set_owner_w(head, chunk->skb->sk) and
operates on the freed socket -- refcount_add() on its sk_wmem_alloc,
then sk->sk_write_space() from sock_wfree() -- a use-after-free of
struct sock.

Re-point every control chunk the association still holds at the new
socket right after sctp_assoc_migrate(), as is already done for DATA
chunks.  Control chunks carry no socket wmem charge and their skb
destructor does not use skb->sk, so a bare owner update is sufficient.

Fixes: d04adf1b3551 ("sctp: reset owner sk for data chunks on out queues when migrating a sock")
Cc: stable@kernel.org
Reported-by: TencentOS Corvus AI <corvus@tencent.com>
Signed-off-by: Jun Yang <junvyyang@tencent.com>
---
 net/sctp/socket.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/net/sctp/socket.c b/net/sctp/socket.c
index c7b9e325ec1c..9a6da4e0d741 100644
--- a/net/sctp/socket.c
+++ b/net/sctp/socket.c
@@ -9522,6 +9522,30 @@ static void sctp_skb_set_owner_r_frag(struct sk_buff *skb, struct sock *sk)
 	sctp_skb_set_owner_r(skb, sk);
 }
 
+/* Control chunks record their owning socket in skb->sk as a bare pointer and
+ * are not reached by sctp_for_each_tx_datachunk(); re-point the ones the
+ * association still holds so migration does not leave them on the old socket.
+ */
+static void sctp_ctrl_set_owner_w(struct sctp_chunk *chunk, struct sock *sk)
+{
+	if (chunk && chunk->skb)
+		chunk->skb->sk = sk;
+}
+
+static void sctp_for_each_tx_ctrlchunk(struct sctp_association *assoc, struct sock *sk)
+{
+	struct sctp_chunk *chunk;
+
+	list_for_each_entry(chunk, &assoc->outqueue.control_chunk_list, list)
+		sctp_ctrl_set_owner_w(chunk, sk);
+	list_for_each_entry(chunk, &assoc->asconf_ack_list, transmitted_list)
+		sctp_ctrl_set_owner_w(chunk, sk);
+	list_for_each_entry(chunk, &assoc->addip_chunk_list, list)
+		sctp_ctrl_set_owner_w(chunk, sk);
+	sctp_ctrl_set_owner_w(assoc->strreset_chunk, sk);
+	sctp_ctrl_set_owner_w(assoc->addip_last_asconf, sk);
+}
+
 /* Populate the fields of the newsk from the oldsk and migrate the assoc
  * and its messages to the newsk.
  */
@@ -9633,6 +9657,7 @@ static int sctp_sock_migrate(struct sock *oldsk, struct sock *newsk,
 	sctp_for_each_tx_datachunk(assoc, true, sctp_clear_owner_w);
 	sctp_assoc_migrate(assoc, newsk);
 	sctp_for_each_tx_datachunk(assoc, false, sctp_set_owner_w);
+	sctp_for_each_tx_ctrlchunk(assoc, newsk);
 
 	/* If the association on the newsk is already closed before accept()
 	 * is called, set RCV_SHUTDOWN flag.
-- 
2.55.0

