Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5D054398F5;
	Fri, 24 Jul 2026 15:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784905524; cv=none; b=X55Y4xCl+DutxOm5qbKCqORAjLLDG6L+LJ0h900DYWzptrTti5xeOS+/wT08oq5ReC9T34aQBgoocmI2JsT+E+YTLNBeuZTwalsq6+QvtUqvxL4TOJXaqqDwXl2/HUMzu3gGSTcyTFdPtqXWzzCqTU98TeiR2jUYsTzIp07TTas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784905524; c=relaxed/simple;
	bh=RTJhgo0qKIxVbwnT35A+DaYO9R4Kmowt9+umEDkfiIE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nDTic+QVQvsawlsHELEC4Vo/IurVxyRgSboNz+IpZWZhDfHNgFZMiQ1Iledbcd9ZMVymqYSIFIjqynPs9r4zxpslKmIScddAKgYFQD9gv/wKNfT4lfGXYrr2MmSSYy6Hsxe/qrnFB/O7AFz+wz+VFao1tzS/7hn15DSHhapqU9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=vrCNJn4t; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="vrCNJn4t"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=qFyYCGTdJ0C9A3OHrXAscHjlRAsB5lrGRwNkRohgOw8=; b=vrCNJn4tND0ehRHVnSlr4PNmhd
	dr7BYOHI3VgkF+3SW/C74ULpNI4xF02hzquFj1qwinQr4PUEq4s4WiHw9+kHJhyR7tbx+sCw7o7k/
	eJudoT7BlcNlyuXji10MR2tjDmLGk3VhRwpH62E9vI1UMXyp104MCsjPOjRw0E4M+dCaSeN2EeeMS
	JfuhxMDs1laqZaGv9roX66gmn83G/nas9rMUiIMUTIjSAbki5dTMGCF9ywCOSJuweopCBsiyAubWR
	5VUyG0gDOyA5hSsf8u9MF0SFkU/o/ExY0KLJIehe7CKr7cAIBasZsoFgSThmt1C+10kKPt1ARKpp+
	4/8NFqFw==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wnHSc-004dtF-2g;
	Fri, 24 Jul 2026 15:05:15 +0000
From: Breno Leitao <leitao@debian.org>
Date: Fri, 24 Jul 2026 08:04:10 -0700
Subject: [PATCH net-next 2/9] netpoll: export the netpoll_setup() helpers
 for netconsole
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260724-netconsole_move_more_final-v1-2-a5f7691db81c@debian.org>
References: <20260724-netconsole_move_more_final-v1-0-a5f7691db81c@debian.org>
In-Reply-To: <20260724-netconsole_move_more_final-v1-0-a5f7691db81c@debian.org>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 gustavold@gmail.com, asantostc@gmail.com, Breno Leitao <leitao@debian.org>, 
 kernel-team@meta.com
X-Mailer: b4 0.16-dev-d5d98
X-Developer-Signature: v=1; a=openpgp-sha256; l=4049; i=leitao@debian.org;
 h=from:subject:message-id; bh=RTJhgo0qKIxVbwnT35A+DaYO9R4Kmowt9+umEDkfiIE=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqY38dcC1Sx4Sq+MqmfDOe5hJOGjKvpjvpRjhpv
 w5ylkMwqsaJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCamN/HQAKCRA1o5Of/Hh3
 beTuD/9nhNUpIOemr5M+U4Yn93Psy8C14chOxKQ7x+Mzys6gtKGaqgW9Pg6oIDRKQ+gSC0Oqlwx
 BSrSzpk97nbMFdgO6veKeARTpXT7i5SrJ/5qe759s1HCTdHidmnsG5bfPXo6CKJmG7yXfqtL9Qv
 422gmgiD6hvsfSJ7NdSQxfKgwdNgMjOGKEyLk4dK3uzxLpQzFZ37tzvGD47FjP+gGtDuANEuLsb
 XFn9YesJnVvkmsTWnrRW50BpxMFeq6QIuZyjsdV/dOQP3w2EXi81M0edvvb4Gd6W7Ny1vDE34vz
 aad16Gz1f/s79ZU3HLWeI5kDAx7k5Vl2m/WGhObqkeOmeGBcQLYwt3egJ9VyteGj2UwMO0wN/Dj
 bgpmvwxCgrVkd5q2LiXf2lfz0Z7tfU7DDSOs/fncoDzxT1opPEFqrImFlsUlv+JxCzxlD6/fn4X
 QN3hLXXw/bFhS/zn1OFukW3ANdmVvwnfVXdRXv03judO30wlMu4v0GqS8u4VofZZzcs93SLoxfb
 F2z7TfTdYVHE0CW6xZuvd6hvRK6N5gTo+KcEj0S38ubGLPsoNaMdXJ/j0hsNauT1ktRSXvUaFN+
 1O14640LhYqUlsKINaGrWQ8bbxzT2iL6Lrvh2qniNcao+rxC6K4Kf0AmItUfm6BwcfQIvMq4dzx
 0qbqoWsaYVolchA==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao

Temporarily export leaf functions that will be moved to netconsole.

The upcoming patch will move the setup function to netconsole, and
continue to call these leaf functions here in netpoll, then other
patches will move these exports functions to netconsole (and make them
statics).

In summary, these exports are temporary in order to make the patchset
digestible.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 include/linux/netpoll.h |  5 +++++
 net/core/netpoll.c      | 15 ++++++++++-----
 2 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/include/linux/netpoll.h b/include/linux/netpoll.h
index d426d1844cac7..0877515fa7442 100644
--- a/include/linux/netpoll.h
+++ b/include/linux/netpoll.h
@@ -73,6 +73,11 @@ void do_netpoll_cleanup(struct netpoll *np);
 netdev_tx_t netpoll_send_skb(struct netpoll *np, struct sk_buff *skb);
 void netpoll_zap_completion_queue(void);
 unsigned int netpoll_get_carrier_timeout(void);
+void netpoll_wait_carrier(struct netpoll *np, struct net_device *ndev);
+char *egress_dev(struct netpoll *np, char *buf, size_t bufsz);
+int netpoll_take_ipv4(struct netpoll *np, struct net_device *ndev);
+int netpoll_take_ipv6(struct netpoll *np, struct net_device *ndev);
+bool netpoll_local_ip_unset(const struct netpoll *np);
 
 #ifdef CONFIG_NETPOLL
 static inline void *netpoll_poll_lock(struct napi_struct *napi)
diff --git a/net/core/netpoll.c b/net/core/netpoll.c
index 9b9fcc307958f..6a545063223ba 100644
--- a/net/core/netpoll.c
+++ b/net/core/netpoll.c
@@ -399,7 +399,7 @@ EXPORT_SYMBOL_GPL(__netpoll_setup);
  * be at least MAC_ADDR_STR_LEN + 1 to fit the formatted MAC address
  * and its NUL terminator.
  */
-static char *egress_dev(struct netpoll *np, char *buf, size_t bufsz)
+char *egress_dev(struct netpoll *np, char *buf, size_t bufsz)
 {
 	if (np->dev_name[0])
 		return np->dev_name;
@@ -407,8 +407,9 @@ static char *egress_dev(struct netpoll *np, char *buf, size_t bufsz)
 	snprintf(buf, bufsz, "%pM", np->dev_mac);
 	return buf;
 }
+EXPORT_SYMBOL_GPL(egress_dev);
 
-static void netpoll_wait_carrier(struct netpoll *np, struct net_device *ndev)
+void netpoll_wait_carrier(struct netpoll *np, struct net_device *ndev)
 {
 	unsigned long atmost;
 
@@ -421,11 +422,12 @@ static void netpoll_wait_carrier(struct netpoll *np, struct net_device *ndev)
 		msleep(1);
 	}
 }
+EXPORT_SYMBOL_GPL(netpoll_wait_carrier);
 
 /*
  * Take the IPv6 from ndev and populate local_ip structure in netpoll
  */
-static int netpoll_take_ipv6(struct netpoll *np, struct net_device *ndev)
+int netpoll_take_ipv6(struct netpoll *np, struct net_device *ndev)
 {
 	char buf[MAC_ADDR_STR_LEN + 1];
 	int err = -EDESTADDRREQ;
@@ -462,11 +464,12 @@ static int netpoll_take_ipv6(struct netpoll *np, struct net_device *ndev)
 	np_info(np, "local IPv6 %pI6c\n", &np->local_ip.in6);
 	return 0;
 }
+EXPORT_SYMBOL_GPL(netpoll_take_ipv6);
 
 /*
  * Take the IPv4 from ndev and populate local_ip structure in netpoll
  */
-static int netpoll_take_ipv4(struct netpoll *np, struct net_device *ndev)
+int netpoll_take_ipv4(struct netpoll *np, struct net_device *ndev)
 {
 	char buf[MAC_ADDR_STR_LEN + 1];
 	const struct in_ifaddr *ifa;
@@ -491,6 +494,7 @@ static int netpoll_take_ipv4(struct netpoll *np, struct net_device *ndev)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(netpoll_take_ipv4);
 
 /*
  * Test whether the caller left np->local_ip unset, so that
@@ -502,12 +506,13 @@ static int netpoll_take_ipv4(struct netpoll *np, struct net_device *ndev)
  * doing so would misclassify a caller-supplied address as unset and
  * silently overwrite it with whatever address the device exposes.
  */
-static bool netpoll_local_ip_unset(const struct netpoll *np)
+bool netpoll_local_ip_unset(const struct netpoll *np)
 {
 	if (np->ipv6)
 		return ipv6_addr_any(&np->local_ip.in6);
 	return !np->local_ip.ip;
 }
+EXPORT_SYMBOL_GPL(netpoll_local_ip_unset);
 
 int netpoll_setup(struct netpoll *np)
 {

-- 
2.53.0-Meta

