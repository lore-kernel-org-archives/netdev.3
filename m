Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.215.178
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792919033;
	b=NU/m10Olpkhoj3hAc6xU2jWlOyoGltNje6SXMMPT9oymuSigP5H/ge56bwO4aRfAhZ6B
	 5XIAhJ3F/dqyTlU1PdmHj1mg4Xds4RifP++ToZhgML1GKndXZvjkXSgQQorCT/o7JrZrS
	 ykjZ68kakT95uBTWDgPMCO25nkcSVGFr4yvdRKYTVzuKdlpYfuhMonTkm8hBljgRLFa9K
	 NxaQDEatTu2vobYPGzdsq5mwVvAm9BFtw7maZleL5msWoQA1X8MmwcWK3nGAibmdNBCrX
	 7SjFS5V/oXxxjZKshD8voiHMgrFDdwjynRqDX9E5B4LmTBetLKCH6IEN3xjPZyTo33g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792919033;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=1BooYTXBqtdl0NuOlZpwBA6Ku6J/l86osVdkZCPC8Vc=;
	b=Q7WqjlBhWpdAOVlsI3pYmvffGZKQvfmSQ6c+l3BQfYP4fgPy/PV0tLI8QyTlZ5mEigIF
	 faAOo/MPgrJKfe2mUhUrw9ahtK9v/UXbVO3Jtwms21oUOZm5CrFyG22DRhlCOAR3HZBrH
	 x0ulGlfcmtv3vu/sXG/oVDig2L0Y54l4PhKAAjofZVUE4afUkanG+MJ/RRQEIsM1KnQ33
	 8bzKckir/7ggbVHC++bLLUtiLivK/ZHMSNKG/w74ceqwjgoQI5ArovohRcElaNqDWFUs3
	 iB19MyivF14Cntz33+sr1+6FJEyD7/cvKQ0Hgdm1r3WQBIiP6bFypb2CL2Lq98fsKlQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=ujJS6mMi;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.215.178
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46F64606A31B
	for <netdev@vger.kernel.org>; Sun, 25 Oct 2026 09:03:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 46F64606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=ujJS6mMi
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-cd60c5da24cso1177134a12.0
        for <netdev@vger.kernel.org>; Sun, 25 Oct 2026 02:03:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792919033; cv=none;
        d=google.com; s=arc-20260327;
        b=FW67/Vdc6kBnKQGsZv66mAOsv83LrbnDpleHt2nUWiejok5JXYv4Lf+lvJWXz0CP0h
         r/qkTd/1szoU8ESY3kwj3U/mJS4bw/6GxNwOMqLVUBzvsrkdGJG2prSSGu28Tf+TeBmd
         8m3yhUea2UhgouKsPcul8SqpkB94PFf6KYOapadmPM6QQAM7HZ2VvezffMW7puE6M/4N
         xfMDCrlfig7FBYD/CUJNVv4Tfd9LUYNpxHz2x3PE8WmTAR4IhBRn8F4R83YYLve0neCy
         +jS4Ol9Vr8qYfFjorU8fd76seLRO1KeI/5c+ps2EkdKa4eigc4HOUEQySu5KIbIcPpbq
         nZAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1BooYTXBqtdl0NuOlZpwBA6Ku6J/l86osVdkZCPC8Vc=;
        fh=8svqWA72m51bYnKZs/Ubvp732FDTeeMRyfCLctoMP2Y=;
        b=Yws2LtZpQJpa+1weqwfjyhK3NEdQxQb1fUkztdojRNB9VJxUr8JgQKSdF8PKLWhSLp
         ch7fAVumpVBMT+AAJde2ZonEkt3HNba7TpP/nCoBEnfpNVWpZlYx6r0jIFBPmK1UOqnW
         wzj85NaVjw0AqRnKMjH5g84SM0LBDZ1b6IWKHVntKwhy/I0BFeXRXfv0VW1slwkFrY3r
         YyldYO0032E4Pr3jgICpAJErBVC6gQscm+/PBN6wUTUJhTpv0W930DEdyL/XwvpJGdSk
         U6wD9H9OCYPRztlMlxVAHg21Sbrzqx1x5iazIdIbAaHlC9lfN6vjyBtVJI/1gQfOlcOZ
         wNGw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1792919033; x=1793523833; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1BooYTXBqtdl0NuOlZpwBA6Ku6J/l86osVdkZCPC8Vc=;
        b=ujJS6mMi0vBZnl+BDCY0ZwxybPNMPiPzuhdFjhJhdpJo4Tx7T7CVEEyTDE8gFLb9Cr
         SRA0nkHUuCJ+rbUDjwjRwkFsDjDachhOG8OFnog5uwWUbfbxsUqJCwTjMuLUpqRYsL09
         k9/Y0+h8x3V7aZqiuiAOy2wRsSgAH8Rr9GzBE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792919033; x=1793523833;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1BooYTXBqtdl0NuOlZpwBA6Ku6J/l86osVdkZCPC8Vc=;
        b=oGBVXeqmR0Ht+WPp7SMDZmD3TIJgZ7jzkq9gARijpPLj8S0eiEKgHVFt3XLH9QmY/8
         WYVKN/JqJ01Zs5N42SbMdBeL3OBocNpVob1Wdx59vbKTbhFY+J5UbDicZJTIblu1bhVu
         fLnzoXQfTeLbvxRLMuTLGrqQSuchnm/YGgvni96Ubm3u8+ccIf3knHaPeF4s4zDuBo2b
         EVDq2lqZZxoUZnHJrIMDxmwh2/2J5Gc8/m9rMTCi/iT1WabGvLdFzfKpb20Ueun9j6K3
         iogveVko6oLWsFKL3bmaKg6OelwcZAURL6CRf3nSpwWLoQxdqy3KgGBXJOrZCiqv2ph5
         9wwg==
X-Forwarded-Encrypted: i=1; AKwUvBzuZ8l7ueLnDvYVXAFXLiBfVi1tRO7/ZGSQm06qEDLtK2mmCihts54Y8J9yjZnkhb6yJK309QU=@vger.kernel.org
X-Gm-Message-State: AFq9FYKljEKsXbzyJo2LlSn9lo2Tas3g1EipTh9GZ6rI7SNIEMoZ6JHA
	73hDkhgKANUnALXSX/VWt4uhFihZVoqD5NtKCC4VKTCuycUpQwjFG2A19tSay5ULGln8jL+Pi7t
	7wcU8YU45MEpUHyXHc4l0l4LS2zvUnRDd6CfsI2gx
X-Gm-Gg: AYBFou3AdmpmkkRfqcjC/pq7tbY0FntcuyMNdtIHQcQkx1jP/cZwlXbulJxvENEpmKK
	22rsLoemeLCIePHjUS7MGerIbG3puDCrMYdieZn4KhQMlTRIyLbFF1W7QgpXODj0h9TWpeGwyQ0
	SaeEd2pxGzmktshu8xggZcBus1UJK6dB0k9gcuxLDHlBEtrDzfd8ubQGRj+Gm4zDRE8WHRMSz7g
	BKAuA87lWAg4b4s6Y0bTBqdCAER1GclewCrjzuWZL0L8SLeDPHwia71qm8w+RkWZJAU4lz1mlGy
	RvmK05PI4+jEwQ9A41tkg/toWPyG828YKvudCHh4earVa77hstKVkSHlS3BA2UVpL9QrAY6tzgd
	6YO9hXCHrdy4u6pRhjYVHHXo7TwfwDrhyHOhzS5yH4wK5N9H5PiDZGgcDKPBSgHfq7XRll8qsD7
	24LxN+/WcFw8CIqo4=
X-Received: by 2002:a05:6300:6bdc:b0:3e0:b937:883d with SMTP id
 adf61e73a8af0-3e7bfbdba5amr2952918637.25.1792919032623; Sun, 25 Oct 2026
 02:03:52 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20260731140533.566493-1-david.lee@trailofbits.com>
 <CAM0EoM=UDkGKLivsdDS5JaVMuefR4jLC2rAWJcOR8XD-4N_EgA@mail.gmail.com>
 <CAC_etQESLytW5rhp0GfZU-mJqJhwk202a5u_nTXZ7W6wJN=AJw@mail.gmail.com>
 <CAC_etQHv2EBYfAhfkYHKrasnJAyDS+u5+a4os4aD1eSmKrck_A@mail.gmail.com> <CAM0EoMm=KbZgcGqLHDFee3mM1GxuNCvAWObP_K4AxsGAoEAedg@mail.gmail.com>
In-Reply-To: <CAM0EoMm=KbZgcGqLHDFee3mM1GxuNCvAWObP_K4AxsGAoEAedg@mail.gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Sun, 25 Oct 2026 05:03:41 -0400
X-Gm-Features: AclHuK_jMLdQH3LqJfc2klawx0gf0RQlCgrLwXyrkJ9NArFRch-vM04NQdh0R90
Message-ID: <CAM0EoMmxpVv4YRoQQ3jN+79OKjaT=ep3+6jff8CHoOBLJUej3w@mail.gmail.com>
Subject: Re: [PATCH] net/sched: sch_qfq: prevent aggregate self-replacement
To: David Lee <david.lee@trailofbits.com>
Cc: jiri@resnulli.us, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, Kyle Zeng <kylebot@openai.com>, 
	"Dominik 'Disconnect3d' Czarnota" <dominik.czarnota@trailofbits.com>, horms@kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 22, 2026 at 5:14=E2=80=AFAM Jamal Hadi Salim <jhs@mojatatu.com>=
 wrote:
>
> On Wed, Oct 21, 2026 at 10:56=E2=80=AFAM David Lee <david.lee@trailofbits=
.com> wrote:
> >
> > Hi Jamal,
> >
> > Following up on this thread. Please let me know if you had a chance to =
review the attached reproducer or if you need any additional information.
> >
>
> Please resend to the list - I lost track.
> And if you follow up after like 2 months(!) you will really have to
> retest with the new kernel and likely look at the list to see if there
> are other fixes that cover this issue.
>

Before i try to reproduce (then proper review) please resend
addressing the issues raised by the sashikos. They are legit.


cheers,
jamal
