Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793995953;
	b=L+/vDPiB7OvcUgaUJ3R/22NnJhS7jx4Srl8CBmD4MQgv91yQKzX0TI4OtJwWVTVM/c5S
	 buVIhGT5r4eJBA6CWxI8jijZKu8mhFCIBQ+bTpuLpY2wWBARh8BTlzqOqZi8uz081SaGE
	 Kj0qotdjdqqhE8MrgVtLpixyhNEjHibov2BgtlsxD5YnfZ1wCoIpRLTF2kTdXTdrcC1Lo
	 2XuPrfqZPVPskip77jeRl0vO9qpmOSXf4GnZWsa6FUI7ckMyuR31X+9G92ksGVTcgZbjU
	 sBotfh3zz44tMrKHImdG2J8q4wqfPgTK6xTIWM1dM4afc+63602wicohUGM6z2iTb4A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793995953;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer;
	bh=G0966jd9oypOLtA4E5HN4EPjRdyNLhCliUPsqhp2w6k=;
	b=wIJdJkfSDgZZkSk4pqQ7WqFV70txmzM6G2FbRMJmhAt3/XJp/ubY7AHYp7z5tDKgKVF5
	 nj5Txx4Fbg/3kSpqlgfJ/cvHAWs/AWEyPProSb32FBd6Pz64+yrW/y59kz3KxYpC4EijC
	 R2tCro+sQROcsZJbsEfkZ+MT4SM90ztLK5/4zZ+8e/by21KSUXK53SvvgufyTJXeQGoKy
	 gSUis1D0sWq3hckCIq5BYb6+HL6i/Yk7eZ0Y0+k5Hsh+sEfQOxWXVTa46Pwp3PHUwOpzQ
	 XCfpo4LOl/b6BTxJCOZTlre4OWqgOTtE389tQg6jvFzn1JgQblX9FMzwpeE+x8pfkgw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UAIG9mt4;
	arc=none smtp.remote-ip=209.85.128.172
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92646606D801
	for <netdev@vger.kernel.org>; Fri,  6 Nov 2026 20:12:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 92646606D801
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UAIG9mt4
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-8b312be5de8so10235937b3.2
        for <netdev@vger.kernel.org>; Fri, 06 Nov 2026 12:12:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793995949; x=1794600749; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=G0966jd9oypOLtA4E5HN4EPjRdyNLhCliUPsqhp2w6k=;
        b=UAIG9mt46x59m4rv3c1reUV6ciVNDkZqA5tGUMCWN1p2xY7WyQ83oLqH1GJdS/2HpN
         NEFo+qN7PKu84yT+m+bOjLGdTQUIbjYYG6Rm/TRZDGmIh/0VIsnt0DZdpIIKIxKJAZBE
         cf1mVf0nISw0XZQ+tKOQjM/8qWrjzG5bATeQxBCSySCB7TTOITy9eXa7/GNvh3yMbLRP
         MqZAHpUaFn1Cj2NWvt4uQfaMwAZhB6cT3Ay49dFebpL2jDol6uVhgpvyaM5x3YLCdv3c
         NbHWY5uwHPHhjg6YYGp8+rKmNGHiVhg+JF84zCXbiI4ObmBVrQy7dIpMaf+Zbx/3Ggbk
         PV+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793995949; x=1794600749;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=G0966jd9oypOLtA4E5HN4EPjRdyNLhCliUPsqhp2w6k=;
        b=YTF3UabOxNEo2GOvOVF6stU3Ntfd1UZhJHedp51d3zSj4C3NBAfzIJbOfPJUwxHD5P
         jgEcq/ThVEf1uUH804b+aAUeEVM0Erh+tJ/D55Jf5nbo56NRzORClLRD+nVG3unOYm6M
         hTSYU9weRMQ1mRS+fqRU65dFtKT6JZlBC65IT2+t2sCERpNtXlQ9AIDUu90gHgBE0msd
         8iXEyyAK+gUbOIgYd6wleXXsECUvYfB0jEhP6tn777Sat65PwdBZFH8k66t+9MlMeYz2
         XHKNX3ecqSjqsDYj0PxtxLMSVk1u7Jgpo7sPirQ/U92hcN6qF6cbAoVawljegZ1MXTFi
         pBPg==
X-Gm-Message-State: APuU4Z/SMZMNo8EwILlOxFDxNwwQ7Pohvt5tM6iGObfkVvaIwcMdK6NA
	QXRY8luc59Kkvo3zsnNgsQLTu23RgWkgVh+Q0fR8AWLUH4hLCI+vYhso
X-Gm-Gg: AYBFou3TIhZXYp3+mpeFnsDTYo15Oppx3Gyl/v0QWyvjFYUpheMAr3BL/kxpZe7nYq3
	QMtbUf56EgFcsZOvuEJ6aQa+Xfk0yV1lFXV7wi7p5L1yyompEvHdV4e2SK4wPyErHsslrSLYNlt
	ssCQpqsJSBIeWhWKAFNEoxiTvsIJmver+QlHsBl9Zj9aWXOkFocldGo0SDAYt/3hWsmlV2jRkwY
	M7685jCIBrkmUeC/vtbcdbz1GOeoPfamCI1ruigEIXSIHkfbUQArDS/UZZpEwxqXXlLJZXpoRKW
	Qq6Lth/zFa2I4s/9jFD4ikxhvQ74hVX6QP97bSo5R50IPIg8CswyIt3tWDxR4xV29LcDoBCM/si
	BaUp/uc0/tYmJaeon20xWY5INiC62nFkEcwshV/cpfQIK+UJ6f/ogKUqlaId/x+iL5X4yDdi3bn
	Ddx/HEr6Pn9YPPPhNj/b4a7zegL8vmn7bR1lzDZX4HOCh/qvTOSxNc3ggFm4NB8eZDz2Hwoq25E
	iUgs3rTw9QzZmHeTS/n2aPc4/Z5ydP03+sOXgY1TBFAdPyI4Q9qwJ/SZ3Xb+QX1V7AwSlaVNHyQ
	RiTSJzTkjvNG9YSgiATK+dSNTWM=
X-Received: by 2002:a05:690c:113:b0:8b0:e10d:1975 with SMTP id 00721157ae682-8b3418ffb8emr16421447b3.29.1793995948659;
        Fri, 06 Nov 2026 12:12:28 -0800 (PST)
Received: from localhost ([2a03:2880:30ff:41::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b33f88389dsm26276657b3.40.2026.11.06.12.12.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 12:12:27 -0800 (PST)
From: Daniel Zahka <daniel.zahka@gmail.com>
Date: Fri, 06 Nov 2026 12:12:10 -0800
Subject: [PATCH net-next v3 2/5] psp: support tx rekey operation
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261106-psp-v3-2-a8dd38f5a727@gmail.com>
References: <20261106-psp-v3-0-a8dd38f5a727@gmail.com>
In-Reply-To: <20261106-psp-v3-0-a8dd38f5a727@gmail.com>
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

Drivers that use on-device tx key storage need additional logic to delay
key deletion until after any in-flight users of the key have been
drained, so return -EOPNOTSUPP for now.

Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>
---
v3:
- move the replaced assoc to psd->stale_assocs, so a rotation
  racing with its free doesn't count the socket twice in stale-events
- document that the previous rx SPI also stops being accepted once
  its device key is rotated out
- drop the claim that the peer accepts both the old and new SPI
  after a tx rekey
- document tx rekey in the tx-assoc op doc in psp.yaml

v2:
- place new assoc on pas->assocs list instead of psd->active assocs
  list
- reject tx rekey on SADB devices until deferred tx key deletion
  lands
---
 Documentation/netlink/specs/psp.yaml |  4 ++-
 Documentation/networking/psp.rst     |  5 +++-
 net/psp/psp_sock.c                   | 57 ++++++++++++++++++++++++++++++++----
 3 files changed, 58 insertions(+), 8 deletions(-)

diff --git a/Documentation/netlink/specs/psp.yaml b/Documentation/netlink/specs/psp.yaml
index d5713f5d1af7..f6af1a510d17 100644
--- a/Documentation/netlink/specs/psp.yaml
+++ b/Documentation/netlink/specs/psp.yaml
@@ -283,7 +283,9 @@ operations:
         post: psp-device-unlock
     -
       name: tx-assoc
-      doc: Add a PSP Tx association.
+      doc: |
+        Add a PSP Tx association.
+        If the socket already has a Tx association, rekey its Tx direction.
       attribute-set: assoc
       do:
         request:
diff --git a/Documentation/networking/psp.rst b/Documentation/networking/psp.rst
index fab797506b0a..43f222b38d3d 100644
--- a/Documentation/networking/psp.rst
+++ b/Documentation/networking/psp.rst
@@ -145,7 +145,8 @@ Rekeying
 
 A connection which has completed the exchange described above and is
 in the "PSP Full" state can be rekeyed in place without being torn
-down, using the same netlink calls as in connection setup.
+down. The Tx and Rx directions are rekeyed separately using the same
+netlink calls as in connection setup.
 
 ``rx-assoc`` allocates a new Rx key and SPI, which should be passed
 to the peer exactly as during the initial exchange. The SPI which was
@@ -154,6 +155,8 @@ next Rx rekey, or until the device key it was derived from has been
 rotated out, so packets the peer sent before it learned the new SPI
 are still received.
 
+``tx-assoc`` installs a new Tx key, which takes effect immediately.
+
 A rekey is rejected with ``-EINVAL`` if it would change the PSP device
 or the PSP version of the association. It is rejected with ``-EBUSY``
 if the socket has not completed its initial exchange in both
diff --git a/net/psp/psp_sock.c b/net/psp/psp_sock.c
index c1e38845f08c..d497f41c483e 100644
--- a/net/psp/psp_sock.c
+++ b/net/psp/psp_sock.c
@@ -280,6 +280,53 @@ psp_sock_set_tx_key(struct sock *sk, struct psp_dev *psd, struct psp_assoc *pas,
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
+	list_move(&pas->assocs_list, &psd->stale_assocs);
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
@@ -312,13 +359,11 @@ int psp_sock_assoc_set_tx(struct sock *sk, struct psp_dev *psd,
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

