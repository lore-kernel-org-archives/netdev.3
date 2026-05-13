Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E4A91A9F85;
	Wed, 13 May 2026 00:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778632079; cv=none; b=Zq7nPJ8KCWu2oulFU9dSOezwrIVrxaq8+NeR6W7zfBSUyQ/a0mIu2i344aau0Psp1MG7PdmE87I2zMmHMMgfqHz7MBM62cyVKaxSCcLW/o9XKYR/EDRkjwgYy5NxYDKdlfA4+GmXNyX8mMQl02UyYsKCzH6DE4grsKEDWFsI/Ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778632079; c=relaxed/simple;
	bh=FTFEXc2xy7HZ3Ge7TIPJLvnirYingrmYi6g8dF7CNMM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HY/8nlb6jyuXajNqQFNJ1uKcRLzKCJMPRROhVqi+KUlSIUPFW5M0q2ZIDJyGJ02etK9tNPskH3qg3RQoKRlHAqOepXsbIV9k8LXPflPaITIwIL1xRBaERdWvmZRckz+MBBsDgq7i/kd5IvzS1gaDyPuVudbUmHhYMS4uwLxvVyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KDr/zZbs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KDr/zZbs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E67ECC2BCB0;
	Wed, 13 May 2026 00:27:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778632079;
	bh=FTFEXc2xy7HZ3Ge7TIPJLvnirYingrmYi6g8dF7CNMM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KDr/zZbscYB+qOrEBgnLbisGa4JvWt8Ie5/Cw/sN5Y/BhWul+vLIdSJscWj+lUI20
	 Is7ByaJq3yuTAqUdcUvTy0cWKuK3dfZ+wMyrcXIVsH1JQz0C5CeaVAIZ2U+s5L0sJH
	 0qyXIIB+qgIECivcE9qVfPiFwK5/LVzi4txKggwaYaflRYkkiHmNQAxEEi3RAbGVOu
	 Hpu2gN67pq54BWfb+kHBn3v05KAjAlWs6KEbinj7ICyvjXisy6FJrzz883ouMhKX4C
	 eHvx7RDa83qKyfGQSgl85/9Js6EtMBwT5j2t9QOJojQ7c3+YF+iJgLABx3R52j57w6
	 Sv8DJs7LBqGdg==
Date: Tue, 12 May 2026 17:27:57 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Konstantin Shabanov <mail@etehtsea.me>
Cc: linux-doc@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
 <skhan@linuxfoundation.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: netlink: Correct buffer sizing info
Message-ID: <20260512172757.10c43c86@kernel.org>
In-Reply-To: <20260512103101.1076173-1-mail@etehtsea.me>
References: <20260512103101.1076173-1-mail@etehtsea.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 12 May 2026 17:30:53 +0700 Konstantin Shabanov wrote:
> Update the docs to match the code (include/linux/netlink.h):
> 
>   /*
>    *	skb should fit one page. This choice is good for headerless malloc.
>    *	But we should limit to 8K so that userspace does not have to
>    *	use enormous buffer sizes on recvmsg() calls just to avoid
>    *	MSG_TRUNC when PAGE_SIZE is very large.
>   */
>   #if PAGE_SIZE < 8192UL
>   #define NLMSG_GOODSIZE	SKB_WITH_OVERHEAD(PAGE_SIZE)
>   #else
>   #define NLMSG_GOODSIZE	SKB_WITH_OVERHEAD(8192UL)
>   #endif

You should explain what you think the problem is in the commit message.
Maybe if you did you'd realize you're comparing kernel header comment
to user space guidance which are (obviously?) the inverse of each
other..

> Link: https://lore.kernel.org/all/20220819200221.422801-2-kuba@kernel.org/

That's not how we refer to committed code.
-- 
pw-bot: reject
