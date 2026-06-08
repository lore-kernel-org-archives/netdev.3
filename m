Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F16313D7D77
	for <netdev@vger.kernel.org>; Mon,  8 Jun 2026 18:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780942550; cv=none; b=uihtPM8cOf3pREx7jnqwg3rhNCydhVjqGXitSUazn8XzU9qiy8VYvFsMUfm7uW6o5MjUBa7ZWIVQShsomGXrGRp0KTuQu452gfPzEMCqsqUzmc9PZhB+gNAOca2OwN+D0YvN4oSGRxgPgeHnAkB0XnMnGUv5LVtdeUz7ECT+8dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780942550; c=relaxed/simple;
	bh=nVvJuOvWR1oz6S/HWYlHag1TQ0cRcGNfk3EfBz2+83s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XD/rF1BBC29KXsNvhX0JdTVTZX6eCoTQPBl0MoJJgJqJEh+58RJL1KNm8A9onpoDm48h5MgGL8qntu8sxBrDgYK/XlQL8OAdLdF58BB7b5YYiFNEbkQgKePh96MDPf/YqrrxE2WtQe1SIp83fN98e8lkTuLMojNHdJo6bxqc7aQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=dA4mRX25; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b="dA4mRX25"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-8ce0f17a69cso35642476d6.0
        for <netdev@vger.kernel.org>; Mon, 08 Jun 2026 11:15:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1780942548; x=1781547348; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ABwQ9Ec6oQdLijfWtetuJzpS6NZcabUv0iN3GAuzHv4=;
        b=dA4mRX25NqlwnImQOUROiFkRyrVksoI4yfpjYxdkYcH4Q0ub4AjPkI45GKXeEvu67c
         hDLsxYTbX9CHiOZ98SQCi7um/c6qTkG6C0akgNf0dS0lSO1Ijz8KAZE5AVPQJ1Qouxvm
         QWwdggzh/BYsKgAJBHEiUiA1sS7U12uAy73W/XdXGYZOgswGgilDeCXevmmu8nLssCU0
         EpqXNbyhqoshBCTZ4ci0n1MNwQbty4RhRK9ey4MdWO2dUzwvwwvkuqAjencBlfUgajwv
         Ch/Yd8CoC/wb0z4d6bU5pVf3WaFioZ+/9KiKr1Weud439++zibboyB1YaHyIHlQtlzQB
         J4cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780942548; x=1781547348;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ABwQ9Ec6oQdLijfWtetuJzpS6NZcabUv0iN3GAuzHv4=;
        b=LZWaR4+2BbyyFwXQR4ZUCVOndhI2jnc79sGJl5LIZml/JACCV1QSIJTTAP46DlvFqH
         bz6wZXF1I3n9Pping3E7ob02sKS3ZvterQ4bBmkjQ8klOwGfEIRqHV12IiCUiVOb/trl
         8WwCb76PPbz2RKdmSqtxN4jydNwQz43TUj7FOmpgYh1amPu3tlBxm2IILxLGBsxbnY79
         LJnKra2KdppwLldZAcl/9rJNTt5WLrfhDCa6WcuelpC37yzla/mJUT3FCU8BOSGccvqP
         rIJnBzXWkG8G1wNCN3Y8VrcW8IDCiITAjnB6a8B7drwn/kM8tv1+CYfVN+1qXQdSFVJ8
         Q0tQ==
X-Forwarded-Encrypted: i=1; AFNElJ/2oaIj/NUbl1qzAExV3QQxoZKHVbJtHQ3pWq+ER4hig0UFWptgWN1KkF1clFoZfPANYn5ON5c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJtJ18G+d1Iq61QS8xTFUzKd2FFw9YiIwjmmYirec/paae9y75
	+wt0V+Db9VBsAXQRgdtS+SboBV85hE8BkM2EhtCltHEmGmE8gvhtfR0kaNVQrCEQp/k=
X-Gm-Gg: Acq92OGzz/y8keSZA314m5/mfOtYAVxBOzPZJhaqrTOwIiqXI8NfC1HBf/uD9s2IvRS
	4tDY+Wrqm/jfdalrvy6MuCoOG/pfMfLBc1klNQ071UPCychbT6emLcxD+COdPh0BhERGeMxrmr6
	WUKI2wyPDvBxko5TgXn/h7J/fDuONgoLXVV60GIzud0cAs9MQk7pliFEXOwGq92rEg+pEb3aaQ2
	3v9ObZ9HrchGRZYp08wp/i2hLOoEUAQ/m0db0LAByiy8SmnA3bhmjrNB6p+zIFAymVKqbebrDh9
	nSSpucbf4buCsWa2tTuN+hz6RiUDukqF4G31hIjULjXG7YLV4Cw6jkC3+p/9LWf2Fsh2g2069tb
	yy0Nb9CHm+bQ08XxLuBnXuumutArq3ELimXs9Ar4mfhuj3TUJHx78xLZEw3vERivyEKO7jcaqCD
	uzoRWwKNusqYt2OJ/rH1YY8/V1jrepXuuwVJBfEw==
X-Received: by 2002:ad4:4e72:0:b0:8b8:726a:74d4 with SMTP id 6a1803df08f44-8cee5fcb15amr208894376d6.16.1780942547813;
        Mon, 08 Jun 2026 11:15:47 -0700 (PDT)
Received: from localhost ([161.35.96.86])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-8cecd2682f8sm172976246d6.43.2026.06.08.11.15.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jun 2026 11:15:47 -0700 (PDT)
From: Samuel Moelius <sam.moelius@trailofbits.com>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: Samuel Moelius <sam.moelius@trailofbits.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org (open list:TC subsystem),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2] net/sched: act_nat: only rewrite IPv4 packets
Date: Mon,  8 Jun 2026 18:13:49 +0000
Message-ID: <20260608181348.1146175.b644bbba93da.act-nat-non-ipv4@trailofbits.com>
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

Check the packet protocol before parsing and rewriting the IPv4 header.
Do not look through inline VLAN tags, because act_nat does not adjust
the network header offset before using ip_hdr(skb).

Assisted-by: Codex:gpt-5.5-cyber-preview
Signed-off-by: Samuel Moelius <sam.moelius@trailofbits.com>
---
Changes in v2
  - don't corrupt VLAN tags

 net/sched/act_nat.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/sched/act_nat.c b/net/sched/act_nat.c
index abb332dee836..cb3e7a415da7 100644
--- a/net/sched/act_nat.c
+++ b/net/sched/act_nat.c
@@ -142,6 +142,9 @@ TC_INDIRECT_SCOPE int tcf_nat_act(struct sk_buff *skb,
 	egress = parms->flags & TCA_NAT_FLAG_EGRESS;
 
 	noff = skb_network_offset(skb);
+	if (skb_protocol(skb, false) != htons(ETH_P_IP))
+		goto out;
+
 	if (!pskb_may_pull(skb, sizeof(*iph) + noff))
 		goto drop;
 
-- 
2.43.0

