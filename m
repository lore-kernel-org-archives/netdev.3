Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B36AF346FC3
	for <netdev@vger.kernel.org>; Sat, 15 Aug 2026 08:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786783620; cv=none; b=VTBH9aKDz9NCKEqJ413NvWVsxTGe0uOOMMyQdlokLBrVbkXUbQXQw1UYhByn+jy+tsWa6xg/S2sGQvlkwtYdhxCej+5SUZtBAMqspFWGzcKrYFy30d4ldqIieUblmzrdtTn5llnVQVuKGOmAROH3OPuTifxSvx9hAJt/60jkmDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786783620; c=relaxed/simple;
	bh=lqX3NFVJb1A4/zvjomlEJ+gLbOtrMdo0bbyB4Eoxjd8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fac6bk+4zqgZxFXE8I4pQzFoKg+bPEYbAadqfiEAv/cup3G7yXDhOZCVXoVN6scKzspPuD0X0ZBO1ZBE0UZi2glujMt06WtLmpezadma6Qgij4Ng/s9+4ogl09gr4XCdLkJRobTHhkgkVpSLz/De48t8a1eEgvSlRty+EF9oi4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ULsNAUsc; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ULsNAUsc"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2ce7d2adef4so30689065ad.3
        for <netdev@vger.kernel.org>; Sat, 15 Aug 2026 01:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786783618; x=1787388418; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Q35baY3576CpJCsemdJuaEMGFcmNQl1jwCggun4sD5Q=;
        b=ULsNAUsc0CMKaatwkE4HmBtndUjqMJSvDfWfWpMU4zHqIvPGpe5dVqrA1xA3cKIBXL
         YqU1+OMzS/5P/tgeaqv2e7wJjQ7tBX0NK7gxussfmViP/zomSxISScQoAUZu0F5rTMGD
         v3eVrhifa4WMXz60Okdd8SI0pQOgOuHeJQr/RwPOQjzYRQhgCZmZCAHLGOiYCmbzywea
         jYZJQ/IBLnqGx9o0pqbbY3AuW8WH4mJnBG6bUHEq5dR5WKGGpxPpi5Yl813CJJDDfQBT
         ftq7KXVaN3ss2808Vjy4r3urUNg/eLFO7V/GTfmE6fG1w0ps04ttLcP0TCzRZ17F1QKF
         Yowg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786783618; x=1787388418;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Q35baY3576CpJCsemdJuaEMGFcmNQl1jwCggun4sD5Q=;
        b=HtJkVI+BRGNviVSWLF2vCVx64q/q4XRJZ3f3qxE/dh8Y+eiChrbF7g186p5FaUICWW
         xOgSv8vcJ+AiI7JGDQ1Z8k3XDDWh2MIehvfTfcc6800JUoVHXPtTKSSjTMnISI4fXfi8
         N5Db5IufO/d3Ie6FexjI4+9rj/BdkHRyW9KwOgpvjzYdQtohBWspT3wzxwCafN1z9NmM
         r4cIFJ1UtjopZjSNG0oCiS3N/IPsBIUxLcjETAhV5j/PbNSr4rPC5EXB6CEG9ajZd4ca
         G2RB4b9ca2GwYqfi9sYtlUEDUnCw7BtIKDx42cQ31uLx2QKd7LwuVQBjySflpZleUDe1
         03Sw==
X-Forwarded-Encrypted: i=1; AHgh+RpJi92mmL1wNTBgBja8hdyiYYQX1R0yg2sDzIBXKsxsgMDdbGwu+wsWajFfVOD9aEhCq2dXflQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6GkVq/NGUbKp4KeOuqR7hIxadIc+1AMTPqe0Lq3563GoW4HOK
	vNixiVWAZpltKHe/UlIpzWSnJ72QjX1D51XuQmwO3nYpO+xohTXH7awP
X-Gm-Gg: AR+sD12+tZlIswfWYgcDcxfWyS3AawBoEL+iraqOrqSHLTAPXt9O7DUw5/5L/HNTroN
	QZ+Hm6oEElteYelijf0EIwtXgADv4c6L5oes+T93VyAqiNm1BhhN83nSb0tkyPRkIyrqUvMyNqc
	FAncO5TTwiw9wXgHX5Mq/r7Kc7YnWqPsbfTrOeqcmmbuh2CSVYQK9xsp8pfBBdD/B0JZWMLAKh/
	+Vntn3j5sAzALWyDExRuAPNbIhS3Lr+3kgJVx7uJRVf0GCfhmT9ek1KJbqD376c3SVRLvjNe0qc
	OXBLmZZwv49sf9mX761EsgvzLVVfKFNZcSW5TTS3SUzxuuc7en+IM8awAugBGRl3rlu3Ek99gL0
	Xpmpzy8AS03C5Q9qfkHEchxdrO9vNT4VpXDB0KOYY0n8o7R+b4JNgDk00WjnmjI/6h4eFI8U5qx
	19O3sUnAZMdW+BbQ7nIc0sxrn/2dRJ6Mzbwvlb/o4OUK4rJ6SPbnDZybHD9N/nRvL+MRCqKt+rR
	hibPgpROK6r3HWBd3Rr9MBe8hQRRjO0ZkK/6CSOzA5lj9TXzJx4A9c4f+32
X-Received: by 2002:a17:902:ce8a:b0:2bf:dd0:c8b1 with SMTP id d9443c01a7336-2d3b04a8c75mr139852085ad.0.1786783617926;
        Sat, 15 Aug 2026 01:46:57 -0700 (PDT)
Received: from m-upc-A520M-HDV.flets-east.jp ([2400:2410:3f60:500:959f:bb81:fb2:a537])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d3ae753ae0sm18121205ad.8.2026.08.15.01.46.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Aug 2026 01:46:55 -0700 (PDT)
Sender: Yuyang Huang <uyoko90@gmail.com>
From: Yuyang Huang <sigefriedhyy@gmail.com>
To: Yuyang Huang <sigefriedhyy@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Stefano Brivio <sbrivio@redhat.com>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net] ipv6: use RCU iterator to dump route exceptions
Date: Sat, 15 Aug 2026 17:46:51 +0900
Message-ID: <20260815084651.69477-1-sigefriedhyy@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

rt6_nh_dump_exceptions() uses hlist_for_each_entry() to iterate over
RCU-protected exception lists. The caller holds rcu_read_lock(), but does
not hold rt6_exception_lock, so rt6_insert_exception() can concurrently
add an entry with hlist_add_head_rcu().

KCSAN reports this race (irrelevant details omitted):

  ==================================================================
  BUG: KCSAN: data-race in rt6_insert_exception / rt6_nh_dump_exceptions

  write (marked) to 0xffff8a7c44c59620 of 8 bytes by interrupt on cpu 5:
    rt6_insert_exception+0x3bb/0x760
    __ip6_rt_update_pmtu+0x4fe/0x750
    ip6_sk_update_pmtu+0x19a/0x3b0
    udpv6_err+0x3ff/0x800
    icmpv6_notify+0x1e1/0x440
    icmpv6_rcv+0x8c0/0xab0
    ip6_protocol_deliver_rcu+0x616/0x840
    ip6_input_finish+0xb9/0x160
    ...
    entry_SYSCALL_64_after_hwframe+0x77/0x7f

  read to 0xffff8a7c44c59620 of 8 bytes by task 549 on cpu 14:
    rt6_nh_dump_exceptions+0xb3/0x260
    rt6_dump_route+0x53e/0x5f0
    fib6_dump_node+0x6d/0xf0
    fib6_walk_continue+0x290/0x2d0
    fib6_dump_table+0x28d/0x360
    inet6_dump_fib+0x37d/0x620
    rtnl_dumpit+0x7b/0xd0
    netlink_dump+0x3ae/0x7e0
    ...
    entry_SYSCALL_64_after_hwframe+0x77/0x7f

  4 locks held by dumper/549:
    ...
    #1: (rcu_read_lock){....}-{1:3}, at: inet6_dump_fib+0x88/0x620
    #2: (&tb->tb6_lock){+.-.}-{3:3}, at: fib6_dump_table+0x1e9/0x360
    #3: (rcu_read_lock){....}-{1:3}, at: rt6_dump_route+0x483/0x5f0

  value changed: 0xffff8a7c44e05700 -> 0xffff8a7c45d60100

  Reported by Kernel Concurrency Sanitizer on:
  CPU: 14 UID: 0 PID: 549 Comm: dumper Not tainted
  7.2.0-rc7-virtme #38 PREEMPT(lazy)
  ...

Use hlist_for_each_entry_rcu() to safely iterate over the exception list.

Fixes: 1e47b4837f3b ("ipv6: Dump route exceptions if requested")
Cc: stable@vger.kernel.org
Signed-off-by: Yuyang Huang <sigefriedhyy@gmail.com>
---
 net/ipv6/route.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index 16dfac54a259..526535387512 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -6046,7 +6046,7 @@ static int rt6_nh_dump_exceptions(struct fib6_nh *nh, void *arg)
 		return 0;
 
 	for (i = 0; i < FIB6_EXCEPTION_BUCKET_SIZE; i++) {
-		hlist_for_each_entry(rt6_ex, &bucket->chain, hlist) {
+		hlist_for_each_entry_rcu(rt6_ex, &bucket->chain, hlist) {
 			if (w->skip) {
 				w->skip--;
 				continue;
-- 
2.43.0

