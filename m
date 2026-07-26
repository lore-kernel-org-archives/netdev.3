Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD873ACA50
	for <netdev@vger.kernel.org>; Sun, 26 Jul 2026 20:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785097756; cv=none; b=nmffUFj2mER+2zU6RLX3QKED+4w/be9d9J9ovDCGFTg2ueaHGOzhywDNQHy8mUOqrXij3TWUbtnWcuQH6aJSKwBuDnKg442o1cbiekb47bHtDG17DGmDgawcQThm8++20gkj0XZ6mvFxw40glk8CxzLbN54p10WJgJzPiTwn32E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785097756; c=relaxed/simple;
	bh=ay5yYKZoc4ufLUChKX8Nnnn4aLSCjUR8A9926X739wQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ze7q3/3ZcO63rNw59ezg7buDiOTvlVDQ2oXJMBxgaISKt46JzPRhGMKm0lSgHXcwaoKCIX+xT+H7S4ia6H/FusdwI9lKTVi+gSXYZhKmEiB97vtUJUdbAzX+s+f0E8ZsO3UHVIzOTAw//k2CELxTehJT68AWQYi07FlPiAEUJF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Amw7A1Ws; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Amw7A1Ws"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-81ee41aaec1so24995007b3.3
        for <netdev@vger.kernel.org>; Sun, 26 Jul 2026 13:29:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785097753; x=1785702553; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BmkY4Gg3JwUl+kI3Gu2sAoYBM+2JBL2G9pxjlj4qZKE=;
        b=Amw7A1Wsoo80jwhnQO1Vw9koiu835p5osuWiIoWbIiuNhJvbQf7syrLjjl423ghHYY
         4cktK+30SmwoF0s2JZPwisVaOxahmgZOoqaQAYIRPkNmkdDRmSIbEW1M5B8GR3xcmGxZ
         SJ/3ed/AwNtGuC1+ys+vJ2zO5g/cBHyv7cuwZg7UFyc/hNJzFsHbNAPhvI3TddKzcltS
         c58Olro6e6ghDw2b5Vyjmb6XcYp500XSda+M7KVMZIxUhzWQ7HvBuEYe7yHI0V3d0BqW
         gIEqEA+5pPfWw7C0zBXj/rhZ0sPAze3zbxERs8dRDTv+uWTsqA0den+5aupxhvJA3qBE
         aKyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785097753; x=1785702553;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=BmkY4Gg3JwUl+kI3Gu2sAoYBM+2JBL2G9pxjlj4qZKE=;
        b=F82xorVIuB8dcgnp9Hf0sunRdv5TCyjrTcZL693MdAQxlWYyiTjixcelASVp9+FATt
         dC22fZzgrCwLS+rUVD2EnZnvWNYn61QuhxlE7yvanjVBeEXYcea/6NUAByWy+VlPyr6w
         xPYFfS6zKyWzizD0/MGUkvJG9XrvCFbPLHIC5oCNq7m8Uf2cx5Htb23fl6DP5CvHm4zh
         ADG10sdBhH4ztxxGWWeErsrLxpRkJ8+SusMWEeEDSiBy1c7oSj7gaxsIm3JtLiZoN1Vh
         l1O2xIb/TtVyxLXKNr63ooFWXr4AK3vpjQIHVwTX00PgzcybPbMtxGltr2wNVDQcZIk+
         I0RA==
X-Gm-Message-State: AOJu0YwiiqsrTB3Pi7jAb+pRE4X9u1md6wqIy0caq1/dkHJygwfVcRtc
	kMf2YUP15p2oaV2cCTlxawLSVvTfPQCi+yDhoeCaNBaQd2NokJ2uEP8kMAwrOxqi
X-Gm-Gg: AR+sD11bOTUwDfXnqurL7ZHrMeogrmdm2fJx1fDBoIOy0f3Vmw/1N7Y29BuWP8rwZhs
	00FebOsfzuhl0u4JiZCVy6EEx11RxPjgyfQ6Pkhb7JuxEJxbPb9LzDlTFn/eXBL4V9Bw/JdlWfR
	ZM5CTKj5vxD2oIqk/MCVqNQcWYKWoIRYqSmv6yY1Gn/y8v2PIUA8IG1hCDu+FizAiqo8KJ5Cqdd
	tN0Cb1tDrrXTdZFTCfYI7Wb7mZlWC6L26B/wvEQkkAEFnwtgxzKmytBW4JfgjVyqHJAW412qSbH
	IS38Hlk6Q9hZlNCvXtcWmuAz3LM5VqFKwEt44bcslpgoNjmJv+Qi2XDsDseTA0geVL5a0FHhUl8
	XQplxxgDU1nKuS2vOgahEsEv60IuckMBurboIekVbhSjlftVV6y49X9EkWL5AfXRmEsUm0CeMEA
	p0ZNK5Sta4un57G/7Ijaw2gqCr4pfESzTqcrM5bkYPJWpVu5pg9SIbKC+rr2b5AOlLLAYNEpJ7
X-Received: by 2002:a05:690c:6c90:b0:80e:3d45:5206 with SMTP id 00721157ae682-81f69d273f2mr20697287b3.18.1785097753486;
        Sun, 26 Jul 2026 13:29:13 -0700 (PDT)
Received: from willemb.c.googlers.com.com (250.4.48.34.bc.googleusercontent.com. [34.48.4.250])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81f657a14d9sm23339467b3.13.2026.07.26.13.29.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jul 2026 13:29:12 -0700 (PDT)
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	andrew@lunn.ch,
	mohsin.bashr@gmail.com,
	Willem de Bruijn <willemb@google.com>,
	Mohsin Bashir <hmohsin@meta.com>
Subject: [PATCH net-next v3 4/7] selftests: drv-net: refactor so_txtime errqueue handling
Date: Sun, 26 Jul 2026 16:28:48 -0400
Message-ID: <20260726202902.760552-5-willemdebruijn.kernel@gmail.com>
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
In-Reply-To: <20260726202902.760552-1-willemdebruijn.kernel@gmail.com>
References: <20260726202902.760552-1-willemdebruijn.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Willem de Bruijn <willemb@google.com>

Prepare error queue handling for upcoming SO_EE_ORIGIN_TIMESTAMPING
messages in the next patch in this series.

Convert do_recv_errqueue_timeout into dispatcher do_recv_errqueue
and move SO_EE_ORIGIN_TXTIME specific code into a separate helper.

This will make the next patch a lot more readable.

No functional changes.

Signed-off-by: Willem de Bruijn <willemb@google.com>
Reviewed-by: Mohsin Bashir <hmohsin@meta.com>
---
 .../testing/selftests/drivers/net/so_txtime.c | 66 ++++++++++---------
 1 file changed, 36 insertions(+), 30 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/so_txtime.c b/tools/testing/selftests/drivers/net/so_txtime.c
index 55a386f3d1b9..7364ce2bec0b 100644
--- a/tools/testing/selftests/drivers/net/so_txtime.c
+++ b/tools/testing/selftests/drivers/net/so_txtime.c
@@ -158,7 +158,40 @@ static void do_recv_verify_empty(int fdr)
 		error(1, 0, "recv: not empty as expected (%d, %d)", ret, errno);
 }
 
-static int do_recv_errqueue_timeout(int fdt)
+static int do_recv_errqueue_timeout(struct sock_extended_err *err,
+				    const char payload_char)
+{
+	const char *reason = NULL;
+	int64_t tstamp = 0;
+
+	switch (err->ee_errno) {
+	case ECANCELED:
+		if (err->ee_code != SO_EE_CODE_TXTIME_MISSED)
+			error(1, 0, "errqueue: unknown ECANCELED %u\n",
+			      err->ee_code);
+		reason = "missed txtime";
+	break;
+	case EINVAL:
+		if (err->ee_code != SO_EE_CODE_TXTIME_INVALID_PARAM)
+			error(1, 0, "errqueue: unknown EINVAL %u\n",
+			      err->ee_code);
+		reason = "invalid txtime";
+	break;
+	default:
+		error(1, 0, "errqueue: errno %u code %u\n",
+		      err->ee_errno, err->ee_code);
+	}
+
+	tstamp = ((int64_t)err->ee_data) << 32 | err->ee_info;
+	tstamp -= (int64_t)glob_tstart;
+	tstamp /= 1000 * 1000;
+	fprintf(stderr, "send: pkt %c at %" PRId64 "ms dropped: %s\n",
+		payload_char, tstamp, reason);
+
+	return 1;
+}
+
+static int do_recv_errqueue(int fdt)
 {
 	char control[CMSG_SPACE(sizeof(struct sock_extended_err)) +
 		     CMSG_SPACE(sizeof(struct sockaddr_in6))] = {0};
@@ -169,7 +202,6 @@ static int do_recv_errqueue_timeout(int fdt)
 	struct msghdr msg = {0};
 	struct iovec iov = {0};
 	struct cmsghdr *cm;
-	int64_t tstamp = 0;
 
 	iov.iov_base = data;
 	iov.iov_len = sizeof(data);
@@ -181,8 +213,6 @@ static int do_recv_errqueue_timeout(int fdt)
 	msg.msg_controllen = sizeof(control);
 
 	while (1) {
-		const char *reason = NULL;
-
 		ret = recvmsg(fdt, &msg, MSG_ERRQUEUE);
 		if (ret == -1 && errno == EAGAIN)
 			break;
@@ -201,33 +231,9 @@ static int do_recv_errqueue_timeout(int fdt)
 		if (err->ee_origin != SO_EE_ORIGIN_TXTIME)
 			error(1, 0, "errqueue: origin 0x%x\n", err->ee_origin);
 
-		switch (err->ee_errno) {
-		case ECANCELED:
-			if (err->ee_code != SO_EE_CODE_TXTIME_MISSED)
-				error(1, 0, "errqueue: unknown ECANCELED %u\n",
-				      err->ee_code);
-			reason = "missed txtime";
-		break;
-		case EINVAL:
-			if (err->ee_code != SO_EE_CODE_TXTIME_INVALID_PARAM)
-				error(1, 0, "errqueue: unknown EINVAL %u\n",
-				      err->ee_code);
-			reason = "invalid txtime";
-		break;
-		default:
-			error(1, 0, "errqueue: errno %u code %u\n",
-			      err->ee_errno, err->ee_code);
-		}
-
-		tstamp = ((int64_t) err->ee_data) << 32 | err->ee_info;
-		tstamp -= (int64_t) glob_tstart;
-		tstamp /= 1000 * 1000;
-		fprintf(stderr, "send: pkt %c at %" PRId64 "ms dropped: %s\n",
-			data[ret - 1], tstamp, reason);
-
+		num_tstamp += do_recv_errqueue_timeout(err, data[ret - 1]);
 		msg.msg_flags = 0;
 		msg.msg_controllen = sizeof(control);
-		num_tstamp++;
 	}
 
 	return num_tstamp;
@@ -245,7 +251,7 @@ static void recv_errqueue_msgs(int fdt)
 			error(1, errno, "poll");
 
 		if (ret && (pfd.revents & POLLERR))
-			num_tstamp += do_recv_errqueue_timeout(fdt);
+			num_tstamp += do_recv_errqueue(fdt);
 
 		if (num_tstamp == cfg_num_pkt)
 			break;
-- 
2.55.0.229.g6434b31f56-goog

