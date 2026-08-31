Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C27D93A7852
	for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 21:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788211952; cv=none; b=BHpNAGj6xbJq/bZJTMx4o9CrbAhmkFY+uE+vWBgFMMj/QF/4rDZKs9mM7Skhko/LhD97z52hOWqPfoNjXWBPr6VxgeZJ374RAbr8xiYX8ZsxQeQPgEgz8V9jYmIHqnGgd11GvOseYueTiFaAL7hRp6Na7D0z8z707HbbRzftKxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788211952; c=relaxed/simple;
	bh=Tb8nXwb0snl2MGcC5bq0DeQeQWumeuB2gZBP7rdfDbk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qKmN1ZfLCAoWVyqc2r9RV89e+YN8rAJegrqEgoZki3FTPXrVBqxxxPZyoJ3vMLV1YCHp3yfA+M8Odi4NYBrbAGxddKFCunPbkbhn/7sv0mwj8dr66IyW4p9HC+hioAFSYx0goymEhAZXGq9h3xjrsRilc8eU+mKLIcf36+hhMfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lOhq7ZlE; arc=none smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lOhq7ZlE"
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-66e5e33a9d0so385086d50.1
        for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 14:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788211950; x=1788816750; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YMofeZs1czkn1aULDqF3YkW2uDywNS3FivDDchbXQVc=;
        b=lOhq7ZlEG5/4bnBGommtn0tmrPN25BYD1jjqfhBDrfpDqS2hT5MbIsNRwGGGUNzE4Y
         44P47it5NplqNLtizDrXcpZusZ0Ylfl9B4PZOTQ/TissneBwICD9p35KS14db+MhJjoL
         zcDzniEUxiAro3ckTcaP7qEbXh/hmM5QPYS7DWaaWkLHLL/OfAF2iJNuUAtFGn2a5/58
         R5A18EwHyA1Isknsdydf37VFneLCsuwk+5DgjU5DjPnfmCKbd0CL58+4YyrK5elXXpMR
         C8Jjs1WchgXkMR1kCXfwbRI1C1+lViG6CwQk+LNFN9AJVt9i3ve7LTf9HAHEytuHLI6F
         p/FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788211950; x=1788816750;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=YMofeZs1czkn1aULDqF3YkW2uDywNS3FivDDchbXQVc=;
        b=gDPsLtxO5Sj9piZXfdCpIdiqeBw4T0EEkI3/uByiixZVjWD3dJAy7/NVv1K830S0p0
         julOahxfECU3BDmrykOuoGZGtpZyNEkKVuCvxoD0/gVWYkLj1rNp2DvjbbPiUxkMV1K9
         LH3AJY8DLNSfnJPEIkmVOpm5vPIxI7Nir1V0l8kNVHtMr++iwdjtEyMGoIuOXdSWoZ60
         7mudTWQI4ZDH8yTQ2Tp66U6eX5+gZNxz/sMpRJ5n9kb3soyTDjW7BdMXP1KOSVzwnAk6
         lWz0Cxu+83voW22C33nYByGSkEpkdV4dONNkX+qAPjmUFHXBlC62Jb4Gz/Y3SU7wY7mE
         uUZQ==
X-Gm-Message-State: AFuF++kxN2SKN7Z6IodTrPuz1wrvzfZnZJB3n7qi0KHBR2TQa2OUyAZv
	wcKM62oVrKSyjSU2Di0xztysmy1PclUjrN0XkZy1pve6AUKRAIWZhhLC/EmPdA==
X-Gm-Gg: AYBFou1ZtuSOOoFAcOVf3/Hroz4u6vkkrGsn/jHHBgbDap1y7xrK4c93SonUSPM2xn7
	nN+ffe2cX76SczRTSQ8utXmjy1cz1qgw7QpJzWSN3MWcxQcQHXbgUn12PLJ2/xmtDTNOnCKPdOr
	d1OLy21AHHKsQvBbiNo8B1VYgowa6+dv0o9XatoSXfteyjkX9yl0wW9YUtVCxrYAlEgSt5D9owk
	+bqjSLkJntmH0kIWReP0f5WQspoUAGZUrLBE+15qjWT+DUvzXAdq7+PuBwIuCE0SXrjVGIxXawz
	W0BWFeHcFjN1UQ0c4aWAMHVGuJ+vTsefGYqoU7p/A0X3XkgHxqH8Dwyx2MjqOHDr+MZUoPG10FK
	mmgk8+t2Ug270RHdDBeD4qbHwL6FglpzNu2i69A/bQnHqBXSbvlrhtLO5B15q+fa30s2+lEcvpH
	CY1ZrJcHTJTOGmszaQ0kqse+FvE4dqxmEVoECi4kcU4pJFT0LcukqBqfnNNuOHpaFfYztCzHOTI
	TuC7EwcWV4I8u3EHzUnyxHVyV+rBRUJBzVKaE+DaUrY1bMlgFfH2/dzU/IIgGLF
X-Received: by 2002:a05:690c:7349:b0:825:c3fc:e63f with SMTP id 00721157ae682-85d672517a6mr128711237b3.8.1788211949779;
        Mon, 31 Aug 2026 14:32:29 -0700 (PDT)
Received: from willemb.c.googlers.com.com (234.207.85.34.bc.googleusercontent.com. [34.85.207.234])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8616243a833sm45474307b3.13.2026.08.31.14.32.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 14:32:29 -0700 (PDT)
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	andrew+netdev@lunn.ch,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH net-next v7 4/6] selftests: drv-net: refactor so_txtime errqueue handling
Date: Mon, 31 Aug 2026 17:26:13 -0400
Message-ID: <20260831213221.1370774-5-willemdebruijn.kernel@gmail.com>
X-Mailer: git-send-email 2.55.0.897.gb25b4bd76c-goog
In-Reply-To: <20260831213221.1370774-1-willemdebruijn.kernel@gmail.com>
References: <20260831213221.1370774-1-willemdebruijn.kernel@gmail.com>
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

--

Changes
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
2.55.0.897.gb25b4bd76c-goog

