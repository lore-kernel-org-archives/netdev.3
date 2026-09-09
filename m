Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A4D53DD526
	for <netdev@vger.kernel.org>; Wed,  9 Sep 2026 09:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788946051; cv=none; b=eU1kvbyLKbpiN+Da8sqwSv/bEL86s1VzZSVa5yYLTWzeLvkaDdorjA8w5EopktD2Z3MVzE9LzTKkv/Exe1u9EzTfJxZuQft9S3KfGkTynB+lpKUXMTElYUksQu84We+PhchHsy5qwDHCPrmlrOyjfaE71H2SKt6YBMffR120LuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788946051; c=relaxed/simple;
	bh=ZcLSLvkBF6ozJekkfIc7TNhqA51pJFNoJ7IKNcYF6Ro=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vBMlxNPicoHCWtJj821HnTMeut5MXhr4VgUxODYzZalI/aEabni4PIfW518zmWovHw3vnTZoTxK5D2WOehHIbm4K+LFZLUuSUVqCnQUI4Tn+OR02PptK2d2/veYYg9zY0vke7/DzbcfnQ4VT550ydO7EVOUYPULhFJxT81jPS4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=isnO0f97; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="isnO0f97"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-49b9320423cso63693475e9.0
        for <netdev@vger.kernel.org>; Wed, 09 Sep 2026 02:27:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788946046; x=1789550846; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lsdKs0VobuM4XI3gIi1gCgynRI1C45G2dcgah+Cu3mM=;
        b=isnO0f97dV2yRvpBkjb+GqrzvLj+5Is7RYGn+XomlxYmcO/WrShU30gFKzVqrHyiJt
         YCNX9k1VuN2mcsa/MU25YHxl7jXjspKc/bYq9OcviM6e5VutOidesNcdvkT2sg3kvEA+
         1mH+4du8qxuJnmIlxQYA3YtuY/eK5uHRY6OGbzDgRBrTu+tzpZBjc9oIpqXkuG445WRB
         GDJ99GhDgiRgHlQrcDLvUBT7YEVAdVEHw5/wabGM6VXANtwBExg5PYwm1eHIJEeHMpDx
         AXVeseSADkSvKYbROwgKkLQ4qorIAWukPmok2YCHWosSds4wz+iS3Cv1bjS+iP9sweUe
         gKFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788946046; x=1789550846;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=lsdKs0VobuM4XI3gIi1gCgynRI1C45G2dcgah+Cu3mM=;
        b=qBUMb5Lbt7Bze8FVxmMIFUlVxFD+4mNb81rFh4lsn1Ka6sDY1rX2NDySZA+hLA1igF
         pBzkB7/tTmQxV69RLqO3T0iwTQLT7DdQwJQBZHzsogd8LiLy66NQxhy/FWLWypHnCYhp
         lVmbXz2EMmrzXTUd08vG/+S4xxevp0fyT13DurAUe7dvIWrnEMvzA7aCCt8sn5MUBxSg
         vi84a1O7cmTZ07tK7NMRxd/dgCjrjnOLvG/AIY/OnmMt0Lnju/iMy0xDMwGsMLZQ2pqs
         sLlnDhDRRWbjI2L5U5a80ZzASdKkdfBzdXdtgELoxmxSR8P0XiY0YOvwyzlOm9ZKJgXQ
         heGQ==
X-Gm-Message-State: AFuF++mOuyGLLdiM0+GNaIbctZ41ewUfzbFRgk6oVQVKX41ROC00kicd
	Vu+LqdrLgpTA+7YaFqBNiIUpvcrBHh3sbAC4kI8e6tCaOZKtxClOzA8IZvTq7OzFtnE=
X-Gm-Gg: AYBFou1cV9b/VN+X4fFBXRZX3t9OfStNR3mZjaKnufCLt82V8XRzhpdBanRq/akjMvj
	3mxF1S24cCn80Sp+W/zZzXu7JEbllQgSfORsE2LPOmL12n3PPZybId1+IwFbBKCFIpojr84U9Iu
	cEQFPCixqEfirBnmvbHdyLwFtMwTEtFi4SZ7uXNGR5GIhovuRzJ1I4abNJQSkBmt0kpTYv8TTxJ
	qTcRIH7+5CukusvAX1eETk1i5Odo+ftOx26avZXiYiznR2qygdJkGU2xUJ6+nYsSlgV1wBaVpjb
	lwmYb4hBkkRbDRNs9SGXLAi2LoSnbV5KtKldxUFZNHCgJ6pYGOeFhLX3GCTi1g6mNyXn1+5iI2o
	Cwx3x3cLqHK5Miqy7vEpYYgnLsf6lMZsvKtnuEOHTVdnAzYHE3SifA6wxy1USW9w2r/XWqBEWXr
	FKyAvOq/C4hRimc5M4E77e9Zlw2U1HKkJgwySIbLfMCyfnUPs1W/2ea7LlPPwehBBC0w3mSq1vH
	dPxy+JHGH13jO0Q6r8lFF3y
X-Received: by 2002:a05:600d:8490:20b0:49c:f89b:f82 with SMTP id 5b1f17b1804b1-49cf89b1bc2mr525615555e9.12.1788946045572;
        Wed, 09 Sep 2026 02:27:25 -0700 (PDT)
Received: from kali ([169.224.126.247])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-485883c074asm41558442f8f.23.2026.09.09.02.27.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 02:27:25 -0700 (PDT)
From: Ali Firas <alishmery18@gmail.com>
To: netdev@vger.kernel.org,
	idosch@nvidia.com
Cc: kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	razor@blackwall.org,
	roopa@nvidia.com,
	linux-kernel@vger.kernel.org,
	Ali Firas <alishmery18@gmail.com>
Subject: [PATCH net 0/3] vxlan: vnifilter: bound the VNI range per request
Date: Wed,  9 Sep 2026 12:26:42 +0300
Message-ID: <20260909092645.3105263-1-alishmery18@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260907141001.GA708129@shredder>
References: <20260907141001.GA708129@shredder>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A single RTM_NEWTUNNEL or RTM_DELTUNNEL message can currently ask the
vnifilter code for the whole 24-bit VNI space, and vxlan_vni_add_del()
loops over that span under rtnl_lock creating one VNI node and one
per-CPU stats block per iteration. That is reachable by an unprivileged
user in a user+network namespace and it costs roughly 2.1 GiB + 1 GiB
per possible CPU (128 B slab plus 64 B per possible CPU per VNI): on
2, 4 and 8 CPU guests every full-range request
ended in a global OOM, with no errno returned because the caller is
itself OOM-killed, and with unrelated root-owned processes killed on the
way down. Because rtnl_lock is global rather than per-netns, it also
stalled network configuration everywhere: a plain "ip link add dummy0
type dummy" in a different network namespace takes 0.011 s normally,
4.472 s while a 1,000,000 VNI request runs, and never completed at all
during a full-range one. Patch 1 caps the span of a single request at
4096 VNIs, which closes both. The cap is on one request, not on the
device: a device can still hold the whole VNI space, it just takes more
than one message.

Patch 2 charges the VNI node and its per-CPU stats to the caller's memcg.
With the cap in place this is no longer the primary defence, but nothing
limits how many capped requests a task may issue, so an unprivileged user
can still accumulate VNIs 4096 at a time with none of it charged to them.
It is also the same class fix as commit 1beb81947eb4 ("net/sched: account
classifier filter allocations to memcg"). One limitation is worth stating
up front: try_charge() reclaims and then invokes the memcg OOM killer
rather than returning -ENOMEM, so accounting confines the blast radius
without producing a graceful failure.

Patch 3 adds the selftest coverage Ido asked for, in the existing API
test: a range of exactly the maximum is accepted and one VNI more is
rejected, for both add and delete.

The limit is a driver-local constant rather than VLAN_N_VID: the values
coincide today, but a bound on a VXLAN netlink request is not a count of
VLAN IDs, and coupling them would make a change to one silently change
the other.

Patch 1 does tighten uAPI: a request spanning more than 4096 VNIs used
to succeed and now returns -EINVAL. Ido's assessment was that the limit
is unlikely to break anyone, since vnifilter is mainly used on bridged
VXLAN devices where the VNI is derived from the VLAN, capped at 4094.
I am sending the series to net because the stall is reachable by an
unprivileged user and crosses namespaces.

What I am less sure about is that Fixes: in net means this reaches
stable, where a script issuing one large range would start failing
across a point release. If that is the wrong trade, I am happy to respin
patch 1 against net-next without the Fixes tag.

Two things the series does not address. A single-VNI request with
START == END >= VXLAN_N_VID still passes the span check, and
vxlan_vni_field() shifts without masking, so such an entry is silently
truncated on the wire while holding its own rhashtable slot. That wants
a netlink policy range check, which I will send separately to net-next
as a pure uAPI tightening.

Measured worst case at the cap, on a 2 CPU / 2G guest: a request of
exactly 4096 VNIs takes 0.031 s to add and 0.022 s to delete, and the
cross-namespace "ip link add" blocks for 0.024 s during it. The old
full-range request is now rejected outright with

  Error: VNI range spans more than 4096 VNIs.

for both add and delete.

The whole selftest file passes before and after: 27 tests passed and 0
failed on the base, 31 passed and 0 failed with the series applied.

The 4096 limit follows Ido Schimmel's suggestion:
https://lore.kernel.org/netdev/20260907141001.GA708129@shredder/

Ali Firas (3):
  vxlan: vnifilter: limit the VNI range of a single request
  vxlan: vnifilter: account VNI node and per-CPU stats to memcg
  selftests: net: test the vxlan vnifilter VNI range limit

 drivers/net/vxlan/vxlan_vnifilter.c           | 24 +++++++++++++++++--
 .../selftests/net/test_vxlan_vnifiltering.sh  | 13 ++++++++++
 2 files changed, 35 insertions(+), 2 deletions(-)

-- 
2.53.0

