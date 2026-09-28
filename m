Received: from mail-dy2-f41.google.com (mail-dy2-f41.google.com [74.125.229.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E09C73264C7
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 04:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790570436; cv=none; b=TnWdaE4CBdEfwGDbGg3FNwLAuL26WwvNuw65jeXSxxbyHcAZ22pG3LQkKjKVnyNR/vYvmPGkNIIPtoK+5ouNwszpZessj8kr5dJQyu3HJTFmdRJ3zHAjjVTfoQd0/O1uXiZqInGfr2gnTtRwqfz56BE4nrCFOzWvYf5a2b08ti8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790570436; c=relaxed/simple;
	bh=zbsvhiknsGv/yVI5HlChpDJSSfdHgfhWUJugR17lOMg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rVP5TZuc8OiB13aPeKpa/cwk8JOM1ni++YaamRjVeGwmwhKalq8GJcg54cT905jO1dbcoDlu05ncyuTT7Yevx8UGLaILBEKTrwXjvOSJcSnkd8azdQwp+QvZk9AtOuu8xfnSLxg8VIGucRx5yHvFAy/Hm59SL1vdy7qk8dN1H2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m31mdnBk; arc=none smtp.client-ip=74.125.229.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m31mdnBk"
Received: by mail-dy2-f41.google.com with SMTP id 5a478bee46e88-3468ec308beso491806eec.1
        for <netdev@vger.kernel.org>; Sun, 27 Sep 2026 21:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790570433; x=1791175233; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=cHs28b6kJcOzKhHAfsJJINiI7XAAGD9v2DTI8Qtx2F8=;
        b=m31mdnBkwLFtxLk8wz3X0ynZt+kdoLNAwkv/oL00WY21tb9ZK7fa6EWaBFgyJsoGgY
         r4NIP671CJryo0K1vTOhQt7/Anaxh1UeCPoynxoFHTFEHdsK2RoHki+4RWZ8qvEcmh9L
         x22nkIXU84fVgMKUubZADuAJbzlGrhJV1WXTlAMJ47VTN0s73RjII8UlF0mDWSRpkhQ8
         cP+uoHYpSMl2u5eweZQSQgjeXatNT6YwDO3sYOu4250XjMGYsg6Y/Mn2/jWtit0aBojM
         43A1dbkqR+YNYxVE366BVG8aJ2qTi0dh681ues2Cwe9JN6vAf11rdVp5g+tzyJhejZLj
         nzOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790570433; x=1791175233;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cHs28b6kJcOzKhHAfsJJINiI7XAAGD9v2DTI8Qtx2F8=;
        b=pazDbm9PWuNYdt/WBl8FbLuVWJE8BIRL79TxdeRs9AuZnLuxglmXuZiBObIuFR6SEB
         wzRlOCbnGi0ivtk3nk53jbdYpmbkWdeD6hV+qDe3BKnX0YJ5OiZ1/otoCtgML37cMOjo
         oy94tH5/JTLomqzz51mb3hPvT5aPKB9CukamyPA9W/dkdKeVGfd9N+RM5ANpSDpTHHFN
         Zx7SxnkOUU4R1apyIFKqcjQ4bP9plrWJFNg7nQy4iiGhOuNMN/uxEFWSoc8uQYwnhSVB
         l808L8diO29zcDVICckE78AuATGJRIofQ1owH4301OR4CdQ7DQ8DvHUr8Q2I/Ehx2U5D
         Jipg==
X-Gm-Message-State: AFuF++lKr7lNABYN7J15p8WUOO0PQDOLk/bwORgwgdVeRATP/BSfqM88
	nmWvd4rz8YCUXqBDbHEXwkIX3Tr+rtGuExemlyYKPOHjGjK422qWCmTUvo01lGEg
X-Gm-Gg: AYBFou03nwyeAyhjnbKv/bURpU8E5w+QLukfoOnfBqjARht47ANpkEC6ts+ujCpFu7s
	8xaBNPZH2gk7TQvzvAxJiBYCxwtXstnjC1eXovd421UrmEsJOc8YesB0LTCsqD+LnqU4v7cumZy
	3H70cO7MuFCha5RGAkbWVCHS7dAzMxUyo2EQNWT2N6TIXOT93l/5ZGYro9mYBSCFl3fCp3oeIMt
	TE2fg5EXSHhrB2J75ICJrtoZQY6wA33pedsX8EncXmKOs8RnY/Rk/IQ2vFPnpm6TE8LwnCEHrwg
	I1UTJhY6EssvInWx2yrEiFJzh7o0XXRzDCW7z36gH0pV5ervuJM0/6QDMBjmD1obHxDowLjPWaN
	Zfh1EOWce+26JPoMhC6UqyLUgdp1notrfAf8xnrC4YEj5VIQ6mHt/iXiDqMUE4wcupkr7ibxL9T
	lF7ByjDNa/hVg5Yzw0jS8SD+Yl8SMb0LTwEcVS/fLtwoerwAmNw25FAOuoJ6an/STHDqbLY+dwa
	rFZ5Dj0ire8ZVQ7Ec+sZyD0nPNpafEPT9Bvlk3CbU3FIW0H0XwC4sbKhh79RLg1z7pr7YcI
X-Received: by 2002:a05:7301:4d0b:b0:341:4f3:8f84 with SMTP id 5a478bee46e88-342707b3fb2mr7984301eec.13.1790570431947;
        Sun, 27 Sep 2026 21:40:31 -0700 (PDT)
Received: from Inspiron-14-5420.. ([2402:e280:21c6:671:571a:2a:d409:bce3])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34144f4eb9esm24529067eec.19.2026.09.27.21.40.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 21:40:31 -0700 (PDT)
From: "Hemendra M. Naik" <hemendranaik@gmail.com>
To: netdev@vger.kernel.org
Cc: jiri@resnulli.us,
	jhs@mojatatu.com,
	linux-kernel@vger.kernel.org,
	vishy0777@gmail.com,
	tahiliani@nitk.edu.in,
	"Hemendra M. Naik" <hemendranaik@gmail.com>
Subject: [PATCH iproute2-next v8 0/2] tc: fq_pie: add per-flow class statistics support
Date: Mon, 28 Sep 2026 10:10:18 +0530
Message-Id: <20260928044020.8304-1-hemendranaik@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

FQ-PIE exposes no per-flow AQM state in userspace today. This series
adds tc support for printing per-flow statistics via
'tc -s class show', matching the kernel fq_pie class ops series.

The corresponding kernel series can be viewed here:
https://lore.kernel.org/netdev/20260928043358.6866-1-hemendranaik@gmail.com/

Both the kernel and iproute2 patches can also be found in GitHub:
- https://github.com/H-N41K/linux-net-next/tree/fq_pie_class_stats/
- https://github.com/H-N41K/iproute2-next/tree/fq_pie_class_stats/
---
Changelog:

v8:
- No code changes since v7.
- Rebased and reposted patch since corresponding kernel series was reposted.

v7: https://lore.kernel.org/all/20260922211139.38570-1-hemendranaik@gmail.com/
- Removed UAPI header changes. The series now contains 2 commits.

v6: https://lore.kernel.org/netdev/20260919061254.39678-1-hemendranaik@gmail.com/
- No code changes since v5.
- Rebased over the latest iproute2-next tree and re-submitted patch.

v5: https://lore.kernel.org/netdev/20260902040221.83734-1-hemendranaik@gmail.com/
- Addressed Sashiko review comments (folded into patch 1/3):
 - Dropped empty tc_fq_pie_xqd_stats placeholder; class_stats is now a direct
   struct member in the UAPI header.

v4: https://lore.kernel.org/netdev/20260727165028.106817-1-hemendranaik@gmail.com/
- Split into 3 patches: fq_pie class stats, pie avg_dq_rate
  formatting, and tc_pie_xstats comment fixes.

v3: https://lore.kernel.org/netdev/20260630184453.171410-1-hemendranaik@gmail.com/
- Moved print_nl() into each xstats type block to preserve output
  formatting.

v2: https://lore.kernel.org/netdev/20260614130729.10076-1-hemendranaik@gmail.com/
- Addressed ABI backward compatibility issue.

v1: https://lore.kernel.org/netdev/20260531131411.28213-1-hemendranaik@gmail.com/
- Initial submission

Hemendra M. Naik (2):
  tc: fq_pie: add support for printing per-flow PIE statistics
  tc: pie: print avg_dq_rate in human-readable format

 man/man8/tc-fq_pie.8 | 18 ++++++++++++++
 man/man8/tc-pie.8    |  2 +-
 tc/q_fq_pie.c        | 59 ++++++++++++++++++++++++++++++--------------
 tc/q_pie.c           |  4 +--
 4 files changed, 61 insertions(+), 22 deletions(-)

-- 
2.34.1

