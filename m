Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794247717;
	b=NLLhd0+aaMcmsDqvBMukFidR/5eFkYsICfYPZv1LfbJYUb5dmZDrpUtiRxYJpe3BOGbV
	 zFln5e0COwzmm8fHq3EYInIeg6V/I+61z4brDVVvfYrplhdHotQH6+Hc/6TwBxCjJUUVU
	 TzibfTfQWZo5MhI7LVzwVGbKQCS+TBLhizb3DA2nlQ5yuwYN+uG+y/HuDDZHLfVNxvl94
	 ZgJx1pPnRHCIr5hAzIaaVzdnVthTFXgHwzIFZxM2djd8Yxi7tydPizrB25PlKHH8NBmPg
	 goS9cT8RQD7UNSPBCR+ZZYYH77HCPKK5EWSVJBsZvLuuyRYy1fV78uqrMxBK3vFtRJw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794247717;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=MwztoYOv1J7zSH3DASjV2LVgTwtMR/2kc1J+u7Xr418=;
	b=j7KzrQLeMIfpWAMKyhO7BTP2z3NJimXgHs8eVSc+noZF8j6EWPXuESZOpfyxh8HjRDjL
	 srR6njwqqWLREHNa73HuANaueS0EH/ow7ZPYjvUwZ1fJ/3d3zrd4FvVyG+VsiqJtQ90/8
	 e9NcXDQPgtHGpZ0lOhrhHQdvlF4C8lEe1O9vyH3GRNUbLZQyFyegEW0lIo/q043bJMHiq
	 WCkPOfmt18TNfYijZ/zpOP49ftoE7XaB2QKBPuOYeaBA3VnhJkgBwV+UVe+cW41s8IM2o
	 3t9uS3I4TZZyIjURiG0a3AFRWCEygWjG1ZEKK6C/4+t7w3V7Z6QMKddF8UR5YBHssXQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jQ7nGnBQ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 849AD606A326;
	Mon,  9 Nov 2026 18:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jQ7nGnBQ
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794247717;
	b=piHM9qYpQxc1z6i8WitYGzPskgPP3i1A5Yqm9HNI/ImPFZkYO8Sj6VouDO+3pGysNr4u
	 Oq/L7EKslB5EGrzJBZ09K6fbMAweepC5fDb4Z3frLcnKRspKGPwbIrxZ+hpAvma58TEsz
	 dxNHgzew80cWaXHz3kjooORG6jjyJbG5iLbE9i3RSoB1SoyrXQTzvTo3F/q6mdgnsGzwH
	 3X5JmN5TnOznlOoLB1QaC7afXPiIDmJ3asKgCJ3toOrMgcFKfuCXa/BxkF5M/rkzIQi46
	 UC7C3hoor3YwZnDhcYG1m+ba0XVu+UswyzAt0nCn14Gob8VL59DOk1DnM5BHbBOeaWw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794247717;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=MwztoYOv1J7zSH3DASjV2LVgTwtMR/2kc1J+u7Xr418=;
	b=j7oekuo7U1f24vZArPDCfvhsmvVgyju/O3fll/MT7cTuV0KKCFZ3hBnQVkYrMYgL5qXC
	 HDoeM521oy1M5yEC6eawKqUz3m64mfftPjmrxMoG1GloYs4M5icJEtqWWw2scNe4UcyvP
	 l7bzqQ/poVpZP1aA1nKxuK9VPQMtaMs8pgu7Y9Crf64WcSnbiA/l/8y3edukdXV1zlivi
	 F5HX1vcYK0dqwZliA/y6lZhhZPNyboAxHRGl14jM32ZV328r/dEw+nYeNCkZnrdpknhac
	 jr0hhSivRj+YH/O2CpfyeR1hh90Az5YjmmXQYZFMQkg2gEsWlF6XdXEetKWXy2ZPskQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 8CA881F0089F;
	Mon,  9 Nov 2026 18:08:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794247717;
	bh=MwztoYOv1J7zSH3DASjV2LVgTwtMR/2kc1J+u7Xr418=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=jQ7nGnBQ2ePWQXquOfhEXf+j1cGzcx5gdDp6MsgshMjYn/km4ZZoM96nIFlAYADlo
	 HO79bxvhyIS8fS3xZFL4XvXqgSKpclGZCq4ViidoXjmwfvku50PEM9EuOhLurv9UEl
	 5c6lZX83RMJ06ImOZA97RFyf/DD25IpseSp9Liv4O4QTNQxgSi3IL5v3+NRgvw6Q6D
	 1DhwEiRUwde2tjkm4ivg3KH7hLTzOExZTOhhe+v6rAEhaFqXabto6xw32gCqWOVKPI
	 dWvCKYY+2D/re9GkBCsyuX3Y1ZuqDaG7HeMLpsqB1lmRp/ZlLtaPb3TedyPYE1EumE
	 efeAvycrts50Q==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 184D548598;
	Mon,  9 Nov 2026 18:08:36 +0000 (UTC)
From: Michael Baikov via B4 Relay <devnull+manpacket.gmail.com@kernel.org>
Date: Mon, 09 Nov 2026 13:08:35 -0500
Subject: [PATCH] net: sfc: run all the packets through GRO
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261109-sfc-udp-gro2-v1-1-025d385f007f@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MQQqAIBBA0avIrBtQM6GuEi1CR5uNhVIE4t2Tl
 m/xf4VCmanAIipkerjwmTrUIMAde4qE7LtBS22VkjOW4PD2F8Z8ajST9cGNwRmroSdXpsDvv1u
 31j4fSpf2XgAAAA==
X-Change-ID: 20261109-sfc-udp-gro2-456dfc3fc462
To: Edward Cree <ecree.xilinx@gmail.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-net-drivers@amd.com, 
 linux-kernel@vger.kernel.org, Michael Baikov <manpacket@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794247715; l=2263;
 i=manpacket@gmail.com; s=20261015; h=from:subject:message-id;
 bh=0rd7K8H1ssa2d09oUpAQlHIjcPRA+ZoTgwxPqrVR7J0=;
 b=M6QcjD2zL+tYeQHO/aGWNAsCfzpoTvIoK02dBnEqGiVReRDgxClyyVRmtPynCI4SvPUlORNGL
 xJyVjCkKUOUDCNOkECX1efjh7M7nZqO3V2F7iD+murSrNAjxKQ1tNKJ
X-Developer-Key: i=manpacket@gmail.com; a=ed25519;
 pk=OljyhmMnK5zdnRB5D/BzDCrh2eycv9FSkJB+r1/MtzM=
X-Endpoint-Received: by B4 Relay for manpacket@gmail.com/20261015 with
 auth_id=1197
X-Original-From: Michael Baikov <manpacket@gmail.com>
Reply-To: manpacket@gmail.com
Content-Transfer-Encoding: 7bit

From: Michael Baikov <manpacket@gmail.com>

This commit partially undoes changes made by the commit e79255de8581
("sfc: Do not pass non-TCP packets into GRO code"). Those changes made
sense back then, but now GRO can help with more message types. Now, when
GRO is enabled - pass all the messages though GRO subsystem.
Tested on SFC9250 with a UDP_GRO socket.

Signed-off-by: Michael Baikov <manpacket@gmail.com>
---
Problem I'm trying to solve: I'm dealing with high data rate, small
message size multicast UDP traffic - uniform size, addresses - a perfect
candidate for UDP Generic Receive Offload (GRO). Made a prototype - it
worked as expected on the desktop during development, but wasn't
producing any GRO coalesced messages on the server.

The server uses SFC9250 and turns out its driver only allows GRO for TCP
packets. Change was made back in 2013.

Expected user impact:

1. GRO will start working for UDP
2. It might add a slight overhead for UDP traffic for e10 drivers.
   (this bypass only exists for e10 drivers, for e100 (ef100_rx.c:140)
   packets are passed to GRO unconditionally

First version of this patch tried to pass only UDP and TCP messages
though GRO, but since it's unlikely to have a high volume traffic that
is neither of those two - this version simply drops "is TCP?" check.

Link: https://lore.kernel.org/all/20261018-sfc-gro-udp-v1-1-f7bf378178f8@gmail.com/
---
 drivers/net/ethernet/sfc/rx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/sfc/rx.c b/drivers/net/ethernet/sfc/rx.c
index ffca82207e47..9874093944f8 100644
--- a/drivers/net/ethernet/sfc/rx.c
+++ b/drivers/net/ethernet/sfc/rx.c
@@ -401,7 +401,7 @@ void __efx_rx_packet(struct efx_channel *channel)
 	if (unlikely(!(efx->net_dev->features & NETIF_F_RXCSUM)))
 		rx_buf->flags &= ~EFX_RX_PKT_CSUMMED;
 
-	if ((rx_buf->flags & EFX_RX_PKT_TCP) && !channel->type->receive_skb)
+	if (!channel->type->receive_skb)
 		efx_rx_packet_gro(channel, rx_buf, channel->rx_pkt_n_frags, eh, 0);
 	else
 		efx_rx_deliver(channel, eh, rx_buf, channel->rx_pkt_n_frags);

---
base-commit: fa5196392691051963726787944db872420dfa75
change-id: 20261109-sfc-udp-gro2-456dfc3fc462

Best regards,
-- 
Michael Baikov <manpacket@gmail.com>


