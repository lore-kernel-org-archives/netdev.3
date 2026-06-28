Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0E6E2F549C;
	Sun, 28 Jun 2026 17:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782667192; cv=none; b=D+J8XX4Y+RHgmDUIb9NvKLIrpLZnnSdmLxYypuPiZ72RcPQaNXp3XBlbPVYG19WUmNcjMH7PKMXCWux99P3GcsnSPyYW/lRUdRA0K2HDe7m1/+PZ44zb+efGAYGzLsFWEtHIRTHeZ7M3O7hqI/qo6QruLk+q7T62n6s28DtdJtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782667192; c=relaxed/simple;
	bh=wxihSXRfs+GcqQRdhjSNucMLVNeFdnTO36TiUb7B/Fg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lbYkvyClFG9xH7jz7uXVelr/pxs88cY9aTfknVr8rN+n2zPIqEXVRaXpaeb4e6AHenKpWJ6YjdtFosWY4HDlqLwAIxB9tn+68/0s/88sxFfaM0vugKFRl+Co2Z8XPuWV2bZ7/M5b+BPnFhZ658Mii9pw+8ZNXTpOSbQxO7ZxpZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y6XzXPiy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y6XzXPiy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A6BE1F000E9;
	Sun, 28 Jun 2026 17:19:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782667191;
	bh=Z4wjVY/rhIT6LDrnHjsDbnz+wudrca1GGsf2sy2l+Fs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Y6XzXPiyZUvyoB2nzzD0UEi3uC2+mvCEnPtggjqeLlXpTVxkUsaM1RtLPbwP6Ownm
	 oKcGAMCtU/lzc2FPlgGJAxWIU0xlETkoTGtuHUivILscQeAQVmOUEhY9gKTeP670nC
	 w0w9NBylO1n6ow3Ihugor+3KjB+yKpSWq70ivxpWZukv46pj8tcDVQznnfew4wqUht
	 ycc/PZavO66mB1/8s34KVh3FNo9xpo39Bnwen6Uf84fHyfObCGUvivFTFuXvG8d0Rb
	 3BgvNk9nUmm4qv5qKHwLHnieGsm1hCINeL+HAiW3ozjkyGvdbMS+mlaup9FsWCvLHY
	 JEQK0Yboyo0ug==
Message-ID: <e907ee3e-df70-4e32-a69f-29a9baaf1993@kernel.org>
Date: Sun, 28 Jun 2026 11:19:48 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iproute2-next] devlink: support u32-array values in
 devlink param show/set
Content-Language: en-US
To: Ratheesh Kannoth <rkannoth@marvell.com>, stephen@networkplumber.org,
 kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, sgoutham@marvell.com
References: <20260615041042.549715-1-rkannoth@marvell.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20260615041042.549715-1-rkannoth@marvell.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/14/26 10:10 PM, Ratheesh Kannoth wrote:
> @@ -3904,6 +3935,14 @@ static int cmd_dev_param_set(struct dl *dl)
>  		if (!strcmp(dl->opts.param_value, ctx.value.vstr))
>  			return 0;
>  		break;
> +	case 129:

no magic numbers. What does 129 represent? Is there a named macro for
it? If not, why not if this is part of a UAPI?

> +		buf = (char *)dl->opts.param_value;
> +		token = strtok(buf,  delim);
> +		while (token) {
> +			mnl_attr_put_u32(nlh, DEVLINK_ATTR_PARAM_VALUE_DATA, atoi(token));
> +			token = strtok(NULL, delim);
> +		}
> +		break;
>  	default:
>  		printf("Value type not supported\n");
>  		return -ENOTSUP;

