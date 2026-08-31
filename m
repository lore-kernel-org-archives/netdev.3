Received: from mta0.migadu.com (out-92.mta0.migadu.com [91.218.175.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFD1726B2CE
	for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 09:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788169419; cv=none; b=dnQF2QV9RJzaNz3BnCh8JDbatvrT4HpW0FeUNtwftBJtypQs6M8PAs42w79LZJRmT6AxcDBw5jUN6M/LMdAmcD3q8xMaHhF+fU7YwQewwmrjVTK4aWUWJ2KYbJmTjOXF+DfmLD/hE2yykIA56QOHD3NT6tZ0YPzGk88F62hywUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788169419; c=relaxed/simple;
	bh=nj5ELMPfMgaj15eVWmnMczKNYJAN3DW6MZqztM3t5oA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ynf3gCJ2SXuKRSzjT+4GqYPc5t+wsnLP/PBoCrc5LfYO4zMuTHpRO2mjbnesbaF5bcT6VeCpV+XQ4yBi3m+7RkWG6i74FsRVl28Qm9LZDye4PY4s0qI0FuevF1G/GtTH1rc2eKfvVWRpY702eYoUdyG0r7pusJ9o5BFtv3jhB1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=eaxV7BYr; arc=none smtp.client-ip=91.218.175.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="eaxV7BYr"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=nj5ELMPfMgaj15eVWmnMczKNYJAN3DW6MZqztM3t5oA=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788169413; v=1; x=1788774213;
 b=eaxV7BYrnlcqtFc7cdXMHiolJiiMeWF0FeGSLM8BE0Y/00oJvcehd3ClA7+XdiQQZ9duDbwD
 hPozLx4wltbdFavlLFiqzGC/KA2qJlyqlnC290HuDKHPNAQvo9jICx94heJoAZdswARUa9D24bk
 PDNe+CHstjQ08dcggIfdgOeE=
X-Envelope-To: netdev@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 32b65fdd18b95e11;
	Mon, 31 Aug 2026 09:43:33 +0000
X-Mizu-Trace-ID: 32b65fdd18b95e11
X-Migadu-Flow: FLOW_OUT
Message-ID: <6aa3a13b-2ca2-44f8-957d-69dbe2d25271@linux.dev>
Date: Mon, 31 Aug 2026 17:43:24 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: bonding: annotate lockless writes with
 WRITE_ONCE()
To: Eric Dumazet <edumazet@google.com>
Cc: Simon Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 netdev@vger.kernel.org, eric.dumazet@gmail.com,
 Jay Vosburgh <jv@jvosburgh.net>, "David S . Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
References: <20260831081027.3209554-1-edumazet@google.com>
From: Xuanqiang Luo <xuanqiang.luo@linux.dev>
In-Reply-To: <20260831081027.3209554-1-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


在 2026/8/31 16:10, Eric Dumazet 写道:
> Several fields in bonding are read locklessly using READ_ONCE()
> (or ACCESS_ONCE() previously) but have corresponding writes that
> do not use WRITE_ONCE().
>
> Add WRITE_ONCE() annotations to:
> - bond->send_peer_notif decrements in bond_peer_notify_may_events()
>    and reset in bond_close().
> - bond->slave_cnt increments and decrements in bond_enslave() and
>    __bond_release_one().
> - bond->recv_probe updates in bond_open(), bond_option_arp_interval_set()
>    and rlb_initialize().
> - slaves->count decrement in bond_skip_slave().
>
> Fixes: 4d97480b1806 ("bonding: use local function pointer of bond->recv_probe in bond_handle_frame")
> Fixes: 9a72c2da690d ("bonding: fix div by zero while enslaving and transmitting")
> Fixes: ee6377147409 ("bonding: Simplify the xmit function for modes that use xmit_hash")
> Fixes: 429208aab9db ("net: bonding: add the READ_ONCE/WRITE_ONCE for outside lock accessing")
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Jay Vosburgh <jv@jvosburgh.net>

Reviewed-by: Xuanqiang Luo<luoxuanqiang@kylinos.cn>

Thanks,
Xuanqiang

