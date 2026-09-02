Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E94149CF58
	for <netdev@vger.kernel.org>; Wed,  2 Sep 2026 18:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788373079; cv=none; b=unOf1R50XW2nTW8DT2+doVwsW0CBP6soCBqDmGmulZ65O277rszhnqt91RXq/MMMwsn2Yf2JNsr6ZiK+HARn6NB1y3KhyM9nh1RNU6FWC5hFy+sRQ1fa9c3oEzr+emAn8vUdv7R0efjYE1yDq9TzNAoY2RJMmsGX0Es32jQbKzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788373079; c=relaxed/simple;
	bh=/K2b/LsF3ZsWT34g7LwBdBGIvrDuTyW41uJKyhBPr7M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ioeeFKkJEuCoYHjcy0mmAluOqzxaJ4FlrcrZaebqW6CCXbLVAujqaUnrT25whZmbHvxIdrwBc1+7SxDW6BJh3coWLIdY3FgKhZNzt2NbS6WAesVOONqB6jV04rrThbu++hxkyxEw9+yj+gW2bK/H9FFpS0Ma6Ou/O3NMg9WBdHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IsohMBAO; arc=none smtp.client-ip=74.125.224.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IsohMBAO"
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-66d23c88af0so624399d50.1
        for <netdev@vger.kernel.org>; Wed, 02 Sep 2026 11:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788373077; x=1788977877; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gtovMHuOb8HgDT0RLGSjseJL+D3r5qsUSpQzM0DLRbc=;
        b=IsohMBAOHLCty18j4vPHJlylVeMjXyeKVeMnc4TYVYU1WOw4yEBS3J/nLA6ypStzWL
         JC2P87LbFY37BofVMxrNsZPy92VE5TTdov/TBR0x+DtZZ1l1UbvofSOwQMrG4PE9VffW
         nbMnS5vjTNk/0t1wF6crZO8QJ6PO9O233T+h8yJg31ziVJuBuemSB58EwHUs3MRVe8e1
         AJhB8gJwskwbrY5z6YW+TpnyCk6xOFCDO2WjznTuU9RuWx4LMHPguudU3ALLhXElY+6N
         QkgaAkPc/Fhe9Hedaal887sNrS8x6IhL8zbYdZ/VTT0TV6Xaq7v5DQw2LmqMB+Ls5J16
         F4bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788373077; x=1788977877;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=gtovMHuOb8HgDT0RLGSjseJL+D3r5qsUSpQzM0DLRbc=;
        b=Ar9syACK3IlFwP+ec2Tuf6xtvbhH7aEtHOBHoUawfeD4+XQ9fRlIZNqcpVpC/r1kCD
         k7d544bao5nwEdQDcFgRBsEVN43OkA5JwB9qkLb+0vW5wpU8Ld6cR7L6R4DhFWCeMLPC
         PM2OFdyv7KalPtpsq7j06SMchodfOPi7crXExiua75/Ro4zhDdwfS/GH4UsYR7vsKhG0
         AaVkYs/cYhcyvjYLJx0ejPZosYDl0QHVe9bBmh+FLlJixQBhdbZTL17b/XaKoKXNX5MR
         MxDXErJwJhQotN9bZo+0UnwqfTg2xcIiXG5/c/cLPDwtegrIaDMg21+6MSh9/8MMyDLV
         TXLg==
X-Gm-Message-State: AFuF++kOoOzAhr//h1JFmuRnjgycx6Nly0Jt+ZV/SIT9V2YkaAFY5EmN
	NCGLEh/ue5x5OUXSV0VOQIXwMGk5L6QAAUjoHl87e8Uo+nBOQt56guOH03RV6g==
X-Gm-Gg: AYBFou1LtuZQFg6cu97KMoQfx4IP3iLmZ06yQpbQcK//jmpn8flpdtDfk0sMxLcl5Qc
	OrKtyaOjidFRZUuVX0RW5HVaXhxob9bfJZjc1oPZtnudlG+dkt6+QYFl87UHhuSduuHgH0wPzc7
	oo0OaKRVsODvZXqeFaXAjjQveC3a7mcvEZTTgzX7J48GBjq9SiynW4jx9bWXEti0pF12tPW2YXA
	HuHtz82NBvGRyK2fMgaY1pUfs6vkSgqgXLE7x3TiNHmdWTdCzAD50jqSuMacMwmNgHeT5Tv7aad
	v+NUitZ5oIIlpqkf2VYmYim2kH24RRYTefeCj/PquMeFC8kF5JOy0WrzT8BUuaYPiDr3Z1pdilT
	ZV18dFmOrweTBi6d8L1dHxtnH9aRe4w+y2rplob1kM8ytvaFoDLAzPTBxktN9qRFFdz7OCEzyRE
	WyMIkx1NhzLfnxTpXgQdFCLCL+VAi/l4VWV0qjZqE3E8L8kmm3Hc0yNbHekPdHHpoL1P6w7suAo
	dUJOvpFqfMtiB3/QR05ncxEOwpvVAwn2Nb5fGGo0k9Igrb9sWFyDDjN4rj4xeim
X-Received: by 2002:a05:690e:1646:b0:66c:85e3:7f2e with SMTP id 956f58d0204a3-66f9bd3bf4bmr1827543d50.36.1788373077005;
        Wed, 02 Sep 2026 11:17:57 -0700 (PDT)
Received: from willemb.c.googlers.com.com (234.207.85.34.bc.googleusercontent.com. [34.85.207.234])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-86c1784192bsm23162297b3.30.2026.09.02.11.17.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 11:17:56 -0700 (PDT)
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	andrew+netdev@lunn.ch,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH net-next v8 4/6] selftests: drv-net: refactor so_txtime errqueue handling
Date: Wed,  2 Sep 2026 14:17:14 -0400
Message-ID: <20260902181747.2483351-5-willemdebruijn.kernel@gmail.com>
X-Mailer: git-send-email 2.55.0.970.g62bdec98f9-goog
In-Reply-To: <20260902181747.2483351-1-willemdebruijn.kernel@gmail.com>
References: <20260902181747.2483351-1-willemdebruijn.kernel@gmail.com>
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
2.55.0.970.g62bdec98f9-goog

