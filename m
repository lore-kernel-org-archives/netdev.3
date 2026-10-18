Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 303B147FAF4
	for <netdev@vger.kernel.org>; Sun, 18 Oct 2026 11:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792323028; cv=none; b=juwq8PZBhEeCdqnD3qi1r9IaJgYzoTxgH8SS40Uo9icLtfzRoOJP4qiOhHt2EW+A9qBaDj1ZfnHVjBBr0+UqcGsnmEW3YBsmHYFwLkDtm/vtoib7sSLAWirGQetQqWH62Ujz6K4iIsbEspD/eYy0rFZnI2Sbs7YeNQKcD+UXsOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792323028; c=relaxed/simple;
	bh=X6gzrwrZSwvb6nhYFxp6vBs7zjV097PxDw1Oj/IM9k8=;
	h=Message-ID:Date:From:To:Cc:Subject:In-Reply-To:References; b=m5CoEVgmyJ9MIoXzA6VIBoTNqWZBff8PjjlvGK6tR9lU4QKp7pTxUBNykWCYicEN7eFukaTFycZZZozKkywNhsC3UZi8raY34yPKxU6yS82uyBkb9uQplmxBlPBeRo7Q2yZkgqIhNd4GVmrb9gmqxGJsiZVVUpuwNbLBYgaaaTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UNgO7trm; arc=none smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UNgO7trm"
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-33bb5afa736so142673eec.1
        for <netdev@vger.kernel.org>; Sun, 18 Oct 2026 04:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792323026; x=1792927826; darn=vger.kernel.org;
        h=references:in-reply-to:subject:cc:to:from:date:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=zqbMboxnHiPTWg2dbceDr02J6CVLgX+y93se6T9a34I=;
        b=UNgO7trm0/YZBMzR+ozQwURYeoUDI55MtLJxMp9sKpYwqJCyd+vErVf6yfeAbKEYCq
         vTIc/o/pc7JKHMs8AZZ1z33rMW0adAP/9lrT4qsZUeyXpuDf5lVo+F96EQgteWKV7Fuq
         zhHV4/vPSulnA6oAOoJmqn5q4kgESLNmydfwBDtzN4R4WQg4LfNamoYrPn3OzYZKw647
         FMqZ2v6/2erIOi/W6cMpF+gj8hVkkFxUIyfOcNKxSWhU8dlWdfvxU22SsoND1lhiMqhs
         bA/R/E9tfycNVMnQVgjBIF4VHBnwjJmYC/voAqcsuV+d8Rtq/4uyIG5R506Uuf/eu2C6
         iLig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792323026; x=1792927826;
        h=references:in-reply-to:subject:cc:to:from:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zqbMboxnHiPTWg2dbceDr02J6CVLgX+y93se6T9a34I=;
        b=jLEtAl8qfn6kSTWedsBdGzHCsUWW1ExD/KX2rxRsbfOkcMQ5Dx7cn5och6ZBohzUo2
         118z8gJ0Mqztx84iV21saTI40pQspWTqhc4BVIihvHFmeyav97L9HjxbnYkTCOVnbj0j
         Yh0Hxns+ZSG70MR3OKVeJoKIASQFJ3jV5OikyW+fQzho0AJkYCUtoPviXVL6D8acTPfY
         VeqEm+qOxqjm5kAtw4ZxsnXrpWiSR4lAT6/A7SyNj/PWjiEaEqRbAgC7p4Rz0VzgZw4D
         i1skZB5mUXKWeKOlgkNACphB7+pDpo/p2suwF/AFfPLP10FuHbbvgPfGpjWcqbrpxcoO
         Bikw==
X-Gm-Message-State: AFq9FYKJnJ4U++G5FRIWhHOrHu/UzA2K7gANbF1hfY5sNJSeI7sq/xbF
	4Lsx7LIFi1OvK7uZMwjzAw+vtp9ShqoxA3yfmkdHMGTpgJSpl9UxeTZmTUNy4Q==
X-Gm-Gg: AYBFou03UR4R1T3rskisYitrr0l091PuvAOfSB4jWfLfCrwx/LB3+6wqmStoLTsDgzB
	mXCwyA3EOatidX+ZCy0DnW0z3FDLDDI43E5x3HkH2wsVVIM+zT+AiTB9kpLTCKUP4U0XzMED55X
	HmJo8ZBZ5PZqr82ML1VqjSxtM5d+UVbuNiw+Ag48erLMeb6TfpfwcUJIFkBpEiA59E30niTe015
	YXskrGl7NE81D84RshNVCVtfc2MtUgzZVDU9vfDqREVS0yr45+QD1Ojjody7u3t4xg06Jr48uIt
	nu1BXo68D3NcKQwSDWFBrMIZab9rl5rXHYM04BJhy2Aud96kzIGaehtYKVfcm5hBuv5+rFWsFTc
	8UXcxwN0GiyEcSf8PFBaJ/XGs0G2UTDy8qgsIJHHSZtZ/JEncSJgXS3iugbEPYuUmZKyrnWKUrI
	fDWboVP5ackE5tzWNCdDLimFfEMxSFYflv04mAKqQ4N9Zmb0ty0heKpO76GrO6rj69EXXWOMNtc
	qK3ot/b/5eqGaHPKypWs0NN0zJtPGOGj57AaaIF
X-Received: by 2002:a05:7301:1c99:b0:358:c9f3:b055 with SMTP id 5a478bee46e88-361a02b6dfamr9574409eec.1.1792323025943;
        Sun, 18 Oct 2026 04:30:25 -0700 (PDT)
Received: from msg ([188.253.120.76])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3607ee0d391sm24066119eec.4.2026.10.18.04.30.21
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 18 Oct 2026 04:30:25 -0700 (PDT)
Message-ID: <1792323015.61575.10feb7db22@gmail.com>
Date: Sun, 18 Oct 2026 11:30:15 +0000
From: Qihang <q.h.hack.winter@gmail.com>
To: netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
    Jiri Pirko <jiri@resnulli.us>,
    "David S. Miller" <davem@davemloft.net>,
    Eric Dumazet <edumazet@kernel.org>,
    Jakub Kicinski <kuba@kernel.org>,
    Paolo Abeni <pabeni@redhat.com>,
    Simon Horman <horms@kernel.org>,
    stable@vger.kernel.org
Subject: Re: [PATCH net] net/sched: cls_api: unlink indr cb on a failed bind
In-Reply-To: <20261013162949.25622-1-q.h.hack.winter@gmail.com>
References: <20261013162949.25622-1-q.h.hack.winter@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

The [High] finding is valid, thanks.

flow_block_indr_list is protected by flow_indr_block_lock, and the err_unroll
path ran without it, so the list_del_init() there could race a concurrent
flow_indr_dev_unregister() that walks the list under that lock -- and, if the
notify half unlinks first, list_empty()/list_del_init() could touch a node
that is already off-list.

v2 keeps the unlink but does it under the lock: it adds
flow_indr_block_cb_unlink(), which takes flow_indr_block_lock and calls
list_del_init(), and tcf_block_bind()'s error path calls that instead of
touching indr.list directly.  Taking cb_lock before flow_indr_block_lock is
the order the indirect bind already uses (tcf_block_offload_bind() ->
tcf_block_offload_cmd() -> flow_indr_dev_setup_offload()), so no new lock
nesting is introduced, and the bind and driver-unregister paths are serialized
by rtnl in any case.  flow_block_cb_alloc() now initialises indr.list, so the
helper is a no-op for the direct (non-indirect) callbacks that are never on
the global list.

Rebuilt and re-run under KASAN (arm64): the unpatched kernel panics in
flow_indr_dev_unregister() with a slab-use-after-free, the v2 kernel completes
clean -- the bind still fails with -EOPNOTSUPP and the driver's
flow_indr_dev_unregister() returns 0 with no report.

pw-bot: cr

