Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6068443C0F
	for <netdev@vger.kernel.org>; Wed,  7 Oct 2026 13:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791379858; cv=none; b=sPp4xc+or2P7HGu3rhzDvDRTXAtdx6PPGgpl3Yq+7ssvW6039sCscNHU+ysOlRZ+Hc6uwKDahwtMNIeeD6J8T74Nju89VIi+zAQPj5Bo9IxhM6YGbcgUB2xISCRMlwId8dDprRiduN8wj2Q+KU7deyfPeKWOMzgh5cl93wz2knM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791379858; c=relaxed/simple;
	bh=A+ePr2uCpRmJ5CuFRbbVI6lM5XoQp261IietRp3BMX8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BfKstoTwjNePiu6JNSk3u8B6YtW05JglzYtoSlh5S45tUnRtCB/lZbgQaZXQXo6nZ3ezjXzU4qiw8TA+w3szxHs7+D0KBIvr5GPwbk4NMuwKtL2zdZg2LKd8P5vzDBs01EJ28sUR3WWLqH5MezKf/YFAf9pGqXszQCtt+oQGFPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=f1xcV1IR; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="f1xcV1IR"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4a168355946so16921125e9.0
        for <netdev@vger.kernel.org>; Wed, 07 Oct 2026 06:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1791379833; x=1791984633; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3OWPBhBdV3eTtxs4GNyCWHeQCUbIaphkLFzrThd9A6Q=;
        b=f1xcV1IROwTvyDQDHZQry7U+bJOzMZjOYaVwRkGwqsm+vIq0+RqwIye2NglGg+igd+
         GuWTCnINAZI0iOHj/oFlu7Z33QRr0ut0wCQPyvkDbpgF9/zxxn9SeHtRgHkMrjkk72uG
         0s9cIey9KExbIi4+I1Tlotx2JlGfz+ZrpWZU0vn+4pPtQ54tzkLy+truOQIhvBUqPDt0
         qEA0IfC+gNAUt0ix4ig8FmbaK6kxzzepG3V/LVmXX2SjovPRHbTjq+WQQmVcMXbg3Oq4
         J7fCFmxg1+MEvTjuJ1zbZGuAxG3rCKyx/OXPviwFlkVsSgV8Efbu9etW3ugcWIKkUjiA
         F4kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791379833; x=1791984633;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3OWPBhBdV3eTtxs4GNyCWHeQCUbIaphkLFzrThd9A6Q=;
        b=x+tUEm0gCJ9PUtWg3C3MOPhHlKrhuen7cjFFSVV8KjgSYJ7J2zLGsMmFc8tmiAp6EK
         JhsPQ4WQ2XYc13Fft0ZxzW9EGIW1E49KRwGswBxITv+zlOkkpaEZAifxdLz71xE9/zEc
         h3iHH+40DOCa6vhIUAmzPiRaHbtcfnA89aVJxtykgHYlV+4sb14xhcBeDrNtIi8qX8jg
         q9o2ZlEEfXXfvSGWKDrLgWMED2DUTd4rxTQvLbXw12pGAfEJlGmi3Vof0VpmSEm5uVTc
         ukatsbdhIMpDDmOgp4UTfL3KK7pgTQD2G1/MYMyT4ELELpRpMgvCEulYM25X3Fl6QNGf
         tgYA==
X-Gm-Message-State: AFuF++l1AYBVNv92XusiJJ8NoPgiu0CjhvIJ8GNarkNwK/BaU5Y3kk3T
	eQsrsgPYBSw/gEqAZydG5/Ln9zA2A2Ctwz9p/en4ITtVwB7zaLg6qyjsF+0tmcPvL0gRaNIrcv+
	4YrTSEe5o8dkXWUL2PIZ4vMXXfp5HQ1fOKEbh/z/7jtxhhW9q97gArti2It3kv9X3
X-Gm-Gg: AYBFou3cChmIYQxf8LKSijw+clupQh2GLBkdoQlIrJZlIFa2aFgklqI+nD0POgrSHZC
	RiSFnCUwsU6X4eQCsIS81qxknkB7BLGcTY1/I1qcMQTOULgXsL7wTXb8qla0zJtfvAGF3SJCsGc
	nW5Tk25qtY9AyB93mbe1HONXzznwloLQbWottASx2prs4q0lB5te3dunJ6hhWQSdHd1irhxKje9
	vKcNvYMs174IknKdE0eKJfgWDimz2y8cKrW/brFtzR5eKpQvgPQ7iiicZ/6DHtUCtbeuOSh8e50
	0R817FxSUqWSVq5wZm3gH04tvFr7ioPsm+lHywEWaailSn2UEYnF0GqqLsOMjBwfq/SDi2EqQ/i
	vaEENhNvI3vkwzjZJLi9b2X2FY7exvM8BFSlWd/JnmSKaq7i08Rv3Wl0yR/uZd8+wSw/PTPr5ky
	LZIjwhoRsGWLfJiVDjHdHYl8HinRr5ug35+Sa9rBeS7k4LpCCkHOdG549WyRhv3Reqgv+17yunJ
	fyZpf/6Wj8=
X-Received: by 2002:a05:600c:3b2a:b0:49e:69ff:c6b1 with SMTP id 5b1f17b1804b1-4a180650423mr31170475e9.31.1791379832538;
        Wed, 07 Oct 2026 06:30:32 -0700 (PDT)
Received: from inifinity.mandelbit.com ([2001:67c:2fbc:1:7fc5:5cc8:bac1:5ef3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a17a0fc2e4sm150356145e9.3.2026.10.07.06.30.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 06:30:31 -0700 (PDT)
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
Subject: [PATCH net-next 6/7] ovpn: send peer object along with PEER_DEL_NTF
Date: Wed,  7 Oct 2026 15:30:15 +0200
Message-ID: <20261007133018.1451958-7-antonio@openvpn.net>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261007133018.1451958-1-antonio@openvpn.net>
References: <20261007133018.1451958-1-antonio@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ralf Lici <ralf@mandelbit.com>

OpenVPN userspace needs the final statistics of a disconnecting peer,
but there is currently no way to obtain them. PEER_DEL_NTF carries only
the peer id and the delete reason, and a PEER_GET issued in response to
the notification cannot recover the counters either: ovpn_peer_remove()
unlinks the peer from the lookup tables before emitting the
notification, so ovpn_peer_get_by_id() no longer finds it and the
request fails with -ENOENT.

Include a peer snapshot directly in PEER_DEL_NTF, using the same peer
object format returned by PEER_GET. This makes the last known counters
available to userspace at the only point where they can still be read,
and removes the need for a follow-up request per deleted peer.

Update the ovpn selftest notification fixtures to validate the new
payload while normalizing timing-dependent counters.

Signed-off-by: Ralf Lici <ralf@mandelbit.com>
Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 drivers/net/ovpn/netlink.c                    | 60 ++++++++++++-------
 tools/testing/selftests/net/ovpn/common.sh    | 49 ++++++++++++++-
 .../selftests/net/ovpn/json/peer0-float.json  | 12 ++--
 .../net/ovpn/json/peer0-symm-float.json       | 10 +++-
 .../selftests/net/ovpn/json/peer0-symm.json   |  7 ++-
 .../selftests/net/ovpn/json/peer0.json        | 12 ++--
 .../selftests/net/ovpn/json/peer1-symm.json   |  2 +-
 .../selftests/net/ovpn/json/peer1.json        |  2 +-
 .../selftests/net/ovpn/json/peer2-symm.json   |  2 +-
 .../selftests/net/ovpn/json/peer2.json        |  2 +-
 .../selftests/net/ovpn/json/peer3-symm.json   |  2 +-
 .../selftests/net/ovpn/json/peer3.json        |  2 +-
 .../selftests/net/ovpn/json/peer4-symm.json   |  2 +-
 .../selftests/net/ovpn/json/peer4.json        |  2 +-
 .../selftests/net/ovpn/json/peer5-symm.json   |  2 +-
 .../selftests/net/ovpn/json/peer5.json        |  2 +-
 .../selftests/net/ovpn/json/peer6-symm.json   |  2 +-
 .../selftests/net/ovpn/json/peer6.json        |  2 +-
 18 files changed, 122 insertions(+), 52 deletions(-)
 mode change 120000 => 100644 tools/testing/selftests/net/ovpn/json/peer0-symm-float.json
 mode change 120000 => 100644 tools/testing/selftests/net/ovpn/json/peer0-symm.json

diff --git a/drivers/net/ovpn/netlink.c b/drivers/net/ovpn/netlink.c
index 5432bc2eb8e8..15b6d99474b9 100644
--- a/drivers/net/ovpn/netlink.c
+++ b/drivers/net/ovpn/netlink.c
@@ -626,27 +626,15 @@ int ovpn_nl_peer_set_doit(struct sk_buff *skb, struct genl_info *info)
 	goto unlock;
 }
 
-static int ovpn_nl_send_peer(struct sk_buff *skb, const struct genl_info *info,
-			     const struct ovpn_peer *peer, u32 portid, u32 seq,
-			     int flags)
+static int ovpn_nl_fill_peer(struct sk_buff *skb, const struct genl_info *info,
+			     const struct ovpn_peer *peer)
 {
 	const struct ovpn_bind *bind;
 	struct ovpn_socket *sock;
 	int ret = -EMSGSIZE;
-	struct nlattr *attr;
 	__be16 local_port;
-	void *hdr;
 	int id;
 
-	hdr = genlmsg_put(skb, portid, seq, &ovpn_nl_family, flags,
-			  OVPN_CMD_PEER_GET);
-	if (!hdr)
-		return -ENOBUFS;
-
-	attr = nla_nest_start(skb, OVPN_A_PEER);
-	if (!attr)
-		goto err;
-
 	rcu_read_lock();
 	sock = rcu_dereference(peer->sock);
 	if (!sock) {
@@ -654,7 +642,7 @@ static int ovpn_nl_send_peer(struct sk_buff *skb, const struct genl_info *info,
 		goto err_unlock;
 	}
 
-	if (!net_eq(genl_info_net(info), sock_net(sock->sk))) {
+	if (info && !net_eq(genl_info_net(info), sock_net(sock->sk))) {
 		id = peernet2id_alloc(genl_info_net(info),
 				      sock_net(sock->sk),
 				      GFP_ATOMIC);
@@ -665,26 +653,26 @@ static int ovpn_nl_send_peer(struct sk_buff *skb, const struct genl_info *info,
 	rcu_read_unlock();
 
 	if (nla_put_u32(skb, OVPN_A_PEER_ID, peer->id))
-		goto err;
+		return -EMSGSIZE;
 
 	if (nla_put_u32(skb, OVPN_A_PEER_TX_ID, peer->tx_id))
-		goto err;
+		return -EMSGSIZE;
 
 	if (peer->vpn_addrs.ipv4.s_addr != htonl(INADDR_ANY))
 		if (nla_put_in_addr(skb, OVPN_A_PEER_VPN_IPV4,
 				    peer->vpn_addrs.ipv4.s_addr))
-			goto err;
+			return -EMSGSIZE;
 
 	if (!ipv6_addr_equal(&peer->vpn_addrs.ipv6, &in6addr_any))
 		if (nla_put_in6_addr(skb, OVPN_A_PEER_VPN_IPV6,
 				     &peer->vpn_addrs.ipv6))
-			goto err;
+			return -EMSGSIZE;
 
 	if (nla_put_u32(skb, OVPN_A_PEER_KEEPALIVE_INTERVAL,
 			peer->keepalive_interval) ||
 	    nla_put_u32(skb, OVPN_A_PEER_KEEPALIVE_TIMEOUT,
 			peer->keepalive_timeout))
-		goto err;
+		return -EMSGSIZE;
 
 	rcu_read_lock();
 	bind = rcu_dereference(peer->bind);
@@ -732,14 +720,39 @@ static int ovpn_nl_send_peer(struct sk_buff *skb, const struct genl_info *info,
 			 atomic64_read(&peer->link_stats.tx.bytes)) ||
 	    nla_put_uint(skb, OVPN_A_PEER_LINK_TX_PACKETS,
 			 atomic64_read(&peer->link_stats.tx.packets)))
+		return -EMSGSIZE;
+
+	return 0;
+err_unlock:
+	rcu_read_unlock();
+	return ret;
+}
+
+static int ovpn_nl_send_peer(struct sk_buff *skb, const struct genl_info *info,
+			     const struct ovpn_peer *peer, u32 portid, u32 seq,
+			     int flags)
+{
+	struct nlattr *attr;
+	int ret = -EMSGSIZE;
+	void *hdr;
+
+	hdr = genlmsg_put(skb, portid, seq, &ovpn_nl_family, flags,
+			  OVPN_CMD_PEER_GET);
+	if (!hdr)
+		return -ENOBUFS;
+
+	attr = nla_nest_start(skb, OVPN_A_PEER);
+	if (!attr)
+		goto err;
+
+	ret = ovpn_nl_fill_peer(skb, info, peer);
+	if (ret < 0)
 		goto err;
 
 	nla_nest_end(skb, attr);
 	genlmsg_end(skb, hdr);
 
 	return 0;
-err_unlock:
-	rcu_read_unlock();
 err:
 	genlmsg_cancel(skb, hdr);
 	return ret;
@@ -1273,7 +1286,8 @@ int ovpn_nl_peer_del_notify(struct ovpn_peer *peer)
 	if (nla_put_u32(msg, OVPN_A_PEER_DEL_REASON, peer->delete_reason))
 		goto err_cancel_msg;
 
-	if (nla_put_u32(msg, OVPN_A_PEER_ID, peer->id))
+	ret = ovpn_nl_fill_peer(msg, NULL, peer);
+	if (ret < 0)
 		goto err_cancel_msg;
 
 	nla_nest_end(msg, attr);
diff --git a/tools/testing/selftests/net/ovpn/common.sh b/tools/testing/selftests/net/ovpn/common.sh
index e33b1fe26522..08bb36ba3c80 100644
--- a/tools/testing/selftests/net/ovpn/common.sh
+++ b/tools/testing/selftests/net/ovpn/common.sh
@@ -19,9 +19,52 @@ OVPN_VERBOSE=${OVPN_VERBOSE:-0}
 
 export OVPN_ID_OFFSET=$(( 9 * (OVPN_SYMMETRIC_ID == 0) ))
 
-OVPN_JQ_FILTER='map(if type == "array" then .[] else . end) |
-	map(select(.msg.peer | has("remote-ipv6") | not)) |
-	map(del(.msg.ifindex)) | sort_by(.msg.peer.id)[]'
+# Peer delete notifications include traffic counters whose values depend on
+# timing. zero_attr() sets a counter to zero only when that counter is present,
+# so missing stats still fail the comparison. zero_peer_stats is just the list
+# of counters to normalize. normalize_peer_del_ntf applies that to peer-del-ntf
+# messages and drops transport endpoint details, while leaving other
+# notifications unchanged.
+OVPN_JQ_FILTER='
+	def zero_attr(key):
+		if has(key) then .[key] = 0 else . end;
+
+	def zero_peer_stats:
+		zero_attr("vpn-rx-bytes") |
+		zero_attr("vpn-rx-packets") |
+		zero_attr("vpn-tx-bytes") |
+		zero_attr("vpn-tx-packets") |
+		zero_attr("link-rx-bytes") |
+		zero_attr("link-rx-packets") |
+		zero_attr("link-tx-bytes") |
+		zero_attr("link-tx-packets");
+
+	# Peers also float over IPv6 while the tests run, but those events are
+	# not deterministic in number or ordering and have never been part of
+	# the fixtures: the filter used to drop every notification carrying a
+	# remote-ipv6. That blanket rule cannot be used anymore now that
+	# peer-del-ntf embeds the full peer object, so drop IPv6 floats only.
+	def drop_ipv6_float:
+		select(.name != "peer-float-ntf"
+		       or (.msg.peer | has("remote-ipv6") | not));
+
+	def normalize_peer_del_ntf:
+		if .name == "peer-del-ntf" then
+			.msg.peer |= (
+				del(.["remote-ipv4"], .["remote-ipv6"],
+				    .["remote-ipv6-scope-id"], .["remote-port"],
+				    .["local-ipv4"], .["local-ipv6"],
+				    .["local-port"]) |
+				zero_peer_stats
+			)
+		else . end;
+
+	map(if type == "array" then .[] else . end) |
+	map(del(.msg.ifindex)) |
+	map(drop_ipv6_float) |
+	map(normalize_peer_del_ntf) |
+	sort_by(.msg.peer.id)[]'
+
 OVPN_LAN_IP="11.11.11.11"
 
 declare -A OVPN_TMP_JSONS=()
diff --git a/tools/testing/selftests/net/ovpn/json/peer0-float.json b/tools/testing/selftests/net/ovpn/json/peer0-float.json
index 682fa58ad4ea..9711f2cf9cf6 100644
--- a/tools/testing/selftests/net/ovpn/json/peer0-float.json
+++ b/tools/testing/selftests/net/ovpn/json/peer0-float.json
@@ -1,9 +1,9 @@
 {"name": "peer-float-ntf", "msg": {"ifindex": 0, "peer": {"id": 1, "remote-ipv4": "10.10.1.3", "remote-port": 1}}}
 {"name": "peer-float-ntf", "msg": {"ifindex": 0, "peer": {"id": 2, "remote-ipv4": "10.10.2.3", "remote-port": 1}}}
 {"name": "peer-float-ntf", "msg": {"ifindex": 0, "peer": {"id": 3, "remote-ipv4": "10.10.3.3", "remote-port": 1}}}
-{"name": "peer-del-ntf", "msg": {"ifindex": 0, "peer": {"del-reason": "userspace", "id": 1}}}
-{"name": "peer-del-ntf", "msg": {"ifindex": 0, "peer": {"del-reason": "userspace", "id": 2}}}
-{"name": "peer-del-ntf", "msg": {"ifindex": 0, "peer": {"del-reason": "expired", "id": 3}}}
-{"name": "peer-del-ntf", "msg": {"ifindex": 0, "peer": {"del-reason": "expired", "id": 4}}}
-{"name": "peer-del-ntf", "msg": {"ifindex": 0, "peer": {"del-reason": "expired", "id": 5}}}
-{"name": "peer-del-ntf", "msg": {"ifindex": 0, "peer": {"del-reason": "expired", "id": 6}}}
+{"name": "peer-del-ntf", "msg": {"ifindex": 0, "peer": {"del-reason": "userspace", "id": 1, "tx-id": 10, "vpn-ipv4": "5.5.5.2", "keepalive-interval": 60, "keepalive-timeout": 120, "vpn-rx-bytes": 0, "vpn-rx-packets": 0, "vpn-tx-bytes": 0, "vpn-tx-packets": 0, "link-rx-bytes": 0, "link-rx-packets": 0, "link-tx-bytes": 0, "link-tx-packets": 0}}}
+{"name": "peer-del-ntf", "msg": {"ifindex": 0, "peer": {"del-reason": "userspace", "id": 2, "tx-id": 11, "vpn-ipv4": "5.5.5.3", "keepalive-interval": 60, "keepalive-timeout": 120, "vpn-rx-bytes": 0, "vpn-rx-packets": 0, "vpn-tx-bytes": 0, "vpn-tx-packets": 0, "link-rx-bytes": 0, "link-rx-packets": 0, "link-tx-bytes": 0, "link-tx-packets": 0}}}
+{"name": "peer-del-ntf", "msg": {"ifindex": 0, "peer": {"del-reason": "expired", "id": 3, "tx-id": 12, "vpn-ipv4": "5.5.5.4", "keepalive-interval": 3, "keepalive-timeout": 3, "vpn-rx-bytes": 0, "vpn-rx-packets": 0, "vpn-tx-bytes": 0, "vpn-tx-packets": 0, "link-rx-bytes": 0, "link-rx-packets": 0, "link-tx-bytes": 0, "link-tx-packets": 0}}}
+{"name": "peer-del-ntf", "msg": {"ifindex": 0, "peer": {"del-reason": "expired", "id": 4, "tx-id": 13, "vpn-ipv4": "5.5.5.5", "keepalive-interval": 3, "keepalive-timeout": 3, "vpn-rx-bytes": 0, "vpn-rx-packets": 0, "vpn-tx-bytes": 0, "vpn-tx-packets": 0, "link-rx-bytes": 0, "link-rx-packets": 0, "link-tx-bytes": 0, "link-tx-packets": 0}}}
+{"name": "peer-del-ntf", "msg": {"ifindex": 0, "peer": {"del-reason": "expired", "id": 5, "tx-id": 14, "vpn-ipv4": "5.5.5.6", "keepalive-interval": 3, "keepalive-timeout": 3, "vpn-rx-bytes": 0, "vpn-rx-packets": 0, "vpn-tx-bytes": 0, "vpn-tx-packets": 0, "link-rx-bytes": 0, "link-rx-packets": 0, "link-tx-bytes": 0, "link-tx-packets": 0}}}
+{"name": "peer-del-ntf", "msg": {"ifindex": 0, "peer": {"del-reason": "expired", "id": 6, "tx-id": 15, "vpn-ipv4": "5.5.5.7", "keepalive-interval": 3, "keepalive-timeout": 3, "vpn-rx-bytes": 0, "vpn-rx-packets": 0, "vpn-tx-bytes": 0, "vpn-tx-packets": 0, "link-rx-bytes": 0, "link-rx-packets": 0, "link-tx-bytes": 0, "link-tx-packets": 0}}}
diff --git a/tools/testing/selftests/net/ovpn/json/peer0-symm-float.json b/tools/testing/selftests/net/ovpn/json/peer0-symm-float.json
deleted file mode 120000
index e31a5bd59863..000000000000
--- a/tools/testing/selftests/net/ovpn/json/peer0-symm-float.json
+++ /dev/null
@@ -1 +0,0 @@
-peer0-float.json
\ No newline at end of file
diff --git a/tools/testing/selftests/net/ovpn/json/peer0-symm-float.json b/tools/testing/selftests/net/ovpn/json/peer0-symm-float.json
new file mode 100644
index 000000000000..c94dcc81c80e
--- /dev/null
+++ b/tools/testing/selftests/net/ovpn/json/peer0-symm-float.json
@@ -0,0 +1,9 @@
+{"name": "peer-float-ntf", "msg": {"ifindex": 0, "peer": {"id": 1, "remote-ipv4": "10.10.1.3", "remote-port": 1}}}
+{"name": "peer-float-ntf", "msg": {"ifindex": 0, "peer": {"id": 2, "remote-ipv4": "10.10.2.3", "remote-port": 1}}}
+{"name": "peer-float-ntf", "msg": {"ifindex": 0, "peer": {"id": 3, "remote-ipv4": "10.10.3.3", "remote-port": 1}}}
+{"name": "peer-del-ntf", "msg": {"ifindex": 0, "peer": {"del-reason": "userspace", "id": 1, "tx-id": 1, "vpn-ipv4": "5.5.5.2", "keepalive-interval": 60, "keepalive-timeout": 120, "vpn-rx-bytes": 0, "vpn-rx-packets": 0, "vpn-tx-bytes": 0, "vpn-tx-packets": 0, "link-rx-bytes": 0, "link-rx-packets": 0, "link-tx-bytes": 0, "link-tx-packets": 0}}}
+{"name": "peer-del-ntf", "msg": {"ifindex": 0, "peer": {"del-reason": "userspace", "id": 2, "tx-id": 2, "vpn-ipv4": "5.5.5.3", "keepalive-interval": 60, "keepalive-timeout": 120, "vpn-rx-bytes": 0, "vpn-rx-packets": 0, "vpn-tx-bytes": 0, "vpn-tx-packets": 0, "link-rx-bytes": 0, "link-rx-packets": 0, "link-tx-bytes": 0, "link-tx-packets": 0}}}
+{"name": "peer-del-ntf", "msg": {"ifindex": 0, "peer": {"del-reason": "expired", "id": 3, "tx-id": 3, "vpn-ipv4": "5.5.5.4", "keepalive-interval": 3, "keepalive-timeout": 3, "vpn-rx-bytes": 0, "vpn-rx-packets": 0, "vpn-tx-bytes": 0, "vpn-tx-packets": 0, "link-rx-bytes": 0, "link-rx-packets": 0, "link-tx-bytes": 0, "link-tx-packets": 0}}}
+{"name": "peer-del-ntf", "msg": {"ifindex": 0, "peer": {"del-reason": "expired", "id": 4, "tx-id": 4, "vpn-ipv4": "5.5.5.5", "keepalive-interval": 3, "keepalive-timeout": 3, "vpn-rx-bytes": 0, "vpn-rx-packets": 0, "vpn-tx-bytes": 0, "vpn-tx-packets": 0, "link-rx-bytes": 0, "link-rx-packets": 0, "link-tx-bytes": 0, "link-tx-packets": 0}}}
+{"name": "peer-del-ntf", "msg": {"ifindex": 0, "peer": {"del-reason": "expired", "id": 5, "tx-id": 5, "vpn-ipv4": "5.5.5.6", "keepalive-interval": 3, "keepalive-timeout": 3, "vpn-rx-bytes": 0, "vpn-rx-packets": 0, "vpn-tx-bytes": 0, "vpn-tx-packets": 0, "link-rx-bytes": 0, "link-rx-packets": 0, "link-tx-bytes": 0, "link-tx-packets": 0}}}
+{"name": "peer-del-ntf", "msg": {"ifindex": 0, "peer": {"del-reason": "expired", "id": 6, "tx-id": 6, "vpn-ipv4": "5.5.5.7", "keepalive-interval": 3, "keepalive-timeout": 3, "vpn-rx-bytes": 0, "vpn-rx-packets": 0, "vpn-tx-bytes": 0, "vpn-tx-packets": 0, "link-rx-bytes": 0, "link-rx-packets": 0, "link-tx-bytes": 0, "link-tx-packets": 0}}}
diff --git a/tools/testing/selftests/net/ovpn/json/peer0-symm.json b/tools/testing/selftests/net/ovpn/json/peer0-symm.json
deleted file mode 120000
index 57a163048eed..000000000000
--- a/tools/testing/selftests/net/ovpn/json/peer0-symm.json
+++ /dev/null
@@ -1 +0,0 @@
-peer0.json
\ No newline at end of file
diff --git a/tools/testing/selftests/net/ovpn/json/peer0-symm.json b/tools/testing/selftests/net/ovpn/json/peer0-symm.json
new file mode 100644
index 000000000000..2899913ea064
--- /dev/null
+++ b/tools/testing/selftests/net/ovpn/json/peer0-symm.json
@@ -0,0 +1,6 @@
+{"name": "peer-del-ntf", "msg": {"ifindex": 0, "peer": {"del-reason": "userspace", "id": 1, "tx-id": 1, "vpn-ipv4": "5.5.5.2", "keepalive-interval": 60, "keepalive-timeout": 120, "vpn-rx-bytes": 0, "vpn-rx-packets": 0, "vpn-tx-bytes": 0, "vpn-tx-packets": 0, "link-rx-bytes": 0, "link-rx-packets": 0, "link-tx-bytes": 0, "link-tx-packets": 0}}}
+{"name": "peer-del-ntf", "msg": {"ifindex": 0, "peer": {"del-reason": "userspace", "id": 2, "tx-id": 2, "vpn-ipv4": "5.5.5.3", "keepalive-interval": 60, "keepalive-timeout": 120, "vpn-rx-bytes": 0, "vpn-rx-packets": 0, "vpn-tx-bytes": 0, "vpn-tx-packets": 0, "link-rx-bytes": 0, "link-rx-packets": 0, "link-tx-bytes": 0, "link-tx-packets": 0}}}
+{"name": "peer-del-ntf", "msg": {"ifindex": 0, "peer": {"del-reason": "expired", "id": 3, "tx-id": 3, "vpn-ipv4": "5.5.5.4", "keepalive-interval": 3, "keepalive-timeout": 3, "vpn-rx-bytes": 0, "vpn-rx-packets": 0, "vpn-tx-bytes": 0, "vpn-tx-packets": 0, "link-rx-bytes": 0, "link-rx-packets": 0, "link-tx-bytes": 0, "link-tx-packets": 0}}}
+{"name": "peer-del-ntf", "msg": {"ifindex": 0, "peer": {"del-reason": "expired", "id": 4, "tx-id": 4, "vpn-ipv4": "5.5.5.5", "keepalive-interval": 3, "keepalive-timeout": 3, "vpn-rx-bytes": 0, "vpn-rx-packets": 0, "vpn-tx-bytes": 0, "vpn-tx-packets": 0, "link-rx-bytes": 0, "link-rx-packets": 0, "link-tx-bytes": 0, "link-tx-packets": 0}}}
+{"name": "peer-del-ntf", "msg": {"ifindex": 0, "peer": {"del-reason": "expired", "id": 5, "tx-id": 5, "vpn-ipv4": "5.5.5.6", "keepalive-interval": 3, "keepalive-timeout": 3, "vpn-rx-bytes": 0, "vpn-rx-packets": 0, "vpn-tx-bytes": 0, "vpn-tx-packets": 0, "link-rx-bytes": 0, "link-rx-packets": 0, "link-tx-bytes": 0, "link-tx-packets": 0}}}
+{"name": "peer-del-ntf", "msg": {"ifindex": 0, "peer": {"del-reason": "expired", "id": 6, "tx-id": 6, "vpn-ipv4": "5.5.5.7", "keepalive-interval": 3, "keepalive-timeout": 3, "vpn-rx-bytes": 0, "vpn-rx-packets": 0, "vpn-tx-bytes": 0, "vpn-tx-packets": 0, "link-rx-bytes": 0, "link-rx-packets": 0, "link-tx-bytes": 0, "link-tx-packets": 0}}}
diff --git a/tools/testing/selftests/net/ovpn/json/peer0.json b/tools/testing/selftests/net/ovpn/json/peer0.json
index 7c46a33d5ecd..fff2a86b41ab 100644
--- a/tools/testing/selftests/net/ovpn/json/peer0.json
+++ b/tools/testing/selftests/net/ovpn/json/peer0.json
@@ -1,6 +1,6 @@
-{"name": "peer-del-ntf", "msg": {"ifindex": 0, "peer": {"del-reason": "userspace", "id": 1}}}
-{"name": "peer-del-ntf", "msg": {"ifindex": 0, "peer": {"del-reason": "userspace", "id": 2}}}
-{"name": "peer-del-ntf", "msg": {"ifindex": 0, "peer": {"del-reason": "expired", "id": 3}}}
-{"name": "peer-del-ntf", "msg": {"ifindex": 0, "peer": {"del-reason": "expired", "id": 4}}}
-{"name": "peer-del-ntf", "msg": {"ifindex": 0, "peer": {"del-reason": "expired", "id": 5}}}
-{"name": "peer-del-ntf", "msg": {"ifindex": 0, "peer": {"del-reason": "expired", "id": 6}}}
+{"name": "peer-del-ntf", "msg": {"ifindex": 0, "peer": {"del-reason": "userspace", "id": 1, "tx-id": 10, "vpn-ipv4": "5.5.5.2", "keepalive-interval": 60, "keepalive-timeout": 120, "vpn-rx-bytes": 0, "vpn-rx-packets": 0, "vpn-tx-bytes": 0, "vpn-tx-packets": 0, "link-rx-bytes": 0, "link-rx-packets": 0, "link-tx-bytes": 0, "link-tx-packets": 0}}}
+{"name": "peer-del-ntf", "msg": {"ifindex": 0, "peer": {"del-reason": "userspace", "id": 2, "tx-id": 11, "vpn-ipv4": "5.5.5.3", "keepalive-interval": 60, "keepalive-timeout": 120, "vpn-rx-bytes": 0, "vpn-rx-packets": 0, "vpn-tx-bytes": 0, "vpn-tx-packets": 0, "link-rx-bytes": 0, "link-rx-packets": 0, "link-tx-bytes": 0, "link-tx-packets": 0}}}
+{"name": "peer-del-ntf", "msg": {"ifindex": 0, "peer": {"del-reason": "expired", "id": 3, "tx-id": 12, "vpn-ipv4": "5.5.5.4", "keepalive-interval": 3, "keepalive-timeout": 3, "vpn-rx-bytes": 0, "vpn-rx-packets": 0, "vpn-tx-bytes": 0, "vpn-tx-packets": 0, "link-rx-bytes": 0, "link-rx-packets": 0, "link-tx-bytes": 0, "link-tx-packets": 0}}}
+{"name": "peer-del-ntf", "msg": {"ifindex": 0, "peer": {"del-reason": "expired", "id": 4, "tx-id": 13, "vpn-ipv4": "5.5.5.5", "keepalive-interval": 3, "keepalive-timeout": 3, "vpn-rx-bytes": 0, "vpn-rx-packets": 0, "vpn-tx-bytes": 0, "vpn-tx-packets": 0, "link-rx-bytes": 0, "link-rx-packets": 0, "link-tx-bytes": 0, "link-tx-packets": 0}}}
+{"name": "peer-del-ntf", "msg": {"ifindex": 0, "peer": {"del-reason": "expired", "id": 5, "tx-id": 14, "vpn-ipv4": "5.5.5.6", "keepalive-interval": 3, "keepalive-timeout": 3, "vpn-rx-bytes": 0, "vpn-rx-packets": 0, "vpn-tx-bytes": 0, "vpn-tx-packets": 0, "link-rx-bytes": 0, "link-rx-packets": 0, "link-tx-bytes": 0, "link-tx-packets": 0}}}
+{"name": "peer-del-ntf", "msg": {"ifindex": 0, "peer": {"del-reason": "expired", "id": 6, "tx-id": 15, "vpn-ipv4": "5.5.5.7", "keepalive-interval": 3, "keepalive-timeout": 3, "vpn-rx-bytes": 0, "vpn-rx-packets": 0, "vpn-tx-bytes": 0, "vpn-tx-packets": 0, "link-rx-bytes": 0, "link-rx-packets": 0, "link-tx-bytes": 0, "link-tx-packets": 0}}}
diff --git a/tools/testing/selftests/net/ovpn/json/peer1-symm.json b/tools/testing/selftests/net/ovpn/json/peer1-symm.json
index 5da4ea9d51fb..41b358e1be51 100644
--- a/tools/testing/selftests/net/ovpn/json/peer1-symm.json
+++ b/tools/testing/selftests/net/ovpn/json/peer1-symm.json
@@ -1 +1 @@
-{"name": "peer-del-ntf", "msg": {"ifindex": 0, "peer": {"del-reason": "userspace", "id": 1}}}
+{"name": "peer-del-ntf", "msg": {"ifindex": 0, "peer": {"del-reason": "userspace", "id": 1, "tx-id": 1, "keepalive-interval": 60, "keepalive-timeout": 120, "vpn-rx-bytes": 0, "vpn-rx-packets": 0, "vpn-tx-bytes": 0, "vpn-tx-packets": 0, "link-rx-bytes": 0, "link-rx-packets": 0, "link-tx-bytes": 0, "link-tx-packets": 0}}}
diff --git a/tools/testing/selftests/net/ovpn/json/peer1.json b/tools/testing/selftests/net/ovpn/json/peer1.json
index 1009d26dc14a..6332709d2a88 100644
--- a/tools/testing/selftests/net/ovpn/json/peer1.json
+++ b/tools/testing/selftests/net/ovpn/json/peer1.json
@@ -1 +1 @@
-{"name": "peer-del-ntf", "msg": {"ifindex": 0, "peer": {"del-reason": "userspace", "id": 10}}}
+{"name": "peer-del-ntf", "msg": {"ifindex": 0, "peer": {"del-reason": "userspace", "id": 10, "tx-id": 1, "keepalive-interval": 60, "keepalive-timeout": 120, "vpn-rx-bytes": 0, "vpn-rx-packets": 0, "vpn-tx-bytes": 0, "vpn-tx-packets": 0, "link-rx-bytes": 0, "link-rx-packets": 0, "link-tx-bytes": 0, "link-tx-packets": 0}}}
diff --git a/tools/testing/selftests/net/ovpn/json/peer2-symm.json b/tools/testing/selftests/net/ovpn/json/peer2-symm.json
index 8f6db4f8c2ac..b1840bf979e8 100644
--- a/tools/testing/selftests/net/ovpn/json/peer2-symm.json
+++ b/tools/testing/selftests/net/ovpn/json/peer2-symm.json
@@ -1 +1 @@
-{"name": "peer-del-ntf", "msg": {"ifindex": 0, "peer": {"del-reason": "userspace", "id": 2}}}
+{"name": "peer-del-ntf", "msg": {"ifindex": 0, "peer": {"del-reason": "userspace", "id": 2, "tx-id": 2, "keepalive-interval": 60, "keepalive-timeout": 120, "vpn-rx-bytes": 0, "vpn-rx-packets": 0, "vpn-tx-bytes": 0, "vpn-tx-packets": 0, "link-rx-bytes": 0, "link-rx-packets": 0, "link-tx-bytes": 0, "link-tx-packets": 0}}}
diff --git a/tools/testing/selftests/net/ovpn/json/peer2.json b/tools/testing/selftests/net/ovpn/json/peer2.json
index 44e9fad2b622..431427e4eb53 100644
--- a/tools/testing/selftests/net/ovpn/json/peer2.json
+++ b/tools/testing/selftests/net/ovpn/json/peer2.json
@@ -1 +1 @@
-{"name": "peer-del-ntf", "msg": {"ifindex": 0, "peer": {"del-reason": "userspace", "id": 11}}}
+{"name": "peer-del-ntf", "msg": {"ifindex": 0, "peer": {"del-reason": "userspace", "id": 11, "tx-id": 2, "keepalive-interval": 60, "keepalive-timeout": 120, "vpn-rx-bytes": 0, "vpn-rx-packets": 0, "vpn-tx-bytes": 0, "vpn-tx-packets": 0, "link-rx-bytes": 0, "link-rx-packets": 0, "link-tx-bytes": 0, "link-tx-packets": 0}}}
diff --git a/tools/testing/selftests/net/ovpn/json/peer3-symm.json b/tools/testing/selftests/net/ovpn/json/peer3-symm.json
index bdabd6fa2e64..f9ab2a15dd9f 100644
--- a/tools/testing/selftests/net/ovpn/json/peer3-symm.json
+++ b/tools/testing/selftests/net/ovpn/json/peer3-symm.json
@@ -1 +1 @@
-{"name": "peer-del-ntf", "msg": {"ifindex": 0, "peer": {"del-reason": "expired", "id": 3}}}
+{"name": "peer-del-ntf", "msg": {"ifindex": 0, "peer": {"del-reason": "expired", "id": 3, "tx-id": 3, "keepalive-interval": 3, "keepalive-timeout": 3, "vpn-rx-bytes": 0, "vpn-rx-packets": 0, "vpn-tx-bytes": 0, "vpn-tx-packets": 0, "link-rx-bytes": 0, "link-rx-packets": 0, "link-tx-bytes": 0, "link-tx-packets": 0}}}
diff --git a/tools/testing/selftests/net/ovpn/json/peer3.json b/tools/testing/selftests/net/ovpn/json/peer3.json
index d4be8ba130ae..4f9522a664ee 100644
--- a/tools/testing/selftests/net/ovpn/json/peer3.json
+++ b/tools/testing/selftests/net/ovpn/json/peer3.json
@@ -1 +1 @@
-{"name": "peer-del-ntf", "msg": {"ifindex": 0, "peer": {"del-reason": "expired", "id": 12}}}
+{"name": "peer-del-ntf", "msg": {"ifindex": 0, "peer": {"del-reason": "expired", "id": 12, "tx-id": 3, "keepalive-interval": 3, "keepalive-timeout": 3, "vpn-rx-bytes": 0, "vpn-rx-packets": 0, "vpn-tx-bytes": 0, "vpn-tx-packets": 0, "link-rx-bytes": 0, "link-rx-packets": 0, "link-tx-bytes": 0, "link-tx-packets": 0}}}
diff --git a/tools/testing/selftests/net/ovpn/json/peer4-symm.json b/tools/testing/selftests/net/ovpn/json/peer4-symm.json
index c3734bb9251b..b41ab838a304 100644
--- a/tools/testing/selftests/net/ovpn/json/peer4-symm.json
+++ b/tools/testing/selftests/net/ovpn/json/peer4-symm.json
@@ -1 +1 @@
-{"name": "peer-del-ntf", "msg": {"ifindex": 0, "peer": {"del-reason": "expired", "id": 4}}}
+{"name": "peer-del-ntf", "msg": {"ifindex": 0, "peer": {"del-reason": "expired", "id": 4, "tx-id": 4, "keepalive-interval": 3, "keepalive-timeout": 3, "vpn-rx-bytes": 0, "vpn-rx-packets": 0, "vpn-tx-bytes": 0, "vpn-tx-packets": 0, "link-rx-bytes": 0, "link-rx-packets": 0, "link-tx-bytes": 0, "link-tx-packets": 0}}}
diff --git a/tools/testing/selftests/net/ovpn/json/peer4.json b/tools/testing/selftests/net/ovpn/json/peer4.json
index 67d27e2d48ac..7d6b3c8af0e4 100644
--- a/tools/testing/selftests/net/ovpn/json/peer4.json
+++ b/tools/testing/selftests/net/ovpn/json/peer4.json
@@ -1 +1 @@
-{"name": "peer-del-ntf", "msg": {"ifindex": 0, "peer": {"del-reason": "expired", "id": 13}}}
+{"name": "peer-del-ntf", "msg": {"ifindex": 0, "peer": {"del-reason": "expired", "id": 13, "tx-id": 4, "keepalive-interval": 3, "keepalive-timeout": 3, "vpn-rx-bytes": 0, "vpn-rx-packets": 0, "vpn-tx-bytes": 0, "vpn-tx-packets": 0, "link-rx-bytes": 0, "link-rx-packets": 0, "link-tx-bytes": 0, "link-tx-packets": 0}}}
diff --git a/tools/testing/selftests/net/ovpn/json/peer5-symm.json b/tools/testing/selftests/net/ovpn/json/peer5-symm.json
index 46c4a348299d..962def1ec16f 100644
--- a/tools/testing/selftests/net/ovpn/json/peer5-symm.json
+++ b/tools/testing/selftests/net/ovpn/json/peer5-symm.json
@@ -1 +1 @@
-{"name": "peer-del-ntf", "msg": {"ifindex": 0, "peer": {"del-reason": "expired", "id": 5}}}
+{"name": "peer-del-ntf", "msg": {"ifindex": 0, "peer": {"del-reason": "expired", "id": 5, "tx-id": 5, "keepalive-interval": 3, "keepalive-timeout": 3, "vpn-rx-bytes": 0, "vpn-rx-packets": 0, "vpn-tx-bytes": 0, "vpn-tx-packets": 0, "link-rx-bytes": 0, "link-rx-packets": 0, "link-tx-bytes": 0, "link-tx-packets": 0}}}
diff --git a/tools/testing/selftests/net/ovpn/json/peer5.json b/tools/testing/selftests/net/ovpn/json/peer5.json
index ecd9bd0b2f37..963dc74cdaa6 100644
--- a/tools/testing/selftests/net/ovpn/json/peer5.json
+++ b/tools/testing/selftests/net/ovpn/json/peer5.json
@@ -1 +1 @@
-{"name": "peer-del-ntf", "msg": {"ifindex": 0, "peer": {"del-reason": "expired", "id": 14}}}
+{"name": "peer-del-ntf", "msg": {"ifindex": 0, "peer": {"del-reason": "expired", "id": 14, "tx-id": 5, "keepalive-interval": 3, "keepalive-timeout": 3, "vpn-rx-bytes": 0, "vpn-rx-packets": 0, "vpn-tx-bytes": 0, "vpn-tx-packets": 0, "link-rx-bytes": 0, "link-rx-packets": 0, "link-tx-bytes": 0, "link-tx-packets": 0}}}
diff --git a/tools/testing/selftests/net/ovpn/json/peer6-symm.json b/tools/testing/selftests/net/ovpn/json/peer6-symm.json
index aa30f2cff625..3ff352fae60f 100644
--- a/tools/testing/selftests/net/ovpn/json/peer6-symm.json
+++ b/tools/testing/selftests/net/ovpn/json/peer6-symm.json
@@ -1 +1 @@
-{"name": "peer-del-ntf", "msg": {"ifindex": 0, "peer": {"del-reason": "expired", "id": 6}}}
+{"name": "peer-del-ntf", "msg": {"ifindex": 0, "peer": {"del-reason": "expired", "id": 6, "tx-id": 6, "keepalive-interval": 3, "keepalive-timeout": 3, "vpn-rx-bytes": 0, "vpn-rx-packets": 0, "vpn-tx-bytes": 0, "vpn-tx-packets": 0, "link-rx-bytes": 0, "link-rx-packets": 0, "link-tx-bytes": 0, "link-tx-packets": 0}}}
diff --git a/tools/testing/selftests/net/ovpn/json/peer6.json b/tools/testing/selftests/net/ovpn/json/peer6.json
index 7fded29c5804..0db187f3af18 100644
--- a/tools/testing/selftests/net/ovpn/json/peer6.json
+++ b/tools/testing/selftests/net/ovpn/json/peer6.json
@@ -1 +1 @@
-{"name": "peer-del-ntf", "msg": {"ifindex": 0, "peer": {"del-reason": "expired", "id": 15}}}
+{"name": "peer-del-ntf", "msg": {"ifindex": 0, "peer": {"del-reason": "expired", "id": 15, "tx-id": 6, "keepalive-interval": 3, "keepalive-timeout": 3, "vpn-rx-bytes": 0, "vpn-rx-packets": 0, "vpn-tx-bytes": 0, "vpn-tx-packets": 0, "link-rx-bytes": 0, "link-rx-packets": 0, "link-tx-bytes": 0, "link-tx-packets": 0}}}
-- 
2.55.0

