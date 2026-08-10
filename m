Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DC352EF653
	for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 01:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786324803; cv=none; b=M+3hSc4vQKIVvUibL0W++8MH5CTQ+1IEbXLik0gs1rr1+eaMIsckrBRi6pu2BEwzq9UkqF9tLc9YXTa1M99RDDdOwnuDaqdF0vXY8qSwFfZ+bCkTyFgL+Wt2dQGV1Enwlj5IqnpL6LzoYaeh8eSqBu3+SVCoy9skTHoqgmgic9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786324803; c=relaxed/simple;
	bh=gT2//A7PpTwcyMwaGwBooEU/BfIWVuEWXZZ6hOn9V6w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aAv/xazHcl7dRIce4wb9Dr5x9f8xXmSGGUPNiPVmbzT0Sc+o/vL+AcXgIMMw2Dewk3ptwrkh59IEXEaJaEsOsv3OihoNBQcgZ/q8pX5q/ppJm7VlwNrCJuwvpRJFfdHJYtKguhqn+mr5fJA4ifEpz5QAl6TMmLEP75XwbZlbxMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=m2/4ger4; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="m2/4ger4"
Message-ID: <01f94272-da18-4a6f-8907-c482522a8ae6@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1786324788;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gT2//A7PpTwcyMwaGwBooEU/BfIWVuEWXZZ6hOn9V6w=;
	b=m2/4ger4NCFPcjXI8nUz2CHVUQjrmnap4D253sYGL0uHBrV4OP3kNM9C231jQMe1AMvZnS
	S8jS+sM9WS457YRxaBMyrBEAu5qY83vzfdVqiMZo5buW7SbvjUIZbeN0/0sQpEg/00Uqb4
	E+565gVWGMLEmpmUIq7vlpk8UsQt+kQ=
Date: Mon, 10 Aug 2026 09:19:28 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next] ppp: update channel locking comment and doc
To: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Breno Leitao <leitao@debian.org>, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Paul Mackerras <paulus@ozlabs.org>
References: <20260807060153.1380548-1-qingfang.deng@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Qingfang Deng <qingfang.deng@linux.dev>
In-Reply-To: <20260807060153.1380548-1-qingfang.deng@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2026/8/7 14:01, Qingfang Deng wrote:
> Commit ec4215683e47 ("ppp: defer channel free to an RCU grace period to
> fix pppol2tp RX UAF") defers freeing generic channel state to an RCU
> grace period via call_rcu().
>
> Update the SMP locking notes comment in include/linux/ppp_channel.h and
> Documentation/networking/ppp_generic.rst to reflect that in-flight RCU
> readers can complete safely after ppp_unregister_channel().
>
> Reported by Sashiko.
>
> Signed-off-by: Qingfang Deng <qingfang.deng@linux.dev>


Sashiko pointed out more issues. I should keep the comments for now.

---
pw-bot: cr

