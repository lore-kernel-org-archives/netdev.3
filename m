Received: from sonic305-21.consmr.mail.ne1.yahoo.com (sonic305-21.consmr.mail.ne1.yahoo.com [66.163.185.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79FAA3E1D14
	for <netdev@vger.kernel.org>; Sat, 10 Oct 2026 19:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.185.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791661078; cv=none; b=eBee4izQaZgLxiFgUuDmirjr5vgqwxAao5/2VYF1SM9n7/+Y3ax2cMdk5UgG/LOPkZAA2imziNuRy6DbQouFPbQr7EWO7dZHTMDgHddXbQnX+uh83/1ikRKo6RUHdUyHrudQhWgNRWGm1OtAj+BJUIxTPkbtaLjtm2yeCkG6a84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791661078; c=relaxed/simple;
	bh=xwjbSYgn6KXQ9wka03ZWzOM3dY+f7vtWb04ux/4AmUg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D6FM0a4ci+HXfRgxiqILdAyPKY1Mz8HmeuALXZ/8QlsE98U2EPJfHYFQnG9De/+IpDyCRwQ10Z+GOLhN0GvcpMSAeqjBbx7AS/lvt4SjlZSgsVQfu3pcHM/D8nZ9cKwk/O1+XpPcSFLVTOgrFWcZLTp7dpErm5GtBJfvJku5T90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=tQRh5XPo; arc=none smtp.client-ip=66.163.185.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="tQRh5XPo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1791661069; bh=xwjbSYgn6KXQ9wka03ZWzOM3dY+f7vtWb04ux/4AmUg=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=tQRh5XPo7RyVOzZ0LdGFgDVt2LHOuELd+1uyUgOtIIGmbcJaAw0GDx3+8C0ylPhWSl7X/ZDovnB3ldEiU5NkUkUzz6hecbVMXoaDgQFtVVV4TK1oXX6z3LzR5Acir2iCKq1CG4dBj8t0hqkWSk87nAB2EXY38R7GfiOSf6uqwsSQ+1fGittRoptsX9POTAirYv2cKe7cSIWzhLLRaGrifK+RtzFnEldA7Z6lqGHJI3Ev1nMw1M5SsTxvli/d+vqsPFtG/4g8TDgXs8pl/rxw27sds1T3tNmZEEwwDVEFmMH6Yu0MqIse50g0o1beS4G7d7E0q8uhgvKRe0Nefse2Aw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1791661069; bh=I4U+UgCIhssSa+jwk5VbHGNYZ7Mw7d7Q9Ktd2X6DH/t=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=fJgWM2KYoUoAN2CKiPiWHxYpizE7WOvwDZphBN2PacA2/KwwmuXRwGzMkxaYxm1JXsn0ZCF97Hm4ekdoM3Nn2rqnsmceg1zm9IPEJFuK2NUGzzyvIfk/CBWZhUsvwSYnmHDZfyOEKBY81OVcYqG/vcwRP0k+q5xPtARC65HUyA7K8lMVCz9uEBURbCdJh/l/PuqcXsnDsRCzp1kl3I+00dWILD8WZrpPXcqrc60AG+uOAyIGuvSiFN292W9MKD8V3jNOycWv/iK0QnAeiqVrPPDO9lbjYJQ/MftNyeg7bixpurHVFiN6cLDpQq326nn+L9g8I/oMFcf5zmHyp4df+A==
X-YMail-OSG: 6rQKzBEVM1nWxOL3GIDBNLJqYkiNN.Q.52v.rnfxY5oVukunkkhyp5xOoRoIO6Y
 hg1tIUQ8M2VzswZeXWC3QpSvuAnkzCe6Z5Al4z2bk466jIHWmMLXwcsYmsDOEX2qQVeQqUTysmVc
 rGUB9pU0YkHBr.WaIfCTfXvSmyULVf.EZk0_NBWjbhb1GmVhohBDZAUCXrBTTMYbuXBj6Pcup9dA
 pwgkzZb9HrYl_fvgBjNCIwy0slp3miP8Oolx70P_7FCY1XsSS3XggmOv.I_WKWKI4LyLNXHjF1ti
 RrKXFu1nkQBuu3KO_ndltGOQrRdj2WTVvDeCEroVEfvF9rwnLm7Rci8DgHV38c_4tgaidUYCNdoy
 .IXeCgPPy7zENWuoeoUoKNeV_TWBD9qQgPdKQ5L.bORRiiakOBkEhd.VvF0.lB7HmvcXmrY1Ze_Y
 CL0YpiScehDa1Ww7IGWhlmrPr4tqbmyb_Am0qJbbCaL0qDyjJwR_Ps4rrrquAGY1L6Ha09lviOSz
 h4wy9fc6XaRNKnCdjCK26GiZaQ1NU.EfGRaMKNZTSB0MRgxHbH3UrMXVq7EhufSnM_Sgztcmae60
 PRqbypnD_oE.1tuSqx2xdpebOFbcUt_cr2Ngu0t9l8FYF55VFwvgt5AupcEoO1KFdojcNPCrHOr5
 F_1H0c.DfErKa06pLDYpkgofBf5STSWe7HZmSuQi9yuSO68Cifh7EAl.V4W28ga8l1bJAVczeHw6
 MrMEqYP5ySOPbI5PbPAZAJFwPNZ1OPOQZ2sPXc0X7FyWG85KzQWWx1L42HKyqnGSdfKD1Cp4Gklv
 s.yjyIFWh2b4TbpxtU3d3zpT8GHlJsUKEe_JAsvtoQ2JfQ2hSWZAwUO7kZkw3wZd65lTrj4CHSs7
 lFAOazCwoNl5BPyjQT5arUxpI7cFmLg8SD1Ki4BFGimxD2VdOplmG7AYfCn6ZIIwnNh9Y.WCC2YD
 4WHLmarLpHKhy_3j3OYEWg4fMJpOLH6c.fNT2r5y1s2oNfWAHPBA9BuTgqXE4W.v3agB2vRSvCyK
 HdZY_dMYUfLw.fz7yPc3qAH7ih_l5wOcBVIiF2sOLgc7WFCDcU4j_aG3otUjCQd2XQYWfM8oJDU2
 2k__lCD7y3R57FazAtodBlKG9v.Qp1GEHeX27JCCgyanHa.xQtlOk5vc_nv6lhPwwSA2K9GmCbhG
 SO9kXqS7CKH0KejL1gKzdIR28xB_y1QDCxgG.R9kWV1Wc.5NnGUUmu1gOVz3bfH_XnGe95DZkCu.
 CHDLFU8Gm8bSoUeX9K7HPfLPD7YaqlOPGU5mawJ8Qs3TpijlXNDI1mDMaXwBH_gGJzAJJW4CpsDh
 VaoPiI6hmns8SNP48u9B0IPIOJbOzGvVi3V1bWz.hQuDtsIn0jy6OABCl7t5ShvPzcKsUi19mjuW
 GisI1myvV5iwVAio_W3v6N91CZWXI7jp3T0oBmvDw9L.DRfKnxK7S_wZhuNqzvgJaTjfOE8k39kE
 gU.hV518xLKdBECCwCOV.ZLJQlvV9M7dufaigCBvTHzdEpl8JDqi79DRb95fxjsELVSmZX3fyT0O
 HQ6xFqzykyx0ne_5IaR0XlTVsJ8392LXP5llW4w.gTj0fFiLqwUx6uQS4iUS6HaCo7m.3dt1dU48
 3zdu43.3yYOptPhBnR5Pyiidgz79bvhJh79MB.lDqQuTzBC_uaMW78jLiuoQ_aT4kIh4pwI0slOO
 czpyosTFFDjj48d4H5K4KO4D39C7iMttTUBHfXSB1WYxcH83Q9A5x2MDiAvwGHXuYgbA2pwQxX7N
 y9xnYPnX6Cltz7Ws9bZbIBM9nlTdxYv8.jXgsVvZJi6ep_nJhLMte1z3FkO3yysYpXmH.nGNOLQZ
 XFnKLYguTo54NKRG.bQ1XKhJPZVUqggR.2VM8W9CuoyTx2b8BLKpaqy4Bzy4IiSQnNiUrP4g5HZT
 pNFNKEkgvNyVgckZbtzjzwwLhUHPC3q6H0Xh4PUx7AjmePNCxgPqeZQS_Xv.PVjHuNTW4hX.S2yf
 azHhy1WHlZHZAZx69T5iyCy0hLr1JS9h_ODXqRMcjucV6LzMgVhBAhzfwl14uEvCgWO1nScsAMWY
 seahDmaOQ.zIolt7vWJ92fq03zA7uKgtihlL8CvPCnv_1l20qXEA3S6zBsFeBe7dLXiB4i86cg1i
 dFHhB1OmXcXx1g.ntAGpxT0qFtHNBwOnkN4TgfHabokOEDx8uMt6OBFaeA3dR77TdfFyQU12OI8P
 gVHK.nrBk91kcU99_zbwH3lS6drTGl0Gz57ysTybFlKMRqnBv.a9x0vVdz4rXU79dXiVLxdie04A
 pcMMp.tKe1aUEdYlyQlqYiEzJhkytmNlH4HkKMNQVUcQlpfZj1HE-
X-Sonic-MF: <namiltd@yahoo.com>
X-Sonic-ID: dfd437aa-a2be-430d-af91-2298abfa9816
Received: from sonic.gate.mail.ne1.yahoo.com by sonic305.consmr.mail.ne1.yahoo.com with HTTP; Sat, 10 Oct 2026 19:37:49 +0000
Received: by hermes--production-ir2-5dd9bf4598-nf4w7 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 07f6395ff3499c6cf6e6a1a81cc87afc;
          Sat, 10 Oct 2026 19:27:29 +0000 (UTC)
Message-ID: <3dc433ad-f0c4-4679-ad8a-b4676cd7255c@yahoo.com>
Date: Sat, 10 Oct 2026 21:27:26 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 8/8] net: dsa: realtek: rtl8365mb: re-latch the
 family D SerDes
To: kernel test robot <lkp@intel.com>, linusw@kernel.org,
 alsi@bang-olufsen.dk, andrew@lunn.ch, olteanv@gmail.com, kuba@kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 linux@armlinux.org.uk, luizluca@gmail.com, maxime.chevallier@bootlin.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev-bot+sashiko@kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev
References: <7e3518aa-4f99-4aae-bd9b-3984bdc4b548@yahoo.com>
 <202610081722.Zoeli0ix-lkp@intel.com>
Content-Language: pl
From: Mieczyslaw Nalewaj <namiltd@yahoo.com>
In-Reply-To: <202610081722.Zoeli0ix-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.26668 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

Thanks for the review. The issues are valid; I will respin as v3.

pw-bot: cr
