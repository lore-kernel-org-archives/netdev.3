Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C7952D2488
	for <netdev@vger.kernel.org>; Thu, 23 Apr 2026 16:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776963544; cv=none; b=bRIlk6Pwy3n4bd4VhP8sDrZabqzrWnwotRvo+QlznqoOmvW0hdWAW4fWLPJTuJFRy1GqhzNMk5Fip59nAPv71KZECh1drRZqCV3f8ImVDkQU50fDCCraCcDjO64B3C2FsKSIK5fD9xVMJbQBd3yXkvVJHgyL9bsz8GP0m3d+xFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776963544; c=relaxed/simple;
	bh=HWF3fynQuO3pQwWRnZ31DO+K+HHAJDpLv0yXmAxCd9g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ABGyPaj9H5r+ccHNQiUpkCuswZEsi22KKvX4r8gmOY3QWSYboRgFw6aWcL5PmUgNubHSdyqbgGR0IHkBkqGoFq+ZZEEqIfOloeQkm33dpB/EgaRk20gv81izhTbjCqmB9wD6S1HFb700yUgeXe8hfC/wenqNTb7huNWpDmy2bKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gOZ4Z8IQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gOZ4Z8IQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7D16C2BCAF;
	Thu, 23 Apr 2026 16:59:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776963544;
	bh=HWF3fynQuO3pQwWRnZ31DO+K+HHAJDpLv0yXmAxCd9g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gOZ4Z8IQ6NqKs4G2m5bqTZDFzIX3P56QkXyJVv9e74wCnhd3n+dYPKjak4raCrWJp
	 ji9PwAfwf/GwZBLV7Nngb+AQJqpRJFZPFRVQwom0eulEiSvddyKJfPvZZ17lR21+DL
	 +uIx3hGlUP2WbCpfWdsiWSj75MFRWcDIlivQR+SIrW18Iqm+Bm7/qcPHQYgGc3O/4m
	 RgoIyO9B2dAY7BHP82u+LwlZDufnGTxKmuhB2nqlYVhtjj6/Cx7Y7cD0hbQDS0u3iT
	 4MHvGUQnpTRR2OyHuX1ragrLrvusuRwveJVVcmn8dvag8o6vP6mbFEoQ3kxW6W2pkL
	 B4Zqz/gMdvhwg==
Date: Thu, 23 Apr 2026 17:58:59 +0100
From: Simon Horman <horms@kernel.org>
To: Ren Wei <n05ec@lzu.edu.cn>
Cc: netdev@vger.kernel.org, davem@davemloft.net, dsahern@kernel.org,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	andreas.a.roeseler@gmail.com, yuantan098@gmail.com,
	yifanwucs@gmail.com, tomapufckgml@gmail.com, bird@lzu.edu.cn,
	caoruide123@gmail.com
Subject: Re: [PATCH net 1/1] ipv4: icmp: validate reply type before using
 icmp_pointers
Message-ID: <20260423165859.GE900403@horms.kernel.org>
References: <cover.1776563662.git.caoruide123@gmail.com>
 <efb2c33f544ece7727704608fc577525b415ae26.1776563662.git.caoruide123@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <efb2c33f544ece7727704608fc577525b415ae26.1776563662.git.caoruide123@gmail.com>

On Sun, Apr 19, 2026 at 06:19:18PM +0800, Ren Wei wrote:
> From: Ruide Cao <caoruide123@gmail.com>
> 
> Extended echo replies use ICMP_EXT_ECHOREPLY as the outbound reply type.
> That value is outside the range covered by icmp_pointers[], which only
> describes the traditional ICMP types up to NR_ICMP_TYPES.
> 
> Avoid consulting icmp_pointers[] for reply types outside that range and
> keep the existing behavior for normal ICMP replies unchanged.
> 
> Fixes: d329ea5bd884 ("icmp: add response to RFC 8335 PROBE messages")
> Cc: stable@kernel.org
> Reported-by: Yuan Tan <yuantan098@gmail.com>
> Reported-by: Yifan Wu <yifanwucs@gmail.com>
> Reported-by: Juefei Pu <tomapufckgml@gmail.com>
> Reported-by: Xin Liu <bird@lzu.edu.cn>
> Signed-off-by: Ruide Cao <caoruide123@gmail.com>
> Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>

Reviewed-by: Simon Horman <horms@kernel.org>

Sashiko has generated a review of this patch.  I do not believe the
problems flagged there need to be addressed as the array indexes used in
those cases have are always valid.  However, I would appreciate it if you
could look over this.

