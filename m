Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90AC745560D
	for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 12:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790771853; cv=none; b=UbjJMb9C/V/BTEvaYKjdb8kjXR+UP8CyxIc48CwGwPpWIhYCdgvF5VAHj0QfoU1qAS2HBjr5lBg4T47YPcvbaEnGUZEfdy9BKJ//1A8BYfZueHavGUR52NHNHus0FSn04T4MRMA0FB2zFZd7oPwyO94OgpAZjckAT9FoJGPH7Us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790771853; c=relaxed/simple;
	bh=aIh6+o4NdnT5vAD3w3VGAeW/zKl6KvwzT1KPor5cIIA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XnF356SYHc5KRAMeDl8mWZxnVpTyOaLPxq0HS/BGqTGHXl1o+7wdGxwJy7qmrzreAI+TCPRYABoMLuRLbFBPRjd8TjzfB7qx158dswnnNEUPVzusLDTFWRRNegh5RiL3NkRSam0YpaGQAV2OIA3F86dGQFIou2ZeZ0o1Wcl4/N4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gkAE8MLT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gkAE8MLT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD9501F000FF;
	Wed, 30 Sep 2026 12:37:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790771852;
	bh=V/QGEzpPTvGTYz7f3YjbwJNyXjuVK+7J3Dih/GPlu48=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=gkAE8MLTKDa69sU3FWIaNxsFeynrFxr34PKoFg9FKsfMAL5gYRMDWOYWqIIU8aQT9
	 Hat8egRFraii/OfT70kxaGOuztbmop5EPc2jW6hkKB4eqGtY7MPG5NOYI9NiuvO+As
	 P+oJqh/1kL0+jniNUS32+jh12ORmidEBZPScTMglOYuMP/SRru3811YQcZqtiUfGrC
	 MiWrD4jXa9iJPaslGgq6WHIBxCDK4ixP4qxaHlBV1J7/MXOBOmt2QlD0W+HZqJ+8Om
	 gv9ahpUyRh38K8+9BkDESeREGVJdIATxquHxE35N+8YEgxeJuCnZ9D8WqxBf6T0vLp
	 xFC7IgU684wJA==
Message-ID: <b752694c-6598-4ff6-a7b3-84a4903b296f@kernel.org>
Date: Wed, 30 Sep 2026 06:37:30 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] ipv4: use zero IPID for atomic datagrams on
 connected sockets
Content-Language: en-US
To: Eric Dumazet <edumazet@kernel.org>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Neal Cardwell <ncardwell@google.com>,
 Kuniyuki Iwashima <kuniyu@google.com>, Ido Schimmel <idosch@nvidia.com>,
 edumazet@google.com, netdev@vger.kernel.org
References: <20260929153834.566551-1-edumazet@kernel.org>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20260929153834.566551-1-edumazet@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/29/26 10:38 AM, Eric Dumazet wrote:
> ip_select_ident_segs() uses the per-socket private generator
> for connected sockets, even for packets with IP_DF set.
> 
> This was historically done to work around buggy Windows95/2000
> VJ header compression implementations, dropping every other
> packet in a TCP stream when the IP ID field did not change.
> 
> RFC 6864 section 4.2 states that "Originating sources MAY set the
> IPv4 ID field of atomic datagrams to any value".
> 
> Packets with IP_DF set and skb->ignore_df cleared can not be
> fragmented, neither locally (ip_fragment() refuses to do so)
> nor by routers on the path.
> 
> Set their IPID to zero, like we already do for unconnected sockets
> and in ip_build_and_send_pkt(). FreeBSD also does the same by
> default (net.inet.ip.rfc6864 = 1).
> 
> Connected sockets still use their private generator for packets
> without IP_DF, or with skb->ignore_df set.
> 
> This avoids an atomic operation on a shared cache line for
> connected UDP sockets using IP_PMTUDISC_DO/IP_PMTUDISC_PROBE,
> and TCP no longer touches inet->inet_id in the fast path.
> 
> Minor side effects: IP IDs can no longer be used to distinguish
> network duplicates from TCP retransmits, or to correlate packet
> captures taken at different points. OS fingerprints will also change.
> 
> Signed-off-by: Eric Dumazet <edumazet@kernel.org>
> ---
>  include/net/ip.h | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>


