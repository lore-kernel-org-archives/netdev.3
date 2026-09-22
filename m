Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63BE6549380
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 13:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790085320; cv=none; b=QtIp3l0KnBI1BAIwrsjd5UfPcMq8RNGMHGSwLd1LurYj50AXUHB6HxqbnC8d+0ohye5CyykoCZ/n6xXDGvLnNdrKJzQWbXr6HylPVpudCbHkcbouU64Rvsp5tUqfK9Uxq/Pj//pK9Bof8uN69ExD8TKi0vZw+PBdAbPEVvoW6kQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790085320; c=relaxed/simple;
	bh=7BbHKdMzr+Z/4HuBTcQGx32wV4cA540pjIz0Cxh2m4o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hBM610/0XoKfmre04i4QDWhqzR05uxpeAEzioHaQHRqWSs44+EmXrFNOrRN6M43WCAnqGYJXu3NBV9ZxQ8RP2NypL0zZ1JPfPn35KVLLkpOPtqhbh3fHDHE4B75WJxhXjpO5qsiGzpkz0KYess+0ZDuOW1m5qZo62SyqWhLPfWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hnsOz33l; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hnsOz33l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99D341F00893;
	Tue, 22 Sep 2026 13:55:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790085318;
	bh=PZN+/As3YJHYqBZAUeegw/c3ZnSXdl6af20oZLYYJ0I=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=hnsOz33lE92HqfXYP6p4PvEM8B/bWI9xyWtoE4xEyoLNaqg3VBJQTvCyrV1w5ms1k
	 9nX4Fqu7cmF49GcEFnRYcTtg3SQ+zryIm0apNUurTnTAW1Q7ahhDZ8EGHkmG0byi/y
	 YTsi4OBxFyrKregFq7DW9S95av/LY51hycjKB1hNIdkCQyHGoiAWH1Lsica4kHD/Uc
	 cXsTCrAJp7982qj9mo5w1NPHV5nDw7uPrPdw/l7Wz/QFZHG+mZ3K7mnJsg33kQg0hn
	 hn5PrPR2ixf+N6vRTJmCKHOu5cf4pPP1/607YOgSz9DyOdKMtO8FTQDv4DoIOdF/P9
	 mgd2Mm/DKYFmw==
Message-ID: <71792738-39d6-4375-9d47-bc4944727ed8@kernel.org>
Date: Tue, 22 Sep 2026 07:55:17 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] vrf: Stop corrupting skb->csum when capturing
 CHECKSUM_COMPLETE packets
To: Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, andrew+netdev@lunn.ch, andrea.mayer@uniroma2.it,
 stesasso@gmail.com
References: <20260922131239.2509494-1-idosch@nvidia.com>
Content-Language: en-US
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20260922131239.2509494-1-idosch@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/22/26 7:12 AM, Ido Schimmel wrote:
> The VRF device is an Ethernet device but it can have non-Ethernet ports
> such as IP tunnels. Before the cited commit, capturing packets from such
> ports on the VRF device resulted in these packets being detected as
> malformed since they lack an Ethernet header.
> 
> The cited commit fixed it by pushing a dummy Ethernet header to such
> packets before the capture and pulling it afterwards. In the case of
> CHECKSUM_COMPLETE packets it also updated skb->csum with the checksum of
> the dummy Ethernet header. This is wrong as skb->csum should not include
> the checksum of the Ethernet header ("checksum of the _whole_ packet as
> seen by netif_rx()").
> 
> This also means that L4 protocols receive a corrupted skb->csum and
> potentially drop the packet, as is the case with UDP packets whose
> checksum was completed by software.
> 
> Fix by removing the unnecessary call to skb_postpush_rcsum().
> 
> Fixes: 048939088220 ("vrf: add mac header for tunneled packets when sniffer is attached")
> Reported-by: Stefano Sasso <stesasso@gmail.com>
> Closes: https://lore.kernel.org/netdev/CALtE316UtL3x7LL6uxfXzx8rW6AbzYPeDOb478hqJCr_-dj=Wg@mail.gmail.com/
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> ---
>  drivers/net/vrf.c | 2 --
>  1 file changed, 2 deletions(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>

Thanks, Ido.

