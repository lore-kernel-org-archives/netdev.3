Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 082653B2FD0;
	Mon, 20 Apr 2026 18:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776710500; cv=none; b=bGFq3RW7zBiqkPEIa9YoERfpWI/qoHPKUML6lCEdDWVkmFuVBZNQHBu4UwwK5YhzWPM7k7GqSXKbpF02W7BN8DBai5kHplBF9sMEcDSJoBNP2Erdym6XxWFKLCP+Pf9wtoTUJb2jx2GagSBYNGnkg7VC/QWQtkrAtoIr2pDWRB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776710500; c=relaxed/simple;
	bh=R05IH2Al6b4iC0lOGI1u+RyILJR2u5tdxDllHeyNEZ8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uOnLQbK2oYtGuz6Zfp7tH91fsC33Q7bGQ/Grp9zbyjDwnjjkhBM3v/RyJ1ld+INX4WdWZk23nleP1tBarzeqx8ZxICM9ratyZGlx/o0iu3quw7E5lqO9QsV2HBUbC8cCsC65letrAuVN3nj5Tcw7B4aaoENmJNCYwlOqK1JCKU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wiionazi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wiionazi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31E2AC19425;
	Mon, 20 Apr 2026 18:41:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776710499;
	bh=R05IH2Al6b4iC0lOGI1u+RyILJR2u5tdxDllHeyNEZ8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WiionaziXM5Wh9qXlHTyY6TXCo1blIYyIf5rMBYd9zfNFrdK6RPD9t9iW/k7LT1NS
	 60A5rxC2CpxVxZIV3dcW0FigOiTMU3965VzQEjl3f72S9ijs+7ko80gi0tPblR0POJ
	 HGPCGTeUW5JdHbpeyNtWEJliLwFWpz3B+b4lUJveaeRiFrUFF2Gfw6liuqIW/iLykF
	 eXCiFt+T8gCuHV4bl+PzqpajI/za5E/l1PZXkZNcsZdFfcUt4rPEk7TRrs6e8CI18b
	 yepTs0Z/KEL/unjgMWAvEL4JJLF8YFeGWGhkHRiUvJ/ChdHB8NZSMwTEXWM/zdCRsG
	 hX2TiPZvJKjMA==
Date: Mon, 20 Apr 2026 11:41:38 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ernestas Kulik <ernestas.k@iconn-networks.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] llc: Return -EINPROGRESS from llc_ui_connect()
Message-ID: <20260420114138.1aa52551@kernel.org>
In-Reply-To: <20260415063457.1008868-1-ernestas.k@iconn-networks.com>
References: <20260415063457.1008868-1-ernestas.k@iconn-networks.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 15 Apr 2026 09:34:57 +0300 Ernestas Kulik wrote:
> Given a zero sk_sndtimeo, llc_ui_connect() skips waiting for state
> change and returns 0, confusing userspace applications that will assume
> the socket is connected, making e.g. getpeername() calls error out.
> 
> Set rc to -EINPROGRESS before considering blocking, akin to AF_INET
> sockets.

Please add a note on how you discovered this issue.
Including whether you're actively using this code or just scanning it
for bugs.

> diff --git a/net/llc/af_llc.c b/net/llc/af_llc.c
> index 59d593bb5d18..9317d092ba84 100644
> --- a/net/llc/af_llc.c
> +++ b/net/llc/af_llc.c
> @@ -515,10 +515,12 @@ static int llc_ui_connect(struct socket *sock, struct sockaddr_unsized *uaddr,
>  		sock->state  = SS_UNCONNECTED;
>  		sk->sk_state = TCP_CLOSE;
>  		goto out;
>  	}
>  
> +	rc = -EINPROGRESS;

Isn't this a bit of an odd placement? ..

>  	if (sk->sk_state == TCP_SYN_SENT) {
>  		const long timeo = sock_sndtimeo(sk, flags & O_NONBLOCK);
>  
>  		if (!timeo || !llc_ui_wait_for_conn(sk, timeo))
>  			goto out;

.. I suspect you mean to target this branch, right?
