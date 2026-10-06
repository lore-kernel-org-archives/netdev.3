Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E38445563B
	for <netdev@vger.kernel.org>; Tue,  6 Oct 2026 13:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791292962; cv=pass; b=W0rKcgxgZF1uYLPOttDlgI0gsaZ60XhoWzlO7/8ynne24bDVEd2NDSF/7XH7RmTHV8bw/1SEkiN0k7zgJPWRP4lABvhnQQ+fsQLq7243HOmwTpIEtfyvXSFDeJnsIjm+NQjhlvbjyImvBfWDOK/00cl+q5CVDXG5kWjUhuBwY0s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791292962; c=relaxed/simple;
	bh=2/kY6gI5Yk1xMI1SVYXumnXuSjxWIMRSCwqdkzoU3Bw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LO34CgLmffrdWtMCUobhVp/BOL/IIbpNbzmA7xliUiXrg3e5MWKzlzN+2HPEkBZkb0DuHIW06ghupKSjkSp5lLaM+sq85mn8swJ/MbJ2xHkXhWyiSIbb6eo/r1C+pevFl1Aorcr6x4Lr6V7i3x0mhkeWV4Wa2cvH5G46z5vlj/s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sairon.cz; spf=pass smtp.mailfrom=sairon.cz; dkim=pass (2048-bit key) header.d=sairon.cz header.i=@sairon.cz header.b=C3bDStSH; arc=pass smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sairon.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sairon.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sairon.cz header.i=@sairon.cz header.b="C3bDStSH"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-383b4a3755fso2039851a91.3
        for <netdev@vger.kernel.org>; Tue, 06 Oct 2026 06:22:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791292960; cv=none;
        d=google.com; s=arc-20260327;
        b=lOOskfObvZA4fB4ogy3fWWjGif1bjBf/ODCupfrg4zfBTnouLx4zwyUWHjn2+xMom/
         VwbBnjFMHHIczfymOoOkB8dnJJRL3Awu8rX7jifaVLaDroqhBXjBVQnK+oHis3nNo52s
         ku2rVwSkF/eJvLoSYe7hWSPXTVM0x2LWC8l5DAJ8+T+18L8vcLUkff7ylXv53UoCIHPF
         fWCO8RX0KQ75vOb6OGw2QBnsSHZW8ySnpLNGcq2B3nU4NbN+juMM2T2dQhgUBTr6e+pg
         /esv67yRcHX8HmZbPSrZOMao8ERvXHb4ZfsrS3Y3VZ3/rTbbqPxirghSY/q2MmYRv08n
         YuEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=2/kY6gI5Yk1xMI1SVYXumnXuSjxWIMRSCwqdkzoU3Bw=;
        fh=18sfnFc4RZRsgl1SzB77nsL6tURc5+nqvfGscMXg8zg=;
        b=Oggq8R6PPUBevCd23Yemjm8dDPGBGnDiZ07gaiFvgfZ8d+XXZyrjuHxPykq3IF/EZL
         6JysaX6q4amk0k5PUjasur+b+gN4FR5yyDTOaVOKcNCV8EKZ+nKpT4nm3xBP2w/tLDua
         9r5+vGN9Ev37Z3LFNXqSs2I9eKryWq+xW5jgzBaenvNdohgdnX+HHcBPW2eNxfwlZWP+
         OI/3jQwWGIj/MW3xj8f8v8IadIgJ0mRuqxdoT/AEERUVbenLfM1vsOhsHxST/ff6iNOA
         S1XGMfymJzZEwKo4upsEJipvbExV2lSR+bcVDptfNCHm8o030yuLiW8WelElzehLYRwz
         yRhg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sairon.cz; s=google; t=1791292960; x=1791897760; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2/kY6gI5Yk1xMI1SVYXumnXuSjxWIMRSCwqdkzoU3Bw=;
        b=C3bDStSHSi2Y6QN93laDi+Neb114peOI4Gf37k/3xVquAGQWUuu1LITVaWeZZz5epA
         1KFsY2ZW22wvgUBcj0Di8WlDviGLUZiS69CMxJyrenYLkpGm9EkV9UX6u3XnmQWzdbi+
         uNmAXurX0Qk2Vkz4vashdlrNduQHM9qUROVC+6yvHK4ZlqccQAnThuW8JgzvnGnprgG6
         /q8xnRtoXvGPshdrceNsVp0whdSd23n64p+h7bD4eXSnt6AiGScl7yZkCQbAjIe4wt2L
         UEDecubxger8g9RoI+/qMxsB4VGUguI161bSL//FzmdtesNL/ZpKYYzv/vWjYjHvbSGK
         ytTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791292960; x=1791897760;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=2/kY6gI5Yk1xMI1SVYXumnXuSjxWIMRSCwqdkzoU3Bw=;
        b=JVCzusyi1UDG9rr8+w5g2JUrlYiqIf2X04w8m7P/4J1xtnNaRarC90kSi4wRM5SQnh
         E0MwPhaadiwA44nyi7U8LLapx4uAyaTonpu8zxeeOi5zHsjRcZcJAL4eizFX2h1xwoHL
         kSyDCDiNeAEwMxVQSQkINFu+AS/e0xETGapRA6PSqrukShu+/8rYkhvWcTMtcQG/uWHP
         bwvAuzNLlbXQOPuNNd9H94eiFO9YdEXXeb1rWMQ68oqSJtqgBIGgL4tALvRWAd90Xz8S
         OSlnUMUpeOY9xDfXtAlXvH42SV4g9Wp+8eVRB6xIK+8oA3vTcncxWOP0lNMTg8+ieHDT
         crkQ==
X-Forwarded-Encrypted: i=1; AKwUvBwwkmH/STvocFFyh/p7770iXoJWNVoL3/KTwVkryGsLGol0xe3XwlH0BUiq7lyGiD+U6E2Ztuk=@vger.kernel.org
X-Gm-Message-State: AFq9FYIPgEHBODFmWCFmQmW9BF5hkGQFjxJ2WXe1GcHBTL9hNMk2qvUd
	P6vz2SYwGjiW5VQ9mXZBxBlsUsbFHa673BKv2uGd3JAwIW7ewJH0V2hJqxlL83mHP3RySiNxNWN
	ELO/glakOnnAWGa+AfP5Gq1fDitzjhTkNyh0js+WiEA==
X-Gm-Gg: AYBFou2mT15+OcZ75MPvGPOfwPB2vp2F+FhDw0riPkVTH2zihuc0v239BPZaIXKZxVn
	/SW2qbn3V54QbJcT6nzPMMKqbXRxFiaNfDIUPaz+o4D97rN4Iavu0XKzqh/nqtYj7E4QmfL6tZ3
	7u/4p4NCeV+zBx9kdURP3zuWErTYZkMZhG/hq/zsiAj+7tvZtmj9/aLKp/b+M9QYId2/VmetYmX
	J3gbusC3/IK6+uQC5M19m67LvO8WLla3sTQa79CptUwwram1YewepIhWjBKOtE1TKHL6PCQsf7U
	kPJvez80JVQqT2oVZy+3cJ2ir2vGP5h571MHgqvowu+E2Wzz+ZAOJmLnNMsarSSeaBKSui+RsUA
	H+DYT+PT46iGBApx142GYkS6aq+03xXmEiA+Q+eo9aV8ZdCKxmPrfc2ztg6qcOrfz9l9CgMdVA/
	c=
X-Received: by 2002:a17:90b:3ccd:b0:3a8:878:ebab with SMTP id
 98e67ed59e1d1-3a80879621cmr5255577a91.35.1791292960306; Tue, 06 Oct 2026
 06:22:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPa5EdCj3v17tB-SF2JNecq5Q8s1Pranr-XzAFWNpNTBPgPG7w@mail.gmail.com>
 <f73ca71a-8a22-495c-91a9-12d89968ac2c@leemhuis.info>
In-Reply-To: <f73ca71a-8a22-495c-91a9-12d89968ac2c@leemhuis.info>
From: =?UTF-8?B?SmFuIMSMZXJtw6Fr?= <sairon@sairon.cz>
Date: Tue, 6 Oct 2026 15:22:13 +0200
X-Gm-Features: AclHuK-K9pG_NO9KBdAk3iESUwUuT_Z21z8xG2zR0qRYXTeutTuoi2M9aya7o-A
Message-ID: <CAPa5EdAxXiHKrdrUk2nrbxJzgh_B3jwkTP00+rV0-xk=2vmiiw@mail.gmail.com>
Subject: Re: [REGRESSION][BISECTED] r8169: TX stall with checksum offload on
 VLAN frames with inline tag (REORDER_HDR off) since 1517d1996b52
To: Thorsten Leemhuis <regressions@leemhuis.info>
Cc: Eric Dumazet <edumazet@google.com>, Heiner Kallweit <hkallweit1@gmail.com>, netdev@vger.kernel.org, 
	regressions@lists.linux.dev, stable@vger.kernel.org, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, nic_swsd@realtek.com, 
	Sasha Levin <sashal@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Thorsten,

On Tue, 6 Oct 2026 at 15:10, Thorsten Leemhuis
<regressions@leemhuis.info> wrote:
> Not my area of expertise, so take the following carefully, as it might
> send you in the wrong direction:
>
> There is another issue known for 447cbe95ebb9:
> Commit 447cbe95ebb9 causes IOMMU DMA faults on macvlan/vlan with bnxt_en
> https://lore.kernel.org/all/20261004122616.56714cbd@nargothrond/
>
> A fix for it is under review:
> bnxt_en: fix DMA mapping length for padded small packets
> https://lore.kernel.org/all/20261006042153.199444-1-edumazet@kernel.org/
>
> Is that maybe related?

I hesitate to tell it's completely unrelated, as I don't fully
understand what breaks in our case, however, I'm quite sure that the
fix under review won't help in case of this regression, as it's a
breakage in a completely different ethernet driver from a different
vendor - bnxt_en doesn't play any role on the affected systems from my
report. But _maybe_ there will be some clues what should be fixed in
r8169 in the discussion for the other regression.

Thanks,
Jan
