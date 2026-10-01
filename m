Received: from cmccmta8.chinamobile.com (cmccmta8.chinamobile.com [111.22.67.151])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 990163016E7;
	Fri,  2 Oct 2026 00:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790901032; cv=none; b=F2FnclTdMi9p6OKBvTV3yYxC8JACIdHg4ieCvv7qDKTrYag4zG2kFXjGfQ+Wghz1zQLUgPVB3c7NMdZct8K1I3wjbulz4sjZq+CYn8t1QpmvGQrZHwAtzTYyHtTnPDtVI+By9Wzf+E6siIEQevBbzpwkOOxzBUH+TijSyutADZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790901032; c=relaxed/simple;
	bh=jyJVzlyW2dooO7w9bPUv9X0xL2HdUonoPiKRrbgTtkA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Z+3J8cKWI+G1lL2yMQp8B2JGr7WuYEuE6Zf1BsGeq49sJRamxRhHJQXLfEsyeK+D3iFYgTv/6zWcS8qQbQoLywBInLPL0SIbIhlxIKOT9/weNlepATXyoDbyRaYkBfZ9u3YVf2ziRhj7pXbl1Dzevq4/+DJP4zGuBSBSUp5hap0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; dkim=pass (1024-bit key) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.b=nUgJ+ECL; arc=none smtp.client-ip=111.22.67.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.b="nUgJ+ECL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=nUgJ+ECLQcTTxFqF1ionhdywyfq1NPBL1lo0iiWpJSpPTIZa6tos94rt1V5z+8/DJBMw0mrM4U2vs
	 o2t6sNwK7fI0n/7u3/9Go+HLP1eebGZFuM/DmZreLQV6oU4iErs6QoJ4JdW5Wew611AaRNl5vgeUhX
	 /6BP+q8SZLApzyW4=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app02-12002 (RichMail) with SMTP id 2ee26abefb222be-d02b1;
	Fri, 02 Oct 2026 08:30:27 +0800 (CST)
X-RM-TRANSID:2ee26abefb222be-d02b1
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain (unknown[112.22.250.209])
	by rmsmtp-syy-appsvr09-12009 (RichMail) with SMTP id 2ee96abefb1dfb1-30ad3;
	Fri, 02 Oct 2026 08:30:27 +0800 (CST)
X-RM-TRANSID:2ee96abefb1dfb1-30ad3
From: Haishuang Yan <yanhaishuang@cmss.chinamobile.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alice Mikityanska <alice.kernel@fastmail.im>,
	Daniel Borkmann <daniel@iogearbox.net>,
	linux-kernel@vger.kernel.org,
	Haishuang Yan <yanhaishuang@cmss.chinamobile.com>
Subject: [PATCH net-next] bareudp: Enable BIG TCP packets
Date: Thu,  1 Oct 2026 12:23:36 +0800
Message-ID: <20261001042336.224343-1-yanhaishuang@cmss.chinamobile.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit f3d0f753f066 ("vxlan: Enable BIG TCP packets") and commit
03ebe91b0f61 ("geneve: Enable BIG TCP packets") allowed BIG TCP on vxlan
and geneve, after the preceding patches of that series made the common
UDP tunnel transmit path handle GSO packets larger than 64KB.

bareudp transmits through the same helpers, udp_tunnel_handle_offloads()
followed by udp_tunnel_xmit_skb() or udp_tunnel6_xmit_skb(), and does
not fill in any length field itself. Bump tso_max_size up to
GSO_MAX_SIZE so that the admin can use BIG TCP with bareudp too.

The default gso_max_size and gso_ipv4_max_size stay at 64KB, so nothing
changes unless they are raised explicitly.

iperf3 TCP over bareudp (ethertype ipv4, IPv4 outer) between two netns
connected by veth, MTU 1600 on veth, 3 runs of 20 seconds each. This
was measured in a QEMU TCG guest, so only the relative numbers are
meaningful:

  gso_max_size/gso_ipv4_max_size 65536:
    4380.6, 4404.2, 4354.5 Mbit/s, average 4379.8 Mbit/s

  gso_max_size/gso_ipv4_max_size 196608:
    5509.4, 5454.7, 5497.4 Mbit/s, average 5487.2 Mbit/s (+25%)

With 196608, about 90k to 100k packets larger than 64KB were
transmitted on the bareudp device per run, none with 65536. Without
this patch, setting gso_max_size to 196608 is rejected.

Assisted-by: LLM
Signed-off-by: Haishuang Yan <yanhaishuang@cmss.chinamobile.com>
---
 drivers/net/bareudp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/bareudp.c b/drivers/net/bareudp.c
index c3b5ed52d877..fcc33e302b9c 100644
--- a/drivers/net/bareudp.c
+++ b/drivers/net/bareudp.c
@@ -589,6 +589,7 @@ static void bareudp_setup(struct net_device *dev)
 	dev->max_mtu = IP_MAX_MTU - BAREUDP_BASE_HLEN;
 	dev->type = ARPHRD_NONE;
 	netif_keep_dst(dev);
+	netif_set_tso_max_size(dev, GSO_MAX_SIZE);
 	dev->priv_flags |= IFF_NO_QUEUE;
 	dev->lltx = true;
 	dev->flags = IFF_POINTOPOINT | IFF_NOARP | IFF_MULTICAST;
-- 
2.43.0



