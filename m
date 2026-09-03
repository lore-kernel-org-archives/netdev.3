Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED2CC4A840A
	for <netdev@vger.kernel.org>; Thu,  3 Sep 2026 13:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788442076; cv=none; b=m8GuAbMtx98MVDhJFGsPer57rU8/OPurpDBsTd7i78SEnGlKcrjTx4Pk1vf9hyHzsZj6ZNN2MVdjP6nP8TYTXvK4QTIu+449atDD6Nwt9Uwk40mLjm+hmbi6rwp+sKizpjYet/wu9gkSpDJMYDQARZbHQmKL5AJ1DXeTnxa03PI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788442076; c=relaxed/simple;
	bh=YPvyN3kfwwpBginyLPvcxEOta7fpjimyqNItqqLCY2c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jiuZcl9gc4AxsA/4dyDPZmuIBpPKt6aPjHcz26cpDnMj31lhNocMRiXQ2kIe33Xi5TLezDn9n1DZjD2WDMicTtxxAkWPC0VX62aZzH/NLySRCynkMBNvfSAdNRkAagufgDpRDwHYKSVMYZvTRQmextl9LV07aaHvh/Q4oKJnzM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jnf726Nx; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jnf726Nx"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-cc1d57602e8so2448082a12.3
        for <netdev@vger.kernel.org>; Thu, 03 Sep 2026 06:27:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788442050; x=1789046850; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=cpNeig/STv3ElkV+GwYqrBBpO1RKTjvMEoB8VPZ2e9M=;
        b=jnf726Nxy5gNE+m9LHyWLAsYfY0THYZ+y9m2amx97WX68g2MKscjZ1bt+E+CImRKCV
         /UhH2X3ssZhX6ZP3SrEeMi2pPKahqPDRF459y23+FV1WuqI+UB/piTylc5EDZ2vHVBLr
         n+22megOz75RdrKRmLMXZ2/zkg/TP3+z7uZyfrXzm0pb9wcuoEgjgbge+Iap1Mo9NKB+
         JMxOwq8NxLwt+v79nSjhlav7Ebvm8iejHLdGEdVUwIo1pb8RMknIa+fCaQVVMkidhKEO
         2VkniitHoJ2BAEnksoVE7wKfvdSK0Kcdt0j28K5RhDsCERpCsaWWsXMjmBdRV0AIv6oZ
         pSlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788442050; x=1789046850;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cpNeig/STv3ElkV+GwYqrBBpO1RKTjvMEoB8VPZ2e9M=;
        b=DMTXc4fyW4h36nCWfXuJG6QtOlHTk/V+UA8gjUFVW2N4kD0pN2AuY5DbH0CyrAFTDY
         WBpFNKWW4q5LC3iWhB2qVmHdYIlCcyYIJ4Z8TtN3LBdhgxDqXwsX933Rg1qQdvnZsG4E
         Luvsi8YJ11l7JID3+cNi9Q1f7BnQddhdQz5iYhrL1MZk9SpgahTWH9lmd2xljU6ZkTWm
         TqnNWG3J56FvthnscFKyoBnvZlw3b2kwHuZmdNO4bLlEprCF/l426RI0HtvD74+lQRdc
         EoMS01fENrbY6wxJy7L2D57g+Vp/+USa+SyAOoOhymFrd9U7QxqEMlQ8aeIl9YS9anRg
         Icug==
X-Gm-Message-State: AFuF++lH7XRf8WYoNHTIn2Wmo0/FPVwlmxReZHqOmNnt3Agjba2lX3r3
	PSOB1ofR3r4KGLCkEudaTHOw0BKyTXcte6qClDfEFjfz2pfhyVMKIn1/
X-Gm-Gg: AYBFou04+5iEUN5gUAoo4ynAi0XHfAYzdxnCILsI8Gmjy9mbD9v4vwd1q4aqzeD0axz
	x9UlDdir/HhxA2DqX3z+AXEoEeMJeCeCTZuMS/z4/EBWHu6I0Rp5TPVo0nCvGTTblRPXQBak7mW
	gxgWHMiGnzc+8maj574iiZ5tWLIKqRetfisOaiLlJ7f6v/9aAHlssJ38Kq3Gy4Ea73Xz36i3Zvd
	r2QOH6C6sg9V25zYLCMxC4aU7lvY24GCEh0Hyd+M4CMAGXiu8SBjXufBhacWIuYbSj/BNQtAUZz
	4Lzf8LtarY/2i03LFV++kQ5ngaFXqc3kEi1wMUVsuIVHC4lYML8BzjkiO+u2TDoYPkkB8bXlgnk
	jzxenCzyx6wi13idnE0WU3w7bDYOK4W/O7eAk/g+m5J/70ooeuZYH02zXqyi4e4UCyk2t8ETH3+
	KOKUzsG2kZIcIddEGkZ0LcqlCr6fyHQv4OEfuVBqtK0JhsVtPTLOsS7DzqaWN1Yc0/MldQAvA7e
	0KaKiBVaGaXsw==
X-Received: by 2002:a17:90b:5109:b0:399:e97:8d5a with SMTP id 98e67ed59e1d1-39aee152d79mr20056075a91.25.1788442049502;
        Thu, 03 Sep 2026 06:27:29 -0700 (PDT)
Received: from ubuntu.. ([49.205.39.116])
        by smtp.googlemail.com with ESMTPSA id a92af1059eb24-143199692a6sm10752142c88.12.2026.09.03.06.27.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 06:27:28 -0700 (PDT)
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
Subject: [PATCH net-next v5] tipc: replace deprecated strcpy with strscpy in tipc_bearer_get_name()
Date: Thu,  3 Sep 2026 13:27:18 +0000
Message-ID: <20260903132718.1616159-1-ajithpv.linux@gmail.com>
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
v5:
  - Cleaned up implementation by removing extra `ret` variable as suggested.
  - Wrapped long lines to fix checkpatch column-limit warning.
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

 net/tipc/bearer.c  | 6 ++++--
 net/tipc/bearer.h  | 3 ++-
 net/tipc/monitor.c | 3 ++-
 3 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/net/tipc/bearer.c b/net/tipc/bearer.c
index 05dcd2f9e887..65fa18928fe3 100644
--- a/net/tipc/bearer.c
+++ b/net/tipc/bearer.c
@@ -195,9 +195,10 @@ struct tipc_bearer *tipc_bearer_find(struct net *net, const char *name)
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
@@ -209,7 +210,8 @@ int tipc_bearer_get_name(struct net *net, char *name, u32 bearer_id)
 	if (!b)
 		return -EINVAL;
 
-	strcpy(name, b->name);
+	if (strscpy(name, b->name, len) < 0)
+		return -E2BIG;
 	return 0;
 }
 
diff --git a/net/tipc/bearer.h b/net/tipc/bearer.h
index 41eac1ee0c09..9ccc9ffa925a 100644
--- a/net/tipc/bearer.h
+++ b/net/tipc/bearer.h
@@ -226,7 +226,8 @@ int tipc_l2_send_msg(struct net *net, struct sk_buff *buf,
 void tipc_bearer_add_dest(struct net *net, u32 bearer_id, u32 dest);
 void tipc_bearer_remove_dest(struct net *net, u32 bearer_id, u32 dest);
 struct tipc_bearer *tipc_bearer_find(struct net *net, const char *name);
-int tipc_bearer_get_name(struct net *net, char *name, u32 bearer_id);
+int tipc_bearer_get_name(struct net *net, char *name,
+			 size_t len, u32 bearer_id);
 struct tipc_media *tipc_media_find(const char *name);
 int tipc_bearer_setup(void);
 void tipc_bearer_cleanup(void);
diff --git a/net/tipc/monitor.c b/net/tipc/monitor.c
index a94b9b36a700..a8a088fc2a2c 100644
--- a/net/tipc/monitor.c
+++ b/net/tipc/monitor.c
@@ -829,11 +829,12 @@ int __tipc_nl_add_monitor(struct net *net, struct tipc_nl_msg *msg,
 {
 	struct tipc_monitor *mon = tipc_monitor(net, bearer_id);
 	char bearer_name[TIPC_MAX_BEARER_NAME];
+	size_t name_len = sizeof(bearer_name);
 	struct nlattr *attrs;
 	void *hdr;
 	int ret;
 
-	ret = tipc_bearer_get_name(net, bearer_name, bearer_id);
+	ret = tipc_bearer_get_name(net, bearer_name, name_len, bearer_id);
 	if (ret || !mon)
 		return 0;
 
-- 
2.43.0

