Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.226
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793078904;
	b=pUvzIzmgktuUNkeGdaiMsTS7u+AVL1bI0HiCjs2y5hRE5YFIY3IQ9RmusLyKU/SLWZv0
	 wZ/xDgH34/p3o95RrCbHFyJeeifILO56yW37qTk2kzl4AGxf34ADWQPIvy0/CUW8CFxj2
	 /KE4HdcUzrGqO5akbrhPlv3iOz3uSHPQ3CjeE1FiiBSdmrT3vXUzKHSYQ/ujymUxyyH1h
	 YuJCyH2deGNNX9uS/vKYI8QAhoixobO3+lA+9rRe1rGkEPfNV1anGlhvMjLtElMoYAmb9
	 vg6uhb+xyHDfaVROHso1AJpJCe9HaJY94AtvybdaahJG7TxEui3Ad72JsY3ifCkvHwg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793078904;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:X-Relaying-Domain:
	 X-CFilter-Loop:Received:DKIM-Signature:X-Forwarded-Encrypted:
	 X-Received:X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-DetectorID-Processed;
	bh=i0Omha6OI9MUeQUJmEdArgRodEoTi21Ihq4kzkDpg+k=;
	b=itdYG3Kx7RosWw6SIA/nsP4rNBiycuU2uCXFxY60JeTLPGAQ3dhRet+eYYMvPk4ZNg2e
	 3CabjGyVYks7yaXCNk+4jAXMJhyoQ+G5sDuZXexzCXE5lYjDZFp4ksWGAmz9mpdmhrdSI
	 G8a7dK3h0fdunHZfaObz00qpRRq0gI1eqxTkfd0qgasBcocPaOoroiC04BNFTk4JjAlY6
	 GX9IYFegbvbic/7V0q09Uj5Vu+ukMKwe1OeaWqoa+r5AcNsFQsNju/FZ2254AGMuQyJVo
	 tibQWrGDW+t8iOrZDQloY5ncmYsSsIpPEN6orZikK0SzI1JrEbw1AXLlJg/FCdvtB1w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=Hv5ts+VE;
	arc=none smtp.remote-ip=209.85.215.226
Received: from mail-pg1-f226.google.com (mail-pg1-f226.google.com [209.85.215.226])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFA22606A31D
	for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 05:28:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AFA22606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=Hv5ts+VE
Received: by mail-pg1-f226.google.com with SMTP id 41be03b00d2f7-cc7d154ec4fso1520617a12.0
        for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 22:28:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793078903; x=1793683703;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:dkim-signature
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=i0Omha6OI9MUeQUJmEdArgRodEoTi21Ihq4kzkDpg+k=;
        b=dbUHfp5J7SqIMfNDljY8VyBLc3FEa88Z2CpgfsMgdZ4jAiPu9aT2uLWZ99sLCAskXW
         l03zxvh+i7PD+NRvig31WB/LNRZviEKUqmkzus9r8reoKpXirZyMIVLE/zuXXrq9g1Vh
         A3ka/I/ZUgTunt+8zyUzCgNOasOS6oZELkG6Gx8YXQjFXlnmezFzhKtwNb1rHdpfpbH2
         0TAAWxl7P0PHfw8yOgOOX5FPqNFMFFTmUs41rWxXQ8TaqRAV4ryBuDaEzibp41ZTWyMw
         rgY5VrJGk0F7zie9LEwcM4LT96CAoF+PxUw1CMS3eBp2JxaEFnyQvtyzBigpMjwQVIER
         JM+A==
X-Forwarded-Encrypted: i=1; AKwUvBxu4zgXQA59zYft7G0Db6ec7WxokgXbuYIppWOgY6wtlGN0jT4qG5mYYWsuf5YnpiAYF02iMFo=@vger.kernel.org
X-Gm-Message-State: AFq9FYJy94Vl484r0RT66+RrcW1evz8ZhyJ8IGc3cvsmt+5OMoqGJXNq
	krGrppTdJlNvZ33nZN23UtujYMA9dYd3uKc4mlY5UstjDB9Q/0xnDmGBeSWPMW1WBA3JOJ5cM7n
	ND+dNpTLAF5v875EXqmwgw22ZyhJ14Zm9VEIAdmMYrbiO342ifg3rr71NilONeYtcXIxax3rcqb
	zCeLkx28yjcxqEyYgJ3f4e+cwIObXRu8SzB5AQj48OMeBRN57arrYRJ8LYtWvw3Ykgv2OOftwhF
	t8qmhQTIA==
X-Gm-Gg: AYBFou1FnWgTckIDrgUDWF93TATxgIBDRU8t2k9XRs84xM6epm34EDso55tGZQ1KAtF
	6tMujIBPGq3ubgVVsLEQiNS2Lgj/+XVPmjiod5uiKkMZQkEcfCUVEoLOLQHuPksjjv1ewzIMm2b
	23ED/jak/8J5jhTRpPiUf84JCNaTJBtqnEfMRl5B2++MBE+BmPloc6EtQ7cL7M3IvHRXyRE7RNK
	D/wpiD3uHSR9Br9Y3+AXCoZTydcEnX2VxEMVT7RSLqsfUGoBSFLeEHr/R8QBS0X9SFELLUjYPgR
	oU9QBVsTAhgeChVNDrpdsFhKeOseBb/PVFipS8K69PS6mttr+J+75WfEm2daUEpskdgUACxQcu3
	v3plLt48jDDHLxKXakw2r+oR0bk44G2xYmE/wyGAOwgJSefyB5kdzy56lYKiogLuvJTGjUnemOU
	RK3MNWkkZhAQxLIwXlmD0Z7lILqALywnp+0w==
X-Received: by 2002:a17:90a:fc48:b0:3ad:50a2:9abf with SMTP id 98e67ed59e1d1-3adeae88e5bmr7596588a91.38.1793078902996;
        Mon, 26 Oct 2026 22:28:22 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-28.dlp.protect.broadcom.com. [144.49.247.28])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3ae406dc8fbsm1323004a91.1.2026.10.26.22.28.22
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Oct 2026 22:28:22 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-vk1-f199.google.com with SMTP id 71dfb90a1353d-5eb510afc00so1018320e0c.0
        for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 22:28:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1793078902; x=1793683702; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=i0Omha6OI9MUeQUJmEdArgRodEoTi21Ihq4kzkDpg+k=;
        b=Hv5ts+VEac2dOY47cVEwh8LEduIMGy0w2R+fpKFa3THYi3LPzXdm+LxiFX+LLcCM2K
         eeEjdhrkx21NWicVviE2eOLtjBg4ATMksb2vUzWhubzHbcHGBJT9Lj4kQbgwDCSqzzEK
         YmiDYRvSBDW6DJdn60XcSRgqkTVgg/YsBc7FI=
X-Forwarded-Encrypted: i=1; AKwUvByHuBLpRs1rAkmOOfiWes01FEMVgKNCZbvZIEBgXVgzkc3BPbEpo768cQIs6OVR3ElUzw7t1S4=@vger.kernel.org
X-Received: by 2002:a05:6102:334b:b0:7cc:1d0b:6d33 with SMTP id ada2fe7eead31-7ce5cda3f5bmr2464710137.26.1793078901773;
        Mon, 26 Oct 2026 22:28:21 -0700 (PDT)
X-Received: by 2002:a05:6102:334b:b0:7cc:1d0b:6d33 with SMTP id
 ada2fe7eead31-7ce5cda3f5bmr2464700137.26.1793078901403; Mon, 26 Oct 2026
 22:28:21 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261026092757.9168-1-vikas.gupta@broadcom.com> <179300703050.3327.1854487549237861268@kernel.org>
In-Reply-To: <179300703050.3327.1854487549237861268@kernel.org>
From: Vikas Gupta <vikas.gupta@broadcom.com>
Date: Tue, 27 Oct 2026 10:58:08 +0530
X-Gm-Features: AclHuK-e-IEGXyZmkxyrolV4vzi29eNKxFEsXYfr1j1mgNehM7DbZTSy-5Bbvrc
Message-ID: <CAHLZf_t1t41ftc4o8i6cS_VVT1RgyLW-o9KeZst_VPPmD9x2oQ@mail.gmail.com>
Subject: Re: [PATCH net v3 0/2] bnge fixes
To: netdev-bot+sinfo@kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bhargava.marreddy@broadcom.com, rahul-rg.gupta@broadcom.com, 
	vsrama-krishna.nemani@broadcom.com, rajashekar.hudumula@broadcom.com, 
	dharmender.garg@broadcom.com, ajit.khaparde@broadcom.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

Hi,
  We found these issues during the Sashiko code review.
  The fixes were tested on the Thor Ultra platform.

Thanks,
Vikas

On Mon, Oct 26, 2026 at 3:00=E2=80=AFPM <netdev-bot+sinfo@kernel.org> wrote=
:
>
> Hi!
>
> This is an automated message. This series looks like a fix, but its
> commit messages seem to be missing some information:
>
>  - How the issue was discovered, e.g. hit in production, hit during
>    development, syzbot report, manual code inspection, LLM or static
>    analysis tool scan.
>
>  - Whether the issue was actually triggered, or is only theoretical
>    (e.g. found by code inspection). If it was triggered please include
>    the symptoms, like the stack trace or error messages.
>
>  - What hardware the change was tested on. For driver fixes please
>    mention the device (and if relevant firmware version) used for
>    testing, or say that the change was not tested on real hardware.
>
> Please do not repost the series just to address the above. Instead,
> reply to this email with the missing information, so that reviewers
> can take it into account. If the series needs another revision for
> other reasons, please include the information in the commit messages
> then.
>
> The evaluation is done by an LLM so it may be wrong, if you think
> that is the case please reply and explain.
