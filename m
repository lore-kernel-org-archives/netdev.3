Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C41E8348866;
	Thu,  9 Apr 2026 09:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775728286; cv=none; b=YMkL3auLd2cff8FDcNIgCPeWXjNrZkBpjnfceknqbUO4tI0peY1LsXI11JJ/j04cNS39ER5XtMb9rMO7XrjzjKkUTGYFjLzvm3iwhKhSIvaRAke9VAoJeG2fScx5SeNa/x/HyWBlHkhg7ft1BmSwOp9pohcne2X7TClVaB7reBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775728286; c=relaxed/simple;
	bh=GuaMOXo1SjXgLhYkJk/nlDxDW3EE8q9QqfxOUTCKs3Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WdF01CL3KtKutCNPrnCiAk6iGHGGMoINzmv4D8beXzviPduLQnmQfu+cT5PTnwfHBpdy/UFjvyeKKIk4OC5Q5zVXiDgRDwQ7qYgWkMBu51lkLW5de0J1Tll1fPN/oSC4RdAGIubLZMS53RB+CqpFz4ot+wKDCmdmmlTYPuD81qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=IM0X4pn9; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="IM0X4pn9"
Message-ID: <41ffbf37-8716-428f-9ad5-ad2c9a9034f0@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1775728272;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3TQ/SAKITw7hz30BN7ZaQ+bq9XIDw7rEFZx/FEY27Ac=;
	b=IM0X4pn9jTVtuahOPe/9bRQBXC/7cb2MXj/5UuZAfqkYxhxoUqqbaDSv1VfpdpdmJuQtbn
	+CEp7eiJYbVMCPzx86S/JpwuxcvoiNlCUK9n0Q/AyP0e8T/1ipsy1ynk08E+H6ajKr2fQZ
	a5BNy8ngSfas0CV1F0oUkYK/8eQJNRA=
Date: Thu, 9 Apr 2026 17:50:38 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net v3] ppp: require CAP_NET_ADMIN in target netns for
 unattached ioctls
To: Taegu Ha <hataegu0826@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Kees Cook <kees@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Cyrill Gorcunov <gorcunov@gmail.com>, linux-ppp@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: gnault@redhat.com, jaco@uls.co.za, richardbgobert@gmail.com,
 ericwouds@gmail.com, teknoraver@meta.com,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
References: <20260409071117.4354-1-hataegu0826@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Qingfang Deng <qingfang.deng@linux.dev>
In-Reply-To: <20260409071117.4354-1-hataegu0826@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2026/4/9 15:11, Taegu Ha wrote:
> /dev/ppp open is currently authorized against file->f_cred->user_ns,
> while unattached administrative ioctls operate on current->nsproxy->net_ns.
>
> As a result, a local unprivileged user can create a new user namespace
> with CLONE_NEWUSER, gain CAP_NET_ADMIN only in that new user namespace,
> and still issue PPPIOCNEWUNIT, PPPIOCATTACH, or PPPIOCATTCHAN against
> an inherited network namespace.
>
> Require CAP_NET_ADMIN in the user namespace that owns the target network
> namespace before handling unattached PPP administrative ioctls.
>
> This preserves normal pppd operation in the network namespace it is
> actually privileged in, while rejecting the userns-only inherited-netns
> case.
>
> Fixes: 273ec51dd7ce ("net: ppp_generic - introduce net-namespace functionality v2")
> Signed-off-by: Taegu Ha <hataegu0826@gmail.com>

LGTM.

Netns devs, could you please take a look?

> ---
>   drivers/net/ppp/ppp_generic.c | 3 +++
>   1 file changed, 3 insertions(+)
>
> diff --git a/drivers/net/ppp/ppp_generic.c b/drivers/net/ppp/ppp_generic.c
> index e9b41777be80..c2024684b10d 100644
> --- a/drivers/net/ppp/ppp_generic.c
> +++ b/drivers/net/ppp/ppp_generic.c
> @@ -1057,6 +1057,9 @@ static int ppp_unattached_ioctl(struct net *net, struct ppp_file *pf,
>   	struct ppp_net *pn;
>   	int __user *p = (int __user *)arg;
>   
> +	if (!ns_capable(net->user_ns, CAP_NET_ADMIN))
> +		return -EPERM;
> +
>   	switch (cmd) {
>   	case PPPIOCNEWUNIT:
>   		/* Create a new ppp unit */
