Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EFF9376483
	for <netdev@vger.kernel.org>; Wed,  2 Sep 2026 05:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788327064; cv=none; b=PyITwVp7cvTKYfQvOSTZhBXK7UAV5xw5jrw0DqyYMbuk9r0I+ydJrn07tTV/aqZRhIsOwbikZs8UBU0bvguhqYmkr0Eyq0f5eN3LxyilWnZfJdTK0eURoBvjwcC7rupUBhZu1g9mRKw3TRSP+GkGiGqeZ1Mu98rEKP4fpmPUSf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788327064; c=relaxed/simple;
	bh=Ze4KZMmqeisDJade5sE6HdwQRZN4yRq7ckdDCGnIeNQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=a7lwq2oga5/UDuQf7no9pp7gfGHL3z82uVNCxI8CByAqb7GmG9laNMlL0IVtkX5Mz7JpyLmCTiIxEGFeqcRd4YSaMF18h2Ub5wlaZ0GcKKM4OckMF3xWXSNAYoW+OoaVbSe4R6QR8erNANjei6q2vp7eaIi6kTtF0remNJuFtE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S9OSF7Vg; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S9OSF7Vg"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2cfbbdfa60bso6700085ad.3
        for <netdev@vger.kernel.org>; Tue, 01 Sep 2026 22:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788327060; x=1788931860; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=4kKDuCF0gtf/+wksRKec866a+BS3VQBZ3BCmkYpnxeA=;
        b=S9OSF7VgqxtQx7vYADvktQ11BYtadHiqnoX9szobCJZyS/+EWpgdHNcUq7MXEbGLQk
         nyA8kkZYmtE2z7Ri3Pr6CpdEQ92jFWA18d1Mqx3eo51DcDrDUAQ+QBT2QvpYXOAjuIRJ
         pZQ2E3DERD5yMOFCCazJjNoJQsDqKLsEg9S0azDKd+3FlfmcT8m/qP4uM9rw0Hk/pe7E
         OsWQkdw46AD5uL3j/KWxuFGb7IBkamGSrurKF8pWp4FGocEuuHNxO59rzQebYRAlJTRz
         kFsjlsrT7Cj4ZA4yKe+s1iKhu+aGVUuad6FpyWNGl+ktTZrAC8LQIrWPdCXAG5fJpW7p
         RX3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788327060; x=1788931860;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4kKDuCF0gtf/+wksRKec866a+BS3VQBZ3BCmkYpnxeA=;
        b=Z6dchLSQFLja18Ar96Gj8GrEfzoi2o0kNXEPvKyg+yBANAevjq7YSgDiL2uXkk0PEN
         vZTB6A/hYZ9Vytu2JFPMm/Pdr7t1nZErCduojxOxe1P7dkT50rrK2kL/4vcGLQFDL3jx
         ADU9KeuTR/Q3HtvYcH1Tf1ZUsfAqew7Im9n1gmSABbhcrq9U9y9caiZtKQvoSd0yXRcj
         sFB2qyLH0wTi8HazAUjpNMa2zPRq9tUBjlC56AP01e4/4wDHSJfXU2enNNVPylL1qiD5
         YVxGWOVUIpjv7WW7zBHXtYuEcxUNvMcHOVhF49ke2UOHj1bwCrPwVzxIcWWR/0sX8EOi
         ZzNQ==
X-Gm-Message-State: AFuF++m6SAW4t6zDs87eaEZPk9hnS/JaWeskFJn1ooeO/XszJUNogdqo
	DigX1mN5sBGn94T0MZVccgQWTH9uLSmI4C8IGr6MUh2x+xSAjsjMKuSn
X-Gm-Gg: AYBFou16d9tX+kT5lijd3kFgqN29S5z72q2X8p5+gL2UhZScHpH+FVFE8jTS82nlC/B
	KV8O3c6zoTNaI0vVd1Q/wvV4O1K/1zwnX04hYtK0U7N20yvO0CGjzDoYyrWCCeWz7mFhwLKYXjN
	LKxAgJ9WgTTD8PvAo5KPUtnpPt8De90WRjAnQSyHyhAMH8rzuyD3wBtnQ3T6zvbFqAN8MYdoW/I
	Ad9YXhS8ScnRJ6ofV/Jot3rqY6Y/ljYBt1WpI02Rh5mgKEA8mpfuhDcFVR2yo8GTiGsGGHeUeeq
	NKEGye4CC0YNDyPiMLwiuyV7AkIazzbm6In+GvQFdKR0/8nMq3QvyV9ihNxv8FonHN7KbSEbxTK
	Fwocq7Vt5BY5rCLiaeD/59yHgz8DUfV/4foCQywLpSQihQg4yJVcMhkBGJXvmlsQxDuFgPOPmnl
	KaZm25a0eCkU+99BfxetO3WL95G+TOca5S+/n7kbNGYt5PEPqDaOr8e4FfJRSZaRg3V1quJJlzF
	OKJVPVJuNs=
X-Received: by 2002:a17:90b:288a:b0:380:21b7:e727 with SMTP id 98e67ed59e1d1-39aee0848bbmr3603479a91.14.1788327060307;
        Tue, 01 Sep 2026 22:31:00 -0700 (PDT)
Received: from ubuntu.. ([129.41.8.14])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-3990d76622csm9830189a91.11.2026.09.01.22.30.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 22:30:58 -0700 (PDT)
From: Ajith P V <ajithpv.linux@gmail.com>
To: tung.quang.nguyen@est.tech,
	jmaloy@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	tipc-discussion@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Ajith P V <ajithpv.linux@gmail.com>
Subject: [PATCH net-next v4] tipc: replace deprecated strcpy with strscpy in tipc_bearer_get_name()
Date: Wed,  2 Sep 2026 05:30:43 +0000
Message-ID: <20260902053043.1483895-1-ajithpv.linux@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The `strcpy()` function is deprecated and moving towards code-tree
elimination. Replacing it with `strscpy()` fixes potential buffer
overflow vectors by ensuring safe NULL-termination based on the
destination buffer size limit [1][2].

To make the interface safer and more robust for future callers, refactor
`tipc_bearer_get_name()` to accept a destination buffer length parameter.
Replace `strcpy()` with `strscpy()` and pass through any potential
`-E2BIG` truncation error code up to the caller. Update the existing
caller in `net/tipc/monitor.c` to pass its array size.

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strcpy [1]
Link: https://github.com/KSPP/linux/issues/88 [2]

Signed-off-by: Ajith P V <ajithpv.linux@gmail.com>
---
v4:
  - Avoid hard-coding TIPC_MAX_BEARER_NAME in the function body.
  - Pass size_t len from the caller down to strscpy().
  - Forward strscpy()'s -E2BIG error up through the existing int return type.
  - Updated function documentation comment block.
v3:
  - Fix patch title as suggested by Tung Quang Nguyen.
  - No code changes from v2.
v2:
  - Target net-next tree instead of standard net tree as requested by Tung Quang Nguyen.
  - No code changes from v1.

 net/tipc/bearer.c  | 8 ++++++--
 net/tipc/bearer.h  | 2 +-
 net/tipc/monitor.c | 2 +-
 3 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/net/tipc/bearer.c b/net/tipc/bearer.c
index 05dcd2f9e887..abd90e6bde09 100644
--- a/net/tipc/bearer.c
+++ b/net/tipc/bearer.c
@@ -195,12 +195,14 @@ struct tipc_bearer *tipc_bearer_find(struct net *net, const char *name)
 /*     tipc_bearer_get_name - get the bearer name from its id.
  *     @net: network namespace
  *     @name: a pointer to the buffer where the name will be stored.
+ *     @len: size of the destination buffer
  *     @bearer_id: the id to get the name from.
  */
-int tipc_bearer_get_name(struct net *net, char *name, u32 bearer_id)
+int tipc_bearer_get_name(struct net *net, char *name, size_t len, u32 bearer_id)
 {
 	struct tipc_net *tn = tipc_net(net);
 	struct tipc_bearer *b;
+	int ret;
 
 	if (bearer_id >= MAX_BEARERS)
 		return -EINVAL;
@@ -209,7 +211,9 @@ int tipc_bearer_get_name(struct net *net, char *name, u32 bearer_id)
 	if (!b)
 		return -EINVAL;
 
-	strcpy(name, b->name);
+	ret = strscpy(name, b->name, len);
+	if (ret < 0)
+		return ret; /* Returns -E2BIG if destination buffer is too small */
 	return 0;
 }
 
diff --git a/net/tipc/bearer.h b/net/tipc/bearer.h
index 41eac1ee0c09..12a322642de1 100644
--- a/net/tipc/bearer.h
+++ b/net/tipc/bearer.h
@@ -226,7 +226,7 @@ int tipc_l2_send_msg(struct net *net, struct sk_buff *buf,
 void tipc_bearer_add_dest(struct net *net, u32 bearer_id, u32 dest);
 void tipc_bearer_remove_dest(struct net *net, u32 bearer_id, u32 dest);
 struct tipc_bearer *tipc_bearer_find(struct net *net, const char *name);
-int tipc_bearer_get_name(struct net *net, char *name, u32 bearer_id);
+int tipc_bearer_get_name(struct net *net, char *name, size_t len, u32 bearer_id);
 struct tipc_media *tipc_media_find(const char *name);
 int tipc_bearer_setup(void);
 void tipc_bearer_cleanup(void);
diff --git a/net/tipc/monitor.c b/net/tipc/monitor.c
index a94b9b36a700..8af49000a07c 100644
--- a/net/tipc/monitor.c
+++ b/net/tipc/monitor.c
@@ -833,7 +833,7 @@ int __tipc_nl_add_monitor(struct net *net, struct tipc_nl_msg *msg,
 	void *hdr;
 	int ret;
 
-	ret = tipc_bearer_get_name(net, bearer_name, bearer_id);
+	ret = tipc_bearer_get_name(net, bearer_name, sizeof(bearer_name), bearer_id);
 	if (ret || !mon)
 		return 0;
 
-- 
2.43.0

