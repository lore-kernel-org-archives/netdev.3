Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C5AA3DD532
	for <netdev@vger.kernel.org>; Fri,  9 Oct 2026 05:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791524455; cv=none; b=LT2HcedZtnAE+k46W5j4vuYrSUVuiy0lqbF2rtWU0a7Qkwp127h7lte3YG+atQ6eiT/ifknYZjGKh4OKFOCeFl5cWGmQqSsDQpRbg2bEf24Z8fNDq/FNOWx0X7Itvkjn0N1zs+F+YdoKc5QBkoPhaROtK/n4bmFr1lrPGji7h84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791524455; c=relaxed/simple;
	bh=HnB57wgD3GFiYI3A8kNtqpj2zQ6URRPxoqjg9tTokok=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Qc8ErxQcnXAkSBjEzfCODZQXRKXH71R8OaDJQzdluu+0hESMsf0Y26LdqiH966VY+qQWIROp/mJd1n0vPvnZKlickgEMT0ZRwbYrKygBOY9P6LejgIa2PdQ/rnup9SICxtcHv9kB3IvMiZRuSKMrJEnq+Nt83+6X9/boG7dt81I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l00VCcxi; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l00VCcxi"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3ab450c0873so175458a91.3
        for <netdev@vger.kernel.org>; Thu, 08 Oct 2026 22:40:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791524453; x=1792129253; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=w+4kAAJ3Fw9J4WUA2k2oRC3BjB3Bj1YsgSFYbXXKqEM=;
        b=l00VCcxiWhQpi5que07Q0W3yGNo8szkB2tQaZHf8S4HPl8CM7raK9U0kkHuZ72mTWZ
         L0AelV66X03VtLkjqk8ib+qiNK9c+JZrqkYS6kRgoMmHBZJRvJuCBM3Vrt741i4697wI
         OJYoh4ij5K6EwgyNzwXAM1AC0H0fws07V6B7qkM2y/aufVQ6fxyvqrJ2OV3ccKU87vHe
         4NNLF2M06R6JZ0d3Gtx/XUM76vxyYyUaV34MWLpHWa1VwuiB6JhdXos3vczJD7Y+Ovi7
         /AosKo+NyorA9ZgXi3+ZTMoZzMKzIxo3u4mhLgHXV/GuvhzAxXJBeMqwvmFrsOSYYvcI
         s7LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791524453; x=1792129253;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=w+4kAAJ3Fw9J4WUA2k2oRC3BjB3Bj1YsgSFYbXXKqEM=;
        b=faJNdhDBwQBoLQo5tRL1c2szglD9aInUDG2c7DvWcpSEJ564gbHabhAsye3uazZv9V
         BrkUc72Qot0VqUk37HK9Jyk0jNdXgmnUj1Kzvpri3OlaSLdC6Ws4h8+sGw+ySR/v1DPp
         lvkkZLxxnwSMrImsLCOXb7Q7kphynMyiNdKNJ0k12jN3fH5KEIranNM44SwfKTUMH/lu
         4A9em2ys6QPEHgqpN+somgvj1cf3kB2sBcISztqNFmabheFSeBzCNkquLNocT0BtFh16
         sKjZLHmCzwRbpDYom0nt9mrx9bMcw6aUW0AiJomseb3zmex4kmapp1j4Vf6PYafip0O9
         jqyw==
X-Forwarded-Encrypted: i=1; AKwUvByCEdcGK96MrCxTZAvsMjAu3SyCoFCc0G8l4Zk6UjNSbfZLFR3Seg9a4VDPevVPBEP6xKdYQBw=@vger.kernel.org
X-Gm-Message-State: AFq9FYL7trTtFGLY4OrrZoX/HkhWmF9saGoLHK4Xz/AvnbwGVEEbalvH
	0blpFShEr6mIf6SXcFCsKvpTzrW9fdhPaSXyO1IZosTo0P7KeKStFPIY
X-Gm-Gg: AYBFou1rfoPq0YLNnE7h+hBaCbDsTjZDPnwmN+jolE1VM4sj90Mijcr1EQJ2C7/YXON
	aTwjoZnTHU4E+VLTlT8RT6x0tblAOjHYqWepQ5pTbcaQJbTpwVCgYIneT5dGmyHvnjuKn3v3icz
	gB9ODAu7IZAk0cEcPezn5JAkwiBHrKUA7BmS7uf7E2yQzUXveUISJAbWuxl8NZfTfPZjhYqIj7F
	7bgQxNkidng0UIWqcVH+mvOXWinUFfwtmPmCz/4odY7lbbKUKRr2HYnh3mmCaWtJqbt5pw/UzJ4
	6+5iZnEM2NviOfjm637c45L03M3svclaJodXa7Tom6hT9zr0qHu0H7wJ/4lVCjF1a9LFBoNgG6x
	S3nR7AjE562envGC/9lUcAZhMALZKHZOWlA8prqIwJDPjplw4KEu8cGh8S27yo0cyPVQ/YWvumT
	uOZdS+AB0fIdInBBO9UjUkWkqLvzToqLJl8gMCP0u/N04+qBVwWPpPDTX7uukEztVho+4klyCOP
	916AP7vqywA
X-Received: by 2002:a17:90b:5346:b0:3a4:e635:a8c9 with SMTP id 98e67ed59e1d1-3ab3a773f40mr964916a91.24.1791524453388;
        Thu, 08 Oct 2026 22:40:53 -0700 (PDT)
Received: from ancienth-X870E-Nova-WiFi ([125.186.72.2])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ab3690474esm2028695a91.0.2026.10.08.22.40.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 22:40:52 -0700 (PDT)
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
Subject: [PATCH net v3 0/3] ipv6: fix address publication races with addrconf_ifdown
Date: Fri,  9 Oct 2026 14:40:39 +0900
Message-ID: <20261009054042.272944-1-4ncienth@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The first patch serializes address publication with device teardown by
taking idev->lock before the address hash lock. It uses READ_ONCE() for
the initial lockless state checks and rechecks both dead and disable_ipv6
before publishing.

The second patch handles an address captured by the per-device snapshot
after the initial hash scan. It removes the address from the hash in the
existing list-removal block, after delete notification and before dropping
the list reference.

The third patch initializes a temporary address's public-ifaddr reference
before publishing the object. This closes the remaining interval in which
ifdown could miss the reference and a later store could leak it.

The original deterministic test used a direct internal caller, kprobes and
atomic rendezvous at existing instruction boundaries; it did not add delays
to addrconf.c. A real RA separately reached ipv6_add_addr() with
can_block=false. No new kernel build or runtime test was run for v3.

Changes in v3:
- Use READ_ONCE() for patch 1's initial lockless state checks.
- Add a third patch that passes ifpub through ifa6_config, as suggested by
  Ido after the Sashiko review.
- Move patch 2's unhash into the existing lower !keep block and use
  73a8bd74e261 as its Fixes commit.
- Rebase onto current net while preserving the v2 cover and first two patch
  subjects.

Link: https://lore.kernel.org/r/20261004183639.3773498-1-4ncienth@gmail.com
Link: https://lore.kernel.org/r/179122559913.434549.12720841717630168470@kernel.org
Link: https://lore.kernel.org/r/20261007164548.GA1153540@shredder
Link: https://lore.kernel.org/r/20261007164635.GC1153540@shredder

Daehyeon Ko (3):
  ipv6: serialize address publication with device teardown
  ipv6: remove ifaddr from hash during ifdown list cleanup
  ipv6: initialize temporary ifaddr before publication

 include/net/addrconf.h |  1 +
 net/ipv6/addrconf.c    | 25 +++++++++++++++++++------
 2 files changed, 20 insertions(+), 6 deletions(-)


base-commit: af32da41b0327b9c6a37856ba82b6760d6c8d10e
-- 
2.55.0

