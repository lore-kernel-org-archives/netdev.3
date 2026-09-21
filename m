Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0784472F87
	for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 10:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789986151; cv=none; b=lMGVT9nEzyvwav823oRmeh5PAQL0NeDMoz7Z83ebjJNKM3OP3V8xN6fbhntvHBwgKguNhBcVGXjNkidedlyKJ265uUbaXD984hE6JUE5V6udBlTtYcD1KlBHVZxeiyeRYkaQo89oODisg3A+fE50pDgxQMH7GZyhFXC3zd01rgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789986151; c=relaxed/simple;
	bh=qXsbFrcWk1CubDMrBrbo9idt7nSVhpy4KWAY9J0czMI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KKQ/3eILK2in2qhdKmChrKUmN/N6UoYuomppMflGB73hbYgD2PnOv+DUl0pTsfA0XV/Qr2dO1V7KjkmXj5lKOiRWibJCFUpXb67LLidCQMWhwMWKWvXc15KvlIWyt+wMX+KGDkUQ7FrEUKj3o2+Y2jTNbawIomKSrmAp0pZnfS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=KqqHYZY1; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="KqqHYZY1"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-48583cc7ab1so1291671f8f.2
        for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 03:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1789986148; x=1790590948; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=x7Oee2K5n1gHbuvMctcavZNSLu1ynEo3WRXs1q1d9bg=;
        b=KqqHYZY14KvJatUqb98w0+0iDz4ae7oVcMY9aW28G2QA9DJqkDKweQof0eT0vZeH+C
         zT6GTOnDYVWkr59tz39NyJy0S/Ev/vDA34C5euuVspCjw5pXqJ/h4C4mu4+He5fR3oqc
         b3sUUPOM8KnT3pg1LPSEhqVU+J8bH6rO0V1chANGlXCsJV3DV2FBtJwV26c3PVtb9juX
         Ag6mK4A7ClgsOMgYni7iWrMpDov3PMh0Tjv1avxXcb7LjIul4P9u/IRgjUsE+cUcCE7P
         4ErEjZxbVEYtOO7OT1wekugHoQJ5jTPiVBHRB+EpsOgFwQCyuMgS/ZCGRV2E11zUEYr6
         NmqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789986148; x=1790590948;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=x7Oee2K5n1gHbuvMctcavZNSLu1ynEo3WRXs1q1d9bg=;
        b=ZTsGgtCYyhQrLXiPm3xTyGyWsTpReudUvRVr7NPthLqbOVbAlY16rFhZYbDyE3dg7Q
         8SfsgQaXlF/GD4Ep7wipXZwThM7oFsSw8D3oq+9Ib8uTT7UIeEmVWr7LTc1OKsfHPKAQ
         4hi0NnK1p0pyP0c4fXX0ocaZEyPRSDVa8ilWs6X4Im7pGzKxHyaeiZiL6574YQ23ZouA
         JYkkBHnF/uFyFjT5TxK7gUC4EPpZ8+F1C+7zyIz62Kawdssk65XX7oKcxOYN3z9YfOy1
         jSsqGWLpDEXMM/bgWyi9PHCYm2JuTKaiyj8FqKVBcyGvxC21U052oJMIB6QXhaP5muOp
         7Abg==
X-Gm-Message-State: AFuF++mzF5aJ4qfAAOF66tsRfVLTiPjJn1xgNA6t/WkegRkO0D9VA4d1
	1jJTEftM9hDwmi+euv0T+TMWJUcLXs/AdzdgI/VNudlaN+q5qqoNw9blZLM/fajJHSC3qlfSUXd
	kecMx2uEnH1uejmTa7AoqMMk2Yf5BZr4ih0gSxxLPRkGyIaNNFccYFAh6lzPaJgumzZk=
X-Gm-Gg: AYBFou3GTUZfRHDYhHC71N5Abqzn0RxIAqXSOdiIVYUgEGW/Jknc59q1VTSpUgMt73U
	1qSigRA9FquXtOcS+TrIlzW2mnZZM6Vl+oiGrkiTlQjGPPXaXUnDyRsYLlYJarcKKtP2hgLRwod
	OULJ7f9dj/MvFlaug0Zh8CH1iEQDiletU7Zcu0laYlWjuxyhYHoVdE4TFz1/ER333EL7isVpzHk
	9rJf+GqBozyeT4Jv9EcmpxRxuHV6eHxQ5iEZpBNGoI0xNZ7SOhPHxt6ciPtsycOJayk9IcX5Qxu
	2QZt9XbiViVFN245nAt97fFiU8NMBrrZsVksaZUboljHZuTVoIl7Sk/hxHPhlX4RcWsiNw8DS2T
	i9BFNELjlxKPZwumEe2fsz67h5J9g66InJwDRX7rWNwRyHdVeDNG6lso1Pi5mUGzq06W+6osOZ+
	ymc8fP4ipdY8H6YPKM0JuOZ2AQIOHQrIIKSOwCapjchIc92qH8+ssWxp5BpwIAMc9qI9ylqYljD
	kGihJl2/N0=
X-Received: by 2002:a05:6000:24c7:b0:487:901:e9e0 with SMTP id ffacd0b85a97d-4871e22068fmr13116146f8f.13.1789986147807;
        Mon, 21 Sep 2026 03:22:27 -0700 (PDT)
Received: from inifinity.mandelbit.com ([2001:67c:2fbc:1:b03b:2cfc:7208:2ecf])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48724583fffsm20925476f8f.23.2026.09.21.03.22.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 03:22:27 -0700 (PDT)
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
Subject: [PATCH net 09/11] ovpn: reject multipeer peers without VPN addresses
Date: Mon, 21 Sep 2026 12:22:10 +0200
Message-ID: <20260921102215.3599702-10-antonio@openvpn.net>
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

In MP mode, ovpn uses the peer VPN addresses to select the peer for
outgoing tunnel packets. Peer creation currently requires a VPN IPv4 or
IPv6 attribute, but it only checks for the presence of the attribute and
not for a usable address value.

This allows userspace to create an MP peer with only unspecified VPN
addresses, or to update an existing peer so that both VPN address
families become unspecified. Such a peer cannot be selected through the
VPN address hash tables.

Reject MP peer creation or update when the resulting peer would not have
at least one VPN address configured.

This changes such configurations from being accepted to being rejected,
but they have never been usable because the peer cannot be selected
through the VPN address hash tables.

Fixes: 1d36a36f6d53 ("ovpn: implement peer add/get/dump/delete via netlink")
Signed-off-by: Ralf Lici <ralf@mandelbit.com>
Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 drivers/net/ovpn/netlink.c | 36 ++++++++++++++++++++++++++++++------
 1 file changed, 30 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ovpn/netlink.c b/drivers/net/ovpn/netlink.c
index e23f7d1f49e0..e9e0f75e0443 100644
--- a/drivers/net/ovpn/netlink.c
+++ b/drivers/net/ovpn/netlink.c
@@ -352,8 +352,10 @@ static int ovpn_nl_peer_modify(struct ovpn_peer *peer, struct genl_info *info,
 
 int ovpn_nl_peer_new_doit(struct sk_buff *skb, struct genl_info *info)
 {
-	struct nlattr *attrs[OVPN_A_PEER_MAX + 1];
+	struct in_addr vpn_addr4 = { .s_addr = htonl(INADDR_ANY) };
+	struct in6_addr vpn_addr6 = IN6ADDR_ANY_INIT;
 	struct ovpn_priv *ovpn = info->user_ptr[0];
+	struct nlattr *attrs[OVPN_A_PEER_MAX + 1];
 	struct ovpn_socket *ovpn_sock;
 	struct socket *sock = NULL;
 	struct ovpn_peer *peer;
@@ -377,11 +379,20 @@ int ovpn_nl_peer_new_doit(struct sk_buff *skb, struct genl_info *info)
 		return -EINVAL;
 
 	/* in MP mode VPN IPs are required for selecting the right peer */
-	if (ovpn->mode == OVPN_MODE_MP && !attrs[OVPN_A_PEER_VPN_IPV4] &&
-	    !attrs[OVPN_A_PEER_VPN_IPV6]) {
-		NL_SET_ERR_MSG_FMT_MOD(info->extack,
-				       "VPN IP must be provided in MP mode");
-		return -EINVAL;
+	if (ovpn->mode == OVPN_MODE_MP) {
+		if (attrs[OVPN_A_PEER_VPN_IPV4])
+			vpn_addr4.s_addr =
+				nla_get_in_addr(attrs[OVPN_A_PEER_VPN_IPV4]);
+		if (attrs[OVPN_A_PEER_VPN_IPV6])
+			vpn_addr6 =
+				nla_get_in6_addr(attrs[OVPN_A_PEER_VPN_IPV6]);
+
+		if (vpn_addr4.s_addr == htonl(INADDR_ANY) &&
+		    ipv6_addr_any(&vpn_addr6)) {
+			NL_SET_ERR_MSG_FMT_MOD(info->extack,
+					       "at least one VPN IP must be configured in MP mode");
+			return -EINVAL;
+		}
 	}
 
 	peer_id = nla_get_u32(attrs[OVPN_A_PEER_ID]);
@@ -531,6 +542,9 @@ int ovpn_nl_peer_set_doit(struct sk_buff *skb, struct genl_info *info)
 
 	spin_lock_bh(&ovpn->lock);
 
+	vpn_addr4 = peer->vpn_addrs.ipv4;
+	vpn_addr6 = peer->vpn_addrs.ipv6;
+
 	/* reject peer with conflicting VPN address */
 	if (attrs[OVPN_A_PEER_VPN_IPV4]) {
 		vpn_addr4.s_addr = nla_get_in_addr(attrs[OVPN_A_PEER_VPN_IPV4]);
@@ -543,6 +557,16 @@ int ovpn_nl_peer_set_doit(struct sk_buff *skb, struct genl_info *info)
 			goto addr_conflict;
 	}
 
+	/* in MP mode VPN IPs are required for selecting the right peer */
+	if (ovpn->mode == OVPN_MODE_MP &&
+	    vpn_addr4.s_addr == htonl(INADDR_ANY) &&
+	    ipv6_addr_any(&vpn_addr6)) {
+		NL_SET_ERR_MSG_FMT_MOD(info->extack,
+				       "at least one VPN IP must be configured in MP mode");
+		ret = -EINVAL;
+		goto unlock;
+	}
+
 	ret = ovpn_nl_peer_modify(peer, info, attrs);
 	if (ret < 0)
 		goto unlock;
-- 
2.55.0

