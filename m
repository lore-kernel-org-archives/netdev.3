Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8730C23183C;
	Thu,  7 May 2026 01:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778116945; cv=none; b=spjLG4yrXuGyoVScis5XVtjRKqvSRJk8ZS26dM9oBkWO4XlrdcdQosyzHHMhjpSeNO0Ay1RgI6AVDlssfMTz3j88tbQXa1hlFrp6DYn5V9ot1sAGGt0VX/z+ZkG/idaTR4r+2u6o1IsaBoMGYHHIpooL/sTvL47aeG60PllZXX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778116945; c=relaxed/simple;
	bh=aw2zFfCleGJ90e2jS6JvB8CmUvvOcZHPi/HznuFLJnw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dgAB6W5PitAluQjVVEujtj/JPGOu3K9B7J0spyL6Q53zxkNyNOEjL6m7mu5tqU5ct1DAz72KmojKIq6bvqnTQUbtcW4B3p2tKSUUbsacNEBfyNqwaQprMvXiIfzRgQDovlGHpO7FSaP19D3UHrQ/AzJc2I3jyERW5ThDlZ3smUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ffA6rzon; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ffA6rzon"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B6C2C2BCB0;
	Thu,  7 May 2026 01:22:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778116945;
	bh=aw2zFfCleGJ90e2jS6JvB8CmUvvOcZHPi/HznuFLJnw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ffA6rzondcY02g7jNJbvoJ3FwBKQWyNmMFZTJpfVeuUOrsJ4FUNGEJrFzrT9v2yyB
	 e91mECRh0oCT1F60/VhG1Bw/Vdw9mYZOC29XXAELvzNuODOXZ8E+DV8DqzRF6K81U/
	 SFvl0gaZQxf9gE744b5b1bblqIBOggB2dXLLVjjy0ATJDqyxmuDlTkT7B2KYHYx1QH
	 j5WyePMH//udw7D6w2ezpgLDj5Bt1f9G0I7Z1C0xQ0lOrIyRxUnFl+wTtsWAvL7cVS
	 IqPuXkqrcxohpXC89/fU72ehVG6HkS5/U+Hrg4Gl5adyU4y3klEzd7M+2ZczIaSpSK
	 Cknc2Hw62Jvqw==
From: Jakub Kicinski <kuba@kernel.org>
To: mmyangfl@gmail.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	andrew@lunn.ch,
	olteanv@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	jhs@mojatatu.com,
	jiri@resnulli.us,
	horms@kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 2/3] net: sched: tbf: pass all params to offload users
Date: Wed,  6 May 2026 18:22:16 -0700
Message-ID: <20260507012217.2187429-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260504101258.1608004-3-mmyangfl@gmail.com>
References: <20260504101258.1608004-3-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
net: sched: tbf: pass all params to offload users

This commit exposes additional TBF parameters (limit, buffer, mtu, and peak
rate) to hardware offload drivers so they have finer-grained control over
queue configuration.

> diff --git a/include/net/pkt_cls.h b/include/net/pkt_cls.h
> index 3bd08d7f39c1..d73c04e3d919 100644
> --- a/include/net/pkt_cls.h
> +++ b/include/net/pkt_cls.h
> @@ -1040,8 +1040,12 @@ enum tc_tbf_command {
>  };
>  
>  struct tc_tbf_qopt_offload_replace_params {
> +	u32		limit;
> +	u32		max_size;
> +	s64		buffer;
> +	s64		mtu;

Are buffer and mtu the most clear variable names for the offload API? 

In sch_tbf.c, these fields store token bucket depths converted to nanoseconds,
rather than raw configuration bytes. Exposing time values under names that
typically imply byte sizes could mislead driver authors.

>  	struct psched_ratecfg rate;
> -	u32 max_size;
> +	struct psched_ratecfg peak;
>  	struct gnet_stats_queue *qstats;
>  };

[ ... ]

> diff --git a/net/sched/sch_tbf.c b/net/sched/sch_tbf.c
> index 4576111fe075..8a1110d59dec 100644
> --- a/net/sched/sch_tbf.c
> +++ b/net/sched/sch_tbf.c
> @@ -153,8 +153,12 @@ static void tbf_offload_change(struct Qdisc *sch,
>  	qopt.command = TC_TBF_REPLACE;
>  	qopt.handle = sch->handle;
>  	qopt.parent = sch->parent;
> -	qopt.replace_params.rate = q->rate;
> +	qopt.replace_params.limit = q->limit;
>  	qopt.replace_params.max_size = q->max_size;

Does passing q->max_size here provide the driver with the original burst size?

The software TBF overwrites q->max_size with min(burst, pburst) when a peak
rate is configured. As a result, the offload API only passes this overwritten
value, meaning a driver attempting to offload a dual-rate TBF is not given
the original burst size in bytes and would have to reverse-engineer it from
the nanosecond buffer value.

> +	qopt.replace_params.buffer = q->buffer;
> +	qopt.replace_params.mtu = q->mtu;

Will this cause the yt921x offload (introduced in the next patch) to
unconditionally reject all offloads?

The yt921x driver attempts to reject dual-rate offloads by checking if p->mtu
or p->peak.rate_bytes_ps are set. However, the tc userspace tool always
populates the mtu parameter with a default value (like 2047 bytes) for legacy
rate table compatibility.

Since tc always sets mtu, q->mtu will be non-zero, causing the yt921x driver
to return -EOPNOTSUPP and reject the configuration. 

Should the offload API explicitly pass the raw burst and pburst parameters in
bytes instead?

> +	qopt.replace_params.rate = q->rate;
> +	qopt.replace_params.peak = q->peak;
>  	qopt.replace_params.qstats = &sch->qstats;
>  
>  	dev->netdev_ops->ndo_setup_tc(dev, TC_SETUP_QDISC_TBF, &qopt);
