Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.139
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794452201;
	b=v1niYFb8CiSmUO87BKtMPRsUvkHut6C18oF+ITPfUxmUekoD9QwAtUd6eIqncEApcSJt
	 cdjlpygNYtx6254w5lFXdjHffl+c0m3BjUCrzy0j+SpoeH8QJavxIvo41ce5LnpbOaCg9
	 6gG8nyK8KQpP+VaAJSr3AQJfkpnclj2QSsvTtaJQKrX9Sm9OPOzWXzn2zJ3LQEPWkp+Zt
	 doSpWvGKwnIGrS1Hu1kz88kilAYGMygeeWoOyzXzhJfTOSM4i/w6jBE9uM4JCqJf4uWOx
	 2e4vG6R1KWB+Hdd/TgOTYrM0DaalC2/JlHtJAOiAaFtzaHwtQ6la/ndRgspEKGa5vJQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794452201;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=tKSHqUk0GSjoSBQpz1LCTjajF+gY+daRXTmFNx1JhFM=;
	b=LOW4lwkWGBlE3xLsv1E8LHhP7Mh6dxSM4LRHkM1h5Ln1gh3S2PKOR23XIaPvH3NXNJFZ
	 6QR4v+T3E8W8xROzGSG7pugcCsjT+wg88j9oDuWx57WcQTK/hV1X1W7hJ/V9p5rIxIcWB
	 bdCPaJorS3AuzONVzluQdrQOPwbF10IpupTh92lQcBjk4SkhKHug/efVW/rDHvYaBW1WQ
	 h7k62xl8PLu4tc5r4DChnbr/ATsk+sMuoTIKo6GMX273EWzpe2JzAsfFnrER96PUklUxp
	 jxoseBWzmQPKomsUA7UvrLzshE2nWnk8VjDlX1VELwL3F/7GDk1SbzU48/gHinvRj7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=he6+57ME;
	arc=none smtp.remote-ip=111.22.67.139
Received: from cmccmta6.chinamobile.com (cmccmta6.chinamobile.com [111.22.67.139])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD321606A321;
	Thu, 12 Nov 2026 02:56:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DD321606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=he6+57ME
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=he6+57MEQG9X6fTbPNdnRaEp/vXEMYddxUJaXZjQEWnQ4Lm+UL/zIM2ZXktzv4Y64k445HZWJ3/CY
	 en9qrhMsK6raumJuN6tf0W3flhIa4pLzUG2V2mKrgANdr0OWec1NHPolngjEQRp8HsdCIvSrCobwZ2
	 BwQszqg9SMV8LaWk=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app05-12005 (RichMail) with SMTP id 2ee56af52ae0e38-da544;
	Thu, 12 Nov 2026 10:56:32 +0800 (CST)
X-RM-TRANSID:2ee56af52ae0e38-da544
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from  (unknown[223.108.79.101])
	by rmsmtp-syy-appsvr09-12009 (RichMail) with SMTP id 2ee96af52adee4f-f02ee;
	Thu, 12 Nov 2026 10:56:32 +0800 (CST)
X-RM-TRANSID:2ee96af52adee4f-f02ee
From: Xia Yan <yanxia@cmss.chinamobile.com>
To: netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	maheshb@google.com,
	arnd@arndb.de,
	kaber@trash.net,
	dskr99@gmail.com,
	linux-kernel@vger.kernel.org,
	yana06070@163.com
Subject: [PATCH net-next v2 2/2] macvlan: fix RX byte accounting for local broadcast and multicast
Date: Thu, 12 Nov 2026 10:56:19 +0800
Message-ID: <20261112025619.563195-3-yanxia@cmss.chinamobile.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261112025619.563195-1-yanxia@cmss.chinamobile.com>
References: <20261112025619.563195-1-yanxia@cmss.chinamobile.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In bridge mode, broadcast and multicast packets sent by one macvlan
are delivered to the other bridge ports by macvlan_broadcast(),
called from macvlan_queue_xmit(). The skb still contains its
Ethernet header there, so adding ETH_HLEN again in the rx_bytes
accounting overcounts by 14 bytes per packet on every receiving
macvlan.

Packets flooded from the receive handler have had the Ethernet
header pulled by eth_type_trans(), so they still need ETH_HLEN.

Use the existing mode argument to skip the extra ETH_HLEN for the
local bridge-mode path.

Noticed in macvlan during review of the ipvlan fix, and confirmed
on a 6.6 distribution kernel: five IPv4 UDP packets with 32-byte
payloads increased rx_bytes by 440 instead of 370.

Tested before and after the change with custom IPv4 and IPv6 UDP
tests in UML. The corrected counters match the received Ethernet
frame lengths. Local unicast and external RX counts are unchanged
in these tests.

Fixes: 618e1b7482f7 ("macvlan: implement bridge, VEPA and private mode")
Signed-off-by: Xia Yan <yanxia@cmss.chinamobile.com>
---
 drivers/net/macvlan.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/macvlan.c b/drivers/net/macvlan.c
index 4f8416bb5..96ec9bafa 100644
--- a/drivers/net/macvlan.c
+++ b/drivers/net/macvlan.c
@@ -290,7 +290,8 @@ static void macvlan_broadcast(struct sk_buff *skb,
 			err = macvlan_broadcast_one(nskb, vlan, eth,
 					mode == MACVLAN_MODE_BRIDGE) ?:
 			      netif_rx(nskb);
-		macvlan_count_rx(vlan, skb->len + ETH_HLEN,
+		macvlan_count_rx(vlan, skb->len +
+				 (mode == MACVLAN_MODE_BRIDGE ? 0 : ETH_HLEN),
 				 err == NET_RX_SUCCESS, true);
 	}
 }


