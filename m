Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11C67311C35
	for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 16:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785170484; cv=none; b=V5xq0JDQoKSH1FHo23/XpD+TssMnVZvYqlI5FDVN20c7ej+EPq/lMnEQVmRKqecpXrxZzduBikFV/M1CZcHXL0tuSdRCdjIGuL+EYYtNvXOAm0+KNUgSAcMbxsYVWJjMdP71YuBKZco9uyK+RpQmYmpF6iIurz11B24GDhlW7GY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785170484; c=relaxed/simple;
	bh=vp7w8YsoF0pZgEq2PM2CYLvSQSsrkXdmwudp69HLuak=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=eVwjNIaPjjMssCGABsK0FxkxFO6j8bht6y1+BayMJZT1etL7q3iFqnjIyiSTr+7eB/ZBv+b/pT5AM5JGGlIfuArcPmqQ1uaKE2A+4vwld7aeioJZmFQCdMFxvXdR1IuroE38C9fpw1hqnzdguIxyupMay8mLVaeqn41LsTJ6lH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TCkW8lqn; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TCkW8lqn"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-38dcbade417so3110456a91.1
        for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 09:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785170481; x=1785775281; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=wAMIqKsMECjuh866za4d81qNl0b4qOpAK+fZ7nIiqyA=;
        b=TCkW8lqnONIyFNU6LoHRRKkAGNEGzLX1DIoGX1iBBI/LCnJOV+jvgwyFVZ8nzblva5
         C8c9nOlrdkuXF82mmGcig54ynCwoIauhxfoJfT5qrkyPHTkuV5BuMzRQ2NN3Hlv6ZSdu
         RAHBGUwymoXDtR294wI39srI5U5MtfnIQPH+ZhPKeOosPuZqJLAmRbptiaLnwPCR3HUB
         ti4GzQJGJnCkI3+NIDYpKWH61H2402XFZ2fWM3GUujE6aT0FXatp67Cd1gAbLDda4hkN
         T4pV7a8OBmd1nVpwebekx39p0ZeDImBmrgTBYnY7QcBVWzdFqNvkumhyKzmnm3KkD07i
         dtLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785170481; x=1785775281;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wAMIqKsMECjuh866za4d81qNl0b4qOpAK+fZ7nIiqyA=;
        b=FNQV765LbdJV6PUGDISKg0nEhyLziCjy4egmVIdpvAY8ehmhgfGjKAA+aDlqS0Vrc4
         TyCgR8vsiK6lxIFQ01zgK2M3vUeZgbaPamzz9rB4oz9RLk0rA1X4dedlO/7PAVfoD742
         3+Z+S+cjHPbMl8Juldhuz0T6EhBqEOVWAvmcdPgtRFwQWWmmxqIZhJ+1uPA++NjH14ap
         qk/fzMceZNKBwhuUNCtJ/lSnKfwklWnketHjqIR0wuYQOxklhoEDMOM2wRnO7iAOXKBi
         5XLd7ThCApRqr/ExNqAfRyEUg2355WhYowAHFusKlqYEwLE7tsfW0OyCPGJAbN4wBg/v
         fgOg==
X-Gm-Message-State: AOJu0YwAsaN3ZfJxwxZTWzfZmSQ8c0S5opoZ8Dhfepbu4SS46tpI5ilY
	SMn5Py8FC+Vv3aQsjpayw3K8bEv1uBeRCdyaZ5Stud1IvP2Vvm2SXkqkmXYHahFk
X-Gm-Gg: AR+sD11hUkqfmV2oscHRmDFgNaNRyYeO+mAFAqcLQ3aCe67ANXac/1e9p46puQYUXDi
	Dei5daVFUlNUgUmwd0zKuGsh66saOJz0kv2g8273gvOpP5LDD1qwAh8JXj28zSAStbnoslTpIjl
	yLUSBuqCqfEkj8m5HsgCW2Qpon5oaXHuauY74AhI+fuNsIQlrFisJ46le1B2KJP8eqI0P75OWl6
	cJ4/TgWr1Tuq2fbDLeerzTadI2Se1ywp88jsQZEaiKWamUMrKCU7Uciqcd/YE6mFewZN8J5qPPK
	7b7rITOIP7fQ8RRhq6GLiOxNPTfL3Isu/qn1HQR/TkG0LfM7Mksj7JKcoCAvpA12jHnkBORMpq/
	mqQbEl04BkGquxzEa3W7KtFwJmYmUFnNpUDm4NBpEl917w0KgOejwdIQtKY+pFUG9USpcEnOOdp
	5CBDl8VDXkLTsmXWlt7RwuBoVv4puWgArJA9fdN7zR5U+ALsbcYq+jltc+vrgQf6CX7S01jzPBy
	DxSgDQ=
X-Received: by 2002:a05:6a20:244b:b0:3b4:669c:ee32 with SMTP id adf61e73a8af0-3c6c7fe54f4mr290098637.37.1785170481199;
        Mon, 27 Jul 2026 09:41:21 -0700 (PDT)
Received: from Inspiron-14-5420.. ([2402:e280:21c6:671:8b84:a60e:2cad:e760])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-314bc59cfb4sm33227566eec.26.2026.07.27.09.41.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 09:41:20 -0700 (PDT)
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
Subject: [PATCH net-next v4 0/3] net/sched: sch_fq_pie: add per-flow class statistics
Date: Mon, 27 Jul 2026 22:10:53 +0530
Message-Id: <20260727164056.106203-1-hemendranaik@gmail.com>
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
per-flow AQM state (prob, delay, deficit, avg_dq_rate)
via 'tc -s class show', following a similar pattern as FQ-CoDel.
---
Changelog:

v4:
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

 include/uapi/linux/pkt_sched.h                |  29 ++++-
 net/sched/sch_fq_pie.c                        | 109 +++++++++++++++++-
 tools/include/uapi/linux/pkt_sched.h          |   4 +-
 .../tc-testing/tc-tests/qdiscs/fq_pie.json    |  22 ++++
 4 files changed, 159 insertions(+), 5 deletions(-)

--
2.34.1

