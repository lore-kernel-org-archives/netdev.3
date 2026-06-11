Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DBBA3CC310;
	Thu, 11 Jun 2026 11:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781176432; cv=none; b=GQY/5+niDYCyTouJXAgLCVyT9YnElPnEXworLZgGftt66VdA773xRr+d2Q+YB62AIh8wpRQGjNOQPgQZFsTDyqDIrD4e747Oe/HSF176/fpog1gdlVBy71rWtfuDR0LzYzwx7cNNFboIIanTPrXAfqxmKHaGwzNK0gp1OzmlLto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781176432; c=relaxed/simple;
	bh=BShnkMPGnSYxn/GsUsyCAwwgrPOHlNWilSZPBwgWclA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cqZscdHq7sVq/PL3kDVeuNP+zy2QR0fNg9JefX9Q8shr8EqyzjpXbi3eIvSaUhshO2hFUN3e2ZpX+OMy756+3+VG0hNo07tFlTT2okNcOUJMl7uxw+xtHprdDHurx4AA3aWBW7bgIoyPrHhGQ8+DDYrrduIjuW1L5Bar7cFGtPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i2A6RVaY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i2A6RVaY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 379C71F00893;
	Thu, 11 Jun 2026 11:13:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781176431;
	bh=I49uPRspepBJl4kuDgVlrU9lUdliPxsqoxf5o6I/NiM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=i2A6RVaYXxFXbQfwMz4Oewn7Vv39Wur4GkrIbXISZCM+125g//7qx/mmBXodZoa46
	 24Rovlm8YDP9iuBtQR53CFeANlFnUvpiHBcxGnQCxze06iRhNrwZoF52rmJEs4fLa2
	 h0nFVxBPrDnPz4C8hU5/oz/Ix48/XYym1w4DMVIKzro8XqmRCT11g0XH4beB/N3Cgz
	 /SgsXT8x9IHNMr1xXQNCp4An2SxzrcybmAEufyujFC25tNcTkbver61FNvepJzmdxN
	 ocq3Acby1jFCiU4OoIOoCE/ciQCegazoiYO3BgizShBRE06k2a3fH7dP/WpS1Nqp1b
	 XCQGLjGKNT3nA==
From: Simon Horman <horms@kernel.org>
To: sam.moelius@trailofbits.com
Cc: Simon Horman <horms@kernel.org>,
	jhs@mojatatu.com,
	jiri@resnulli.us,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net/sched: hhf: clear heavy-hitter state on reset
Date: Thu, 11 Jun 2026 12:13:29 +0100
Message-ID: <20260611111328.544867-2-horms@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260609004937.1240807.c0dcec938172.hhf-reset-stale-classifier@trailofbits.com>
References: <20260609004937.1240807.c0dcec938172.hhf-reset-stale-classifier@trailofbits.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev
---
net/sched: hhf: clear heavy-hitter state on reset

This commit clears the heavy-hitter classifier tables when the HHF qdisc
is reset. This prevents packets from being scheduled using flow history
from before the reset operation.

> diff --git a/net/sched/sch_hhf.c b/net/sched/sch_hhf.c
> index 96021f52d835b..1698c1b54dec8 100644
> --- a/net/sched/sch_hhf.c
> +++ b/net/sched/sch_hhf.c

[ ... ]

> @@ -461,12 +461,34 @@ static struct sk_buff *hhf_dequeue(struct Qdisc *sch)
>  	return skb;
>  }
>  
> +static void hhf_reset_classifier(struct hhf_sched_data *q)
> +{
> +	int i;
> +
> +	for (i = 0; i < HH_FLOWS_CNT; i++) {
> +		struct hh_flow_state *flow, *next;
> +		struct list_head *head = &q->hh_flows[i];
> +
> +		list_for_each_entry_safe(flow, next, head, flowchain) {

[Severity: High]
If hhf_init() fails due to a memory allocation error, q->hh_flows will be
NULL. When qdisc_create_dflt() cleans up from the error, it calls 
qdisc_put() -> __qdisc_destroy(), which unconditionally calls qdisc_reset()
and triggers hhf_reset().

Does the pointer arithmetic here yield a NULL-derived pointer that will
cause a kernel panic when list_for_each_entry_safe() dereferences 
head->next?

I noticed hhf_destroy() has a specific check (`if (!q->hh_flows)`) to avoid
this issue during cleanup. Would it make sense to add a similar check here?

> +			list_del(&flow->flowchain);
> +			kfree(flow);
> +		}
> +	}
> +	WRITE_ONCE(q->hh_flows_current_cnt, 0);
> +
> +	for (i = 0; i < HHF_ARRAYS_CNT; i++)
> +		bitmap_zero(q->hhf_valid_bits[i], HHF_ARRAYS_LEN);

[Severity: High]
Similarly, q->hhf_valid_bits[i] will also be NULL on the initialization error
path. 

Because bitmap_zero() internally uses memset(), will passing a NULL
pointer here cause an immediate crash when the cleanup path executes?

> +	q->hhf_arrays_reset_timestamp = hhf_time_stamp();
> +}
> +
>  static void hhf_reset(struct Qdisc *sch)

[ ... ]
