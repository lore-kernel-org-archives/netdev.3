Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6755221FD4
	for <netdev@vger.kernel.org>; Wed, 20 May 2026 00:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779237653; cv=none; b=ZmLN2QP/UCnWUo/0/XJErNiydM+UUTSXBsG6wfRm9O3CxQipiWtdA/jlH4r+H5kR/fxf8hYfjshLNYZn+deJSoQrIDmb5G6N/mwlbBlUjJkDsSp7XKFuX1UtAc1ooQawN0E4CD0AKN7w5eqDlc89Ftbvg/HLQ5KCsy1PMttYo+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779237653; c=relaxed/simple;
	bh=+Gjblp7M3nm3fb7Qqh70DRNtaSJm/lscaRx+1lLzqQw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fZe12rbXi0mM7yjFRrwljL+IIF0jM0Q1w+Wj5GBCiC6DLbw68RwgT8d5SEJ3xx0jXSn/fPvgYUHqcu7DZlW1IKjaSSVaCWl+q5Ov0gwMFOp/l3dtxusESzyRdhsOptupmr5Hi0Z4h88lnOJNalRZ/vhilVwe7foqWtSD7F1/3uM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H0t1IpZ1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H0t1IpZ1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82CD41F000E9;
	Wed, 20 May 2026 00:40:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779237648;
	bh=AWB3+5aE1Sgo9bbsCXjOYMPY8iPoSXHxVP/IKz6k3xg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=H0t1IpZ1mLARhzbzmOjcfRgipCpxhYOn51K2VGcwos3vzrc9+xhkGkfSRgW20oYCJ
	 Z9F2p+HGeuu5KsYZLzzD94sWtgHynPVtuMMKf+iefTKSsha223UYo43f6U6X9EN8fu
	 8QHvoVsJDdH/etAYegISMRdtbA7zg/Xliy3jTYUAjDz7v+G7St7SbU5fwHMUtoa9s0
	 MUfuh0PTPUSgxG71E3xW48xL5DkemN+8etYcVY2nDCtq/YLX2PCLo4RdTOiYjJ6TS5
	 XE02LExwYoiameq8fSSsLmq8a9yPRizAjO9X8ppC920lJb7TOfqA7u+HKOuS9qOubz
	 xUfxBqbVoEEMA==
Message-ID: <5c61b2be-49b2-4547-b343-4a87e2c9eee3@kernel.org>
Date: Tue, 19 May 2026 18:40:48 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iproute2-next 2/2] dpll: monitor: add -t/--timestamp and
 --tshort options
Content-Language: en-US
To: Petr Oros <poros@redhat.com>, netdev@vger.kernel.org
Cc: ivecera@redhat.com, stephen@networkplumber.org, vgrinber@redhat.com
References: <20260512135225.167158-1-poros@redhat.com>
 <20260512135225.167158-2-poros@redhat.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20260512135225.167158-2-poros@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/12/26 7:52 AM, Petr Oros wrote:
> Bring dpll monitor in line with the rest of iproute2 by allowing each
> received notification to be prefixed with a wall-clock timestamp.
> 
>   -t / --timestamp  emit a separate "Timestamp:" line before each event,
>                     using the default text form of print_timestamp()
>                     (matches ip / bridge / tc -t monitor)
>   --tshort          emit a compact ISO 8601 prefix
>                     "[YYYY-MM-DDTHH:MM:SS.uuuuuu]" inline instead
>                     (matches ip -ts monitor)
> 
> When combined with -j, the timestamp shows up as a "timestamp" /
> "timestamp_short" field on each notification object, the same way
> ip -j -t mptcp monitor integrates the helper.
> 
> The flag is parsed globally but only consulted from the monitor
> callback, so passing -t to non-monitor commands is a no-op.
> 
> --tshort has no short alias, so its long_options entry uses an
> identifier above the ASCII range (OPT_TSHORT = 256) following the
> iproute2 convention used in misc/ss.c, instead of consuming an
> ASCII letter that could later collide with a real short option.
> 
> Signed-off-by: Petr Oros <poros@redhat.com>
> ---
>  bash-completion/dpll |  8 ++++++--
>  dpll/dpll.c          | 21 +++++++++++++++++++--
>  man/man8/dpll.8      | 23 ++++++++++++++++++++++-
>  3 files changed, 47 insertions(+), 5 deletions(-)
> 

no longer applies to iproute2-next.

Fixup and repost. I think you can keep Ivan's reviewed-by.

Also, I merged main into next and had to fixup the dpll man page. Please
take a look (Ivan as well) at the merge conflict and the way I resolved
it. Send a fixup if needed.

Thanks,

