Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=66.163.190.148
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793863126;
	b=2pYyBBbSyH52/h5sTYQCkIwV/wo0OdyWC0e5YacDxdJ8FS7AEk73mVO5H3mij2SGVBC2
	 urY8pNE7OzqCcf/2QCod9tas0ntYmwy4EeOtNAihxY6QoP4kMUqhM1AMzpWAuOH9nUXIk
	 tQcHfTJuMFhai9b0oQrxgsFKa2etKXejAsE795M4vL01Ifw2Xoq0gY1LSB0yw0PrZ/WNj
	 /CSVye9jTVPzKV+HyauMWOJP3jWXDOGoPXpvXjREbyMHMJ9kBw8WqzS92KUd5jVY73O4a
	 7vNdH8/fWpR/U50VHefhlGQyJF9OxOO/NTDIX7QNhXll9FXwCj76eC4slytrj0KTDQg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793863126;
	h=DMARC-Filter:DKIM-Signature:X-SONIC-DKIM-SIGN:X-YMail-OSG:X-Sonic-MF:
	 X-Sonic-ID:Received:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Mailer;
	bh=hnJxFzFYiDjAGOC387QOo92SDHQnXIskf30SLHqsmrU=;
	b=wZkDN55+1gswtU53h+vdksKeT871vvF/Rzu1eiJu/NCWDgK5T2PILWnfJnrHUg4Bs9E+
	 SO5hXKKG1WUlP6LBCTmxbN9RPwpP0ayCDcqtDRqUm1svv7L9ppqpDZH61ynlYN8mhjL7U
	 YO+NEqEURyTFopcfzsH02mQNGu2P+j2K5LK5KTbF00ze+SYkTMPd7x+lPuqGV/puhKoA9
	 5SZwuLGCbW63GTA3XGl2BVousm7LufdytH2eGuL32e8Rka8AE2XctqjcR4hrJfxsFLivg
	 KRF4CppelHA37Ad560D6tGXrMQQCOutYfp+874jZKIPUVs00s9Ub2E1UAO7bsK4DZkQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=yahoo.com;
	spf=pass smtp.mailfrom=yahoo.com;
	dkim=pass header.d=yahoo.com header.i=@yahoo.com header.a=rsa-sha256 header.s=s2048 header.b=ksaD9OUc;
	arc=none smtp.remote-ip=66.163.190.148
Received: from sonic315-22.consmr.mail.ne1.yahoo.com (sonic315-22.consmr.mail.ne1.yahoo.com [66.163.190.148])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48569606A326
	for <netdev@vger.kernel.org>; Thu,  5 Nov 2026 07:18:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 48569606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=yahoo.com header.i=@yahoo.com header.a=rsa-sha256 header.s=s2048 header.b=ksaD9OUc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1793863125; bh=hnJxFzFYiDjAGOC387QOo92SDHQnXIskf30SLHqsmrU=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=ksaD9OUcdG0lWJm8bCp2eWisGOHKzLVHij1WV7UjPSAYfsSI1UKp8fh0cz0ABsNvfLLN9uKoQdVdcMUnldbhX36wIPrI0pbldlAnyFIMPZgH32dCAKjq4IO8kfmzo3auEJctC0VyHm5lKO9q7hx33D6fO0efGXBKdCJLJ5J6hDFh6vWhrl6mWH95Eyrg3T7nYgBXyfbPpAMEmKCnKqM8pFmK8EIunQlnVqRjxzIPGlzEWWQt/t/DyEdVMibKGQNdp8GhEZigVz3evVXHd3WPTvWOHmfifYfEBwrHJ1Jdd4s9DTTJts1QhWR0FUdFyFfaFDtF0xdutga15Hobc+zLmg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1793863125; bh=uuzhrE+LisKRoMwi2riyVi/ZdCqeCxV8pXHwOI7Du8V=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=YYJGKiqk6stWemy0xb9vEgYiGmsnvZ+e6Hk05jSh41kd3ZN642QAA3c1h2LJm/d7H9Ja8qdR7VxS2n8N2EwroqxUXMtQH+Ilw3EmIUL3c5FIPI0+2GAKuQMbJAac7vItmLJORGc+P39/JX+b4ifwQusX4ieCCACyliqPumMtCaBFBQeGdqjBfTE2yTr+d2xQpYq1Jtnwf9ryGrxFD1bkQ3iAMO7Tpr/AyANXMxozo0ON5f17Jif+1zAvwEVyXHg1nwzGaeZZ8+2EPf4xooQX1bXeTSTzdferToxv9l95HovqOWZNPzCiqX07iSVRJJbMphaFHhxm8JzlT1hLqYn+fQ==
X-YMail-OSG: VyEVz.AVM1lNsSidy9p9jP8cEUnLw4fwblh_UOX_1A2Pskkq_1N10GRx_GkmRtW
 kGcugBLWgOjFrSn3DSThr6me.wY_omboo.jJ3V4SAu6q30MV6A623Txk.lDdrDfz38PY7Ay23Y0f
 ESvOvYkSpR4oCwPLTwAYLVxQa6VKTRiKaZLRMUniAwL58Eu8ooKAAJ_6Ozc.tQkB6VT3BWwHJ0A.
 twwZd504QrC5CdDzMNx24uwNabon8VrrgrlAlsvHmao3Ub6MQf2NcZGaMhvF9sXlegD27fK5swB8
 vklvf_DAYuryfVUjHt6as5feXEYCGTyhKxgZCBluGoyKWqwbjOpXMgdxX9vxPkQCwBBmwLlCVHnP
 40rOKjFB2peFZkg7ep490YMdhFK2hmK2pxPr0r_WM80Y31OxEp2TpA_qKs87JGQaGmHz78sk31Z4
 5bTfXVriG.MfhcQ5W2lFGzXxMOfllmIT4U1lveM1G2uDlp_Q9jh4mFSVk4qIOiMkw5KcGWskUnzx
 nAhlvneRP74Z9YtulpQpEPwouq96Xql0FMAIKCh_pOKwMUB3kkkX.pTs_jPEyl9jdvjRNPly_.bn
 8Nzh7v0lkKrawPZB6leQV6tXIQj9h9W5O6klF6NQLOTlU6lZjXS9S7CDEhNlJ6WYNmOAD2aqCn0H
 L_049rBJlKsL.5CuZZvZbjLn7LW6IxpA2vSoT6kiMNTJRnECWbhrL4wB6oxv.w0hukjcrLkW1O84
 9Jy4eqfg6CO8S4LQEaHxVOKT4.ps5G2t.0ZSy9b9sTfk5aTQCeU94y7PjdHRs2YSO..PY8fJnMIt
 dCdkJJ1p0rYLadQgaNdPE3D5QBGB9n50OyVL_p4W7Qrcbj83ODAPT7GulOyNWTTzhqAqE5D9K7jZ
 7xyhWPYx0v2Wx89mCAusbdrdsSTYRQmGFgXgaoVdqL0eXMw2EXRGMKv1sPqrWRtpi_dwptuuZkqp
 eMsLcUn7Uo9YlK_V6jKuMvFW7lDLqff4xbCivo5BexXU9MGSnpPr9RRT0dKVVIgUGuXwRTHiTMoL
 cMUPPgvi4H_7SuDKiOXVnJ_5x7uvtN_gft3mmeMZJqZAho7EakDG0UH54mPAmNFb4Lt1VMTXanKe
 nyA3HNTH8xZIc.VteGxDa1UZkXMyHUoxTu4.DeTLvUB1CFXQQWjUhsfRul9feX4rmPpyJ86vI.NI
 0Y9L6nz_dg__cCGX5nuQikbEtX4Pch84TaBdSjDZElBZV5fVpGQ156A6j7ymEOSEUgRTtKz2NyVg
 Dk.FEGWPCji84hGrmnY6Zx_EmzZ02bS9tavTtT5WP7t.j6gS2y_cNakRhhQ1S8yLzb4z.2O6t5sW
 51JvLW9n_typRmbFlbBbxNb3c30f8n20vMpZxaFcEITOh1e1jOxC_ZdGoCsOczD36GRFzb6Vnqvj
 abcpbWemndhTz.o5YY.qkNlCn01YNF8r.Xl9kqIVLV4zmKDdmi8SnAHyUhqZ4QtyZ7kRDZRrBALi
 jOMcDpF8YFHAnwiK74VhgWElOdUqUmD1vdAyFlIdN5QcC.yHW5khKUsnlioYChAQ0v4SKKL2uFxO
 kunu5LCPZ2vm84vDPW9zsW2U9efRAyrq38fzIBCnmt60X4KPNR49AHVbHVBMxVOPCOUVFnj79Mn.
 2tdEE6Qe5VHkKXLTi4MbGRHTWhT557Wmy35sUMCzlDJVxJSUr6hfEeuhI3GqNnlnn6oP3ySkrzTY
 VzNu7cPe0iBMRqD1ABLMYW1BYJbs4k6K.r24N9sNUhKTYNiFsmKQVJtHZE5zC_EKl6RkcgKOF5Dh
 aEGsyOgLgS7Mu0ZZumyKu1CsHkAN5.SX1cKhD.Q40VRfAYMEbijIw0xeiA00BFmeT8lg4P1SJII6
 8QDp1d0x8V86LX9FE1qVwiZHJHMheht7tHzesia6NRWuONi6UN5G1YRzOo6oBaC43Ihl.JVuI_fV
 bO2Luh3YWsklemYrVIWGAVX07GdYBx1vqld3f1UiUjbuhYSS06a0WfOgX6J4vji7UBYsQfFiiEGC
 _rezze4fMzBdZGDFTQVMv1eefUN8rfijQ0RsLlb9vrECfQUWV5E6h6GBRQAsjnLRLq7fLdzEKSCf
 85wsERmU7HkYCyx8fa147iP8z8tkyqJsg45Jej036lPDmXaYiuNLWz6rHLYbDNZIG.p46Qml0LRu
 kJJ0EuaEgnblrVfmVL_AQOjUbuUNSHQ3o7NLuaRYBeDBYX66yyufzfskiE6NQVY7YjsKphTWrgOZ
 FhBx_YpZxaHO961KpxqwwI_hU6ZPYTspFwbfLtBqn1UtqAi7HMmuKg9IwZmOxHIi4tgYTO8WXHkQ
 LjHE16ja2SrLurfNFWQ--
X-Sonic-MF: <namiltd@yahoo.com>
X-Sonic-ID: 550448c0-81b8-40bb-a89c-e477e4cf44af
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.ne1.yahoo.com with HTTP; Thu, 5 Nov 2026 07:18:45 +0000
Received: by hermes--production-ir2-5dd9bf4598-c2rmk (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 305a53ff9b5e3c4878dba0797c3f1d13;
          Thu, 05 Nov 2026 07:18:41 +0000 (UTC)
Message-ID: <e3036c42-8c31-49e2-8ab5-cbc5b8771e51@yahoo.com>
Date: Thu, 5 Nov 2026 08:18:49 +0100
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
Content-Language: pl
From: Mieczyslaw Nalewaj <namiltd@yahoo.com>
In-Reply-To: <ausrVrtHQHvac9bV@analog.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.26943 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

Subject: Re: [PATCH net-next v7 08/10] net: dsa: realtek: rtl8365mb: 
re-latch the family D SerDes

On Wed, Nov 04, 2026 at 01:57:24PM +0100, Alvin Šipraga wrote:
 > On Mon, Nov 02, 2026 at 03:43:45PM +0100, Mieczyslaw Nalewaj wrote:
 > > +    struct rtl8365mb *mb = priv->chip_data;
 > >      int ret;
 > >
 > > +    mutex_lock(&mb->sds_lock);
 >
 > OK, I don't think I can give a particularly good review of this patch
 > since I didn't follow the previous work for SerDes support... But at
 > least, can you use guard(mutex)() here? ;-) And elsewhere it might
 > apply.

Sure, done. rtl8365mb_sds_write() and rtl8365mb_sds_read() now take
sds_lock with guard(mutex)(&mb->sds_lock), so the goto out_unlock paths
and the explicit mutex_unlock() are gone and every error path is a plain
return.

 > > +    mutex_lock(&mb->sds_lock);
 >
 > Like here, etc.

These two are the only users of sds_lock. The other locking in the patch
(sds_cfg_lock in pcs_config(), pcs_disable(), conduit_state_change() and
teardown()) already uses guard(mutex)().

As you suggested, I will not post v9 yet and will wait until we have
settled the remaining points in this thread.

Best regards,
Mieczyslaw
