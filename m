Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1026754781
	for <netdev@vger.kernel.org>; Thu,  6 Aug 2026 15:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786029920; cv=none; b=aK3/JjJt+Rxzei+YLb8fLygkhgcTMrxOG3g4W23Jhsr5zcFr4N+3gB4vGWY534QhE2urNuW1WnZsH9giWqOTBs4W4P0YSz+eFP+bmWidhfKy+Az263dXzYculSm59pfMyWYxL2/gtyAxcAL44Es/MEW2rcfUZjBltwP1TBKqJp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786029920; c=relaxed/simple;
	bh=jfg//PsIpcZEBVyWs8trSXrtL2MxrsKvFIXh0ZGt7UM=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=KgPEi3gxRrhbBAeLEMLjmfGFpfGlEBa4EJ+OrgguWMZFhIPDOUOuIJ5SuWeBDsQw95Cqeu4xbxmxawKvv44WMlgQRySZ5PzwDNjIsw2/miuNBuyfpsRWiec6A6C3+Vf1zOLMEiaDrdfhMd/4KAp+dEUwStRow3aFSR3cM3K2f4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KQaQ1Mg7; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KQaQ1Mg7"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-821106b5b64so21922687b3.1
        for <netdev@vger.kernel.org>; Thu, 06 Aug 2026 08:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786029918; x=1786634718; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=GfbG1Rpbowvh+M7HemGorHD/Gmp98Ye7EdAOCnhIrW8=;
        b=KQaQ1Mg7onhvYas/UIc8RIY4p9NuDuSUKy+FjQnfOsguGk+OhJVAxZaaSEbs+GX1sH
         qVLB1hOt3uEZh1JjPQOR9rKsPGduBg8t+lWnOSGbMiO2csAkTJABPUvS++UOzhA7lfrG
         O4QdndRP0LuV+HY+QpAh5OFAuhblh+OLY2b1Zuqbl0TK+WuVGdjJEH5Pg5prEAoQt3W7
         hi3BgmIq/OGos6BzodtNnhB8VfN8NfqelbeW/OHvyDDmJF3wnAXUvIcOxLmdFwsXfuXN
         c7DSE35EvHp3oHKX6UJoo95fIB07vG2Pv9nnIbZl327izdxhRgq6AQtw1RVyCtsoNx+Z
         hEAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786029918; x=1786634718;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GfbG1Rpbowvh+M7HemGorHD/Gmp98Ye7EdAOCnhIrW8=;
        b=ScPtCQa0CvgZBXid5p/sr40iYntieGACIrROfAuMVbLcRGMancZ37MRmpeV8N1RQyW
         A7yaH+QQO/8uZ6wfVBeyCBqX5wADiA5hwCNZAqNk8sPDr7f6BooFpQxUFyt4Od7pYbjz
         9NVkyPzHrPhf5mQn/P/VoQ9D2k+RF8jDbLosA6XukcyD4lDNX22SnYZj/62AKUGrcim4
         XzxFhhY6ST8ftVgcqNgX1ggruLgprHpHF6pT+Eko/N+kpuhM8gIEi5IDPwtpbRDlXvKB
         jrFRuqAcUsO7OgMu33gZP4A6loV3zKyLQnYhtNK0WLsnaSZi6ybrBXzE12N7USD44s/o
         78Aw==
X-Forwarded-Encrypted: i=1; AHgh+RpbgcJLMp+TT1cRKWPxsgnKmhUgPUcUcZPDczrP1t2uDrAcnCLHYHvKa1fRNW6ytn7HhOVni1E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPG2eTQftTA1qynoHbZ4ZeANWswpr0WexthcpxSLjTN0LABfrY
	VBzA1eDKIEx3VSj2fcD0ZVPMGJaFZBdldR44lfIrogLoNKMkdIvfB+pP
X-Gm-Gg: AR+sD10zSL3Zc7mv/DOSe5Z99LCavp+xMwIO4xy3EOWLF2SJJQyj/FpzIfWna9NJQhe
	bA6jCPdWsC5XSUxm6WrsViuHvhwz2wuBAw+JPbNCPgZbUkclvt/WgH32cZz2wANG8t1ZbawkIKK
	sS9CLRdF0m3xfak1HqQ49oqmws8YSkstLYCAFXw0D5XiPSlhWMKDn+vilhH82kipbR6OvfDWcMK
	fjPKyp9nmHYjwxtnjNPC6EInniq8f3vEUsjkUV3vJMqsAa86jB5ILsfkJ3LptEsUoarotUYwHGU
	mwjIAfOI9oq+3yqKz6BPOFJ0t+msp9EljTjcIsj48OSnT4wMyIbV1zXUkPcZO/jX+BHyxqZMf1O
	Q8G0aWyEk5Z4wyqA9sc842oqwjGJuxLFaIgfxM9hVfRQt4leZ/kfQ+8QZL4Ngm1m6q4xL2pOeYo
	/ElEJvlMxnr7WPrpXCUMYOcx2v41/fxTTbLAZZ28Xs+QhwSKv4rBC3JFxDQBDIW8ahWaE5zl8At
	ud7nF+W2I5BJzniihcQMt1c07Tz3q5bYTwOaHDQWJpONH1K
X-Received: by 2002:a05:690c:6106:b0:820:122b:c3d2 with SMTP id 00721157ae682-8213bf4d2f5mr30764887b3.11.1786029917833;
        Thu, 06 Aug 2026 08:25:17 -0700 (PDT)
Received: from gmail.com (250.4.48.34.bc.googleusercontent.com. [34.48.4.250])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8210f9f94b1sm22099257b3.22.2026.08.06.08.25.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 08:25:17 -0700 (PDT)
Date: Thu, 06 Aug 2026 11:25:16 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Marcin Szycik <marcin.szycik@linux.intel.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 netdev@vger.kernel.org
Cc: intel-wired-lan@lists.osuosl.org, 
 anthony.l.nguyen@intel.com, 
 joshua.a.hay@intel.com, 
 przemyslaw.kitszel@intel.com, 
 Willem de Bruijn <willemb@google.com>
Message-ID: <willemdebruijn.kernel.102a89fcf35b5@gmail.com>
In-Reply-To: <2c551a5e-22f3-42c7-a6ef-daf246e57cc5@linux.intel.com>
References: <20260803210707.1912217-1-willemdebruijn.kernel@gmail.com>
 <3f784e80-69b1-48b4-bc82-a3536363518a@linux.intel.com>
 <willemdebruijn.kernel.35c676937c974@gmail.com>
 <2c551a5e-22f3-42c7-a6ef-daf246e57cc5@linux.intel.com>
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
> On 06/08/2026 16:19, Willem de Bruijn wrote:
> > Marcin Szycik wrote:
> >>
> >>
> >> On 03/08/2026 23:06, Willem de Bruijn wrote:
> >>> From: Willem de Bruijn <willemb@google.com>
> >>>
> >>> idpf_tx_splitq_build_flow_desc performs a 32-bit store to &cmd_dtype
> >>> to set the 8-bit cmd_dtype and zero the adjacent 3-byte timestamp
> >>> field in a single operation.
> >>>
> >>> Descriptors are in little endian. Add missing cpu_to_le32 and cast to
> >>> __le32 to ensure the fields are written correctly also on big endian
> >>> platforms.
> >>>
> >>> Fixes: 1a49cf814fe1 ("idpf: add Tx timestamp flows")
> >>> Signed-off-by: Willem de Bruijn <willemb@google.com>
> >>> Reviewed-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> >>>
> >>> ---
> >>>
> >>> Changes
> >>>   v1 -> v2
> >>>   - add Fixes tag, Tony's Reviewed-by and Cc: intel-wired-lan@lists.osuosl.org
> >>>   v1: https://lore.kernel.org/netdev/20260731103137.4000876-1-willemdebruijn.kernel@gmail.com/
> >>> ---
> >>>  drivers/net/ethernet/intel/idpf/idpf_txrx.c | 2 +-
> >>>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>>
> >>> diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
> >>> index c724d429a7aa..91ca75e45463 100644
> >>> --- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
> >>> +++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
> >>> @@ -2408,7 +2408,7 @@ void idpf_tx_splitq_build_flow_desc(union idpf_tx_flex_desc *desc,
> >>>  				    struct idpf_tx_splitq_params *params,
> >>>  				    u16 td_cmd, u16 size)
> >>>  {
> >>> -	*(u32 *)&desc->flow.qw1.cmd_dtype = (u8)(params->dtype | td_cmd);
> >>> +	*(__le32 *)&desc->flow.qw1.cmd_dtype = cpu_to_le32((u8)(params->dtype | td_cmd));
> >>
> >> While it technically works, I find it unreadable. Looking at this line
> >> without reading commit msg, it looks like a bug where a 4-byte value is
> >> written to u8 field. The intent to zero an adjacent, unrelated field is
> >> not clear. Consider assigning these 4 fields manually, or adding a
> >> comment/function doc.
> > 
> > This is a bug fix, which generally should be the smallest surgical
> > change only.
> 
> Agreed.
> > That said, I do agree on the style, and a follow-up for net-next will
> > clean that up too:
> > 
> > 	@@ -2408,7 +2410,12 @@ void idpf_tx_splitq_build_flow_desc(union idpf_tx_flex_desc *desc,
> > 					    struct idpf_tx_splitq_params *params,
> > 					    u16 td_cmd, u16 size)
> > 	 {
> > 	-       *(__le32 *)&desc->flow.qw1.cmd_dtype = cpu_to_le32((u8)(params->dtype | td_cmd));
> > 	+       desc->flow.qw1.cmd_dtype = (u8)(params->dtype | td_cmd);
> > 	+
> > 	+       desc->flow.qw1.ts[0] = params->offload.desc_ts[0];
> > 	+       desc->flow.qw1.ts[1] = params->offload.desc_ts[1];
> > 	+       desc->flow.qw1.ts[2] = params->offload.desc_ts[2];
> > 
> > The fix is queued. If there is consensus, I can respin. But given that
> > we will clean this up in net-next properly, my preference is to keep
> > the minimal fix as is.
> 
> I'm fine with this.

Great.

> Was the cleanup patch already posted to next?

Not yet. I'll try to send the series later today.

It will have a (trivial) conflict with this line. But I will likely
need to respin again, so don't want t wait for that (and the merge
window).
