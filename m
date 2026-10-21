Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792553092;
	b=oR+CPv3w61BZWk68vKJbYmjdjM7ZWAYbuovtUgu+0AtgnYkuffiDZeje3GQwzdruBLKs
	 pTm/CHLa4efclRjk2CVxpgaBf8yb6wzv0I/1Ma6BtHKBZVspl2I7MgqdEVcvvYbK09/T8
	 50RPacqUG9dkK9tSCQS6OMT1D0ZrVtE9mZPfwBDjj/IkoDvs2P+K5VZEKv1HHNW2MXwdE
	 8jiTgbu0bQwfBqNyy/U86sYdSo6azhga46cOAJJdOZZIh27lJSrJAPpenS9e+JW5Bu8lu
	 6/CJuon2dH76lc2R4TUA+qp2kwy4copAGv6S/NyH96aXbxBkN3hFl7JB39ttG0IuASQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792553092;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ZFVAKQGsMgdgNfkXAN9sULjMGSL2i7oHnvsLeDRjk+s=;
	b=RMpGPzl3cmI4pTzkU0B1G5vF96w/i3ORscvYzryH7wC9in1FVX8vGRW8fddIkjezxIZ5
	 NKtUDL7ePQJMnQQQXDuuiZx8BnbuOvKYckP65SThXRSrQJ6OW7ln2fIPp85KScq5sAnIN
	 KUS8Qk8l3ygyytkK8/x6lfy0xT/z9k6z+ttBeNtqOMqjx9wplkTxJhfiqH6aw3aeKMiFQ
	 HyMb1K+RKRKx0bCdhcxkKLYGOLE2prM936Yv/Aq9AcluD2yk6A5S14IwfYramD+pFZrpb
	 PAGm2r6+lr++fKmUOQloGuT4XKahLENccOVoDG5TOtG0zDd1aVhr0/bKYL/IxEj1A3g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=octane.security;
	spf=pass smtp.mailfrom=octane.security;
	dkim=pass header.d=octane.security header.i=@octane.security header.a=rsa-sha256 header.s=google header.b=ojPcxL9A;
	arc=none smtp.remote-ip=209.85.215.169
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D5E2606A31A
	for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 03:24:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7D5E2606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=octane.security
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=octane.security
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=octane.security header.i=@octane.security header.a=rsa-sha256 header.s=google header.b=ojPcxL9A
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-ccca948203aso31201a12.3
        for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 20:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=octane.security; s=google; t=1792553092; x=1793157892; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZFVAKQGsMgdgNfkXAN9sULjMGSL2i7oHnvsLeDRjk+s=;
        b=ojPcxL9Amul7kBOJOcMw0LKjDpPLd8q8X4B9mxDTd+UGa5ldBO7U8up7cReajCWUjL
         q7dsM3IKeJh7w/ESsLpUyS49ZK7zLfX1Jme3+ilA1Xi5x2L5rYG1aMmNL2F961FLUWfJ
         WfceVgc85Q28m3htW28qpD0iXq6Iv3pPg0vfevqlM9yLNDjHVZ6Ibqye0ijNEGEOj4Fx
         kUyTfo7Iw6O8lBLh7rbEDQbjhi1kURc4pUlFIkKD24lU/iCToGIUR7WGFYV5RnIMS3tM
         zx+A5QO0tfj1tT8xxgq3mymKhLtyyxEXmf86a2DBqsSqCY0EAZrvvXzVH7YKZ+DgJW9i
         I7UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792553092; x=1793157892;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZFVAKQGsMgdgNfkXAN9sULjMGSL2i7oHnvsLeDRjk+s=;
        b=EzQCDarz3d4pER8UYBKi4zpGMNesQcRJb7G1AhyIrx5G+FNEPK7jq07OKF4Z73sZyU
         ty0N2aiPvhJsSTlAz/QylZoc6szhChA233M7Jrs+DD4y1Wt5MDA+uM91lKWks4QcW3aW
         twv7thpuOhyMj5QpdCwQMYZAqOAq8jfPwjQnwbLlvweRrqAKf68o8kSw/ZmLFTHZpqba
         CXVYgEproDRA/XNpQETtMZtF+cfDpJ1hX+qH1X3qNnjgT/XGsr9J5qU2a9EYr7E69uve
         DMOgMW3WQIAZl31H3H9xrzq42SeEYzRVX2ckGUHXBx8mR3MtxwQwri4x2PdGIRURvDfZ
         azag==
X-Gm-Message-State: AFq9FYLRYMXtoJ9k0SEcjGEKTQrpmRqWr02qMN1jEcJYBFO3tb1ii43g
	DYMIY2VQtrG3U6BZ4/mUsTsRslS0uYADgptPtZQmY8z9CUQC8BjeniPuavCx1Fp9pfOM0U+vsGA
	JBPgl
X-Gm-Gg: AYBFou089GWbBBMr+anW0tsBlqhjHhUaVd5VC/Q+5+m1R6Xkuq2CuMGNJEi6Pp+yrg0
	kAxhvKAyGYmT0eB2gcbiASANsEHw4eIpOinkHRfU//Ml+K66mMibS7nMRpO10OdjDnFLGcpleze
	OZkmtRv+bCDIqgS0yf2iP/WYTPLmUaXTQ0cUroSrqbMMfHRH3K1y9f6YpEqSGtg6YxV1VG8jLmq
	1vDZ5Cv395YOOjFR8eLqXS4l1DVq99supWIodVtqRPLaYrwBqRxZCXYIg9PF5cr9FnDWo2SF/wK
	4uUsT6ciytrkjhSBiRGxh5KHy/Cn92NJcG7V+brwyyxvu4Sqk4Vwglg9f3BtTen9nD/6vmt1U+a
	9louCneOlnK0+p2XIQNlsNSyxt7HT9fhuJd/5r/fEj65FwSKRDDqEVVRkojqjdl2iiaf82fWmnL
	D6XdQ08cWYVT7jKyC7Gi9e5WiVyre2xcbcsdfo+h8nnCe5y0xBTwovl2zOclEOZqYRM0kmsu549
	fqrm1pQuw36nPtGPoq10iTpt9QBW/WYDSxBKmPTVjVrplwZ2r13rU/NHPcZL8vi/KR0RWkdxei7
	wlCGOf9VScUuix9BdjHcPv+kbxiB9GU4pOl05FjJ6PWZaDhVNEMfc+8yTe1khOTQXT5xq6lrust
	chg==
X-Received: by 2002:a17:90b:390e:b0:3ac:9706:7735 with SMTP id 98e67ed59e1d1-3ad86b0c35cmr794388a91.5.1792553091800;
        Tue, 20 Oct 2026 20:24:51 -0700 (PDT)
Received: from localhost.localdomain ([103.207.175.177])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ad8030226csm2155285a91.12.2026.10.20.20.24.49
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 20 Oct 2026 20:24:51 -0700 (PDT)
From: Shubham Antil <shubham@octane.security>
To: netdev@vger.kernel.org
Cc: David Heidelberg <david@ixit.cz>,
	oe-linux-nfc@lists.linux.dev,
	gio@octane.security,
	stable@vger.kernel.org
Subject: [PATCH net v6 1/6] nfc: nci: skip controller reset while unregistering
Date: Wed, 21 Oct 2026 08:54:38 +0530
Message-ID: <20261021032443.44412-2-shubham@octane.security>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261021032443.44412-1-shubham@octane.security>
References: <20261021032443.44412-1-shubham@octane.security>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

nci_unregister_device() marks a device as unregistering before closing it,
but nci_close_device() still sends CORE_RESET and waits for a response.  A
transport may already be detaching at this point.  In particular, line
discipline close holds the TTY line discipline lock for writing, so receive
callbacks cannot deliver the response and close waits for the full timeout.

Skip the reset request when NCI_UNREG is set.  Keep the reset for a normal
device-down operation, where the transport remains attached and can deliver
the response.

Found during a source audit assisted by OpenAI Codex, gpt-5.6-sol, and
reproduced by closing a pty-backed NCI UART while its NCI device was up.

Fixes: 6a2968aaf50c ("NFC: basic NCI protocol implementation")
Cc: stable@vger.kernel.org
Assisted-by: LLM KASAN
Signed-off-by: Shubham Antil <shubham@octane.security>
---
 net/nfc/nci/core.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/net/nfc/nci/core.c b/net/nfc/nci/core.c
index 73e3a96470ac..8ee33505e93a 100644
--- a/net/nfc/nci/core.c
+++ b/net/nfc/nci/core.c
@@ -582,13 +582,15 @@ static int nci_close_device(struct nci_dev *ndev)
 	/* Flush TX wq, RX wq flush can't be under the lock */
 	flush_workqueue(ndev->tx_wq);
 
-	/* Reset device */
+	/* Reset device unless it is being unregistered */
 	skb_queue_purge(&ndev->cmd_q);
-	atomic_set(&ndev->cmd_cnt, 1);
 
-	set_bit(NCI_INIT, &ndev->flags);
-	__nci_request(ndev, nci_reset_req, (void *)0,
-		      msecs_to_jiffies(NCI_RESET_TIMEOUT));
+	if (!test_bit(NCI_UNREG, &ndev->flags)) {
+		atomic_set(&ndev->cmd_cnt, 1);
+		set_bit(NCI_INIT, &ndev->flags);
+		__nci_request(ndev, nci_reset_req, (void *)0,
+			      msecs_to_jiffies(NCI_RESET_TIMEOUT));
+	}
 
 	/* After this point our queues are empty
 	 * rx work may be running but will see that NCI_UP was cleared
-- 
2.43.0

