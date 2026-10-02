Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7258647FAE6
	for <netdev@vger.kernel.org>; Fri,  2 Oct 2026 16:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790960182; cv=none; b=g+2Q6cR9lMEovcDrMp++ShXJaVYwK9AKnOhplcN+pe3vms4VZvHT7t+4xqnePU3stJ+1d/7h3ztUxmX7JW9fyDHo+v29pzW71uw86eK+BOLLVudM98e2cenRf3i3RYcZKQ6UCXIpf0wW4AH+ewRkZfSEO+/HoC9ukVixzCvc74Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790960182; c=relaxed/simple;
	bh=yvr4THWK+b359x9GAPgm8g4XYqFtpb7xUBVoOJlXZcA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c7F+ezmgQPYoGsY/LhycCMFOKG4tp0waxTeQiOupeY/0NHQ/oibqheW83GkL27OgzC8pzhM30N72lfObZBUdVkLqKHP0Lco/pONprvsl5DoAFK/aivW/BraFilK6FzQlgXnKRblvrAqpCi/8/CJlTHsffwUZwczWuOX0e+RyiYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QAiRgpaX; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QAiRgpaX"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-396ccafb751so95835a91.2
        for <netdev@vger.kernel.org>; Fri, 02 Oct 2026 09:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790960174; x=1791564974; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wizRrn3DJlyZ2Elw+HTCvVAyeo09ldgbQPuJfwoj4to=;
        b=QAiRgpaXlooI50Qgfb7L7k8wvT1o58ots5e26kFsGJHtcBBO4Bp0AiH7l1N9mOnHok
         U3W7y6egLMvh+WYyCamxLrFdfHxvGBz54QgGosN6Ej72OqptUXXcFaOOydMNs3joYSFN
         PFV/9Pc/a//sEhUxgGuH45dEeNhSOrDIi7jXy4eyXnrZbX3Orctgt8Na7pq+xe9enjws
         fRI6dxmj4wStTS0kotEzAx4vT9GKS+FpUbtVmSg8kLzD+kQIYAnroDA0lvKS147lVmXt
         w3P1m0X/nuPU8aIVx3NXv5Q3HzjmNBMf1GYgahyT5gRYCD9ZaAD/jvG4oiIrdV4y+hDa
         8eBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790960174; x=1791564974;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=wizRrn3DJlyZ2Elw+HTCvVAyeo09ldgbQPuJfwoj4to=;
        b=F0NUxFEjOnNmCnkIhOTrcKxn/K7OPOooWK189thrFcd4T/LqhkcMVAPCzOQHAOnuSW
         R52pUXIvNzCYXDGM8lP1TZPTI2ItoqTf3N9bJ2r0ytgbvNuJo4a9RYb+1AIpLf6CnZi/
         o5LG8GqbIxTKkB3SDzrPW2kAstjjkFICU/MpcUoo9z3MXp+ev/he1zRSiBQ7b5hxXqRl
         xYM1XBoRjV9f0J0MPCOhlCYo+OUcOWBmiq5KylpAfHTEMH9w+IgqiBNudx58d8eZp/nn
         J7AGy9Jt4L1B/50Qxu+a/2sGLnMBdAVD07d+KHuKhC7M2Z5zZ2UzJ52ZCZOLpMoZB+Zu
         F9iw==
X-Forwarded-Encrypted: i=1; AKwUvBwQDpj4FsiOe8arJ3k516ZNYC+XAiVq1F/zmhAGXOL4iF/dHKBWTHURdIKC4TxcPszglNpr40A=@vger.kernel.org
X-Gm-Message-State: AFq9FYL3MhctXRfWiQ0tX2KtiA96Gd6scNxq2Ua8ETQ2LcQ8AWeUOWgc
	fLpPdljDcDVV8qj8xMWUoK039AOIDzVwO9E3U/vbvuQDlG07Y6BffziK
X-Gm-Gg: AYBFou1jZQZuzI89HRRsmf6Hnso2k7aBiI6Pi/EZATIaTZdLuti9cRceqhhnpiZllf4
	Hn+uYKf/RoBwOgmOqjs9j94vHoKu13C/R1OdKYr6XNximstpwItbOFmemmWHKecTWnxPQJu8kOu
	xffS7B11c+uyeeDwcuvwiQeP+YS54Fd8cFbZ4DVpDF3y4ciHvmNv1bd64GceAWIVodh6zbidKdJ
	3qnY0NFphe+iKlAC93kQQNJTcmZvRhrY9aXVkCFxCsz0tWejTvG/Wwq+bxG0Ucm9/DaKJO7KwQL
	lB6rHfCWFccH3dIbKkXvluuzlOUIeeyV95NdsqOUQEOwPTuosgy4dVeYXGZibepADO+Sj7X4L17
	ygKBHube3p58PwufFUKYPiK0qOZNpGySXxeP7LzhWw8emhzmkZ1qKDkwjqqBK9buWYCmZOx6N0z
	BFTQM7XEBPP74ScpZTATIrgXrqPDJpclP/FWW9EuyRr2nnRgW2m5Vg5pM6i308r+p8PdkKJ+QFp
	XW77p1NCX0=
X-Received: by 2002:a17:90b:3889:b0:3a7:eb0:119f with SMTP id 98e67ed59e1d1-3a70eb012e7mr335685a91.43.1790960174158;
        Fri, 02 Oct 2026 09:56:14 -0700 (PDT)
Received: from ancienth-X870E-Nova-WiFi ([125.186.72.2])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a6f7f7482dsm2448670a91.11.2026.10.02.09.56.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 09:56:13 -0700 (PDT)
From: Daehyeon Ko <4ncienth@gmail.com>
To: pablo@netfilter.org,
	fw@strlen.de
Cc: phil@nwl.cc,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	netdev@vger.kernel.org,
	stable@vger.kernel.org,
	4ncienth@gmail.com
Subject: [PATCH v2 net] netfilter: conntrack: reject nested ctnetlink master chains
Date: Sat,  3 Oct 2026 01:56:01 +0900
Message-ID: <20261002165601.1754467-1-4ncienth@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261001180224.1018290-1-4ncienth@gmail.com>
References: <20261001180224.1018290-1-4ncienth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Conntracks created through ctnetlink can reference another conntrack as
their master.  Userspace can repeat this to build an unbounded chain whose
recursive destruction exhausts the kernel stack.

Stop the repeatable userspace paths.  Reject a direct master that already
has a master, and reject NFQUEUE-attached expectations for such conntracks.
Keep regular ctnetlink and kernel helper expectations unchanged.

Fixes: 5faa1f4cb5a1 ("[NETFILTER]: nf_conntrack_netlink: add support to related connections")
Cc: stable@vger.kernel.org
Suggested-by: Florian Westphal <fw@strlen.de>
Suggested-by: Pablo Neira Ayuso <pablo@netfilter.org>
Assisted-by: LLM
Signed-off-by: Daehyeon Ko <4ncienth@gmail.com>
---
Changes in v2:
- Replace iterative destruction with the maintainer-requested creation-time
  restrictions.
- Reject nested NFQUEUE-attached expectations while preserving regular
  ctnetlink and kernel helper expectations.

Tested on net 71a77ab76e74 and exact v6.12.105.  In both userns runs a
one-level master was accepted, 5,998 nested direct attempts returned
EOPNOTSUPP, and cleanup ended with nf_conntrack_count=0 without a crash.
A policy control also confirmed that terminal IPCTNL_MSG_EXP_NEW remains
accepted on a related master.  A real iptables NFQUEUE/NFQA_EXP control
created one expectation before the patch and none after it.  The related
object is W=1 warning-free.  The netdev allyesconfig and allmodconfig W=1
full builds were not run.

 net/netfilter/nf_conntrack_netlink.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/net/netfilter/nf_conntrack_netlink.c b/net/netfilter/nf_conntrack_netlink.c
index 4e5d7c70143683..c68e79d1ac87b9 100644
--- a/net/netfilter/nf_conntrack_netlink.c
+++ b/net/netfilter/nf_conntrack_netlink.c
@@ -2359,6 +2359,11 @@ ctnetlink_create_conntrack(struct net *net,
 			goto err2;
 		}
 		master_ct = nf_ct_tuplehash_to_ctrack(master_h);
+		if (master_ct->master) {
+			nf_ct_put(master_ct);
+			err = -EOPNOTSUPP;
+			goto err2;
+		}
 		__set_bit(IPS_EXPECTED_BIT, &ct->status);
 		ct->master = master_ct;
 	}
@@ -2864,6 +2869,9 @@ ctnetlink_glue_attach_expect(const struct nlattr *attr, struct nf_conn *ct,
 	struct nf_conntrack_expect *exp;
 	int err;
 
+	if (ct->master)
+		return -EOPNOTSUPP;
+
 	err = nla_parse_nested_deprecated(cda, CTA_EXPECT_MAX, attr,
 					  exp_nla_policy, NULL);
 	if (err < 0)
-- 
2.55.0
