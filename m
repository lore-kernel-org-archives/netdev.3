Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 279A064
	for <netdev@vger.kernel.org>; Fri, 20 Mar 2026 00:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773965143; cv=none; b=q+NCFLzSB9ee6D1hzydyeN09OOMnVzAFLmZmboJi3ZHja2qMIO2WpoVZemJCh6A4qWtr8xlLA4FZDg+6p1amyNOPExmrMIl7nDzrsTHTfL1s1C7v8KHBxB6DWfA4P0uxn/7LmbBjuGUtaF7hG6hN2h/KqW4/YkiKsEG8ag81uMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773965143; c=relaxed/simple;
	bh=u9a+HUSNrVAAkzh+T44LxcUv39YeiUyKUwSvhq39FXw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KYWFc7b3OjQ6bk+R752149+qqUfpkSKVG6ChIwnC5i9NIYhVKoR1zUA/hEnT93cIKtEWRYWiHgy50TWN6v/fNTGTjo5DeXX1a7u+aiC5IzlPy32jOHxVgCUTMxbTLuAZjYlX/nANXdy22gz2y6fhDjGephGEMehbcb8wXU9QgwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ICagL03F; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ICagL03F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2A9BC19424;
	Fri, 20 Mar 2026 00:05:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773965142;
	bh=u9a+HUSNrVAAkzh+T44LxcUv39YeiUyKUwSvhq39FXw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ICagL03FQUAl2azxm9C0rk69ndgtpCaoiPUdyEhBm0CSS7lv83j4TTf2wsPSOX0Ws
	 ezTkVB1blxCx6PTCqGc5wNGcmF/1Wdt8jdmnFCuORwISTCzr4skXwEnyoF/ReiI4L4
	 v0pXPnUPCLXkqDPAWBC0gTj7lidsXOjUhY60yGkxiKooXh16BsKY3dHOJullNDJd3e
	 LXtazxi8Dh2DzqOYKFyMTr1UmaDDrhxXobLkv3SCGbQPcX5HhWzN9TTa8tk/k1heJe
	 mbyZzTCkaLD6PopoBlnwF+JN5Wb53I+i0Q5nZTIKcktpgG3slP0O1Gam6tSyufnmRA
	 RII1unK3HFZ+g==
Date: Thu, 19 Mar 2026 17:05:41 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, Kuniyuki Iwashima <kuniyu@google.com>
Subject: Re: [PATCH net] rtnetlink: fix leak of SRCU struct in
 rtnl_link_register
Message-ID: <20260319170541.27c75eac@kernel.org>
In-Reply-To: <5ed5489ecdd05c43bd551804f3bd020ae349f3ca.1773849195.git.sd@queasysnail.net>
References: <5ed5489ecdd05c43bd551804f3bd020ae349f3ca.1773849195.git.sd@queasysnail.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 18 Mar 2026 17:15:15 +0100 Sabrina Dubroca wrote:
>  	list_add_tail_rcu(&ops->list, &link_ops);
>  unlock:
> +	if (err)
> +		cleanup_srcu_struct(&ops->srcu);
> +
>  	mutex_unlock(&link_ops_mutex);

Does the cleanup have to be under the lock?
