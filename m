Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AE6B25FA29
	for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 17:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784829318; cv=none; b=OILttUSxW0giRWmbwHbXvR0aCoJk1xXw9uTCDZV1rRcAUBwzqOzqYRdq67olDw25KfNZU1WzCy6y8SYn9+rOSMSq/qOJFKUSW02r4UAirEgG41UuPAZ4aLScO9+i12eTzr8eIQOzCg4wlTnqPlTUnUBH2i3ZDZxnDqddjbFuZk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784829318; c=relaxed/simple;
	bh=naQmjEb/FF5ML3YAjkcFraSoJxLpdbtln9MqFNO4PT8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U+OR6MBKcynRKwms+ZpshOYSerrmfmpx6CswSDR0Vz6k3D6qAg+p3bZO7MRboHd4oFu6J0djGUyXLfXg5Y7LzmA/7tkKhHYxL7BWJ5uCHTtI4LoLeOVAnKTf55Ta4nEbiKu+rQ0uWMFuF4QsEDUbn7T51fuzVYxqu/E+Gv51MBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pc83WvIr; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pc83WvIr"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-381c51fde6bso1027896a91.2
        for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 10:55:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784829313; x=1785434113; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=T9pOdm/pCPYaCzGOYtfVb3PgMLIeG1DYk/sH1Fibdn0=;
        b=pc83WvIrXTa39bpWonN1YDL+0IigT2+wtsNzJeV8gdlGUrMyFtkknMjnQga1V4ts06
         3eSztPEAAJUHweZrm1TJZSMYoWzItLShhAvUGjOucCl+lyuTpn5GLl7V/3h9GuRXyN2B
         8Nrg3crvtgs58mTfrnOPW89Ilz31OM09AYprYDUfXTuq7iWAtxm0EqjMyXsWreOK7b1f
         CGorHzD0VPjy5otQqnu7uX/+VF2lZEPX7tKGEodDFOHsaG6rMaqoiYBG1rlKmIzSfXGX
         Om9cdKyuUa0+tZnIcneB/0ucQoWseF2+nEA9xFIgGbwMRwiqGRIjqRhcAjsOVhVFLZOM
         s2ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784829313; x=1785434113;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=T9pOdm/pCPYaCzGOYtfVb3PgMLIeG1DYk/sH1Fibdn0=;
        b=I0yvSmoLYEHkLBad5K40FxoH6p5akOo8d+ZebKlAJ4mI1BtdNP+FiAfaSuMXne334d
         cMNJf74bDOQcMXiChBBUGaGlME77Nr81kL7f+TfEyi33B5XFvU8LXXTh1vNkCXFXJWWD
         2DXtycaFSff2MR0OuSeZ4JIvK+FGzGIhXAi9QxCzqFEWkjlsBjotlfE7k2jJXyQY2aIr
         tkc1DdEaJG+gJ19e+N9kX+DQb4rc6PqRBB/8EOisUAjEM1+seBuPGtzixn3kocufaxaY
         DyGHkk8tYuGJQjyJuiPC5PTBCNT/WTzpiyTZh+hvITirm9xJpVz9LeJ/ayseUST68JVL
         U1qA==
X-Gm-Message-State: AOJu0YwLODTnCmXExMv8SXL8LyHFW1q/VOLNKmbMm0thAPThYV93Z2Y1
	zZwwlaaJKcA4yVMEseUYtO6ArUarSQJ4nie4VIucWpaRvK4LBCHa997lnm5rnkd/0IY=
X-Gm-Gg: AR+sD13lyEzZqXynDxJ/YhnmRPQrq+7kdm2E4y3mXL98mO/QgWzjjPoa14Nj895QxxL
	PXmyA8v84pVjYoij1ih8sAfOHnXJAXeD/+ZoeSli0RQatEv2IGhZN9bYxg+IM4J8PzUVCKhsZfG
	L7mKpJHmTIBPNDshNXOSeMFYiKG92L/SMkF4eeGBNXaBJMtNjgnG5kJpZgYhGPwvqNe1r41F+ip
	Iglq33D3KPJfvDgr1xtapDv1i6Fx+nZ52fuoTtznUKosBPQNRFbj1yMHyD8sg1Y+lBRbGvc5gM+
	wFodX98q5S0w7gPVs/y/nl3lC7MlXWckHYWyiGAc81YNH+Mp2o5WrY4lSyNZ3NfXov2Ze7XIlO8
	rTMzfx/gg67MDC7X0VEWSmNBG+/iPrDppq/4SYY/F1SpYKFjMqefOid8RnfM/ujkwrDdnDGKyU0
	8LWwP+cgnWWcA1lslzehT0jXynHWHypw==
X-Received: by 2002:a17:90b:38c8:b0:38e:b400:a860 with SMTP id 98e67ed59e1d1-38ec642bd98mr4661942a91.13.1784829313163;
        Thu, 23 Jul 2026 10:55:13 -0700 (PDT)
Received: from enjou-Legion-Y7000P-2019 ([167.71.204.91])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13d130262d2sm15943883c88.7.2026.07.23.10.55.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 10:55:12 -0700 (PDT)
From: Ren Wei <enjou1224z@gmail.com>
To: netdev@vger.kernel.org
Cc: jhs@mojatatu.com,
	jiri@resnulli.us,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	peilin.ye@bytedance.com,
	cong.wang@bytedance.com,
	gnault@redhat.com,
	vega@nebusec.ai,
	bronzed_45_vested@icloud.com,
	enjou1224z@gmail.com
Subject: [PATCH net v2 2/2] net/sched: act_vlan: skip pop_eth on non-Ethernet devices
Date: Fri, 24 Jul 2026 01:54:48 +0800
Message-ID: <32c26661015715cb100df38180c81cc730d7c92e.1784709375.git.bronzed_45_vested@icloud.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1784709375.git.bronzed_45_vested@icloud.com>
References: <cover.1784709375.git.bronzed_45_vested@icloud.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wyatt Feng <bronzed_45_vested@icloud.com>

tcf_vlan_act() currently applies TCA_VLAN_ACT_POP_ETH on any device
type. On loopback and other non-Ethernet devices, this can strip
ETH_HLEN bytes that later paths still expect to be an Ethernet header.

Treat POP_ETH as an Ethernet-only action and leave non-Ethernet
packets unchanged.

This fixes a short-packet handling bug that can trigger a BUG in
__skb_pull().

Fixes: 19fbcb36a39e ("net/sched: act_vlan: Add {POP,PUSH}_ETH actions")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Assisted-by: Codex:GPT-5.4
Signed-off-by: Wyatt Feng <bronzed_45_vested@icloud.com>
Signed-off-by: Ren Wei <enjou1224z@gmail.com>
---
 net/sched/act_vlan.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/sched/act_vlan.c b/net/sched/act_vlan.c
index 6a375fdc63dd..b77f649ae204 100644
--- a/net/sched/act_vlan.c
+++ b/net/sched/act_vlan.c
@@ -4,6 +4,7 @@
  */
 
 #include <linux/module.h>
+#include <linux/if_arp.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/skbuff.h>
@@ -76,6 +77,9 @@ TC_INDIRECT_SCOPE int tcf_vlan_act(struct sk_buff *skb,
 		__vlan_hwaccel_put_tag(skb, p->tcfv_push_proto, tci);
 		break;
 	case TCA_VLAN_ACT_POP_ETH:
+		if (!skb->dev || skb->dev->type != ARPHRD_ETHER)
+			goto out;
+
 		err = skb_eth_pop(skb);
 		if (err)
 			goto drop;
-- 
2.47.3

