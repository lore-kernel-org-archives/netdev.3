Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57FD333D4F0
	for <netdev@vger.kernel.org>; Sat, 10 Oct 2026 21:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791666177; cv=none; b=QKNTbbE4Lf7V79lCvfFtLM8AaiWP/JxKwfXPTNLtUNm4ikXBhNSHQIULW+rdUmTvR3ViQyWxzj+d4BbVDj8UeEXQxtQtlq6TYtLOebX1yXTHB/KyQOLhF6ntZfnMMSVzvULr0wQqyoSR+iViZz2MfIUVYoQrEMJtYRUUI5yGPNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791666177; c=relaxed/simple;
	bh=CWB005W1JYdLCvsKy7Ozq6WQtnMeMg9lxlm/MnPEdhw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lEqRGst+jXFJRQCsiHLc7ji7sz8yCWDyeTqx0yLWUR0VLm7YApJxBTtft8F/shwAo0dA1Xgx6VjVim0PIXYVrs6TZy1mXFump+qgF8mF+bw/VZWAtn7uLFApTth0YIoGu+bw+RyaoJDM2kLPVpLZByWwW14pwOsY051Ul+dKPkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=idIOcLWG; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="idIOcLWG"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-91b63bd2030so12239746d6.3
        for <netdev@vger.kernel.org>; Sat, 10 Oct 2026 14:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1791666175; x=1792270975; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=jcVxPsPHkMv7myJPq9OeT+TVrTGAJUgIg48UHobGlpI=;
        b=idIOcLWG+QVHdypSONwQHE+9TeUQXC+vWFNEG61iof8GBQis7IpCJyFlCtPp13vgHA
         Zrj419D1emcp+DDAWYeSZ7i+8kOLuw9ijFtrlzvZszjte/x4h5KtBXlCblMKwd08l8vk
         PVHprpU36Qq75rE2KoIUOBvm0o1JN5HoE3WGQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791666175; x=1792270975;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jcVxPsPHkMv7myJPq9OeT+TVrTGAJUgIg48UHobGlpI=;
        b=epSCVnUj77wTIk80Fj5TSR2WKeOQwI4UFN+7DhMbNx4FuPX0/r1svkiOzE1pL+9kus
         76Ve4JMlXPVYKmskFQEx8pKdaTyJdwlgOqs4GOlxxMqZA+6Kf1ieAM/bTVVVZ+kRxH2t
         97+bABCdYM6Ff6FOAUqJywUwVA1bmDw6+g4HIHeyMIpspaghw6ftOjx7MSTZd+yw2MqX
         FnM5cPlZ5K4XVY+U+5PnqEYQFzyiZqxiHqp8CncQJo/csmMQ3G9ZPDWCELv/vv5CUer2
         5Zw+NblrAu5QAOpjE/Eym5VvH0V17Avh66hST2q6XDAhLWVvIARkbw53kxbBBttP594W
         kweA==
X-Gm-Message-State: AFq9FYL+gM/CpM3OrJNqJdIA25XLGe5LDyXqFhbD6GI4QY+YoQVQ/dmo
	CbPdd71kpP1jwtXZ12gd3+9nVtWqwhEIn5AhP2MO8Vckffxjwn2/z01unsoa4TQree0hNJXh8Rb
	QNlY=
X-Gm-Gg: AYBFou1bkuUUmkRkos2W20Rg74BrkLNjn9HZoUhNeJuNtWb4iS0x+IMuYenhGLkHMtO
	ttXx5Kic+IdKWPjdlLmQdEkdiqIHzY3IQN+FO/w3SMkE+l1pXE1Uud/cfZxUFWVdJu6NnbLed5K
	4Peez0UedLbczGE1Pe8shv338SprVYJI2shCodN9RgYHoA8gUe6OheYMGlh1Jo+Raj/IZY9JI/c
	yy9Ie5MsOi3VKah1wqbO/9qrGeKrtHexts4hOLCuiiaU7Rx6MTGL/02fqY/yu0AgJm9qDcsKpEi
	PgIdzc6WgnhJDYkWXD0NlW6MbYDQm4lKFW5xpggrqMvoIMewQ2Rx/oUbqhp28eEM87NxokUDn5o
	JkWw6gQIqzss2rXIEFeKIOlEGgLzDrsekOwyq5lUvb3rewMZWL79VRc6bp61JK1M2IifuE19VZn
	ugFO4GNq5IHNMEHLUbhB/cPsWMg48Y0uJOEdXUA1krCXhyc7ctWc6TFL4UOdPTps+Gn2YGnICO4
	qHh+AfUxK9cYsDa5dfPqRERo4DZKIfriZ5Nd76VArit
X-Received: by 2002:a05:620a:2b8b:b0:93e:c12c:f12a with SMTP id af79cd13be357-93ec12d08ebmr821334685a.69.1791666174924;
        Sat, 10 Oct 2026 14:02:54 -0700 (PDT)
Received: from mbili.waya ([64.203.83.2])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93eb984845csm498538085a.14.2026.10.10.14.02.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Oct 2026 14:02:54 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	ihor.solodrai@linux.dev,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	jiri@resnulli.us,
	bpf@vger.kernel.org,
	stable@vger.kernel.org,
	sashiko-bot@kernel.org,
	victor@mojatatu.com,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	andrew+netdev@lunn.ch
Subject: [PATCH net v2 0/3] net/sched: cls_bpf: accept dev-bound programs on shared blocks
Date: Sat, 10 Oct 2026 17:02:47 -0400
Message-Id: <QDISC-PYC7.v2.20261010165947@mojatatu.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series fixes the regression where a device-bound SCHED_CLS program
attached through a shared block is rejected even when it is bound to a
netdev that owns the block, and closes the bind/reoffload replay hole a
later-joining device would otherwise exploit.

Patch 1 gives netdevsim's cls_bpf TC block callback the device-match
check nfp already has; the callback is the authoritative per-device
acceptance boundary and the defect there predates the cls_bpf core
change.

Patch 2 makes the core attach-time check derive the target device from
the shared block's member set (block->q is NULL for a shared block) and
require every member to match, mirroring the broadcast fan-out of the
offload path.  Patch 1 is a prerequisite of patch 2 on v7.2+ trees:
commit 120977e2c096 ("net/sched: cls_bpf: reject dev-bound programs
bound to a different device") made the replay path unreachable through
shared blocks as a side effect, and patch 2 re-exposes it, so a stable
tree must take both together.

Patch 3 adds shared-block and late-join coverage to bpf_offload.py; it
uses the existing sample_ret0.bpf.o with an explicit `type classifier`
override instead of adding a new sample object.

---
Changelog:

v1 -> v2
- Patch 1 (netdevsim): enforce bpf_offload_dev_match() on the cls_bpf TC
  block callback, closing the bind/reoffload replay path (nipa High).
- Patch 2 (cls_bpf): reject an empty shared block; reformat the comment
  (gemini + nipa Low).
- Patch 3 (selftests): new shared-block + late-join coverage in
  bpf_offload.py.
- Split the v2 draft into three patches; patches 1 and 2 each carry their
  own Fixes: and stable metadata (the selftest companion carries neither).

Jamal Hadi Salim (3):
  netdevsim: reject cls_bpf programs bound to another device
  net/sched: cls_bpf: accept dev-bound programs on shared blocks
  selftests: net: exercise dev-bound cls_bpf on shared blocks


 drivers/net/netdevsim/bpf.c                |  12 ++
 net/sched/cls_bpf.c                        |  28 ++++-
 tools/testing/selftests/net/bpf_offload.py | 139 +++++++++++++++++++++
 3 files changed, 175 insertions(+), 4 deletions(-)

-- 
2.43.0

