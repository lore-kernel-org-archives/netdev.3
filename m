Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A84BC3F4DF3;
	Thu, 10 Sep 2026 09:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789033675; cv=none; b=l64CC4fpsWKw35ZzeB+lW3OqA+JbhAoQ6m9icCN2Z3UkY6/AJDE5GI5AgrE+FGrxwyNFeyGeiDFdI5FBEJ8WuLNMciz9Qcnu5/k4H8EMoe4aeg8TA1rHTLC/FrrIRcDHaHspiEAqxVJDAK7bAyXjoqyW6sG6dyW2ep/5r1J3BCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789033675; c=relaxed/simple;
	bh=sm+OA/D7zuZPSAUn11AYbOLKZZL1lSdRLym2xOya4U0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pexBGkTnNQMlQipsZKvZ8li9p93aSnJkFkby4KupolaQNLOYdpUmBnSDlzUnwi2e06/TkuH0/9CRg671fI+PCXT9uAoeq45L4aF8rpD8j7s6QtTUX/4hPk5cKAoK2i/RxhoiAP8Yke9CWljX2zanym9CzXY6aPx9a4cL6pvGpo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=RkpBnYV5; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="RkpBnYV5"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=h5Me5hoKb0ftKqrR7fgJT1u7D3+bvrtf8XI9UCkIHHw=; b=RkpBnYV549OksgaCh2QiYwL2yH
	jv1MmyoJSmR5D928jMG/iDOdMKM7CMLeNSwuE5wHjXbiWmyQbxMiE9+Joq2lUpBnZNuffUTlqrnqy
	u8iumIS3gcICtxJoqgB7gpIMkoqQhpTirJG3wbtEvbcuCJApDwBfoQw2fRM5h5QcGQ2srVEv61tJO
	7ag5wSiPUf+w4iG9r1ehNiPcRovIGm8w5rzmRjLgmKXGHhvPU/piO9rtwwLWApXSOQJ7OVWnwB1+0
	Yimjn4LDOc/W3zDELEypXMyElA8/x9Ix//wRY/mZ9O1EpJtYrQU6MWzPRZVb/2AlHWkiyv3yTXppc
	u1oygAZw==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1x4bNU-000QN0-2n;
	Thu, 10 Sep 2026 09:47:33 +0000
From: Breno Leitao <leitao@debian.org>
Date: Thu, 10 Sep 2026 02:47:12 -0700
Subject: [PATCH net-next 2/2] ipv4: igmp: convert ip_mc_msfget() to
 sockopt_t
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260910-getsockopt_phase6-v1-2-e681e102d5b8@debian.org>
References: <20260910-getsockopt_phase6-v1-0-e681e102d5b8@debian.org>
In-Reply-To: <20260910-getsockopt_phase6-v1-0-e681e102d5b8@debian.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4282; i=leitao@debian.org;
 h=from:subject:message-id; bh=sm+OA/D7zuZPSAUn11AYbOLKZZL1lSdRLym2xOya4U0=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqonymT1hs6CqFV/jwDsPSBIKsRaqNfpfFXj2Yy
 PbfT4tZSVOJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaqJ8pgAKCRA1o5Of/Hh3
 bThBEACwoKmhuMrocLOS4T/Jo79tcOPSRQNCjjITvxKeLRKIzxE6Jm2tGZTQ0N0XdjClCDuZb68
 kFiUoYgXwKU4qVl8yaIq6c4enqGyMtbrhwAcWGEWZATBoFm0FC47pJCJWjXy0nyHPWI3G4dSmWm
 IojYCeAvtxJsUh+1TmsCg2t+EHPNMFGv+BT+NFqtKzdcnm+DeNkJAchHHPKWhgfyVa79cRTd2Vy
 +9BnTkHikw6ZHaGhJIZEpUFq/dCForWu5nPScX8XxV/AJIlyZc+jtKjtsMndXev5P0hG+dCq3xT
 70NGiypScKp42UI0bS3I7PBGJLHvTce8J83QCntGGGVuX1+B2R/oy/yhOfAx2A53ZyX0ON9Wvcv
 vOAmIUnRB/r2Z0lkNUmIySb3jYE/qfw+DyTBoZDAXGnVWEmfPercL3lvMqivX7pWvPyCI7+YIhb
 2fzhas+b3AorVA5oPkX4peRCAtd9aIWqvi9S5UnmHgN95Z7445w17K8FtoPJYNsRezpZs3BzuKS
 bJseHSMotzZdlkmzsiY6mWD3SYZ1cXSz7BHyntnJrJIA8QcqG8zK0jpGnoca2OIUaKnTOJ6r1WK
 SMK48ZC4ZbkK0ESTXj1c7DAZ3ghuxUhHX1ve92uUYUXfv+XVfTKYxDTfZ5WqSwmaMxHBUYkCRdN
 j98NE9tpB67JbOw==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao

IP_MSFILTER reads its reply through ip_mc_msfget(), reached from
do_ip_getsockopt() and from nowhere else. Convert it, and build the
sockopt_t at the call site for as long as the caller still carries a
sockptr_t pair.

This is a special case, where optlen might only point
to the header, and the real structure size is inside the header.

This is nasty, but, in order to avoid breaking userspace, we need to
preserve the same mechanism, by:

1) Only applying it for userspace address, otherwise it is too risky
2) Assume there is room to support the new size (in userspace)

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
index a55ef327ec932c..c58e565f2a5aa7 100644
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
+		if (copy_to_sockptr(optlen, &opt.optlen, sizeof(int)))
+			err = -EFAULT;
 		goto out;
 	}
 	case MCAST_MSFILTER:

-- 
2.53.0-Meta

