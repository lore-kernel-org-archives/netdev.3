Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BF9A2F6920
	for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 14:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786458533; cv=none; b=ar26zn+2TlUaiAOBVciwh42rnTsLPc3UqyBoxB385G3vCe1pdyUI9hR9Ty882P7rtnBDEBSyglnyLXmk6DK9yPK/O3fz8YtL0XH9ar28wJFGCDhXft/a+rOOHLCcvqRg134NV2wbCBIaEXvvq69qTZOOcsNDS903yano/eCzCtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786458533; c=relaxed/simple;
	bh=Wbc9IfOjV5H4ec6lOc+QbDakGqTjVdtakkEe9EPpLrw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X9g+3KWmdYM1OyidRLUX2isBbyMYTZMJ1p5CDubTq+J0Vwk83rDuv8BZaUcB6d4zu2276XC8kiYnypIx4uCUkVIi//wzqmc/uruWOH5NLEBluphyFEVb4d0RLJq1L3yR9pMCNDGHKQjIyaVZlNPnk9zjm+y9Hlcx4AVW+20nMXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TA1SuRNK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TA1SuRNK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93FD11F000E9;
	Tue, 11 Aug 2026 14:28:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786458532;
	bh=66sN+L8b+lr6QL01ITa3loSsO7X33z8Meqm3XjvWyHw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=TA1SuRNKMpb1H7R0qJTRoExcfvGpMSkaW8Nt17dAvW/iTWLqjMlpzwgPBm3r9p9IQ
	 IFP5uhbQwARO5xyEbVD6A9+aK5VQryjAvvayEu3k3K4niJjxbFrKxLuIjwQl3Io/O/
	 /kIw6t6n2ZDKkn+kajRK8CGOB7XjZtFW/Kq5rnY7z90he9FVJ9ZAfqGVVWwVprUomn
	 Q88BecS8jDhnKS4jmDVsRL9LhTlozKFduJkzIMP1bs/ZAzSarqoDmoue3Ki3ghg1g5
	 xjYyrIZbdu/XUA4Oe/AunZK5KIdDQT7wnoV0W2guXE7LB4reD5zmu6wkVPo+AYCkd9
	 pMIanepaai75g==
Message-ID: <040c79a4-a69d-4c84-a22d-603527264d8f@kernel.org>
Date: Tue, 11 Aug 2026 08:28:51 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 net-next 04/15] neighbour: Remove unnecessary
 EXPORT_SYMBOL().
Content-Language: en-US
To: Kuniyuki Iwashima <kuniyu@google.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Ido Schimmel <idosch@nvidia.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuni1840@gmail.com>,
 netdev@vger.kernel.org
References: <20260811022448.116235-1-kuniyu@google.com>
 <20260811022448.116235-5-kuniyu@google.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20260811022448.116235-5-kuniyu@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/10/26 8:23 PM, Kuniyuki Iwashima wrote:
> Commit 1bf20cc62a54 ("neighbour: remove obsolete EXPORT_SYMBOL()")
> unexported some functions in neighbour.c because IPv6 is no longer
> built as module.
> 
> Since it unexported neigh_table_init(), no module can register
> neigh_table dynamically.
> 
> Let's unexport a few more functions.
> 
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> ---
>  net/core/neighbour.c | 17 -----------------
>  1 file changed, 17 deletions(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>


