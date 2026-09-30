Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D638C46EF6B
	for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 22:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790807165; cv=none; b=IkowFcQ7395PaK8/LF7yYhrMbBjQoqmoAiC9TvBNHHOK6MvOeeEpD4TjT56CL2+jj0YA47beDaD/xDDGdZWV03oQ0twmZDoOJNRkOZnYzKQv2tBOEOFLF5SWhhH/CJcLh/wMC62EuDC3oVlOX0jKb6Kp/GNcmyrzp1wko/WNTa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790807165; c=relaxed/simple;
	bh=Znl0RhHn719q78qOEHu+wBvcAikrEs24abN6CQjjdlo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TEaceAF7m6SylYcNedNy05uhgY7zQmttUBwIi+oFLiN5vJU3539E4Gp97PNTqDgOR+TZMNr9F9iDlI3/Bd0iMvDIUoCP+4k5TGIaGyRZK2rcAqvlyHl/SzoA9KsnDnqiv0NUhgKCQrWEQe+Eq2ArXOWaOuYhknp3F4RLPcWC7Us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=a9Nomgo6; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="a9Nomgo6"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49e69b9e16aso60528555e9.1
        for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 15:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1790807161; x=1791411961; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=q22SZP/7nPFftZo/+lDsg8hh1n+O38jLUhz70eAE5Hc=;
        b=a9Nomgo6ftW4banvmjGz6qDX/EJLBgKLh7M4u+j6NjdlWv/5/i3e0QHxNp259CX/YQ
         6wwoDZQFzw4bt7PnK5iJT0fSkVJ4Ul7u9gvgewtLerriEvXGN2Y+20KKoCGfytgmQ0sZ
         Cua++YfcDT9WcVvjkzNFpO2VI8IS915vUJVgJ1vsHWy0N+CpfJRXbyWZR9l7YevCYGdd
         y05u7gkeUAwDaVG6FGryCL6UFbIyQcQeXBwEdUGhfVWIQft2vwW0ahg92Sv/cROskMJ6
         GnHfexm7FalOy3peEhiyebvM2XKHamzYsQN7sCp0WKpYJHDEkSL0X9qTKXxF17fD5mgF
         EEKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790807161; x=1791411961;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=q22SZP/7nPFftZo/+lDsg8hh1n+O38jLUhz70eAE5Hc=;
        b=Idt1ByT0JhP34E/aWpc+QMOkpHnrZFUkIge2Gymv6CItYMuPQCP+GwK9ZlZrjEGADp
         FZdsgdK6sb674MijbO05ahXHnWZL3k34+c0NlC11rZurxRFK0E6bBXyLu4eijg+iD3Sn
         1jk+T74S0czpBxpAk5vavH8e+YxqiSGEHnZjpYqY/8+yCI+bkb4f/1fALXR2EZGZfTd6
         UXgSBdcVVVx0B+NPg7CccdGJ2b2BbaxbWTClTay0gxirPc1DTNlYb8WvG13WMT5yP3/d
         bS3FBBl/UoNP8rE+9giN/tCEVhARwmsBrxjdmRtk4kaYIbDpv0JvJgEPmOW/qKaVdkVX
         etkw==
X-Gm-Message-State: AFuF++mVrCy3qzMUbp3xNjOSruUtb1BGyZjYnzVst99EzkbxvPBaveqb
	o9uMUaKSz1lKxJHS6f3E5nxK3srxCLmpUIrVZa+o0sFuWngne8IJQ7EJdGe37Ipu2CC+2b3DTCc
	9INbv3Vae/9ZxfIxnK12lYTzbjbz8tlX3LsVfCTcAl1syYcDKCH7hX7p6ZgNdXSRFupM=
X-Gm-Gg: AYBFou00CDmYPCtUD0msOQ2SRJl6UykO+lnxiougyk/tk4FQlj7VDe6JlzeZZizjzxk
	LhzPoqxz5kBtyBTeoxSqj5ulv/DeokOoNdMatDPZV5yDhbAHsBzz3QFPnYH2h+jW/MzQZSinyB1
	6HgleatkDTJWq28Ic7KYWd9fKitwn67UpYS8RqZ5pFaPcyMemed2dtVb5atC+/iJf8KZz0rYOoW
	u0Wnmt+IjpfqlzlABAoTzWb6qvIAR9erOvL6tpe1scV2npVjVOCFl2cm1abWjQjAcVipr9KQZMc
	QZWipVM22sgQkpElnBtF9cRhCUCwNk8S9AcmckccR9QoTfCRLT5s4B3QOdolM8CTEVzM+71PoAA
	5+a2qcaeNq2RJKR/ecs3BeH7MSkvX8MpLomj8UYp9+tah5oHrFloQvTowMX3JeHsR7J9RBQ1Hyp
	80rSVHPI47u+vZImuospMtyAFS9Z2LHlZRrOFxP33hkXEirXgPzSnl7f9S918pzL++DMCUDLdtr
	gW+ooEm2D4=
X-Received: by 2002:a05:600c:6094:b0:49f:e238:e7cb with SMTP id 5b1f17b1804b1-4a01b0052c6mr46264595e9.29.1790807160660;
        Wed, 30 Sep 2026 15:26:00 -0700 (PDT)
Received: from inifinity.mandelbit.com ([2001:67c:2fbc:1:5892:feba:7b41:58fb])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a01f979c05sm24433095e9.3.2026.09.30.15.25.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 15:26:00 -0700 (PDT)
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
Date: Thu,  1 Oct 2026 00:25:40 +0200
Message-ID: <20260930222542.3839327-7-antonio@openvpn.net>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260930222542.3839327-1-antonio@openvpn.net>
References: <20260930222542.3839327-1-antonio@openvpn.net>
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
index 96b40742eddf..623a99004501 100644
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

