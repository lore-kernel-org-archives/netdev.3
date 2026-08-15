Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5527381ACD;
	Sat, 15 Aug 2026 10:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786789313; cv=none; b=EnGGc66P4ydpxb/9Q+b0/SE94cFUQRRUiUUqxD2SkNN8CzHApR9VL9ruSiEnyikBIAF/XeDTBVU5D5VAcT5ZP9oyA8b+CZkRFyECPar9/xs3R9tg756Rqe3hANXTow9K7+pKfTX4iCFKyojaZvIMGdtQ0Vkb9xMD8o1g6ykqRF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786789313; c=relaxed/simple;
	bh=dnnrYBTkZE31eTlgNRFbSh/RxXHTUQJ9xNeGGYlJfsQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=EDONRtEe/enPdZz+tULac8Ib2O2Y6ppkOEKSFMYJTfYsdhdvBRBBK0HE5Zw4mWiSuk5DxUgNxPZxzonz9tOZlbQA70hVJGP2mEpUP1AwLgafj7ZXQZ9SvHZU404Av8Cd6mWVvCu049RVblBBIRzmll3iRf5eC+G+XSfcHVYyQss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u1ekKOFs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u1ekKOFs"
Received: by smtp.kernel.org (Postfix) with ESMTPS id DB6EFC19425;
	Sat, 15 Aug 2026 10:21:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1786789312;
	bh=dnnrYBTkZE31eTlgNRFbSh/RxXHTUQJ9xNeGGYlJfsQ=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=u1ekKOFsPKxmHv/kFlq6y5MTwv1yU2Y0fV+9i0qv6nn9oHC4+y/PZ2JjdLTxxdwCO
	 X9JZlsicwGZr6e/qV3bWzDyJomnjaRcDWCwAzBZ4JMc2iuGZn6ECYETBJJfUrqslU8
	 3obyBjLeSh3YDBSBepwj+0yWEbY/pWXmRgKdI6VyMObOYa4mc0jvGfT45IeL9VCRwy
	 rvRqoa171Ir7yMPrfTD0Yn7phnEJJoyzVWNI3BcRTH7PCDkYmA1RfXevelrrOlb4tw
	 ZGVWQSR0aVvweooxqr6H604gux7Odzg5xCURg5MTVgEIy8v4Caa0SiJR1RT5/MobGQ
	 FYWLTfrisWCNw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6251C5AD5A;
	Sat, 15 Aug 2026 10:21:52 +0000 (UTC)
From: Fan Ye via B4 Relay <devnull+fy15309206903.gmail.com@kernel.org>
Date: Sat, 15 Aug 2026 10:21:52 +0000
Subject: [PATCH net] net: thunderbolt: Count delivered packets in
 rx_packets and rx_bytes
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260815-tbnet-rx-stats-v1-1-8da375c2cd09@gmail.com>
X-B4-Tracking: v=1; b=H4sIAL89gGoC/yWMSw7CMAwFr1K9NZaS0PC7SsUibQ2YRUCxQZWq3
 p3QLufpzcxQLsKKSzOj8FdUXrmC3zUYHinfmWSsjODCwZ18JOszG5WJ1JIp7dt0Hl1sfYhHVOl
 d+CbTGuxQn7huo376Jw/2T2FZfgw9GvF3AAAA
X-Change-ID: 20260815-tbnet-rx-stats-34a9d0541257
To: Mika Westerberg <westeri@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@google.com>, 
 Yehezkel Bernat <YehezkelShB@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 Fan Ye <fy15309206903@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786789311; l=2398;
 i=fy15309206903@gmail.com; s=tbnet3; h=from:subject:message-id;
 bh=CngaDMizcsyLGQUAKShYaKxlan6ft6mp+j8UUKsqMCU=;
 b=yEKH7ZEau1FUm3tk0qz+Xs0t/095yYSIq1bHYZ4q4zV7c4V1FQypCQqrHU1wZuuYnTaXXjsRN
 /Lr0NNVz/iXALRalNYf1h3/PWQ5QY8o4VxqfVauiMAGH+oht+9JH7Ux
X-Developer-Key: i=fy15309206903@gmail.com; a=ed25519;
 pk=6QsQIrI/kruYWIJyCH9ntPMXsHCqF5JtK/DCMtOCzdc=
X-Endpoint-Received: by B4 Relay for fy15309206903@gmail.com/tbnet3 with
 auth_id=929
X-Original-From: Fan Ye <fy15309206903@gmail.com>
Reply-To: fy15309206903@gmail.com

From: Fan Ye <fy15309206903@gmail.com>

tbnet_poll() increments rx_packets once per received frame because that is
the NAPI work unit, and then adds the same number to stats.rx_packets. An
skb is handed to the stack only when the last frame of a packet arrives,
so once the MTU exceeds TBNET_MAX_PAYLOAD_SIZE the statistic reports
frames. tx_packets is bumped once per skb, so the two ends of a link
disagree: at MTU 65330 the receiver reports 16 times the packets its
sender sent.

rx_bytes has the matching problem: frames of a packet that is later
dropped mid-assembly are already accounted, so it does not correspond to
rx_packets as documented. Account for both where the packet is completed,
and leave the NAPI work counter alone.

Fixes: e69b6c02b4c3 ("net: Add support for networking over Thunderbolt cable")
Assisted-by: Claude:claude-opus-5
Signed-off-by: Fan Ye <fy15309206903@gmail.com>
---
Seen at MTU 65330 on an ASM4242 host-to-host link, where a packet is 16
frames. On the receiver rx_bytes/rx_packets came out at 4083.9, i.e.
TBNET_MAX_PAYLOAD_SIZE, and rx_packets ran 15.9x the IP layer's InReceives;
with the patch they are 65308.3 and 0.99. At the default MTU a packet fits
in one frame and the counters already agree, which is why this went
unnoticed.
---
 drivers/net/thunderbolt/main.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/thunderbolt/main.c b/drivers/net/thunderbolt/main.c
index 98893732bc6e..43ee896f1b17 100644
--- a/drivers/net/thunderbolt/main.c
+++ b/drivers/net/thunderbolt/main.c
@@ -892,9 +892,11 @@ static int tbnet_poll(struct napi_struct *napi, int budget)
 		       le32_to_cpu(net->rx_hdr.frame_count) - 1;
 
 		rx_packets++;
-		net->stats.rx_bytes += frame_size;
 
 		if (last) {
+			/* Before eth_type_trans() pulls the Ethernet header. */
+			net->stats.rx_packets++;
+			net->stats.rx_bytes += skb->len;
 			skb->protocol = eth_type_trans(skb, net->dev);
 			trace_tbnet_rx_skb(skb);
 			napi_gro_receive(&net->napi, skb);
@@ -902,8 +904,6 @@ static int tbnet_poll(struct napi_struct *napi, int budget)
 		}
 	}
 
-	net->stats.rx_packets += rx_packets;
-
 	if (cleaned_count)
 		tbnet_alloc_rx_buffers(net, cleaned_count);
 

---
base-commit: dac3e89a2c90c2feeb471e1f22a2512ad424b792
change-id: 20260815-tbnet-rx-stats-34a9d0541257

Best regards,
--  
Fan Ye <fy15309206903@gmail.com>


