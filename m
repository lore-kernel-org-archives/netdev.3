Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC95030567B
	for <netdev@vger.kernel.org>; Fri, 15 May 2026 15:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778860718; cv=none; b=YzbjObUBwafNf/9/R/U3ZanleBLSMPz7D9O5Agf6e/GXB2WI32mjjbm0T8E+UYMaZRJ+nVArApSVhz6sCUGXRehFRzwusm0rKwant+qox7Q5+5LcwRlx7AjTotMt8ZTJzFr/f468tpe7HtP7f6hxBvlX1J4ldcNlaA3uzBt1nYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778860718; c=relaxed/simple;
	bh=ifCFt/SS0qOZ/K0hcR9GN9TBxEEXku3gNf00TnzqSBA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EZLEmxOealUiX4b9Dd78s2pzQrwsYkp0sNDCTCxFQ3kmhJ69YH+/PEUSKlJIozW08UhQASNoqIjruAttP+NDoSa0/0UuYO9PZgsF4yzxEdTC2PCTHyW1pcyFbhoFtBMd4jpkqlDarCaIeESgcNN+WbVsoAc6ICqSQLVqM/Ny15E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=meyXdl+5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="meyXdl+5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87DA2C2BCB0;
	Fri, 15 May 2026 15:58:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778860718;
	bh=ifCFt/SS0qOZ/K0hcR9GN9TBxEEXku3gNf00TnzqSBA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=meyXdl+5Z8iwfc1uAH00+m32Hz2Qqy7xF7ycx0oViPxaufixDXAXucFOweKv6Feto
	 nJM2V5FX1/U1/OKb0ueOq8JS6thpB8yxPtymtmWy0dvMB4mKEgBBbeAyIOryUMVC0f
	 CiJ9RtuiuuSwgHUD3RNI+GkWdgbe39KsAUN92nDM8skwDRP18PfpdxETSkNjdMTUwv
	 +PDpWD8oTMEb/5q+zENZff4vvV7RV3bBWzGd9g4vIt2uM4Z3pgdJrPOxRvzo1tVcZp
	 H9/GvT2Uduah6atnY/tXkPZRrHySJtTxF1IPSXy4ZLrdJw6DoIOuzpGjYdPsbFudnM
	 5Dd7Mqi0jMzjA==
Message-ID: <90c9c8cb-f547-4e60-8ce9-5e54fc38cb37@kernel.org>
Date: Fri, 15 May 2026 09:58:37 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iproute2-next 2/2] dpll: add fractional-frequency-offset
 to parent-device
Content-Language: en-US
To: Ivan Vecera <ivecera@redhat.com>, netdev@vger.kernel.org
Cc: Petr Oros <poros@redhat.com>,
 Stephen Hemminger <stephen@networkplumber.org>
References: <20260513145115.174597-1-ivecera@redhat.com>
 <20260513145115.174597-3-ivecera@redhat.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20260513145115.174597-3-ivecera@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/13/26 8:51 AM, Ivan Vecera wrote:
> +static void dpll_pr_ffo(struct nlattr **tb, bool top_level)
> +{
> +	const char *fmt;
> +
> +	if (json || !tb[DPLL_A_PIN_FRACTIONAL_FREQUENCY_OFFSET_PPT]) {
> +		if (top_level)
> +			fmt = "  fractional-frequency-offset: %" PRId64 " ppm\n";
> +		else
> +			fmt = " fractional-frequency-offset %" PRId64 " ppm";
> +		DPLL_PR_SINT_FMT(tb, DPLL_A_PIN_FRACTIONAL_FREQUENCY_OFFSET,
> +				 "fractional-frequency-offset", fmt);
> +	}
> +	if (top_level)
> +		fmt = "  fractional-frequency-offset: %" PRId64 " ppt\n";
> +	else
> +		fmt = " fractional-frequency-offset %" PRId64 " ppt";
> +	DPLL_PR_SINT_FMT(tb, DPLL_A_PIN_FRACTIONAL_FREQUENCY_OFFSET_PPT,
> +			 "fractional-frequency-offset-ppt", fmt);

something is not lining up for me: the attribute is
DPLL_A_PIN_FRACTIONAL_FREQUENCY_OFFSET_PPT here but the fmt statement is
still fractional-frequency-offset and yet name is
fractional-frequency-offset-ppt.

Also why the use of DPLL_PR_SINT_FMT instead of DPLL_PR_SINT which
avoids the extra fmt argument?

