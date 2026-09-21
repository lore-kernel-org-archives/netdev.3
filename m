Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDDFC47427E
	for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 10:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789986153; cv=none; b=ei9Id9+Bfbd2PAeqbeD9ksylCEmV7Kv3Fyv7k1jOoRTJcB1i4wPxIv7sKkuvWlu5+SVYi35PhccQAD+LEAYSnkl058orq/FisDYtoJOy9MYzxPgziPGAW0h9KhdyVK0RqavTGIM/3wkVW05kVcQYgTht0SWgv3LbpV7BXNRX0qU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789986153; c=relaxed/simple;
	bh=9o3kT5fTGgSV8kw6ZzE5kGEvxCM/nPBdMOtHig3X7Z4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KIyeVtKJbpbV/YYkYDax4AKx6XujTBgk+s4FtQgvInA30iMacfXV6GEz4LAaLfFjEZflBvihuMAD1aAszun20/2UWrfSyecYlKz2SdBqgK2o5srlb8KwPnQDELq/7Pr8LN7NbsAZIYX3lHiYeD43/hMWGZiCwuDox+cfAcBZLJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=glr7OMB2; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="glr7OMB2"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-4843cedd129so1649496f8f.0
        for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 03:22:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1789986150; x=1790590950; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0pnytvBI5BQuVROOpdmtYv2R2xz15uZU0xGWxxn3wh8=;
        b=glr7OMB2CbcISPVgUxF4JsMqmgF+WCvcn85N58UxGc+VlUaVkvjaMZEgvo5QPSG4LX
         y+6GmMiuWqix4TziGrotEfEltbNiSbYF70j2g5UQy+7To2KezZWYLSDvxduew7UH5QOH
         nIcnN3yeZKm2wLDeYIHVwTsg3Tbs680/vyukJ3YNEFSVhVWKmdD3KazID3W6sfdSY38D
         i1W97viUnjPArsSND+JqXSWRBFEcM881ZIHywd+S+kbUfdTEpcFuDY8f2jBjdMX++L/n
         CHqD7yjiDC7F9vGw/fJXicd21VikU+7qGISjMFD13w6lTTofQjEeAMuLEFvUcjhwY6aD
         Ou3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789986150; x=1790590950;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0pnytvBI5BQuVROOpdmtYv2R2xz15uZU0xGWxxn3wh8=;
        b=RJiWRc73i3MeSS9zZ/dGdmOHxQHhyu5fmrTYMUArDwrg4H9xeQRnh8lqbxyEEzO4Gk
         VZ2BK2xfffac7cBIDIOPQAE7dB4i7qUDWzso3BsCBLIde9vA7C2XNdKJTngF1zsSimaB
         bzoSZ44q/yZB1nEyksP7Kax5eTdOtSgrOxC04hOIgZbJZMBXt7JevhJ7BSrBpxwaYwGu
         sII/P3GRtwrXyxRldzrJLXNHGl0C+774TAs3YkjcFYm0Xeta9jgw2SK1KNblW4bqJGLW
         jkPqR/O4t8IEnZs30BpgIzVaTHfa62n6kcMfCpk7IQuthKiu0CcojG/zIaQh0q2DF6/J
         SehA==
X-Gm-Message-State: AFuF++k/AaalKHiaAN39Kr9o3fGuAxW+QOvuI9SfgjcD3OguLjU569BT
	lD2A/pab8fdwh2jEsWTTxZa1uTK7fLaufHT7Qnylfex0SSzdXBecb78/5u+J05+/bt5mXs2Y6DT
	bpgP3atysJUboc9ACLLguGtPNOdmSsaAW9yRanKMsbpDHC41nPHEa8vpklL6nf1WbJOg=
X-Gm-Gg: AYBFou2AIFrDpw8p8wcAoq4CXGK28y2Xwj7DGmYyaq3fiEHiU/We6sN1Zl4eG9ZWPo+
	bV+F6y5ITbHmXCaN2N9HZA3Wlfr0qR4KB1xxU2s7TRnIfF7/CnehnQqHgjO6hbOJbS66mTQQ1cr
	/xm7Vi/9O811L53QPjrlX5TxI1VyuqtHaw9jVRN6APQUkdgesdi6hSzyZwU/grmw0055bamC4xV
	TZqINCbArz+L8EjeKZCrpNsu1pNy8MlKntsL13K6GS8O4A6mDJFU/kQ2PfNfcfZ3l65uM3VTGhd
	HNI16XaV1rDPfFbNVTQOinx9AddTU5M+p+IvqaIAvwzqHhu0ysD86FQcMLYzA7y7lu8veLnjKED
	BNuocM7RBKvwmbKQ8+VRrLm4EpRFU0b2T8wn6fqqDk50og9KDs7lqS7nMdivFZLTRGHFkUhTs1B
	PqDvA2YsU5BUZ4pc2VL6o9KBa547cfJOYRCIypuw2vry+3sFMf9aUBYbfi6Rl+hxQVBKCPnaEaN
	D+HrbcAgoo=
X-Received: by 2002:a05:6000:2084:b0:487:1266:628c with SMTP id ffacd0b85a97d-4871e20d088mr19066787f8f.2.1789986149992;
        Mon, 21 Sep 2026 03:22:29 -0700 (PDT)
Received: from inifinity.mandelbit.com ([2001:67c:2fbc:1:b03b:2cfc:7208:2ecf])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48724583fffsm20925476f8f.23.2026.09.21.03.22.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 03:22:29 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: Ralf Lici <ralf@mandelbit.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Antonio Quartulli <antonio@openvpn.net>
Subject: [PATCH net 11/11] selftests: ovpn: validate peer VPN addresses
Date: Mon, 21 Sep 2026 12:22:12 +0200
Message-ID: <20260921102215.3599702-12-antonio@openvpn.net>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260921102215.3599702-1-antonio@openvpn.net>
References: <20260921102215.3599702-1-antonio@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ralf Lici <ralf@mandelbit.com>

Exercise peer VPN address validation through both peer creation and
update. Check missing, unspecified, duplicate, multicast, broadcast,
loopback, IPv4-compatible and IPv4-mapped addresses.

Temporarily configure a peer with both address families to verify that
either family can be cleared while the other remains configured, then
restore the original addresses before running the existing traffic
tests.

Extend ovpn-cli peer updates with an optional VPN address and preserve
peer creation errors so the negative tests can observe rejected netlink
requests.

Signed-off-by: Ralf Lici <ralf@mandelbit.com>
Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 tools/testing/selftests/net/ovpn/common.sh  | 13 ++++
 tools/testing/selftests/net/ovpn/ovpn-cli.c | 54 ++++++++++-----
 tools/testing/selftests/net/ovpn/test.sh    | 75 ++++++++++++++++++++-
 3 files changed, 123 insertions(+), 19 deletions(-)

diff --git a/tools/testing/selftests/net/ovpn/common.sh b/tools/testing/selftests/net/ovpn/common.sh
index 2d844eb3aa6e..5e9c81e885e6 100644
--- a/tools/testing/selftests/net/ovpn/common.sh
+++ b/tools/testing/selftests/net/ovpn/common.sh
@@ -136,6 +136,19 @@ ovpn_create_ns() {
 	ip netns add "ovpn_peer${1}"
 }
 
+ovpn_peer_vpn_addr() {
+	local peer="$1"
+	local file
+
+	if [ "${OVPN_PROTO}" == "UDP" ]; then
+		file="${OVPN_UDP_PEERS_FILE}"
+	else
+		file="${OVPN_TCP_PEERS_FILE}"
+	fi
+
+	awk -v peer="${peer}" '$1 == peer {print $NF; exit}' "${file}"
+}
+
 ovpn_setup_ns() {
 	local peer="ovpn_peer${1}"
 	local server_ns="ovpn_peer0"
diff --git a/tools/testing/selftests/net/ovpn/ovpn-cli.c b/tools/testing/selftests/net/ovpn/ovpn-cli.c
index f4effa7580c0..3b612a8a18fe 100644
--- a/tools/testing/selftests/net/ovpn/ovpn-cli.c
+++ b/tools/testing/selftests/net/ovpn/ovpn-cli.c
@@ -650,6 +650,26 @@ static int ovpn_connect(struct ovpn_ctx *ovpn)
 	return ret;
 }
 
+static int ovpn_nl_put_vpn_addr(struct nl_msg *msg,
+				const struct ovpn_ctx *ovpn)
+{
+	if (!ovpn->peer_ip_set)
+		return 0;
+
+	switch (ovpn->peer_ip.in4.sin_family) {
+	case AF_INET:
+		return nla_put_u32(msg, OVPN_A_PEER_VPN_IPV4,
+				   ovpn->peer_ip.in4.sin_addr.s_addr);
+	case AF_INET6:
+		return nla_put(msg, OVPN_A_PEER_VPN_IPV6,
+			       sizeof(struct in6_addr),
+			       &ovpn->peer_ip.in6.sin6_addr);
+	default:
+		fprintf(stderr, "Invalid family for peer address\n");
+		return -EAFNOSUPPORT;
+	}
+}
+
 static int ovpn_new_peer(struct ovpn_ctx *ovpn, bool is_tcp)
 {
 	struct nlattr *attr;
@@ -691,22 +711,9 @@ static int ovpn_new_peer(struct ovpn_ctx *ovpn, bool is_tcp)
 		}
 	}
 
-	if (ovpn->peer_ip_set) {
-		switch (ovpn->peer_ip.in4.sin_family) {
-		case AF_INET:
-			NLA_PUT_U32(ctx->nl_msg, OVPN_A_PEER_VPN_IPV4,
-				    ovpn->peer_ip.in4.sin_addr.s_addr);
-			break;
-		case AF_INET6:
-			NLA_PUT(ctx->nl_msg, OVPN_A_PEER_VPN_IPV6,
-				sizeof(struct in6_addr),
-				&ovpn->peer_ip.in6.sin6_addr);
-			break;
-		default:
-			fprintf(stderr, "Invalid family for peer address\n");
-			goto nla_put_failure;
-		}
-	}
+	ret = ovpn_nl_put_vpn_addr(ctx->nl_msg, ovpn);
+	if (ret)
+		goto nla_put_failure;
 
 	nla_nest_end(ctx->nl_msg, attr);
 
@@ -732,6 +739,10 @@ static int ovpn_set_peer(struct ovpn_ctx *ovpn)
 		    ovpn->keepalive_interval);
 	NLA_PUT_U32(ctx->nl_msg, OVPN_A_PEER_KEEPALIVE_TIMEOUT,
 		    ovpn->keepalive_timeout);
+
+	ret = ovpn_nl_put_vpn_addr(ctx->nl_msg, ovpn);
+	if (ret)
+		goto nla_put_failure;
 	nla_nest_end(ctx->nl_msg, attr);
 
 	ret = ovpn_nl_msg_send(ctx, NULL);
@@ -1730,13 +1741,14 @@ static void usage(const char *cmd)
 	fprintf(stderr, "\tmark: socket FW mark value\n");
 
 	fprintf(stderr,
-		"* set_peer <iface> <peer_id> <keepalive_interval> <keepalive_timeout>: set peer attributes\n");
+		"* set_peer <iface> <peer_id> <keepalive_interval> <keepalive_timeout> [vpnaddr]: set peer attributes\n");
 	fprintf(stderr, "\tiface: ovpn interface name\n");
 	fprintf(stderr, "\tpeer_id: peer ID of the peer to modify\n");
 	fprintf(stderr,
 		"\tkeepalive_interval: interval for sending ping messages\n");
 	fprintf(stderr,
 		"\tkeepalive_timeout: time after which a peer is timed out\n");
+	fprintf(stderr, "\tvpnaddr: peer VPN IP\n");
 
 	fprintf(stderr, "* del_peer <iface> <peer_id>: delete peer\n");
 	fprintf(stderr, "\tiface: ovpn interface name\n");
@@ -2090,6 +2102,8 @@ static int ovpn_run_cmd(struct ovpn_ctx *ovpn)
 			return ret;
 
 		ret = ovpn_new_peer(ovpn, false);
+		if (ret < 0)
+			return ret;
 		ovpn_waitbg();
 		break;
 	case CMD_NEW_MULTI_PEER:
@@ -2331,6 +2345,12 @@ static int ovpn_parse_cmd_args(struct ovpn_ctx *ovpn, int argc, char *argv[])
 				"keepalive interval value out of range\n");
 			return -1;
 		}
+
+		if (argc > 6) {
+			ret = ovpn_parse_remote(ovpn, NULL, NULL, argv[6]);
+			if (ret < 0)
+				return -1;
+		}
 		break;
 	case CMD_DEL_PEER:
 		if (argc < 4)
diff --git a/tools/testing/selftests/net/ovpn/test.sh b/tools/testing/selftests/net/ovpn/test.sh
index 9b5610837032..392109d5e14e 100755
--- a/tools/testing/selftests/net/ovpn/test.sh
+++ b/tools/testing/selftests/net/ovpn/test.sh
@@ -56,6 +56,76 @@ ovpn_prepare_network() {
 	done
 }
 
+ovpn_new_test_peer() {
+	local peer_id="$1"
+
+	shift
+	ip netns exec ovpn_peer0 "${OVPN_CLI}" new_peer tun0 \
+		"${peer_id}" none 65000 10.10.1.2 1 "$@"
+}
+
+ovpn_set_peer_vpn_addr() {
+	ip netns exec ovpn_peer0 "${OVPN_CLI}" set_peer tun0 \
+		"$1" 60 120 "$2"
+}
+
+ovpn_run_vpn_addr_validation() {
+	local addr
+	local peer1_addr4
+	local test_peer_id=$((OVPN_NUM_PEERS + 1))
+	local test_peer_addr6="2001:db8::2"
+	# Do not include 0.0.0.0 or :: here. They are invalid on creation, but
+	# clear one address family on update and are valid if the other remains.
+	local -a invalid_addrs=(
+		"127.0.0.1"
+		"224.0.0.1"
+		"255.255.255.255"
+		"::1"
+		"::192.0.2.1"
+		"::ffff:192.0.2.1"
+		"ff02::1"
+	)
+
+	peer1_addr4=$(ovpn_peer_vpn_addr 1)
+
+	ovpn_cmd_fail "reject peer without VPN address" \
+		ovpn_new_test_peer "${test_peer_id}"
+
+	for addr in "0.0.0.0" "::" "${invalid_addrs[@]}"; do
+		ovpn_cmd_fail "reject new peer VPN address ${addr}" \
+			ovpn_new_test_peer "${test_peer_id}" "${addr}"
+	done
+
+	ovpn_cmd_fail "reject duplicate IPv4 address on peer creation" \
+		ovpn_new_test_peer "${test_peer_id}" "${peer1_addr4}"
+	ovpn_cmd_fail "reject clearing the last peer VPN address" \
+		ovpn_set_peer_vpn_addr 1 0.0.0.0
+
+	for addr in "${invalid_addrs[@]}"; do
+		ovpn_cmd_fail "reject updated peer VPN address ${addr}" \
+			ovpn_set_peer_vpn_addr 1 "${addr}"
+	done
+
+	ovpn_cmd_fail "reject duplicate IPv4 address on peer update" \
+		ovpn_set_peer_vpn_addr 2 "${peer1_addr4}"
+
+	ovpn_cmd_ok "add peer IPv6 address" \
+		ovpn_set_peer_vpn_addr 1 "${test_peer_addr6}"
+	ovpn_cmd_fail "reject duplicate IPv6 address on peer creation" \
+		ovpn_new_test_peer "${test_peer_id}" "${test_peer_addr6}"
+	ovpn_cmd_fail "reject duplicate IPv6 address on peer update" \
+		ovpn_set_peer_vpn_addr 2 "${test_peer_addr6}"
+
+	ovpn_cmd_ok "clear peer IPv4 address" \
+		ovpn_set_peer_vpn_addr 1 0.0.0.0
+	ovpn_cmd_fail "reject clearing the remaining peer IPv6 address" \
+		ovpn_set_peer_vpn_addr 1 ::
+	ovpn_cmd_ok "restore peer IPv4 address" \
+		ovpn_set_peer_vpn_addr 1 "${peer1_addr4}"
+	ovpn_cmd_ok "clear peer IPv6 address" \
+		ovpn_set_peer_vpn_addr 1 ::
+}
+
 ovpn_run_basic_traffic() {
 	local p
 	local header1
@@ -293,15 +363,16 @@ trap ovpn_stage_err ERR
 
 ktap_print_header
 if [ "${OVPN_FLOAT}" == "1" ]; then
-	ktap_set_plan 13
+	ktap_set_plan 14
 else
-	ktap_set_plan 12
+	ktap_set_plan 13
 fi
 
 ovpn_cleanup
 modprobe -q ovpn || true
 
 ovpn_run_stage "setup network topology" ovpn_prepare_network
+ovpn_run_stage "validate peer VPN addresses" ovpn_run_vpn_addr_validation
 ovpn_run_stage "run baseline data traffic" ovpn_run_basic_traffic
 ovpn_run_stage "run LAN traffic behind peer1" ovpn_run_lan_traffic
 [ "${OVPN_FLOAT}" == "1" ] && ovpn_run_stage "run floating peer checks" \
-- 
2.55.0

