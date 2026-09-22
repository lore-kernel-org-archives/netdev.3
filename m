Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E11D24A5EA4
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 06:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790057347; cv=none; b=lqkMLRLsohUfj1cgHyh7lsRC9OY076rdUimM0e+bSqei/i/bW6jcRhvVAW/ZM8Qe0mbYMLtXhmfTjxBL3+TrxBbtgHLJ+2dSylyYCclJa68kF0nGbEQdy2nIe+v8UjCkwJCVa7rld1sIvzfSgxblPAoGP/o/Rta8k00aylHWvl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790057347; c=relaxed/simple;
	bh=MFHR4VsECxiiH3uP/JJBa0l95bcvABMvrxG5ghEBgVg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bbBOnlxdl0bg2PXRHknvlrUFNuWorxWpDhqErAT4XN3yOLteIDF7jAvPlXw2FT8Pv9e/vulLEun1sd9u+gx3bFlcTSojC1TSDghywyAY/4MdmQy2lT74xJFZ6dkS4pa4uifI2ejLR9ITfkLlNckIHVvDoyvxEsy8gSmInlTTBFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=Q//qpqqv; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="Q//qpqqv"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49b912d3931so27941955e9.3
        for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 23:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1790057343; x=1790662143; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=y00sQ5PJ4emPnR7XatNNnmIU8Js0sYzL+xMRMQlq/Jc=;
        b=Q//qpqqvMXwchxDZTsS+e11nLgqEO2oEsyh3VzjPtK71SmcVXEnnrowZDe7NwLKXjN
         qjZI62XFgm6C23cVKKUF/H7uPxre30Dkb8yMeOeBzHiI4c2wNXFtu+cUHnx0+am3XW5b
         /mkijACiZZVvp/1oRg+545rS3zoncauA+jy1WBmV4ZTvSHfOMW9vmz7q5lEhIFxuq79f
         G6IB/SE/jyZL7Yl9Bdc/T1ihPivVXg4xtmQhz3Y4Gmt0Z3a+mdyj8bWnXMFecPaG+u5v
         6lCOlY4KAJp5fHSU6mfX5OWh2seyvL2ksTMxluP2F6D1Tun9J6D48fVTHmHZukbNHLvx
         enEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790057343; x=1790662143;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=y00sQ5PJ4emPnR7XatNNnmIU8Js0sYzL+xMRMQlq/Jc=;
        b=l1Aiv381U7v/7PSioIj+XO4/ULx9g/1ZNjALrwbfPN2ozmgU1nYNpyTlbqvIAYYEpL
         s+oHS69XY4sxPa4vjVRRLPjBzxebaduRHF5TOSoKpVR11XU2zrsDMi0HWEriwYo3256b
         gbEjq7EHn9aEB+1rCy8dXxshxHDTbAdCgyoKFkEeqEFIfhWaHlCy8vyo43K5Y4DLb7UD
         efMsTvFyX5fkDlI5zTVhOwvfHgyrmUwbtlCqn5jus44cItXxFQM0I9xivilimfDITPEA
         n7Zxhzoe0qDait5b1K1/T5/0ci52FrXj4hbTRcWQ+ZpVaT0AU9tdwWpH7b9hjslxgyvv
         Mc9A==
X-Gm-Message-State: AFuF++lLgHneA9joBBLWk0mJl6YCLzwYN4dePDqbjPbPrkj0HrMjAl+s
	QLe50fI0iMI01PFaRTi9ZgIEb/WFeieEaz38gqE4pVmIfyapBj+ckc+ilDQdIQJeyJVMwGOdl5D
	3rWVaP2MY70rgl7cWQv1JD7ED9P+NMGt8JRGwPC0HNiti5RoxCbZILoP+AgXshkCVni0=
X-Gm-Gg: AYBFou1LwIeNCtzlTXfdZSvP67eO+UcYjpqyPsr3Wiq4cpM+cdRXxZX19Xq9XMHVYCf
	TKSqFNTCML9F2yhXYnH1b0x18rQ19bKyxRzpzLCrASuDij1zakDXheUx/MECHU7KcI++O2FkySH
	hxfbP4rtmVi+kwl51LoqjvWHBuRZ5CblcitIHjDBh2UAskYUcPAoO6yVGyi/FRnYyKTmF/8Tu8R
	QQEq2wHPmBzE21R0wgY3mQKsrIPpNBf7qlrhVGOSNsBhaPhl1sZHHXrozqDgQFAVN3FcIr9KU7K
	fDKeMInu0vrBsGoV3Ui8mV+g9CjV+pJV+7PFsJYMiyoQyjIKwsmuU59vUBlwlW7f+pWO/Nby63E
	MZree2rnq/TyrdaC3dBge0vCQ2i214nAs3cdXgZpchXAf0fuOYUC0yWiNDtJcooOSnORXeNU1TO
	a9MsYI4Zgank13bqFMBg/YAap3Z3CLLcLQNCf5qMeCcNNGWL4gpwhG21ydq+NJHh24jVBFSNPK8
	6G61d8mDbQ=
X-Received: by 2002:a05:600c:8518:b0:49d:28c4:b304 with SMTP id 5b1f17b1804b1-49fc5741563mr192455235e9.29.1790057342942;
        Mon, 21 Sep 2026 23:09:02 -0700 (PDT)
Received: from inifinity.mandelbit.com ([2001:67c:2fbc:1:b03b:2cfc:7208:2ecf])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fdad6306esm25814125e9.15.2026.09.21.23.09.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 23:09:02 -0700 (PDT)
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
Subject: [PATCH net-next 5/5] ovpn: send peer object along with PEER_DEL_NTF
Date: Tue, 22 Sep 2026 08:08:51 +0200
Message-ID: <20260922060852.2266148-6-antonio@openvpn.net>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260922060852.2266148-1-antonio@openvpn.net>
References: <20260922060852.2266148-1-antonio@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ralf Lici <ralf@mandelbit.com>

OpenVPN userspace needs the final statistics of a disconnecting peer.
Today this is done by issuing a PEER_GET request after receiving
PEER_DEL_NTF. When several peers disconnect at the same time, those
extra request/reply transactions overlap with notification processing on
the same netlink socket and can make userspace hit transient netlink
errors such as NLE_BUSY or NLE_NOMEM.

Include a peer snapshot directly in PEER_DEL_NTF, using the same peer
object format returned by PEER_GET. This lets userspace consume the last
known counters from the notification itself, without issuing one netlink
request per deleted peer.

Update the ovpn selftest notification fixtures to validate the new
payload while normalizing timing-dependent counters.

Signed-off-by: Ralf Lici <ralf@mandelbit.com>
Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 drivers/net/ovpn/netlink.c                    | 60 ++++++++++++-------
 tools/testing/selftests/net/ovpn/common.sh    | 39 +++++++++++-
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
 18 files changed, 112 insertions(+), 52 deletions(-)
 mode change 120000 => 100644 tools/testing/selftests/net/ovpn/json/peer0-symm-float.json
 mode change 120000 => 100644 tools/testing/selftests/net/ovpn/json/peer0-symm.json

diff --git a/drivers/net/ovpn/netlink.c b/drivers/net/ovpn/netlink.c
index 4dad85294198..aaca0612d6f4 100644
--- a/drivers/net/ovpn/netlink.c
+++ b/drivers/net/ovpn/netlink.c
@@ -546,27 +546,15 @@ int ovpn_nl_peer_set_doit(struct sk_buff *skb, struct genl_info *info)
 	return 0;
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
@@ -574,7 +562,7 @@ static int ovpn_nl_send_peer(struct sk_buff *skb, const struct genl_info *info,
 		goto err_unlock;
 	}
 
-	if (!net_eq(genl_info_net(info), sock_net(sock->sk))) {
+	if (info && !net_eq(genl_info_net(info), sock_net(sock->sk))) {
 		id = peernet2id_alloc(genl_info_net(info),
 				      sock_net(sock->sk),
 				      GFP_ATOMIC);
@@ -585,26 +573,26 @@ static int ovpn_nl_send_peer(struct sk_buff *skb, const struct genl_info *info,
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
@@ -652,14 +640,39 @@ static int ovpn_nl_send_peer(struct sk_buff *skb, const struct genl_info *info,
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
@@ -1193,7 +1206,8 @@ int ovpn_nl_peer_del_notify(struct ovpn_peer *peer)
 	if (nla_put_u32(msg, OVPN_A_PEER_DEL_REASON, peer->delete_reason))
 		goto err_cancel_msg;
 
-	if (nla_put_u32(msg, OVPN_A_PEER_ID, peer->id))
+	ret = ovpn_nl_fill_peer(msg, NULL, peer);
+	if (ret < 0)
 		goto err_cancel_msg;
 
 	nla_nest_end(msg, attr);
diff --git a/tools/testing/selftests/net/ovpn/common.sh b/tools/testing/selftests/net/ovpn/common.sh
index de96d333ee2b..611d528c7de8 100644
--- a/tools/testing/selftests/net/ovpn/common.sh
+++ b/tools/testing/selftests/net/ovpn/common.sh
@@ -19,9 +19,42 @@ OVPN_VERBOSE=${OVPN_VERBOSE:-0}
 
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

