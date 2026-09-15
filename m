Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0D2043C067
	for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 14:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789484213; cv=none; b=ZOkLNQvQWO74qrvg0msg/1zsJCHS8JHzvrGebwiQixu7eL4dXvGqh7M5JVEZjx5LcE0QMA8geBPdogJE8vsIpRjmhqwwAaq9MriBHyZTsdocc6cEwhQ8D20h03A2ERdnS2vbo+72mTInCDVetEYem8XnTe+f+5HxYj2rgKuZ1gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789484213; c=relaxed/simple;
	bh=CnwVAcawuCeqwVLcw+UXgd0jligul/1PYTWtAo4b2W0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tgV/ECVlWYzhSiiLLCYBGTiGUDHOQNdmFdpGzepJ3byQqSrhXjU7GIAUCAJGX1rcTIx/zCu1AIWF3oIIzRLmO7GREvKOofrjdodXU2GRr+gkJhxT113aqRZPygRp2Fwa2ndqJx4IdLKh6vXrxZXZqUULrzTVX8OERy4Yg8g+bBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mEAMLcqT; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mEAMLcqT"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-39b350c69b4so2818496a91.2
        for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 07:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789484211; x=1790089011; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Ms0aUWaGGxumCyZnOZqDHnktR7rW8QHDwRgjlV4BpjA=;
        b=mEAMLcqTpyExtBg60nmC242wyNEN8KmCOmJ/u4LEwWyllJK8SSG/ja7wtmujqDiNRJ
         MKKcDuCDry2PJHxXlG9lXIcLzGQpA2JZ2Qfou3rNypLzYVhwPYIxH/SCKvalu3QZJgrv
         r5UMQrNSGP6RBwsqU1fnEVps3OEOC7JCOd2aIFuBiRSgyrDLRVqQJfdmhPOBaCnQtwpx
         qdCD8AD2sXsLX+vWNt31HVukuDne4/NdMQBBLEmnMbyF3yMYuz6O/b/Z8WmmqpTUd3DD
         aA6rVwaHIc8Kdg25O6x+cJ4lz05EBfvy6vPTwHuC7IMS9TnTq1gphImQpqko5ZyM1t5W
         DGKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789484211; x=1790089011;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ms0aUWaGGxumCyZnOZqDHnktR7rW8QHDwRgjlV4BpjA=;
        b=vKHFJcU0L7JSJNmIo1KuFm3z3665S2nq+kN3v2vceyY3pqP4iwQOyEC3kh1C+210r4
         j9E/HbqccyXy2P8RJsfQuAquHCBf3hRm+1b8tpq8rwvjuBhDCNr14H1l0Bn9wOIUTEon
         oVXCT2JEgktSb3R0Tr4ugLZThf1q2MeIJ3k/V6UJ5Bw6mzOjnx01pfCe55DlA2mSWDwV
         OkCtL9LB6uTpDjDPhstMU+b4De/rtsuuS/yHqpwm5Szqm3Hh9+3wnUSistMYRq+O52Tu
         KiUWPIKtOXWhMu2w2jTnb9STKWf4ljptpHtxTVq8qP4wvuI+iXgcotG5O+41gf6HHNlf
         fbzQ==
X-Gm-Message-State: AFuF++kEIW8Zb8UnuoiBk2BPnFo0s9KsU9o+v5r6khhJwY4vb/eQrPSQ
	dTc6/Qt7UbzVM0bxGDjOT/7C3atwKI1OinaL9BoIaNcoDTmHAk5nbHVX
X-Gm-Gg: AYBFou3dibBuDMgOQBXlMx4PGrXbiWJCWa6wxDmDV/5apMxNGjvG0zqcHFgwvUniM7e
	QpHHZeKZRyWDtYlamxma5ABtwXuNZYVKEFxlZaKDJwjTE/LF3+wDqbonrXcFAJQq3JbqVayhR9c
	5ht6VlJUyukrO/8HJ1cOf9RRjlw1FS1prJijl9jrrNPx9IPrSKvHBC9YK62LjXe1m9R/iKYubWp
	sXn6IvnOPNcayi4jbc8yYMDMID+KcifGHgG9obyE0hPEJGsYEgifqqNSZrCC2/VBRNqwMddwKRe
	Kf5NCtLqjUg9YP81FZ68NhwXbHCqpW/iV0+dz8Lno1a6bcRodoFBUCgLnNwZPk94DMeuZ3vQd1b
	RIwm2NVYOu9qL54gYTpWai/BpxUypVSjEbAtxikNEu/95l/mEiZi9vnVfcnlkARSASSpQZHWu6g
	0pZE71UGU0Vyt1lnnGleeUHi2jIjTVAZhXNK/tleXhzrFOaY5hhCBopnSdybPwoo7vTUVJF2H4m
	Ohi4Iy7Po/LyQ==
X-Received: by 2002:a17:90b:164d:b0:398:9c00:29ec with SMTP id 98e67ed59e1d1-39dec0a8e92mr13326788a91.20.1789484210723;
        Tue, 15 Sep 2026 07:56:50 -0700 (PDT)
Received: from ubuntu.. ([49.205.34.70])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-39dfd9c557asm5857473a91.2.2026.09.15.07.56.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 07:56:50 -0700 (PDT)
From: Ajith Parappalliyalil Venugopal <ajithpv.linux@gmail.com>
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
	Ajith Parappalliyalil Venugopal <ajithpv.linux@gmail.com>
Subject: [PATCH net-next v6] tipc: replace deprecated strcpy with strscpy in tipc_bearer_get_name()
Date: Tue, 15 Sep 2026 14:56:41 +0000
Message-ID: <20260915145641.2434403-1-ajithpv.linux@gmail.com>
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

Signed-off-by: Ajith Parappalliyalil Venugopal <ajithpv.linux@gmail.com>
---
v6:
  - Dropped the unnecessary `name_len` local variable in `__tipc_nl_add_monitor()` 
    and passed `sizeof(bearer_name)` directly, as suggested by the maintainer.
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
index a94b9b36a700..f3e965c48472 100644
--- a/net/tipc/monitor.c
+++ b/net/tipc/monitor.c
@@ -833,7 +833,8 @@ int __tipc_nl_add_monitor(struct net *net, struct tipc_nl_msg *msg,
 	void *hdr;
 	int ret;
 
-	ret = tipc_bearer_get_name(net, bearer_name, bearer_id);
+	ret = tipc_bearer_get_name(net, bearer_name, sizeof(bearer_name),
+				   bearer_id);
 	if (ret || !mon)
 		return 0;
 
-- 
2.43.0

