Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E536A2DF13E
	for <netdev@vger.kernel.org>; Fri,  1 May 2026 17:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777657930; cv=none; b=HFHSsOp1WnqOWQylTafJp/7dz/YalgNHOOZeiPDfk26KnWAScfWgteGGtJ7AGe1c5vu3AAZjQva8kUMGTLRnwTFc6lefnhBZDPPX18TC2JAmrIAiOPn9RopuZ1Sq9tTENK694SyDfZHb/8iHaFUPVOwlELa9vVRYQ6bKiDIDvMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777657930; c=relaxed/simple;
	bh=hXQCcDR0vpUi453ZUvPAVwaVF0h9O28C+P40KAX3r2I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R3yqMHZxB23I6ST8zJu9NGHkDRlAHeLqqqO7bhqFsRk7J9LfwtonXPKEpW+0CqPk7KwXrvfaJ9l5rJeSTU9qhsXtpMBVwH7BUro8Rw+aRFmr/fMHjqCOaFMZxrsBjDIpykurvZYP6cVxyyk9QjjVK0BddjhX6JRWYnwCfJxlOyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d8RFcFTu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d8RFcFTu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50F36C2BCB4;
	Fri,  1 May 2026 17:52:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777657929;
	bh=hXQCcDR0vpUi453ZUvPAVwaVF0h9O28C+P40KAX3r2I=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=d8RFcFTu8irdpQldRtYjNEUhM27jENhNbrd+u2eJpDDtbas964boCsPJF9poO7Dy8
	 6Fxvt4lfBkF0Q7JDKHMi3zc7Kd5zV7MRPcSlErwUUL63AamNbIrZyXt8ATWkaFB5bT
	 1UrZPQbG5QI2PY6TvUje+H/QC+05nN7sdX4wTzsOUA5jZo6flXuxadTvfPJFDcdIbp
	 vgLd5Fcg0G/gMZpMfM7T4WwAfob6EXD7Dj39X8Fjdh5Iq05WpHPZMkX8hIirTkVuw1
	 Zzw1ATMobT0W7qnOcWR7CscBEXTL1mgwVms4Sry/SNhH5ZeFNoNMoQeQOllMfbnTbx
	 xGBEuZqqS4uhQ==
Message-ID: <d77d6d28-5d85-4145-a9e2-1c6d48cc621f@kernel.org>
Date: Fri, 1 May 2026 11:52:09 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iproute2-next 0/5] netshaper: Extend netshaper support
Content-Language: en-US
To: Mohsin Bashir <mohsin.bashr@gmail.com>, netdev@vger.kernel.org
Cc: stephen@networkplumber.org, pabeni@redhat.com, kuba@kernel.org,
 ernis@linux.microsoft.com
References: <20260501011611.3533573-1-mohsin.bashr@gmail.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20260501011611.3533573-1-mohsin.bashr@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/30/26 7:16 PM, Mohsin Bashir wrote:
> From: Mohsin Bashir <hmohsin@meta.com>
> 
> This series extends the netshaper CLI with missing parameter support
> and adds the group command for building scheduling hierarchies.
> 
> The existing netshaper tool only supports setting bw-max on individual
> shapers. This series adds the remaining shaper attributes (bw-min,
> weight, priority) needed for TX scheduling, and introduces the
> group command which ties leaf shapers to a parent node in a single
> operation.
> 
> Mohsin Bashir (5):
>   netshaper: Extract parse_scope() and parse_rate() helpers
>   netshaper: Add bw-min and weight parameter support
>   netshaper: Extend show output with parent, bw-min and weight
>   netshaper: Make handle id optional for node scope
>   netshaper: Add group command for creating scheduling hierarchies
> 
>  netshaper/netshaper.c | 398 ++++++++++++++++++++++++++++++++++--------
>  1 file changed, 324 insertions(+), 74 deletions(-)
> 

man page?
