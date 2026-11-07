Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794023316;
	b=C11y8G4KQ8xN0AW3SjkZuYqJYySDdYeWkfDkxk8xupHsesRqjrBUS7Z5bjz5n5nekanC
	 MmQlNqRF7+BgpqDZuuWbyHojgWg5mH+Av633II7SsgVDLGshJnCbeDKNvF2muYDxhxW8a
	 6ADaf+0kh+IJzBLk6Hp1qRaQN4Jd/wjm5n4QHPxaMtWF+r91gtt4WEWR0lpJr4/mSzjSJ
	 9jpMdr0vDGn0WCfvSNKcGV8HSxglPx6FdvVgz797ENzvBaJLsAnIs5b2FFND3igNAOIdF
	 kMoPO6JNj8ScpG+LmnjKi8mkMImG0c3kco7/Vkc37hha3wTq5SkONLtFkMDTP352Alw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794023316;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=dm6DL4wf2Is67CgUvS9KidbvGCFurB4giMg2DK6VO8E=;
	b=3ZC0UQNZvoKZcUDHEcpZV+sipE096544H+F0j+8m3OenK81WU1JyG1U2+WpGclqDpqog
	 FB1tkT1yykoBVjBZKzRcVJwsa4MzdApY6C81WiLU1cvHBUKDCamJz/R4oR6xMf63LOaDF
	 qk/GJXvaVq9bwGkR47WRbZ7xzAOj5Ax+2b390mSROQWeyXBIdeDRsYQCLQml/xA2R5gL/
	 9YinCLELd3xEzCugqtvVXUF6zG3iWZ5VuUjysajMLCtD5hKmXZbhHteHwSH8qfhNOiWXp
	 QCliMCOFISQeB2GF3EXF7YKO8J049ffW3M1E3T7tvlYMrK4uuNbTNMt1UDCfbWuUN8A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cloudflare.com;
	spf=pass smtp.mailfrom=cloudflare.com;
	dkim=pass header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=c705yWv6;
	arc=none smtp.remote-ip=209.85.208.53
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF5B5606A326
	for <netdev@vger.kernel.org>; Sat,  7 Nov 2026 03:48:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BF5B5606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=c705yWv6
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6b4f7d3cd98so1372753a12.0
        for <netdev@vger.kernel.org>; Fri, 06 Nov 2026 19:48:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1794023314; x=1794628114; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dm6DL4wf2Is67CgUvS9KidbvGCFurB4giMg2DK6VO8E=;
        b=c705yWv6ST2wIHyljQue36BoXzd0Lc9qzeF6sBd9vSV4fcNk+DP8RBWourx8WAoK53
         Wkk7Ndcg6bNs7dkLzitFvY3+DSKz6/4amY8sFXv23O+FU88UEOFTstXwdwmoQmHZVqOQ
         WJPMD2woyfUF7C0tDk/38Z2L2nO5AAc+0zwW0JTzeqmYQEVMeyi38A1xz77jT3TMh5Ko
         vMZ9ID20H1AJNxjDL2o0i6Y4QjFH7/dsIH8HL9o4zVSVhLGKw9dXrxNBIQYOtmiH0CCZ
         IHKOo+ENQXJHVvPAYRQLhP5w3TWlxyZwUbgE294NNFJmv/zLi/AJ1mxhcTVpw/szPjgL
         Yi2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794023314; x=1794628114;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=dm6DL4wf2Is67CgUvS9KidbvGCFurB4giMg2DK6VO8E=;
        b=DvuWjod2qyxUBFs99bJrlMrQOZCL6tLai+oFNU31Pz1m2WB1jLVFeuXnsZmrXCQTh6
         cz4HXtA0yd48y0ZIBjtfcyRv7F8pcdoDNTAzsyXKe99sWWvK0iM7TSqzJY+oO4+OdHjb
         12I0NfSMD/39mnf+FK/oBFXZg8jAxiXtBAy8h6CBJl7fzdI6x2UGu1NjmxF6yKbBv73w
         TMEGgknKGTp9B//0HZ7yIY5Si0ixTsu8QONOCc5x8vQ4Drnk87pSCr3mdXyiBT06ARaa
         UCVn0WOvLZPiAHbvuw6aw11Y9UnHp6JDAf58XYKf1ZA0vUfJbHI1MHOExFvTjMEQnu+r
         DU9Q==
X-Gm-Message-State: APuU4Z8jH/WoaRlTobD7al9mWOKmv8a9cA5uWN/Px7l3iG9zQ+iSjnfI
	vNARwr6k3eAhA74NXXRF2QRIPwCD2h2/y4R20+Ubdz60cDYSa27MY7BRvCqgPwrLOPH4HGustpX
	O/D3A/no=
X-Gm-Gg: AYBFou3oH0x2hFuR0/3X47L4Tt3qWKxF0VO1WIeAFP0CCPOlRHYQZWkcspX67EzMHQd
	OjBYH3MOMrhNkk9uJvmXOaGWJG+Y++m78zgf88Fg03sXLLGq5+OdXBUNEjPH7rTrD6I+FT5GzWp
	HOUYe3rD1f+ujGhVLc284fXST59LCt3MbVZXU1zJEiXQGE2UnK2t3mGl1tpsRhlceUGm/e2W81B
	hhhNyd7SW9NQBcWIVI9Bfz6RNGs9iAdY9fLlPpog9Ra5IhJqE+EySVT4C8W+P5vTiOQtR9BLY73
	MGOl3SMYKXKOSrR1lxowdauM75te57HdQwhJ4tsiIdIhryHD9aENrqcXAG9CoE6h1/at++pC/xn
	WwC+srZ+KhM9eXEMXGuVuE/l3oKILDw/UBVgiTWKcOJA0HJgKXfvDjU7cIWl7bAQdlHemZmsihx
	d97OpMU/dDmjcItobHsUk7FPiu6+1wQReTKsT+z9Y6VVDz5UnnXpEgQ4CXTMAW/e8fVNWDFIosA
	m6zNHf1/HKSxrYcKy7k9G/0K/RMW2dRHAWLkjSU19B1n4DtVDwS2APxh027LcU5OvtHpMJIidGP
	sCiP/+OGvyggVaX2ZTWyJcLBOHHFOfZ0YBK202IOGkF8wkm2H761/ydTMKKs9I4VB1wUMss+gsT
	S7XMfUpYL
X-Received: by 2002:a05:6402:27d3:b0:6b4:5909:138d with SMTP id 4fb4d7f45d1cf-6b5977c7402mr3068392a12.20.1794023314236;
        Fri, 06 Nov 2026 19:48:34 -0800 (PST)
Received: from L9JK9NPFH9.lan ([104.28.20.56])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b664afe901sm1403428a12.24.2026.11.06.19.48.31
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 06 Nov 2026 19:48:32 -0800 (PST)
From: Tianyi Gao <tianyi@cloudflare.com>
To: netdev@vger.kernel.org
Cc: David Ahern <dsahern@kernel.org>,
	Stephen Hemminger <stephen@networkplumber.org>,
	David Keogh <dkeogh@amazon.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	kernel-team@cloudflare.com,
	nh-open-source@amazon.com,
	Tianyi Gao <tianyi@cloudflare.com>
Subject: [PATCH iproute2-next 2/2] iplink: add tx_extra_headroom attribute
Date: Sat,  7 Nov 2026 03:48:20 +0000
Message-ID: <8b0703db9f83b8493ce44b3b25f66669ff171857.1794022936.git.tianyi@cloudflare.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1794022936.git.tianyi@cloudflare.com>
References: <cover.1794022936.git.tianyi@cloudflare.com>
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

Add support for IFLA_TX_EXTRA_HEADROOM, which sets and reports the
extra TX headroom of a device.

$ ip link add veth0 tx_extra_headroom 256 type veth peer name veth1 tx_extra_headroom 256
$ ip -details link show veth0
12: veth0@veth1: <BROADCAST,MULTICAST,M-DOWN> mtu 1500 qdisc noop state DOWN mode DEFAULT group default qlen 1000
    link/ether 22:5d:72:d3:f4:43 brd ff:ff:ff:ff:ff:ff promiscuity 0 allmulti 0 minmtu 68 maxmtu 65535
    veth addrgenmode eui64 numtxqueues 8 numrxqueues 8 gso_max_size 65536 gso_max_segs 65535 tso_max_size 524280 tso_max_segs 65535 gro_max_size 65536 gso_ipv4_max_size 65536 gro_ipv4_max_size 65536 tx_extra_headroom 256

Signed-off-by: Tianyi Gao <tianyi@cloudflare.com>
---
 ip/ipaddress.c        |  6 ++++++
 ip/iplink.c           | 10 ++++++++++
 man/man8/ip-link.8.in | 13 +++++++++++++
 3 files changed, 29 insertions(+)

diff --git a/ip/ipaddress.c b/ip/ipaddress.c
index ff85792f..8442e5cb 100644
--- a/ip/ipaddress.c
+++ b/ip/ipaddress.c
@@ -1238,6 +1238,12 @@ int print_linkinfo(struct nlmsghdr *n, void *arg)
 				   "gro_ipv4_max_size %u ",
 				   rta_getattr_u32(tb[IFLA_GRO_IPV4_MAX_SIZE]));
 
+		if (tb[IFLA_TX_EXTRA_HEADROOM])
+			print_uint(PRINT_ANY,
+				   "tx_extra_headroom",
+				   "tx_extra_headroom %u ",
+				   rta_getattr_u32(tb[IFLA_TX_EXTRA_HEADROOM]));
+
 		if (tb[IFLA_PHYS_PORT_NAME])
 			print_string(PRINT_ANY,
 				     "phys_port_name",
diff --git a/ip/iplink.c b/ip/iplink.c
index c6aee8b6..079b4a63 100644
--- a/ip/iplink.c
+++ b/ip/iplink.c
@@ -124,6 +124,7 @@ void iplink_usage(void)
 		"		[ protodown_reason PREASON { on | off } ]\n"
 		"		[ gso_max_size BYTES ] [ gso_ipv4_max_size BYTES ] [ gso_max_segs PACKETS ]\n"
 		"		[ gro_max_size BYTES ] [ gro_ipv4_max_size BYTES ]\n"
+		"		[ tx_extra_headroom BYTES ]\n"
 		"\n"
 		"	ip link show [ DEVICE | group GROUP ] [ { up | down } ] [master DEV] [vrf NAME]\n"
 		"		[type TYPE] [nomaster] [ novf ]\n"
@@ -1247,6 +1248,15 @@ int iplink_parse(int argc, char **argv, struct iplink_req *req, char **type)
 				       *argv);
 			addattr32(&req->n, sizeof(*req),
 				  IFLA_GRO_IPV4_MAX_SIZE, max_size);
+		} else if (strcmp(*argv, "tx_extra_headroom") == 0) {
+			__u32 headroom;
+
+			NEXT_ARG();
+			if (get_u32(&headroom, *argv, 0))
+				invarg("Invalid \"tx_extra_headroom\" value\n",
+				       *argv);
+			addattr32(&req->n, sizeof(*req),
+				  IFLA_TX_EXTRA_HEADROOM, headroom);
 		} else if (strcmp(*argv, "parentdev") == 0) {
 			NEXT_ARG();
 			addattr_l(&req->n, sizeof(*req), IFLA_PARENT_DEV_NAME,
diff --git a/man/man8/ip-link.8.in b/man/man8/ip-link.8.in
index 719781bd..976d546e 100644
--- a/man/man8/ip-link.8.in
+++ b/man/man8/ip-link.8.in
@@ -48,6 +48,9 @@ ip-link \- network device configuration
 .RB "[ " gro_ipv4_max_size
 .IR BYTES " ]"
 .br
+.RB "[ " tx_extra_headroom
+.IR BYTES " ]"
+.br
 .RB "[ " netns " {"
 .IR PID " | " NETNSNAME " | " NETNSFILE " } ]"
 .br
@@ -105,6 +108,9 @@ ip-link \- network device configuration
 .RB "[ " gro_ipv4_max_size
 .IR BYTES " ]"
 .br
+.RB "[ " tx_extra_headroom
+.IR BYTES " ]"
+.br
 .RB "[ " name
 .IR NEWNAME " ]"
 .br
@@ -514,6 +520,13 @@ specifies the maximum size of a IPv4 packet built by GRO stack on this
 device. This is especially used for BIG TCP to allow the size of a
 merged IPv4 GSO packet on this device greater than 65536.
 
+.TP
+.BI tx_extra_headroom " BYTES "
+specifies the extra TX headroom that is reserved when a UDP, ping, raw,
+AF_PACKET or AF_XDP (copy mode) socket allocates a packet for this
+device. It avoids a reallocation when a TC egress program adds headers,
+and a copy when generic XDP runs on the peer of a veth device.
+
 .TP
 .BI index " IDX "
 specifies the desired index of the new virtual device. The link
-- 
2.56.0

