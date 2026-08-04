Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E14F82EEE6C
	for <netdev@vger.kernel.org>; Tue,  4 Aug 2026 01:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785808075; cv=none; b=GQoCtkJaJoXQVsBq5ZNig+QGH0/kobDchQZ/fh+jN8zsM+aWuDXgLTK/U7k9pqX5b7aVMM5pu4ORSN4XzDuGGgrMrhA+4XsmHJ07hH+qei/nBXeGVe0miF/vM3eEWqDi/JWwlrQLvR6GK1E5YtnUG+k8HOrZzM6HEEtMd14r9LI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785808075; c=relaxed/simple;
	bh=o1eLQMEHSaO4J5F9k7/YliUZtUTXMI/llAbal8afmHM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dCZwjkFgd/G7iCNBpSa/US+4W6ws1pz6rcpS8RWRHLwMxyRIw6rJaTpT3rUIomY/Ke55jNQZPnFzr0tyxIwJFcNfGzYGK/SHQGTg4FGvSs7bETwcgvOpzl734lOSjuBPNf3SutfSVxDRvda5VJR9gEORXVQ/jbHCQZaSolaP6IE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uk1dWEOQ; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uk1dWEOQ"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-84e04df8c46so3689936b3a.2
        for <netdev@vger.kernel.org>; Mon, 03 Aug 2026 18:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785808073; x=1786412873; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8L2BgXJHdmrRxQEN7S4xlJQ5TE/oB/hO2agIkDxI05I=;
        b=Uk1dWEOQ2PSRwLvSnfaelB4IHyMD1Hnb9+GoaDC17pcnc5Mpk4xp87CYhHRDuMySYj
         HYtio68SSLm3nElyRjWmVVHtRQJjPkQWDf2iHX0DtcDXsRbrJA13nZuCB3GUSnYlhj1y
         spYAhKqzWLp/xbUL+xJfI5/L/g8Qe/iOmcSSiwmYB+uWJ0GhPqPHi/eQBWGdWhzwiwVF
         zZGaduaUHDVsOsfQmlOSdbPv1vDRzRjZxf7gph3kLQi+zc9eHP3FCze0o2WPuLlipt+X
         1yiLdIXCmw3B5FntiOnJHL8u5+gCHMdHNaJr+te9OYuyoNzRnYXb28FHKedRrOSNWb0L
         gk6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785808073; x=1786412873;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8L2BgXJHdmrRxQEN7S4xlJQ5TE/oB/hO2agIkDxI05I=;
        b=pm/pBMl0k6xeDJ8oqYzG4u3Ce1/iginvRGWn1TG+CpTTvifm6vDGyRXLeLqR1mIyNL
         sTRLUvhAgsUKToZTyNPTDoH6xPCMAI4T7dbtVsmi621lbZrjCn355kqOrno4Xr1lBUqo
         TQhBd0DKAAbD9TXAEpowtCeojsB7k+e9dqYNP75x7EQxKqnJzh6QxXE887OpwF2bEdvG
         FZ4TzkwZcxgq0oW7BPgYrT257yjNh9UrBO5NWSOBlcszkqO9DHaXstZnNaBHFyGSL9rw
         iPx+50g6xG+a/QlqSxPh/1U9wCa8amjaSAFE9lO4iS4zX5DYAL5SJBAKo4ev9t5xZT0E
         Xy0w==
X-Forwarded-Encrypted: i=1; AHgh+RpK88aP8a15APtmh0/cy9Hj9WJzvpTgIW4Sce+aYomAcPwgGxChh9DK33i9iOSF6JDnd/LqNJ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YydDzQNk8t+2EU/ARrgcVvyvedIrqH/Azg+Y0LlnnE7PeGC2e9h
	VJD7FdjcD9E+ri9282Z5dRJTeu2IExNbJR34zjpqhzl7HCZPB++v6bh4
X-Gm-Gg: AR+sD13G3nWd7kZgSnzNXLT/XfiosOHfYPR09nKInsau2D7JMmz97GJEWhmF1LwtpaU
	xQch9JhPEmzX+00oqSBZnPnF77i4O9/Pl5FKUI4Eo/APFv5/Br6aI7p0RWmleCaj2ie2t7G5iKF
	utPlTLq1hG9nucr/s69U7XUFPxb3O4eVsbrVU3q0OHKQgfwNiEG/J6sXFXsDV6Ohdh26xIoui3Y
	gK4j6Tq9ZPq36f6MS157MiEDYb/t4pueYYz0et1pwFeKPvhFhDWrGtlxPptqvPIStNW2Ky656Nk
	sAWAmQzFQ189htzqzEq++ngD0eG/OgLL1gN+ICf73M9ISeSGXrQ0pzhuJ8Fo/cBkgKdiMI9Pr1c
	gNFSFcgy/u7zVUzodACrLn5dlctnwY03zAK21NbwJqqfuUlMpRHAt4GlZTiW7cSWItOQit+JAGb
	m3RQ0W/N0pcwKbXDTeqI/M4TaTFoDo6wcPC19al2V2HLUwUvLoQgLX8dX0jWuPhaVag8Yc/ET/S
	O2qIGKJaSxecsGV/SaTWWI3I1B8121P1oawP3Ko7Pg2ctej1uVG
X-Received: by 2002:a05:6a00:10c7:b0:848:367e:ba48 with SMTP id d2e1a72fcca58-84ee4920b4cmr10995404b3a.45.1785808073190;
        Mon, 03 Aug 2026 18:47:53 -0700 (PDT)
Received: from m-upc-A520M-HDV.flets-east.jp ([2400:2410:3f60:500:cb1c:934a:3e5f:ef88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84edc2d7b97sm4410164b3a.43.2026.08.03.18.47.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 18:47:52 -0700 (PDT)
Sender: Yuyang Huang <uyoko90@gmail.com>
From: Yuyang Huang <sigefriedhyy@gmail.com>
To: Yuyang Huang <sigefriedhyy@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Bobby Eshleman <bobbyeshleman@meta.com>,
	Chris J Arges <carges@cloudflare.com>,
	Daniel Zahka <daniel.zahka@gmail.com>,
	David Ahern <dsahern@kernel.org>,
	David Wei <dw@davidwei.uk>,
	Dimitri Daskalakis <dimitri.daskalakis1@gmail.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Gal Pressman <gal@nvidia.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Nimrod Oren <noren@nvidia.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Willem de Bruijn <willemb@google.com>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH net-next v5 05/10] ipv6: expose the route deletion reason in RTM_DELROUTE
Date: Tue,  4 Aug 2026 10:47:09 +0900
Message-ID: <20260804014714.4362-6-sigefriedhyy@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260804014714.4362-1-sigefriedhyy@gmail.com>
References: <20260804014714.4362-1-sigefriedhyy@gmail.com>
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

