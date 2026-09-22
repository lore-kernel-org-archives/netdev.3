Received: from mail-dl2-f42.google.com (mail-dl2-f42.google.com [74.125.229.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FE173B47FF
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 20:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790108443; cv=none; b=nNHD2E1LTcj0oc50Ohmvvn7GFpCnnC6wWEn9j56ICl+ZAbzVXVZJWiaIozeKc34fEW/3uOjnT+umSiIXN5JSsjJ7gpZXJCgNv2F9pGdyXREK4BtkS/1av+vXoquf3VC+6P4qAM8g8niAB9AV08BY5GEf1j0rkElmCytUIMxFPso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790108443; c=relaxed/simple;
	bh=NfI/Dm5EYDMnMTAl3fxv1BGBbGtmkx+otpGuTeOYlsM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gYSgU3efYk579n7cP3Nq3YV3NVfRyce9WnLTYNctx2/Ros0vy1Nc/EWqwIn1/ziCvaUhoQ1vMYdR+Rr3JpYBA9jm2grC3rsX9DNfryLV4ZJiXMg6UvdZ3m4i70H4j1oltjlh8yOSGvpRKcvS+PcrIw43u7X9x96J9v7v0KBOpSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lm5bcyw8; arc=none smtp.client-ip=74.125.229.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lm5bcyw8"
Received: by mail-dl2-f42.google.com with SMTP id a92af1059eb24-144e32aaa1cso141016c88.2
        for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 13:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790108423; x=1790713223; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NfI/Dm5EYDMnMTAl3fxv1BGBbGtmkx+otpGuTeOYlsM=;
        b=lm5bcyw8kOZ1x/vhA0+QxXrRD8amGvH15hMxKrrzHpaa99g+sjEgx8XqN1+AVNGk+F
         57gwSw+UmANftrxVLDQpYJ20g37w+1T5HqcpHJPhgqoM/MW01P6CaZYeU3jFSdHZ49s4
         jPvMPl/Hzyb6ZluI0eaQnvPfHj+vcBJNwuxoAbP0NkQS5eiDTiGy3fzWEb8sKegwppOO
         Ei0sFx1S5YpazUzKxipuJ+0iJE2ejopeYI6LzVs20+mUkT7wQRYac2Na8xp3TYxUWRce
         blUy11W2J7yONA8zAXORPBuYRA43AA9+ENyucV45g1xQ3uWouxBJ4wwJfKYzenladE4O
         +jYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790108423; x=1790713223;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=NfI/Dm5EYDMnMTAl3fxv1BGBbGtmkx+otpGuTeOYlsM=;
        b=yLMbUIn68LWWFsbz/J0Uej3ByZDaxPVOuScRptPSfWr6rMFoHBkttV3y7RcJ7HbHm9
         ihENmn6K8HdfdtlbPyLps6sE1RpsR9dZjRg1S/llCnpGnrDOp6T4o5zO85ZTPgzTUO/+
         VhplARqV3raH//OyDiKeSaewpwxlKXYNR2Gjb6Ineuxgx/jAtamZxzyf/Zyg2UggvDM0
         V5A7QElnzJQxGWebxB5vx+HoNPP3Jn6rr5yr1KuMgX7iJsotCAX1Qt7LUQCQrka0qdV4
         hSui8G0IflFa8w1+UZOVXP26U91CFLcq3tEZDuCILkRmf8IFh7y8Cr5jxPrxSNEIoAeK
         TyvQ==
X-Forwarded-Encrypted: i=1; AKwUvBzUOJ0CdnmtzWbo5E4DYR/eeGEJD9//kmabDpYg8c4Qd5Qk9XV1BzPpH90d4sxoHZ1khctPPYo=@vger.kernel.org
X-Gm-Message-State: AFuF++lLUxpJd/rpVAt8DPbQ9DmSGR5jMjtJVYe9eJ/A2+OQDQc34knr
	DbriMX4RAsNOXiIya/UtBZwGMffGWYnLq3nu8DicBI50yZFeNX/WaE4M
X-Gm-Gg: AYBFou3qvNuTA1bXUGeIu70M4vb86Mr5DkVTtKev972y0TFwDwqkK6KhO/EoSHQ5c39
	zKBNpl4Zop9GYykkZfSJ0yBC68tfor1VZq9x2AUdBkzM3Fxa6IIPJUABuHbvptqny62pxbFNEMG
	Sij6BQyKBIZz/5n1gp6tfoq/zhBhlyIzPV80wCePgKwckUzxGEeYplHZTUm6sPNfgzJDRdbXeMJ
	UXSEYxP7D2Hyc9TriuMgzYWL6fXwkUi3oHhKQG3d7nBGGq33NGC7SFu1omK7/JHonsEmw9dq6zM
	NEDvOddhO13pSPYuBFrwElqOkLyB+JrlR00bNpVC5DMLnn1daTS9ea195IxO6E/bJEMlqY3uaJh
	KdahT1ZDe8FGUPSWtQadtN2WbuEvuUrGhrx6q2rZa8sRlP8tazCgN5uvUCpJTbuWJnprr3O3ku1
	kcSgT+rYXKX6ukW3RbqGbycaRzyFOm6iEjApojvQO1F8PBx0zJ2NKEvB2ePV4vQMg8tJBZzf7OV
	IaNr51Thqx/72hnzGLOUZ2TAXAmCIpXbBmHLjC6QVavM/mJC5mk+kqijQy2g8Nxm4Lh08AqCqGO
	nQ93Fqo1Bu++VOAwVOBq
X-Received: by 2002:a05:701b:455a:20b0:141:4951:f150 with SMTP id a92af1059eb24-144f90adb56mr519266c88.18.1790108422631;
        Tue, 22 Sep 2026 13:20:22 -0700 (PDT)
Received: from Inspiron-14-5420.. ([2402:e280:21c6:671:f16e:2102:25ad:9cdb])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-144f9820ca5sm716854c88.3.2026.09.22.13.20.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 13:20:22 -0700 (PDT)
From: "Hemendra M. Naik" <hemendranaik@gmail.com>
To: netdev-bot+sashiko@kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	hemendranaik@gmail.com,
	horms@kernel.org,
	jhs@mojatatu.com,
	jiri@resnulli.us,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	shuah@kernel.org,
	tahiliani@nitk.edu.in,
	vishy0777@gmail.com
Subject: Re: [PATCH net-next v6 1/3] net/sched: sch_fq_pie: add per-flow statistics via class ops
Date: Wed, 23 Sep 2026 01:50:13 +0530
Message-Id: <20260922202013.25126-1-hemendranaik@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <179002340755.2160803.3742716999091408861@kernel.org>
References: <179002340755.2160803.3742716999091408861@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Thank you for the review. Replies are inline below.

> Is this paragraph describing a change made by this patch? The diff is
> purely additive and net/sched/sch_fq_pie.c had no delay or avg_dq_rate
> conversion before it, so the new fq_pie_dump_class_stats() is not
> replacing any truncating computation.
>
> The code that actually contains both of the described defects is
> pie_dump_stats() in net/sched/sch_pie.c, which this patch does not touch
> and does not mention, and there is no Fixes: tag.
>
> Could the paragraph either be reworded as a deliberate difference from
> the pie qdisc, or the series extended to fix pie_dump_stats() as well?

As you noted, the diff here is purely additive, so this paragraph isn't
describing a fix to existing code in this file - there's nothing in this
patch's history to carry a Fixes: tag for. It's explaining why the new
code uses div_u64() and a widened u64 intermediate: to avoid a known
overflow pattern, not to describe a prior bug in this file.

The bug you found in pie_dump_stats() is real, but it's independent,
pre-existing (net/sched/sch_pie.c, ~2014), and unrelated to whether this
new ABI addition is correct. We'd rather not fold a fix for that into a
series about adding per-flow statistics - it deserves its own patch,
separately from this series.

We can make the paragraph read as a comparison rather than a claim about
this file - e.g. "which can wrap" instead of "which wrapped" - a
wording-only change, no scope change.

> Growing struct tc_fq_pie_xstats from 36 to 64 bytes is visible to
> userspace in both directions [...] Does the accompanying iproute2
> change parse defensively, e.g. copying min(RTA_PAYLOAD(xstats),
> sizeof(st)) bytes into a zeroed local struct rather than bailing out?
> [...] Could that reasoning be added to the changelog?
>
> The alternative would be to leave tc_fq_pie_xstats at 36 bytes entirely
> and emit a separate struct [...] Was that option considered and
> rejected?

Yes to both. iproute2's fq_pie_print_xstats() already does exactly this:
it copies into a zeroed local struct and memcpy()s only RTA_PAYLOAD()
bytes when the reply is short, so a short/zero-filled read still
resolves to TCA_FQ_PIE_XSTATS_QDISC (0) and prints normally. This
reasoning is already in the changelog - it's there now, not something
we're planning to add.

We did consider a separate struct and rejected it. fq_codel can put its
discriminator first only because it was designed in from day one;
tc_fq_pie_xstats already has nine fixed-offset __u32 counters that
predate this patch, so a discriminator can only be appended here, not
prepended, without moving those offsets. A new, separate struct would
still need its own attribute and its own print callback wired up in tc,
splitting one qdisc's stats across two code paths for no added
compatibility benefit. Extending the existing struct was thus better.



pw-bot: cr




