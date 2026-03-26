Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F1B235E923
	for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 17:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774547194; cv=none; b=Tj4d1o7WForcVfbiSkMzhrkEakOb8WeaRSD3BgV1GxivHAe/8cs/+NWXqyVgFNsygh4fEzl0wCb0x5oz32U5188QdNyQTGmuzQKu8rUsG2Tl6khHkSVPcrGx0SMADODuVP3IOSjLm7hF0rK+hfpY1gtHH/2B/V892sMPiFVeb/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774547194; c=relaxed/simple;
	bh=j+f3uClfjMHsdo332pJtQTIhUZDYivfEjSJPDjJCbgA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nWFURv3Ry+0se56W79k1Jns0SY4D2pGm1xnDQN+Y9d/eSAO3BiEGkRC+ewOUVz40XogGkurfbv0GAXWYnrP8ugZiqOwwgviCDHUGpxeZq2KpuHiFBt83PYgxRywVabxteqO+0OFoCYFtD645zY7MOlxkjew98yIA9LZsy/X9OG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=mwtKWOOI; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="mwtKWOOI"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774547188;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KzyxAYRyx/x/x8wyor+HCtuz83L/riqOOKLGxAKi7fs=;
	b=mwtKWOOIPEcjFjkeaXeJBYUrdQdNGSYE6T/gZ49TXy9YmdCfmoSnYj87ziKMAGjxn6HhoE
	VrU9qdjgSR1GC3nRX9mEW6JXxmrqgCff7sdywyLbLui5hwr+PYmrWMKoqsXgYDMIIMZcj0
	sFCsPTobsWs6uNPl1BpGekFEfwnbDUc=
From: luka.gejak@linux.dev
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Cc: horms@kernel.org,
	fmaurer@redhat.com,
	liuhangbin@gmail.com,
	linux-kernel@vger.kernel.org,
	luka.gejak@linux.dev
Subject: [PATCH net-next v2 2/2] net: hsr: use __func__ instead of hardcoded function name
Date: Thu, 26 Mar 2026 18:46:00 +0100
Message-ID: <20260326174600.136232-3-luka.gejak@linux.dev>
In-Reply-To: <20260326174600.136232-1-luka.gejak@linux.dev>
References: <20260326174600.136232-1-luka.gejak@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Luka Gejak <luka.gejak@linux.dev>

Replace the hardcoded string "hsr_get_untagged_frame" with the
standard __func__ macro in netdev_warn_once() call to make the code
more robust to refactoring.

Signed-off-by: Luka Gejak <luka.gejak@linux.dev>
---
 net/hsr/hsr_forward.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/hsr/hsr_forward.c b/net/hsr/hsr_forward.c
index aefc9b6936ba..0aca859c88cb 100644
--- a/net/hsr/hsr_forward.c
+++ b/net/hsr/hsr_forward.c
@@ -184,7 +184,7 @@ struct sk_buff *hsr_get_untagged_frame(struct hsr_frame_info *frame,
 				create_stripped_skb_hsr(frame->skb_hsr, frame);
 		else
 			netdev_warn_once(port->dev,
-					 "Unexpected frame received in hsr_get_untagged_frame()\n");
+					 "Unexpected frame received in %s()\n", __func__);
 
 		if (!frame->skb_std)
 			return NULL;
-- 
2.53.0

