Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E95C42900D;
	Mon,  3 Aug 2026 14:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785766741; cv=none; b=m4LGPz7RCqpHByw7ss+UB76ufI9OmdhvhqE8kefCRhUs3nEzGVo7ZosdhZy2mHkLCRd3JB0ila+3hHLqZ7990DwV2ZQPaG6tHl9QzhuJqpMk98/WkQzWMv1swCGQlt31PqPPpdt83HtRCwJdVW5VWfx/NRuG4+5VXdJdWu3+YCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785766741; c=relaxed/simple;
	bh=QsHaBt9CHpN4CpE6cpkpmo+R/TG+1hfbOMk5ZxBrfg8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BR0Qm/2IwMGPkcasmdActsphocygvf7xg4ZbSKNSdiSjWAtvSHiqRqVdcVM4HGicc3Oo6aR2LnQ0dx3vBxcoahIraEvaEg92FAwkOHZvrHUrxcoE3K6zKIIyp1Fnp+pa4Hs0rq7wQ8KQ8HIHDP0EoRy1AoXUCh2fv1gEUPLCycM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rb2TRENc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rb2TRENc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 241881F00A3A;
	Mon,  3 Aug 2026 14:18:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785766739;
	bh=3CLc1MsJX3Lsgw3cqMX2Uw6ELDbd/XqWG95uUZWwPUk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Rb2TRENc96jhuEQ8lZxsyZZex9onDfrJnhwNAHZGmTRM1pU2na0+0u81YVBNMlTiq
	 75Xe54TuemtQdnU1HnPD5dbQKKDFeYdd0/kzZ70b7+9mmb5QREUPFBPcY1rs5HqGyY
	 4zubGc7k63IMVqYxUNp4WcppOdSQ58VOM1tRHNdfT2GSQZ0AqZOxsiE8CcDxlMf5gX
	 zOQfGB5iB4AtABj9ihZpRco1EH6ElpVgvQCK1vtqRtpZp/NknJmcx22vc86m+mH+/Q
	 zZQNUrBmsrvI9saX1E8el6dbhMLMQEZHaqoKUT/VKN3BIfI/2+UW7P+fEKxgp0dA/8
	 ZSWAzgUpDz9Jw==
Message-ID: <03365777-874e-4e5a-be18-5e546b172db3@kernel.org>
Date: Mon, 3 Aug 2026 16:18:56 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: wan: fsl_ucc_hdlc: allocate enough MURAM for HDLC
 PRAM
To: Matevz Langus <matevz.langus@borea.si>, Zhao Qiang <qiang.zhao@nxp.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
References: <C736AAC7-5345-4B3B-BA33-299ED9566F65@borea.si>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <C736AAC7-5345-4B3B-BA33-299ED9566F65@borea.si>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 03/08/2026 à 14:58, Matevz Langus a écrit :
> [Vous ne recevez pas souvent de courriers de matevz.langus@borea.si. D?couvrez pourquoi ceci est important ? https://aka.ms/LearnAboutSenderIdentification ]
> 
> More MURAM needs to be allocated than just sizeof(struct ucc_hdlc_param).
> We have noticed MURAM corruption outside of struct ucc_hdlc_param. It was
> caused by QE UCC HDLC microcode. NXP QEIWRM.pdf Rev.9 05/2018 chapter
> 14.2.2.1 HDLC Parameter RAM says 0x6c-0x100 Reserved.
> Even looking into QE UCC HDLC microcode source code reveals it actually
> stores data beyond 0x6c.
> 
> Tested on LS1043A, T1040 and MPC8569 boards running UCC in HDLC mode on kernel 6.12.
> 
> Signed-off-by: Matevz Langus <matevz.langus@borea.si>

Same in MPC8323 reference manual, it is marked "reserved" until offset 0x100

Reviewed-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>



> ---
>   drivers/net/wan/fsl_ucc_hdlc.h | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/net/wan/fsl_ucc_hdlc.h b/drivers/net/wan/fsl_ucc_hdlc.h
> index 71d5ad0a7b98..e170d3ac9116 100644
> --- a/drivers/net/wan/fsl_ucc_hdlc.h
> +++ b/drivers/net/wan/fsl_ucc_hdlc.h
> @@ -60,6 +60,7 @@ struct ucc_hdlc_param {
>    __be16 haddr4;
>    __be16 ts_tmp;
>    __be16 tmp_mb;
> + __u8 reserved[148];
>   };
>     struct ucc_hdlc_private {
> --  2.34.1
> 
> 

