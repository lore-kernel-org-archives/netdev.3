Received: from mta0.migadu.com (out-251.mta0.migadu.com [91.218.175.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67FEB3B8BBF
	for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 06:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.251
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790749140; cv=none; b=lGpyAw9LX6mSNmRrUb2Qz2GrXQwkFjNXiMDTYKyX/GtuBvDynF+YYHVtn592k/DfV7Ps/FilEzeC92+Ma9pe28Y92t0Xv9HPe12jXzzHvao4CBw37m+Sl/80njMGylGR9+DvsKHeuVja50RfYxM/QlnWOmqLWqKkTsdGqgl9e6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790749140; c=relaxed/simple;
	bh=snBJQ+lQIIMpi6AglwAtnrHAmlNkvBEanptfE+hWDE0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nne0P6PBoQQVK5SS+ZHloUo1cRvIGp1QnpsdHPbyfVgf131QElWjSU6FrtwhOMDV/sJFZmXHkepiOhHsQ0bdtDyVtvlTcuPAxYKF+r0VpeuMA760/wII/5V5s5j8CU+cqWMTyOI/STyB85pbBe6u83yEeHyoexs9Lcl62q5+4a0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=N2qYj2Dn; arc=none smtp.client-ip=91.218.175.251
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="N2qYj2Dn"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=snBJQ+lQIIMpi6AglwAtnrHAmlNkvBEanptfE+hWDE0=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790749134; v=1; x=1791353934;
 b=N2qYj2DnFFRLAxPwWdcGRjjPVYgSz2XMOkZpUoIBrf+RhR5wTkpYYZBUrLlk+WnKpKzAFlMc
 OvmtzxjWOFNvRXaHExbUdNLlYckzXLBGm0Dn+RuKipmsFnmU/59Q5hZ3f3KvbvfR/QL06y/PW7A
 njNMZSAAkMRy4T2OANEBCp70=
X-Envelope-To: netdev@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 63691c95b7772991;
	Wed, 30 Sep 2026 06:18:44 +0000
X-Mizu-Trace-ID: 63691c95b7772991
X-Migadu-Flow: FLOW_OUT
Message-ID: <a988ac49-d701-4588-9e66-85bf3d6d0e12@linux.dev>
Date: Wed, 30 Sep 2026 14:18:38 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 2/2] ipv4: reserve one IP ID per segment for UDP GSO
 packets
To: Eric Dumazet <edumazet@kernel.org>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Willem de Bruijn <willemb@google.com>,
 David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
 netdev@vger.kernel.org, edumazet@google.com
References: <20260929131247.401104-1-edumazet@kernel.org>
 <20260929131247.401104-3-edumazet@kernel.org>
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <20260929131247.401104-3-edumazet@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 9/29/26 9:12 PM, Eric Dumazet wrote:
> __ip_make_skb() reserves a single IP ID for UDP GSO packets, but GSO
> assigns one IP ID per segment. Following packets then reuse these IDs,
> either from inet->inet_id or from the shared generator.
>
> Unless IP_PMTUDISC_DO/PROBE is used, DF is not set on UDP GSO packets,
> so segments can be fragmented on the path and IP ID reuse can lead to
> incorrect reassembly.
>
> Reserve one IP ID per segment, using the same test as udp_send_skb().
>
> Fixes: bec1f6f69736 ("udp: generate gso with UDP_SEGMENT")
> Signed-off-by: Eric Dumazet <edumazet@kernel.org>


Reviewed-by: Jiayuan Chen <jiayuan.chen@linux.dev>


> ---
>   net/ipv4/ip_output.c | 15 ++++++++++++++-
>   1 file changed, 14 insertions(+), 1 deletion(-)
>
> diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
> index a24cc8ee11d3ea3069bcc0d4d12e6867c2c475f7..b1cf0c6bfc79c8d234cc81ff32332116c1ee3401 100644
> --- a/net/ipv4/ip_output.c
> +++ b/net/ipv4/ip_output.c
> @@ -1410,6 +1410,7 @@ struct sk_buff *__ip_make_skb(struct sock *sk,
>   	struct iphdr *iph;
>   	u8 pmtudisc, ttl;
>   	__be16 df = 0;
> +	int segs;
>   
>   	skb = __skb_dequeue(queue);
>   	if (!skb)
> @@ -1464,7 +1465,19 @@ struct sk_buff *__ip_make_skb(struct sock *sk,
>   	iph->ttl = ttl;
>   	iph->protocol = sk->sk_protocol;
>   	ip_copy_addrs(iph, fl4);
> -	ip_select_ident(net, skb, sk);
> +
> +	/* UDP GSO packets are segmented later (see udp_send_skb()):
> +	 * reserve one IP ID per segment.
> +	 */
> +	segs = 1;
> +	if (cork->gso_size) {
> +		int datalen = skb->len - skb_transport_offset(skb) -
> +			      sizeof(struct udphdr);
> +
> +		if (datalen > cork->gso_size)
> +			segs = DIV_ROUND_UP(datalen, cork->gso_size);
> +	}
> +	ip_select_ident_segs(net, skb, sk, segs);
>   
>   	if (opt) {
>   		iph->ihl += opt->optlen >> 2;
