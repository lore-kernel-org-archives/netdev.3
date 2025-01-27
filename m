Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F0AA2AD1C;
	Mon, 27 Jan 2025 23:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738018876; cv=none; b=LZfKkJmXlUlfbQVd3qLT3C/T4MAvG0YL/vMgPG2vxjoAW8cVwEkMEDNvY05zy3jPhWf9xwy+lrosNTQ0kMnVo5tpEnPgFvFWTNxb7BXeRicrxoLYMcQBDUPRMEfuSrvBVMWJTLNsJ2tRjiW4qIzwN82aq9y4o9RMytBtiL7xpBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738018876; c=relaxed/simple;
	bh=zHaJ24cQkJtZVzuNZtIZQVNFnCV2F7Q9RkEH+q3Ofeg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OqwIA/F9c9XIx65aMsF3XRSb+H9+uva9heqpbMH2I/2UftDPOD35SGL+u5ocmNuEDD4VfNdmu7k4URdufnHjud/vgfJYKod+o6tZaFTtwWxU5ScSOWE+2zPKZ2gQl9Dl3R/hVHFJi/QPOCGCE5iKFwwAvpKhr628kAoYuj0c/yI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gXJ1ezjD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gXJ1ezjD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BB61C4CED2;
	Mon, 27 Jan 2025 23:01:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738018873;
	bh=zHaJ24cQkJtZVzuNZtIZQVNFnCV2F7Q9RkEH+q3Ofeg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gXJ1ezjDr3B8d4Q54UcBfUrghCbdj9PxvqvV/fzIVnWnlAD7qTsexjHl4fXPywhN8
	 eBd3HuI4b1EL5zYWd23l/tQ9x0ZmXeqh6hZVB13B/2DaI1dZ22en+xpCUo3lsDLsNJ
	 I6M5mRDIrPNQp/LUo0TAw9Be5NkY+dXikz3FPepC32BeU0FcWa5s3c65LoUz56B02j
	 CoIRSuufrXsqQipqOkeBKM7ta6kwxt8DE3FERhOUd2Xnzcd0fn6SMnCEIb+mv4EUgx
	 Zhx3dOShbEJ5XIOWHwckrsuKuleqGQOEO9n7aRyFAKhUyn2Ifl6Xj7/eFqJHjgZ8ow
	 8D8b6Og2Va+UA==
Date: Mon, 27 Jan 2025 15:01:12 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: netdev@vger.kernel.org
Cc: Shigeru Yoshida <syoshida@redhat.com>, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 linux-kernel@vger.kernel.org, syzkaller <syzkaller@googlegroups.com>
Subject: Re: [PATCH net] vxlan: Fix uninit-value in vxlan_vnifilter_dump()
Message-ID: <20250127150112.5e395327@kernel.org>
In-Reply-To: <20250123145746.785768-1-syoshida@redhat.com>
References: <20250123145746.785768-1-syoshida@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 23 Jan 2025 23:57:46 +0900 Shigeru Yoshida wrote:
> +	if (cb->nlh->nlmsg_len < nlmsg_msg_size(sizeof(struct tunnel_msg))) {
> +		NL_SET_ERR_MSG(cb->extack, "Invalid msg length");
> +		return -EINVAL;
> +	}
> +
>  	tmsg = nlmsg_data(cb->nlh);

We really should have a better helper for combined message length
validation and nlmsg_data(). I'll add this to our list of outstanding
cleanup tasks..
