Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794419282;
	b=usVp1xYVSH34oktl08URG2CTa+t0vSw/Z504XJ4BzXRdJc/irV3q9KuSCHgvZciIGna2
	 RajHh32OPYLwXdyhUn0aCIO4C8xLXhp88DdaKrRzxL39V9WnkUm5fPGwsh9xJj9obb04J
	 7XzcaXQE0BmbiJBMZzE4gQWU/H+/jPDf1d6PiCbFsxMGYzJcX78+tdMVOIfnxPOJrl1h0
	 a4u1d15XkbWkFmpQI70MMJtNv6w6BPnyDXYBVZ6dv2yxzwvRKFLh7B6frVdWJt3Xno+y/
	 5tkOjM7Cyrj2+k1dMlc8DLy4sGT0OyAdk6kKdSgSPpClofF1iIfjVD/tcR3Ge0wAusA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794419282;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=iHEyEjx61i5+KpzynKjMkfGNsZoJzf5A43ccLavLZAI=;
	b=bRZpWaa5uoOrrCaogimjrERbFUL8BBQpIUFAI/eMJzjMTwCt+PhB+q4duESIJyj5GRS/
	 ewJQ2DOl1+BcW7Pwa0q8qy/A8I/5FjSqh84W8csPTgn9LjnZbZtgVZQsYOBG1c/XM1q0v
	 I9A66mIjzn/HGhCDHiD33zCGjg4cCXJ1CO8LzUon8wQiQNnWdloUWn/+sqY0KtrpBR2bT
	 Givn/KHMhXOQY0bHrHrtjuCLyMLRdYdVJbguojiQ5mHsv1PdVbg+wzvjm+Kl9yZk/nemZ
	 ol4CBcTjOLSX4h/gsbWh+I8jNE06PTJu61VDMHzyx8S81lYnrgyMW2iXVQv/3n+zbDw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=D83WIRG3;
	arc=none smtp.remote-ip=74.125.224.50
Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74C0F606A88C
	for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 17:48:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 74C0F606A88C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=D83WIRG3
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-67c6a0abc2eso1181258d50.0
        for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 09:48:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794419281; x=1795024081; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iHEyEjx61i5+KpzynKjMkfGNsZoJzf5A43ccLavLZAI=;
        b=D83WIRG3J/Z+076mzvh/YssO+Jre6Z7MuWj0DlXDwtQsZ2wYkARYNwMoORfVP375VC
         NWqe+5jVeq0bizthE1v7GvtERH2otTKWL6Zj+HaCaC+c6/Uba4hwn14MPXfjzennzNIe
         Kk5I0WV6SBG98chNTcd07LAtSKLPedPvr/Glmq+52cS8ADs3jHk38vGrvzFKVBNDiyze
         om/99G7o82pb2HD584tzROXFbuHLbnqzxE8+FvQ57SDQnl5ouuron6fOZgAls9BHjV2Y
         cRjifjJ9CSYfdE1vaq99GHt0x9+I0j8eIQQdMKgGigGFDny5VCiZE9JAwB+0RxaQgp7f
         cgAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794419281; x=1795024081;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=iHEyEjx61i5+KpzynKjMkfGNsZoJzf5A43ccLavLZAI=;
        b=ztAwRpDfBppb6JDa67Gwv54ik4UiT8qK3f4ZfljQ2E6nJFRltCW4dEgyVuCBlYOrtE
         57O0ymaEsLlfJGhcHcShXBT9g+R/jSirB1fGw8eUJTbboz3XMiTbfwCCAFRntwdC9tOv
         xtJfQT6YS7XjK4+9iZKdOh3dZNb0I5/FY/PrXtoZ9rUurUpSCCQeaxXdBHogglMO3Fdx
         lWQLHoJknpWdwQqzCSzB7NB2lHdOjocmFAlAZYjEQMRb7QrShZU53p0zqxpfwEtQSKp1
         7Vy+Yn1aihvOYEcxIB9eyldcqAOUNjUbZCJgZU0DHtOVfE1erdxySOyMR9snd18tcz3l
         yVkw==
X-Forwarded-Encrypted: i=1; AL+hErFp+PdMviaX/1YWsJ56WMxu5V6WqD1KPW5KiFHUJ0nOQxp9O8CqfmDMtLQocbfVDBcAb6AcuI0=@vger.kernel.org
X-Gm-Message-State: APuU4Z/6CuPI2i4D0T0Y12Ri1zUV1OqYjV1CkTFZCId19IgmR1ge/yBA
	28GIxFHN/R03jRwCVch45wkqvwTS3yWlyjKJ4qGjpECc90PRcib6kzvy
X-Gm-Gg: AYBFou3zn/Np/F3qAwpRzVzWjQAZBtWYe/5EfAsiFL/OFF184U+rWhYGf2PW/R+G70O
	gClOqi9g/Zq4a66OYPidTWvi09HNDRmt9uC2hh05RFvTQ8E5MaS7ow5CSwCTqbb3EhAXs+XsJGX
	9R0Y4UC8Hn+gKTLDgtn4tmQbyVbKTojZX5hCSI8DGrRcdGhF9wFWSBoI+ox7rvWB4zZdCGjhWj5
	O6a4cBI60H8Ftmv4sl4aBYODKYUxiZB36vIu6w254fhky5g3FRyY5tgDWuvAaKTzEoFraNwJ8w4
	JjL9LgxCjk1AI/YDwAleN4r5l6EWRN7n0uzZzHekITz/+ai5v6VOO11QR8FTahDAEAgwwsBu1v1
	28UnKy/F5n5Z/9f/1SFfq/GtoqD5VOPPsEALAg4tQubKRtqFDEEr+og5De3Sj4XS49k+zjBvG7m
	FSOPyqxk54qSZcblts+X1+aOXFwAINTwyw3SYHgWO9LMfpDY84hLHAw1JbNDYRwecTluYq4K5r9
	g7/c3AVK8Ig7v57+5fenRHS3Tc44kLIr0DBYCD88m67nKwN0nB/k4TCWZOdmFSFMWQVbwa6IfwM
	c15hcsGq7qTmrb9WBxzDsfllDwQ9kXv3KewnC7pYPBsUJpEhuLw6SQ==
X-Received: by 2002:a53:bdc1:0:b0:679:a692:630d with SMTP id 956f58d0204a3-67c67ff79dcmr1390972d50.86.1794419281418;
        Wed, 11 Nov 2026 09:48:01 -0800 (PST)
Received: from VPN-156-197.vpn.usf.edu ([2607:fe50:0:f802::4046])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67c589c6f24sm5077708d50.12.2026.11.11.09.47.59
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 11 Nov 2026 09:48:00 -0800 (PST)
From: Juan Agustin Niccolini <juanagusnicco@gmail.com>
To: davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: horms@kernel.org,
	ncardwell@google.com,
	kuniyu@google.com,
	josef@toxicpanda.com,
	jbacik@fb.com,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Juan Agustin Niccolini <juanagusnicco@gmail.com>
Subject: [PATCH net v2 2/2] selftests: net: Add SO_REUSEPORT bind cache test to bind_wildcard.c
Date: Wed, 11 Nov 2026 12:47:04 -0500
Message-ID: <20261111174704.24312-3-juanagusnicco@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111174704.24312-1-juanagusnicco@gmail.com>
References: <20261111174704.24312-1-juanagusnicco@gmail.com>
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

Add a test for the bug fixed by "tcp: Fix the SO_REUSEPORT bind cache
admitting a conflicting socket". With a 0.0.0.0 listener on the port, a
v6only [::] SO_REUSEPORT socket fills the bind cache, and a dual-stack
[::] SO_REUSEPORT socket must then fail to bind with EADDRINUSE.

Without the fix:

  #  RUN           global.reuseport_v6only_cache ...
  # bind_wildcard.c:860:reuseport_v6only_cache:Expected ret (0) == -1 (-1)
  # reuseport_v6only_cache: Test terminated by assertion
  #          FAIL  global.reuseport_v6only_cache
  not ok 1 global.reuseport_v6only_cache

With it:

  #  RUN           global.reuseport_v6only_cache ...
  #            OK  global.reuseport_v6only_cache
  ok 1 global.reuseport_v6only_cache

Signed-off-by: Juan Agustin Niccolini <juanagusnicco@gmail.com>
---
 tools/testing/selftests/net/bind_wildcard.c | 54 +++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/tools/testing/selftests/net/bind_wildcard.c b/tools/testing/selftests/net/bind_wildcard.c
index be3298c791b2..334a0cf87edf 100644
--- a/tools/testing/selftests/net/bind_wildcard.c
+++ b/tools/testing/selftests/net/bind_wildcard.c
@@ -811,4 +811,58 @@ TEST_F(bind_wildcard, reuseport)
 		bind_socket(_metadata, self, variant, i, SO_REUSEPORT);
 }
 
+/* The SO_REUSEPORT bind cache (tb->fast_*) filled by a v6only [::] socket
+ * must not let a dual-stack [::] socket skip the conflict check against a
+ * 0.0.0.0 listener.
+ */
+TEST(reuseport_v6only_cache)
+{
+	struct sockaddr_in6 addr6 = {
+		.sin6_family = AF_INET6,
+		.sin6_addr = in6addr_any,
+	};
+	struct sockaddr_in addr4 = {
+		.sin_family = AF_INET,
+		.sin_addr.s_addr = htonl(INADDR_ANY),
+	};
+	socklen_t addrlen;
+	int fd[3], ret;
+	int on = 1;
+
+	ASSERT_EQ(unshare(CLONE_NEWNET), 0);
+
+	/* bind(0.0.0.0:P), listen() */
+	fd[0] = socket(AF_INET, SOCK_STREAM, 0);
+	ASSERT_GT(fd[0], 0);
+	ASSERT_EQ(bind(fd[0], (struct sockaddr *)&addr4, sizeof(addr4)), 0);
+	ASSERT_EQ(listen(fd[0], 1), 0);
+
+	addrlen = sizeof(addr4);
+	ASSERT_EQ(getsockname(fd[0], (struct sockaddr *)&addr4, &addrlen), 0);
+	addr6.sin6_port = addr4.sin_port;
+
+	/* SO_REUSEPORT + IPV6_V6ONLY, bind([::]:P) fills the cache. */
+	fd[1] = socket(AF_INET6, SOCK_STREAM, 0);
+	ASSERT_GT(fd[1], 0);
+	ret = setsockopt(fd[1], SOL_IPV6, IPV6_V6ONLY, &on, sizeof(on));
+	ASSERT_EQ(ret, 0);
+	ret = setsockopt(fd[1], SOL_SOCKET, SO_REUSEPORT, &on, sizeof(on));
+	ASSERT_EQ(ret, 0);
+	ASSERT_EQ(bind(fd[1], (struct sockaddr *)&addr6, sizeof(addr6)), 0);
+
+	/* SO_REUSEPORT, bind([::]:P) conflicts with 0.0.0.0:P. */
+	fd[2] = socket(AF_INET6, SOCK_STREAM, 0);
+	ASSERT_GT(fd[2], 0);
+	ret = setsockopt(fd[2], SOL_SOCKET, SO_REUSEPORT, &on, sizeof(on));
+	ASSERT_EQ(ret, 0);
+
+	ret = bind(fd[2], (struct sockaddr *)&addr6, sizeof(addr6));
+	ASSERT_EQ(ret, -1);
+	ASSERT_EQ(errno, EADDRINUSE);
+
+	close(fd[2]);
+	close(fd[1]);
+	close(fd[0]);
+}
+
 TEST_HARNESS_MAIN
-- 
2.43.0

