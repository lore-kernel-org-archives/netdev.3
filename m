Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=52.59.177.22
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794494968;
	b=zjzC4nd0GhVHgSr68xEid1YZtPyvXdmwZeKCR5f4h8clo9UV26mxZFg9zD1AJSaVI+yA
	 AlmgU28aru8tP12d2aGZJsdp4RUpD0ZPrGr7N6fe4tX4x3V4pu5GmeFf4k10pl8ZNb9iM
	 EC5Gpz+wiomsTgWkPQWgVR4OrBbIsbhKmUtlT8WH3Ax6myqPG8eEXbNSos1zeggx/fXip
	 aIL3bNR70DP+F73Nw/ZxOGQwmIO5etOcuc3GLwLg1lPXYM/Vcg7hsIt8Aut8cXX0hSivp
	 E1Y588NplWcr41oWqXslfy7+V3sGRyD+ZETlSNvKJDBZ1Lro0013fW1cLwAzNQ58eCQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794494968;
	h=DMARC-Filter:DKIM-Signature:X-QQ-mid:X-QQ-Originating-IP:Received:
	 X-QQ-SSF:X-QQ-GoodBg:X-BIZMAIL-ID:EX-QQ-RecipientCnt:Mime-Version:
	 Content-Type:Date:Message-Id:Subject:From:To:Cc:X-Mailer:References:
	 In-Reply-To:X-QQ-SENDSIZE:Feedback-ID:X-QQ-XMAILINFO:X-QQ-XMRINFO:
	 X-QQ-RECHKSPAM;
	bh=zjGNu9iJUY6tRHH5ZIf6zaOe5ITdcxUbrHIdm2i7RUM=;
	b=S5WaOJRJH4E2yyWlQmZuB3agq3cUm0vdsFXvb46C04LZQMYHf7/LFfdouwv97HtWqatU
	 fSUhBjq9kMAWfVGGHJSdYZs5vg8FPxupRMlxZrkAW9BY+u2XjtG3Vq0P5vezb8Uuzv70w
	 KLzM06HSTiWrBGhG69WMav4nIhUQAMs/7mTelkSlLym+rPLLS9FZVriZhWoaamGywVV0S
	 6MXJCnfekpgZEAIStdivslTPds5lysoNYvptAvRA3uR344rFwgBzCahppaagC8LuoWEmk
	 IidSAP5SeakUM8gBsfD+qn0AqUdZKK8EKUqZ2nlDMgOQlGniGtxeayC7puo0oiWnhYQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux.spacemit.com;
	spf=none smtp.mailfrom=linux.spacemit.com;
	dkim=pass header.d=linux.spacemit.com header.i=@linux.spacemit.com header.a=rsa-sha256 header.s=mxsw2412 header.b=bPzMatk7;
	arc=none smtp.remote-ip=52.59.177.22
Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 856AF606A323;
	Thu, 12 Nov 2026 14:49:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 856AF606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.a=rsa-sha256 header.s=mxsw2412 header.b=bPzMatk7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1794494915;
	bh=zjGNu9iJUY6tRHH5ZIf6zaOe5ITdcxUbrHIdm2i7RUM=;
	h=Mime-Version:Date:Message-Id:Subject:From:To;
	b=bPzMatk7qpExuK/54DlD1AYIsJFWlH7UOaEsiiTsoJRqPkBhOLgzmYW2YFV+1U+mh
	 ItFD3t74wMuNAITiwMdNZK85jl1D25N/6sTvc5hfVOVFKwHAPy7sjgxBDDybH75GTD
	 CjUSKckealMdIw0+3UxM1MIO5mvgMc4zdEHLZAf0=
X-QQ-mid: zesmtpgz6t1794494909t187aaf4b
X-QQ-Originating-IP: Js536/AgtVk23vBPAsP9wENuhTH6rx7T9W8Qieg91IY=
Received: from = ( [120.237.158.181])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 12 Nov 2026 22:48:27 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 5432486051573447005
EX-QQ-RecipientCnt: 20
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=4b60170ac85986e157bd72089ccd51b2afc8a5789b706b54e2b49f94448f;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Thu, 12 Nov 2026 14:48:26 +0000
Message-Id: <DMTBCR706MJ6.23YJ33SOJOGV2@linux.spacemit.com>
Subject: Re: [PATCH net] net: spacemit: Hold RTNL lock in emac_resume() and
 emac_suspend()
From: "Troy Mitchell" <troy.mitchell@linux.spacemit.com>
To: "Ali Tariq" <alitariq45892@gmail.com>, "Troy Mitchell"
 <troy.mitchell@linux.spacemit.com>, "Vivian Wang"
 <wangruikang@iscas.ac.cn>, "Andrew Lunn" <andrew@lunn.ch>
Cc: "Vadim Fedorenko" <vadim.fedorenko@linux.dev>, <netdev@vger.kernel.org>,
 "Andrew Lunn" <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, "Eric Dumazet" <edumazet@kernel.org>, "Jakub
 Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>, "Yixun Lan"
 <dlan@kernel.org>, "Chukun Pan" <amadeus@jmu.edu.cn>, "Siddharth Vadapalli"
 <s-vadapalli@ti.com>, "Tomas Hlavacek" <tmshlvck@gmail.com>, "Muhammad
 Bilal" <meatuni001@gmail.com>, "Maxime Chevallier"
 <maxime.chevallier@bootlin.com>, <linux-riscv@lists.infradead.org>,
 <spacemit@lists.linux.dev>, <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.21.0-reader-ipc4
References: <20261105123441.2524171-1-alitariq45892@gmail.com>
 <DMO13SWAGZAN.NYISGLGI7Y5A@linux.spacemit.com>
 <c55c5878-d9c1-4863-bc55-99d334ba2ede@gmail.com>
 <12a95b3a-9c8b-4a2d-9b81-12b3839e64a9@lunn.ch>
 <DMPNAPNEGQ5I.XYUIB7Y8HDCA@linux.spacemit.com>
 <ee3f414c-fffa-41e6-8bec-6af7ce676c4b@iscas.ac.cn>
 <DMQJ0R4QTE6R.2I492KA9N85CB@linux.spacemit.com>
 <e11f1ba6-6e56-4bac-a0cb-f9258a53f34e@gmail.com>
In-Reply-To: <e11f1ba6-6e56-4bac-a0cb-f9258a53f34e@gmail.com>
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:linux.spacemit.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: OLeWdWTN7s9ArBRVgLcndy27MEg8aF14b3t/uiBeUwp6rZK7b9N9IMyB
	qCwQrKkpCcvizFM58KhJi8zeIpnezLhIjdKpcPQh+fwBpSxjsbavSUKoB6VUH3SVqpCBJXy
	qM3C4NtpmnqMmOlGNvc2f6vu5LZmZxmiqb6ZMHP0LmCpQx0wdt4CxPXAsULXUQytaNmdM5a
	oBafatLrX/+bk+Fi7o1mxUQwf95iITdpeZ0+dz+AocmJMpuI/xRUaDcUXwfy9/Cr6lAV3zZ
	ualxUEGChTslHzsNJN5X9n5fVwzwtyVEUCm1hssCjEPPp1LOCqpKzpme+WDPFksuE5RTQtY
	SmzuVbf0hfsVsiqnC6za9jxwf2VftW/6RivqISpGbn8jGoarRCYCS4oZnWJnWqoVTqMtK0/
	pXA7M+9Ft0RywFvZH0qEokBR4YAx8PEdAWesacbwr04T0JqEdL9iwr90xWawLkgb/F67RfS
	XcYRCWZokE3kQOFrCo9L8O/QOQK8nFyfrjbVDw66EjwBJXGCAZvqRtPYayx5KiDYRGZUaEn
	oy3LQM0Y6zdu9oZTlxXNCqdFIpuTTPbE04D/O1OQpeBjfPooODxsKGwcFfPr5DaDm7t9aTf
	S/aY375/gM7Q/t14KmaRViearykkoenKi5qqZqWYR3CRSrqd4YIGzEHEqOt1ncycNg2D2GK
	Qi+2crYOCFTh3BLBP7Pvt2ijYZdeNrVhIBv4FK1RjuNSi5jooek+SbTyKqzFZl66yh8W/zi
	HtX2Ad5vHFj9UDVdcjzXDaYbo2+mvQ4i8egiFCiNp2Ap4fCmc6mL2LxsACeJwn9BAPa/NMp
	oXzIaMAtk2wDyQ7iBrraKjelwOdoRNugZWwsQI0wmqF/aqc11WG9t05uP6SU/v4rLu6zH1Y
	p4hAStSVOfeEd34dosOCyC8KLMhzXoWCJzONOM4JD2QvFWyysUfG8klaSxflcOpuB/R94Ot
	s1uiHGeovlshR2Tc97vhhVXp/Y0pG92enn2QPMQ7bkQgxqSJzswrQyohq3xLMIz99toQM3e
	xOfDIohi3x1owk6Hf/8XhgwA8vp5VDqP7362kWjGxpSGfAvctnb9PW8whb4IdfLlHrRzks8
	JYLjz3tc8bxK2WdVAMozlBilohuUdVyJDY1ovFTByC9+RmqOh7pM/8=
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
X-QQ-RECHKSPAM: 0

--4b60170ac85986e157bd72089ccd51b2afc8a5789b706b54e2b49f94448f
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi Ali,

On Thu Nov 12, 2026 at 1:33 PM GMT, Ali Tariq wrote:
>
>
> On 11/9/26 1:10 PM, Troy Mitchell wrote:
>> On Mon Nov 9, 2026 at 7:59 AM GMT, Vivian Wang wrote:
>>> On 11/8/26 15:19, Troy Mitchell wrote:
>>>
>>>> On Sat Nov 7, 2026 at 5:32 PM GMT, Andrew Lunn wrote:
>>>>> On Fri, Nov 06, 2026 at 03:44:50PM +0500, Ali Tariq wrote:
>>>>>>
>>>>>> On 11/6/26 2:43 PM, Troy Mitchell wrote:
>>>>>>> On Thu,  5 Nov 2026 17:34:37 +0500, Ali Tariq wrote:
>>>>>>>> @@ -2056,7 +2059,9 @@ static int emac_suspend(struct device *dev)
>>>>>>>>    		return 0;
>>>>>>>>    	}
>>>>>>>> +	rtnl_lock();
>>>>>>>>    	emac_stop(ndev);
>>>>>>>> +	rtnl_unlock();
>>>>>>>>    	clk_disable_unprepare(priv->bus_clk);
>>>>>>>>    	netif_device_detach(ndev);
>>>>>>> This can deadlock. emac_stop() -> emac_down() calls
>>>>>>> cancel_work_sync(&priv->tx_timeout_task) with RTNL now held, while
>>>>>>> emac_tx_timeout_task() starts with rtnl_lock().
>>>>>>>
>>>>>> Thanks Troy, that makes sense.
>>>>>>
>>>>>> For the deadlock, I think the correct function to call is rtnl_trylo=
ck()
>>>>>> inside the emac_tx_timeout_task(), which would return if the lock is=
 already
>>>>>> held and will hold the lock if it is not.
>>>>> rtnl_trylock() is generally a workaround needed for badly written
>>>>> code. Please try to avoid it.
>>>> Agreed. If the reset is done in place, the work does not need RTNL at =
all,
>>>> so .ndo_stop can keep cancel_work_sync() as is.
>>>>
>>> Thanks for the diagnosis and suggestions.
>>>
>>> Although, maybe we could simply avoid cancel_work_sync() in emac_down()=
?
>>> emac_tx_timeout_task() checks for !netif_running and does nothing if
>>> already down so it should be safe. The task cancel_work_sync() in
>>> emac_remove() does cleanup on unbind so the task is not leaked.
>>>
>>> This seems to be the pattern in other drivers as well. What do you thin=
k?
>> That was my first thought too, but I'm not sure netif_running() is
>> enough here. emac_suspend() calls emac_stop() directly, so
>> netif_running() is still true and a pending work would stop the device
>> a second time. And since the netdev is devm-registered, emac_remove()
>> runs before unregister_netdev(), so the work could be requeued after
>> the cancel there.
>>=20
>> So we'd still need to cancel it in suspend and remove, and at that
>> point resetting in place looks simpler to me. What do you think?
>>=20
>>=20
>
> Thanks Troy, Vivian and Andrew. I'll drop rtnl_trylock().
>
> I think a simpler approach here will be to go with Vivian's suggestion
> of dropping cancel_work_sync() from emac_down(), and handle Troy's two
> cases by disabling the work where the device is stopped without the core:
>
> 1. Suspend: emac_suspend() calls disable_work_sync() before stopping
>     the device, and emac_resume() calls enable_work(). So the work
>     can't run while the device is suspended.
>
> 2. Remove: emac_remove() uses disable_work_sync() instead of
>     cancel_work_sync(), so the work can't be queued again before the
>     devm unregister_netdev().
>
> For a normal close, the work's existing netif_running() check is
> enough, because the core clears it before calling .ndo_stop.
>
> With this, nothing waits for the work while holding RTNL, and the
> work doesn't wait for itself.
>
> v2 will have two patches. First the TX timeout fix (reported by Troy)=20
> then the suspend/resume patch, which will take
> RTNL after disable_work_sync() and before the netif_running() checks.
Sounds good :)


--=20
Troy Mitchell


--4b60170ac85986e157bd72089ccd51b2afc8a5789b706b54e2b49f94448f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJcEABYKAD8WIQSL4Ay2cExaPXAQcU2YCe+A+TM0LwUCavXRuiEcdHJveS5taXRj
aGVsbEBsaW51eC5zcGFjZW1pdC5jb20ACgkQmAnvgPkzNC/PdwD8DO7z3cbgb16T
doImdDC4h5bI5kgpf0udTdwgsfv+jDgA/iBx0Shg3fNGZonovHhDnPSigl1PzAZx
DoQpm0TbFXIC
=2L/5
-----END PGP SIGNATURE-----

--4b60170ac85986e157bd72089ccd51b2afc8a5789b706b54e2b49f94448f--
