Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B2D6448D1A
	for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 10:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786616589; cv=none; b=LyAuv65kTyEPT6KJTLJFlTGTdcUl1uuZayL6aLDm24NBlWGL9CF6GXtpQsxqcwAji7c50BTh2IbIhujgmsdPDsjKet7D9WM0RQPwQZCDrDLIgwXvFlc6+CiIDNyTlkzVQft8j+taCYDu6DJzBLKvVO2mNJ+Ww3LMXzr0wd5tgTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786616589; c=relaxed/simple;
	bh=xJxw9Uv3yXLFMn6LzSa5jLw2xgV5ADme9TshmOwWP+c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YJUKlhQQ3ghQ3QXh0NhsRUrJoa3t0V/3pOmb8+DtEKnpxi5FP34L4KsyUtdf2fqmtyxMVPwgL5JJFWqcVPVOyJx6ogRqqYwpalRL4vgoNLHiriEC7vFQ/3/mDRRpZfcfJIbKxSTlpfwfYRtXewiwepZafiJiLyEOhMtSer9Fq0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JU6Um0xk; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JU6Um0xk"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-38759bcd877so708779a91.2
        for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 03:23:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786616582; x=1787221382; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=hIxjK4umB2pfrbgSo/OAz3hJvYDuFUjUMLFzRCPtR8Q=;
        b=JU6Um0xkPD4YkXluCgpxLA8jRUnXVIu8VFYre340Rhfc9f0qtC9A8i1NxrJhLwA92d
         7fF+J4hcowmBogondoLcMxIl0tVFX1qGX0TYKTL1LZJZwPuVR7/i2zwogxnkcv0z5qL9
         QhKj1qoPb7BB/Q7Y4LmzrZ19Uv8FjjTBo0TaFPGGtoC+BFj2LMsbwejE0MrDLZf28omQ
         DvI3Gl6DgAzHIbgepgaVj9A8Sxpxsnf+0aqWbLXgjcw096Rdbp8DUz7Qxy8au2jkGJIy
         2O8P5SUG3DwiYTaME61b3IuKsrmqFoAR/oApP6zsh6hXWQZ3IuMFuwaoYPda/PaevQz6
         Ecpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786616582; x=1787221382;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hIxjK4umB2pfrbgSo/OAz3hJvYDuFUjUMLFzRCPtR8Q=;
        b=dCeiuMpp1fbf1Pw56C50h4XHPkSbuaHtYu1FWm+4CoIJ0wkA9EbmNmX5Oq9fsu0W1s
         7Fc3aa3xNhN54WMQ/FceXYn0eYdxS9ffkBWb/WUX5KObxQBfC2zA0prU3q1RPeoBWihC
         Ci9FkiX82qylrmUv2m9bxMyh/McUjKhIywCaLqmnNYacjhxr9/BMhNnrWXDkhOYeiapW
         pHpJlUl8S64fITUix9HKTBAoqiSOsDE69RLR46nOV2fGrMxgoZ3cVX+IM2Hmf2t4jrrA
         BYYnOko7l0pJl5bUcC9useRLcxvcQZWNnxraS64mFzpYzPoDnJK5j2lVUmsnu0EghMMn
         Oreg==
X-Gm-Message-State: AOJu0YwLsmu/9UspSUl01vOLUIpWeu5LnranD5ZB7o9Vz6SWWJk1YCfd
	Idk+hjJL7PMWaJCLhh5+m5e+hJUqRrzl7SrTNu60rrAj4WEDmRnem/nV
X-Gm-Gg: AR+sD126kMdfreYTc4ELg1AcEsELOQCocgq+tXZpIqWOXPQmRCz6pkWY1eGmlP1Jtod
	RnbwwG39sdzLptoJELKjZXWxEmaZOQ1DMkCmre1i1nBz67rIpC+OSLplsblgVS3EHYn58zoeAzw
	bW5WNS4SCvX06sDFpB4YIH4ST3Et7EvcVuMXljKj4hk3AxgRkhcoCz+SQ/9R5+eAkueUTHBAs8o
	uGPX2cPAlazNJ53/MCMhKi4Mhk9cbuAFt22pQcs4sccaXqTEcdJqsclbZ81MnK7dNgoNAvG2ELL
	bx80bMxoru4uL7X1gPusaWHr7RbqUhsy9Ha6XF6/rmqqr2rSUzIAHwIl5BcMN9GEMuBiX3HsKBi
	cZNPTl06vE3GfzLZ28niV8CaqbCDxOqzZkTw8H3A9QeJiaa9uOJ0daML2gyjfFXkgdrK0CFgMsd
	RCn/ltScJC++uVIuVsVJBNPV7ficdCbsY6iLnqBYieWgdu12aV8nuBkyccNRwfnt0Rm/Cmi6OAM
	rg=
X-Received: by 2002:a17:90b:224d:b0:37d:f983:7b5 with SMTP id 98e67ed59e1d1-3931e06a33bmr5721138a91.9.1786616581592;
        Thu, 13 Aug 2026 03:23:01 -0700 (PDT)
Received: from ubuntu.. ([49.205.39.116])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-3931cefea07sm2977846a91.14.2026.08.13.03.22.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 03:23:00 -0700 (PDT)
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
Subject: [PATCH net-next v3] tipc: replace deprecated strcpy with strscpy in tipc_bearer_get_name()
Date: Thu, 13 Aug 2026 10:22:50 +0000
Message-ID: <20260813102250.246781-1-ajithpv.linux@gmail.com>
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

In `tipc_bearer_get_name()`, the 'name' parameter decays into a pointer,
meaning `sizeof()` cannot capture the underlying array bounds directly.
However, all parent callers allocate this buffer using the
TIPC_MAX_BEARER_NAME macro.

Replace strcpy() with strscpy() using TIPC_MAX_BEARER_NAME as the
explicit destination bound length.

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strcpy [1]
Link: https://github.com/KSPP/linux/issues/88 [2]

Signed-off-by: Ajith P V <ajithpv.linux@gmail.com>
---
v3:
  - Fix patch title as suggested by Tung Quang Nguyen.
  - No code changes from v2.
v2:
  - Target net-next tree instead of standard net tree as requested by Tung Quang Nguyen.
  - No code changes from v1.

 net/tipc/bearer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/tipc/bearer.c b/net/tipc/bearer.c
index 05dcd2f9e887..951bb474c7d4 100644
--- a/net/tipc/bearer.c
+++ b/net/tipc/bearer.c
@@ -209,7 +209,7 @@ int tipc_bearer_get_name(struct net *net, char *name, u32 bearer_id)
 	if (!b)
 		return -EINVAL;
 
-	strcpy(name, b->name);
+	strscpy(name, b->name, TIPC_MAX_BEARER_NAME);
 	return 0;
 }
 
-- 
2.43.0

