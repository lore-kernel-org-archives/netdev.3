Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.231.138
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793879247;
	b=K4nWyL5h+pfGs3aWi8t3zuujf2JgzeGvAny8V/v2GV/HTJH0ln2GSnrxVzh9J4JNcm7B
	 DqdYkMeM7PnvR1bfc15g2cpU8rYJGwFzoP5she9Ea2IVjbp4zctWslfNE5IYJEMWUCVy9
	 9tfIRn80M+O1sGKHoZQdFPQ/TeofUDHQqQlhBkEhLKja7mso6oCOCJwSPIcld+cIr6lcQ
	 3XKBLjQxd/4NKT9EIghVYDXNQyv/Q31o1r5uGdfHNCrg8bqStrHACZB+o9LXY39C2CpsJ
	 HX7QqLSu4ISCyT1Eij/zlX8JN4fBJ6pmmRKVM4LfuotHSeTx+P4HTRAuUrxkhaAL9Yw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793879247;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=gvWI/tdBBMelOS87owt2y2j7vRTweXagYLYewMb7XOg=;
	b=OLnC4a0N2jjzcTJdAxuZjpBEqR4myHdqz9aidRmtto3bP3hVS7UMSWubEpQoEYVTuPd/
	 xfKtn1FmWuPNkaZUQr6opmbM8/lOePvcWhMSKvUM+SQ8Z8AsgOOCFlTuMA86NYiPOQo0j
	 PG/DpC0XSqGinDqYaISvS1Zd6WFTOxq/vXoAM2QRRV2A1QqxfRNeWmXE/AduKpMzdQ1+W
	 oYVToaRmpWYZFQbbAqEFYncSFUs/e7QWi0nimNpEf8WOGm8UGNbF8GKAh8IkF3Ud5SNal
	 /slp21tmGZpPppwLFHDt/QQp+lRp8n+oxob+9G3hqXFC1dKzjbip9hGXfxjT4KCd1pw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eWeVK3LF;
	arc=none smtp.remote-ip=74.125.231.138
Received: from mail-oo2-f10.google.com (mail-oo2-f10.google.com [74.125.231.138])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5386D606A335
	for <netdev@vger.kernel.org>; Thu,  5 Nov 2026 11:47:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5386D606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eWeVK3LF
Received: by mail-oo2-f10.google.com with SMTP id 46e09a7af769-820ff812cd8so372553a34.1
        for <netdev@vger.kernel.org>; Thu, 05 Nov 2026 03:47:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793879246; x=1794484046; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=gvWI/tdBBMelOS87owt2y2j7vRTweXagYLYewMb7XOg=;
        b=eWeVK3LFJ67QiftlI+LA5YLEgkdaFNdTRJZrztVnh6C7RDAo44BhSxcxj4Uq3UsVcK
         4mVxBxvQCy3s0aIt8tSYBTsEhlnYRW97lokXN7VOYA/M/cLhyBdK0WSjPJyAYJw9hHqr
         VEzntUbo/Q2l2o3PS3Mkl5Pt3EG1eWo/X+BQxdThJaFnuAAVRVw/Xl7uQbJqWf+v39kZ
         inOg1mTIR7wUCJ5i7bOFm1eOlgDUVGyaAzmamPKknll6xyyjeosf80xSo69Xq0Yq8sIi
         zh62ZvvUlz7uWy2pic/AEW5PKX1UjCevVXfPBkfn2oVmiGmBoTS4v0c1r7bbaxb9ReRy
         02fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793879246; x=1794484046;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gvWI/tdBBMelOS87owt2y2j7vRTweXagYLYewMb7XOg=;
        b=BL89LDQCjoy1j2lENiYYrQIs3ZQdhnDR4nml8VmBEhkdrkg0J1M1/NyJ5xkavL1/YI
         yQwI9+CeZ9d74uKqCTVtrV/PzKMpzqRzKwC8Gsi1AFi1yb5Gx02qXymdAKa9W7MX9X/M
         znxfPdGL55CniyDH2zqn75IZTMIGM7zaxuu1Td+W0jo77RQOSy0LnLx5FHE/oUC2mW+L
         VYZ1nYURmatwHj0g6qqbCrOyQFVWaR9LNdYvpBtP2aQ+HmMxKXwM3DFILEqjpiusSZLf
         SFBhBdjckxP3IW2jZT2TkkUWKW84WVMktnftjSqJAERpM0I+GXcfrKrhrtEOSzPa6GmB
         Kmpg==
X-Gm-Message-State: APuU4Z+1NQBbXGkNiWtWLu7eLyb4q4T3Y4/DtQ3CeChbq09BarFpiIJX
	dsyqy1tkj4rzGTSxIeIbZ0PzQvhqDCV3fJmmg18X6la7tvhlumQGMaqG
X-Gm-Gg: AYBFou0zKarDaY3F4DDN6mLsVnwMoi9uvppSeQlLDqy3OSdC5FTfJu15di5rBQx5agP
	UQjaeVC1d0/JZHWgYqP26ciX3JRP6PSZFR0b6kwoK6iCYFbWL/bsWzVKa4ZsjbqT3KqNmRlIX7l
	aYZkYup1caXTxdad1t0JRqRt5RXZDoS8t1pjvM11CtVv0UUbm6siXjV2suEg1cR0gWEuCtFBG9T
	Qf9Rxa/OEYB87XpPr3sLLh5eH1diEq/9ri4btVneBkoKntGlRcATyWXpexnB0a5aQm5D0u4aIs7
	85sSiUNFY6EnYbBySKaOrd0tFh4nYGZ7Mqkeg0CrHZBr+fMeBx5HNtKDoSQFz3R84xME6gQ5u9x
	n3bd9O0BHVlGGPdD/l3Z9vzY6ML5KdW3svFPrWScxcOIZdMUAiQZ0FpdMf3t+X/rn71Act9EMUQ
	4mZM8P/+DTP0Vbm3oYeGDN1UlP2ScvQCXbn6qaLc2Y645sg6TCgHpafOiG470+hXpTFMSvz7K3g
	WPgdMMjju3rhy3192DAR6K2U6Mh5RmwFUiq0t4xW6gMhY1tiThKT2M1XGXUgWGB/vDo8DQf0wHi
	dJLHzQU3sGeLTvLHifNrxcLv5Cih6x7lNuthz1kU+2mvM/Te3lCmMT3q7H7x0EO8eSIC
X-Received: by 2002:a05:6830:719f:b0:83b:3feb:4f04 with SMTP id 46e09a7af769-85d36298d84mr14347881a34.4.1793879246149;
        Thu, 05 Nov 2026 03:47:26 -0800 (PST)
Received: from localhost.localdomain ([14.116.239.33])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-85ef37dc277sm4735727a34.0.2026.11.05.03.47.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 03:47:24 -0800 (PST)
From: Henry Martin <bsdhenrymartin@gmail.com>
To: dsahern@kernel.org,
	idosch@nvidia.com,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	namangulati@google.com,
	kuniyu@google.com
Cc: netdev@vger.kernel.org,
	stable@vger.kernel.org,
	Henry Martin <bsdhenrymartin@gmail.com>
Subject: [PATCH] nexthop: fix null-deref in nexthop_flush_dev on UNREGISTER rebroadcast
Date: Thu,  5 Nov 2026 19:47:07 +0800
Message-ID: <20261105114707.3030737-1-bsdhenrymartin@gmail.com>
X-Mailer: git-send-email 2.43.7
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A device unregistered outside its netns teardown can be stuck in
netdev_wait_allrefs_any() while the pernet exit handlers of its
netns run to completion.  nexthop_net_exit() frees devhash and
sets it to NULL.  The rebroadcasts then hit nexthop_flush_dev(),
which dereferences the NULL pointer, e.g. on mainline v7.4-rc1
(KASAN build):

    Oops: general protection fault, probably for non-canonical
    address 0xdffffc0000000004: 0000 [#1] SMP KASAN NOPTI
    KASAN: null-ptr-deref in range [0x0000000000000020-0x27]
    RIP: 0010:nexthop_flush_dev+0xb8/0x240
    Call Trace:
     nh_netdev_event+0x250/0x330
     netdev_run_todo+0xaa2/0xef0
     rtnl_dellink+0x35f/0xa90

The faulting task holds RTNL, so the network stack is left wedged.

Skip the rebroadcasts, which are the only NETDEV_UNREGISTER events
delivered with reg_state == NETREG_UNREGISTERED.  This mirrors
commit fd0909e963ed8 ("netdev-genl: ignore NETDEV_UNREGISTER
rebroadcasts").

This issue was discovered by Tencent CodeBuddy Security.

Fixes: 8a4fc54b07d75 ("net: get rid of rtnl_lock_unregistering()")
Cc: stable@vger.kernel.org
Signed-off-by: Henry Martin <bsdhenrymartin@gmail.com>
---
 net/ipv4/nexthop.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/net/ipv4/nexthop.c b/net/ipv4/nexthop.c
index 42e55b5a755ee..1eba7026abcae 100644
--- a/net/ipv4/nexthop.c
+++ b/net/ipv4/nexthop.c
@@ -3996,7 +3996,16 @@ static int nh_netdev_event(struct notifier_block *this,
 
 	switch (event) {
 	case NETDEV_DOWN:
+		nexthop_flush_dev(dev, event);
+		break;
 	case NETDEV_UNREGISTER:
+		/* netdev_wait_allrefs_any() rebroadcasts NETDEV_UNREGISTER
+		 * while waiting for the last references to be dropped; the
+		 * netns and its nexthop pernet state may already be torn
+		 * down by then.
+		 */
+		if (READ_ONCE(dev->reg_state) == NETREG_UNREGISTERED)
+			break;
 		nexthop_flush_dev(dev, event);
 		break;
 	case NETDEV_CHANGE:
-- 
2.43.7

