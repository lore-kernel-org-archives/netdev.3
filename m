Received: from ris.borea.si (ris.borea.si [193.77.156.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D4C6415F30
	for <netdev@vger.kernel.org>; Mon,  3 Aug 2026 14:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.77.156.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785768176; cv=none; b=CneEyQBr0NbH2RA3tQs9jxRotoMV50hTB6nk9HZuE2COjzu6X14O+MibJjrjXfnMYyUNsUWDgCQR4LszCHXEaWUcOfPrY6Anl8kM5Vio5+1jJDMxFOREfxoHrPh6xgycoY80BGdXd0AKJqP9j3CK/kyG+Exx/RI+2XicITTFlTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785768176; c=relaxed/simple;
	bh=hDZ+H8ZG3HNWKm1FTcB2IO1zuohXLz2NLnLM/E0lY8M=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=Dx6oax6TK7rhGh6JN48QFrb1g/uVI4LEMVBzJnLfyfV8BjrQfg21HyE0LK56AbuhXCTEGt0iPkv2OivoF8dww6j3VomTPAbr5zuoJ9aTujLzkRn9oQpODpUxV5G20fc5sN24X0AU/3vGZTGN0DXvNVtsz/RHfwsJotjzQvFJMXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=borea.si; spf=pass smtp.mailfrom=borea.si; dkim=pass (1024-bit key) header.d=borea.si header.i=@borea.si header.b=rlK9T1qx; arc=none smtp.client-ip=193.77.156.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=borea.si
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=borea.si
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=borea.si header.i=@borea.si header.b="rlK9T1qx"
Received: from ris.borea.si (ris.borea.si [127.0.0.1])
	by ris.borea.si (Postfix) with ESMTP id 4hDKCb1tQWz1t6
	for <netdev@vger.kernel.org>; Mon,  3 Aug 2026 16:42:51 +0200 (CEST)
Authentication-Results: ris.borea.si (amavisd-new); dkim=pass (1024-bit key)
	reason="pass (just generated, assumed good)" header.d=borea.si
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=borea.si; h=
	x-mailer:to:references:message-id:content-transfer-encoding:date
	:date:in-reply-to:from:from:subject:subject:mime-version
	:content-type:content-type; s=dkim; t=1785768168; x=1788360169;
	 bh=H2Vt4IlI3KMxVE8qBCDtjC+d1qIw883LCHhrBpB3u3E=; b=rlK9T1qxSQ+H
	n0oWcp1Tt8EGjV7bKrSp+jCPwLif9NN5Ht9AEzt9ipsLE015h1Gun0MsRyeP6DA/
	W/xwWNMvziJeLdVRSdsB49artUbHOWzmUhTf56/x6RIlaB7RWzTPcOrlGh1L0z2j
	j0ArBH8KEinZEq9H3KItT4nfSLyFkOc=
X-Virus-Scanned: Debian amavisd-new at ris.borea.si
Received: from ris.borea.si ([127.0.0.1])
	by ris.borea.si (ris.borea.si [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id ZeE12RCr-Xno for <netdev@vger.kernel.org>;
	Mon,  3 Aug 2026 16:42:48 +0200 (CEST)
Received: from smtpclient.apple (unknown [IPv6:2a00:ee2:a80:0:880f:f393:d837:b93f])
	by ris.borea.si (Postfix) with ESMTPSA id 4hDKCW6rqKzNQ;
	Mon,  3 Aug 2026 16:42:47 +0200 (CEST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.600.51.1.1\))
Subject: Re: [PATCH] net: wan: fsl_ucc_hdlc: allocate enough MURAM for HDLC
 PRAM
From: Matevz Langus <matevz.langus@borea.si>
In-Reply-To: <03365777-874e-4e5a-be18-5e546b172db3@kernel.org>
Date: Mon, 3 Aug 2026 16:42:37 +0200
Cc: Zhao Qiang <qiang.zhao@nxp.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <066899BE-9B23-4FCC-BBE1-6CB3BC8CD196@borea.si>
References: <C736AAC7-5345-4B3B-BA33-299ED9566F65@borea.si>
 <03365777-874e-4e5a-be18-5e546b172db3@kernel.org>
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
X-Mailer: Apple Mail (2.3864.600.51.1.1)

Yes, this patch is for all devices with QE / QuiccEngine.
In reality also for CPM based devices like MPC8260 even MPC860 on all =
cases 256 Bytes should be reserved for PRAM.


> On 3 Aug 2026, at 16:18, Christophe Leroy (CS GROUP) =
<chleroy@kernel.org> wrote:
>=20
>=20
>=20
> Le 03/08/2026 =C3=A0 14:58, Matevz Langus a =C3=A9crit :
>> [Vous ne recevez pas souvent de courriers de matevz.langus@borea.si. =
D?couvrez pourquoi ceci est important ? =
https://aka.ms/LearnAboutSenderIdentification ]
>> More MURAM needs to be allocated than just sizeof(struct =
ucc_hdlc_param).
>> We have noticed MURAM corruption outside of struct ucc_hdlc_param. It =
was
>> caused by QE UCC HDLC microcode. NXP QEIWRM.pdf Rev.9 05/2018 chapter
>> 14.2.2.1 HDLC Parameter RAM says 0x6c-0x100 Reserved.
>> Even looking into QE UCC HDLC microcode source code reveals it =
actually
>> stores data beyond 0x6c.
>> Tested on LS1043A, T1040 and MPC8569 boards running UCC in HDLC mode =
on kernel 6.12.
>> Signed-off-by: Matevz Langus <matevz.langus@borea.si>
>=20
> Same in MPC8323 reference manual, it is marked "reserved" until offset =
0x100
>=20
> Reviewed-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>
>=20
>=20
>=20
>> ---
>>  drivers/net/wan/fsl_ucc_hdlc.h | 1 +
>>  1 file changed, 1 insertion(+)
>> diff --git a/drivers/net/wan/fsl_ucc_hdlc.h =
b/drivers/net/wan/fsl_ucc_hdlc.h
>> index 71d5ad0a7b98..e170d3ac9116 100644
>> --- a/drivers/net/wan/fsl_ucc_hdlc.h
>> +++ b/drivers/net/wan/fsl_ucc_hdlc.h
>> @@ -60,6 +60,7 @@ struct ucc_hdlc_param {
>>   __be16 haddr4;
>>   __be16 ts_tmp;
>>   __be16 tmp_mb;
>> + __u8 reserved[148];
>>  };
>>    struct ucc_hdlc_private {
>> --  2.34.1
>=20

