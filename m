Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 020233C1985
	for <netdev@vger.kernel.org>; Mon, 17 Aug 2026 09:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786957437; cv=none; b=REDM5KzJ8VUFns4e1Wr6YB5iutnZ3n9uGM/hYXGFw1jDO7RCVib17/aRzAVUJiS3mFcrtTow3mHc8pnbUUgT4Ai49csgwz+zUF4OWTE1mj7hISlh/VguhwKzWUKHWKq4FwwV1kFUG2h1sxwTHnc3l1/202e/iE/O9rRcVZddi5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786957437; c=relaxed/simple;
	bh=Wi76+b676gi5CwmFSrQ2Rbh7lqqzbuVqsH1et1C6H+4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jRa0P+Qt7UBjrad0ulAT3+bZgzJ1RFXFTuI+O0vCCs7nXMIy30yis8/w4MPoJm1ClWANdDbIJeVpZiLY47ScKXWfMRaHHlGgjZPIZv68O4wRW69OdfKOG9NdOrwNvzXZxiwnD0sDsuCeEdy1WX4R566r0YTUwNRKqfPX08M1DpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M6eP8Fyb; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M6eP8Fyb"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-8487b7b3fc8so3355692b3a.3
        for <netdev@vger.kernel.org>; Mon, 17 Aug 2026 02:03:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786957435; x=1787562235; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Bc6M5LL0/QfMzxnGdhWWX9AaHyIrA9wlsurO16uLIIk=;
        b=M6eP8FybHURcfdcWhvpHE1f1IxWAwUvk8htgTrli0RSr9ywkhqPRcQ2XCDmY3s8lbV
         6yJqPqQ1nJ2KNd10Yoay38Ylt+vm4xTdBxMICRLMVq57Y2OvzmU9VTuM91qGMxxsI6md
         R+vV+hYEp96OTKjHVCWy3jjPnTh7hcnXEZIJZX3bFS5OksZ2iGaBs8WxUI3aqd4sOg+v
         dl+J+dPkB0Tj03VIL33+exEmZPeun4jOnAqUGQcs0UjdnZEzxaoaAmvtxZzriCkVmwPy
         Wq385h1vWcJQs70xzZWul4lf6+Bdl2Qx/8u8ZDoWhTVCEDUe8NdA7nWEbeFtGP+iYYJH
         x4RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786957435; x=1787562235;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Bc6M5LL0/QfMzxnGdhWWX9AaHyIrA9wlsurO16uLIIk=;
        b=mwIGdxPEGP0oICccKSWUQmOihvlc9JQ0qmO9n5yvLyAu7biEbGyDnv4lTlUFGLAVjl
         2fQI8NWVz3FNibGJHI91x3dN0LdUjtKdpSx1SwMPt+Bz1WtTxYSEttyqmhiNVi3bdBPi
         4/aamZ+5wxOh2hiGVSFetp6QaApG6EYDHgWZS+ffRevkKpQqJbJ3hnSj+7l3zyS3Wihs
         qFoXyL3nvbtmabTbtqDZfM5gqbPjGrvImnQ2gBU6W6/bly0S0JKMrWW7aWFJ+3+hZFEK
         HVoczRmhWHDBiz4fqyGt66sE1PE+nHO5cvUFwYnueSV34Pf2/I999qt6tfNdklVuDv8W
         EYeg==
X-Gm-Message-State: AOJu0YwA1wJ7+7oBDC0MYlKQFF3gmuuTgHBmAL1h2cqYJBGcchsOVzX9
	tgldDcNbSVe7NhMkjdwTw7sIK2f5IjZ8QW0jiuP6S+US+N7QV/0LIU2c
X-Gm-Gg: AR+sD138Nf/H+4qD4UFkPaEu7shKzO33xmHDL39w1GVqw/Smk1zbOdqGaJEAxpgRk98
	cF5arYHczbmi6ji6C9tQklYtcHaReDe9M8gzXM2Kx5kUAaGIuS4/5Sut2oz975ifZTD4ejcLx52
	EDfnvYqBtC1g4nRlRbRR07B+II/94rLsOlhbw9HkDC2I0lBwjVKEsbdn41utpZQD7IuigUnVDoI
	gNOXFkOp/CfJA+wpb7adY0LfraCQcgsp6qenlOWHWWF0PtHmC6IfyI2CvTIIN7KTDJZ9HtW9x1Q
	YL1sMY/IeUx28j0TDCLIh3VwtQarrWEjjFhjUzUssCfGiB+aG9/IjtSC+hFRo/lDkizBsoU+Lmi
	qZeaFDQU/51CTdHLoqID68/HwQpXGClaR87x5QdxNpCXMtnn6+qtXWlLmv08VtEupFKi1+2G63Y
	m4w7v6ei3pefgxiQbZogqLl2G916nBzpC/2yLybustOpzV4UEmyKNgUk1csN0bATOrQ4PREp0Go
	x51RqUqSvA=
X-Received: by 2002:a05:6a00:4197:b0:847:9015:e68c with SMTP id d2e1a72fcca58-84fde1a0dd8mr26074383b3a.17.1786957435242;
        Mon, 17 Aug 2026 02:03:55 -0700 (PDT)
Received: from v4bel.. ([58.123.110.97])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8517d2476easm2342517b3a.42.2026.08.17.02.03.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 02:03:54 -0700 (PDT)
From: Hyunwoo Kim <imv4bel@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
	ncardwell@google.com,
	kuniyu@google.com,
	horms@kernel.org,
	willemb@google.com,
	andrew+netdev@lunn.ch
Cc: netdev@vger.kernel.org,
	imv4bel@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH net 1/3] ipv6: fix request socket use-after-free after IPV6_ADDRFORM
Date: Mon, 17 Aug 2026 18:03:15 +0900
Message-ID: <20260817090319.3897799-2-imv4bel@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260817090319.3897799-1-imv4bel@gmail.com>
References: <20260817090319.3897799-1-imv4bel@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

IPV6_ADDRFORM turns an AF_INET6 TCP socket into an AF_INET one. It requires
the socket to be established, and a listener can get there with
connect(AF_UNSPEC) followed by connect(). Request sockets queued while it
was listening are still there: inet_csk_listen_stop() leaves them in the
ehash, and their timers only drop them while the socket is not listening,
so making it listen again keeps them alive.

A request that arrived over IPv6 was hashed with inet6_ehashfn(). Its child
is cloned from the converted socket and hashed with inet_ehashfn(), so it
belongs in a different bucket.

inet_ehash_insert() locks the child's bucket, warns about the mismatching
hashes, and replaces the request with the child in the request's own bucket
anyway. reqsk_queue_unlink() locks the bucket the request is really in, so
there is no synchronization between the two. Both can see the request still
hashed and both can drop the reference the ehash holds.

The extra put takes the request's refcount to zero too early, so it is
freed while it is still on the listener's accept queue. The listener is
then closed, and inet_csk_listen_stop() reads the freed request and
writes to it in reqsk_put().

Refuse the conversion if inet_csk_reqsk_queue_len() is not zero. Nothing
clears that counter when a socket stops listening or listens again, so it
still accounts for the requests left in the ehash. A socket that never
listened is not affected.

Fixes: 079096f103fa ("tcp/dccp: install syn_recv requests into ehash table")
Cc: stable@vger.kernel.org
Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
---
 net/ipv6/ipv6_sockglue.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/ipv6/ipv6_sockglue.c b/net/ipv6/ipv6_sockglue.c
index b4c977434c2e0a..64fc6127e75332 100644
--- a/net/ipv6/ipv6_sockglue.c
+++ b/net/ipv6/ipv6_sockglue.c
@@ -572,6 +572,10 @@ int do_ipv6_setsockopt(struct sock *sk, int level, int optname,
 					retv = -EBUSY;
 					break;
 				}
+				if (inet_csk_reqsk_queue_len(sk)) {
+					retv = -EBUSY;
+					break;
+				}
 			} else {
 				break;
 			}
-- 
2.43.0

