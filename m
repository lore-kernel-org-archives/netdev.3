Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5B34357CE9
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 05:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789535317; cv=none; b=UjGBdKDKKqM2DSOp8EYSV7aeQFSB971xsdYfPb+dE3V0RkTB136YGclU4lDCA9o7/eQnTKqkGKzBIioeCw43IH2YBiF44mauJv/3HaPSgJg0aNLLGxyV4g8aqpDCmbzVPzuYSfNnOKGLz6F/YiiC66VHK0GfffH0DYdZQwLwIr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789535317; c=relaxed/simple;
	bh=2cgZHqdIDWjy5S2mo79peEOhzTJ1Ke+APakpgI0d4ZM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=I7xpEadKXlhY7xgAEZWKo5Hp2M+9WBO1q7ofYMg/hl8L2Yx9snHV36CY+oAcCZ3rVim/J6bilINVE5Y9pRlTO4lwPe2Sc+AnhNj7TzQ6ejBE5e9DitvAqkWhkEiB25styodB93+558dpcd7v7SSmgyL5o2TPLTfD3wEVTrXcyV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=I3WP6PLh; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="I3WP6PLh"
Received: by mail-pz2-f12.google.com with SMTP id 41be03b00d2f7-cc1cea50dc0so230071a12.2
        for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 22:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1789535315; x=1790140115; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=j9ZKxm5fjZ6Tz5RkeiPUJnapHxTN5p2mOK51NP1wOEA=;
        b=I3WP6PLhDcuaKCqdSweGcprMPYZHHHtH2X35W33TwkodGvSxmlYZR2kkFksr2M3639
         3noZq8jDpVLhjVL71c/nnG1Pi/bR25T8+xmnvUdY1W2n09JYOQ4bGDf8hvxyJoXwp4Rn
         p0ZMpTZS2xo3HvkkZesb69eYs4mjiCW0K1SqlW8ENZfjKQ7DIWIT7rjqRgJhfSX4m4iM
         Qw0sUGOH854L/Umhz7l8G9W/LCuRIBj1QIctp4Aw3vCs82XbJuXpUvI5Z319q6qRb8MS
         rsU5gO1kw3eQkBORn02k17jhYO/kl7HwstbCLmPz/STiakzpIvGhCCkAO+mA9+sKmHeG
         1cIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789535315; x=1790140115;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=j9ZKxm5fjZ6Tz5RkeiPUJnapHxTN5p2mOK51NP1wOEA=;
        b=EmLMHoLYecNYIlMlHAa+7Tl3i87EN73W8z7Nd2J6Kfeq5j0VFDuBC/kCJz+mjixf/9
         p1Utupm2zsvXfgYvazXk1v0dnyFCGp3grSuc4Lb8GRlYUKX3fJAb3kqG1xunShy/4aQD
         4fuTjtLU1t0q3vllRNeIHtuSXG+gz/u+iO0lp1jdsEk43MYCQD/qgSNNK2nmZlHNgiGi
         4PezLs2BuXN94b92fWgwWln2+VjqSh4miVHVTx5iwG3Qc5FoBo0V8XolKtreKUceW+fa
         zdynsk4DD7rUDrtRTeXVzgfrqZeBA97N1JgrR1F0H/DW1StiJ1S5F1jOyMw2LQ1Guu+e
         zyEw==
X-Forwarded-Encrypted: i=1; AKwUvByPesiOQgSpZ7HCENaCASpGJBhqLk0l70ShATL71ZVnNZqWxqySa3ZfPLYxMHOPth9t3CP9e7A=@vger.kernel.org
X-Gm-Message-State: AFuF++m3P+s1LU7SEputj+jJDkopl8Pqz8i76zvlX8alXD/KwOy8kcZb
	rUYh4l4WCGh7O0T6y6y+xL6gLVsN3NmSqeoAGu+TM3u9zKIDUbslp79F8eRwPifbT5U=
X-Gm-Gg: AYBFou2WGZXvUsL7RBsAeEM4d+HS//BfL2nfNchSS8MOAv4V1KkJoh8tyWAF+yO+UEn
	Ue+xkSK6hHuXrsDrMExzFWTVWnEsul2kLD6Mpyo6rLAZOrQh4X+lGJH6Vt8uY4ldQOLl77W4VyL
	IZSRDd9WNxZs25FD9WIsdKnmKUBNlBDodI5BriOhXwRDjgtnWYYdfVxl1cSH2pLAYiB+vOZcBpy
	IUQ4Lg8OIqKQzlQLKmlPzIejJRC9+unZGkWv2Nnt086YCB0cuGxmlb1za18FoPl3jCwVE9Zu+av
	Ll1lR1xIJcUT/iMwgbN1ucBxxYZfltij46Ke4CoLoRuOqzKzDEWK2jYs3qu+mun5yiUewzC550T
	FjwBvlysXkYAAPwLCwsmQCZU//QG6y4Lc2a/LQIY1pK7unIjwrjs2KsA10hH8zLUMtvttLRLq++
	KyhC6FmVLESgTXIcLvG2KBJ44cThC8KGcdozVdmWGAgrjVZua+Insl7vmw5c5/Cs2qDjOhNsUF9
	dH3Dh59LHwAUXQDiLDhQAH8OA5wsSN7jZ8s1ug=
X-Received: by 2002:a17:90b:3c11:b0:39d:efa9:cd1a with SMTP id 98e67ed59e1d1-39e1e2655e6mr3057475a91.4.1789535315262;
        Tue, 15 Sep 2026 22:08:35 -0700 (PDT)
Received: from alpine05.ht.home (107-190-31-17.cpe.teksavvy.com. [107.190.31.17])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e1bbfdd49sm2363363a91.11.2026.09.15.22.08.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 22:08:34 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	daniel@iogearbox.net,
	netdev@vger.kernel.org,
	etsal <etsal@alpine05.astextra>,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf 00/11] skb/arena bugfixes
Date: Wed, 16 Sep 2026 05:08:18 +0000
Message-ID: <20260916050830.8774-1-emil@etsalapatis.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: etsal <etsal@alpine05.astextra>

Set of verifier-focused bugfixes related to dynptrs, SKB
management in BPF, and dynptrs.

Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>

Emil Tsalapatis (11):
  bpf: Fix bounds check for skb-backed dynptrs
  selftests/bpf: Test dynptr slices past end of skb
  bpf: Fix bpf_sock context code generation
  selftests/bpf: Add selftests for rx_queue_mapping context access
  bpf: Reject pkt arguments in mutating subprogs
  selftests/bpf: Test rejection of pkt args to mutating subprogs
  bpf: Prevent variable arena/non-arena register contents
  selftests/bpf: Test for mixed arena/nonarena code paths
  bpf: Track whether dynptr type is known
  bpf: Track skb memory invalidation by packet-backed dynptrs
  selftests/bpf: Test dynptr slice invalidation on skb clobber

 include/linux/bpf_verifier.h                  |   5 +
 include/linux/skbuff.h                        |   3 +-
 kernel/bpf/cfg.c                              |  10 +-
 kernel/bpf/verifier.c                         | 112 +++++++++--
 net/core/filter.c                             |   7 +-
 .../testing/selftests/bpf/prog_tests/dynptr.c |  10 +
 .../testing/selftests/bpf/progs/dynptr_fail.c | 183 ++++++++++++++++++
 .../selftests/bpf/progs/dynptr_success.c      |  20 ++
 .../selftests/bpf/progs/verifier_arena.c      |  49 +++++
 .../bpf/progs/verifier_global_ptr_args.c      |  53 +++++
 .../selftests/bpf/progs/verifier_sock.c       |  38 ++++
 11 files changed, 472 insertions(+), 18 deletions(-)

-- 
2.54.0

