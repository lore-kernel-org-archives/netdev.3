Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA1BD38D6BD
	for <netdev@vger.kernel.org>; Fri, 17 Jul 2026 06:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784270060; cv=none; b=ME+j5pd5tRLydTJ0E6EA7yRaV5qITjMrX0MMVxl9WEZPnTV19RyFt+y8hCw+/QZ2RrIvv4QccYeM/1luPQxQoEE5K4KUwHfVrUFfDg7d0wMLLWwMlAHFNYRDWdRDu9byVXrTqVIcfGA92awjJOeiqHaccoQ5YB+4goFuwvIgems=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784270060; c=relaxed/simple;
	bh=rLtOpX3Pm694jUGgBZ00nozbgnYGkQahZVhZM5kt01A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UqgIL7DVb9dSpBEX6pdwOOi+ocdvaNmPhabMcaQBSWAqDzhrwTX9vthRQyT5yIFxE/nRf8E812RZ/SXIJDQzQEo7ukzjbaR1y5GL4UVKGVLbUSjgstB8P9aqSn3BXZaH0caQwCv/xDz4OMpZg6fggNx8WUZk0UtOa2QwXpSryYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mv9kamXe; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mv9kamXe"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-84536ecfc5bso4233513b3a.2
        for <netdev@vger.kernel.org>; Thu, 16 Jul 2026 23:34:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784270058; x=1784874858; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Cy2mOijfnAIACI62+6ipNwyok1LWBe2LVqzzgKNZrwU=;
        b=mv9kamXeBke/iOruHxxTOcof79xSyKtwoloprAM5fySDPdPuexI9UYM6QCdRrNqhFi
         iaoKs9pn9+dQ1vUr5sResKfdmGlpWfSRoW5ARsLcnSijTa2Z245T/zNunkbEX4DHzSof
         LhVyj4eakhLo3a3IodbDm/nmp2u3/g32wYbpAPRYWxQTnin1IC3rqoD8tpsn/rTJngG1
         84zId5htjPBQ+3BVvl8AvKp55Bl+VHK2YMQdUQgCRAvvyGWjM+HM2N4+pfGGOzs8PWoY
         0hivHC6UdH/1A0iHf0EzB9Ljo24U19mfMBr+H1oJSexk3zWwXlaRwhUBwdWSpqSIzBM8
         vftQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784270058; x=1784874858;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Cy2mOijfnAIACI62+6ipNwyok1LWBe2LVqzzgKNZrwU=;
        b=LuPg7bXjovioHwu9KbtYxhmOydPs8aG70cKowsHO6NkVGQS6tEsKEnuwmtRJkmGHqk
         Lsdnc2ppEyiX5LJpr/WvpSXBSwKvh8/PCFL2jJFQPO/H0jH78i7Rq0kfKWTr5CsFgpXY
         Gd8AWcf+A+hpNRBJkC+PYGeOEbjKrdj98xrZhbxDfCNfkFThdFPlRp8ARhzA7J5rYhhV
         IqhDcwQHimVjAB5DSJ609Cqv6mlYZ+1E5Wnn7eNx4THJ0NMy2sDdZq4kS7MN+doZlxm7
         dVHPnhdyn5SCP7OAR02SgnaI4alVKYKgTCPrncreYpKaFyeJTNe4HEiE3P2St/njnIbG
         6BMQ==
X-Forwarded-Encrypted: i=1; AHgh+RrZFJFxu2QrKFytVZuE0F8EnFtI+y0AP2D8p7qojM5ttA6g6GKMu/FiNhWecUN5h2lMncFrric=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBG9wgeV+m5z6fsVsXBgfNovLXJY9HmO462TmRmBc1iHU726XH
	QghFMYZ8t8/Y4IIEJ/5FppadqPEQEV/OeDO/n3kSg5jyNvHMuermDOLm
X-Gm-Gg: AfdE7ck4Rw/oboIC3lcwzgQpBW+9CPVVFYSQUYSkNJX/7nxRRT7qJ9D4RNCMSjr4xCm
	r8wdmUdutFndCwi+SdUNoW66BTK+OSnGTrDKxVqMWVjTmVeb7xKSVfU1EzOy5U78LOB7tBL35UH
	BzLxVJhIvNtUAw7MkkeJHqK5z+nGUF5jZykucb/ytjlXp6rb0nJSeR0k82+aZb5KwB9RkTLCBUi
	17EOck8TnYLbtaAxJAMoRXWRFyg6LW3zbvM25BRLqM+ZCgdEuW3jpUEPu5AgARaX4qSgzciSk8I
	KglkiZmqjj0X0SVecSEjIvlHnp0NUYZJH4JsrLW1xowHNBbzBRMpanMAXtYck9p1bQ57zJaD7Jr
	RqjMxLk8B0wnywCkVbP2Izu63gAw9GdmZS6k/iNuj93ZGrT0l/ZzQbHpLHujon2qLaZadXQoOX6
	SRJj+pdZ5tNcf+/Dr6wGU=
X-Received: by 2002:a05:6a00:3a04:b0:847:8504:9946 with SMTP id d2e1a72fcca58-84c29289498mr1296866b3a.25.1784270057792;
        Thu, 16 Jul 2026 23:34:17 -0700 (PDT)
Received: from m-upc-A520M-HDV.lan ([2400:2410:3f60:500:c4cd:1a6f:a45c:f79e])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84c2afae3afsm390417b3a.60.2026.07.16.23.34.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 23:34:17 -0700 (PDT)
Sender: Yuyang Huang <uyoko90@gmail.com>
From: Yuyang Huang <sigefriedhyy@gmail.com>
To: Yuyang Huang <sigefriedhyy@gmail.com>
Cc: David Ahern <dsahern@kernel.org>,
	netdev@vger.kernel.org
Subject: [PATCH iproute2-next v2] ipmaddr: use RTM_GETMULTICAST to list multicast addresses
Date: Fri, 17 Jul 2026 15:34:11 +0900
Message-ID: <20260717063411.20206-1-sigefriedhyy@gmail.com>
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
change in v2:
- accept_maddr(): only accept RTM_NEWMULTICAST; the kernel never sends
  RTM_GETMULTICAST in dump replies

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
index 462b409e..16470655 100644
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
+	if (n->nlmsg_type != RTM_NEWMULTICAST)
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

