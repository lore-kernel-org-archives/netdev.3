Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27E0341F5C4
	for <netdev@vger.kernel.org>; Wed, 19 Aug 2026 15:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787152923; cv=none; b=CYdhMbBxh4WHv6bPZbp9XYu+Vx2UjCjuJ+1nuYMMMx12wSFS/TBFdo61k82DbFgOguaEMjLND0aJ1WmeIDmDEgC9fBHLXnOoIlQLR86JV+dt4GimHsXKnPx1r/R+6rFA30uB3LhTk2SrgLg8Xteu7vo6Tdo+aKTgxHNT4BLNlUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787152923; c=relaxed/simple;
	bh=h22Th/kQPmBGk1xVBncsKfbdun+vDIBGuBflIQqLMw8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=A1yWDYzUDtfJ0Y6zf9wsfd9c373Hu+ig5Kgx4Nnxeo//nK9v+qBA5q0Jq80hwM/sX4cv6Aqde17VKG6D8IdRYf3nHL/wSAZ33rDcuTrmlpixHh/lFcdA99cQCSrfQgzsPpHTPltn2QQ67xRhuwXzIXbBFKPK69qTaJ5ZMzeXXFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=egN3GI4K; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="egN3GI4K"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-84e507b079dso729539b3a.0
        for <netdev@vger.kernel.org>; Wed, 19 Aug 2026 08:22:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1787152921; x=1787757721; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=7+lBP/0zzrM0YWXqyHqXC0bOhctJheQ0v0xEC9ob1O0=;
        b=egN3GI4KTjTWvJ0Zky4lVrq8ozfZ4dXsN5nVj1c2TC67iqGPOKXT9+TGHZV6AkNfYG
         t30gtqXsEBmbK7kyliX5gyNSaR/v5l2csp92v/RNKqVYN90X373S8Y3I7hmA0bB43Zd0
         EoA9kQ/gUcpWqFA6n/hk5VBS7bG4yUkK2CsbMBAybhXskEXVK6DUTgXgmRkwAfOF1+K1
         hvGDWVP2xw67U3O15jypFgT0hIIxS4qq2Kfg3M/bg6VBPOtUU8mbjjKXu6oMBkZbRQZm
         KkZIAGfpqkJddtHq0b+Gr7xf35LGvEyhRuC2p+TVDO5ygse6R/Wzqj48/nvfNFb6aMXv
         hmjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787152921; x=1787757721;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7+lBP/0zzrM0YWXqyHqXC0bOhctJheQ0v0xEC9ob1O0=;
        b=HmExjxLQJRi5qKJx2f+w1VmtbXOvPAWG3XTBMwFTBNTD2+LxFx3d6c7Fuzb2xzK76R
         jwHRJgzpmRJ4Pl5J6WpywRofOVD0R6BauFdqVr3pnzW5WQLzdcW4hiZ2ZrsA/4ZlheQr
         Yr5Z5w3bp7VxD9xxlLaTcUt3VS3GGdijV7qUGrOBF73l3BCkYJIPY4Tm0xxt6U6r+Wvh
         v4l01foSCQnjdS1zJyVKi4fbLeNnest4sMDBXedmbL/F5tJ43O3P+tu+E2kHe/HCuBVW
         cDnDl4TLTpN52fw63wtmvTixAS8qR0u7e6f3V+SU3bdfeN8quSRcvcMip/oCHWGTIyAu
         4umQ==
X-Gm-Message-State: AOJu0Yz8A3iaraygytvLC2rJig3DoQMKgKkRaFHwdyPuj5EmN7flSA/r
	hg7fg6eHc/mtrJeHoWlNwTM/95CI7qe96rsDYMLJ4Q6uL1esZwhwM0RlfvXKHr60MZ2bb7WdXyi
	Dw2FcyQ==
X-Gm-Gg: AR+sD114zGPisEDY4RSKhgRvshH3ac7y8uDYgJ+dGc3GlA/h6LE+02w9oopPiT1xu53
	yXpi93GjZnUZLEw4Cm86ocp8fA0mUlXdbrQWpI6U4XujwdgDtfTr7xz0lenFnpIf2Ev0iJ8ngow
	++ecYPXB1oZyqG5osDkUl6sqlQ4oCXkGKykPGdgrwvoPltvevdB3uSbpMWOwvdXH8oWffGckSiz
	A6RLwESku7sI9G+Nr7lexqZBKiwRXIxMKkva/AI9nRPNdHV9j23pnWlJZtNUsWXiUZhY7KU0nEk
	+TfT6uKHUwxwBW9icM2QQOlAmuUIuFvzjW0FKKJ3Uf7erzxJPghXK4vwEgwtkYzr4VY+BwJo2bM
	Ck+KZaHLPgzgfcIxD794nekJdIHS13oEqY//gE27vMRZ8nOJtAEKfazkrIJMGaAYp91MLXeRfvF
	lkeNqMmZ05YjRITyj49vfG6224lBBdZf0wqeKo1yqvH+U3FKavd+5rmjjG6NB+oBmcktlmeic=
X-Received: by 2002:a05:6a00:13a5:b0:84c:1cd2:142b with SMTP id d2e1a72fcca58-851d3943ee6mr9141704b3a.9.1787152921205;
        Wed, 19 Aug 2026 08:22:01 -0700 (PDT)
Received: from enjou-Legion-Y7000P-2019 ([167.71.204.91])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-851d3668afasm780519b3a.48.2026.08.19.08.21.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 08:21:59 -0700 (PDT)
From: Ren Wei <weir@nebusec.ai>
To: netdev@vger.kernel.org
Cc: edumazet@google.com,
	ncardwell@google.com,
	kuniyu@google.com,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	vega@nebusec.ai,
	edragain@163.com,
	weir@nebusec.ai
Subject: [PATCH net v2 0/1] tcp: clamp route advmss to TCP_MIN_MSS
Date: Wed, 19 Aug 2026 23:22:03 +0800
Message-ID: <cover.1787074852.git.edragain@163.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yong Wang <edragain@163.com>

Hi Linux kernel maintainers,

This is v2 of the fix for the divide-by-zero reachable from
tcp_select_initial_window() via undersized route-derived advmss.

The previous version only rejected undersized non-zero RTAX_ADVMSS
values at the route metric input point. As pointed out in review, that
does not fully fix the bug because the panic is still reachable through
the "default advmss" path when RTAX_ADVMSS is 0 and the effective
advmss is later driven down by route MTU and min_adv_mss.

This version fixes the bug in TCP by introducing a helper that clamps
route-derived advmss to TCP_MIN_MSS before it is consumed by the TCP
paths that derive advmss from dst metrics.

I tested this version in QEMU and confirmed that the previously
reproducible divide-by-zero no longer occurs on the advmss=0 +
small-MTU/min_adv_mss path.

Thanks,
Yong Wang

---
Changes in v2:
- drop the RTAX_ADVMSS input validation from previous version
- clamp route-derived advmss in TCP instead
- switch the relevant TCP IPv4/IPv6 call sites to the new helper
- drop the long reproducer script and crash log from the cover letter
v1 link: https://lore.kernel.org/all/2c3901162c65a1d85cc1756a83a458db834d70c1.1786610865.git.edragain@163.com/

Yong Wang (1):
  tcp: clamp route advmss to TCP_MIN_MSS

 include/net/tcp.h        | 5 +++++
 net/ipv4/tcp_ipv4.c      | 2 +-
 net/ipv4/tcp_minisocks.c | 2 +-
 net/ipv4/tcp_output.c    | 6 +++---
 net/ipv6/tcp_ipv6.c      | 2 +-
 5 files changed, 11 insertions(+), 6 deletions(-)
 
-- 
2.53.0
