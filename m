Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1724D3D3CEC
	for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 21:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769032194; cv=none; b=YgFviNuGXeWZNI3VwoNeP9iGRiNNjwsvidMnHD+S2ABbrpG7OoDaIeAuhGQiG7Pfa/Iay8hMd95/OUk24FWrTpCW7vV572IKrS2szC4+VLFhXRpgPS0b84rYUJMkzCM9wP1OkuOxzFs0ZKAnqblVbeCVJ3GxaJy7+JcsqhgqMkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769032194; c=relaxed/simple;
	bh=PSuODDHvT2Zsv8gqUfVoORui5QbVXVyyCSTIOoG5Rcc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l9pG6nQsJLBcDqSUq+tTTSi//3eCDdbZ7VkxywM/99kV9N1bFqL7PKBhJml4StGhAo4iMDI8SIdwyRFBST/5BfbjbSZfLCY3k7FMEnre9dB2+vENguABrIKLN0t2aWf/mXkGXoUNyNxLH7rumsdNZ8gdpjCLGxGsEY2gK6jkVyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com; spf=pass smtp.mailfrom=herbertland.com; dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b=BphXfKcr; arc=none smtp.client-ip=74.125.82.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=herbertland.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b="BphXfKcr"
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-121bf277922so591519c88.0
        for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 13:49:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=herbertland.com; s=google; t=1769032192; x=1769636992; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oD0sSvT/HdtRWqvc5jR48ncmfqM0sJr9NZ9n/O3DtpA=;
        b=BphXfKcrnGKPOuZ1wXuitbsrPnuqhhyw9H8hGlwwGmV/vOH7H7NPkM4qVJG2lTgpUh
         jdHmGjLBDXAKxVxzMe0BCtL1VTvKxYOyPT0tdM6pk/VAf5PZfl1IK5xbNPIJMpb/mJNM
         1FEs0RlLymlbjIjb9SFmPS1DYiQU3VUDDCN7WuX3UUJ5FUo6+7k6JcLrslUd42NgM2ah
         0FIXKOCG5tjiIs5ss+v+uP7VEFuYG82qsSoNgZ+q0tLX+VuPQorrr1th6o9fCO5ZxfUF
         m7Y8wpSpNlhQfirse3NWhXbUDzQyqHtxPJZRnb6sj1JK5P27e5a7uOdSXvusI3ec4QgF
         Eofw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769032192; x=1769636992;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oD0sSvT/HdtRWqvc5jR48ncmfqM0sJr9NZ9n/O3DtpA=;
        b=MmhHrW/2SI6P6FeHtOsPYKEM23gHzHMuxbncR7ftO5WcE/KntxsnLpXeTU17P7ApEn
         BaRw6MJzXTOCDYoEJ/1v2pVTp5EJNGUIXwWRM/bw9lF9zTw0EbpIdujhJmEXZGqMdbvb
         Ft8o8/jSruCNJxhEw7reX3U4GiF2ayP0q7F/UnQmyWtDOv6/KPrVjsfJeepg1y6UU81w
         mlBJZc+5kPRrFsEjnYZSGy+j/BUxRyBMF/h24LMGhOzJAMRJKM+9ynv1WrAjqo7R6Swq
         sEipZR4KwpkAAvpRNnnJMeDDXB/LJ+Uf2GfrWWkOyqBxsZCsw3XSnym6p8BsXyE3Fw4Q
         9oFQ==
X-Forwarded-Encrypted: i=1; AJvYcCX6nelmCU2/Qy48Cygl2vTtW6DayGWHhRwx8MNyACQ6TxrZho3a+64E28idzbB1AK3R9Dj4gGo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwcZ4ddg/8zMDQJDDlgWhnpUkPjSjVodYNglyhuh6baVwYkRhU
	mbKnX5v3tQiXzr4gEEM4MKVKdmM52jSliN8uGao9ptcasfojTTLVpepfbcSUksEDDg==
X-Gm-Gg: AZuq6aLNlEJF8Qba9DdkKv/z7Zo1RpHrxgula3rUo7hC0rPZr0bRDVdO3/8hjKz5+2o
	ntpmXFMy1v85JsQiF3pz0EOWJQVU20yqzhT5WlpB0yctFp+g8HKAMYycPoA8Hd5n0v6ocexFjaW
	qWaHMNFPKVGRKL/J86tb1+wSOb03JgTlGPQqMwdZj9HJAmsA+r7bn8liO+goDzGbfCh74CFyF5m
	rZIG3Lp1CUEQroSzdUkdBH7FtmltQcNI7bhKimGACJY5VuRorKgacbtA/PqQHSHajL5nxZ7K7X3
	SV4wryr2ArHYoa8hJ/1L89e6athEChNwMK8K3+uRRMEcMSelZYELG5NWHjVS2lnSYcAk4OcHDOa
	9dD0GUfyAPEW9i+kbRIil6NZGJxa5UP9UB9UUAsU3W7Ui0PLFta2hx2l92xT2UPaiuIbX2MxxEC
	cMRp/KuzxVATvvBUto9ujEp5j1gP8rQanLzXzZOeZdCWf8BQrQfM5n6OAV
X-Received: by 2002:a05:7300:8c14:b0:2a4:3593:c7d9 with SMTP id 5a478bee46e88-2b6b4e8b390mr15836734eec.25.1769032191451;
        Wed, 21 Jan 2026 13:49:51 -0800 (PST)
Received: from pong.herbertland.com ([2601:646:8980:b330:30c4:fd82:1cb1:ed85])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b6b364579csm22774482eec.23.2026.01.21.13.49.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 13:49:51 -0800 (PST)
From: Tom Herbert <tom@herbertland.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	netdev@vger.kernel.org,
	justin.iurman@uliege.be
Cc: Tom Herbert <tom@herbertland.com>
Subject: [PATCH net-next v4 2/7] ipv6: Cleanup IPv6 TLV definitions
Date: Wed, 21 Jan 2026 13:49:20 -0800
Message-ID: <20260121214925.112604-3-tom@herbertland.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260121214925.112604-1-tom@herbertland.com>
References: <20260121214925.112604-1-tom@herbertland.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move IPV6_TLV_TNL_ENCAP_LIMIT to uapi/linux/in6.h to be with the rest
of the TLV definitions. Label each of the TLV definitions as to whether
they are a Hop-by-Hop option, Destination option, or both.

Signed-off-by: Tom Herbert <tom@herbertland.com>
---
 include/uapi/linux/in6.h        | 21 ++++++++++++++-------
 include/uapi/linux/ip6_tunnel.h |  1 -
 2 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/include/uapi/linux/in6.h b/include/uapi/linux/in6.h
index 5a47339ef7d7..c2f873c98d20 100644
--- a/include/uapi/linux/in6.h
+++ b/include/uapi/linux/in6.h
@@ -140,14 +140,21 @@ struct in6_flowlabel_req {
 
 /*
  *	IPv6 TLV options.
+ *
+ *	Hop-by-Hop and Destination options share the same number space.
+ *	For each option below whether it is a Hop-by-Hop option or
+ *	a Destination option is indicated by HBH or DestOpt.
  */
-#define IPV6_TLV_PAD1		0
-#define IPV6_TLV_PADN		1
-#define IPV6_TLV_ROUTERALERT	5
-#define IPV6_TLV_CALIPSO	7	/* RFC 5570 */
-#define IPV6_TLV_IOAM		49	/* RFC 9486 */
-#define IPV6_TLV_JUMBO		194
-#define IPV6_TLV_HAO		201	/* home address option */
+#define IPV6_TLV_PAD1		0	/* HBH or DestOpt */
+#define IPV6_TLV_PADN		1	/* HBH or DestOpt */
+#define IPV6_TLV_ROUTERALERT	5	/* HBH */
+#define IPV6_TLV_TNL_ENCAP_LIMIT 4	/* RFC 2473, DestOpt */
+#define IPV6_TLV_CALIPSO	7	/* RFC 5570, HBH */
+#define IPV6_TLV_IOAM		49	/* RFC 9486, HBH or Destopt
+					 * IOAM sent and rcvd as HBH
+					 */
+#define IPV6_TLV_JUMBO		194	/* HBH */
+#define IPV6_TLV_HAO		201	/* home address option, DestOpt */
 
 /*
  *	IPV6 socket options
diff --git a/include/uapi/linux/ip6_tunnel.h b/include/uapi/linux/ip6_tunnel.h
index 85182a839d42..35af4d9c35fb 100644
--- a/include/uapi/linux/ip6_tunnel.h
+++ b/include/uapi/linux/ip6_tunnel.h
@@ -6,7 +6,6 @@
 #include <linux/if.h>		/* For IFNAMSIZ. */
 #include <linux/in6.h>		/* For struct in6_addr. */
 
-#define IPV6_TLV_TNL_ENCAP_LIMIT 4
 #define IPV6_DEFAULT_TNL_ENCAP_LIMIT 4
 
 /* don't add encapsulation limit if one isn't present in inner packet */
-- 
2.43.0

