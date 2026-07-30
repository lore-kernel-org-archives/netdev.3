Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB2F23F8257
	for <netdev@vger.kernel.org>; Thu, 30 Jul 2026 09:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785404797; cv=none; b=FGKyLcaSnoIwQbocyxn35wzgvauUl+XJh8NyG4mvSuJz+5ae+wTGRAbBWmwIiDj1ygWNwNuqkeBYmJc+7DvXiEu3Sb19s2HRXZ+be6wBHWsphaVdHsSERGF4dt5aEOChhwJdEQT+W60opplTsAIAzTNibHbJlhHuZqZYQtPQu4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785404797; c=relaxed/simple;
	bh=eErbmbzF0p+Ymvxi2rWlK7tHjT3lb4LsRDu48s3ll/s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WJZ4LqhAEJSJHO8xDqQwiywXI3JeRrvTCNpXjlS+5SkSK9RkeuFmv+bu0FVBTaTY8Aze0dbLRXpBLh9zrf4G+Hhgb0mTVpssQZCtvG9O9RO7S6SsYBR98CPYguBHNRO9diAhNCHcbNJroLqqvAvszSSMOOD3bXrKAtvz6FnYBUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=AJw8X4ha; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="AJw8X4ha"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-471eeac43bfso1751069f8f.3
        for <netdev@vger.kernel.org>; Thu, 30 Jul 2026 02:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1785404794; x=1786009594; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ANuF36uLeJZqBWVbJg0BQItKy/nIiK9wSozqm5stJ70=;
        b=AJw8X4haJpMM+i8MKbDs4zHZrqQnXCQf9N/gBYBD84+t3RDt6MBtCMs4pWj7fJU28R
         z3WZVUdqqsMysQU8fiXVO1cr1F0IO+QOcDMKjSLOgFB6x3eA98Bu1g/NBFo+/bsses4W
         CDHZxMKBdSTEKTwDuong04DsYV2OA60jC52KHN0N/NdSPcNxEs/mlFObePL++2NzvI4V
         Ed50ayUsOqU7LIp6L8ZcRqTT/kwgz8Kd7YZe5lsm17TufRDJfBhTQKvoAQtb6+CQXzcT
         4rWrHJveYSOksJM/LvoSZWR/Rpt4qBr8P9ZlsbdmQDScsHBuehmxbinlZSulRAnrhXTq
         7koQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785404794; x=1786009594;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ANuF36uLeJZqBWVbJg0BQItKy/nIiK9wSozqm5stJ70=;
        b=r2oMsyh9pJq//bSJcpR+6Te2eNhh7bj0mL1+b9iy6E8g2A/l74hegbXhfqBiVmUL0N
         J5+L+DPy7wiLzqpC9g3c0BMSe3Kjpz39JoB4uJOu5gEwnol/nsoRt+aUOJ/QppmIN45f
         mJ0oPpzuuNem9v7+FdE1E1hqwVfRefzT7nc9NSjB/Xyj1SyrMDBBflURXpmKb5ICZj3l
         ylXEHr0lr/Xtq2EXNBKfMCMKyLgGheZWa0lzbHvRcDusjrAD1XkmcTgX+bJQm9d04ZD2
         TSmn5xsCkzua/Tzk371ymq5wkoF3r8zRm0plimeLuE2rv1bUUN4KROW8gsg4hpd3c0KU
         Ny8w==
X-Gm-Message-State: AOJu0YwSwtn+X0tEFCS27z0THM41IcmB3/vr0LDtNasmbfRK2iau1vb0
	IF49NU88/zASOmqQcxccsvkGW3JdoSAQjFNSe1Rgwl9+lPnV4eO05JxabUyZihbMko2vqjYEPxQ
	f21zt1nGUbMtm4xAKeg6w58Qhrl2ugvpEO4lbBai05jqZs924kbz3UQ/DyGu2BBrl
X-Gm-Gg: AR+sD13P/h3ygsHLL7JPFh2vcZXLDO1zL+zkXk99scp3J2YuubOYsxSYxz1F/rh+qIa
	AjgFmhUU4eKgSG6bZtlUNan7Fyn2VszKkT0AfwPUsX2qXSboUc0vm99RXrnItEuvQ6EmDNKZ/BQ
	hQLhGaap8SHSRGEseNcln14jcWg0MY0XolhmbPtX4PqB8cbJ12EjQbuD0SVZjucgH2W6gKvZy2R
	c47MCAze7YGzRcVTpoV0L0h2KoKIVYFZ+A6ajZ/Ge0WNXHjSJuqOSkVeDwphXKpRAysFaDDkwqc
	aXxfsy5zFyjeKxy3EoWz02yKrxiFix5ypktKqzpkOn7kRKUwT9ETACKeAHkxEGM54/djdXysgB0
	DhADxe8S7Msg0SCkB+hz5A3b26mqan66TBUZTgynFGmBUBubk1zhMSt8go5Rbz11+i/v7k2Fe2A
	Xd3bV84/xkxEirYiYZEblL//QOkpxndQIMoF1dKv7kHaQlUmhEn0n/1KpiB6FZBP8WSM1u0cspD
	A==
X-Received: by 2002:a05:6000:381:b0:47d:f01e:83cf with SMTP id ffacd0b85a97d-47fc821708bmr2550992f8f.58.1785404794080;
        Thu, 30 Jul 2026 02:46:34 -0700 (PDT)
Received: from inifinity.mandelbit.com ([2001:67c:2fbc:1:97f0:8a89:3637:d698])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fc88e424fsm6971410f8f.14.2026.07.30.02.46.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 02:46:33 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: Marco Baffo <marco@mandelbit.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Ralf Lici <ralf@mandelbit.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Antonio Quartulli <antonio@openvpn.net>
Subject: [PATCH net 02/10] ovpn: limit keepalive values to one day
Date: Thu, 30 Jul 2026 11:46:13 +0200
Message-ID: <20260730094624.4102963-3-antonio@openvpn.net>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260730094624.4102963-1-antonio@openvpn.net>
References: <20260730094624.4102963-1-antonio@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Marco Baffo <marco@mandelbit.com>

Large keepalive values can overflow the delayed-work delay on 32-bit
systems, causing the keepalive worker to be repeatedly scheduled.

A correct configuration should not require such large keepalive values,
and an upper limit of one day is already generous and unnecessary in
practice. Limit both the keepalive interval and timeout to 86400 seconds.

Signed-off-by: Marco Baffo <marco@mandelbit.com>
Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 Documentation/netlink/specs/ovpn.yaml |  4 ++++
 drivers/net/ovpn/netlink-gen.c        | 20 ++++++++++++++------
 2 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/Documentation/netlink/specs/ovpn.yaml b/Documentation/netlink/specs/ovpn.yaml
index b0c782e59a32..ac50d1d7c00a 100644
--- a/Documentation/netlink/specs/ovpn.yaml
+++ b/Documentation/netlink/specs/ovpn.yaml
@@ -118,12 +118,16 @@ attribute-sets:
         doc: >-
           The number of seconds after which a keep alive message is sent to the
           peer
+        checks:
+          max: 86400
       -
         name: keepalive-timeout
         type: u32
         doc: >-
           The number of seconds from the last activity after which the peer is
           assumed dead
+        checks:
+          max: 86400
       -
         name: del-reason
         type: u32
diff --git a/drivers/net/ovpn/netlink-gen.c b/drivers/net/ovpn/netlink-gen.c
index 2147cec7c2c5..92d2fdc17c2e 100644
--- a/drivers/net/ovpn/netlink-gen.c
+++ b/drivers/net/ovpn/netlink-gen.c
@@ -16,6 +16,14 @@ static const struct netlink_range_validation ovpn_a_peer_id_range = {
 	.max	= 16777215ULL,
 };
 
+static const struct netlink_range_validation ovpn_a_peer_keepalive_interval_range = {
+	.max	= 86400ULL,
+};
+
+static const struct netlink_range_validation ovpn_a_peer_keepalive_timeout_range = {
+	.max	= 86400ULL,
+};
+
 static const struct netlink_range_validation ovpn_a_peer_tx_id_range = {
 	.max	= 16777215ULL,
 };
@@ -68,8 +76,8 @@ const struct nla_policy ovpn_peer_nl_policy[OVPN_A_PEER_TX_ID + 1] = {
 	[OVPN_A_PEER_LOCAL_IPV4] = { .type = NLA_BE32, },
 	[OVPN_A_PEER_LOCAL_IPV6] = NLA_POLICY_EXACT_LEN(16),
 	[OVPN_A_PEER_LOCAL_PORT] = NLA_POLICY_MIN(NLA_BE16, 1),
-	[OVPN_A_PEER_KEEPALIVE_INTERVAL] = { .type = NLA_U32, },
-	[OVPN_A_PEER_KEEPALIVE_TIMEOUT] = { .type = NLA_U32, },
+	[OVPN_A_PEER_KEEPALIVE_INTERVAL] = NLA_POLICY_FULL_RANGE(NLA_U32, &ovpn_a_peer_keepalive_interval_range),
+	[OVPN_A_PEER_KEEPALIVE_TIMEOUT] = NLA_POLICY_FULL_RANGE(NLA_U32, &ovpn_a_peer_keepalive_timeout_range),
 	[OVPN_A_PEER_DEL_REASON] = NLA_POLICY_MAX(NLA_U32, 4),
 	[OVPN_A_PEER_VPN_RX_BYTES] = { .type = NLA_UINT, },
 	[OVPN_A_PEER_VPN_TX_BYTES] = { .type = NLA_UINT, },
@@ -97,8 +105,8 @@ const struct nla_policy ovpn_peer_new_input_nl_policy[OVPN_A_PEER_TX_ID + 1] = {
 	[OVPN_A_PEER_VPN_IPV6] = NLA_POLICY_EXACT_LEN(16),
 	[OVPN_A_PEER_LOCAL_IPV4] = { .type = NLA_BE32, },
 	[OVPN_A_PEER_LOCAL_IPV6] = NLA_POLICY_EXACT_LEN(16),
-	[OVPN_A_PEER_KEEPALIVE_INTERVAL] = { .type = NLA_U32, },
-	[OVPN_A_PEER_KEEPALIVE_TIMEOUT] = { .type = NLA_U32, },
+	[OVPN_A_PEER_KEEPALIVE_INTERVAL] = NLA_POLICY_FULL_RANGE(NLA_U32, &ovpn_a_peer_keepalive_interval_range),
+	[OVPN_A_PEER_KEEPALIVE_TIMEOUT] = NLA_POLICY_FULL_RANGE(NLA_U32, &ovpn_a_peer_keepalive_timeout_range),
 	[OVPN_A_PEER_TX_ID] = NLA_POLICY_FULL_RANGE(NLA_U32, &ovpn_a_peer_tx_id_range),
 };
 
@@ -112,8 +120,8 @@ const struct nla_policy ovpn_peer_set_input_nl_policy[OVPN_A_PEER_TX_ID + 1] = {
 	[OVPN_A_PEER_VPN_IPV6] = NLA_POLICY_EXACT_LEN(16),
 	[OVPN_A_PEER_LOCAL_IPV4] = { .type = NLA_BE32, },
 	[OVPN_A_PEER_LOCAL_IPV6] = NLA_POLICY_EXACT_LEN(16),
-	[OVPN_A_PEER_KEEPALIVE_INTERVAL] = { .type = NLA_U32, },
-	[OVPN_A_PEER_KEEPALIVE_TIMEOUT] = { .type = NLA_U32, },
+	[OVPN_A_PEER_KEEPALIVE_INTERVAL] = NLA_POLICY_FULL_RANGE(NLA_U32, &ovpn_a_peer_keepalive_interval_range),
+	[OVPN_A_PEER_KEEPALIVE_TIMEOUT] = NLA_POLICY_FULL_RANGE(NLA_U32, &ovpn_a_peer_keepalive_timeout_range),
 	[OVPN_A_PEER_TX_ID] = NLA_POLICY_FULL_RANGE(NLA_U32, &ovpn_a_peer_tx_id_range),
 };
 
-- 
2.54.0

