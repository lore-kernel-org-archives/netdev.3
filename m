Received: from mail-ua2-f12.google.com (mail-ua2-f12.google.com [74.125.226.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3209341F7D4
	for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 18:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.226.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790362158; cv=none; b=LKlYRO5TjNtqj/D2cPWgkdmd1Qiven+4bT0lAPdzuVS53ndTCcRsH7Wcb2HTxxtxl0dCCUUkXyqlMV2RDUvrLTnxwR8DmxKdI+vUswNcKKEm9yGkmDP6aLpg1dEBBQ+abOlqeXPGFLsG0YRHNOHLN6QUVe+2xFYNYUBlxKIAfAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790362158; c=relaxed/simple;
	bh=F8eGUcbXM9YJxxiTRFj1694VCKapoa42uE3eAkq3zP4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ubj/iZpAUjTP2vnvJbK0kRdnLLHbBGaSwTg3rXUL9VfJOJcyhcGk96ppDrlN6mkjIV5xveEIjrX/RdpAkibEBlyKm40ibNgUVKKiAwZbQCzAorJTZpc6gFYzXx8yLf56QPKGCdlI5F0Wazz2jwF+IrKmUUUBtKVzrslNmPuhHc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jd6JilxB; arc=none smtp.client-ip=74.125.226.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jd6JilxB"
Received: by mail-ua2-f12.google.com with SMTP id a1e0cc1a2514c-97e7c8c8602so649711241.0
        for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 11:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790362153; x=1790966953; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=kiKLmngPsfetWszmPVz9vnjkZ6oUGJcFeK7p9i5ASKU=;
        b=Jd6JilxBOET2kfXR5w38tJI4gEPIPR8nreSgtMQMGeLUOswN/XabL9//j8UvBgV50+
         1JchEB8skL8jiXnYFaU6XneVu/dGQK2PDu2EpfuLKHefcCNlHmUutYZKRH3gX3kaby7L
         Y4+gDiTFBPc3FdjpV9BMoA8KqFXE5uZsOg2TFMw2qur1p2Gc+RbaeLCDOo+cPdXg8m5e
         9Tsn/T8XOy8JthkW3hXw8EraNnWAh+hxCHe8erdijZWR+uLlXqJfulUABGtN59uHR+T7
         Q5nOU92OWRTnmfST/5dPR7xRgp7ILlSOOkuq3J48Q990xRp+UH2387yLdDtURCAcDOlF
         obkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790362153; x=1790966953;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kiKLmngPsfetWszmPVz9vnjkZ6oUGJcFeK7p9i5ASKU=;
        b=QZUby2nWfvI75hGPsmuaM8ZCCJ82uPcBTWEWH0jhdyTpmSCD3oloSOWYyjpAknMSUQ
         icvaSubtPcv/pFGOYQ1cNviktQLQFy0//H/x6SV/dFJwL+2w3DfIV0Y5y4eqJZ8i+NG0
         Cpnd3JrELLUhP7wHdYwF23PagP4oOC+1qyJygBGH/WZPnhCv13ZlSyFFnn4MukWI3LVD
         MY/sTUVvnjJjMXj0Ixeh+ReORwRor7DI6VDdho8nbaGiB/h8AaVrEbf0jCf45SRCXC3M
         n7/GVrVG1AvqYm6Mt2f+Bup0KW4lmcE9RmP7t8WAfe21Kx/XYWrbH0XDKkyUFEHC7poS
         aUgg==
X-Forwarded-Encrypted: i=1; AKwUvBywUS0ot5/fyfSixv0kcvJWmj+kuUUMC/OpOXgDoCkdPM6dpdIKNomPS5vJQSjMOp/WKCDn34g=@vger.kernel.org
X-Gm-Message-State: AFuF++m+EpUl52fMX4Sr7TVXjbxpSa1vbACqAop9wxzf1PKG4vctUZxI
	v7SLkr5q8NCvQWbbfEmu1kyuQeGi0jGfgQKLsiT0Q0EPylNz388kMfY8
X-Gm-Gg: AYBFou3zM6jFcaej8uEQDl5+oMO+aW2TK5FNhRozEpnb62W9oNZmx7Ij7o1JOdbBGrc
	qStB5HbYtd5Bajj6NdvT5P93ECC+l+lm3nCSkZepXeRpyHhxHPjmnpSuUjKrIBdxP4n5L5b4azS
	0ID/QhQ5FSnSrrzSL70ItyRLSW6A85ZzYZwKhV+l0FIb5TfOI1ihULS+33Nl/orzk6K6RzKmmxO
	RBT69k4WRIMqN/HKpqFU4B5KsjktRU/vVbGSXAsUyKBwwNhXI50cXFC3JADqBQMKVcwAgTWYcwK
	HU7Ds8Fi6f69o7aSJ0jSIzmU8WbLY4dHirKP3kND9TD3JrmzG0NlmVfikk3RR8WdHGHXW/QN+SU
	mJFB96XOoaTLGrcpZr/mHQzr26XGK7ySRMCwXC0Sq0RGsPCovsb38RJNwSwkX0RFjyvk48GGrqE
	RkoAKM2IJgelKWdh0x/aMKGWjRB/kfD+wPbLsK4COqXZNVsIwOMFiTng0fYExti4OyDSZXiH3aP
	g==
X-Received: by 2002:a05:6102:10c8:b0:7b2:f790:c020 with SMTP id ada2fe7eead31-7b2f790cd9emr639017137.30.1790362152641;
        Fri, 25 Sep 2026 11:49:12 -0700 (PDT)
Received: from beelink.. ([187.13.30.172])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-9861b029b1dsm3585744241.9.2026.09.25.11.49.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 11:49:12 -0700 (PDT)
From: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
To: david@ixit.cz,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: horms@kernel.org,
	oe-linux-nfc@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Aldo Ariel Panzardo <qwe.aldo@gmail.com>,
	Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH net v2] nfc: llcp: prevent resource leak on repeated connect after DM
Date: Fri, 25 Sep 2026 15:48:57 -0300
Message-ID: <20260925184857.357926-1-qwe.aldo@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A nonblocking connect can return while the socket is still connecting.
If the peer rejects the connection with a DM PDU, nfc_llcp_recv_dm()
changes the socket state to LLCP_CLOSED.  A subsequent connect() on that
socket currently overwrites the previous local, SAP and service name
without releasing them.  Repeated retries therefore leak local references
and SAP allocations until no SAPs remain.

Release any resources left on the socket before obtaining resources for a
new connection.  A closed socket can also retain the device reference held
by an asynchronous connect, so drop that reference as well.  Bound sockets
do not hold the device reference, so release it only when reconnecting from
LLCP_CLOSED.

Fixes: d646960f7986 ("NFC: Initial LLCP support")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Link: https://lore.kernel.org/all/20260923133339.2518641-1-qwe.aldo@gmail.com/
Cc: stable@vger.kernel.org
Signed-off-by: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
---
v2: fix author name (v1 was sent with an incorrect From: field)

  net/nfc/llcp_sock.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/net/nfc/llcp_sock.c b/net/nfc/llcp_sock.c
index 5558d8a..e76361e 100644
--- a/net/nfc/llcp_sock.c
+++ b/net/nfc/llcp_sock.c
@@ -690,6 +690,23 @@ static int llcp_sock_connect(struct socket *sock, struct sockaddr_unsized *_addr
 		goto error;
 	}
 
+	if (sk->sk_state == LLCP_CLOSED) {
+		/* Release resources retained by a previous failed connection. */
+		if (llcp_sock->local) {
+			if (llcp_sock->reserved_ssap < LLCP_SAP_MAX)
+				nfc_llcp_put_ssap(llcp_sock->local, llcp_sock->ssap);
+			nfc_llcp_local_put(llcp_sock->local);
+		}
+		if (llcp_sock->dev)
+			nfc_put_device(llcp_sock->dev);
+		kfree(llcp_sock->service_name);
+		llcp_sock->local = NULL;
+		llcp_sock->dev = NULL;
+		llcp_sock->service_name = NULL;
+		llcp_sock->service_name_len = 0;
+		llcp_sock->reserved_ssap = LLCP_SAP_MAX;
+	}
+
 	dev = nfc_get_device(addr->dev_idx);
 	if (dev == NULL) {
 		ret = -ENODEV;
-- 
2.43.0
