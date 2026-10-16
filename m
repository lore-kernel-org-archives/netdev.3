Received: from out28-123.mail.aliyun.com (out28-123.mail.aliyun.com [115.124.28.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE22137F006;
	Fri, 16 Oct 2026 04:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792123925; cv=none; b=tw3f9HFe/Y3xb1hnNun6zTmwsSabI0bGvnzWh7mf32IE1gGSh0COv+Vz6qSmbewa9GHePNxdpAPaFsmWSCNIrOpvoCwu9JUTS26oeO1QYhjymizhNi/bznv+4HcVCUypB6O+x3Xz+bb4CsTkPA1sLgatc4Wfi1itkC9oKrcxSQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792123925; c=relaxed/simple;
	bh=SR9U9zFwf4ohXXSs1IFWCy9pAc5l12b6KOZuvX8XW2Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rhgTQ5xpslAN3Ru5FSVfEpGuDjQbajJFBYz2tyAvnhnNhYpbFWyuEYiY3htjgsbOpLEQFRqKmkoAETaNHbfIAQz3U93GIKc7ZfMWO8KDFYb9E3dBqydrL/7cd4Jub2kGfcPU9rRWpbFEz0EatMmP7oOIV+CWQpXymRHxYYTcLRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com; spf=pass smtp.mailfrom=xiaopeng.com; dkim=pass (1024-bit key) header.d=xiaopeng.com header.i=@xiaopeng.com header.b=aezxHtbP; arc=none smtp.client-ip=115.124.28.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xiaopeng.com header.i=@xiaopeng.com header.b="aezxHtbP"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xiaopeng.com; s=default;
	t=1792123913; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=0a5T7wx+TeWcfwy+1qS3o5fCKHYJbaB3LB2/Y2K8J5w=;
	b=aezxHtbPFSIHZVi8nblFpbmPM0EhjW/+A2772anJdRCl0VSphRM1DY66E3s0h0QoPcRvTq9oWcI2Gun9pLIRk7QQNfFQ/XJMpCwri/f5mYrXECGyXTCkI4uYWCqTisjYuvf1YrVJJV7p3G96DF7eqRhM/Wy/3ibgrysIhrzskCs=
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.0751425|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_alarm|0.0101323-0.00207211-0.987796;FP=5090283234190380785|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033045213054;MF=liuc63@xiaopeng.com;NM=1;PH=DS;RN=8;RT=8;SR=0;TI=SMTPD_---.jfvLNd-_1792123912;
Received: from localhost(mailfrom:liuc63@xiaopeng.com fp:SMTPD_---.jfvLNd-_1792123912 cluster:ay29)
          by smtp.aliyun-inc.com;
          Fri, 16 Oct 2026 12:11:53 +0800
From: Liu Chao <liuc63@xiaopeng.com>
To: "David S . Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] net: ipv4: ipconfig: fix OOB read in DHCP option parsing
Date: Fri, 16 Oct 2026 12:11:52 +0800
Message-ID: <20261016041152.2294843-1-liuc63@xiaopeng.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The DHCP option parser in ic_bootp_recv() advances the option
pointer by the option length and only checks that the new pointer
has not reached the end of the packet.  The length byte and the
option payload (opt[1], opt[2]) are then read without verifying
that they lie within the buffer, so a malformed reply from a
rogue DHCP server can trigger an out-of-bounds read.

Validate the option length against the remaining bytes before
consuming the option, and skip options that do not fit.  This
keeps the existing parsing logic intact while ensuring all reads
stay within the received packet.

Reviewed-by: Guanglei Zhu <zhugl3@xiaopeng.com>
Signed-off-by: Liu Chao <liuc63@xiaopeng.com>
---
 net/ipv4/ipconfig.c | 38 ++++++++++++++++++++------------------
 1 file changed, 20 insertions(+), 18 deletions(-)

diff --git a/net/ipv4/ipconfig.c b/net/ipv4/ipconfig.c
index 22a788987..0b39a5ccf 100644
--- a/net/ipv4/ipconfig.c
+++ b/net/ipv4/ipconfig.c
@@ -1081,25 +1081,27 @@ static int __init ic_bootp_recv(struct sk_buff *skb, struct net_device *dev, str
 			__be32 server_id = NONE;
 			int mt = 0;
 
-			ext = &b->exten[4];
-			while (ext < end && *ext != 0xff) {
-				u8 *opt = ext++;
-				if (*opt == 0)	/* Padding */
-					continue;
-				ext += *ext + 1;
-				if (ext >= end)
-					break;
-				switch (*opt) {
-				case 53:	/* Message type */
-					if (opt[1])
-						mt = opt[2];
-					break;
-				case 54:	/* Server ID (IP address) */
-					if (opt[1] >= 4)
-						memcpy(&server_id, opt + 2, 4);
-					break;
+				ext = &b->exten[4];
+				while (ext < end && *ext != 0xff) {
+					u8 *opt = ext++;
+					if (*opt == 0)	/* Padding */
+						continue;
+					if (ext >= end)
+						break;
+					ext += *ext + 1;
+					if (ext > end)
+						break;
+					switch (*opt) {
+					case 53:	/* Message type */
+						if (opt[1])
+							mt = opt[2];
+						break;
+					case 54:	/* Server ID (IP address) */
+						if (opt[1] >= 4)
+							memcpy(&server_id, opt + 2, 4);
+						break;
+					}
 				}
-			}
 
 			pr_debug("DHCP: Got message type %d (%s)\n", mt, d->dev->name);
 
-- 
2.50.1

