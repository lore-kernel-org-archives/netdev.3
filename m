Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B5A3376
	for <netdev@vger.kernel.org>; Fri,  2 May 2025 21:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746220986; cv=none; b=ABI3JVT/YH5ym++GYNmV5Rp8JgNQnhOtTvmJcBuqbDp9Es8oMpid8nMPTuOt34qMtJ+ej6PpJgJnR7ykwanu9iLYP8DyAQyOdO3sMGVUlbKbX3MY8UiEaVMsEcwjGLQ+lJLL3HlewF80o1Jx6t1dHS0FOdo8NS1X5H5vw8nn7tE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746220986; c=relaxed/simple;
	bh=Q1NC9NF8yew/l8erdzsdR9c85y4YfEqS/uvoW7jiH+s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E8HZyOwuyhz1vhLuYrJal0BOrflgA2b2n3WbhpC9BU2nNZqg1ge+tt6QlHiLftmc+B7Hrlrp6i1+gQ4WJ5UJYz1xgeJY0ETx0BbdeQTrQ+DyFgt9gPEUVaJUMRDcQRCRrRcjvrNn9qahmkJHfQ6p4V3yHW7ZMHVwu7xwunSC7yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=DUcIy4Nv; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="DUcIy4Nv"
Message-ID: <77957459-cd64-4d7e-a503-829a1cf892c9@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1746220969;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1rTcNs31or4e+5FCcbsSqLsCUJw9Cx7CfBmlhI5nBms=;
	b=DUcIy4NvMCm86xqd+gtlgvwj/PVO/3LDmMp6XcoQIgmNWbbFy5+SAjJzwjmGof8J+4rrKg
	mwILVXckRv9UKaFK66ocJCJMErv5ePTTsGNfMoBdx4cplYPl5RV9rJF82yGU5OXL7hj3Vh
	WoO6V0w3OTUuHr+c8lOP7UU/KYtJT60=
Date: Fri, 2 May 2025 14:22:42 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v7 bpf-next 4/7] bpf: udp: Use bpf_udp_iter_batch_item for
 bpf_udp_iter_state batch items
To: Jordan Rife <jordan@jrife.io>
Cc: Aditi Ghag <aditi.ghag@isovalent.com>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Kuniyuki Iwashima <kuniyu@amazon.com>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org,
 netdev@vger.kernel.org
References: <20250502161528.264630-1-jordan@jrife.io>
 <20250502161528.264630-5-jordan@jrife.io>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20250502161528.264630-5-jordan@jrife.io>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 5/2/25 9:15 AM, Jordan Rife wrote:
> @@ -3596,8 +3600,8 @@ static void bpf_iter_udp_put_batch(struct bpf_udp_iter_state *iter)
>   {
>   	unsigned int cur_sk = iter->cur_sk;
>   
> -	while (cur_sk < iter->end_sk)
> -		sock_put(iter->batch[cur_sk++]);
> +	while (iter->cur_sk < iter->end_sk)

I fixed this to "while (cur_sk < iter->end_sk)". Not that matters since the next 
patch 5 fixed itself but it is better to keep this patch clean.

> +		sock_put(iter->batch[cur_sk++].sk);
>   }

