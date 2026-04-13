Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EDDA320A0B
	for <netdev@vger.kernel.org>; Mon, 13 Apr 2026 11:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776078049; cv=none; b=KTaDrUz1OnuszZtnJ44CXF8Iy2skk13BUks2remxia8cPbI11pgR1W+/m4M1TDF/HFWT7Wdzr5MWpyy+rfWDV/ZGjWahY823y5eERDTm3b3VnxDe06dc55TvCfEHbktBNi/2VKfBGkCNZbscCQwCL3a1/68g3vok53zS6yYNoME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776078049; c=relaxed/simple;
	bh=VZ8HyhhFjFyVQH7uSTfub/ydKk+nqQohlEtDDAToMxo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GALbBlPVN40fiy9gq7SpWz8aZQaiISetIN2pK6FOcHMyD8zBqrkaIxR+fBZugzjiJkG6EGz/UnakUjW+ILWlM6FGgJmAdodvmGPY7Y4/LrVEdntEm2hnxAsXl7JZBToJcDj5T0Fucf2SerCslTJR3Q0515tEXDzAr/i4j97Jlms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NQvRH2li; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NQvRH2li"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-35fb166b0c6so457012a91.0
        for <netdev@vger.kernel.org>; Mon, 13 Apr 2026 04:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776078047; x=1776682847; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WlXWYUs2IaHZYtZ4dVKqvKjo4K/vgTx13ZoUtAyHYF0=;
        b=NQvRH2li2NBvdQa6pH7Z+KFRhxsz2x+8PJWOFMgjuAW1lIb+AfrpItmk3wVPKYpxeJ
         +kBk2M9UZGvELLYYCiCdbDBV0RneGLmit8Vl8shmMrwbVcsnbGvegui3b9iph/hCn8bz
         6l431CwvmIUZHkmroX0TYEucNZVkfdes94wqox/ROJmW/d7k/7uZptP3qIJ314yxg7KI
         gtk7OYfVmZetMKR5qlRb9fkhyFcjso8GJYsGvhwtR+p7WaT1azpdkl7xKpLWe63zYSsK
         8I01jUW5yG7emiSVsbH6ezf/pi8mOklkxY5jCC3PI/lZ8bPYG7HjFGMbPbrE85gXbiuV
         VC3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776078047; x=1776682847;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WlXWYUs2IaHZYtZ4dVKqvKjo4K/vgTx13ZoUtAyHYF0=;
        b=n5jXkBGzzPAn2RNTppRRc1CfvkCq7a35L5K+RgRG7EZh3cRqOZJkhhGq1kjolcEwlI
         ySK2dAW6SFMrzyembK0iqnTlV6RBJu4Rh0O9PncmR8I/uDSAybW/DbZtkOIh1jgGq/FU
         f4Lxw1lpQRl1oB4PB9xZ1UYBueQ2UfiK+fekg83Pjc+JiNMEsgDm/PNKPzbs+JbzZ68r
         v9JjSnHYEnIzS0fazkiqA3VobUNhJNhqLDIdI0Vr3gFhXrDMyJADZWiP44MvAwun38yw
         4V+bZBOTuT1/sIocPRFV0oVbZCo6crsWI5/im/qZo5Htbsq8X+AAbpk8UpU5r8qmbWwF
         yIFw==
X-Gm-Message-State: AOJu0Yz9mx0DbfG/VJZzitO/2i4ru5FZzMgE2ueQNb2JFs+pORSGEUZQ
	WgSZZvIh9Z2VvQRK23E/yr9w1D7hewJJzHjNs4DsdKMKxfVZJ1+bP6NvTs+VDw==
X-Gm-Gg: AeBDiet4RbwqD8PSNzO6OALUBqIpPhcdF7wQlmkqp43kqeH3gno5PYvd/EBSD3UYFWA
	zqZNrALdZrP46Gin6RKDGGiqWS3WU5u8swB7YsQQOmDtQyRuQd/gbw3Z+m9S9WE/RFlVb58lV1s
	9JFUmYMEhtSzIiRjalaGMLw/WcvNbuKQZ//0v6aU9qGGcUYgQV59laeCv6MrW8AZd4LMb7K8PVX
	3FoqTkUQHAxqL2QOnRq83K7yMTJQqKg20kvtsKo7GLChLgFiGYBB3ds0xS+nCrWf7wGBU8R77s8
	zbuIxIel/cXsxFV18Q/oCqQHuqrg04HPUrn4GGKhcwQnRNU3IeQd7b9ZMpMU4/vnN7ibfLN46Yb
	VgFG1V2HkAl6ZtLx/ycLD4enVzwHF27dTn4Zu40QAm/Hgl53VK8SW8cACsauNRHcoNdutZs/4K5
	s0PccGeNPPOKnqXoBJOg0+umA1Zh79obVKWA==
X-Received: by 2002:a17:90b:1d91:b0:35f:b57e:7f33 with SMTP id 98e67ed59e1d1-35fb57e8053mr2712625a91.14.1776078047091;
        Mon, 13 Apr 2026 04:00:47 -0700 (PDT)
Received: from gmail.com ([218.253.131.218])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35e5aebb15esm4545825a91.4.2026.04.13.04.00.44
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 13 Apr 2026 04:00:46 -0700 (PDT)
From: Dudu Lu <phx0fer@gmail.com>
To: netdev@vger.kernel.org
Cc: toke@toke.dk,
	jhs@mojatatu.com,
	jiri@resnulli.us,
	Dudu Lu <phx0fer@gmail.com>
Subject: [PATCH v2] net/sched: sch_cake: fix NAT destination port not being updated in cake_update_flowkeys
Date: Mon, 13 Apr 2026 19:00:41 +0800
Message-Id: <20260413110041.44704-1-phx0fer@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

cake_update_flowkeys() is supposed to update the flow dissector keys
with the NAT-translated addresses and ports from conntrack, so that
CAKE's per-flow fairness correctly identifies post-NAT flows as
belonging to the same connection.

For the source port, this works correctly:
    keys->ports.src = port;

But for the destination port, the assignment is reversed:
    port = keys->ports.dst;

This means the NAT destination port is never updated in the flow keys.
As a result, when multiple connections are NATed to the same destination,
CAKE treats them as separate flows because the original (pre-NAT)
destination ports differ. This breaks CAKE's NAT-aware flow isolation
when using the "nat" mode.

The bug was introduced in commit b0c19ed6088a ("sch_cake: Take advantage
of skb->hash where appropriate") which refactored the original direct
assignment into a compare-and-conditionally-update pattern, but wrote
the destination port update backwards.

Fix by reversing the assignment direction to match the source port
pattern.

Fixes: b0c19ed6088a ("sch_cake: Take advantage of skb->hash where appropriate")
Signed-off-by: Dudu Lu <phx0fer@gmail.com>
---
 net/sched/sch_cake.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/sched/sch_cake.c b/net/sched/sch_cake.c
index 9efe23f8371b..4ac6c36ca6e4 100644
--- a/net/sched/sch_cake.c
+++ b/net/sched/sch_cake.c
@@ -619,7 +619,7 @@ static bool cake_update_flowkeys(struct flow_keys *keys,
 		}
 		port = rev ? tuple.src.u.all : tuple.dst.u.all;
 		if (port != keys->ports.dst) {
-			port = keys->ports.dst;
+			keys->ports.dst = port;
 			upd = true;
 		}
 	}
-- 
2.39.3 (Apple Git-145)

