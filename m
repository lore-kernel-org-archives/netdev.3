Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 083DC480357;
	Fri,  7 Aug 2026 13:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786108430; cv=none; b=liWCCU4Se40lNJcvnN5xcBv3NjoS8Z/d/kPeMXobSXu3kD1i9bwPidWZcG9JAapDJ0nR8cYqIsGeGAOjsFFk78HSFZjvHfysuACV5+QZ9FItiOQfRo7JyAjfAHbsUyP+sN82y616FAdryBknvXCJ9TswtxQK6MNju9cixTG6rzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786108430; c=relaxed/simple;
	bh=w8NteUCfRFJcp1SWdAcJMWXoK0KCN8lhNOjEYhTUbFI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rm33bTMU6UYHKV/Ii8kFuae0gnmVxSltJLP1tqZLNLQRwNaVI5EMRsRSGRrd6/QY4t/qoL0JQ6kpSlkmtdyMU/K5pFONBpNiOSxqDEpCrQc+6jfhELo5okoykR5OEN15bDLEPB4knTsrnSoYopILS+rMi/XH0SKdAuq21cxvSXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z4+6LBGV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z4+6LBGV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 930DF1F0156C;
	Fri,  7 Aug 2026 13:13:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786108419;
	bh=CQR0dKpRZD1SJD0+o7Qmgaon51zC1ivu0WrFvoKdOcM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Z4+6LBGVro17G3QaCBonOEX9DsiFq+Qtgfmeul/h2QZMpFCuiCWUml4WIHnGIE4eq
	 T78mWluGDv+Cf9r7+rDULt5CAphrqJdGBuIa8fwbN8qK3EPBp/FOkBsfHiOQlT+QYH
	 mVdwOba5bAIhwABsR/kCRo3QxUFZpT112qh/zqg/KOimWCJ3zlVZh2UH9r9errSfCe
	 4dBBqgyA3MMcl88wbGhvwq1qSZYjXujVwRsrOV4GCkWxzPLnNJq9H4qTfhuBOiH2Te
	 elghrEizoiW4Qsfb5JJaDKVt1tXp9RJReK35Vk6mHepAJThMoirGNpZdWF6TRbLTmw
	 aT+6w2U0YWexg==
Date: Fri, 7 Aug 2026 14:13:35 +0100
From: Simon Horman <horms@kernel.org>
To: Qing Ming <a0yami@mailbox.org>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>,
	Harald Welte <laforge@gnumonks.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	osmocom-net-gprs@lists.osmocom.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] gtp: serialize PDP deletion with link teardown
Message-ID: <20260807131335.GL51943@horms.kernel.org>
References: <20260806023226.5537-1-a0yami@mailbox.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260806023226.5537-1-a0yami@mailbox.org>

On Thu, Aug 06, 2026 at 10:32:26AM +0800, Qing Ming wrote:
> PDP contexts can be deleted through GTP_CMD_DELPDP or while the GTP
> network device is being unregistered. The latter is serialized by RTNL,
> but the generic-netlink delete path only holds RCU.
> 
> Running both paths concurrently can therefore make both paths delete the
> same PDP context. On a KASAN-enabled kernel, a reproducer racing DELPDP
> against RTM_DELLINK triggered:
> 
>   Oops: general protection fault, probably for non-canonical address
>   KASAN: maybe wild-memory-access in range 
>          [0xdead000000000120-0xdead000000000127]
>   RIP: gtp_genl_del_pdp+0x1c1/0x420 [gtp]
>   RBP: dead000000000122
> 
> The second deletion dereferenced the poisoned hlist pprev pointer.
> 
> Take RTNL around the DELPDP lookup and deletion so that PDP creation,
> generic-netlink deletion and link teardown use the same serialization
> domain.
> 
> Fixes: 459aa660eb1d ("gtp: add initial driver for datapath of GPRS Tunneling Protocol (GTP-U)")
> Signed-off-by: Qing Ming <a0yami@mailbox.org>

Hi,

I think it would be good to mention how this problem was found,
and to what extent it has been tested.

You may also want to consider adding an Assisted-by tag as appropriate.
