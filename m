Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794247730;
	b=SnKIvgVabxFEpj44W84k/yI3lP4pGR9ZHLIf2sjjiaa6k9MgCx4VCevhlyJt4eoGEJzs
	 qZy9QTyoAP08ekeHBbzF97E8yebWbF4ZjmOvfr7XUyPscY8KcrDgQm2pg8X4gesFGHR9K
	 mf1AH35fTRfYP65hGTu0PlPm9BUe85FKoTgCnb6tDKf4Xk8iofkwEP0492JMiZFuaCXJ8
	 MtGfa+SMgdf4xogRDzB+JyhS0jwIQ/EPDzHfqjnJlRWtTu5O+jhRUGIMabCgLHgFpR2P8
	 8+23zOkJbgMr82KfbxhbiaQFtGfXM25oo60pjwUuEny3nuPqNleHgwVmgtIw+aJFHrA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794247730;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=fsHlUhiFfA5uf1PiwTU3auHAhsiVHEuuHVeOcQKbRu8=;
	b=znX5QuCyjygORlK+mI/d4yS9N8NOFVkvVxeN4R8G/J7memSl6QXtjeZGj6LllRCfqdor
	 meX75HCftfVS258HPuHe5dg9R3Tkt7ivaFRafmJDBl5NvEuRYfUFq3/qszh/DB0pscMe/
	 45KT9NWKXeOwUtdENjQ1laPh3Awp7qlLA+4gP3xi0k0CdUOGAyOs4S2V/vV9gnfCdyvMT
	 rp9MDOAQxcWeGJTPb+44bLDLTxNE88oShXCVkuBETnEwFwLoHcFSguD/Q8FOMisBGBHIy
	 7l9OmsHDBvDtOR+0StB2E1hexEUtlrGf5RGf+ip9uP1TshqgfslkOimwlx9qqrdSSqQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=networkplumber.org;
	spf=pass smtp.mailfrom=networkplumber.org;
	dkim=pass header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=cGJROU9h;
	arc=none smtp.remote-ip=209.85.210.169
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5BA7606A31C
	for <netdev@vger.kernel.org>; Mon,  9 Nov 2026 18:08:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D5BA7606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=cGJROU9h
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-8a06cc097c7so661383b3a.0
        for <netdev@vger.kernel.org>; Mon, 09 Nov 2026 10:08:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20260707.gappssmtp.com; s=20260707; t=1794247729; x=1794852529; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=fsHlUhiFfA5uf1PiwTU3auHAhsiVHEuuHVeOcQKbRu8=;
        b=cGJROU9h0pQy/fe8BYOoNJxG53ywcAxCyT1yR76sjwEgnm4WQ0HqIawaZiRmX7c59U
         nxzkk3xBeGbSVHdz6JiWPavpWHeTVJBv5tCZ3ErdZ+J3HIVSyr3+WBpnTMKvQ+ljq4tw
         CrBBpz0zZ0/XKkbtFY4BmyC1AMHsTwh9iMUeuZSq/UFbElEVa1Q4wYa6kS46Ax9xBeNB
         WITF+Tp9WkdfaIRVmEIPjDNEqad+uIH4JWck8PGnYKHkf0TfmPZDKuS/VYH6RUBTgvgH
         S9eronWtQ6NqT2Z6BAAs7Ut2VSrIe6qTqw+s1nyZCH1oMTBhx5b7DQs+iDBTtoJ5y/c5
         Qvfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794247729; x=1794852529;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fsHlUhiFfA5uf1PiwTU3auHAhsiVHEuuHVeOcQKbRu8=;
        b=yM8rTOE+OBy/kJ5pZqyFbzKgZqvHXQ+HIKfzP5UxiXzhDdfUPXXrV75kboNaVG9q4F
         cMuZqKC96FzcG4xteZX9xXHLPUg82A1rWlEHp0y7i0M58/V96af7l3XRF9BpPLLPpXDu
         VPvKrqI1A7aal91eHSehW+G6vWhf2M0tPcsYvbB4YEskO3YDtjGH6dDAxSDZ4Qvwvbjz
         GECTu4tUd0ih0lV2B+gfdaEngMHT9vaA49fBjFxXb0NS/K5AMovr2QJpeWWD5blcRQyh
         28QxxbkxaF0uw3d774SO8I9KdQPbw+intFaMYp/LvySqOvgCGRzMUQZYi+bLAV1R2q1e
         mfWQ==
X-Gm-Message-State: APuU4Z+z91WdSM/SJwUBco+nueCcDAstaO/APWwk+1/u6EI/SJA66Y5Q
	6G3Ql2ZR1E62eJB9AvncoR2jDD4Lh71jDkKSKka8BEz28mr0jQJiv+W1cuMQ0NTIaYbddBf4K/5
	uikiGIYU=
X-Gm-Gg: AYBFou2/COHD+O//SYLh12QZ3Nhg/5O9PFT0+E9VsWmZIR4aZp4idcAFcSF4KCPrD53
	RDunrawf09Op9oRDGsf6B0JimKX0rE/JhgMXBQ0zE0/Yww+/x3wLLg7MrR2kW2IiDn/C35PDV/P
	PGT3HUTbLOPrlG5nI+yAkurlWkRwVAcRg6uB/WdzlHHggNCSuW1vqziIVaUfIDBrANPWYJOHBby
	n3c4/pBKsz5Dv+Z6o5nAltJlDuZc4sNk1F/5/f2IBZeTdTxuNJyjiVpj7/YANe4GikTEj7uUm1c
	SoGa9JwOs9lfE/d7lXUH+KrBdBhC+SvT/24BX6eWCVLYUBdFOaFbEJ9htZWZFBuCh0OesM4xC3d
	Bo/Cglgi/BsADVJyQsyKFERw3RBWfTWhWTcTTZwkVd3G1tBKn29f/qbwpdr0hUn8EwWNcNd3eKe
	A/d+XmZUgM5CAknAFF+402l+eZmIt2snMd47JseiuPsREwAiTj4LHD5XKWpWxu4B80P+5NNe9ZA
	MzihlyOEyzCH5Xq14RTF687WBRPcmMH8ttQwH+jBP+PrmeRus5fGJXeJKxMwdkhc9vl7pL/p1z3
	ZLwxvn4BpzfXHtWJr1aBOt5YEzGiBDnutO0JKEuuDnD1F+Gn3cZ4PZqTpLSgEUcAtFzKVliQWF7
	snBJT5UysMKgm0MN/
X-Received: by 2002:a05:6a00:850:b0:89e:71df:d6da with SMTP id d2e1a72fcca58-8ba83bcdb53mr440207b3a.5.1794247729225;
        Mon, 09 Nov 2026 10:08:49 -0800 (PST)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8b64a1e6240sm1664051b3a.53.2026.11.09.10.08.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 10:08:48 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: dsahern@kernel.org,
	Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH iproute2] lib: do not truncate 64 bit size in json
Date: Mon,  9 Nov 2026 10:08:46 -0800
Message-ID: <20261109180846.301249-1-stephen@networkplumber.org>
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

