Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6898D3ACA74;
	Tue, 12 May 2026 09:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778577008; cv=none; b=dMGLAVIzqxl1A3SevTGxFb4B4SP9/8Dajj2aMNLamJJyfLAnA41wwhIF4YxS83IY30S7g5Jg2D4Zycy0RrA3BNzRc1gtapNokwJo+RC8ZYCvVaIRtITy0n7uBJI6MxXUnlHzrSo9QvKxqGYYPrtUQQtqJCb++4zE+K8a0WR9x3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778577008; c=relaxed/simple;
	bh=Oy/PK+rfvPB547k5eldxcoWWWNM/5NRDxeePRJ+qaX8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MMYVsupqdqNLsd9c2ovWq8c/SJunIWGTonAecpBeNUuHOy9UhpFRTDL5eOS72ndyuv4XyzsPRhSI0UH5CXnrOFKwAHQFO0tGSYV18oAKvJCanLotvahk1BWYgEnyt6NtBkU1W8sjtD2w7CJtb1d2SaEXXA8vMdfQOQbilamSHzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lwxcNKpD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lwxcNKpD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A671CC2BCB0;
	Tue, 12 May 2026 09:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778577007;
	bh=Oy/PK+rfvPB547k5eldxcoWWWNM/5NRDxeePRJ+qaX8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lwxcNKpDUqffupbCFXlZ40zCtS/5sMUvcsgXgqjzkc6YWor+Q+V9Z+d+rhfNHQdFD
	 eA5CzkLuEtAMw45+Dqkt0NMEdjNhuY3s+QhAskeg8J4izwoKQNhRc3WHodJh0Bmzia
	 /o09mT/+BRgeEhWTzFPfI0NeSOoPSEZaD8W9wIhr/i3JRzrZyUZ5sbmefykp1WFxG7
	 SKOiawUBF7UjEVhmqq3Fd9vdaORkYQZE7plWHuyQ5gkfFbOypA1VqPHGFvSkTID46s
	 3bP66b4oCWLciUl7+BFR2qLp8ZM332EVmvq1s+6HSqcDEAsnNOuCN6Rl1z8ejTKtRo
	 heJtP9cUwP05Q==
From: Simon Horman <horms@kernel.org>
To: mmyangfl@gmail.com
Cc: 'Simon Horman' <horms@kernel.org>,
	netdev@vger.kernel.org,
	andrew@lunn.ch,
	olteanv@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	jhs@mojatatu.com,
	jiri@resnulli.us,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 1/2] net/sched: tbf: add extack to offload params
Date: Tue, 12 May 2026 10:06:02 +0100
Message-ID: <20260512090601.264199-2-horms@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260508065757.2566258-2-mmyangfl@gmail.com>
References: <20260508065757.2566258-2-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: 'Simon Horman' <horms@kernel.org>

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev
---
net/sched: tbf: add extack to offload params

Drivers might have error messages to propagate to user space. Propagate
the netlink extack so that they can inform user space in a verbal way of
their limitations.

> diff --git a/net/sched/sch_tbf.c b/net/sched/sch_tbf.c
> index f2340164f579a..4576111fe0758 100644
> --- a/net/sched/sch_tbf.c
> +++ b/net/sched/sch_tbf.c
[ ... ]
> @@ -193,6 +197,7 @@ static void tbf_offload_graft(struct Qdisc *sch, struct Qdisc *new,
>  		.parent		= sch->parent,
>  		.child_handle	= new->handle,
>  		.command	= TC_TBF_GRAFT,
> +		.extack		= extack,
>  	};
>  
>  	qdisc_offload_graft_helper(qdisc_dev(sch), sch, new, old,

Will the driver's extack message be overwritten here?

Looking at qdisc_offload_graft_helper() in net/sched/sch_api.c, if the
driver returns an error and any qdisc is offloaded, it calls
NL_SET_ERR_MSG:

net/sched/sch_api.c:qdisc_offload_graft_helper() {
	err = dev->netdev_ops->ndo_setup_tc(dev, type, type_data);
	...
	if (any_qdisc_is_offloaded)
		NL_SET_ERR_MSG(extack, "Offloading graft operation failed.");
}

Does this unconditionally overwrite the specific error message just set
by the driver, defeating the patch's goal for graft operations?
