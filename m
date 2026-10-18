Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF9473403ED
	for <netdev@vger.kernel.org>; Sun, 18 Oct 2026 15:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792337476; cv=none; b=AssRcYfnOGceWitmu3mtEFB6lP9muW7V8lSG9kcIj3S9foCkmK2fyTeQqNLlxwpriRgvuLhI6gpYtcZngb1UUy6Wo/KmN9J1GIWHHcjmRh3bKr1ri2Ur5h9QizSGkRPLKdcHPb+kuTuvTikYgXCheI2oKeCl7Ol92r/prxNu9Co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792337476; c=relaxed/simple;
	bh=PzBI00utEXCdwv3FgCzoWyg7YfkkrwiBeVqnJzeHpRQ=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:MIME-Version; b=VAjdBE28lBv0jVii0TstXutI7WxGX5Im+SrCuPArAEuzgf0E1FWCR7x5o6cdPPBTDYS8ri0SbfuS4/LZk3Vl3J3XqB9ysmj6BHKWjPKbLh4VO184ZMc/sKDMIy9kJlLPNJsSlMRIjLePLTy0X87gmfgTDSRdyXLwYRMT75MEc80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D0L3FcTf; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D0L3FcTf"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2e8fe8e343fso5677325ad.2
        for <netdev@vger.kernel.org>; Sun, 18 Oct 2026 08:31:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792337475; x=1792942275; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PzBI00utEXCdwv3FgCzoWyg7YfkkrwiBeVqnJzeHpRQ=;
        b=D0L3FcTf2k//NCBztV6gd0c3dINWeDqzPO5LbAw6TaD4FD6gba5EI57oQIYXTQTgN8
         AwJseldNRGPQJQlsy09SptbI/wE96eHy4Ukdo22oBqu4hqX1AiUDOSghj1tZw3btyIYG
         MtKm6C53HNX0uQbM5xyTzIjAuf5deysTbuHZR59kUSCG0+F6u6yx8g3kTbuTFFyULkJ9
         iSDkIqBWbQ2iCjxtHLNnYKM6M1Fs8HcFhINHSpcMjbpI82z2nofVsJkYCKZ9Sy8TAm3c
         MUJ4wFCFqJizKJnDIIvRCg+44Jp2QWSP61pczilZMKQgZHIuDKmUPIKVOzxr6enA1zS9
         emzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792337475; x=1792942275;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PzBI00utEXCdwv3FgCzoWyg7YfkkrwiBeVqnJzeHpRQ=;
        b=HoUptJfXRjXGpvlORMwPUOyw6E87F4RG0Qv4uAUS8vFflTrST/GfTYKane5rn/ipDZ
         hsS8x42PKjDkuGy3nWp+EbFzLL2alNDEQTfjAWBJeDtV9B3oTR+RkC32nbAb9A+fgp4Q
         47hcjE83RknC2HxYrhQd5gHL7Ez+KUReEPeizc+7IFnV2NpvFj9OeOu9lUnbz1+qbGsR
         TOMRqTY1m0b6/wmk/M3+uqZadM8FgSS/+SXg6zfVvUmXDkF3wKJO9InxPD8va0OP84U7
         cSWQJF/HjV2xeXJWQRKsA7RfGJCMd8fs/6aHedk2VQyV4uctfr5Uv9wHLOku0mbKEwNr
         6ubQ==
X-Gm-Message-State: AFq9FYIUzEh3e4eGrZNEOjUKK1a4X0JR/6d1tbU+ieMoKyLn0l32rpl/
	rApCDpyjf8MOGF75DZsV+fHg+Vxz/4LVeazWzmozvQ6pwr6eGJxdxLUP
X-Gm-Gg: AYBFou35Y7fkggWEqmiKcr+s+IV0bmUeG0g/gGtoVOYjBAySG0JwjIvwGLobGO+M/Yt
	oTI49krYtQZIRuS0Z1ab9+ZGqc8QvAa40um3iX115uZQoIgUNBLJn0wXZzQ8XYfXYxjoDMwCiTH
	wHlIImqlKAIdLF6j4s7n5KZNJmWeH/nbE0gJ3H6grnrpacYVJ3ujCeyCOgpycFN/TbH8qV1bvlH
	bUBi6s9iDAz3X+wv2T+uZFGBbCUI8wGSjxMfgmVqNJQAitry6vJ32uhruelMHsjdp3wl40up73Z
	wteWPu7OL8gdcvNMJwZcFfS/MkqSCJbuxDA2fl6QPO320dSLtSWSEeDo70HBI7EUqd8/0J6fmNI
	qn3YwH6u/B0xdsWiXlYUhuI/WaMNqt6SoOWnSIvGawZzzKU6dD5aFEMH5RmJNcj54KXqK4ZVV6t
	shYsOzlcD3iEDPR4oVFthiAOsLSfNIqsyCQuPwwaSWnHdNVMZ2S0IjqtU6UuI7iUn+Bt521RZI3
	2EdqGGI79DXw2hN3nK8uFDFUYNWPUU0G/H6DmW5zl0Vfp/Hf2HklCty7ZyDoEteUW86Sp7rMCTT
	/az2RLB1JeOg8Q==
X-Received: by 2002:a17:903:2347:b0:2e9:5772:9aa5 with SMTP id d9443c01a7336-2e9a69e93dfmr43357165ad.32.1792337474904;
        Sun, 18 Oct 2026 08:31:14 -0700 (PDT)
Received: from localhost ([153.61.198.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e97e804d2dsm30343315ad.17.2026.10.18.08.31.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Oct 2026 08:31:13 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Sun, 18 Oct 2026 15:31:13 +0000
Message-Id: <DM82LW742MNX.XRJ64BXF8A8A@gmail.com>
Cc: <netdev@vger.kernel.org>, <bpf@vger.kernel.org>, <daniel@iogearbox.net>,
 <andrii@kernel.org>, <eddyz87@gmail.com>, <memxor@gmail.com>,
 <josef@toxicpanda.com>, <mason@kernel.org>, <steffen.klassert@secunet.com>,
 <herbert@gondor.apana.org.au>, <kuba@kernel.org>
Subject: Re: [PATCH net] net: free the policies if a socket's clone fails
 late
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: <netdev-bot+sashiko@kernel.org>
In-Reply-To: <179228971515.3135.11305942271655228187@kernel.org>
References: <20261017013912.396296-1-alexei.starovoitov@gmail.com> <179228971515.3135.11305942271655228187@kernel.org>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, Oct 17, 2026 at 07:15 PM netdev-bot+sashiko@kernel.org <netdev-bot+sashiko@kernel.org> wrote:
> [Severity: High]
> Can the same policy leak still happen through the branch just above this,
> when xfrm_sk_clone_policy() itself fails partway?

yeah. It's an old bug, not from this patch. It needs both policies on
the listener and an allocation failure on the second clone.

> Would it be safe to call xfrm_sk_free_policy(newsk) in that sub-case, for
> example in an else branch of the !is_charged check? Alternatively,
> __xfrm_sk_clone_policy() could roll back the already cloned policy on
> partial failure.

Yes.
Somebody would need to send a followup.
