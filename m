Received: from mail-dy1-f196.google.com (mail-dy1-f196.google.com [74.125.82.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88AD01F5834
	for <netdev@vger.kernel.org>; Tue,  3 Feb 2026 00:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770079772; cv=none; b=ECldl0tNKktIj3nTeurvNEsjgUyI1veawdbkA3UJIII91hnDxlWwWMU+Wh2lMZIwTXg4BXjhn+xMxmAEfFDA47UnIEANFkBpf5mibF+oUVhjpP2da3u8gS5BfMwG1iPKhKQ+pD3xbUx8zdPDGgHXL/8UiGIopjTMKIrpjuHLpzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770079772; c=relaxed/simple;
	bh=ZDVIaIhW/rF3SfPjYAo2BteKiXxbFqQtcogFiek0mS4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GAYeDjF/lm3Fqx32d22UKrZ/r+c3h/RDJjM+tNJ6PKwA4gwZ2wqujIS/GnyRxQ1xMRdVbVF8dYtvgAo1aI6ygxgMFg45qRmEdNf4/8EGZtiYsOJRXI2h3oqhCz+V+kAB9NUHZkjHITW9bFUreU1HQJVARVehu+TtTrA+4q1MMf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com; spf=pass smtp.mailfrom=herbertland.com; dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b=Cyd1a2dq; arc=none smtp.client-ip=74.125.82.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=herbertland.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b="Cyd1a2dq"
Received: by mail-dy1-f196.google.com with SMTP id 5a478bee46e88-2b70abe3417so10962442eec.0
        for <netdev@vger.kernel.org>; Mon, 02 Feb 2026 16:49:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=herbertland.com; s=google; t=1770079770; x=1770684570; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6p32hXI2V1EqLdhquuxtk5/05nTmTbC2B4yqsmeA4t8=;
        b=Cyd1a2dqP7MpK9lqrZ/9Uw3n/rxq7VSx7jom/9VNaVDBUZTWvfgzgzb5+kcyxEINZo
         TfZqcf8M/NSrQA5oeA0YzsJQvVXmquu0gCEXGxQmCWTXpRHuUu3h4GZvBxgGLSI8oybD
         +95xTYNhR5/fKxdDY2PVsX2IBmCFn0+GgA054yumqbh2PVoeOF60kfRQsZsstPQES+eB
         /hdnwuEhcY4HhyBKGPokAvQPw7PvfzM84UX2FLWyTbFJm5Krhzcf5+Sfsnb8BVjh2aku
         opZ+ZcWIPNNi9sUVXm8KiWzjoKGvhvnARfoYS+QFxynQq/AGuUdTVWr6p/ygea5lcCuo
         qwLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770079770; x=1770684570;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6p32hXI2V1EqLdhquuxtk5/05nTmTbC2B4yqsmeA4t8=;
        b=m8euNivhl7uLhKSYR8mnV9tEOOV9H3ITApppwueueka4g77f+YC3jzrYdi8vfOeeCf
         /TFF8RZczwl7X95oK2yHHVGJGrropz4FSb1qcexsr9MNn2P/9vDuH6VFAAzKAL9YSLyc
         y97fcav0GeKDBmRCXxLSSnHDdQG0tAGFEftUR0Mt9t1WEP+9kBKB5krj7N2j3V0uupZ8
         TuMtQV6KR9Z5O3GnZMHqWkxNL9d1HwkAfFcotrv6gNrAqNrl+QHXhRuPM2LaPEHYeOrx
         GpxXdeazhXTSqfd181/Yo4WmM8+s+0XzRH1PwRI/g2nfwVK5Ys2P8Pe25BAyRS/BUWXJ
         ZoUw==
X-Forwarded-Encrypted: i=1; AJvYcCXlPXnwKw+CofSxiLU+yWwoDOVACqDqe24XrYc8nV9/utOpnGEpKQYygflBsZ4lUKWpHo9Vcn0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRxPkazVRL+JKN70A1ECuOHJEcTs0SEaU60Z3Ft/Cf47qCuloC
	fMWKuWLHYf4C920diyDEmhemnLsYxiKteehOocmG451KjKLzrQQaV1aU9RM+r2UtCQmum6yK7oL
	+nai5sA==
X-Gm-Gg: AZuq6aJqnF9qiY+jKZWk1WjeLWZlGnjYBBrMLbwmGuEar8FsXeKGjQSX7gtSsvTf9sj
	4YnrhAWYaOSnjRh4ktES35pIblStZ3BzmpAs3H8U8VEXHiSjlfYI676V8XuseiBO82lawPJsY/j
	c1A4EY4HoDwha8FBZ+9pHexNRcJUgEKb9i458fRVa6XqESyOIvJNNt5aRpaFCkEaVmohnTOxsTp
	Tmyn+EO4o6/Im/oPcCLhpB7ljo/M1wKAkzx7c63izI9gQjg6L9InBWFpWARS8yaxFqf9lrHd//u
	olIm/5yw6H/gdCGQof2cWQh/MsYZ6lnciYvtly8yVJcftZVJq7/rZcFpb6KQ4fYHEk/+LMm2PIx
	lsNvHalpPuCNBqI48JmjLpppsi89ya1sEhvBZtoDRcnMj1qQlSpuwhraM/PbWcklX5FLMRUqC2e
	2udf94XZqXsFFi3g1yE76zp8W3JSwcBXxGwPcqsaXu91lqSC6qeX7NX0mp
X-Received: by 2002:a05:7300:434f:b0:2b7:1746:c947 with SMTP id 5a478bee46e88-2b7c86268ebmr6076821eec.6.1770079770505;
        Mon, 02 Feb 2026 16:49:30 -0800 (PST)
Received: from pong.herbertland.com ([2601:646:8980:b330:d7c2:35ea:5a4f:74f9])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b7a1abe92dsm21017016eec.17.2026.02.02.16.49.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Feb 2026 16:49:30 -0800 (PST)
From: Tom Herbert <tom@herbertland.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	netdev@vger.kernel.org,
	justin.iurman@uliege.be,
	willemdebruijn.kernel@gmail.com
Cc: Tom Herbert <tom@herbertland.com>
Subject: [PATCH net-next v6 07/10] ipv6: Document enforce_ext_hdr_order sysctl
Date: Mon,  2 Feb 2026 16:48:50 -0800
Message-ID: <20260203004853.94438-8-tom@herbertland.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260203004853.94438-1-tom@herbertland.com>
References: <20260203004853.94438-1-tom@herbertland.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document the enforce_ext_hdr_order sysctl that controls whether
Extension Header order is enforced on receive.

Signed-off-by: Tom Herbert <tom@herbertland.com>
---
 Documentation/networking/ip-sysctl.rst | 34 ++++++++++++++++++++++++--
 1 file changed, 32 insertions(+), 2 deletions(-)

diff --git a/Documentation/networking/ip-sysctl.rst b/Documentation/networking/ip-sysctl.rst
index 5051fe653c96..a0ad32240dc9 100644
--- a/Documentation/networking/ip-sysctl.rst
+++ b/Documentation/networking/ip-sysctl.rst
@@ -2485,8 +2485,8 @@ max_dst_opts_number - INTEGER
         Default: 2
 
 max_hbh_opts_number - INTEGER
-	Maximum number of non-padding TLVs allowed in a Hop-by-Hop
-	options extension header. If this value is zero then receive
+        Maximum number of non-padding TLVs allowed in a Hop-by-Hop
+        options extension header. If this value is zero then receive
         Hop-by-Hop Options processing is disabled in which case packets
         with the Hop-by-Hop Options extension header are dropped.
         If this value is less than zero then unknown options are disallowed
@@ -2581,6 +2581,36 @@ ioam6_id_wide - LONG INTEGER
 
         Default: 0xFFFFFFFFFFFFFF
 
+enforce_ext_hdr_order - BOOLEAN
+	Enforce recommended Extension Header ordering in RFC8200.
+	If the sysctl is set to 1 then the ordering is enforced in
+	received packets and each Extension Header may be present
+	at most once per packet (except for Destination Options that
+	may occur twice). If the sysctl is set to 0 then ordering is
+	not enforced and Extension Headers may be present in any
+	order and have any number of occurrences per packet (except
+	for Hop-by-Hop Options that must always be the first Extension
+	Header and occur at most once in a packet)).
+
+	The Extension Header order is:
+
+	    IPv6 header
+	    Hop-by-Hop Options header
+	    Destination Options before the Routing header
+	    Routing header
+	    Fragment header
+	    Authentication header
+	    Encapsulating Security Payload header
+	    Destination Options header
+	    Upper-Layer header
+
+	Possible values:
+
+	- 0 (disabled)
+	- 1 (enabled)
+
+	Default: 1 (enabled)
+
 IPv6 Fragmentation:
 
 ip6frag_high_thresh - INTEGER
-- 
2.43.0

