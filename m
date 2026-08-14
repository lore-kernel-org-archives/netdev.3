Received: from mta1.migadu.com (out-81.mta1.migadu.com [95.215.58.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82F7A3BE161
	for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 10:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786704193; cv=none; b=G+olj3RY8EQNRyjzCiJD0ivD5HHSmYGHqyq5uO9VN5t5ZRfYV7dbBCONXjR9gc63iosxp0lN4ROzG7NeFbSZP7+XqnQmvYvxq65vwRyhEEn7/yLRHzGbydqxZRNqcen1i9aFLmS14reG2lPlzk13oY0TPn2kPBi+Oa5T+zHB+50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786704193; c=relaxed/simple;
	bh=TkMHXxDX3Q0Ph7sOnBczYV2bh5oVujI/gXqvKj6gW+A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l6A3XIhdPQsxvx31+/3uIngpw/bmt4sLDRffPfB46n7jaSfVvTxiDDbiR+v2HR/a5T5LUz6yJq60izh8gJgqHqQ0i5VTBZOuoCJOb+Z1h3O6feF5D0CbVKaEh4f2a12/w+q3P8BFGGXI2MfXWGHDPzF7K/lmfWmOfUgzXOllfeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=XWTUi3xt; arc=none smtp.client-ip=95.215.58.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="XWTUi3xt"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=TkMHXxDX3Q0Ph7sOnBczYV2bh5oVujI/gXqvKj6gW+A=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786704184; v=1; x=1787308984;
 b=XWTUi3xtv0DhqULhZCV1gNc6B8YE/IqELnyQnyoVy3j44nyUhn+uAbiBr/fRiVY1At78T025
 x5vYmdsYPA0PrTKHpYJ1Wmymodk0+s0kxdfGO/ThA6m5IKUjAgD0oDfunPh1fI0uKp+BggtIXUo
 SS1j46xiFKytlnPiiXXwG0tg=
X-Envelope-To: netdev@vger.kernel.org
Received: from [10.54.25.56] (210.22.144.162)
	by smtp.migadu.com with ESMTPS id 2962fc705d168a82;
	Fri, 14 Aug 2026 10:42:54 +0000
X-Migadu-Flow: FLOW_OUT
Message-ID: <cede3131-202a-4468-b848-f3ed2e721c72@linux.dev>
Date: Fri, 14 Aug 2026 18:42:47 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: advertise TCP MSS from the configured MTU,
 not the learned PMTU
To: Eric Dumazet <edumazet@google.com>, Neal Cardwell <ncardwell@google.com>,
 Willem de Bruijn <willemb@google.com>
Cc: netdev@vger.kernel.org, David Ahern <dsahern@kernel.org>,
 Ido Schimmel <idosch@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org
References: <20260814063545.225896-1-jiayuan.chen@linux.dev>
 <CANn89iJ-2Z5eFZKRAWS_MxVosr8Xe76k-P2djBX+JVfsH57heA@mail.gmail.com>
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <CANn89iJ-2Z5eFZKRAWS_MxVosr8Xe76k-P2djBX+JVfsH57heA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 8/14/26 5:21 PM, Eric Dumazet wrote:
> On Fri, Aug 14, 2026 at 8:36 AM Jiayuan Chen <jiayuan.chen@linux.dev> wrote:
>> The MSS a host puts in its SYN tells the peer how big a segment it may
>> send us. Right now we can shrink it with a PMTU we learned on our own
>> send path, which is the wrong direction entirely.
>>
>> On asymmetric paths this bites - think DSR load balancers, where the
>> request side goes through a smaller-MTU overlay. We learn a small PMTU
>> going out, then advertise a small MSS, and the peer stays capped for the
>> whole connection even though its path back to us is wide. MSS only shows
>> up in the SYN and never grows back.
>>
>> On symmetric paths we lose nothing by dropping it either: the peer runs
>> its own PMTU discovery and usually already knows the real path MTU.
>>
>> So work out the advertised MSS from the configured route or device MTU
>> and ignore the learned PMTU. Our send side is unchanged, still clamped by
>> tcp_current_mss(). Add ip_dst_mtu_configured()/ip6_dst_mtu_configured()
>> and use them from the two default_advmss() paths.
>>
>> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
>
> LGTM, but this probably needs Fixes: tags and should be sent to net tree.
>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Fixes: 164a5e7ad531 ("ipv4: ipv4_default_advmss() should use route mtu")
> Cc: stable@vger.kernel.org
>
> I added the following packetdrill test, please add it in a series.
>
> commit f0c619ca446b669c48b5c2e2c78e23af1a0850b6
> Author: Eric Dumazet <edumazet@google.com>


Thanks Eric, I will do it after cold time.



