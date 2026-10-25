Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792957362;
	b=h070qGxDIgy+YHuu8QITxaYkhBayxvyBDDIz6wmv0w9LRG5Igdjak2uSBCyZoTDlLbN1
	 A/URn0GqGMpX2qdtBfRMiDzO3fvO/0D33JzKtIQpnlM1+c3NJVjhBw7aVv0gxgFobVrfw
	 TKfhFebYqlx8GkkLWIRmvHapqKaZYbbTclG0iNnbYsJUI3BEN6BG8XCNHgWuZbHRfaEmI
	 RhNOjC3B8RRUe0OwLhd3RdDPMfAY7HJPP1lhFeQub8iDDjXR2QL2QvaLuceXha2lLxqre
	 zxx91e2isvl3Rq8Pguehs4xA0nT8MwqrBrTtFrOyWx/BF5N/FkLOIT0shNNr3bHtdqg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792957362;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:Content-Language:To:Cc:References:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=gJdqFv7x5YJU260/H/Wz300qdhKDuJnZTzjsirnU2yY=;
	b=V6XKs8aJLgq5VARVwUhi9Xv0wiwjPIcLLCmCy+pLkqGuIsntqSJZLdF0rgnFWuqmbRLK
	 kJg7cYCLEz7rdM/v1W85WJ8h4P7Mr2e65xfLArIkg0rZfwx/VyX0fQfLXMu53EsLQEZYd
	 hQ0WOV2DwXnkeaBqEI/qqvHYvRq6fp3hRiyA8xuf5YPUrsLC2T00HEn1mZgmw/ZB/djhK
	 MFiOskM7CNKVsQp5tlsSIby0tjEX9fUMwHRfQC79wQ7ozjIZvRkalGwNJEbB8q60BV3pi
	 /6t186/7hgsS6MJ202i5G6HVO+LMLlGG12RLRjn7bJeszbs56JydHsCuHJndZ6CUEWw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mkzUrowP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 811D0606A31D
	for <netdev@vger.kernel.org>; Sun, 25 Oct 2026 19:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mkzUrowP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB3631F01825;
	Sun, 25 Oct 2026 19:42:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792957362;
	bh=gJdqFv7x5YJU260/H/Wz300qdhKDuJnZTzjsirnU2yY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=mkzUrowPC1HsKietLuoqNl3uxq8pxMCrlZiVNUJGZtmHLPZqZBvzpIssHDO/UNhlC
	 J/AqYyRZNjpsd3xr2HD2kxyiCdyS5oG46WJVWG0SHzce6/R99SDDeHhhm+9vDn+pwM
	 CFBelN6NE3jSAfC5l1OheXstccNiIwZOM6JH8oe/YWyITVgBVKiKILln6PAUyuNbMA
	 24klitjB+8IKIIiMRwQzNkdC6g7onl7IhUctYAB7Frt3DyJGqp9sZa7OiHdtJYPeqO
	 9jqDkWwYG/wP8dH9svPre60c5/uOcgHmdACcyg4j4xrz8MCWwquGtPeVkMf289rVv0
	 RV5ADSbkKm99g==
Message-ID: <65dc14b8-8e9f-4a70-8698-2bf12cbce5f0@kernel.org>
Date: Sun, 25 Oct 2026 13:42:41 -0600
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
Subject: Re: [PATCH iproute2-next] json_writer: fix pretty printing of arrays
Content-Language: en-US
To: Stephen Hemminger <stephen@networkplumber.org>,
 Hadrien Patte <hadrien.patte@protonmail.com>
Cc: netdev@vger.kernel.org
References: <20261022211002.31098-1-hadrien.patte@protonmail.com>
 <20261023181302.2a06fe99@stephen-xps.local>
 <20261024183341.34161-1-hadrien.patte@protonmail.com>
 <20261025113418.2f5acab4@phoenix.local>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20261025113418.2f5acab4@phoenix.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/25/26 12:34 PM, Stephen Hemminger wrote:
> On Sat, 24 Oct 2026 18:50:46 +0000
> Hadrien Patte <hadrien.patte@protonmail.com> wrote:
> 
>> On Fri, 23 Oct 2026 18:13:02 -0700
>> Stephen Hemminger <stephen@networkplumber.org> wrote:
>>
>>> Putting all the array elements on oneline is easier to read and more compact.
>>> What does python do?  
>>
>> My current patch actually contains two separate changes:
>>
>> 1. A fix for arrays of objects. Scalar arrays render fine on a single
>>    line, but when the elements are objects, which contain newlines, the
>>    brackets and separators end up glued to them and the indentation
>>    levels of opening and closing brackets are off:
>>
>>    # ip -j -p addr show dev lo
>>    [ {
>>            "ifindex": 1,
>>            "ifname": "lo",
>>            "flags": [ "LOOPBACK","UP","LOWER_UP" ],
>>            ...
>>            "addr_info": [ {
>>                    "family": "inet",
>>                    "local": "127.0.0.1",
>>                    ...
>>                },{
>>                    "family": "inet6",
>>                    "local": "::1",
>>                    ...
>>                } ]
>>        } ]
>>
>> 2. Putting each element of scalar arrays on its own line. This is a
>>    style change rather than a fix, though it is consistent with common
>>    JSON pretty-printers such as jq or python's json.dumps.
>>
>> I'm happy to send a v2 that only keeps the first part, leaving scalar
>> arrays in their current single-line form if you prefer.
>>
>> Thanks,
>> Hadrien
>>
> 
> Looks ok, as is. more of an observation by me.
> I don't in general look at json pretty print 

Meaning you are good with both changes? If so, Hadrien the 2 separate
changes should be 2 separate patches if possible.
