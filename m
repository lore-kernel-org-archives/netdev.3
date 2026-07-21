Received: from sonic315-20.consmr.mail.ne1.yahoo.com (sonic315-20.consmr.mail.ne1.yahoo.com [66.163.190.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46DE54CA266
	for <netdev@vger.kernel.org>; Tue, 21 Jul 2026 15:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.190.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784646219; cv=none; b=CQzYi7jlSoWIL/ZAWgd9ik9MNkCaxP+SBlpTLEAqkzVUow10Ug7+xZaLJV/XhnoVM8kf6DUfBUXFOrvhAD/zC5F7Tp0V69Qqs/q4Lo9SqjC+r+ZD9VxouL5vqEvw005Ywm6CJfuDibWPFpZtylzvR+JfPaZcDLEY+OK5fjzCnV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784646219; c=relaxed/simple;
	bh=S5kzdFvZhX9EjQAwbrxx5lhdIGpyd27AqERIZutRh68=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=btRYmYCBJ/BJxRv+3aAFiGfyKEFbNsS+Tm/i9HWegktFnHu7Y1zjAWd2ADHdrq22Xc7Po4VurrGJIUOyBt6buVG49hD3m/CtnllV0r87WVDm4VK/ZYhr9l8Q6bt/3A1VUjJq+oEC9X5WU8wwKkzBJMuf4S7aa9+i3ZO2fMNuTj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=YmP2XJFn; arc=none smtp.client-ip=66.163.190.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="YmP2XJFn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1784646217; bh=2B6gY/9f9XbeGv7YU0rhCErE01zfoZL7/ZEl1LbDVjs=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=YmP2XJFnJB7TwGbEUQYcU7qVBkIQ4IEWkMkJYDw9Kqvypm21pZoNpcNIOyag/VAjx/efWjtdEJ5UGH1AvA8f323h6xWqN5+JsE/Van4NSBlnAkmKEZp4pcjLLowbJcFjXOT6vvfoN3tnDIctzl7NhzrHA08IvbSPmLgvof5jSpPGRn0B8tQb851sA2FWmaCzjSc9Bs8OqJoMT47qGNkXJgNnnNAVQoGtWoGvcxUqipD59cmINukxE3/UVOip61kQV3KvUdA2f26Yt0aOhiaCUoRZgsmO/4uVDrblT+ceSIBXF21fZuXkPkjQkvAbwoRL0RTjOjdwQVDSPz5m4avFLg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1784646217; bh=b9HddInWv6qJlNyeuRAhKVfO+JK32mEWaGL/0OJ5fg1=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=ouLF7DGkS/MYGj1vmcATw53orpFCeeWzsAUjQ2UDIe3WpI+NEoJo4wvmKr4HtWo41Y1DgwoD0S7q6FSnBJ6b4EWtYhHbvZBSPup3MVxrezmO/EPUgm/nVRrGyfVg/Q1fTbVit4zI7Kt2sJRMYgtz1TSeoGcMnAtCmfw6A09VKV9Gkk3KBfFEGwP+rjrTJgJqK7Khow+iB+f6lug+CkU6l3Ss8K03ybnffcJlycnGq5itZLHzbOW0BvgTnxtsBu04PXoMUWgu7f9lhZ/nnyEXlmCmhOryL49ssrP6gXQrK7VW2EPjq5Rit9n0cx32171Uww/EHloB+RJyTGatiIGCGg==
X-YMail-OSG: EUloSt4VM1kBNc5LsXQG0Ivgxj6MShTT_qrIGif5YpyxG3ov8dRCGvS2n9a8k.G
 XXveZA6Eqk.fAY_1HOC3mpFqkSlH52vMYbuAzIyC_kuMMKtHskHGMxA_qDpg5jweFO9lHpHrcNob
 NFqu6TPZoHtpKwKSmGtqU.rlqAb5CFgbHMtBGXnGmpjOoXtgI1.vNNu_xguwKziRDvFjM6GIVDGT
 FD__pUHGsrkkwHC2IB4kDZi9wkP_I238ZRQOJsnEb0sZd7.fxhYfStHa7GytVfb4FJiycGBZ4c5T
 HLnLNWSOmJVqDkdh.x.ok8mk3ghRnuSxhcTWG7R.q5I9iFlCElfYc1pL2keQDPHyC9GSjxfQeIeM
 jgeJDYItepIB.dewytRjaEFousAptY7_jDuZxwLZ4dJxKUtIUC3i2hTuMppJgA55f0muvIKn2zep
 1O6ojz7KBUyqz9Rk3ENbRUBNn1ufhhNQKArLWGy088YzrU6gzSz26T2kFO2T.JheNxQzasiHmvP3
 BYjXBS3qdHv_OIX3.SFPK7G3e3HxLdYVh8cVgzbQ_Nd93myIxpnEo4K3bV7_aXEMmfDacq5kMP.6
 fJq0Ff.IaNKOJgg15O84x2PNyIoNpXJ2Bmh3MsfMaFoAJm2oHap_EqK7LtEmUARmuHFzfi0Rjy6y
 IJRNfJRue1u4AHl8NrdfjoSQMfyTXYn8PMr.rNmaaSgZozLpAjy2sn0T7pQy_6NFvaPnRkwMUONP
 Ut22Qd8b6PHmeyxxhEiUYqFFsXgNW9SfTiflN9MLKFGCcfk8v5ScIeSjL.DHIsw06qWCeQ8YIGp.
 pJ0ETrukdgv3x_D4KjTesYSRdrjHFms3ayZHXxpMVXLhiS0lg.__zuTukcvfiztNjA7zttjyRyQn
 OcthVf7NnePyMBYGSt4BLoPxCPcb4JRKOr2E8TvYe_FWnSL1ZXLjvNq4o4ElpSL4LA0RwF.uoYgw
 NSSXMQApYdAOXkzkd2JaLCQTRLATMHJFcHK6YgTd.DXDluwyGPLQnISd0v3UMK4Ysp3C0LSx3TLR
 3Oc9NP3zMD_zBJW1lOj06YIyjhoAuif4Gf0YEPE5uuuA00rAkUCbJ2QhbrcA5.7h3hbQAgzAozsK
 ZevZPhB1uBXnKRUcxnqCwyAe2VA2Y5XxZdtFhLWJnRIc3H57vvhJg8XQvXFfGUFMDQlW7bIgilhy
 ivyrsNhPfCqJiuN_eRFyzFDMBg7dozxmW.wAVdefLLvcpGLSIS.1gb1B8oTaJMHGi._yQ8FvRC2t
 1AzAC_5ac1ZhNJPN9Od3F6kXo78jaCE8PlVUUxasOiZDeN_koW1xf7.m9vdeJqAiOPyqH7Q8XCmX
 pPMvMEJs6e6ZhjpUbFr3.JYIka36rk3.xcf8bi8ZBZQboE1VSBPSfkSlV9TC3sQt5_Jmo_mSgDrj
 xXqKGkvc0hJhTZf1vlaWmwSFvQt8oK1xF_l2i_ezaayEHQe488szHZftbByq2O8Y.EQYqxQq0J5Z
 6JnIX5GI5.qaxPO486cKhcUdY4dq.wUgqRVBZLmKxl8E7uhFV2a9HS9SWRUxB4FnGIR1J7rrkyaC
 teKgGFg7sPZmf27wMgenMGgs.HhyjGkFT7K4qTb8kzO.3bIuYFj4cDLuVtsAhAZoW5ZjdDACWoZG
 NUyFIpN7G8KmNoGyACJWUuvGKd_mm4eX6CMyFk4VtnJYTjrfjejYj.gPBFij3tVBLH9ScKMvhsQI
 mbM6Q.J7MQro0Bu1mTFNkRh2Z1VQGpNY5JgJry_Eg8.TMkjhf17OPZKHTGsyfNzsxvFAXTpNcOBa
 ITZXLqDQnDb_hZb34lIJmIHwpMk_RjEM2wwmPpxPivB3FFt961aBnQt9QjV96wot8sOig0LwhnvX
 K2UeYwNoJOEfBgGfenKEnoUt_jXjEqDo8ZhBSIUap5TRYC4G87i6p4CnbubzwAH6jBFX3Hd3uDpL
 hAVLo8WmU2_RRXl7uO3EgyAOzT2Z3h3bCBeUOuRT03KCWDBaZLxmpvCRR_cz4ITg8LhIaxhWOjq6
 rNPpim7JMt5RvbSDv9ejNqAIEAyPz5yshuSwFZOPYWHBhKpW_qIr50QIBFIriqlGtEqEqwFMB6YZ
 4YVQ.WDLIr4x6lrJVkMN1bQxrf2HWzlHnB1i3TQiIeMTpwsMiuwntzEStuVXsTUAiPfHf0J_U9y0
 BMOH.B3YjEiasoIGGntDmrCsof7vBWOj62x661QS_H5_yIxaY4D5lqjVtEYWe8shtP5tiqfezvVM
 Hv1aG0A7l2qWd52erQGO_cZ2okf0CYe4WRfJFSRyL7nvWyffk5WlpC.Q54JCieCEhwSYYvec17D0
 WKXt1Is6nB3bca5.e6hcwC_jrQuAoV2ctQQQIFv8s
X-Sonic-MF: <namiltd@yahoo.com>
X-Sonic-ID: 8385ab2c-14ce-47b2-8667-104d1b3eb9df
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.ne1.yahoo.com with HTTP; Tue, 21 Jul 2026 15:03:37 +0000
Received: by hermes--production-ir2-7b48fcd765-kss9d (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 2539361a5e1aa91d765b2766a7a56184;
          Tue, 21 Jul 2026 14:32:16 +0000 (UTC)
Message-ID: <2d04657b-80d3-4ed8-8ce1-de464aefb33e@yahoo.com>
Date: Tue, 21 Jul 2026 16:32:10 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 1/2] net: dsa: realtek: rtl8365mb: add SGMII
 support for RTL8367S
To: contact@c127.dev, Linus Walleij <linusw@kernel.org>,
 =?UTF-8?Q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>,
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Russell King <linux@armlinux.org.uk>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Luiz Angelo Daros de Luca <luizluca@gmail.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260711-rtl8367s-sgmii-v6-0-88f7944ddca7@c127.dev>
 <20260711-rtl8367s-sgmii-v6-1-88f7944ddca7@c127.dev>
Content-Language: pl
From: Mieczyslaw Nalewaj <namiltd@yahoo.com>
In-Reply-To: <20260711-rtl8367s-sgmii-v6-1-88f7944ddca7@c127.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.26180 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo


On 7/12/2026 6:31 AM, Johan Alvarado via B4 Relay wrote:
> From: Johan Alvarado <contact@c127.dev>
> 
> The RTL8367S can mux its embedded SerDes to external interface 1,
> which is typically used to connect the switch to a CPU port. The chip
> info table already declares SGMII as a supported interface mode for
> this chip, but the driver only implements RGMII so far.
> 
> Implement SGMII support as a phylink PCS, with the configuration
> sequence derived from the GPL-licensed Realtek rtl8367c vendor driver
> as distributed in the Mercusys MR80X GPL code drop:
> 

[...]

Reviewed-by: Mieczyslaw Nalewaj <namiltd@yahoo.com>
