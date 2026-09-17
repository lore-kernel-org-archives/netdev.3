Received: from mail-pz2-f42.google.com (mail-pz2-f42.google.com [74.125.228.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5FB94B44A9
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 15:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789659617; cv=none; b=g057OkagQSGF2/wp5JANOKINyV3IPYB/2ACNp9MaKYI2Pqa43xIODp00qxXcclTJC4fyRsKznp+zmaiU+aWbvcPAVxJSe0ZGo7LP7NqLpxat1wwTbJsB5rQSa1b+uS32yUnwzH45UikFJ4lTZXaJgTMEKbV2AnwcDLExUXChJJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789659617; c=relaxed/simple;
	bh=KzbsMfT9mDqqgshLhXJ1nuoPk1e2OxZC2YnocBIcZew=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AAPwC0fQbMnZ9JZQyiyHWNNUypV9XsWyuj5Wq5Ek9IV21T4xUEgIMAS6PH3u4kdOjRfPHa4OC4f8zXpSfiUBm/mCEMU5MMgRupOhdT6uUNFKQ3QE7rKpckZ/MWaeRnetasaSm2WH2mx9J7B43FcdWu9nfEJ30+WJqGW7nhSne44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AhKLrtlN; arc=none smtp.client-ip=74.125.228.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AhKLrtlN"
Received: by mail-pz2-f42.google.com with SMTP id d2e1a72fcca58-86e6d007703so849661b3a.0
        for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 08:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789659609; x=1790264409; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=/BLueBpn8GLWCUZRyZrIy9LgmAKje6FNvcB8D0aXHBE=;
        b=AhKLrtlNwMOA/EVggQliESgZgQjHYLZZmJ7I8znC6UW8X8vdLAfJY5lRF54W22ieAh
         oEIJcbODiSTF060rx2ZLVIP+D34SByHxD0/nWyOH7qZrvq67fflbbVshzIsNGkuFC3a5
         Xuo2npM8sdAwMGQrqiPCkRLRDjdVU1yzqrR2oOiP4HcwXCuZgUbGzi4eNyWELsMrjEp1
         k0J4PbpNoCx/YuU4/VW+KCwXCUlFVfOrg5dqCtGHJT53QXPF2oq6EYBBpRmpqw6u5jBN
         vgWag+tmHW3/Mgoc+5cBUAVW2Jaf6cUCTqem8dXKz8WZGF1s8mqxSZ5js9JX5x11Z18d
         9ofA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789659609; x=1790264409;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/BLueBpn8GLWCUZRyZrIy9LgmAKje6FNvcB8D0aXHBE=;
        b=gcTs4NW0d2tyuMZWxBzVRPuX3JL+4C2YtCQIrse5S3kFjg9UD8RewFuL+wJsRYeg82
         lF/Lmegn/YxHlgsH+PDxY2C3zTweTXQgUmXQ95j8xrqrPPxhfIMwrBTurmPT0j7yX74l
         UkN/eK+gWtXioo3RejZpsRjL++Q46GRfyuCTlkc58DYJAILX4RtxCODOQ7eOyl0EkJA9
         47U4GRSNknpb6RjsFTGtnoGfeZ7dOwzja0zeqAkfd0FZcW19BIWgqif+oXPgs3L2+cWK
         d7niXtYXZiBd+9AzlR4zLMN/bA/CN75H9iwySOhZjX3BdOFgHB0cw0rBzYBZ4Wwyjo6B
         3F6w==
X-Gm-Message-State: AFuF++kzT+iQUVq3M98Y3EtmAkevVYXOYu5tEAM/T8oDNBngQreL4+F5
	xOfyj1S6AM3W8y6l1+l2OV678SotqBi82rSNtdrtEIliBZA1iR6U4szo
X-Gm-Gg: AYBFou1YEYDiBL3NK+Kh3FT8NXOnx+bcxZ7cIDA0A4zSRQtQsvHbDlihRjfMR9jIe/x
	Xkup1vGB8nPqk+hAA/dCCXt1wxjKETYtPPVzt2JzYH1Oxeh74ZnYpZYNW7Y+6I9Mgk0KJP2x9LM
	yYCaqCMjatsyiuAQosIhMrxiael1AWx1BMJUsTRVsbipKszFW2S/CasG1pQVm2JEP4P5ZHlQ9v+
	w52q05+7AixAcTsnTUIVnCVim7dO5gE6uiHCz0Pzk/9MY5aleRno+6xA6U+pyLGKX/4wAA9ywlg
	F028eYrTPXqHrWNWfP9OvHzrYkpm/2IavNjDVNSwWZ8o0pfXctbaUbrFaAxZtnLisCRICRhBsct
	MJUhZm65efVa5ZUMnSONew4APQ1jvyF6LQXDQ3mgJPTWQD2sI/t5yu1HYmqFX0+jmGdgAb9ubvV
	lKP0xVOKIENjbEM9/yMUz1/65FKtseL8/gIKY9ohiTWED4s356bzTXU8pZviB7h5hPHVibQMDwQ
	3RtjzpOI/RlxOhuzLm9J52BHsW4cjF5
X-Received: by 2002:a05:6a00:1892:b0:869:4d90:a0cd with SMTP id d2e1a72fcca58-8723a5a7c3dmr15557312b3a.16.1789659608898;
        Thu, 17 Sep 2026 08:40:08 -0700 (PDT)
Received: from 192.168.50.3 ([198.176.50.208])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc50abb1776sm3467697a12.27.2026.09.17.08.39.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 08:40:08 -0700 (PDT)
From: Weiming Shi <bestswngs@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	co+65e5c76b187f08b2@bugs.sh,
	Xiang Mei <xmei5@asu.edu>,
	Weiming Shi <bestswngs@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net] veth: manage XDP program pointers during channel resize
Date: Thu, 17 Sep 2026 23:39:25 +0800
Message-ID: <20260917153923.904124-3-bestswngs@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

veth_set_channels() tears down XDP resources for removed RX queues
without clearing rq->xdp_prog.  If the program is then detached or
replaced, those queues keep the old pointer after bpf_prog_put().  A
later channel increase can re-enable NAPI and run the freed program.

Clear the program pointer after taking an RX queue offline, and publish
the current program only after bringing the queue back online succeeds.

  BUG: unable to handle page fault for address: ffffc90000256048
  Oops: Oops: 0000 [#1] SMP KASAN NOPTI
  RIP: veth_xdp_rcv_skb (include/linux/filter.h:779
                         include/net/xdp.h:696 drivers/net/veth.c:820)
  Call Trace:
   veth_xdp_rcv (drivers/net/veth.c:941)
   veth_poll (drivers/net/veth.c:986)
   __napi_poll (net/core/dev.c:7787)
   net_rx_action (net/core/dev.c:7850 net/core/dev.c:8007)
   handle_softirqs (kernel/softirq.c:645)
  Kernel panic - not syncing: Fatal exception in interrupt

Cc: stable@vger.kernel.org
Fixes: 4752eeb3d891 ("veth: implement support for set_channel ethtool op")
Reported-by: <co+65e5c76b187f08b2@bugs.sh>
Assisted-by: LLM
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
---
 drivers/net/veth.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/net/veth.c b/drivers/net/veth.c
index 6ed3ee81153fb..ef7624bc2c0ec 100644
--- a/drivers/net/veth.c
+++ b/drivers/net/veth.c
@@ -1247,12 +1247,15 @@ static int veth_napi_enable(struct net_device *dev)
 static void veth_disable_range_safe(struct net_device *dev, int start, int end)
 {
 	struct veth_priv *priv = netdev_priv(dev);
+	int i;
 
 	if (start >= end)
 		return;
 
 	if (priv->_xdp_prog) {
 		veth_napi_del_range(dev, start, end);
+		for (i = start; i < end; i++)
+			rcu_assign_pointer(priv->rq[i].xdp_prog, NULL);
 		veth_disable_xdp_range(dev, start, end, false);
 	} else if (veth_gro_requested(dev)) {
 		veth_napi_del_range(dev, start, end);
@@ -1262,7 +1265,7 @@ static void veth_disable_range_safe(struct net_device *dev, int start, int end)
 static int veth_enable_range_safe(struct net_device *dev, int start, int end)
 {
 	struct veth_priv *priv = netdev_priv(dev);
-	int err;
+	int err, i;
 
 	if (start >= end)
 		return 0;
@@ -1281,6 +1284,9 @@ static int veth_enable_range_safe(struct net_device *dev, int start, int end)
 			veth_disable_xdp_range(dev, start, end, true);
 			return err;
 		}
+		for (i = start; i < end; i++)
+			rcu_assign_pointer(priv->rq[i].xdp_prog,
+					   priv->_xdp_prog);
 	} else if (veth_gro_requested(dev)) {
 		return veth_napi_enable_range(dev, start, end);
 	}
-- 
2.55.0
