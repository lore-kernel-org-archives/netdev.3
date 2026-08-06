Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58A44447807
	for <netdev@vger.kernel.org>; Thu,  6 Aug 2026 14:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786025970; cv=none; b=Rem4Q9J7ZjUunof3mV3Hg+H3TuyznSpsgol7KtAgfVb0gevR2nmUDfmUf7ZdvTJnif1iVcbLhUhrwGPua7sPXQ+0wfU+Gc+isW0ce1euhnSaKmY5mk70K4ddVidgWvdx9EMOmPIB/JQnRBsa6b8//5xf56pQEnPkUke99H/psLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786025970; c=relaxed/simple;
	bh=xpRqP2c7EJnhpN8Mlu1HVYnvpqp//uKS0gcxBIHj8d0=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=imQg2mulHwzthAVemvpcuh0nQQdQJ+LgOw9LpUmBnavFniczls8t3VFhlykxYjeegcAddZ6YkHDlXKPXFjBD78hbym0KsnNsrZTi3Xugq0y/8/Uk/Kuhn8VBQe7PEG1eOTrIGaV0Mncg8SP7wGBxZVY/RmAYGMUbxsxPkeBdVYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A6dutck7; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A6dutck7"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-81f3b227a4aso36296827b3.1
        for <netdev@vger.kernel.org>; Thu, 06 Aug 2026 07:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786025968; x=1786630768; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=U6AiC35sShnPlOFQ9Pp15i1soMotoG1ABTLtkAnLaiY=;
        b=A6dutck7rTajjb0c1+2feW4KwKiYbYOTxXgpYdEzvhJFY2jYVnml1O4Ac0lYwDvaG8
         JQTWUT6iJruJmmXE69HGju4Kt658cvdlLZgbmgVRCdS+I1M0s10njBhXbMp02wxtOeyr
         JE8O9T2Rbs6TpenXZsfvNN616uXZuVvO4/zVWji+37UnnlPNH58DII5tKaClXzK2ihup
         Db/iPSNUbmsbG4PbST0AIPc1NGnN6Be4+H2RttFmLxAPdpSMVwmkdFDsOxSChfSEw3Zm
         5sVC6Ydit2Xdlo9iO7uKrp3llSy6IjFq/pf1DnmNU5FpfsNfTxuGlFuAvV5fKnplXAHt
         scSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786025968; x=1786630768;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=U6AiC35sShnPlOFQ9Pp15i1soMotoG1ABTLtkAnLaiY=;
        b=tG34DyHikvfAS4rE3h99f5ttSUH1Uq3j4ctAOPwu+lG3DKvTl6fx4FYFVQ1snYPLIw
         7tzPSRYe+RBeMmPOC+gMLaDqFzOXtrUWENNGJ2iKQafjhmDDvVFybPkCEa+IfHFlz2+w
         69q8m+OFPoqS1ts7OM4ajhGe1CQOVjWKW1CXwNj4Ehhq34Go8p5tyAQGFW7MRplmASi7
         1pAJAJ3ZRLWQvDjXrwoj8E3DxrOazPguNN3rfKr4wo/yG5Ot4flQZUrYluSoZOEALRa7
         18mIBcwRoOpMREGgd9KtaBj7pUGFGmFUY5B21fMjb5UG8G3EdwZDS/OlTMLmVS8ZUCs9
         dpyQ==
X-Forwarded-Encrypted: i=1; AHgh+RpvaBUMRbVq9WEP9VlnQfG9RFQYAVOuMspi39SdxW5aPdAoOqpCsdaZXHMGJujIlo8YLTkwavk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyF3bdAdOu624BOPd/qHD7awztX4mlPt4Hy3B9lS7+KKUYm/lme
	8l0qMb7HSHodQGL1jrP22ngNuxLJltM8GlFQ71wDdrrlxhsQrPISMqBC
X-Gm-Gg: AR+sD13ncaMcPdwTELVaAGVQ7T06L7azgl+fq2PdV4Wz2z3u1aeOoEYixz9qCzStyFW
	64o9QOYUUnWE11ZEAt+tKwKygwlvZXcHQHzoCdch2UcjKS4VWcSfueFneAiIKAbPm4m48lI9ghn
	yAhm8M3kASg1w0g2btU5Z46MlJRztcLMYXlrNNblBN5X1b0rmDuK4Rm5say6E0kPecBiTh8QrxY
	gJbCrXo+Ll2Etj2OpNS4P6qVk28oKc7v2CqoF/XZ6VxjDkKBJZKVi08E8DIynzuLGbX+QnI2vA9
	MdIH1DnOOoc2kkHhCU71kEZPOmvAGfapsHIfT/3xji/LtuE97tLc0rom458KWPq/IKmWgDpAm1f
	rNHAAsx8czltjSJdC+qXuOZkLab+tWlESHd8nBPI2bqFLJdQopoqKqFevpLjVYNw8SiscbNUMEM
	gQ5DNeU/RnXwhMiuxX4XREtRXZA6iQn5/NFAqCCk+DPhsakcPqzWR2EAgCSlHLLfz7gjXZ2Rp8G
	O3XiuY7APrBBoZDnmWOlVE3GRmPGoqwTJoB
X-Received: by 2002:a05:690c:498e:b0:81e:6cd1:5322 with SMTP id 00721157ae682-820224a7cc1mr93970097b3.20.1786025968063;
        Thu, 06 Aug 2026 07:19:28 -0700 (PDT)
Received: from gmail.com (250.4.48.34.bc.googleusercontent.com. [34.48.4.250])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-820134d8ed2sm40002997b3.45.2026.08.06.07.19.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 07:19:27 -0700 (PDT)
Date: Thu, 06 Aug 2026 10:19:26 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Marcin Szycik <marcin.szycik@linux.intel.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 netdev@vger.kernel.org
Cc: intel-wired-lan@lists.osuosl.org, 
 anthony.l.nguyen@intel.com, 
 joshua.a.hay@intel.com, 
 przemyslaw.kitszel@intel.com, 
 Willem de Bruijn <willemb@google.com>
Message-ID: <willemdebruijn.kernel.35c676937c974@gmail.com>
In-Reply-To: <3f784e80-69b1-48b4-bc82-a3536363518a@linux.intel.com>
References: <20260803210707.1912217-1-willemdebruijn.kernel@gmail.com>
 <3f784e80-69b1-48b4-bc82-a3536363518a@linux.intel.com>
Subject: Re: [Intel-wired-lan] [PATCH iwl-net v2] idpf: add missing
 cpu_to_le32 in idpf_tx_splitq_build_flow_desc
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Marcin Szycik wrote:
> 
> 
> On 03/08/2026 23:06, Willem de Bruijn wrote:
> > From: Willem de Bruijn <willemb@google.com>
> > 
> > idpf_tx_splitq_build_flow_desc performs a 32-bit store to &cmd_dtype
> > to set the 8-bit cmd_dtype and zero the adjacent 3-byte timestamp
> > field in a single operation.
> > 
> > Descriptors are in little endian. Add missing cpu_to_le32 and cast to
> > __le32 to ensure the fields are written correctly also on big endian
> > platforms.
> > 
> > Fixes: 1a49cf814fe1 ("idpf: add Tx timestamp flows")
> > Signed-off-by: Willem de Bruijn <willemb@google.com>
> > Reviewed-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> > 
> > ---
> > 
> > Changes
> >   v1 -> v2
> >   - add Fixes tag, Tony's Reviewed-by and Cc: intel-wired-lan@lists.osuosl.org
> >   v1: https://lore.kernel.org/netdev/20260731103137.4000876-1-willemdebruijn.kernel@gmail.com/
> > ---
> >  drivers/net/ethernet/intel/idpf/idpf_txrx.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
> > index c724d429a7aa..91ca75e45463 100644
> > --- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
> > +++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
> > @@ -2408,7 +2408,7 @@ void idpf_tx_splitq_build_flow_desc(union idpf_tx_flex_desc *desc,
> >  				    struct idpf_tx_splitq_params *params,
> >  				    u16 td_cmd, u16 size)
> >  {
> > -	*(u32 *)&desc->flow.qw1.cmd_dtype = (u8)(params->dtype | td_cmd);
> > +	*(__le32 *)&desc->flow.qw1.cmd_dtype = cpu_to_le32((u8)(params->dtype | td_cmd));
> 
> While it technically works, I find it unreadable. Looking at this line
> without reading commit msg, it looks like a bug where a 4-byte value is
> written to u8 field. The intent to zero an adjacent, unrelated field is
> not clear. Consider assigning these 4 fields manually, or adding a
> comment/function doc.

This is a bug fix, which generally should be the smallest surgical
change only.

That said, I do agree on the style, and a follow-up for net-next will
clean that up too:

	@@ -2408,7 +2410,12 @@ void idpf_tx_splitq_build_flow_desc(union idpf_tx_flex_desc *desc,
					    struct idpf_tx_splitq_params *params,
					    u16 td_cmd, u16 size)
	 {
	-       *(__le32 *)&desc->flow.qw1.cmd_dtype = cpu_to_le32((u8)(params->dtype | td_cmd));
	+       desc->flow.qw1.cmd_dtype = (u8)(params->dtype | td_cmd);
	+
	+       desc->flow.qw1.ts[0] = params->offload.desc_ts[0];
	+       desc->flow.qw1.ts[1] = params->offload.desc_ts[1];
	+       desc->flow.qw1.ts[2] = params->offload.desc_ts[2];

The fix is queued. If there is consensus, I can respin. But given that
we will clean this up in net-next properly, my preference is to keep
the minimal fix as is.
