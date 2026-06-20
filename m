Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C3F54964F
	for <netdev@vger.kernel.org>; Sat, 20 Jun 2026 02:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781923479; cv=none; b=CcTLx5eHO4QkwROHbtwKTRaOOrm6HWGJwxagh5RaxWYRN8LqS1cy4b+hLJb95JbBwy9csUtKSr3LdgBeoNCqgFyQ6tGPtS1Z9qgCjixzcIXIlFO5GI39NSRkdWkK1w2gGOTkHEIbKiZGzlgCysmuRLgOj2Q/O1s8YIkKUvwUQcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781923479; c=relaxed/simple;
	bh=NP4quYUiUG5ir6Lfp/c0pxMjxtMtKmPdVnpeYKXlUh4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RJyN8YVFiv3rokooyN2+J32HT+Wrc+bP4AHRbeNVS/wDC/mkv2fyEeHe9jBEU0a/qzBR/qktF9Udv1+fKT5Rr6h9SaVtB+Jg8UwogHEEPGLNB3Kmu33R/yP5JyTFH7XUgxji3m/1cFcM5sZhpWaqx6Eg467CvjvsHiJTKVvsjxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dv1hXSxK; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dv1hXSxK"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-37c867bd3e0so1281578a91.0
        for <netdev@vger.kernel.org>; Fri, 19 Jun 2026 19:44:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781923476; x=1782528276; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tEtBLcfn+4nL/oLFXcmstWWRDWBHHiHGLWZQy1ZHB3Y=;
        b=Dv1hXSxKUXJ9TVQynNVZA6sCZscNGNjyUl8o1fETyyQSirtnuAPVeKpX5BoLCbWuVC
         md18EqGZZovQGbvXGFqTDG+WpsXkUZVlX1BhQy28REFKzmtq6zw/zfEzqVQA4J5KQSgp
         bes/khJf490M9lrJm66nWmRTSmIe35AuV2d67ClIhGOFbAfARQ4Vd0UR0EhbkADcrwbQ
         BLkySwSFMcWaQvrfOINQzmOUsFphR5ue/T8PVVgJQYSUaU3LAI+zcQnuAbAdHlHoG65P
         a1OBGs3Ih+i0rA6vJ11aqEjeltGVp3twUfLPyDkpFMCQ9u/SNo6JeVGPzNd4mQH2eHcc
         pqBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781923476; x=1782528276;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tEtBLcfn+4nL/oLFXcmstWWRDWBHHiHGLWZQy1ZHB3Y=;
        b=OkdT1mKk7hIKhssmRBdnUrJveG7y+gQW7gtiZAwaXogUKIGorATX4caKDHIZDFnhWx
         +BtCSsMuZHndt4fYc9vP+YfFaFIzv/72ITV/8MEpykV0sRZtl7Wtd1FxhI+bEUCF/mw8
         dsVfuGpcKiDfdIvPJMnU5ezyvyd5sSU5Qmq3aMlt6euAwleaBatJq8g9/orgXOS8Vruq
         qsZy5KyhX+r9mOz+RCTHx/tYU4iub3Q2aRJaQQNgc1/EwgBwKj/E2L5Pa791OxN0k73K
         w33etgdmbrwwyVlw6WH2JfKjIh2DtUBgJfplzUjyUg2/MGQNF+rGStCmaWbSQ6Iq5RFc
         vvtg==
X-Forwarded-Encrypted: i=1; AFNElJ+pmcOxAAXUjVNU/EAJ62zDnFMXTI5zo3ijW3qEADmPCm6gm181HwvEVL348r/NrOMcV/W2oKs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfK/S3bcDrtbXz9nb6v2AtIdClFr1NRJadYO9EctKCNKNcgvgf
	Yc8nQ3EloBOctvRgAdVm7bW8Gzys2VRLal/OulZci3XEggI/c9wa4hWd
X-Gm-Gg: AfdE7cng8DG0D/6QoAJ06QISlL1y14U5qYrTv1DZUOB56c2IGxhhO9Pd6ZgLPHQTAPO
	CSyWCSp3E5FXGTjhdRNkJ6rm6EDxD8vnU+oabJ6VF/mxJyULmG/1rKG2sm7BjhguAOeqDEZQNE6
	E9gNMBIqYES9h3Uwa+lM31mzItqYt2RpBaRB2XJ3nX/TxZtme5K/OiahtK4z+P/yEWK4Cou6TxZ
	VW72oEvQCNPuA+M8lg4e8SHK4YIISuuw0MllGxJupLRMvz+kJ+dUdMHlgv4ehlSYftvIOwgk0Kh
	NSQ/WBtPylZWv0vO2rMHDtYyhnTkew5QD2aZZOaj7EdnQbAV09y2QDqgcGi8eI2UQD5a/ZqUvl9
	7XpcmNxB/LOQ6CbdZWlGLEzKi7qrKIWUatObArqqSUAw7hZudToGSDLM9GKDYGwiyCc24L3Tpoq
	LZxoNeL7+yFCTeLQqDrspt8VHlsjoH2v0iVuJk/xnQAYqiEJeqFG4=
X-Received: by 2002:a17:90a:f94f:b0:365:a5f6:4a5c with SMTP id 98e67ed59e1d1-37d15dce559mr6675282a91.1.1781923475789;
        Fri, 19 Jun 2026 19:44:35 -0700 (PDT)
Received: from cps-manycore-1.. ([147.46.174.222])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37d1600975asm1087971a91.0.2026.06.19.19.44.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2026 19:44:35 -0700 (PDT)
From: Sechang Lim <rhkrqnwk98@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Jakub Sitnicki <jakub@cloudflare.com>,
	Eduard Zingerman <eddyz87@gmail.com>
Cc: Eric Dumazet <edumazet@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Willem de Bruijn <willemb@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	Bobby Eshleman <bobby.eshleman@bytedance.com>,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v5 0/3] bpf, sockmap: reject a packet-modifying SK_SKB stream parser
Date: Sat, 20 Jun 2026 02:44:15 +0000
Message-ID: <20260620024423.4141004-1-rhkrqnwk98@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A BPF_PROG_TYPE_SK_SKB stream parser runs on strparser's message head,
which can chain skbs through frag_list. A parser that resizes the skb
frees the frag_list segments that strparser still tracks through
skb_nextp, leading to a use-after-free.

A stream parser is only meant to measure the next message, not to modify
the packet, so reject a packet-modifying parser at attach time.

v5:
 - target bpf-next instead of bpf
 - add Reviewed-by tag (Jiayuan Chen)

v4:
 - https://lore.kernel.org/all/20260619062959.3277612-1-rhkrqnwk98@gmail.com/

v3:
 - https://lore.kernel.org/all/20260618102718.2331468-1-rhkrqnwk98@gmail.com/

v2:
 - https://lore.kernel.org/all/20260612123553.2724240-1-rhkrqnwk98@gmail.com/

v1:
 - https://lore.kernel.org/all/20260609112316.3685738-1-rhkrqnwk98@gmail.com/

Sechang Lim (3):
  selftests/bpf: don't modify the skb in the strparser parser prog
  bpf, sockmap: reject a packet-modifying SK_SKB stream parser
  selftests/bpf: test rejection of a packet-modifying SK_SKB stream
    parser

 net/core/sock_map.c                           | 20 ++++++++++++
 .../selftests/bpf/prog_tests/sockmap_strp.c   | 31 +++++++++++++++++++
 .../selftests/bpf/progs/sockmap_parse_prog.c  | 22 -------------
 .../selftests/bpf/progs/test_sockmap_strp.c   |  7 +++++
 4 files changed, 58 insertions(+), 22 deletions(-)

-- 
2.43.0

