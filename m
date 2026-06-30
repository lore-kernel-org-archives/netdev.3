Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B597305E3B
	for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 19:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782848999; cv=none; b=BH2/ERFLZxbga9snjJsxtW6cr8vc69Fbzf2rMvqp+TgplcCzTCIvxD/c+P4tWropCcr7Yuia3bkPYH/z9BulTuFLOLQdGAUYovaow24+l230wdvMDJOEMVXTLTDGKpcrOZ5YIdV/j+Lsm6wLpG/RB1euvFRgRJ/c6NrgvzMP9Mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782848999; c=relaxed/simple;
	bh=ndjrqTDd7iJKz5Vy6GvgobLXO+ceomtbKFEb3u3b6EM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hkOYwvI6O5DVmoVXC5BExuonIycqRtbc5gQJsSY8mhew2ULRvTdK0WbzkLqI32NEfSSLPXbX/MNC+xHoOWtJxQPBigJzkgswD0hQLFSq2GuL0SD5bY7eJJJPUR/zaUG9BdC23SQa+Px9itpMgc5vUas1OJt0GPNiAsLYZJRt/LQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WfEvfRS9; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WfEvfRS9"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-8f0d6853360so18513266d6.0
        for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 12:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782848997; x=1783453797; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=n1qWlnp0byEBEeqkZdCjA2Jg1Z+PW8t3ekcekpBNKTw=;
        b=WfEvfRS9wgll8++0qRTBXGf3uVtr4Fd3CdmSt3/ecBmFVdzTaKzgS3ZvLI/ZkMQifh
         Y6t7k3f3oAGm2zGFRtSJIquyMGPkbCFpUL1VqLePDdDJuimT9uRpZHZkJ9z1/qFB8MTe
         WiPjcUy1BuU2ioxGPG7cbHJyGDP8daUiFjQKE1gAWZs4P5splOqOBCPLyCcbAj2pqple
         RB9MS862488hwpaX+xQrJFHmUx8qb7UZ4vXNSIgfxNMiAE7Tp9ScMnIx0SNDd+K9Y/hC
         C0pds9pUSfVGAFwLKQ8neftJVLax8Grd+6IPUxpmet7TL2/bcG42Nlox4yhY5TaP/wP1
         4xQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782848997; x=1783453797;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n1qWlnp0byEBEeqkZdCjA2Jg1Z+PW8t3ekcekpBNKTw=;
        b=S97rIBgoIdoltyM1a2PVrESc1WhTrUGzYTl+mXESbB3iaFDijaNHWUszMQ7Jgd0XQC
         vkbA7B8T8eG4QBT/A1BpA/7gD5TnZX1NSpoG88P+hN3PcuhTqGz3oiW6FqQ4/2bVxacK
         rg8/T5F/elWUxiEFo/+gprHaWF4O4IXZDziOIR4aL1Y5AZ/yWYzHFMbJkTwEmZ3zLgvr
         1wEVg3Bar/Rgrff8kOt7RRouG1m5NiQyQJnLaLDI0xLEDs+rk/ZA9nJNq+IqxzbQV5et
         ONea/+AAcrXqZgMQl3g0UGLOjGSPEC2RpZNa8OerNWwUK/vbW9Og9wLha7Clom4Jzecj
         VHoQ==
X-Gm-Message-State: AOJu0YyacXJDallWKmrAt9hgu8+5q7jmnWEqinH3GcoToK+U058vCDyG
	AnEsL+3woqKs7NUaHMBs6UEftgbeU0ZxmP8zvrNNho3G6odXxMMDD6IPbKPpGA==
X-Gm-Gg: AfdE7cmgpLVPplWUmAAY+JLCpf3Q7cRGC1xeb/L/tI0HAWPQfF6z8hPmU273BNZ4dqZ
	Na5oSQz1UlsbhkVj+8Xw0CH9Vqv2EtQ7UomDdvZPbwdiL5w4kRUtMinC6bWLKdBiYeTy+4tXrtk
	oCjvNktXRQlpWBliGc/KzaxV0PIMonKRcP8Lu9KmWzJxoUn8sPiLsabGYig7UcxomnF0ITWHSeB
	58qz5wEDFoMUB5fdEpPmUPzy/c6z6Hrr5KT3ReW1N5S9XYcIkuwwqGx5FabzuZtRPg6QKs2lDbk
	76u0DD/u1F3Yh/ukch+VWRDoocWZN65RPmouiQutjVp/TgOgrAnbuFJWNFmo0C71zJpqR9Jyxiq
	SoFm7gfBawTxxQo+ArVpMkj8/ycwV9JQR4hn74ynSIicwFTVtcQWfbs57gqoEVcBXnjVAn3mXeE
	OXDsdz5CYTLStgTQEVXYQkqtip5A7aP/dQjRULEz2dBg==
X-Received: by 2002:ad4:5baf:0:b0:8e9:f5b0:f623 with SMTP id 6a1803df08f44-8f1bd6f20f8mr82544276d6.51.1782848996851;
        Tue, 30 Jun 2026 12:49:56 -0700 (PDT)
Received: from i4-l-hqh5357-03.ad.psu.edu ([130.203.139.71])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8f1a7e0d5e3sm33242986d6.48.2026.06.30.12.49.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 12:49:56 -0700 (PDT)
From: Shuangpeng Bai <shuangpeng.kernel@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	linux-kernel@vger.kernel.org,
	Shuangpeng Bai <shuangpeng.kernel@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net] llc: fix SAP refcount leak in llc_ui_autobind()
Date: Tue, 30 Jun 2026 15:48:56 -0400
Message-ID: <20260630194856.1036497-1-shuangpeng.kernel@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

llc_ui_autobind() opens a SAP after choosing a dynamic LSAP.
llc_sap_open() returns a reference owned by the caller, and
llc_sap_add_socket() takes a second reference for the socket's
membership in the SAP hash tables.

llc_ui_bind() drops the caller's reference after adding the socket,
but llc_ui_autobind() keeps it. When the socket is closed,
llc_sap_remove_socket() releases only the socket reference, leaving
the SAP on llc_sap_list with sk_count == 0.

This is user-visible because repeated autobind and close cycles can consume
all dynamic SAP values and make later autobinds fail with -EUSERS.

Drop the caller's reference after a successful autobind, matching
llc_ui_bind()'s ownership model.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Shuangpeng Bai <shuangpeng.kernel@gmail.com>
---
 net/llc/af_llc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/llc/af_llc.c b/net/llc/af_llc.c
index 8ed1be1ecccc..b0447c33dbf0 100644
--- a/net/llc/af_llc.c
+++ b/net/llc/af_llc.c
@@ -312,6 +312,7 @@ static int llc_ui_autobind(struct socket *sock, struct sockaddr_llc *addr)
 	/* assign new connection to its SAP */
 	llc_sap_add_socket(sap, sk);
 	sock_reset_flag(sk, SOCK_ZAPPED);
+	llc_sap_put(sap);
 	rc = 0;
 out:
 	dev_put(dev);
-- 
2.43.0

