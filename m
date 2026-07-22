Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37E4E353A83
	for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 13:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784727755; cv=none; b=d8gC0I5CRTCrXVrVhpOu6akUu3KvqK9t7iO7mY/5O7wOgaSeg9+p0/3DHtYZo16JiSRG4WBahb2c0rWqBmsLtxvf/98bUEb5vtxGj3WK6LWbtaaI2DwdBf/rcN0bmlfkq6LlH7lVGAMcrmHoRChNSWafJeaTIh7pNMsUL5qLU7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784727755; c=relaxed/simple;
	bh=qWnVCFHEIQQwVG8uhmXw/dvzIi9AupAXMmD833qTb6E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=E1A09kkEZ/OZ5t8apFmUaJm7vZt2qkd0O/WepW+IJzvte7bB7JmPcCQwkTKBLPZCHQmo59SyLMud94nADxUIZXFFMGISuSWQeMd2owtR0droE4C8Y5v/MkQg4E1PtnoTFTYLM5/9z7F2vkE7Objucfo8F7k3/LosGwwuFIF6zFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=r6LYFZ24; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r6LYFZ24"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-490cf322ed0so91988805e9.1
        for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 06:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784727751; x=1785332551; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=keVf3FgJZB5UJkfkXGyU1cYZXcGd56IkuhMm4F3AyS0=;
        b=r6LYFZ24qifmW5LZicUI3qSTOTteSWQAke3ZqLwiI2RHT5Fqk+iIN1jxBXfVl7S1BN
         YVUllGnEKrRsexnkRBU4bEgPXd8/Uo4TrYfzwEle8YHjdhtdQyTOJvswuHWAJ/hpoair
         QVFREXAwqllowMEiayxUHn5963O8dxUYQusVjNUxiOXtilwJhcyreBwUUyKAwoEkQb/P
         xZP2QtfKCJKruF2gJX1rTScHkyPlzKx1EBVx/6GKyiLL+oEQkqPg073gEBOx0anDrhyu
         Qj2jSAHriKOkPJusCeBinNKpIt4Iw3CstfKctDS4kmZ0hcVYJw6CN+7bglW8yA4Pxf/C
         +ilQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784727751; x=1785332551;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=keVf3FgJZB5UJkfkXGyU1cYZXcGd56IkuhMm4F3AyS0=;
        b=b9mUs2Dv7SoJFK9m0cYvOySBh//n7PGCvCSxT6paNt4yHD6gATbWny1wpNKV5ocwU/
         3eV8yF+OKQVBYl0DQaSz7oGE7KowAEON++M+JpMsQ24UmFHu02PCoqUViVP3rcZbku6/
         J8kv6HyMim7ZiA46nxfF81jO4I8lxZlGHAP9jS8jtLXVBB1C3pxkhmH/3AO25MKyOhj0
         GV/nXFJJDthLuOxYyi0A2GPN9GJQXFl4r/bsghv0R47yTLR8HpWQxRCZgdLbCxxIgzV+
         g6BIu8FworyXtlaSG/i3iCN3xNUBK90sD/ZgvNZzIHWUgH53C+aF26JfrHmpcs8uhQCS
         n1Ew==
X-Forwarded-Encrypted: i=1; AHgh+RplCwiGI1lmBjV8gW/hTRi9lPo4NYiop9+rLn1xmq1GWVu8mjPRUJSjYQfTNTmxfDYvw3LRaHc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjRy181T/+zPex+MHhmtDzFiO9A0QifmaP6THv79W9inOHX682
	mWYYTfhDg09MesA1/6otS9ZWbmLDyit+5ps9M1zxDcXYHn2wXy5P7bfo
X-Gm-Gg: AR+sD12JoDAn6eq5+0q8NWtIkR9MG+qJElD2g+TO6bYek0o+A2zBx7LV1JlbvPK8IUb
	KEPHzggYerBoQR4JveZ2ZIJ/2+YpdtwdGlT+29ogfmBxY2J23lXOReMpEer31FEuCTKT7WpDBrq
	CJhvkoUQMMRGAkSovVbxJfQLgihtKsF/0Wq/SQ086brTeocLKb4qSlpQ0f7JAIHEpfKITfWSTFG
	YFuCgAhzQURwWOxWZEilKoS15CGfsFpCHHoC6W2zYSzKCULxhYq7ODPAwkUOnyV2vNvcZiI/pCd
	w+gvi/674/P8SnGtTeBTf3Rnw1OLitlbfB9quX8K7j+kBGJkbqVJhNG0iuaYG6Iat02Cb9Cd+Mm
	7JidNFwXZtdfub1zSk6siqrHwlR9+lT986AwyTRZd+Pr8VLPXL26V5PkGmR44/QERCmhhy3Is+d
	xV8/HVyqBNjkhoEpVWrAlCjRbbDW/a/5bpeH7i86/CLKK8XieC1+Trx/gVkJM=
X-Received: by 2002:a05:600c:b90:b0:495:6f6b:fb75 with SMTP id 5b1f17b1804b1-4956f6bfb8dmr17230625e9.38.1784727751353;
        Wed, 22 Jul 2026 06:42:31 -0700 (PDT)
Received: from 127.net ([2620:10d:c092:600::1:c15])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4956a63fb10sm73403015e9.13.2026.07.22.06.42.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 06:42:30 -0700 (PDT)
From: Pavel Begunkov <asml.silence@gmail.com>
To: io-uring@vger.kernel.org
Cc: asml.silence@gmail.com,
	netdev@vger.kernel.org,
	=?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@meta.com>
Subject: [PATCH io_uring-7.2 0/3] fix up zcrx "notification" uapi naming
Date: Wed, 22 Jul 2026 14:42:14 +0100
Message-ID: <cover.1784726895.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is a degree of inconsistency, nuisance and ambiguity in the naming
of the zcrx "notification" API. Rename it to "events" and do other small
adjustments while it's not released yet. The patch set only does
renaming, there is no functional or ABI changes.

Pavel Begunkov (3):
  io_uring/zcrx: drop "notif" from stats struct names
  io_uring/zcrx: rename ZCRX_NOTIF_NO_BUFFERS
  io_uring/zcrx: rename notif to event

 include/uapi/linux/io_uring/query.h | 14 ++++++------
 include/uapi/linux/io_uring/zcrx.h  | 32 +++++++++++++--------------
 io_uring/query.c                    | 12 +++++-----
 io_uring/zcrx.c                     | 34 ++++++++++++++---------------
 io_uring/zcrx.h                     |  7 +++---
 5 files changed, 50 insertions(+), 49 deletions(-)

-- 
2.54.0

