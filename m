Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792442330;
	b=uta9YR6m3loCJPhKSLXmq0cPUZZXIav8OBKBarJzKXIr4KYBn6xNFqnR9h9vwl1f7OS5
	 6MaGo40PKiUzicGMp+jnLHKUraymJThrbmFrYi+mP80pdRAxfAcQOazeCGzbnLAhNDiqz
	 /Q82uTYBcith9PP1vXMp76BhV97rAbD7lpH2Ft8vyAu96WvDF+StZJylJNEINb7UJtcRN
	 AkX6FysAouHzWpx8ewKnyDJTuZNokxHbIPch/ReSBR3FNn3Deln24hH4I5x+8y7adyprY
	 4BeOAeTvuhO6nWoz9cPNJEIZlknvbyIdL7kzTRcFiIsqGwviJ92rNZSL4Eo6iSnUFVw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792442330;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=L4xQEXhQxwy4NyswnjGyhdjaZptT7RD0HRVJS5amfb4=;
	b=pTY3BEiPvvel/5MxzmflnBfbIA9bZfx6wqBduSUiaQtRK88Xs0UsUmGLQ0orVm462cLm
	 Vz2aGokyyf1aLugvQqU8MHGMHoBAX0S/YXEd2HHJxEWcVTaMQQsVnWujy1KHKq2QiA91K
	 BX3Qi51vWuR7MJYKgjZP8m9wduGqdlsLYkCpXXb6inR4Ya9073dhDnOOR4eCDbmi/0wP9
	 Vx4TYBwhk97mMz2VEOmGynmp3+Wq9bIwJ3XM+f32HvQ5mW0PZSum8HpsMxsaZXE278vAG
	 VisriIkB1MKlwtQOlyCHonLS29Le7c2SMadH9kvi+Hn3Tm0sL8bTfx1sAcsdQbONLAQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="AChDcV/M";
	arc=none smtp.remote-ip=74.125.82.47
Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A9B8606A326
	for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 20:38:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2A9B8606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=AChDcV/M
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-1517bda04a0so2038110c88.0
        for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 13:38:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792442329; x=1793047129; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=L4xQEXhQxwy4NyswnjGyhdjaZptT7RD0HRVJS5amfb4=;
        b=AChDcV/MhWt9KeEHc8w5xRHy/zkViJjoxQHM5w5h1k1v0phU7AkNVOSkDt41foSK4H
         OQZmbu88NT1qJSUw2A4c/F3//PoOmUqYaZJMR2alTx4SBf0YMkIQuFKlru0Fe5QJYz12
         YLV42itVYGZ6bcIePO6OPFiuV1PT0lO0d0TR/jEwpFnoSaPcMmUC3VLwvHQvcl/LDhal
         UCzofQV1LmhR6wyGsMFBJNRgURuIdM16ct8f8wrjvz6V29UcUpT+schn3TUyJMzED/gb
         mvuW28cOvgqyXYyzITn9cDTiqAikmn4e2KPyd++/PM49wEAkgr/UgdOeoJFEv2eieom/
         ZwTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792442329; x=1793047129;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=L4xQEXhQxwy4NyswnjGyhdjaZptT7RD0HRVJS5amfb4=;
        b=gHUbCDYufisyEiJVf4qMIekLXf8QTCZiqnIoZGyUN5b07BxCb1eUKEpNWkRRmlRTR+
         q8nDx1UBBkrvpItz9CNssMYoosaAc1JNCCoT5WE4lTrkuzplJHlwho4VXDdRbEsBVW0c
         6PM0wyA1d8qcpUExytpD9iD6Yf9B5gMe9+7igYFVfs2zgBlDzNvM7YI7obpzZ22xcGSP
         WT1eWwTqV+zcn9sAAPCVTsbwlGPk5xV/RCHf70w30KpdXm5exZXs8DFGBvY8ruF5lMHS
         1bSercWejiqEb6uL/0lmCQGhEKYp+WeBMHAdd+ywsRRNZKcEo4e1pzHw0nNubT9pnvgU
         UtSg==
X-Gm-Message-State: AFq9FYLqXw6yKlPbu9CJaUzki++xv8GgcWUDGb6Ayc8nDZSxvN95mvsc
	29LmBVCd0fVdEkxluA2PAfQEzo/e7h4RtJ42BJIPzw183I8LucasS9spLe8wyg==
X-Gm-Gg: AYBFou3IjU16xIKo0AECOwExti8p/O20sU1Zl3tXMfp5tpBwrjoxj4y+Zeh5H6wq+pk
	DIZ6MFkjgQ+AoiBUyujiLgrpkUjTFpTXCYgssJbOxk7SY0vcbKq4YP4MinJ1LqgDbY0PTBsPXOt
	9irnmewy5riN1Q4BKvlnuR2h1sPrFbDFyPRYQ8/jvLn7KgYI/wCDEqoF77i58ldPwv+drEo+0PG
	2He4kVB+02l77+kAuZ8vAhORMvoncThDIebcOE8+uw76qaS75EMp2O6T8qtCP9OcrWBgzV4Uqu8
	JAbGgBkQ/Tz9I4TIR+isD+/s5JQWlatnIy9+rCe3iHEY/TuujZm6zqvKAmbY8C8TcyTckNvvt83
	9b3gkooMhd6iWx2lWvhdMLt7hF+EVsp1+L/e2Sue9Jj/SEh7PgYl6+sDn73HtKw9vsLN5Nwlaqs
	p/kHYfCFhhGczZed+YFP7VsgVZAAsjPf1fvapjlQ2zAIObPLfFSo12BzUx7RGr4PkV60YZN+fHA
	DReBc7V0TfgADsmRP1BSFiybHVTPU0HII8OLENtvgrVazuFejSP8/eED3k/XFwkJs+wUdsKSpMT
	HXlaX4wb4qTzls8=
X-Received: by 2002:a05:701b:465f:10b0:15d:f053:18b6 with SMTP id a92af1059eb24-1851160d00amr11610613c88.9.1792442329100;
        Mon, 19 Oct 2026 13:38:49 -0700 (PDT)
Received: from l ([2603:8002:ea00:6800:7440:7d9b:b57c:b3ae])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-183190aa411sm35138806c88.4.2026.10.19.13.38.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 13:38:48 -0700 (PDT)
From: Dave Seddon <dave.seddon.ca@gmail.com>
To: netdev@vger.kernel.org
Cc: Dave Seddon <dave.seddon.ca@gmail.com>,
	Stephen Hemminger <stephen@networkplumber.org>,
	David Ahern <dsahern@kernel.org>
Subject: [PATCH iproute2 v2 3/3] testsuite: add bond slave LACP port state test
Date: Mon, 19 Oct 2026 13:38:43 -0700
Message-ID: <20261019203843.3127235-4-dave.seddon.ca@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261019203843.3127235-1-dave.seddon.ca@gmail.com>
References: <20261019203843.3127235-1-dave.seddon.ca@gmail.com>
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

Decode generated bond slave messages with ip -d monitor file.
Use a synthetic partner state of 0x0100 to catch a u8 reader on
either endianness. Also check normal and zero states, actor state
output, and an absent partner attribute.

Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Dave Seddon <dave.seddon.ca@gmail.com>
---
 .gitignore                                    |   2 +-
 testsuite/Makefile                            |   2 +-
 .../ip/link/show_bond_slave_lacp_state.t      |  26 +++++
 testsuite/tools/generate_nlmsg.c              | 103 ++++++++++++++++--
 4 files changed, 122 insertions(+), 11 deletions(-)
 create mode 100755 testsuite/tests/ip/link/show_bond_slave_lacp_state.t

diff --git a/.gitignore b/.gitignore
index e5234a3d..48064c45 100644
--- a/.gitignore
+++ b/.gitignore
@@ -38,4 +38,4 @@ series
 testsuite/results
 testsuite/iproute2/iproute2-this
 testsuite/tools/generate_nlmsg
-testsuite/tests/ip/link/dev_wo_vf_rate.nl
+testsuite/tests/ip/link/*.nl
diff --git a/testsuite/Makefile b/testsuite/Makefile
index fb50f618..82f3f98c 100644
--- a/testsuite/Makefile
+++ b/testsuite/Makefile
@@ -47,7 +47,7 @@ testclean:
 
 clean: testclean
 	@rm -f iproute2/iproute2-this
-	@rm -f tests/ip/link/dev_wo_vf_rate.nl
+	@rm -f tests/ip/link/*.nl
 	$(MAKE) -C tools clean
 
 distclean: clean
diff --git a/testsuite/tests/ip/link/show_bond_slave_lacp_state.t b/testsuite/tests/ip/link/show_bond_slave_lacp_state.t
new file mode 100755
index 00000000..71c6f0bc
--- /dev/null
+++ b/testsuite/tests/ip/link/show_bond_slave_lacp_state.t
@@ -0,0 +1,26 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+
+. lib/generic.sh
+
+# suffix|description|expected regex (leading ! = must not match)
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
index 106dca63..7cb9689b 100644
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
 
+/* 0x0100 catches a u8 reader on either endianness */
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

