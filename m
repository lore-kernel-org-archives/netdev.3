Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C497377AA7
	for <netdev@vger.kernel.org>; Mon, 24 Aug 2026 07:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787555363; cv=none; b=ts9+Mbp9tVw4dYDxc7j5RyvvN1/wn0kWdQw4DQxCKicLuyFGNVDiKMPdgVCUtRnsYhnFKWQDho9qB3KM5bX05b7OLltlTAbvnn2CgfHWNY0n9wRnlY6E94gndVKSANM6C0bWiHlD4jASQLpNAoVapasIfkoG6w9CGsh4E+wyTuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787555363; c=relaxed/simple;
	bh=T3Znx85+wRAnG9rsNvo9Z30hf5HBN/a8hUHQ/NtsWcA=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To; b=Td85+EDWV88rC3lv3SJZzZqbm+70dgl/YLv5DPIXcs+WrTV+tewcuN/jDmDX7xR/4Jv+tmoFlAT8k4ptiIxJY2NhnzWzVePzd/MNw/XQyAjgK+rpLWSFwJ78QKgWMb70TcvP6IjXdSnV+wpM1TeST314hL9DBup6doC5Jdp4ymc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MNFGA+KK; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MNFGA+KK"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-395cf2535acso2582953a91.1
        for <netdev@vger.kernel.org>; Mon, 24 Aug 2026 00:09:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787555361; x=1788160161; darn=vger.kernel.org;
        h=to:from:subject:cc:message-id:date:content-type
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JQN40EZErL2DHTXaUSRxFDwWdzQHo0e1wBH6G70Kxos=;
        b=MNFGA+KKQ/GzWEmOBj6yvmVGQcC3mZcQiL6wx2lHaxRCiAEQ5Y2PFocep+uSvQKfMV
         Wjcd1dIuI+WdlrrtPeRrsFCIOf4HhGqfD1Aygd2C7aMbIKP5GitmTO2RxlW5NnjBpk3q
         Fx6yTekRZp79SokuY5HgsIHlChXKHHynuYYdtS/po47Yt4EtbWWGXAfyfvqzNGECSg+j
         DIHgaGlt8T5eS4vOYIHm/icW1/l4LCyi6KqXxTpxNHJdgDjGOzaU8Yqv/nj2QFTD+u9F
         Y9ILxxzbrlGqZmUHgVGMRPqTUe72k5Wh4XIPYev8BvO9ISxynvsZhKI2oyjPojrQWu81
         mHZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787555361; x=1788160161;
        h=to:from:subject:cc:message-id:date:content-type
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=JQN40EZErL2DHTXaUSRxFDwWdzQHo0e1wBH6G70Kxos=;
        b=SD2FB4IH6RLkiUkw7sQeAdDvnbMHgp+oIniFplz/xJTep+ieP5MfVJWBX4vCbiryr7
         kB/CvhMk8rEaMiEGoUG9HGq2+TY3eScgRIyiK0bAW/Krqt0QHMRcV9+DMGfpco9tr5cg
         4BPEq+4fb+i/K9GG+Tq23hapw/XGwaTN5QYWLFTvHVqf+eFi6QSver0V89bF9QMLik73
         ecr1DNxKbZVtjgo9eRvk9pSCDXldxP8AvGU6bFtrBhnN8O8pvr2kh8VpzNvCJm85W0pR
         Yktm8v5Mn9hOxTnPD3kh8YhgMUH1bl8l8Z4J5pErAEwVokJ+8E9FlIx1TJrHIX42qAjJ
         bJ1w==
X-Forwarded-Encrypted: i=1; AHgh+RobywtVw8AUY33/LBUynC27SGGT15FZrJcbP2WJnYKUpcUBBQFDS9hrrPuRJUJHdmIunYqRQzU=@vger.kernel.org
X-Gm-Message-State: AFuF++lVgkqstL4SMR9KEMRBbMY8kNA3jlmP0kBCKeqwWaQad5alc771
	g4ylxfBslux6E9UkMoVGQsoSEpVcq+hq9kANABz8F7uTnHHfTbcNe6u7
X-Gm-Gg: AR+sD1029vtdIA5Mls4nJk97uZt0sjEjYpBqmm2k+M6XwkwZke5HYLFhY4FiF0M3Fff
	r9ibn349GNOCmZ0UNPH12qX5NIeYiAiKkcsTG94FOaPpBfbgyPzZHRQQbYoY8Ydv6wIGpjTmjPt
	ARomcDq+wr6y4NiriFgm2B7R6rbqjbjCcqbiutQWm+SzTRmp0T3Gw0WlG3OgXp3Pvkea4RMu6Sg
	/hP6s4b929Bp+MZndN2AKg5Vr6HhDfy0PkhOTLKapUZ//xo2jVRV0+4c+GeQrIBH4fk8cWpL4Ud
	c6fPwLSxTyv4hHVG1E18U462CDJ9xUFApN13CCsEzCj0UKBWgFjR/ls7YKDhqTToqHnkCnlv8vh
	VGeWTTgLnMwOn8clR4okze37qmmxYkjTm0LdKzklq3ICG66pFL+i5RmkzVaLkKcNTCbcDC1468Y
	AQdg1jxzPgOE8bNx/8kCcXgfnMi9CDIu9w+y9Q2q/P/olVZwCCKeC8ZznzCNbTqnYaKKbKbsxb1
	jS4MmRoB4PUwojQo/0kCcQ=
X-Received: by 2002:a17:90b:388d:b0:387:d9cc:7dc3 with SMTP id 98e67ed59e1d1-395a074a348mr40512016a91.21.1787555361491;
        Mon, 24 Aug 2026 00:09:21 -0700 (PDT)
Received: from localhost ([2401:4900:8850:f081:3f06:139b:b140:eb29])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3280782f09fsm15279067eec.20.2026.08.24.00.09.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Aug 2026 00:09:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 24 Aug 2026 12:39:06 +0530
Message-Id: <DKWZHHOFA1F3.1EL2DMFNGMP0Y@gmail.com>
Cc: <linux-hyperv@vger.kernel.org>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>
Subject: [PATCH net-next] net: mana: remove unreachable dead code in
 mana_bpf()
From: "Muhammad Falak R Wani" <falakreyaz@gmail.com>
To: "K. Y. Srinivasan" <kys@microsoft.com>, "Haiyang Zhang"
 <haiyangz@microsoft.com>, "Wei Liu" <wei.liu@kernel.org>, "Dexuan Cui"
 <decui@microsoft.com>, "Long Li" <longli@microsoft.com>, "Andrew Lunn"
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>

mana_bpf() declares an uninitialized 'ret' and falls through to a
trailing 'return ret;' after a switch statement whose every case
(XDP_SETUP_PROG and default) already returns unconditionally. This
statement is therefore unreachable dead code left over from an
earlier refactor, and it would return an uninitialized value if it
were ever reached.

Drop the unused variable and the unreachable return.

Signed-off-by: Muhammad Falak R Wani <falakreyaz@gmail.com>
---
 drivers/net/ethernet/microsoft/mana/mana_bpf.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/net/ethernet/microsoft/mana/mana_bpf.c b/drivers/net/e=
thernet/microsoft/mana/mana_bpf.c
index 53308e139cbe9..70bb8c9dc3413 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_bpf.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_bpf.c
@@ -253,7 +253,6 @@ static int mana_xdp_set(struct net_device *ndev, struct=
 bpf_prog *prog,
 int mana_bpf(struct net_device *ndev, struct netdev_bpf *bpf)
 {
 	struct netlink_ext_ack *extack =3D bpf->extack;
-	int ret;
=20
 	switch (bpf->command) {
 	case XDP_SETUP_PROG:
@@ -262,6 +261,4 @@ int mana_bpf(struct net_device *ndev, struct netdev_bpf=
 *bpf)
 	default:
 		return -EOPNOTSUPP;
 	}
-
-	return ret;
 }
--=20
2.55.0

