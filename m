Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1CC92367D3
	for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 12:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784723333; cv=none; b=W+01e7Qi11zrWlF4S/quEurAVs31WtTlabcpwHMTaaTBxQxp3EWckPTkJXe8N59bpRlSLgSwO8vUDZvlbYKAl7MrpduTk8coO/bV9DQ84rPjsGMpUCjsxDN2/Af8GV8bINispbq06uaxHq/0lCCDteNJ4HUi+4HCJ7XdAAzSLsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784723333; c=relaxed/simple;
	bh=8JObLPk4bRFGMYDDkHTjoHj58CrxdNYcMjsaNFymvwg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=t1+oSxmZOvkKUm11PnFHz0znmvkDHsxaLZGZoSeOgGu4jYNK0N37T8Fc5Yzf29Ir3DMYr6PdKRcDdEPN9QAIICZPrm9V5v2tFlGA3ImaEyNkL83ybt7oMVW7rBasVFkxELkyeAjl4vsR0bOPqDzfIKKfDQhtzYJU5ZVfthq0ZBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr; spf=none smtp.mailfrom=isslab.korea.ac.kr; dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b=hHiCsJks; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b="hHiCsJks"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2cf41bab353so66655075ad.0
        for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 05:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isslab-korea-ac-kr.20251104.gappssmtp.com; s=20251104; t=1784723328; x=1785328128; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=YtMV7pbyivyJnV1bBaXBXi5l1WS4Cz/tds4j9Pl0ClM=;
        b=hHiCsJks55cjLA/EPbMEdez0CLEdrNLftU6AyzFpO4OG2jvWia4w7NgE9TeKRfflQf
         Yzh5q/+pITYuU+ugKDhZjqe+4S0vgdwFei/46iSIoIWlAhPr2YHurMz2kXiuTemClRem
         TZiBFKJSNMs+gD8/5Zt/r9BNOQZH1Q3eUHG1nk9Jw/34yY3abtGFXjUB8sCQwxLyJifk
         56krmuxHZJCedSiKYZm4PQpaD1NWtHuJz4dw9yVzj3hmxgd+wwv2B/GkYyryKj3clD1Y
         q6TTSNibue/ldJWu9G2B+7hR/KD3rXnymTIyk2vMNMc2+2esm8p4xiHY2uFh8MvKlJmh
         oWow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784723328; x=1785328128;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YtMV7pbyivyJnV1bBaXBXi5l1WS4Cz/tds4j9Pl0ClM=;
        b=HOhFKMJ9jgGumHb4gjWzqwXmTcXieRb03dkXuM+dA9uAsH6u8hrc7E7lFG8Rg8L7zX
         NiHobHV/ODLMpOTo06QezIDZgBb+Kry6tmjiE9wd5/ue4kPWqghFuV7mdpYWcUfLRzS6
         1cpA8yodAiZzFeGMXC7QFBqZQWjs1DiGSd81Y9B5qM1ZfgW53gC8yBgLEaQQ45L3qbQj
         q9FkjzI7J67YOfXEGFqyDTNhf4uTPYo6P7YfaZr6HwrRzNoPGLHZYgUnyFqj8XO46EKD
         NpMjnGsk/7befqEjuXAvQl84GzbL3G2KXWg35zENCpGG4YhPBoq/2M1V9wfIBdA4kzfH
         81Lg==
X-Forwarded-Encrypted: i=1; AHgh+Ro7+lIAia7TrEw+yDt90Tl5IBuHi0SXjxa8KCv2J9MsL/rTEilpGCT3FvhZ0M7K4/fxJmn8QDY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxb5eJy/b24BmewkhctH4s+ZVSzUwge8G29CfRMEOsFZXmLXYtf
	qm52TXdq3q6WMNMb5QNRLikAVf/vDk5Yo5sZF/nCiyGd3DoG7pE0H9cziUYqdRINt7Y=
X-Gm-Gg: AR+sD12tbCS8xkQ46mFpW8PTwp/lQF7rghK5AdTwzrY6vn2xCtrbGJM4E0QwSogX6RH
	nWv3K8BjtTcSIj5zHnGRtXURgWpl3cUiIHQekO/cSWKqDUkCHOT6u4vcpSH8atnjHC2slN+W2Hf
	gKIg61aDxaRzJy244Q+xrVu2F/FHpHEl2f3hy/DyDae3BZxVJLflKCGQsEKyVDbK9FMQNxKFcH2
	n7kPONAG7yjaRuWXj8aXAgDbwqjyYLgEYjCSLJvKOU+9yXgEXak+Z4E92OOmGD77PXbnUQNvbA1
	wiZEsThtJZXPcvGG0Dr5zLqDVW0ULcAA5Synf1qpL5sd7FS+ZlESPcqyfjNJFB4wqSoSEcXdNoC
	iWDIj8SFQxNlTi5DAO6m2iYOtWmViC/hYbenRpkyndz+g9xoiO5dRPRwP7xa/OT6NwAlegra+0R
	S2Yd+X1rniGRw4xR0LLzE9uA==
X-Received: by 2002:a17:903:26c6:b0:2ca:5a42:d8c5 with SMTP id d9443c01a7336-2cf34a318damr238202195ad.46.1784723328403;
        Wed, 22 Jul 2026 05:28:48 -0700 (PDT)
Received: from localhost.localdomain ([115.138.38.139])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf8efa39e9sm14057355ad.10.2026.07.22.05.28.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 05:28:48 -0700 (PDT)
From: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
To: nhorman@tuxdriver.com,
	netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	idosch@nvidia.com,
	jiri@resnulli.us,
	linux-kernel@vger.kernel.org,
	Yehyeong Lee <yhlee@isslab.korea.ac.kr>
Subject: [PATCH v2 net] net: drop_monitor: fix info leak in NET_DM_ATTR_PAYLOAD
Date: Wed, 22 Jul 2026 21:28:17 +0900
Message-ID: <20260722122817.5548-1-yhlee@isslab.korea.ac.kr>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

net_dm_packet_report_fill() and net_dm_hw_packet_report_fill() open code
the NET_DM_ATTR_PAYLOAD attribute to avoid zeroing the packet payload
before overwriting it with skb_copy_bits().

skb_put() reserves nla_total_size(payload_len), i.e. the header plus the
NLA_ALIGN() padding, but only payload_len bytes are copied in. When
payload_len is not a multiple of 4 the 1-3 padding bytes are never
initialized and are leaked to user space inside the netlink message.

KMSAN confirms the leak for the software path when the packet payload
length is not 4-byte aligned:

  BUG: KMSAN: kernel-infoleak in _copy_to_iter
   _copy_to_iter
   __skb_datagram_iter
   skb_copy_datagram_iter
   netlink_recvmsg
   sock_recvmsg
   __sys_recvfrom
  Uninit was created at:
   kmem_cache_alloc_node_noprof
   __alloc_skb
   net_dm_packet_work
  Bytes 173-175 of 176 are uninitialized

Use __nla_reserve(), which sets up the attribute header and zeroes the
padding, instead of open coding the attribute construction.

Fixes: ca30707dee2b ("drop_monitor: Add packet alert mode")
Fixes: 5e58109b1ea4 ("drop_monitor: Add support for packet alert mode for hardware drops")
Suggested-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
---
v2: use __nla_reserve() instead of open coding the attribute (Eric Dumazet)
v1: https://lore.kernel.org/netdev/20260722104419.273358-1-yhlee@isslab.korea.ac.kr/

 net/core/drop_monitor.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/net/core/drop_monitor.c b/net/core/drop_monitor.c
index 2bf3cab5e5..b4d1ff2829 100644
--- a/net/core/drop_monitor.c
+++ b/net/core/drop_monitor.c
@@ -671,9 +671,7 @@ static int net_dm_packet_report_fill(struct sk_buff *msg, struct sk_buff *skb,
 	if (nla_put_u16(msg, NET_DM_ATTR_PROTO, be16_to_cpu(skb->protocol)))
 		goto nla_put_failure;
 
-	attr = skb_put(msg, nla_total_size(payload_len));
-	attr->nla_type = NET_DM_ATTR_PAYLOAD;
-	attr->nla_len = nla_attr_size(payload_len);
+	attr = __nla_reserve(msg, NET_DM_ATTR_PAYLOAD, payload_len);
 	if (skb_copy_bits(skb, 0, nla_data(attr), payload_len))
 		goto nla_put_failure;
 
@@ -831,9 +829,7 @@ static int net_dm_hw_packet_report_fill(struct sk_buff *msg,
 	if (nla_put_u16(msg, NET_DM_ATTR_PROTO, be16_to_cpu(skb->protocol)))
 		goto nla_put_failure;
 
-	attr = skb_put(msg, nla_total_size(payload_len));
-	attr->nla_type = NET_DM_ATTR_PAYLOAD;
-	attr->nla_len = nla_attr_size(payload_len);
+	attr = __nla_reserve(msg, NET_DM_ATTR_PAYLOAD, payload_len);
 	if (skb_copy_bits(skb, 0, nla_data(attr), payload_len))
 		goto nla_put_failure;
 
-- 
2.43.0

