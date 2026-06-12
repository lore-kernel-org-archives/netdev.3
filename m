Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95B6B3955FB
	for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 04:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781239974; cv=none; b=I7m5FbfNB+WSeGnOsBPiBoe4iKIGQ9dduF/AXewgNCD1LCCvotFZo4vRkibPMlHO0/I6oXONl6EJvrd16SrPaAFHn94+rBWXQCymZj8NzC15xHlKq7DE1FoTFzwikq8EEDHOHp/r2zRP01ywfltd34MExIf33wivujreGsIP3G8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781239974; c=relaxed/simple;
	bh=vY3xbWXpmJfv2OhO+gb5k1OC5My2WhH+Y/j1M6gKkOo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DlPZhVHGgkChn5RJsauLCcUE5LXDQOsuhEJJtD1ZxNBJ9P/PKQ3xwZC/au/kX0jbpB3gk6n5NfZPV+HZDbl68Rlo1JnhuqAX6jfhzVrylngkp14aWmpSrFr7f2WKtI8QGNRoD/VMYkYBkCYWagC4QEEVxvERO7q8ijSDFvPYjBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U8PNRhH/; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U8PNRhH/"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-36b9033d230so367966a91.1
        for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 21:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781239973; x=1781844773; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y+nZnDKFOx91pDYvjVh0Hhda8Rw1ouTmm9qCxw7hHaI=;
        b=U8PNRhH/tZFEIKxnFtAg01a+4nHPnO/6OPe7Rmbu5nNKF74P4GnPzswacolhPzl9sF
         ocwSELbvqZW0A/cMt7jrYUneQSCgn00PT6UmhM+Xb32y2rP4l8JmwJTVpl87iY1Ei0t/
         LzszRFlX5zgj1nn+HN5bDLGzNnZspI9Go8Z3C1GbdKNObt9gMO/3EBqSFcNu3dd5S6Nc
         /MyjXYlxHogzOxNlpZEbPmhQAe7ioFzisIDduNN93v9aEBXbTldYZfXaYEMn+r6DWo+m
         2CmB7q3D0xqUDmIxZlmGEp3DplLJ1vZ21viH+Rp7VekNV/wcERqSyJ1Rojd6sWMYguze
         QHrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781239973; x=1781844773;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=y+nZnDKFOx91pDYvjVh0Hhda8Rw1ouTmm9qCxw7hHaI=;
        b=gfz/Sf/zP/L/67I4Xc+8pJwIqbjXAZ2yGrfW/nmFfheOMCpQqmrG78RDCFv6HAOG/K
         pAQhPZbpfWcm7gOazR4sOQR8/9Ev2YXEqzt0OakoZh1Qauid08UATJSDw6BsMZaaHRek
         8UxycDoCnH4V5U1NQvu8XSW2eHzBRI9LHsLKu2QqhInoaJcG+f7gJ3ZRaUPGxzElWPhm
         zeKp4+kqNWgcA6b7nZTdAfM0CUWbGuam/CsulniR0qL9JMTPINEsWrRYGxqsUe4YzuFV
         RH+orNe6AtFfW6X+IU1Ex1txPENDJorgXcdF4FpR1WxhkPvuuFsOVH/Sk6sTgMjnM5kS
         aPXQ==
X-Gm-Message-State: AOJu0YysG1Zmk3OfafeyiFUZuVIpnkWtYXhyyYatacaErXZuZSF1Ruyf
	lH6fXcQv52RhiGZXWB4+ZsLLSuHi16Wr4nFRqUegvXlDEWr+ZytKRpvAHVcGIPFg1w==
X-Gm-Gg: Acq92OG5BS9p2lR9C8Po2y+MQR3HeR0VhVjICYHNs8JT8AR/g7d7F9wZ5QEELQSJ0jv
	i8lsKs0H1jy2xl/KUCureXpEBDyJGleK62nT8ybAVggbuJZsL350XjRhXNY2MM+oXiQf7ts3kn5
	RnG+I7iGKSHUF6NblSjjx2rpgYmbsb7PhoelFAIdlo1McVQVuq4lLxS/2nqUYZigPzkfPy3esSO
	TT1ufRssRtgVwvZKiK1HA+ITbyD5d7Lf6OcTuUC2xFxxvNsnRlUATHV5mnCmXIaK7WldSjgOxEW
	RxA7uso4lwq7OT5Jp6P8u8X4iCaK5/LpSFBhzfjx6j7lgRlEG+0N0nKOovcm7WbF1fKrP+7l6jk
	ro2kPAx1XHJCygEmQk+iSIsL/auTTJb+SgmODvmrvA5Jj9krH/zx4ZBeOVTrtuNt/AgWy6hDYjV
	IYRbIC6hLm1TCc0nwE2m9kIBTf34BHKiXBEsx/Lr2p2zR2Ao9V0WM4PgXcCc7elojIP8Q=
X-Received: by 2002:a17:90b:2cc3:b0:36b:de66:92c3 with SMTP id 98e67ed59e1d1-379ef747839mr1322790a91.10.1781239972964;
        Thu, 11 Jun 2026 21:52:52 -0700 (PDT)
Received: from raf.tailb4a862.ts.net ([153.124.163.116])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c8661b5b207sm827558a12.5.2026.06.11.21.52.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 21:52:52 -0700 (PDT)
From: Raf Dickson <rafdog35@gmail.com>
To: netdev@vger.kernel.org,
	virtualization@lists.linux.dev
Cc: pabeni@redhat.com,
	sgarzare@redhat.com,
	stefanha@redhat.com,
	bryan-bt.tan@broadcom.com,
	vishnu.dasa@broadcom.com,
	bcm-kernel-feedback-list@broadcom.com,
	bobbyeshleman@gmail.com,
	leonardi@redhat.com,
	horms@kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	Raf Dickson <rafdog35@gmail.com>
Subject: [PATCH net-next v3 4/4] vsock: fold sk_acceptq_removed() into vsock_remove_pending()
Date: Fri, 12 Jun 2026 04:52:16 +0000
Message-ID: <20260612045216.105796-5-rafdog35@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260612045216.105796-1-rafdog35@gmail.com>
References: <20260612045216.105796-1-rafdog35@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Callers of vsock_remove_pending() must also call sk_acceptq_removed()
to keep sk_ack_backlog consistent. Move the call into
vsock_remove_pending() itself to make it automatic and prevent future
callers from forgetting it.

Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Raf Dickson <rafdog35@gmail.com>
---
 net/vmw_vsock/af_vsock.c       | 2 +-
 net/vmw_vsock/vmci_transport.c | 4 +---
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index 24916dd4e9..4a7d6d247a 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -494,6 +494,7 @@ void vsock_remove_pending(struct sock *listener, struct sock *pending)
 	list_del_init(&vpending->pending_links);
 	sock_put(listener);
 	sock_put(pending);
+	sk_acceptq_removed(listener);
 }
 EXPORT_SYMBOL_GPL(vsock_remove_pending);
 
@@ -773,7 +774,6 @@ static void vsock_pending_work(struct work_struct *work)
 	if (vsock_is_pending(sk)) {
 		vsock_remove_pending(listener, sk);
 
-		sk_acceptq_removed(listener);
 	} else if (!vsk->rejected) {
 		/* We are not on the pending list and accept() did not reject
 		 * us, so we must have been accepted by our user process.  We
diff --git a/net/vmw_vsock/vmci_transport.c b/net/vmw_vsock/vmci_transport.c
index c2db016cca..3e6445f4e1 100644
--- a/net/vmw_vsock/vmci_transport.c
+++ b/net/vmw_vsock/vmci_transport.c
@@ -980,10 +980,8 @@ static int vmci_transport_recv_listen(struct sock *sk,
 			err = -EINVAL;
 		}
 
-		if (err < 0) {
+		if (err < 0)
 			vsock_remove_pending(sk, pending);
-			sk_acceptq_removed(sk);
-		}
 
 		release_sock(pending);
 		vmci_transport_release_pending(pending);
-- 
2.54.0

