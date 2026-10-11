Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 565F23B6377
	for <netdev@vger.kernel.org>; Sun, 11 Oct 2026 03:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791689355; cv=none; b=d5tVWRLA8zv+T3yD3QKzTgVTfoA7qD4Z3OshMemKpqifCpyyJsK48r6xpqsk5S4rHocuXiriyf5W0JvsfCdMgBh8GquMxevqsh98pq0NRdSzBEBm8X6euGQdAhvC90w6o7Qq0PcgkCERGhCPS8EkkITMRhd93ZkEWT0ecqaTJzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791689355; c=relaxed/simple;
	bh=xJuYFqxVvGK/QyKcLtDJP0wBd+Pbo7Vi8SjVsBjNgzo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jEEQFC5/QX5mSLKzD5jVqatRANUsitVP+UtsnRAIr+XGmsVtulyhw/FYf5w+A6iYwKjV/z1J3jeR78yeDlF98UychKPgHrQDE8o/tmbH050tr0wRYgZtDYBaVQUtrgtqKIU6ssmWrguk5BoXbcR+cFnPR9mJaxALQbs4JUkd++E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ogkrIKCt; arc=none smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ogkrIKCt"
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-30b6dad2382so2075478eec.0
        for <netdev@vger.kernel.org>; Sat, 10 Oct 2026 20:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791689353; x=1792294153; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=DMvdaSKwMRcNUnAFlSuJUiJIEor6Huzh2QKml94ZCNY=;
        b=ogkrIKCthVKmCSWy3tcNhH7j3g2/oHBX5ANEgTaaBfN84p9LVnQF0NwNWDpRv+OaJn
         rDDXowJBa8HJMwhP02PdzgFvEEnQ/4KCJrwkzU/wSvz84kpk7F8jJiDhzpvWgoraSDcb
         1uyMMeSv5j6q/aExtFkXB7LgZCUFF2eUYG1rcSjdSCfnXNe+DWiEc5RDbyBsFhLGYIpJ
         oiplcGdgl8bvB/JB+y9Yamrlrc4LdXdaIQn5a4/MOBqKo5onXwc+TzFICFKkzdRlFQ0k
         gH+jJwUdDurokY1FcpU8eDA5v/PeEF9Ll0swbeYLcI9fJ2UWuQozlKqQEJ4XMoCzl3Wn
         zzYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791689353; x=1792294153;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=DMvdaSKwMRcNUnAFlSuJUiJIEor6Huzh2QKml94ZCNY=;
        b=b0IKW/nl/xZAdpo21BEayfjVfFUVopyVxrNahrdOA9Mw84q1oVOwcfGRgkTuD5RcWF
         6E4X65DC+gciGVsGILkAlp2q0ZvwKz3zt6MQ0gFRnXZvQdQ66sRl5sJ+Zct3SvRqbLp/
         C9Bdok4bbuZIll8hGTr+waN+otaQWNDJx/SwtArwL4n+ZcXVwMzkEieEC6hIILitI9J3
         dg+kMz6EODzVWGIl59DlgWcbDeCT6NqmNYBEXYK9s1k+8EZmWnjGMzgecZocEc9PI4iG
         ouTiONrhLRkfzUjfKLsRYdYzfjoWnwGp6CysWfcxhfJmXC/rDhPyJja/6rHiRTv2UNeX
         Vmuw==
X-Forwarded-Encrypted: i=1; AKwUvBxHCef9UlSorHPvokRAdsrMZtg8CVQqetj/svBsdjiMD40Rx9IH9E8CwpfHuo/GqH0yxTT43N8=@vger.kernel.org
X-Gm-Message-State: AFq9FYJOM1LY+6ZW8/V3SyMdx0qZR5whFtrOve1IHcpCtuPHVXSlXw73
	4oLpMIS/UJmjm/9rfRpmst18Spoa71tn8p1eXObt80Yrki+KyvNn5/Bw6s+kqg==
X-Gm-Gg: AYBFou3ADjs6y2DxWnwOpQxxQIYQt7y46IoT4k7VA1u2iTSLMOIuGARrJeiLln0zBn5
	pT8DSflHOwJzg07qIfzUlo+o8xjJVrc26PnlvWxh9aRiBLv0SlpQi6vGMrVLL5DUB9Kr2trYe6b
	mOzzI1mObCDOA5C/wPG77vS7OCyf5Jqn4EfLmrD9ZwDpZZ59JZMHH5DuaP6KMQYowwLawxkgvr6
	Q5r8PHOerV46amO/YJMbGzSi5EhJrRIohVvXuh1vfQgct090Q9hD3keUx/bEhYdbv0JZpop1N+u
	cJoh3k6vLpbC0UBChmg1/EZir3qkUGzUrlorhVUrUFNYZe8llALIXyf+ddF9KLtQxl6zsDxlfrW
	OTOrbl7wyIRD6ORvTzadQKSe1WHcWLiPZj7t9iYXBdyNY+v6X0DtgXrxxz0ZnkdDTHdQj9uiNIK
	r1vC79k7Gbp/9pBCY5JMZwuSCRGbjU7GIxrpLGFsFoSOxHcGJP0iwm1kRfxC9TNiv3ji77qVUSp
	QacsZQQTPDDK/QBG1GW4qAHM3Kh7ucjT+J2qApWr19oxka4ZsNrarogog1To2r6NRFtNtjzq8v6
	II40oMlYlJIC8oM=
X-Received: by 2002:a05:693c:62c5:b0:353:7d40:6636 with SMTP id 5a478bee46e88-3537dedaae9mr7802343eec.1.1791689352457;
        Sat, 10 Oct 2026 20:29:12 -0700 (PDT)
Received: from l ([2603:8002:ea00:6800:4112:f5be:f9b3:803f])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537cab27d5sm22393297eec.17.2026.10.10.20.29.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Oct 2026 20:29:12 -0700 (PDT)
From: Dave Seddon <dave.seddon.ca@gmail.com>
To: dave.seddon.ca@gmail.com,
	netdev@vger.kernel.org
Subject: [PATCH iproute2 3/3] testsuite: add bond slave LACP port state test
Date: Sat, 10 Oct 2026 20:29:06 -0700
Message-ID: <20261011032906.1398174-4-dave.seddon.ca@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261011032906.1398174-1-dave.seddon.ca@gmail.com>
References: <20261011032906.1398174-1-dave.seddon.ca@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Decode generated RTM_NEWLINK messages with ip -d monitor file and
check the partner state value and flags, the u8 actor state, and
zero and absent partner attributes.

Use a synthetic 0x0100 partner state to detect a one-byte reader on
both endian types: it returns 0 on little-endian and 1 on big-endian
instead of 256. Real LACP states use only the low eight bits.

Check the actor state before asserting partner attribute absence,
so empty output cannot satisfy that test.

Assisted-by: LLM
Signed-off-by: Dave Seddon <dave.seddon.ca@gmail.com>
---
 .gitignore                                    |   1 +
 testsuite/Makefile                            |   1 +
 .../ip/link/show_bond_slave_lacp_state.t      |  33 ++++++
 testsuite/tools/generate_nlmsg.c              | 103 ++++++++++++++++--
 4 files changed, 129 insertions(+), 9 deletions(-)
 create mode 100755 testsuite/tests/ip/link/show_bond_slave_lacp_state.t

diff --git a/.gitignore b/.gitignore
index e5234a3d..a16f6362 100644
--- a/.gitignore
+++ b/.gitignore
@@ -39,3 +39,4 @@ testsuite/results
 testsuite/iproute2/iproute2-this
 testsuite/tools/generate_nlmsg
 testsuite/tests/ip/link/dev_wo_vf_rate.nl
+testsuite/tests/ip/link/bond_slave_partner_*.nl
diff --git a/testsuite/Makefile b/testsuite/Makefile
index fb50f618..bef66002 100644
--- a/testsuite/Makefile
+++ b/testsuite/Makefile
@@ -48,6 +48,7 @@ testclean:
 clean: testclean
 	@rm -f iproute2/iproute2-this
 	@rm -f tests/ip/link/dev_wo_vf_rate.nl
+	@rm -f tests/ip/link/bond_slave_partner_*.nl
 	$(MAKE) -C tools clean
 
 distclean: clean
diff --git a/testsuite/tests/ip/link/show_bond_slave_lacp_state.t b/testsuite/tests/ip/link/show_bond_slave_lacp_state.t
new file mode 100755
index 00000000..4ccf3960
--- /dev/null
+++ b/testsuite/tests/ip/link/show_bond_slave_lacp_state.t
@@ -0,0 +1,33 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+
+. lib/generic.sh
+
+# IFLA_BOND_SLAVE_AD_PARTNER_OPER_PORT_STATE is a u16 on the wire; the
+# actor state next to it is a u8. Each row decodes one blob written by
+# tools/generate_nlmsg and checks the printed value.
+#
+# The synthetic 0x0100 state checks the full attribute width on either
+# endian: a u8 reader returns 0 on little-endian and 1 on big-endian.
+#
+# row: file suffix | description | expected regex (!regex: must be absent)
+while IFS='|' read -r suffix desc expect; do
+	[ -z "$suffix" ] && continue
+	NL_FILE="tests/ip/link/bond_slave_partner_${suffix}.nl"
+	ts_ip "$0" "$desc" -d monitor file "$NL_FILE"
+	case "$expect" in
+	!*)
+		test_on "ad_actor_oper_port_state 63[^0-9]"
+		test_on_not "${expect#!}"
+		;;
+	*)
+		test_on "$expect"
+		;;
+	esac
+done <<EOF
+fast|partner state 0x3f|ad_partner_oper_port_state 63 ad_partner_oper_port_state_str <active,short_timeout,aggregating,in_sync,collecting,distributing>
+fast|actor state stays u8|ad_actor_oper_port_state 63[^0-9]
+zero|partner state 0|ad_partner_oper_port_state 0 ad_partner_oper_port_state_str <>
+hionly|partner state 0x0100, high byte only|ad_partner_oper_port_state 256[^0-9]
+absent|no partner attribute|!ad_partner_oper_port_state
+EOF
diff --git a/testsuite/tools/generate_nlmsg.c b/testsuite/tools/generate_nlmsg.c
index 106dca63..7c0aed3a 100644
--- a/testsuite/tools/generate_nlmsg.c
+++ b/testsuite/tools/generate_nlmsg.c
@@ -11,6 +11,9 @@
 #include <linux/if.h>
 #include <errno.h>
 #include <stdio.h>
+#include <string.h>
+#include <linux/if_link.h>
+#include "utils.h"
 
 int fill_vf_rate_test(void *buf, size_t buflen)
 {
@@ -40,6 +43,7 @@ int fill_vf_rate_test(void *buf, size_t buflen)
 #define ASSERT(x) if (x < 0) return -1
 #define ATTR_L(t, v, l)	ASSERT(addattr_l(h, buflen, t, v, l))
 #define ATTR_8(t, v)	ASSERT(addattr8(h, buflen, t, v))
+#define ATTR_16(t, v)	ASSERT(addattr16(h, buflen, t, v))
 #define ATTR_32(t, v)	ASSERT(addattr32(h, buflen, t, v))
 #define ATTR_STRZ(t, v)	ASSERT(addattrstrz(h, buflen, t, v))
 
@@ -87,26 +91,107 @@ int fill_vf_rate_test(void *buf, size_t buflen)
 	return h->nlmsg_len;
 }
 
+/* The synthetic 0x0100 state detects a u8 reader on either endian. */
+struct bond_slave_case {
+	const char *file;
+	__u16 partner_state;
+	bool has_partner;
+};
+
+static const struct bond_slave_case bond_slave_cases[] = {
+	{ "tests/ip/link/bond_slave_partner_fast.nl",	0x003f, true },
+	{ "tests/ip/link/bond_slave_partner_zero.nl",	0x0000, true },
+	{ "tests/ip/link/bond_slave_partner_hionly.nl",	0x0100, true },
+	{ "tests/ip/link/bond_slave_partner_absent.nl",	0x0000, false },
+};
+
+static int fill_bond_slave_test(void *buf, size_t buflen,
+				const struct bond_slave_case *c)
+{
+	__u8 mac[ETH_ALEN] = { 0x02, 0x00, 0x00, 0x00, 0x00, 0x01 };
+	struct rtattr *linkinfo, *slave_data;
+	struct nlmsghdr *h = buf;
+	struct ifinfomsg *ifi;
+
+	memset(buf, 0, buflen);
+	h->nlmsg_type = RTM_NEWLINK;
+	h->nlmsg_len = NLMSG_LENGTH(sizeof(*ifi));
+
+	ifi = NLMSG_DATA(h);
+	ifi->ifi_type = ARPHRD_ETHER;
+	ifi->ifi_index = 2;
+	ifi->ifi_flags = IFF_RUNNING | IFF_BROADCAST | IFF_MULTICAST |
+			 IFF_UP | IFF_LOWER_UP | IFF_SLAVE;
+
+	ATTR_STRZ(IFLA_IFNAME, "eth1");
+	ATTR_32(IFLA_MTU, 1500);
+	ATTR_L(IFLA_ADDRESS, mac, sizeof(mac));
+
+	linkinfo = NEST(IFLA_LINKINFO);
+	ATTR_STRZ(IFLA_INFO_SLAVE_KIND, "bond");
+	slave_data = NEST(IFLA_INFO_SLAVE_DATA);
+	ATTR_8(IFLA_BOND_SLAVE_STATE, 0);
+	ATTR_8(IFLA_BOND_SLAVE_MII_STATUS, 0);
+	ATTR_32(IFLA_BOND_SLAVE_LINK_FAILURE_COUNT, 0);
+	ATTR_L(IFLA_BOND_SLAVE_PERM_HWADDR, mac, sizeof(mac));
+	ATTR_16(IFLA_BOND_SLAVE_QUEUE_ID, 0);
+	ATTR_16(IFLA_BOND_SLAVE_AD_AGGREGATOR_ID, 1);
+	ATTR_8(IFLA_BOND_SLAVE_AD_ACTOR_OPER_PORT_STATE, 0x3f);
+	if (c->has_partner)
+		ATTR_16(IFLA_BOND_SLAVE_AD_PARTNER_OPER_PORT_STATE,
+			c->partner_state);
+	NEST_END(slave_data);
+	NEST_END(linkinfo);
+
+	return h->nlmsg_len;
+}
+
+static int write_nlmsg(const char *file, const void *buf, int msglen)
+{
+	FILE *fp;
+
+	fp = fopen(file, "wb");
+	if (!fp) {
+		perror("fopen()");
+		return -1;
+	}
+	if (fwrite(buf, msglen, 1, fp) != 1) {
+		perror("fwrite()");
+		fclose(fp);
+		return -1;
+	}
+	if (fclose(fp)) {
+		perror("fclose()");
+		return -1;
+	}
+	return 0;
+}
+
 int main(void)
 {
 	char buf[16384] = { 0 };
+	unsigned int i;
 	int msglen;
-	FILE *fp;
 
 	msglen = fill_vf_rate_test(buf, sizeof(buf));
 	if (msglen < 0) {
 		fprintf(stderr, "fill_vf_rate_test() failed!\n");
 		return 1;
 	}
-	fp = fopen("tests/ip/link/dev_wo_vf_rate.nl", "w");
-	if (!fp) {
-		perror("fopen()");
-		return 1;
-	}
-	if (fwrite(buf, msglen, 1, fp) != 1) {
-		perror("fwrite()");
+	if (write_nlmsg("tests/ip/link/dev_wo_vf_rate.nl", buf, msglen))
 		return 1;
+
+	for (i = 0; i < ARRAY_SIZE(bond_slave_cases); i++) {
+		const struct bond_slave_case *c = &bond_slave_cases[i];
+
+		msglen = fill_bond_slave_test(buf, sizeof(buf), c);
+		if (msglen < 0) {
+			fprintf(stderr, "fill_bond_slave_test(%s) failed!\n",
+				c->file);
+			return 1;
+		}
+		if (write_nlmsg(c->file, buf, msglen))
+			return 1;
 	}
-	fclose(fp);
 	return 0;
 }
-- 
2.55.0

