Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C70AC281530
	for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 01:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784769923; cv=none; b=Vde0S0kEaP+Nlt4dtmoW+HhqHsMVITWzhxl4bhVEG6NeZmaicUaXPQlJkg06YmdB4A+gpgfQ32P3Afppu/O9Kcq3LJHWnCBVw+dbXFgRbjvyRj3lCYkbmD9FJei0MF/Ws1/tRzCJhIjdG9jJgIbMoSzsmZ6E35Qa4PQBgO3MwZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784769923; c=relaxed/simple;
	bh=g/7UEAJB8laiG7dwgA8tJy3KfUNOyJKN0xte0Ix9u2Y=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=BH/KjP3tbXiIka3JJFP6TKOok0gkeRBzVBT7pusIoMRTqKWhUE86iLj8QvoIJQEgDgqgZ822tZCvoylJVwY674aOvcRUlrZe8lfh9N5G8sTeCPyIJwQws4t3ik1GUSLm48UXQV1vgqdpOTy9UAEeFqGBcqVCpvVPxujSDqbnRYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WMnkqO9s; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WMnkqO9s"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-38511175ad3so64988a91.2
        for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 18:25:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784769922; x=1785374722; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=UA93U+oxKVKrotx6QwidBM5E5Gw/29jKAH29UWINdiA=;
        b=WMnkqO9sSjyUoytvjKdBOXdlUbhRoNPFtLvgUScTGs32GibRLMnCU+EMGlVRSXWuFp
         rAgFybxW6m6tP3JGSlyYTpONSser0cGPYvyym9WIlNVIQbQX2Zg7PHqBG6SRNQTHyVq8
         AaWcMGF887pKmj7Rp5aghSnjtBxgAYWplBVjml4NUbWK7NTQYociohsIzoRikJ7RNquu
         N82E/xyNFibj4/4F1eFq+w1LgdzIOhnkFQZWlV+0n/RUy+pQf4q0PEy7AGSSG5EL+25e
         uIkOjjzHq6lie2AIlzeyx2Pk7KabdV/uoddPgZ7eNqvqDH2u3j0UKhqlroJOTfnZGJW/
         regg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784769922; x=1785374722;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=UA93U+oxKVKrotx6QwidBM5E5Gw/29jKAH29UWINdiA=;
        b=rFEdwjoBrtA0yvd2g2vmus5q5NW9yubFoDoT08PkNVWFs/QUkoSlEAplo4BosD1tXl
         HeJWCNB+AKQhi3wi3pZWmpSjgXARYodt6qTmvdgWBxnq/Ni7Hv0pEPtHABc7g079W0DM
         9eYJ40dpctfn/Z3ZRSooVCapBDMKrbYbp44xxOXUzvDfhOavpotK7/O+I3AiyN9ywvOZ
         +WSo1gHo1/XoIRoK9P0RJCIPiSO31CUTO9lssyyRpGiUkGwFGl3GJVmOLDgXclxVAiwI
         UfUAEZ41Aemgve4cNzUCoo/61Ils8Odll6w0Zv2dBU82xIuhBMTVhINtWUARoSdELnww
         Jf9g==
X-Gm-Message-State: AOJu0YyGeXsnTrbSqoo336irl7de0bXB5m6MuYKNrosgzw5bLM3XgNEX
	lNd2FRKCh5UDr4QUzpDdFXAkORR3Y7Ww+nWQoKWaZ0TRoYkW1Ffp32gc
X-Gm-Gg: AR+sD136g+q3SrguBpOxuMe4zQPkq7B2dssdbAgPxjpSzmdtzErJBECJswl3rsBeJZo
	YdCBAUOc01eGnsmWYxQMROMsTgeh+AZOOIiBG/UzlZsBhz019fdDFy9GpTd8KadUbgPiw1naCn3
	zQbGnYNyQ6wPXbJiykRiXIk9OcuJm+ubs4qON0s3wqytNudVfXOaOd7LXmDEXLN+J8bDDwqpHq/
	bHwBhTcesi1W5OAoihkBcZJ0iITmwTEM7OR7NaL8dLRa/Ply10rElgVxDPrwVzI/UFiwYdUnGQN
	nGwg+SJSfNd1ZVR0lZH9DPdoNVa3rtccITKtHWOq9BkoKgAxqRnFyKDOyebwErtpgygi2Dg+DqV
	v80EqHUN4ejX1a79xm4l+UDkecnKOuhOgu3M8HsdRYpmjKgA+tqRgqITUG4A/5D4ZyrZSnD8vXz
	NPS1fB8BCwvy+6wYQgEu1ng+dRhA==
X-Received: by 2002:a17:90b:3905:b0:38e:2524:724f with SMTP id 98e67ed59e1d1-38ec64dd02bmr1121242a91.12.1784769922176;
        Wed, 22 Jul 2026 18:25:22 -0700 (PDT)
Received: from CPC-mjac-HKWGEZ.localdomain ([70.37.26.35])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38ecaac56a7sm30896a91.11.2026.07.22.18.25.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 18:25:21 -0700 (PDT)
From: Jack Ma <jack4it@gmail.com>
Subject: [PATCH iproute2-next v2 0/2] ip nexthop: support fdb destination
 port
Date: Thu, 23 Jul 2026 01:25:06 +0000
Message-Id: <20260723-b4-vxlan-fdb-port-iproute2-v2-0-9012ac01b49e@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHJtYWoC/42OQQ6CMBREr0L+2m9oLaCuvIdh0cIHaqAlbWkwh
 LsLmLh2OZl5M7OAJ6fJwz1ZwFHUXluzCX5KoOqkaQl1vWngKc/TgnNUAuPcS4NNrXC0LqAenZ0
 CcWQXlmfXolBS5LAVjI4aPR/lT/ilDM0Byq/tJ/WiKuwDO9BpH6x7H2ciO7B/diNDhiJjt5tiR
 Fykj3aQuj9XdoByXdcPgWpHEuUAAAA=
X-Change-ID: 20260722-b4-vxlan-fdb-port-iproute2-13165877ba46
To: netdev@vger.kernel.org
Cc: David Ahern <dsahern@kernel.org>, 
 Stephen Hemminger <stephen@networkplumber.org>, 
 Jakub Kicinski <kuba@kernel.org>, Jack Ma <jack4it@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784769921; l=1414;
 i=jack4it@gmail.com; s=20260712; h=from:subject:message-id;
 bh=g/7UEAJB8laiG7dwgA8tJy3KfUNOyJKN0xte0Ix9u2Y=;
 b=fcMuq9PnaOe/9zulsgbmrIUpZF1yWgeje4ib0WpwDmwf+seHkX0fjn0se5X/MfcWTuVeEfxG4
 uTYL/OWmKy8CP5HB/bZjHpYfV0bLTN3TveXJl3vV7OzTVUYPPTkGwIV
X-Developer-Key: i=jack4it@gmail.com; a=ed25519;
 pk=x8xh2Md9yNDil0xBOA9WA/oqC3O4Eg4rdlIul4YUktU=

Kernel side (net-next), which adds NHA_DST_PORT and is the reason for
this change:

  net: nexthop: per-nexthop UDP dst port for fdb (VXLAN) nexthops
  https://lore.kernel.org/netdev/20260723-b4-vxlan-fdb-port-v4-0-46e3a2dd88a3@gmail.com/

Signed-off-by: Jack Ma <jack4it@gmail.com>
---
Changes in v2:
- Rename NHA_FDB_PORT to NHA_DST_PORT and the "port" keyword to "dst_port",
  tracking the kernel rename (generic name, still fdb-only validated).
- Split the uapi header sync into its own patch (Ido Schimmel).
- Add the ip-nexthop(8) man page entry for dst_port (Ido Schimmel).
- Drop "fdb" from the "dst_port" usage; the kernel enforces the pairing
  (Ido Schimmel).
- Print the dumped port as "dst_port %u " and add the missing trailing
  space to "fdb" (Ido Schimmel).
- Link to v1: https://lore.kernel.org/netdev/20260722-b4-vxlan-fdb-port-iproute2-v1-1-45199b1ee240@gmail.com/

---
Jack Ma (2):
      uapi: add NHA_DST_PORT
      ip nexthop: support fdb destination port

 include/uapi/linux/nexthop.h |  3 +++
 ip/ipnexthop.c               | 18 ++++++++++++++++--
 ip/nh_common.h               |  1 +
 man/man8/ip-nexthop.8        | 15 ++++++++++++++-
 4 files changed, 34 insertions(+), 3 deletions(-)
---
base-commit: 35a237091c24858cac6c6679175bb6a628cbe400
change-id: 20260722-b4-vxlan-fdb-port-iproute2-13165877ba46

Best regards,
--  
Jack Ma <jack4it@gmail.com>

