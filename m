Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CD9C4D73DF
	for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 14:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.166
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792421305; cv=pass; b=hm/QnsCYzO/YcZ1/PWqeBjy0afAaTLHOiWVmJ5SjnZsVmr2kxnJ35jcUX4R5N4eFBEJtUlQGsLOWSBUwu9N5d7lJEJ8oJUZ5/qrXehfvvcFqlmneRY+bZC0KnAgra6Mev5ZTmWL2Nf/PUpZGmK9Agbqnuo1sUp3IZs341gNynco=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792421305; c=relaxed/simple;
	bh=KtRgrbk4cdWvqtMsuF+6WxyUrype50D8+NF+PCRvC68=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cerV4430Ewk8p0rd5gdJEwcdBQX+JAoA5DJ05C8NTKzNRmxvMHnPshS/lIXvBUpcTiw0YIx9SKMgEIazaotpdGuc7cVPHToJuTgzh7t9bOj7IgNAlGturrXOS+Izv+18MinNSrmwFjL7dZD9Szr9YGFgRVChXVyBAjA6O5KkIAY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=Vkfe3EW7; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=uNCna+sg; arc=pass smtp.client-ip=81.169.146.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="Vkfe3EW7";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="uNCna+sg"
ARC-Seal: i=1; a=rsa-sha256; t=1792421283; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=NgU18o0oYsfcew7rPuRNEr3FFlLP03j7xC3YyA8waetBRlRfNMxVtjESshSUDiipNh
    MwFSuf0YiWLBwRnQ4HoPCJVXYxvda6c1OprRQfBC9nlfHwYlniiqUHWcJJWisx7q+YtL
    xHZoKsbV0LXXDD1wu3TLxfhVFeuWhaOkfA9thVld/9Wz+oQS9spEYd2n1Ockyt1GuwQl
    CLehDEr5tC2FnZYRlY7wIbBrXvuyAXKxpCCFSWpF/4RzBt6Sdl8nE5Siua4571qwjk31
    HLsS7ug/gj/5TgnS4vEOVOVNf3dg7Rjmno9lufLE7u6TbM9iX4QucBryuSBYWa4xaaKf
    eD4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1792421283;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=Am9IYcY8VLdf7s45sks5mTGT30lEapUlqqzMBU/AqiU=;
    b=VFr7RNrjH75Y2sj4epjPtFc9079czjUJEucgwMi8aXhgf4E64Haxhpa+r0uU3bS1K3
    PwN3n9bnMxzL1IDJLPYDGCLvpl/cSMvgcjLzyn1a1QIzCbfhG0P2KUTd+QtQ9/GLwnXw
    A4dRFLxSzJs90ZjJGdoRyCpx+zxa2nzDSUCS/vk3KKahtZQbX0RfiX/t/EGYVPXq/L7E
    jCMmYBFYDGgX9WtFg1ovnezrWg+DDEC0K1mZyM2zwTiMF4zZKJm3HgWPm2bM/EAeGJf0
    1oRr8l950AtN3tNGyjooAufJKVSn/g/EVnTG7DuduFMPS73O6s7ECzmPCjUAuF1QscC6
    IbQw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1792421283;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=Am9IYcY8VLdf7s45sks5mTGT30lEapUlqqzMBU/AqiU=;
    b=Vkfe3EW7qLyQ+/R8BLen4FPe5VBtqocLIOcQ1Hx3BXvWnZbEUrftRgGxXgXzXDbpyq
    jar83vp8yrohUkOj04cs/dNnd1uqvfnq7CKrCaGJ+GhhCcS8uFqKMB8SsYrYVJjWA3UJ
    I4I4mwTuaVdwwz687kKVqjgLedIO90a6MuiOtxSaXFF46NloDVQmQsVxe5JbUkwCw83j
    th7htD3BELUeH1WrED5u10zHdtoVjnSaA5al4nCv+ReZLbPiqraya0Bef8z6L9dJUYs7
    QGpbyXTklyD3Tyg5Rrk+SHR0p86nLXL+QSvcKAAkNgoWmoLNORUbad0jhbN3uR8ZR+ue
    QPUQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1792421283;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=Am9IYcY8VLdf7s45sks5mTGT30lEapUlqqzMBU/AqiU=;
    b=uNCna+sgfZvI1soZshx44e1IDvFnue7o39aq+gW/89tg+/8Tppw+elM17vG9rpqOlf
    BEfyw8IvjNkl7fPmYtDA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from [IPV6:2a00:6020:4a38:6810::989]
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Kfdf2a29JEm2XNU
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Mon, 19 Oct 2026 16:48:02 +0200 (CEST)
Message-ID: <b0ff428a-4d7e-47b0-b752-4533bb403677@hartkopp.net>
Date: Mon, 19 Oct 2026 16:48:02 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] team: reject CAN and IEEE 802.15.4 devices in
 team_port_add
To: Paolo Abeni <pabeni@redhat.com>, netdev-bot+sashiko@kernel.org
Cc: jiri@resnulli.us, netdev@vger.kernel.org, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, yaojiale02@163.com
References: <20261013083523.4728-1-socketcan@hartkopp.net>
 <179196707247.434549.3372737964220312421@kernel.org>
 <bf99c42f-92eb-4e4f-aba4-1aeda5b84f65@hartkopp.net>
 <6ecdd152-36ea-4ddc-8c41-d74f7fadd497@redhat.com>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <6ecdd152-36ea-4ddc-8c41-d74f7fadd497@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 19.10.26 15:58, Paolo Abeni wrote:
> On 10/14/26 13:49, Oliver Hartkopp wrote:
>> On 14.10.26 10:37, netdev-bot+sashiko@kernel.org wrote:
>>> Thank you for your contribution! Sashiko AI review found 1 potential
>>> issue(s) to consider.
>>>
>>> Critical: 0 · High: 1 (1) · Medium: 0 · Low: 0
>>>
>>> If you believe none of the issues are legitimate, please reply to each
>>> issue of Medium severity or higher and explain why the AI is wrong.
>>> If any of them are legitimate and you plan to respin, please let 
>>> patchwork
>>> know by including "pw-bot: cr" as a separate line at the end of your 
>>> reply
>>> (one such reply per series is enough).
>>>
>>> - [High] The new denylist in team_port_add()
>>>    (drivers/net/team/team_core.c:1228-1236) only rejects ARPHRD_CAN,…
>>>
>>> Pre-existing issues:
>>> - [High] This problem wasn't introduced by this patch, but the bonding
>>>    driver, which the commit message cites as the precedent being…
>>>
>>> -- 
>>>
>>> team: reject CAN and IEEE 802.15.4 devices in team_port_add
>>>
>>> This patch makes team_port_add() reject ports of type ARPHRD_CAN,
>>> ARPHRD_IEEE802154 and ARPHRD_IEEE802154_MONITOR. Team never sets up the
>>> private mid-layer data these L2 types expect, so enslaving one leads 
>>> to a
>>> NULL pointer dereference. The check mirrors the CAN check bonding has 
>>> had
>>> since commit 8ba68464e478.
>>>
>>> Link: https://lore.kernel.org/all/b58d98e0-8fe3-4e4e-b8a5- 
>>> c1c7e647ccca@hartkopp.net/
>>>
>>>> diff --git a/drivers/net/team/team_core.c b/drivers/net/team/ 
>>>> team_core.c
>>>> index ca75f08e3c593..5f1708c2a3445 100644
>>>> --- a/drivers/net/team/team_core.c
>>>> +++ b/drivers/net/team/team_core.c
>>>> @@ -1225,6 +1225,16 @@ static int team_port_add(struct team *team, 
>>>> struct net_device *port_dev,
>>>>           return -EINVAL;
>>>>       }
>>>> +    if (port_dev->type == ARPHRD_CAN ||
>>>> +        port_dev->type == ARPHRD_IEEE802154 ||
>>>> +        port_dev->type == ARPHRD_IEEE802154_MONITOR) {
>>>
>>> [Severity: High]
>>> Does this list cover the whole class of devices the commit message
>>> describes? ARPHRD_6LOWPAN devices still seem to get through
>>> team_port_add(). Examples are lowpan0 on top of wpan0, or a Bluetooth 
>>> bt0.
>>
>> I'll send a v4 covering ARPHRD_6LOWPAN too.
> If this message is not too late, please additionally include the
> relevant stack trace in the commit message.

Will add a stack strace ASAP.

Thanks!

Oliver
> 
> Thanks,
> 
> Paolo
> 

