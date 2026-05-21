Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF8C1331A63
	for <netdev@vger.kernel.org>; Thu, 21 May 2026 22:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779402397; cv=none; b=DjJCDxqvQ6LjmIuP1DuMB0Ev1za4KkbOv58+Hjp2NF8n7LhVgv2c+dXOjT7HEZGnp6XyIa4u0EWvKG1fY0GxFDgPFVGrMT5mDpqS7BhS2l5rKfBTGEKt/Hzi5XMkMpNmbHhF1D/L2h+iyZMDkr7Qj06h00GdynhQQ296P1rMDwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779402397; c=relaxed/simple;
	bh=xcT/+uFLimq9CPRqD9d9UA1OOCvvCWvBrOhOYyhxRPw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qnRuwtP/OrrKwVSW25yXhbUKrVXlH13rHgZv8/JbZfZr6epwGYb97PNLf8UpYvvqDM+6V0B1iXX1UaagdpaD72B0eLfLf825bYAtdUDrnCsS2/TOkclRuWpR+HKIzVO6/yRJiPzVsHWuDL8iqiVNGeYmebRh6FmE+ACLNtynk5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=clLPkxO5; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="clLPkxO5"
Message-ID: <a7830c42-958c-4e6c-8dbb-a3127ea72d89@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779402392;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Cx6HA7vZeZvNnm63TiH8yyq2s7FeGC06VAml6f3m1zE=;
	b=clLPkxO5n2K0EL2F0uAfzy6YOgxJ61RdywkQzU1+JxYmfCq8MZyqQzZHvwbVRqr5O5ZO6J
	03OJIfvZNpDTxhqe6ZPlU1CczRO4svSuNMYXESqLiiaNdLsRpBzsiRJMYSLNo0kwwjX8Nv
	l9IAEpAF+fXRU4G++ye3dUYNFMZVwSM=
Date: Thu, 21 May 2026 23:26:29 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next] dpll: change dpll_netdev_pin_handle_size() to
 assume DPLL_A_PIN_ID will be used
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
 eric.dumazet@gmail.com, Arkadiusz Kubalewski
 <arkadiusz.kubalewski@intel.com>, Jiri Pirko <jiri@resnulli.us>
References: <20260521171440.114956-1-edumazet@google.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20260521171440.114956-1-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 21.05.2026 18:14, Eric Dumazet wrote:
> We plan to no longer hold RTNL in "ip link show", and use RCU instead.
> 
> Assume rtnl_fill_dpll_pin() will have to fill DPLL_A_PIN_ID.
> 
> It is fine to over-estimate skb size (by 8 bytes) in if_nlmsg_size().
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
> Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>
> Cc: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
> Cc: Jiri Pirko <jiri@resnulli.us>
> ---
>   drivers/dpll/dpll_netlink.c | 11 -----------
>   include/linux/dpll.h        |  9 +++++++--
>   net/core/rtnetlink.c        |  6 +++---
>   3 files changed, 10 insertions(+), 16 deletions(-)

Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
