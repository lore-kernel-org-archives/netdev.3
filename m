Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.151
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794452201;
	b=XXnXMdL0WbPgYQ4lmZZMxYtB3GRN08DDPefqKsrfQ+vhfvhUKJpy4tlvRQzuQTcNIOAJ
	 9Rx5oa61qMaHgSahI3S+32azcpqPIR5dB1YBUJbvw+t3os2iuogRb540agaLE6vnmPe/n
	 EbbqboNAWYQ3mBlCq1/Asv/HbwQTCTZIZ+UJm8b1xosjaZQY4qO/HedoigU2uzE9i8h4e
	 FH4WP4E3T0D9MwUbbzbQ6Jg+1214Dv0evwgRzKBhBM1fMa/cO9+Zz2B7a5Fwbg01GztbR
	 kvbdg3pNg+gEVQMbn8UHa+UvycUHDkAt+aYADkWhJGeniQ607Vf9Tm3NeBCoVxFy9pQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794452201;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=oUPs9GlYH0/nBK76LefvoNogcOj2nXvq9zmlvxCeq5I=;
	b=sJ1sYPR115cMRzTpsOVDhfcytbkNGW+A/Xbjni7xLzYNvIuqzTlysSnZ88RfzAC3Zxdv
	 DqFfnPQ0B7cfliR8tieaHNLAkx2MzKwZ6SRYl5bUt48CSaVnC6stO5aoBOQEn6lANMFoa
	 IwmnDiPsRVCYu/UtYDVokjML4H1iQW2p/jf46CkXi0LNkV50eKKYd6IEM0jnOGB6272Ur
	 b7SLN6Cj0XNr0+aNNivdjJhToqn6ko0AplA5tBVShPO09pJCb82yYJumvJT7W3lsDXOws
	 xUksucua3qVxO9ChNVsIa/sEOYsSUEbBcdg25Wi01s9XSq10bigY3218XXHwTaFXC4A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=Ap6VbWm9;
	arc=none smtp.remote-ip=111.22.67.151
Received: from cmccmta8.chinamobile.com (cmccmta8.chinamobile.com [111.22.67.151])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90C76606A324;
	Thu, 12 Nov 2026 02:56:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 90C76606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=Ap6VbWm9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=Ap6VbWm9CIT6GBzEHWQ6wNH0IWYcbSfH/6WszoeknFHTIdtF47Ar94Q4WqyFUunwIWfzcAzW4j1iq
	 Gm6FYdVxz6YMlq4tHxVKJKqDuAbGUde/ehDyDk0RkEBlmNn8zfad1rw+MwaVp4lhdQPiaxyv4ER8bV
	 OmYQ72AGG54sRGng=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app06-12006 (RichMail) with SMTP id 2ee66af52ae0ada-a981c;
	Thu, 12 Nov 2026 10:56:32 +0800 (CST)
X-RM-TRANSID:2ee66af52ae0ada-a981c
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from  (unknown[223.108.79.101])
	by rmsmtp-syy-appsvr09-12009 (RichMail) with SMTP id 2ee96af52adee4f-f02eb;
	Thu, 12 Nov 2026 10:56:32 +0800 (CST)
X-RM-TRANSID:2ee96af52adee4f-f02eb
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
Subject: [PATCH net-next v2 1/2] ipvlan: fix RX byte accounting for local traffic
Date: Thu, 12 Nov 2026 10:56:18 +0800
Message-ID: <20261112025619.563195-2-yanxia@cmss.chinamobile.com>
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

For traffic between ipvlan devices on the same lower device,
skb->len already includes the Ethernet header. Adding ETH_HLEN
again in ipvlan_rcv_frame() overcounts rx_bytes by 14 bytes per
packet. ipvlan_process_multicast() does the same for local broadcast
and multicast traffic.

Packets received from the lower device have had the Ethernet header
pulled by eth_type_trans(), so their counters still need ETH_HLEN.

Use the existing local and tx_pkt flags to distinguish these paths.

Found during a code review of the ipvlan receive paths.

Sending five IPv4 UDP packets with 32-byte payloads between ipvlan
devices in separate network namespaces increases rx_bytes by 440
instead of 370. With this change the count is 370. External RX byte
counts are unchanged in the same tests.

Tested before and after the change with custom IPv4 and IPv6 UDP
tests in UML, covering L2 unicast, broadcast and joined multicast,
and L3 unicast.

Fixes: 2ad7bf363841 ("ipvlan: Initial check-in of the IPVLAN driver.")
Signed-off-by: Xia Yan <yanxia@cmss.chinamobile.com>
---
 drivers/net/ipvlan/ipvlan_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ipvlan/ipvlan_core.c b/drivers/net/ipvlan/ipvlan_core.c
index 7ad12dc78..ba646293a 100644
--- a/drivers/net/ipvlan/ipvlan_core.c
+++ b/drivers/net/ipvlan/ipvlan_core.c
@@ -276,7 +276,7 @@ void ipvlan_process_multicast(struct work_struct *work)
 			if (!(ipvlan->dev->flags & IFF_UP))
 				continue;
 			ret = NET_RX_DROP;
-			len = skb->len + ETH_HLEN;
+			len = skb->len + (tx_pkt ? 0 : ETH_HLEN);
 			nskb = skb_clone(skb, GFP_ATOMIC);
 			local_bh_disable();
 			if (nskb) {
@@ -331,7 +331,7 @@ static int ipvlan_rcv_frame(struct ipvl_addr *addr, struct sk_buff **pskb,
 	bool success = false;
 	struct sk_buff *skb = *pskb;
 
-	len = skb->len + ETH_HLEN;
+	len = skb->len + (local ? 0 : ETH_HLEN);
 	/* Only packets exchanged between two local slaves need to have
 	 * device-up check as well as skb-share check.
 	 */


