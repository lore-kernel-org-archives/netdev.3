Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.62.57.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793002976;
	b=zSgIt/vSIxRPzrXHsXtFZ0CsgWogFSeVsn/qOxbfupnaiF6mEj+zKDwJHIBwrtPLch/S
	 kVfKTtLLEHalxK/kV1y6pkfiAXAAwzMTbJ155TAXjsBI6zoCuriD/B4mg/jvXAJxe9O5T
	 0jjQXhZcXNJGhitJYW9XJJr2CAYQFWdANGdsQSo1JbQkjKRHDT5q2W14gAib1AAokEDpz
	 NjCrIEdesSInc9ksxnIrr5xLrxLI9uPl+VUK3qAKOhBmCKr4hnWBvyLbPM6QJwr/R1Phw
	 J8oaWn+JOp6itKLTkNdYdXKj6zT8a+ces74GmfXqOuDBKGdXYVOn5ro9XnyAznu3XYQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793002976;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=+WnPlSodIin5wFzancUMh58wfHgI/PO41J4tv6r/S7Q=;
	b=OE7jbWaNfi0jJgypLpyLB3ETDR1efLCENBXd8AZXpgCfjqiQALTPJSlxjLhP1dkfvhBm
	 3FsAjxukJZ9e0aYIGwXdIxlzNW71pQ18yThE55aoAFWljLCSmWgzYrkYRJvKe5s6x6+UN
	 I72Jg2/WFGQjsbWpWntdh/Fzxcfha1lnJt5Top8j/yeTAqwc5dWKUgEzQ8c5sqLNXunQi
	 Hpr1l5QExlKLvc8z+P0q0Sbd6V4S59LzfpVDNqG3uyjfSgDrss3Exzw5JW99N1NTS2a4J
	 7lLtODIENdu9xbia2cmySun63kyyJkuWitu2fcARxcuX9PiAqQ+jBlJBnawb/rAlXWA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qq.com;
	spf=pass smtp.mailfrom=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=fHZ75MXt;
	arc=none smtp.remote-ip=162.62.57.49
Received: from out162-62-57-49.mail.qq.com (out162-62-57-49.mail.qq.com [162.62.57.49])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B267F606A31D
	for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 08:22:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B267F606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=fHZ75MXt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1793002970; bh=+WnPlSodIin5wFzancUMh58wfHgI/PO41J4tv6r/S7Q=;
	h=From:To:Cc:Subject:Date;
	b=fHZ75MXtqIcDWnPq69NUcgrhblGEVkotIczpht1uvN4IYkydg0/XpSxCWBNhFtUx4
	 neKkMIB0QNWsXcThKKhQDZahR6g0FDSBoV6wLjUgMrnAkCp3raIWln+nbnc14XQ2cd
	 EmwxIf5CPSIWX8Z8GVXOzgieYkl6gLZ2MjpBanC8=
Received: from kernel-lab.tail5e91bb.ts.net ([39.144.194.158])
	by newxmesmtplogicsvrszb51-0.qq.com (NewEsmtp) with SMTP
	id 5AF074D1; Mon, 26 Oct 2026 16:22:47 +0800
X-QQ-mid: xmsmtpt1793002967tnik34gyr
Message-ID: <tencent_F6E8C7CAC6D390C8E912EEE4FD9FE4333505@qq.com>
X-QQ-XMAILINFO: MOnz+xTS1+9ikKlV4etVMZbykzL6Vcc+7vdYny1BIZ4V5/Tr5YOtHFbtVvdJVm
	 S8zhBOnHsok0i2eop0txx8nVDT1qvGMyAl3n5vzSG4w+Tp3tXxE7NCF19oFZckIqQaMfc+E0d76O
	 p8Zw0qDSUoOFR9hTZGIPNXRIgKd7RwOrTHmq6V69whkyXEPgutLM/iEq3ovDp4UhiGkNvInEWsij
	 siTV3Y/h3hBZq4mcMwMy6Pjwznk4AAxpNx+jzL/cMOYPvw3HcOslKP1OqQBDRtZ1plP2dXTD+z61
	 +P82PSbQ52aLlzaRlP/2Yw55lChNcXZIsD9KLqcDBSO3gbot9H4sILVyY0pnWqGvHW67r3Amxt5/
	 4Kk66gjkrN9uQmsC1SS1FtHtTee7tdAW1naaDZ/81fYVRSRO3RelA1JDfcjpsVfAFIXFwpog0qyv
	 UCMEH5xhCuqaNNz0ndLnZ9xmDYKW6DASGf0uJ+ESxebiCZ07KUeuFrwmrPxb+XpW4xGEtaqDAOXw
	 6dNetbkBNwM6mwIjS+bXbleSFTBjoTNYURohe22VBSqgM5nTi61bdL6vrreTVzmou+v/Az4mY9wY
	 rdezOUcmU/QfvQRF/w2QwYK/rATDA/xW2sAxOBPX8Qtx1ijL1+YTaGxK0wgQbDPcDqfeHk1rg+fv
	 GZKVVolWQW0uNoBWqBRPtjEtmQoMhZNUgjFOSgAgCneCv9y0DckzCKzgIrwE3MKw4sE4g/ff6qvs
	 4uV2M6PW3ZObLDYjeOguuA/gsbzkHE/OoyZC/gz9m3nvtm5zq/OsY+iPVfDMODNMA5PzPE26G2RA
	 LYoHvODd6cOUz+A5HRSvssHifOHrVQpeYhPKDCwXIrSsQ1QSdP9lsE3qEaY6qc6+57jA4spHyqUR
	 LnMHDx8DZBSiAE6wTeA5hUTu6tiB7wwpMM21SEm2zMnTEC53s3TBztFAPACyA488s+JqYx2dLvsA
	 3grlyTaqMX5rC2Zek1a+RzxH6vfdQ3bk2EmOdDbLZrAIpzW9PHVhpI2MPgK8Ztc+i0PKXkgQ3tqx
	 79bpRa1deDzbg4/XK+jca8peRUSi0GrSkfnPSdTQ==
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
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
Subject: [PATCH net] ipv6: bound temporary address regeneration advance
Date: Mon, 26 Oct 2026 16:22:47 +0800
X-OQ-MSGID: <20261026082247.1571155-1-1075151112@qq.com>
X-Mailer: git-send-email 2.43.0
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

ipv6_get_regen_advance() combines regen_min_advance, regen_max_retry
and dad_transmits. All three are signed sysctls, and the latter two
are multiplied as int. Negative values or overflow of large positive
inputs can make the unsigned long result much larger than intended.

When ipv6_create_tempaddr() clamps the preferred lifetime, it adds age
and one to this advance and stores it in a u32. The sum can wrap or be
truncated to a short preferred lifetime. addrconf_verify_rtnl() then
finds the new address due for regeneration and restarts its scan after
creating another one. The temporary-address path has had no
max_addresses check since commit 4b08a8f1bd8c ("ipv6: remove
max_addresses check from ipv6_create_tempaddr"). In a baseline namespace
test, setting dad_transmits=-1 and adding a temporary-address template
with mngtmpaddr produced 2859 loopback addresses in two seconds.

Non-negative inputs can also overflow the int product, so rejecting
negative writes alone is not enough.

Reject negative values for all three sysctls with -EINVAL. Writes that
used to succeed now fail validation; negative values have no useful meaning
(negative regen_max_retry already disables temporary addresses on the
first attempt). Keep zero valid. Use checked u64 arithmetic and
div_u64() to calculate the advance, and cap it at U32_MAX. Compare the
required preferred lifetime in u64 before narrowing it to u32. Calculate
the desync margin only when the configured lifetime exceeds the advance,
avoiding an unsigned subtraction wrap on 32-bit builds.

The issue was found and this fix was prepared with assistance from
OpenAI Codex.

Tested on x86-64 KASAN:
- negative writes to the three sysctls were rejected without changing
  their values, and zero remained valid;
- normal temporary-address setup produced three IPv6 addresses;
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
 Documentation/networking/ip-sysctl.rst |  3 ++
 net/ipv6/addrconf.c                    | 50 ++++++++++++++++++--------
 2 files changed, 38 insertions(+), 15 deletions(-)

diff --git a/Documentation/networking/ip-sysctl.rst b/Documentation/networking/ip-sysctl.rst
index 4b19c8d3efda7..e78a59ebc9df2 100644
--- a/Documentation/networking/ip-sysctl.rst
+++ b/Documentation/networking/ip-sysctl.rst
@@ -2872,6 +2872,7 @@ dad_transmits - INTEGER
 	The amount of Duplicate Address Detection probes to send.
 
 	Default: 1
+	Minimum: 0
 
 forwarding - INTEGER
 	Configure interface-specific Host/Router behaviour.
@@ -3023,12 +3024,14 @@ regen_min_advance - INTEGER
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
index c8c0dd04982d9..39ecb2c25055b 100644
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
@@ -1394,6 +1405,7 @@ static int ipv6_create_tempaddr(struct inet6_ifaddr *ifp, bool block)
 	struct ifa6_config cfg;
 	long max_desync_factor;
 	struct in6_addr addr;
+	u64 min_preferred_lft;
 	int ret = 0;
 
 	write_lock_bh(&idev->lock);
@@ -1430,9 +1442,13 @@ static int ipv6_create_tempaddr(struct inet6_ifaddr *ifp, bool block)
 	 * idev->desync_factor if it's larger
 	 */
 	cnf_temp_preferred_lft = READ_ONCE(idev->cnf.temp_prefered_lft);
-	max_desync_factor = min_t(long,
-				  READ_ONCE(idev->cnf.max_desync_factor),
-				  cnf_temp_preferred_lft - regen_advance);
+	max_desync_factor = 0;
+	if (cnf_temp_preferred_lft > 0 &&
+	    regen_advance < cnf_temp_preferred_lft)
+		max_desync_factor =
+			min_t(long,
+			      READ_ONCE(idev->cnf.max_desync_factor),
+			      cnf_temp_preferred_lft - regen_advance);
 
 	if (unlikely(idev->desync_factor > max_desync_factor)) {
 		if (max_desync_factor > 0) {
@@ -1485,15 +1501,16 @@ static int ipv6_create_tempaddr(struct inet6_ifaddr *ifp, bool block)
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
@@ -4705,7 +4722,7 @@ static void addrconf_verify_rtnl(struct net *net)
 
 				unsigned long regen_advance = ipv6_get_regen_advance(ifp->idev);
 
-				if (age + regen_advance >= ifp->prefered_lft) {
+				if ((u64)age + regen_advance >= ifp->prefered_lft) {
 					struct inet6_ifaddr *ifpub = ifp->ifpub;
 					if (time_before(ifp->tstamp + ifp->prefered_lft * HZ, next))
 						next = ifp->tstamp + ifp->prefered_lft * HZ;
@@ -6921,7 +6938,8 @@ static const struct ctl_table addrconf_sysctl[] = {
 		.data		= &ipv6_devconf.dad_transmits,
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
+		.proc_handler	= proc_dointvec_minmax,
+		.extra1		= SYSCTL_ZERO,
 	},
 	{
 		.procname	= "router_solicitations",
@@ -7001,14 +7019,16 @@ static const struct ctl_table addrconf_sysctl[] = {
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

base-commit: 7076f684d5132e6a6145e1da2fa74771ecd052e5

