Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793621109;
	b=UQ7zqurRyjBo2LsMPux8MJh/HFojYWtzRzkmTCyp8L3QcHryvWw2LkNU7QIAmg8H2OFX
	 fEfOdHiJsAeNiT7W71+Rxqk+6oPWCxWHT7FdLKlHHx8U8KYGr/SSzIYPepaQnc/OVLW0A
	 LpIcDk59cn0S2n23nXJ7AR+7U3Whab7u53yYvRujC7ZyLx68t/friiO73DfzyU1XLFvFv
	 TffpiehmbnhiTT5GzQGHlLJFStNVQuJcUHjxDJOcwiPj63vgF1vG+a4PXNQm13G3btbXC
	 7wN05a35q1XJQ0dS4z2mSoWXgZe2Q+OUlmIUF3XMFJh3UvcoxZrD49a24w6hu5gtDxA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793621109;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=hbeE3DAarKR8X1vVzLm4gObAcCpbrHaGz2CUHydJifQ=;
	b=JJR7k7akZR0ooe6drIGJ2eb3KUpM2LL7yWMVOciWyM4hdN9epTKSAcw1c4Yw40y0UDJt
	 wtrXA7WNQXb4aap77IisBt/7/VDs5CdR8OkTyHQ79su0T+salQSzZPo2FG1SMIWFV7U4w
	 iOdfBfDH8en1D5uzGgN8ll90C4KlG2fxPL0dBR260D9m07OuVXAT4ufVALhN7sFi/Niaa
	 SJngZU8nEMyz6Ojv9sLpiJJ5+IxISZNp7jqueV6FTm3YVmk8+8jTVXgmEbAoPvGkbUIsz
	 ErQgwQI/4zTbqHQSvivrtTOjF3668XLTY73Tr9mnc/zNPoeVRI2gVoAFaPG3WgOaFlA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="CI4tiV/m";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B97A0606A329;
	Mon,  2 Nov 2026 12:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CI4tiV/m
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED26E1F00A16;
	Mon,  2 Nov 2026 12:05:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793621108;
	bh=hbeE3DAarKR8X1vVzLm4gObAcCpbrHaGz2CUHydJifQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=CI4tiV/m/CL1DJSchDXuai0U/0ncux81CJqiXpACcL0MZCLGMTYrBYLMUljUzRRZ2
	 naaTp6eYmL4wJqKeSsmdlNKvLL+o3akIjJdyFY3HhCJ1w9TCY9DU3YzBW1IBKXwTzk
	 gtRHibFYVdrZVVdpPdo5idhN4vls+Pq7fVnzQl6XmRtxrUCYwTrchc/H6sQ8mketwZ
	 mPiGAm+lyr4JKfxRZm+T83/4RXagFUjX73oeMX+Cj79eYyw5nmQiLywoxuVv1Dh43T
	 SO2HUs8iTBv9izk82juLaep2/50y4QV0zcJ6gjnrw//xkHNSOft8FlMirHAf/4GSuN
	 qsTlsmmKLp3XQ==
Date: Mon, 2 Nov 2026 12:05:04 +0000
From: Simon Horman <horms@kernel.org>
To: Linkui Xiao <xiaolinkui@126.com>
Cc: jiri@resnulli.us, davem@davemloft.net, edumazet@kernel.org,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Linkui Xiao <xiaolinkui@kylinos.cn>
Subject: Re: [PATCH net 0/2] devlink: do not dereference a missing param item
 or shared buffer
Message-ID: <20261102120504.GD257209@horms.kernel.org>
References: <20261030033332.3685172-1-xiaolinkui@126.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261030033332.3685172-1-xiaolinkui@126.com>

On Fri, Oct 30, 2026 at 11:33:30AM +0800, Linkui Xiao wrote:
> From: Linkui Xiao <xiaolinkui@kylinos.cn>
> 
> Two devlink helpers look an object up by id or index, warn when the
> lookup fails, and then pass the NULL result to code that dereferences
> it. A driver mistake (a param_id that was never registered, an sb_index
> that was never registered or is unregistered twice) therefore costs an
> oops instead of a warning.
> 
>   1/2 param: devl_param_value_changed() hands the missing param item to
>       devlink_param_notify() -> devlink_nl_param_fill(), whose first
>       statement dereferences param_item->param.
> 
>   2/2 sb: devl_sb_unregister() runs list_del() on the missing shared
>       buffer; list is the first member of struct devlink_sb, so it
>       reads and writes through address 0.
> 
> In both cases every other user of the same lookup already returns right
> after the warning, so the fixes just align the remaining callers; there
> is no change of behavior beyond avoiding the dereference. The param side
> follows the example Jiri set for devlink_param_unregister():
> 
> Link: https://lore.kernel.org/all/20230126075838.1643665-5-jiri@resnulli.us/
> 
> Both Fixes: tags point at the commits that introduced the unguarded
> WARN_ON pattern; the current devl_() functions are pure renames of those
> originals. No in-tree caller triggers either path today (the audit is
> part of a defensive hardening pass), so both are aimed at stopping
> out-of-tree drivers from turning a driver bug into an oops.

Thanks, both these fixes look good to me.

But I do wonder if the hardening aspect, from an in-tree pov,
makes them net-next rather than net material.

I say that, because my understanding is that there is some pressure
to only push critical bug fixes via net. This is because of the recent
up-tick in bug fixes driven by AI-related activities.
