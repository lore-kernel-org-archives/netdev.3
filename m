Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73930309EFC
	for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 00:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790123827; cv=none; b=UUkmssZ0In3NslrBF/JAZ/iSx3Ww8PtByliWmLi8fo4VsnNRJqMOkU1xvq/Z+jm4bNXRh0thS3qt+sXrvgsoN9BcDl6nJFQ6v5M/Scnxs0YwolitFih02RKl74gEnilAItLcHmKn7MglHVUcUMLqIqAGNs3EsEMQ0DYwasNxAto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790123827; c=relaxed/simple;
	bh=4GmpNfU3LQJSJpqQsR6/KFUehJWyBgCDEINSJI93IoU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=M8l4oC14gbfVYCjezrxIn+Pw+1yy6gJEWbdFGHSZ7bRWe2dCWtTw6RlNCXlFcby6idNzVZ5jnkHuVZHYb4R4Zy7eDdzsqr1MSseBLE9T5SDwUHbvdV+ls0IbNSujHlD23eohQHKH6efICAwQa2MBZ5emEOYKiQG73nmOO7VXFTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aJveOrB0; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aJveOrB0"
Received: by mail-pz2-f12.google.com with SMTP id d2e1a72fcca58-8692a856865so220921b3a.2
        for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 17:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790123826; x=1790728626; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hr/q+PFpOYwfdPGF3n4BjUmiJpuCV+tZ3wvtyOR+SaI=;
        b=aJveOrB0Mra2DE7rRtm4jSoFHGhSRfwfiHF6IAzvI2+qiUMe2/TqHK1wzPcnGROmDN
         Yjm4CnDbH9yxAfX87R/bjReLg3lEr09B4M8P7xXt84uGQPvBfAh0CCN+ipdRc5ZPLLIq
         ahzs0Y69rFMW9b8QpF0GmLKCbhoXoxkkUHZD6J45ncLHYO/rN2Rn5F41pRu4ShJJri9u
         EafLif2Czzfa4/5OacdWbZMmvrweSQqYazisfeoNVPNcHKK03PfQ4YWBxaFB4OrULJdX
         Dz0Q8w8MvzRfWNdPMumLqrWaWtfSR4F8ZcA/1RlHAZa/EF2xSly7i2GPbpvAPZIt166n
         bsNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790123826; x=1790728626;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hr/q+PFpOYwfdPGF3n4BjUmiJpuCV+tZ3wvtyOR+SaI=;
        b=ValfwhNOnZe3TgKktnTc18vbiWqCiaqKvmajVrWFVWhkrg+f76AfQSqtlLN9hSWshu
         jffyp+1sKBhYmV5zY44ESybWYb+skZgLHwsGZJbVcH+ZIDaO3is7B5iVRnrH7S2ss11u
         vi4NzfTshlhRHQDX3qQ8WGiD5kafDkojVuuq7MjqsklN4oJ5zOspgtGmQEWz7F6qCfse
         DDlg8ohODjonE3A/0dnXhkAlPt1BwGawmuO6h1jPgwwbQpA0zdhHBzJxLHWo5Hd7Ygci
         nqKvetLuT4JsGoTK17fGxWheM7TmdwPn6xv2jjOrSBgG9XqzJes9RD2D0wELgzKIGfqw
         Hqhw==
X-Gm-Message-State: AFuF++nDLjiNDoY5sN+o7KQkhlxXwY0m5YEuYTE5sG068Q4oJm9l1gB9
	+6Zn4YAKhwSFfDj/BmV4cLQMVYFlt13t4Gp9Fj4awLBM/aUi8IMtKOBn
X-Gm-Gg: AYBFou2rkn1KIewghe9I6LeviOQBOtoXmxCs7NetNOntMHuIVq223VE5vIa6lSC4Lss
	eWUxXUzo5c9ViWMtM6BjeLhF6xXxi87P/MxI6Lqeh+yRt9L27pDDiQRP7RZ0ijMqxRtQzokafW4
	t+fnro1ZhtSm2xyOpRl8lbmODPHKca60dcAdvfVtzri7b2lVOzlvvYCjXPO1OMRd/R9EPWENm+h
	Dcl0llmRWusGQVI1gGHL24IxFZDMUGMQrz9HBw2t2LeSoANF7LmsR89nS5YAMwdz8+E7OGKSZRz
	RoCxfXi2svhWed1gqy3iq4dHHgFZJReMYYclaHVhsOJGULWUzwxKQG2EOyrSsVXbzsYomF4KxtL
	7FAbAzDQj2jn4EfM2khDkm9rTaClSffqC9l5qCNS0Tv8vj+He2sn6hyZozzy2HSa5uTuz6Ysij+
	OkeNHK5gN9hQm2RY0IGQ43uHlmpwmUKlFl4HzKcA8ZkvQ4EcV/VM6XI9ANn4m6cOlwRMd74iYC/
	Nz3kvRxJg==
X-Received: by 2002:a05:6a21:8209:b0:3cd:61d5:f342 with SMTP id adf61e73a8af0-3ddf7caaa23mr1367384637.9.1790123825606;
        Tue, 22 Sep 2026 17:37:05 -0700 (PDT)
Received: from [163.43.103.131] ([163.43.103.131])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-87d1dff9778sm427895b3a.49.2026.09.22.17.37.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 17:37:05 -0700 (PDT)
From: Yuya Kusakabe <yuya.kusakabe@gmail.com>
Date: Wed, 23 Sep 2026 09:36:56 +0900
Subject: [PATCH net 1/4] net: lwtunnel: accept RTA_ENCAP without
 NLA_F_NESTED
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260923-lwt-encap-noflag-v1-1-8de7ab6c86e9@gmail.com>
References: <20260923-lwt-encap-noflag-v1-0-8de7ab6c86e9@gmail.com>
In-Reply-To: <20260923-lwt-encap-noflag-v1-0-8de7ab6c86e9@gmail.com>
To: David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Justin Iurman <justin.iurman@gmail.com>, 
 Alexander Aring <alex.aring@gmail.com>, 
 Steffen Klassert <steffen.klassert@secunet.com>, 
 Herbert Xu <herbert@gondor.apana.org.au>, 
 Nikolay Aleksandrov <razor@blackwall.org>, 
 Eyal Birger <eyal.birger@gmail.com>, 
 Nicolas Dichtel <nicolas.dichtel@6wind.com>, 
 Xin Long <lucien.xin@gmail.com>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Yuya Kusakabe <yuya.kusakabe@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4481;
 i=yuya.kusakabe@gmail.com; h=from:subject:message-id;
 bh=4GmpNfU3LQJSJpqQsR6/KFUehJWyBgCDEINSJI93IoU=;
 b=owEBbQKS/ZANAwAIASrX0XUqXRtNAcsmYgBqsx8pyJmi0jAqYRMcjxJXjhNdLthCsldl2TNYY
 eoZwTVjneuJAjMEAAEIAB0WIQTaB7usAfxNKMeqa6Yq19F1Kl0bTQUCarMfKQAKCRAq19F1Kl0b
 TblhEACVx9cyL9CTQZ3/LW7LeTj/pABjToLaFkHgZfuwSHVlBzTS3yu2+krdGau9EL0CJLVq188
 r59Ar1A4fN6ev/mtkMZTb9m4UFSvhfuQrsbbQ9Zd0LGFxxkkWuJ170XfUk55jGj9oRDhwwSBp7a
 iuLADGLOepwwxQK8MKiJrvr7lGnEq6Q9C0dia8k8T+eKEhaPKiQsUnXsCZY9MJq3pLZjNhcdNw5
 10rk+G6Hl4EHEYcBhJxVyntwoGR2ef6ADM5ih30/hCbD85BnpUkawKwFUgHkwkgy9JHYHQBQRNJ
 STemUUjI372w6gVbvk3c4sjuxyGn0rOujU09KGmhYa7wJVctO8SX4Ry0lmeXH687Un/dzUdu0Q+
 438+cRsJ3+IPhbkdFjdx0bJuig9BFP75GU0naBgDbpPbi1vCJL9OKz6yGUJN2M6YXnrOQiuyqll
 eAYAsp5rr9u4yEQmWMbCLjiA0rs6awRsRbGu0jpM04Dvz2grecEaGjWpba3JliD0QFjXzOwexGr
 v0L3BDfh1TPlLJh1E9aghLCjpGZzg4Hk1N6y5VDou+ZyJeWhwuirNZwA/bI/I7FOqRErShqf+OP
 4xIHAxSaMT1DqeWZxWWnvi4HR8Zy5sW2vGYbOZ7SikZV6jM2OeAAXF1KHdZPnOqwH8JLWhp1SoQ
 ETkdu7NZ992w6Zw==
X-Developer-Key: i=yuya.kusakabe@gmail.com; a=openpgp;
 fpr=DA07BBAC01FC4D28C7AA6BA62AD7D1752A5D1B4D

lwtunnel_fill_encap() dumps RTA_ENCAP without NLA_F_NESTED, and
"ip route restore" sends the routes saved by "ip route save" back to
the kernel unchanged.  rpl and ioam6 break on the same path:
lwtunnel_build_state() hands the restored RTA_ENCAP to their
build_state callbacks, which parse it with nla_parse_nested() and so
require the flag.  Restoring an rpl route fails as below, and an ioam6
route fails with the same error:

  # ip -6 route add 2001:db8:1::/64 encap rpl segs 2001:db8::2 dev dummy0
  # ip -6 route save 2001:db8:1::/64 > route.bin
  # ip -6 route del 2001:db8:1::/64
  # ip -6 route restore < route.bin
  Error: NLA_F_NESTED is missing.

Setting the flag in the dump is not an option: userspace that does not
mask it off the attribute type, such as parse_rtattr() in iproute2,
would no longer find RTA_ENCAP.

Add lwtunnel_nla_parse(), which validates the nested attributes
strictly but does not require the flag on RTA_ENCAP itself, and use it
in rpl and ioam6.  Switching them to nla_parse_nested_deprecated()
instead would also make them accept unknown attributes, which they have
rejected since they were added.

Fixes: a7a29f9c361f ("net: ipv6: add rpl sr tunnel")
Fixes: 3edede08ff37 ("ipv6: ioam: Support for IOAM injection with lwtunnels")
Assisted-by: LLM
Signed-off-by: Yuya Kusakabe <yuya.kusakabe@gmail.com>
---
 include/net/lwtunnel.h    | 27 +++++++++++++++++++++++++++
 net/ipv6/ioam6_iptunnel.c |  4 ++--
 net/ipv6/rpl_iptunnel.c   |  4 ++--
 3 files changed, 31 insertions(+), 4 deletions(-)

diff --git a/include/net/lwtunnel.h b/include/net/lwtunnel.h
index 26232f603e33..046978d6224c 100644
--- a/include/net/lwtunnel.h
+++ b/include/net/lwtunnel.h
@@ -6,6 +6,7 @@
 #include <linux/netdevice.h>
 #include <linux/skbuff.h>
 #include <linux/types.h>
+#include <net/netlink.h>
 #include <net/route.h>
 
 #define LWTUNNEL_HASH_BITS   7
@@ -37,6 +38,7 @@ struct lwtunnel_state {
 };
 
 struct lwtunnel_encap_ops {
+	/* encap may lack NLA_F_NESTED, parse it with lwtunnel_nla_parse() */
 	int (*build_state)(struct net *net, struct nlattr *encap,
 			   unsigned int family, const void *cfg,
 			   struct lwtunnel_state **ts,
@@ -53,6 +55,31 @@ struct lwtunnel_encap_ops {
 	struct module *owner;
 };
 
+/**
+ * lwtunnel_nla_parse - parse the attributes nested in an lwtunnel encap
+ * @tb: destination array with maxtype+1 elements
+ * @maxtype: maximum attribute type to be expected
+ * @nla: encap attribute passed to &lwtunnel_encap_ops.build_state, or an
+ *	attribute nested in it
+ * @policy: validation policy
+ * @extack: extended ACK report struct
+ *
+ * The encap attribute, and some of the attributes nested in it, have always
+ * been dumped without NLA_F_NESTED, and userspace such as "ip route restore"
+ * sends a dump back unchanged, so the flag cannot be required on @nla.
+ * The attributes nested in @nla are still validated strictly.
+ *
+ * Return: 0 on success or a negative error code.
+ */
+static inline int lwtunnel_nla_parse(struct nlattr *tb[], int maxtype,
+				     const struct nlattr *nla,
+				     const struct nla_policy *policy,
+				     struct netlink_ext_ack *extack)
+{
+	return nla_parse(tb, maxtype, nla_data(nla), nla_len(nla), policy,
+			 extack);
+}
+
 #ifdef CONFIG_LWTUNNEL
 
 DECLARE_STATIC_KEY_FALSE(nf_hooks_lwtunnel_enabled);
diff --git a/net/ipv6/ioam6_iptunnel.c b/net/ipv6/ioam6_iptunnel.c
index cfb2c41634a0..946c360ff214 100644
--- a/net/ipv6/ioam6_iptunnel.c
+++ b/net/ipv6/ioam6_iptunnel.c
@@ -113,8 +113,8 @@ static int ioam6_build_state(struct net *net, struct nlattr *nla,
 	if (family != AF_INET6)
 		return -EINVAL;
 
-	err = nla_parse_nested(tb, IOAM6_IPTUNNEL_MAX, nla,
-			       ioam6_iptunnel_policy, extack);
+	err = lwtunnel_nla_parse(tb, IOAM6_IPTUNNEL_MAX, nla,
+				 ioam6_iptunnel_policy, extack);
 	if (err < 0)
 		return err;
 
diff --git a/net/ipv6/rpl_iptunnel.c b/net/ipv6/rpl_iptunnel.c
index 4e10adcd70e8..1861af408bbc 100644
--- a/net/ipv6/rpl_iptunnel.c
+++ b/net/ipv6/rpl_iptunnel.c
@@ -78,8 +78,8 @@ static int rpl_build_state(struct net *net, struct nlattr *nla,
 	if (family != AF_INET6)
 		return -EINVAL;
 
-	err = nla_parse_nested(tb, RPL_IPTUNNEL_MAX, nla,
-			       rpl_iptunnel_policy, extack);
+	err = lwtunnel_nla_parse(tb, RPL_IPTUNNEL_MAX, nla,
+				 rpl_iptunnel_policy, extack);
 	if (err < 0)
 		return err;
 

-- 
2.50.1

