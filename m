Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=66.163.189.83
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794171228;
	b=qSnxjBJc+DXvjnfUusOSYHPYahJNy58bTzweVf7sN56XSRlJq3xFofvVDXoRHtno/bE3
	 0JGrwpqGOuncZeEuj5aUfez67FjdkiPKT2rVQcsKCTb4bUlo9wUcivxk06XDRhU7zJBKs
	 /hyad8qv7mHAlL/xEKDffgMVPW/TJ+M1Ks0nzEzPcPSU06LanUsPEKvNYIWUAQYHCMfVA
	 yiD1LXoBOFUetzlqMmQBMt2dcLAJLw7RIzgklA2JVEgh2D3B2Y8hv/iyikgYV+dD6SkkF
	 LzYY+vRUNZkW4TyuCCs102reddl+63LD4Vm/tU+kiCQ0d/CD3UO6KHje3IQUg76WZ2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794171228;
	h=DMARC-Filter:DKIM-Signature:X-SONIC-DKIM-SIGN:X-YMail-OSG:X-Sonic-MF:
	 X-Sonic-ID:Received:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Mailer;
	bh=e/3pPBGnBIMYiIi6ztyK5TxrJUDF7cio2r7awt76SK4=;
	b=KoK+Uz31gCmvJd8T9Zg/PU1mOYIKzh6sGMNUUcLDYsZZTAKthk80pDjOOXbyXR+KoA9S
	 nbhXfMy02MFBGiAyQGcjJLbPTV/vVrxr4bpJn9dqeLVWNVYpVtvipJF9I1SBQ8JnIwYZd
	 RSUrUZ/9m0ci7LqIyX+ZJicD/G+zkSpIZ9I7RlF6hj0At8JJazCCeiAFj7exm/gWa2xxp
	 +Qlg+jPTsAwp74vBqTQfWsXJVRlweHONR5f70rTC2yT+h7XvtqBfJrfpGOqeiOUUMG/BK
	 S6UXDY09TlumnyJ0dmfWCTdE8HXw3xiMBZku4/0nKT8GAYsRPHKeQyv7O/lPiBe1iqw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=yahoo.com;
	spf=pass smtp.mailfrom=yahoo.com;
	dkim=pass header.d=yahoo.com header.i=@yahoo.com header.a=rsa-sha256 header.s=s2048 header.b=byhOVwYq;
	arc=none smtp.remote-ip=66.163.189.83
Received: from sonic306-21.consmr.mail.ne1.yahoo.com (sonic306-21.consmr.mail.ne1.yahoo.com [66.163.189.83])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CC71606A320
	for <netdev@vger.kernel.org>; Sun,  8 Nov 2026 20:53:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9CC71606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=yahoo.com header.i=@yahoo.com header.a=rsa-sha256 header.s=s2048 header.b=byhOVwYq
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1794171221; bh=e/3pPBGnBIMYiIi6ztyK5TxrJUDF7cio2r7awt76SK4=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=byhOVwYqH1Aza48vpRJ4LjGjOjfIAQXumAA/b2x7aiZ8TbeJ51qhc0R7B5hTqjGxOlDMkeuZHYviK2g3C/4jb0cYaoquCFkYdoHf8Kh0h+MCW12TFZa91qZ2pjUQwweRT7bAw5T4eEHaVJ4NABo7FAatlV6GYmYkk66DG+Wb0fajMWDEAt5Sm6Mmk1D/BJ257H4WGqoNzgF5E1ZDkx/xqOSQOO/hhkX5XkLYJGu+uYYeBGm4JCuphz8KUk9KYTmJxX6/50+dfltfF4pDHxukO2tzbi2FMQvrx0nIjdrMH8I0/T8VAy8R1nrmYty1f1B2sGaEkztrGzfXda3N6IuZhA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1794171221; bh=bfbRY13LtdKfiFRgGEqBHhC0t1aLNx8+za0tHZYb/SC=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=DyFh9zEmpmNtV93lkurnqAgHG/mtGTM4Hmcg31EJUCcEBaZaHWwIKRK5xqQjHxcl5p6dlEg/UGJcg/ZkmjcB+jsjUiW+tCtl5o5lyIGXhEjMSW+ZP6dOSGiAa71SpA0d+bpcR6VtGpYSsjkzxdZ/Xjnpj8s75/BJ50a0LLH90Bv6QfmyFJYKAKWbzgXHp9BNbvgwfw9xU8Aii73uCA2R2IwYZlif8ILOiud4MXo5+WHivALnGtrGVB1FLPZHz/xx3srrtiJriZl4v1bx1BLDWusc/rLLD6wu2qi20R/2QWxb33ISnp4rBCYD388Ub+e9CAmiQwOCl2EagBsSGXHlyA==
X-YMail-OSG: X7lC0_kVM1k708JTOK6ZygPyY4o8Jok51aUXM7sDPReFjcldjTYWzcZS5L4Ckmn
 rCg3QFkUUCZD6kMtZw5.FOzDpuVQ9s9m3xgIzvneHlW1sH5quIPJQ.HqFJ2EQc2Lgl2hiznduCdo
 a445tWutLgsd27OBJ8AICmHz5l9bJRz1_8BSn39.XUwPXp.JiQsQD1ytP2ujzWYg4zFY9Kb3ODP5
 YU2MvRSRsAdhnnPUA_QcPPZEqMvGPCyr5uZ.GlWKSxO3gh0WKIzt5DHDPPrMMS6PFMdxvEPazaN5
 13hASrHtLmY8q2x5cGWTgu_qfzeQfU6jY3x3j23w2nMgLylurBn4gfDjb017fT5V7qOGKp_J2HHt
 hv6tV4hORcGneUujDvXevLl77v2t.8gNn4qqzpqcT_WZohfNOXWybaczU.GgPZ8wbKN4UDRPq6Vc
 MViinPL9q0KdSJOQRy.LImEFLR3E_nkc0D9IWpeFDxQGyWVHjVY4RFHBEm_tv1UYWDFlgDrPErqt
 OoJN3hMsWNWNLCnPGSp0J6OtppEywbsky8E54ZXbPjbcdo5UEzX8P_kd1kJZLuLfZJKuT5_AOjG7
 fUB09D7qG2T.ZUqLHMIM_lD0.n75rw46gHRKmx8.Ewkz4iQ7nBkBXnmuBgZOFc7y5DUI8hZzw77F
 RNc48YpxP44RgvUsQGJHqZIPnqkEKKhynbTQReO7kyUItMK7BUH7Yw_RkHP2s1ivUhz4gFmSQRdM
 gGvAoQutoQnCWmjzxiy9eOXoEIipcyr5hS5xHNiY5zEZxwZ7M4iUXJ09tDmxnjPxFRi4dEM6_GnV
 fzB2Jdod7aefEt1eDX3045F3hL96QPrxL.TOw5nZ8YgwCPTubcfQuoA.AVgz_sFALNrtlFiLCzIU
 aDKGT1C01_0O6Y5DJCTzqh0Hkln2VbAhjO2HRhHOFmXc1y_HzuMWxhkWIjbNwoBrIvD1CDS2EBGF
 Nn6sI8bJEcCBCRzWz_xD0C_mBSdTxEibsadCsqD3BItmF1cSf.MFrEAd_cH_tm..Q.0ohc71EXXb
 9juu94wQz3.jTvqhDeV9qleNZRZjrhkLMP20DISu_iWVFNZJXSKtDl.wOyhbPniFUs7XskUrry8F
 4HzXoM2p6IxTpfU4amoBl2L2FVDKH1FkOXCrbaNNjAVUaaFY2ODdzPTakP.xx1XzZGCbOPSNMsHa
 3dZMDpBwbddGsfgcg8Im0Lh7kE0j6I8OhNDCNMVQqZ40ahZEyif3T2LNRHbO1MhsN9JdbX4Lj42r
 xL1RgLhL8wJnjM.rtmdJF7d8vMDyZ7apdAHWtszIBoX50WpV.cYvsLjKluEktEF9TalpxBqeONI.
 02l8YjbZQFMm7dQIPa_oMJIwx5O7yEnMy5tRM6h1RkOXwhS544bqBNWY3zhakhMw5jf_GLHCZJZ7
 t6Kg51NnS6ausIIA4loAnLdWLux_2hTgblSWZWlYY4O547L0I80Olm3TQwYjMSjk2XgrVGrHYYDl
 iFrSkk5IjguKtUhHpzxV09py1xC2nI.lRqrB3GSE1RWeywAbbMTIS32hK55QHPGdYacQCcnRuncr
 hA9GlHJK_9Zo1Rdh2WbP_4P8GTnaqe0t5zpXJ0QgUJNpE3Oun2cNYhL5Vd0tOZ8yy3klVEaCz_rv
 Vc_v92HfnwTE..GuvE9wRzXIa.ohg1Yi4aXpYDCoi.k8g7SFsk7JsVAf0Mgy4JS0VCzZeXTmJXcc
 DJCuEHlGfiGYt9mP2rBhh6BsuKiiA4_pndpwHbnp7XSFCkAZFYqHv.8w_HTZZ1qfOciA6o7U9aQv
 oZwKq8MRfdHOSrUTxIjsJzCXfDbOnpa5SkLM9C2_kfQ4liRVq82uX_b2_v3vQThxg.QvlXR0nnBB
 DRvI3xvSXDotqGPfn44pSSQWQ0ruCqIfoWux1Yi3m2EtWqD2KrHGeWG36_k4PwAg12FS2W758.uS
 01bfnPhpehfn2WrnmFEYJ6ACVAPaqARi_cpWenvPjudJ9xWcj1I.R5i2jr98rO16tJcN_6kZ2ZZp
 .uWG1ncAdvjGayjtBrIJFpqxSX_WCzZCBUip.iN75cJkVIrd.3WPOlqus8X_tW1JiTUDdfaPuDDA
 tkdCJoFrwx_._9XGmGFlH3XHDp50_Ab_F3ENWXg1Ex30hFaSu4JJpX.hdC8hvBM0vLME86oSG07J
 7RBMynpdnWOKILkSarCuVv8_.mYaueIflc9TMJrMiY3CqwpvPMVoLTYPU8eXMoA7VxpqzFmtnvOp
 DpeHJFf4Ws2Ihh6enurOqSVXykATVgfHDPzydCMKSBXDGTlkfJsMmCcxnhGNN9gmLBuxNEdfyZIe
 mXWftIciHDDvEBaF3uF3gBAtKucbLQip9qS73fnKOlONG.RFvWal5
X-Sonic-MF: <namiltd@yahoo.com>
X-Sonic-ID: 10da040a-9b43-41bc-8977-490da0709b1a
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.ne1.yahoo.com with HTTP; Sun, 8 Nov 2026 20:53:41 +0000
Received: by hermes--production-ir2-5dd9bf4598-c2rmk (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID c961121125a6f0b424c88f0430981591;
          Sun, 08 Nov 2026 20:53:38 +0000 (UTC)
Message-ID: <f84cfedb-b551-4316-8d2b-4d6e06fc151b@yahoo.com>
Date: Sun, 8 Nov 2026 21:53:33 +0100
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
Subject: Re: [PATCH net-next v9 08/11] net: dsa: realtek: rtl8365mb: re-latch
 the family D SerDes
To: Johan Alvarado <contact@c127.dev>, alvin.sipraga@analog.com
Cc: linusw@kernel.org, andrew@lunn.ch, olteanv@gmail.com, kuba@kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 linux@armlinux.org.uk, luizluca@gmail.com, maxime.chevallier@bootlin.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, gusfmora@gmail.com,
 kuncy7@gmail.com, fabianotassotti@gmail.com, gabonpivovich@gmail.com
References: <9b73858d-fc09-4988-8bab-fd7b88db9412@yahoo.com>
 <39e46930-0d24-46d6-8861-5dd309bb7640@yahoo.com>
 <1e8da5e3-0d1c-4ce6-bb3c-4b9b7a5789a6@c127.dev>
Content-Language: pl
From: Mieczyslaw Nalewaj <namiltd@yahoo.com>
In-Reply-To: <1e8da5e3-0d1c-4ce6-bb3c-4b9b7a5789a6@c127.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.26943 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On Sun, Nov 8, 2026 Johan Alvarado wrote:
> I'm still investigating and will report back once I have something
> concrete. Until then I would ask to hold off on patch 8.

Hi Johan,

OK, I will hold off on patch 8 until I hear from you.

The logs and the board for this are with Oleg Gavrilov (Cc'd), who
co-developed the patch. Oleg, could you please send Johan whatever he
asks for?

Best regards,
Mieczyslaw
