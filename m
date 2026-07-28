Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BDD831E82E
	for <netdev@vger.kernel.org>; Tue, 28 Jul 2026 03:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785208269; cv=none; b=sFZKqg5xfqdjYq5Dl2oW0XsKyrXmBxlIzaBcpGbesQZaALE4eWacmnKN47MvJK9tvA+kjtUNARf1fLCZeRB72GBK8YJ4/Z2D590AW0j3EB8ZjUHDyk8OQ2WiQtIZFCE5cwbT3aJNEFyqjURQUdQfVAPvmXED43QZ42JFF75XCdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785208269; c=relaxed/simple;
	bh=v7oBAjJMIhVfdijcfMPA9HrTDSWEC2QWu+BjAmEIkd4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WwAxz7zRMGIoyULGUEjaUzjznwKI8FsgjvXqdxrVT9M8MNEmnRrd8hOqawvKMY93YN/ZPPNCkgpLRGPWVrDjTW1axU6e6fXWM1mDy7dW5uEWp0FCfObDXy59BXynKdo/d5OcNoH5DjoHF8LHpmhNZC3ZCl2bwJQt7oLi0trxRCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cxhU7aSB; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cxhU7aSB"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-848c995c29dso166799b3a.3
        for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 20:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785208267; x=1785813067; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ts5/Y1TVWAmyd7a1WEfthTQKByaZz802Qr0m4Iw99Us=;
        b=cxhU7aSBNN+wxB3L5ZBNnm2fTXbC2E557Nc9xgSUMjcyabWrxAPWFgptQGOaD1CWQG
         cP2EwNbo8+O5olnpSVL23H1zmZuCgu4j+7oB5J3tU+XMV7x4Z0mU+bvRvXEloMi52NRE
         k7u5mHIyHkJE5dqQWjW9Kw1K0OqBeOsWtTnSjX+QDl6obMl7WaVofX/HZaPvMvXTtC7A
         +x0rNXZMDcXuhnuIdHrOO8EYSUna8hBWgd0jCPixb3iRd3s8VjzXkFf+naxslr5gfqQ3
         Xz122+/IHJMlw9B9Wfo/MQkJ1r4BKxIxzA2xgrGcGL6xE+wrzddESM93An2AolfIq7Nz
         lAtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785208267; x=1785813067;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ts5/Y1TVWAmyd7a1WEfthTQKByaZz802Qr0m4Iw99Us=;
        b=mQJGeJ5iahTNGBwwsLmEt/fbj3xuv3AeDo6khxcnSHRy2c8HGgYzRD8QmEqj3RbIK4
         R9mMBN+Of8TUvcRu7+jOrX7UvVDcxnejzILctzo7bXomYnOMZtOxojVK+R4Sub/YM6wd
         mhl4OrmLMhdlZkE4vdvT8bBMvDjRQmNHgrMiFZqMgeKwhxR6J/wJV0Qtf+fDw4oU0vfe
         ZycIIGPgtblgVbNiwkN4411vgiopC5cD8p/EIt4NCUN/NZ/KxClGpe01YTG/jlj0ZQBu
         PDV0Bfp4AKY/6Z0gG0JK5zs72j53qWm1utTyUPu4Y2/4ciMvFRJEDBBv+uW4FqhX4MVt
         5zLg==
X-Gm-Message-State: AOJu0Yyi/vbu44G776+et9xAfRLwUnaW9C7l+HS7g084aZuTl8L3/IiW
	n8Tqv0eSDBZ9Tdn64KNjyudkZBHUYuaSffy2ipo4wKsXxt5P6M88nuPXbmgLIMuX
X-Gm-Gg: AR+sD11nJ8djPSQc28YE9tWe5zPT9PhRxJokgjpdufX0Bn8+C6FRsv3I9TPXRZG/GdB
	FGc5zedVxkbOmJ8HaT6iEA6dT5am+eiUCbswkRRVRL/Nr7e1m19F6rmVRxXWxlHRQSnEDXmpDJW
	iKOwfYigLC8rykZnbZMSTULpf4ZI2jqIqscyZEBoOcNEoh/TZARuKSBE1CqqoBy/z3EtNqF9U8M
	h0PjSKmGl81YFG1BF3reuzoIbCxbdF5DJpQxWzZ5kJPbGGBzqRPCK4nHjt5sMyMiIFkpb2tPrS/
	Mt5/Xpoep4IKRnEQl15JsOF1rIdyxaKYO7U8jwvoR6UBRnku1zqWIRzaFA8ni0sgrqDabG0jUKO
	31J2F2Bu9ngr9eKPoQEZSOY/UzC4hBkXsc03RoWRSLPeA3RCUSXmkFToNVMOOiixu3mql6/rScw
	vTEknnkKemT/zlLpjTxuzpVkcSoLzJgq7LD8vOr0DjmrbwKNL+o2MlyY7raYV8PJRs
X-Received: by 2002:a05:6a00:2302:b0:847:8971:87d8 with SMTP id d2e1a72fcca58-84e9335ee6dmr364413b3a.6.1785208267429;
        Mon, 27 Jul 2026 20:11:07 -0700 (PDT)
Received: from localhost.localdomain ([139.159.170.93])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84e53470a92sm3709432b3a.60.2026.07.27.20.11.03
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 27 Jul 2026 20:11:06 -0700 (PDT)
From: Qihang <q.h.hack.winter@gmail.com>
To: netdev@vger.kernel.org
Cc: willemdebruijn.kernel@gmail.com,
	daniel.zahka@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	stable@vger.kernel.org,
	Qihang <q.h.hack.winter@gmail.com>
Subject: [PATCH net v3 0/2] packet: use consistent hard_header_len in send paths
Date: Tue, 28 Jul 2026 11:10:53 +0800
Message-ID: <20260728031055.49375-1-q.h.hack.winter@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260726092110.80185-1-q.h.hack.winter@gmail.com>
References: <20260726092110.80185-1-q.h.hack.winter@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

AF_PACKET send paths read dev->hard_header_len at several stages of skb
allocation and construction. Concurrent netdevice reconfiguration can
make those reads inconsistent and cause skb headroom underflow.

Split the regular and TX_RING paths so each patch has one Fixes tag.
The separate SOCK_DGRAM consistency issue between hard_header_len and
header_ops->create remains outside this series.

Changes in v3:
- Split into two patches, one Fixes tag each.
- Add LL_RESERVED_SPACE_EX() for calculations using a saved length.
- Use int consistently for saved header lengths.
- Drop unnecessary READ_ONCE(header_ops).
- Snapshot hard_header_len per-frame in the TX_RING path.
- Reset copylen for each frame.

Link to v2: https://lore.kernel.org/netdev/20260726092110.80185-1-q.h.hack.winter@gmail.com/

Qihang (2):
  packet: use consistent hard_header_len in non-ring send paths
  packet: use consistent hard_header_len in TX_RING send path

 include/linux/netdevice.h |  6 +++--
 net/packet/af_packet.c    | 47 ++++++++++++++++++++++++---------------
 2 files changed, 33 insertions(+), 20 deletions(-)

-- 
2.50.1 (Apple Git-155)

