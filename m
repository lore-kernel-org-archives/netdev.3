Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=81.169.146.170
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792425571;
	b=2Zba5DaksHzNvcMWvtdJoGwrKpXzhKxx2h4E42IyzQG3QRHg1ZJbqIr7ZnXToebnhrNC
	 qrDg4HAiAUPPVFKWW9BSG0BSwciTnMfYf7LilxJ2U+h0AnAcSijAZ79+Yzkk7sCn6VZ4x
	 EOaulNeEbXd5jv4lblToBYJhLn6QD0lMYADX9yQkWNaleiAmStpXfHAPR6+8RvHiAaKPj
	 W1fWNEtBnfLXLAYhBs9hsWVs9inzVPGxS1E3IjJhje38TonU5m/W2nmDYMXJ5e39wP+ua
	 eR/1TQE88K477DKgXLinHf2x2N8u4PotstjFskV2JCdyTWCSDDz5MdHS1hVx7OtOnUg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792425571;
	h=DMARC-Filter:X-RZG-CLASS-ID:DKIM-Signature:DKIM-Signature:X-RZG-AUTH:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=v7CjAAoIEFm2pvbnTgsXyElzjQ1U6UrWV6gU8iTMfMY=;
	b=z7eWdlc3PeRruyLACC5BRXGp3ejedmVpgnNJl+WfcFNKv9HIQVBIE6OqDVI7eAeDQE17
	 IHcjRimJ7N7DzmqS/31yMAN+YimWURKYfdClhCED3xFXlE6qqlsMrp6yBDYGxPZLAzOJh
	 yvkwVS/4w3O+9zU963Aq2CjDTIEUycJFVs/frEIgHhsVUx+ieY8uapvHg7a3Tbs7ceNSB
	 taU0sYL0VCGN8e3N1RoJZCUZ//UexQCWfOuwhvZTVO9+wK891SP5TApqrCLUAKuol4eEq
	 Q9yWP4z7RKyOt/WGtCNvPsc89Foa03DLSbrbz4281/6/+74+yhP2YL0rhf/XlUj3eXw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hartkopp.net;
	spf=fail smtp.mailfrom=hartkopp.net;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=rCT39n6u;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b="vMeV/G4w";
	arc=pass header.oldest-pass=0 smtp.remote-ip=81.169.146.170
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [81.169.146.170])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95C6060705D9
	for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 15:59:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 95C6060705D9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=rCT39n6u;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=vMeV/G4w
ARC-Seal: i=1; a=rsa-sha256; t=1792425558; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=O1QECGQONFlI2F/QuXkUgSvGbWAR2zJuQCiMhTz73mo2ewoGvNZHzw4pm4Qe37GpJ7
    U8XHr6xYbh1o46awFwEitbHjBLEFtMidG5iYrrHaODD/mVocBd/Rh8GGWqm03kH8AdR4
    6NLocBA2CYOLBGJhjK2BDmIpeIzpiykWX77qUPbTyMbLmhiOgbEg0nRINPSXt6lypjA5
    G6e4JBmGvK2dA/gSYRH7479U50IUaTwAd8QzgMHh3EPP8XWmYudTsTDoa6p0h4ZU4Apm
    RYiN5Q/qW7kH9bKPin/KOmiu5rpYKAnGVjM5Dh/hZ/rE2ZsKfq5srRLzBM/isxz1Vn9c
    5kyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1792425558;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=v7CjAAoIEFm2pvbnTgsXyElzjQ1U6UrWV6gU8iTMfMY=;
    b=XAze8AcEaX9X51Mwor+TwbAI8EwvYrTJZQ381C7PTVhJBHbsuR3UbS/2Wlw/MVQPxP
    8mtZtshmxEIiiID2/+3PaPAeI3dJISSwPs6w+d9/HS5BsR6Z4JNFAVOtlkYH1LHxF69y
    UpnSA91N2pa7b0VyHijQKcBJ2ytUWZChC4GUN/lsZ/YAC7NwQLMtPnl8TPK39YziI98z
    QQAoMO9od+r1b57+lQnQl8IdP3z77ScJq7ozU7FViv1pwRh5ZIVcKpp2WpV30SsPy34K
    jadz0nHsHYgVD3QM3CyJbotnkZxLhK6qAEHBgVLydNgeqKw/roHq+VfCx0TTbNlLARRB
    YZPA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1792425558;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=v7CjAAoIEFm2pvbnTgsXyElzjQ1U6UrWV6gU8iTMfMY=;
    b=rCT39n6ui/mJ9ORlQu+150/tLrso9zqsaRpazs2zy8QteKPWejDZD4mee/UnU0sgkS
    r/WPBDOXPZyCMFFr1PQPkyA2X62qGHqqTGcZqC6UE5wBT2ECNz2mxGKK0URKEJXjKxra
    NFMiIxG26owkOms+TyQhanT6CX68EKrTqMO7TMpzqiu0W6Knqryk6KWHcBI3TMO5Iyp8
    XBkf43dG6aPS0amP2ZU4IQmK7YucKsMtItqN4c8hKwbjifJFzSz5cnqGo/6hQ6Cy0MF2
    8ToIkqNkkK3RPLw62HMN+R/KqT2c6I/R6Cu5Ah7eh8dxFxGrEdjsmKRSO/m5HGMQ0xEl
    g9OQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1792425558;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=v7CjAAoIEFm2pvbnTgsXyElzjQ1U6UrWV6gU8iTMfMY=;
    b=vMeV/G4wsHd6iJ8qHqa24AF9GUQxhai9b796YU6Ncdh+rxovN0l9jpXWEacRaPDGCo
    CMA2lD9njj0PXqPdwxAA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from [IPV6:2a00:6020:4a38:6810::989]
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Kfdf2a29JFxIXek
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Mon, 19 Oct 2026 17:59:18 +0200 (CEST)
Message-ID: <9d1160bd-74dc-408b-9b79-5f1fe7c98e57@hartkopp.net>
Date: Mon, 19 Oct 2026 17:59:17 +0200
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
> 
>
Here's v5:

https://lore.kernel.org/netdev/20261019155407.61487-1-socketcan@hartkopp.net/

This is the same problem that syzbot reported for the bonding driver
with a vxcan device enslaved to a bond master, which crashed in
can_rx_unregister() and was fixed by commit 8ba68464e478 ("bonding:
refuse to enslave CAN devices"). The team driver has the same gap.

We have no dedicated team splat as team was not tested by syzbot.

But I referenced the bonding report (incl. splat)

Link: https://syzkaller.appspot.com/bug?extid=8ed98cbd0161632bce95 # 
bonding splat

Best regards,
Oliver

