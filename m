Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B24003B05AD
	for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 05:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792040827; cv=none; b=KMSM4ExD1zvj/nvwfgRJIeNMcAbLWgg3/8+j5Gl+/gXg/68sMK41oz2BdhGZUFKdlTrHSPnwIxhmC4MvL6J1C1XLhVBLkrK9RJ4IDFIN6eIC7qn2JBb1UhDX6u70cDBsvbGpbuysRoreYSZenBcMt98Iq7XZDz36TOpX3alRJrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792040827; c=relaxed/simple;
	bh=BzMooO+MyhAUIkUsoVaVvfY9WVK2CMtiJcv2Qe9/waw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tlH6OvfbG/afVtU7GF7/Sm00ZBUNpD8z+glnlazHSj9/L8u2YK77PY6OP2/8rhVVuNgz1+YGdx8lU4nivHoVXkO/BKJCAmofyeiGwpwVxauJO0zHqk/6NuR5MZ8ok6fl0ye7B9VAMqRLCgrj/QGb+gozmopcWsNBKXGZ84QHOA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qirWBfYF; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qirWBfYF"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-cd3310348d2so3242490a12.1
        for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 22:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792040826; x=1792645626; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=pC28TwDg73+ZidxQ3D66++ykVZgMdXrvvSXsTDZC4do=;
        b=qirWBfYF0OXIvvehXk8ZSOoMxg3cP5IvRPpf8966riScvFV79Onneo8KSQe78QdwLF
         Gv08JaHjsMKgmLE6QCogSC1KbGVNlMv4RGAk5yAx5h0Eiz1x85ZYjdFtYmTwyvgzBqUh
         gsfPwb18HEfHffgJP4EKQ+00rJaGfSKkaGO/YZv134xSVJBR/PgH4PiMkEFoCB5maZdx
         CmrVjMslZ92hpltVnCwifJjRlur3NtFt8dz5tHNO9B72EaA9Edod9Iz1nZIHknI69HYr
         YjfON20KIbUn0/PAlBRS2W+5PalLjW+D2EpXAtc3OHqd1Uz6OisL7iEZqYkhQJ/zROrY
         gpaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792040826; x=1792645626;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pC28TwDg73+ZidxQ3D66++ykVZgMdXrvvSXsTDZC4do=;
        b=u2tK8bRl7scJNpqxlGcMpnjwDHVTcjZkmOsCltxFA9Z+2fUgWz4AyGEfASaYrPzMY2
         4hrcq2ofdk4yr/i03f52BP091ZH4C05eMt4t+9yCkNf8fwDsPPvof1xXwZonBOQLRyVt
         a/s/p7EP8Ihm2wn7W9E7+UTqzcz5TVrHHHJB+rRLXZWUmPrpMqW5b1T9hALtiKb/YgDD
         9+Cot/fxYBLm3BmM42HqZxMCCqycx7oGsG+1perCP1mfm2P3TAZRnfVxcjup9Tl5em7H
         v64FGXAsHo99p3SFtua9Cbdgn7gC0qPC9K/ODnKDwE0Gc5W+2uCOGJpIPjuMpAUMY3GT
         C0dA==
X-Forwarded-Encrypted: i=1; AKwUvBwEeH+5+feol+o3zCJmC/b4/LWci8ms8DqgpLX4w+MnC407F1RRPSaIb1aKVNVpJH78Ucw6Xrg=@vger.kernel.org
X-Gm-Message-State: AFq9FYIK+c5MsEXOsRczM9KgBp0U8f2yr2fRw7fkaCEq7DgXvmf5S1kK
	7MzHmQygj4RcRzj4Po99GMgccHsmFVebF13vNhocyy7xstIoHuBwOTbN
X-Gm-Gg: AYBFou2Axx3fa+Xb6ORAXE2q9hBFK9b/2ydz4Cmp8gqdYWB8KHHz3G+WloNEXVftL/y
	WkI2DvNjjKIZBSPboXarwMwBuIRbZcpc7hgGifmgaZpFoO8Foqok6xxit7YEyK9RGw3jK9+ScI2
	p3FNIALt5XaU/FfrYuJAL/TjGb7J6AEh7LUejL2/jTI8MpfoKS7cYbHk+hxOl+64cJrGl2n2uiy
	ulGABGnlWMzA7wIuFurfxDaPvb14wkqzv/L58k1YD6bWL1diar7CWWzFYjVZYhGfkcRqXEdo8ls
	Vl5Ch38esIBxyqTK+9daLDuTTrnpXkndskiazsmlH1twpu8UA/YLFSq6s+Keygug/6IGwADc2gT
	hyDEu4+QXHM0HboLOh8DLtsr0wkLCs1Qwf/pQqLT0V2x+f8H97Ox7KzjTi3k7bPxxRd7E/eh0g1
	ySHJea+VdyykKkiXwwRzmpUiaAbGLR+toGOE7uCh6cdBJScR0gi+2KfNiuBM7n/56ENRvf1xaVD
	kcc0DrAXbY=
X-Received: by 2002:a17:90b:2887:b0:3ac:a6a5:5757 with SMTP id 98e67ed59e1d1-3aca6a55a5fmr40182a91.11.1792040825951;
        Wed, 14 Oct 2026 22:07:05 -0700 (PDT)
Received: from ancienth-X870E-Nova-WiFi ([125.186.72.2])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ac9449ae48sm2548033a91.13.2026.10.14.22.07.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 22:07:04 -0700 (PDT)
From: Daehyeon Ko <4ncienth@gmail.com>
To: David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Hannes Frederic Sowa <hannes@stressinduktion.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Daehyeon Ko <4ncienth@gmail.com>
Subject: [PATCH net v4 0/4] ipv6: fix address publication races with addrconf_ifdown
Date: Thu, 15 Oct 2026 14:06:47 +0900
Message-ID: <20261015050651.1841557-1-4ncienth@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The first patch removes each non-kept ifaddr from the address hash during
the per-device list cleanup. This prevents addrconf_ifdown() from freeing
a captured object that a late publisher left linked in the hash.

The second patch serializes hash and device-list publication with dead
device teardown. The cleanup patch is now first, so the newly atomic
publisher cannot create a captured-but-still-hashed intermediate state.

The third patch initializes a temporary address's public-ifaddr reference
and both timestamps before publication. No lifetime update can observe a
partially initialized relationship.

The fourth patch prevents stable-privacy DAD recovery from changing a
DEAD replacement address back to PREDAD and queueing work after teardown
has cleared its route.

The original deterministic test used a direct internal caller, kprobes and
atomic rendezvous at existing instruction boundaries. A real RA separately
reached ipv6_add_addr() with can_block=false. No new kernel build or
runtime test was run for v4. Validation used source review, strict
checkpatch and multi-tree apply tests.

Changes in v4:
- Reorder the first two patches so the hash cleanup precedes publication
  serialization; retain all existing patch subjects.
- Describe the freed hash entry as a use-after-free and document the mutual
  backport dependency in patches 1 and 2.
- Keep patch 2 scoped to idev->dead; drop the preliminary READ_ONCE()
  conversions and the unrelated disable_ipv6 recheck.
- State which finding was triggered and which follow-ons came from source
  review, including the observed device-teardown symptom.
- Initialize ifpub, cstamp and tstamp together in patch 3.
- Add patch 4 for the stable-privacy DAD recovery race.

Link: https://lore.kernel.org/r/20261009054042.272944-1-4ncienth@gmail.com
Link: https://lore.kernel.org/r/179161099408.434549.14449036924552933828@kernel.org
Link: https://lore.kernel.org/r/179161099539.434549.2238120015372268173@kernel.org
Link: https://lore.kernel.org/r/179161099665.434549.5858601179492551889@kernel.org
Link: https://lore.kernel.org/r/20261012145306.GB779501@shredder
Link: https://lore.kernel.org/r/20261012151316.GA798355@shredder
Link: https://lore.kernel.org/r/20261012145240.GA779501@shredder
Link: https://lore.kernel.org/r/179152464915.2527009.3889155025831898857@kernel.org

Daehyeon Ko (4):
  ipv6: remove ifaddr from hash during ifdown list cleanup
  ipv6: serialize address publication with device teardown
  ipv6: initialize temporary ifaddr before publication
  ipv6: do not restart DAD for a dead ifaddr

 include/net/addrconf.h |  3 +++
 net/ipv6/addrconf.c    | 46 +++++++++++++++++++++++++++++++++-------------
 2 files changed, 36 insertions(+), 13 deletions(-)


base-commit: 513444cc62e231a11c9b15ea88de0890da9b2b4f
-- 
2.55.0

