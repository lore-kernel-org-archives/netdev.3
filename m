Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E1282D47E9
	for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 16:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790007206; cv=none; b=uG2nTDQoMQkzPoFhsS67baJsDhw7C9KGHAaSB/6W31b6Wn/22NmyCObDJ2IDeVbFz5e1ak5vacMBDbY0Jo0xS2dsq/d7ssmYt/g34pvjcZr8sggHdMmcZjd1d6ZWunBNNhbZ24RdGkl1sz20LUpMI488Bbz1RSRv7FDIvpyoEtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790007206; c=relaxed/simple;
	bh=fc/Fm9QJ1XEzrcYExyPRUGSTEH/7rZftGlIamDV18dk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eup5aeTLQUpnAtMSEtLkIUttsNuIVSOWU9sas3wyp/nZZDVkAUBTwguI/KLE/zAvhq34rk5WNxFMcOlIv4W6TNkKCDUQmc0JUkIQWCxcwTB0NZ2D9GO+UFDEzwFoNm9So0VHSkr4tiC9ldOAArwFRwWIpCIJoWmYaddNZL/y8Bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HA3bHvN3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HA3bHvN3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D9321F000FF;
	Mon, 21 Sep 2026 16:13:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790007205;
	bh=2v3K/Yu4fiO9z9QOr1BZXAE5B6uLt+5rCrbFWwNvBsg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=HA3bHvN3ddFkWl6+lLh+m5Aq328gG6hL098mfEVgle+gxv+nkZXoRpGbnMMvg/qVO
	 /AzmJ9z3rGlvIpRk5gRoTJBaJgAdPRy32ii/aWAekS2lqTS+wh2JHwjEb7d0OXCnnN
	 gLSaVMVKM9G7SUO+KdD9cUzQzWmsvtqgQLBjt2IhcNlP6z4XeWBA7TAe+FGoDla9s3
	 Cr8WNtXXzX/XHfncYmDgZkKbZPAzhaSrccNGbyN1O8ESolA/LB8msXcfzspeQf867T
	 3PgPFgsPA9vkVYuLML9Hncme2HegHr9YBPFps/YDB7dOw3QQBMfoA1zQZbDXddk1Zf
	 3Dw5JG3LIeBhg==
Date: Mon, 21 Sep 2026 17:13:21 +0100
From: Simon Horman <horms@kernel.org>
To: Victor Nogueira <victor@mojatatu.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, jhs@mojatatu.com, jiri@resnulli.us,
	netdev@vger.kernel.org, hybris@mojatatu.ai, sashiko-bot@kernel.org
Subject: Re: [PATCH net-next 0/3] net/sched: complete action notification
 accounting
Message-ID: <20260921161321.GV13925@horms.kernel.org>
References: <QDISC-RYTB.v1.20260918093205@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <QDISC-RYTB.v1.20260918093205@mojatatu.com>

On Sat, Sep 19, 2026 at 08:04:26PM -0300, Victor Nogueira wrote:
> The action notification paths size their skb from each action's
> get_fill_size() callback, but three gaps remain: one callback undercounts
> (TCA_MIRRED_BLOCKID), five actions have no callback at all, and the
> TCA_ROOT_EXT_WARN_MSG attribute is unbudgeted.
> 
> Patch 1 fixes the mirred callback for TCA_MIRRED_BLOCKID.
> Patch 2 adds get_fill_size() to act_simple, act_mpls, act_nat, act_skbmod
> and act_connmark, the five actions that still lack one.
> Patch 3 budgets TCA_ROOT_EXT_WARN_MSG.
> 
> Victor Nogueira (3):
>   net/sched: act_mirred: account for TCA_MIRRED_BLOCKID in get_fill_size
>   net/sched: add get_fill_size() to the five actions that lack one
>   net/sched: act_api: budget TCA_ROOT_EXT_WARN_MSG in notify skbs

For the series:

Reviewed-by: Simon Horman <horms@kernel.org>

