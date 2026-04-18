Received: from smtp.uniroma2.it (smtp.uniroma2.it [160.80.4.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 122CF282F30;
	Sat, 18 Apr 2026 16:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.80.4.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776529999; cv=none; b=A/LKuQhFKBLZLoNxMQqrk+1B1z9w1SpeA24Qa77Cgz6dI5tthN4anb9vrqiJZpNEE4TIaEM31nlvqy2KIH8l7ekNTpIZk+24yqgl3we4c2VD4ghlCP9lZOn7Q5N4zDP3QNDGXCNZbVrNIiYORpkstFWlnzRIQd/pEe0iLGoA0lE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776529999; c=relaxed/simple;
	bh=RxtbJPFmePB3AI5A99iJ/FCP4n2fPOmkN+DLYenzYqM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Y4r1GT9TeKV5WHx73W/nUtll8sgD7o463Mso3d/nMkXGZUE32uRrX9cQ2h/T2fs9KEc0CTQRpM6290Anf6XDqIyKM4I/gsLo94NF1A7fR6MDTAJ2rTlg2X/q2iODvGx4NlAkEiLJ5KMbXpuVW41MnZ8ld4jXiT1mWOel8nGAvJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniroma2.it; spf=pass smtp.mailfrom=uniroma2.it; arc=none smtp.client-ip=160.80.4.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniroma2.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniroma2.it
Received: from localhost.localdomain ([160.80.103.126])
	by smtp-2015.uniroma2.it (8.14.4/8.14.4/Debian-8) with ESMTP id 63IGT3oi010419;
	Sat, 18 Apr 2026 18:29:08 +0200
From: Andrea Mayer <andrea.mayer@uniroma2.it>
To: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, horms@kernel.org
Cc: anton.makarov11235@gmail.com, stefano.salsano@uniroma2.it,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andrea Mayer <andrea.mayer@uniroma2.it>, stable@vger.kernel.org
Subject: [PATCH net] seg6: fix seg6 lwtunnel output redirect for L2 reduced encap mode
Date: Sat, 18 Apr 2026 18:28:38 +0200
Message-Id: <20260418162838.31979-1-andrea.mayer@uniroma2.it>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.100.0 at smtp-2015
X-Virus-Status: Clean

When SEG6_IPTUN_MODE_L2ENCAP_RED (L2ENCAP_RED) was introduced, the
condition in seg6_build_state() that excludes L2 encap modes from
setting LWTUNNEL_STATE_OUTPUT_REDIRECT was not updated to account for
the new mode.
As a consequence, L2ENCAP_RED routes incorrectly trigger seg6_output()
on the output path, where the packet is silently dropped because
skb_mac_header_was_set() fails on L3 packets.

Extend the check to also exclude L2ENCAP_RED, consistent with L2ENCAP.

Fixes: 13f0296be8ec ("seg6: add support for SRv6 H.L2Encaps.Red behavior")
Cc: stable@vger.kernel.org
Signed-off-by: Andrea Mayer <andrea.mayer@uniroma2.it>
---
 net/ipv6/seg6_iptunnel.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/ipv6/seg6_iptunnel.c b/net/ipv6/seg6_iptunnel.c
index 97b50d9b1365..9b64343ebad6 100644
--- a/net/ipv6/seg6_iptunnel.c
+++ b/net/ipv6/seg6_iptunnel.c
@@ -746,7 +746,8 @@ static int seg6_build_state(struct net *net, struct nlattr *nla,
 	newts->type = LWTUNNEL_ENCAP_SEG6;
 	newts->flags |= LWTUNNEL_STATE_INPUT_REDIRECT;
 
-	if (tuninfo->mode != SEG6_IPTUN_MODE_L2ENCAP)
+	if (tuninfo->mode != SEG6_IPTUN_MODE_L2ENCAP &&
+	    tuninfo->mode != SEG6_IPTUN_MODE_L2ENCAP_RED)
 		newts->flags |= LWTUNNEL_STATE_OUTPUT_REDIRECT;
 
 	newts->headroom = seg6_lwt_headroom(tuninfo);
-- 
2.20.1

