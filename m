Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9FA737206B
	for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 20:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784753108; cv=none; b=S3V8GdYwOoyd/hCnnx4PnRi2LRVSvFG1Q5GRZFP17B7cZIKkuzPnwI74ML9Yw+GonJXf/APui9pHLmMiy4nZHGv9JwSbn40VGms+H8hOjrdhPdaZIG9/ozTHN2+6xoDaeEFL8gGEQpaQvdru1LgFxS9wA11epjFpgLEM64lGBzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784753108; c=relaxed/simple;
	bh=fa2j+MJ+bu4AjgNuEiLJ6fFIQwaR906hlBCiYLeLbZI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kr1Rq1Q8Hlmk9+DIZXeXnuVhJ8hpB1pT/S1M+29hd4p1IzbSfFkdLRx9HNnN7tu+a91jk4Ulwg4dU0bSyXrCTVpG08U+egHn8z8+i0RW8dZZXMjL5avYb5w7rr6GETXJdrFJ+PtKYWHs7Cm3J8/z+l0BY+joHtPrMWP6CS9sycE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=r1cM0hks; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r1cM0hks"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-81e6f2ee60bso49211217b3.1
        for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 13:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784753106; x=1785357906; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qJXpjUmJG9CghmfT96uCE3JAmfSW2+wlpQUq8BR3Ndw=;
        b=r1cM0hks9HHdmI4KGGEaj22YzOW4I4j6nKggiR+JumFqyujGxXYAuwqc8EAMoPBM6j
         V52486d7KU1H9cr1Q7+4ArzwAkDB2i8gHDDOj6UIwvYEyCnaQ7zT1XBIWZmVnHfU4DuZ
         8/B7kKR2EOap35Mw5KhGM6qBeSZVYCg3talEzHuJp8tXBfXm4eVUBTdLCX/mkp8zQMFL
         XOshyFSj+mPNqshaAmpI5llq1bnhyqjOjJc1uaVGLPCdxuMIV9rENgejo4IbQfKpIVJc
         tXVdOR65uiHz9a4QFiK3lJU971dr8bSHqmSPLLHE6HCMjlT+wapLdQFnp19Arw41kDC7
         AStA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784753106; x=1785357906;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=qJXpjUmJG9CghmfT96uCE3JAmfSW2+wlpQUq8BR3Ndw=;
        b=rxHS5yIxpKkVnnNHuYlDjwD3VEVKzw2/U0xQUPON9xZppwS7Mmy+j8rp2erRIgsxnX
         NEJh95Xx7bQVfkmmNs/BjlOQ3DEK/+G+3ND3iM/IbNa6b2UcZ0dGLlgqpCZshhNRNyFm
         jilH7H8YfvWdvCPefDNPsRBxc2ch7j0hE4TwcuWcnTYnhiR8hC1K1alqhJYqa1VBmjnJ
         8i0961um9tJBse7FvanVL4yq3Jogdm+TN8xeQ63+LTR7YetascIPvik6NvkTI2DJej+I
         gwJ2n9555eHHuvsW8P6UPeUmAObOeXQhkXxR8MS1lu62vQsOYDp8oq9m0c1Y1qAc2lWs
         sdbw==
X-Gm-Message-State: AOJu0Ywa7TfJmI8rBwHiU6Pc8H4tA6nf0X3UtEfKTkzhsjXRObQnFl0a
	z8s0L43kEXx0nCcjsZOxqYznqMiHRtOgAxQtlUl+S/UnRSBKCDU3Toj/4pzffv2w
X-Gm-Gg: AR+sD11RmYuUY+NYIbO5ESS2PxVUU/4diUw+4jBwAE1xo3XSSqViM2Jepbuv3GZPH/r
	pJd0mpltGcdOcKcY8hq2GLHUV+5mx5H0zAPc/oZj+5joyxcoTdAAaFP3H7ztq9FyCLi4A2c9yTa
	0beTGyHLmgNV2bBPmgEfHs1JSX+cmnvuo6/1E77wqY8FDUoZ2qRgjsWVZBkZNkjLNzN+PVelKLG
	L3TWlmAQCVSj5eo3jdcX/GjKD5zctddf4W5mCFijlLAuTldo1k9ccavrXpW0CTrYTeI3bZDyPt7
	C2/mkrK3/87vi5K7q7bm6t+plsn4AoWLYzEwjDuvLxBHbYh+qf6UiKZfOJ+6dbDlVSEWT0mvwQi
	HaOZ4+r2GGmDP7lfWfn7Jq4BoAgCqu4sDbzsfYSZ5pXBoKtErOiEDEh2GCf71/Xaq9oNJWb30bM
	lBhD7JNeD5OHtHQzuErB2Gc1DKWa0iCPfSv7no+bHZkP/fXsorV62PWjS++WPDTokbK2flqs7yz
	njijbczrtOJkhqrv2mujuydGu0=
X-Received: by 2002:a05:690c:d8a:b0:81e:bc7a:df50 with SMTP id 00721157ae682-81f3398e12bmr19347497b3.3.1784753105545;
        Wed, 22 Jul 2026 13:45:05 -0700 (PDT)
Received: from willemb.c.googlers.com.com (172.235.85.34.bc.googleusercontent.com. [34.85.235.172])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81f33bf2df0sm19506797b3.6.2026.07.22.13.45.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 13:45:05 -0700 (PDT)
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	andrew@lunn.ch,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH net-next v2 4/7] selftests: drv-net: refactor so_txtime errqueue handling
Date: Wed, 22 Jul 2026 16:43:50 -0400
Message-ID: <20260722204454.3234605-5-willemdebruijn.kernel@gmail.com>
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
In-Reply-To: <20260722204454.3234605-1-willemdebruijn.kernel@gmail.com>
References: <20260722204454.3234605-1-willemdebruijn.kernel@gmail.com>
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

