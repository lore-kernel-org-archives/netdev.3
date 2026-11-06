Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793956519;
	b=b3EC7uPliHwAcmyv1WGZ5Z3iiTSaZWGZkasZhUXuXAuNauJJjCDmk0WWXwEC4w6aSiWs
	 piu4HE5zGSTBCoaHRa4GBLuCLwbuDMuzVfXPdQ1wRlCy/c6EpfxjN/7JMltX9quyeFkQr
	 t/zM3565/VGodvrVtAg5rNHnDcIPzZz0t/nYOvVeyARDaG+/N/Qmr0RAslR56ubwzrQoU
	 j5olLcjEvNcefSRNvGpbdWtVYXyh/wNkU3ql/K/wZCvaKr+Yr7qAUQw70r4kYy4YlC2Ik
	 o6p0XKYbL1+m9BSF0Mp9GIBAtMWvmE+6F5IbDlOYafuEulZ/FSpOLtK3UGe6GiQmfDw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793956519;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=sBA7R3KwCKs67deoscBxKKJpdFiLzz2bzb+Httq0mxk=;
	b=yss/gv3rYUOILhM67KGv9O4R+QjEwx4TcmeaMgc7Bh1LrHt6WXX0ES1qM4+F6HtagbAv
	 RnzC88ng+gqCBxne7HHtUhfDvRdwS3gAyQx+3Y4C17uKtdgpTXivYTxS1TEdMyvpYQR86
	 Wzdf7dmPRtpv74aK8yaOFHmMW3Idtmjj7ajBYTh/CFvwfJEOkATYgVZ8L+q9rDxVpAkib
	 o3UQse3Lrm/z+d5deh2EpTQxYbsm2YQnnB6w/kggiNX1oHJjfdON1EQhDjTKCF25yVjLb
	 cuFQ4r6X/5vPvM0c2HbHveVrE4OhqGX6JWZGCh7kIy1UN9KZ3jrLEWCl0Ddn5Hw59zQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fVK+rjQL;
	arc=none smtp.remote-ip=209.85.214.173
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22121606A329
	for <netdev@vger.kernel.org>; Fri,  6 Nov 2026 09:15:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 22121606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fVK+rjQL
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2e8da6ef7ddso2196965ad.3
        for <netdev@vger.kernel.org>; Fri, 06 Nov 2026 01:15:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793956518; x=1794561318; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=sBA7R3KwCKs67deoscBxKKJpdFiLzz2bzb+Httq0mxk=;
        b=fVK+rjQLmuRatRUthdbjrbLWL9QeAbzlIs0OEq32iO/yO9Zx4O/yBW45UBCupAcP2A
         JG618ID9n8e7JyrIQByiHeGj/yklgQSZCjVUcZvIku7sAiyLEFjQAHQwerCmfFFa1tHm
         YATCSoHa7cK4VkgcDPwEikOI8nQ5/A95j9lNm7fl4vJ8F6EbLxmrg83aPyYTYChacTYb
         77bmwZ1duiA3cX7k8FCSNJHXTPeS+FYc91ZhQPnWFn261fo8cXsYken/J1d7WiHrKdWy
         DZV7rd9Dcvcx1jyBaYr4UfMWWg+gq9sVrBJcEWz/ymTNIFzOsKXi53OhnZ5ZprgSEg7Z
         IyOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793956518; x=1794561318;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sBA7R3KwCKs67deoscBxKKJpdFiLzz2bzb+Httq0mxk=;
        b=lSJb/b+9iQrU+L+tLYVQtF3zFnnbArKrXWK47oyXbByU0FFzFY9ZaecDni730450s3
         LaG4Qb+jFfave1zOhmIaAZ/A0ojpYSFU5yS7rd3pmBmYoOkCY895oS7T3Wzb4hWdzUFm
         wpQ21T/DYZG+UWkewbXKvZW0OfbpgljH8ZmQLAbEbp8MUvSvYJiEWmVw5IgBNw38JWm1
         JrGJyng2XM5oE0obv1DPstfCVFWpnykbrGPaMt0rc4szGPH1UGZvYvOWOV9vCCpNRbqt
         dD7Zvo6J6lKbrNIj02mD2WTU9rhPlPaQQ+fwGSaLofHg+L3jPZiq0CfExBO7LBWth/Cc
         32mg==
X-Forwarded-Encrypted: i=1; AL+hErHsgYSfjCL/z57knREbZeGEPSGDkVNvAQ++vOmN07yZGqV5MntTDmNIcStvIjDztPpo+rqoHSo=@vger.kernel.org
X-Gm-Message-State: APuU4Z9Ke7o3FN1W0lKb7m2lVMTVXqrLT6GrtGGXmT0NEAlTik+SZOpQ
	rjDmuDrNYn1pFnFeQz+fLjRXAOMXnWkZzuLcLPzh6mNNQI+Hb+GN5hhv
X-Gm-Gg: AYBFou1GTO2nmxT6BAbTcuEtHI4VojmJNeb1vasgT1b17T0jn61sellk8Nd5FAFb+G4
	M3/QoBBkdcThTbF8blHD5EP6GQwCoMVd7zMk6L2kdG8u0fdkQTTZtI07ti7TR4hxCL3Dl8EuXx6
	fP/9befywIiJq/jRvfL3rozDMxgfO24yKMrfRMFtz6eICchqA+k0Id206Xuzl+eFw8H71X+utxK
	gzyC2m8XQf90Jgv6fBHQLiUKZjvhkRyHtomDSo6DxZFb+44jWZUkojjFopRlXVqudkgOLbhYdks
	U5dKDshvQ/tBSugWHZE0BhacAqqcQe1jXPRtE8IKTX1DmhZ6SzLd595H1NTeDDeSj8hHDRt2Xs1
	kRYRpWLmXuubGtZgJ89BQUyioU9GBPvn3AlcQMPm2dIausoBoOFiOmyc68gOYLtmdN7GY5tPFkb
	AX0CSPr157RvrcA8d7+ugELsj9FRWrtODw8CYDXyc8sCWNoOklw2RBmEZ8xuT9PcqXshazSYnwT
	qVT/Grrc3kEQB1P1Yheay+gglOLBIRosZ9j+mFBLx9iS2ZaNf0NKxTRXeY3MwqQR2E3bQ1vQ1Q2
	4/iSVLRBpD7dgt4drlQmG09/JdoU0cq06ye9urIm15T9VQyDjIE2x1KQwmu3vcayR9c3z8E4wpc
	KmN7ioKIqQN3JiXs=
X-Received: by 2002:a17:903:26c6:b0:2ea:1016:27fb with SMTP id d9443c01a7336-2ed40ad43c4mr26365945ad.13.1793956518024;
        Fri, 06 Nov 2026 01:15:18 -0800 (PST)
Received: from JUNVYYANG-MC1.tencent.com ([43.132.141.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ed47d40d91sm3564815ad.28.2026.11.06.01.15.14
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 06 Nov 2026 01:15:17 -0800 (PST)
From: Jun Yang <juny24602@gmail.com>
To: steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au
Cc: davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	nakam@linux-ipv6.org,
	shinta.sugimoto@ericsson.com,
	yoshfuji@linux-ipv6.org,
	netdev@vger.kernel.org,
	Jun Yang <junvyyang@tencent.com>,
	stable@kernel.org,
	TencentOS Corvus AI <corvus@tencent.com>
Subject: [PATCH net] xfrm: hold migrated state references through xfrm_migrate()
Date: Fri,  6 Nov 2026 17:14:27 +0800
Message-ID: <20261106091511.45429-1-juny24602@gmail.com>
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

From: Jun Yang <junvyyang@tencent.com>

xfrm_state_migrate_install() transfers the cloned state's allocation
reference to the state table. xfrm_state_migrate() returns the state
without a caller reference, and xfrm_migrate() saves it in x_new[].

If a later migration step fails, xfrm_migrate() deletes those states
during rollback. A concurrent deletion, for example from the expiry
timer, can drop the table reference and free a state before rollback
calls xfrm_state_delete().

Take a caller reference before installing each clone. Drop it if
installation fails, after a successful migration, or after deleting the
new states on rollback.

Fixes: 80c9abaabf42 ("[XFRM]: Extension for dynamic update of endpoint address(es)")
Cc: stable@kernel.org
Reported-by: TencentOS Corvus AI <corvus@tencent.com>
Signed-off-by: Jun Yang <junvyyang@tencent.com>
---
A KASAN reproducer for this issue is available if requested.

 net/xfrm/xfrm_policy.c | 7 ++++++-
 net/xfrm/xfrm_state.c  | 6 +++++-
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
index 9ea60c7717ff..06aa036701c3 100644
--- a/net/xfrm/xfrm_policy.c
+++ b/net/xfrm/xfrm_policy.c
@@ -4726,6 +4726,9 @@ int xfrm_migrate(const struct xfrm_selector *sel, u8 dir, u8 type,
 		xfrm_states_delete(x_cur, nx_cur);
 	}
 
+	if (nx_new)
+		xfrm_states_put(x_new, nx_new);
+
 	/* Stage 5 - announce */
 	km_migrate(sel, dir, type, m, num_migrate, k, net, encap);
 
@@ -4740,8 +4743,10 @@ restore_state:
 		xfrm_pol_put(pol);
 	if (nx_cur)
 		xfrm_states_put(x_cur, nx_cur);
-	if (nx_new)
+	if (nx_new) {
 		xfrm_states_delete(x_new, nx_new);
+		xfrm_states_put(x_new, nx_new);
+	}
 
 	return err;
 }
diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
index e45aa1ed5b96..aa97acaacd64 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -2220,8 +2220,12 @@ struct xfrm_state *xfrm_state_migrate(struct xfrm_state *x,
 
 	xfrm_migrate_sync(xc, x);
 
-	if (xfrm_state_migrate_install(x, xc, m, extack) < 0)
+	/* Keep a caller reference after installation transfers ownership. */
+	xfrm_state_hold(xc);
+	if (xfrm_state_migrate_install(x, xc, m, extack) < 0) {
+		xfrm_state_put(xc);
 		return NULL;
+	}
 
 	return xc;
 }
-- 
2.43.7

