Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4223E403AE6;
	Mon,  3 Aug 2026 15:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785769398; cv=none; b=IbAw1GbDVCyoH4GQlwiQHSIU3yTxuapF0e+YcrY9L6WukG9hQoRw8r5jAvmAwflBk9nb6UIufaA4zNuc8qUt7zfvUiDvZ9UWRINSo+D9gc9kbouFuVNEgfTun6u5X2l/Cgi6q3Mn0xK2qMaMqt1Ejkpn9ujs1rEim/yipkTcpoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785769398; c=relaxed/simple;
	bh=OKYD15RZuqME+W28AvdZLsoUR+IG/F2AQVDx2CdxiZI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qQk8l/EeZjF3rfOYHPL4tV6STojfhSKuJhZPgsQlga1sQG/6ZDejbfDqZABkZSiVDLGdiCUopYOSgNcMIp8h0g535Hj0m8b4EUe2GR9xXfoG1DxJUtt7RUHLRyObyyb+dnN5bV58H/8DkaKM/TeNiB+xGpknYLJAwOJQ+sgpbVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SEPItdHX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SEPItdHX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 292731F000E9;
	Mon,  3 Aug 2026 15:03:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785769395;
	bh=Bv/5UCLd1dIUorgqwAbxHjEFyoaSxIeYFjxIhGJoihM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=SEPItdHXk9NWXbVczWwSggvG5CNVE7BjqtKavfbCyGE9dCarOisk/+OGgF1KedBKM
	 GQ2JRwcJ4RLVfm/jtLLALsAzYqjr8QVy2X3r9H8RrhS+3Ong+Tir8CRf9DWwf/xxu8
	 L3RgEX9rl9XdP1PHV0MsA2OUV6JRuT81Q77LJwonVw0y3ZB+imFT1cmoHlLjR61o3U
	 kcay+9G1LDa+tkgeuk7mcMzyjrlaOjLQVB/KOOFAVbOcAcw0S5WkxHcu7GPv3DpQ8i
	 aouOVkEhkJaF3iXoHwJRq6aLY9bcJVmty8btvnQCn2beuZHkaJxEJNvLPbkfXkRT5q
	 XMkcSvrRczMoQ==
Message-ID: <c6b54353-69f3-428b-be9a-266081564421@kernel.org>
Date: Mon, 3 Aug 2026 17:03:12 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: wan: fsl_ucc_hdlc: allocate enough MURAM for HDLC
 PRAM
To: Matevz Langus <matevz.langus@borea.si>
Cc: Zhao Qiang <qiang.zhao@nxp.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
References: <C736AAC7-5345-4B3B-BA33-299ED9566F65@borea.si>
 <03365777-874e-4e5a-be18-5e546b172db3@kernel.org>
 <066899BE-9B23-4FCC-BBE1-6CB3BC8CD196@borea.si>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <066899BE-9B23-4FCC-BBE1-6CB3BC8CD196@borea.si>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 03/08/2026 à 16:42, Matevz Langus a écrit :
> [Vous ne recevez pas souvent de courriers de matevz.langus@borea.si. Découvrez pourquoi ceci est important à https://aka.ms/LearnAboutSenderIdentification ]
> 
> Yes, this patch is for all devices with QE / QuiccEngine.
> In reality also for CPM based devices like MPC8260 even MPC860 on all cases 256 Bytes should be reserved for PRAM.

Please don't top-post

For MPC8260 I don't know, but but MPC860 it is not right, on MPC860 PRAM 
is fixed and you have another PRAM at offset 0x80 so the SCC PRAM is 128 
bytes max, except when using it for QMC.

Christophe


> 
> 
>> On 3 Aug 2026, at 16:18, Christophe Leroy (CS GROUP) <chleroy@kernel.org> wrote:
>>
>>
>>
>> Le 03/08/2026 à 14:58, Matevz Langus a écrit :
>>> [Vous ne recevez pas souvent de courriers de matevz.langus@borea.si. D?couvrez pourquoi ceci est important ? https://aka.ms/LearnAboutSenderIdentification ]
>>> More MURAM needs to be allocated than just sizeof(struct ucc_hdlc_param).
>>> We have noticed MURAM corruption outside of struct ucc_hdlc_param. It was
>>> caused by QE UCC HDLC microcode. NXP QEIWRM.pdf Rev.9 05/2018 chapter
>>> 14.2.2.1 HDLC Parameter RAM says 0x6c-0x100 Reserved.
>>> Even looking into QE UCC HDLC microcode source code reveals it actually
>>> stores data beyond 0x6c.
>>> Tested on LS1043A, T1040 and MPC8569 boards running UCC in HDLC mode on kernel 6.12.
>>> Signed-off-by: Matevz Langus <matevz.langus@borea.si>
>>
>> Same in MPC8323 reference manual, it is marked "reserved" until offset 0x100
>>
>> Reviewed-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>
>>
>>
>>
>>> ---
>>>   drivers/net/wan/fsl_ucc_hdlc.h | 1 +
>>>   1 file changed, 1 insertion(+)
>>> diff --git a/drivers/net/wan/fsl_ucc_hdlc.h b/drivers/net/wan/fsl_ucc_hdlc.h
>>> index 71d5ad0a7b98..e170d3ac9116 100644
>>> --- a/drivers/net/wan/fsl_ucc_hdlc.h
>>> +++ b/drivers/net/wan/fsl_ucc_hdlc.h
>>> @@ -60,6 +60,7 @@ struct ucc_hdlc_param {
>>>    __be16 haddr4;
>>>    __be16 ts_tmp;
>>>    __be16 tmp_mb;
>>> + __u8 reserved[148];
>>>   };
>>>     struct ucc_hdlc_private {
>>> --  2.34.1
>>
> 

