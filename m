Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89EB843786B
	for <netdev@vger.kernel.org>; Fri,  7 Aug 2026 13:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786108789; cv=none; b=M8TU3AIpX6P6XwAi0kaCqqvYk+HL+N2/VEaBjTDGhpvUhiMAD84h2lqZpQAIRnBB1en4nrnciku0vO2O2MistzE0mLcGoe+b+zerGoglguOaQAvUn3aukyA2m+ywS64sBOM/naFX3QA4ritlqZzHgqNBwgjED9b8fLNdHXHzO1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786108789; c=relaxed/simple;
	bh=/3QfjorFC4WHngMHUPf5Mu5W04ciyZS5aS+owYb5SWI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kC6/vy/dv+Vzz/WPKV2AQ9ZzWToKIZEEe74pavjHm0XxGfoGKamFazM6xtyQYGfwySJKroOiZQHDKsQ7ZXx8+NaOmWrh3lWENzE5S50cDIt63k88xn80AoHxV0y57bhCTfNqMA83i/MaPiXEBm7CM/EvtRXieRnArjFwNX3uKnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e96yy8GE; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e96yy8GE"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-490cf322ed0so27661235e9.1
        for <netdev@vger.kernel.org>; Fri, 07 Aug 2026 06:19:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786108781; x=1786713581; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=gAxAClyqJm0XfJys8/gN2j1pvq2c/F/Yxstuid7ORa4=;
        b=e96yy8GEilOsEx/arLwyI16P9tVHHzTXydm7WpL8a2qMBpmHJ3R4egl1ilzG/fHp2L
         6EfvorIDER65rZcXBpmhjhFyYZFujDRNeAnMYAKTPAv/0RrXqnfnlXgFkaxqAVR4SZ3l
         c+SqjqSRBccexf2cv5XpKBzMidl0vdfT89YiJ35pk1tr0qKYNRSRWTvDqFh6b5N4kznk
         EGh5CN2GdKvVwD35YHJBlpCGSGv1s7rkxouKSONgZTepD5Tplg7tSu7DHGS2Ui1MeUtb
         l/BH8k0xRtixOZ5+MFIMVpGnjy+Jb4QJ7V4gwlHtma7jTuPH38Sxb3fhaB2zOd9A49Y0
         ff5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786108781; x=1786713581;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gAxAClyqJm0XfJys8/gN2j1pvq2c/F/Yxstuid7ORa4=;
        b=SXjx26aOlwShHRZLUZYcu4Bz7j/u++Gedrbs2BnrMIhx+T/X7mNnkKexjg9Ug56b0K
         bAvWV3+UzlZdk6xBJjdFXk6U8XYYj1vh27v9ovCAK+ntmtUZJ4qVsinLs/JvajjErbwj
         JtjEKMRYe1gX4/1i95lvCXy7ZmBegCxBruClBooofKWiuX8ZF54OoVo8tqH2HnteMY9j
         s3w9xpptRezxXXP/4APWpSxYPNnfcsQgTzA6PxC7fM3cBzAkFlr9DZ2iskb0lTYrdl7c
         SwcQwLlQ1VT91zGkf3Z/Odwk90KT9lAyTtYaRmfJRg8smGtFrhJJgf4wSgHf3vA0zEKo
         4mYA==
X-Forwarded-Encrypted: i=1; AHgh+RozIEveex0lAdP5GxxirsqwlBum53uhBtX6vdbxz4JrHgLkNYo/jgf0wgxlO6vAzanBhBt0EVw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8hD0sqkQEOaubNC1GEgIOqXCZqRE8Bjzm6o1KL6GMOH0iKTo9
	js9AEA2t/mHSvnvTQU2Wfz+LzyF36whrl+zaFzA4a1yTzxIb0g8kFVPKuwVtbNe1
X-Gm-Gg: AR+sD12LMdPANAE9jJrN0K0G/tAUbCkMkXo4qqkrC3bKYKRQV8Zos8fgguKAimVLzg1
	brSExzMsAmx8lb6pw5t/hKe0pPGC5hqZ5rVMMwkBABiURBmTJ28iBlZqaFyx4kSBMzTmF7tmup4
	JYu/iX1UREEjWXtbn/4LJICcpNJJANac7kjbjbIm+T+jkkpF3TTOE0dkgD4S6VtnpFPx9UCDYm8
	6r0iycK1OlQjA8LouJOsMYGvp+Dh680sEV3Ss+IMj4Ue7x0C3/0PWbzNmRZMVbmeKR3Q+xbMMZI
	dqoES1oG2YuQvtkYvzc9xXTlADu+65PUQFua42obTu+cv0kP5Bdk5zJQVvHO31i3TDGK59UPCno
	BPIvv3ldTybkZz6lhc2Hh56nCnqA50t9InOjz7gyxyNEBHguCkBUwZkGcuY1Yz0Rw+KdIrUUcav
	koOUmi8eAxRW3DCiqAa1+136yEBV3+h0CcDMX3n9YQmx2Y24VF+c9zAvRqXxqDTA2/9osG1OWt5
	0ym0sh42f/399jV6SwOa6gYXPZF67cdcy+PIrjClFu9p4Cc2S2MU1rB6wdq+RmjCA==
X-Received: by 2002:a05:600c:8b4c:b0:493:bb6b:5bb5 with SMTP id 5b1f17b1804b1-4994e7c4de5mr282052215e9.13.1786108781343;
        Fri, 07 Aug 2026 06:19:41 -0700 (PDT)
Received: from 127.mynet ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4995427a244sm144125015e9.10.2026.08.07.06.19.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 06:19:40 -0700 (PDT)
From: Pavel Begunkov <asml.silence@gmail.com>
To: io-uring@vger.kernel.org
Cc: asml.silence@gmail.com,
	netdev@vger.kernel.org
Subject: [PATCH io_uring 00/16] zcrx update for-7.3
Date: Fri,  7 Aug 2026 14:19:18 +0100
Message-ID: <cover.1786108672.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

zcrx update for 7.3. Patch 1 fixes RQ processing over-throttling,
which shows up with larger page sizes. Patches 2-5 makes the RQ
use more scalable for multi-CPU setups, including softirq running
on a different CPU from CPU. Patches 9-16 implement dynamic area
provisioning.

Pavel Begunkov (16):
  io_uring/zcrx: scale refilling with large pages
  io_uring/zcrx: move RQ head/tail to separate cache lines
  io_uring/zcrx: add RQ iterator
  io_uring/zcrx: cache RQ tail
  io_uring/zcrx: coalesce same-niov RQEs on refill
  io_uring/zcrx: constify area_reg on import
  io_urint/zcrx: narrow var scope in io_zcrx_recv_skb()
  io_uring/zcrx: don't reload skb_shinfo
  io_uring/zcrx: add helper for deriving area token
  io_uring/zcrx: don't pass ifq_reg to area creation
  io_uring/zcrx: split dmabuf unmap and release
  io_uring/zcrx: unmap under netdev lock
  io_uring/zcrx: move freelist lock to struct zcrx
  io_uring/zcrx: keep array of areas
  io_uring/zcrx: lock area creation with pp_lock
  io_uring/zcrx: add dynamic area provisioning

 include/uapi/linux/io_uring/zcrx.h |   7 +
 io_uring/query.c                   |   2 +-
 io_uring/zcrx.c                    | 398 +++++++++++++++++++++--------
 io_uring/zcrx.h                    |  15 +-
 4 files changed, 305 insertions(+), 117 deletions(-)

-- 
2.54.0

