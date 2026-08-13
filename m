Received: from mail-wr2-f1.google.com (mail-wr2-f1.google.com [74.125.225.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01E22443E31
	for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 10:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786615318; cv=none; b=W/pw6lFkEWjaSU3RqMjVPHMnnkqKOqkLTv9nC7m5930S/l0egTegjvRaxXyz8fmQ2EIJ8y5kzk9Ti0agR85KSuW4fhVQwzdgHgydDZ99oLAmaVfzjzG6J/M+DPKIF3MuUPtkqZirVOTMvP1DU5sPlMtLqp1AFyxwRhkxzJtz2TA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786615318; c=relaxed/simple;
	bh=Q0+QB9BwEYAYlgo9YE2H2s5de+QAXj0P1Ha1dNadRsg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EI/4ZbusRPBEfiWcEXZs1CRDw9hv0+vtcMy8e9qeK/c4jK+OCkaBqjZUcPxqKs1QeVhOECtbkoMpFrdNV9TrN2Vo/b4Hz0bx+09ESXd8XUtGq7uPC6kDZcCYjQB7iWNYKHTpRJiUYMYOzYuEK2AplW2EvyWS8lvAc8bKmGnPkrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.225.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr2-f1.google.com with SMTP id ffacd0b85a97d-47fd1b2021fso113582f8f.1
        for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 03:01:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786615315; x=1787220115;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=n97YvNOmj4b8I+aJs+kvkg3sEyKeOeBdhpSAoNMpAiE=;
        b=U9yadoVU8jd4X+arOqhfxZdlOFvv9Hz9V6CzPzfZcnmzM3sdX+cPhm5bJlakMBMMQc
         CIS9LBBFTZ6ZGOd8dwgPMBQh/4Dk1rjXalxRatUdlDrQyqd0lNRrGgz4+wzipXbpZ/ol
         cdapLiNXARKWtwXWqILiUZlkxux5l35e0BEYWlkM0o3jI13DYKrG28sZaTUgTAZ22kBS
         /KB3N0eLawBQ3l89QUKmawl/sUSusSTIq/v8rNNr1s9mWjzxuv2ndMYDDGLYynkHGrzi
         NdBGN6GjsQlmdTV67Fh/eupRC4A0EC/bbuQ07P1w8foOJfGlYi3bK4uoecQ1pce6ZQ+t
         K0eg==
X-Forwarded-Encrypted: i=1; AHgh+RqEPqtGMPpfsyA90xGkJxMU19b/s/59YX4tg1CW5TQVM7X+U7+I7+psx3ugpV+IoU02H+IBoV0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyyfnk2ars+1bNA3fm8vIuRBrtCL6zDwwbRAltsYiTjiowWZmOY
	hOHhnIc9v7OIMqg4BXLVXmwmjl6kxhEzIb9EsJmB1/F8Q4IcmsultQOG
X-Gm-Gg: AR+sD12dc9vVW1WQCclx6h9PWmSk6qiQojMOCOmOXpWDpdFaW250AEMrGYc0QoheTlp
	FUx/RW5b4Zj/dy7kgA7fGVOLIbxPwX3w0dsFYkn7SNjeH/mTaoI1Ge1T2yPGg0RqoKyp2cfe+5i
	T8BpUPf2mqX2AAqjh9q5dYJHVHgNW/u9/1xxBykqXkDWTABQ67+wGFH8TptdkjERqer6dI+87lN
	J2m4v5J8BR6+9KjaQrcxXvzV1HGh13G8XhPDvNVTl1YhDdOP/I6imVfHr/Yt29TwX0zN3zclqYm
	Rl7ub4kq4ciN5cL/8+7/seXBwmij7BFFPgoFQBsaOqmoJ3EKkSyA8ynDyqhXflPvgGJINutf50S
	DTGgFfR9XYzuCGQl+KnT563Ow6PrWka4K52Cg9cu0TPzivWFOk/D/lpwtF4Cb9GADVCGjMVOJ+P
	SaQJk7hJfglyEHBmLrVKZfkPCowrtd78q0v6MRPA9PlQeQ7bD6Lc5Jgs4mj0H6Glq3jTJSUApAW
	GZYKKaKCEzH4OgwonnfyGt0v5w=
X-Received: by 2002:a05:6000:41e4:b0:47f:aead:f81b with SMTP id ffacd0b85a97d-4815a00d5c9mr6363941f8f.21.1786615314886;
        Thu, 13 Aug 2026 03:01:54 -0700 (PDT)
Received: from [192.168.88.241] (89-24-57-65.nat.epc.tmcz.cz. [89.24.57.65])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4815a5c2769sm5148791f8f.36.2026.08.13.03.01.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Aug 2026 03:01:53 -0700 (PDT)
Message-ID: <799823a3-e128-4825-8c6b-09f3d26bf6d3@ovn.org>
Date: Thu, 13 Aug 2026 12:01:50 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 2/2] net: skbuff: don't skb_tx_error() the source skb
 in skb_zerocopy()
To: Norbert Szetei <norbert@doyensec.com>, netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Aaron Conole <aconole@redhat.com>, Eelco Chaudron <echaudro@redhat.com>,
 Ilya Maximets <i.maximets@ovn.org>,
 Steffen Klassert <steffen.klassert@secunet.com>,
 Kuan-Ting Chen <h3xrabbit@gmail.com>, Zoltan Kiss <zoltan.kiss@citrix.com>,
 dev@openvswitch.org, linux-kernel@vger.kernel.org
References: <8063260C-05C9-4997-B9B6-2135063C4858@doyensec.com>
 <C35992B1-7740-4886-94FF-F85DE8B0106F@doyensec.com>
 <187134BD-0DC1-4548-AA87-526A45213FEF@doyensec.com>
Content-Language: en-US
From: Ilya Maximets <i.maximets@ovn.org>
Autocrypt: addr=i.maximets@ovn.org; keydata=
 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
In-Reply-To: <187134BD-0DC1-4548-AA87-526A45213FEF@doyensec.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/13/26 7:49 AM, Norbert Szetei wrote:
> skb_zerocopy() copies frags from @from into @to. On an
> skb_orphan_frags() failure it calls skb_tx_error(@from), a destructive
> operation on the source skb the copy helper does not own. That completes
> @from's zerocopy uarg and clears SKBFL_ALL_ZEROCOPY, including the
> SKBFL_SHARED_FRAG page-ownership marker.
> 
> Both callers already report the failure on their own drop path.
> nfnetlink_queue does it at nla_put_failure, and open vSwitch does it in
> the flow-miss drop arm of ovs_dp_process_packet(), so nothing is lost by
> dropping it here.
> 
> On Open vSwitch's OVS_ACTION_ATTR_USERSPACE path the skb is not freed on
> this error: do_execute_actions() ignores output_userspace()'s return
> value and, unless the upcall was the last action, keeps forwarding the
> same skb through the flow's remaining actions. The uarg is completed
> while that skb is still in flight, telling the producer its buffers are
> free, and SKBFL_SHARED_FRAG is cleared on an skb the rest of the stack
> still handles. That flag is what makes esp_input() call skb_cow_data()
> instead of decrypting in place, so a later local ESP delivery can
> decrypt over frags the skb does not own privately.
> 
> Leave error reporting to the callers.
> 
> Fixes: 36d5fe6a0007 ("core, nfqueue, openvswitch: Orphan frags in skb_zerocopy and handle errors")
> Cc: stable@vger.kernel.org
> Suggested-by: Ilya Maximets <i.maximets@ovn.org>
> Signed-off-by: Norbert Szetei <norbert@doyensec.com>
> ---

Reviewed-by: Ilya Maximets <i.maximets@ovn.org>

