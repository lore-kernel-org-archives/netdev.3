Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75E11448BBF
	for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 14:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784817773; cv=none; b=uvSX/EryomSWuYeFflz8BALFbMfLm4Wai1cZzt6UCfpgEyeKhmcMWU4I81BsNgMSnFWXSmE4Nuhp0MsxZj2UNogKnINMo9P9Q84lvTevB0+YLjDA092FiGiBt0XnR0c9KcLalJ4TrYwyT3Jy9kc+M2Bd6+8dR6uOti0FRBisKHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784817773; c=relaxed/simple;
	bh=yRhGOXvyw0OkmSYDrxJFQ6eyn9r13kGbw7V19oZp74A=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=f5WDp16/wFUwQ9QC8fuSn9iYNukIuFnGvynfSANzvJOCFcmiN32ZQYnZa5bYpvzKxFw3GzBNyU6Y9kKyoZXGN0DVnLlPwIekowXuRE0Gpxkzm4KnblOg0de2A78t5ahbuwVi/kunKdqaMBSu7Ao/MIbfibXK5aRj6lJa5rCot1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GuY7v+pe; arc=none smtp.client-ip=209.85.222.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GuY7v+pe"
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-92ec91dc265so72277385a.2
        for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 07:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784817771; x=1785422571; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=oeE31NCU3h4ApAcJCLODrhBJb1QbmNirbK6rRMjyJA4=;
        b=GuY7v+peNLzWcBkAjqQsHJi67xm7UbjiSGrW3kQHWiXwUqv7ypS4okC7GySv2ehNrC
         dWcChfSeB8lHPr4tuVifKdaxpC/KLg+t4GeLXlPRaCaiTwkeWFUps0hSrLI+Toa1Yk0/
         vJWgwlZS9GXnEFW6mCjpMeg5XGFXc3zA0RPeIg3yp2Qeh6Vb6H2SA0uaN9cLouXdL+pN
         WyaG1dito4T6rY7zuT6M5N0dN2I1UMFHhqiijXKAPOwJUI43drtaOkWI8M8f0Aq4urww
         DIhYwQzQeDRIKXqOvk9xA9M/wUvr6XbhI/gl808FPx2VLO4Zvs87G87tB9Vxgxu45Zzs
         E3PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784817771; x=1785422571;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oeE31NCU3h4ApAcJCLODrhBJb1QbmNirbK6rRMjyJA4=;
        b=R0QvQW4V9Qk9IqNYxCrKSbHvuAkHhrCWQtYYiM29KWu+frn1qEw3PHi3hEafjISqgj
         fprXa6n5nkN2gBJ6bUQz397GlIc0vly3qp7eno2iO9nhu0FPQd8bZRlgXUSQEHmCKazi
         GzcJMN61KRGiSz2k0RMYV3pqWwY+PtCCuSId6i6wfWoYKkX0eJzPOkDHHH/QQ54iKaup
         CRV4eUCqHeUxdBufOoEJMbRN3lrqPOakz3zKZwfOSzbA3W6aLOO5qsyQJ/VKRQTQyZny
         iSMqKIsdYomTu92CoCocJBXkanubXCxe15ywBb/anOczrTPy8paxe0cekwgahWT+pEBF
         o2tg==
X-Forwarded-Encrypted: i=1; AHgh+Rqr1XRZ/GqOfDqX/i5XJLpUW1ZTedvwi96UPRjoRuGAjDRtSXwyCZASlArkNrvjP/U3qeZAEls=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFIWjAcElDKnQiFSSYt+RdPEfnTWX9EDKQtLIW9O/Fpt+QCkS1
	BBZBbYwC/hk399Zs+9lQiVGQxQKlfjVLWPWoEc27spNU7MeHH/iFe/LCuPfWL6rGySN3pT8FX9m
	sbCxIl6kstKGLgw==
X-Received: from qkmw3.prod.google.com ([2002:a05:620a:e83:b0:930:e723:4bf8])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:4594:b0:923:45bb:a95c with SMTP id af79cd13be357-931035b2a35mr308353585a.10.1784817770608;
 Thu, 23 Jul 2026 07:42:50 -0700 (PDT)
Date: Thu, 23 Jul 2026 14:42:44 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
Message-ID: <20260723144249.759100-1-edumazet@google.com>
Subject: [PATCH net 0/5] vxlan: fixes for skb header pulling, cloning, and
 concurrency in TX path
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

While working on RTNL-less fill_info for vxlan, Sashiko found annoying
pre-existing issues, adding noise to an already complex work.

This series addresses some of them in VXLAN transmit path,
primarily within route_shortcircuit(), header validation, and neighbour lookup.

Patch 1 fixes a potential use-after-free in vxlan_xmit() caused by caching
the Ethernet header pointer ('eth') before calling route_shortcircuit(), which
can reallocate skb->head via pskb_may_pull().

Patch 2 calls skb_cow_head() in route_shortcircuit() before modifying the
Ethernet header in-place, preventing packet header corruption when the skb
is cloned (e.g., by packet sockets, tcpdump, or dev_queue_xmit).

Patch 3 replaces direct reads of n->ha in route_shortcircuit() with
neigh_ha_snapshot() to safely snapshot the neighbour hardware address under
seqlock protection, avoiding potential torn reads during asynchronous updates.

Patch 4 changes route_shortcircuit() to use pskb_network_may_pull() instead
of pskb_may_pull(). Since skb->data points to the MAC header on transmit
(skb_network_offset(skb) == ETH_HLEN), pskb_may_pull() was only checking 6
bytes into the IP header, leaving the remainder un-pulled in non-linear frags.

Patch 5 applies pskb_network_may_pull() to the remaining transmit-path header
pull checks in arp_reduce(), ND solicitation proxy checks, and MDB entry lookup,
where skb->data similarly points to the Ethernet header.

Eric Dumazet (5):
  vxlan: re-fetch eth header after route_shortcircuit()
  vxlan: unclone skb head before modifying eth header in
    route_shortcircuit()
  vxlan: use neigh_ha_snapshot() in route_shortcircuit()
  vxlan: use pskb_network_may_pull() in route_shortcircuit()
  vxlan: use pskb_network_may_pull() for transmit path header pulls

 drivers/net/vxlan/vxlan_core.c | 21 ++++++++++++++-------
 drivers/net/vxlan/vxlan_mdb.c  |  4 ++--
 2 files changed, 16 insertions(+), 9 deletions(-)

-- 
2.55.0.229.g6434b31f56-goog

