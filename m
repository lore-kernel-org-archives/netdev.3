Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1624524728F;
	Thu,  7 May 2026 01:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778116992; cv=none; b=Tg5SvJtRg2tqb1C1NRcI5hVGrgwx380eEW5r+01fNmVLeNMSTbQhw7v1vLOQpqIUTCBV0KRYop+97qmXH2n2B2+IJNGGQn9IWbvHg0NESvkiT+w+EMYAnHNHLKAfI7mdrhE+h1FQeeZOGXtnh0JeCvKL9tRDYn+xN6jcYJLbSfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778116992; c=relaxed/simple;
	bh=mOEYcV0mjK67ECfMJcfIMBac5UGKWvLZDGa3Bbgfczk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PNQiCW7IK9NEFLXI5j3NR6xN7cAueadM/HRCwFab+cXdR+8qly7cMEV9i9kMd3POD+FzLr+9qq/N0XRkIFR/NO1kOuqeTc0e48vNWXbsOrZmcn/1miRu4IpXGfDr55yEQhDnY0FEWnCHatF//U6gII35j/ns9bh3Mu22EPgqQV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t0qQkrQS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t0qQkrQS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3EE3C2BCB0;
	Thu,  7 May 2026 01:23:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778116991;
	bh=mOEYcV0mjK67ECfMJcfIMBac5UGKWvLZDGa3Bbgfczk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=t0qQkrQSIsAZS+TLkdHEOnpprYS+IXYLA9TCeQLp3U8TA5L7VENdCx6hSBUjpGNh/
	 RhRTf/RpdCke1UHa+obBgInmQVQaOpnkBM6v2y1oqbsFGN64HNnkr6+QYQHDcE85Uj
	 K1pXf2GPo7MpDUxcrtpr4yozO2pRd6O5tVvgz8DtDMjVZsdRoGC36aOB5A7YwDA0iW
	 rRmjnXvgfxLIv+6gG60QvUmJmn+ZuPy5+ps5/xVK664bny2q38Pt4OTRf5DEfeboLD
	 plK566jV94e6t7cYvSCJuswTC6xynRWEctgda6PyMWOD/5MP/R5VFi3D2qB4FYA9sV
	 GaN6ADdW8S51w==
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
Date: Wed,  6 May 2026 18:23:06 -0700
Message-ID: <20260507012306.2187935-1-kuba@kernel.org>
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

This change extends struct tc_tbf_qopt_offload_replace_params with
limit, max_size, buffer, mtu and a peak ratecfg, and populates them
from tbf_sched_data in tbf_offload_change() so offload drivers can see
all the tbf parameters.

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

The buffer and mtu fields are stored in tbf_sched_data in nanoseconds
(see tbf_change() in net/sched/sch_tbf.c where they are derived via
PSCHED_TICKS2NS(qopt->buffer) and psched_l2t_ns()), but they are
exposed here as bare s64 buffer / s64 mtu right next to max_size
which is a byte count.

Would it be worth renaming these to buffer_ns / mtu_ns, or adding
kerneldoc to describe their unit?

A driver author reading this struct and seeing mtu adjacent to
max_size might reasonably assume mtu is a byte MTU and program
hardware accordingly.

>  	struct psched_ratecfg rate;
> -	u32 max_size;
> +	struct psched_ratecfg peak;

tbf_change() does memset(&peak, 0, sizeof(peak)) when no peakrate is
configured, and the qdisc internally uses tbf_peak_present(q) which
checks q->peak.rate_bytes_ps != 0 to distinguish absent from present.

With peak exposed to offload drivers, every driver now has to
reproduce this convention implicitly (e.g. by checking
p->peak.rate_bytes_ps).

Would an explicit indicator such as a bool peak_present field, or at
least kerneldoc spelling out the rate_bytes_ps == 0 means absent
contract, make this safer for future offload consumers?

>  	struct gnet_stats_queue *qstats;
>  };
>  

[ ... ]
-- 
pw-bot: cr
