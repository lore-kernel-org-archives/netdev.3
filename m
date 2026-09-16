Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CC014F053C
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 12:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789562528; cv=none; b=BM3lmm8GrFt7YDqitI6f2dbX2L6pcZFxCltuytgwWCIePw/y3IfvOdm3gP8BfgLJv9uPt7+JOT+QkZASsmllh1hVp3d9ZSdoZ5IdXWtZ11RGWp+6/klcm+3fulMFNFxV9NapQL9XCGSWY2GftU8g3ncaA7XIStR8v3ofti9kN9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789562528; c=relaxed/simple;
	bh=ds1bo4pwxQdBiUgJBCPtUtc/GnamteKwx+efkM/Pa0A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=STSrRrjiDxA/7nH1Eg5axb7Om2TcjtL/+yNLjKIbecnMQScfPGgWkq3SsLkppLYuKX6Upv3XLNw6DZ3ibyNtlC/7EsPBxYfZx/ls87cXfi+4mBT1MR6n1rqox29mqnDzQuiuhbsEbjBHU9ZFv6TXoJhXoohgB+eKMZ5t6Tjyna0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l6K/aQ+u; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l6K/aQ+u"
Received: by mail-pz2-f12.google.com with SMTP id 41be03b00d2f7-cc4aa0f1a94so632190a12.2
        for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 05:42:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789562521; x=1790167321; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=W9M5OuXlFLCy9BLJR1BD5x0IKdwWKcWD6cmzPENDMSM=;
        b=l6K/aQ+u+RYflQHxzAjieswiT6UKVGVNIKCuPhmcU4NmUVt2zUdSZtNve+TbGVqQ/j
         YEihSgiHRC/2dDLUY1X+5+suvFaGYBPkbthADb3bznQf1jQXI6/QEC9kqqE6H2KBX8It
         mrS0RiajwNtECAwlD4U0cDsAsPShSgkoW/2bC/4DLCnIyS9kQS5F3l5mqqWDL9C3MAJ1
         IjJNJP5GzBPwUYFmYufWYPqTmYnOEzHjuU+qIK4QlZujtaWYeTbFPh8qbJZLlW3LoTh5
         UdDeBp3p8QK76YrC6V63SDQwvHGO9Qln6ndkQhcW/o9gXwHxnGufl5fxPJf8gM4ulGug
         pyvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789562521; x=1790167321;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=W9M5OuXlFLCy9BLJR1BD5x0IKdwWKcWD6cmzPENDMSM=;
        b=HvvoKD8o1iTe3LZr1CEq1Kj6c0daXySYmhdVVEeb1k/ECqqnv+FT9DboOHszFuoVmJ
         6LZCa2SHcVCWb5lxK7e4PBVAwmtPZo9L5E84csec+t7TaFya79SN9Ab8ff2MIb1HpkdT
         A5Or/YO5sOeGCX/CnMIHZhx/4j2hhLBrdgvCEsN3kQFPsvVtU/W/wmdz4hwOz1jNTA9O
         ceQveRPZ8lfpBMCCs0IGL/VrSC8Izn8XD/U/+mKGtGgY8m3DNv+xPPTUKKrC2KjGWvRV
         OvtBcfFCnpc/EjdwAsDKGOPgQKUqmo+Ujubc4z/D4sZKQsUGW2eXxbEdpyuh/OM0x9zW
         UD4w==
X-Gm-Message-State: AFuF++nNx2cfVPIloT0XrI1YJummbF/TsBIZYUukSYAZGCiNTXQX82n/
	jKgfhEwofR/ED+B7fd04VgbSAmsJxnpXpA9Z/yCjJydM+uf37Migky1XkdeEIALpxrLBDA==
X-Gm-Gg: AYBFou1SURkMmp7RlK+Oq7ec94MUvfMOIqYVYhFaU+beMdufOf062BFXqWh5BviN8Ig
	49ESp3ddjNgtVt3WOXXeh3z4DF/QmpCRjLE2XzlocGUWtt2Uj3HhEvVzAAevCiNRmvAC7fJ1SIR
	kAghjX9Cy8flfl8UaXknhTGugmm/mQpZwuGYeaqVJmupZLj3W0Nk6s8XLhyPcKEMJur48HQbwcG
	O7e51f/fwm0sR8R1z7SH9czWlCuvqEB0WNOEQ0bEeMt93R0n0OonUpsB6b3kSYTmex8g4oYEvld
	Wiv7XM9mjk1MKrHbfGfmhPpSywy2fpV1eabLOfQReVHxrX656oldxLfluoQ6vo5p8LxNRICYfZi
	Tgl5Ryt6XC6iwh/aGNApaR35HrhbkvaQ0rjsUDrNzZM4zJYrvrLXjEqKOjqGfgJ3drbZnPa5uZY
	8fwwoeyE9B0w7DJPpHJMvaq3TZrec8sMeX+UqGFUzIcUddGU411JxVEczBrgKpzTQNNjxx3IK5e
	RUpg1MejO9rAtzhVBXFKi57BiwWoiDeuI1F7pXGnD/B3rGGjOSalqhjkE2hKKUhrT6LQltNqvfs
	5lz7x4XO6V0mbXdyA7SuC0EHlGPIm1Y80F0e/gdxLMS/a0wxhZWSPFSOB1A=
X-Received: by 2002:a17:90b:380f:b0:39e:1494:1863 with SMTP id 98e67ed59e1d1-39e1e56b3f6mr5557144a91.25.1789562520844;
        Wed, 16 Sep 2026 05:42:00 -0700 (PDT)
Received: from KERNELXING-MC1.tencent.com ([43.132.141.24])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e1b69331esm5070948a91.4.2026.09.16.05.41.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 05:41:59 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	willemb@google.com,
	kuniyu@google.com
Cc: netdev@vger.kernel.org,
	Jason Xing <kerneljasonxing@gmail.com>
Subject: [PATCH net] tcp: preserve timestamps across receive queue collapse
Date: Wed, 16 Sep 2026 20:41:53 +0800
Message-Id: <20260916124153.43457-1-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When tcp_collapse() rebuilds skbs under memory pressure, the copy
process doesn't include the right tstamp and hwtstamp from the
old skb.

In net timestamping case, if such an skb happens to be the last
one consumed in a recvmsg() call, the application receives no RX
timestamp for that call.

Fix this by copying both tstamp and hwtstamp to the new skb right
after the initialization.

Fixes: 98aaa913b4ed ("tcp: Extend SOF_TIMESTAMPING_RX_SOFTWARE to TCP recvmsg")
Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
---
 net/ipv4/tcp_input.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 0f60a1dbf927..c5756db892f2 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -5835,6 +5835,8 @@ tcp_collapse(struct sock *sk, struct sk_buff_head *list, struct rb_root *root,
 
 		memcpy(nskb->cb, skb->cb, sizeof(skb->cb));
 		skb_copy_decrypted(nskb, skb);
+		nskb->tstamp = skb->tstamp;
+		skb_hwtstamps(nskb)->hwtstamp = skb_hwtstamps(skb)->hwtstamp;
 		TCP_SKB_CB(nskb)->seq = TCP_SKB_CB(nskb)->end_seq = start;
 		if (list)
 			__skb_queue_before(list, skb, nskb);
-- 
2.43.5

