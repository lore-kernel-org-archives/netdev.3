Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 832B7288C30
	for <netdev@vger.kernel.org>; Sat,  4 Apr 2026 09:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775296590; cv=none; b=XEJ457PSfJF4jnQAmTO/IBh36ekkeWOvnIHtU/ijODzLTbjNTtiGIGEbqoRyd6ARXyhBu8MI4XdFN4uW1qKxVdehigNj+wRVS3+GFmi8ykQ3wVQBGxc5m49zQ4odb5ByAK9vLL63X6DxCgLwd7UcUnvkqCpuVUK29EgRS6am6/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775296590; c=relaxed/simple;
	bh=EHEpMniwIHOZ6/r+AlZSaysXedBfbFrCyNCdnIX5QSg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LkepUf1AxpDWP5fdVJLilpBzQX5Z3LJ/fMGqYWOAhvTKbfkaVPjFsI9LGPBKqXtcjpf6kQeBa48IGa7fiYQxNa9ivOkB3gEQBLIaqgs1LtK0pC1sBoLiUbjIVBm8hY+HMeP/nD67PgSEffrTkhp4qoEVqgmIRthbEoi+f+UEtvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EpFInEa3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EpFInEa3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 913E0C19421;
	Sat,  4 Apr 2026 09:56:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775296590;
	bh=EHEpMniwIHOZ6/r+AlZSaysXedBfbFrCyNCdnIX5QSg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EpFInEa3iA2hKMnR92Z+WlJRkMpt167QjKW6f0a2bsMbDpI6bou3HngwHVgDt/jG6
	 +M193pykKv2VS3SjKzhndZOpitGbAWuF6ZGYa3aWfeJrukVNvTiOg9Hmn771w5d4Rx
	 PSb/Lrd1Z6IaXH95EhT9nO0DfNjhj8/7028nC8zE+Jrxf4aSeT1i9j9U1YUV8fMzAa
	 3ktpXupLtNp/0wFEfc/DVcylP6pvx5MJ1xtb5Uh7/IzuMEbp2SywwgnKiD8txsH5wP
	 rs/zqoNS7bUO0biXxF1Vr99n07RVmgoI1//Tx3oCNjPCwK+mx15wV2FB31KzmWFCRk
	 ecSmj+c5OfnMA==
Date: Sat, 4 Apr 2026 10:56:26 +0100
From: Simon Horman <horms@kernel.org>
To: Jeremy Kerr <jk@codeconstruct.com.au>
Cc: Matt Johnston <matt@codeconstruct.com.au>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next] net: mctp: tests: use actual address when
 creating dev with addr
Message-ID: <20260404095626.GB113102@horms.kernel.org>
References: <20260403-dev-mctp-fix-test-addr-v1-1-b7fa789cdd9b@codeconstruct.com.au>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260403-dev-mctp-fix-test-addr-v1-1-b7fa789cdd9b@codeconstruct.com.au>

On Fri, Apr 03, 2026 at 10:21:04AM +0800, Jeremy Kerr wrote:
> Sashiko reports:
> 
> > This isn't a bug in the core networking code, but the addr parameter
> > appears to be ignored here.
> 
> In mctp_test_create_dev_with_addr(), we are ignoring the addr argument
> and just using `8`. Use the passed address instead.
> 
> All invocations use 8 anyway, so no effective change at present.
> 
> Fixes: 22cb45afd221 ("net: mctp: perform source address lookups when we populate our dst")
> Signed-off-by: Jeremy Kerr <jk@codeconstruct.com.au>

Reviewed-by: Simon Horman <horms@verge.net.au>

