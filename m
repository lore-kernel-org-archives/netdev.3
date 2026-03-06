Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22B58369991
	for <netdev@vger.kernel.org>; Fri,  6 Mar 2026 02:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772765829; cv=none; b=EuTwETjMTBYTMTWOc2dm+zZZdg9zdqBgnWiwrzmepHBHjRTbvmfDIyOrY105TEiZSxk1y8mKE+9C4FOaJweb6KpjzmbGA4/FAqEuEvhr4KXu179OALNxisDGJaLSqNkK+evFlQcF5nlHBkoEQiFZ1Yz4lQchPw6XtB3iKCBU720=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772765829; c=relaxed/simple;
	bh=bXJP2SXiVX2o4dpulncWtlqjnIJImv7LNnOJ7S98Fjg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TU4Gxf590lfTV2ylq3+pd4tVWdebmISn8esnTbuuas+iqD++nGhV+M+hF/1E/PFKd3IOXLXEUrL+nGUHf1zHbvoCyX37EUOmxRfJDUFk8BkdYSARLcoFRCojjyPH6mRRWxHVn5BtHfM+rAfydbE8nCjSL97dZHpu1N2viBiapok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MKjRBXaC; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MKjRBXaC"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-c70c38515d3so1223771a12.0
        for <netdev@vger.kernel.org>; Thu, 05 Mar 2026 18:57:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772765825; x=1773370625; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zRFcyL5S6zZneqoCWZWBrZsq4dvGE1qemSjLy6Z68yY=;
        b=MKjRBXaCNx8eMl5+pxlf9MmHiaTVlFPJnMimSX7rNe2o2/fsicN5SVxzgxVqASFOaP
         8w0dsyY9VTAudnnBIz/HbYgg9BmoMHo7VJuKwfMW3EUy+E3ca13pVKvmrVAI10Pf3Ag+
         sP09nhPricMpFElXLk0LxK+i7Ynx5ktyfxHqzmSXjkv32A85qfiE2fCzKvCfiMSLwXEk
         33XCZ4SRlX//j9iq+eHPrzf+i+J3MjdXoskB3LN10Qh5WCqr9iCjxIcScN9W0xcklSmg
         66YPjg9+vmqeJHb5l5yEaG+UkPE199XNUozKt7mmZ9AZ722I8eOn804tyFXexM7aoifu
         A+UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772765825; x=1773370625;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zRFcyL5S6zZneqoCWZWBrZsq4dvGE1qemSjLy6Z68yY=;
        b=Ams/z9hQJpL3mMUhvjpLZ7Qc1cRHgTB5MgVm6QU7jjtD4WunviHY/fIX4oKd6hABq8
         IASdiVYxa5y7er77xozP7A0AhPw1smvVpJJvgM8gyODVF9vLsfj1r4fNUn+f3EvKha51
         Pu2TilHYHlc4ieHBZx2uWy4HvRwHEOpvwEmLRH+H1Qn2Q410phPRxVoOyVCAJ1lRSCHN
         n9OLj1WQd+qto9kV/dwSzWNH4R2WRvP9FxjSkmVHzKzdn/HHgTXEKxWPenTzIA5mXe1T
         oX1PJmqvQRlE2nZbXCMZANzVxSNbMGlMrO/X5Yd5xGX3q7oXBgPU6s813Vm7gyCjuIGq
         XwSQ==
X-Forwarded-Encrypted: i=1; AJvYcCUOZ1qj+ElhtJXekG8H+X30G81pQ049xTee4axWnH+31DC4EkFv1BziWwSza8giVdX8wgXvB1U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxpBKZLWROOTxnvtqWWmiVHIS/f4BJBlvbrR5bw+J6UC8SB3Qc
	9uOQQ+lT/1jIGAHia7zta8UdlMxGhT8W9Zngd44CkoCuZ/9bNqQzJF2R
X-Gm-Gg: ATEYQzzgs/m4/uEC7y7bMi4RxAPinJ3dH8N2b/25cbHUpZRnGl5NIjy5Y99HV3K+WoA
	5GeCx/yv8eBDni2lHhaFz9Bht5GRXEdbD/bM0QYjYSjBRtt+Jrvr6hv5BY1xClnD7ENujVDdJk5
	+ac8YU+U85IsvQq5A01tMRRT9DfC2tT/UrKI8IYlseZ5yVN74PAHDnCs2XlWIznPug6BbaYPcrt
	iLKzBohI9pp9ENHz0ErKE8HPZW6iejCApPG14KUx+1RIpSnzCpjLvcz6A8vuEn3V1MKZgcaTIFg
	8jvkOAWRYReRnoc/niBBR0pmuZgF+BsHFQzbwToQzQ8qi1oIPBc4UmanhiGS0REpAxMQAFulCem
	JtBRtYWVc/vlKc2y0b+k3/yYXF2zWcNFN8Yua+q0DO8Ym/0JhSKZXAC1mHaN7qM+0yxuZ40BSuz
	NYuyj/rUsByUdlZr1UJIH3BP3VknnSrNLviR/7UcfT+B29ltJtSdoIvTt2bKJo7FSLDFcOqhc=
X-Received: by 2002:a17:90b:28d0:b0:359:9a60:44ca with SMTP id 98e67ed59e1d1-359be392b52mr442708a91.8.1772765825222;
        Thu, 05 Mar 2026 18:57:05 -0800 (PST)
Received: from 3ce1e5d2d1b2.cse.ust.hk (191host009.mobilenet.cse.ust.hk. [143.89.191.9])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-359b2d38ab8sm3406171a91.1.2026.03.05.18.57.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 18:57:04 -0800 (PST)
From: Chengfeng Ye <dg573847474@gmail.com>
To: jk@codeconstruct.com.au,
	matt@codeconstruct.com.au,
	netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	linux-kernel@vger.kernel.org,
	Chengfeng Ye <dg573847474@gmail.com>
Subject: [PATCH v2] mctp: route: hold key->lock in mctp_flow_prepare_output()
Date: Fri,  6 Mar 2026 02:56:51 +0000
Message-Id: <20260306025651.853772-1-dg573847474@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mctp_flow_prepare_output() checks key->dev and may call
mctp_dev_set_key(), but it does not hold key->lock while doing so.

mctp_dev_set_key() and mctp_dev_release_key() are annotated with
__must_hold(&key->lock), so key->dev access is intended to be
serialized by key->lock. The mctp_sendmsg() transmit path reaches
mctp_flow_prepare_output() via mctp_local_output() -> mctp_dst_output()
without holding key->lock, so the check-and-set sequence is racy.

Example interleaving:

  CPU0                                  CPU1
  ----                                  ----
  mctp_flow_prepare_output(key, devA)
    if (!key->dev)  // sees NULL
                                        mctp_flow_prepare_output(
                                            key, devB)
                                          if (!key->dev)  // still NULL
                                          mctp_dev_set_key(devB, key)
                                            mctp_dev_hold(devB)
                                            key->dev = devB
    mctp_dev_set_key(devA, key)
      mctp_dev_hold(devA)
      key->dev = devA   // overwrites devB

Now both devA and devB references were acquired, but only the final
key->dev value is tracked for release. One reference can be lost,
causing a resource leak as mctp_dev_release_key() would only decrease
the reference on one dev.

Fix by taking key->lock around the key->dev check and
mctp_dev_set_key() call.

Fixes: 67737c4 ("mctp: Pass flow data & flow release events to drivers")
Signed-off-by: Chengfeng Ye <dg573847474@gmail.com>
---
 net/mctp/route.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/net/mctp/route.c b/net/mctp/route.c
index 0381377ab760..4a1ac55ad31e 100644
--- a/net/mctp/route.c
+++ b/net/mctp/route.c
@@ -359,6 +359,7 @@ static void mctp_flow_prepare_output(struct sk_buff *skb, struct mctp_dev *dev)
 {
 	struct mctp_sk_key *key;
 	struct mctp_flow *flow;
+	unsigned long flags;
 
 	flow = skb_ext_find(skb, SKB_EXT_MCTP);
 	if (!flow)
@@ -366,12 +367,17 @@ static void mctp_flow_prepare_output(struct sk_buff *skb, struct mctp_dev *dev)
 
 	key = flow->key;
 
+	spin_lock_irqsave(&key->lock, flags);
+
 	if (key->dev) {
 		WARN_ON(key->dev != dev);
-		return;
+		goto out_unlock;
 	}
 
 	mctp_dev_set_key(dev, key);
+
+out_unlock:
+	spin_unlock_irqrestore(&key->lock, flags);
 }
 #else
 static void mctp_skb_set_flow(struct sk_buff *skb, struct mctp_sk_key *key) {}
-- 
2.25.1

