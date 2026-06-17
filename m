Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F24F937F72C
	for <netdev@vger.kernel.org>; Wed, 17 Jun 2026 08:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781685185; cv=none; b=ZgIAcLsBjOvXkQboqD3l/Wrd2M5MRbLDKOtH7vBXohTEQBFCSDhiJda/vhb0PgfqADWL1qp8OBOlbdSDOXOJRS1qjtD+lflS7lBOX18+PtLBRXdCtYuppL34fqr1ayqQ3sqtJErPrU1lHU4jD31H49NhW84QVmFwrOajVfs4qbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781685185; c=relaxed/simple;
	bh=sps3Q8Ta180ctg8URltxP61j5Cp6Um7TJRB930+ycqU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HN20lqWXlgSQ9PEvS8jRXwctL+XrZyibonjuu+YXv+oD+WUqeWoQtR980SoT6nERgq4mqic8pzE5jrsngCy498hfs2QtcvFLFUWTaP4m2SD3xSRliY4c2xS8q3yfdK6UrvvZjnBxSmZacX4BUhlxk0C8Q5bMz/5UDsHasQ1PqCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=exMjhxKa; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="exMjhxKa"
Message-ID: <e8ace4ba-31cb-40d7-b288-eeb411f8d0ef@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781685181;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sps3Q8Ta180ctg8URltxP61j5Cp6Um7TJRB930+ycqU=;
	b=exMjhxKaR594oatVEaRfPnukz0TfeBEeF2kuueruGw/4rgOt6LHaxb00Jgkgf8U0a40qRF
	0OsnpuUedlA8nLCRY1oYiHykM8N5b9kL4rGN96fwuxtRLNv3FQemXJxm5MdGo4i1mdxgtR
	1ravbpivhlcJ2vKVnlHulHjvSVMth4E=
Date: Wed, 17 Jun 2026 16:32:52 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net] ipv6: ndisc: fix NULL deref in accept_untracked_na()
To: Weiming Shi <bestswngs@gmail.com>, "David S . Miller"
 <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Xiang Mei <xmei5@asu.edu>
References: <20260617065512.2529757-2-bestswngs@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <20260617065512.2529757-2-bestswngs@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 6/17/26 2:55 PM, Weiming Shi wrote:
> accept_untracked_na() re-fetches the inet6_dev with __in6_dev_get(dev)
> and dereferences idev->cnf.accept_untracked_na without a NULL check,


Does ipv6_rpl_srh_rcv have same problem?

