Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16D703C13EC
	for <netdev@vger.kernel.org>; Tue,  6 Oct 2026 22:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791326534; cv=none; b=NjcXkBs3P65T/t3WImxBqsKC0eS5vGWL9Bh2d/sXpq+arfCmCBaaL700vsiUy4C16zoKXxzqXwkgaQCdsNd0FDhsmB+jf2rgfMXtxJ3oCeoeoTpngzg1UeIsyhYfJ0fVK6KkEdg+ku2Vqz7ep/O5IEkYR7ssvJ8JfgcSJK7Qmk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791326534; c=relaxed/simple;
	bh=tF6woHDg7ileDh3Mif219tJ3RB98MgJB4BX/8WlRgJI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SHfhVxtZUjb3kfg+EeOcu1elEtNSG8O6/titZLD/vtEHup2EwtSihwtbDvhTddDrZn4GB0DrYXooawl2gStCa8851TkhYn4To5FIzIe+WGL/lAEi3aruzFzmGPEQ5yrqKOXrAHJ9P1yePcPL2gE6sbufdcGmb19MnMKIdD7SKUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=a94SS9gz; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="a94SS9gz"
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-4f5d3bff929so2261643b6e.1
        for <netdev@vger.kernel.org>; Tue, 06 Oct 2026 15:42:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1791326513; x=1791931313; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=q6XYGdL3I+tAtmV9WIKjy0bqKE9rScVO4aiYLXZi1NI=;
        b=a94SS9gzY5MYPsrD2UoBiJhZ0ceVEJliSgTQkMo1XdQO4M0EgwDG5XnNjQ896pZiBr
         a/zjE9liTxI8Ttsj16f0N6XuLzfvSVM6M1ladfFmJd6oj0rEGoY5MdOhLIAb70dsj22U
         ZM8jZULE1IXK57J/wD6l1+z4OXm0A3u8qUst0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791326513; x=1791931313;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=q6XYGdL3I+tAtmV9WIKjy0bqKE9rScVO4aiYLXZi1NI=;
        b=2aYNXukC2YBS5rC4vs77x6t/HOIQEWdBKX97HTLjxKFWXTzbPWAlezpvhY8VJhEiOY
         O0EKFEO4+2DL3J5smxt/wpM0RFVg3ATMfh8IweWXLleIlHkYOtUY/tiESFnXziJ3QzKO
         D9MPolVTJiXsc0l2t63sdg2B21dq4C3RCKDZUxh06j4UdOu148xYu2mdCapLDP0fUPmz
         O9QurOI17gupwCVSxAmssHLFs/C9QFY+y9T6Um54JNVbAyELswfSKIuapdYWD2+kBgOT
         M1GrTVuMh0Wbq6VRLF2h+eYALgXG4ijXjc1Fmq6vCbR815rpEUET6+7+kV23SsCKWXg7
         lj2w==
X-Gm-Message-State: AFuF++kpZ/E2lcnW/t+NH4JvnfkilouzDXWa0vkhGIiMvNdUkLIyO1Rt
	NmsT/vt2VazgOTW/gzdIhiXM4rGik5I7sm8xp0LwLcZ/+YdXbdx6tYedHvUae0zaxb8eszs5kbT
	uj+l0Y9M=
X-Gm-Gg: AYBFou2kS5IVaRRGPDeYZCfd8dySkBQ6JKLLxW9QyqbbTJzrH3jqEWHJHX1xDW6mY2O
	ojv3Vyzf/VBrT9nSoyHuti/aoJ9qANh53YSWPM9qHO4vv5nd2OH0o3/lZZ4gM/d1Lir8zfODHJx
	qEQbEy0i7smmCgmnFX+yiPurbXHY6Qs0knWVu81bjwi1IuP/K4Or99yzxRNczpxZHKglV3/56g+
	D5GFFauP6h9bd/xf1Jikte1LvQZ1Trz8vTSOgX/N0MZP/xC86Er6GrOa8iwbux2LIzhja6w9WMQ
	fJ65b7Hc2TUUamYNdeE8bC4lgX23ghMEKjNjAqcKJkZKu85U2Pxkjk7xGZe6T7/1aXchfvFY9Fm
	CO99DwM9O7ze2rhxu/RppVEf7BuKXKzezH/TDJn08CjmW1quYioXl4hbaPhOQ6euFdd9kG1WJW7
	IH5/CmWSeygNIPpd+YM6ImRyjF4rcYbu9D55vOkn7zc87rCNg9lrhgi9FGzd35oHnnEH3EY2akE
	42NVULLExxBhMYjwo4khbBiC5Vu9N4cKBsEZ+78l8fq6rkdPnJ/kARI/kCKp8PaSdf60WyLEaM=
X-Received: by 2002:a05:6808:16a1:b0:4f1:c824:fd06 with SMTP id 5614622812f47-4fc46984c21mr760312b6e.14.1791326513041;
        Tue, 06 Oct 2026 15:41:53 -0700 (PDT)
Received: from com-75606.corp.openai.org ([199.47.143.7])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4fc49656fbfsm655946b6e.15.2026.10.06.15.41.52
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 06 Oct 2026 15:41:52 -0700 (PDT)
From: Kyle Zeng <kylebot@openai.com>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	outbounddisclosures@openai.com,
	Kyle Zeng <kylebot@openai.com>
Subject: [PATCH net] netlink: avoid hashing the network namespace pointer
Date: Tue,  6 Oct 2026 15:41:49 -0700
Message-ID: <20261006224149.50498-1-kylebot@openai.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The netlink rhashtable key includes a raw struct net pointer and a
user-controlled port ID.  Both /proc/net/netlink and socket diagnostics
expose the table's bucket order.  By binding and rebinding chosen
NETLINK_USERSOCK port IDs, an unprivileged reader can distinguish equal
buckets and recover the low bits of the Jenkins hash.  Its 32-bit seed
and the limited set of kernel-image slides can then be searched offline
to recover the address of init_net.

Use the namespace's unique, non-address ID in the comparison key
instead.  This ID is assigned before the per-net initializers run and
remains unchanged for the namespace's lifetime.  The lookup key and
object hash are still built by netlink_compare_arg_init(), keeping
lookup, insertion, removal and rehashing consistent while preserving
namespace separation.  Neither public table walker needs to change.

Fixes: c428ecd1a21f ("netlink: Move namespace into hash key")
Assisted-by: Codex:gpt-6-astra
Signed-off-by: Kyle Zeng <kylebot@openai.com>
---
 net/netlink/af_netlink.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
index 9fdf964224ab..e62bb67b78b0 100644
--- a/net/netlink/af_netlink.c
+++ b/net/netlink/af_netlink.c
@@ -464,7 +464,7 @@ netlink_unlock_table(void)
 
 struct netlink_compare_arg
 {
-	possible_net_t pnet;
+	u64 netns_id;
 	u32 portid;
 };
 
@@ -479,14 +479,14 @@ static inline int netlink_compare(struct rhashtable_compare_arg *arg,
 	const struct netlink_sock *nlk = ptr;
 
 	return nlk->portid != x->portid ||
-	       !net_eq(sock_net(&nlk->sk), read_pnet(&x->pnet));
+	       sock_net(&nlk->sk)->ns.ns_id != x->netns_id;
 }
 
 static void netlink_compare_arg_init(struct netlink_compare_arg *arg,
 				     struct net *net, u32 portid)
 {
 	memset(arg, 0, sizeof(*arg));
-	write_pnet(&arg->pnet, net);
+	arg->netns_id = net->ns.ns_id;
 	arg->portid = portid;
 }
 

base-commit: fd179f8a05be3ccae366b9b96e176b51fbe54aab
