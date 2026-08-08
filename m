Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E113931E84B
	for <netdev@vger.kernel.org>; Sat,  8 Aug 2026 00:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786150634; cv=none; b=LwpIjW7DeUNvFwAZkCQvX0/1W9Q4PwlJ8U6f4z2tcvsIAdkX9xOVSoNI+EI6c9SYRNFHiAOyJvyck9cHwnpgoSn5E4Sn6Mdyock7xJO5LxZNLP5Byofx/6GqACJu7cMYhwmIvbbidu4kheVoGriOE8BnxH9xX+BwQdpW94IMJqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786150634; c=relaxed/simple;
	bh=LptUurOI+OXACGzviKpmnx9OsYV5snEdOTU9fBVihMQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kOj8LxRg+w9TxqQDT4kVslWhwJPk0Cppf2sc0qfAjc2dalq4Vs5+DjsjGx/mqLMYOe3z3Gd9CwV+UytV7c8TW1YOSjfHzwKsWZV2Qu+p0Ybp97eCK4UcCq+pfUwhrkQoaexA28uMLJeHd62jnGkgjQ7LoXFbv0HG4Ih+TUscqhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Eyb/d6aS; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Eyb/d6aS"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-38dc69c74b8so120943a91.0
        for <netdev@vger.kernel.org>; Fri, 07 Aug 2026 17:57:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786150632; x=1786755432; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1EE695Rdk07hMzYmc0ZAJFaWL6Cw+K0q24XElbn1AAE=;
        b=Eyb/d6aSA3WBRlA9fYoSr5aWS9jh2mDRwK7fIH913cZRfNbX3+g3fOFuGZ5ik/gXc4
         HAnYUgARUufGej8vCWcV086d1Dsiyr5I2nO9qJKIOImy9Rp7/MvszERPdgHDuSVt6CKU
         1EU58W7LNf04LXef/dVkex2NxxZRxXujsLZaVhdnxI2NSDJUq+7xfnMHLKS417ikFcFL
         DNpGe6lL6iisyWtVsSCxQeUDqvSP7yJvw4LRNv+9WXuRKIi5s3sStniItcgbgKQeTWrs
         ikpmEy0UjnCuKpS1szNxUhh06OqUajqk+z5UbnXPVdlmj9Lg/JA5e5pseX7eyK4atvQe
         mHdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786150632; x=1786755432;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1EE695Rdk07hMzYmc0ZAJFaWL6Cw+K0q24XElbn1AAE=;
        b=FyfD2Rj7J86U2AhO4Hfcl+L7I01iCDe4DIqFtjA4ELtB3Tovz5gDvAuxcUWr0NWdxs
         vw+PzdcFdz0HyQdGl70XLxt4jzx5wDM5sw56pkBGvI0SJcT4P8hgbiyRoOaracpAwFJL
         /SkkFFzgy6Q0J9j6QP2TyFKecZUVyDxIWdSTge0cZW7z9dUr8rEVLgWlgAljLcbS09VQ
         MUxFNf80skPIkIbVvjTr/XzhE18qEK5V1GaJgicQ1vfgw2zAC3+NPvwMGmgBLu07/C70
         wGfV1eSu5+sGWeeyJvQtF7Jh8XOAjj4SkM0FZTfWVyOGtY/riPKr8B1XBvwMXCWZG9ru
         ClFQ==
X-Forwarded-Encrypted: i=1; AHgh+RqUns/wfGEeFeyPmW6zaHYPUkdMV7WtlpOoX3hGdL9F6LzYPuj/SSKskecAfZnqrkSn1OSPIGs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCbr6kTjMcSr6d4fHfeKsqmpOEwgAkxCs3kuEf7nnYgp339Ncm
	411B0Cj4LxHojH8aRahuUyKYtkp5BKr907WkIuh6V+3nl5y+RKuA5b0Z
X-Gm-Gg: AR+sD13eMrgGU1w+ZhqNQOznXCgQgo2xeIDIJA2OjOCJkBMopM7OB++wa63+8mJEBq3
	meFT3zlb6yLYf3d6/84bBVvdFHy8ER9Own104yIKSjkN2xV0mok1lQP5UR5mTYs2sVJpE54yzZs
	H5J1LMVx8BtDUsUglswiMMlwLmNEk17D0t8M8lyQPTLSOHWYOMu0PF7KwTJVgX5qUnASjh7ZR1k
	ERFslfbhltUpOPwKOtyEvLwxvZTFu5a4RFGMfkLK20PpuzzvmN5mHcQ6/h3VUggjZ6iPiFAmZ0K
	ffTCXAewcEvJNDPlkWiw9gUPbO78ZKlr4UQje+iYF6kB4r+jiyScuZfMoWmyXXrm9a3wVAxLpUA
	TWDyY6zazAo9XcGny2FYSrKQBhh8ERqssLS+CUgwbpDRvywJ+6GTyjYggxstHzf0aX9peUPCBGP
	67ONYcdt9SQYD9w4ne8TfQZlPGW61fbZIMm6epC/i2ImDzgc0ZJeMH4frqcTpH2/MxO7Rzmwr9/
	naAQlUJUPOXsvu6bk8RFCN3jeyVUqFXreimgikwUG+rMS7s8mMOz6x+oiX1Bw==
X-Received: by 2002:a17:90b:2590:b0:37d:f983:7b5 with SMTP id 98e67ed59e1d1-3903c56fff5mr27286985a91.9.1786150632199;
        Fri, 07 Aug 2026 17:57:12 -0700 (PDT)
Received: from m-upc-A520M-HDV.flets-east.jp ([2400:2410:3f60:500:d7e9:6449:7464:1dfa])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3925fc6c13asm4205182a91.2.2026.08.07.17.57.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 17:57:11 -0700 (PDT)
Sender: Yuyang Huang <uyoko90@gmail.com>
From: Yuyang Huang <sigefriedhyy@gmail.com>
To: Yuyang Huang <sigefriedhyy@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Chris J Arges <carges@cloudflare.com>,
	Daniel Zahka <daniel.zahka@gmail.com>,
	David Ahern <dsahern@kernel.org>,
	David Wei <dw@davidwei.uk>,
	Dimitri Daskalakis <dimitri.daskalakis1@gmail.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Willem de Bruijn <willemb@google.com>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH net-next v6 05/10] ipv6: expose the route deletion reason in RTM_DELROUTE
Date: Sat,  8 Aug 2026 09:56:37 +0900
Message-ID: <20260808005642.26901-6-sigefriedhyy@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260808005642.26901-1-sigefriedhyy@gmail.com>
References: <20260808005642.26901-1-sigefriedhyy@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Emit RTA_DEL_REASON from rt6_fill_node() when the deletion reason is
not RT_DEL_REASON_UNSPEC, and reserve room for it in
rt6_nlmsg_size().

Every caller still passes RT_DEL_REASON_UNSPEC.

Signed-off-by: Yuyang Huang <sigefriedhyy@gmail.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
---
 net/ipv6/route.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index 6732e95bf7b3..d3bf2dd209bd 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -5751,6 +5751,7 @@ static size_t rt6_nlmsg_size(struct fib6_info *f6i)
 	       + nla_total_size(sizeof(struct rta_cacheinfo))
 	       + nla_total_size(TCP_CA_NAME_MAX) /* RTAX_CC_ALGO */
 	       + nla_total_size(1) /* RTA_PREF */
+	       + nla_total_size(4) /* RTA_DEL_REASON */
 	       + nexthop_len;
 }
 
@@ -5966,6 +5967,10 @@ static int rt6_fill_node(struct net *net, struct sk_buff *skb,
 	if (rtnl_put_cacheinfo(skb, dst, 0, expires, dst ? dst->error : 0) < 0)
 		goto nla_put_failure;
 
+	if (del_reason != RT_DEL_REASON_UNSPEC &&
+	    nla_put_u32(skb, RTA_DEL_REASON, del_reason))
+		goto nla_put_failure;
+
 	if (nla_put_u8(skb, RTA_PREF, IPV6_EXTRACT_PREF(rt6_flags)))
 		goto nla_put_failure;
 
-- 
2.43.0

