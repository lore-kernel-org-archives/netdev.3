Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46E4C2F8EBA;
	Mon, 18 May 2026 23:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779145767; cv=none; b=P7uNPWJjSCYAT6sdTyaS/sMMxFA6FVYbfHvhi8dPeESNdyjSghGtvXH69BXlLvdv/wtgj/Zz63+NRK7xg4LiRrVQgtLwotxvco/MPoUl1RxdcuytKPp6sUAvbj9e3tLGuBVUEjktb3MB65UUSXd5s5J1oGMDwwY3HK6INElWwE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779145767; c=relaxed/simple;
	bh=3KiSMFOH3HMwtKNyFsd9/qwQR4mxxUvWD2vMw5ReAHQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H2+1L4nKdqMcaMcTGAyn9jUufz4VCyZGRexYQdwj6ZMpw8IskqFwKNlPx3jgI8JAX9Pa7eCpHf7P+RUL3xySyvIeQKFqgFST7wQV1z2MRE29Apzj8rJqmB4fNOlaJhDTXmqvuzVS6hzmFHdlZeGYj2KGhOmFGnHpGGm/uUDYQK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B08LyvlP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B08LyvlP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A297C2BCB7;
	Mon, 18 May 2026 23:09:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779145766;
	bh=3KiSMFOH3HMwtKNyFsd9/qwQR4mxxUvWD2vMw5ReAHQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=B08LyvlPz1JZJX+jFgq1TwFJNTp4k0gzz8rUMUgl59GbMGhbO74usM3LHoiXD5x2D
	 i/HLz6DttqIefwGWwT/C55CIUCabNkiFmQnz2MPjju24aVbE9rR9JmzU7z9KCmQWZ7
	 XWgtmGQ1WAKeQHmAZhvifpjllSgHWNrfjIILjRf7V+Z46tmRaR6clCRGd56rbqGgqe
	 0Fs4gfGdVeKBfKlSzCI7fXUgqvLdDlXHUo57U+whTLix+HTJJaakuoru8UIa25GymH
	 iknJmBIgjxx29T0c/yoEECkGLjF6t0wG6T+zNHmAKV6YHcCb0QPO9Keo+mo+lK/05l
	 Fi3As/9wlGhxw==
Date: Mon, 18 May 2026 16:09:25 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Stanislav Fomichev <sdf.kernel@gmail.com>,
 Kuniyuki Iwashima <kuniyu@google.com>, Samiullah Khawaja
 <skhawaja@google.com>, Hangbin Liu <liuhangbin@gmail.com>, Krishna Kumar
 <krikku@gmail.com>, Yuxiang Yang <yangyx22@mails.tsinghua.edu.cn>, Xuewei
 Feng <fengxw06@126.com>, Qi Li <qli01@tsinghua.edu.cn>, Ke Xu
 <xuke@tsinghua.edu.cn>, stable@vger.kernel.org
Subject: Re: [PATCH v3 net] net: core: dev: add reprocess depth limit for
 another_round in __netif_receive_skb_core
Message-ID: <20260518160925.0b061c1f@kernel.org>
In-Reply-To: <20260514122444.48184-1-zhaoyz24@mails.tsinghua.edu.cn>
References: <20260514122444.48184-1-zhaoyz24@mails.tsinghua.edu.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 14 May 2026 20:24:41 +0800 Yizhou Zhao wrote:
> In __netif_receive_skb_core(), the another_round label can be reached 
> via a TC ingress redirect (bpf_redirect_peer returning -EAGAIN).

Does not apply to netdev/net, please rebase+repost.
-- 
pw-bot: cr
