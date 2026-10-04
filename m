Received: from mail-pj2-f40.google.com (mail-pj2-f40.google.com [74.125.227.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C93403DAACD
	for <netdev@vger.kernel.org>; Sun,  4 Oct 2026 18:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791139016; cv=none; b=NfI2IzO7QSkiV3mPJZH4DxL8J5PRkqbcRc+4PMnRxJr4UFdnd9NZKNaA+sxmxLp/swlzguqWCoYwkAQmvaPmMxk0+xjMTQmKEVwFeEyJZrwoIiD3qVF8ksRxZQ1xKSvoTQFnuewDLGKtSMFFXbGHbUwA+P/dlOJXwUVL+ayfBmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791139016; c=relaxed/simple;
	bh=l7y/BfYr6beDRN7uw+2BvyADlXI2W0Z3e8t75PZ9q3E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ianZyJ5bjvc9KDRV8+WSUpTvJEWobR3m7H5fpFrltxRkPI2wUlEg5p4NsXB2greHIXPNwOm+ccn8JuRbMufrynA2XWgAyXqFgFAlEOYmxm5CMVVuNofrkggwDXQ9viDXCDZbI7JFuQgBYkdaE9zRQqF00NCQ3a6BdxNFH36a1EI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nkf9nZw4; arc=none smtp.client-ip=74.125.227.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nkf9nZw4"
Received: by mail-pj2-f40.google.com with SMTP id 98e67ed59e1d1-3a0eeda3e03so396643a91.1
        for <netdev@vger.kernel.org>; Sun, 04 Oct 2026 11:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791139014; x=1791743814; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ccfGdzBPJdPkxWNhh6lQb+kmcGTxqCss1c2TAlA4PbE=;
        b=Nkf9nZw4CG2O1rEhGW8XkdXYZPOGf2SieSEimA036XFsiALscMNKGvB0afSgJh1dDy
         1ANOu5rC8SZ01seDM9Ej0y5R8ZITWrdwSsU5y1pzLW/Ic8/WKiT3ZP6AnFV+sRyG3Tze
         ITiucvuUOJZQDFdFwWmo0tMYVvJFl3+ErO+++Wy7pa3O2/uSurEOdh5m8dhSHwAJLmpA
         1uHVEvG6ytzrlA//vOv7oBKiMCv89ZrclokrrwCEueZY00Dkoz8rJtAM6DuA+XZzwyiB
         T8eGF37J7GyK3FGjrU2rX/SzmPTR0o+3JH6pecWiIkDCu2Bobls1zvH3ZlWWu+IAJ40q
         /8IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791139014; x=1791743814;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ccfGdzBPJdPkxWNhh6lQb+kmcGTxqCss1c2TAlA4PbE=;
        b=fsO3s5mtuon8DM5FAconPTUNT9r4ajzZCZuNy1zMV3hgYCJBHCcXa/e83ZZzcGJe58
         OiVx9yW8qahy6KgmsOOBtJ5Ypmq+FED7gn2t7N9dh7y+U5JvKYVm1Q0tKRSl2QwOMiEs
         HVENQLP2F5SFJWdM4oBz1yW33kc/ACcQ9XCg6cqF1PjKTh8jrd2Yw69+3OnG7jSYdDqF
         FKLQYEbkxSO8hIcRrPa8HNkPGgMoygAWYMweayDwVct/2UO6V4frPMZujle3NhHGZsXb
         twbvK5Co4o2ja39l1F/iJD2nNQ/28T5eV7kAPe0Sre8H6BiTaPSF0grqWUJrO6OMeaiD
         F2sw==
X-Forwarded-Encrypted: i=1; AKwUvBx5rQN6NpyaGGOTq/0YaWqkdlaPX6L50NwJRZmqHkPz6RSc/xPxWIJ3ZKaJYbsNpFMzjReVYd4=@vger.kernel.org
X-Gm-Message-State: AFq9FYLyMMGwIpic2SIZUyrPTNZBy8xE+Cp0O1ZChbiuOrtJbLvYYXl5
	z1BCANisvfRUeNPTLSiq7vqQy5MI9iDVZeZGFvZlTJRb9CO+OHSLrKvL
X-Gm-Gg: AYBFou0PD/1BHsy8Ya4vucEoJxvVYBetjDDha2lQEwWI8pLd9rIPR/dgbjyNkkGQZSG
	yx8RJjZpAzCX3uvGiXpA8VrN2oKtdt0Ou0H7PId5XnldQ+NPMppew6GzRYp3zc7waySgSPwZBFJ
	QEJtCOBx/J+ZW9bBK0b6pvqyjpaoOlM2WNJ3W3lQt43+vNVps2jypopBFCEbMsHbKQGAzArxbag
	Elnaj6wSJ/EIxagwqm/AB7MleHSYYlQBH1TjTmBUCb8xU3O9gkNasBtcb49IG00qiNVazAQc2fB
	9J/au1eROBz7RrR8NdIAWhiJVSBZd1UpchbQy71wlZxmhlo0rVwhpfBBS4EXaIMRYJVyG1g3vdO
	GFyyhLCTrX5UkX6jYJovKqsUjNvTpa+MmwzDFQomuo6499sCuh9Tn+x3RUE+63ZHY3XOfMqugrA
	xN1H00JUvrFUin0J3ukEB24Di+Z2hoRbJ4EYwwGYk7MIzaBXTuMfXs/E+rEkK8WdWNpeMJnwiXz
	uM2tMPlq/c=
X-Received: by 2002:a17:90b:3ec2:b0:39e:6a81:c923 with SMTP id 98e67ed59e1d1-3a6ce6af1abmr3427622a91.22.1791139014138;
        Sun, 04 Oct 2026 11:36:54 -0700 (PDT)
Received: from ancienth-X870E-Nova-WiFi ([125.186.72.2])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a78e4262cfsm7522854a91.6.2026.10.04.11.36.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2026 11:36:52 -0700 (PDT)
From: Daehyeon Ko <4ncienth@gmail.com>
To: David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Daehyeon Ko <4ncienth@gmail.com>
Subject: [PATCH net v2 0/2] ipv6: fix address publication races with addrconf_ifdown
Date: Mon,  5 Oct 2026 03:36:37 +0900
Message-ID: <20261004183639.3773498-1-4ncienth@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The first patch serializes address publication with device teardown by
taking idev->lock before the address hash lock, as suggested by Ido. It
rechecks both dead and disable_ipv6 before publishing.

The second patch fixes the related NETDEV_DOWN case, where the idev is
not marked dead. An address added after the initial hash scan can still
be captured by the per-device list snapshot. Remove it from the hash
before marking it dead, notifying listeners and dropping the list
reference.

The deterministic v1 test did not add delays to addrconf.c. A diagnostic
module used kprobes and atomic rendezvous at existing instruction
boundaries to force the interleaving. Separate, unmodified RA/MTU stress
did not win the race; the ambiguous sentence was removed from patch 1.

Changes in v2:
- Reverse the nested lock order, protect the dead indication with
  idev->lock, and recheck dead and disable_ipv6 before publication.
- Add a second patch for the NETDEV_DOWN WARN identified by Ido.
- Change patch 1's Fixes tag to 8814c4b53381.
- Clarify how the forced interleaving was produced.

Link: https://lore.kernel.org/r/20261001052150.136559-1-4ncienth@gmail.com

Daehyeon Ko (2):
  ipv6: serialize address publication with device teardown
  ipv6: remove ifaddr from hash during ifdown list cleanup

 net/ipv6/addrconf.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)


base-commit: 6dc989ea46b96ce170840174b4a38c4a387fb005
-- 
2.55.0
