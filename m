Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DB7F3164C7;
	Tue, 12 May 2026 23:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778629010; cv=none; b=jq9Vm98hQOZJkEN3jytoAZAALnGs7tjv3a+oSRzC0eTQpmDANaLUA4YFiOEls79K3YPzuVpz+7hdqkjrsr3APLHu4SCEpf7JiE3SriQzYet9PcWIU5j7mWwq42EAJtoSGxvsyo0XHd2ggbWssZHv0zvwPZ3rK5DdNf4rwbqRZ/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778629010; c=relaxed/simple;
	bh=dG0qSiXkRjgk9udIoctxC1ci5W6OuKyLB5frEI3/g9U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kQ/Gw83eqDHriJomCx4QI446/SQasQSu7Sw+RkcwIsWnmVjKmUAxPC4mqenkQswZnBWNHCJraZIpthUqeyvZmK6dIKzCNuXrw/DqBCyhFytEGpkA5y+e23QQ5GdJP7Crfirf/Tt/NAFYxD4vmsBAlfiFATvZrH2OcluI+wVovdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XaaI+9Oh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XaaI+9Oh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BBABC2BCB8;
	Tue, 12 May 2026 23:36:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778629009;
	bh=dG0qSiXkRjgk9udIoctxC1ci5W6OuKyLB5frEI3/g9U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XaaI+9Ohw3HbswEw5cwwwypUXcpSb4T1bYEOULjEXVxK4opt/E99WmEfpxX6/WN+h
	 3pUi5f+0ns6S63PmgPBW3BzIdVoH1jt8DcTLcCHVskrMYbQsOBzx39/8aBKHX8RCqG
	 H0prEap6Ta7dr0IDeabPKbmunhl6KeUQbmkgvjj4pwkcbp7BSP8Xvvr+G9G41JEt63
	 nv5KJdOrFdV77haJVmXYKImeROtweVz/OvyAiJgh6AbamWYIRMb1t+VdGT4ZmZPdRp
	 akuhrYjOGAVY5k8NGrvMW/Pao52dOwQACgHGsgoqgCntpHSzrfSiy+6mnRZZMbj5c3
	 pMYJ+keFd+lIg==
Date: Tue, 12 May 2026 16:36:48 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: f6bvp <bernard.f6bvp@gmail.com>
Cc: toke@toke.dk, stable@vger.kernel.org, davem@davemloft.net,
 netdev@vger.kernel.org, pabeni@redhat.com, gregkh@linuxfoundation.org,
 linux-hams@vger.kernel.org
Subject: Re: [PATCH net-deletions] net: remove ax25 and amateur radio
 (hamradio) subsystem
Message-ID: <20260512163648.7367a640@kernel.org>
In-Reply-To: <20260512144512.9960-1-bernard.f6bvp@gmail.com>
References: <87se8mytvv.fsf@toke.dk>
	<20260512144512.9960-1-bernard.f6bvp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 12 May 2026 16:45:10 +0200 f6bvp wrote:
> Each patch carries the appropriate Fixes: tag and a Tested-by from me on
> real hardware. They are visible on lore.kernel.org.
> 
> Since ROSE will no longer be maintained in-tree from 7.1 onward, the only
> remaining users are those running current stable kernels (7.0.y and
> earlier). Would it be possible to have these five patches queued for the
> stable trees via Greg's stable process?
> 
> I am happy to resend them as a formal series tagged [PATCH stable] against
> the current stable releases if that is preferred.

Could you perhaps target the OOT modules?
https://github.com/linux-netdev/mod-orphan
Does it work with older kernels? I think I compile-tested it but didn't
do any testing..
