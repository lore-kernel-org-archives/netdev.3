Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F28A3769FA
	for <netdev@vger.kernel.org>; Sat, 18 Jul 2026 06:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784357289; cv=none; b=D9B34QeyrFppGDQVkj97wnoFXXYh8sPyAthFmxuXnImYOkc2ryXc7Zmag3DVnI4m+WGu8TPOYznck1DMfHr8YgrWPeMsWkD7vOCtKyWh43IVwCieTf4nFRUyaCLrarD91WeeTY5a+etezeeX8rl705/kG3h/BFWYg1hm2Lv2VvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784357289; c=relaxed/simple;
	bh=+vSaySc9Hh/0537F1Jmcjz3MfjRSSE/TxDGwc+jkZSY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cpHCtEw6jhAuZuF+y7xfCxSHprblQNfOjQFNbKG6Riyf1kQgWdsy82Tg2z1M8qJHyfJqoauOsgsPJWxvne0TAqrwvQ4o6AfZ0+y0nk29rBjkJlHbdx73aDUOyrKwsnYKNueTWekCZdd6Xi/PRiCGu4b83isK+1zy9aGwPWT/VBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pKeoHCHl; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pKeoHCHl"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2cea3004256so98854455ad.0
        for <netdev@vger.kernel.org>; Fri, 17 Jul 2026 23:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784357285; x=1784962085; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fi5mgMDxIBNkaJhSvnua6zIuIuLL2opLvaZY86BAO28=;
        b=pKeoHCHl51J+PyMmCnao8MNoJdJOkuj7NjAOgPm5ubUGa8L8RCT7kNucTLYaF05xzh
         yeuEHsQlzkFou32RNaEOJDUG1ttCNBPnmv/qWXi1H4V/iwTffDSnHOLv80v0HwLEYT1w
         RfzbMFcy//0R20G0wbi8RtUQXTxZo3LGwxWK1t9nFP/YkS/TA/KuXAlg8A61FesEPz5d
         HB3Ft+KSQajMraeTTyYd8SoZ1WGcKLjpZCgR9OUui3bpgTBdu3F08qzXBvl/fLOqoele
         DwgMVixIdTpmvJafaRKUd1JFc5oFrbx0yPY4UzlAVgocoFOabM4ZECKidN3HVe261b0R
         Rm8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784357285; x=1784962085;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fi5mgMDxIBNkaJhSvnua6zIuIuLL2opLvaZY86BAO28=;
        b=RfOvbo6fyoxYUXGZpDH7kX4hkDAJnH7cDw5t6TlJR0EYWrpDoBYD3vEfvxk038HFt3
         xf3jqFL+sygZFYK5rExxwJH0dLV5HFlAsiAzlt4jP9LTXV0VZY8jtbLhkFs3RWF8XA0m
         ccxoF3q8cMZukxjaDgMljiDBqB3RE9hGNTj+CUy01qZITI6BfPWQTru4VukHagP5KIkR
         s8aB/tZwt65zB7RyIk/1UUZ9A//kkpqgkkeUrPoea5dCAM/XdAqjvb1nKgn4kOSxqqUI
         H96Ign3xGfe7s6H46DDAjUX3puSocrRejs7OkEdlFxv5zZs5nJrUDj1Ov21vSRlyr20a
         95+w==
X-Forwarded-Encrypted: i=1; AHgh+RrfuQyjmHiebegbq+Ic5DjD+pcqEpf2UL9wqk2KIZ9wMAaZxV1LN27cfdiVj3O1YtQ48ILv0Zs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYcYYDheRvZ+sGN1ZWwQqEJ2qYvsRyQfGY8La1/TyaqFY6YmLW
	bAv8NqTGqPsJy+uB76bLR1ayDZxs97Dz/Nfne8QxNshACKx+Dyqh3BHd
X-Gm-Gg: AfdE7ckhDa8j2K0O3KSyVh082L95QfAtYEm/d2qRFRfY7HpzPgHJtQraslIADoERtaf
	D9jdqNCYPAd5XMW1tONXhBBtKbCeZqzJItgaBj4oGZVOAfRU0UXiIWrvWI/IeTStehmWu9MzCEY
	rQmcwoQ0i0Ais9yc9Zk2Pkw/77R7n39OKEV1ShbAsXKdgCICBIg0ESsgjU3hzWmhZ2r8BS+HUT5
	+wlRCjrRjD777Vi39u/k0UYhJWTVG6tUexkWNMy9u6YwzLBCDiyLD8Pl1EQpLyDjOEDtc3mtwNX
	8RewfLFmhl4Eq5F31e3Y0Vhpw0qghpWz0neeLy9KAH2ys8MlOqzCkEyoVrpnKBrXhkrdbH+suDQ
	GdBEB7SnIcGhAlPNLzLw6/5PV1M3J2r3YH2FjgJrv9oKBQLr7+dvZbkXK8SKj9+/cGyiRxVxQgn
	9JRSz3k43J4wWzUl64PQ==
X-Received: by 2002:a17:902:da81:b0:2c6:8d95:fd6d with SMTP id d9443c01a7336-2cf34892342mr60762195ad.21.1784357284838;
        Fri, 17 Jul 2026 23:48:04 -0700 (PDT)
Received: from m-upc-A520M-HDV.lan ([2400:2410:3f60:500:9278:f508:9b9:d937])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf344b1353sm22975335ad.19.2026.07.17.23.48.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 23:48:04 -0700 (PDT)
Sender: Yuyang Huang <uyoko90@gmail.com>
From: Yuyang Huang <sigefriedhyy@gmail.com>
To: Yuyang Huang <sigefriedhyy@gmail.com>
Cc: David Ahern <dsahern@kernel.org>,
	netdev@vger.kernel.org
Subject: [PATCH iproute2-next v3] ipmaddr: use RTM_GETMULTICAST to list multicast addresses
Date: Sat, 18 Jul 2026 15:48:00 +0900
Message-ID: <20260718064800.103028-1-sigefriedhyy@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace /proc/net/igmp and /proc/net/igmp6 parsing in "ip maddr show"
with RTM_GETMULTICAST dumps. The kernel dumps IPv6 multicast addresses
via netlink since the beginning, IPv4 since v6.15 (eb4e17a1d915), and
reports the group users count via IFA_MC_USERS since kernel commits
7cb8198761e6 and e1d0f3f08391.

The netlink result is only used when it carries the same information
as procfs: if the dump fails (e.g. no IPv4 dump support) or any entry
lacks IFA_MC_USERS, the result is discarded and the procfs parsers
run as before, so output is unchanged on older kernels.

Link-layer multicast addresses are still read from
/proc/net/dev_mcast as there is no netlink API for them.

When a device is given, its ifindex is passed in the dump request so
strict-check kernels filter the dump server side; received entries
are checked against the ifindex again for kernels that ignore the
request field. An unknown device keeps printing an empty list.

Signed-off-by: Yuyang Huang <sigefriedhyy@gmail.com>
---
Changes in v2:
- accept_maddr(): only accept RTM_NEWMULTICAST; the kernel never sends
  RTM_GETMULTICAST in dump replies

Changes in v3:
- accept_maddr(): match RTM_GETMULTICAST again, reverting the v2
  change; dump replies do carry RTM_GETMULTICAST (RTM_NEWMULTICAST is
  only used for notifications), confirmed by testing on a live kernel

 include/libnetlink.h |   3 ++
 ip/ipmaddr.c         | 109 +++++++++++++++++++++++++++++++++++++++++--
 lib/libnetlink.c     |  26 +++++++++++
 3 files changed, 134 insertions(+), 4 deletions(-)

diff --git a/include/libnetlink.h b/include/libnetlink.h
index e91505d9..518b8714 100644
--- a/include/libnetlink.h
+++ b/include/libnetlink.h
@@ -62,6 +62,9 @@ typedef int (*req_filter_fn_t)(struct nlmsghdr *nlh, int reqlen);
 int rtnl_addrdump_req(struct rtnl_handle *rth, int family,
 		      req_filter_fn_t filter_fn)
 	__attribute__((warn_unused_result));
+int rtnl_mcaddrdump_req(struct rtnl_handle *rth, int family,
+			req_filter_fn_t filter_fn)
+	__attribute__((warn_unused_result));
 int rtnl_addrlbldump_req(struct rtnl_handle *rth, int family)
 	__attribute__((warn_unused_result));
 int rtnl_routedump_req(struct rtnl_handle *rth, int family,
diff --git a/ip/ipmaddr.c b/ip/ipmaddr.c
index 462b409e..95b703d2 100644
--- a/ip/ipmaddr.c
+++ b/ip/ipmaddr.c
@@ -27,6 +27,7 @@
 
 static struct {
 	char *dev;
+	int  index;
 	int  family;
 } filter;
 
@@ -207,6 +208,93 @@ static void read_igmp6(struct ma_info **result_p)
 	fclose(fp);
 }
 
+struct maddr_dump_ctx {
+	struct ma_info *list;
+	bool mc_users_missing;
+};
+
+static int maddr_dump_filter(struct nlmsghdr *nlh, int reqlen)
+{
+	struct ifaddrmsg *ifm = NLMSG_DATA(nlh);
+
+	ifm->ifa_index = filter.index;
+
+	return 0;
+}
+
+static int accept_maddr(struct nlmsghdr *n, void *arg)
+{
+	struct maddr_dump_ctx *ctx = arg;
+	struct ifaddrmsg *ifm = NLMSG_DATA(n);
+	int len = n->nlmsg_len - NLMSG_LENGTH(sizeof(*ifm));
+	struct rtattr *tb[IFA_MAX + 1];
+	struct ma_info *ma;
+
+	if (n->nlmsg_type != RTM_GETMULTICAST)
+		return 0;
+
+	if (len < 0)
+		return -1;
+
+	if (filter.index && filter.index != ifm->ifa_index)
+		return 0;
+
+	parse_rtattr(tb, IFA_MAX, IFA_RTA(ifm), len);
+
+	if (!tb[IFA_MULTICAST] ||
+	    RTA_PAYLOAD(tb[IFA_MULTICAST]) > sizeof(ma->addr.data))
+		return 0;
+
+	if (!tb[IFA_MC_USERS]) {
+		ctx->mc_users_missing = true;
+		return 0;
+	}
+
+	ma = calloc(1, sizeof(*ma));
+	if (ma == NULL)
+		return -1;
+
+	ma->index = ifm->ifa_index;
+	strlcpy(ma->name, ll_index_to_name(ifm->ifa_index), sizeof(ma->name));
+	ma->addr.family = ifm->ifa_family;
+	ma->addr.bytelen = RTA_PAYLOAD(tb[IFA_MULTICAST]);
+	ma->addr.bitlen = ma->addr.bytelen << 3;
+	memcpy(ma->addr.data, RTA_DATA(tb[IFA_MULTICAST]), ma->addr.bytelen);
+	ma->users = rta_getattr_u32(tb[IFA_MC_USERS]);
+	maddr_ins(&ctx->list, ma);
+
+	return 0;
+}
+
+static int read_maddr_netlink(int family, struct ma_info **result_p)
+{
+	struct maddr_dump_ctx ctx = {};
+	struct ma_info *ma;
+	int err;
+
+	rth.flags |= RTNL_HANDLE_F_SUPPRESS_NLERR;
+	err = rtnl_mcaddrdump_req(&rth, family,
+				  filter.index ? maddr_dump_filter : NULL);
+	if (err >= 0)
+		err = rtnl_dump_filter(&rth, accept_maddr, &ctx);
+	rth.flags &= ~RTNL_HANDLE_F_SUPPRESS_NLERR;
+
+	/* Kernels that dump multicast addresses but do not report the
+	 * users count via IFA_MC_USERS cannot replace procfs.
+	 */
+	if (err < 0 || ctx.mc_users_missing) {
+		maddr_clear(ctx.list);
+		return -1;
+	}
+
+	while ((ma = ctx.list) != NULL) {
+		ctx.list = ma->next;
+		maddr_ins(result_p, ma);
+	}
+
+	return 0;
+}
+
 static void print_maddr(FILE *fp, struct ma_info *list)
 {
 	print_string(PRINT_FP, NULL, "\t", NULL);
@@ -291,12 +379,25 @@ static int multiaddr_list(int argc, char **argv)
 		argv++; argc--;
 	}
 
+	if (filter.dev) {
+		filter.index = ll_name_to_index(filter.dev);
+		/* an unknown device has no multicast addresses */
+		if (!filter.index) {
+			print_mlist(stdout, NULL);
+			return 0;
+		}
+	}
+
 	if (!filter.family || filter.family == AF_PACKET)
 		read_dev_mcast(&list);
-	if (!filter.family || filter.family == AF_INET)
-		read_igmp(&list);
-	if (!filter.family || filter.family == AF_INET6)
-		read_igmp6(&list);
+	if (!filter.family || filter.family == AF_INET) {
+		if (read_maddr_netlink(AF_INET, &list) < 0)
+			read_igmp(&list);
+	}
+	if (!filter.family || filter.family == AF_INET6) {
+		if (read_maddr_netlink(AF_INET6, &list) < 0)
+			read_igmp6(&list);
+	}
 	print_mlist(stdout, list);
 	maddr_clear(list);
 	return 0;
diff --git a/lib/libnetlink.c b/lib/libnetlink.c
index 8905e297..edf3a8ba 100644
--- a/lib/libnetlink.c
+++ b/lib/libnetlink.c
@@ -336,6 +336,32 @@ int rtnl_addrdump_req(struct rtnl_handle *rth, int family,
 	return send(rth->fd, &req, sizeof(req), 0);
 }
 
+int rtnl_mcaddrdump_req(struct rtnl_handle *rth, int family,
+			req_filter_fn_t filter_fn)
+{
+	struct {
+		struct nlmsghdr nlh;
+		struct ifaddrmsg ifm;
+		char buf[128];
+	} req = {
+		.nlh.nlmsg_len = NLMSG_LENGTH(sizeof(struct ifaddrmsg)),
+		.nlh.nlmsg_type = RTM_GETMULTICAST,
+		.nlh.nlmsg_flags = NLM_F_DUMP | NLM_F_REQUEST,
+		.nlh.nlmsg_seq = rth->dump = ++rth->seq,
+		.ifm.ifa_family = family,
+	};
+
+	if (filter_fn) {
+		int err;
+
+		err = filter_fn(&req.nlh, sizeof(req));
+		if (err)
+			return err;
+	}
+
+	return send(rth->fd, &req, sizeof(req), 0);
+}
+
 int rtnl_addrlbldump_req(struct rtnl_handle *rth, int family)
 {
 	struct {
-- 
2.43.0

