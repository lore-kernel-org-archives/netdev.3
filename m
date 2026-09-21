Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7350D423783
	for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 10:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789986157; cv=none; b=dvE4BCF8g/eItLjCEmwUhUwFemUbv4jfR6q0sD3cfoxwXlAUUQFj5IqfGonfddVT1j9/0nOKtBRm3uPgxngOg3sz1hMcbkgn9EaGh0UwI/d2TyC3LJvYlTCGI3bDGcn54tpx4n22WkCd5HHgkwpNX3OplI0NnaBH40Ioe4Qx0Zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789986157; c=relaxed/simple;
	bh=tcVTMphSsEyDtDE6SpyRGqLMH8O6+D+dEE59mUZR3eE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GYnjgC488h4o6iu0JLXI3rL93EfJn0BFp/eeTCppmEzRg9Eh63r+EbBctff9yqdQRQCuEm1NpwsLv+piBkXDRmBGOS8Nr6iL+I591nNi/8Ko4hkLg6BdY7Rt5XfQ3BhoJ54MAkCth0dAlup7k/bbnpZuc16Aj6ru+tc0ljcN0xU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=XVFp0mJi; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="XVFp0mJi"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49e66390995so14667615e9.2
        for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 03:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1789986153; x=1790590953; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4fxwc9lD9vYQ3/cjrLRCyVyxMKLryFLVyoMFOE+/2lY=;
        b=XVFp0mJiIUkK5p594V0+jbeDPZ4QBcj2N1B7IMrjjKx3Jq1kAyqwAai3SKjDf/PQgT
         Zt12KbQN8rxUQyomIiyxgjyT1ChrX45HPMtIk71gSy169p1pYnwAUqFf91F1ENPzAF5b
         6qC3vxm9USZUCi4AAT2Nq9/e22fLMMfSagB8ZJ0H/Xt/fQnyjgvvXCHYUXohr+HYzq7R
         KrQ09yNz56jNkR3RSrpcK3CKqPf9cj4z2eNcKOMROFtmZv4HM6NTlCmGxQVaty+IKPh2
         qhXIvTRxYiB3EBqI9cR5URggxs2nbvg6225/BCBZfP25v4bhMdhoK2YPMCDxrKqF5n18
         DQaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789986153; x=1790590953;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4fxwc9lD9vYQ3/cjrLRCyVyxMKLryFLVyoMFOE+/2lY=;
        b=Gor2epNK1prRIwU24v95kjcK4zsuWxb1/HIR1kdqlx6vLfIt9CdfI7I63fZsAQuir9
         PWHTc8v4DHp9v5rHGlOtEQCZdYPyVLZ7Um4tSs/WTH/l1S8ZiM/4Mp+7ywlfhHtxC5Ny
         XZf15NiG1znzC5R7JTewaltK8u1BhvjBhSOBEpc9/9zX2EdzsWBvdTTsEv7JYDgHPwme
         8D4aEG46g+WBODLSCMJFXh+GGzONo9X+A7KKm3uAfdJc9UhWPXyMj4KiuEZ+VUDVhepH
         3uwPQx50Y7GYITKAYbRrDY+doeXo63lAGNPKVTZnh41YhiG1yN/nhbTOCzk9fbD5wLVv
         RW3Q==
X-Gm-Message-State: AFuF++moIKJnmeMI7Afp4u3CvqA1LuXzzNCMI3tFCfysuSVZusSKBWqh
	kRjTcmLIjUTgRcQlHR1DsslYA+y9a6yl0BSRClSKRX2NR9fsgt60ErzulQ9vUwJNU7BI/sRhHgU
	wHwBXeudfHWf6lrPE69trw4lzfpg+cKwNRhbyFa0ZlVcZOy9PGzdOkFxRzh1au4x9Oyc=
X-Gm-Gg: AYBFou18e/aIz0FVluKtZV8Ooxs9pt4fptR86tPQEHflyhzarQNkZHcYDdreWIf/CHZ
	vAQCBQRaPN8I7F+XTYbs2GCiAnCQ+IR9bv1HXpht+acoc+OlDmsBzUgUcnGJ411auPcgBoA0cwU
	ia6GHql9DZUw/iuzhcJxKZYIjz+gwsqpWzTJ/HRzy57/jy9QK3lYKnkK4YyyZyX/4bR55r4KEBu
	sui45sUMx+afQc3aMy9cMH6nSNoW15JFCnebBNzV5uQPmS5msHFGWsiONDhleC9e6bGTSH52aGx
	US9gjLZ0VYxKDJZwLk9hIrBbSE7mdGCH1bTUlxAmSGe61oZzjXJ9gD2Z2xOMovUbpKtkT28yyru
	ctBezaLliOKLIkV2m8J3viZpW06JZz89NDEtKm2AmgNaIhHli4EOL0osgLhPNDni12of5eh/VFc
	laNjrdllGX0p/dGaK6Yc4JMxrdJx0AOSnLeNC73Bex+Pi8Qng0nptwo94MPpN0uLLOE0Rzaph4l
	GLDK3HmVAM=
X-Received: by 2002:a05:600c:6296:b0:49e:63cd:31fb with SMTP id 5b1f17b1804b1-49fc5714bdamr142984355e9.9.1789986148855;
        Mon, 21 Sep 2026 03:22:28 -0700 (PDT)
Received: from inifinity.mandelbit.com ([2001:67c:2fbc:1:b03b:2cfc:7208:2ecf])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48724583fffsm20925476f8f.23.2026.09.21.03.22.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 03:22:28 -0700 (PDT)
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
Subject: [PATCH net 10/11] ovpn: reject invalid peer VPN addresses
Date: Mon, 21 Sep 2026 12:22:11 +0200
Message-ID: <20260921102215.3599702-11-antonio@openvpn.net>
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

In MP mode, ovpn uses peer VPN addresses as lookup keys for selecting
the peer that should receive outgoing tunnel packets. The netlink
configuration path currently accepts address values that cannot sensibly
identify a VPN peer, such as multicast, broadcast or loopback addresses.

Reject invalid peer VPN addresses when creating or updating an MP peer.
Keep accepting the unspecified address as the internal unset value,
provided that at least one VPN address family remains configured.

Fixes: 1d36a36f6d53 ("ovpn: implement peer add/get/dump/delete via netlink")
Signed-off-by: Ralf Lici <ralf@mandelbit.com>
Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 drivers/net/ovpn/netlink.c | 55 +++++++++++++++++++++++++++++---------
 1 file changed, 42 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ovpn/netlink.c b/drivers/net/ovpn/netlink.c
index e9e0f75e0443..5432bc2eb8e8 100644
--- a/drivers/net/ovpn/netlink.c
+++ b/drivers/net/ovpn/netlink.c
@@ -185,6 +185,39 @@ static sa_family_t ovpn_nl_family_get(struct nlattr *addr4,
 	return AF_UNSPEC;
 }
 
+static int ovpn_nl_peer_check_vpn_addrs(const struct in_addr *addr4,
+					const struct in6_addr *addr6,
+					struct genl_info *info)
+{
+	int addr6_type;
+
+	if (addr4->s_addr == htonl(INADDR_ANY) && ipv6_addr_any(addr6)) {
+		NL_SET_ERR_MSG_MOD(info->extack,
+				   "at least one VPN IP must be configured in MP mode");
+		return -EINVAL;
+	}
+
+	if (ipv4_is_multicast(addr4->s_addr) || ipv4_is_lbcast(addr4->s_addr) ||
+	    ipv4_is_loopback(addr4->s_addr)) {
+		NL_SET_ERR_MSG_MOD(info->extack,
+				   "VPN IPv4 address must be valid unicast or any");
+		return -EADDRNOTAVAIL;
+	}
+
+	if (!ipv6_addr_any(addr6)) {
+		addr6_type = ipv6_addr_type(addr6);
+
+		if (!(addr6_type & IPV6_ADDR_UNICAST) ||
+		    (addr6_type & (IPV6_ADDR_LOOPBACK | IPV6_ADDR_COMPATv4))) {
+			NL_SET_ERR_MSG_MOD(info->extack,
+					   "VPN IPv6 address must be valid unicast or any");
+			return -EADDRNOTAVAIL;
+		}
+	}
+
+	return 0;
+}
+
 static int ovpn_nl_peer_precheck(struct ovpn_priv *ovpn,
 				 struct genl_info *info,
 				 struct nlattr **attrs)
@@ -387,12 +420,10 @@ int ovpn_nl_peer_new_doit(struct sk_buff *skb, struct genl_info *info)
 			vpn_addr6 =
 				nla_get_in6_addr(attrs[OVPN_A_PEER_VPN_IPV6]);
 
-		if (vpn_addr4.s_addr == htonl(INADDR_ANY) &&
-		    ipv6_addr_any(&vpn_addr6)) {
-			NL_SET_ERR_MSG_FMT_MOD(info->extack,
-					       "at least one VPN IP must be configured in MP mode");
-			return -EINVAL;
-		}
+		ret = ovpn_nl_peer_check_vpn_addrs(&vpn_addr4, &vpn_addr6,
+						   info);
+		if (ret < 0)
+			return ret;
 	}
 
 	peer_id = nla_get_u32(attrs[OVPN_A_PEER_ID]);
@@ -558,13 +589,11 @@ int ovpn_nl_peer_set_doit(struct sk_buff *skb, struct genl_info *info)
 	}
 
 	/* in MP mode VPN IPs are required for selecting the right peer */
-	if (ovpn->mode == OVPN_MODE_MP &&
-	    vpn_addr4.s_addr == htonl(INADDR_ANY) &&
-	    ipv6_addr_any(&vpn_addr6)) {
-		NL_SET_ERR_MSG_FMT_MOD(info->extack,
-				       "at least one VPN IP must be configured in MP mode");
-		ret = -EINVAL;
-		goto unlock;
+	if (ovpn->mode == OVPN_MODE_MP) {
+		ret = ovpn_nl_peer_check_vpn_addrs(&vpn_addr4, &vpn_addr6,
+						   info);
+		if (ret < 0)
+			goto unlock;
 	}
 
 	ret = ovpn_nl_peer_modify(peer, info, attrs);
-- 
2.55.0

