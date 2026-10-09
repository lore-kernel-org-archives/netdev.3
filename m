Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76EAE3E0C67
	for <netdev@vger.kernel.org>; Fri,  9 Oct 2026 20:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791578823; cv=none; b=GWc9UmSOiXN3y/OEYnGb/Xb7tCQ74BZrdvz8TCDtL7EkjoXMy/NaLoMEnZO37sPzSxjUiwdEnDJEopjzgeuiZ3QQO5SGRnaDQ21Mhb15HkqdEF7Y6dAe79XaaOZUPgx87oByEZ8g3IF2EudjsyTw84OHDDFf9EYGKK6qhAzVHqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791578823; c=relaxed/simple;
	bh=/MkVzxqhoTILE/yMZ7RqWDU9ruvMLz2NwY+R/gEk0w4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=n0ZwisR8gzueeKTAozVkfkNpR0D7IS6crZTBOGEx48c6G4NFEjv3Azn8VZavJoPG3Kwq5sudrPTWROFP2HKdsriMz40bc3gxaGLJ+SpdsxBTJfqJtTbNrMSckSYlu/QFPwg05ZPgCWlaJmQecp+wYV0vNZfhfhEe0OsbxL/UKt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rg8HnQ3I; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rg8HnQ3I"
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-8252259f6d2so133992a34.3
        for <netdev@vger.kernel.org>; Fri, 09 Oct 2026 13:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791578820; x=1792183620; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NrwYVw70TMJpTrLOs+TyTJTX5+f87OlQglzmhc9yKKw=;
        b=Rg8HnQ3IhnqK1T5E6Hb/22QSHZJC4dOJAA6P7qUCnHU2v51sX2+E3KyciQyKA1wcRm
         3FuX52PS0R1CJK3stXV9sJ+shxxAWTOWZGu85WFhMVF92+pPUAR22PE2uWiZiEuJMIyj
         hmIveZZ0FgkldsB87QpfZ0f2Y+IP/rsfmythTt49WOjNJW1/G52c7//HOR0CDhsdcVK+
         cLs78+1sXNQh0gaOxqo0+nFNWT1829NBRysO65TAkXCr+nEIsrXQl9EG6sbBd423DMql
         ruQ6P/dDWI1YjNGupJ6mmEcazQaJ47+2JPj7+J5bb0kY5fHWH86/Z3bkNtCPbT6o5FML
         9Kvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791578820; x=1792183620;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NrwYVw70TMJpTrLOs+TyTJTX5+f87OlQglzmhc9yKKw=;
        b=ha8YvLUL2YGKbi1YUxWsVmbjwI+AHTdPg9MnNWAURiIvFtiOAdma/NGxo2/uHHSTW1
         y0eWRgjX9k+6lY9oUc1Wr+GViDSv7AOyk9evGP3NxYWrZK/tnrhh4cKsm9IHkkjSVm4b
         LYkqe22KwoHjhmd22LQyx2hRqMv318Ld3FLSAGiZE6q30zUpFfZxIz++TAYfMVKMgWbl
         LyHPRoiwebGkFT4/ef9ax5ECpz2D/da6UiiC9AtIshEA5+2tagsoeoqGhhwW8W6Lt/xE
         btmwEyoNqZ/5mrTAvZzgy3eM9u863USrSKM9G8vvKuRp8kqST862hRx5+QQodrvAqXTq
         EADw==
X-Gm-Message-State: AFuF++nIumueVqOKW61Vjn0N4qNfguj+Lm7M40aBdg5nQ02wSNliu4cs
	2ZhW5WLxT5g6NSSzKGfSc0TshaUlZpc8P9cAHSU3I403lXtc82LjfgYC
X-Gm-Gg: AYBFou1erQA9+HAzjwqA0ZEJ+KT3obgP2CQ2eelOTbrKWCvK1unWugE8vLfNu/0TeOS
	z7h4bwpI4DMus/L3x6jYAsWFnJ1qi2bIL/mVgtpHH8ZkKvKuz2+mj8IYrzaa2oLjr/aQJdE/v8H
	xn1j49smQsZkzLaxjpChiONpX11Tv6x/oDhDYR0yOm22xZb6sqmacdKilH1ugb0JCCoBfzmv+l+
	p1JbsZ+IlXyvl35QXs7kwJrlnzA8ZsT/a8wsKvuVlmMwHVPm/6znWHvMT+PsHiDx/zYg+e/ki3Y
	GiQggxD/O8Nqalr29sNzvV5h/aqerXRM9EjcACHqeJUfNvb4VCnckH+uuj2VUN6bQ/KsABrsn5q
	rG/63bpFgauYr1YtSuuvGgvt+zrRwYAz5wvoj07nl3sKIlnOrv7/X1XzlXxJGpiN9VS5sL61ILY
	3uR+Ed9zYOl3iQpVSqbgernn3bfPZlAvrkI3+TYyUl5/PjB+1JUmk21gA29yUODNuCLQ4=
X-Received: by 2002:a05:6830:2107:b0:81f:6e05:c1aa with SMTP id 46e09a7af769-83096fa8197mr2863274a34.18.1791578819976;
        Fri, 09 Oct 2026 13:46:59 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:7::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-8303a328dccsm2851289a34.22.2026.10.09.13.46.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 13:46:58 -0700 (PDT)
From: Daniel Zahka <daniel.zahka@gmail.com>
Date: Fri, 09 Oct 2026 13:46:42 -0700
Subject: [PATCH net-next v2 2/7] psp: support tx rekey operation
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261009-psp-v2-2-5596ab50f677@gmail.com>
References: <20261009-psp-v2-0-5596ab50f677@gmail.com>
In-Reply-To: <20261009-psp-v2-0-5596ab50f677@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>, 
 Donald Hunter <donald.hunter@gmail.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org
X-Mailer: b4 0.13.0

The tx rekey operation creates a new psp_assoc with the same rx state,
but with new tx state. The new association is spliced into the socket
with RCU to be used immediately in the tx path.

Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>
---
v2:
- place new assoc on pas->assocs list instead of psd->active assocs
  list
- reject tx rekey on SADB devices until deferred tx key deletion
  lands
---
 Documentation/networking/psp.rst | 26 +++++++++++++++++--
 net/psp/psp_sock.c               | 56 +++++++++++++++++++++++++++++++++++-----
 2 files changed, 74 insertions(+), 8 deletions(-)

diff --git a/Documentation/networking/psp.rst b/Documentation/networking/psp.rst
index 0f9b6b73f244..5c4e4215d906 100644
--- a/Documentation/networking/psp.rst
+++ b/Documentation/networking/psp.rst
@@ -140,14 +140,36 @@ The PSP assoc state of a socket is not reset when the connection is
 torn down. ``connect()`` on a socket that has PSP assoc state will
 return ``-EINVAL``.
 
+Rekeying
+--------
+
+A connection which has completed the exchange described above and is
+in the "PSP Full" state can be rekeyed in place without being torn
+down. The Tx and Rx directions are rekeyed separately using the same
+netlink calls as in connection setup.
+
+``rx-assoc`` allocates a new Rx key and SPI, which should be passed
+to the peer exactly as during the initial exchange. The SPI which was
+in use before the rekey remains acceptable on the socket until the
+next Rx rekey, so packets the peer sent before it learned the new SPI
+are still received.
+
+``tx-assoc`` installs a new Tx key, which takes effect immediately.
+The peer will accept data encrypted from the old and new SPI.
+
+A rekey is rejected with ``-EINVAL`` if it would change the PSP device
+or the PSP version of the association. It is rejected with ``-EBUSY``
+if the socket has not completed its initial exchange in both
+directions.
+
 Rotation notifications
 ----------------------
 
 The rotations of device key happen asynchronously and are usually
 performed by management daemons, not under application control.
 The PSP netlink family will generate a notification whenever keys
-are rotated. The applications are expected to re-establish connections
-before keys are rotated again.
+are rotated. Applications are expected to rekey their connections,
+as described above, before device keys are rotated again.
 
 Kernel implementation
 =====================
diff --git a/net/psp/psp_sock.c b/net/psp/psp_sock.c
index b5887171c84e..060149f3d72a 100644
--- a/net/psp/psp_sock.c
+++ b/net/psp/psp_sock.c
@@ -283,6 +283,52 @@ psp_sock_set_tx_key(struct sock *sk, struct psp_dev *psd, struct psp_assoc *pas,
 	return err;
 }
 
+static int
+psp_sock_tx_rekey(struct sock *sk, struct psp_dev *psd, struct psp_assoc *pas,
+		  struct psp_key_parsed *key, struct netlink_ext_ack *extack)
+{
+	struct psp_assoc *new;
+	int err;
+
+	if (psp_dev_has_sadb(psd)) {
+		NL_SET_ERR_MSG(extack, "Tx rekey not supported on this device");
+		return -EOPNOTSUPP;
+	}
+	if (!pas->peer_tx) {
+		NL_SET_ERR_MSG(extack, "Socket PSP state is not fully established");
+		return -EBUSY;
+	}
+
+	new = kzalloc_flex(*new, drv_data, psd->caps->assoc_drv_spc,
+			   GFP_KERNEL_ACCOUNT);
+	if (!new)
+		return -ENOMEM;
+
+	new->psd             = pas->psd;
+	new->dev_id          = pas->dev_id;
+	new->generation      = pas->generation;
+	new->version         = pas->version;
+	new->peer_tx         = 1;
+	new->prev_spi        = pas->prev_spi;
+	new->prev_generation = pas->prev_generation;
+	refcount_set(&new->refcnt, 1);
+	memcpy(&new->rx, &pas->rx, sizeof(new->rx));
+
+	err = psp_assoc_set_tx(psd, new, key, extack);
+	if (err) {
+		kfree(new);
+		return err;
+	}
+
+	psp_dev_get(new->psd);
+	list_add(&new->assocs_list, &pas->assocs_list);
+
+	rcu_assign_pointer(sk->psp_assoc, new);
+	psp_assoc_put(pas);
+
+	return 0;
+}
+
 int psp_sock_assoc_set_tx(struct sock *sk, struct psp_dev *psd,
 			  u32 version, struct psp_key_parsed *key,
 			  struct netlink_ext_ack *extack)
@@ -315,13 +361,11 @@ int psp_sock_assoc_set_tx(struct sock *sk, struct psp_dev *psd,
 		err = -EINVAL;
 		goto exit_unlock;
 	}
-	if (pas->tx.spi) {
-		NL_SET_ERR_MSG(extack, "Tx key already set");
-		err = -EBUSY;
-		goto exit_unlock;
-	}
+	if (pas->tx.spi)
+		err = psp_sock_tx_rekey(sk, psd, pas, key, extack);
+	else
+		err = psp_sock_set_tx_key(sk, psd, pas, key, extack);
 
-	err = psp_sock_set_tx_key(sk, psd, pas, key, extack);
 exit_unlock:
 	release_sock(sk);
 	return err;

-- 
2.52.0

