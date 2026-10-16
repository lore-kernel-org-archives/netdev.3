Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2CBA4CE699
	for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 16:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792169525; cv=none; b=NPsIXyqARDFILzmOyUq00DJkhKs0RjToHW9dPy3qh4WCwpzBY4H3vLpYPvIY5EK+cs9XVepMUk5s/TsdBeCtL2uUbuAff8cvTc25orLFvXcYdNbtjaCB82eRCQgNQd4s/N5FVmNvkdvqCkpBu2IWvx4bjBiQaamqx8JGoCZv9CU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792169525; c=relaxed/simple;
	bh=c+1wFwMtjYZL5jvdhQePrUCLHTKdHQahsHgz6+PHb6A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FqcSjNFhFHxLCH2wfWHRCjMBNJiS/YS2afA1oKV2TcpWwAjhUGJDfK6U/e12N/h65piXsKeK67NjaDb/ll0M9RvwOxqzS6Rp514Zg0SW7xr1wSxQsCgZP0wEWSdEal5LuTw5aTUJeuIpjzIAa42dUnzmdamBtjfBjIUQ8z0kif0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WfTQVS+J; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WfTQVS+J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64C4F1F000CA;
	Fri, 16 Oct 2026 16:52:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792169522;
	bh=kdNbANgrNe6FBaArNZERMwWSFqQ2R3GUk4nqF+drWwQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=WfTQVS+J3wvtV0uo3yPHbsgdpn49EjaUmbG3jQDgB+yi69lm00W0dTPOuPhbbaMnN
	 ZBf55pQamj6EuQx2dkdv6mLDLQlbW3UZZbXKptgukbAQx/EisU+Kc3ajJJUNlysBin
	 GoenRMLDyCIEFjVI3PisCj/DdKUSOygaK+V9UqJTs4+sNYy3u4SlT+JBkE/fWrXc1P
	 9MxGyiNx8hjRczzCXZdln08B3tDRhD0KED+kilkp3slP/sD8wrBDGctOi+d1hwRcnI
	 9SRIMtmDdztvim5ZSZLv9OholDK/m++yRBCMa27KdC9cJxqr4PmhyK43gV/lnAG3z6
	 HsrW5ZKiZTvuA==
Date: Fri, 16 Oct 2026 09:52:01 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Stanislav Fomichev <sdf.kernel@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com
Subject: Re: [RFC net-next v2 1/5] selftests: net: py: add timestamped
 metric output
Message-ID: <20261016095201.0f5686f6@kernel.org>
In-Reply-To: <20261005201115.2690830-2-sdf@fomichev.me>
References: <20261005201115.2690830-1-sdf@fomichev.me>
	<20261005201115.2690830-2-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  5 Oct 2026 13:11:10 -0700 Stanislav Fomichev wrote:
> +ksft_metric()
> +~~~~~~~~~~~~~
> +
> +Use ``ksft_metric()`` to report a numeric measurement for the current test
> +case. The helper records the time relative to the start of the case and emits
> +each observation immediately before the test result as compact JSON. For
> +example::
> +
> +  ksft_metric("throughput", 100.5, kind="scalar")
> +
> +emits output similar to::
> +
> +  # ktap-metric-json: {"name":"throughput","time":1.234,"type":"scalar","value":100.5}

Should time be optional? In case some test wants to report single metric
not value over time? Maybe just mention that it's an option if someone
needs it in the future?

> +When ``run_kselftest.sh`` nests the test output, its diagnostic prefix makes
> +this ``# # ktap-metric-json: <json>``. 

This sentence needs to go, it's out of place and obvious to anyone who
worked with ksft.

> A background sampler can call
> +``ksft_metric()`` repeatedly. Pass ``kind`` explicitly; it is emitted as the
> +``type`` field. Supported kinds are ``scalar`` for one numeric value and
> +``per-cpu`` for an array indexed by CPU number, with ``None`` for a missing or
> +offline CPU::
> +
> +  ksft_metric("cpu.utilization", [75.0, 22.0, None, 100.0],
> +              kind="per-cpu", host="local")

Should we say something about what the values for "kind" are?
Or should this be internal - IOW create ksft_metric_X for supported
types, like ksft_metric_scalar, which would be more self-documenting?

> +The helper does not infer the kind from the Python value, since an array may
> +represent something other than per-CPU data. Metrics are measurements only and
> +do not affect the pass or fail result.
