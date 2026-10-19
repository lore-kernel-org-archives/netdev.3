Received: from sonic312-25.consmr.mail.ne1.yahoo.com (sonic312-25.consmr.mail.ne1.yahoo.com [66.163.191.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E596B3FC5C4
	for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 05:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.191.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792386615; cv=none; b=YLj2O0k3oUG6ph9md6+gEdhcFx8sBLbtMdzJJkzQW9TE6/zJm1+vi3M7Bm8fmiekmxP5gFeQSRSCdgJ9Hix1qHHPwEs/pnTtYCeLJY+1UWY2NYhgVzFD6HAr7rqGZvytoXHw32N17i7ApHCvMrQkyiTeeDvmTRRZJSY0MXb+Eck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792386615; c=relaxed/simple;
	bh=qckAoH21Ag2uf0YGlwleQDsAf9f8LWfR1FKSvJxeBL4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j+3cEsz7JTRTvGW/+Ngf1yGeBWMthXv3mlbv4ZTqzRqX3f+bK8pcSQdfc7WivPCpkQWFRl27ZgstqIFHxYqQW88Drs/0laj3ZSm1h5xIW2yoyDW/HTglHRN2Z7InUfn/lzwbsfIip5bwKoAbwfu9c+UEkASVVNZDUlNKwaqnTII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=A9/FBVat; arc=none smtp.client-ip=66.163.191.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="A9/FBVat"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1792386604; bh=PqshCizSG4zH83hYBYiW1Kt2Yp5y780ZgAiv2pgXCKk=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=A9/FBVat7fiHPD5g814Ev7EKofdx4GmaRDP/EJ0fo6mBwunTfsshEIKTAHCYueHhkwqiaOzaPpgoSMLw54+/lvLBQSTIWIyOxZPoGw7MD2q1oBDAAQnef7Wm/HMf4zQq7s/nzjXY0Lr0T6sgCGB7dkf3F4bGxAkWE6vc1wDSgZzHIn3OOwfp8ufHI8TRnzhb7a1l+g3xcqmSkbITw2h4yr2yvM75O94kgRbflxV4rgJHSs49pysaCCsbzNkZPaHz5qERwJyelWsxw5Jl882t+mhAfd1LC5PIYJYiD36EgC6FGCj8Xpu3ckgga58ah1jpwFX7IFxVDb2db4IoqhZZeA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1792386604; bh=pG2aRHqjBrqRTiOlQXxqNlwER5hcFkIi5yWXzw/sYM8=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=eFKjxNkXRopCTuYdE4I8HfWMYafzJgcGs94wGiU7O+gDu4J6kLrmVd7DmXbaig7YFpi6e6cQudVHVcWDXaMn6sE3tqpXz74pK0AK+/DixdAaj1fkJLEDqj1wk2VpBr7sQigA44ZLl1gZJ1+thsRj6rLuTHNDzo9H9NtFVvGVbMsCOlThHKwsl3VDT374d5xM7gq6kDLM+R/iDFupxmUfrgTvjj5BQMUIoiOjt1MoXNdL3nlOkzo6CS6knX3baUH3/Kh7zqDndaQJ1Ct13PXgButKwyVwUVOE9ygAHDjOxiKaM78xLK1FMZ3+bBLauMX0stRniNcgiTRVrGESzq+r7Q==
X-YMail-OSG: gzTMN7AVM1nmCOuJ7Mm7ULpPsVJgIMx5bWw6AuZhDf85fGE9Tq5d8ehpnvZzYML
 xPWFWYq_V8nLaycsLEY7KZreYRjsh2x4_rSvaC4gJ8nkxFY5_6vObRrBJp3upuIVPqAegKDeLfyK
 5pNUDBs0pYZCQ5fxu4seJ_rlGfJ8klg0MQH0VpXmo6DaDp3SaVsC6FR4Da9E_znvGEsJ4E4d3rx6
 wU8kkWWnbFKhwMiSNnju9THSgb1gpjlRAfPkmVYPUZg.zBDayvvZ_1DzsG9wiXB3fPGFRI8P95JX
 xHiXG697uUEl1nQVdD_6eDNEjBvk7AobwartQBcZZgCDALzgD30wUew3gTBQC_WC1L3tHkLAPeK8
 qwqq_eXXDd.l6ExKZct.uqY0lna7dnEEzNo3F_QQR0AvO3R76rUGrCBEBhg7Ozvf2VyESlCE1j3n
 yT83Gk5lmWZuBvbttOiduyYXGk9VliTAvLqaqbl.k6OiPe6gRszgWw0vSXiMSHqEbGdMEOLAMOab
 VzIzdLw.JMgwI0EYqy0tP9DyZRptZ48Er46bWFXPfvBu56Hv0aKQe9sZ.4dz5VDMMdC7ersLjx7p
 W88rprvmmiUAMCGDjkWAi20P1rkYP_HC3QaQxfHBn64ccFDFjrTA4SNwDkH2nhpp_9svpw7fc9xj
 Lads00mjank.6yjOdvTvlVGq_dPlB21ihK5NEIc9JzLSVbXpwNcODDhtNf584GdnShlS9tTKHKYS
 GYgFbepyhuCp6uqbAv_MKS__nCMEsKI24AY_vl7I.QWWVpM0irw1pyCyUHsyRnPpVL1lY4YXvFmf
 WaxVNzOgTgpIbg5fRR5vA0RC4dpxE3m7zh.zfXlLcYtBNUPBXZnu3ErD3nqkWTh3QFj9JW7hwPcR
 kfqIg5RQLZnxfsvcfj6T9YjdYKwSzadczWg8qW8MdHQU93DmwPWeQTyQGVF0uD7idUwXlZ_OxWTs
 TKh7TvR2umLHVSo1KExAbGbriffDPmvrJXO8VyG5mN08Gg1UQAjVB._rl1P2cFWAmfAK8qpEDCT5
 Hdz1BjCTMdpUk_Wb6n.jJJiryY2LQqddJJ8vkJOHiflIc5zzSbkEFwP8mZE0eTkAGs7bcWQaGRuV
 QmNttl0eJjiLoaWyh66XOURbAx2vgc8cn5LfC0Xt8fNAX7Xd.CRe5VTm6IGhjtYAVRYZS2p0aW7Z
 57fZ6mVJegrERZTRJJkpc95S4pCmigpjBKp8RCj.JFY9QfjM98q0kA4Oriyc4bH2kyo.VKhbQmQl
 Wx1wqCA_CIOdUm1rLYUbdgRdCmpuzetr3RHTGVQrsKy3VxhcfBEDX2PgZuBxPiyW7fih4d5W1Hjb
 Jw5coI8U6HJZn13AkuLfoiIhMbORK5BDEYcyyfSh69dXJMW8zqyCJjTDiDn2p47vVpwMxVHr8wWt
 tK66Kn0LCoavL3RWTSpVi5ah4lgMxJZrMCv_pGzPWBzr0rkl5NKAOKwKBc8TF1kd_T7Ap_hth1.n
 CAnrAYg4S5p67c0JKXW6ELiN_a90H7ft0CKBt.UKRPKVsTdK2cxdxwluF_euXgTp9fPp4grClXZG
 O3ZAundmbRuG4BWJjeeYjLvqHfFZ9bd0IJstd2F75eYZt_8X7LniQ8ctMVyUN7GNt.PA4FDGcWRp
 qG5D_ZnOO2LrrA.VNZTk5EPit804fzgb1x8WpnmqzM4Y9eoT95SWRclQO3LxfZVmJykNRjBXsm36
 B7bq7v2atqZl2qa6nhxYKI70.uEw9iMMvuqHGSLFpi7eTTOUaJLOqeBkXjxlQGdvq9Dk49ULD27i
 EMnfrTQJ8F9aUlWyey66LeUfe4JnVojkWj9deZpx8wUr85wmtRapbwF49kDE6s6OOXL9jPzz9SdF
 CpdcaECRsGFMvbjIhFZxpDqmPjCWddXwO0wfnCU0YUCSAM.ygoE4cZg8Q5aYdbyy3yZwER22F3rD
 XMs4_F8b40oVB408EHicjFdW47ndNafCFf8JGjCzhkTEkpaLy8PzajrpqpsC9MrXeEfkwlCBMach
 I7rjfta3e7xqi12lCSfaxlsbrZ78OHAMTOEuFXA.W_ZkzKbtBmWvYhOY2tDtaD4RI7O0Hh4ryDAN
 6iDNwpCRO5WrulgWkt1IrC04zawFbJD9xXgQJWJyGA.I5FoleYMuQyRMujm.DH6RAOXdLlfftdWs
 MMkWZhjWChdOSBdL5lvWGk9vh4SvaKhVbWUILbnYLfxsnyHXjKulicL55_8Y91Fo32iscCT23KpH
 ktpzwIIQfXzGu5uQQEVJGI3LYP03IkUQJU6xUwYoG9Q43I9.hysAuLUiAlI38XanBYuuwMOkatmd
 wYtBsTHWKvwoVbiyUWzVa6XftuUQSBUA5Ijh5nxVspQ--
X-Sonic-MF: <namiltd@yahoo.com>
X-Sonic-ID: b218638d-e80a-47c0-a190-bd8a68584711
Received: from sonic.gate.mail.ne1.yahoo.com by sonic312.consmr.mail.ne1.yahoo.com with HTTP; Mon, 19 Oct 2026 05:10:04 +0000
Received: by hermes--production-bf1-6d6877594b-clgz5 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 09854f4a961b13c1c315fe5d98a68053;
          Mon, 19 Oct 2026 05:10:00 +0000 (UTC)
Message-ID: <9124a33c-55b5-4c7a-b8a7-25d0bd4e6936@yahoo.com>
Date: Mon, 19 Oct 2026 07:09:44 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 0/9] net: dsa: realtek: rtl8365mb: add support
 for RTL8367S-VB
To: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Cc: linusw@kernel.org, andrew@lunn.ch, olteanv@gmail.com, kuba@kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 linux@armlinux.org.uk, maxime.chevallier@bootlin.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <5a4715dd-89e0-4868-9ffb-c8fb73b18d04.ref@yahoo.com>
 <5a4715dd-89e0-4868-9ffb-c8fb73b18d04@yahoo.com>
 <CAJq09z4kKcQ+idfP+19pogi-H5s07SgKO-CGg7AWX8An-9p4Fw@mail.gmail.com>
Content-Language: pl
From: Mieczyslaw Nalewaj <namiltd@yahoo.com>
In-Reply-To: <CAJq09z4kKcQ+idfP+19pogi-H5s07SgKO-CGg7AWX8An-9p4Fw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.26740 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 10/19/2026 4:44 AM, Luiz Angelo Daros de Luca wrote:
>> This series adds support for the RTL8367S-VB (chip ID 0x6642) to the
>> rtl8365mb driver. The chip belongs to a new "family D" that differs from
>> the existing family C in its VLAN table layout, speed/RGMII configuration
>> and SerDes (SDS13) handling.
[...]
> 
> Support for Family D is very welcome and increasingly necessary, as Family C
> ASICs are no longer being used in new designs. However, the current support
> still feels incomplete in critical areas.
> 
> When porting a new switch family to rtl8365mb, each feature and hardware table
> shared with Family C needs to be verified against the new family's register
> layout. In particular, this series leaves rtl8365mb_l2.c untouched, but the L2
> table layout in Family D differs from Family C (from memory, the table entry
> format is 1 byte shorter and the bitfields are organized differently).
> 
> Passing basic traffic in a default router setup can easily give a false sense
> of stability because the switch starts forwarding with factory defaults.
> However, as soon as DSA attempts to configure FDB entries, dump the L2 table,
> or manage multicast groups via bridge operations, the driver will interact with
> the L2 table using the wrong layout, causing silent data corruption.
> 
> To make Family D truly upstream-ready, we should adapt these shared components
> (especially L2/FDB handling) or, at the very least, explicitly return
> -EOPNOTSUPP
> for unsupported operations so the driver fails gracefully instead of corrupting
> hardware state.
> 
> In the cover letter, you mentioned the test device. Do you have the Archer AX55
> on your own bench now, or were these tests run remotely by users?
> Exercising full
> DSA functionality (FDB add/del/dump, VLAN filtering, STP, flooding controls)
> usually requires a dedicated local test setup where you can generate, sniff,
> and inspect traffic directly.
> 
> Best regards,
> 
> Luiz


To answer your question: no, I do not have the Archer AX55 or any other
RTL8367S-VB hardware on my bench, and I have no test environment of my own.
I cannot exercise FDB, VLAN filtering, STP or flooding controls myself.
All testing so far was done by other users who run this code on their
devices, and I depend on their reports.

The code was put together from the Realtek vendor SDK, the existing swconfig
driver code and the help of other contributors. It works on the setups where
it was tested (CPU port over HSGMII, bridge VLAN filtering and per-port
PVIDs), but I could not verify the shared parts against the family D
register layout, and you are right that rtl8365mb_l2.c is untouched.

Without a way to test, I cannot develop this further responsibly. I am
therefore leaving the series as it is for anyone with the hardware and a
proper test setup to pick up, adapt the L2/FDB handling and the remaining
shared code paths, and take it forward. I am happy for others to reuse,
rework or resubmit any part of it.

Best regards,
Mieczyslaw
