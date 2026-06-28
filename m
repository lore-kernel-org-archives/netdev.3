Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B683E2E7366
	for <netdev@vger.kernel.org>; Sun, 28 Jun 2026 13:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782652956; cv=none; b=GVWfEhM5Jdtg4yMruKZ/EKcoaXrqMoCzYRzH1qvK79a139gRWEMFc4pcE6R7A3iYldJN9tM3QeQbOooH+uEh3JzhRv1HWCGB/3OKCh9ooH44AcrQCwjn4JimHX/roaN6Jeaow5vCxyPXjvrWwOb3XED5dZMIkaO6M0UytDFso7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782652956; c=relaxed/simple;
	bh=HSDd5m24MgsvLeOsjUkQS2kVaIYz4IWdKvctIm573do=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LEhh7BQXimisxeJtIrFfqKzT5FOZ8WYKx9yAD6nXe4YLq8SnGQeGdkmTG8wvui5+DsrE4hO3I3RSyqTYLdCyZhJKr4I6yPX2k1JCW2sRR/TZHvAQz2BXr8ijEiuwK2gTsyCOMavDWKUcrmW/neuejj9yqxRRdKqf7VtEn/mPbz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=hBaGaD3m; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b="hBaGaD3m"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-92e2161778dso67689685a.3
        for <netdev@vger.kernel.org>; Sun, 28 Jun 2026 06:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1782652954; x=1783257754; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6TZV8cTyfOeH5B+sRIt0RLVpCBP2dgVx2EFaRU+pcdM=;
        b=hBaGaD3m5G9zUwVPW0Dmv+x30iEax5goGwtMZz6YnRcm646KNaNuDQ9IT3dnLWswvk
         EiILJnxaa8JzEj0UpNNUzKtQHurCzLjaM9z/v7DpmwETHk6N8wNsH6GwTPJY4HzU/fw1
         ZIqzdVVGn+evIMqjUtTehdQh9btMrP7zc22ckeWoo/Se4aIkLdXjvtTxLgK/XtHWIB+8
         m/cIlvE4jeaKCWBoW4yIJSr6TtnsaQy/3ZT/Ox+Tv1/OhgWzBCvW28knKADXVK50hncY
         WinRrtniEFk6VYA2v1j6c01dMriO4A52dGFOsco9wy/nWj4NPRufz3KFpjuBi90ddQJf
         BPqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782652954; x=1783257754;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6TZV8cTyfOeH5B+sRIt0RLVpCBP2dgVx2EFaRU+pcdM=;
        b=OKnLMkplTsVw8IsH3g/r+nmE4r7kFoKVGJG3nwXvgB2I0wpkmcM7JGo0LBwzbNAw+D
         IsW9nfzfEmN4+pTztHjVHws9ct+GIcaG7Oc94aVVwbFHXoM+EnWYf+jEPzCpmUXn+LAN
         9CVZmrUPIEBpmY0vWF9tVrW9J5V5nrg28h6FtyDTM75LjqDUX2v7jP0fZ9KSTm7DRiud
         OpLLDOyOc2QdXlZv0IhuUYSmqP1WqAo5sH7CzSYCmbuH7CXHaTmN2iQaG+6S/qIvH9Ru
         14z7DMSRdVnC5aO2Un2uvSfVbozlTxwcUzzKgOJBYJXm1SuvKyihx8f9ExhV1Z0Xbk+o
         0GcA==
X-Forwarded-Encrypted: i=1; AFNElJ+vIQqzPttKrbKpjQPPc5KUr9/F4AY1xRxnb4MFf7e1VfaFq2U7IMTNLdSezjjYCK1sT7onS4U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJ3wpxouw+ILrkafRM/0GtEN66DTfNDabjcU9FZp9qtTcgbCjJ
	TQSE3IqRX9Cf2fFzggzqVPU53K62f9TyasPNBULodWUK08gPhuCqBXcogLOopbjiSHY=
X-Gm-Gg: AfdE7cnWLYjzZ87HVFnUkUPFdXfcKusui+wMQXHBKaKFyFi5/29y4JCpcKwxwTvAsmU
	9ixhE+GZx3KbTDzhJ/+XoGgdGgn86Abze2pw9QfblKcNtiHzCsIdTipFzfqTIIL4M6rc1y0hyuF
	lakD2yL8XPeGE4InTyjbmGQ+U3Y1Mkode/5jtAGDKj+P+3lmfi889PT7ooDK2QN4qmnYyd6L7x8
	qxPLI6UTufu8Wk0rr2tmnj15wYiqPcKxGx10N1r8+tF9/ufA31YpbIyM1yRvgssFL9ebSGxYNG/
	3A+6szxebIJpZTNPVcEBPf50K1+eEvPp1049anJDxSUfebdV5OgoDgMRfgY2J88DURMMqSz3PTE
	Hwe8AzRa2YJC49kH9u4My6JzUYPpzYP2B2HD5moB3JIJQ0lFU2umjszC3NaowSxNbHFpdo6NN8A
	9ilDySyiUg9P5eWmIg
X-Received: by 2002:a05:620a:4153:b0:915:83f3:780d with SMTP id af79cd13be357-9293d3a6804mr2185677385a.32.1782652953690;
        Sun, 28 Jun 2026 06:22:33 -0700 (PDT)
Received: from localhost ([161.35.96.86])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-92da627a75bsm435449985a.45.2026.06.28.06.22.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Jun 2026 06:22:33 -0700 (PDT)
From: Samuel Moelius <sam.moelius@trailofbits.com>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: Samuel Moelius <sam.moelius@trailofbits.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	netdev@vger.kernel.org (open list:TC subsystem),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3] net/sched: act_nat: only rewrite IPv4 packets
Date: Sun, 28 Jun 2026 13:20:30 +0000
Message-ID: <20260628132029.2209612.f2aaf6467355.act-nat-non-ipv4@trailofbits.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

act_nat can process packets whose protocol is not IPv4 and then
interpret the payload as an IPv4 header.  Non-IPv4 packets may be
modified based on unrelated bytes at the network header offset.

The action is documented as IPv4 NAT and should leave other protocols
alone.

Check skb->protocol before parsing and rewriting the IPv4 header.  This
keeps accepting hardware-accelerated VLAN IPv4 packets whose network
header already points at the IPv4 header, while still rejecting inline
VLAN packets because act_nat does not adjust the network header offset
before using ip_hdr(skb).

Fixes: b4219952356b ("[PKT_SCHED]: Add stateless NAT")
Assisted-by: Codex:gpt-5.5-cyber-preview
Signed-off-by: Samuel Moelius <sam.moelius@trailofbits.com>
---
Changes in v3:
  - Check skb->protocol
Changes in v2:
  - Check skb_protocol(skb, false)

 net/sched/act_nat.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/sched/act_nat.c b/net/sched/act_nat.c
index abb332dee836..1bf4a5853617 100644
--- a/net/sched/act_nat.c
+++ b/net/sched/act_nat.c
@@ -142,6 +142,9 @@ TC_INDIRECT_SCOPE int tcf_nat_act(struct sk_buff *skb,
 	egress = parms->flags & TCA_NAT_FLAG_EGRESS;
 
 	noff = skb_network_offset(skb);
+	if (skb->protocol != htons(ETH_P_IP))
+		goto out;
+
 	if (!pskb_may_pull(skb, sizeof(*iph) + noff))
 		goto drop;
 
-- 
2.43.0

