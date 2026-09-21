Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18CB93B47E1
	for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 10:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789986142; cv=none; b=eTXBQi87+vqEBpMt16BJ8E5fU66DabzsFoBM1ty4JT5YDIn0CQrMyB5C5Ae3P0HeHelYt9l0JtMzijXihB7qeqJD4YHbLzr1nTLFJYnGLe1YKnVwlEsnTN1kYi412u12LkPGUkYVUo2wFXPTXUHyCmMlTzAka42FSFLVMXQUfcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789986142; c=relaxed/simple;
	bh=XyJEhvEbk2ThZZFN2P39VzdGo4IIdzXSwfhx6R84vIs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W7QBMIwFketoSzSwtZ8Yy9rV3NH22qb/3Vp8zbwhdjZ9SS2v4EFOVK2F32JWnDekwDmVMVoJ7BCAM6fYh70tk8d8oQIbiDcaJ9WYDOD7j8hSBfBHqH7kd/TvHcdoi4qbPvQluI95J+YNxoTE4D0RJm+y24EA5jyL2pPmCn8ZLqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=OYI3F/bK; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="OYI3F/bK"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-4843e397f74so1346223f8f.1
        for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 03:22:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1789986139; x=1790590939; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YBV07tsczaVwq2cMtubNOM342LvX5qJ7CVK4Vn+lzX8=;
        b=OYI3F/bKWzqUE2ixBCBfkbjCCL8iBXCeAhWSUD4G6NmDMcxs1HF7CMwt5gBJyglFJA
         lsNp/I4cYCbaNQLYj2VQe5xzpEccgdPFwQ0YNo4Ois+UF9gG5u+moPAlIYElx/1PTWv/
         Wm6Z6snxYzyxexx/fByVS/ziXDpgsOYqfyi0rrCvd9Ke3THZeyOYKleNhfzkL8bxQx8s
         Rbs3gdH/86RLhWpvaa1iYpfgrMaCu1kqNiZktCp0oEtieKWYIi8Sn7D8ij6xNHoTdEfI
         2mjLYkcqTH5O8F3fm6E9yIIIZ/ZK23aUfIDzcoZ9C0lIcn5AtEGnYek14oISyJCL1g61
         AcLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789986139; x=1790590939;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=YBV07tsczaVwq2cMtubNOM342LvX5qJ7CVK4Vn+lzX8=;
        b=DCVv0Ptnq9qvLLfHlZ+lIPPYjdVqJ34SqC47JLwke5/lxtw90BnsMtrLo5acDqxPPF
         HswtdR9rqWqnhJAUef2latVzyTgevotkiD9MNoQPsaRjStXZtsQRRVMYNIFABi7STQaT
         kmIXgu5+zrhvuYFC3PGHvFwZBJ56ADpqGHxJNJCEu7FKT4Kb1OHApk6JaZWFTkaNYVdc
         BLRM9HMuss0ZNcpzY4Ua3WDouL2GG8ki/h3v0Ji4CyLJbDYhhor9kzJpUo3///9/QHui
         OlwcYaQqk5OCV/igbsGFQJjYT9FVPhaE0P/ewriIC6tLJ2AwNPjnEvQx6xnpHP047Hce
         JSGQ==
X-Gm-Message-State: AFuF++mVSMD1TdGybSGkRDpJXYOrseGHCKlyUTpYVTyikoTBLJhxDYop
	nP3C+M2bi6FJOakJFbPul7FF5Nc0h9HLpzHAlay3Dg5WBX19x8x3vCrVbMrGpPcUwOtJdJO9hmi
	JVRoEz+wD/qD2XNQ40Le0A1LUL3vEs34vFnQ5AkQdAcI3aKV+GJAhewmgVZHPv5aeLNE=
X-Gm-Gg: AYBFou2slv2Ms4hWkMuAiITgM5cMJ0TdkXgoA1+Cjz3EvBALMt9bSXHwFrLDdkMxFxS
	LhJcv21hlH4E3iska/RABYY3gwpzjEAIsZWjAIRcKVbE7E+K4X7O52C/lbXmrq0I6q1a2zTGPlu
	XONDwJm2cx6uPpjQ4xLBRnOIoyaKQ1T0sa5gmCzc3BQ3eLwsjvebM3dVET7PPPY5quHC1qtZsKC
	R33m9eC2wY1U8iK42jjngFfHoDblcw9odm/D973agd+H0AEapZVhLEl2vFJ3seV2oqB3ZrUeRUI
	dxruI2pHXLiICGdQUG6hcpzXDY1j9WA8AlRNGcsuFk9EospeeOPDuM1rbSLkYstvd2w1OXTajJt
	BJaIZy3FiePnGPM8TdfbYw2QUPzSFx6zjiEwS2Zs8vUkxm0vy7ConG2FU8rKLH5S4YlI/BHuyzZ
	Lz6uHV1E0I2WHrHht8LrPcCyrYkYkgGacbEfnvAa8NvzKQJhRUnN79rqds7MgO3NM8j5FQaFTsz
	7+KHFxZX38=
X-Received: by 2002:a5d:6f06:0:b0:485:8d9c:47d2 with SMTP id ffacd0b85a97d-48713c7ef38mr22682883f8f.30.1789986139231;
        Mon, 21 Sep 2026 03:22:19 -0700 (PDT)
Received: from inifinity.mandelbit.com ([2001:67c:2fbc:1:b03b:2cfc:7208:2ecf])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48724583fffsm20925476f8f.23.2026.09.21.03.22.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 03:22:18 -0700 (PDT)
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
Subject: [PATCH net 01/11] ovpn: preserve IPv6 scope id for netlink peer endpoints
Date: Mon, 21 Sep 2026 12:22:02 +0200
Message-ID: <20260921102215.3599702-2-antonio@openvpn.net>
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

ovpn accepts OVPN_A_PEER_REMOTE_IPV6_SCOPE_ID and reports
bind->remote.in6.sin6_scope_id in peer dumps, but the netlink endpoint
parser never copied the attribute into the sockaddr_in6 used to create or
update the peer bind.

As a result, an IPv6 link-local remote endpoint configured through
netlink loses its interface scope, unlike on the peer float path where
ipv6_iface_scope_id populates the field. The UDPv6 output path then
builds a flow with flowi6_oif set to zero and route lookup can fail or
select the wrong interface.

Copy the scope id when parsing non-v4-mapped IPv6 remote endpoints. The
existing precheck already rejects the scope-id attribute for IPv4 and
v4-mapped IPv6 remotes.

Fixes: 1d36a36f6d53 ("ovpn: implement peer add/get/dump/delete via netlink")
Signed-off-by: Ralf Lici <ralf@mandelbit.com>
Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 drivers/net/ovpn/netlink.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ovpn/netlink.c b/drivers/net/ovpn/netlink.c
index 4dad85294198..2ba762082acc 100644
--- a/drivers/net/ovpn/netlink.c
+++ b/drivers/net/ovpn/netlink.c
@@ -100,6 +100,8 @@ static bool ovpn_nl_attr_sockaddr_remote(struct nlattr **attrs,
 	struct sockaddr_in6 *sin6;
 	struct sockaddr_in *sin;
 	struct in6_addr *in6;
+	struct nlattr *scope;
+	u32 scope_id = 0;
 	__be16 port = 0;
 	__be32 *in;
 
@@ -114,6 +116,9 @@ static bool ovpn_nl_attr_sockaddr_remote(struct nlattr **attrs,
 	} else if (attrs[OVPN_A_PEER_REMOTE_IPV6]) {
 		ss->ss_family = AF_INET6;
 		in6 = nla_data(attrs[OVPN_A_PEER_REMOTE_IPV6]);
+		scope = attrs[OVPN_A_PEER_REMOTE_IPV6_SCOPE_ID];
+		if (scope)
+			scope_id = nla_get_u32(scope);
 	} else {
 		return false;
 	}
@@ -126,6 +131,7 @@ static bool ovpn_nl_attr_sockaddr_remote(struct nlattr **attrs,
 		if (!ipv6_addr_v4mapped(in6)) {
 			sin6 = (struct sockaddr_in6 *)ss;
 			sin6->sin6_port = port;
+			sin6->sin6_scope_id = scope_id;
 			memcpy(&sin6->sin6_addr, in6, sizeof(*in6));
 			break;
 		}
-- 
2.55.0

