Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794188681;
	b=2G6/UUJX+DJn8dH+R/JtcFipXOuMXTKaf4UD1iF9HfT4jqOKN1Ocbr2s9kSaaYTj7hs3
	 ijI2FEeFRnOXvW9JDfz+S7S0VxLbSWk2uajdB3tN6Y1n9K0TMAgry1IwORhtRGvVpYQL0
	 oVMK7vJCRTU4ZKF81HDUOWCD2BitDKR/UlPtlH2By5Bq3eezPTNTiLjF2AaXN+UHf37Pa
	 NB2FOcpAleCyd+uukxEunP/+EuqHM2DkgXUCo/lvgUuWmGK5OXvjIlGQ77l+c5vKtcJeG
	 ssUaRa4a1wzQGXevlReW3mXIReAU4msaWtODRh03cyeBpNpTtzbccsTgMHI/e95u6Qw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794188681;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=T4cq8BA6d67ZhkILk6j1pw1IgPyeHdcn1eDH4YrEp7U=;
	b=pmiViZVAE36CWv1ItPZT2Wy8wWgr9impa4FyILaP6k3qWoRdrbyj1uEQbKzO+73nLqrP
	 TsPAP5r5RPnPWdgq6h5GhpKNBn7IVXVzf2B8TEO9y27cAnJ2bg+rxW11SaFjrDoe2SI7N
	 HYMav7Vl88zUBz1I1BfmYlwrppnVq++jqnLZRSGdFFW0uMaNiFVhkdIHcIGsElL//zQDu
	 05IjHtuber8BWHdAVpFY27govJhVB7ALD12wHM0JvaduH8EvkjoZgoCoY/NwfxM288awS
	 Zu+JKCJrCP5ZgC2K1fdhKKPpG+YjxeedGiJhxGFW/0W/TId9SjaBOkX7+X4/58q6YPQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=networkplumber.org;
	spf=pass smtp.mailfrom=networkplumber.org;
	dkim=pass header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=UUs+VE1N;
	arc=none smtp.remote-ip=209.85.215.169
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9595D606D804
	for <netdev@vger.kernel.org>; Mon,  9 Nov 2026 01:44:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9595D606D804
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=UUs+VE1N
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-cd6acc50b8dso81955a12.3
        for <netdev@vger.kernel.org>; Sun, 08 Nov 2026 17:44:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20260707.gappssmtp.com; s=20260707; t=1794188681; x=1794793481; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=T4cq8BA6d67ZhkILk6j1pw1IgPyeHdcn1eDH4YrEp7U=;
        b=UUs+VE1NGFaSommwKFf0IKlVy5NMRB0DjboPn816sKmoZTQki5sYmeMQTtpeveK979
         eQIl449XBLwMnoQB75+fzDT7cD9Ys63mIKW67rJj6lHet/ODXIUnzbxDqUGdP94QpRpU
         9U4asCvJnjOEzJZoO20CfCcuJoo+AUIXY9VyoGSy+cUSrnDU9PPTK2+PgU++nWYKQndJ
         c4H+Y/+RaH2j5vejXoJAxUTOg5a8EKDa+KPvJ6mDx3HW/KzLtQCfgvvlJN/sMspynjrd
         ORLSXIyebK/x1UJxWi1yKsdKr2FiA1f+sNhGsDKzsJrn8y0RuhhmeQhRPcdaBxGh57tZ
         oABA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794188681; x=1794793481;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=T4cq8BA6d67ZhkILk6j1pw1IgPyeHdcn1eDH4YrEp7U=;
        b=wHL37NOtU0BbwTG5Rsb1JcBc1IE2Jmv6YCydH8VpwAyTIDLjkXrjTlMzEJAfCD5rD7
         Qe4GdmboLKAyyB9c2pFKFES+Bj+9CxMvz0oSMk09/JwZAI8kG1ghl+itzMKUeDm9FNEI
         icqYeNqnPNuC6pDio/RoWhpYZIadJoS6IZY9pCOLy9uQU0utiXIzVwpKmGR9/Fd+bpev
         pK4iGnNa//1+frxHLlhXzrDPXlwrpEcsgcdvxamA3aaR2nN5//eQ7JOFf1G5K3Hiz+Xy
         Ea1+sVobRiyrHdxNZI+D7WOcnytOheloUnZVCr+a4LDqmdC2xsKsN46bBafqQZ+NKoAO
         ujmw==
X-Gm-Message-State: APuU4Z+6dkXgvyrOeejzXMrSJPXWCi5AiSr9RYkRxAZhm1x38Dy5hImT
	cVWMW18DiPUKAEnxxEztqsErtK2bbty5r/6RfMMzQX3C5YCcI1BYY1KKDerNobSuQAOLp53SgDK
	7y9u3rKI=
X-Gm-Gg: AYBFou1/VDfkTDvc0p/DtWJE5g2X201DhYbZeyIjU8f8cknW9oEQPuv8R0pkxq0Cesx
	xInvnvtJYuhX9okr6xHSSBDH0tdY0bLwQfw13fzuCux5WJPAtFNqnMnlRONG20exh9COIXHryb1
	iyopshtEqhZBkP0w67FKvR9Eae6KMBBDE18iUibr02yyHWngY5yD3Ks2zTTruDywQYoGTN+TGTw
	2YPj2T0w27LnFBtGrWLUvs0g+bHTxK/jpcmLwX8jr80amINz5Mpk/lJ16jWmX5QRMoZlf97pkqM
	CL/lz+bW8ynK8zFnxaAdkAMRNGuParuIawy8lYBU67bEJwycFmZgmZ91992V0BotcB5OZFA9MCN
	w4SQdOhNSUgB2ty7+up0psVEQ7wRyF+Qs1+l2Ns4pvkdlVScoIIqenUHv4Yhu/wMoDYazoe0tPi
	7AlPH5yPQv9dfHPWdmSezWJxW8uu/cFvou01y0up6oEIJERGXemKbq0HDrloK41bQf/0tnJc00f
	4/HnmBGNnqdyDKwokGjEMLQt9rEmEGCcE+bw9/NQaolM5RtF38LOtLCD9+fQxtKLU4txBQHoyOH
	kcC9ghi444gfzlLMMC7zivMuKCHT+7Ffyf1PkfMYTmEs3tn1EDHgxq7dyehWXZZR0DCEFhg=
X-Received: by 2002:a17:90b:1e50:b0:3a7:250:333e with SMTP id 98e67ed59e1d1-3b12d3302b4mr2534279a91.11.1794188681040;
        Sun, 08 Nov 2026 17:44:41 -0800 (PST)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b0fc1bc1e6sm5641735a91.0.2026.11.08.17.44.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 17:44:40 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: dsahern@kernel.org,
	Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH iproute2 4/5] netlink: handle unpadded last message in receive loops
Date: Sun,  8 Nov 2026 17:44:01 -0800
Message-ID: <20261109014434.115922-5-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109014434.115922-1-stephen@networkplumber.org>
References: <20261109014434.115922-1-stephen@networkplumber.org>
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

The kernel may send a datagram whose last message has no trailing
padding, for example Open vSwitch upcalls with OVS_DP_F_UNALIGNED.
Subtracting the aligned length then leaves the byte count at -1..-3.
__rtnl_talk_iov() and rtnl_listen() compare it as unsigned, read one
more header past the datagram and exit with "malformed message";
rtnl_dump_filter_l() exits with "Remnant of size -3".

Walk the datagram with NLMSG_OK()/NLMSG_NEXT() everywhere, and treat
only a positive rest as a remnant.

Reported-by: Anthropic OSS scanner (ANT-2026-S4ZHKVIW)
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/libnetlink.c | 76 +++++++++++++++++-------------------------------
 1 file changed, 27 insertions(+), 49 deletions(-)

diff --git a/lib/libnetlink.c b/lib/libnetlink.c
index 6432d537..de0681ac 100644
--- a/lib/libnetlink.c
+++ b/lib/libnetlink.c
@@ -994,7 +994,8 @@ skip_it:
 			fprintf(stderr, "Message truncated\n");
 			continue;
 		}
-		if (msglen) {
+		/* negative if the last message had no padding */
+		if (msglen > 0) {
 			fprintf(stderr, "!!!Remnant of size %d\n", msglen);
 			exit(1);
 		}
@@ -1088,29 +1089,13 @@ next:
 		if (status < 0)
 			return status;
 
-		for (h = (struct nlmsghdr *)buf; status >= sizeof(*h); ) {
-			int len = h->nlmsg_len;
-			int l = len - sizeof(*h);
-
-			if (l < 0 || len > status) {
-				if (msg.msg_flags & MSG_TRUNC) {
-					fprintf(stderr, "Truncated message\n");
-					free(buf);
-					return -1;
-				}
-				fprintf(stderr,
-					"!!!malformed message: len=%d\n",
-					len);
-				exit(1);
-			}
+		for (h = (struct nlmsghdr *)buf; NLMSG_OK(h, status);
+		     h = NLMSG_NEXT(h, status)) {
+			int l = h->nlmsg_len - sizeof(*h);
 
 			if (h->nlmsg_pid != rtnl->local.nl_pid ||
-			    (unsigned int)(seq - h->nlmsg_seq) >= iovlen) {
-				/* Don't forget to skip that message. */
-				status -= NLMSG_ALIGN(len);
-				h = (struct nlmsghdr *)((char *)h + NLMSG_ALIGN(len));
+			    (unsigned int)(seq - h->nlmsg_seq) >= iovlen)
 				continue;
-			}
 
 			if (h->nlmsg_type == NLMSG_ERROR) {
 				struct nlmsgerr *err = (struct nlmsgerr *)NLMSG_DATA(h);
@@ -1156,21 +1141,23 @@ next:
 			}
 
 			fprintf(stderr, "Unexpected reply!!!\n");
-
-			status -= NLMSG_ALIGN(len);
-			h = (struct nlmsghdr *)((char *)h + NLMSG_ALIGN(len));
 		}
 		free(buf);
 
+		/* negative if the last message had no padding */
+		if (status > 0) {
+			if (msg.msg_flags & MSG_TRUNC) {
+				fprintf(stderr, "Truncated message\n");
+				return -1;
+			}
+			fprintf(stderr, "!!!Remnant of size %d\n", status);
+			exit(1);
+		}
+
 		if (msg.msg_flags & MSG_TRUNC) {
 			fprintf(stderr, "Message truncated\n");
 			continue;
 		}
-
-		if (status) {
-			fprintf(stderr, "!!!Remnant of size %d\n", status);
-			exit(1);
-		}
 	}
 }
 
@@ -1294,38 +1281,29 @@ int rtnl_listen(struct rtnl_handle *rtnl,
 				}
 		}
 
-		for (h = (struct nlmsghdr *)buf; status >= sizeof(*h); ) {
+		for (h = (struct nlmsghdr *)buf; NLMSG_OK(h, status);
+		     h = NLMSG_NEXT(h, status)) {
 			int err;
-			int len = h->nlmsg_len;
-			int l = len - sizeof(*h);
-
-			if (l < 0 || len > status) {
-				if (msg.msg_flags & MSG_TRUNC) {
-					fprintf(stderr, "Truncated message\n");
-					return -1;
-				}
-				fprintf(stderr,
-					"!!!malformed message: len=%d\n",
-					len);
-				exit(1);
-			}
 
 			err = handler(&ctrl, h, jarg);
 			fflush(stdout);
 			if (err < 0)
 				return err;
+		}
 
-			status -= NLMSG_ALIGN(len);
-			h = (struct nlmsghdr *)((char *)h + NLMSG_ALIGN(len));
+		/* negative if the last message had no padding */
+		if (status > 0) {
+			if (msg.msg_flags & MSG_TRUNC) {
+				fprintf(stderr, "Truncated message\n");
+				return -1;
+			}
+			fprintf(stderr, "!!!Remnant of size %d\n", status);
+			exit(1);
 		}
 		if (msg.msg_flags & MSG_TRUNC) {
 			fprintf(stderr, "Message truncated\n");
 			continue;
 		}
-		if (status) {
-			fprintf(stderr, "!!!Remnant of size %d\n", status);
-			exit(1);
-		}
 	}
 }
 
-- 
2.53.0

