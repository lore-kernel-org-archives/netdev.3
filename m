Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91F093F86F8
	for <netdev@vger.kernel.org>; Tue, 28 Jul 2026 21:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785275704; cv=none; b=g7dRVGejLpXE6jmg8NkAOFPH0ybZeh858/8PPD0/r2Go6GFcWHEH54qySandBdZzbil+zUUYq2Rc97eLiHWTmmIbFkhaRj6Lxd92u+0KLldNcJyrhCAXznHfAKDM6wdYkmfs/5r/3nMTtxuyc6iVi4aYIJEwfXP08QYAbcUrGIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785275704; c=relaxed/simple;
	bh=2qeO/WkF/DClBeUffQkqd0ahYzhZwSzVW/wt0VcPdbo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FeY4EN1IJg6oTV9FvZxz7U0ipNJ+Gn0GMvD6SKHo33YXIO0+AbrPLz29z5rEgIUTAEISPZRFD9abqaYFn80OHT3it7/NsTwtuCqn0P/3yXu1vo6+Dim85P/9gRirH6WZzvWeaRgSjYzkjpertJi2EPS7uO8vLT989T0l4rKTRF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=GYpPaFQL; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="GYpPaFQL"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-ca12086c06eso198800a12.0
        for <netdev@vger.kernel.org>; Tue, 28 Jul 2026 14:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1785275702; x=1785880502; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=3SfYLn9CtNDFB6i8sB+AicmS9yko/JxXpzTNKe6+bXY=;
        b=GYpPaFQLvlnjiVCYf+Ob9z5x3O3G/pfPu4kWry9Sa3J3SHy7zPzcbCIXCXOAI0f8nD
         3Y2KVOY+yFOPYz/4/X4CNYA4suE5pxSUtZ71siVxLu4ec8wk+Ihw/dKTmZgnDrzQgGcp
         XjvjTUmAJ6qPe9E6B103sWWcXN9X7XDW8kw1fM+B93u7HrH5ty2iacXxsgkFhEndbJx2
         JsEXRKlnrBSA/+vGouN8WcffI4UHEWRK7eyPjywIp2liLg0Hi20Xt5x8ZKFY1X2d9hz7
         A0Ivn7GveIWsiR4ufjNHrkHXH4NUfrf+uGP2EQmHJMM/MzJlqKPvXT+JeKQz679RoLgy
         0MAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785275702; x=1785880502;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3SfYLn9CtNDFB6i8sB+AicmS9yko/JxXpzTNKe6+bXY=;
        b=blzHvmOadfuMRV8ElrabgprC3IPPVdknKX9O0HtJQvlPd/PAVm+7nWTuTMclT1SJAr
         pSteYtAa/2oBnVyVuJt4BKhGY7vkL7vQ5YfIVLF9IVqGfw7PhlAon+9V49ecL7v3C3YN
         wBgwOqcl2yVzTyN4DElrrBCFIgowJI85mtQegLkOJ5CfnAe5DL3CLnL3f/T0y0lmQCGY
         XegJ3kZnAjVZo8uy1hIdfR66s0X7gndo4eD5TCFcnQ5ZS7qrdTpZKfEReJcEjZrRSfWW
         gYkA2gWUXosCDR6RX5+NePGJmy44ceAG3Z6aOHXqR0vh1a/kpnEJUDlhbdRg8rHEqKcn
         ySgw==
X-Forwarded-Encrypted: i=1; AHgh+RpWQaG7FwOwaazjV/+y6gCL8ZWu6LKo+C5PtmdCDQNIFqGdCRv8GwF84mUHwsUNjvp0REOyIqI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsRpxEhZMFsWPave4sGS5Me85vA8Q4jIGHJuMpSvm8wPhH6Fhx
	gWCVplxGifyy48Pm0dqRoydMqBuSdiVx8DnNwPmAFajopiMezip+kyEj8RNXn8kgIA==
X-Gm-Gg: AR+sD11T5X4179sQlclGxNkaan3tv2HhRlVWRhyTQqXLg2XZFwg54eZ2PFKmhaSLyWt
	QFxfIkcQd2FpeD3FzZKuRkX4bkHvhIFhQz+208oodoWBjbq8n/iZGiRxhqzwjJFJvggmPsMLpMk
	sHuPbuse89iC92bWp63A7f+o172iUPhN12RrH0Z5iISFosA6Q+UwsJXgU6YBEGHzVYus3vC6jCW
	i1HhKj7ddjWyRDHXVwzFVs4b9JTa69eX/xWRGAF8WLur9fqE7WyKckHNzaPmqqVPByDiC05aU3L
	IVzq9x95kFZX05k9SRuwL+eV11ZqnudRwBX8lEri2kdijQe9WI7ycOETJSr1fiQPhCywvrqZtRR
	idnF6RP2iNI1wcjEp9+IwKAI8HI0DxmIHeM9n2SQMGQJVCSLPJMWYnmeVvf9ecRJBuEJ4pRXWct
	9MaZXd7/zTMgW3/+lXUr+MdGRtnLBe2WJl0LhxhpDkFxhHFjXku1MKhARAUzWLroZfyQ==
X-Received: by 2002:a05:6a20:d529:b0:3c3:856e:dccd with SMTP id adf61e73a8af0-3c8ab0e59b0mr5362874637.23.1785275701861;
        Tue, 28 Jul 2026 14:55:01 -0700 (PDT)
Received: from xiang.tailc0aff1.ts.net ([20.171.14.70])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31504b670cfsm2232736eec.8.2026.07.28.14.55.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 14:55:01 -0700 (PDT)
From: "Xiang Mei (Microsoft)" <xmei5@asu.edu>
To: kuba@kernel.org,
	pablo@netfilter.org,
	Andrea Mayer <andrea.mayer@uniroma2.it>
Cc: "David S . Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ryoga Saito <contact@proelbtn.com>,
	AutonomousCodeSecurity@microsoft.com,
	tgopinath@linux.microsoft.com,
	kys@microsoft.com,
	"Xiang Mei (Microsoft)" <xmei5@asu.edu>
Subject: [PATCH net v2 1/2] seg6: check lwtunnel state after nf hooks in seg6local
Date: Tue, 28 Jul 2026 21:54:47 +0000
Message-ID: <20260728215448.1543553-1-xmei5@asu.edu>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When nf_hooks_lwtunnel is enabled, three seg6local functions run as the
okfn of a netfilter hook and recover the behavior's parameters by
re-reading skb_dst(skb)->lwtstate:

  seg6_local_input_core()          LOCAL_IN
  input_action_end_dx4_finish()    PRE_ROUTING
  input_action_end_dx6_finish()    PRE_ROUTING

The okfn signature is (net, sk, skb), so the skb's dst is the only place
the state can be found, but a hook is free to change it.
nf_nat_ipv{4,6}_in() calls skb_dst_drop(skb) once a NAT rule has
rewritten the addresses, and the okfn then dereferences NULL. A hook can
also leave a metadata dst, a route whose lwtstate is NULL, or a route of
a foreign encap type, the last of which makes seg6_local_lwtunnel()
reinterpret another structure so that seg6_local_input_core() calls
through slwt->desc->input.

An unprivileged user can reach the End.DX6 case from a user and network
namespace: enable nf_hooks_lwtunnel, install a seg6local End.DX6 route
and an nftables ip6 nat PRE_ROUTING DNAT rule, then send one matching
SRv6 packet. It panics in softirq NAPI receive context:

  Oops: general protection fault, probably for non-canonical address...
  KASAN: null-ptr-deref in range [0x0000000000000080-0x0000000000000087]
  RIP: 0010:input_action_end_dx6_finish (net/ipv6/seg6_local.c:912)
  Call Trace:
   input_action_end_dx6 (net/ipv6/seg6_local.c:946)
   seg6_local_input_core (net/ipv6/seg6_local.c:1621)
   seg6_local_input (net/ipv6/seg6_local.c:1643)
   lwtunnel_input (net/core/lwtunnel.c:465)
   ipv6_rcv (net/ipv6/ip6_input.c:351)
   __netif_receive_skb_core.constprop.0 (net/core/dev.c:6165)
  Kernel panic - not syncing: Fatal exception in interrupt

Add a helper that returns the state only when skb_dst() still is a real
(non-metadata) route whose lwtstate is of the expected type, and drop the
packet otherwise.

The six other callers of seg6_local_lwtunnel() take the lwtunnel_state as
an argument from the lwtunnel core, which dispatched them through
seg6_local_ops, so the pointer and its type are known good.

Fixes: 7a3f5b0de364 ("netfilter: add netfilter hooks to SRv6 data plane")
Reported-by: AutonomousCodeSecurity@microsoft.com
Signed-off-by: Xiang Mei (Microsoft) <xmei5@asu.edu>
---
v2:
 - Check that the dst is valid and its lwtstate is of the expected type,
   not just that the dst is non-NULL (Jakub Kicinski, Pablo Neira Ayuso,
   Sashiko).
 - Also fix seg6_local_input_core(), same okfn-after-NF_HOOK shape.
 - seg6_iptunnel.c is handled in patch 2/2 (Andrea Mayer).

v1: https://lore.kernel.org/all/20260720204430.1886091-1-xmei5%40asu.edu/

 net/ipv6/seg6_local.c | 34 ++++++++++++++++++++++++++++------
 1 file changed, 28 insertions(+), 6 deletions(-)

diff --git a/net/ipv6/seg6_local.c b/net/ipv6/seg6_local.c
index 2b41e4c0dddd..b75a4dc3a36d 100644
--- a/net/ipv6/seg6_local.c
+++ b/net/ipv6/seg6_local.c
@@ -24,6 +24,7 @@
 #include <net/addrconf.h>
 #include <net/ip6_route.h>
 #include <net/dst_cache.h>
+#include <net/dst_metadata.h>
 #include <net/ip_tunnels.h>
 #ifdef CONFIG_IPV6_SEG6_HMAC
 #include <net/seg6_hmac.h>
@@ -213,6 +214,17 @@ static struct seg6_local_lwt *seg6_local_lwtunnel(struct lwtunnel_state *lwt)
 	return (struct seg6_local_lwt *)lwt->data;
 }
 
+static struct seg6_local_lwt *seg6_local_lwt_from_skb(struct sk_buff *skb)
+{
+	struct dst_entry *dst = skb_dst(skb);
+
+	if (!skb_valid_dst(skb) || !dst->lwtstate ||
+	    dst->lwtstate->type != LWTUNNEL_ENCAP_SEG6_LOCAL)
+		return NULL;
+
+	return seg6_local_lwtunnel(dst->lwtstate);
+}
+
 static struct ipv6_sr_hdr *get_and_validate_srh(struct sk_buff *skb)
 {
 	struct ipv6_sr_hdr *srh;
@@ -905,11 +917,14 @@ static int input_action_end_dx2(struct sk_buff *skb,
 static int input_action_end_dx6_finish(struct net *net, struct sock *sk,
 				       struct sk_buff *skb)
 {
-	struct dst_entry *orig_dst = skb_dst(skb);
 	struct in6_addr *nhaddr = NULL;
 	struct seg6_local_lwt *slwt;
 
-	slwt = seg6_local_lwtunnel(orig_dst->lwtstate);
+	slwt = seg6_local_lwt_from_skb(skb);
+	if (!slwt) {
+		kfree_skb(skb);
+		return -EINVAL;
+	}
 
 	/* The inner packet is not associated to any local interface,
 	 * so we do not call netif_rx().
@@ -956,13 +971,16 @@ static int input_action_end_dx6(struct sk_buff *skb,
 static int input_action_end_dx4_finish(struct net *net, struct sock *sk,
 				       struct sk_buff *skb)
 {
-	struct dst_entry *orig_dst = skb_dst(skb);
 	enum skb_drop_reason reason;
 	struct seg6_local_lwt *slwt;
 	struct iphdr *iph;
 	__be32 nhaddr;
 
-	slwt = seg6_local_lwtunnel(orig_dst->lwtstate);
+	slwt = seg6_local_lwt_from_skb(skb);
+	if (!slwt) {
+		kfree_skb(skb);
+		return -EINVAL;
+	}
 
 	iph = ip_hdr(skb);
 
@@ -1609,13 +1627,17 @@ static void seg6_local_update_counters(struct seg6_local_lwt *slwt,
 static int seg6_local_input_core(struct net *net, struct sock *sk,
 				 struct sk_buff *skb)
 {
-	struct dst_entry *orig_dst = skb_dst(skb);
 	struct seg6_action_desc *desc;
 	struct seg6_local_lwt *slwt;
 	unsigned int len = skb->len;
 	int rc;
 
-	slwt = seg6_local_lwtunnel(orig_dst->lwtstate);
+	slwt = seg6_local_lwt_from_skb(skb);
+	if (!slwt) {
+		kfree_skb(skb);
+		return -EINVAL;
+	}
+
 	desc = slwt->desc;
 
 	rc = desc->input(skb, slwt);
-- 
2.43.0

