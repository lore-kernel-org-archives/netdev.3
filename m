Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=66.163.191.204
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793874245;
	b=gZofUsiT90jJbENfTTGgOq5kMX4XaYlDYmyDEyZ9tWsS5wjLn8pm/ge0eRngDpq+d6Y9
	 KytJP049FZLFHc6iWIDieQnPnPiKf64aUglB7TB18cs2r0GGi6F9o+85YK4Eb6HmT8Fwm
	 1GBG3+iRpqbtf9GQzePyROZpD5GyZ9GOtRAdoVbQT2ixrQJjWiBSm+F0O5PAqLT5CXCdB
	 W8BJyShdwC5yrZnTk7DQ/CjVRXAA3gPnp+hPKbFvqoua4K9j5VizhZtz2EulXJZRUiK9j
	 7L0C58Sg20gRrLdqInFZAqjXyBXOLXWKL/SJvZ1Ea2bSA1hEzqSpt9UXiUmQBe2R+tA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793874245;
	h=DMARC-Filter:DKIM-Signature:X-SONIC-DKIM-SIGN:X-YMail-OSG:X-Sonic-MF:
	 X-Sonic-ID:Received:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Mailer;
	bh=qipybyQ3wy6vyf7/dc2kyw3hG+D2vRp1Qd98an/qs0Y=;
	b=qjgtpcpowgYVYvCIHqx0iS0KuKGeRWm5b1KKbg1vnCgfK0MCU3Di+vPKVvCmulelF7Rp
	 CHQMFEaX5ur39salT8Y9PZYGm3Q3h/r1FKc5BBtD5X9YVMFfKM4MJWVoBp/y/id5fZT6a
	 09PkkJ4fsOHy/UoCslmPDcN9FM/M4ktpKP2z60jQOy1FBrj0XmCvxOOeUgODpIMsxQWjf
	 Q/1SRNdlNuHqmcj91AdRuGGfqRb+wPcF/sxwghrvViQgw1JEiLJ1OWdIgzoqOfbKzLE0u
	 xTem5NTFrW9rFdJ/L1FAi+x030eR3/8FQ1lsgEf6cUgeCkJ0tCuFjoOCAxg2N2xR3/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=yahoo.com;
	spf=pass smtp.mailfrom=yahoo.com;
	dkim=pass header.d=yahoo.com header.i=@yahoo.com header.a=rsa-sha256 header.s=s2048 header.b=OK9Ciafl;
	arc=none smtp.remote-ip=66.163.191.204
Received: from sonic312-23.consmr.mail.ne1.yahoo.com (sonic312-23.consmr.mail.ne1.yahoo.com [66.163.191.204])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8710606A326
	for <netdev@vger.kernel.org>; Thu,  5 Nov 2026 10:24:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B8710606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=yahoo.com header.i=@yahoo.com header.a=rsa-sha256 header.s=s2048 header.b=OK9Ciafl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1793874243; bh=qipybyQ3wy6vyf7/dc2kyw3hG+D2vRp1Qd98an/qs0Y=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=OK9Ciafl4fvKnnhj12MmIAGq8vTPjOUwkwZ841a8yha9L/jQER4UsLkarQe1QXlrLYAhRonRPu6QqU2zRZfgnDuEKXgE/uP/tYA8JsmXbb7p/J/WOidgHRK3hnGZ20EC0BFEHciUoxPKE/RGT7wReip6SrNJKCAM89Wcns2AzkOHUiHz2zHz+/isrmxbN6SrIOlXJMFRZullcPplX11YK00O6xkf634t9DXjRcsMd5whKRHfRvH/RZzoUH0nmv7BCIc0S5ILT0EoerEp3wrVeb096VxKOlRITD/JNGO7N7KU5yr4Lw2rKN355XNCeBlLF8K4C+TPz80cOxg/DGGWBA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1793874243; bh=RJUNVbb67wMl+9vVRNOmYHxdu+wAIj8929v7yQBFNre=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=fc8Guy3H5QheeektZoSB4fX1/OWOjiOKi7hu3/HoFfvz+qJTr8TaZuociqIGNYjXV3Syu7c/tvQBtjjxaFVtkr2WOG/f2EF3XcBrkyxGaOAcYV0tGlgTa2HuaqJiViNh8TlXbrNNd6YrZ90kI+GpFcSXXMsZNO59FFygHWegwepjPidCegOh5ALOtGiFMr5Ot5ZUpKyotOuT/EpUsRAoJ4ODjKBIquOpjbeShO/q3dNZqhqljlsfBuTLVX0QmukDgWFKaTbbs8Ns+XUERVzR4jz2lvkP/xMC7q31QGO9npnxTd2HpyPKNLfD570nmJoj/qVbTWauDzN20k+2VeM6PA==
X-YMail-OSG: 0eifEpEVM1lE4M0t_CY6KnN3bLOcGoWRec54AYRT07mMrKkUbVQsCTipUm.bIDG
 aOT4m9Az_.J7PIEBH60MSXjENzlGB3ZQ9qhTE.L__sbEwo8wjFir51PbHNUHo0BvLBevBUmToVv8
 vNGBPEK.oU2VlmgXF4o1e9YQb4kmh3OGO6I5lWoxM12zsB5CJ3CdLEUT2502z2O_XQ7CjwFqdlhv
 Rb0EaPzZrhp_mWrDHN4xtGMLCnaC7FScItD4Fp6OfMVPOPH9IxG5a1.tevEFvT90ZT3f1GMGI4_9
 TD_Ur3.86NkVRWyD.dJ9Uq6FncXa6PamEILVMwOROP4hWMb0Lq4AUHD7ZIvn7NpDio8C6XeuIwnd
 vHkpFW47SW71z_r.jiEEhBgcGMBG7KrnxGx5w4pi0xa4eB82OK9HkB7ryXvDTwVowMbgff0dyTEN
 v36hN1TP1V18o9J9eupsE.F4TuaxXGskyDT16D8XUSkYIwnPj5jihQ85Oe1YkCOAAZYTwSWIRd1.
 uoQc_VsSG_rrPlxMxdIR6wCpYhxlRcjEb1HQ1QshUbE9kiIs0MdlPfLJY5k0_9EwzOr9FJeJ7dJ5
 YoWHkE54uvW_LaLI931zI32iKf1Arpl6wRWMzhJwB9Ln1gandwV.jybCLYpDBdJV42tBG.Fwv7MC
 iOw_zZXyEV2LsNkr22OVefAJmDgbpiPbkHVusiEKfRM7vXa.7ky5mDm_XvDCUQhAcNnsw61e6LPA
 4iwhsk93YTM4DGt0t8gFM41GDwLF9HGmhBcFl6sWsPbLYt11FUbNFJbQxHXndFfksgrGqr740EzM
 A8P9eXVE3XPoeXAR6GJQyXwxvLlE20PJ36vhd9PHxvS5KNEqVQzvt0.8f5gOXz2lVgHm27zWLEup
 zRBbzs7f_P1B0UAWnUp7s6LfI_V7_oOBalxIeukEwVrkFJyG4lx2Oj0psdMH9yW4lv0zO0K8s_z8
 MYUP30jyGPtdRa9pBtuquDucuQmh493q4THeFUWRMf4fUhHICYgl1n.RN9lKOTyZNoRxxo4bjHoR
 oYC0mIl2.9Fbil99dffJQS8JfJot.V5FLke4TYIGjBwBBHeiihfscS.94SAzmB8.ewBG9be0bPJV
 JwGjIL.BLhZM8Ft.4NKJUC9Q0x4BA1UIfjxXCshb_.m2jflCmEgvIEMh19y3.2i5gWkCGMnG7ieE
 eSvK6iMR8T4UGiGJcFBqXLmYzznBbLywp1EGUMnbTrbfTIxk3et5clO6vBfs4AkscBsOauOG.7ON
 j9uAZbZ3x.V9UZ_hMfqXRskDMYjuJzYXJJ5v2IHJrnHF7WDD1akoQxYQyN1s5OihMAN.9h.K8sAL
 YUV5vBtsqmsf6TfV9JOPQNWwrYDz1vzvIUuz9NZQlvMFJ7Lf1ARSoMLDZTpHjjoC4Zq60H2D71qh
 8lkTtiHy2hPG8bnhjSygqoabP8K1iIS1q76sP2qvIJPdmfz4xArgUyjOGcf87xjpXNqRCxS8_vUC
 1lWbtHE5L9Fcpk1SkUUZgO4BH4m81iITFxdZ_nbP2rctRJN45jhiMkix5.vY1oGFb.B0Tcxsqkt2
 FczrUMXhx5ZFykfSER5C4nxTHDH1Npfp0llbutE_EM5WRRtN2DaikLa52kGVpXANk.OVdiL1W8xP
 zWwHa0zcijqDtUOMTfjr0VwW6_FxmfzFGg25UsLLA7G3t0UZzrrOoWALVqnH.PxzVAJCXD0wINhH
 ICR0GvMvwEQKtsOtH4EoKGvig1XkHJeMdPWSjoZ_VfKFirINs5yl_xiQzXBt3vkuKxy4Kl_CjnhX
 sml_rIVDTkTcUdCiPfpQaLUDXrOjtJWvweG3UkggquDAOiZh4MGMIoRixfOgZskB3TmOKWnexbCm
 8A8PyhIDlHt_PNmkbwUyRetBoWhJ67zWMenxQ45DYNJTJWld0g80E.v4iunZ11.R3azPFyG2js.o
 JshgOMTXCOu4_Dihid9oo.cxUuW7u49Yxx0KK1XWw1QulBXw_2yNSyf71AEL0CqAYXIc5.pim4CV
 TnCE_fE5huCXBbi6IaxLcC8eqFxU6xrAuvByqouX6fJgEcrYePV0BKwws3LzouAhEcp0xo8u0UlP
 YIc13hEDbUzqfNGDG3vP031Wsq9s80V5QVfFGAByBBX.G3g4zejSlOHJ56lt1m4_WQwuducDIWt3
 dsG0oiKQah7lxiMpIj3vJpzP5ISOSwzjrdPS09qMwm8LI3xN50nyGJKFjUPU8mMpVPhcTry8c4WH
 vq8OGeOKHNS.d.HoeNm5xlviToFYUNMSn0__AuffXdi3w_4Uop4yJi7X1dOqadnJBdoS_3EraDDW
 AUfnBQJ0y5g--
X-Sonic-MF: <namiltd@yahoo.com>
X-Sonic-ID: cf6cac19-34cc-47b1-8cef-564e2369df50
Received: from sonic.gate.mail.ne1.yahoo.com by sonic312.consmr.mail.ne1.yahoo.com with HTTP; Thu, 5 Nov 2026 10:24:03 +0000
Received: by hermes--production-ir2-5dd9bf4598-bbdwl (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 6200c68789ac75b7eee6c67eebb17167;
          Thu, 05 Nov 2026 10:24:00 +0000 (UTC)
Message-ID: <6460689d-ef3a-462c-a5b7-df3c2c843f86@yahoo.com>
Date: Thu, 5 Nov 2026 11:24:08 +0100
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
Subject: Re: [PATCH net-next v7 08/10] net: dsa: realtek: rtl8365mb: re-latch
 the family D SerDes
To: =?UTF-8?Q?Alvin_=C5=A0ipraga?= <alvin.sipraga@analog.com>
Cc: linusw@kernel.org, andrew@lunn.ch, olteanv@gmail.com, kuba@kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 linux@armlinux.org.uk, luizluca@gmail.com, maxime.chevallier@bootlin.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <3bf4dd70-9771-497b-8c27-e925e0ef81eb@yahoo.com>
 <3ecac0ea-830b-47a0-931a-67fea637f0c3@yahoo.com>
 <ausrVrtHQHvac9bV@analog.com>
 <e3036c42-8c31-49e2-8ab5-cbc5b8771e51@yahoo.com>
 <auxDYMASk8J0SZRW@analog.com>
Content-Language: pl
From: Mieczyslaw Nalewaj <namiltd@yahoo.com>
In-Reply-To: <auxDYMASk8J0SZRW@analog.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.26943 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On Thu, Nov 05, 2026 at 09:52:53AM +0100, Alvin Šipraga wrote:
 > On Thu, Nov 05, 2026 at 08:18:49AM +0100, Mieczyslaw Nalewaj wrote:
 > > rtl8365mb_sds_write() and rtl8365mb_sds_read() now take
 > > sds_lock with guard(mutex)(&mb->sds_lock), so the goto out_unlock paths
 > > and the explicit mutex_unlock() are gone and every error path is a 
plain
 > > return.
 >
 > I've spent too much time out of netdev recently:
 >
 > https://kernel.org
 >
 > Andrew here gives some input on netdev maintainters' view of guard().
 >
 > So perhaps you can ignore my comment to this patch after all.

Thanks for the heads-up and for sharing Andrew's input.

However, please note that guard(mutex) is already used for sds_cfg_lock 
in several other functions within this patch, namely pcs_config(), 
pcs_disable(), conduit_state_change(), and teardown().

To maintain a consistent coding style across the whole patch, should I 
keep guard(mutex) as it is, or would you prefer that I convert all of 
them back to the classic mutex_lock()/mutex_unlock() pattern for v9?

Both rtl8365mb_sds_write() and rtl8365mb_sds_read() are very short and 
the lock always spans until the final return, so they shouldn't suffer 
from the over-protection issues Andrew mentioned, but I am happy to 
change the whole file back to explicit locking if that is preferred for 
netdev.

Best regards,
Mieczyslaw

