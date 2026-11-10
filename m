Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794309813;
	b=sQrgkq1ZxURYFgY0aU1ox35KbhKS74F5dreLSFqDwLHaamuiKl2RsozAoFX6E7MM8x9M
	 qr/nAh0RdbKsq9OeJhZOf1suTDTeQ9viyI6Gr7ebL3Y2FFOzrpg/MaE+gMYk2g1lw21mh
	 dFj+fbGAFL3R+Jo6TBjyf0GHM9xAZXbUx/Ws6atkOgi2kYD7SROzvjYgjsYlNvJX8m175
	 gz/bsyJst5hgItFIDaB6XZZ2GvSwAJbl5skxRx7Z6JnQPzsmhJLp/S/Y1KMhvUTZCKNsA
	 Up+UNZMhc6xI2hmVczymhWcvYjlirGd1ZSAWzlRzG5kwc/L0qsjrF+Wc/uUuthbrrKA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794309813;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=nV9RvqWkqqUe9ueUa8RJ8XBgYpSS/wqmTlJFvrZtdGY=;
	b=vyUlfjsVFnF/ViDu/DqW7LmqLLsXxMI4rfOMqhZ1T+qosq7w/fQvFjSoXfu4RVNGMzUF
	 WEDqWGgfeRsfSiVedkse7GTouq120Qjyf/MuvxGcz12YKZYsQ3E1IgZYXV9puip7RIbCz
	 rWbhR2R6o8/RwIXG+vcUn3BMntRtAQ7YvSARS/FSa7p5S5ZpBR+SNODov1sgRypfdiZ6/
	 9WaNiBipHVK86R38khEjP+7Uqwq0MaetVAJYe0+kBN+K+I8FHhbt7GhfVfXN3IJdhvkPA
	 WbOp/RFL46/dWC9jgMecGw74JqUn8qMCeHy3oRpz3R/ksmoPEVld+wdwiulIYDssfLw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=WZyWx7RL;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=QWkKDBsD;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26BEC606A33D
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 11:23:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 26BEC606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=WZyWx7RL;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=QWkKDBsD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794309812;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nV9RvqWkqqUe9ueUa8RJ8XBgYpSS/wqmTlJFvrZtdGY=;
	b=WZyWx7RLZl8/87J+rl0GXTRSdMWDaee47nzWclSU2pErmahfP+9WTKvw51Tf7P+AZe0zY2
	YB809PL/xCnXYgIuWLOu/BYdsoVEfv2I+gg9HtHdjsxDi9O8ZoT9eOCqkXrvuJKopMnbod
	Tys/yAooFKO6GDSmSgUCVLSrhhHriOQ=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-332-CdKrA6NSOgqoTllDEEtg9A-1; Tue, 10 Nov 2026 06:23:30 -0500
X-MC-Unique: CdKrA6NSOgqoTllDEEtg9A-1
X-Mimecast-MFC-AGG-ID: CdKrA6NSOgqoTllDEEtg9A_1794309810
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-91c7bf2d734so41400506d6.3
        for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 03:23:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1794309810; x=1794914610; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nV9RvqWkqqUe9ueUa8RJ8XBgYpSS/wqmTlJFvrZtdGY=;
        b=QWkKDBsD0uJYwZXf23UgXt4i2t1fP81+Zl8jbuaC64YRBRMTmY07eb6Ylz93KcUXfq
         gBuLXREvTCVXqL1aZ/BE4xPh/xBhnQH1MQ3Jzk9zz8McrKMZVl1KHZPy/dRVggh9jtgO
         K/3ytAFg3LGfHZdO3LF/HBa6ajBlHXB7MCbJV79zMVqt6zlay1XOP12eOLkJ5fbYg/qM
         IyefqyoS9+LO0c5OkkQhrrjyv4ZzuBYyk5V3TiPx5C3c/D3IGU/T4iPrWJH+TRZbyQTH
         3XmIDqpwlhKNlqoaHJF6dTWtpYSwmOZagBENPlibF4zU3cIacfDrd9SZUvF9kIImvO/n
         6NpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794309810; x=1794914610;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=nV9RvqWkqqUe9ueUa8RJ8XBgYpSS/wqmTlJFvrZtdGY=;
        b=SKk2uFTH4oNo2CasYLs4eBnZMQaQZlzEhHOOauRcNgalMOJvajhJH5vw+CAL41TS+n
         H05TMh/Zi1Jw6efVTH42LoA4qP/MfeYgKhDSSkazy5ebsGlF45XubFVhvTG/JE6Lto6V
         6di4OUQebhLukjJ1VF6093Ag6xzvC8y9xeWoSWw17z8wgOlbZOalaGVg9egWpIIIgyr3
         9y0iEY4jGGCsWCzcumq1MTQ3ip2CMyryXw06Fls1C9t6HobRnQQggIr7zruTZNm0wGGr
         ZoX7VXCfTbGDtV/nCc593yOAqmJ5bBwizbDg0XpHBPwJgn1Y98d1hywgyQzN5osu+mPY
         7O4g==
X-Forwarded-Encrypted: i=1; AL+hErGXgbcBO0/2UTD1RA1ibYIVHmJgC8aXZMpK7rGwkYUdy5/LrsgxkrqgVkDEWlmQ4ouUB4VtNr4=@vger.kernel.org
X-Gm-Message-State: APuU4Z8NRiTsePJJtWbVr0tcAKF/+ACnE6olYkE/uWBwNL5V6bKg5plb
	Tvt1JkOQNhFi+3ag9wE7tpo9CxIPMp7t6XMYd1MWHtkxNBlWDVbauo497dxK1PDsXlxIvs9T/dA
	Txx6Pynx90CPRrnGCk7HJcIZVAFvg5po0YBmVNfKW+1vA4nARhHQvHTvqZg==
X-Gm-Gg: AYBFou1TLJ4bNNrgyznqN7aspfZmLKRzB4ZT+CfFJ8Kp9witkd+o3UB40y8GvkM7LXK
	VhOLoC6IfJMCkrBCgien6QPFbDaU2FwprcCnUJ/pbRVJnB6gyjrKsdQvtyji3rTZBnP6X8E8W4I
	3bw8pVx3wwIRYi6KGqS6yeTvkuitwQSzijZejVVT+y3NSxZavOVLzyqsQdOOMnRSHK1VCayoEqt
	C1fXg75PpzbRvCBQDICCKsz7OAeU3eRsObeRIJz3D7Uwz5li/2UQOWTSjX424ngrFZu096cHY3K
	Zv16v2iE38NRQENgFNb74GQbt8RuyQsNH2hvhd2255KP4VW0/ImER0AFr3DwevO9foXfxvIQHc7
	mJ3kbP3VdtsGQ8+x9At4oiLfkKu1p/zkYoLiVuPxTyzHybsroJRuL+oZ2B5G1QriodHuhn3ApN8
	5aM4033zL2jyVI5PHYhgjJS7iblxHTgAodaYgrJjmfV5qmI7wDug77gVAfatKQxSBjrl5bjS7es
	lD/EAwoZTg9zjiR2TjwPLdduheRzvda9tYOXdu1VPAdM8wX4TNw
X-Received: by 2002:a05:6214:21e5:b0:91c:cd1f:2471 with SMTP id 6a1803df08f44-91eef81b291mr39213946d6.22.1794309810084;
        Tue, 10 Nov 2026 03:23:30 -0800 (PST)
X-Received: by 2002:a05:6214:21e5:b0:91c:cd1f:2471 with SMTP id 6a1803df08f44-91eef81b291mr39213586d6.22.1794309809498;
        Tue, 10 Nov 2026 03:23:29 -0800 (PST)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91ef04e7315sm18569186d6.22.2026.11.10.03.23.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 03:23:29 -0800 (PST)
From: Alex Markuze <amarkuze@redhat.com>
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH net-next 1/4] net: preserve splice iterator progress on rejection
Date: Tue, 10 Nov 2026 11:23:22 +0000
Message-Id: <20261110112325.3263078-2-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261110112325.3263078-1-amarkuze@redhat.com>
References: <20261110112325.3263078-1-amarkuze@redhat.com>
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

When the iterator is nonempty and the maximum length is zero, the generic
extraction path reports -EIO instead of performing a no-op. Return zero
before attempting extraction.

The extractor advances the iterator before checking whether the pages can
be sent. If a page is rejected, revert the unappended extraction
remainder, as the fragment-append failure path already does. This keeps
an accepted prefix and leaves the rejected suffix available to the caller.

Fixes: 2e910b95329c ("net: Add a function to splice pages into an skbuff for MSG_SPLICE_PAGES")
Signed-off-by: Alex Markuze <amarkuze@redhat.com>
---
 net/core/skbuff.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 48f676411724..ee7a1bc72cc2 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -7554,6 +7554,9 @@ ssize_t skb_splice_from_iter(struct sk_buff *skb, struct iov_iter *iter,
 	ssize_t spliced = 0, ret = 0;
 	unsigned int i;
 
+	if (!maxsize)
+		return 0;
+
 	while (iter->count > 0) {
 		ssize_t space, nr, len;
 		size_t off;
@@ -7578,8 +7581,10 @@ ssize_t skb_splice_from_iter(struct sk_buff *skb, struct iov_iter *iter,
 			size_t part = min_t(size_t, PAGE_SIZE - off, len);
 
 			ret = -EIO;
-			if (WARN_ON_ONCE(!sendpage_ok(page)))
+			if (WARN_ON_ONCE(!sendpage_ok(page))) {
+				iov_iter_revert(iter, len);
 				goto out;
+			}
 
 			ret = skb_append_pagefrags(skb, page, off, part,
 						   frag_limit);

base-commit: 4dd16e31135ea8437a720222df34e8745f385d6d
-- 
2.34.1

