Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4F7B224B1E
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 01:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791422048; cv=none; b=iky30Z5q4OzdL1kcIUGdGavS6YnArdCZaB2tPpjKQ8+oXSULnZEitydmVi5JGrzqP89PID9DqhEMdU/43qmsPifgaY68KRNO46o/I2o+X2TuomeUDx3ywp5tnCp37J2CAzA7jMaVVzGFr2bOJTfNLkydgogjPkluLb/MF6Rixek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791422048; c=relaxed/simple;
	bh=bextlbdLEL1x7OK1WA/qkO4fVbrMdsVFqmmkNDgwT10=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EBcrdBT4QJmAQ7+71ih/Tc76I/eLOOZQasjVXVG1kZpK+UEfq2s58NoALzQRrGT11mKnBSzMvqgLy5D9c7BpEuhn5ec8sL3L52QzmuLtfwW1enTPewPLTvrungVMn4s6dgAbLxaj4SYiGkfwonDE8b1KS1U78J9STNnWo3Vq8Cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=YnJbNBJn; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="YnJbNBJn"
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-823545ce223so4030743a34.2
        for <netdev@vger.kernel.org>; Wed, 07 Oct 2026 18:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1791422045; x=1792026845; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=K7dN6q1DVq+JBc4NWV9L91mIrstCqQxMk6a5w1N4MMM=;
        b=YnJbNBJnymd8pDJP+zkyB1YSMU1DYLba+9QgtaIP8kEBqY0FJNHjPA3/g8bHVoUtzv
         0f/mrHZjLVcE4+3+aV1+6OUdNeL9FZpEV4VZdmrtA+8S6CKMuQptdkka3BmvuNQ2P0jZ
         NiDaXXsPwoMp2iHA97FZEIjoPOOhs4yX6Qm64=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791422045; x=1792026845;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=K7dN6q1DVq+JBc4NWV9L91mIrstCqQxMk6a5w1N4MMM=;
        b=NzyCNyqi54pflSjx38ljW4zimaxOKmsZLRObekLzRyy5U6EiWQX2AGB/fSJYhvWB9i
         pOk+ypC/u4wT5tvYO90XM3WF65LwZ6+hQ9uZ4KRqXGHLZJe8A2ksHMVWUFDcZNzknujC
         yKNXlcJgFH+es5h2PXCm0ZK8pKgxnfQZqorZrgNoG5QpNNZLxde+e0bVkfjxzjhbVm/7
         f6zAATBBx2JWh+cDqRKJ2ZbAz27416epe/2BUlvnYb5WYGtksFEc+Wejh2/nzeCwo79G
         HzflZxJayIKDGL9C5GPP73K3j2BNIfSeh/31wLsnyCSb2F5uAPaGkvoOEj3W/BJVEmgN
         Gm4g==
X-Gm-Message-State: AFuF++lfRmWXiHv3LxEcXGdUKQUwjQP13NoWl62Z628/0M3ST6bHoWbU
	yCk8oCsnrJjlCY3BrN5OiXhArwdk9qOOErgknYe+L40crCy+/Wnv9ej5QLb4TKY+WpvXJ/POPUk
	F6D18WME=
X-Gm-Gg: AYBFou02uq8/oqeM5RKrbN/EaIlsM+iPr1Rwq30lfIlzXdgXNKl4JT68LJqMyo9FMtQ
	A7eGBuSu56UbMgPEVAAWU9ua0wU9qlWaX+7Xg/gLypR6JBS9rUQjLeyEPnICdUvj/xkZJr32IuU
	BdSQQd6QGfYzVjMET+L3PnBedcQvfHqTSOWjd0G/2tEVo6s6tIMJGk3YtDC37LeW1n8v//F3A7R
	hd4yPbQwgObleCSP0KOxdEqqzGRIhbOosszZJB83Foyvc5Sv8pD1H0t1p9+Mm3vWlae5gnj+922
	T1RVN9db1ftKWDhZacwCUXnHdMi3GV2JZd+I0DghuZSHnq2V6IXWD1wjGq31vU6RkyrC9aiZ7oD
	ph/aUObBsoLDAWNfZ99KyvwDaCwKgklFhj2/pezemTx251qte8HxHJt5td507tbmuiU+BjNaKrY
	TswmckRigsbloLhGGAB6GJ7CKDAl4I+tm+JHVICSlW1DyvjUGi2a/7SHzbVh05MmaW9HBW0Rob7
	s7Wi4XPvQFHud8RBTos4CH8VozJcddr6rmtOKTFC025wjfE6s32bSp7J5kr/QpA5P0ytJwpVZjv
	syClTD1sSg==
X-Received: by 2002:a05:6830:82be:b0:81b:8032:716d with SMTP id 46e09a7af769-82acf9ac9c4mr5132412a34.20.1791422045501;
        Wed, 07 Oct 2026 18:14:05 -0700 (PDT)
Received: from com-75606.corp.openai.org ([199.47.143.7])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-82adbdf42f1sm5179099a34.8.2026.10.07.18.14.04
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 07 Oct 2026 18:14:05 -0700 (PDT)
From: Kyle Zeng <kylebot@openai.com>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	outbounddisclosures@openai.com,
	Kyle Zeng <kylebot@openai.com>
Subject: [PATCH net v2] netlink: avoid hashing the network namespace pointer
Date: Wed,  7 Oct 2026 18:14:00 -0700
Message-ID: <20261008011359.63727-2-kylebot@openai.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The netlink rhashtable key includes a raw struct net pointer and a
user-controlled port ID. Both /proc/net/netlink and socket diagnostics
expose the table's bucket order. By binding and rebinding chosen
NETLINK_USERSOCK port IDs, an unprivileged reader can distinguish equal
buckets and recover the low bits of the Jenkins hash. Its 32-bit seed
and the limited set of kernel-image slides can then be searched offline
to recover the address of init_net.

Use the namespace's unique, non-address net_cookie in the comparison
key instead. It is assigned before the per-net initializers run and
remains unchanged for the namespace's lifetime. The lookup key and
object hash are still built by netlink_compare_arg_init(), keeping
lookup, insertion, removal and rehashing consistent while preserving
namespace separation. Neither public table walker needs to change.

Reading the socket's namespace cookie in netlink_compare() is safe
under RCU, including during namespace teardown. netlink_release()
removes the socket from the hash table and defers its final put with
call_rcu(). cleanup_net() runs the per-net exit methods and waits for
outstanding RCU callbacks with rcu_barrier() before freeing namespace
storage.

Unlike ns.ns_id, net_cookie is also available and initialized during
setup_net() in older stable kernels, making the change straightforward
to backport to v5.15 and later.

Fixes: c428ecd1a21f ("netlink: Move namespace into hash key")
Assisted-by: LLM
Signed-off-by: Kyle Zeng <kylebot@openai.com>
---

Changes in v2:
- Use net_cookie for compatibility with older stable kernels.
- Name the key field net_cookie to avoid confusion with netns IDs.
- Explain the RCU lifetime of the socket and network namespace.

 net/netlink/af_netlink.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
index 9fdf964224ab..39db078c925c 100644
--- a/net/netlink/af_netlink.c
+++ b/net/netlink/af_netlink.c
@@ -464,7 +464,7 @@ netlink_unlock_table(void)
 
 struct netlink_compare_arg
 {
-	possible_net_t pnet;
+	u64 net_cookie;
 	u32 portid;
 };
 
@@ -479,14 +479,14 @@ static inline int netlink_compare(struct rhashtable_compare_arg *arg,
 	const struct netlink_sock *nlk = ptr;
 
 	return nlk->portid != x->portid ||
-	       !net_eq(sock_net(&nlk->sk), read_pnet(&x->pnet));
+	       sock_net(&nlk->sk)->net_cookie != x->net_cookie;
 }
 
 static void netlink_compare_arg_init(struct netlink_compare_arg *arg,
 				     struct net *net, u32 portid)
 {
 	memset(arg, 0, sizeof(*arg));
-	write_pnet(&arg->pnet, net);
+	arg->net_cookie = net->net_cookie;
 	arg->portid = portid;
 }
 

base-commit: 602042bf29f6efde39cfb5fdd9289bf4854bc0c5
