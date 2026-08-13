Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DE8733937F
	for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 02:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786586754; cv=none; b=sc6XiVY/eF7uatQXOIdidJ7QNXfrFNselpuOR9rYzBwZoEdaZEFjK6ajdSZuSm7nb4dlGPMmpJQXJIK8pZc8AcFFV5KLGESBWd+vOGA9sPxza9kY3G7OoS1Cz6Ga4YAmKU/ERn0V/rNVRckNhR/zStirVKkp5oOdQQro/szj5EM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786586754; c=relaxed/simple;
	bh=CDQMD0acIv83joxmn2KY+EpmmLptEworu3xezWguKo8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UnHpkyWV1yXCkgOvUCoTYtsO1zCeubXRtWMG63Mdq+ui3pK/5G/x3RMLLPseFmEOCDzyJ+Jz3V1oMQlzThRyaCAZfz1txTf8iqGiGZX12w4w8O6ZxN17bCLwbb4f9HCxhTI6JYWvyVhrza3wllzwPyRvkvtVvzjXA0mbqxm4Gx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QkNFKfoo; arc=none smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QkNFKfoo"
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-6688acd1a51so2633800d50.3
        for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 19:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786586751; x=1787191551; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AayXFEH20nCWAujrRYCVvAQwSYl6NgBjhpGJTOaXFV0=;
        b=QkNFKfoo90OF05x467oznUKUt1hCXmI2qISQoGiYvbc96LqwaoJPlb1RLQ34s6YQ+8
         MW/Rd0tB7XsF7HbOzasvwYER6B6uL3jDdm0A6m7SsnIGYpHdFP3KM2EIKVxo+hCABMjs
         cxrsUGUq0A6x0OjNqjkk/eL0dDJv6MR0AVkg2rneaJvXniyJ2KBfiA7KC1Hz3Z4SyQ3l
         rSXiV5MajsJuFs7AZn3hpCl9JpHenQ0Uc8+TG4rytwB29yNr12gqjxy6CQoSg9fCeEM7
         K3qVpB5C1+j8E45c/UlSSXiF/kzWemrs16rZcB84i1Um2HhrAPi0LG2fbH926M2zXmTB
         cUWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786586751; x=1787191551;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=AayXFEH20nCWAujrRYCVvAQwSYl6NgBjhpGJTOaXFV0=;
        b=f6U2LVYSJ5rXrZQpGWIqd2ilsdEtOjkj/JYR4hXIu5YhiH7Kjj3me8iNu+fszY/BGl
         OLutyqr/epdhF+97EFl5y69PEuBMrcReEYcp5qoPvYUSeWH7urZWfEvY+ixlyYm5Yi1b
         qowVPdcxuU+6yHhYfApyGTnYR02Pg3VvgGsGtzD6DkhGnd219hXevKdRKwNyYCd6Sr4j
         9kc9n2LD6BdVX9+EmwKoqrUHj/DhfpmRhuruilV5zdkeeZ/NrYArJxyh37bHBZayy2LB
         zUVPU4TUO2dsnc93rW9d1HkkSDhv6lN37c1fhD+/1vD/l169FXnLHX+hmLRkMABfLI3g
         Obsg==
X-Gm-Message-State: AOJu0YytrPAJI2gGefmxX4QH8ltSb1LX6WiCJVNKZady/SzwAW59mQKh
	/02gZtf5+m5dOL3lbBgFPoi4lRim8kPkbOCqvEc/EmZBcyIOObEvrBFfSTJc9g==
X-Gm-Gg: AR+sD10YtQJDnL8/AguIV7S/gma0hQTOSgZEWH1EoRnDfZKvywAhUxTfVlxvCZEaTUC
	i7OH0eTbM7AgxARFY/X9VnkwwhbV7H69W7OUmniivVNdBULDsy/1nboJymlHV11xzkJMh48HfL/
	RS0GF/DHPSr/yO9iX3QVksFrdrapN43bQHRIq+69/uxyP0PWc/a3w9zXYgDXtSr8+9d8XgQBMz9
	PCiTpTz16HpGpE/EHfP2kkY0zTGobKhu/KTZiGjtty8sFF9Xj6Sh+xSEArVBIfsVYdV7tHOVQNB
	Xxl5wCIowHN98ERJnyaph86TmEsCMEwX7ko8BaXT1rZG+jxeUT52tPEsMlxE6iK2gth5Zm2a+0A
	3UZ09WEL0GDaTIGPcpGpcvGcMEd5aSS5HnsCXVSIjFV6tUyGcszoPnq9cAIDBBiISdtLmp38A3r
	gQdJclP2VL1C6v7jw0aem/Bo9bn2cP/fUPLKOaw7B/WCznXHSCKKCleBTxKEN6IZzDPu8AwDHrM
	3E9sY4xV1tW8GEqI5zU+2Ww5sxI6KB5l1bCerpRWmHRE+Htbdgm6SjhK9A=
X-Received: by 2002:a53:b9cf:0:b0:66a:c3aa:48ed with SMTP id 956f58d0204a3-66c5147184amr878655d50.11.1786586751309;
        Wed, 12 Aug 2026 19:05:51 -0700 (PDT)
Received: from willemb.c.googlers.com.com (250.4.48.34.bc.googleusercontent.com. [34.48.4.250])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66c56e74870sm226899d50.6.2026.08.12.19.05.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 19:05:50 -0700 (PDT)
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	andrew+netdev@lunn.ch,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH net-next v6 4/6] selftests: drv-net: refactor so_txtime errqueue handling
Date: Wed, 12 Aug 2026 22:03:59 -0400
Message-ID: <20260813020529.3506539-5-willemdebruijn.kernel@gmail.com>
X-Mailer: git-send-email 2.55.0.691.gc56d675ccc-goog
In-Reply-To: <20260813020529.3506539-1-willemdebruijn.kernel@gmail.com>
References: <20260813020529.3506539-1-willemdebruijn.kernel@gmail.com>
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
2.55.0.691.gc56d675ccc-goog

