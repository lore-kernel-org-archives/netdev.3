Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794472879;
	b=i+OYbXIh/TtQszqVvN67JsZroO1pP1mdDmaMs+zTgadtnen9uEESq8Od+olSM7dKfThn
	 8vcsmSPa0OdnZJOArU5lJ9x0uQY3RWIPrVZBiEqu188lcY1FNZU5HE7TlOrCxvcmKj7UI
	 BSwQ8f2l8l286ps0IkP47z6pASIuK7OCmOeaWpt4TTi5xyxSzfhdMmZE8mYvJ8nzO6Rc8
	 BYMC319fXGbnmrvldRUbxXMXj8KRHSuTaM5Iwl/m2T2k9MFWSp3/SZD7Rt9rEwiYdkUOY
	 SHPqJAfFxpgUriInac/wckLtImgvXbDK/bYCSvbWQLRJOVPap3TrVb92lIy0aop3YQQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794472879;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=Uq4VXy4AF5PJdRxnkQk5LCfQupPmt0sewxk8SmZmqhI=;
	b=mWGGDIDVtz7xAmSkutc4OuJAOxVy3g7c5CIFtouKD77OmfwB45+GE89eSKMaC9WuNohY
	 d8dlG3mTJ0G0LWee3biBscQti20wKmEa7QtxaE3KXR247f9XmpnMoWZcu9mTMkMy5M+tE
	 DH5YP5qCobMsCtYtrqVMB7avU/nhip2NkgDyCG9SGCGKMvhEeLPGW+2kSmxBKhle6sJ3U
	 /OUCa6kXy3sc073qnsrKkyxvnp5/i+n7UjPMNbMFlaBVSWijgc0kHZQtMGbJHVSNLZAhe
	 r0bbqi7+thVwftgg3SomLLlDio5xd1gPLWXWBCyodwrdRi09eLAaDepoCcoVLCmhsqA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ojab.ru;
	spf=pass smtp.mailfrom=ojab.ru;
	dkim=pass header.d=ojab.ru header.i=@ojab.ru header.a=rsa-sha256 header.s=ojab header.b=AJnDbTL+;
	arc=none smtp.remote-ip=209.85.167.44
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F186606A31C
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 08:41:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5F186606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ojab.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ojab.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ojab.ru header.i=@ojab.ru header.a=rsa-sha256 header.s=ojab header.b=AJnDbTL+
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5c1479be604so2809520e87.1
        for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 00:41:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ojab.ru; s=ojab; t=1794472875; x=1795077675; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Uq4VXy4AF5PJdRxnkQk5LCfQupPmt0sewxk8SmZmqhI=;
        b=AJnDbTL+42SSwf646z1g8TSDMZ0HRnyAh63KI3uiDFPWdhD2BYnjTZealAGzCgzShj
         LKgbxLQVaVLBh5m68rT+t9+VF8hM6xBOJFP8wVLWWanS8xp3/uGb9pWo5dgL9r9KeDOv
         Xn0GF/RaPJoxxHWJeF8eRRItB+Qt3V2cyS/Ymc78CVLETgQ7ZNEUGDnnyv+KDqxpR2gw
         wgL8YcHyeLYvuRn/DMCPWz+MdGzfmGeJLSlcsdRxIKT0uLamc6XNP+3VEjLmM5Sq6Hok
         yOzp3CDdrzF/AI1oyzRhdDaTGu/9AcYQ5RtTBM9BZx/R8HjDrsmeLCFeMLcxEkPgxvXD
         yJ8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794472875; x=1795077675;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Uq4VXy4AF5PJdRxnkQk5LCfQupPmt0sewxk8SmZmqhI=;
        b=cNwEhjo/tSF0fFuwg2+NlAGQnKjUChe8Zb8z+31fBobS0GQuaIVHbCwgxfJAmcJC+i
         sc9hnaLw5wMVULHCIMgW4zm6bol/e8M2uDt0V+b8Mdnt7xAY2OSQSRWt986I5snP1q03
         pZlEhqqnXqndC8yg2G8691e2FWyqlfySxc3wPt2EDoLWIHANNQiqc+/t4se6iDLpch2j
         1Kr0ObJqENZTRLkvQBVJK2sVQC4GkRH7uXqssb/fUG9BsUhKYU79o2UDjVAphMyn3rTh
         JEDm1PQ2yySgGgkMAipls/65aCsOiJV1TVrQXvg8wOvqSS/+u+rh4DFlogCKO12RF8fK
         abhQ==
X-Gm-Message-State: APuU4Z9CyvWsoeV8kl3qHLtRrgLbAaosj84k8pcaIMzxOxowIkb78rjO
	HfOz1aQPgQOzSjDFcXGkeELqLDDCKs8aOYee2W6nNDJuEH2f8tzPfqMXlpkuYSkyIlfZhjuvFAI
	/3it35LGINz8=
X-Gm-Gg: AYBFou0jpTYW7Ut+vSJXAuckqQxXdwJpGYe8cgpgdHu0uiC0ACS4pFuQ+45Q6QmNIBD
	4w2PQPCSgWOaUmCV3/RwpZq7g4qZtTf+I2dJmV3L+G186+ZEBOtY5C825yg+vhP5Xkw2bCAZrhv
	XzCqfeGA43KJQERZNJROeIlPek/mkSXPxRjzDlWJgFq8vYjeRvuEjAH4w3+M8KodUN0/WEIx1Tb
	ziTrtQzQcqX9Ps0BUTtoSYOE5+PcDdWgMd9o1un9uQEs/e1ROvpjhtHdlV/c9eErHDIfoCTHfcT
	r+KcoKFYWc8e62htghHI09aF9Wq5pvrYoXkWeWVjw/5tY6XncdCgzuklVrWU8XECHiLW6O6R2vI
	L1rXJX6O4mIIKj76X/gIXM3spDbo9SJSDUCGUJRWFksNle4JzvMhspJr9tA6Njjro4nHeNpbfYp
	5fQZKgecj3tfu9Ik34QsLAWdjDR+usmNTOVGIYyEdfuG6SwCfqXa5pxDlamVQrbYT5P4TcXJMm2
	xmaKKmPFACLiggm9NRXhNYc3MiyQq4M62dq6miH2qCDxdhp7ufEt55twwN+C2qk4alJxhc=
X-Received: by 2002:a05:6512:32c8:b0:5bf:cea4:b26a with SMTP id 2adb3069b0e04-5c15d6543damr1403732e87.48.1794472875049;
        Thu, 12 Nov 2026 00:41:15 -0800 (PST)
Received: from ojab.ru ([2a02:2168:a04:6f83::1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5c157bb1476sm1418000e87.60.2026.11.12.00.41.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 00:41:14 -0800 (PST)
From: ojab <ojab@ojab.ru>
To: netdev@vger.kernel.org
Cc: ojab <ojab@ojab.ru>
Subject: [PATCH] tc: fix build with flex>=2.6.5
Date: Thu, 12 Nov 2026 08:41:07 +0000
Message-ID: <20261112084107.517-1-ojab@ojab.ru>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Since flex-2.6.5 [1] `yyunput` takes a single argument and build fails
with:
```
emp_ematch.l:35:69: error: macro ‘yyunput’ passed 2 arguments, but takes just 1
   35 |  static void __attribute__ ((unused)) yyunput (int c,char *buf_ptr  );
      |                                                                     ^
emp_ematch.lex.c:466:9: note: macro ‘yyunput’ defined here
  466 | #define yyunput(c) yyunput_r( c, (yytext_ptr)  )
      |         ^~~~~~~
emp_ematch.l:35:39: error: variable or field ‘yyunput’ declared void
   35 |  static void __attribute__ ((unused)) yyunput (int c,char *buf_ptr  );
      |                                       ^~~~~~~
emp_ematch.lex.c:1836:13: warning: ‘yyunput_r’ defined but not used [-Wunused-function]
 1836 | static void yyunput_r (int c, char * yy_bp )
      |             ^~~~~~~~~
make[1]: *** [../config.mk:34: emp_ematch.lex.o] Error 1
```

Use new `YY_NO_YYUNPUT` to silence redefinition warning in this case
and skip `__attribute__ ((unused))`.

[1] https://github.com/westes/flex/commit/721622ea6e6aaf3aa7e55d939679f21e98b76d86

Signed-off-by: ojab <ojab@ojab.ru>
---
 tc/emp_ematch.l | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tc/emp_ematch.l b/tc/emp_ematch.l
index 2f4926d4..c6fd907e 100644
--- a/tc/emp_ematch.l
+++ b/tc/emp_ematch.l
@@ -10,6 +10,7 @@
 
  #define NEXT_EM_ARG() do { ematch_argc--; ematch_argv++; } while(0);
 
+ #define YY_NO_YYUNPUT 1
  #define YY_INPUT(buf, result, max_size)				\
  {									\
  next:									\
@@ -32,7 +33,9 @@
 	}								\
  }
 
- static void __attribute__ ((unused)) yyunput (int c,char *buf_ptr  );
+ #ifndef yyunput
+ static void __attribute__ ((unused)) yyunput (int c, char *buf_ptr);
+ #endif
  static void __attribute__ ((unused)) yy_push_state (int  new_state );
  static void __attribute__ ((unused)) yy_pop_state  (void);
  static int  __attribute__ ((unused)) yy_top_state (void );
-- 
2.53.0

