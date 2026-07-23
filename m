Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C5D9379C39
	for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 04:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784780613; cv=none; b=iSaNZ8QKfHFlneQLVrqvvvHQpWTK3qs329oYoneYiDCxCTeFKhAPmhcd5EeGfJbF+9bg03Wr4flsPWu0E5hjETh2bGeIpKLHCnvCtXFYs+SOOyw9/aPabg3TkYMtITSFPOGXYDYt+AG1ByyLxvHZQbARbq2KdosOhH7/tMtwxDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784780613; c=relaxed/simple;
	bh=aa5JpoxyiiIszoUJIXjj6mrtfIfrRBPmusHtb58OjJg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jp2Ps3CQvqkDNf9lsAibNdNAAm2dzemHMTXS9+cElevN3LR66yq9GbCWfrwVNHEqAWqu1fd7drImgyb8WpJvseqkKsidBq56LhmKTYjD6I1S3xTv5OmojRp+NxEvXDQssndUmBLXrC9uAIpYERzG5hhSEea14/bnOgsPVSyCAbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A4np3G9f; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A4np3G9f"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-8143daf89c7so2041787b3.1
        for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 21:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784780587; x=1785385387; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=0Iu9ZA5UsRHXZ0k9a3suZoz0cbH3TgLB+kgHy6PNqKU=;
        b=A4np3G9fx57IlwJCUo9oEadiZzsuZ9+aO5yC+281EV5MECkdkBR/7/8XJrv5J/zAxb
         2OhA3+w07YFtfg3dF2FDPnQ+eXkb27PzV7cOxBuBmUedEAYBMCJPEJrvh/yWCGoIzDL1
         ZieIMdvpnwdU2cUNds68H3tpEx8HmiXL3cqOxlLtWLz1JN3N7svXjk9ZJsoUdDVGVGHv
         n4Ub0DBqSEubG3SYvg0OqSlgCA36SLJiUolVRHAhbIVb59z75Bw+9J0z9VwROM/Qdpd0
         46QSJ+rmSMrDxvqu0z+0RDokAXrSDTf6DvWL1i1ONs/5Asf8QwTYK99s6WRk31vONKGn
         UUbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784780587; x=1785385387;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0Iu9ZA5UsRHXZ0k9a3suZoz0cbH3TgLB+kgHy6PNqKU=;
        b=pZK3z3oxz2uGE44qwJkFvmbFVtfNWBzg77LvBeyqBI1qEf2UIDjr6+NTzvKwxRuW0D
         CetEdbgqvNLqIG8Es42/3nSy52knkdgD4YFMU/ghEQvXXe/9+AV3D9fmHiWE4fvIuFJt
         G+GXRn7FFMTfAMJFpm59tULiCGRQNf7npevZeP+BdtJAz1pepi1EJ+9vd2SmZt728ItO
         1IzvV0gugEauM6LrgAc1dAsw+RDxYL45rujyUkN9aYB4boeLj6J/4fujqChELzBHTWIk
         nL7+QaXVrpNI0IcjoPvTTN9fNkRcWJ67/2gRJa8XHFdNGYXZZQMandNdlmsg2b+riz+Z
         67QA==
X-Gm-Message-State: AOJu0YxyZGKjE6SK/B0rJhe3uEb05gDSzd2XeMOwH0eTMyJZxGGWmYaX
	bw9C74HmzeM/ZJQY+s4sDwv13pkSV44HlEMAf16yVQctQ3gvzweugYJk
X-Gm-Gg: AR+sD13eNMOa9UYlRUYVOYWQRWkUMi0pHxIHqDybkkMQBaf83mwx8pHYmL1KKQanV0P
	u7qVhocaP9qMBrg+6jHqaHca8gKeXjR1EGFcXNjvt+dpVGVp3w7ksOU5c+pnt0Si4YgMNQz8X4a
	bRKOsfvK1kmbpCOMfkk7UWrHrbWKX2Wc9Z3uR1DphWhHwU7aq1rnAYLQzZlBF5DYfIT59g2e6Tv
	c/kqLBCiw5c142JwQStjlrRA1hHzLxY0OBgJppVMZA37NaUmv4YBUoejKMIx4/XjMf9YHtEW363
	K5gw2kQ55DUkibBcCUeIGE4UqlijntRxaK/V4f8rTVwbjv+PUNv1Xltvvr45LLvE4HemUsCgNZE
	v4ONOSl0FGWPwPRDvnXyFMbSERbhmogjIl8IgnBcz13nrL62vV/XlL+wS7Zj0qh9JDfyFXroj+H
	yxpRTxGcxnyFWyJh1ZmuZ6qb/a6AWlb+K0p12EqyM0eLBaRR3d0eAnKPpiqM4fhvzo58Ku05b1g
	W+LDPFxefzQJg==
X-Received: by 2002:a05:690c:6c87:b0:81c:fc30:a35c with SMTP id 00721157ae682-81f4c281ce8mr4429137b3.42.1784780586767;
        Wed, 22 Jul 2026 21:23:06 -0700 (PDT)
Received: from LAPTOP-83ECOPAB.f7a5e5c3-cab1-4810-bdbb-207cdd06de9e.globalsecureaccess.local ([136.55.173.105])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81f33da4122sm23388037b3.32.2026.07.22.21.23.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 21:23:06 -0700 (PDT)
From: "Cen Zhang (Microsoft)" <blbllhy@gmail.com>
To: aconole@redhat.com,
	echaudro@redhat.com,
	i.maximets@ovn.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	dev@openvswitch.org,
	linux-kernel@vger.kernel.org,
	AutonomousCodeSecurity@microsoft.com,
	tgopinath@linux.microsoft.com,
	kys@microsoft.com,
	blbllhy@gmail.com
Subject: [PATCH v2] net/openvswitch: check Ethernet header length before  key_extract()
Date: Thu, 23 Jul 2026 00:23:04 -0400
Message-ID: <20260723042304.88332-1-blbllhy@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a packet arrives on an ARPHRD_NONE device (e.g. TUN),
ovs_flow_key_extract() trusts the user-provided skb->protocol field: if
it is ETH_P_TEB, the packet is classified as MAC_PROTO_ETHERNET and
key_extract() is called without ensuring the skb has ETH_HLEN (14) bytes
of linear data. key_extract() unconditionally pulls 2 * ETH_ALEN bytes
for MAC addresses and parse_ethertype() pulls 2 more, either of which
triggers a kernel BUG in __skb_pull() when the linear area is too small.

  kernel BUG at include/linux/skbuff.h:2848!
  RIP: 0010:key_extract+0xa7e/0xd90 net/openvswitch/flow.c:933
  ovs_flow_key_extract+0x419/0xa70
  ovs_vport_receive+0x222/0x390
  netdev_frame_hook+0x3e0/0x630
  tun_get_user+0x2d0c/0x38e0

Fixed by adding checks in key_extract() before pulling the Ethernet
header.

Fixes: 217ac77a3c25 ("openvswitch: allow L3 netdev ports")
Reported-by: AutonomousCodeSecurity@microsoft.com
Link: https://lore.kernel.org/all/20260721143602.64677-1-blbllhy@gmail.com
Signed-off-by: Cen Zhang (Microsoft) <blbllhy@gmail.com>
---
v2: Moved the check into key_extract() per Ilya Maximets.

 net/openvswitch/flow.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/openvswitch/flow.c b/net/openvswitch/flow.c
index 66366982f604..de7b77d6702a 100644
--- a/net/openvswitch/flow.c
+++ b/net/openvswitch/flow.c
@@ -926,6 +926,9 @@ static int key_extract(struct sk_buff *skb, struct sw_flow_key *key)
 		skb_reset_network_header(skb);
 		key->eth.type = skb->protocol;
 	} else {
+		if (unlikely(!pskb_may_pull(skb, ETH_HLEN)))
+			return -EINVAL;
+
 		eth = eth_hdr(skb);
 		ether_addr_copy(key->eth.src, eth->h_source);
 		ether_addr_copy(key->eth.dst, eth->h_dest);
-- 
2.53.0

