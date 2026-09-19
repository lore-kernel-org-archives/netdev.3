Received: from mail-pz2-f28.google.com (mail-pz2-f28.google.com [74.125.228.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C79253783C5
	for <netdev@vger.kernel.org>; Sat, 19 Sep 2026 21:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789853333; cv=none; b=Eld3SbeUn1VMYULPFGyiabm8iQM/gjeN6hsObGVPM9ze5NMwXLdK+Y/0pbkN17eGf88m7JppTdgZ7UVlgLy+o2pkLDmKX7cFHtVIQ4O3iFz6Og1npZQ8td7ZczWn2NR0mlqrhRgS74w8TB9sHLtgVTzbp8v14MOpUXlOvXtC/tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789853333; c=relaxed/simple;
	bh=qi+8UfjOHnuyvfYtoqMX/7Q8LuPSKEg1QIzac8Ia9Ko=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=X8kz20x4/qwgnEqitFTBL2/JoUo5aaeIRKnQYYrxI82d9C+wr64hGzBr0ea9IEN+UvfVg24pozhNt03iP5jDmoZN4rvcck49v4qZU6bbO0b2xPquDMuSmEZIEYwu7xnEQIQwdAzmaF+tV5cX8rpnbW6k0IhHe4ddaqZc+M2EKkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U9q2cbN6; arc=none smtp.client-ip=74.125.228.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U9q2cbN6"
Received: by mail-pz2-f28.google.com with SMTP id 41be03b00d2f7-cc4ab4fe290so519775a12.1
        for <netdev@vger.kernel.org>; Sat, 19 Sep 2026 14:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789853331; x=1790458131; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=AV643nCtB/hqzvQNISm7doHVXi7iv2eQBCiZ3N3vJaE=;
        b=U9q2cbN6xDeijWvU4MSlyLbavSnMLfP1I/ryc16wfW9CjoVZ812oQUoSbeQiBYRkWh
         hnssi6huPOjxR74pa61XWbST8DdNOueEgQbZFQ4n2/OSl8Ca5uB0hH3GC8H0oqxyb9Ba
         5dWBr8lC/J1GDezpPYMjdttOu9g32FmNI0gpGE6rSe7TT3gZz2pdDY3QGvvkJS5q9tdV
         ZfY392Kctre4OVzRNEonhdu/xe+8/+Os1Kl+5YExz8geqEQTdlVlsLfH6l0oWkEYX+2s
         jjRyUE5lHOg0eDPH0kmUIVj1oq/cQYImyKfy4WBuY/IqpHkz0YQZZWsog49KE/CdZXWE
         Ow8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789853331; x=1790458131;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AV643nCtB/hqzvQNISm7doHVXi7iv2eQBCiZ3N3vJaE=;
        b=OeXDLqhFEq4RVSSCCwVLL4lnZPxz3c/QEYY+MTFhh20JeVV6tP35IKWIStTiAqw1NR
         kW9GiopNCfP2GxrKUL8utRR/hJ0yZPsbXjvNImBksjKupOO4hrVxW2/33Nfqp0QClwsG
         MAbd8CKXfmPRIzMy735G9h8rjJH86bB/nMsY4tBL6K7Ai1mqURCBjF5iL8JMUtUNo2gr
         1A4/T9RjpdgHacH6pfyQERg0o8XYh62ZIhpVdrFJkB9rJhc/7lNj3KjWU9D9X/B6ArR5
         QF0h8/lXS3DIF28w/9VhwBtT2KwruggwOo+nU5mwbf5PVhxWA1uFLg0ENI2Z236lRgJf
         +Y8w==
X-Forwarded-Encrypted: i=1; AKwUvBxGQRmP1yovUVkVju33N8sncMcpXenvdSt1AJ+w1rYPaWHr1bvDtb8H10nz3GFY5pZpZFb4c5w=@vger.kernel.org
X-Gm-Message-State: AFuF++kfp7rqCs37vz/BWp3Actv22GNlBmCCortPQbVNmmNuOp8PA6E/
	jircdHTwuEksnL4zSFJJjdaAzt21cshV+wGDVtXmkV+T9UZQYDr2SB1t
X-Gm-Gg: AYBFou0O3LER0DqYh4JgnK2Fe+U6IoIUYOu3i9keTpa7pjEgznQnBKHR+Hmh5/sJtXi
	VkuwA6AzfDXITBQweozoKpHGCPVb7+WNpYd6gXAkjxG51iHiXzAvfaL8jBj9kKYjUUCe7GXgv2I
	7lNlATi043729ycu+QQi/h5Gj7arwpAr/JZ1BHKnGgadnYHZO6UvdXCnNtkr3M93sABMyEibtLP
	mwYTuTxw/wNYC5ukjfAEdRLSZCy/mEHa0mZk2YefTiYE37GWh6TPleX4j+NRCg6qz+k7wBLdjm7
	/J5x0XaDxG3V6jgyBx3NBoWyP7rfI3SP0c9nxZrZ7XslXF9repZeOcFE95vFkPnp0PLAtlOhDWB
	298/rodc6b+QCkHnPEOJpkImByTSH3zmULoJrY5ouGUuIKBEDljYRwySD7cdJDim1WuI27GllPW
	7H0SmlpSVgRC0XT6vSg9f1Ab7oIr8x2nn/quCKO5lojqSjKXxDQiXfLZijED4WQx4Wni/UiS9Aa
	c++yivuBS7mzDqQDTUHWTC/4zCWenFwdoo2coeraGL5rTHL9x69Xli1MgTcy7qpxu8aCUhMJHTc
	IT0lZyV9FA==
X-Received: by 2002:a17:90b:2b8e:b0:39e:4c7e:bc5 with SMTP id 98e67ed59e1d1-39e5572d5a2mr6755750a91.19.1789853330851;
        Sat, 19 Sep 2026 14:28:50 -0700 (PDT)
Received: from phui-2.c.googlers.com.com (78.123.83.34.bc.googleusercontent.com. [34.83.123.78])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e6cb3284asm6107715a91.14.2026.09.19.14.28.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2026 14:28:50 -0700 (PDT)
From: Hui Peng <benquike@gmail.com>
To: mani@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: horms@kernel.org,
	linux-arm-msm@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] net: qrtr: ns: validate msglen and sq_port in qrtr_ns_worker() and ctrl_cmd_bye()
Date: Sat, 19 Sep 2026 21:28:50 +0000
Message-ID: <20260919212850.3240353-1-benquike@gmail.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Two validation checks are missing in the QRTR in-kernel nameservice
(`net/qrtr/ns.c`):

1. `qrtr_ns_worker()` receives control packets into a single reused
   4096-byte `recv_buf` via `kernel_recvmsg()` without checking that
   `msglen >= sizeof(*pkt)` (20 bytes). If a short packet arrives on
   `qrtr_ns.sock`, `qrtr_ns_worker()` reads stale bytes from previous
   control messages (or uninitialized heap memory on the first packet)
   when parsing `pkt->cmd` and its union fields.
2. Unlike `ctrl_cmd_del_client()`, `ctrl_cmd_bye()` does not verify that
   `from->sq_port == QRTR_PORT_CTRL`, allowing any unprivileged local
   `AF_QIPCRTR` socket to send a `QRTR_TYPE_BYE` packet and purge all
   registered services for the local node.

Check `msglen < sizeof(*pkt)` in `qrtr_ns_worker()` and require
`from->sq_port == QRTR_PORT_CTRL` in `ctrl_cmd_bye()`.

Fixes: 0c2204a4ad71 ("net: qrtr: Migrate nameservice to kernel from userspace")
Assisted-by: LLM
Signed-off-by: Hui Peng <benquike@gmail.com>

---
 net/qrtr/ns.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/qrtr/ns.c b/net/qrtr/ns.c
index bcb090ee79d4..d7e1a37f0717 100644
--- a/net/qrtr/ns.c
+++ b/net/qrtr/ns.c
@@ -347,6 +347,9 @@ static int ctrl_cmd_bye(struct sockaddr_qrtr *from)
 	iv.iov_base = &pkt;
 	iv.iov_len = sizeof(pkt);
 
+	if (from->sq_port != QRTR_PORT_CTRL)
+		return -EINVAL;
+
 	node = node_get(from->sq_node);
 	if (!node)
 		return 0;
@@ -639,6 +642,9 @@ static void qrtr_ns_worker(struct work_struct *work)
 			break;
 		}
 
+		if (msglen < sizeof(*pkt))
+			continue;
+
 		pkt = recv_buf;
 		cmd = le32_to_cpu(pkt->cmd);
 		if (cmd < ARRAY_SIZE(qrtr_ctrl_pkt_strings) &&
-- 
2.55.0.1082.g2b9226bbc0-goog

