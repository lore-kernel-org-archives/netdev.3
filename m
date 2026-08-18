Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 522FC19B5A3
	for <netdev@vger.kernel.org>; Tue, 18 Aug 2026 13:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787059579; cv=pass; b=W6LDEtYN0S8rkGzyZwpZTnx5PNBhDFGX4vPo5bcg6A7X4h0TIqPRd9RGLyd2tPgPKOtPAym+kwyKKF8nxHOS8oJqW1qHS0l+61ZlOd8GnhT8D75E1Iy5hE1vBFjtEhYDevk3RgWKbijS8E/RddJ/O94orEHFbryrObNm+1JFxBA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787059579; c=relaxed/simple;
	bh=zArZwKr7m7TsL+svTTLuArdZHtWR3lWTl4dz+ld616k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MYcdak5NktBP3S2m5V2Lxplaq7Jk1RMXriDpKuyCQMgOUX1S9iX8rh1JsNQygiNhH14gVP/aU762YVQ8fQP7UXUxWY3zn4iQv6+vz1rmCd3EMsgrxhnmHbHFAImXnfBa9UCXfTv/MD7bjJjYjlss6hPvlblKzHdHwLLDSJbB1oo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=LN04zxpx; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=GQR+t5KT; arc=pass smtp.client-ip=85.215.255.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="LN04zxpx";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="GQR+t5KT"
ARC-Seal: i=1; a=rsa-sha256; t=1787059550; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=sJWG6jTLua6ZZ1532+BH9RsaLZPjOCjaRs99umdHlkyzMe0tm+Z8VKY0pOTaXgrjTK
    eK4+hJfVcrnLa5XMJnrgItCRjO9l15sj1ElSa4lhXCQmES66AqJM7Tq0Abb/wklPx+xD
    AcJiKlzsNUDYnkDBKDb3WbmfkIojFSXBXQUvSPEa8lvli3EpujCWVKo3ohGn/9nuMx6a
    4wWlyyq8k9fvo+i04AL2oJZs8+MPV+t7OWBOjZIK1DD+zW91SfK3iHIi7m0bdp/rv7Id
    eI13skf/n4P32/ZGZYwqr81Bg9bwrVaMSmU/jD1yhq4KNq7pBzHSb9WaZxdtnzO8Wn1H
    3uqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1787059550;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=97qNjj1medF/z/2yzN+yhSiH84G5BSHVf4OONXEjTjk=;
    b=TH1rZOKPpdUSQb2fad4LgsCTd0COOHPhv2oP0Kyb0S4Ms5Q1sERhA/EPEDwrblAbuA
    /OWMnUrcQHmGUBU/0XJvcjs2pZEa+fhSTmOur5pVjT144cQ1s3ZIhfOeA7CFnGgAM00F
    BIvjJi/GngapZ38+GA9eFKXE5wx3qXYFUKL3AjnUIB829D4yfdKmeA3vTATnN4pQXxw7
    disS8ehtfpnZUMM3Emu9EvGy9fuGBkdKxnIlSpPG1EO80OcBiFhLqwuI1JH6HMeaJPSn
    7jXkJ/brOAVvHqt78VlhQA6b+vrd5/HeRIbUzKOEej5UOrW49xApExfH59ivyjvLe2oH
    BPJw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1787059550;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=97qNjj1medF/z/2yzN+yhSiH84G5BSHVf4OONXEjTjk=;
    b=LN04zxpxm4KompAAP3+SVk3gEd0ffFMA4D2SapyGkaS83zRxNmpHeUBROtgLLXDl3U
    DANPdax2r3eEQBWsssYsRb4k/iyEphKUTYQtSQ0XHk5k9Ndt+P0JoSjJl9ZgD8A2ogWY
    uay8HZoR59tiYq/4WMknpqOE0Wt2LKffAAi7Lx0+ovy0aNr0xk8xaubh2qDsM45hh3PJ
    RN+/U2qa39RiedhMPT75bYsg7erl7IRQs5dqeEP6M7PA4pXHrgP3+FgOqD6nD7ITwUIk
    6UkwdPqa45uSaidMLqcrdmuyzAWibE38AuPw5VlUatcyz/cgjwM9tGjaZekFH7R0YBNk
    dGwQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1787059550;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=97qNjj1medF/z/2yzN+yhSiH84G5BSHVf4OONXEjTjk=;
    b=GQR+t5KTgGAqJdMlNquA1TxFpmRvapdvrODvMe85O8RglvaLHsM2BZajZETcjeqSYC
    vLYwCw88wJKRevjCLWCw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from [IPV6:2a00:6020:4a38:6810::989]
    by smtp.strato.de (RZmta 55.6.2 AUTH)
    with ESMTPSA id K171b727IDPnHIf
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Tue, 18 Aug 2026 15:25:49 +0200 (CEST)
Message-ID: <072004e8-d5a8-4f01-9dd5-da2d3aeaa447@hartkopp.net>
Date: Tue, 18 Aug 2026 15:25:36 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: do not bond/team netdevices which use ml_priv
To: Hangbin Liu <hangbin.liu@linux.dev>
Cc: Stephen Hemminger <stephen@networkplumber.org>, netdev@vger.kernel.org,
 Jiri Pirko <jiri@resnulli.us>, Jay Vosburgh <jv@jvosburgh.net>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Jiale Yao <yaojiale02@163.com>
References: <20260815153938.187073-1-socketcan@hartkopp.net>
 <20260815090015.4a518a54@phoenix.local>
 <02333bd9-89c4-4952-8ae2-ff3c15dcd4df@hartkopp.net> <aoQwCj9AXNI1qfsu@fedora>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <aoQwCj9AXNI1qfsu@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Hangbin,

On 18.08.26 12:12, Hangbin Liu wrote:
> On Sat, Aug 15, 2026 at 07:23:35PM +0200, Oliver Hartkopp wrote:
>>
>>
>> On 15.08.26 18:00, Stephen Hemminger wrote:
>>> On Sat, 15 Aug 2026 17:39:38 +0200
>>> Oliver Hartkopp <socketcan@hartkopp.net> wrote:
>>>
>>>> +static inline bool netdev_has_ml_priv(struct net_device *dev)
>>>> +{
>>>> +	return (dev->ml_priv != NULL);
>>>> +}
>>>> +
>>>
>>> Minor suggestion: use const and drop unneeded parens
>>>
>>> static inline bool netdev_has_ml_priv(const struct net_device *dev)
>>> {
>>> 	return dev->ml_priv != NULL;
>>> }
>>>
>>>
>>
>> Good point!
>>
>> Will wait for some more feedback before sending a v2.
> 
> Hi Oliver,
> 
> Sashiko gives some feed back[1], would you please check it?
> 
> [1] https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260815153938.187073-1-socketcan%40hartkopp.net
> 

Unfortunately the AI bot review did not create a proper answer, so that 
I would be able to answer in-line.

Sashiko says:

"Is this test too broad for plain Ethernet slaves?
netdev_has_ml_priv() only looks at dev->ml_priv, not at 
dev->ml_priv_type, so it matches any driver that stashes a private 
pointer there, including ARPHRD_ETHER NICs that were never involved in 
the CAN crash."

and later also points out potential problems that could arise with tun.

Today only the CAN subsystem properly sets dev->ml_priv_type. Other 
users simply grab dev->ml_priv for their needs (inkognito).

To me the question is whether bonding/teaming and now also tunneling 
code takes care about the mid-layer private pointer dev->ml_priv?!?

The fact that the issues have been found by syzbot for CAN devices might 
be through to the fact that the virtual CAN interface (vcan) can be 
created by netlink commands and can be easily used in test setups.

So what would happen, if the same tests with bonding/teaming/tunneling 
would be done with real hardware drivers as the mentioned "direct 
ml_priv writers still in tree at this revision:

   drivers/s390/net/qeth_core_main.c:qeth_alloc_netdev()
       dev->ml_priv = card;
   drivers/net/ethernet/chelsio/cxgb/cxgb2.c:init_one()
       netdev->ml_priv = adapter;
   drivers/net/wan/hdlc_fr.c:fr_add_pvc()
       dev->ml_priv = pvc;

plus drivers/net/ethernet/i825xx/82596.c, drivers/s390/net/ctcm_main.c,
the libertas main.c/mesh.c paths and
drivers/net/wireless/microchip/wilc1000/netdev.c."

??

If bonding/teaming/tunneling might accidentally overwrite dev->ml_priv 
we have to block all those devices. No matter if it is CAN or whatever 
ethernet device.

And this it what this patch aims for.

So either the users were lucky so far or they never used 
bonding/teaming/tunneling on these devices? I don't know.

But it definitely looks like we should make a safe move to block all 
ml_priv using devices.

Most of the referenced drivers are 20+ years old! Only 
drivers/net/wireless/microchip/wilc1000/netdev.c is about 11 years old 
and moved from staging into mainline in 2020. The use of ml_priv is a 
left-over from the former out out tree development. The wilc1000 drivers 
does not use the existing infrastructure in the correct way. In all 
cases this wifi driver and all the ancient ethernet drivers should (and 
can) be implemented without using the ml_priv pointer today.

When there are (unlikely) real users of those (ancient) drivers together 
with bonding/teaming/tunneling those drivers should be changed in a way 
that they do not need dev->ml_priv anymore.

For that reason

static inline bool netdev_has_ml_priv(struct net_device *dev)
{
	return dev->ml_priv != NULL;
}

seems to be the safe solution that would point out potential problems 
with those drivers immediately.

Best regards,
Oliver

