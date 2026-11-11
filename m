Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794437517;
	b=cN+6e/BJPkKZnQSqjsqpkjgdLH6kjxxJ1u6RshYt41p9ezvyxoHP+jSE1pJK3jldMvyy
	 4dcw11wkji1FJ/iHiNTlu7PG/s4qChk5l3IvUY1Nj9RpZQU8/ckRvVUmWPMQKY2NNkQ5I
	 kxGkMhNRwelfzyRgnCz2R4GiOb/UDrJQrlXB58FhqHEAXxuPB8PY2XeyzzC90620OQ0hv
	 yrt6vsFXqpIXqlMWUnd+ERZmU6QK97/c8GggDQGEDAdJ/qhXtQv6yZBQ3KN6IIojW9kuF
	 YvO9OE0+HSKY0RvuHTIWgbAcQMccPWesVmaitW8l4AF0y3AKN9AQZJeJn0osFdaizeA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794437517;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=6/vhofawT2SU6SgpF8OfaiGs0g+T9Ie9hyxAqVetXP4=;
	b=sSfwiCHmB5c4gWanPD41cJ/IR0XgnBB/jE5yEw+qYhCZtuAT95af7Pc1Ghrh1UIUF8xT
	 qo1odsqetkJBzlaXhJiZK+EGWOPYIyXIHpNQ07adHyPRPgGRCp1A9ov/Y+2ktMiw30Gmz
	 vOZvva+QRIr8EsaLOdCDPhotaLRVQiBNZUX6I4YkNH0pk01geo4mpCA7ueMsR1lImlMwh
	 2tqYUEhrAQTe5VzyMvwwymy9IqGXbfgeRghLkcXq7SVkn4cw70WuAlxH6CKsecm3Pr7LK
	 6k83is2CNJna7POncPcR1c2w6xDj2FqakbpvQVV/E+8QEh8UhPQgRlM88U++mG+bLqw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=S7Ljy7R6;
	arc=none smtp.remote-ip=209.85.210.175
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD2FC606AECC
	for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 22:51:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DD2FC606AECC
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=S7Ljy7R6
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-8b600fae14dso1408780b3a.2
        for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 14:51:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794437516; x=1795042316; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6/vhofawT2SU6SgpF8OfaiGs0g+T9Ie9hyxAqVetXP4=;
        b=S7Ljy7R6P0pvsFfplRx8vmeSpwWlYryM2KtPN8g7PAd3MCWx0eHXmJwVwSCamyDoHo
         fY+A2Pc7gE2AWzo6Fy4uYb0L+DcX9VTlaEcA9lvfLYNO3Zud7lz7jLkxoAQH5SoZhoW1
         9TRDOIkH84I+Eue2lfJ2SETleTqSKo7htEsiPEkUKfejquFQ+N8b4qzki3DUnGoAJ5YB
         sbP69DPZTRGLBpPuKqxlEfL8qFfhykJQOR2byVPX9tcbW3xJFWg4f81Wa6rmf67sJ/tW
         LU/2X+S0/uXHYcegzexiwyYUGSq12JkrbocXZcNUesxt3R3E8nBFIQKey5IUdg8+P8Co
         iirg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794437516; x=1795042316;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6/vhofawT2SU6SgpF8OfaiGs0g+T9Ie9hyxAqVetXP4=;
        b=uBe+cP+Py7s+ii45YZmDayWO3tZjyAhdPgHT46ML0zM5HvYdnTwN0cBQKeBGsT4ZpR
         /CYoe2YR4WnLcUqh/TmC7kVJGDpyvDQPPti9D5VjfINNcPVOAXb0ccUXNybaeOK5KNTC
         w3WFyPhRonNVDHu2UucZxWkKB1kxvxHiaJWAk6d9RSRmFUHFsBv18p6VpWVwBeNCkM3V
         7pU0/y/8AWzdbXiQxyZO5TMgo/FVmuFsW0k+MDx/3nmurh/3jS/8q0Gy/ArCoNg+NLCG
         CuUlPfct1/ieyKjLB3+NrTqaDg6JjBNghACQJl5XgLsUKCAxwcdXu3h8cQw16esHeakr
         pQTQ==
X-Forwarded-Encrypted: i=1; AL+hErGWj6tA/Y4x7nr8/brOMk3UwzJQhVqXXo5UY4kz/BWYJ6kA73AsegqT23kCmU1sDFnLhoHfwT0=@vger.kernel.org
X-Gm-Message-State: APuU4Z9HlCwWyYf8beAF0Or/rXBWpkQQvgKUS/wZhS2u/QYCd+CMk9Ju
	pEWBrAj7uZ78/QGdxLkDgcm8O5xOSuMhrzvlvAHEbs1kZIvcxVfNoo3B
X-Gm-Gg: AYBFou0c4oghtxNQffDhm1G+Tt3DrnF1TmqnVDiIPs20HA1OaHiBoNlyPyTVLpgFyJv
	ZKmzSuuWUxbFq7YZBltf9aTQiEznA1MdGIcswYFgzRE8nzyUPZqQUTPtR2WegQleVJF/Rcx8u6R
	0A90O4LLQlJnIjkHBZ10cvcrYtY7uvJOhhUEnXac1lEK5wN6+gw95SzUviJmy+bMSMAQBo3db9V
	Fpl5m1ee+Dq9aDspmEsXBt/HHPerielmJY2cfj8FaeSInWDyLvKbMJ0ggRU2ElCNGzwcP43nfw9
	8jRWJ11sPL6mC8C8AXDyFJLKWZLP7WkOV02w1rOEPkLaKM0+EkyvLlRtSUjwqQFwy15YJ4INKLc
	XBoTIS2YQ1giHpQBY3X/dOKZPWB7qeF2PTqRkrHuWerbfhCrWNlLQUZ65vNZ1Qw2qkqUtIMqUmC
	xxR6/hfHVPGhjdsIbbz2pqGQhuzAsccbM039TyoBg7eOimWT9bVNFHrYI5a5B/j4paOMgczZcbT
	DPb2zi+iYJbhXf3ZRnMwXwp1HRETFoKF55hYPY0yTP9C4+v1oWxGL1kbLanZrZanz3U9j2eMwkC
	j2kjAo1/5TwTnyxryLBNBiRtiXbBMAOUVur0TAhF85NBpSCqNgNeYZxmypZklW/bPFAJuHVCZ46
	d0c4qa+h/zdhI1ltQhKpw7aHpDLwl7dC8Rou5cAYybvYdLOnrbfZNiLKqx5CE3dCMDvKpT/IfqX
	4W2bHOn40AAc5atDN4OjCRf3eyUKL5k1vZZ5fGIcSX
X-Received: by 2002:a05:6a21:6f09:b0:3e1:a4ac:2d5b with SMTP id adf61e73a8af0-3f2ff4d9896mr3404820637.41.1794437516195;
        Wed, 11 Nov 2026 14:51:56 -0800 (PST)
Received: from sid-dev-env.cgrhrlrrq2nuffriizdlnb1x4b.xx.internal.cloudapp.net ([4.155.54.158])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8baaa86dd0fsm2471575b3a.22.2026.11.11.14.51.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 14:51:55 -0800 (PST)
From: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
To: Kuniyuki Iwashima <kuniyu@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Kirill Tkhai <tkhai@ya.ru>,
	apais@microsoft.com,
	hargar@linux.microsoft.com,
	rlmenge@gmail.com,
	egoriluk@gmail.com,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Siddharth Chintamaneni <sidchintamaneni@gmail.com>
Subject: [PATCH net v2 2/2] selftest: af_unix: Test scm_fds on dgram disconnect.
Date: Wed, 11 Nov 2026 22:51:48 +0000
Message-ID: <20261111225148.88506-3-sidchintamaneni@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261111225148.88506-1-sidchintamaneni@gmail.com>
References: <20261111225148.88506-1-sidchintamaneni@gmail.com>
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

Add dgram_disconnect_fdinfo in scm_rights.c verifying that scm_fds in
/proc/self/fdinfo/<fd> returns to 0 when a connected SOCK_DGRAM socket
with queued SCM_RIGHTS datagrams disconnects via connect(AF_UNSPEC) or
observes a dead peer in send().

Signed-off-by: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
---
 .../selftests/net/af_unix/scm_rights.c        | 79 +++++++++++++++++++
 1 file changed, 79 insertions(+)

diff --git a/tools/testing/selftests/net/af_unix/scm_rights.c b/tools/testing/selftests/net/af_unix/scm_rights.c
index c165f250220a..ced83d3173b7 100644
--- a/tools/testing/selftests/net/af_unix/scm_rights.c
+++ b/tools/testing/selftests/net/af_unix/scm_rights.c
@@ -395,4 +395,83 @@ TEST_F(scm_rights, mixed_lowpoint)
 	close_sockets(6);
 }
 
+static int count_scm_fds(struct __test_metadata *_metadata, int fd)
+{
+	char path[64], *line = NULL;
+	int scm_fds = -1, ret;
+	size_t unused = 0;
+	FILE *f;
+
+	snprintf(path, sizeof(path), "/proc/self/fdinfo/%d", fd);
+
+	f = fopen(path, "r");
+	ASSERT_NE(NULL, f);
+
+	while (getline(&line, &unused, f) != -1) {
+		if (strncmp(line, "scm_fds:", 8))
+			continue;
+
+		ret = sscanf(line + 8, "%d", &scm_fds);
+		ASSERT_EQ(1, ret);
+
+		break;
+	}
+
+	free(line);
+
+	ret = fclose(f);
+	ASSERT_EQ(0, ret);
+
+	return scm_fds;
+}
+
+TEST(dgram_disconnect_fdinfo)
+{
+	const FIXTURE_VARIANT(scm_rights) variant = {
+		.name = "UNIX ",
+		.type = SOCK_DGRAM,
+	};
+	FIXTURE_DATA(scm_rights) self = {};
+	struct sockaddr addr = {
+		.sa_family = AF_UNSPEC,
+	};
+	int ret;
+
+	ret = unshare(CLONE_NEWNET);
+	ASSERT_EQ(0, ret);
+	ASSERT_EQ(0, count_sockets(_metadata, &variant));
+
+	create_socketpairs(_metadata, &self, &variant, 2);
+
+	/* 1. Disconnect via connect(AF_UNSPEC) */
+	__send_fd(_metadata, &self, &variant, 0, 0);
+	ASSERT_EQ(2, count_scm_fds(_metadata, self.fd[0]));
+
+	ret = connect(self.fd[0], &addr, sizeof(addr.sa_family));
+	ASSERT_EQ(0, ret);
+	ASSERT_EQ(0, count_scm_fds(_metadata, self.fd[0]));
+
+	/* 2. Dead-peer disconnect via send() */
+	__send_fd(_metadata, &self, &variant, 1, 1);
+	ASSERT_EQ(2, count_scm_fds(_metadata, self.fd[2]));
+
+	ret = close(self.fd[3]);
+	ASSERT_EQ(0, ret);
+
+	ret = send(self.fd[2], "x", 1, 0);
+	ASSERT_EQ(-1, ret);
+	ASSERT_EQ(ECONNREFUSED, errno);
+	ASSERT_EQ(0, count_scm_fds(_metadata, self.fd[2]));
+
+	ret = close(self.fd[0]);
+	ASSERT_EQ(0, ret);
+	ret = close(self.fd[1]);
+	ASSERT_EQ(0, ret);
+	ret = close(self.fd[2]);
+	ASSERT_EQ(0, ret);
+
+	sleep(1);
+	ASSERT_EQ(0, count_sockets(_metadata, &variant));
+}
+
 TEST_HARNESS_MAIN
-- 
2.43.0

