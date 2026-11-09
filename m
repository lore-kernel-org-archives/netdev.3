Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.27.60.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794229919;
	b=dJyBk5ZR+YdyK4wNJIZMr9U32zp6lgSvWp0nglJtW/18u5YMjsymqiB7oE1la2bVoUys
	 jIRpqFsi2bqZ7G2T4SohwtXSJfV41NNOa/hcvGe9fmNPCE50XhtZdByeoa3FIRUMcw6ms
	 b3CUarC00XuPMuMTty4pfL1Tvr1bb6LYXSZuYYFdt5GarZihDSgQSIG5gx/w4UybJe96e
	 1UILRoAVaZoH9Qv/GjFxdFAGs6Yq659H9xKAqc25u1dmij/U1kHGPL3G/g90+EPzrUiAy
	 gtWtE7bELAVoHXM0Ym+F3/V/0gUiIN+nN7mK8F0racVlNUFUUE7+aU3eAhN68DXJXhA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794229919;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=8xMyqUkEzpX897kCOiJ2SKQ/j8Jqv8CNetpwMmDB10Q=;
	b=DiTFFYHB4UeWrbpoVqbnlWNLRqLLpUkfalo7lpLCfs1HWTnn+954TUKtjhj9O+ilow0r
	 HGwIT893XF3eq0xDCY4xmqvWDxlcl+k8thIA+X1+ISEWb/pmILYohP6EAkPMx8jrwtHww
	 imp6R1/Gm7j4CpnjyuNUPtCXl2m4kciXmz56gyS0u1xtPk8FrD5JFgeNb1LBE3arb4Drk
	 2R/OuFK412ev03g4KzLKd+NtLNo1+GM59xS54U8gqpwmxphQY1wWCZZfO3G68gkn4rWMo
	 B8DRIk9CEFDUzYwe7rdyMMo0hmxxa9fnca7A6FX21XwCHWmNUCLdG7fCOO2MrMYPXZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=corp.free.fr;
	spf=pass smtp.mailfrom=corp.free.fr;
	dkim=pass header.d=corp.free.fr header.i=@corp.free.fr header.a=rsa-sha256 header.s=rcs header.b=bdzbbCOz;
	arc=none smtp.remote-ip=212.27.60.169
Received: from rcs.proxad.net (rcs.proxad.net [212.27.60.169])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4DD4606A32A
	for <netdev@vger.kernel.org>; Mon,  9 Nov 2026 13:11:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E4DD4606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=corp.free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=corp.free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=corp.free.fr header.i=@corp.free.fr header.a=rsa-sha256 header.s=rcs header.b=bdzbbCOz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=corp.free.fr; s=rcs;
	t=1794229917; bh=nFC3nm7n6xyUMkliU/XCdv51X+x/Xg3CFO/dUQVPsF8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bdzbbCOz0AQSyUreclQwTq1UlV14nD9cqQOXUIk29x45sA23oib49qy9VYcDSw4FS
	 aVHTnzxcRotKtSxa4pInjXsSkEjxNKCBmQ5TZKDw7fesKy8P7sX7JaaYbS9EiJQa7v
	 Pu5e8Dtn5YJRSDDm1+6BxOjxrqGgGdzVqkiDX9yoS0Ec+k4yFFxrQ8fSIjQrOViAL4
	 m+HuVddAam19KFkLA23m8YraCcEEZl1vxUF9bVh8q/RsbnaZOkhltzpXN1XKG3aF7d
	 GyQF6LQs47u07L9vm1uKW66ptu0bJ2ejI4xCktzEsN9V9uvoR+pNQXgEzA2xXG6QXf
	 isKR3BN4LtNaA==
Received: from lnxos-dev.home (82-66-150-212.subs.proxad.net [82.66.150.212])
	by rcs.proxad.net (Postfix) with ESMTPSA id 18CF544C11B9;
	Mon,  9 Nov 2026 14:11:57 +0100 (CET)
From: Alexandre Cassen <acassen@corp.free.fr>
To: David Ahern <dsahern@kernel.org>
Cc: Stephen Hemminger <stephen@networkplumber.org>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	netdev@vger.kernel.org
Subject: [PATCH iproute2-next 2/2] flower: support a mask on enc_key_id
Date: Mon,  9 Nov 2026 14:11:48 +0100
Message-ID: <20261109131151.960789-3-acassen@corp.free.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261109131151.960789-1-acassen@corp.free.fr>
References: <20261109131151.960789-1-acassen@corp.free.fr>
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

A block of tunnel keys takes one filter per key. Add a mask:

  enc_key_id 0x40000000/0xc0000000

The key also accepts a 0x prefix. A plain number stays decimal. The dump
prints a partial mask.

Signed-off-by: Alexandre Cassen <acassen@corp.free.fr>
---
 man/man8/tc-flower.8 | 15 +++++++++++----
 tc/f_flower.c        | 41 ++++++++++++++++++++++-------------------
 tc/tc_util.c         | 12 ++++++++++++
 tc/tc_util.h         |  2 ++
 4 files changed, 47 insertions(+), 23 deletions(-)

diff --git a/man/man8/tc-flower.8 b/man/man8/tc-flower.8
index 3f8ba465..d64873b5 100644
--- a/man/man8/tc-flower.8
+++ b/man/man8/tc-flower.8
@@ -80,7 +80,7 @@ flower \- flow based traffic control filter
 .BR arp_tha " | " arp_sha " } "
 .IR MASKED_LLADDR " | "
 .B enc_key_id
-.IR KEY-ID " | {"
+.IR MASKED_KEY_ID " | {"
 .BR enc_dst_ip " | " enc_src_ip " } { "
 .IR ipv4_address " | " ipv6_address " } | "
 .B enc_dst_port
@@ -407,7 +407,7 @@ provided in LLADDR format, in which case it is a bitwise mask, or as a
 number of high bits to match. If the mask is missing then a match on all
 bits is assumed.
 .TP
-.BI enc_key_id " NUMBER"
+.BI enc_key_id " MASKED_KEY_ID"
 .TQ
 .BI enc_dst_ip " PREFIX"
 .TQ
@@ -468,8 +468,15 @@ Match the connection zone, and can be masked.
 .TQ
 .BI pfcp_opts " OPTIONS"
 Match on IP tunnel metadata. Key id
-.I NUMBER
-is a 32 bit tunnel key id (e.g. VNI for VXLAN tunnel).
+.I MASKED_KEY_ID
+is a 32 bit tunnel key id (e.g. VNI for VXLAN tunnel), in decimal or in
+hexadecimal with a 0x prefix. A mask may be optionally provided to limit the
+bits which are matched. A mask is provided by following the value with a slash
+and then the mask. If the mask is missing then a match on all bits is assumed.
+Some drivers also offload the key id on a physical port, where nothing
+decapsulates the packet and the hardware reads the key from its tunnel header.
+Such a filter has no software equivalent and may require
+.BR skip_sw .
 .I PREFIX
 must be a valid IPv4 or IPv6 address optionally followed by a slash and the
 prefix length. If the prefix is missing, \fBtc\fR assumes a full-length
diff --git a/tc/f_flower.c b/tc/f_flower.c
index 6fc2c6a1..54643fd7 100644
--- a/tc/f_flower.c
+++ b/tc/f_flower.c
@@ -88,7 +88,7 @@ static void explain(void)
 		"			arp_sha MASKED-LLADDR |\n"
 		"			enc_dst_ip [ IPV4-ADDR | IPV6-ADDR ] |\n"
 		"			enc_src_ip [ IPV4-ADDR | IPV6-ADDR ] |\n"
-		"			enc_key_id [ KEY-ID ] |\n"
+		"			enc_key_id [ MASKED-KEY-ID ] |\n"
 		"			enc_tos MASKED-IP_TOS |\n"
 		"			enc_ttl MASKED-IP_TTL |\n"
 		"			geneve_opts MASKED-OPTIONS |\n"
@@ -925,16 +925,25 @@ err:
 	return err;
 }
 
-static int flower_parse_key_id(const char *str, int type, struct nlmsghdr *n)
+static int flower_parse_key_id(char *str, int type, int mask_type,
+			       struct nlmsghdr *n)
 {
-	int ret;
-	__be32 key_id;
+	__be32 key_id, mask = htonl(UINT32_MAX);
+	char *slash;
+
+	slash = strchr(str, '/');
+	if (slash)
+		*slash = '\0';
+
+	/* A plain number stays decimal, as it was before masks */
+	if (get_be32(&key_id, str, strncmp(str, "0x", 2) ? 10 : 16) ||
+	    (slash && get_be32(&mask, slash + 1, 0)))
+		return -1;
 
-	ret = get_be32(&key_id, str, 10);
-	if (!ret)
-		addattr32(n, MAX_MSG, type, key_id);
+	addattr32(n, MAX_MSG, type, key_id);
+	addattr32(n, MAX_MSG, mask_type, mask);
 
-	return ret;
+	return 0;
 }
 
 static int flower_parse_enc_port(char *str, int type, struct nlmsghdr *n)
@@ -2193,7 +2202,9 @@ static int flower_parse_opt(const struct filter_util *qu, char *handle,
 		} else if (matches(*argv, "enc_key_id") == 0) {
 			NEXT_ARG();
 			ret = flower_parse_key_id(*argv,
-						  TCA_FLOWER_KEY_ENC_KEY_ID, n);
+						  TCA_FLOWER_KEY_ENC_KEY_ID,
+						  TCA_FLOWER_KEY_ENC_KEY_ID_MASK,
+						  n);
 			if (ret < 0) {
 				fprintf(stderr, "Illegal \"enc_key_id\"\n");
 				return -1;
@@ -2662,15 +2673,6 @@ static void flower_print_ct_mark(struct rtattr *attr,
 	print_masked_u32("ct_mark", attr, mask_attr, true);
 }
 
-static void flower_print_key_id(const char *name, struct rtattr *attr)
-{
-	if (!attr)
-		return;
-
-	print_nl();
-	print_uint_indent_name_value(name, rta_getattr_be32(attr));
-}
-
 static void flower_print_geneve_opts(const char *name, struct rtattr *attr,
 				     char *strbuf)
 {
@@ -3281,7 +3283,8 @@ static int flower_print_opt(const struct filter_util *qu, FILE *f,
 			     tb[TCA_FLOWER_KEY_ENC_IPV6_SRC],
 			     tb[TCA_FLOWER_KEY_ENC_IPV6_SRC_MASK]);
 
-	flower_print_key_id("enc_key_id", tb[TCA_FLOWER_KEY_ENC_KEY_ID]);
+	print_masked_be32("enc_key_id", tb[TCA_FLOWER_KEY_ENC_KEY_ID],
+			  tb[TCA_FLOWER_KEY_ENC_KEY_ID_MASK], true);
 
 	flower_print_port("enc_dst_port", tb[TCA_FLOWER_KEY_ENC_UDP_DST_PORT],
 			  tb[TCA_FLOWER_KEY_ENC_UDP_DST_PORT_MASK]);
diff --git a/tc/tc_util.c b/tc/tc_util.c
index 45d76e75..291f0d9e 100644
--- a/tc/tc_util.c
+++ b/tc/tc_util.c
@@ -940,6 +940,18 @@ void print_masked_be16(const char *name, struct rtattr *attr,
 			  mask_attr, newline);
 }
 
+static __u32 __rta_getattr_be32_u32(const struct rtattr *attr)
+{
+	return rta_getattr_be32(attr);
+}
+
+void print_masked_be32(const char *name, struct rtattr *attr,
+		       struct rtattr *mask_attr, bool newline)
+{
+	print_masked_type(UINT32_MAX, __rta_getattr_be32_u32, name, attr,
+			  mask_attr, newline);
+}
+
 void print_ext_msg(struct rtattr **tb)
 {
 	if (!tb[TCA_EXT_WARN_MSG])
diff --git a/tc/tc_util.h b/tc/tc_util.h
index 8ebca396..e46696a9 100644
--- a/tc/tc_util.h
+++ b/tc/tc_util.h
@@ -135,6 +135,8 @@ void print_masked_u8(const char *name, struct rtattr *attr,
 		     struct rtattr *mask_attr, bool newline);
 void print_masked_be16(const char *name, struct rtattr *attr,
 		       struct rtattr *mask_attr, bool newline);
+void print_masked_be32(const char *name, struct rtattr *attr,
+		       struct rtattr *mask_attr, bool newline);
 
 void print_ext_msg(struct rtattr **tb);
 #endif
-- 
2.47.3

