Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794343631;
	b=3TVFoxzwTVhYVZt0LbDVwJzHX+L8/leMHJf3pxGJryevoKcpDkwpTsq7vDYC6VvlmHL/
	 /RySJwPsIj5RRFlNqqHCwytknp0CBJILOkeEy7iUxeIfJaSAotYi05XkrWLKByFd/0phD
	 2aJjDg/4aAwwGo/4BGy2cpb2IkJOQf7p9weRVWJLcepA/fcSTi3jdXDcKKkDW+ogSWdja
	 HhP66/Z+MGWm0kLuCLU8sY2gZUiIzuFVvvTXKta0BZb4icvOLkbTTNISvpq3sH8Oglnpy
	 iQnAT9y/f9hlYH3q+M7hzV91ylnYGl4ymMPoOqkZ2A2J9aHfiWC8549Lv+Ad77K6zAQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794343631;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ZohoMailClient;
	bh=fAn3fHJb0ZVIYk3MdVuhvN+Ds2C9lyvb1z3lSs/YPv8=;
	b=PGAzl0XvbzEh/+FqU0Olp05S5kGNxWbLn1UERuxsNArM6deSvGk6wGp33Nld/Mt55T96
	 xPuEg4DG5WIQKk4KD6ChFOyPr1kze2EkvJp2GRJhMtmtyqQCOfC3zvuoMKSLzC+wnDyFo
	 Rgcx0OdcO3xLYWlCjnWiYZ5oKATYv9rdotO7YDXUYGi9lZuK4loCyGRO/L0WAt7xkEI5C
	 iiYRHx/hsvJmm5ZzTkz9boOvnMtZEcHCvBkLzNjqNhCyrRxviQVFMzkzt90HfyGZMhBcg
	 BMV4f/NCasjrr7uMiDxUBQXjm41khaVt8OKFfWzPZZJfq/8ycItv6JAxEsXLnU9+wCg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=machnikowski.net;
	spf=pass smtp.mailfrom=machnikowski.net;
	dkim=pass header.d=machnikowski.net header.i=@machnikowski.net header.a=rsa-sha256 header.s=zoho header.b=NXHF19Ec;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.54
Received: from sender6-of-o54.zoho.com (sender6-of-o54.zoho.com [165.173.180.54])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21BA1606A325
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 20:47:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 21BA1606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=machnikowski.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=machnikowski.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=machnikowski.net header.i=@machnikowski.net header.a=rsa-sha256 header.s=zoho header.b=NXHF19Ec
ARC-Seal: i=1; a=rsa-sha256; t=1794343619; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=kSikkyItWRSaVeKMEQ2HERi7plaEaikGEarRTvhkCP9t4N3bmcxCB6IOFxSPmeB9U5WNwewt38zup2qChfkwTDthvBjWfjiv5plXvirtr9RXn5V3QOMDaIS9R+FanLcPT/L9CbvR3oGKIz3wSLKgGOJEscD3wJXN75hlS+xpA0I=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1794343619; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=fAn3fHJb0ZVIYk3MdVuhvN+Ds2C9lyvb1z3lSs/YPv8=; 
	b=l0CoSJSg2L5OwatsqQWqJa9z6KTx7nJsgJBZYTBBRL68S61QKNKS1RKXHpeN1izasLxyqFrXpN442ojJSRLRQFI+ZpdWU1bn7IVRq8gKNQeoqQibAopBTWDDt2jBTATz+h2g9Ern+fuoYukrVL4OzJhujfzRcpbhsBEH73nMzEg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=machnikowski.net;
	spf=pass  smtp.mailfrom=maciek@machnikowski.net;
	dmarc=pass header.from=<maciek@machnikowski.net>
DKIM-Signature: a=rsa-sha256; b=NXHF19EcQ7qPmO33456x69gCqQ9n41Yp3RvIlgmBPiF6NaibH+nOF4cdyU7r/e6f8sdNoqA3KCLwVsbqx/Yrn1azfWwHCqj+5/jMGl/dRRuEfzcemp1+WVF9q2zeJHFGJf+uBSBfN5woDlvXDqarQCuKcohdSyso6FwxIDnzYlFZG1z8bvAuSDVMkE7TNSedONguSxVB2lkpDUpzbdaiBNKMkZhX9cK9pgo7FyLFGVyY/E8fhlxd/9YQcwfzY4XBhE+oSrbqzhL5l2NHNQTPSeb6HKXv70BpzXQTwxpVJW7gKcToFecLJxCGtC18fkS80CWPWwLoAOtgf1/gw9FGSg==; c=relaxed/relaxed; s=zoho; d=machnikowski.net; v=1; bh=fAn3fHJb0ZVIYk3MdVuhvN+Ds2C9lyvb1z3lSs/YPv8=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1794343618590611.5932086149721;
	Tue, 10 Nov 2026 12:46:58 -0800 (PST)
Message-ID: <f9e139ec-c4d6-42ac-8fe3-90e0c342765b@machnikowski.net>
Date: Tue, 10 Nov 2026 21:46:55 +0100
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 net-next 2/3] netdevsim: Implement basic ptp support
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, kuba@kernel.org, richardcochran@gmail.com,
 milena.olech@intel.com, willemdebruijn.kernel@gmail.com, andrew@lunn.ch,
 vadim.fedorenko@linux.dev, horms@kernel.org, almasrymina@google.com
References: <20261108201503.85000-3-maciek@machnikowski.net>
 <179425609934.994134.5338593155278222514@kernel.org>
Content-Language: en-US
From: Maciek Machnikowski <maciek@machnikowski.net>
In-Reply-To: <179425609934.994134.5338593155278222514@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External



On 09/11/2026 21:28, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider.
> 
> Critical: 0 · High: 0 · Medium: 1 · Low: 0
> 
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
> 
> - [Medium] nsim_start_xmit() (drivers/net/netdevsim/netdev.c) only
>   overwrites or clears skb_hwtstamps(skb)->hwtstamp inside `if…A non-issue. We are not working with a real HW, so we have to cut some
corners to make it work. The most probable leaks are fixed, those are
hypothetical.

Thanks,
Maciek
