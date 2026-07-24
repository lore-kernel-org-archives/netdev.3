Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02BF2361959;
	Fri, 24 Jul 2026 15:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784905519; cv=none; b=H3boG4rDpsxU9S+qUjwTCkbkLsW1o3ZDy8KxnoolJ6TlgVC9p2lgfMmMnSnCdcHoDPwjNeuCMHlO8RPBFcosm4vOARHtqhckSYSaBi6j59AgBrNqZbdyo2KwMQB0rA6ASgWTPBU0RkXABYCtOTw02uG4RZPfnxO2LvBSco8hiWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784905519; c=relaxed/simple;
	bh=+tDRU5j9MC1ST/XsNsQZ34PN0tqnv4Q1qLAhMdaSTGE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=RABCmaVQBO+kF5G0dHMnQYea9u5YbCXSYurOB1OY7hpaV+TN3raQsP3pm+qB3MIR6wyPbFHzJwMgYZgCY20TzXreEadS911Xv7kuMiVpAmY4zl/TI+uMMPZ8tUdPzDnYXrtZ1rHzBL5Lxo+HQkKdJtCUN7wHSlB563sqndUe27g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=ZDCMC5BV; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="ZDCMC5BV"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-Id:Date:Subject:From:Reply-To:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=feshhfQ18MeWVktzGgn0fKtotqnBuVBRNdKIJXVvWWM=; b=ZDCMC5BVwSk5MsDdlNNZA34mhG
	JegFIrCYYDoVxdw1RybJw+5LJV0JlApwGBqZtKDYLvG3qRCkcA+2BWpjrHS/zgYnbXvZzzd9+wFvJ
	LrYvZdqfStKIu5lDXSW1jTd3QACWr5eas1ZMWiqV2CGZM4dheCptQ6abQDLj25zZstbuLD85izVzk
	W6hgaaEXC/VstM7KAe/uqCETwhVYmWzGLz3v5Kgtz5/zqO6OkD1ttISsxWfSj/3zry1pwUROYw+Ma
	YLybM4xlVmpbf4Sn3pCK8PLph40SaYuzQTYjdrxhiIh3beaD44z9OY9AB46hyhGbmglsA4HpFR5Cd
	N0SShyKw==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wnHSU-004dt1-2Y;
	Fri, 24 Jul 2026 15:05:07 +0000
From: Breno Leitao <leitao@debian.org>
Subject: [PATCH net-next 0/9] netpoll: finish untangling netconsole from
 netpoll
Date: Fri, 24 Jul 2026 08:04:08 -0700
Message-Id: <20260724-netconsole_move_more_final-v1-0-a5f7691db81c@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOh+Y2oC/x3MQQqDMBAF0KuEvzaQZKE0VylFbPy2A3ZSkiCCe
 PdSN2/5DlQWYUU0Bwo3qZIV0fjOIL0nfdHKjGgQXOjdELxVtpS15pXjJ29/CsdFdFptz+ecnGd
 K/obO4Fu4yH7ldyibVe4Nj/P8AddHhg12AAAA
X-Change-ID: 20260721-netconsole_move_more_final-6ebdc01ecc19
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 gustavold@gmail.com, asantostc@gmail.com, Breno Leitao <leitao@debian.org>, 
 kernel-team@meta.com
X-Mailer: b4 0.16-dev-d5d98
X-Developer-Signature: v=1; a=openpgp-sha256; l=1905; i=leitao@debian.org;
 h=from:subject:message-id; bh=+tDRU5j9MC1ST/XsNsQZ34PN0tqnv4Q1qLAhMdaSTGE=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqY38dx4oH9LBkWbUWYNVgJp8KaO8TVn7vxh2Pb
 gcE/RG4LZ2JAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCamN/HQAKCRA1o5Of/Hh3
 bfzFEACBnXjdPZ+FqYIZw9/VhUcLbbvv4VPEqWdUdP+ZwMlOO6kmj2b2/61wJoSD4loSYYn7I49
 M7Y5tmmL9tCRrkYf6g+qag2+LpGKECXTrnjnsIJRdCXRmlKPR1uKV87guxoMSX9unx7Be7m0r7C
 U4EMmzYf6AUCpxIjXQyeQla2dy7eblbxzVR9RbAmKhJ57CxDMryLSpu3hboxhjTGh7C9//VyzdX
 F0SViWIHXwiHSRHlJmvuwf5GBrJZnjt8U51/FAOdvmqUikbcQw9K21oDzGE8Lng0CWJwhz2y7UY
 Zrr5X6BrWMhXDsIM3xjVbWSiMLH7AuiGQB5i3V/mnbkqxAFgTzDBcGyvepBCHfvo1OSPTzmVJzn
 c27U9sn7210PWJsuYWJHz+UrzFKAFCkPvpvZgdAcpuLthL+BvQdEHZ0uNw8UzvKHoiex+WRGhL6
 JNQE8YmkrvdVA95WLPAUIfVZmzQOpuymi1Wt+UyUf2vk0n7OUfWuLmVmvBVUVt0VmR+i9vzTmEw
 zdTetvpxjJbnDKl814lbRPTVWtwZ/NWcvJhjq3Vx4tgLx9HGQne1V97L0D8bM7L7N/AhK31UsaO
 djXjiOIxB4gmX5iWw+ktxzBsQlyfgMI+pYmZuuWmg7jTzdSewbczFsvMQbDsJKBW2INjTVD/ymj
 +MRyHfhyFKxSYww==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao

This is the final series moving the netconsole-specific functions out of
netpoll and into netconsole.

There is nothing else left except struct netpoll ->name and ->dev_mac
fields, which are netconsole-specific fields, but they are still in
netpoll structure (no other netpoll user uses these two fields).

netpoll is now left simpler and with a clearer role: an API that takes
an skb and transmits it. The device setup and the local/remote address
handling that only netconsole needs no longer sit in the generic netpoll
code, but in netconsole (which was the only user).

struct netpoll gets leaner too. The netconsole-only fields are gone, so
the other netpoll users (bonding, team, bridge, vlan, macvlan, dsa) no
longer carry fields they never touch. (except ->name and ->dev_mac)

Signed-off-by: Breno Leitao <leitao@debian.org>
---
Breno Leitao (9):
      netpoll: export carrier_timeout via netpoll_get_carrier_timeout()
      netpoll: export the netpoll_setup() helpers for netconsole
      netconsole: take over netpoll_setup() from netpoll
      netconsole: move netpoll_local_ip_unset() as netcons_local_ip_unset()
      netconsole: move netpoll_take_ipv4() as netcons_take_ipv4()
      netconsole: move netpoll_take_ipv6() as netcons_take_ipv6()
      netconsole: move egress_dev() as netcons_egress_dev()
      netconsole: move local_ip/remote_ip/ipv6 to netconsole_target
      netconsole: move netpoll_wait_carrier() as netcons_wait_carrier()

 drivers/net/netconsole.c | 301 +++++++++++++++++++++++++++++++++++++++--------
 include/linux/netpoll.h  |   5 +-
 net/core/netpoll.c       | 210 ++-------------------------------
 3 files changed, 267 insertions(+), 249 deletions(-)
---
base-commit: 9eebf259d5352b87080d67758f483583d9e763d7
change-id: 20260721-netconsole_move_more_final-6ebdc01ecc19

Best regards,
--  
Breno Leitao <leitao@debian.org>

