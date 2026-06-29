Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2B77477E23
	for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 17:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782754041; cv=none; b=YJOcf4su/GYnHMU3nZxGaxsTUJqUzgODs5fqrGlohTGEm5HTydHABt4OCPVqHP1BTXV5Y73cK/rMttw4uezrZ1FxM5YAME5c8AOjnCuwbGpqZ07BT7lpcZH6zJ88+vguTj1zT4zFMKzeMSu3hCMBDXaamjh4wgfV0IdLFf1tfUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782754041; c=relaxed/simple;
	bh=xOeZ3AAryQQpH7b3QXyw0FJI7Icm4ldkT4ekRB6O/us=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AGpezoOm5ZPcTLibiVqA3Ark5V0A5EohdZhjM5Yb4Q0ZY9eS71Eg27bb0OxBmUUAK0+YL21/1TaDs9OuItGxf3Moou6YdkWTc71hLClhikDiRZwjvsyGE/N2OTIcJN6RkO/6TU5bYRKWA83dYLHDWG5Em+ojYkBLNi+/v93S518=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lsCuMxeC; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lsCuMxeC"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-845537740ddso2078274b3a.0
        for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 10:27:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782754039; x=1783358839; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Bc1x3dlPbzBDaS3MpDbrXFa1nZO4qwexshU5OtsKQHE=;
        b=lsCuMxeC/1fyqK7YDIKbQL9XHgNLDq0EK0YYoSNy3wo+w1Dt0vlu9ZwsaQbMteAoS7
         0UdENJrlfdpqSGQ7CsrZkxrMX6I89ZtRo6eGZWBh+uA0D9eaCHeVZQgyq1Mnji8F6LGc
         PRQOFk/P5XC4ktd4J1lJvD0UII8OYVLuxJ0iF0Ki4mbaYuazyE9W9eGu/RIcSCmWq0YS
         21a0Qo1ctaQ1LCIAyUxQAdi3+f9auDCn7dcvMJKtCoUGWpud9xKsSP6g02/Np6YC4mzo
         yZKK+A4uai1jIC8td/ENf4Vbs6Cdm/o1pGzziyVjOX0V9nUwgabb5MLYQ2XNoo24e2ey
         oRrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782754039; x=1783358839;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bc1x3dlPbzBDaS3MpDbrXFa1nZO4qwexshU5OtsKQHE=;
        b=fwglyzgDvglAFCSaPuXdYL3A7LL/aCDrrpNGst/TgfpnCkcaWNJ+IIVeQU+ZExsCJW
         kkR1vB9qmrpNGNg6hM6O5/F5jlY8HyuAjJXnnhJVUy2iYgIXxJcgHwSp+DzzSbKDIBG3
         mAQik+uzoDtEm9kmvoz9+DZYyZ9lmJMDkQw5bEmthdjB4+qFjfZclYLAiby0ksel1M6l
         pdPjw7e47OF2WaknbY/XYqG96zegxo8UiayZepYI/HQBV72d38PLoiq13NQzrReJANXF
         oRVYPGzypMvklsj/6aBsdB3HB76b9k/GpQoI1lIxglXNmhFfGOnEHW12L39vcjneqzo1
         O+uQ==
X-Forwarded-Encrypted: i=1; AHgh+RoIPvVqt575cnAjaFklwwSxx0PG/s3XiODt012BDGcSYk7wvmHzUhldg+/J6gToBugOHJjkG/U=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMzPrq/4oskIuAQqRJ9GBvrBPXX/lKicFkAUfLSx9MeWFj1f1t
	brzYxLEcKaBF5HB3z328xDLi1wzAHYkk00s/7lGqCWzrWoSoXqqBd+TB
X-Gm-Gg: AfdE7cmffPjGJiaahjC4jcDGzkAHUKH/gTkIO3dMfdm3cr0BFQhJwUQLIguHQeD050l
	p3vNjwpuV0eh/kpcHmdA97h/LkOqIg9EMHhfFJ297zfeNXWF+GwWkkt6w8/Iuq7e8GeEhakXTUo
	54Yg9rkbmQEwSmumMQppc0CsDDdyzAhBgjgZmKBeW5qFm1NdFz803CgSFi4gokLu1xs/uqVxN9+
	Ba3qlcUyuEKIOd/EunH8ZUhDVo2ceF6beF1MOQ23TfnM/a6vsM6DWD/eaIu8nBXCIw6c9+BGCeV
	3i745k5lguoMlOWpuBO4R1UWe2oYpVgV36qtTXMmldixmsN6z0kXAZGEDMGR9DEh8OetRnT/oCI
	vQMi1IvhQ7Ixf4LAGMwmRV3d7OsssQ1Xz7TNarE/D/fbbr2g+3+/RfXC4VM3v92gm/AmyL0519G
	YXFKYaQZwt1BBLbPWx+Y8EVse7BIYfJ+FmK60hUWyEwGS5bKuBYFA=
X-Received: by 2002:a05:6a00:4fd4:b0:845:d274:c01e with SMTP id d2e1a72fcca58-8479f2d17a2mr333793b3a.55.1782754038787;
        Mon, 29 Jun 2026 10:27:18 -0700 (PDT)
Received: from cps-manycore-1.. ([147.46.174.222])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847a039f2afsm78542b3a.53.2026.06.29.10.27.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 10:27:18 -0700 (PDT)
From: Sechang Lim <rhkrqnwk98@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Lorenz Bauer <lmb@isovalent.com>,
	Jakub Sitnicki <jakub@cloudflare.com>,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	Shuah Khan <shuah@kernel.org>,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v3 0/2] bpf, sockmap: disallow sockmap mutation from tc, xdp and flow_dissector
Date: Mon, 29 Jun 2026 17:26:59 +0000
Message-ID: <20260629172704.1302218-1-rhkrqnwk98@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A tc, xdp or flow_dissector program updating or deleting a sockmap
deadlocks on stab->lock vs sk_callback_lock and has no reason to. Patch 1
disallows it in may_update_sockmap(); patch 2 drops the selftests that
exercised it.

v3:
 - drop the broken selftests (Jiayuan Chen)
 - drop the Fixes tag and target bpf-next (Jiayuan Chen)

v2:
 - https://lore.kernel.org/all/20260620034632.2308-1-rhkrqnwk98@gmail.com/

v1:
 - https://lore.kernel.org/all/20260616091153.2966617-1-rhkrqnwk98@gmail.com/

Sechang Lim (2):
  bpf, sockmap: disallow update and delete from tc, xdp and
    flow_dissector
  selftests/bpf: drop tc/xdp/flow_dissector sockmap mutation tests

 kernel/bpf/verifier.c                         |  4 --
 .../selftests/bpf/prog_tests/fexit_bpf2bpf.c  | 13 -----
 .../selftests/bpf/prog_tests/sockmap_basic.c  | 52 -------------------
 .../bpf/progs/freplace_cls_redirect.c         | 34 ------------
 .../selftests/bpf/progs/test_sockmap_update.c | 48 -----------------
 .../bpf/progs/verifier_sockmap_mutate.c       | 10 ++--
 6 files changed, 5 insertions(+), 156 deletions(-)
 delete mode 100644 tools/testing/selftests/bpf/progs/freplace_cls_redirect.c
 delete mode 100644 tools/testing/selftests/bpf/progs/test_sockmap_update.c

-- 
2.43.0

