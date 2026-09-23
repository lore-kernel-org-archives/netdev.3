Received: from mta0.migadu.com (out-194.mta0.migadu.com [91.218.175.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE8753382F9
	for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 01:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790126542; cv=none; b=gMnZD7ZfJVVYGE8mRo4vLRS/ysZguppayEkmKHqitCTdBT3eHQp4w00yl/6nD8se4Fiotw+jQgpQL6qlPXozn5bvHpjcrGSInq3pKyxD3XspA07kTvSnuv04ZJfjmd3TdaGVrDjSiKXFs51FfD6YNlq8jCIXqxR+e2xBJUB6zaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790126542; c=relaxed/simple;
	bh=xgeJq1epbgJrMp8qvQY0RPC2gSK5k0M9Se+kxeaC7NE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oGauSddcw1/33xu3UlYFQD4H59QcmKt7NyNkUAQ8/IPgUoR1LCHZsDj+KNyrcWFrqftEeESBcZthqa2lU7TucG/TjJAvELP7lZ3Lr2ZOzc+XJYTiWcEanyt4Mz8ZHx6ezB2aBcNZc/Hej4jNTBdTx4zMQ/NxoeTMzrgKUxx17xU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=F0nL6zlV; arc=none smtp.client-ip=91.218.175.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="F0nL6zlV"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=xgeJq1epbgJrMp8qvQY0RPC2gSK5k0M9Se+kxeaC7NE=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790126535; v=1; x=1790731335;
 b=F0nL6zlVLV/BO1HaOqCis3M1pdO8a6L7ej5S8CvL8gztCQwAyjE6fzeHPIZsilI7K4CxyJtF
 Tj9Wq1MFBJGp5Qf2AlTt6GYJRcBksmqTpRhnWnbTluqboZrBO92x0+DiygTez1r5i5eb2P/9ayL
 Nt3ibXV/2VZstoZLzGWFrY0A=
X-Envelope-To: netdev@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id e316435f0a7b1eee;
	Wed, 23 Sep 2026 01:22:05 +0000
X-Mizu-Trace-ID: e316435f0a7b1eee
X-Migadu-Flow: FLOW_OUT
Message-ID: <c9341953-58e1-498f-a103-16765684eb07@linux.dev>
Date: Wed, 23 Sep 2026 09:22:00 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] tcp: remove dead code in tcp_rcv_state_process()
To: Eric Dumazet <edumazet@google.com>
Cc: Simon Horman <horms@kernel.org>, Neal Cardwell <ncardwell@google.com>,
 Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org,
 eric.dumazet@gmail.com, "David S . Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
References: <20260922010627.2291980-1-edumazet@google.com>
From: Xuanqiang Luo <xuanqiang.luo@linux.dev>
In-Reply-To: <20260922010627.2291980-1-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2026/9/22 at 09:06 Eric Dumazet wrote:
> Since commit 3d501dd326fb ("tcp: do not accept ACK of bytes we never
> sent"), tcp_ack() bounds the acceptable old ACK window by
> min(tp->max_window, tp->bytes_acked).
> 
> When sk->sk_state == TCP_SYN_RECV, tp->bytes_acked is always 0, so
> any segment with before(ack, prior_snd_una) immediately returns
> -SKB_DROP_REASON_TCP_TOO_OLD_ACK and never reaches the old_ack label
> (which returns 0).
> 
> Therefore, tcp_ack() can only return 0 in closing states (where old
> ACKs are accepted), and can never return 0 in TCP_SYN_RECV.
> 
> Simplify the tcp_ack() return value check in tcp_rcv_state_process()
> to only check for negative return values and remove the unreachable
> !reason branch.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>

Thanks,
Xuanqiang
