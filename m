Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E62F2DFA4A
	for <netdev@vger.kernel.org>; Mon,  6 Apr 2026 13:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775483943; cv=none; b=b4mBrTfrekduh68/mNazl5Ah1u8LsvRVDRKuYd5+4ujcg4o8HF8kIGLuP4vwBSPwALut/0J+baKg1BN1/KNcu2KEjClw5uMMArraDhZZ96PePLesbZPpbJSUUq7PvjoVuPnPKTbEpP4DpVrwvp6Dk0+irb0dgIGCxHd8iIGWffA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775483943; c=relaxed/simple;
	bh=PeX5UkVx2rDi6O2/jL5XOx6oMr1qUDsYsbLmgLrlbj4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ESL80/51m1aeFDDAyTjauJAZldBNlRdtMBzN1Oo+DENF8IhJZAjwo/AfuUVXk7fDMt4N1KFj3FoyN9nlt7B9l3BmmIbbyJFN6pqG32lzYxlGBbj7YLyKZdAXdJU/Ud/9hF2FRVKutN0BCrkMLNwDOfj1GOQ2nRyqf6T8h//b1PA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ns5HWGtq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ns5HWGtq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EFE6C4CEF7;
	Mon,  6 Apr 2026 13:59:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775483942;
	bh=PeX5UkVx2rDi6O2/jL5XOx6oMr1qUDsYsbLmgLrlbj4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ns5HWGtqQJ6tmETv23q+ZfnXnaMmae4LRM/uKe/l3ezqTX0T3zFim6EqMpjm8mRVl
	 TxhUpMN0/Y6jwyV691LHwYs9gmKjMcuk8R3CGqVi85RXs8h+SreH9J7/Yjdz+BLWSu
	 7WuR1zkz0ZthaU5eJrVtpTO7raGQVYuqrZGmU3D7UZdjCgnuRPF40IPZq6aFWPSl2X
	 wCW0PFAgxvHwIPorji2MO1glm6DmnMGSap4YQX/hptoLxkyYF48F05toEJt63MlwOU
	 sleSGH3iFBXpwF2MkXzdNHU0rn4gp/rYcLRT5ou/94aV3CYFiDewjQtQTL5T4qoLc0
	 l29TE4Sqa3eXA==
Date: Mon, 6 Apr 2026 14:58:58 +0100
From: Simon Horman <horms@kernel.org>
To: Jeremy Kerr <jk@codeconstruct.com.au>
Cc: Matt Johnston <matt@codeconstruct.com.au>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next] net: mctp: defer creation of dst after
 source-address check
Message-ID: <20260406135858.GB395680@kernel.org>
References: <20260403-dev-mctp-dst-defer-v1-1-9c2c55faf9e9@codeconstruct.com.au>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260403-dev-mctp-dst-defer-v1-1-9c2c55faf9e9@codeconstruct.com.au>

On Fri, Apr 03, 2026 at 10:24:51AM +0800, Jeremy Kerr wrote:
> Sashiko reports:
> 
> > mctp_dst_from_route() increments the device reference count by calling
> > mctp_dev_hold(). When a valid route is found and dst is NULL, the
> > structure copy is bypassed and rc is set to 0.
> 
> Instead of optimistically creating a dst from the final route (then
> releasing it if the saddr is invalid), perform the saddr check first.
> 
> This means we don't have an unuecessary hold/release on the dev, which
> could leak if the dst pointer is NULL. No caller passes a NULL dst at
> present though (so the leak is not possible), but this is an intended
> use of mctp_dst_from_route().
> 
> Fixes: 22cb45afd221 ("net: mctp: perform source address lookups when we populate our dst")
> Signed-off-by: Jeremy Kerr <jk@codeconstruct.com.au>

Reviewed-by: Simon Horman <horms@kernel.org>

