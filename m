Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE099199FAB
	for <netdev@vger.kernel.org>; Thu, 14 May 2026 01:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778721475; cv=none; b=TBE6VAP0aUEzovqjczfHi3SpqyGrGjMH8yztpKQWvJ0J9fdy60oAlL9VlPNbcIHHYL+Vjhc+ggu82gRtJI10CJdKrmMiuyXNZvjxKwtLDgcdF2KcuR40s6qcfl+X4BJNiPL7LM6g9Jsgm2SbffR0JqveF7K9aumP7ee8JErGsJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778721475; c=relaxed/simple;
	bh=f/JEA+gvAL6RsKE4k0VQGSoZzDc9Bv1KBRJTUSNnzqc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RnTdV6KDUm+Hlc0BhdrsSyaXNes1FGDSPATyq0PXbt9NwtvOjQVz4ytjMeLmkVwzMIppJhguZSnM8ECMFZJKQeglsPnPbTNmWIWAGABlh/TEhE72r3ko7WaIDo0zQwPKm0baiam8Dp7jBR0+K4uKr5m25tEsgKGJ0u10oYTerKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L8lC/VFr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L8lC/VFr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AD41C19425;
	Thu, 14 May 2026 01:17:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778721474;
	bh=f/JEA+gvAL6RsKE4k0VQGSoZzDc9Bv1KBRJTUSNnzqc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=L8lC/VFr8a5m507MMQ/6dlEpIEq4JzHr8EUm/qaEfe7NqkDSmZW2G20dyusVUlbDa
	 RZ548D0f0fGh+cG4E/5LgHePlDu9rcdfD9R/8Cv/YVIM8SzvVvWvWz4eXx6SzNIPV2
	 7jcvzafqpdckSz5ke/AFmN/jxkzM60vJbsTvWcOppW4OtYpQKxPQLi437JngBkiTc3
	 S50Hl/cm+4J+cJEXDd5Wi8C69vI9CoZId7lXoLpCCaArKyTvObu3YBSYbuYpMvYkaM
	 2IoCvru1NrM9gXx/JWu2ubu8IM3/sPnE1GpYmYDWzeCdG3dHcMEJZfeGHxYfHA+c+z
	 1u89su2ZnXf4w==
Message-ID: <89e9f18f-2fc9-4453-bcdd-96fe31c0a3aa@kernel.org>
Date: Wed, 13 May 2026 19:17:53 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iproute2-next v2 0/6] seg6: SRv6 Mobile User Plane (RFC
 9433)
Content-Language: en-US
To: Yuya Kusakabe <yuya.kusakabe@gmail.com>
Cc: netdev@vger.kernel.org
References: <20260505-seg6-mobile-v2-0-93291b7b0134@gmail.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20260505-seg6-mobile-v2-0-93291b7b0134@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/4/26 10:10 AM, Yuya Kusakabe wrote:
>  include/uapi/linux/seg6_local.h |  17 +++++
>  ip/iproute.c                    |   9 ++-
>  ip/iproute_lwtunnel.c           | 149 +++++++++++++++++++++++++++++++++++++-
>  man/man8/ip-route.8.in          | 154 ++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 326 insertions(+), 3 deletions(-)
> ---

I am not cc'ed on the netdev patches, so I have no idea the current status.

Future iproute2 patch sets need to have all uapi changes as a standalone
patch that I can drop when applying the rest. Headers are synced from
the kernel.

