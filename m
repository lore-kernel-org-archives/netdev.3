Received: from mta1.migadu.com (out-106.mta1.migadu.com [95.215.58.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03DB62D63E5
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 09:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790587449; cv=none; b=a/RxrruTzETwoRB9JMToGE03aSbbjxtMNcrjA1L4XBf7eDbqTVGQQqhfvVAdhCyAmyU7PvOYVL7py7ZpCFoIuhnDRJssezMuvLC31tHnjikiIPJWoylUmESwEfq3IvobxjbVqKuszxH3rz4IaEDEq9zj3VaJEMj0/ZmFgf5Ft+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790587449; c=relaxed/simple;
	bh=AIj/f/4pHaMrRHjQXMO3NpYyHAgSnHWcQDXeujSSlx0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rfq+M/n7HLIzKp52a+ZVRgEU7prI6/a8nPI++9NNWkkPIhIh0EbBorw1I6JRD8TKKslbPw63+2SMlSQbT/W0beIpM1L5whdens54UQ+oKyUrtypV/Xf5I0EObCgxGdj1cebXKzGUcyiYX15vi+k9/xEMOE0HCiaLOFNMYmPU7ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=P65/qkQQ; arc=none smtp.client-ip=95.215.58.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="P65/qkQQ"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=AIj/f/4pHaMrRHjQXMO3NpYyHAgSnHWcQDXeujSSlx0=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790587444; v=1; x=1791192244;
 b=P65/qkQQmLq4tX9e2QYWx84Ee7WjLpqHOdKtzUyQ/IBwi0TIKYgjMD/I5ppwzYpNtp+enHc5
 YTkyyX85HLCTwx6+QN+Rx9W17iuVLhItwvSXUKUdapR4xPmNlEyhLQwe+Rh4Ub7liaYteKR/zwd
 Dq3GtlQPwSV+jLLNOstdoq9o=
X-Envelope-To: netdev@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id d825eb00b4c9f6f8;
	Mon, 28 Sep 2026 09:24:04 +0000
X-Mizu-Trace-ID: d825eb00b4c9f6f8
X-Migadu-Flow: FLOW_OUT
Message-ID: <641ccc52-2677-4a52-aa11-e3b3c3c50920@linux.dev>
Date: Mon, 28 Sep 2026 17:23:57 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] strparser: make sure __strp_recv isn't running before
 tearing down the parser
To: Sabrina Dubroca <sd@queasysnail.net>, netdev@vger.kernel.org
Cc: Hyunwoo Kim <imv4bel@gmail.com>
References: <4c80ea646f95abbd5beca2c081d129fe7d61a0aa.1790344112.git.sd@queasysnail.net>
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <4c80ea646f95abbd5beca2c081d129fe7d61a0aa.1790344112.git.sd@queasysnail.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 9/25/26 9:51 PM, Sabrina Dubroca wrote:
> The comment above strp_done() claims that if strp is stopped,
> strp_recv will no longer be called. That's only true if the caller has
> a mechanism (eg locking) to guarantee that strp_recv() calls that
> started before strp_stop() have completed by the time we call
> strp_done().
>
> This adds a lock_sock/release_sock pair to guarantee that any
> in-flight strp_recv() (which runs under either bh_lock_sock or
> lock_sock, depending if it's called from ->sk_data_ready or strp_work)
> has completed.
>
> Only espintcp can be affected by this race condition, but this patch
> makes sure no future user of strp can have the bug.
>
> Reported-by: Hyunwoo Kim <imv4bel@gmail.com>
> Link: https://lore.kernel.org/all/aZgpkyTDU3aXe_V0@v4bel/
> Fixes: e27cca96cd68 ("xfrm: add espintcp (RFC 8229)")
> Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
> ---
> This could crash on strp->sk ("general mode" of strp), but this mode
> has been here for 9 years and has never been used. I'll send a
> net-next patch to get rid of it.
>
>   net/strparser/strparser.c | 4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/net/strparser/strparser.c b/net/strparser/strparser.c
> index a23f4b4dfc67..401e67533005 100644
> --- a/net/strparser/strparser.c
> +++ b/net/strparser/strparser.c
> @@ -511,6 +511,10 @@ void strp_done(struct strparser *strp)
>   {
>   	WARN_ON(!strp->stopped);
>   
> +	lock_sock(strp->sk);
> +	/* sync with pending strp_recv */
> +	release_sock(strp->sk);
> +


Using sk directly inside strparser breaks the abstraction and that's why 
cb exists.

We can totally use it instead
     strp->cb.lock(strp);
     strp->cb.unlock(strp);


>   	cancel_delayed_work_sync(&strp->msg_timer_work);
>   	cancel_work_sync(&strp->work);
>   
