Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB57C36A017
	for <netdev@vger.kernel.org>; Tue, 21 Jul 2026 00:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784593990; cv=none; b=nXLQ+fqk5Hl+dSlv3IZ+SqA9+4A4ygYQu4dvSC4AyWwEC3Dp0PNQ1KpimXRHbiVslITMqxIKsKctguz9l++MhfgeAA8fTO61KTZU1VgRH/in+0cf3ZFxak1QA5UD4bqsg+Kdbi3c8nygGYYf6dSiAGP1phiEDCXUBGbxVK8XsFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784593990; c=relaxed/simple;
	bh=MUBpS1XJH7zRX3wTBzgdXQDVOjb/+Jv/yFoVlhDV0HU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hTjLV6Qi9aXKiSmgVtK3xav6u4KAFqNt48G2GvbC22Vtnfah+B8mdKK4d+ADyOZIqkwL2csLoeF4ohjVDsEWwEqmJ3v5rzy1nZOpMWM2jrKpw9Rzdiaur7Q3+3Br3nZC7wfyG3zMDCAXzyZjoGp4rb1Ov/YmfmEYoom32aA+Qdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xcgfqy2z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xcgfqy2z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3139E1F00A3A;
	Tue, 21 Jul 2026 00:33:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784593989;
	bh=/P62JBrvG20JFu7tRgq4YMcf2uKXTk1JTRsRYXdUoKo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Xcgfqy2zwfTlLCd8m5w2hg7tjmdF+/RxzKxkqp6Q1lqTRIZiu42/4MdPrErADG27g
	 xZoogcNCKwl4gp6XW1TIhrP3FsiF2/S8fV16+PBjbzNfaK7xw4shzOLtRRsRgH1345
	 vJLYW8siN9ZenuHjeHpoXgDs1aA4k3xbztfEqSrNEQI4CEiDeUy4Qo7bmpTO/1dSCI
	 xXYzFobJ8PRRQDjNGDjkTVhsD8z0F/ux8cJPUIHXW8++BnaEM/WGYyhHH4CEasC9K/
	 XQuecu4FKfCeDRWrLV4SaUO1QeCWzP3yE+aZtDj3rlE3URNlc9XXmtkO1mtYurc3MV
	 4uqvl6zoCHA3Q==
Date: Mon, 20 Jul 2026 17:33:08 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Florian Westphal <fw@strlen.de>
Cc: Dharmik Parmar <dharmikparmar2004@yahoo.com>, netdev@vger.kernel.org
Subject: Re: [PATCH net] selftests: netfilter: conntrack_resize.sh: fix skip
 exit code
Message-ID: <20260720173308.4a3bb77a@kernel.org>
In-Reply-To: <aktQ5kLLtdG3pn3W@strlen.de>
References: <20260705204252.630729-1-dharmikparmar2004.ref@yahoo.com>
	<20260705204252.630729-1-dharmikparmar2004@yahoo.com>
	<aktQ5kLLtdG3pn3W@strlen.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 6 Jul 2026 08:53:55 +0200 Florian Westphal wrote:
> Dharmik Parmar <dharmikparmar2004@yahoo.com> wrote:
> > When conntrack sysctls are unavailable, the test prints SKIP but exits
> > with $KSFT_SKIP.  lib.sh defines ksft_skip instead, so the kselftest
> > runner did not see a proper skip.  
> 
> Acked-by: Florian Westphal <fw@strlen.de>

This is tagged for net but FWIW & AFAIU we haven't applied it.
