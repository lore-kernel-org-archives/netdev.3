Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47FC53F86EF
	for <netdev@vger.kernel.org>; Tue,  4 Aug 2026 02:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785812378; cv=none; b=ZoZH8K+tjuO/jfsxt6OJwbtrqSfFQJX4jdwy5z/VikzxuPDkhVXKdUvnTrT2NIFLb7t1sSZEfOXmTTw1zayhzEJVHSlUArEInTUHSNrx7IPN1QC3pME10M2QwcbVT0glh4U2jpt4i20VYWuQzIio4lcG+R7UQNzQeH8mfbRTjWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785812378; c=relaxed/simple;
	bh=kGHg5dJxMvflgLmIQwKaqqixfYXyjBoPcjsJhN7I9ys=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uK7ZP4pJKHbXipL2gihQzx3dL3tkeqGPKWlm/WpdAy+AsCBBPJz0FTBwA5TD8H8eu7gymjoiJQeaUKQtO9ibWHC45dthCcSXfZi7bftpqA312lLQEgFQgffHdqnkppGcbTJ5EQzumx896ENvnmLAuHosxiJ57b1PpwUnjEARUnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DyXTQkr/; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DyXTQkr/"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-c9cf07d2df6so3082488a12.2
        for <netdev@vger.kernel.org>; Mon, 03 Aug 2026 19:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785812376; x=1786417176; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QkQ333WBrChtciSILIhBH7Fyg9DmGWGZdjGTMAJJv4M=;
        b=DyXTQkr/8xC0usDA55oPDLTk+SbM0KXdIyo0Eh10qwsLOBND6x5lWiY9cxhgdMKVw7
         bkLsjl5QlK/xDVaBUKqiwU2u9d/dhK7mmpmtrIc7UGSsr1IuCsg0N/5T+ama6OOPMXkZ
         Xjy8UI2YHKQZ6iRqE1imkBnk38aHKV7c5kskoTVyUleAgBy67WNw8TX4ZON4Gv6OiXkd
         xWL7di0sFDMRJYNaNOxRJc5rQCWRr+rapGONzwxvMOWv0nzUd25TcV6wRbYe0qzmdBVs
         aKE4VxrcKq7f250754maIlAgtHvpo1J7v20Z13DRA9we1YoTo1tuCM91r+cA4iZda7V1
         w+0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785812376; x=1786417176;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=QkQ333WBrChtciSILIhBH7Fyg9DmGWGZdjGTMAJJv4M=;
        b=fITOWPqnooi0kWvV3IcADBSSU9eIItqUpq5eSDSVdvEL0ave99K/g3MhxNKOPlcdhF
         r3avFnQf+Qzg8d3CYkoFuojA9ILWnl6xS6TelUCAgKGPwwXqZE8hnrg1oU3iQ7fvXkbo
         pWWgx8AecrTL9BlNS2eKgV0EbbycSVzjB9hqfd07c4WlAxBOvRG9o/Gpcp+ytFaFR7d4
         KI/vFltSOYRWVynLfWb4OABgwFOLjMALUSzeO90W7Og1kYFrX1tsMtVO5zN4vRWcNmR1
         zwq9CY0XV3CG37E/QjXRQ7Cul0knoBTS6I9p7LYdqtlSQFWVZGeLPRHgEXYAtEYGOMjz
         eS5g==
X-Gm-Message-State: AOJu0YwlGe5TuthPo+7prRxmObu3FGEsOoNt8cCl7PuMhWVgs5GGWblH
	jnDtpcTc/2fYQYJWQZKyZ24ZHXvalL2OmGj54wlu+5zRMIOjoIR4NwPIUKIaCCnH
X-Gm-Gg: AR+sD1125cOjCCXRWKOMNyt6GYiU0SW3YB2oPhviduFDTIt8YTnw75x51SFHRpE2v9E
	/2po+/miAMlOBBomMwCSLagc8jDG6BKE+6lRenLdEji5ZDI3a/ePbNe0r9reOqbfWui6QmqzKKr
	m+JsupssGbYf2EyE/SgGFJ5dlsuawowkW5Lgc2x5+3a8eoK+5OSdDKJUXCFqVaz2MpcVxjOWxiX
	v21+RN5CgJaiM5s6d4ilwK8akGwiATTto1uCobED+TRHGwDbNvnl3IV4pQkUcqBVvuRbd0Y3oAA
	Ph6ZV7HqUVsyKQ0BNsChVTPRziADxWtlICEeP5pVTFrkbzQuHCiUCbOAbLoJ7hg0p+Pf1KLs13+
	opuE8b4UxmnLWWcaGD9gq2rAiME6gJLcrJXGARsjWju6/OwNwGZTbIs9XCBb8Ss7TZ10N7EYuOr
	Y7Fv8BHXUqH6HppINNrvZpQrzVLRinySVMHFRJDOvnbo7FPmZTdkwUM8OHwD51SdtezA==
X-Received: by 2002:a05:6a21:9206:b0:3c0:9c18:d5a6 with SMTP id adf61e73a8af0-3c92a8cc15bmr12885686637.67.1785812376564;
        Mon, 03 Aug 2026 19:59:36 -0700 (PDT)
Received: from fedora ([2804:1b3:a8c3:8ee5:1c39:64d9:e257:73dc])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13fab2530c0sm35974758c88.8.2026.08.03.19.59.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 19:59:36 -0700 (PDT)
From: Marcelo Mendes Spessoto Junior <marcelomspessoto@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Marcelo Mendes Spessoto Junior <marcelomspessoto@gmail.com>
Subject: [PATCH net-next v2 1/4] selftests: net: test IPV6_FL_A_RENEW
Date: Mon,  3 Aug 2026 23:59:07 -0300
Message-ID: <20260804025910.50145-2-marcelomspessoto@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260804025910.50145-1-marcelomspessoto@gmail.com>
References: <20260804025910.50145-1-marcelomspessoto@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

RENEW was the only flow label action without selftests coverage.

Assert renew returns no error on correct usage and fails for labels
that do not exist.

Based on the previously implemented EXCL share test, that demonstrates
that a new flow label with same label can be created after the linger
period, use renew to show that the flow label can last longer and
block a new flow label creation after the previous linger time. This
test, however, demands sleep during execution, and should be placed as
a conditional test under the -l option.

The addition of expect_fail_errno helper is necessary to assert the
corresponding error when a function can fail on multiple ways.

Signed-off-by: Marcelo Mendes Spessoto Junior <marcelomspessoto@gmail.com>
---
 .../selftests/net/ipv6_flowlabel_mgr.c        | 44 +++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/tools/testing/selftests/net/ipv6_flowlabel_mgr.c b/tools/testing/selftests/net/ipv6_flowlabel_mgr.c
index af95b48acea9..01fab414895c 100644
--- a/tools/testing/selftests/net/ipv6_flowlabel_mgr.c
+++ b/tools/testing/selftests/net/ipv6_flowlabel_mgr.c
@@ -27,6 +27,7 @@
 
 /* from net/ipv6/ip6_flowlabel.c */
 #define FL_MIN_LINGER		6
+#define FL_MAX_LINGER	150
 
 #define explain(x)							\
 	do { if (cfg_verbose) fprintf(stderr, "       " x "\n"); } while (0)
@@ -42,6 +43,18 @@
 #define expect_pass(x)	__expect(x)
 #define expect_fail(x)	__expect(!(x))
 
+#define expect_fail_errno(x, e)						\
+	do {								\
+		int __exp = (e);					\
+		int __ret = (x);					\
+		int __err = errno;					\
+		if (__ret && __err == __exp)				\
+			fprintf(stderr, "[OK]   " #x "\n");		\
+		else							\
+			error(1, 0, "[ERR]  " #x " (line %d): expected errno %d, got %d", \
+			      __LINE__, __exp, __err);			\
+	} while (0)
+
 static bool cfg_long_running;
 static bool cfg_verbose;
 
@@ -71,6 +84,17 @@ static int flowlabel_put(int fd, uint32_t label)
 	return setsockopt(fd, SOL_IPV6, IPV6_FLOWLABEL_MGR, &req, sizeof(req));
 }
 
+static int flowlabel_renew(int fd, uint32_t label, uint16_t linger)
+{
+	struct in6_flowlabel_req req = {
+		.flr_action = IPV6_FL_A_RENEW,
+		.flr_label = htonl(label),
+		.flr_linger = linger,
+	};
+
+	return setsockopt(fd, SOL_IPV6, IPV6_FLOWLABEL_MGR, &req, sizeof(req));
+}
+
 static void run_tests(int fd)
 {
 	int wstatus;
@@ -160,6 +184,26 @@ static void run_tests(int fd)
 		error(1, errno, "wait");
 	if (!WIFEXITED(wstatus) || WEXITSTATUS(wstatus) != 0)
 		error(1, errno, "wait: unexpected child result");
+
+	explain("It is not possible to renew a label that does not exist");
+	expect_fail_errno(flowlabel_renew(fd, 5, 2 * (FL_MIN_LINGER * 2 + 1)), ESRCH);
+
+	explain("Create a label for basic renew validation");
+	expect_pass(flowlabel_get(fd, 5, IPV6_FL_S_EXCL, IPV6_FL_F_CREATE));
+	explain("Check if renew does not return errors for existing and valid label");
+	expect_pass(flowlabel_renew(fd, 5, 2 * (FL_MIN_LINGER * 2 + 1)));
+
+	if (cfg_long_running) {
+		explain("create a new label with FL_MIN_LINGER linger time");
+		expect_pass(flowlabel_get(fd, 6, IPV6_FL_S_EXCL, IPV6_FL_F_CREATE));
+		explain("renew the label to increase its linger time and put it");
+		expect_pass(flowlabel_renew(fd, 6, 2 * (FL_MIN_LINGER * 2 + 1)));
+		expect_pass(flowlabel_put(fd, 6));
+		sleep(FL_MIN_LINGER * 2 + 1);
+		explain("The label cannot be created because the new linger time is not over yet");
+		expect_fail_errno(flowlabel_get(fd, 6, IPV6_FL_S_ANY, IPV6_FL_F_CREATE), EPERM);
+	}
+
 }
 
 static void parse_opts(int argc, char **argv)
-- 
2.55.0

