Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0EEA3F5BFC;
	Mon, 14 Sep 2026 12:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789388426; cv=none; b=MBVvsbQdzvUMWGRx5aqen+Zo0+1zWEqgC8v4xeVEXL+1FLujpTHHbPf9wm3cVvAOuzH8zWlXgNvAVO19ze5AzAp7mQI6sBmyZR/v1JbRJbHtY5Wd0xD4xWKhITMbnJ/MwVTBhGHKM8uaPbeqtp6R/GEX/2Q8EgNJAUciYVJN3vE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789388426; c=relaxed/simple;
	bh=3ufswQVQR+63tDafLALw2FZWz+l+9LWhRH3gAEgpyuA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=T2ij5QxCT5HII0YKdxOvxcv9ynIlkBZ7p/5XlMPmP+r5pC+zLnwTZegY4xl6nFJYwMvf5L9IeXF3gWJlW8hdUALbh8w55e7ml5TRwhSFbwP9W1p0vJ7Cexp56Bm/EW1S4SRkkIdJESQzufbtda9uRcrMlhGBYTMl0eypPCb8Yl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=ERQBdk85; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="ERQBdk85"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=oJhhgKFVY6AJH/Glck9e3yrRte0HMPO9hUkqs1342oo=; b=ERQBdk85LcpVncNxbv6PC2DH5b
	g7JOLioYOBl3zjB+/EytOuEH8yCKHhfT2S0Ly4BvotRtwveXP0Q4qO6YRUb6Zjr1aftZttiGJh+oV
	HvNo7ZyO+IySyQPxjnVjWEFJLlqGc8/zv7sOv488EU/qtihDtoR/jFind7kLxH/TCMssrBFI7jRid
	KxYdA/UXHfq1LVQd8ytkgN3euVKpOolY2MfHA1YW+MhY6Z0AhLZT887eOCo18+FxIHPlU9KAHWSPy
	GdAD9ttvneqqfuCl4OADjFZZCwv5WjvXnFNrgy8L1uXmkA5f2TN+3jDtyV095u+bO4i6g9cf1Vf8g
	Qm9MLVXg==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1x65fa-003bts-2u;
	Mon, 14 Sep 2026 12:20:23 +0000
From: Breno Leitao <leitao@debian.org>
Date: Mon, 14 Sep 2026 05:20:08 -0700
Subject: [PATCH net-next v2 2/2] ipv4: igmp: convert ip_mc_msfget() to
 sockopt_t
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260914-getsockopt_phase6-v2-2-e48befc9602e@debian.org>
References: <20260914-getsockopt_phase6-v2-0-e48befc9602e@debian.org>
In-Reply-To: <20260914-getsockopt_phase6-v2-0-e48befc9602e@debian.org>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Kuniyuki Iwashima <kuniyu@google.com>, 
 Willem de Bruijn <willemb@google.com>, David Ahern <dsahern@kernel.org>, 
 Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 david.laight.linux@gmail.com, Breno Leitao <leitao@debian.org>, 
 kernel-team@meta.com
X-Mailer: b4 0.16-dev-f8e9d
X-Developer-Signature: v=1; a=openpgp-sha256; l=4442; i=leitao@debian.org;
 h=from:subject:message-id; bh=3ufswQVQR+63tDafLALw2FZWz+l+9LWhRH3gAEgpyuA=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqp+Z4fN1hIVs3P1mWxp5y3Rp/5cCNul/rS+pw3
 TqxdAOVr6qJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaqfmeAAKCRA1o5Of/Hh3
 bQFvD/9QB0f44UDN4AOTC3soXNd/DyIS/8ZeK8k27GrnVW9OCbnwPFYYE6Mlz75jQ9KTyJMEAXf
 9cg6d9RuRFERUSTtpzsG9PWEZpCw6SvBXlYR1+MGubAcH236T4ZS5uDNX8xBANLhU0hwfrkdQfZ
 /0TZE5C3qWHNebs0paoA/+KTTSVVaG5Cg3D7wpWNHyzdjCs9+FznNZwuZY65QciyzXPicJ1aKqN
 zH78lV5QgWBf+AwzeUClew/PDQy958gpnvi5+ml4jEsjrpuaR8dFdRjuA6aArh6B1zmBQFuMuUB
 RiYOUaIGbrD4msjDh8ZTUQ8UXzmiT9ia8DpAPwwlAXwmH1+OzNqhYb+REvAwsHmR0tqp2Cauiz8
 f+NHlk6Rqm/VFilgpkhkP5BMPtETLBqhhLCJxt2v+T1ArDjJkCNNA0wnlSn4Go0H2TMzCF0ZE40
 7hKf3loq/OXLlM/h4NvkcmRaVjmORqL22+MlJTGGRg3v+ra18AUHK4UYUYMjSZh5P7EUo/1P4xT
 NvnFj+JZaIXq1pznyts4TVMgG7ei2lO0G5qldaTkk0jzlad0RIgkiYaL8rLdI/Zu8B6MfCt9vOK
 C5d3kdMxKoJpOgYEROsJitDb4hnadXlqm3y+W7Y+7IDu+iHRYxqcgDvwKstj7+RTbO4K/r9es01
 BlhKMhhR7CKGk9Q==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao

IP_MSFILTER reads its reply through ip_mc_msfget(), reached from
do_ip_getsockopt() and from nowhere else. Convert it, and build the
sockopt_t at the call site for as long as the caller still carries a
sockptr_t pair.

optlen here only has to cover the header, and the real reply size comes
from the imsf_numsrc field inside it. This is nasty, but userspace
relies on it, so sockopt_expand_out() preserves the same mechanism: it
grows optval only for a user address, and assumes the caller left room
for the size its own header asked for.

The *optlen store moves out of ip_mc_msfget() and into the call site,
guarded by !err so the -EINVAL, -ENODEV and -EADDRNOTAVAIL returns still
leave the caller's optlen word untouched.

The source list also moves from copy_to_sockptr_offset() to a sequential
copy_to_iter(). IP_MSFILTER_SIZE(0) and offsetof(struct ip_msfilter,
imsf_slist_flex) are both 16, so the bytes land where they did.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 include/linux/igmp.h   |  3 ++-
 net/ipv4/igmp.c        | 23 ++++++++++++++---------
 net/ipv4/ip_sockglue.c | 10 +++++++++-
 3 files changed, 25 insertions(+), 11 deletions(-)

diff --git a/include/linux/igmp.h b/include/linux/igmp.h
index a0cf0398519fd7..e075611344ef3b 100644
--- a/include/linux/igmp.h
+++ b/include/linux/igmp.h
@@ -14,6 +14,7 @@
 #include <linux/timer.h>
 #include <linux/in.h>
 #include <linux/ip.h>
+#include <linux/net.h>
 #include <linux/refcount.h>
 #include <linux/sockptr.h>
 #include <uapi/linux/igmp.h>
@@ -273,7 +274,7 @@ extern int ip_mc_source(int add, int omode, struct sock *sk,
 		struct ip_mreq_source *mreqs, int ifindex);
 extern int ip_mc_msfilter(struct sock *sk, struct ip_msfilter *msf,int ifindex);
 extern int ip_mc_msfget(struct sock *sk, struct ip_msfilter *msf,
-			sockptr_t optval, sockptr_t optlen);
+			sockopt_t *opt);
 extern int ip_mc_gsfget(struct sock *sk, struct group_filter *gsf,
 			sockptr_t optval, size_t offset);
 extern int ip_mc_sf_allow(const struct sock *sk, __be32 local, __be32 rmt,
diff --git a/net/ipv4/igmp.c b/net/ipv4/igmp.c
index d56355aca79776..144fca158adcb0 100644
--- a/net/ipv4/igmp.c
+++ b/net/ipv4/igmp.c
@@ -2709,8 +2709,8 @@ int ip_mc_msfilter(struct sock *sk, struct ip_msfilter *msf, int ifindex)
 		err = ip_mc_leave_group(sk, &imr);
 	return err;
 }
-int ip_mc_msfget(struct sock *sk, struct ip_msfilter *msf,
-		 sockptr_t optval, sockptr_t optlen)
+
+int ip_mc_msfget(struct sock *sk, struct ip_msfilter *msf, sockopt_t *opt)
 {
 	int err, len, count, copycount, msf_size;
 	struct ip_mreqn	imr;
@@ -2755,14 +2755,19 @@ int ip_mc_msfget(struct sock *sk, struct ip_msfilter *msf,
 	len = flex_array_size(psl, sl_addr, copycount);
 	msf->imsf_numsrc = count;
 	msf_size = IP_MSFILTER_SIZE(copycount);
-	if (copy_to_sockptr(optlen, &msf_size, sizeof(int)) ||
-	    copy_to_sockptr(optval, msf, IP_MSFILTER_SIZE(0))) {
+
+	/* The source list is sized by the imsf_numsrc the caller left in
+	 * optval, not by optlen, which only has to cover the fixed part.
+	 */
+	err = sockopt_expand_out(opt, msf_size);
+	if (err)
+		return err;
+
+	opt->optlen = msf_size;
+	if (copy_to_iter(msf, IP_MSFILTER_SIZE(0), &opt->iter_out) !=
+	    IP_MSFILTER_SIZE(0))
 		return -EFAULT;
-	}
-	if (len &&
-	    copy_to_sockptr_offset(optval,
-				   offsetof(struct ip_msfilter, imsf_slist_flex),
-				   psl->sl_addr, len))
+	if (len && copy_to_iter(psl->sl_addr, len, &opt->iter_out) != len)
 		return -EFAULT;
 	return 0;
 done:
diff --git a/net/ipv4/ip_sockglue.c b/net/ipv4/ip_sockglue.c
index a55ef327ec932c..e06c1f48ecad6e 100644
--- a/net/ipv4/ip_sockglue.c
+++ b/net/ipv4/ip_sockglue.c
@@ -1706,6 +1706,8 @@ int do_ip_getsockopt(struct sock *sk, int level, int optname,
 	case IP_MSFILTER:
 	{
 		struct ip_msfilter msf;
+		struct kvec kvec;
+		sockopt_t opt;
 
 		if (len < IP_MSFILTER_SIZE(0)) {
 			err = -EINVAL;
@@ -1715,7 +1717,13 @@ int do_ip_getsockopt(struct sock *sk, int level, int optname,
 			err = -EFAULT;
 			goto out;
 		}
-		err = ip_mc_msfget(sk, &msf, optval, optlen);
+		err = sockptr_to_sockopt(&opt, optval, optlen, &kvec);
+		if (err)
+			goto out;
+
+		err = ip_mc_msfget(sk, &msf, &opt);
+		if (!err && copy_to_sockptr(optlen, &opt.optlen, sizeof(int)))
+			err = -EFAULT;
 		goto out;
 	}
 	case MCAST_MSFILTER:

-- 
2.53.0-Meta

