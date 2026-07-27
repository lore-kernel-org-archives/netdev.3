Received: from mail-wr2-f0.google.com (mail-wr2-f0.google.com [74.125.225.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB75642D75F
	for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 18:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785175297; cv=none; b=s3Tt1rbN3H+Qztj1dLrxy4xxS7EhwF6CBZVFk3jnBY/KBZIqn2ViH9RXbwA/I6THk4DfIs5VpSllKON2bOXHXATTYtVy7xSdXGvmI29aDHReahqOm1itUFLS28hU0JXycyG/z3qakTXF/4yRLIi9H7E2rPJohKuBBpaXj0KKcU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785175297; c=relaxed/simple;
	bh=b+n/2iB2uHX/RV9B+uAXOurS+RjncC8Tku/DSzHEW2M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kEEkIJljtPId4rTuDFLASr+iQwh1rmA/1wFsfsVB2R6BEH041FaCNCofukBlFRVi4KsMmOzlu/jZn8Zjzkrj4C1r7KTCwRwXEWRYhRdqRkyeXFB1ZXdt/AdUGhDDCFP1IVn73PGp889dK1AEEkuJw5jLjEgSmj9oOMhA6IE9Ok4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.225.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr2-f0.google.com with SMTP id ffacd0b85a97d-47f8fd5f16aso1404846f8f.0
        for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 11:01:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785175292; x=1785780092;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pQbucOyUiEoW2tUJJeNL0F0/fNmQ8BYd2yE1zScqXc4=;
        b=Kt4iiejVJcrtZZek41tHq8Q2cOPBTUg97U9uqffAf463EE/E2z2EKCjwbB2R1NOwgh
         mTl/kx7ttM3c2VTpeJRoW+omLviDXP6HT+jiW/dr8iFLd5O/7LsoEC5tOGRHpZSU/Fzl
         A5MnOWu3+38nnLxw4ubao3BlbVBlAW2CKJDgrdHwOtm1HBg62kG4ttoRMbmYm0FsmXBv
         yw/e8EhdW47rhjBTrHeq9LsfebMh7lC0dEcvyliEulXc/UUbsTnTWyv749zvSwK21Psh
         XWAL9gBgmSj0nnMNz9bKdaTd5ka5PBmPXrIBLc6hZcWObNErB9EiTJURcj7fA5hw0upV
         GEbg==
X-Gm-Message-State: AOJu0YzgdFHKh8a+UlxBPkqWwj8baRM3p7rZNGgrnf/HVtyrCfdJGlvH
	Any2ERNaitJcHFqzZnwXrDAIiySZR35CQmmuuEcno4klmnTlf095Vc3N
X-Gm-Gg: AR+sD11X4wRuqUvr4XTaZHwUbUHjQnF1iXXNuE3W8ylJ8uLR+AQ0GnZo9tDpW2TUbiL
	1qUFPXn8rdY+lf+iTxHo9EEu5FiIR3PzJrMt1FlDs9S+B87WFjfhE4QQC+VhkE9Cirg6YhVrUsV
	e8ELk0wiIJ66vgWkyvwc49hNED4p1C93xKiP/S7CAVO6dVcNKdLubks0jb/qp9lA6WYZt31Rzrz
	HuyKQiZsMenyqXrh1jfqZ6gj1WE4HYnN0TeH2HrAYxCEQhbgFOXUm2s/jVl32EvsOQzLY6mtmtt
	UEyEjkY2x8X6/hX7o4R7XQpzXJqIt5758JYD0Vyh/woGXLJEp0ARkRVkiUQhOgHypislRjTEqAI
	i4mUZHHSPP6iacB/QLaRpA9VSz6q2/krfLPuaasksKcGbTC3YJIfuQg9b+s7jCwuzH2mh63EjdM
	keTz9KrhKWzfal4PafFF3N+WYcqGM8bMkpbvgTEDw=
X-Received: by 2002:a05:6000:2dca:b0:47f:87f9:6d06 with SMTP id ffacd0b85a97d-47fafa80cfcmr197487f8f.61.1785175291790;
        Mon, 27 Jul 2026 11:01:31 -0700 (PDT)
Received: from [192.168.88.241] (78-80-108-129.customers.tmcz.cz. [78.80.108.129])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85c6f076sm51301231f8f.34.2026.07.27.11.01.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jul 2026 11:01:31 -0700 (PDT)
Message-ID: <403ae4a4-5df3-4744-89e4-12e46fd56f25@ovn.org>
Date: Mon, 27 Jul 2026 20:01:28 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v4] net/openvswitch: check Ethernet header length in
 key_extract()
To: "Cen Zhang (Microsoft)" <blbllhy@gmail.com>, aconole@redhat.com,
 echaudro@redhat.com, i.maximets@ovn.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org
Cc: netdev@vger.kernel.org, dev@openvswitch.org,
 linux-kernel@vger.kernel.org, AutonomousCodeSecurity@microsoft.com,
 tgopinath@linux.microsoft.com, kys@microsoft.com
References: <20260725043128.193164-1-blbllhy@gmail.com>
Content-Language: en-US
From: Ilya Maximets <i.maximets@ovn.org>
Autocrypt: addr=i.maximets@ovn.org; keydata=
 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
In-Reply-To: <20260725043128.193164-1-blbllhy@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/25/26 6:31 AM, Cen Zhang (Microsoft) wrote:
> When a packet arrives on an ARPHRD_NONE device (e.g. TUN),
> ovs_flow_key_extract() trusts the user-provided skb->protocol field: if
> it is ETH_P_TEB, the packet is classified as MAC_PROTO_ETHERNET and
> key_extract() is called without ensuring the skb has ETH_HLEN (14) bytes
> of linear data. key_extract() unconditionally pulls 2 * ETH_ALEN bytes
> for MAC addresses and parse_ethertype() pulls 2 more, either of which
> triggers a kernel BUG in __skb_pull() when the linear area is too small.
> 
>   kernel BUG at include/linux/skbuff.h:2848!
>   RIP: 0010:key_extract+0xa7e/0xd90 net/openvswitch/flow.c:933
>   ovs_flow_key_extract+0x419/0xa70
>   ovs_vport_receive+0x222/0x390
>   netdev_frame_hook+0x3e0/0x630
>   tun_get_user+0x2d0c/0x38e0
> 
> Fixed by calling check_header() in key_extract() before accessing the
> Ethernet header.
> 
> Fixes: 217ac77a3c25 ("openvswitch: allow L3 netdev ports")
> Reported-by: AutonomousCodeSecurity@microsoft.com
> Signed-off-by: Cen Zhang (Microsoft) <blbllhy@gmail.com>
> ---
> v4: Update documentation and move variables into the Ethernet block.
> v3: Use check_header() per review, fix format issue.
> v2: Moved the check into key_extract() per Ilya Maximets.
> Link: https://lore.kernel.org/all/20260721143602.64677-1-blbllhy@gmail.com
> 
>  net/openvswitch/flow.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/net/openvswitch/flow.c b/net/openvswitch/flow.c
> index 66366982f604..8ad0be37a65a 100644
> --- a/net/openvswitch/flow.c
> +++ b/net/openvswitch/flow.c
> @@ -889,8 +889,6 @@ static int key_extract_l3l4(struct sk_buff *skb, struct sw_flow_key *key)
>   * Ethernet header
>   * @key: output flow key
>   *
> - * The caller must ensure that skb->len >= ETH_HLEN.
> - *
>   * Initializes @skb header fields as follows:
>   *
>   *    - skb->mac_header: the L2 header.
> @@ -910,8 +908,6 @@ static int key_extract_l3l4(struct sk_buff *skb, struct sw_flow_key *key)
>   */
>  static int key_extract(struct sk_buff *skb, struct sw_flow_key *key)
>  {
> -	struct ethhdr *eth;
> -
>  	/* Flags are always used as part of stats */
>  	key->tp.flags = 0;
>  
> @@ -926,6 +922,12 @@ static int key_extract(struct sk_buff *skb, struct sw_flow_key *key)
>  		skb_reset_network_header(skb);
>  		key->eth.type = skb->protocol;
>  	} else {
> +		struct ethhdr *eth;
> +		int err = check_header(skb, ETH_HLEN);

Please, use the reverse x-mass tree ordering for variable declaration,
i.e. lines longest to shortest.  In this particular case, just move
the initialization to a separate line:

		struct ethhdr *eth;
		int err;

		err = check_header(skb, ETH_HLEN);
		if (unlikely(err)) ...

Otherwise, LGTM.



Sashiko reports two pre-existing issues that are not related to this patch:

1. Potential use of uninitialized bits of the key during lookup if the
   code takes the positive branch of the if statement, since the addresses
   remain uninitialized in the flow key structure.

   There should be no functional issues, as those bits will be bitwise
   ANDed with zeroes form the mask before the lookup in most cases, and
   in case of L3 key comparison with the L2 flow where the addresses
   will not be zero, the key must not match anyway due to prior mismatch
   on the eth protocol.  However, it is possible that KASAN will not be
   happy with these operations producing warnings.  I'll try to take a
   closer look at this one.  The zeroing out of the key was previously
   removed for performance reasons, since it doesn't affect flow matching.
   But having KASAN splats is also not great and potentially dangerous.

2. There is an unlikely case where ovs_flow_key_update() might fail,
   which would cause skb leak on failure of recirc() or ct() actions.
   I'm not really sure if this condition is reachable in practice as it
   requires parsing to fail on a packet that we previously successfully
   parsed and then modified.  But should be fixed nevertheless.
   I'll send a separate small patch set for this.

Best regards, Ilya Maximets.
