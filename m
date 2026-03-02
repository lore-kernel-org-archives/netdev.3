Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com [209.85.222.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B69CE35FF5B
	for <netdev@vger.kernel.org>; Mon,  2 Mar 2026 16:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772469578; cv=none; b=l1/z2i+qu1hthH/sFzyp8UPhAVtVE1uR8AiuPiLi+NkVRf4Ldb38ikuBc7nB3MxLGy9k8ZL9ZImj2beZxAajf5ZeJBA4j8LJ38jjVWoiZOpK+1cOXXu3+ohMJeLf9+j7etoY9Le6zU9x7aO8YVcPNetOxFsAE8NRgvPA8iBLnC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772469578; c=relaxed/simple;
	bh=uC6/vplQaR/Nl+sf9eIp5Vu1ztYNCKErjypTlH4knNg=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=l74awC/AfVrx7UIGRY7eGykSg8rXvwqEErpuwduYuMKHd5XDNBiMPQ4udQV+uoWYAgtXFn3rNOsWenwCQsbNiKws2HNsLX5sAg0+NLEdushkb64B43S2pO0F5zoOd3v99O5HTHkFVL9f2JztEco2ivSg9O4AphVLk/osJIjs4bY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wZGtvRTa; arc=none smtp.client-ip=209.85.222.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wZGtvRTa"
Received: by mail-qk1-f201.google.com with SMTP id af79cd13be357-8cb3b0d938dso3932659885a.2
        for <netdev@vger.kernel.org>; Mon, 02 Mar 2026 08:39:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772469576; x=1773074376; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Lsd7w/YwUfDuZqvwGO4uzCIEQrC3e9zbAgcIypwwWLY=;
        b=wZGtvRTa0DriyF0aAtC3nJXF7ziKbqGmfEovqBTNHhRZkFMDhij2b43/8jdVJzfbRu
         H46FdXVa9CUjpkg1l8rUFtV+jU195AHmxCs+1lBJeymoYsN5Bz1Nz8VlI0m2WMy7MfDv
         sHFRpuBMYioKlo3ZAdCNxt286Xii+YWn6wVvoYRNXRUF86jNSS7HpIvl+J4Z/3xQWObu
         2VYLrZ9y3k6bE7LX53V+1qimSOrYfUEA8mFVi3jlnGEYhMLjxNDd5SEXb2bvmBG9m3on
         x0Zi7DseH0LQYfCFstYPyVJ52SKeh5KEv3akQ+z7DicLgDMHFOxn61NYKIQ7VK29KiHy
         bh3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772469576; x=1773074376;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Lsd7w/YwUfDuZqvwGO4uzCIEQrC3e9zbAgcIypwwWLY=;
        b=ckLwDFI1iLN+ieJMf9+dQCWTV9uaLsxEhWyiFHuZfex6zN58VqqSLhAWFDDGge0FkH
         KIZpsSYH6zuH+/fPgVkRXGMww0GZsiLB/f5ybeP/Q45f/cdRyRdwqz8DLBNYYcvXyrSQ
         myrqmZkimiIAMTU7Gg0QLajrTK+xD55hp2aJnV24kkpPVCtLeTX6W8iWlo539IallPE9
         6J+yL+en4M/6N5CcQYseLWGukuJiLcN1ru7/EG+a9vZdOcfGASHBkaGhpQeNeQ93Gecm
         NHiuIp4XL+x9TxzHYpDzNLVKmJwFUmZ1yn88HozFa5ktff1BoammW08gMT99QLjgsjJ0
         UUuA==
X-Forwarded-Encrypted: i=1; AJvYcCVHrWu+pGxa+WpT+7URolIz1DK7S3Lksxfv8CN8R1c17hECdfU5KW+Qg5RLSohRqAVO/Fal+AI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1/CS5PHMryOLjZjdQYq1rEvAiVk3Y3f3lbO+oMBTmN63/88TH
	/nUxbPGkTrq+dAzQMjCK9k4q5mQOIdZ6vEyXtHtxzW7qzr3RmmmyHMGClDD3pNQEw7z+hgReDge
	9wrPf4B4RZxSEOQ==
X-Received: from qklm2.prod.google.com ([2002:a05:620a:26c2:b0:8cb:3fad:e583])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:280b:b0:8cb:5176:f00 with SMTP id af79cd13be357-8cbc8ef6df0mr1584405385a.45.1772469575309;
 Mon, 02 Mar 2026 08:39:35 -0800 (PST)
Date: Mon,  2 Mar 2026 16:39:33 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260302163933.1754393-1-edumazet@google.com>
Subject: [PATCH net-next] net: fix off-by-one in udp_flow_src_port() / psp_write_headers()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

udp_flow_src_port() and psp_write_headers() use ip_local_port_range.

ip_local_port_range is inclusive : all ports between min and max
can be used.

Before this patch, if ip_local_port_range was set to 40000-40001
40001 would not be used as a source port.

Use reciprocal_scale() to help code readability.

Not tagged for stable trees, as this change could break user
expectations.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/udp.h  | 3 ++-
 net/psp/psp_main.c | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/net/udp.h b/include/net/udp.h
index da68702ddf6edc6a28440490be07be7eef2d1a4e..b648003e5792a167822f28aeb728c3d64a2141f4 100644
--- a/include/net/udp.h
+++ b/include/net/udp.h
@@ -29,6 +29,7 @@
 #include <linux/seq_file.h>
 #include <linux/poll.h>
 #include <linux/indirect_call_wrapper.h>
+#include <linux/math.h>
 
 /**
  *	struct udp_skb_cb  -  UDP(-Lite) private variables
@@ -376,7 +377,7 @@ static inline __be16 udp_flow_src_port(struct net *net, struct sk_buff *skb,
 	 */
 	hash ^= hash << 16;
 
-	return htons((((u64) hash * (max - min)) >> 32) + min);
+	return htons(reciprocal_scale(hash, max - min + 1) + min);
 }
 
 static inline int udp_rqueue_get(struct sock *sk)
diff --git a/net/psp/psp_main.c b/net/psp/psp_main.c
index d4c04c923c5ac6aead8b5bac41c54ae1143f4110..9508b6c380038b311a9b778933789b5c4cb61007 100644
--- a/net/psp/psp_main.c
+++ b/net/psp/psp_main.c
@@ -202,7 +202,7 @@ static void psp_write_headers(struct net *net, struct sk_buff *skb, __be32 spi,
 		 * reciprocal divide.
 		 */
 		hash ^= hash << 16;
-		uh->source = htons((((u64)hash * (max - min)) >> 32) + min);
+		uh->source = htons(reciprocal_scale(hash, max - min + 1) + min);
 	} else {
 		uh->source = udp_flow_src_port(net, skb, 0, 0, false);
 	}
-- 
2.53.0.473.g4a7958ca14-goog

