Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A63B2C11ED;
	Sat,  7 Mar 2026 03:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772854212; cv=none; b=CZxGHXBz2thTl8PetiXf/t65/T1R10z+8TKTS5IPOkRMA+9kPnqSmeRcb1AGLX+WGKK7pbXS+Zy9mlCZb04UExj6PSJlvJrlwSTEkOEt2rlT0oQTGi0qKlEXOC1n1GB2j6Q2GLkdfsB880EJgXQyQCIY2rOzc6ydVTeFYJPrImE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772854212; c=relaxed/simple;
	bh=MnNXYCiMuHYNNUyCmKTw5o89ZC/EhAGm+px85RR3WQM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R+r1eNHbZ2PvKgma28bhjR8UmwQEh/UHs056RgV/1MQ8RIdpEg0DiWtZYbFDVfpDjKG08gLdT0g4vwegFMju51wCgvmKFekDKuN9nya+Vu9P3hHQWe2Nv5PmbbrWxHK7fcsSt6ISq6enTjXGyry0m/ULKgvBufy4sCl73Ya+SAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1vyiMi-000000003wd-0i8t;
	Sat, 07 Mar 2026 03:30:08 +0000
Date: Sat, 7 Mar 2026 03:30:05 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Daniel Golle <daniel@makrotopia.org>, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Frank Wunderlich <frankwu@gmx.de>, Chad Monroe <chad@monroe.io>,
	Cezary Wilmanski <cezary.wilmanski@adtran.com>,
	Liang Xu <lxu@maxlinear.com>,
	"Benny (Ying-Tsan) Weng" <yweng@maxlinear.com>,
	Jose Maria Verdu Munoz <jverdu@maxlinear.com>,
	Avinash Jayaraman <ajayaraman@maxlinear.com>,
	John Crispin <john@phrozen.org>
Subject: [PATCH net-next 1/2] dsa: tag_mxl862xx: set
 dsa_default_offload_fwd_mark()
Message-ID: <d9d8e6058e635c1fdd4689c875204d48d0235295.1772853341.git.daniel@makrotopia.org>
References: <cover.1772853341.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1772853341.git.daniel@makrotopia.org>

The MxL862xx offloads forwarding between bridged ports to the
hardware, so set dsa_default_offload_fwd_mark() to avoid duplicate
forwarding of packets of (eg. flooded) frames arriving at the CPU
port.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 net/dsa/tag_mxl862xx.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/dsa/tag_mxl862xx.c b/net/dsa/tag_mxl862xx.c
index 01f2158682718..c02f69de61cbb 100644
--- a/net/dsa/tag_mxl862xx.c
+++ b/net/dsa/tag_mxl862xx.c
@@ -92,6 +92,8 @@ static struct sk_buff *mxl862_tag_rcv(struct sk_buff *skb,
 	skb_pull_rcsum(skb, MXL862_HEADER_LEN);
 	dsa_strip_etype_header(skb, MXL862_HEADER_LEN);
 
+	dsa_default_offload_fwd_mark(skb);
+
 	return skb;
 }
 
-- 
2.53.0
