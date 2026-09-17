Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30BAA4E9C2D
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 20:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789677770; cv=none; b=cVwHDgANK/WzGX7FY213i26inVqhhWxJvt+3AAPXXUOPO5YEorYn4O7LLQSRXRuap5jG20emDJQk+TFuSt/zhRjnRQ9IyJNFeuOnwQ2yAT6TBb+8ATgkUljUGYU1MDgHvUBfPpB2t4mEMrYHCWUsAcwa+u8bg9SsrXNyDyBwIac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789677770; c=relaxed/simple;
	bh=f5YgqNXr7kQ+zmdldTupNAdXUjiDnZP/rTEI5lKEsBk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RTandvzriyDQ+q1tUDzAQw0LeKQXZ2I0uQ/p6pnaeP2OXofgoQnXfyGx2OKSicHC/cndMM412ryUvreCG2ulZ/y+hXGwFABrHrxwkToVhGdivr6hOWLasAQDdRVZOgBw0AmaDn4SBKtxGB/IgvsUyade7u/B9M4PNIUcziaQHBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qALufLHo; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qALufLHo"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-39b9184fa80so71867a91.2
        for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 13:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789677767; x=1790282567; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=bbre42kML9hxugGX/Iho8U4qBybcT1kk/x/wQqLaFXQ=;
        b=qALufLHowHXvnQjGrFNUPQfCwAQ06a+6HSC+pT6BN6XB7x3Z3L8QMH9qUf9CmUMknu
         los0a4vYHSCUZh+Xd5MaY0c4jy5derVzqYV14WusMUEcQrEnUKccoYWB80vWIld34uZ8
         W3PndQOJ32r1eAqeziizl2l7qth3XBUdiKoPChgtGpRF7D/6j9x0e403NN3+xbEwG0+i
         VZ6kPVPGDxFKtJCc6s29a5tBYbZWhWPFfTfCCsYghMpK9wbSkTAzEpgrpmzUlOxZk21Y
         A+WD3Gu9rmzd1L5GdDVhtp6J7wa6drPCi4cDnwB1d6SOsebJw2FH9bgMp36vWjZJWaVx
         STJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789677767; x=1790282567;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bbre42kML9hxugGX/Iho8U4qBybcT1kk/x/wQqLaFXQ=;
        b=nSQ2x0cIKaAlq7fr9qt3oiyNzOgoDfc40m79XGflXtMjHH4iKLe2M0+MtpMEssrkYE
         Fz/3DBX0Vxf9cm5uPdIcN1Jvz9eaeNHN16KJqvYc1GVBKapa94Vcz+ONgWSIQ4Ssf/KW
         FU0JvUxFK7XPf28A3qj1E5SMROMMMVXdk2ifgzDNBjcprdBZvyfD3xXdY/LWmPM58Nei
         pXCk3fdfuMUCKI6Cj88jkaCfGL+itxd09uikp9mxr3RTUlqEMhl5jwciq5harQ+Cx7Pd
         rl2vFAR/5lCoRoDWFtCdRDAhcjdd5hrJndX/gEabTfN73xIfG+2FcKPY0iLVLDMpmhti
         GaiQ==
X-Gm-Message-State: AFuF++nIolKbwFHwhR4Btpep5Lf1OTOGUJjWZ4PuURQKQfWKLBvuyqj3
	Nt5L1/U6QZTLuSfkLwS5PHDKq+CoWQD2wL9Iu6Eoq3mWEihLbd5nefoeJzRt2DW4
X-Gm-Gg: AYBFou35klh6oi4otUz3iW3m1A/kt5Oq7YdHHwaUlT1PNWvd8ds07VnQGemnpJQclr3
	uHcG9qFoOjz+9YH8ILbKrjFctItdE0TAwRTE5UtXt9PjelpEGQLe4m1bGpglH+7ysEICZLN6s8x
	RlSxQ25fYjPlmTsw/VH5A9eAqziWfq712m7IzGnJQsdoVk9MDloBjAILgfe1EXScxbTF7b8JZqv
	8uUnaU4azR/LwoNVBasxXFc/voxVzgXerghLvaJTMJ7pkp5wrptoP1cU3XM+5+GbRDJPvo760va
	yRELlGxr3A2ILNXLcZAA9YYWOhl3Ez7uqrbIBBbj1Jj8Fo49uZw37yvDaUlLWu9d56+jS5/9zNS
	qr90LFrAUTvXtTeD8fCVdwrX/vSd9Oeni18znmqr5V0aOMs14b3kvTjhSxfRqavP3OhFaVMIkVK
	hHp1HUQqNspZATvCToVgH2GxyK4JUK0+wQsCAv2jBlB5lCvx9uQfNK9XWsfHSrc8iqWSeDnYom8
	c2SD7fBubGOGQXqTiNFIeljnQRR06p6beRuuUAntVFWvKjSa30czsJMoz4s+BkgZdkCvq4qYV2w
	LuSN1XwKzA==
X-Received: by 2002:a17:90a:d005:b0:39d:ba21:fd90 with SMTP id 98e67ed59e1d1-39e54f2bf77mr1103411a91.16.1789677767395;
        Thu, 17 Sep 2026 13:42:47 -0700 (PDT)
Received: from Inspiron-14-5420.. ([2402:e280:21c6:671:6248:69c:ea81:be26])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33c1943f4bcsm3620046eec.21.2026.09.17.13.42.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 13:42:46 -0700 (PDT)
From: "Hemendra M. Naik" <hemendranaik@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	jiri@resnulli.us,
	jhs@mojatatu.com,
	shuah@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	vishy0777@gmail.com,
	tahiliani@nitk.edu.in,
	"Hemendra M. Naik" <hemendranaik@gmail.com>
Subject: [PATCH net-next v6 0/3] net/sched: sch_fq_pie: add per-flow class statistics
Date: Fri, 18 Sep 2026 02:12:22 +0530
Message-Id: <20260917204225.275251-1-hemendranaik@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

FQ-PIE runs an independent PIE controller per flow but exposes no
per-flow statistics. This series wires up fq_pie_class_ops to expose
per-flow AQM state (prob, delay, deficit, avg_dq_rate) via
'tc -s class show', following a similar pattern as FQ-CoDel.

This patch series is accompanied by a companion iproute2 patch series that
can be found at:
https://lore.kernel.org/netdev/20260902040221.83734-1-hemendranaik@gmail.com/

---
Changelog:

v6:
- Address Sashiko review comments:
  - Revert the fq_pie flows range to [1..65536]. 
  - Also drop the accompanying selftest 83be change.
  - Compute the per-flow delay with div_u64() on the full 64-bit
    nanosecond value.
  - Widen avg_dq_rate to u64 before scaling it by PSCHED_TICKS_PER_SEC.
  - Document the 36 to 64 byte xstats growth in the patch 1 commit message.
  - Fix selftest 83c0. The ping payload exceeded the TBF burst so no
    packet ever reached fq_pie, and the missing -W left the run waiting
    out ping's default timeout.

v5: https://lore.kernel.org/netdev/20260902035231.81866-1-hemendranaik@gmail.com/
- Addressed Sashiko review comments:
 - Omitted .tcf_block / .bind_tcf / .unbind_tcf from cl_ops (statistics
   only being exported; filter attach to fq_pie is now disabled).
 - Dropped empty tc_fq_pie_xqd_stats placeholder; class_stats is a direct
   struct member.
 - Limited flows to [1..65535] so per-flow class handles fit in a 16-bit
   TC minor.
 - Rewrote selftest 83c0 with TBF + fq_pie, ping traffic, and
   matchCount 1 on per-flow stats output.
 - Updated selftest 83be for the new flows limit.
 - Dropped the tools/include UAPI mirror changes from patch 3/3.

v4: https://lore.kernel.org/netdev/20260727164056.106203-1-hemendranaik@gmail.com/
- Fixed unaligned commit message; moved typo fixes to another patch.

v3: https://lore.kernel.org/netdev/20260630183702.170798-1-hemendranaik@gmail.com/
- No changes since v2.
- Resent after the previous submission was deferred due to the
  net-next tree closing during review.
- Updated corresponding iproute2 patch in response to review comments;
  kernel patches unchanged.

v2: https://lore.kernel.org/netdev/20260614125000.6058-1-hemendranaik@gmail.com/
- Addressed ABI backward compatibility issue for tc_fq_pie_xstats.

v1: https://lore.kernel.org/netdev/20260531125314.22492-1-hemendranaik@gmail.com/
- Initial submission

Hemendra M. Naik (3):
  net/sched: sch_fq_pie: add per-flow statistics via class ops
  selftests: tc-testing: add fq_pie per-flow class stats test
  net/sched: pie: correct tc_pie_xstats field documentation

 include/uapi/linux/pkt_sched.h                | 20 ++++-
 net/sched/sch_fq_pie.c                        | 86 ++++++++++++++++++-
 .../tc-testing/tc-tests/qdiscs/fq_pie.json    | 27 ++++++
 3 files changed, 130 insertions(+), 3 deletions(-)

-- 
2.34.1

