Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B33BB367F21;
	Mon, 29 Jun 2026 14:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782742792; cv=none; b=SvEnqFuqJ5NtmuZhMKJDEWKaJ0aR5B8rTmoBVP/gF9/DFCZyRRG1otg0FXPdY0QAgdyMsGXFV0YR5hUTBS/Dja/l2LIHKB3tAIMXra4e78pCnMSuLkKkl/695MhQoa0FVd+6CCL/bZ9wb75eY3VR85SHweUZgeYW3tYeCui1Dgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782742792; c=relaxed/simple;
	bh=iS99re75dY3V+PFIZ7qixxTmDNStP83Ea2LWPcXwUO8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Uir+QdOWV9hyz+N1Bri0DrXJqR/G0onHh77VCuETVtsLqMpT0go8ijNXlaWO/gIaVkzP+xobdrcaNoIxqQNs6zRNComSEWO49ejjbihj0/O1AfenZoBbW6xaHfEqtkAdMbAdKAOZ2B1oMbrB0tvIyIcW0QMlP+OZxlxyjWqvpAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QUTYDiDp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QUTYDiDp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6CF51F000E9;
	Mon, 29 Jun 2026 14:19:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782742790;
	bh=9uP35ct9WDNsGoQMpEhrEgfY0h8qu+42154CsbT28V4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=QUTYDiDpncZK1KhL546z/SGfIQMPTVsJm7s5oXih4yz57gBJVbhNOl0LAGujFiNoZ
	 fYHtDzfGYSSw3jGsqkjNFQaWYqZWa9MLogSX53L4f/3PLEboygLMU+HP1Reo6EEvU7
	 Bi0g1V0IRHMGmbAZEyEi09ftAX7dHCxexpXSVDFGWmzbmqPDUZaKmHQz4mbW6DSq0z
	 DFWNhKkIx+v72u0K+CYZvUt4ZjwL2vQ8SSBfBOVdvZUaP9+D4pDe6orHKmJn/rmyoU
	 88L/sx1efa6ros6lojSeSVcRqcGwjgPWFrULKppBlWzkWSKD/kB0ynSzAwUndIZTYb
	 L+KyhgI6u1OtA==
Message-ID: <b93b6a29-2ced-4a0e-82ba-1da8225f9308@kernel.org>
Date: Mon, 29 Jun 2026 08:19:48 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iproute2-next] devlink: support u32-array values in
 devlink param show/set
Content-Language: en-US
To: Ratheesh Kannoth <rkannoth@marvell.com>, pablo@netfilter.org
Cc: stephen@networkplumber.org, kuba@kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 sgoutham@marvell.com, Jiri Pirko <jiri@resnulli.us>
References: <20260615041042.549715-1-rkannoth@marvell.com>
 <e907ee3e-df70-4e32-a69f-29a9baaf1993@kernel.org>
 <akHW1ZiovKdwUq6s@rkannoth-OptiPlex-7090>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <akHW1ZiovKdwUq6s@rkannoth-OptiPlex-7090>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/28/26 8:22 PM, Ratheesh Kannoth wrote:
> On 2026-06-28 at 22:49:48, David Ahern (dsahern@kernel.org) wrote:
>> On 6/14/26 10:10 PM, Ratheesh Kannoth wrote:
>>> @@ -3904,6 +3935,14 @@ static int cmd_dev_param_set(struct dl *dl)
>>>  		if (!strcmp(dl->opts.param_value, ctx.value.vstr))
>>>  			return 0;
>>>  		break;
>>> +	case 129:
>>
>> no magic numbers. What does 129 represent? Is there a named macro for
>> it? If not, why not if this is part of a UAPI?
> 
> The magic number 129 actually represents DEVLINK_PARAM_TYPE_U64_ARRAY from the kernel UAPI (include/uapi/linux/devlink.h).

The uapi is actually devlink_var_attr_type and in this case
DEVLINK_VAR_ATTR_TYPE_U64_ARRAY.

> 
> The other cases in this switch block utilize MNL_TYPE_* constants from libmnl. I previously tried to
> patch libmnl to add a matching MNL_TYPE_UARR = 129 macro, but the netfilter maintainers declined it,
> noting that the enum is internal to libmnl (thread: https://lore.kernel.org/netfilter-devel/20260623043755.2435685-1-rkannoth@marvell.com/).

I agree with them.

Looking at the use of devlink_var_attr_type it is duplicating MNL values
for the early entries, but it is not nla_type as part of the nla_attr
uapi. Seems to me the 'nla_type' reference in the code is misleading.

I think cmd_dev_param_set in iproute2 needs to be changed to reference
devlink_var_attr_type instead of MNL_TYPE_*. With that as a prep patch,
add in the new use of DEVLINK_VAR_ATTR_TYPE_U64_ARRAY for this patch.
@Jiri: agree?

And then your subject line and commit message need to be updated to
reference a u64 array, not u32, correct?

> 
> To resolve this without magic numbers, I can use the existing kernel macro directly in
> the case statement with an explanatory comment, like so:
> 
> 	/* DEVLINK_PARAM_TYPE_U64_ARRAY maps to 129 */
> 	case DEVLINK_PARAM_TYPE_U64_ARRAY:
> 
> Please let me know if this approach works for you, or if you prefer a different handling.
> 
>>

