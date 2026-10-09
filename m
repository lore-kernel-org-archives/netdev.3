Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B0044DD3A2
	for <netdev@vger.kernel.org>; Fri,  9 Oct 2026 12:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791549201; cv=none; b=BG2E0tJF1mxtiMPaDzKuJiIxUrXXaDHtv/7U1Yy97vrqE5OPc2T0I2FVXTcg17DgGooK+XpL2Lj2lSx2l6UPMVzJRoM1s1YGOdL1CeLa9rfN/njhfN5IkMQeAfvbjcoDMyjhevTsQTyONgy8gAGIqbLVu71AH/KdUxJFNDS3PXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791549201; c=relaxed/simple;
	bh=jbamgwQfLb+hH9hvkawjSzHeaoByt48REmiE5+CdFxc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ARLoCvzxuqTz+1KJEUqoCKJHbpNsW8FGJWy7vrswpVKO7EdjDvBkMIT2E1wCQhkGhqQHrFP4yrir6zsuphINGuz0fMdHWuDHiFnAbLe+HE/ky2k/cVJRtxYGr9MqA4/adbq6cQLWMrpTfJAOncGASoS8tINOqK/DvjqQw4NPkw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KUNi72O1; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KUNi72O1"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-487048857f6so3630653f8f.3
        for <netdev@vger.kernel.org>; Fri, 09 Oct 2026 05:33:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791549194; x=1792153994; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=SErRyHSFpCUt5Avm8F9PG91ICpNkYudvdNEVEjAozzI=;
        b=KUNi72O1uN4teyOpBOELyWyV7WGJ3oMXZIw3b+An55hAVy8ytl6lMYk5ry1l5GFbCg
         3ASTb9S2xVQZrcsi/99rDrVZGcGAoTCe+8gxL1lIQEuP+s6VTHzApTxAAX92TUi9wg5B
         qWI5hxWIGeELEBKJEn6KRA6e1HtuqH/kmsfhu+UkGcKmaAOZOzoiJOjcSalX+7SoHhaM
         DhAmnCVsrv3fENXrQo/mAGC2mp/1zidQPjxKtcWd23nADW9fW+VRKd2s0n+chB+mkf3a
         Z4BePbrP/FdDWY0JynSTgS8rAjio6ihyYoDVCvrooeaaEFjZ5aIHJb7deCGcoVhvAdRN
         twpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791549194; x=1792153994;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SErRyHSFpCUt5Avm8F9PG91ICpNkYudvdNEVEjAozzI=;
        b=IW3OJbXBV0bK3u7RDN4iLi5np+YHBe1bKNjdNwkM/6v/4Ey4l/bm682q2abpXKKL4K
         U6o7b1jxI0ZrZzB5B/xerSfxsDD/SvvJFz0deXfIt+dmftkyWfooLxBMD72Iace4Lo6B
         YCJ7GrlhNtIEyxqetV47R8gaVAUi/AOVhV7zvUE0+GVz7fqUQpdpkVZyW4K819UbPwen
         YdFuZl26l7R7q7DtbblO81w96NxptEYxnmuiHkulQFVRa6/8BEJ6m1PVtH1Vq91tJMw4
         czqCkx0qB5LSu3AG9Xzltzf5h//T16Qh8K4+DUCV5GLCnxr4M4TY53XjjHGdVnTkxs7p
         zxVw==
X-Forwarded-Encrypted: i=1; AKwUvBx3Mx3C4aAHPZFhcE1Yu/cdeTfF8y7HkdaveEfEIfgpL712iU6plxqNGVL63XdCU8lMpgH634I=@vger.kernel.org
X-Gm-Message-State: AFq9FYKEpzhd/98YMGAETJFyjqiysx3l1yxdWss+xiUp+b+EVrGhopG1
	9lqxBCaaOM/mnw+nJtdMz/IqlTbZQkt1c5Y2oIMVDJrq4wJHK+Nh1ZMIGo1bWxBrGw1KOA==
X-Gm-Gg: AYBFou2dSbJYXHThTxt3MGPo3tS2Z5nhqvQFKkAH/6/S2XdhLhzRvV81/4HYXzX+YLn
	yDoNLy3smB60usRt/W3LxnA2uUcteJXaDdUsd2Iu2kK9P2wa2X6U8VCmKFp9jYTv7xk4aG50o5O
	vgEL6tHIzJBMGRA8aPCeV8Fnp4xXEY4UzP4l5Ni2MLATzm99emefZrJCdB6kFKubFVma0EMYtIH
	zsBqNLR+BJVLQ5lcvTCHsyN/IAO/4LuZtePuQ1q0kulrRjnr1VDK8kF0AkctdU5essxXIEvacL5
	IZEpqy2V+p8SPnYFxt8zR8G+gAFIQAAAKIXSWoPgD2bLNaH3ROJw6uT5SZyRsq/iBY4H390s5uu
	n5+ApKuniUqda6/CiQnAEJmpFpFYCppoDH7DsUdDHspRdbLvDbQWsASYkTzheq0jUc2P8/qeLZ1
	qUzl3FTJyZCy6bvF0p5AOoZPNBzHDwH0JNM15vS5kpdGPC8eodSiQjx/GMWNLq6C8g8lyCJ/9No
	3Wc7bD580jXN6r5VhC6Zb8d2bm30GMgnKORmb7aFavhR4HVDBYX56F1wgOv8fGZy71h3WI2NGSt
	doq34i/nzu/nJOuU0JsbxOwpDgbN2QPKt/XNX162PHC1g/RIl9qa1aqP/SXHrbLkAYSzYphimrE
	QlOLwlnU8F36dhvORNAQ=
X-Received: by 2002:a05:6000:2907:b0:48d:c18b:d644 with SMTP id ffacd0b85a97d-48dc18bd66dmr152416f8f.26.1791549193843;
        Fri, 09 Oct 2026 05:33:13 -0700 (PDT)
Received: from Ubuntu (87-205-15-91.static.ip.netia.com.pl. [87.205.15.91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48db9acee65sm3650230f8f.49.2026.10.09.05.33.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 05:33:13 -0700 (PDT)
From: Krystian Kaniewski <krystianmkaniewski@gmail.com>
To: Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v2 0/2] net/sched: taprio: fix RCU stall from replayed schedule entries
Date: Fri,  9 Oct 2026 14:33:07 +0200
Message-ID: <20261009123309.284193-1-krystianmkaniewski@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

syzbot reported an RCU stall with a software taprio schedule made of a
single 127 ns entry. When advance_sched() falls behind, it replays every
missed entry inside the timer interrupt and the backlog only grows.
Patch 2 makes it continue from the entry in progress instead.

Patch 2 then checks for an admin schedule handover once after catching
up. That requires the cycle_time_extension comparison to be monotonic,
so the sum now saturates instead of wrapping. As a result a large
extension can hand over to an admin schedule whose start time leaves no
room for the timestamps derived from it. Initializing such a schedule
already overflows today, and a carefully chosen extension can already
reach it. Patch 1 rejects these schedules at configuration time and
comes first, so the series never hands over to one.

v2:
 - patch 2: do not use the list iterator after the loop in
   taprio_entry_at(). The helper returns the entry through a separate
   pointer that is set inside the loop (Jakub)
 - patch 2: wrap the lines longer than 80 columns
 - patch 1: no change
v1: https://lore.kernel.org/all/20261006113335.241564-1-krystianmkaniewski@gmail.com/

Krystian Kaniewski (2):
  net/sched: taprio: reject software schedules that overflow their
    timestamps
  net/sched: taprio: do not replay missed entries in advance_sched()

 net/sched/sch_taprio.c | 179 ++++++++++++++++++++++++++++++++++++-----
 1 file changed, 157 insertions(+), 22 deletions(-)


base-commit: af39eb111ce6b5eba9c08513b62c4868eb7e7fd5
-- 
2.53.0

