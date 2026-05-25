Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62B012505B2
	for <netdev@vger.kernel.org>; Mon, 25 May 2026 02:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779677766; cv=pass; b=ZSrpBFAuth8LYmA+Bpk7nioVq0OgrQGW/ldZSKpfLfjZp6kg+nyZrvhSVn/+M++kkicmUBMEuN1eqKodzLs8wHbcibk4uv/QZ7usEoMAmrsGMkzM6TJ6PFOmB59g62IVhfmNHRGCnKYPD5NutnJsgC8RbAObt/MDJEv1KNw/w9c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779677766; c=relaxed/simple;
	bh=5wQBLArApPLsMlICqhf9ciPauydOov7GSVKlsLMYUQ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fXCuGui6jw6x29Eay6nN4QV4QOJr6tq5t57t0ZjM94XDWKHADzpLIssJo0g5C0ni4PzHCKmf9BkKrl4j1lfEP6+v7jZCVpv7M0OxN5mr1qgRVVRF0rqV4kaRz5TNhftw5UA8ImQix4P4adcgT1u6ujvfuJrbE9DBX8mmduEgoHU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UE3Brgcl; arc=pass smtp.client-ip=74.125.82.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UE3Brgcl"
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-134ac81c445so13295981c88.1
        for <netdev@vger.kernel.org>; Sun, 24 May 2026 19:56:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779677762; cv=none;
        d=google.com; s=arc-20240605;
        b=Wv7mG/syll+5bU0edbCzFkjs3N/G4GcUOmZ0Kgo1i11m13egRuP8wmkfgOQr81ifnC
         APv3KRfJiLTrUY+CrwFoXOCJUMBUORFZwFHjm5SfhLG4BRLqcGBRBNEgBDERsPesWjgO
         QzQCFrytmEfjHBUeLJIbYqsv7vBtTyc02AUV8wanC5IfRb49wk/2FDZ2EErnMD5fxDiB
         wKm9hQvvMAoTiTcBJfnQ9WAU5awRn8uGCA8AfXUgMGP/gGFQswfPGjDcaSMrwTgCIym9
         ddd2q/MxfRWcHqN+UQc4pkphai9zIq65abePUrcPeymY089Ey+8i8PHHRTC4ZoRZca64
         xuAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5wQBLArApPLsMlICqhf9ciPauydOov7GSVKlsLMYUQ0=;
        fh=5CEq3yyamxZrIK3AqDRklZWFWZYtLv2t5y6JI1KeIXA=;
        b=JLA2Wnq1svxCVk02UOTyQhx3LvJSqjg7qefB7VhAbg3JmdblBtaAbxxsgkhErKP2Kd
         SrTykuehvpfHCLnnSUG4Ta7pquYxJ+Yw1WrQwwrjyCQ43H8seoMkyBl7ihxy6EzMqMdQ
         JxhSEEW2hE9bT5n1+/wtn321isP0kPDpPqtsuHFapStqtGrcKxLZI0rmtRCEIT9KwKPU
         dNJUTbmWPFSA1jMgyRc4qwhZjhqz7h0FxFOVpBBM46qm9Bsimy0KYYHYIuFxJdmUKwvz
         FQuMctB/KX7kzdspQlcxNALd+Du/UhNq8cD6ywI/xal6nlylrFGbvpPjSgWbb86Xq/zV
         u7ZQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779677762; x=1780282562; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5wQBLArApPLsMlICqhf9ciPauydOov7GSVKlsLMYUQ0=;
        b=UE3Brgcl2VRfaROxPvigTm1vthtO/KxYSmKBtNIO0ofliJzKASFwU0ad0S4Up/Q0lS
         wZ37JIJ6IVIQNIC8E2jFey3Ue9SBlW16xTbdqYJgn0FYMtV3v+uTjpKgO+ebkwKyPj0o
         Z1buRBy+wuo0k/a8wjtU+B5kIxMjJWCtIeLUCLmHnzUY/YVfiLVI085Tmsp/R+R3LD1H
         6kkUIH9GsckNDn3CGf1+fGpU6oHX1m9TWdnLoIsjqx5Cd8CKkAkxzR9r1Q3l4lbqp9ml
         5ZPCHBl0ueAE9b2sP4zzTvCEbXkrWpEHzNLbiBb3DRIzvu3ssb6QvPMpbGrusly2BDvr
         1/+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779677762; x=1780282562;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5wQBLArApPLsMlICqhf9ciPauydOov7GSVKlsLMYUQ0=;
        b=r9SMilJfI2gsMu12FKIUTrU2T9iEo6OinqGqvnhncL9ufppx5LkcdPXErvUAIDqexN
         FDIIE2JsYaRoZJT/yh7gr7x/mIDDRN9n35sIxTto0UF/c7wHYiksyDN+AHh+uyhbCpgv
         L5tj8NhIsYFEO8jXcVSlPayURzB1bIyGWPIhLn27FvSma3KYatQGjb4/Vm3dgXVK44Ns
         QCB5Dj/X1HezPuiM1IYFlqQ/66G61/7NGz3PnSStUV9EFquDPQXf0zZwkDeHxawrzEnT
         sJJH1+hOKTeBV94DfSmA3BeXkKclVoF+X118MBpPpS9I801KqQxsG86OICOHuzJiwY1C
         ftPg==
X-Forwarded-Encrypted: i=1; AFNElJ+KD3xAnHPNIlrsXVDEBDacyRfw07UrFbAYm4uotxBHrfGrZOefcARvrU1UqAsqznDZc/rNyU4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkyL54kQm+3bMiAzdCiBBidmHyC9JSxf+LFQT+H3YBudGyRSIE
	+Z0ilBV+8QYG5899J4fXlGBUjkH7I5ar6hNSG+Uz4m0HRkje2zSMCdPXcUip/JABoW75dHCsGkV
	bG54zDa+gKiug+BgILAU/gN1CvJ5j5hOiK9o4HlS7
X-Gm-Gg: Acq92OGpxXvNQCMpINX/JoEZFVZgeiw3sqb6Q9tcLSoXmswnS9hfXv97+qVABF6mRQA
	k8DQ8dTN6rj936sO8ZCbrQXxjVnW28QoF3H904PgE98VXLJ3zXE9w7ITx2Uu6VdwF9ulPyQomsl
	mRmUtMOLajuwotHKwpUpG2Es0z+c/sLRpls5OWWVnBgQ3I2TaHzqAwNRTF6+LJYC0x/4MjIKTpD
	ju54M6H/nIrEgL/ZNq21pLTD5D9noQZO3fJU8Yc7wuMEfKBALkEzklJyC0YuMU4J38aKG3FptdD
	8AmTHGPC/UGlo6La4Xr3Xi3RMzlYP8147zPBLi7oWwnzOk9/M/QfMuMtaTnvFMd+Zr8TxzvZDo5
	jDbWKi4vQOcATx/p/CffBicRhA+wxcH4VRsVff08cwi+oTIy2/+2HDdqKwqkKjWA=
X-Received: by 2002:a05:7022:6727:b0:134:a701:de8 with SMTP id
 a92af1059eb24-1365f810954mr4947471c88.5.1779677761816; Sun, 24 May 2026
 19:56:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260522115512.1519110-1-edumazet@google.com>
In-Reply-To: <20260522115512.1519110-1-edumazet@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Sun, 24 May 2026 19:55:50 -0700
X-Gm-Features: AVHnY4I1Feh4VgeXI0Rld-w-yg1lhMmakG9Cy390mAKs1qE75P8RYuHgQGKyQZg
Message-ID: <CAAVpQUA=kJ-Ne0zDniRehpebv51MuBnvKcAL5DpT2ofk8Ad12A@mail.gmail.com>
Subject: Re: [PATCH net] tunnels: do not assume transport header in iptunnel_pmtud_check_icmp()
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Damiano Melotti <melotti@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 22, 2026 at 4:55=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> In some cases, iptunnel_pmtud_check_icmp() can be called while
> skb transport header is not set.
>
> This triggers an out-of-bound access, because
> (typeof(skb->transport_header))~0U is 65535.
>
> Access the icmp header based on IPv4 network header,
> after making sure icmp->type is present in skb linear part.
>
> Note that iptunnel_pmtud_check_icmpv6()) is fine.
>
> Fixes: 4cb47a8644cc ("tunnels: PMTU discovery support for directly bridge=
d IP packets")
> Reported-by: Damiano Melotti <melotti@google.com>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
