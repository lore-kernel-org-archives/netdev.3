Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=121.127.44.73
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794492037;
	b=297de4PMUuE29IO+Bes/dOr01l/aS5hGdKP9esyjPRUuKiC2eNhB66qiA92TBR1GmgYd
	 mx+GW6YVH5FS3Op+wyT4UgQSfL1UQxOkzHTV9u0ZETm4Qz2UIA83WIUQQLGXtdwLu6oHf
	 fpRWu/fGMjMmx1su4Zrui1GiaAgkDLkGDmefJhj2GZoiLzaq/c/Z838kNBhTZkQSKYLxN
	 gtfY04pu53aQ8xAoD4MgDngdgZL4WA4u2h0pmQzTUanm11QepFPA4U/OzlmK9ckZD9fcj
	 EDFD8NyOjzNsHbX472FsjpOzVsCwn/IT1V/KRRhRYH5s3gEX1Qnfn44aRr/ZEjfdpdw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794492037;
	h=DMARC-Filter:DKIM-Signature:X-Forward-Email-ID:
	 X-Forward-Email-Sender:X-Forward-Email-Version:
	 X-Forward-Email-Website:X-Complaints-To:X-Report-Abuse:
	 X-Report-Abuse-To:Message-ID:Date:MIME-Version:User-Agent:Subject:To:
	 Cc:References:Content-Language:From:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=d1WbYIc2Iz5HDx5LnxTBFE8YVPlRRyGf0ESALqN6uMk=;
	b=lThezmaOHyyUjF6O2qOSEIoieXwD06k4Jf0Z/aMB0ZtEiyYb7uBCA7EiEmT34EiR4RBI
	 nFOu5l7Pu6ed8doFBjMAIuJ/FVu7jXLyrAMtGithMPMF5DiaSpXh+COZqrfo1YihOTp20
	 Aa72fcu8jiuTcVKES8o4hCiz4SNiiug11HfcFIdghRpitR4g58WHWUqlyaLshuHy3ITrL
	 ZhYSKeaIQtNjzir1ZSszyAeRVh8ARBq0n4iJIRF3A1YK5T0v36VYEHSA1GJfzAgUQVe+e
	 z5PT/Piz1rHoWQ/cU7dMArMLgizxQYTcds/Rd/UtEKfAs32GVAIovREI7XdwquUNtCg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ovn.org;
	spf=pass smtp.mailfrom=fe-bounces.ovn.org;
	dkim=pass header.d=ovn.org header.i=@ovn.org header.a=rsa-sha256 header.s=fe-13eddc7e57 header.b=HJKFg3DX;
	arc=none smtp.remote-ip=121.127.44.73
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EAFB606A88E
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 14:00:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9EAFB606A88E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.ovn.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ovn.org header.i=@ovn.org header.a=rsa-sha256 header.s=fe-13eddc7e57 header.b=HJKFg3DX
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ovn.org;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: Autocrypt: From:
 Content-Language: References: Cc: To: Subject: MIME-Version: Date:
 Message-ID; q=dns/txt; s=fe-13eddc7e57; t=1794492030;
 bh=d1WbYIc2Iz5HDx5LnxTBFE8YVPlRRyGf0ESALqN6uMk=;
 b=HJKFg3DXrDUhGi8gs42BmSmVeaeWnszDaMr2ONI3/OmHtV1Wn34mbUox2aj3SRX8n2/6I4mK7
 +7wGvis266Azx6LFpqbzV9xMdvLyhIUUJo5/0JnJF+C97TothTm/Ajm1pyL9boduffOgLeKXkDp
 PZWEBg5X2zIkcKXA+n+kmjM=
X-Forward-Email-ID: 6af5c67cb586e500661c815b
X-Forward-Email-Sender: rfc822; i.maximets@ovn.org, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 2.19.18
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <d8adb557-1902-44b5-8120-e16cfcf9388e@ovn.org>
Date: Thu, 12 Nov 2026 15:00:22 +0100
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] net: openvswitch: make transport checksums
 writable
To: Kyle Zeng <kylebot@openai.com>, dev@openvswitch.org,
 netdev@vger.kernel.org
Cc: aconole@redhat.com, echaudro@redhat.com, i.maximets@ovn.org,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, linux-kernel@vger.kernel.org
References: <20261107040238.27606-1-kylebot@openai.com>
Content-Language: en-US
From: Ilya Maximets <i.maximets@ovn.org>
Autocrypt: addr=i.maximets@ovn.org; keydata=
 xsFNBF77bOMBEADVZQ4iajIECGfH3hpQMQjhIQlyKX4hIB3OccKl5XvB/JqVPJWuZQRuqNQG
 /B70MP6km95KnWLZ4H1/5YOJK2l7VN7nO+tyF+I+srcKq8Ai6S3vyiP9zPCrZkYvhqChNOCF
 pNqdWBEmTvLZeVPmfdrjmzCLXVLi5De9HpIZQFg/Ztgj1AZENNQjYjtDdObMHuJQNJ6ubPIW
 cvOOn4WBr8NsP4a2OuHSTdVyAJwcDhu+WrS/Bj3KlQXIdPv3Zm5x9u/56NmCn1tSkLrEgi0i
 /nJNeH5QhPdYGtNzPixKgPmCKz54/LDxU61AmBvyRve+U80ukS+5vWk8zvnCGvL0ms7kx5sA
 tETpbKEV3d7CB3sQEym8B8gl0Ux9KzGp5lbhxxO995KWzZWWokVUcevGBKsAx4a/C0wTVOpP
 FbQsq6xEpTKBZwlCpxyJi3/PbZQJ95T8Uw6tlJkPmNx8CasiqNy2872gD1nN/WOP8m+cIQNu
 o6NOiz6VzNcowhEihE8Nkw9V+zfCxC8SzSBuYCiVX6FpgKzY/Tx+v2uO4f/8FoZj2trzXdLk
 BaIiyqnE0mtmTQE8jRa29qdh+s5DNArYAchJdeKuLQYnxy+9U1SMMzJoNUX5uRy6/3KrMoC/
 7zhn44x77gSoe7XVM6mr/mK+ViVB7v9JfqlZuiHDkJnS3yxKPwARAQABzSJJbHlhIE1heGlt
 ZXRzIDxpLm1heGltZXRzQG92bi5vcmc+wsGUBBMBCAA+AhsDBQsJCAcCBhUKCQgLAgQWAgMB
 Ah4BAheAFiEEh+ma1RKWrHCY821auffsd8gpv5YFAmfB9JAFCQyI7q0ACgkQuffsd8gpv5YQ
 og/8DXt1UOznvjdXRHVydbU6Ws+1iUrxlwnFH4WckoFgH4jAabt25yTa1Z4YX8Vz0mbRhTPX
 M/j1uORyObLem3of4YCd4ymh7nSu++KdKnNsZVHxMcoiic9ILPIaWYa8kTvyIDT2AEVfn9M+
 vskM0yDbKa6TAHgr/0jCxbS+mvN0ZzDuR/LHTgy3e58097SWJohj0h3Dpu+XfuNiZCLCZ1/G
 AbBCPMw+r7baH/0evkX33RCBZwvh6tKu+rCatVGk72qRYNLCwF0YcGuNBsJiN9Aa/7ipkrA7
 Xp7YvY3Y1OrKnQfdjp3mSXmknqPtwqnWzXvdfkWkZKShu0xSk+AjdFWCV3NOzQaH3CJ67NXm
 aPjJCIykoTOoQ7eEP6+m3WcgpRVkn9bGK9ng03MLSymTPmdINhC5pjOqBP7hLqYi89GN0MIT
 Ly2zD4m/8T8wPV9yo7GRk4kkwD0yN05PV2IzJECdOXSSStsf5JWObTwzhKyXJxQE+Kb67Wwa
 LYJgltFjpByF5GEO4Xe7iYTjwEoSSOfaR0kokUVM9pxIkZlzG1mwiytPadBt+VcmPQWcO5pi
 WxUI7biRYt4aLriuKeRpk94ai9+52KAk7Lz3KUWoyRwdZINqkI/aDZL6meWmcrOJWCUMW73e
 4cMqK5XFnGqolhK4RQu+8IHkSXtmWui7LUeEvO/OwU0EXvts4wEQANCXyDOic0j2QKeyj/ga
 OD1oKl44JQfOgcyLVDZGYyEnyl6b/tV1mNb57y/YQYr33fwMS1hMj9eqY6tlMTNz+ciGZZWV
 YkPNHA+aFuPTzCLrapLiz829M5LctB2448bsgxFq0TPrr5KYx6AkuWzOVq/X5wYEM6djbWLc
 VWgJ3o0QBOI4/uB89xTf7mgcIcbwEf6yb/86Cs+jaHcUtJcLsVuzW5RVMVf9F+Sf/b98Lzrr
 2/mIB7clOXZJSgtV79Alxym4H0cEZabwiXnigjjsLsp4ojhGgakgCwftLkhAnQT3oBLH/6ix
 87ahawG3qlyIB8ZZKHsvTxbWte6c6xE5dmmLIDN44SajAdmjt1i7SbAwFIFjuFJGpsnfdQv1
 OiIVzJ44kdRJG8kQWPPua/k+AtwJt/gjCxv5p8sKVXTNtIP/sd3EMs2xwbF8McebLE9JCDQ1
 RXVHceAmPWVCq3WrFuX9dSlgf3RWTqNiWZC0a8Hn6fNDp26TzLbdo9mnxbU4I/3BbcAJZI9p
 9ELaE9rw3LU8esKqRIfaZqPtrdm1C+e5gZa2gkmEzG+WEsS0MKtJyOFnuglGl1ZBxR1uFvbU
 VXhewCNoviXxkkPk/DanIgYB1nUtkPC+BHkJJYCyf9Kfl33s/bai34aaxkGXqpKv+CInARg3
 fCikcHzYYWKaXS6HABEBAAHCwXwEGAEIACYCGwwWIQSH6ZrVEpascJjzbVq59+x3yCm/lgUC
 Z8H0qQUJDIjuxgAKCRC59+x3yCm/loAdD/wJCOhPp9711J18B9c4f+eNAk5vrC9Cj3RyOusH
 Hebb9HtSFm155Zz3xiizw70MSyOVikjbTocFAJo5VhkyuN0QJIP678SWzriwym+EG0B5P97h
 FSLBlRsTi4KD8f1Ll3OT03lD3o/5Qt37zFgD4mCD6OxAShPxhI3gkVHBuA0GxF01MadJEjMu
 jWgZoj75rCLG9sC6L4r28GEGqUFlTKjseYehLw0s3iR53LxS7HfJVHcFBX3rUcKFJBhuO6Ha
 /GggRvTbn3PXxR5UIgiBMjUlqxzYH4fe7pYR7z1m4nQcaFWW+JhY/BYHJyMGLfnqTn1FsIwP
 dbhEjYbFnJE9Vzvf+RJcRQVyLDn/TfWbETf0bLGHeF2GUPvNXYEu7oKddvnUvJK5U/BuwQXy
 TRFbae4Ie96QMcPBL9ZLX8M2K4XUydZBeHw+9lP1J6NJrQiX7MzexpkKNy4ukDzPrRE/ruui
 yWOKeCw9bCZX4a/uFw77TZMEq3upjeq21oi6NMTwvvWWMYuEKNi0340yZRrBdcDhbXkl9x/o
 skB2IbnvSB8iikbPng1ihCTXpA2yxioUQ96Akb+WEGopPWzlxTTK+T03G2ljOtspjZXKuywV
 Wu/eHyqHMyTu8UVcMRR44ki8wam0LMs+fH4dRxw5ck69AkV+JsYQVfI7tdOu7+r465LUfg==
In-Reply-To: <20261107040238.27606-1-kylebot@openai.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/7/26 5:02 AM, Kyle Zeng wrote:
> An IP address rewrite can execute even if the transport-header pull in
> key_extract_l3l4() failed. In that case the transport key is cleared,
> but the IP protocol and transport offset remain available. The address
> rewrite helpers check the total skb length before updating the transport
> checksum. This does not guarantee that the checksum is in the linear
> head, or that it is writable.
> 
> An AI-assisted source review identified the missing writability checks.
> The supplied userspace reproducer sends non-linear IPv6 packets with

There is no reproducer supplied with this patch, so please drop that
part from the commit message or re-word.

> long, valid extension-header chains through TAP and Open vSwitch. It
> triggers a size-2 KASAN access in inet_proto_csum_replace16() as UID
> 1000 in an owned user/network namespace. The reproduction uses natural
> allocation pressure, without kernel changes or error injection. IPv4
> TCP/UDP and IPv6 TCP/UDP/ICMPv6 address rewrites have the same issue.
> 
> Replace the total-length checks with skb_ensure_writable() immediately
> before each transport-checksum access. Keep an unavailable transport
> checksum nonfatal, as with the existing truncated-header handling.
> Preserve the old address values across the operation and reload packet
> pointers afterwards, since even a failed pull can have moved the skb
> head. Retain the existing unchanged-address, later-fragment, and IPv6
> routing-header behavior.
> 
> The Open vSwitch module builds with GCC and W=1. The changed object
> also builds with allyesconfig and allmodconfig. Code review covers the
> common SET action paths and adjacent checksum writers. The supplied
> reproducer and kernel selftests have not been rerun against the rebuilt
> module. Codex assisted with the patch review, validation, and report
> preparation.

This paragraph also makes no sense in the commit message.

> 
> The issue was found by an LLM.

You already said that in the second paragraph.

> 
> Fixes: ccb1352e76cf ("net: Add Open vSwitch kernel components.")
> Fixes: 3fdbd1ce11e5 ("openvswitch: add ipv6 'set' action")
> Link: https://lore.kernel.org/r/20261030042304.74291-1-kylebot@openai.com

This link shouldn't be here.  Patch will be linked on apply.

For the sashiko complaint, the resoning should be part of the commit
message, so the bots and the people reading it in the future understand
why the decision to skip the l4 checksum update instead of failing was
made.

> Suggested-by: Ilya Maximets <i.maximets@ovn.org>
> Suggested-by: Aaron Conole <aconole@redhat.com>

I don't think Aaron suggested this implementation.

> Cc: stable@vger.kernel.org
> Signed-off-by: Kyle Zeng <kylebot@openai.com>
> ---
> v2:
> - Put writability checks directly in the transport-checksum branches.
> - Keep an unavailable L4 checksum update nonfatal.
> - Save the original addresses and refresh all potentially stale packet
>   pointers, including after a failed pull.
> - Target net, include all maintainers, and describe discovery and testing.
> v1: https://lore.kernel.org/r/20261030042304.74291-1-kylebot@openai.com
> 
> I have a reproducer for this issue and can share through DM.
> 
>  net/openvswitch/actions.c | 56 +++++++++++++++++++++++++--------------
>  1 file changed, 36 insertions(+), 20 deletions(-)
> 
> diff --git a/net/openvswitch/actions.c b/net/openvswitch/actions.c
> index 12e339cbf791..fe472e950cb1 100644
> --- a/net/openvswitch/actions.c
> +++ b/net/openvswitch/actions.c
> @@ -319,20 +319,22 @@ static int pop_nsh(struct sk_buff *skb, struct sw_flow_key *key)
>  	return 0;
>  }
>  
> -static void update_ip_l4_checksum(struct sk_buff *skb, struct iphdr *nh,
> -				  __be32 addr, __be32 new_addr)
> +static void update_ip_l4_checksum(struct sk_buff *skb, __be32 addr,
> +				  __be32 new_addr)
>  {
> -	int transport_len = skb->len - skb_transport_offset(skb);
> +	struct iphdr *nh = ip_hdr(skb);
>  
>  	if (nh->frag_off & htons(IP_OFFSET))
>  		return;
>  
>  	if (nh->protocol == IPPROTO_TCP) {
> -		if (likely(transport_len >= sizeof(struct tcphdr)))
> +		if (likely(!skb_ensure_writable(skb, skb_transport_offset(skb) +
> +					       sizeof(struct tcphdr))))

This and all other similar lines are misaligned.  It shoudl be a tab
instead of 7 spaces.

>  			inet_proto_csum_replace4(&tcp_hdr(skb)->check, skb,
>  						 addr, new_addr, true);
>  	} else if (nh->protocol == IPPROTO_UDP) {
> -		if (likely(transport_len >= sizeof(struct udphdr))) {
> +		if (likely(!skb_ensure_writable(skb, skb_transport_offset(skb) +
> +					       sizeof(struct udphdr)))) {
>  			struct udphdr *uh = udp_hdr(skb);
>  
>  			if (uh->check || skb->ip_summed == CHECKSUM_PARTIAL) {
> @@ -345,11 +347,15 @@ static void update_ip_l4_checksum(struct sk_buff *skb, struct iphdr *nh,
>  	}
>  }
>  
> -static void set_ip_addr(struct sk_buff *skb, struct iphdr *nh,
> -			__be32 *addr, __be32 new_addr)
> +/* May move the skb head; callers must reload packet pointers. */
> +static void set_ip_addr(struct sk_buff *skb, __be32 *addr, __be32 new_addr)
>  {
> -	update_ip_l4_checksum(skb, nh, *addr, new_addr);
> -	csum_replace4(&nh->check, *addr, new_addr);
> +	unsigned int addr_offset = (u8 *)addr - skb_network_header(skb);
> +	__be32 old_addr = *addr;
> +
> +	update_ip_l4_checksum(skb, old_addr, new_addr);
> +	addr = (__be32 *)(skb_network_header(skb) + addr_offset);
> +	csum_replace4(&ip_hdr(skb)->check, old_addr, new_addr);
>  	skb_clear_hash(skb);
>  	ovs_ct_clear(skb, NULL);
>  	*addr = new_addr;

There is too much unnecesary and unclear pointer ariphmetic happening.
It may be better if we just pass a boolean here and select nh->saddr
or nh->daddr with simple ternaries or if statements.  It would be much
easier to read and it will be less error prone.  Something like this
(not tested):

 /* May move the skb head; callers must reload packet pointers. */
-static void set_ip_addr(struct sk_buff *skb, __be32 *addr, __be32 new_addr)
+static void set_ip_addr(struct sk_buff *skb, __be32 new_addr, bool saddr)
 {
-       unsigned int addr_offset = (u8 *)addr - skb_network_header(skb);
-       __be32 old_addr = *addr;
+       __be32 old_addr = saddr ? ip_hdr(skb)->saddr : ip_hdr(skb)->daddr;
 
        update_ip_l4_checksum(skb, old_addr, new_addr);
-       addr = (__be32 *)(skb_network_header(skb) + addr_offset);
        csum_replace4(&ip_hdr(skb)->check, old_addr, new_addr);
+
        skb_clear_hash(skb);
        ovs_ct_clear(skb, NULL);
-       *addr = new_addr;
+
+       if (saddr)
+               ip_hdr(skb)->saddr = new_addr;
+       else
+               ip_hdr(skb)->daddr = new_addr;
 }


> @@ -358,19 +364,17 @@ static void set_ip_addr(struct sk_buff *skb, struct iphdr *nh,
>  static void update_ipv6_checksum(struct sk_buff *skb, u8 l4_proto,
>  				 __be32 addr[4], const __be32 new_addr[4])
>  {
> -	int transport_len;
> -
>  	if (l4_proto == NEXTHDR_FRAGMENT)
>  		return;

There is no point checking this anymore.

>  
> -	transport_len = skb->len - skb_transport_offset(skb);
> -
>  	if (l4_proto == NEXTHDR_TCP) {
> -		if (likely(transport_len >= sizeof(struct tcphdr)))
> +		if (likely(!skb_ensure_writable(skb, skb_transport_offset(skb) +
> +					       sizeof(struct tcphdr))))
>  			inet_proto_csum_replace16(&tcp_hdr(skb)->check, skb,
>  						  addr, new_addr, true);
>  	} else if (l4_proto == NEXTHDR_UDP) {
> -		if (likely(transport_len >= sizeof(struct udphdr))) {
> +		if (likely(!skb_ensure_writable(skb, skb_transport_offset(skb) +
> +					       sizeof(struct udphdr)))) {
>  			struct udphdr *uh = udp_hdr(skb);
>  
>  			if (uh->check || skb->ip_summed == CHECKSUM_PARTIAL) {
> @@ -381,7 +385,8 @@ static void update_ipv6_checksum(struct sk_buff *skb, u8 l4_proto,
>  			}
>  		}
>  	} else if (l4_proto == NEXTHDR_ICMP) {
> -		if (likely(transport_len >= sizeof(struct icmp6hdr)))
> +		if (likely(!skb_ensure_writable(skb, skb_transport_offset(skb) +
> +					       sizeof(struct icmp6hdr))))
>  			inet_proto_csum_replace16(&icmp6_hdr(skb)->icmp6_cksum,
>  						  skb, addr, new_addr, true);
>  	}
> @@ -396,12 +401,19 @@ static void mask_ipv6_addr(const __be32 old[4], const __be32 addr[4],
>  	masked[3] = OVS_MASKED(old[3], addr[3], mask[3]);
>  }
>  
> +/* May move the skb head; callers must reload packet pointers. */
>  static void set_ipv6_addr(struct sk_buff *skb, u8 l4_proto,
>  			  __be32 addr[4], const __be32 new_addr[4],
>  			  bool recalculate_csum)
>  {
> -	if (recalculate_csum)
> -		update_ipv6_checksum(skb, l4_proto, addr, new_addr);
> +	unsigned int addr_offset = (u8 *)addr - skb_network_header(skb);
> +	__be32 old_addr[4];
> +
> +	if (recalculate_csum) {
> +		memcpy(old_addr, addr, sizeof(old_addr));
> +		update_ipv6_checksum(skb, l4_proto, old_addr, new_addr);
> +		addr = (__be32 *)(skb_network_header(skb) + addr_offset);
> +	}

Same here, too much of unnecessary and obscure ariphmetic.  Suggesting:

 /* May move the skb head; callers must reload packet pointers. */
 static void set_ipv6_addr(struct sk_buff *skb, u8 l4_proto,
-                         __be32 addr[4], const __be32 new_addr[4],
-                         bool recalculate_csum)
+                         const __be32 new_addr[4],
+                         bool saddr, bool recalculate_csum)
 {
-       unsigned int addr_offset = (u8 *)addr - skb_network_header(skb);
-       __be32 old_addr[4];
+       struct ipv6_hdr nh = ipv6_hdr(skb);
 
        if (recalculate_csum) {
-               memcpy(old_addr, addr, sizeof(old_addr));
-               update_ipv6_checksum(skb, l4_proto, old_addr, new_addr);
-               addr = (__be32 *)(skb_network_header(skb) + addr_offset);
+               update_ipv6_checksum(skb, l4_proto,
+                                    saddr ? &nh->saddr : &nh->daddr,
+                                    new_addr);
        }
 
        skb_clear_hash(skb);
        ovs_ct_clear(skb, NULL);
-       memcpy(addr, new_addr, sizeof(__be32[4]));
+
+       nh = ipv6_hdr(skb);
+       if (saddr)
+               memcpy(&nh->saddr, new_addr, sizeof(nh->saddr));
+       else
+               memcpy(&nh->daddr, new_addr, sizeof(nh->daddr));
 }


>  
>  	skb_clear_hash(skb);
>  	ovs_ct_clear(skb, NULL);
> @@ -479,16 +491,18 @@ static int set_ipv4(struct sk_buff *skb, struct sw_flow_key *flow_key,
>  		new_addr = OVS_MASKED(nh->saddr, key->ipv4_src, mask->ipv4_src);
>  
>  		if (unlikely(new_addr != nh->saddr)) {
> -			set_ip_addr(skb, nh, &nh->saddr, new_addr);
> +			set_ip_addr(skb, &nh->saddr, new_addr);
>  			flow_key->ipv4.addr.src = new_addr;
> +			nh = ip_hdr(skb);
>  		}
>  	}
>  	if (mask->ipv4_dst) {
>  		new_addr = OVS_MASKED(nh->daddr, key->ipv4_dst, mask->ipv4_dst);
>  
>  		if (unlikely(new_addr != nh->daddr)) {
> -			set_ip_addr(skb, nh, &nh->daddr, new_addr);
> +			set_ip_addr(skb, &nh->daddr, new_addr);
>  			flow_key->ipv4.addr.dst = new_addr;
> +			nh = ip_hdr(skb);
>  		}
>  	}
>  	if (mask->ipv4_tos) {
> @@ -537,6 +551,7 @@ static int set_ipv6(struct sk_buff *skb, struct sw_flow_key *flow_key,
>  				      true);
>  			memcpy(&flow_key->ipv6.addr.src, masked,
>  			       sizeof(flow_key->ipv6.addr.src));
> +			nh = ipv6_hdr(skb);
>  		}
>  	}
>  	if (is_ipv6_mask_nonzero(mask->ipv6_dst)) {
> @@ -559,6 +574,7 @@ static int set_ipv6(struct sk_buff *skb, struct sw_flow_key *flow_key,
>  				      recalc_csum);
>  			memcpy(&flow_key->ipv6.addr.dst, masked,
>  			       sizeof(flow_key->ipv6.addr.dst));
> +			nh = ipv6_hdr(skb);
>  		}
>  	}
>  	if (mask->ipv6_tclass) {
> 
> base-commit: 05441d697f7f9a927264f4058cbbc6a03dfcac9d

