Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.62.57.252
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793287597;
	b=ds8Vf8UGBhz/5wTFjpf9MfgrYbpef9wcwaPf3FQMi2rtjG0c2pBS3ydfS+JaRKDeEIYu
	 RtgJn3fM7LLqEFywJIsd/pF4BvmN8lveRlWNVRvY0RljGJHHZOSQIctAT/rfLtJNv3pXw
	 2Ixo2CW95ZNDj8/q4IdnebG8OkHfRv75CbC5Ml1LSz25pWKjQ8QFSFVSuiaUT62WB7pun
	 Eq0hnc0tyzF8T8+waAT1P8eiBeLZHyfudnLMLSI20drWihilErGO2MVt516qBQrpi1mWE
	 not1NFP/0S03rwhf63DRI5HGKOZUsWBlhDd4M6XGy0wifRAEPiBIb39EVVk1culDr+w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793287597;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=8EclGczKs6ymPsNv0lkpXydKevS30Xy2NVZZW8G/dtE=;
	b=AAj7u5uQ9SzREVl9PqDQeOg6fdUKnYu2s+NB+a0pgKeVrGl030ZOO9RqLjV8ZE2HYr16
	 YJxfdwW1VudDBdt2pmPeynd+700ZxJ5Cq+SZ/dFfHMEQnG0q+ol8mp5hwyQn3CJUdfWPs
	 JHdtD+nBshV9rBIw/LkA74sXersPOrkXzGqVNfhM8WkdQaNIznwP+AjdwT8g3KQhiUM4q
	 ZTzfT8DzP1CozyBDbLGrFbbt6hXqvQ15NRihBtfQ13SjrLCI2Y9Sklyi8KQOhfiXq1Laj
	 /6kP3049y8TIDzTcb56yPR2Vzn4WkIBcBZAuxnFctfQBIVANprMDfzsjn4w23k60idw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qq.com;
	spf=pass smtp.mailfrom=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=v3wdtyBS;
	arc=none smtp.remote-ip=162.62.57.252
Received: from out162-62-57-252.mail.qq.com (out162-62-57-252.mail.qq.com [162.62.57.252])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F435606A31F
	for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 15:26:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1F435606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=v3wdtyBS
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1793287590; bh=8EclGczKs6ymPsNv0lkpXydKevS30Xy2NVZZW8G/dtE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=v3wdtyBSMFN1ZE9qaF8xxyI4v9plv5MDJT4kegTlWgLu4Hp2Q6NyLT69sfLHl56li
	 VelwM+RosNJFlvxVpvQIxIRQlYN2LZP2mcoPNn0y1JDY2cUy1/btu9zQfK6DRnDfXS
	 0xADYdJLIVVxrSrmFc1ya2kiK4toeBIXcc9Yxujg=
Received: from kernel-lab.tail5e91bb.ts.net ([2409:8950:57d:63:5510:213f:594e:6216])
	by newxmesmtplogicsvrszb43-0.qq.com (NewEsmtp) with SMTP
	id 69B10AB5; Thu, 29 Oct 2026 23:26:27 +0800
X-QQ-mid: xmsmtpt1793287587t75nlgz3g
Message-ID: <tencent_C2E4FE9B7C0A05615861782611715EAA9C0A@qq.com>
X-QQ-XMAILINFO: Nte9/BsRzcszUN5uxJK1nMHBa0HlLiC2WrFDN+hdEoNFZ+qXlSNwZwxxIXOrDB
	 77j7dbOlPl8+HX22HPHsIx2dyUvYfQBHGH5FT2jL5DcLrY6DC2lq7xE/r1q58XeGutj25/k2VsjU
	 8Uzr/6uSoFelVtrsFVqY4gaVVtrypPSSTQbr7bxXkYtNW0GFrSvuU893brDPHbUy08LVwDG3jVTB
	 ASCBdu+FD+I9qnnc9+J4+0qRDx/LpOhyewFeGF6uxWSg1phOh6/G6KMFkNv7QgqO1a3jLNroWYe6
	 Kmr3BlLrCfnV2PDCmKv5p3kEd3VNxGwuZ0tCfaQsNLh/p3uQa8wqGBboPg9nHdTU44W8r6eX38aO
	 P/tmoseSb8IaFy7hCJKjAzfF6CRIfoyXEJ7XoywJUPYoqHRCXJzWht5MDt1wicv02ubwQ5YmHbfW
	 pcgdMLrtX0zV/Iq+a42M3eM2WVC5MT75r4h7yCiELNnc+Wo9mhT8wc9N7FgZ+jdZeqqju2/PYLpn
	 cJkCVAm+Q/GOSeh+MGsQOCYg6yLvXn1q0Fr5JxAgzxdoy+BMmEBYas0CLr1Jqrlz+ya8qsr84GDk
	 TScnbPPx39DOsQi3WAJHRN/FyN/Vhis49fmOW5qKehwcU03i62guwmWdB8LlmNkUud4S93l6Q0Nu
	 jo2isTldF9OssVHsHHiSv29xdZTeW/SjolNNAzzLZfaiB0vQK1XVTQB8CtinXIgG5ZPgWyTpWSTa
	 mWOJKn7piEqqv9JwN7LvkAlGf0IMB8r16KINg0xBYomMusV/UTVyrsPc1e4xRi2MbN/4AAuIbopT
	 YKZLjb9glLi17v4Gm0K7NvR9sGdDqjdYG/0rs7NSIsJxjzRovsaaEK2GWMibUdOWphNpuUZeWhO8
	 Cyx0xIO+sSXMNU8V5ZzX8akOqoe+heDVGCV+QS7s5p67MuJvV4lvDTIpw6LmA7lbuTyYIDYbOeQ7
	 hXOzuzRdBBs3SGcJCLDlE7QyZRm5vtiA8mB5O0xMhX703fntHi8+m1RBwTIBnACs6GQ7g8K9ei9M
	 nHGTk1nXrrlovwVfRHoMq600WSdD1rE1rksDKu251s3BUAN7x3sZq46CoKces8LlKG+itKdR4lki
	 TQTHR20sv39WWLNkE=
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
From: Yingjie Wang <1075151112@qq.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	dsahern@kernel.org,
	idosch@nvidia.com,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	rdunlap@infradead.org,
	linux-doc@vger.kernel.org,
	alexhenrie24@gmail.com
Subject: [PATCH net v2] ipv6: bound temporary address regeneration advance
Date: Thu, 29 Oct 2026 23:26:27 +0800
X-OQ-MSGID: <20261029152627.1726299-1-1075151112@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <tencent_F6E8C7CAC6D390C8E912EEE4FD9FE4333505@qq.com>
References: <tencent_F6E8C7CAC6D390C8E912EEE4FD9FE4333505@qq.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ipv6_get_regen_advance() combines regen_min_advance, regen_max_retry,
dad_transmits and the neighbor retransmission time. The first three are
signed sysctls, and the product is evaluated as int. Negative values or
signed overflow can make the unsigned long result much larger than
intended.

The retransmission time can also be supplied by an on-link Router
Advertisement. On an x86-64 HZ=1000 host with regen_min_advance=2,
regen_max_retry=3 and dad_transmits=1, an RA Retrans Timer of
1431654765 ms makes the old int product wrap to -3001. Division by HZ
and addition of regen_min_advance then produce -1, which is returned as
ULONG_MAX. This gives an on-link trigger on hosts that accept RAs and
use temporary addresses without requiring a sysctl write.

When ipv6_create_tempaddr() clamps the preferred lifetime, it adds age
and one to this advance and stores it in a u32. The sum can wrap or be
truncated to a short preferred lifetime. addrconf_verify_rtnl() then
finds the new address due for regeneration and restarts its scan after
creating another one. The temporary-address path has had no
max_addresses check since commit 4b08a8f1bd8c ("ipv6: remove
max_addresses check from ipv6_create_tempaddr"). In a baseline namespace
test, setting dad_transmits=-1 and adding a temporary-address template
with mngtmpaddr produced 2859 loopback addresses in two seconds.

Reject negative values for all three sysctls with -EINVAL. Writes that
used to succeed now fail validation; negative values have no useful
meaning (negative regen_max_retry already disables temporary addresses
on the first attempt). Keep zero valid. Use checked u64 arithmetic and
div_u64() to calculate the advance, including values supplied by an RA,
and cap it at U32_MAX. Compare the required preferred lifetime in u64
before narrowing it to u32. Calculate the desync margin without an
unsigned subtraction wrap on 32-bit builds. Clamp the effective maximum
to that non-negative margin so a negative max_desync_factor cannot make
the u32 comparison architecture-dependent.

Tested on x86-64 KASAN:
- negative writes to the three sysctls were rejected without changing
  their values, and zero remained valid;
- normal temporary-address setup and a case with writable
  max_desync_factor=-1 each produced three IPv6 addresses;
- with HZ=1000 and a one-second retransmission time,
  regen_min_advance=0, regen_max_retry=2147483647 and dad_transmits=1
  caused the baseline kernel to reach 2847 loopback addresses after
  two seconds; the fixed kernel left two.

Kernel selftests were not run.

An i386 defconfig with CONFIG_IPV6=y and HZ=1000 built addrconf.o with
W=1; nm -u showed no __udivdi3 reference.

Fixes: f4bcbf360ac8 ("net: ipv6/addrconf: clamp preferred_lft to the minimum required")
Signed-off-by: Yingjie Wang <1075151112@qq.com>
---
Changes in v2:
- Reorder the declarations for the netdev reverse-Christmas-tree convention.
- Use an intermediate variable to make the max_desync_factor calculation
  easier to read, as requested by Paolo Abeni.
- Clamp the effective max_desync_factor to a non-negative range so the u32
  comparison has the same result on 32-bit and 64-bit builds.
- Document the RA-supplied Retrans Timer trigger raised in review.

Link: https://patchwork.kernel.org/project/netdevbpf/patch/tencent_F6E8C7CAC6D390C8E912EEE4FD9FE4333505@qq.com/

 Documentation/networking/ip-sysctl.rst |  3 ++
 net/ipv6/addrconf.c                    | 53 ++++++++++++++++++--------
 2 files changed, 41 insertions(+), 15 deletions(-)

diff --git a/Documentation/networking/ip-sysctl.rst b/Documentation/networking/ip-sysctl.rst
index d3523c9064a22..817cba10e1787 100644
--- a/Documentation/networking/ip-sysctl.rst
+++ b/Documentation/networking/ip-sysctl.rst
@@ -2874,6 +2874,7 @@ dad_transmits - INTEGER
 	The amount of Duplicate Address Detection probes to send.
 
 	Default: 1
+	Minimum: 0
 
 forwarding - INTEGER
 	Configure interface-specific Host/Router behaviour.
@@ -3025,12 +3026,14 @@ regen_min_advance - INTEGER
 	does not conform to RFC 8981.
 
 	Default: 2
+	Minimum: 0
 
 regen_max_retry - INTEGER
 	Number of attempts before give up attempting to generate
 	valid temporary addresses.
 
 	Default: 5
+	Minimum: 0
 
 max_addresses - INTEGER
 	Maximum number of autoconfigured addresses per interface.  Setting
diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index c8c0dd04982d9..ff2a29c94bdfe 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -60,7 +60,9 @@
 #endif
 #include <linux/capability.h>
 #include <linux/delay.h>
+#include <linux/math64.h>
 #include <linux/notifier.h>
+#include <linux/overflow.h>
 #include <linux/string.h>
 #include <linux/hash.h>
 
@@ -1376,10 +1378,19 @@ static void ipv6_del_addr(struct inet6_ifaddr *ifp)
 
 static unsigned long ipv6_get_regen_advance(const struct inet6_dev *idev)
 {
-	return READ_ONCE(idev->cnf.regen_min_advance) +
-		READ_ONCE(idev->cnf.regen_max_retry) *
-		READ_ONCE(idev->cnf.dad_transmits) *
-		max(NEIGH_VAR(idev->nd_parms, RETRANS_TIME), HZ/100) / HZ;
+	unsigned int retrans_time = max(NEIGH_VAR(idev->nd_parms,
+						 RETRANS_TIME), HZ / 100);
+	u32 min_advance = READ_ONCE(idev->cnf.regen_min_advance);
+	u32 retries = READ_ONCE(idev->cnf.regen_max_retry);
+	u32 dad = READ_ONCE(idev->cnf.dad_transmits);
+	u64 duration;
+
+	/* Preferred lifetimes are u32, so a larger advance cannot be used. */
+	if (check_mul_overflow((u64)retries * dad, (u64)retrans_time,
+			       &duration))
+		return U32_MAX;
+
+	return min_t(u64, (u64)min_advance + div_u64(duration, HZ), U32_MAX);
 }
 
 static int ipv6_create_tempaddr(struct inet6_ifaddr *ifp, bool block)
@@ -1391,8 +1402,10 @@ static int ipv6_create_tempaddr(struct inet6_ifaddr *ifp, bool block)
 	u32 if_public_preferred_lft;
 	s32 cnf_temp_preferred_lft;
 	struct inet6_ifaddr *ift;
+	u32 desync_factor_limit;
 	struct ifa6_config cfg;
 	long max_desync_factor;
+	u64 min_preferred_lft;
 	struct in6_addr addr;
 	int ret = 0;
 
@@ -1430,9 +1443,15 @@ static int ipv6_create_tempaddr(struct inet6_ifaddr *ifp, bool block)
 	 * idev->desync_factor if it's larger
 	 */
 	cnf_temp_preferred_lft = READ_ONCE(idev->cnf.temp_prefered_lft);
-	max_desync_factor = min_t(long,
-				  READ_ONCE(idev->cnf.max_desync_factor),
-				  cnf_temp_preferred_lft - regen_advance);
+	desync_factor_limit = max_t(s32, cnf_temp_preferred_lft, 0);
+	if (regen_advance >= desync_factor_limit)
+		desync_factor_limit = 0;
+	else
+		desync_factor_limit -= regen_advance;
+
+	max_desync_factor = clamp_t(long,
+				    READ_ONCE(idev->cnf.max_desync_factor),
+				    0, desync_factor_limit);
 
 	if (unlikely(idev->desync_factor > max_desync_factor)) {
 		if (max_desync_factor > 0) {
@@ -1485,15 +1504,16 @@ static int ipv6_create_tempaddr(struct inet6_ifaddr *ifp, bool block)
 	 * temporary addresses being generated.
 	 */
 	age = (now - tmp_tstamp + ADDRCONF_TIMER_FUZZ_MINUS) / HZ;
-	if (cfg.preferred_lft <= regen_advance + age) {
-		cfg.preferred_lft = regen_advance + age + 1;
-		if (cfg.preferred_lft > cfg.valid_lft ||
-		    cfg.preferred_lft > if_public_preferred_lft) {
+	min_preferred_lft = (u64)regen_advance + age + 1;
+	if (cfg.preferred_lft < min_preferred_lft) {
+		if (min_preferred_lft > cfg.valid_lft ||
+		    min_preferred_lft > if_public_preferred_lft) {
 			in6_ifa_put(ifp);
 			in6_dev_put(idev);
 			ret = -1;
 			goto out;
 		}
+		cfg.preferred_lft = min_preferred_lft;
 	}
 
 	cfg.ifa_flags = IFA_F_TEMPORARY;
@@ -4705,7 +4725,7 @@ static void addrconf_verify_rtnl(struct net *net)
 
 				unsigned long regen_advance = ipv6_get_regen_advance(ifp->idev);
 
-				if (age + regen_advance >= ifp->prefered_lft) {
+				if ((u64)age + regen_advance >= ifp->prefered_lft) {
 					struct inet6_ifaddr *ifpub = ifp->ifpub;
 					if (time_before(ifp->tstamp + ifp->prefered_lft * HZ, next))
 						next = ifp->tstamp + ifp->prefered_lft * HZ;
@@ -6921,7 +6941,8 @@ static const struct ctl_table addrconf_sysctl[] = {
 		.data		= &ipv6_devconf.dad_transmits,
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
+		.proc_handler	= proc_dointvec_minmax,
+		.extra1		= SYSCTL_ZERO,
 	},
 	{
 		.procname	= "router_solicitations",
@@ -7001,14 +7022,16 @@ static const struct ctl_table addrconf_sysctl[] = {
 		.data           = &ipv6_devconf.regen_min_advance,
 		.maxlen         = sizeof(int),
 		.mode           = 0644,
-		.proc_handler   = proc_dointvec,
+		.proc_handler   = proc_dointvec_minmax,
+		.extra1         = SYSCTL_ZERO,
 	},
 	{
 		.procname	= "regen_max_retry",
 		.data		= &ipv6_devconf.regen_max_retry,
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
+		.proc_handler	= proc_dointvec_minmax,
+		.extra1		= SYSCTL_ZERO,
 	},
 	{
 		.procname	= "max_desync_factor",

base-commit: d7314b51341c037973ce022f12c6009fd07b021e
-- 
2.43.0

