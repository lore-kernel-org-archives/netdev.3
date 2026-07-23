Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 111CD30FC03
	for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 06:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784787873; cv=none; b=LDEQBsw4v8o8cYEipJn4v2wSQJWsqWvU8tSrk2uuvWCu3kAiPEmac/dbQ1bFJq6bpIqtpCSlthV8pArtQ7kFrbpc+MdkbIzekBlFdAacG5e2ntWr4ZC3qeXo9PF+RRs/k4ir5EGyJYbBL32P5z47cIbkQkEa0ZPB+87Gr3fGRzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784787873; c=relaxed/simple;
	bh=2R13blRGfFPZ/SwD80wzlfRHmnbeHOHPKADhP+vcY1I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HIIITcve+WStDl3kJXFbA9KAQQNVnavSblw5qO2KLtZgAjY1xadlvPFU1ax3VQMriGeOiiXmAHfOQ8MBRVNI6hk+GYE/J6LxNbPjRXzSqkThGbnXjMkhMHVK4IrQywF6gM3ccTIDjyRwca2mM4FteSYV7Rr79H+sX6lp6t3NuSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=dDcX/tyZ; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dDcX/tyZ"
Message-ID: <b16aec0f-a90f-4132-820e-239ddadbe8f0@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784787869;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sh96Z4nEx0PzkdFSAUU36azYXNYjocK8bPREh6lGfcg=;
	b=dDcX/tyZZdZWlaK9f65/RwTTM8k2TTP/7d9fK/1PmB4CaNjr/xc9ue6v/aWnUOVA99nxLX
	7ccL1hmVCaXneVB6Jckgv3e97mDyLn+HqNpXRRkx5c/BS3a9b267UWqwO5GBeqFVPC9tkf
	Xq7QdP+xLsi79Mm2oB5ORFS807njsHM=
Date: Thu, 23 Jul 2026 14:24:00 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net] ppp: annotate data races in ppp_generic
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 netdev@vger.kernel.org, eric.dumazet@gmail.com, linux-ppp@vger.kernel.org
References: <20260722101605.2868548-1-edumazet@google.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Qingfang Deng <qingfang.deng@linux.dev>
In-Reply-To: <20260722101605.2868548-1-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

Hi,

On 2026/7/22 18:16, Eric Dumazet wrote:
> diff --git a/drivers/net/ppp/ppp_generic.c b/drivers/net/ppp/ppp_generic.c
> index ef54e0a0462a175bb989db8dda895e9ae755965f..cacc4c3a37d2cda0aea2e176e5d0638f959e18a3 100644
> --- a/drivers/net/ppp/ppp_generic.c
> +++ b/drivers/net/ppp/ppp_generic.c
> @@ -866,16 +870,16 @@ static long ppp_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
>   		break;
>   
>   	case PPPIOCGIDLE32:
> -                idle32.xmit_idle = (jiffies - ppp->last_xmit) / HZ;
> -                idle32.recv_idle = (jiffies - ppp->last_recv) / HZ;
> -                if (copy_to_user(argp, &idle32, sizeof(idle32)))
> +		idle32.xmit_idle = max(0L, (long)(jiffies - READ_ONCE(ppp->last_xmit))) / HZ;
> +		idle32.recv_idle = max(0L, (long)(jiffies - READ_ONCE(ppp->last_recv))) / HZ;
In the original code, the difference will wrap around on a 32-bit kernel 
with HZ=1000 if the session sits idle for 4,294,967.295 seconds 
(approximately 49.7 days). With this change, as the difference is cast 
to a long, it will be negative after 2,147,483.647 seconds 
(approximately 24.9 days) and then clamped to zero by max(), making the 
situation worse.
> +		if (copy_to_user(argp, &idle32, sizeof(idle32)))
>   			break;
>   		err = 0;
>   		break;
>   
>   	case PPPIOCGIDLE64:
> -		idle64.xmit_idle = (jiffies - ppp->last_xmit) / HZ;
> -		idle64.recv_idle = (jiffies - ppp->last_recv) / HZ;
> +		idle64.xmit_idle = max(0L, (long)(jiffies - READ_ONCE(ppp->last_xmit))) / HZ;
> +		idle64.recv_idle = max(0L, (long)(jiffies - READ_ONCE(ppp->last_recv))) / HZ;
>   		if (copy_to_user(argp, &idle64, sizeof(idle64)))
>   			break;
>   		err = 0;

