Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BFCD3BED35
	for <netdev@vger.kernel.org>; Fri, 11 Sep 2026 06:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789107724; cv=none; b=l7QriO5PuxONnSI9Ou9Y0iuMSA7IOYeMRTimnhjSxDWZDRV/Kbf3xj1+5NHOoMd/PB2ZplOyojsLv+syec8vFwB5A/sEUICdOHgIhjHMtbp+RdX6EIuZGvc6Bi2v8LOF3Z2co1thjNndd2iiQZf9fGlwDudJAGi73nguwABuyVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789107724; c=relaxed/simple;
	bh=y/dc5vCWc/TYHv36NI7Gq3zdv9XYjSnFdjXNV6jfadY=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=ZoC4jWevVBrn6FstP6++IxlJAyh7hmKSxHL7n28u4WTN/5+3wr4g5UyQpQCblJTnOrIjAfAjWCebXbHSCoSVP0BIqSgPazd9R/cOt7j6SR27VhGH3eMTeNCouCEk96AvEj4l/Rx89ddgT+YQGMUsecndIqMibhBr2xo64rVLRls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=so+umfHr; arc=none smtp.client-ip=209.85.219.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="so+umfHr"
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-9104417215aso11511526d6.2
        for <netdev@vger.kernel.org>; Thu, 10 Sep 2026 23:22:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789107722; x=1789712522; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=BgnNK7mkZHSpv22FvMxsZCCuI+BQAsTOXuEeDXMnytg=;
        b=so+umfHryG2JjLE5BAMVBuE/welmqm/A3hs7u68gqadLcbUi7m75OscwjjEj/9MV3F
         49fX3rPZavhdf/feOQXB3/h4AA31yb7/1tdBmJmbVGfjrcODFFzkNcUbgpmXvsX0vHZ9
         37MgrXv8ojFNn+R5Hu4Hm8W0xdCl3Rdd/AIr1syyF7WciVYzo/Q7Exa6ndX8xI1HtbpC
         kpCdPuhkBHKkQPMG+M+uqJzOCoM1TX2m6GoCjFwDnagpRyXEkmyIMpXypbt+ZG2ZqWV3
         XZ16mWU7i2uWm+sdNQRMnUEq1N5OK7tVwYdvpsdtZ690iiYdwSrm/dLxDmY0sNQagHD8
         hfxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789107722; x=1789712522;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BgnNK7mkZHSpv22FvMxsZCCuI+BQAsTOXuEeDXMnytg=;
        b=Znvl30Q92clycnSB8zc6JWGhFCf0iUK3G2A9ib9aTfWG1FG1A4RhseaN8FGmaGLaLU
         vVVZkDtu5Tvw3MQpCmDM2aju8cj+saO1WwEjDC2ImyS6u7x8eH+evi161ITst/CAFnAU
         90S1sc0N1/9d6KK0BPMS32AlZQW2blOD6P+07IxTsvXJKMg+g2ONbfESfutrjawMpQEH
         Qly8olu/eeKw3A88E4Nui3Yq0091YUDuE+o7SMyrlyuG2TXUzdzVoQJIHhpqvipt6/CF
         4KVTeJEHto70q3EhlkOSzH2NTHObdo1vegByUT8jg9jSAD0OD3kby0ca5dfaVung2j3k
         wVpQ==
X-Forwarded-Encrypted: i=1; AKwUvBxxcLNBZdKCzuM/PG1jzF4zrgJ+W9UPYhKxwSLwvQ/KGiA1rPT3gZ+zm2oQC8NB2qlCLTfX6ck=@vger.kernel.org
X-Gm-Message-State: AFuF++lj+MrIQXTqWLBOg8oCQqrWqHlgLWaSsTd7zVSzx8KC3xejcOji
	4SIgzq8VEmxW3BRVNzSn6IUNq6B2smYbgwsSZ2xekAvRh47sjlzd6KPG92swFOCc6IwanKxSDCc
	S90qqnsLAtY4YZg==
X-Received: from qvqm12.prod.google.com ([2002:ad4:504c:0:b0:910:4b12:6ce4])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6214:5199:b0:90e:867d:c893 with SMTP id 6a1803df08f44-91212064fb6mr32956056d6.8.1789107721620;
 Thu, 10 Sep 2026 23:22:01 -0700 (PDT)
Date: Fri, 11 Sep 2026 06:21:54 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.1007.g17ff1f9808-goog
Message-ID: <20260911062200.231316-1-edumazet@google.com>
Subject: [PATCH v3 net-next 0/6] vxlan: convert configuration to RCU and
 enable lockless dumps
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Ido Schimmel <idosch@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

This patch series converts struct vxlan_config to RCU protection, eliminates
redundant destination fields, and enables lockless RTNL-free link dumping
in vxlan_fill_info().

Changes in v3:
- Folded configuration conversion patches into a single patch to maintain
  clean bisectability and avoid intermediate mutable state.
- In vxlan_changelink(), pass lowerdev to vxlan_config_apply() to prevent
  truncating dev->needed_headroom and dev->needed_tailroom when lowerdev
  does not change.
- In vxlan_changelink(), ensure default FDB updates for VNI filters trigger
  when remote_ifindex changes, even if remote_ip is unchanged.
- Pass old and new ifindex to vxlan_vnilist_update_group() and
  vxlan_update_default_fdb_entry() so newly added FDB entries point to
  the new interface and deletions target the old interface.
- Cleaned up redundant NULL checks and unreachable error paths.

Eric Dumazet (6):
  vxlan: vnifilter: use list_for_each_entry_rcu() in
    vxlan_vnifilter_dump_dev()
  vxlan: pass vxlan_config pointer to helper functions
  vxlan: move VXLAN_F_MDB to struct vxlan_dev flags
  vxlan: convert configuration to RCU protection
  vxlan: remove default_dst and use vxlan_config and lowerdev
  vxlan: no longer rely on RTNL in vxlan_fill_info()

 .../mellanox/mlx5/core/en/tc_tun_vxlan.c      |  11 +-
 .../mellanox/mlxsw/spectrum_nve_vxlan.c       |  14 +-
 .../mellanox/mlxsw/spectrum_switchdev.c       |  57 +-
 drivers/net/vxlan/vxlan_core.c                | 717 +++++++++++-------
 drivers/net/vxlan/vxlan_mdb.c                 |  45 +-
 drivers/net/vxlan/vxlan_multicast.c           |  76 +-
 drivers/net/vxlan/vxlan_private.h             |  19 +-
 drivers/net/vxlan/vxlan_vnifilter.c           |  96 ++-
 include/net/vxlan.h                           |  12 +-
 9 files changed, 638 insertions(+), 409 deletions(-)

-- 
2.55.0.1007.g17ff1f9808-goog

