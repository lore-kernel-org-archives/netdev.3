Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794168876;
	b=A4lAFV5EEy6FFZwB0OCDSXQfzygWlA00juejwas6PQC5vW6PbqUVJ6s+h08ReuK/vLT4
	 eJwZJHmbKzIF0EhJA7/Xl5nCCQNCojjFM7/hH/XQoXoNw6kpDL5FlYX7wUQ7HI3udFYcr
	 c6XnOgDxMBc6Md6G2jUMdUPbO1BXdKCTP19GcgLaijo8qAXg+x7WF+abaACZ9mXRYo9vu
	 eC/+oNGX6/11MIjVYnNcO3o+ikh73U4awW46wwg+c9ch/1y2E9O/J75eURX4uHnwbAhdn
	 +fIzVbD+mRY8a6zb0SnYN4bk53yECHsRyUB05yFQ11hbTG17n8/g8yoVJvOprBJXVUw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794168876;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=fsHlUhiFfA5uf1PiwTU3auHAhsiVHEuuHVeOcQKbRu8=;
	b=hi8yhmkx4+x8Zp0XxoMhaSuYE09z0KBpKh5/KoMBdHmeWLtm8N0uPih9eAABAQaLqwwR
	 7h/LIH4rPmwQjOhhn2yxHNcHUZoiu3J23/tFdmc5QcChXCTyGt1H1/8d2CSrwdlyy9GPz
	 BJcwQfeZUEXp6KuJ3c2UU3WfUOjgJ7dYiNcbhpXdaTZIEJVeSawlePoWtvxIi2KXrllK4
	 CgwrIdaff4Xp+QIgbO6TwAXodl6lWPTPn636WkrJmOWV3tNMrWFnf+3Fmo2jvKTQ1sEJh
	 phyec0B/5c0elVSeGd7tDaC/N+itKrEefQ7wzflXyAUABSiVkJtz+ECoJQMm4rSG8ug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=networkplumber.org;
	spf=pass smtp.mailfrom=networkplumber.org;
	dkim=pass header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b="hDO/c1Wb";
	arc=none smtp.remote-ip=209.85.216.43
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D52C606A31C
	for <netdev@vger.kernel.org>; Sun,  8 Nov 2026 20:14:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0D52C606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=hDO/c1Wb
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3ad41b47541so141858a91.1
        for <netdev@vger.kernel.org>; Sun, 08 Nov 2026 12:14:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20260707.gappssmtp.com; s=20260707; t=1794168875; x=1794773675; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=fsHlUhiFfA5uf1PiwTU3auHAhsiVHEuuHVeOcQKbRu8=;
        b=hDO/c1WbHfBeUCHJPde5XkmspHuSLwVEj7WTEVU8VEjF4vGE+znidZLN8pWL5DFKHI
         duJcKgNMwqV3RaLtTb8bZ5PG+X3k+Y2BV2yRnLKP5p450NMIKD6NM8FJY36UtF2VO6fp
         xtVGj4lgYTqsNUxCTKr1p1aAQ1dS8XY7PLmNNybS3yiaWK/IzP1seqvPA9l6Wo9Q+A15
         aUCThAldpUUP6sbzRtG9fmCSriXHlIalpnBfAXsnoOLp4DIE0x8hs6qEM2wdnzjHniL5
         ohEi+CtHG0gV7ePLUzAxOzeHA0kMmz4j1+zJQCdgpHEjo+v9SbkMdaJl4jr7Ns7MqHVi
         oL9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794168875; x=1794773675;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fsHlUhiFfA5uf1PiwTU3auHAhsiVHEuuHVeOcQKbRu8=;
        b=Uz4U8vVjSK0w7VolzNahcnzqbCsYiEDTVsImJyR2YC5GfErukrd7J6/TXVq/uaNSQG
         tNKasCNZkiMrQXfQPEDToo3E7gcUc63HMdYLt+mr9slkM2dLb1gXQiKjhFabF3md7cxY
         e/H2m3q50SSzOj2EjcpPotd9YOTXfX7/Ls8+tOUXV6Rn0vlW4FDiUYi02gzRhMfeefkB
         Aw+G3giPBW9eNQ9pUX9alSg2E6Bu5K5sg3rx6WpExv1BdaKNdoUEbxkMma3Br69SPtZO
         n3f7SH5qD6DhUSOtQ9peV+wS+Vp9kk5A8CymjzSa/A68Ze+dyHiDxwMzwIWH3nkeTXSF
         x9fg==
X-Gm-Message-State: APuU4Z97d9KVc3jjDn25I8HeJLM2Q+bSallG95jm1Z4/b++J0IM847u2
	aZBb6oQfpRO1SOJo8iD+O7/RNhOSrfJGJlGSPaw/z4nfTUkZIATK2KGCfds82pEPDriuOuIw0hF
	CTeqvdaM=
X-Gm-Gg: AYBFou2NHB88WQvMZfdR7X19Otd+jzB7sLuZx/wDqhcDSbX7/JiGgfo6EPQEZEqUyn9
	WYlQSeX/Y7qSdns/bPWf9OTVZaZdNQUVjyw4x515WGl5Fy9zSQkcx5v2AOe5H+235F7wWxF6TYc
	SXp6V33KX2J8EfGIbPePBOhNrmaCZ4usGH8iezQ8aEH6UsJ6AQaS0t3e/r7+ZoUEGc+q430Ze6s
	qKaVdC/Ae3LrwzcMtgk24d9wnS92+d6TOlWmITDBw0quGhNKeQbdi5DRDwyC4olXSlObRv8frjQ
	Jj0ZxARWjpsYLQ8ucQOn5uoGAWHxT9yp+a8ciH+38ZchO+72toyOCrwGkCwAl6A7Y4Ld+70WL+E
	6bkLjy9uJDhJUVLWtVoGAP86tU7mHWzwInLZWJBLXg1z3NAvPIFOTHSTQlE7Zk0Zq11+c5BWRYi
	FoyQVvnyT/vtFgKSKAeKraGun+ClJPkAkbXm8rQYyid47g5wp/AVG4KdxYs9WNx4tgRmIax8GeZ
	ZPmpcFnLYkss3ZSu2ZXAdVpbcOdSP67y+lo8gl9CPGFRZGsakxayh4PG3tnz3aNR0IjP6zTrG9f
	hWtssBDPe0ElgI4WMS7ZOzID9PeVBeAu9YLA2ElOflCIU/UkiUkXST100BJVUFfa/pLVPw==
X-Received: by 2002:a17:90b:58c6:b0:3b0:cc6f:104d with SMTP id 98e67ed59e1d1-3b12d45f862mr2156740a91.51.1794168875376;
        Sun, 08 Nov 2026 12:14:35 -0800 (PST)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b127970954sm4105127a91.15.2026.11.08.12.14.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 12:14:34 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: dsahern@kernel.org,
	Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH 2/2] lib: do not truncate 64 bit size in json
Date: Sun,  8 Nov 2026 12:14:23 -0800
Message-ID: <20261108201432.1133641-1-stephen@networkplumber.org>
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
Content-Transfer-Encoding: 8bit

print_color_size() takes a 64 bit size but it gets truncated
when printing json.

Reported-by: Anthropic OSS scanner (ANT-2026-H0R4ZJSS)
Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/json_print_math.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/json_print_math.c b/lib/json_print_math.c
index 3e951cd9..85c29d6c 100644
--- a/lib/json_print_math.c
+++ b/lib/json_print_math.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0+
 
 #include <stdarg.h>
+#include <inttypes.h>
 #include <stdio.h>
 #include <math.h>
 
@@ -33,7 +34,7 @@ int print_color_size(enum output_type type, enum color_attr color,
 	SPRINT_BUF(buf);
 
 	if (_IS_JSON_CONTEXT(type))
-		return print_color_uint(type, color, key, "%u", sz);
+		return print_color_u64(type, color, key, "%"PRIu64, sz);
 
 	sprint_size(sz, buf);
 	return print_color_string(type, color, key, fmt, buf);
-- 
2.53.0

