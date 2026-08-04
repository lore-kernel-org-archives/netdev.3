Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB0D23A5E88
	for <netdev@vger.kernel.org>; Tue,  4 Aug 2026 01:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785808081; cv=none; b=BIsHn8bM/16B1c5tDJp37zw7c+h5NDQUEZtkxy8Wab2whdPRpmv7n6h3TETbgkg64KcvIoKbgM/Q/Rn0PA4qdae82O5hl7ne0ZO441W1vcZWZWdEY3ZiTgfm/mkMaB5Y8NwD83x1yedM1bdM1/IHS7ObeOs2+UWdOcC3wshPCLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785808081; c=relaxed/simple;
	bh=4OqBbZ37IXEzg2TO7BOGq5d409xbe0y05hAE38ugGOc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ajeHmuDREwekCpwBPJy0YxnvUwpf4bmd3KhUYxXRUwd/hzmgbmSMs8i9rCW3iF2hAfdBAQXJ9rO33Lt7nITiBnrnahBbjCIkoOWGX5wePdBKfem93u94wpwBbIMVBezzkIXamookfOZZoPG74T6W5NGStoF7whyy1EvM6rGPKa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iKhK8TyM; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iKhK8TyM"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-8485b358552so4275858b3a.2
        for <netdev@vger.kernel.org>; Mon, 03 Aug 2026 18:47:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785808079; x=1786412879; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BO9P0c12i8oOaunBK0JGFIWu3k1uuj5sihro3agFJaw=;
        b=iKhK8TyMrQoVGGbRhwtU7BkxgTxaWHlaB3D6Qr0QrsaPivxNghy729vbDAjaltQEN9
         R6JRGmyx0Bl/x7vJxCgLqH7PrpIPqjuowAfJ87bSsBG6DGg8opSDieuwkTrW4YQTdfxI
         RENZeUPzQE/ovsByipRrt23nxUgIj67etQWco3prDl/n827ArsDdN5cOVGxStrNeZ1JW
         6ivxzue7BdxvPXQb0sURAivEo4+N4emuGpmIZS0ilfwc8aoaDcal0llVaiJ19nfA14dX
         Wk1jZtgosuYex+KT6RTnvXyZjsQV2kbPSgi7hIfubXv3iGxyzaBehP6Zlsu9pik5xi5k
         KfSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785808079; x=1786412879;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BO9P0c12i8oOaunBK0JGFIWu3k1uuj5sihro3agFJaw=;
        b=MsJlIqgLae2p3Uq91LUX0c7tczgpUf8YuVzwrRtgme/6gpecQ6dapWh/yNaMUHtl7T
         /7w6ytp9PP/40NP3Pf0y2Lx4lZj8Vk9QpOb8redMIUIAK/5NcWK0RgdarUj2Mf7O8inp
         CqlRBaAFf8NQMDmiJlHlSlioXDOR1WP4IVVwCd4cMgy2aLfOBzuvdFtG4/RZBFSHxUV8
         tIhj5z0eEwUnqwvQOszDS+nrERsJZQ/jkFpRjrOH+aUeaXE7kxdedrWgwRfwmIzHOu5S
         rY2/bmGL+CAOvdfWyAvXCs6IB/h+u6lnOenkw7Bya5/kDCiz4Z7dqkEHDhF5HMeCBh5v
         /icg==
X-Forwarded-Encrypted: i=1; AHgh+RrDny2370O88yTWmGr07N2hh2lX0T97LXJIkHBjIJrbrEXts/B1/UDewcg2EKKB1rrXrBzp8mM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpdqNIGb1DH6GpmnzLeQvpsrup768Nfpf/GLnhWqilnBXf3xOa
	Ir4ZQ6LU5QW2WX7pQJ6Dgvu3zBwHXmvhQ4kmpdRmItP20geioIDFip3D
X-Gm-Gg: AR+sD11AtFl3edzrXEXRMYuoWCB9ajaS2xnX3YpzlAgKaZV0kRtNIOZb50gC43+6eCt
	I5EkazGjb3kGMGBd3lwufR5CtjFe3FveiYycAuSDfP30wc3HqqgZ+AA8XOcpnp/cfZmPZVmn9hu
	RuTbThjEqMJ5rceKmmALCvlm8Erwv8o8Xkkx2vBajBmlIMJGqpSH85EnyPvPFk8E6Qgc15R6+nw
	QI5R7UbxAcYbyF4UJH8lXInMJXABWpKU7zExjNp/DalyrL7SAb3R6IhaJMsGctYujNPPnqql5Tp
	AUnjggeaBvCQLg1H66IgbBc+G+AOKYp5LIjLPrkyCWoHf+xIqTS08CqO9tmiZkNNFo1iu2bnsGV
	XxWLIlHDJEyIm8gDiVgzHqWTnFSqv1i6SNyFWT3pXwoVOfqnwFe3Ile0idTxyL/vwxAt9jojZWs
	KNzAF8rer2QwBha+k5BDx6+vsaXyRARsVwiIOBeW/h9r6Dlmq/kJiiIcHvzOnnWtwn7X+I93ySA
	X7lv0loRNVBxWBlpbZG/HJtf1wO9K80VDlv02TyVyytL4pF8x0=
X-Received: by 2002:a05:6a00:c94:b0:845:4cb5:2343 with SMTP id d2e1a72fcca58-84ee47ecde4mr12278447b3a.19.1785808079122;
        Mon, 03 Aug 2026 18:47:59 -0700 (PDT)
Received: from m-upc-A520M-HDV.flets-east.jp ([2400:2410:3f60:500:cb1c:934a:3e5f:ef88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84edc2d7b97sm4410164b3a.43.2026.08.03.18.47.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 18:47:58 -0700 (PDT)
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
Subject: [PATCH net-next v5 06/10] ipv6: add inet6_rt_del_notify()
Date: Tue,  4 Aug 2026 10:47:10 +0900
Message-ID: <20260804014714.4362-7-sigefriedhyy@gmail.com>
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

Move the body of inet6_rt_notify() to __inet6_rt_notify() and give it
the deletion reason. inet6_rt_notify() keeps its prototype, so the
route addition path does not change.

Add inet6_rt_del_notify() and call it from fib6_del_route().
RTA_DEL_REASON now reaches user space on RTM_DELROUTE for routes the
kernel deleted on its own.

Signed-off-by: Yuyang Huang <sigefriedhyy@gmail.com>
---
 include/net/ip6_fib.h |  2 ++
 net/ipv6/ip6_fib.c    |  2 +-
 net/ipv6/route.c      | 20 ++++++++++++++++----
 3 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/include/net/ip6_fib.h b/include/net/ip6_fib.h
index 0ba5d3c56543..232289b439c3 100644
--- a/include/net/ip6_fib.h
+++ b/include/net/ip6_fib.h
@@ -533,6 +533,8 @@ static inline void fib6_rt_update(struct net *net, struct fib6_info *rt,
 #endif
 void inet6_rt_notify(int event, struct fib6_info *rt, struct nl_info *info,
 		     unsigned int flags);
+void inet6_rt_del_notify(struct fib6_info *rt, struct nl_info *info,
+			 enum rt_del_reason del_reason);
 
 void fib6_age_exceptions(struct fib6_info *rt, struct fib6_gc_args *gc_args,
 			 unsigned long now);
diff --git a/net/ipv6/ip6_fib.c b/net/ipv6/ip6_fib.c
index f8a9ec7fa616..3e382ba1573e 100644
--- a/net/ipv6/ip6_fib.c
+++ b/net/ipv6/ip6_fib.c
@@ -2057,7 +2057,7 @@ static void fib6_del_route(struct fib6_table *table, struct fib6_node *fn,
 			call_fib6_entry_notifiers_replace(net, replace_rt);
 	}
 	if (!info->skip_notify)
-		inet6_rt_notify(RTM_DELROUTE, rt, info, 0);
+		inet6_rt_del_notify(rt, info, del_reason);
 
 	fib6_info_release(rt);
 }
diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index d3bf2dd209bd..1704359d3960 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -6378,8 +6378,9 @@ static int inet6_rtm_getroute(struct sk_buff *in_skb, struct nlmsghdr *nlh,
 	return err;
 }
 
-void inet6_rt_notify(int event, struct fib6_info *rt, struct nl_info *info,
-		     unsigned int nlm_flags)
+static void __inet6_rt_notify(int event, struct fib6_info *rt,
+			      struct nl_info *info, unsigned int nlm_flags,
+			      enum rt_del_reason del_reason)
 {
 	struct net *net = info->nl_net;
 	struct sk_buff *skb;
@@ -6398,8 +6399,7 @@ void inet6_rt_notify(int event, struct fib6_info *rt, struct nl_info *info,
 		goto errout;
 
 	err = rt6_fill_node(net, skb, rt, NULL, NULL, NULL, 0,
-			    event, info->portid, seq, nlm_flags,
-			    RT_DEL_REASON_UNSPEC);
+			    event, info->portid, seq, nlm_flags, del_reason);
 	if (err < 0) {
 		kfree_skb(skb);
 		/* -EMSGSIZE implies needed space grew under us. */
@@ -6420,6 +6420,18 @@ void inet6_rt_notify(int event, struct fib6_info *rt, struct nl_info *info,
 	rtnl_set_sk_err(net, RTNLGRP_IPV6_ROUTE, err);
 }
 
+void inet6_rt_notify(int event, struct fib6_info *rt, struct nl_info *info,
+		     unsigned int nlm_flags)
+{
+	__inet6_rt_notify(event, rt, info, nlm_flags, RT_DEL_REASON_UNSPEC);
+}
+
+void inet6_rt_del_notify(struct fib6_info *rt, struct nl_info *info,
+			 enum rt_del_reason del_reason)
+{
+	__inet6_rt_notify(RTM_DELROUTE, rt, info, 0, del_reason);
+}
+
 void fib6_rt_update(struct net *net, struct fib6_info *rt,
 		    struct nl_info *info)
 {
-- 
2.43.0

