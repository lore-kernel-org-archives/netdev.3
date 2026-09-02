Received: from mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E27C7413799
	for <netdev@vger.kernel.org>; Wed,  2 Sep 2026 09:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788341393; cv=none; b=mI3g8S1dNw2LCmTTPzu+lkNx4xpi+3AFLJK9J/qConcNH4muQevRAsSRgSj2Yah4nSiyvAGWVMknSu+UlfbK6kHQ9plc2t2AruNq8KMvdWW2I/HrEfEIJB1+2Uzi/H9DqSSEWR5+SNG9FBgKe/Symw0Tw2fTsY0EoM84IYgFdQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788341393; c=relaxed/simple;
	bh=nXVAMVCk2SAZDGSV63lvGul1vVa5/XzRCxj6a3/JecU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WeqEGh1RiVRvqVzFnS0PaYPSALUTErJ2dqrSSbo+KkOIYZ+X60dpW5xlCiJyUyrLV6CMOg0c+W9F7xV9elqr1/y357ADDJBSbSZGNeU8K5Of61ODvqVp/O57lu+m/Ydb/CfeDgbCEp5jy13ltzW7bKAUJNt0NvnGDVDSIm3GEe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=WG8hyeEj; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="WG8hyeEj"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=nXVAMVCk2SAZDGSV63lvGul1vVa5/XzRCxj6a3/JecU=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788341389; v=1; x=1788946189;
 b=WG8hyeEjwcmvHkOaUtVT5T1YI6XTrix5ByzOkY+6wGZlrtZcG4KmrxotmVGlmdX4/1xJ4NdR
 aTF92Pt5o4o5QmCHPbhtjfTQlOviJETQO11NphOt5z/4XtUQ0lxV+HKdPlMdkeKPeVvlgdJqKec
 Nb8UsOvMZb94Y8U9ecJhIZts=
X-Envelope-To: netdev@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id aa64bcd72e854232;
	Wed, 02 Sep 2026 09:29:49 +0000
X-Mizu-Trace-ID: aa64bcd72e854232
X-Migadu-Flow: FLOW_OUT
Message-ID: <84b011a3-7662-4f6e-ad4d-6bf81d2e1b30@linux.dev>
Date: Wed, 2 Sep 2026 17:29:39 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3] ip: validate options before echoing them
To: Daehyeon Ko <4ncienth@gmail.com>, netdev@vger.kernel.org
Cc: David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org
References: <20260902055802.3724915-1-4ncienth@gmail.com>
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <20260902055802.3724915-1-4ncienth@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


on 9/2/26 1:58 PM, Daehyeon Ko wrote:
> IPv4 option metadata stores absolute offsets from the network header in the
> skb control block. That metadata is only safe to use while it still
> describes the header at skb_network_header().
>
> This invariant can be broken in more than one way. An IPv6 UDP packet can
> remain queued while IPV6_ADDRFORM converts its socket to IPv4, after which


For IPV6_ADDRFORM, we already reject this operation if outgoing ipv6 
packets still exist.

case IPV6_ADDRFORM: ...... if (sk->sk_protocol == IPPROTO_UDP) { if 
(udp_sk(sk)->pending == AF_INET6) { retv = -EBUSY; break; }

May be we can also reject this operationif ipv6 skbs still exist in 
read/recv queue ?


