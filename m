Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C15B155C97
	for <netdev@vger.kernel.org>; Fri, 28 Aug 2026 08:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787906741; cv=none; b=jjeZbXLOmB7lERUE3dHT53a0gB8cN52Tr4O0RqauB4dih72AmnvrZukatgDceqJ8vbR/cVAiOJZvqxSyVowkzRO21E+dFD9a3vPhd2dNQVYxDlZ83b3WvBI4H/2LCGRmQWZb1FERrmj5WAmC5mmIo81qADj14k2I4TEIYd96aRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787906741; c=relaxed/simple;
	bh=NqoqCfyoFE6X5OHQBuc+CfaqoiCY1+1elxwSxpA+jWI=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Nojj/meizqbG04t+ATAEJLyl5Qz7cmfFH4v+qZkC+NJAY0bev/np2V2OQXwJfe7e9bpIoa4zsCfC0BKF7rkUfN6rpjTGWW1pHo6ITpcva+X0bUpkSRyNYpdL1fpbA8q9BYS8g8aMOOwvaNDf3RPZ8e63I84Vo+GCOaBCw8WFZ94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sdi9dwQ0; arc=none smtp.client-ip=209.85.222.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sdi9dwQ0"
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-936708f129aso72944785a.0
        for <netdev@vger.kernel.org>; Fri, 28 Aug 2026 01:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787906739; x=1788511539; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=gz3GUsAoUfnTfSCRuKI8Oi8c89aw9vjcgL+SSV6OIz0=;
        b=sdi9dwQ0pf8QG+LO+01tMB9XyLHWA6VCi1rgfLO0EhijFfvlOO8lsS+QMimjdMqNnI
         WVA/6xcTQZybuj8Vy0jvW7pUSkKhcsEXW853A/1xkrMNpWqRLfSQzVNhTOoJ3Z4JfmJD
         oVE4vglMZhvY1YrT6EFHqgz7OGZJUUXO0LgefyJawumxzir0YA/zDZpTSoriBWe4CzLH
         wK+Ac64Qv38fZ5S4uNyNDK8cZVz0upwbYYn8nsL1ISLLBoS46Z6QmRTO6zS4ncSuPT0h
         BV1OpP73vv/1Bzcg4PB4Oj2Elb0XwjvdDLKaIECQndcY9CRzA+Z5HRssltyVSbpMz/BO
         96TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787906739; x=1788511539;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gz3GUsAoUfnTfSCRuKI8Oi8c89aw9vjcgL+SSV6OIz0=;
        b=YFRmtCdS87yXh386qYT/KJ2mM9z8VEQ8uyn/Tm54hxGmUiRy5z+X1EjaE/6Qp3L67Y
         43RXtYOIa11VwQnQffdF9Rd8kvq4i03J2K1mk8kMEekodlP+X4cSxV6TJoZMVobGllhG
         wojD42Gz6q4IMpx4Fz6dyEbUrOhJ+pyK8r4kgQp7ngTYKnt4mdKVpCkJXzlYL8VpfIK0
         J9rO+awI9Z4DSy0ZrececsVLqq93V4saytXEVO4JMNacQ80c0TTaqBrNoaHAV4MqKiT4
         kL4DTzw92JBDq3HjR6A6t0OYGyMHDDKDWRVT6xmOxhzUIVCD9eM+X/NIFii8XYKVNi4l
         2mmg==
X-Forwarded-Encrypted: i=1; AHgh+Ro8Neatdsj+fFWDWLXvnb5UAy2LIqeggMiLhCnxu3sHwk2w9jKiWAsQqGC4PCZMBDEk68pjfEc=@vger.kernel.org
X-Gm-Message-State: AFuF++mZAqiPDpEhFshkLCB+q2zm0DVhbWq7lK1jRR/iyCaKSb/zbe2G
	JTZ5p5oDXizR/84mL5BPwug4Thwvp5nK8thlSbMA6WOWkXI+7J4gZoJ7qxc2K4Gyk8zFpabdW+A
	oeXmhiE/UfJ277g==
X-Received: from qknus12.prod.google.com ([2002:a05:620a:6b0c:b0:92e:6aaa:d1c3])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:2810:b0:92e:745c:6c5a with SMTP id af79cd13be357-93913809eb0mr572171285a.14.1787906738836;
 Fri, 28 Aug 2026 01:45:38 -0700 (PDT)
Date: Fri, 28 Aug 2026 08:45:26 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.897.gb25b4bd76c-goog
Message-ID: <20260828084531.1826790-1-edumazet@google.com>
Subject: [PATCH v2 net 0/5] ipv6: mcast: RCU and timer fixes
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Ido Schimmel <idosch@nvidia.com>, David Ahern <dsahern@kernel.org>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

This series addresses several RCU synchronization and timer calculation
issues identified in IPv6 multicast (MLD) handling within net/ipv6/mcast.c
while I was working on fixing a syzbot report in net/ipv4/icmp.c.

Patch 1 fixes an RCU reader diversion in ip6_mc_del1_src() where mutating
psf->sf_next to insert an unlinked source node into the tombstone list
diverted concurrent lockless readers (e.g. ipv6_chk_mcast_addr()) into
pmc->mca_tomb, causing them to miss remaining active sources.

Patch 2 converts ip6_mc_source() to use copy-on-write RCU updates.
Previously, source additions and deletions modified the socket's
psl->sl_addr array in-place, causing concurrent lockless readers in
inet6_mc_check() (UDP/RAW receive path) to observe torn 16-byte IPv6
addresses or duplicated/missed sources.

Patch 3 fixes delay calculation in igmp6_join_group() when canceling an
existing delayed work, preventing unsigned jiffies underflows when the
timer has already expired and clamping the delay to the unsolicited report
interval.

Patch 4 ensures rcu_assign_pointer() is consistently used for __rcu list
updates in __ipv6_dev_mc_dec(), ipv6_sock_mc_drop(), __ipv6_sock_mc_close(),
and related helpers.

Patch 5 switches igmp6_mc_seq_show() to use jiffies_delta_to_clock_t()
with a signed long delta, preventing underflows in /proc/net/igmp6 timer
duration reporting.

v2: addressed AI review.
v1: https://lore.kernel.org/netdev/20260826103711.3302915-1-edumazet@google.com/

Eric Dumazet (5):
  ipv6: mcast: fix RCU list diversion in ip6_mc_del1_src()
  ipv6: mcast: use copy-on-write RCU updates in ip6_mc_source()
  ipv6: mcast: fix delay calculation in igmp6_join_group()
  ipv6: mcast: use rcu_assign_pointer() for __rcu list updates
  ipv6: mcast: use jiffies_delta_to_clock_t() in igmp6_mc_seq_show()

 include/net/if_inet6.h |   2 -
 net/ipv6/mcast.c       | 148 ++++++++++++++++++++++++-----------------
 2 files changed, 88 insertions(+), 62 deletions(-)

-- 
2.55.0.897.gb25b4bd76c-goog

