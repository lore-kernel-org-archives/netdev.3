Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36DCB3403EF
	for <netdev@vger.kernel.org>; Sat,  8 Aug 2026 15:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786204364; cv=none; b=PDbDtPteHIo08MwMjWo6jg1eQZ9BRMqpvFnrrWm3EzeB4clNnBN23AwugIHEDb6u3EIOLlPvFG4eJ7v0sgsYViX9sjzOlBWV4fKfATbHnF68bTEnqfUWg/bjVz2OZcapeOYric0DdfY4ej5yZx1XoDNHBgM7ZDxtg5bCBgbEQJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786204364; c=relaxed/simple;
	bh=/gURIW/BkmWHpbEXzjNfT/coqaue8J2Jne6jBAQwFTI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dsPGGbx63Zp1iNO2iso7Z764o4tMT9rl4By+9GiIOF57nxYUuQzhPH2OofVx0V51kpKekG+VtgL6RQSisDE4scMLKcArepfP5Mu6c4GxVDjPmqBYlqD8rM+PoXg3ktIekXoOYbKvH+c5blWpmNkv90F1teMNAU471XTUkOyR6ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U5p89SD3; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U5p89SD3"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-81ff017d420so41987917b3.0
        for <netdev@vger.kernel.org>; Sat, 08 Aug 2026 08:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786204362; x=1786809162; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=m4AcnQRhEDZ+EydrdS5Nv+6C2yrHGgiq+Zc/wRZ1zzY=;
        b=U5p89SD3jCpV+8aRmOqtdIyipAHnAKfwn4vvlQrutUdjEIcdg1Yxm8uh8h3RUVNJxV
         gEr+AJp8FEoXDOzvuh7rr7sdXvEPKp5RzdkLKMyB5UIPmPJXn5qDt9pWu6+w7K5+FJpl
         Ar/nTooeu0garN8+UEKQbgzWaEEDhdCe4biKmSdxz+t746+x6bm/vAqGfzz3g4aA71wb
         MsMV8dETyiXiTsJFI92sIue9YTQG5ezm1ccPi8w9j3r0Oye1wArrI7Q7v7Z3HT//5jJq
         cjfHAfF17xVg8EYju5F1+bTGBvu3db3k80TSMiEWgn6eM1fuGKkdEZ1FC/ch9Pw4lGUI
         zM5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786204362; x=1786809162;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=m4AcnQRhEDZ+EydrdS5Nv+6C2yrHGgiq+Zc/wRZ1zzY=;
        b=XJh8al7F5XJcEKkU+cw3b2fWEG5Csz/NdThY1IPBKVWdza0V32EfyTV44JkcPaM2JZ
         /DCzj/7P0zYAf16JyxZQWdxpQ3R06gmUdLOOT3hT6uhbjblw8kNvD0D3uv/xyJpjxz7A
         nFb7UpUbXzJNHuFchdpWNhTuA10b6c98L7a++CJCpmINxMa5+mUkO1gltpfDyYxpd1FH
         bEVOenf2qbSN62WmBgWbZV3F06+TKb4MtpeAKQt6Qc5Sln0ru88JVWFPyGZQ+7W8Zyxs
         CJ8Rl+Huno1Fx72VupeuZSY1Z09C2+Gks1e0gNWM9oOeoQWOmc+NTTeGi7h+D9EsJlL9
         REjw==
X-Gm-Message-State: AOJu0YzsEXg+XvPTqSKNGjzyo+Xg82Pz5RbbEBQ/tDVJn7RGT8Y2DSAc
	S5VJh/gAReUt2YWUrHLEsIzG+4jBJ0K/1dL1r1BH/cBbyMAGMlAi5rmA2+Lapg==
X-Gm-Gg: AR+sD13heSMZN21flUPbd+ngaoISM6FIkr4iwxXgaFWqGh3aLc+6Bras+Sh2zeCVsIF
	2gXh5e95IqWskM17Ddc9nFyu+SHtdXzd5qfCZco7+eseVlK0pc7NQTLeTqN4SW8aEMFjoSqijl4
	QLeva9RPpQNgolOMEx5WZ5IyCNTqMCvjA8CNmcevj6XJrVi/WcjBCjhWSpdvPIOyjD4VMl0vtsx
	3Zx2C1fo1OBl6yD99ZtzzD+EYK5w3Wxh3huPYgT5YZhC3zN2qZ6yUTsGbTSg24uhL/xiMbuJUj4
	TM3PQ6jRqbSUkbs4rx+xAY94Fy9SeQrPA5vjOxm+b76JTvvDGcHu3t/RSbGaclweCiTRFrWEx0u
	5qMLbfb0947rWB1C/hUUQ15lPNKbuBL8n0Wkmf9miK1j4uAoAjfEGQx6dqT7MgTMBhDBIGV7qN3
	Yi39+Z416oaQ6jQFB/+lddhfab4VvnocI1Veczf2zMGTeqk0y4AoAJrMxtv1Jj2qX57k5MpG1CV
	lS4Cvlsnoh63FAdAeySpGkK5LTerbhu2EXJVA0utNa9ZzoMpgtIbOnsY+0=
X-Received: by 2002:a05:690c:8e02:b0:7dc:1c56:2901 with SMTP id 00721157ae682-825eab49651mr32403537b3.1.1786204362134;
        Sat, 08 Aug 2026 08:52:42 -0700 (PDT)
Received: from willemb.c.googlers.com.com (250.4.48.34.bc.googleusercontent.com. [34.48.4.250])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-823f79a6c6dsm27839747b3.48.2026.08.08.08.52.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Aug 2026 08:52:41 -0700 (PDT)
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	andrew@lunn.ch,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH net-next v5 4/6] selftests: drv-net: refactor so_txtime errqueue handling
Date: Sat,  8 Aug 2026 11:51:42 -0400
Message-ID: <20260808155217.885299-5-willemdebruijn.kernel@gmail.com>
X-Mailer: git-send-email 2.55.0.679.g6767b8d81c-goog
In-Reply-To: <20260808155217.885299-1-willemdebruijn.kernel@gmail.com>
References: <20260808155217.885299-1-willemdebruijn.kernel@gmail.com>
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

