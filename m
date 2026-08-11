Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDF3834040D
	for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 14:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786458898; cv=none; b=QidowS87q3NcldjBQNahdkVSxzJl0iO0WtWxwURMuna6IqFprUkaLS4Ziy9lrkiE3f/lsft/aZ0RuPvwuzZwgle7WTUGjpU98T/6Dd6R9fRLHn2Fa0byYQn64vQyx2mwuFOV3p3thancQPSMWbTEyEJQuzq1KNZ9qGyVeC/NKcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786458898; c=relaxed/simple;
	bh=ppDVZc7k7Y7hNpqZn3C6yBbB77CHfIoEZnqLrzGKuQM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Eodxv6h60IgFm5YPRzgWRI6M5e3AOhW/Zp2kcr1XVBeNbdWbnN0MjOmEkERm+JjwuzIi4gml0EmdmhCoM1OSxcznHggxWNkYwE2zGA3qaPd1fnE3iVZckDBi1/Nml1T9UQn97eIu73BkozolAdpa3JC6nO2CDKqQFBg66CG3tas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fC07K4QF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fC07K4QF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22B6C1F000E9;
	Tue, 11 Aug 2026 14:34:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786458897;
	bh=aYoNSo05gfyWjHOxbgiyZAeXxrxFQQdlI6MapOuxmZs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=fC07K4QFhOYfw1YSEZgZLPpPdpCvCCpUvDu49yyjWh1llY1YEd2iTNV3Cf+NHVF2H
	 gDe5vKl8al9zuS/OT1Kj9sD9tXyaRedw3EDuVRsG+CL9IhiwsHVeNg2flouu5Sfcn0
	 2YbuKTNMAniidHiGMMyA2AYTFq9dO6ex0BBLIX6xTLlaH0K6EDtLd+Q/1NS4skg+gA
	 yzu1/S1VRdtQ7y9MDAoLtOpCXiL9qFWec1lmnk1yN8OZbg1jtxH0/4+LshWOJVwDtm
	 DSqpwanqIs7/N4eyokLXM1/FO8K96jo9ZS2KcxRIqcEDBgMEa9fnWYGsLQd249rJbA
	 +obs1/uXEQHBg==
Message-ID: <1d1d443e-a7ec-45d1-86fa-58700cea085b@kernel.org>
Date: Tue, 11 Aug 2026 08:34:56 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 net-next 03/15] neighbour: Remove lock dance for
 neigh_update_{gc,managed}_list().
Content-Language: en-US
To: Kuniyuki Iwashima <kuniyu@google.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Ido Schimmel <idosch@nvidia.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuni1840@gmail.com>,
 netdev@vger.kernel.org
References: <20260811022448.116235-1-kuniyu@google.com>
 <20260811022448.116235-4-kuniyu@google.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20260811022448.116235-4-kuniyu@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/10/26 8:23 PM, Kuniyuki Iwashima wrote:
> __neigh_update() could call neigh_update_gc_list() and
> neigh_update_managed_list().
> 
> Both of them acquire neigh->tbl->lock and neigh->lock, check
> neigh->dead, perform link operations, and release the locks.
> 
> Let's remove the lock dance.
> 
> Note that neigh->dead is always marked under neigh->tbl->lock.
> 
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> ---
>  net/core/neighbour.c | 39 +++++++++++++++++++--------------------
>  1 file changed, 19 insertions(+), 20 deletions(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>


