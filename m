Received: from mail-yx2-f12.google.com (mail-yx2-f12.google.com [74.125.224.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 228E7545D93
	for <netdev@vger.kernel.org>; Thu, 10 Sep 2026 17:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789060326; cv=none; b=r+eDKzD+TQ29KSc0mGHhqqG84H/YwuMHNT0xghEa2xgWxez1JrTtk1TsNrb4arldd8Ab/YWJeDEX7/LIvTHEApju2xopytZ/tfKBy4UqK6HMjJQMDHG+Du6pm9wtR0ypj/VcGWz/sK9mg3wOh9grDrKuE/9HiZqnS44xBhYCrhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789060326; c=relaxed/simple;
	bh=Y7kL2vem/8Ka2EG3Ans9tqDbm8RFnHk3MQXHUz4EQdk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mA3l2u+CTGID3RA5kyE6xB4yMhhLW7CQQMm9m+kx5iOQDwjJoD0CcGbcmHqMKwhEjF/Hat6nCMmLPp/5FpjRD4bkiDnrUOOdjZeOZnvx1QFmgiuaxwjhsR6Se/Gj2CF1jHojxvh8tUeRJFYzm7d8+OkO0PI7Ke9SUAIYsTWCsZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SJyRHkTk; arc=none smtp.client-ip=74.125.224.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SJyRHkTk"
Received: by mail-yx2-f12.google.com with SMTP id 956f58d0204a3-66e4ab201ebso1927740d50.3
        for <netdev@vger.kernel.org>; Thu, 10 Sep 2026 10:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789060301; x=1789665101; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KycgLgrAvf7CyAsQ0k0zligRmhmw0fBEd+p01CLCe6k=;
        b=SJyRHkTki1UdL9ybDCvvo/0QGYZuHgU3g+UDuFVoTfV8eYzenbwz6UsPFulmzbmwXl
         McY/lKLAIsOf/yvncG8JVywDjYtfxwwzxHzwNiviALPPg2IFbzGZOyBxA20jZna6Zqbd
         fkSPG2LnTlqMIl3aC+5KnlWr4fn6a4cewAYI5WyOdjt1mvq36NpVTQFI2SKO+ybZEKlJ
         uqOrtPKjQMul892Cqc6TLfjPN+hTkVocnUdvYOd8V1tbB7r8ao/8/XZo8I17tl5+bW8P
         7mfmCnaI9pGBkpe7D8G26R0Sx3tbeEGym8NLJam2JY45FSuliQJENt+ALQJFPDZd0PLg
         ZKMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789060301; x=1789665101;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=KycgLgrAvf7CyAsQ0k0zligRmhmw0fBEd+p01CLCe6k=;
        b=BkBA6ZbOPUFXeZYmX/b412g4yd/c1bED40/kSkwnF+NXAk5tBSQB7wsWFECoq6gUvf
         AqPCRRxYLZxDPOcnKKDCn4IP1vcnfWbDuenRc7FD8jLXNkKppEwHqRoToKUtttKRXKkP
         wwkL2MhvatMX6znFJT8XsfMhtrcux5PRwYaWhFsr1NC6GaBT4CEJ6MvR+2vHuMP7W+PJ
         vhf48V/TAmZoiGEhrFHhTXh7z5LtTCu/bmQpFd2h1RqYIce+DjBOI8Z2P5xS4NsdJW3Y
         w0xIvmnE5KuQb8GMFJAE3/ECgQTUNq7HFaf7On+4kcLk4CkVW+aad2o4sYAClv0Qm4qe
         0kkQ==
X-Gm-Message-State: AFuF++mn8WYxdsE9QBewGMQvr2wN83QUNZqqtGSjyoWsHiE74wxHyMju
	nDG1Y0mjK/12bRji8bUxq1ldnQueJDg/jeH+OBLKukxMHWCvf9Ljnr94ytbeDA==
X-Gm-Gg: AYBFou0PZMbJQeqdBfN4ehQ9ATzklAFyMpXnJic7XIyat40NF6F4o5tsIlvU7ssGYMX
	fkGxVp/PxQhF7vl9c259XfXDM+7vn0n+ONuzSvyc9Chuvrqa0grQ82EJXeDOQmd2uKZ6O1z9dr7
	KzUKGxm3nltdUPEVobxJXVrbVr0BZ4KygHDlvxWoNFxQeFeAGCFIuMQw38JXdnAo5WQC8j70eWb
	ElyGswwJI9qVxEEX2i6PJb1F92boEjk2a10D6A9JfOpT5OWCzzzICkZOIR4GhSWwBS4Lj2ebWal
	+49Y2D1SA1oDiyE7ignjcE+Zn6ea7CES+x+/MZYMX3v6RAdbA1B2uYB4VUP4TmE+JncCAQGbrF1
	X9xrSWPU8GtxxjYyk/p0GtcCGnk7B/8Ht24daLMY3FbVx2uRbXvG3p+4b+ZU785tz2aBq1gIvbp
	oPppKn3Sl1bEr9OQ2gBRmCIVc7lhITtwZjqWJIDBnDHWDmk/Nppkg9tPoHmK41RUkA1WDOUYNhA
	wl7YO0/C2VZMGjekw6Js+kDHXTOPmuMXVWXDrlNhVwMwFX7kYi8B678xtIZSHu/Vxi+AM5V2MM=
X-Received: by 2002:a05:690e:14cc:b0:66f:c1bc:87fa with SMTP id 956f58d0204a3-67124a49656mr68188d50.83.1789060300672;
        Thu, 10 Sep 2026 10:11:40 -0700 (PDT)
Received: from willemb.c.googlers.com.com (234.207.85.34.bc.googleusercontent.com. [34.85.207.234])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66fb48ee9easm14059834d50.8.2026.09.10.10.11.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 10:11:40 -0700 (PDT)
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	andrew+netdev@lunn.ch,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH net-next v9 5/7] selftests: drv-net: refactor so_txtime errqueue handling
Date: Thu, 10 Sep 2026 13:10:24 -0400
Message-ID: <20260910171131.2532487-6-willemdebruijn.kernel@gmail.com>
X-Mailer: git-send-email 2.55.0.1007.g17ff1f9808-goog
In-Reply-To: <20260910171131.2532487-1-willemdebruijn.kernel@gmail.com>
References: <20260910171131.2532487-1-willemdebruijn.kernel@gmail.com>
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

Changes
  v8 -> v9
    - fix separator (---)
  v3 -> v4
    - rename func to do_recv_errqueue_txtime
---
 .../testing/selftests/drivers/net/so_txtime.c | 66 ++++++++++---------
 1 file changed, 36 insertions(+), 30 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/so_txtime.c b/tools/testing/selftests/drivers/net/so_txtime.c
index 55a386f3d1b9..f6f3253ed174 100644
--- a/tools/testing/selftests/drivers/net/so_txtime.c
+++ b/tools/testing/selftests/drivers/net/so_txtime.c
@@ -158,7 +158,40 @@ static void do_recv_verify_empty(int fdr)
 		error(1, 0, "recv: not empty as expected (%d, %d)", ret, errno);
 }
 
-static int do_recv_errqueue_timeout(int fdt)
+static int do_recv_errqueue_txtime(struct sock_extended_err *err,
+				   const char payload_char)
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
+		num_tstamp += do_recv_errqueue_txtime(err, data[ret - 1]);
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
2.55.0.1007.g17ff1f9808-goog

