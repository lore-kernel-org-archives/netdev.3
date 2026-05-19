Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B17340404
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 16:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779208746; cv=none; b=PtZXkGmf17yemKyNhm1BhgJPadUswW/HebV7skOT3AHNQ9i56E5iqZwtf3f24PD05wipdkG9Wrldniv31kU2WFPXgCbBMt1oWq6da3c3QukrRnrdrTrbhUQ0H7ewyp6w6DSg2noD3e6UtRBHMine63ct26xgGukQPuZSfBVSVkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779208746; c=relaxed/simple;
	bh=pqo6nhEaFqwKk9CGwK2WDegDArNbEt3Qy3PntN8qD+o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gM79t9f3hUS9S/wt7y81FB7ZAebyQaIB7DH7JUtE8sFnGWWZzV8MlpAbunPy5q049HfYoX9dOK/pt5QtOQvaRxN6iffY78o20mgMIK4Oh2irk8mon77HKdolJfF1s7gn5MpJIH4dIx64dNysIcNCdIimDcqMVa8gRDLvHN8VvUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mL0iXLDq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mL0iXLDq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 650D9C2BCB3;
	Tue, 19 May 2026 16:39:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779208745;
	bh=pqo6nhEaFqwKk9CGwK2WDegDArNbEt3Qy3PntN8qD+o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mL0iXLDqWvANbd6oQdqycxw1DJ6oYcRPmqvhDpQSMzk+ziCEcDBCyn52aHrmmzIuK
	 ZrESgKRkjdA4DDN5c78Ej8OqNm05bolqRa67ant65XDkiLCVRhp9la/Hlode5a3IlA
	 SXsLbED/s7IJ35gpMghUwCR0m8DOF+n4KLZiBTiR61Ziq7ITWNgglocD5Pg/cxR9fw
	 vaFOevhWjhDRqGA9SCT7w62YOV0byywoLj2LIiI9W81GYAMBG9jWvDB7UJ8FgyAf6e
	 18wejEa1BJnCAQmGacrxyg9JDVXzbnDgXxMQraIX4ISmsAR0qKIsQX7fyLQ6pfFUkU
	 +b2ehgzHxdCwg==
Date: Tue, 19 May 2026 09:39:04 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Kuniyuki Iwashima
 <kuniyu@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Subject: Re: [PATCH v2 net-next 1/2] rtnetlink: use nla_nest_end_safe() in
 rtnl_fill_prop_list()
Message-ID: <20260519093904.49298543@kernel.org>
In-Reply-To: <20260519114355.2769474-2-edumazet@google.com>
References: <20260519114355.2769474-1-edumazet@google.com>
	<20260519114355.2769474-2-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 19 May 2026 11:43:54 +0000 Eric Dumazet wrote:
> Avoid corrupting a netlink message and confuse user space in the
> unlikely case rtnl_fill_prop_list was able to produce a very big
> nested element.

Should we not prevent it from happening in the first place?
IIUC otherwise if user adds a lot of altnames ip link will no longer
work?

> diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
> index 6a5e9ace55a0880d7b1e4303d12dc0a8b8b7c5ed..ae0254f19178735b2805a8189e81a960a49b2858 100644
> --- a/net/core/rtnetlink.c
> +++ b/net/core/rtnetlink.c
> @@ -1971,7 +1971,9 @@ static int rtnl_fill_prop_list(struct sk_buff *skb,
>  	if (ret <= 0)
>  		goto nest_cancel;
>  
> -	nla_nest_end(skb, prop_list);
> +	if (nla_nest_end_safe(skb, prop_list) < 0)
> +		goto nest_cancel;
> +
>  	return 0;
>  
>  nest_cancel:

