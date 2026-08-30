Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21C8E3921FB
	for <netdev@vger.kernel.org>; Sun, 30 Aug 2026 07:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788076688; cv=none; b=LwA1g8hSmw6x6JkdKtiQAAwa6jHdqLcNrZ1CxfT7HDfUeCRRC3cJjoIhRjAJcsN+TLNQpn+dlTyq6nBYXYMC+FgDCH4iqvNQDVekv4nIzetirQlNzlrwUzzOvsOp4fNIomvXeET7azf9ircxkSKyLoxGuccON4uMMdbUX+7bqr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788076688; c=relaxed/simple;
	bh=3p6Fhd4iWjiZrQZUaGhDeRN6fLt4LAAuJHSnJOELKMk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bI47cZgIKgJcvDHWogG34Y2lERIlU/9uQG4gKho7EZJkQkZ6LpJKG++wibYPU+AiCVbB2luogENGI0c8GTybUtGbqD0W88ES/WCgfl9GhPh0jAZRSufWs13l5VTVx4Dot5uxz6ls88FmPPKwHqmgODlDRscfWlrINtN5cQ4Jv4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gf1+F9kz; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gf1+F9kz"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-49556f97a9dso15085915e9.1
        for <netdev@vger.kernel.org>; Sun, 30 Aug 2026 00:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788076670; x=1788681470; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=k5ZBAdrL5zAROsitwyWfoRyQ13QRzPrvVonWTF5O0i8=;
        b=Gf1+F9kzGrzfH+l7D1Xoc9U1N4Hxii/brUC0wiqNJ+GfpQyAXzWficOrcdWdJtXlXK
         v40US4xjkybdMoOuFBL/3wk0C5w/5oSEbX2x0CbLOviSp3oRl3YEF+BJ7p0oYoYNCOHe
         ascTg7f9oVT+rtSd2/qkwtBLopgnZjPRwzU4rkIkdjeh1GnF98UjVOPDmkViUUlkAMNQ
         rt/goEdd79Zc8Us2DdswKPiK2rEqLxf3YIhsriDeOiQh9Om9MjVdCplh2Oq/S0O7eR8E
         uYJzl9a8rl9Nd5mwwzICniTmTEdZ3R18iGiSgBIExos9qq1XftR9nnPFyBXFPVlnepEt
         1T6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788076670; x=1788681470;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=k5ZBAdrL5zAROsitwyWfoRyQ13QRzPrvVonWTF5O0i8=;
        b=hsTw3sss7lLfh0eYB8JN+M2dRrJ8ZKlYpTQ0a5lbYrb6sKkivekk0FRkDw85YiVJRp
         5WHUKmp9QVdto11ZSHmkwOztDGQKzr6Lu+QMCISjVBBqVBJrMHV34nx+PYriNoXcRbAW
         aHZFRf0nnpDNkEE6js4HazIrmJl3RK1zXw/w8HGVyY8n4Dp3NRZhcRDLwgvAObW861X2
         lGyAUL4Nhd3td+BnSE1luJChE3jj3Jnxo113q05OQWMb3CjtjFprjSmsuUX8Vg8d2At5
         IHjvtSS7tUuygvTfP30o9uMcp4EgSC5oN+JTYvNSR9I75r4bQ/jbUQZX//M/CmkCKynU
         HXgA==
X-Forwarded-Encrypted: i=1; AHgh+Rrb6KZfE4TLbFXO468qq7JlmyS338Nk1slVULpcJ1U7BDJTGwclyMuneLG34fHzIjZ7p3Pmrps=@vger.kernel.org
X-Gm-Message-State: AFuF++kA4Hd8od9479nR4em4wzFtSvhGZruyzSWjuO1NOwg9B5On7Yyk
	7rNOBtv9iF7J9342+ALS7V2pvyHqJROrNFvp+vR4wctrzRkxvfaqBCI=
X-Gm-Gg: AR+sD12Ztczkr0iFQ8csBd344cYDx03YpmCPD4FUzu31OPKqF8iBFDajnhHXp1hbE+F
	Y6My/ESgvgQkFjL+cWe6WgtlDGBDhaowBRl+ABbRIvfgOy3MAxa0N7IohRnerrXre4oREn/dRpr
	E0Oc7N6/pEKooBQfxQUy5DiQAbo1fE2Df2HqscJY6UI4tIL0BtC+//sdp0JCvN1UTgRar5QUi8T
	Ud5iAIm+O9WklmkFp1NUHfcxIGFpwYieTXYo/HWlPII2mwQdSNtwly/7t1rGITugR/JuxyzYiGD
	pFICxDEZ7HN2XTUt2nK1GMWcC6TLLVL+8JTWSl7hseLFkGCAYdDWpIr1wTTJmEqcCNlNxmo4oK0
	rfkgsXM6GZLwQqsbz0o9GNN+n8RlT0s2+CqInuczhdriVcZgtxEgx73DJcLuRjuw+DMexqMu3cA
	4TMf3aJKnFmO9RtYmLfkyVicTYMu3TAyPIWgHHTw7ONH1hPkP/CNQ=
X-Received: by 2002:a05:600c:8b35:b0:493:c634:952 with SMTP id 5b1f17b1804b1-49b91c3c91bmr265871445e9.7.1788076670012;
        Sun, 30 Aug 2026 00:57:50 -0700 (PDT)
Received: from fedora ([46.8.219.5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cd53a4678sm14757875e9.13.2026.08.30.00.57.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Aug 2026 00:57:49 -0700 (PDT)
From: Vitaliy Sochnev <sochnev.v.74@gmail.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
	netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Vitaliy Sochnev <sochnev.v.74@gmail.com>
Subject: [PATCH 0/4] net: airoha: fix silent RX packet loss on ring 4
Date: Sun, 30 Aug 2026 10:57:13 +0100
Message-ID: <20260830095717.37218-1-sochnev.v.74@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series fixes silent RX packet loss on the airoha_eth driver that
shows up as PPPoE/DHCP negotiation randomly failing to complete
(reported and reproduced on Nokia XG-040G-MF, AN7583). Two independent
causes were found on the same ring - ring 4, the shared "force to CPU"
ring that several unrelated control protocols get routed onto - so
they're posted together for context even though patch 1 targets net
and patches 2-4 target net-next:

  1/4 (net):      RX_NO_CPU_DSCP interrupt was unmasked but never
                   handled, so a ring drained to zero descriptors
                   never got NAPI rescheduled to refill it. Plain bug
                   fix, no new behavior beyond "stuck ring recovers".

  2/4 (net-next): a second, independent cause: hardware can complete
                   a descriptor past the software-posted boundary
                   before it's been reposted, wedging the strictly
                   sequential consumer forever even though real frames
                   are sitting further along in the ring. Detected via
                   comparing hw's own RX_DMA_IDX against the sw
                   consumer across polls, recovered via a deferred
                   ring resync. Marked net-next rather than net
                   because I can't currently offer a fresh
                   reproduction to back it up - see the patch itself
                   for what evidence it does rest on.

  3/4 (net-next): new ethtool -S counter for observing when 2/4's
                   recovery fires. New ABI, split out from the fix
                   itself, no correctness impact either way.

  4/4 (net-next): grow ring 4 from 16 to 128 descriptors, since the
                   race in 2/4 is correlated with this specific ring's
                   idle-to-first-frame burst pattern. On its own this
                   doesn't fix anything - it exists to make the race
                   in 2/4 harder to hit - so it only makes sense
                   alongside 2/4, hence net-next timing here too.

Some background on how these were found and tested, and answers to a
couple of questions I expect to come up, since they already did during
downstream review:

- All four were developed, build- and stress-tested against a 6.18
  base as part of an OpenWrt PR (openwrt/openwrt#24872) before being
  rebased here against current net/net-next. 1/4 and 4/4 have real
  hardware evidence: 1/4 fixes a reproduced-on-hardware bug tracked at
  the issue linked in its commit; 4/4's 128-descriptor ring survived
  500+ forced PPPoE/DHCP reconnect cycles (~20h+) on real hardware with
  zero drops, both with and without 2/4 present.

- 2/4's race itself did not reproduce during ~57 combined hours of
  fresh stress-testing this round (with and without the fix present,
  same test methodology as above) - its rx_stall_recover counter (3/4)
  never incremented once. The case for 2/4 rests on earlier, less
  controlled field/downstream testing that did point at this exact
  race, not on a fresh trigger from this round. I'm not confident
  enough in that to call it a `net` fix, hence net-next.

- 2/4 and 1/4 each carry an open question in their commit messages
  (an MMIO-read cost on the RX hot path for 2/4, an interrupt-storm
  question for 1/4) that came up during the downstream review -
  answered inline there rather than left for a first pass here.

Vitaliy Sochnev (4):
  net: airoha: handle RX_NO_CPU_DSCP interrupt, not just RX_DONE
  net: airoha: recover RX ring after hw completion race
  net: airoha: add rx_stall_recover ethtool counter
  net: airoha: grow RX ring 4 to 128 descriptors

 drivers/net/ethernet/airoha/airoha_eth.c | 207 ++++++++++++++++++++++-
 drivers/net/ethernet/airoha/airoha_eth.h |  22 +++
 2 files changed, 223 insertions(+), 6 deletions(-)

-- 
2.55.0

