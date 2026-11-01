Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793551357;
	b=zk68NJZDlkFnkOm4r7JvyUzVpCkEWscM1NqBahmSttuAE8F+srxSN6VEndUk2qM0fmIF
	 Jn/QeQMsQbZPFVWEEkNbEggStB2Ru0xBxwgzouopPneWYR51mTx46AcMmyEciiOk/zGaF
	 uEug7cFKvyh+0QPPMhvkHSfT6OVeAdICytJ6zGIJjpLcB6/a8N991MGQlDng7vots/sql
	 Ahci+i3WvwNI+kNwPFMwfbZyGxTISYHuAVap50QcHauTH94JUl5h/1RBVQtl6UM5H6TLr
	 3amzwumYwkayvCptPpWOyKCUW+b7zRDOK19Rh5XURvr4vqyp2zDCJcii+cR1aoi5PZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793551357;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=zFknrQwTtU94FjTBr40UiM+o/CoWSePUgix/JQMPxhs=;
	b=zcM2sGI+janNSle/hFGvI4oBJRyE5hgqA2BPE7B24VG/R/Zes99jM3A1maK/YRbJvpNy
	 2ev1H4RvU5iodjJA+jsW5jGjyaEF4C1z7ols+G4wHfIhsDxf4NO0eM1xyZWGcbUHLzp/L
	 UOR0I4pqPu/JJle36pGn0yXFJVhW3IvSZ1PBQ18uFtl2DOnK6CCo3XkmHY0u9puX5Bs4+
	 1t5kW6ENZElH4dOpXTSy+yPjsqHebd2bnjAAqp3AeKpJv41WI7JEcK+F0QSKJqK6MW25Z
	 cww2//1HgUeEdhf7qrvcRMd+kTRGzIYLJ+zctMicsjvWQEolAU1baLDS4oOEEWYiDYQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bairaktaris.de;
	spf=pass smtp.mailfrom=bairaktaris.de;
	dkim=pass header.d=bairaktaris.de header.i=@bairaktaris.de header.a=rsa-sha256 header.s=google header.b=ehy7AFGT;
	arc=none smtp.remote-ip=209.85.218.52
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97BB6606A337
	for <netdev@vger.kernel.org>; Sun,  1 Nov 2026 16:42:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 97BB6606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bairaktaris.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bairaktaris.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bairaktaris.de header.i=@bairaktaris.de header.a=rsa-sha256 header.s=google header.b=ehy7AFGT
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-c43373ae89aso335887466b.3
        for <netdev@vger.kernel.org>; Sun, 01 Nov 2026 08:42:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bairaktaris.de; s=google; t=1793551355; x=1794156155; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zFknrQwTtU94FjTBr40UiM+o/CoWSePUgix/JQMPxhs=;
        b=ehy7AFGTtpw3Ci6pLL9b3lH8UKYlZNnc11/XL5xOsbSKtC7Cyiv2VrgpaoYAVdDIi3
         ulXFWDcltWvvUiKNHFD4dE02YlxwvWyIm8lxlFHaK2GTvDm9Q5TYXYbRP2TwV5WlBf+L
         sOop2LYiwthCy5WQc+9vQ5elYnGx9yXWK1b57OdlEOSh6wwE0ZwgZbc21eEeo3MIE8MK
         l6JYh5vWFWyyWrMATH4jXOC0WVCXrPlP6SWMPpWchFDcElVscfbD2gQg3S6ti8NvWuo4
         JWjzJfpRChUtRDzBBTosN8J/xkIc12KyyYvbE7G3KI/oGeKlpsf1eYzIigWbqG4X6yAz
         4v9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793551355; x=1794156155;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=zFknrQwTtU94FjTBr40UiM+o/CoWSePUgix/JQMPxhs=;
        b=0w2QfLKILfB0VSTxqgWOgQjz+TcsJnf2B2z0dr/gjf1WvEuR/0HNUF1xTCq4Jg746o
         T1GdJEuK2che+IfM2EM7twEveSAI4Ur3Rw1xLciWJqod32axHV2B7md0B7oajaJ8a/8V
         vW4Sa0+BT+Ln2G2SnLkGSODfAxrEpnw+MDYXyXu2qPSFFNqBJ4BA8Bh/moLaBullB8t/
         N4EuKA01GRpIXIQW6zn3dDjzxz1e1GTjnwoQxn5ySWdWHxA4qB/jHHcKe3LOik9kM3+d
         wanOjfNsGOp6xzdCCBZqyDB9VaIhbN7fZk1HxUXmpl7W5jqnPkW1TpGAhwosE9zOFpbl
         XKIQ==
X-Gm-Message-State: AFq9FYJ2Lm70W3JxdWFgs6kGx10XWnsa7ElQBqlVkZVs641t4gpcJW0u
	Ln+Hgx+DuvVxVJE46yUkHkJgK8HZxeFvi40pFOvcbWmKiBzI/SNrC2qEKGirPtM5R4yZAyz33Lw
	eOjZX3q+g
X-Gm-Gg: AYBFou1l4cYjJL1aSnOYmAV2FGqgj/v8a/fqQmk6IQKR9lb5dK2f713C7mpO9zwi2lM
	UPbsK9fysDO62NWvzq6g/GXxUc7nzGsic+c3vJLreiRyeBW4+IWWTmOsG2IqxI2WkYBN4jBSmR/
	WJkLC1xlKaNENCdDkpxzVy667KJ9U2EFgqpvDNeTwgVOQ28klbF1oTtK6ry8nkh+Vdc5SnFxX1F
	BUp4LLNHRznGvfF0YJ63Dl8oZAclXdiOInuI/R4S8chgjA7Q1GqkwHHX/RQwFplya70bJvXpczJ
	3kOICsQg6ns0cFrfKAA2yJCe6z/2u/9Sl4BV6jiEuZ1gWL4tuz+JrNbPaOweGa9VTapI3Hq9qKU
	2BdAG6rvZbev2FQqc2GUegSCkmaBeBHcjRvluuGwP8YaLhOapXhkIV/MalykOT8GbH/aHpCxLN6
	EhobiAyoZkimCJNh2nw4OhCMJgvy3eFA0bMig3z9MjgExUIAnuNYzW31kv6WjW+8rnjAwDTW6zO
	de5KUzbW5lIefXiJdterclvR4oee+iFoNLu5LH5B0CMCnh6WQda1w7oYNneesVggj4nXNXwva9t
	dx35HwlUf8pJQfzjzAcHdWlcx5jHlp9kFHSgR6gHRu0WH68qIVD52bXHUW8ReRpNwMRC3Opo9/w
	mk4tu9yIOa2r0kcTbnXE8kRvy5ECBE2QCkUmA9YfYIkzV0cyarNmjU8+1tfNMbU/an5iYc1zkm2
	s4X9471uP5L9rTLRdqk0KzqB99ud00tPU1N10AzlYbS4p0qe/H2kWFJkEX0J5agG4MEg+JgXBAr
	qFdI00+erC3LntAGsvMcubkI67zOsmBGHwww3ZnEVKQmGBFM8x1p/bGSQxg6m+wtKph6W6jqgV7
	ljeEblaAxmQCz0JFZt2sEb6iod4677MM5lJLJLmb
X-Received: by 2002:a17:907:1c91:b0:c46:645f:cedc with SMTP id a640c23a62f3a-c4ca7b804b8mr628806666b.46.1793551354982;
        Sun, 01 Nov 2026 08:42:34 -0800 (PST)
Received: from Desktop (p54aff88b.dip0.t-ipconnect.de. [84.175.248.139])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4cabe0f37esm296622966b.33.2026.11.01.08.42.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 08:42:34 -0800 (PST)
From: Julius Bairaktaris <julius@bairaktaris.de>
To: netdev@vger.kernel.org
Cc: dsahern@kernel.org,
	idosch@nvidia.com,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	steffen.klassert@secunet.com,
	willemb@google.com,
	jiayuan.chen@linux.dev,
	mfleming@cloudflare.com,
	almasrymina@google.com,
	bigeasy@linutronix.de,
	richardbgobert@gmail.com,
	ecree.xilinx@gmail.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v4 1/4] net: make room for the tunnel header in skb_segment_list()
Date: Sun,  1 Nov 2026 17:42:29 +0100
Message-ID: <b27640960edcb8e072fdd2e8d282c1deee747b8a.1792838740.git.julius@bairaktaris.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1792838740.git.julius@bairaktaris.de>
References: <cover.1792838740.git.julius@bairaktaris.de>
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

skb_segment_list() pushes each frag_list member back to the outer MAC
header and copies the tunnel headers in front of it, but never checks
that the member has the headroom. A fraglist GRO packet forwarded into
a tunnel and segmented in software then hits skb_under_panic() on IPIP,
and on VXLAN the copy writes before the member's head (KASAN:
slab-out-of-bounds write in skb_segment_list()).

Call skb_cow_head() on each member before pushing it.

Fixes: 3a1296a38d0c ("net: Support GRO/GSO fraglist chaining.")
Signed-off-by: Julius Bairaktaris <julius@bairaktaris.de>
---
 net/core/skbuff.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 48f6764117243..48291a2d21241 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -4777,6 +4777,10 @@ struct sk_buff *skb_segment_list(struct sk_buff *skb,
 			}
 		}
 
+		if (!err)
+			err = skb_cow_head(nskb, offset + tnl_hlen -
+					   skb_network_offset(nskb));
+
 		if (!tail)
 			skb->next = nskb;
 		else
-- 
2.53.0

