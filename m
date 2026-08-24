Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17DFD43B3CE
	for <netdev@vger.kernel.org>; Mon, 24 Aug 2026 15:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787585951; cv=none; b=aBILIUxK1ZWjomXEFKvQIkSCMNhas0gr7MJqFZ/P9O1IN6IZ1VJ6Z3O+aQBKBvbiv54noBYmCKlrHo7wVrr3x+FcynADjnm0tmgWMLjaadDEVBAgTLPS/2+nnOYLWitFVkU+6WDXSD9KCYalp/ThHQjimslIeDoz3iHcbxRSEmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787585951; c=relaxed/simple;
	bh=N9Qr47hoJHf5mH0LIY/iPRnnbplhX0buuzhOzLMf3Sg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Bnlv2FPoOYb+yC6uXm2d3ck4wYbyqDyitI1Ko8i4YmfOWPLKZLLA9TkL9ZiErgwZSyyLfkY1Wnj6nyE3IOs3xEg/1qW/TilWKTrujK4nNdGOME0tpuH7hWUB5UjRPAB6HJl/3mpVjMDZ4aGmhcIuaFajBW9fp/B70Vx6fBJ1dqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=g8/gMJln; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="g8/gMJln"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2d6af66ca14so11726345ad.1
        for <netdev@vger.kernel.org>; Mon, 24 Aug 2026 08:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1787585949; x=1788190749; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=54XN+lr0mhNGT6+V64LXevY2nPLK9Aerexj+sgq57HA=;
        b=g8/gMJlnUBx4ZNDfXsHpF+rbIEgI8OCKfqL1EGSKe+erlpzZr5UvZ7ttdl5f9lHwbF
         quEpqXLU2qCDMv/uLBo5Dzp2fEXPMavh6IxkS4i5FRE+u6YULGTy2FcpkhjwPF/BeHx3
         uZVegUdNUeh6xYp5zwvw6sqH7b82fErEhsMfs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787585949; x=1788190749;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=54XN+lr0mhNGT6+V64LXevY2nPLK9Aerexj+sgq57HA=;
        b=rodNQ2RSZCykxIWGACk+O2iSimkquBTgE+D1BBr1avV7Nv2Ox1tmU+A6TRQav/QuEe
         AjP+5wHcFIaytAJLyJOgCUQRAJmrtIfE4G0Af8Y53MNpeb3D1+nPKazBm8N1LliaIb8L
         o6kSjtwvuXnVyA3HHIjgXKzNw4DixAuuYwDiQHfPGRwtsSHCYMR4jH/NfrA4OdOL+rYI
         6ROzsl0z7cnNOsWwn/aEdQY70h1ZGr2cBGn0okAhMv56wc3XvhSWidbuaKwAKenxAJqY
         iU30fKvXc7+ez/rvAqu2HgpZDDzaGhVgJ9IH/NCHcKtpY7/1TA38N6Z+SIokSI6P64+G
         ufUQ==
X-Forwarded-Encrypted: i=1; AHgh+Rom+u/Tfv6zb33R2F6HKaYefusaIj0x3wcxh489YXONiJ+fVNiW3xRyv1D7uexXmuu5qX3qo8M=@vger.kernel.org
X-Gm-Message-State: AFuF++kIVscdTtUwO5bol43nuDFEFX8FrckzZd9aEm2UyDBAmfq0eAoU
	vSpVJAOzNKxNtG6l6Uu9ajocd9U+zavtfpMTHVvKsZimkj9UnYusWiiAqG1sx7A97Q==
X-Gm-Gg: AR+sD12ZfurD4BNWsPwoeHB4+8twG6SDvunXEyb6IdjHXZRLTtHArxd8Zd9BmqwXDrL
	9ovI+nlktgPivu6W3zD0CgllTNBdkY2qsngAOahHqm7zVVdKltACQWsIzFe3dVCrtuVQQk7xHyE
	xzJB9kI/V6AWeo+wmYjY/tMI0JrhL+1K6pKexJsrll8iYEdT/Q+dMK1HBk9pM/kqkcipYDyZmoh
	Kv828unQkWgUlSQwBjLaQzo/opIQ9Hv0OYHeB/Sf32vK0nY5RFS9ZDWAtye2QEw8QExZhd5y88y
	hapV/7KkN1Z/WsOwIfcA2RuGO3a0agIjOk1wH6nyf+IUNmKdKYOtGOX/VWGWNF2lmwFkSaA5AZs
	xh/oUTefgkiHh8Nc7Y5QRkbbQ7E8kiAdZFTMLrPhlpKZvKLULfM6LGi58t+s+6gFaT/YbWTLtFO
	SHCGitn8Ta1gjFlx+WTt61b4ttqYuj98/HxQQ6g/Vo/WQ=
X-Received: by 2002:a17:903:b8c:b0:2cc:d6de:d597 with SMTP id d9443c01a7336-2d670bb70d2mr387938675ad.7.1787585949254;
        Mon, 24 Aug 2026 08:39:09 -0700 (PDT)
Received: from exu-caveira ([2804:14d:5c54:4d67::2000])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d6767b0aeesm18704585ad.36.2026.08.24.08.39.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 08:39:08 -0700 (PDT)
From: Victor Nogueira <victor@mojatatu.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	jhs@mojatatu.com,
	jiri@resnulli.us
Cc: horms@kernel.org,
	baowen.zheng@corigine.com,
	louis.peens@corigine.com,
	pctammela@mojatatu.com,
	netdev@vger.kernel.org
Subject: [PATCH net 0/4] net/sched: Fix remaining actions notification accounting issues
Date: Mon, 24 Aug 2026 12:38:59 -0300
Message-ID: <20260824153903.4143642-1-victor@mojatatu.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 8e2efb3f45a5 ("net/sched: add get_fill_size callbacks for actions
missing them") fixed the reported echo/notify skb overrun and noted that
the pre-existing issues Sashiko pointed out [1] would be fixed separately.
This is that series.

Patch 1 makes tcf_action_shared_attrs_size() a real upper bound again.
TCA_ACT_IN_HW_COUNT and TCA_STATS_BASIC_HW are emitted on every action
dump and were never budgeted; TCA_STATS_PKT64 was budgeted once but can be
emitted twice; TCA_ACT_USED_HW_STATS and the rate estimator attributes are
conditional and also unaccounted.

Patch 2 makes the RTM_GETACTION path use the attr_size that tca_action_gd()
already computes and then throws away, so that "tc actions get" can read
back an action whose dump is larger than NLMSG_GOODSIZE.

Patch 3 wraps the reoffload delete notification in
tcf_action_full_attrs_size() like every other notification path, and stops
leaving a skip_sw action installed when that notification cannot be built.

Patch 4 accounts for the block in tcf_mirred_get_fill_size().
This was not in the Sashiko list, but should also be fixed.

A net-next patch adding get_fill_size() to the five actions that still lack
one (act_connmark, act_mpls, act_nat, act_simple, act_skbmod) will be sent
separately.

[1] https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260810164357.1653956-1-victor%40mojatatu.com

Victor Nogueira (4):
  net/sched: act_api: budget all shared attributes in notify skbs
  net/sched: act_api: size the RTM_GETACTION reply from the actions
  net/sched: act_api: fix skb sizing and action leak on reoffload delete
  net/sched: act_mirred: account for TCA_MIRRED_BLOCKID in get_fill_size

 net/sched/act_api.c    | 37 ++++++++++++++++++++++++++-----------
 net/sched/act_mirred.c |  3 ++-
 2 files changed, 28 insertions(+), 12 deletions(-)

-- 
2.55.0

