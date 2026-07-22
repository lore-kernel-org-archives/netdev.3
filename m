Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE58D40F737
	for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 10:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784717083; cv=none; b=VtOyx8PsKTUtUakwCS9YF43B8uSqCxwG+SVgyy8cgU5bWFObK6zcXXEq3TsGnIOKxc+PRmKGY8ZCmk3qOhWbtCdEFrAzyl97yAjpaBlxtw2IfhFPy73j7+9w9ZuZq94Ca9TvxfmGdXcNiLyKC9tZeErZCbIuuCkANfDRU6zPpjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784717083; c=relaxed/simple;
	bh=aa+xes5EVTH2cdfL9asTzmuuxnDoeHgeRLEzA1fR3z0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DxVjCDuUqHsEuhgGYm5LqJNlyh9NQ7S6GPpaEmv2aa01xJF4VtlbIzd+GYYXCGdzQO3GCiWKeYGwQf5GQIBveClIOv4PxLNNm84XUinvr6A658I8aHKTExOV1v0qDMNRNLGMeVFLJLRCTxwP1PoUY3sAob/KA2P5UneS5YN12uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr; spf=none smtp.mailfrom=isslab.korea.ac.kr; dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b=iwPFDUHX; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b="iwPFDUHX"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-38e3617ba36so6814513a91.3
        for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 03:44:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isslab-korea-ac-kr.20251104.gappssmtp.com; s=20251104; t=1784717080; x=1785321880; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=HtMiEqgjJ43JzVvLsgi0+3J6JR6aigqKa2wm4e7uPrI=;
        b=iwPFDUHX1ekmHXpFAuq6R/YMYd9iTlyAMNAAR6KDvVilF9XnzdZvQ2Tmx4eZNZDheG
         7I54/W78fqIHF6zQPW/1fS26B9xNiBguzpLkTIRxioLEPDlVdS4nljk5xuCib4SiUm2a
         1eadEsIZN7QysWS8YPeH9Ywxh543EyuUmEJySiXA0wQp39QZl+S+tMHYGFH8RMKc7d1x
         OrPhQ/w8/SKMcUgmpCBrjLNq4WCQO05qsSXclEzf0O5mRQtsHOpTrAJyLGbvrOpMcauV
         uZELifBRdSYP9ln2XkNznzE3xHsiYBJxgiQ0MruJR/37HVZtxvGqnhmcJFCSK8+eEipV
         oY9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784717080; x=1785321880;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HtMiEqgjJ43JzVvLsgi0+3J6JR6aigqKa2wm4e7uPrI=;
        b=AjDZI1X23fMYWEiqx+3cZFP4YsxVHRVyqAaHLj2QjEVr9RY1kj5dUqydIyTWsqqQ3T
         Jg/pestHiE/+msGfLyfd9MWRX/j6WJ4JgGJz4nF4oTg+hzNbwjviy6G7jjhnH1LM+8cy
         6ajTg48e71FjEpd5W8ZP8uvfCqB9QHnrxm7Y+Rh84pJdL9ddHsP72kz0DLXQHf0OT8O9
         j7a9wCQlWBRNSS5Q02/Ih+xanhkiR3Y+0r29dXdFRjIxwEa+8WYYRo0HRqyYNy5EOAtc
         AVtgbQm/F4FGdAQCTnhj9SKHfjmVO6UxrM4Gw6jLnSwyH5i/Btsl/gad1QbnRaxK4hi+
         8LrQ==
X-Forwarded-Encrypted: i=1; AHgh+Rpq9R5a2kpa52So8trHTypbonAK5B5Hs6s66f1vn1qNEKq+hBmhlXI8J2XEj/WcRvC66h1ksEM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPv1tC7q8LPdcUZmrs+fRFZP2mYvE9T1NV/4WFxfswKNgEmvDi
	p2su7+t4dHF5KPcDZ+SybtnPBSyfc9oZ2ExLUCdejXmCZ/kSE6+MkZAqur7v4plpHx4=
X-Gm-Gg: AR+sD1282DRKTQfE3C63I+RqZQ4M/fnH2knO0+koGrcL4u97uGnFYEmfnrqZ8lkCYA0
	Bi6vuScBKuHOYTvKxip2YZF+R2b3JACRjX5Wlxuyy3KvDr2nNkD+wqM9WPmdGmBqfoKOMs3dByJ
	3SyMvmU/7exKx51NGdbgVOz+jBoAZ/oopRQLwPfK0gXeF6kuOXl5eUMMwyguH4uTONVdd0ZiJ3+
	hSdykqSFD+fq4gP1tEhOsanKstbqh37jXdHL3c6/+GhvQfkEd2jOhNNA7YQll/pZff8Qjy8XvlT
	tABy+mI1hABbJ3q5dPIep5Ri5WlFGPEOoC/Gqo+caBld97PUgWDZEwB0SzkgdeHjpDsT3uez6c2
	TqxiEDZa5npQk2tuzhIPBTonUVJT28KdHjyE33odQDC26GwSou+A7dK3yAJrt5MFMvQjlU5dWoz
	JZyLCRzXU/qQ==
X-Received: by 2002:a17:90b:3c0f:b0:38e:408:9d7d with SMTP id 98e67ed59e1d1-38e4b56d824mr22043839a91.36.1784717080006;
        Wed, 22 Jul 2026 03:44:40 -0700 (PDT)
Received: from yhlee-960QFG.. ([125.131.91.97])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38e921698d7sm3090392a91.10.2026.07.22.03.44.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 03:44:39 -0700 (PDT)
From: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
To: Neil Horman <nhorman@tuxdriver.com>,
	netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Jiri Pirko <jiri@resnulli.us>,
	linux-kernel@vger.kernel.org,
	Yehyeong Lee <yhlee@isslab.korea.ac.kr>
Subject: [PATCH net] net: drop_monitor: fix info leak in NET_DM_ATTR_PAYLOAD
Date: Wed, 22 Jul 2026 19:44:19 +0900
Message-ID: <20260722104419.273358-1-yhlee@isslab.korea.ac.kr>
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
before overwriting it with skb_copy_bits():

	attr = skb_put(msg, nla_total_size(payload_len));
	attr->nla_type = NET_DM_ATTR_PAYLOAD;
	attr->nla_len = nla_attr_size(payload_len);
	if (skb_copy_bits(skb, 0, nla_data(attr), payload_len))
		goto nla_put_failure;

skb_put() reserves nla_total_size(payload_len), i.e. the header plus the
NLA_ALIGN() padding, but only payload_len bytes are copied in. When
payload_len is not a multiple of 4 the 1-3 padding bytes are never
initialized and are leaked to user space inside the netlink message.

This is the same bug, and the same open-coded pattern, that commit
aedd02af1f8b ("net: psample: fix info leak in PSAMPLE_ATTR_DATA") fixed
in psample by reserving only nla_attr_size() and zeroing the pad with
skb_put_zero(nla_padlen()).

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

Zero the attribute padding in both the software and hardware drop report
paths, mirroring the psample fix.

Fixes: ca30707dee2b ("drop_monitor: Add packet alert mode")
Fixes: 5e58109b1ea4 ("drop_monitor: Add support for packet alert mode for hardware drops")
Signed-off-by: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
---
 net/core/drop_monitor.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/net/core/drop_monitor.c b/net/core/drop_monitor.c
index 2bf3cab5e557..6a5bcaf21b57 100644
--- a/net/core/drop_monitor.c
+++ b/net/core/drop_monitor.c
@@ -671,12 +671,14 @@ static int net_dm_packet_report_fill(struct sk_buff *msg, struct sk_buff *skb,
 	if (nla_put_u16(msg, NET_DM_ATTR_PROTO, be16_to_cpu(skb->protocol)))
 		goto nla_put_failure;
 
-	attr = skb_put(msg, nla_total_size(payload_len));
+	attr = skb_put(msg, nla_attr_size(payload_len));
 	attr->nla_type = NET_DM_ATTR_PAYLOAD;
 	attr->nla_len = nla_attr_size(payload_len);
 	if (skb_copy_bits(skb, 0, nla_data(attr), payload_len))
 		goto nla_put_failure;
 
+	skb_put_zero(msg, nla_padlen(payload_len));
+
 out:
 	genlmsg_end(msg, hdr);
 
@@ -831,12 +833,14 @@ static int net_dm_hw_packet_report_fill(struct sk_buff *msg,
 	if (nla_put_u16(msg, NET_DM_ATTR_PROTO, be16_to_cpu(skb->protocol)))
 		goto nla_put_failure;
 
-	attr = skb_put(msg, nla_total_size(payload_len));
+	attr = skb_put(msg, nla_attr_size(payload_len));
 	attr->nla_type = NET_DM_ATTR_PAYLOAD;
 	attr->nla_len = nla_attr_size(payload_len);
 	if (skb_copy_bits(skb, 0, nla_data(attr), payload_len))
 		goto nla_put_failure;
 
+	skb_put_zero(msg, nla_padlen(payload_len));
+
 out:
 	genlmsg_end(msg, hdr);
 
-- 
2.43.0

