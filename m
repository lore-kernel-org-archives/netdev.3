Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=66.163.184.147
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793749308;
	b=3QxOpOqz+9NFECP0tTFPo4YUg4lkiQaei1ghZgFGhVoJrf+LApepcFyyCEJ1bB6K9oPR
	 5UcZWmgx/jGKU+gW4E/ql1AkTmQLD9EGJAF2c2LpjWHc0CzajD0GbLIxhWjNEh+96z+V2
	 rPiq/R0Yli1PsD8tq83P5Lk74FDztglkv4OrcEihiasMAGC+W/StqW9r78a0OORitfJaC
	 XyEhy5vvSZVN+Q1ANbB6yrHSd2vkdC0Jz7rtIiSqFqc0qgLOEcQuvssb1D1Nj4QSKBqC+
	 r4Q1ZOOvzQhkocuFCpf5wZYEZu2ywAuYL/jNKtBezRoajwj2mu6ykuDXLFP9QBtOYCg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793749308;
	h=DMARC-Filter:DKIM-Signature:X-SONIC-DKIM-SIGN:X-YMail-OSG:X-Sonic-MF:
	 X-Sonic-ID:Received:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Mailer;
	bh=O6sdXePEGQnCUklksv2f3AL3E61fXpQ8dART8Ftimg8=;
	b=hwp/LqKOxV/Iw6y9ieUpMabOfouoAHuOgiiQG5hK/6LO4LvUOGOmjJOosasvlIBIhBxa
	 BkNMlaVPjSKGbtog8yjlEENtYD2miUgXKTE286PnjivCT/ZQNL9bWAgNK/pKaSWmWHFnG
	 NDJ4GiPlgl9vxNvkpOl1427SFh+Cuu1OQzDrP2DLTyKuvbMsI0lYpMQMiS7h2C0HsEsVI
	 H5n34TrK4LXGekdRGmbot2Fg/34drTf/tGyslY2BLJZqXvf+49Z+ISNLQaFDYwF3gSuC6
	 xNztZEzZ/v2ECXqvvLd0OMlw190NzSFA7+har9uAbWBjjsxMXDeykPgSr8cDReJsReA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=yahoo.com;
	spf=pass smtp.mailfrom=yahoo.com;
	dkim=pass header.d=yahoo.com header.i=@yahoo.com header.a=rsa-sha256 header.s=s2048 header.b=JoZmsgyc;
	arc=none smtp.remote-ip=66.163.184.147
Received: from sonic309-21.consmr.mail.ne1.yahoo.com (sonic309-21.consmr.mail.ne1.yahoo.com [66.163.184.147])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0B2E606A31B
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 23:41:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A0B2E606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=yahoo.com header.i=@yahoo.com header.a=rsa-sha256 header.s=s2048 header.b=JoZmsgyc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1793749306; bh=O6sdXePEGQnCUklksv2f3AL3E61fXpQ8dART8Ftimg8=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=JoZmsgycoO8HAJv8AN/Q7ho0Su6Gh7Tj/kZ7NMTFPL1TU7W691e0XPFnA3DXvkhEiBlcogtuERL0uJavhz5WDxVhwBBnCbYg9cxLlA62Ex5TDKhLf9awu+tC3H0hs6rUtpoUgP9fq6gWLUrZ98OKl6OSG0gAqLgwMxYCFf3SqNthUo8ri4aCovl4aNKBa7bTlrriBo/0agFtD58cOYUx6rIsyTMKK7Z0ycaQQBcOmbyRxn2Kyea0zugphACHDZmbujgIMOmVS5iCCD/RxymfPGkJNKWmk8G7pkvbRc0qFgeSAtFsccus/YJzYzgWL3z/PcV2S8fP1Iqi6W6qP40gvg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1793749306; bh=Fy2ozdKrh9FmRwvnVMyzhD97JBrR7GoS4h7bfoi3fjh=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=AwO74z0jrXxK41IgiUkC0CdyTF65NxDMVX+9pAaImYcbc9fDhDiQLS73iXH5sINtmzxwHl5tU9xWkLYGD1ELQ2CnjHa8Ws8FlSPU84m9GK9tolcFlDyv5NyFSatWZ9ZT4OaqrO1IWQHszLILEQPg+TnquMbOBL+3wuvVm20QDeCE1RUVOvIOTLqli0JhZhG8lCK0BZCMvTd4WF8G29kwd+hGIKL1VDbHo6eVHT2/mjLsCoiJjORv0vvxMUx8tnNXmR4ReMLI5tlUwY60i3gqLiAcQkcySVLVEEIkv+8RLR2W3FlXeCgWXKhPzA9JiDLY6zdHCXnOWzJ1v8FY+OKLJg==
X-YMail-OSG: 4uCNa08VM1n.s3bofF.YJlLGcKzw95KEQwPgFm3AjaV.0nRk5X961CHzUtXGyxf
 ezAe8pCG2iFX5NFkx8.W3OcEKJLw38MHc.KBJ_hlPkP5uGSyADKK0tsQTt7FQuwrWaSC1W5DJhyg
 S2BeObiRUphXHbfDKnJHGejfWupgjifSSzGgW.ovSr.kicAxDU8aSlNQhZwtk1WA_RLy6SS2a4Ve
 HzI87aNizp_pjhjspV1Kc7dWxuHlkkYWTMr437Ji31knJKnpVkhCJDSTzpmDf8kZ4wl2OtJmLbCH
 enpgPypxh77JQw9PGbk8wEKmd.mY6CmzcFzVlPs_GGE.EZI.xvoZm5gG9m1R46VRt5eIqXXJYhmV
 AoZpFh2avIvHPx55vDgACPhVkyQH3d1D.Q22EV3PVQOkJmcvsxos9b7r20JsGxMI1TosYXzBGkWC
 H59dc2MvLmdU8X5pCOoGEMaS3lfBSxq6VsEguJYYHLVnZGEGfwLMgHA1Cof4Jc4PxSsPsDupFSpz
 7T5fQQNZlu9jmcM3Z9L42luIkPI5sUpDLgLlSzMWtDiuzcIZ.DenNy_7ua5AgxnCFtiCwqenY7pt
 n1jiwCN9C9K_52hDz1q_3Ac8XwJl0jaFoBbhN9GCQCD4Vkv5nXooxWX4jedsThvz11En8dXIOEaW
 Xqk6BBGQCI5S9LF_MPlsbN7xKGcPSKdfgsnIBaiet5poh8Y6RgEa79_6cmwBluvLNsNBpGSQioho
 CfRUg72i71OesTKRAhyhoHHRtAJMYk.4902BVPC1UW5zKMF5LsJ2elkmpNivqHchpQY6UeHjA.NJ
 DQbtAk2r3WNJV_tYmc.tT7OPYUxCf5Vz0swx6qfCxM02iwbMLb_9brpgzgumwLn77fqfFaBlhsyc
 dVuVHJOlKA4fhLnFWGadqCvY9w8JRn6LOXCWwA76E_NAiKrdRR1gpg7aTODFt.pUVhKrvXqIO8Id
 MSJx2_DJ8CL85QKIYEKrhA8uQS4GEOK8I1DRyHaBXQArP5ckh.nYZBqPxqEQZ_VBnqIjafXTfb6b
 kHbtmvQj2T0Qu5KGTNzOwIym5DUwugBiB0PSw4amkIIKQYnb2YLEijSuLakX6XSWwh0SsbRJ9c0S
 l.Nn02ayEj5LsQuiWG6fq1n4d3eX70u0MJtn_7TPvEmb.0gEIf.AjlAbxS41fVV_6SoSeeLsdjQF
 Ff99R0hnpiPALYLPKDhtzFzTNd2N5teLLuCeajzMsekDFl.rJOUb9zKePgZ0kj5nmsDqvW524n7n
 THjeStfmWvryRs6s4NGTS1nEinpm0gJhcGenfNkce.x.S._UtzhE0k9xuMQbtIz418EiYVauI5LS
 TFWk2g6YJfXYA13vehuL4T7bUIKVbs21LaWSeBc8Sgl4hDDTkVa543LYb90N29eiQiQhy0w.A14O
 xmsPy8bcoShsN7R0R_7s7kaw6bB0MXswHd3JJ2miOT10IeaAZ4ns0A0L.P.BKOcE8pMRix_rerBF
 8K.MPzkCHs.hxVSMFmDLq56jjz6wHKM_6553AYrVcjNyc8hTPxphq73xSHjfZke9Nt3lbyQ0mCbo
 1CxoYgMuqWPNbX58Vqt3SQgACtF_2Uk.pTUxWC4EuQjcOltiTsFhna3zSBOb4dvlkHWlaNr5Vh53
 03VVqbmhXF9YnRfzaVgvu6cVGvPztwY8eMEYrGDEf_J3CZta0DB2n_XYCUtyOWUCiCXtC3ZK3JjD
 khhs.EvzwJbe1G9pFMMxLA1J9fbSCnCZmTvU9fSNLCiSZC_WPzH.fFI4PgSTrprGfeYxTlSE2mjX
 1Sxz7a6QjF0vajbV4YvunvYZEnjGZPlK7Dk0lAFAEIgLeLU7rXUhHgrj.2Lz02YzrvmP7ZiAL7hX
 JfYMb1H59Q0mNpCW_IgQjhqogvxtnaedY8oesCk597F.rnOwQREdFfTqvaLUTJW_pyRTlNAEBpO2
 PTQ7BUmJ4CBLUXU7xjkgKX66siEhLN408IIGRHeBNNCPGsppuZrMp7nIGyYcPjkXpNIghn8LXzZH
 3ah3BQzxgWOiUPF4Vu7nyPc_s3bkmOBe4CUa7c2VKXRYAyRDAp7T_FevX3SQc4Nj9brwVUMfTt_w
 OR.P90IoysHHj.e35BkfdZLcqzKTt_xtC6fBMmgnY4mAWTVb1.JqpL1qQLexDwHBLhk5n8MmwnIK
 yEHH2CIuhZG3X4iTJH6c7pKTreGKis0tebXNNg_bYizJLkgAzg8FszaR4wsdpmJnUlBF.LWroWI7
 VlSN7vEovF3XOx2Tha_.l8rXjyFmKgyXTvk1mg49WtLutZi7dLocSmW1J7U54cKpe2tnoJOEXlJJ
 P7w2uAGo0cwfTgvskdBXcTPJ20kz7dbBnS9pjT5H44quSJqrXEm0-
X-Sonic-MF: <namiltd@yahoo.com>
X-Sonic-ID: 5b17de1b-df8a-42e1-bded-2a3c818cefe7
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.ne1.yahoo.com with HTTP; Tue, 3 Nov 2026 23:41:46 +0000
Received: by hermes--production-ir2-5dd9bf4598-lsjm6 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 07fe932f9edb1c7406d42f3371a6c20c;
          Tue, 03 Nov 2026 23:41:43 +0000 (UTC)
Message-ID: <6c6155f0-0431-4ef9-8067-dbc104af710e@yahoo.com>
Date: Wed, 4 Nov 2026 00:41:40 +0100
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
Subject: Re: [PATCH net-next v7 10/10] net: dsa: realtek: rtl8365mb: add
 support for RTL8367S-VB
To: =?UTF-8?Q?Alvin_=C5=A0ipraga?= <alvin.sipraga@analog.com>
Cc: linusw@kernel.org, andrew@lunn.ch, olteanv@gmail.com, kuba@kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 linux@armlinux.org.uk, luizluca@gmail.com, maxime.chevallier@bootlin.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <3bf4dd70-9771-497b-8c27-e925e0ef81eb@yahoo.com>
 <c7f88f0e-b174-4715-b148-5f9a2648bc2f@yahoo.com>
 <auph2uJLrJ6Nj0dh@analog.com>
Content-Language: pl
From: Mieczyslaw Nalewaj <namiltd@yahoo.com>
In-Reply-To: <auph2uJLrJ6Nj0dh@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.26871 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On Tue, Nov 03, 2026 at 11:52:24PM +0100, Alvin Šipraga wrote:
> Hi Mieczyslaw,
>
> First of all, apologies for such a late review! I hope you appreciate
> the feedback anyways.

Hi Alvin,

Thanks for the review, no need to apologise. Your comments crossed
with the v8 I had just sent, so they are not included there. I will
address them in v9.

> This is OK, but in the same spirit as my comment to your other patch, I
> think we want to make the C and D families equal. So why not:
>
> -#define RTL8365MB_MAX_NUM_PORTS	11
> +#define RTL8365MB_C_MAX_NUM_PORTS	11
> +#define RTL8365MB_D_MAX_NUM_PORTS	8
>
> and add a num_ports member to struct rtl8365mb_chip_info. Then below:
[...]
> The above becomes something like
>
> priv->num_ports = mb->chip_info->num_ports;

Agreed. In v9 I'll rename the constants as you suggest, add num_ports
to struct rtl8365mb_chip_info and use it in rtl8365mb_detect().

> Another thing I noticed in the L2 patch was that you added a macro:
>
> #define RTL8365MB_D_L2_MAX_PORT 7
[...]
> Which I wonder, can you even get there if the num_ports is 8? We didn't
> need that protection for family C. I think you can drop the macro and
> this check.

Right, with num_ports capped at 8 the core never passes a port above 7,
same as on family C. I'll drop the macro and the related checks in v9.

> The reason I'm saying this is that I saw quite a few places where you
> have a construct of the form:
>
> if (family is d)
>   // use family d constant
> else
>   // use family c constant
>
> Which can become a bit hard to follow/maintain.
[...]
> I hope it's possible to remove most of the if (family is x) { do
> something } constructs and keep things flat.

Understood. I'll wait for the rest of your comments on v8 and then
move per-family constants into chip_info where it makes sense, rather
than branching in the code.

Thanks,
Mieczyslaw
