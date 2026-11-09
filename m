Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794183019;
	b=HYlf/9pqNXOFxJTFIC8WxIhrIPwY/8x07ZHKianULthJA70k4+Yxvcq8IWTx36KeA80j
	 dy5jICFLJXWrqcKfL/r2jp2ew0TLs0ME25pXH9ptfr7zMLkkMt+/3+JM6Wud3G4hN4jqn
	 zt7hfqvMEQIC1XoT5vwxRFpHc/iSaIvmLT82H1FAr184d8zdWagUxW4T89At2pTdMSVD7
	 OMFSHdI9F3FK/TFvxiKsuYkYxDPLCg2WuFfKWQSvh94tL/OQB0NN+5jG/s6F3RcW8m7Us
	 Ink8NY5L/YY6u1bOwlqbWECJtoK7v4yJi5CuyVsp5+k8oBJKmbo17YEavTCwqmYfI9w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794183019;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Subject:Date:
	 Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=PyTqqEn2wX12kZAgZgEAmVuIcoRQ/KUps+43IBZdEzM=;
	b=qHa5sE2wVhTD8gpWMft+FfDB9LcUbtLlZDoSrudBY/WFKWEyXmxNa+IWq36GNL6k/qhO
	 wn11IDOWAbMkrxfYSuAc242dqq76CHgm5/iHAStJlRI+YRPXNEQIX6E+xBnaE/3Xill4x
	 nPdvZrcLpqeYtP2Ds05WI51Aje3Bv19JNs5SiIIFaIlN7RHOemL8pdAh9Qbt889P0MuAg
	 4jfovjaFT6nV2xlR6vYh7ENolz/A1DOrh1MDzwlrWHnpelTzsUxjB78AKI2CDTnPUZ+XV
	 hkJwMeCzHuSxz3abickWdqUhsKl3E1ZhVv9hLFJ+yudxQLfM0chOKd+nRRgQLhYY+VQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iStRZirw;
	arc=none smtp.remote-ip=74.125.82.178
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED69B606A31C
	for <netdev@vger.kernel.org>; Mon,  9 Nov 2026 00:10:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ED69B606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iStRZirw
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-36fc0a3fe93so686204eec.0
        for <netdev@vger.kernel.org>; Sun, 08 Nov 2026 16:10:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794183018; x=1794787818; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=PyTqqEn2wX12kZAgZgEAmVuIcoRQ/KUps+43IBZdEzM=;
        b=iStRZirwtXbMsEeyt8mJmEQC1BN0pUC1ce01sEbH7zzinI+36nBDHz9KTroZuGzvdR
         YsRw4/kMVbClxq9SZoKJLlFdQhGH9mCC/rBpE09xnUzArHxjVS2GyZ6rW9tchU0FTnZ7
         2NThoMEtO5TGMZ2puYuWhsuK0W/etbev5eI3G+q5Iv4PtvHrqW8wx1r1Ji8tkTF5/OAd
         J3/eRKbWmm0CSckHG7UNA/HZH5Mrr1v+N8vv8QKoG9gukPJLMGT48xC/5IQPIBENl/oE
         qWhSvcBoW1+zCnhpJfeJ02iY3IhItA7CyNLtG9+/kZKY3um5fdqw2/oor56tKGuEMC1A
         QA2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794183018; x=1794787818;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=PyTqqEn2wX12kZAgZgEAmVuIcoRQ/KUps+43IBZdEzM=;
        b=hxJaVuCiGXpJA0mgHO3/7mNsibNfwkyStQPtdYTqcX9wzRjI99xZcJcsHW7ebc5JxV
         dXVGuannSUL/B/0RancMaaV54hvd7fgSwBYu35iU4cKv51pUbEVWbDuPyuL4Vtjl8IuX
         fSsbRn7+aIReKz4RCKA1We7m/sCuTcyI9Ww6+AKu8d/l3BAIgCWhRzKA69b3OPswBHVP
         RGrImfKfX6z4GU6osqh6wVLHjkbqk/gZEaPBGD64+tJxHRha2e1XycHp/F0Ai8mHrAw+
         gu2t2nqZpsXGvCukO/MWj3fp+1iJWDRVDrIqhJyWhBaslUgthrwMN9yrRcOQwUTADG/x
         YnfA==
X-Gm-Message-State: APuU4Z+em3UH4Xz28SCyYE60jTnlIWMSb4UDaPk4u0Lc6T4Ng3tqdxWG
	9LsRPbArtn+NcylB11N7ksln9oGHgLe9ItqCGJ5eOAXeGTrjeQCyv4Ea
X-Gm-Gg: AYBFou3SqYEIlF0uzdoIq37mgXsTnkXjAW5Hg13b184awuibv9GSNSdj3VIWCHwXrxl
	+PNwetyjc2l6zBqdkaswaAwff786sLAekgAJLZXeRfxzsnyJkH3INW6mNZtlUHtAf2W6cBA18w6
	dVUj8qmnD99+kAplHowfndvpfJwTJ7ULgSRe3HxG+RwTS/2e0F3gjSlBiF1GGj276TVZcyvv+YP
	Ueun09xwQm/NF3VApFN5cMkw4phgfgfJRQUlhr6x1vymG2Edw9vcYJz8mVP7yyRKAjMkminHN7K
	KFzpGmy3IAwgY7i3i73CX6/dHzBHAHn0iZ6xKEVQq7b9eCW7fePhp5nv+aPCe5gG9mETnAMOJ5f
	ck/n995DRmkELQiW+/FiVJPaIGcmym6HWs/u5jFtHl75kXhjxnMlwR0uBBq6E8xyl9mzwH8oTmL
	o+JJGcxL8OGrbcDS2paa697PUJbVqLfUNNMZl5j037Dfh/Av6FX259xw2DLhY1vUjNIzWalc4Ft
	3FVJJyTU7QpAbbZ1JzzEbA3kPWtmMx+j/1fA5MQLo4x/ji2l16BvA+BV8+tJeTh9I/WPPd8Ktio
	25viPNzn9LT5dyXyhVeuC/DzJgOUgw==
X-Received: by 2002:a05:693c:8808:20b0:36c:9e26:88b6 with SMTP id 5a478bee46e88-37256613f82mr4409295eec.9.1794183017970;
        Sun, 08 Nov 2026 16:10:17 -0800 (PST)
Received: from dev.local ([163.43.243.221])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37265ff3415sm7790873eec.18.2026.11.08.16.10.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 16:10:17 -0800 (PST)
From: Yuya Kusakabe <yuya.kusakabe@gmail.com>
Subject: [PATCH net-next v5 0/2] seg6: skip route refcounts in seg6local
 lookups
Date: Mon, 09 Nov 2026 09:10:13 +0900
Message-Id: <20261109-seg6-lookup-noref-v5-0-96dc6a652c7e@gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGUP8WoC/23QSw7CIBAG4KsY1mKGZ4sr72FcYBkrasGU2mhM7
 y6tLhrT5cDM98O8ScLWYyLb1Zu02PvkY8iFWq9IdbahRupdrgkHrhmApAlrTW8xXh93GmKLJ4r
 AtDTqqAEdyXP3fOifk7knATsa8NmRw/cmPY4XrLqRHHvPPnWxfU3xPZsmfklqIalnFCgYjqUsC
 okl7OrG+tumis3k93wmMFgSeBYUq8A4Z0pmin9BzIXFN4gsaKeY1WB14cS/IGcCF0uCHH9hHdh
 SmLy001wYhuEDmuSQMJQBAAA=
X-Change-ID: 20261004-seg6-lookup-noref-e016495b60ed
To: Andrea Mayer <andrea.mayer@uniroma2.it>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Gabriel Goller <g.goller@proxmox.com>, 
 Yuya Kusakabe <yuya.kusakabe@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2126;
 i=yuya.kusakabe@gmail.com; h=from:subject:message-id;
 bh=r8iXkM8RhORDogoTl4VkuWoeTGCS5cWvT3FEyheqGgs=;
 b=owEBbQKS/ZANAwAIASrX0XUqXRtNAcsmYgBq8Q9myrVipLCknrBU5SJV2TPFs2kF3X25o2+nJ
 FNZfnl4Hm2JAjMEAAEIAB0WIQTaB7usAfxNKMeqa6Yq19F1Kl0bTQUCavEPZgAKCRAq19F1Kl0b
 TQ9+D/wL0aPKqaUINLk0fal0rXnwjtAGTNMsON9DuE36VQwgMrZVnfBmofWg9S2GOFObJ/RWaSC
 mP31iIOC1ATKv1I0das4lSzckHsYuFSygdX2E+CW/96vLNeMwF0EcXH24wHsXJwnZljTGJ2NKCF
 8ruipLI4p9yE7muqR2LZYA8pEXAfoBz4qNXdHCneD1iZwDY8Its8rIYv93t0DhPwI1s32G8dgfY
 ezZup19e90qh9GU6GikNfYzJQBSJbFzWGB2yIlnfH/aFq2F1eQFw/dPyjD28AlOyeNIlS0C1Mur
 jYfWd2csIGwbPMATXiwGThhQTvVsC4zOk3hCZCKKIdIBTjt8D0zPP1igdI04z81TFAIiWNbcYEv
 irHhb+x+eyvlPzCOP5DixitwKCQ2qTGcS4EfQzWe/C1BGW4NgrWBkyMUhp0YJ+eIFqV7gtHjRK4
 ATGMpP2LyQC2GLIx/GyMFRdY612r5641HMHPyZpnjCCvR2L/D3TZGHKgXT60h4wO4tZWMrXz7Nf
 iFkkNGDCy32r6dIKgDjFz/PEWAhjJ8yS5zqx3VqBTVU8pzOlUqqOWkoWhafZcvNTmGcCaN/0Rcc
 EiYKfAZzZfmRVwIBUNoRSzmTUsyZNYewX4lKUl1thlUQ7kMNDG7KN5/Nhr7HLVUG6WSzDu4ZXKz
 PZPk1VdmvGwklvw==
X-Developer-Key: i=yuya.kusakabe@gmail.com; a=openpgp;
 fpr=DA07BBAC01FC4D28C7AA6BA62AD7D1752A5D1B4D

seg6local looks up the nexthop of its IPv6 and IPv4 behaviors from the
RCU read-side section of the receive path, yet takes and drops a route
reference for every packet.  Skip the reference, as ip6_route_input()
and ip_rcv_finish() do.

An LLM coding assistant helped write and test this series.

---
Changes in v5:
- Rebase onto net-next after the merge window; no other changes.
- Link to v4: https://patch.msgid.link/20261023-seg6-lookup-noref-v4-0-0ad0a83960ef@gmail.com

Changes in v4:
- Take no reference on ip6_blk_hole_entry after a noref lookup,
  including for a missing table.  An End whose next segment is a local
  address took one for every packet (Andrea Mayer).
- Comment that the noref helpers need RCU held until dst_input()
  (Andrea Mayer, Sashiko).
- Link to v3: https://patch.msgid.link/20261015-seg6-lookup-noref-v3-0-6d51a60a67d3@gmail.com

Changes in v3:
- Keep the refcounted lookup in seg6_lookup_nexthop() and give
  seg6_lookup_any_nexthop() a noref argument instead, so the BPF LWT
  helpers see no change while a route is released (Andrea Mayer,
  Gabriel Goller, Sashiko).
- Mention NFQUEUE reinjection and the release race in the commit
  messages (Andrea Mayer).
- Link to v2: https://patch.msgid.link/20261010-seg6-lookup-noref-v2-0-51c09dd98197@gmail.com

Changes in v2:
- Split the lookup into a noref primitive for the seg6local input
  actions and a refcounted seg6_lookup_nexthop() wrapper, which the BPF
  LWT helpers also call (Andrea Mayer, Sashiko).
- Rebase onto net-next and re-measure.
- Link to v1: https://patch.msgid.link/20261005-seg6-lookup-noref-v1-0-092e84774e80@gmail.com

---
Yuya Kusakabe (2):
      seg6: skip the route refcount in seg6local IPv6 lookups
      seg6: skip the route refcount in seg6local IPv4 lookups

 net/ipv6/seg6_local.c | 59 +++++++++++++++++++++++++++++++++++----------------
 1 file changed, 41 insertions(+), 18 deletions(-)
---
base-commit: 7b6ab4dbc156e2f96419715130b3d5738a306c93
change-id: 20261004-seg6-lookup-noref-e016495b60ed

Best regards,
--  
Yuya Kusakabe <yuya.kusakabe@gmail.com>

