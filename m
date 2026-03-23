Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EB7830C60D;
	Mon, 23 Mar 2026 21:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774302066; cv=none; b=PZnds/0vLJVxdCv73ARxetWzGAolH4WJZS98iP0fzAJjPdEnvvhpBoGFGnJJpDft3UXyN5qsFVNKbrS0Y3CmkamiSy6sLA1BY67fufsH38FEH7Xljc994jN379Pf2MhR98FcbnFLLIDLRX2zs5RlBzQun6/iSeH7fWTcekEvpYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774302066; c=relaxed/simple;
	bh=h9j5i6CVG1YQYDEdZGesA63aAPkaeHJ8niES9bwYnSY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B3xOLciICfnFb9ESbNdDJZVzfShIUAirgqqvIjsu5/Gyn7KtQ313YVeGLi5mzpSddHn5bk/qFThl+7xhpFckioVf6uvrC/9qXf4z0Mhue5PIgtC5Hx/lm3A1pzq7dO4ZwwF5aLlnqNaWr4yJhxD4zpYUtXNqEDlfoPtGXHmcbu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sNmhK+pe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sNmhK+pe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA480C4CEF7;
	Mon, 23 Mar 2026 21:41:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774302066;
	bh=h9j5i6CVG1YQYDEdZGesA63aAPkaeHJ8niES9bwYnSY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=sNmhK+peFplKP0NeiIPzHuF6p50cWb1K0yhGxDKz5AG/dly6iNt1lHdOWkt05k+W/
	 8vhxqj7vvhSG9PF7AkfOrAohuc7nb57Lr4EiQIrgDxcj3rHevJwK/Bl0f3BnpS6cKs
	 eTE7t2cHxClcunDGncUYsub8hooz10ABlIROZPSR5TUcd5MaKhIe/lYa4AzQq0Wu9q
	 PpqQw9r8Uxp9m3ojIbaDJAMLZRxAiJHaT5DNiLh53GCQ/XKn0ZTqCfuOwiTgDejQse
	 IVjFzELfjxvc791XnFgcGaXXzTHbSKAvCy7HEZPLgNBb2Hk9jl0LMlEvqSb2//I37L
	 S4uoRH5d7Cl4Q==
Date: Mon, 23 Mar 2026 14:41:04 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Chuck Lever" <cel@kernel.org>
Cc: john.fastabend@gmail.com, "Sabrina Dubroca" <sd@queasysnail.net>,
 netdev@vger.kernel.org, kernel-tls-handshake@lists.linux.dev, "Chuck Lever"
 <chuck.lever@oracle.com>, "Hannes Reinecke" <hare@suse.de>
Subject: Re: [PATCH PATCH net-next v4 8/8] tls: Enable batch async
 decryption in read_sock
Message-ID: <20260323144104.091779c8@kernel.org>
In-Reply-To: <0cf288bb-6ab1-4f2b-8a7f-727b3e1fe0d2@app.fastmail.com>
References: <20260317-tls-read-sock-v4-0-ab1086ec600f@oracle.com>
	<20260317-tls-read-sock-v4-8-ab1086ec600f@oracle.com>
	<0cf288bb-6ab1-4f2b-8a7f-727b3e1fe0d2@app.fastmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 23 Mar 2026 17:28:27 -0400 Chuck Lever wrote:
> On Tue, Mar 17, 2026, at 11:04 AM, Chuck Lever wrote:
> > From: Chuck Lever <chuck.lever@oracle.com>
> >
> > tls_sw_read_sock() decrypts one TLS record at a time, blocking until
> > each AEAD operation completes before proceeding. Hardware async
> > crypto engines depend on pipelining multiple operations to achieve
> > full throughput, and the one-at-a-time model prevents that. Kernel
> > consumers such as NVMe-TCP and NFSD (when using TLS) are therefore
> > unable to benefit from hardware offload.
> >
> > When ctx->async_capable is true, the submit phase now loops up to
> > TLS_READ_SOCK_BATCH (16) records.  
> 
> It appears that async_capable is always false for TLSv1.3. Since
> TLSv1.3 is a hard requirement for both NVMe/TCP and RPC-with-TLS,
> patch 8/8 is moot for us. For the moment, I'm going to drop this
> one from the series. Once Alistair's KeyUpdate work is merged, we
> can revisit.

Excellent, I was about to ask you for the actual use case..
