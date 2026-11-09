Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=160.80.4.33
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794242876;
	b=i1DRhzJKNal7Y9vtTs/KsHwLQ0Xluc74IKpjq0qYVacl0k5mYhj1FIAF+hG33/RHVdW0
	 9UlZZUm9uFiGCndGt9m/WqSefvgrEWfJ9bXEGwewaihjMUwYSKFX8xc5rdh1xp4HCiM6W
	 Ujw/jJYyGTDHJcfZEe6+ZnoKbDRWj2hjc9WKCqt67kzMt2BPFBKJP2+sFQBId7vMIxDVF
	 lzOlutXVH2pd0uMXFqtnA79tV/uXwY2qYCPe74Lw3Sx5kKIyJOZ0hJLVG1PUD0zJXj05e
	 KgRznV2xEO2OqQncs1kKJvFDJY7mdw6QDXB09njUUTc9sIKYEBWF2ZkFnpaamqgKcGw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794242876;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:Date:
	 From:To:Cc:Subject:Message-Id:In-Reply-To:References:X-Mailer:
	 Mime-Version:Content-Type:Content-Transfer-Encoding:X-Virus-Scanned:
	 X-Virus-Status;
	bh=JyrVlOx5Pw/FngxAbjpQKaqtcPrR77mlf34YeVFjYvU=;
	b=e80X4cgQU2QIc7XqZLXK9EcgkNTkX/JiA9NN3/xNaEidWagg1d+auxI6GXqXP11SSWMv
	 VZHPX/v2lDkdW/h5STOtu1qrXtFMZE+1qvEfrYpG4AtK9dWGz1AaJOXF/7MvIA2APKByW
	 p7u4gVqTvZkdkmwX7f0QN/OH0i/tuG4pdNY/smEaxj2+VU1wfHnl5FaonhEox7MtccxXl
	 Az8c5IWtrd/4PHkzR/yZwgJPi2D55XCzBXfxdUfvF4wGJPFtdZ0EAAPnY1vdHINDz8DPm
	 3dmMGYj0Qq2ha7NHB1YuOLZ6/pmCUJ4XrLUJZdZ6xmbRPruXeAFvfvF8PFw4QUl4u6g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=uniroma2.it;
	spf=pass smtp.mailfrom=uniroma2.it;
	dkim=pass header.d=uniroma2.it header.i=@uniroma2.it header.a=ed25519-sha256 header.s=ed201904 header.b=5F1LdMql;
	dkim=pass header.d=uniroma2.it header.i=@uniroma2.it header.a=rsa-sha256 header.s=rsa201904 header.b=eFqLqCOw;
	arc=none smtp.remote-ip=160.80.4.33
Received: from smtp.uniroma2.it (smtp.uniroma2.it [160.80.4.33])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCB8A606A31C
	for <netdev@vger.kernel.org>; Mon,  9 Nov 2026 16:47:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DCB8A606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniroma2.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniroma2.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass header.d=uniroma2.it header.i=@uniroma2.it header.a=ed25519-sha256 header.s=ed201904 header.b=5F1LdMql;
	dkim=pass (2048-bit key, unprotected) header.d=uniroma2.it header.i=@uniroma2.it header.a=rsa-sha256 header.s=rsa201904 header.b=eFqLqCOw
Received: from smtpauth-2019-1.uniroma2.it (smtpauth.uniroma2.it [160.80.5.46])
	by smtp-2015.uniroma2.it (8.14.4/8.14.4/Debian-8) with ESMTP id 6A9Gl3W4005821;
	Mon, 9 Nov 2026 17:47:08 +0100
Received: from lubuntu-18.04 (unknown [160.80.103.126])
	by smtpauth-2019-1.uniroma2.it (Postfix) with ESMTPSA id 36FEC122944;
	Mon,  9 Nov 2026 17:46:56 +0100 (CET)
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=uniroma2.it;
	s=ed201904; t=1794242816; h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JyrVlOx5Pw/FngxAbjpQKaqtcPrR77mlf34YeVFjYvU=;
	b=5F1LdMqlYBzK4dYfy+9CEgiRlr86W3PLd9NUsQT6rP+I5zIi92pEmLq4JqCr4TjP9gZvq3
	3qNTecTOGxAjjoCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniroma2.it; s=rsa201904;
	t=1794242816; h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JyrVlOx5Pw/FngxAbjpQKaqtcPrR77mlf34YeVFjYvU=;
	b=eFqLqCOw3lkV2MY83uaTnOpfJrpv/3lBbyyAvoRIMUjJ2TITUOc8yFacE59SswzgEyEnqi
	NbL5DMYKVdPqijddGV2h4YdDS2zOW8RszAa2srWMNnX5ZmYdw2dLqH4Nd+UfjXdHzZyu98
	F52IG4opvGcqG10xYnohYJLgiESfDhxeZz0wmfnJ75bRtyyRmnxNwyrLRskcoEhqg6rKm/
	rD1zpPC7P0u/bZbd1sGrefQjf5RgPzUhgeYom6n+7j/cMJ41XUOMnx/4Mo9bq121dgiuXl
	gicea0YCNbw/yR1FxhhDzbIPh/00n4ZitjYK6IjzADq+bnoN/YJGxcWNw7xMsQ==
Date: Mon, 9 Nov 2026 17:46:56 +0100
From: Andrea Mayer <andrea.mayer@uniroma2.it>
To: Ren Wei <weir@nebusec.ai>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@kernel.org,
        kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
        contact@proelbtn.com, pablo@netfilter.org, vega@nebusec.ai,
        sashiko-bot@kernel.org, petalzu987@gmail.com, liuhangbin@kylinos.cn,
        Hangbin Liu
 <hangbin.liu@linux.dev>,
        Stefano Salsano <stefano.salsano@uniroma2.it>,
        Andrea Mayer <andrea@common-net.org>,
        Andrea Mayer
 <andrea.mayer@uniroma2.it>
Subject: Re: [PATCH net v5] seg6: validate state in netfilter continuations
Message-Id: <20261109174656.1c6267023862bf0a42b80465@uniroma2.it>
In-Reply-To: <8574739acd6f5d9eb0a5640e893122619e9f79ef.1793726355.git.petalzu987@gmail.com>
References: <8574739acd6f5d9eb0a5640e893122619e9f79ef.1793726355.git.petalzu987@gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.100.0 at smtp-2015
X-Virus-Status: Clean

On Fri,  6 Nov 2026 11:30:19 +0800
Ren Wei <weir@nebusec.ai> wrote:

> From: Zixuan Chai <petalzu987@gmail.com>
>
> When nf_hooks_lwtunnel is enabled, End.DX4 sends decapsulated packets
> through NF_INET_PRE_ROUTING. If DNAT changes the inner destination,
> nf_nat_ipv4_pre_routing() drops skb_dst(), and the continuation then
> dereferences the missing dst's lwtstate. This causes a KASAN NULL
> pointer dereference and fatal exception panic.
>
> End.DX6 has the same issue with IPv6 DNAT. In seg6_iptunnel,
> POST_ROUTING SNAT with an outbound XFRM policy can replace the dst before
> the continuation resumes.
>
> Validate the current dst and expected lwtstate type in each NF_HOOK()
> continuation before calling the existing handler. Drop packets with
> missing or incompatible state while preserving direct no-hook paths.
> The helpers return bool because callers only need a validity check.
>
> Testing shows that the End.DX4 DNAT reproducer triggers a KASAN NULL
> pointer dereference without this change and no longer does so with the
> fix. The SNAT+ESP/XFRM reproducer also completes without the reported
> fault. The in-tree End.DX4 netfilter forwarding selftest passes all four
> bidirectional checks with nf_hooks_lwtunnel disabled and enabled.
>
> Fixes: 7a3f5b0de364 ("netfilter: add netfilter hooks to SRv6 data plane")
> Cc: stable@vger.kernel.org
> Reported-by: Vega <vega@nebusec.ai>
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://sashiko.dev/#/patchset/20260720204430.1886091-1-xmei5@asu.edu
> Signed-off-by: Zixuan Chai <petalzu987@gmail.com>
> Signed-off-by: Ren Wei <weir@nebusec.ai>
> Reviewed-by: Hangbin Liu <liuhangbin@kylinos.cn>
> Acked-by: Pablo Neira Ayuso <pablo@netfilter.org>

> [snip]

Hi,

thanks for the v5.

Reviewed-by: Andrea Mayer <andrea.mayer@uniroma2.it>

Thanks,
Andrea
