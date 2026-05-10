Received: from sonic306-21.consmr.mail.ne1.yahoo.com (sonic306-21.consmr.mail.ne1.yahoo.com [66.163.189.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EBDE22A4E9
	for <netdev@vger.kernel.org>; Sun, 10 May 2026 15:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.189.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778426595; cv=none; b=C11CEcdyiXBC4fa6kCfOXnThkJKU2jBK3uaBsR4H8ioPqcMI8x7K8+VFPACzqPgKAC45pfP41aiMDJN+vFz6TDpzQwV6H2AJgVfASZhhlXyYSjoM/bEOfDfEddBFgmIS2YIpKvtnlF3N595wtYFfGhVwGT/726jmnwAWNhNFrnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778426595; c=relaxed/simple;
	bh=0Pii6v0mt8yThc1QJqpAmJjIq7tSFTASnnUObmMVxOg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LZhTIjBnonRuMvrRoKwMqVHJpAI8lhKsZjwEzq+lbyd0tOANIBuc3A6xXjAZ6BDfegHUzgzU++8nl1gZpHnSPd2lQbRLUcqKE9/PeJLeUjfke3jCM27Wb0OOM2UvPME9LdU91OeZqkkMFH8KvL45yCDYnTtWAYVigQdlwseTz+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=Ch6g/VT4; arc=none smtp.client-ip=66.163.189.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="Ch6g/VT4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1778426587; bh=7ullgjSU4d0AIDFIxXODm9U4fFmynE/YZqJVBDMPJmw=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=Ch6g/VT4H4r3ew9odglwpBBf+BAGmA8z0RyhrSeG9bdX8rBSu7AS+f0tcbh4uYXWquZ4aw6PrpO4aE7GIXo0pfWHUWGjh6QLgyskr6ZXTAXpQFO5f4BiKxU8HiqvN+EmXiaEB5P1ly3s1kpACnZCCkXuShLn3Dd7NpqdZBEwMDYwKLL1HriJb0YkINhkoiLMaTfVRNlioQtsldJkdz514VDUIb9hysnD0njxCEDdK2P9quP2Opq84vsigj/++amw5KW97/UfezeRL+TPmkcGHAURawkJgx+3oxFzGC1JlDLLCsCeHtUe+GAaxNTQhMczjKmQ3XrlQF7QBrfVhDSRtA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1778426587; bh=U6JPI7c1YFnieLogLbZ27hJB/i+eogRJrBUAdHStrsN=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=ZuSsYE2M/am+jRUsHow1pR5neqHoRbz0tiGy289zOh0pd07al978HeIEF2dX793FFO/K3vKPto1NsSB3EaoEeRidemBP+YaomJgaEqTJniaXcYmVlzUSOPanajBrSPZz12GtUza92IQEgHBzv6xDHKEjlu45wv0rj9q1aMo/a/7Bqhy9LG06mi3t7FXjH0q4jNTzR3SP+mJGRvh2vtWS8+N1BYNKGIszBFnKqDvlKWquyucgRtEYZ0s3JgqaeKGiIFQ8z/+sJriiKiQI+aDUI6YiXGZA8alNIOnC4IEya7+1Eqbx3fz8Jf+V64cv/mrW6I7PjFZVxZCLPLwFAt7DQA==
X-YMail-OSG: .i9G2gMVM1lvlFimleMOwCefvzUxaZHpU7Sec_rr.zIJ6cfWnkxCBkyWBwJMX.m
 wUnLvCGZ4Lq83PrtEm9rxzezom9xDDFM3kJ4g0FCUghDuNVbAUXfG.y_zHIecqyMNQYxbNkzbg4S
 hQ0ZudOJ5XyddGO1xp5NjNywaBXEzVHQ.ovBZwgKBHyQbrXE0baUK3nhxtyV3Uxf31e3JLyt_e0i
 5rGxaHYJq6uO907ZYxB8H8wHeHTB.f65H3SwPs_NOdrpvkDoKpx4x.gIoKrcL0VlyQEwAWSVWody
 n4wbHN.hcH4f0no99uBj56b13fchmg.UQuGZtgwFA09S3aN18eCqtPmvomn4SNCuXRF_zzkRejYQ
 jM6HTyb6Z0OO1LplCrU794Ic_407gtBHLLNaPnCe9RrS1HM3trNDvvVEdWHp0JhxOICxdnTH.svb
 zAlnl.tOngh134bB5Fwy41vLENaUNLFR8263VMGRnmELR_3zrc3mi4HPMr7LClMtW_zVlRCKkuzW
 mGCskv4JaHeswbOp6cQMoLaLhlNaeMH.n7UmFFKRXtyYtDDJWJaAWr1_Iu77PjX.7_ozrKb06qWI
 dfAaVrrjvM5DWoV9cYfl70yJj5u3AipO_dJOkJKIp_i28DvLe989XNsSVhubTvasWZL1DZZQmINS
 lDwv.srPcm5bVFJ7F3oZU6di7OxhATHGHcfRQj8feTt2NLeYVLz1wQQnIUS_et7RhVrPWkBAGHf0
 ciXEMKs7okDY_FlrTy6XUoSBlJimOyza_y8nvt341YvnZinTyGXroDsAhH8hjMFT4jxHjn8PZKah
 UGWkkTkC2vJChbPFrZHgB9NN8W2me3sIOhqJqGMP5ndwp5O59Wbxwr_KhVtMBeQvBbE_hraFHFXi
 jL.yu31mJeyfQxn9vZC2syH3htQ09mgJOoxVLjS28o.TaFVReNq21SflUb58J68_G7_xzdXalNkP
 V6AwGIyp46gjI03yF3g7EJgEQEG3tCkZWcnKPFJl8pGM0C3S281Ucie_8.ZmFiKunccNT073WTLD
 WkNWDk2RsFF_O9cAL2h3onvFY1l3tdPl0vZ8hZui3EgZ.tZZpOyYPGQxxmdehIfEHTBSSD4O4I76
 uCHgIEkS86P9q76i5ODIUXgXuW32Nvwra.p3Fw.puOcsohIGJSC72JtLOQ_XYKL9OaTFR6E0bmrf
 8PkXC5tPQeE0tNAqX.aFXVc.Jos68GchodfOQ3LG8CJ.wogcnVVzAa383.0num_UAGrwHwEXKsOS
 QFGVGOFyRa8FuuLdZRc.SWNBaG2hpRvzcFeiBW2ZNoSKUh0DR5KAcwA3SqzWTGw684EgERy5Ev_5
 cPdt7GbuA2rmrtca0WsiqP.YT6YPBBJZAdKi6k60zFeOf_PUHyrqESsa0XH2JxmcXFEhy3UG3lb3
 uG.wSkJoyhDGrQ.qc_2EdhYFgsli9QoWGVioW.3szE1Ncgo82aCu5nn_MWqA2u1NrdSjeU8hkM0Z
 1ou3xH3eoVsbj5bxxjKczza0IyrxiLr38KnLGpyh9lUCaFtkfFvkt1rTQTcKMfV.csi9QtPxiIJe
 M2MC4QjHTndUq8rdS.iw2cGBfANWYeZ5FXtasHjeT51sSMAL_CgQRZPWgbzlYh9ZsISdVKsMeFzO
 ATqh6fcDuQwWZMjNlUJkNBUxHGF99LW_E6Fyrz2_6XMoOBLs3h0qkZj3kYBsk2eNWlR35rRMEvmU
 FUXvJieYAUdTe_Sqz24P1P0Grc3AVBwhblw53X8npRuq8TqMB9Q9WaAxBAkT1lq2gh70V_Hdcm4E
 eOVw5pEpMOtf02qbrl50qbghKXTUVQfnyfj8YAcPdwOBo54sOM0ezZ.sz9qrJHRXezzb_W9por77
 rSE_wglGqB79I2VPzyLvoK2Rm6uZRvoUzvTzqwPcUNo6JTVRqWmdaQ9bZ_LQZVmcfEQ9hd6QEZn8
 OA9gAS2geQcPnmnVj12fqWrcTe0qchwYzvvq_btpKPTnq9LSKoPiiV8KVANOwAQs8nBELmTp4xRF
 TxNcO6jXYA.TVj2RKHpiqnBwUurUP0PwZyEWO7vrMDdoSRIcxx1wowrgBYGyyS6X5eR095q.HOrg
 nsmGJutPOhLW2f9I_4USlQAQoxj8K7wTJ4tIg7n.IMn9nxdgvE_YGu48_zGlLFp6mr2WEEVjQDb3
 8kWluVKMAakUuTH7ZSuTokVeC3zOssbROYjxXeb8JPPQhVf2BTMP5.Iio6.Ce6oL_I_MadN99jN3
 8.2bGgesnlvaxlJvK9IdUFXaMFcLS3EppUDWTkqiQJNjRZHiq.k_YnU9lO6flHp6WNqCtJmSJHOY
 RE1B6ZnItH1fBmjHtnT4x7q8dunlzrc0jL6Ibp_65
X-Sonic-MF: <namiltd@yahoo.com>
X-Sonic-ID: ce3321a9-839b-49da-9acb-75d29dc8d261
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.ne1.yahoo.com with HTTP; Sun, 10 May 2026 15:23:07 +0000
Received: by hermes--production-ir2-89844b765-d82gs (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID f3639f5c1fe4ec784ed7d3f74052cb74;
          Sun, 10 May 2026 15:23:04 +0000 (UTC)
Message-ID: <41728b05-7274-44f4-860e-649ad416c72b@yahoo.com>
Date: Sun, 10 May 2026 17:23:02 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next PATCH v3 1/8] net: dsa: realtek: rtl8365mb: use ERR_PTR
To: Luiz Angelo Daros de Luca <luizluca@gmail.com>,
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Linus Walleij <linusw@kernel.org>,
 =?UTF-8?Q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>,
 Yury Norov <yury.norov@gmail.com>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260506-realtek_forward-v3-0-1d87c5f85a3b@gmail.com>
 <20260506-realtek_forward-v3-1-1d87c5f85a3b@gmail.com>
Content-Language: pl
From: Mieczyslaw Nalewaj <namiltd@yahoo.com>
In-Reply-To: <20260506-realtek_forward-v3-1-1d87c5f85a3b@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.25725 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 5/7/2026 4:58 AM, Luiz Angelo Daros de Luca wrote:
> Convert numeric error codes into human-readable strings by
> using %pe together with ERR_PTR() in dev_err() messages.
> 
> Reviewed-by: Linus Walleij <linusw@kernel.org>
> Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Reviewed-by: Mieczyslaw Nalewaj <namiltd@yahoo.com>
