Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9855E30D41E
	for <netdev@vger.kernel.org>; Mon, 13 Jul 2026 16:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783959799; cv=none; b=M5dfcO6kDTGfVbQUFrXt7S1tVlFm42iiVnSyKBUpZrTZXkAjQbgTydznpmSvxwzUaZace2lkJVmigQy3IDbT88p0VP2pNR39sVqMyHo7fkXGlnVcCaURg2tbO3yek+vdIzI905XNpKeYkcNqmX25G8lHYA78VHlcx1Ur40rAzls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783959799; c=relaxed/simple;
	bh=B7kjpC2G00xRZiwpS45deuXBg70rScBz3ZVyNCPDYfg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ceo4fvMIfDONWegQZ45pfowmDYu54lozi2LtCQP8AtlGSA2VqQp9CQfsqy1EOW1ffYYSEEgbgHJ7YHlzyOdO4Q2l2GUkSouupHxWwYGl3yQz1Agluad4POOM3XpMPV5DO+TmEBpNKFawTCpFmwrL0PKrZNM8urW21scsmcU21rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PgP0dTjX; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PgP0dTjX"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2cc7ef7ec27so37470675ad.1
        for <netdev@vger.kernel.org>; Mon, 13 Jul 2026 09:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783959798; x=1784564598; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qLsS+LiJOOGjNompP9VG70BhV07yJqBPnV7nhWUrazk=;
        b=PgP0dTjXzzEMgL55AI1+a/kNuAZSv3efznTsu3jVfGwbnEW21BVhxW7svYTEiFsiPK
         YR3OoUcnoMuhj2Ww/QfUYdkBeCuvHrFv72+CWWxOFnwBBtPIJBv69YeTuzj2oZGqNRB/
         qdaNTv9NcdDrEDVYV4NyDTDc1hGx1kDPql7PeG0O+vS7xl1SAlW9DSku/jPQ4KCYcqxt
         03LtVxbSYKEACJTw+E57UOri8yeiK6+XrS84Q1ApKZa77jA1uVV3aGb5Hms1gZlUJlr3
         9vY2Cvcs+jnqEaGG/x6BpfKhDkU3LZRDvudLEPMM0D3thSXmnhZl0G/Y2EJkAf89I5ht
         m/gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783959798; x=1784564598;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qLsS+LiJOOGjNompP9VG70BhV07yJqBPnV7nhWUrazk=;
        b=iW33qnJbsJD6Eq4ULzZtxb24w2wKixwIZsQrWORtLW983t/sG53xLuwEe1ppdLmz1/
         8ryF5+v+Zbznbk5MHklLOaT9v0tS3Bxb8HTdpyiL+4ZA3N0LjavnlY+cRORSJBq5Fs7q
         ohbj4GcooiFwyLtUOqqo8DZVWq/y6h9i6QHFdNs6do6s9q7GE2sKVqEms10B20bPV1tm
         GuYhL7TajmY3U1KbvWNFVu1up+0QDm0d+M9iOyZdm0n6yzQjg1Nzv+LfopVgAz3avDYb
         TPNe3QQZUKsJJPEW4RInHTwBqKOPZKnJ6Hm2rku+xWGnNddc+8QnRUuwKNi86KMp9Ism
         Htvg==
X-Forwarded-Encrypted: i=1; AHgh+RrBZVmoc94Bvv/5DcxNgmrPWUBopPmYl8dI1EYSsF8pizp62B8CCY1dQ4xCGTT0AQYs5s5hA3E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpRvSa2A8ZDcpWe5ysi6VFVeLqFxaiU+lujbIyCborw1ToyLv0
	UP3xZ+Ubhx1OaPOGno0gP+PpxBeF3Me3H70JWkzG/qOyIApIjJHyhOOS
X-Gm-Gg: AfdE7cmgHXHAUnuFc+zE7KvsJICxrvpqkgJQf0w6J1UD1it3B6RxggEHixD46K34Uhk
	gN5sUw6xEhoNBuX0WHwp3hau60aR1cocn0qqM+C7JNlncXwt2S5uTe176nznxrHl1gbAMZisZUJ
	QjIMHsKzsfFkxT1x1+6OVWDtNejDtcYDbTn0GJF549arCe0f3s29i2tK+diGKJGL8iEGw8BYkez
	Seoi8RYczVkfRUgigXHJDDLa7QyRpZdrzyRL6LPTOv+nzhFsWJ+oMgeMhPPNAn2Dncir5l0phCC
	wv8aLsmYcL0AcXWWWIxmHx5r5k5g4xzzrn5NGTJQWFms3W00NsHmaj2zoqRQhjZ45gC2tf0Nkow
	ahF5yMMpLDdm/eT2/rejbqcncqdCY4BfxRKXKGp822FF86IgAeOcHmS9/mTl3kfFqvDj5rjwkqB
	s0SEErjPzIxQM6d2/P9I1D+qWIYYdJXIjKiizJsGB3f8OzBmE0HlhTYmIRDew8lbiUVNoz6Q==
X-Received: by 2002:a05:6a20:a122:b0:3bf:9cbd:9a33 with SMTP id adf61e73a8af0-3c1100308e6mr10053783637.14.1783959797821;
        Mon, 13 Jul 2026 09:23:17 -0700 (PDT)
Received: from r912.tailbb6e1e.ts.net ([160.30.85.32])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b987fc629sm25769471c88.0.2026.07.13.09.23.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 09:23:16 -0700 (PDT)
From: Avinash Duduskar <avinash.duduskar@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org
Cc: eddyz87@gmail.com,
	memxor@gmail.com,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	shuah@kernel.org,
	hawk@kernel.org,
	yatsenko@meta.com,
	leon.hwang@linux.dev,
	kpsingh@kernel.org,
	a.s.protopopov@gmail.com,
	ameryhung@gmail.com,
	rongtao@cestc.cn,
	eyal.birger@gmail.com,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	toke@redhat.com,
	dsahern@kernel.org
Subject: [PATCH bpf-next v7 0/3] bpf: bidirectional VLAN support for bpf_fib_lookup()
Date: Mon, 13 Jul 2026 21:53:02 +0530
Message-ID: <20260713162305.1237211-1-avinash.duduskar@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This series adds VLAN awareness to bpf_fib_lookup() in both directions.
BPF_FIB_LOOKUP_VLAN resolves a VLAN egress to its underlying real device
plus the VLAN tag (XDP programs need this because VLAN devices have no
XDP xmit), and BPF_FIB_LOOKUP_VLAN_INPUT runs the lookup as if a tagged
frame had arrived on the matching VLAN subinterface, for iif policy
routing and VRF table selection.

BPF_FIB_LOOKUP_VLAN opts in to replacing params->ifindex, whose value
existing programs consume since d1c362e1dd68 ("bpf: Always return
target ifindex in bpf_fib_lookup"); without it the output is unchanged.

An egress that does not reduce to a real device plus one tag (a QinQ
stack, or a parent in another network namespace) returns
BPF_FIB_LKUP_RET_VLAN_FAILURE with params->ifindex left at the input;
repeating the lookup without the flag, with a re-initialized params,
returns the VLAN device's own ifindex. A VLAN on a bond reduces to the
bond, which picks its egress slave at xmit.

The new return code is appended after BPF_FIB_LKUP_RET_NO_SRC_ADDR
(nothing renumbered, tools/ mirror updated) and is returned only when
the flag is set, so no existing caller can observe it.

Changes v6 -> v7:

- Patch 1 (BPF_FIB_LOOKUP_VLAN: resolve a VLAN egress to its real
  device plus the tag): uapi doc clarified, repeating the lookup after
  BPF_FIB_LKUP_RET_VLAN_FAILURE needs a re-initialized params, since
  output fields overwrite the inputs they share storage with. No
  functional change.
- Patch 2 (BPF_FIB_LOOKUP_VLAN_INPUT: run the lookup as if the tagged
  frame arrived on the matching VLAN subinterface): no code change; a
  commit message correction (an invalid proto returns -EINVAL under
  !CONFIG_VLAN_8021Q too).
- Patch 3 (selftests for both flags, tc and XDP paths): local defines
  for the netns subtest addresses (Emil's review); the netns input arm
  brings the moved device up first, so the namespace check is the only
  condition it can fail on; the live-frames subtest uses its own netns
  name (no collision under test_progs -j) and counts only the test's
  TCP frames, so background traffic cannot satisfy the delivery
  assertion; a stale mtu comment corrected.

v6: https://lore.kernel.org/all/20260704092159.1256823-1-avinash.duduskar@gmail.com/
v5: https://lore.kernel.org/all/20260624030530.3342884-1-avinash.duduskar@gmail.com/
v4: https://lore.kernel.org/all/20260623025147.1001664-1-avinash.duduskar@gmail.com/
v3: https://lore.kernel.org/all/20260617224729.1428662-1-avinash.duduskar@gmail.com/
v2: https://lore.kernel.org/all/20260616223426.3568080-1-avinash.duduskar@gmail.com/
v1: https://lore.kernel.org/all/20260609172052.81613-1-avinash.duduskar@gmail.com/

Avinash Duduskar (3):
  bpf: Add BPF_FIB_LOOKUP_VLAN flag to bpf_fib_lookup() helper
  bpf: Add BPF_FIB_LOOKUP_VLAN_INPUT flag to bpf_fib_lookup() helper
  selftests/bpf: Add bpf_fib_lookup() VLAN flag tests

 include/uapi/linux/bpf.h                      |  52 +-
 net/core/filter.c                             |  97 ++-
 tools/include/uapi/linux/bpf.h                |  52 +-
 .../selftests/bpf/prog_tests/fib_lookup.c     | 720 +++++++++++++++++-
 .../testing/selftests/bpf/progs/fib_lookup.c  |  57 ++
 5 files changed, 964 insertions(+), 14 deletions(-)


base-commit: a975094bf98ca97be9146f9d3b5681a6f9cf5ce3
-- 
2.54.0

