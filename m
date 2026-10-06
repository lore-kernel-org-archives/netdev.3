Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 015123542D4
	for <netdev@vger.kernel.org>; Tue,  6 Oct 2026 11:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791286427; cv=none; b=q2kdMzmOlnmzY3tnr/Ga9l3NtHj0RinJyt+glF+Xd9VkXCdN7OAMFqEqWQDZ5mdgxq+kZFXIg61mSoCXF5HxXQ1HAg50Ztn5kCAo1zpRJQvxgW+v7y/tlw8qEXTYvxVo0ACQUIP5O/tr/BXsX5cww9XwJiWb501woNLTXDooyPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791286427; c=relaxed/simple;
	bh=rbvt+tFZXxO5cFLINWgZ71k4YVwvsng5rl3cw2NGZ6w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tHeS3aY9lY1mcqZW+3M7R01wCND3tu3kcFmc5uGUSWGH8CCAjrLuBJyZ6N2HActuKLmvWJtyfDqH8kafDoAVPrPskgQdphzc4g8CZb4w3MPEMijR8bp/8BEN+0JT3HieSKygTpx+TFlM+XOn278BpVtF/juSz75S9yXtji0rQyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ou9jdrN5; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ou9jdrN5"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6a9a20a5e72so653552a12.0
        for <netdev@vger.kernel.org>; Tue, 06 Oct 2026 04:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791286424; x=1791891224; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=kcAdRzVf/u8zZAu+qB0ABmtM1m8Lw721MraQWUZf5XE=;
        b=ou9jdrN5E8suovejcv4mQx+crgmUN3BqXNrUiyYEK/04W/n7XeADOkHb03lSrOWrrr
         /4I770nVYiV1cuCd9t1Y7p3uRLtVTniUCS8y2Wu3+GSR868Xho1wjFxsVojn8lemrcdL
         uHw6ZHyRUQ+idtG6QnyBGbFjye1FLn7+BT3ED1u+bNjBzhtZf5iuU030HoAjf5wF1CUp
         KIGTD2wk5HWPUPFbJnQcpif2/9HfiCjqcmKfmAUvZ/zrq4tJ3A2VdnqdlTFx/AzcQ/KT
         Dw2VVb7KugaeYRO7DBBiY9Usx8higPnoIBmTS6uww1lFYSMGvTVG98sVUmVGomg0czh6
         iFuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791286424; x=1791891224;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kcAdRzVf/u8zZAu+qB0ABmtM1m8Lw721MraQWUZf5XE=;
        b=FeJs4vwwHS+pwk7SbFzl63dzDx4myPBgspp5VqHM1Lczgi0CMWuw72RaM743NmutA4
         6mZqws1kOzRZ320fekxMLZrUiuSGeAiN02k3rgGzetcl6SW43JzjRVAngDYGVfGKN+//
         RDCwxAlSWZnbS1ZERk/d3naur62DQConkdUyWyQ/DEVeoO12dI+h3JUBkFxQz5ja5S84
         6T0CFV2zCgYoyOYyEt+3ASSPaTGxHvdojTXu9tsn+MhFbGnsN7TLTOy1U0Wmn7aMEVRt
         mAbD3u4RD5FVFz2mcaAjRpOr99gLLmh2A5JaI369VggxqKuhcHt3AbqbralbTBiVfPUH
         W7cw==
X-Forwarded-Encrypted: i=1; AKwUvByVSRw/H3ZawQEWs/C9PAcwne++uM6SSEb1GCyTw+TDuIcewWvGlZYwOAfZOqJ47jGE89+V3Og=@vger.kernel.org
X-Gm-Message-State: AFq9FYJnmewdXELFqjVAAsMlwPafaown75OYew5uPe6ek5nFR/8Uz1uV
	x7DZsWMKeS7oCiRle12qFG19C5bGgi1X4MUhMeMGrLQ2YQYbgMsRbPr3
X-Gm-Gg: AYBFou0U/ATERScaRk1qP4+83z2UPNhYsZ9K8vk7Z342tdGpU3LwhUhewP8nijrR1Ft
	Qsk26Y26Ed+4UGSwcqpOm0voP50Mf1UG57ZvS/DjYw7EuNc6/M7a+4DK4AzuijKFMVxpOLoptLE
	GPhrcruPMwz+szxR/U8426JaONtULUK5EiasdW2wfOg/i8aR3HsEiUQMoRvLnvIAePo9PvP0grk
	7uiwIYkAsWamLHkST5tyGLPNqy3FlRZ02wDWUbm7Om/SYiRIE8Ctudzrz9xTQDFb/FWePaoant9
	EnDt2d81xZHmQibDCiCD9QB3WwA/Jbjcm2HCmzyMLLvukV7MPMw/NISrmrCwHqDB/zUDO5tvQJf
	ZDH1rdYt86sgguyVoHQREvKaRZnMYkYL3H2gp7IQ+djKWgbouYVsMHvvdKli/FgjDKzJB1AEZPt
	TTr17Y4x3coM4l9n06GyDFHi0RLCpeDujbW8Hc93LFUAcz1gYVK+XEhJRqNnu0nfFuw9atbkORd
	eZBLCFtpN67ck2toLJGO0Y+7bbYKgC3hFM8RKRheUZYK0LzFbv7KNGEmJnwV+AzcWpe/K3YHdlT
	zzkVdFuEhzFCe3AB4AwAKaHngtDElK56oafvcjARZH+lRRNB74x8EvLSXjA+MxkmOQSLBrGR+D1
	6vIBaiAzNP7DpGIFSkCduRtphdYfB
X-Received: by 2002:a05:6402:4512:b0:6ac:8b71:fd91 with SMTP id 4fb4d7f45d1cf-6afe2959a75mr1292168a12.3.1791286423860;
        Tue, 06 Oct 2026 04:33:43 -0700 (PDT)
Received: from Ubuntu.ts.net (87-205-15-91.static.ip.netia.com.pl. [87.205.15.91])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6afb01e5937sm4465468a12.11.2026.10.06.04.33.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 04:33:43 -0700 (PDT)
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
Subject: [PATCH net 0/2] net/sched: taprio: fix RCU stall from replayed schedule entries
Date: Tue,  6 Oct 2026 13:33:33 +0200
Message-ID: <20261006113335.241564-1-krystianmkaniewski@gmail.com>
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

Krystian Kaniewski (2):
  net/sched: taprio: reject software schedules that overflow their
    timestamps
  net/sched: taprio: do not replay missed entries in advance_sched()

 net/sched/sch_taprio.c | 171 +++++++++++++++++++++++++++++++++++------
 1 file changed, 149 insertions(+), 22 deletions(-)


base-commit: af39eb111ce6b5eba9c08513b62c4868eb7e7fd5
-- 
2.53.0

