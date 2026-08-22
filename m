Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8999538399B
	for <netdev@vger.kernel.org>; Sat, 22 Aug 2026 08:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787388587; cv=none; b=oSs1eC1fFVh0m22st1fxZ2vON21mzUWM0De0VoHty81whOBMw/6IxtJ+Zuv+Pd3q6qRrBadqEyHON7tKhJxD7S4KYi1SakrhCf76DsQ79hZlJ9CR6PivgGtca6gmFqpM+q1ME8MnEJNoYMjWh5Uagr06hf/84MITZuTrCVbxCU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787388587; c=relaxed/simple;
	bh=hUfZtknh5T7BTc7mXHYiFhCsf0LAvHazCpZOSEEHzS0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H4TKFp9bya86tboFdfmWEMDbdYm0/GpNdXW4l6YGAEQymM1HcSd8e1T8U4coVZocU0BXYOhIOli6Kr5aT1+naIh+JR2kzXXhDsaocAmNtN/gUhlXHNrIUKvT0Y4vhZY7QdGxSC2Y+mE0bGRY1cgiQmASZWrLUKAeUXdVn9IrQE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-c9aea40d799so1135790a12.0
        for <netdev@vger.kernel.org>; Sat, 22 Aug 2026 01:49:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787388586; x=1787993386;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=WYgZmlmJIfFrwmDbnOnUlwtqZ356w6Q+EPhFDbj3zJk=;
        b=AhBKuvdLbS3aF3dmTBQ8wwZv1VMf8kXZBkPjZIA/fajT01UY6oeT8mgrahusW6q2va
         iRHO7FZln6DV/lodGZgMWSlHpN6VISDJUv38wSAt3ZNrH6+hkpKS462IJygCUmcbkk5G
         Ur3IflmZcKXm5dX7YYLzDecrWJ2sUZrh1Q++qsNXEClkM5hZzolBsMJ6jhARP7cnlJte
         5E7ft5iZx/cJ81mMmqS55CiUfJUKkUvMxj6iC4FW6GjBjIhOP1rqYnYbc8HY/tNs4Hh3
         KOSSk23M2oB7ch05sTBTDmVbU5GnuUT9komd8WpwVxq6F7ng0PHhO10+1vO1wQ47dNvj
         yf/g==
X-Forwarded-Encrypted: i=1; AHgh+RqbTsgAKI0X8jIqyFFD3wfYDY+AzuTpPn6XK/ysCKSI1DBBhtCLEYvjMDrBQ6bNZxUnrwGNglY=@vger.kernel.org
X-Gm-Message-State: AFuF++kaNax/g6gD+RQDfPEUXZ8kxTmTWOXxxkVJKsGJrOesCHHWGLTY
	w5fJGniCc+XYousyi5BQLVeKLQgmf8mgGy54FVSJ0Rtr0lobrOb5KZxnpF8efbOtlxrh
X-Gm-Gg: AR+sD12n5Cmx40sJJy8iNfJDAPG2FW6F8SAFqKFz1zFXKH5WBxybnjd/oUxT6Kq452I
	yxh0ZSQbCp5YQZiEYK+0vKtGGVj8Iv1CWlxEsm37aa1VqYR1zazFqYazj8HYvTlO+osj77Qtfv2
	aAF86r3KZd3w7N5fIK+2rv+agMOwboYi/IT8aCh8EX9mnrRQaccXm7Pa5gQiKFTf55zOAABC0nR
	oVnXDm4vieTELMaCeFO0EGvqfpw1WgIuA97xLm7B7Me3No2qysURSPE3UcM2PSEivKxee639QU4
	av+YkHO8Hsa/ecrM75J9eDSxudbWB/1wPTr7qYqLDNwzWieewfKurzUaRrMJpABOJANCEgVHEYl
	7VJlob4gYniLii7kIfB7ZemyMj/9DnWpHvoOsZzKfPo1IeJqRrz0Vah4u8RPKxNMNMpfOcbKnOG
	XL34Ia1+giZqvhT85FRFhbV6DETRvBhAONFjGDQuwuQ35NZy5mz4AOxnq1Hw==
X-Received: by 2002:a17:90b:1b42:b0:37f:fd1f:d30f with SMTP id 98e67ed59e1d1-395c3a06ffcmr20238817a91.12.1787388585636;
        Sat, 22 Aug 2026 01:49:45 -0700 (PDT)
Received: from Roxy.localdomain ([2602:feda:30:ae86:2bd:64ff:feda:6b7b])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-141860fe08csm8628316c88.8.2026.08.22.01.49.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Aug 2026 01:49:44 -0700 (PDT)
From: Zhiling Zou zhilinz@nebusec.ai
To: andrea.mayer@uniroma2.it,
	netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	david.lebrun@uclouvain.be,
	vega@nebusec.ai,
	zhilinz@nebusec.ai
Subject: [PATCH net v2 1/1] seg6: reset IP6CB after IPv6 decapsulation
Date: Sat, 22 Aug 2026 16:49:27 +0800
Message-ID: <83541e78b0eb0d5adc169a318a51e3055f6bf820.1787388261.git.zhilinz@nebusec.ai>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1787388261.git.zhilinz@nebusec.ai>
References: <cover.1787388261.git.zhilinz@nebusec.ai>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zhiling Zou <zhilinz@nebusec.ai>

decap_and_validate() pulls the outer SRv6 headers and makes the inner
packet the skb network header. The IPv6 control block still contains
values collected while parsing the outer packet, including nhoff and
extension-header flags.

End.DX6 and End.DT6 route the inner IPv6 packet directly to the IPv6
input path. An unprivileged user can reach End.DT6 from a user and net
namespace by installing a local SID and injecting an outer packet with
Hop-by-Hop and Destination Options headers followed by an SRH and a
minimal inner IPv6 packet.

The outer extension headers leave a large nhoff in IP6CB. After
decapsulation, ip6_protocol_deliver_rcu() uses that stale offset on the
inner packet and reads beyond the skb head. KASAN reports:

  BUG: KASAN: slab-out-of-bounds in ip6_protocol_deliver_rcu
  ip6_protocol_deliver_rcu+0x1118/0x1450
  ip6_input_finish+0x11b/0x240
  seg6_local_input_core+0xed/0x2e0
  lwtunnel_input+0x1e9/0x4e0
  ipv6_rthdr_rcv+0x525f/0x6c50
  ip6_protocol_deliver_rcu+0xcb7/0x1450

Before clearing IP6CB for an inner IPv6 packet, save its incoming
interface index and L3 slave state. Restore both after the clear and set
nhoff to the inner IPv6 base-header nexthdr field.

Use IP6CB(skb)->iif rather than skb->skb_iif because VRF processing can
replace skb_iif with the L3 master while IP6CB keeps the receiving
interface. Preserve IP6SKB_L3SLAVE for the same reason.

Fixes: d7a669dd2f8b ("ipv6: sr: add helper functions for seg6local")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Signed-off-by: Zhiling Zou <zhilinz@nebusec.ai>
---
changes in v2:
- Preserve the ingress index from IP6CB instead of using skb->skb_iif.
- Preserve IP6SKB_L3SLAVE across the IPv6 control-block reset.
- Place the IPv6 reset next to the merged IPv4 reset.
- Add reachability and the relevant KASAN call chain to the commit log.
- v1 Link: https://lore.kernel.org/all/6a236dcc43d141a9105e8ee1b84bcccc628d83b0.1786894895.git.zhilinz@nebusec.ai/

 net/ipv6/seg6_local.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/net/ipv6/seg6_local.c b/net/ipv6/seg6_local.c
index 95ea0b62729ac..7b52122201858 100644
--- a/net/ipv6/seg6_local.c
+++ b/net/ipv6/seg6_local.c
@@ -261,6 +261,15 @@ static bool decap_and_validate(struct sk_buff *skb, int proto)
 
 		memset(IPCB(skb), 0, sizeof(*IPCB(skb)));
 		IPCB(skb)->iif = iif;
+	} else if (proto == IPPROTO_IPV6) {
+		bool l3slave = ipv6_l3mdev_skb(IP6CB(skb)->flags);
+		int iif = IP6CB(skb)->iif;
+
+		memset(IP6CB(skb), 0, sizeof(*IP6CB(skb)));
+		IP6CB(skb)->iif = iif;
+		IP6CB(skb)->nhoff = offsetof(struct ipv6hdr, nexthdr);
+		if (l3slave)
+			IP6CB(skb)->flags |= IP6SKB_L3SLAVE;
 	}
 
 	return true;
-- 
2.43.0
