Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01E5447FAF9
	for <netdev@vger.kernel.org>; Wed, 29 Jul 2026 12:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785326897; cv=none; b=f3suQNTNYM6CtgjUxUyhKSAi36Lfe9d2W8YLvYjKZ8NUZiRCzVzs3b+nsMOUXqwJy5a/e+JCnQIzUiJqLcv0V9irxhmk6zq41U3rdWkzUsh3CvmTD+ZAf4N2t91CN+6VQ2nda+BXZGEAmIPTC6ZxlV2jv0eq+x42Dmholo+oUFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785326897; c=relaxed/simple;
	bh=Ldrln8LKzLxxG1U61lhESq/BvKrysELVPMi2uGpkCNE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sm2j6pbtIl8SIDkMukvrDs9n5JlrG70QKsBxDiqfFDacmDFURJdGrl/ONA16IcgUsWrUuEyRxq/KwntJgEqe/alsWFVkU0ShgIUVSR6hI/BRVmPvhal3B1b3I+W1l5ftbhFFWevB51hs1li73kQceN76GPdoYP25stiOZbg68gA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ce8C9p3l; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ce8C9p3l"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-84e04df8c46so977932b3a.2
        for <netdev@vger.kernel.org>; Wed, 29 Jul 2026 05:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785326895; x=1785931695; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2gu6y3IXkxO6mUr5eTB6klMueKQY1psJ64Dbxcvj7NI=;
        b=ce8C9p3lO/8lnmqf6oMy5lRGEmDJFLfqPZ/+/bE45fhi4KZgLSGkCHI1uZz4VjQjPq
         7lw2axV+8lJtNgSyPTnMAdavyAYowJ7kI1DwkKVRh/Cw2r/go0+AUFu1YTBjEZRxVeJm
         3eDzNk7eTs4Pw3dGhuJZKbtELcM3CjUV8RlQeh1SFR/gciAvFSJaJ+QNt6c9qjRD+5rF
         4GEW7exdeVwJYhl5QgqB+Ewj/xgUyMp6TCPibQkTgBpkYZhrxoSbGdvfhhvqbhFniaH5
         zTaeyxGGbCVrF+T34lb63Uytao4QkGM5ERtCU/5Vdg9z8pCnJ3Iv1dyCa4npt7gn8RIc
         FDug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785326895; x=1785931695;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2gu6y3IXkxO6mUr5eTB6klMueKQY1psJ64Dbxcvj7NI=;
        b=OTjKGkgYX1nsHADfUn3gxQ2j+hw3xZMPKRU/M6gcaTC90kgHo0SUWfRAfOAdtMZxGf
         uWVFQ79cqwWu7sZgz3CD4FBQKxB+aVzp4SKsQyf2dRJYgJu9Sz7ooe6ZXH0f+EQ+xm4O
         6mwrIad2k1bRpuUcc7i45oGg/ZFux70qpjM0cfnTqxGsRNTcWTooSbIEmX5gFLRTvve6
         EJ5jXLyGqWi7WNeycek/QSMI7D5vVHEyZr69Tj2eXjRLyhYUbg6zQtUbTdP1pkF9lJi1
         tDkdmqTOzO9gS1Dgy/bmQewNhePaYWQsFMVKZaI/nqhnFJRyXXbKHqnmSMexvNHkmdct
         4IAg==
X-Forwarded-Encrypted: i=1; AHgh+RrbBy3R+Ez7EiGcTcwAtgrAfUnyB8qpqR5oU9kxVu/DYr0SU60WTyRF0XpGd3AwCSo0EYcVZlM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzavKZybw6CeDkXWBZ4/1fh7BjmYc2V1dcn3+Z0QCRVkOrDxOGa
	OSZh04ZMLARdFDthUSiU3RBJeMaOytHgNrOYepBWMmTqTJlJONph8JJo
X-Gm-Gg: AR+sD10lvqC21H81DN6xmmKmrwOkJk2GzpJ9N+iCZ98fzYjdaBll7AtBtglwb45qhav
	8ar52El670ohoIWYz6sNfRe1Da9DZIThGk7eK60DlMSjB3aQUQR086adgVEHyLSfqG98hyNr2IR
	JT8+K54RineZNar7T7yHsJ8C/RvuxXlWm24vI84VLKeATTctUvldUWpHLeGdscTK0B3BorZauMV
	zY1hGbFaVPOaoCij/+k06gRkdt5+z2/+A+4AlOZWA69U1ZLPmmZlpKXRhW2Iloi4z+qBs5r+PCP
	W07CecrUmOCgJsxSYyAbJpElWJHpFJOtPPEqXDX3QG9hObywjpRjgE0VSBUI5K1PMXWGnTFqtnc
	P2CoMHE3AC31RrLM5lpiHUa4CGJFmdX3hGQsTNR44eoN6BVtQ/u+fkd5WYP2sw1MO9ii1WOHnv8
	v9HDiCNeCHFJ008KZvSA5dQHkipT1W3YohJmV0Uu+h6jxop4ELJAEfmcvhNxVmK8eljCizmYK45
	SnDYtVMb4bH8xl5k1TIWhdVgeLdBXfu8QyrSg==
X-Received: by 2002:a05:6a00:3e0b:b0:848:2f77:e2d6 with SMTP id d2e1a72fcca58-84e9336cb1dmr6491726b3a.63.1785326895013;
        Wed, 29 Jul 2026 05:08:15 -0700 (PDT)
Received: from m-upc-A520M-HDV.lan ([2400:2410:3f60:500:c705:d3b3:a6d9:8512])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84ea0300ac2sm1263482b3a.35.2026.07.29.05.08.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 05:08:12 -0700 (PDT)
Sender: Yuyang Huang <uyoko90@gmail.com>
From: Yuyang Huang <sigefriedhyy@gmail.com>
To: Yuyang Huang <sigefriedhyy@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Bobby Eshleman <bobbyeshleman@meta.com>,
	Chris J Arges <carges@cloudflare.com>,
	David Ahern <dsahern@kernel.org>,
	David Wei <dw@davidwei.uk>,
	Dimitri Daskalakis <dimitri.daskalakis1@gmail.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Gal Pressman <gal@nvidia.com>,
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
Subject: [PATCH net-next v4 05/10] ipv6: expose the route deletion reason in RTM_DELROUTE
Date: Wed, 29 Jul 2026 21:07:34 +0900
Message-ID: <20260729120739.47880-6-sigefriedhyy@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260729120739.47880-1-sigefriedhyy@gmail.com>
References: <20260729120739.47880-1-sigefriedhyy@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Emit RTA_DEL_REASON from rt6_fill_node() when the deletion reason is
not RTA_DEL_REASON_UNSPEC, and reserve room for it in
rt6_nlmsg_size().

Every caller still passes RTA_DEL_REASON_UNSPEC.

Signed-off-by: Yuyang Huang <sigefriedhyy@gmail.com>
---
 net/ipv6/route.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index b30becf3f56b..b67c8a31ccd6 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -5749,6 +5749,7 @@ static size_t rt6_nlmsg_size(struct fib6_info *f6i)
 	       + nla_total_size(sizeof(struct rta_cacheinfo))
 	       + nla_total_size(TCP_CA_NAME_MAX) /* RTAX_CC_ALGO */
 	       + nla_total_size(1) /* RTA_PREF */
+	       + nla_total_size(4) /* RTA_DEL_REASON */
 	       + nexthop_len;
 }
 
@@ -5964,6 +5965,10 @@ static int rt6_fill_node(struct net *net, struct sk_buff *skb,
 	if (rtnl_put_cacheinfo(skb, dst, 0, expires, dst ? dst->error : 0) < 0)
 		goto nla_put_failure;
 
+	if (del_reason != RTA_DEL_REASON_UNSPEC &&
+	    nla_put_u32(skb, RTA_DEL_REASON, del_reason))
+		goto nla_put_failure;
+
 	if (nla_put_u8(skb, RTA_PREF, IPV6_EXTRACT_PREF(rt6_flags)))
 		goto nla_put_failure;
 
-- 
2.43.0

