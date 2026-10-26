Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=62.72.0.81
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793056603;
	b=lxfKK/TJnQyU0lKGMIRsWjhveFbccDWqdnmWWUqIs67vSR88u9t9TMn3MBTzxrJUZFru
	 DSr9NATVkx9Mwr6lWZI5HURw1XPeeS/8EwYulUq81M4lUAlDWxDq+xQc3BCyM7XOCs3I0
	 CpO9YUx+H4XN0HZEE0dDrKzd8QwSIx+rlSXSDn9WkoDZPxi1L7yKwcgagnaivFtVzg7du
	 fsD+cyzbCEBpva6gnQm8snPYamzRFltLAUYLphsVoUtWy5B1zazGampLCTxxhTLlNlkd2
	 +qaTxwgtnM8SKEy4D2GqdI0zGEiR8y+zOZdfbnhpyNwJB8azNRyUkDZ2lDv+QvbZeOg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793056603;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:cc:
	 Subject:In-Reply-To:Message-ID:References:MIME-Version:Content-Type;
	bh=76DcOtJQlvUM8FkqGhwTxozzFwnxhvOl0D2p3vW2Sbg=;
	b=fFbWgN4XMEIeR0a7EZvybIiArw9skZ1llkdSRZ6Su3d3f8L2jVYU+gpfV91iZwD+f0Er
	 pDnwdEQk9ZWEF43nNME1Q8AtrutfZEtFQfgkGW6gRUwGvm9O6rYYURSMD00ZWk5qXo3tF
	 nbrN5kZOaGczn962DIOpmE8HQPqDGQ+7L5XVjLpCaGRS0tT0NRm8EzCaIgWMhvcFjkDK/
	 q0qxt0xC15d4Fd3LyCnHm129bgkvqAWSScrxu9goedif3ipDG3tM0XgUjgI2AbaRGhwDe
	 vRoQp6JwfkDHAjTzmLkl1hURWTEvyQmmIrSnH3Twwu3kCeJAcCHbW+9qBnOdptrPZ2A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gentwo.org;
	spf=pass smtp.mailfrom=gentwo.org;
	dkim=pass header.d=gentwo.org header.i=@gentwo.org header.a=rsa-sha256 header.s=default header.b=VfAfR3KS;
	arc=none smtp.remote-ip=62.72.0.81
Received: from gentwo.org (gentwo.org [62.72.0.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE83606A31A;
	Mon, 26 Oct 2026 23:16:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CBE83606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentwo.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=gentwo.org header.i=@gentwo.org header.a=rsa-sha256 header.s=default header.b=VfAfR3KS
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gentwo.org;
	s=default; t=1793056596;
	bh=GaMVZdZtfEz95aFkhufC4OMQg51Qb7F3dqNgK1ZncbU=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=VfAfR3KSe9TgYDoa2LtKyianQzzZGJhawtw2soD84LLwGDns37ZE778n2LEeluVaW
	 TEyLh+kY6gsBN+ChV6lNnq2daAV5D2gUqAXX5RnSYhgEuZQzp6TgINOr2Be3sDkyVr
	 5a5ZHTnOFuSfBqrej0uXKjeRcjxIwujoTDp8LTcE=
Received: by gentwo.org (Postfix, from userid 1007)
	id 5F35F40B32; Mon, 26 Oct 2026 16:16:36 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by gentwo.org (Postfix) with ESMTP id 5A28D4029C;
	Mon, 26 Oct 2026 16:16:36 -0700 (PDT)
Date: Mon, 26 Oct 2026 16:16:36 -0700 (PDT)
From: Shubhang <sh@gentwo.org>
To: =?ISO-8859-15?Q?Jonas_K=F6ppeler?= <j.koeppeler@tu-berlin.de>
cc: =?ISO-8859-15?Q?Toke_H=F8iland-J=F8rgensen?= <toke@toke.dk>, 
    Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>, 
    "David S. Miller" <davem@davemloft.net>, 
    Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
    Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
    Shubhang Kaushik <shubhang@os.amperecomputing.com>, 
    "Christoph Lameter (Ampere)" <cl@gentwo.org>, 
    =?ISO-8859-15?Q?Toke_H=F8iland-J=F8rgensen?= <toke@redhat.com>, 
    cake@lists.bufferbloat.net, netdev@vger.kernel.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net/sched: sch_cake: skip redundant cake_mq rate
 updates
In-Reply-To: <3625cee3-3643-4ef8-808d-2fe8267593fd@tu-berlin.de>
Message-ID: <a4511177-c3de-9ab5-7ace-74aea1e95db4@gentwo.org>
References: <20261025-net_sched_sch_cake-v1-1-5165c924a590@gentwo.org> <3625cee3-3643-4ef8-808d-2fe8267593fd@tu-berlin.de>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-344181521-1793056596=:284822"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-344181521-1793056596=:284822
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

Hi Jonas,

>>   -		cake_configure_rates(sch, new_rate, true);
>> +		if (new_rate != READ_ONCE(q->tins[0].tin_rate_bps))
>> +			cake_configure_rates(sch, new_rate, true);
> Thanks! Yes, I think the idea is right. I think we could even omit the
> READ_ONCE.
>
> Best
> Jonas>   		q->last_checked_active = now;
>>   		WRITE_ONCE(q->active_queues, num_active_qs);

Thanks for the review. Yes, the qdisc lock serializes this access,
so READ_ONCE() is not needed. I’ll send a v2 with it removed.

Regards,
Shubhang Kaushik
--8323329-344181521-1793056596=:284822--
