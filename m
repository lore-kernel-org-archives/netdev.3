Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 419E13DEAF7
	for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 18:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773686202; cv=none; b=R1pUox1/rbuD4MKYy8s4iugVjApUhEeOZl0VW6FWxVPmpulRlCaDVJ+DR3rxvB8S02T5OUIhRki6bvx+ckB2OSCpcz0y/7D6D13dvwAknNDyiPiOFM2/td7fZYmSVaOJwOHuouUG4VPFzqcFs+qPSmBEb2CK1JsxKmPNW1rXDQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773686202; c=relaxed/simple;
	bh=OFE/aVa+v1CfWNMpUZ2YoBhJ0BozyU+3cj3ruLgWHBE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qxQ3n++BCNuebEBz/JdBN9OgK54NQk5K8KrK8E2Vw0QnFejiIw2kxS9P6kJcXFTO14zaOU0Gln6Z3K9bPkMs0YbXBfLK7LjnSdoMc1OxTFQjtJXrTRTlLAuaaQeBaASCLTlXwow1kHHvp2r53oh2dhPXS5iY/lowb1dGp6Ty6jE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U2uhn/4B; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U2uhn/4B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E968C19421;
	Mon, 16 Mar 2026 18:36:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773686201;
	bh=OFE/aVa+v1CfWNMpUZ2YoBhJ0BozyU+3cj3ruLgWHBE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=U2uhn/4BJnWNzENfLgqaK1rDiFDqUL7q+RjBlo4i56wUf34NC8NVfUaETHlL3bbpN
	 QbM02R9PIpC0cMw9hc1pJoA/dlaxizRQgAH9CoXqurLp+KBTV7D1aL8BOxYWAUfsuN
	 cjNh+/LspoXCcLJwR9me2jsp16K/U4Wk+jkDi2dqxcSzr8YO/En2PiEgN18Z7M/Kev
	 mK6UdXl6LuMrszupehFfOeV0BAc1ofTINCjFIyCa+OIz3pD3pi82wknlo2kVEhJ1PQ
	 RhtQGKSjxpAavuieZGAPLWBSm0Ht0SjeyKJWPw3NV0KsWJtqpU8FUbEYw60ZF2rmeQ
	 kxTnmmq23LReQ==
Message-ID: <622ad33e-f9f9-4039-b2ca-fdb480f979b5@kernel.org>
Date: Mon, 16 Mar 2026 12:36:40 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 net 0/2] ipv6: Fix two GC issues with permanent routes.
Content-Language: en-US
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Kui-Feng Lee <thinker.li@gmail.com>,
 Xin Long <lucien.xin@gmail.com>, Simon Horman <horms@kernel.org>,
 Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
References: <20260311052954.1224278-1-kuniyu@google.com>
 <20f079ac-3046-4b12-a9c4-381a077cf36a@kernel.org>
 <CAAVpQUAxyQESuJ_-H9vW3szTL_76LjksyswOmQYti1yj_jbeKQ@mail.gmail.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <CAAVpQUAxyQESuJ_-H9vW3szTL_76LjksyswOmQYti1yj_jbeKQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 3/16/26 7:28 AM, Kuniyuki Iwashima wrote:
> On Fri, Mar 13, 2026 at 8:03 AM David Ahern <dsahern@kernel.org> wrote:
>>
>> On 3/10/26 11:29 PM, Kuniyuki Iwashima wrote:
>>> Patch 1 fixes the unbounded growth of tb6_gc_hlist due to
>>> permanent routes whose exception routes have all expired.
>>>
>>> Patch 2 fixes an issue where exception routes tied to
>>> permanent routes are not properly aged.
>>>
>>>
>>
>> There are several tests covering gc and changing routes from permanent
>> to temp and back. Can you expand those tests to cover this problem?
> 
> I'll expand pmtu.sh or icmp_redirect.sh, but do you have something
> in mind ?

tools/testing/selftests/net/fib_tests.sh based on:

commit 3407df8dc2de07d6b80f28d1a19a5c24a835f69b
Author: Kui-Feng Lee <thinker.li@gmail.com>
Date:   Thu Feb 8 14:06:53 2024 -0800

    selftests/net: Adding test cases of replacing routes and route
advertisements.

    Add tests of changing permanent routes to temporary routes and the
reversed
    case to make sure GC working correctly in these cases.  Add tests
for the
    temporary routes from RA.


