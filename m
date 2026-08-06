Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21DB5490C0A
	for <netdev@vger.kernel.org>; Thu,  6 Aug 2026 23:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786058969; cv=none; b=gxWTJJN0LuyGB5SkuMSXPJZuFDyr5NGLV2ATt/YfnILYuVnp+3J8WjI+JQVvuu3jybN8bW/psuucsNawOGs3bqBroMhcK4HZZkC3WvoyMMV8mAhF1UQvq3KaosmX0Njvpmv6HG3UHqp1QlFp1KMCMk8QhZSPR8KMnfPgXf7MFf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786058969; c=relaxed/simple;
	bh=/gURIW/BkmWHpbEXzjNfT/coqaue8J2Jne6jBAQwFTI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tjRjZlxWcFKLWGSwriB2QmpCbXFT6SGQUqGExcvyIQEWFcUYz3uRqs4EEDGK8eRSmQAnPfUNWFeCh38tcJlpi82Yl5wrJizs6q/Ds0YHpDIVOjRn9qmxrzWIik3lleN+CjBNK+iyaQ3zuEbLpnaOLTq5gaHQ9Q10WX9d1W6uTH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pyDNWdCE; arc=none smtp.client-ip=74.125.224.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pyDNWdCE"
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-66807ba2f0fso4253872d50.3
        for <netdev@vger.kernel.org>; Thu, 06 Aug 2026 16:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786058967; x=1786663767; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=m4AcnQRhEDZ+EydrdS5Nv+6C2yrHGgiq+Zc/wRZ1zzY=;
        b=pyDNWdCEm8ZlFNBu4aKhpGfMRn/dp2vccfrwQyrDmZe0I94Svv2vY1XUb6GO6V5FSN
         oF3rR9GGkotEb/vvEq8gUleOHzz/nrIUUVgkALil60OIfwrUp1O7WzRausfSv1V5tbiK
         KhY62+WCUW7P3O6GgtJzsfO2KP/3upjNE5nloRFiZRZb5xXppMRmgkmNQHuV4AQJ5WBi
         VjerO4OXSTr1JlvbLxevaphSzfzP+X2WNewPf3U2+ZzfIywTG+dJ93no0edknEp4WlmS
         kMP8twsYZdir75inK8GQcEf+N3ml5EoXzUQe0k+k2Z+2ySQx+anrbSCTUNVNhKoAyUvM
         F1ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786058967; x=1786663767;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=m4AcnQRhEDZ+EydrdS5Nv+6C2yrHGgiq+Zc/wRZ1zzY=;
        b=L3t9AHhtCRh8jTsULIoATZtKRq4oh32HWB1e6RjIF2wb0ipd/zSGEkEQvRhkdjeSBG
         RsmYB8lhPrnFN7YhsttEs0aJMa1E2q2OsuoBS8o/Z5+Q1fRXMPv+dDRZjsUhh7fH7moI
         AyKbn5oiMOljt0B0AnCbGFI2oScjnAKLihNxqPpfm+SDTVqfmFKCFwnTd6I+4qciLq6l
         i3oE5fKKn2CDqOwhEU+MokNC4ngCdueWuvDK66zBHTyDJVYDNwcB/dRO3eAUCKm+D+lt
         t5OYyhDL9lVKs0QM24lTFqtPlvzUznasWeSucEEk66pYQTfLsxd8RhzXY9yvbsrFC8Sr
         xyKA==
X-Gm-Message-State: AOJu0YxEGS684YgjIQOInkNKx1gND/mcX8MgWmoLbz0SMtBhXzVbth+4
	VIItY7SUvn7XyH7RGGL+rLs7ubwXJHKlrkXKhpALCxZgpB6vezh9+PJ/skwA8w==
X-Gm-Gg: AR+sD11YMSiP2oPGQg0nYrW9mge/0mrQktxeFJ/Gcim0c3aEQWwbbnAoZglHi5PgCAy
	kqX41So+uohfFm10rrkH0eEdzzvuX+dGqt06VbIitNl84Caqt4LDnrpXPQBgw3YOO0yXcRINp4v
	Wrw4HpsmSCZTmjzOH4GSswQvfVcFsrR0IhNzLNWJiX9/3vRJJDYk3qGHwIrWcdKGDczkT/fNnDw
	t0+Qym19R+wcZ+fKH37ClG7leBs05La01GlhY+4XOe3j0yFvbGfIsGgTvM8HExeU+0NXVE/EaL7
	e80C4tedJOOcm7OM/vQ4WkfkWUnluzbSLerh6pIKRKCMjCpdqEQbjrOAM0wPcQ+0Wv3eHGlWFji
	VLDj37mxF9Emw/pSr9TDnpVoLskeVrrClIvhPOGIDFboQjkjaREbsnrzhxBiBSEwdMPu9RniOir
	j+8uGStgh2NgYt51GZZjR8ES0fJiSeCG+e4XFmLT/wi8HIeT+91Px4pzpA3zAmzNCJvYwLr7pF0
	771aEfnicMyXRvbfxaZ05EYL15F0W8wME1AaX2pi8qY7gfSDMEK6IDcue4=
X-Received: by 2002:a05:690e:4553:10b0:668:8dfd:8c7f with SMTP id 956f58d0204a3-6699ab5702fmr8625314d50.43.1786058967110;
        Thu, 06 Aug 2026 16:29:27 -0700 (PDT)
Received: from willemb.c.googlers.com.com (250.4.48.34.bc.googleusercontent.com. [34.48.4.250])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66acacdbdf2sm209273d50.4.2026.08.06.16.29.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 16:29:26 -0700 (PDT)
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: netdev@vger.kernel.org
Cc: intel-wired-lan@lists.osuosl.org,
	anthony.l.nguyen@intel.com,
	joshua.a.hay@intel.com,
	przemyslaw.kitszel@intel.com,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH net-next v4 4/6] selftests: drv-net: refactor so_txtime errqueue handling
Date: Thu,  6 Aug 2026 19:26:01 -0400
Message-ID: <20260806232913.4020403-5-willemdebruijn.kernel@gmail.com>
X-Mailer: git-send-email 2.55.0.679.g6767b8d81c-goog
In-Reply-To: <20260806232913.4020403-1-willemdebruijn.kernel@gmail.com>
References: <20260806232913.4020403-1-willemdebruijn.kernel@gmail.com>
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
2.55.0.679.g6767b8d81c-goog

