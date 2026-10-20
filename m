Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792494023;
	b=fof8GVPnkNgbh+ZCHErihG4OEzYv4olpGAUUcANi7vGkvJ03V4+SWIpMvO08ehjb5npZ
	 zX664Zlf2DsomiY+DEgLJQZ1g0Jc1Bt9vHFfqJ3rXAiMwGY/ko+nFyhl11jmRnlPOwbHa
	 U15gY9kuloLuPOWA3m67rwQlxiF+TNmIdwGpNHNEHv4SsII/nuOftwlCmoJVfYnNho77i
	 Lbb6Pxfd5vUkiaIQ2wEu49ZguDaiYDh3RimNjB3hIMq+AMOLZArvkv3ekRDjeurIMPX48
	 Ucu2gBhsng9uv75HQ4qdyWgGjAzrfAgVV8PwQ0TRwDqJR0I3i0Y2+2fuxdBnPjAg8jQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792494023;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=FuFUTtK25dGBWnxysXdpyNsNZRA20ZU8zu1KApnKbdg=;
	b=kIFE4s+6mCmo5grg6XJvBjRA2sinTuQNs20blIPPZyXa85FYIgX4KQBPsDmwOEAM/leY
	 8CUK/pstzOC8l6/d0qIUl4j3XxGL+/qHwXOoBx+zRLfPZeKTXoFJYPXracYATUXEZCWzv
	 rPTlxHwzvPuxfkUM/UGu5zKP3H9nefc1Q4vHSr0kaEQ6VvmUUA7h5KKVA9ufw4GE0ncTY
	 pSzY3vL6gaAsrfE6ZT563pb2lX2bD4EnD+b60Zbv+bcQZPNHEErWKVOI85eRAB2zEtYUd
	 eyEvNiM2Wp5K7uzrAHKyUdPtx0FgG/4ePwAMBjkqZxmyFQAVfLKfFyAJPQtl2pQ4IqA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=NXbbUOn+;
	arc=none smtp.remote-ip=209.85.219.42
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D3D860A2604
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 11:00:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1D3D860A2604
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=NXbbUOn+
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-91b8b456dbeso39333766d6.2
        for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 04:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1792494021; x=1793098821; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FuFUTtK25dGBWnxysXdpyNsNZRA20ZU8zu1KApnKbdg=;
        b=NXbbUOn+3xiZtp6/jkb/+Zi7Z0JgkW4vorHI/N6SX2nYb9crhGKOXNqKMJkKEbwjo1
         QiNK/HMqyrAQdkq2SnIdTS8ymjmsNSBzfn8aRa3k1hvclyKVXh5txkDfoCtMO6YbvkvS
         a5YyPRvbL0/d7+g2C2JfgVZsC/tNOJOAcAsrY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792494021; x=1793098821;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FuFUTtK25dGBWnxysXdpyNsNZRA20ZU8zu1KApnKbdg=;
        b=dy2DpXC0DAzmtwgCWqbZAqdy77ZSa2onOfQbZ1hN99Tqy8CQEfwm0qoB27FtbDrzoT
         fsUJSc4UETjrBVLTAm1LP0C02PVjPHB66n6iyMxcdZVdOoXy4f2QFYm3l11B6ciVfpZK
         WVNspMl7TLQVvr2S3NJRkXg+7dT70od4SqqDwKYgKwuogmDZFPEEH/lZRgYTtAQR1/6a
         Z7yXsW88tT3W9O+VGnCRVwz6zff4h4OqnYNMwIoMrEQoE7RG/0sZoq3W4WPt09iaL+lU
         x8VWnMYj9uHDHPUsrm0cxFEVZSyAS08YhHUCqWVwW/3BJvz0AFhJF1RRG5lvtbv1dI+x
         9Pew==
X-Gm-Message-State: AFq9FYJ94eaSLkXoeJXp1gg8pkT7YP6vYEapIvnURIML2juivOHKAy0f
	LD9A7bqLF6QvHcTsZt2e4Y5NWx7ty2ZyhxlhbNQednT0Hk60CwTZDvqZ1fqEgJpa5JsYVV4zxwI
	i++8=
X-Gm-Gg: AYBFou2ZQYUd1uf0lq/FjmRSM5Bjx3yloBbmZMcKZ3hMNHD80dSgKR67rPL9JNBwahx
	66ywfAS8KEKTfL3D6l5Nz78CFaII+y7J0yY/hcdCHfoLx/x4xXe0oWXCNCetU8ufpeICFkbCKSj
	B2s8OgPwcztBOd/7Kfrfm3dC05iKfJd5oiMwMiBE0Tmrza90VtoFfTOvcyzv8QXjK6W5u7C22x0
	27WfEiSkH65H4Tz8/Ksp2/TZjW9SzUyYdzy+Bdojxb/AoZITjtsCJkJdw7d3rfxEAenBEd5Ugkt
	OV00V8YzLkNbh7ljh8ntM5ZNHvo2XhTTEM+UHPJtvd4fuxcdSz7dwZnYNCBJvg8L+sNa8gvxBYx
	lQI5iPFRTtgtdZmt55KNJyr3pVQZ9A/TmUHFG6T8DTocu4miWziCStroMHFBKTIn3h7SHKvyV/d
	tIhRsAFUTFw+miCJRjqr+11SAD6V53UMeE56VnsCst5RTNRRs/mWpg1KiBSC+LNN0WnQ/zhXJaD
	Hd03HNA5pjRqRg3SfzxCx70MDHfhnu4UzdUIXxGDy65O00Ha+1g6QQ=
X-Received: by 2002:ad4:5f0f:0:b0:914:4464:41a9 with SMTP id 6a1803df08f44-91bdf1236abmr196653696d6.29.1792494020952;
        Tue, 20 Oct 2026 04:00:20 -0700 (PDT)
Received: from mbili.waya ([64.203.83.2])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91c040e6667sm23382356d6.39.2026.10.20.04.00.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 04:00:19 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Victor Nogueira <victor@mojatatu.com>,
	cake@lists.bufferbloat.net
Subject: [PATCH net-next v3 4/4] net/sched/sch_cake: drop dead nla_nest_end() error check
Date: Tue, 20 Oct 2026 07:00:08 -0400
Message-Id: <QDISC-5RTM.v3.r0.20261020053711-4@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <QDISC-5RTM.v3.r0.20261020053711-3@mojatatu.com>
References: <QDISC-5RTM.v3.r0.20261020053711@mojatatu.com> <QDISC-5RTM.v3.r0.20261020053711-1@mojatatu.com> <QDISC-5RTM.v3.r0.20261020053711-2@mojatatu.com> <QDISC-5RTM.v3.r0.20261020053711-3@mojatatu.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

cake_dump_class_stats() closes the TCA_STATS_APP nest with

	if (nla_nest_end(d->skb, stats) < 0)
		return -1;

nla_nest_end() never returns a negative value: it has a single
`return skb->len;` and no error path (that is why the overflow-aware
nla_nest_end_safe() helper was later added). The '< 0' test can never
be true, so the 'return -1' is unreachable dead code.

Drop the check and close the nest with the bare statement, matching the
sibling cake nests in the same file.

This issue was discovered while fixing a bug on the gate action, see:
https://lore.kernel.org/netdev/QDISC-H19Z.v1.20261001053234@mojatatu.com/

Conditions to recreate the bug:
- not runtime observable: the issue is found by inspection.

Link: https://lore.kernel.org/netdev/87v77csd5q.fsf@toke.dk/
Reviewed-by: Victor Nogueira <victor@mojatatu.com>
Acked-by: Toke Høiland-Jørgensen <toke@toke.dk>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
v2 -> v3:
 - No changes to this patch. Re-sent as part of the series v3; keeps its Reviewed-by and Acked-by tags.

v1 -> v2:
 - No changes to this patch. Re-sent as part of the
   series v2; it keeps Toke's v1 Acked-by, carried forward.

 net/sched/sch_cake.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/sched/sch_cake.c b/net/sched/sch_cake.c
index 4caf9718c9bd..124f552023f8 100644
--- a/net/sched/sch_cake.c
+++ b/net/sched/sch_cake.c
@@ -3211,8 +3211,7 @@ static int cake_dump_class_stats(struct Qdisc *sch, unsigned long cl,
 						       READ_ONCE(flow->cvars.drop_next))));
 		}
 
-		if (nla_nest_end(d->skb, stats) < 0)
-			return -1;
+		nla_nest_end(d->skb, stats);
 	}
 
 	return 0;
-- 
2.43.0

