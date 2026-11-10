Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794343540;
	b=4aklEueHKLMbS8lAVA2wr2PR/z/pXKrRZ34CFFleZ+qM6TeTPYpGLrjEy8ZSUwPNfLQb
	 xVrlcOSd4bqUGUmn6t5DbIp4DeVYVExdy3AZ5mZ7+kliTm4JvhFIBACcQIUojmk6fpjBK
	 N0/M6wVm5CVDheCCTRQPCmVoeB3Lsy/yKt03u4W7E8FbV6fZ38/roq5XzE67sIV7SCZMB
	 3a3ZDn7JCsFBkUDBOsVgWGG3Ans4hvCV47ejhvzxm/625SiiC1moImvSQ3sVSMLL1MVJy
	 XulVtMK+utR7OxUlw8bQDPD047OfAefTLVEl+aUY4RKHatoY8abcp7ztn+n2zuk60cg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794343540;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=QS6tIBWeQpAVCHgZ00Ay33RlDxsOh5tAnN1shI1GpNk=;
	b=sCWxEjwiqQ8f+5J8lb9hveZuqfPwWD3KG+dsMJSVcdXG8K/2Npk87FuYUiS9iIF9Hpq0
	 FtkIwTLTgsmqKQW9ooSRrI+aC6k6lfkcnsY6WuTVtO4bW6NZQ5my5UGbWnhaPrilboKa7
	 MTPy4X8SRvDECGmzLxtgoa4SQcIBYd4oZLauvUdzzSKR4JvGe4K97LH/YvspiJrB0vCCU
	 QUVLH7DTaWhGAnb7AHct3ycTWr+OPumpJWVLMcSGbut6E+Hf4oIwlTd/OKCdGaycX21Aq
	 1jVqPNTI3VElqmtY2ePV3ltB2BQKTILOEO7/Qs8i+I+Y2JH5UAobJzCRRYgyw+yLGmQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="jd/wTADe";
	arc=none smtp.remote-ip=209.85.222.181
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02F1F606A320
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 20:45:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 02F1F606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jd/wTADe
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-93e503815adso199137985a.1
        for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 12:45:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794343539; x=1794948339; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=QS6tIBWeQpAVCHgZ00Ay33RlDxsOh5tAnN1shI1GpNk=;
        b=jd/wTADe/IxW5y1Tu8cRX8JzyYPR6XEB6pfxYXD5Zw+BxBSCBuHXoD+f+7/DcNfeVd
         7vQI5eYY++AeurZGed9B4uWy9AB3AkxtPCFei4RYAKcN3/jNPvsqi/YmCysThDqXgq1p
         mF5oIvMenr+c2GTJfYFo/JSgvif83Ss3xwM1lCcZZoTZBKP6vyChtY/KiF0+Vd0wn/ok
         B+vwvt3mBnEvSpN6PMOeFB8EY6d9O/Cnor+cTjAGoxb1LV4+AUAJezS1Wkl8rTY+R5CQ
         vbQGncEwFBUuEUJJeI0IosgrEKsRXgruvnRaBI33+iJbM1lMGOvFQhNuDSrrBXIC9C8o
         4cBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794343539; x=1794948339;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QS6tIBWeQpAVCHgZ00Ay33RlDxsOh5tAnN1shI1GpNk=;
        b=lLtFbocLCAlGyKU8ZXIGg3zuf9W9ZEri1kMeDkRnJv6gaP7iJosgSyoiDbujvcnP1K
         1V+F9mH6L9Jgr1YQsKzlKgn8tgR0feu3hZkveOqDLMQTo5wJ4biWZZO1eQ1/s4i4Zblb
         R1u3pXgFKNhvqryps+a5chZNjlBMgxxs6F2hOgAV5axVosL/+qxffA/H2jQBSZCo0q4S
         7TkByTT4QNs5k2dwAK6S+JGkYQpUKejnB4qEgE9JxSETgG7O6YbZUMXNqVdapf0f4OTB
         8JjZJr7WDBNPuSQ2JECxtx/S3kTU9HG93UytjlpAjQ6mdZzTN2oRvSfQiCdKYGQgIMQq
         FjkQ==
X-Forwarded-Encrypted: i=1; AL+hErGB218AY2KqPr2aKWp9TJVDLP+pNnLG/D+7FrxiXzuS0CVmIvN/mL/pROjBCIh6RserveJRHas=@vger.kernel.org
X-Gm-Message-State: APuU4Z8fv4T1BGHT8qhOBSgXZiYD7d8RZD971roZptBX3jSIq5wIhJbW
	Ao0Q/1rpgO/X2wgTd6EuIP4bEQMiS4CWMR18YE1SUq+0xvIZX2wyGfag
X-Gm-Gg: AYBFou1FzJEaX+wqSn+W5b1ivzkT5bCuTqoVQBus3b8AdJL53fEURjX06Ltc9ILpEiN
	KN6F+BQKi5BNMGVfPqyG2v/zOOfsdwGlX3wr46YOWT/BKrOk+kORIfXOAjCjeeoZJLbLdmn0MVb
	o+JB1XOUb1xtCPnUp5Y6sAfctz4usntxnpw/J635f9wCFzT19lRjMpxozDwYd8P1i6HJdaq5m1b
	E9qrUc6/V5xINu4cqiAOL9AjqeTplSEXPCNhXqcyIJIAqdnG5i9m0iMtzDXGlcxGkD2v0x6GYQA
	lnfqbRfG4PU8bvMIPQJmrx7h57c44A/QzCCfG0Z0gR4EIFtu/A5bkaPJDdu2xjZk6Vi3nf0Vv9D
	UBLjNa6axOP+93cpr15D505ZUEpiYUMxCt9evjFw/cb1OU/rl6+OpnnoZf+pMa/4rY7sgAEP6wM
	6v6u9VG0+sP6AF02m2fwvElFecof01fwrgcSiACWew2C021UsrAvMJOP194Dfhnm4fXv8w+/r30
	C6PNsLJeqIKZzlYNhCaZgxkBSuLK9wMm7FNNDOveAiT96nHGTp92OgFnFMPF+UpOCCachPiMoRM
	3kuO+C5eA1PMHQl4wdMbckK4H5kdbEfxZmGPtEHy7dZ8q90Q6AgpgO/vaFeNEPOTK0rDF5pCZKs
	63eV62K8QGbtUDk1FKHYqo40yBHSE7pp51cHSvrc+eEuypi4=
X-Received: by 2002:a05:620a:1b94:b0:947:832b:5527 with SMTP id af79cd13be357-947b003f9b6mr20573885a.42.1794343538943;
        Tue, 10 Nov 2026 12:45:38 -0800 (PST)
Received: from localhost.localdomain ([2601:140:9000:ea70:4d94:8f0c:83a0:5c76])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91f02fcc4b7sm5204076d6.44.2026.11.10.12.45.37
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 10 Nov 2026 12:45:38 -0800 (PST)
From: Ethan Ferguson <ethanf108@gmail.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Willem de Bruijn <willemb@google.com>
Cc: Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ethan Ferguson <ethanf108@gmail.com>
Subject: [PATCH] net: remove CONFIG_NETDEVICES requirement for SO_BINDTODEVICE and SO_BINDTOIFINDEX
Date: Tue, 10 Nov 2026 15:45:24 -0500
Message-ID: <20261110204524.82341-1-ethanf108@gmail.com>
X-Mailer: git-send-email 2.54.0
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

The SO_BINDTODEVICE and SO_BINDTOIFINDEX sockopts return -ENOPROTOOPT
if CONFIG_NETDEVICES is disabled, even if the lo interface exists. I
believe it would be prudent to allow for valid bindings even if
CONFIG_NETDEVICES were disabled, as an error here would be inconsistent.

Signed-off-by: Ethan Ferguson <ethanf108@gmail.com>

---
 net/core/sock.c | 56 +++++++++++++------------------------------------
 1 file changed, 15 insertions(+), 41 deletions(-)

diff --git a/net/core/sock.c b/net/core/sock.c
index e8551df8330f..d2da59700ecf 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -634,18 +634,14 @@ EXPORT_SYMBOL(sk_dst_check);
 
 static int sock_bindtoindex_locked(struct sock *sk, int ifindex)
 {
-	int ret = -ENOPROTOOPT;
-#ifdef CONFIG_NETDEVICES
 	struct net *net = sock_net(sk);
 
 	/* Sorry... */
-	ret = -EPERM;
 	if (sk->sk_bound_dev_if && !ns_capable(net->user_ns, CAP_NET_RAW))
-		goto out;
+		return -EPERM;
 
-	ret = -EINVAL;
 	if (ifindex < 0)
-		goto out;
+		return -EINVAL;
 
 	/* Paired with all READ_ONCE() done locklessly. */
 	WRITE_ONCE(sk->sk_bound_dev_if, ifindex);
@@ -654,12 +650,7 @@ static int sock_bindtoindex_locked(struct sock *sk, int ifindex)
 		sk->sk_prot->rehash(sk);
 	sk_dst_reset(sk);
 
-	ret = 0;
-
-out:
-#endif
-
-	return ret;
+	return 0;
 }
 
 int sock_bindtoindex(struct sock *sk, int ifindex, bool lock_sk)
@@ -678,15 +669,12 @@ EXPORT_SYMBOL(sock_bindtoindex);
 
 static int sock_setbindtodevice(struct sock *sk, sockptr_t optval, int optlen)
 {
-	int ret = -ENOPROTOOPT;
-#ifdef CONFIG_NETDEVICES
+	int ret, index;
 	struct net *net = sock_net(sk);
 	char devname[IFNAMSIZ];
-	int index;
 
-	ret = -EINVAL;
 	if (optlen < 0)
-		goto out;
+		return -EINVAL;
 
 	/* Bind this socket to a particular device like "eth0",
 	 * as specified in the passed interface name. If the
@@ -697,9 +685,8 @@ static int sock_setbindtodevice(struct sock *sk, sockptr_t optval, int optlen)
 		optlen = IFNAMSIZ - 1;
 	memset(devname, 0, sizeof(devname));
 
-	ret = -EFAULT;
 	if (copy_from_sockptr(devname, optval, optlen))
-		goto out;
+		return -EFAULT;
 
 	index = 0;
 	if (devname[0] != '\0') {
@@ -710,16 +697,13 @@ static int sock_setbindtodevice(struct sock *sk, sockptr_t optval, int optlen)
 		if (dev)
 			index = dev->ifindex;
 		rcu_read_unlock();
-		ret = -ENODEV;
 		if (!dev)
-			goto out;
+			return -ENODEV;
 	}
 
 	sockopt_lock_sock(sk);
 	ret = sock_bindtoindex_locked(sk, index);
 	sockopt_release_sock(sk);
-out:
-#endif
 
 	return ret;
 }
@@ -727,42 +711,32 @@ static int sock_setbindtodevice(struct sock *sk, sockptr_t optval, int optlen)
 static int sock_getbindtodevice(struct sock *sk, sockptr_t optval,
 				sockptr_t optlen, int len)
 {
-	int ret = -ENOPROTOOPT;
-#ifdef CONFIG_NETDEVICES
-	int bound_dev_if = READ_ONCE(sk->sk_bound_dev_if);
+	int ret, bound_dev_if = READ_ONCE(sk->sk_bound_dev_if);
 	struct net *net = sock_net(sk);
 	char devname[IFNAMSIZ];
 
 	if (bound_dev_if == 0) {
 		len = 0;
-		goto zero;
+		goto copy_len;
 	}
 
-	ret = -EINVAL;
 	if (len < IFNAMSIZ)
-		goto out;
+		return -EINVAL;
 
 	ret = netdev_get_name(net, devname, bound_dev_if);
 	if (ret)
-		goto out;
+		return ret;
 
 	len = strlen(devname) + 1;
 
-	ret = -EFAULT;
 	if (copy_to_sockptr(optval, devname, len))
-		goto out;
+		return -EFAULT;
 
-zero:
-	ret = -EFAULT;
+copy_len:
 	if (copy_to_sockptr(optlen, &len, sizeof(int)))
-		goto out;
-
-	ret = 0;
-
-out:
-#endif
+		return -EFAULT;
 
-	return ret;
+	return 0;
 }
 
 bool sk_mc_loop(const struct sock *sk)
-- 
2.56.0

