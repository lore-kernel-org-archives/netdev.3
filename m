Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=74.125.224.49
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793467400;
	b=xzMJTSPbFuzLOh852f2BLA1q0OcBGiXqfny8G1EMlRdJe6d62JRkQcv/QYNUyDUOEMeM
	 TjJFdTNro0ZWpHl7nh+QxQlOtyZufu73+45984oT65XsnIVf80vXSS1jV9OVGW+o0gIfz
	 09al+dbbN2jV6osCMSMy3ukVPKGaZyzl8tiIadePmPQx7+HrWr6v289fw7US5lFvX6xTV
	 8u0mBalfE6qwc93NcIO371tAWkrtNgL8pxLRkCObsOSDgFKhcDsJXRZXdpR2SZ4Q8P5jx
	 Io/ub8zXRFjT7b7JzV8+0VyCmRXbQ0s5I/XK89dZivfqQgy6san2+Kq86GjCNp9/fdQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793467400;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=A1b33ZVTzx0TaLrZ9DBFPPcv9iR1/Ri05N+1BlbpIlA=;
	b=2ZLE9bnPzXKo/wBZmT/vgp3Xb0rSGh7lVkAynIBXqtheOS4Qd+MsRzyxJDQczLhIh+eC
	 5sYxkfqkmq1A/1IedQVW24bMd57Lxam6KxOlNce1NW7GHzdX0peTWnypvh9L5Ae9WB21z
	 0WU9lCaoBwz3EKm6EANfmSR8VV97uSWeZawYuDHmhAGNnGPf/Q78xLbJf2TjNi2BhRSqu
	 7JByuuw19XlRGSgm0/oMxjd+XdM3frppj3vxbB1ADg8bzeFNwnGDKo3IddIppuAuAS+8Z
	 UXwYfDX4k4+KRvx9H+OCNiicjUeGJ5swvp+c+R3LVGYVjbsKShfDkhF4hvLpTxsOyyw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YUewY4e0;
	arc=fail smtp.remote-ip=74.125.224.49
Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6345606A31C
	for <netdev@vger.kernel.org>; Sat, 31 Oct 2026 17:23:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C6345606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YUewY4e0
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-6774639a8a4so1294315d50.0
        for <netdev@vger.kernel.org>; Sat, 31 Oct 2026 10:23:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793467399; cv=none;
        d=google.com; s=arc-20260327;
        b=ShOsFaGVc3EQAwElfb+wNXdfWWIgpFNPG4U60YoUhnNvrk7gqaivGckDXcVVTNb2TK
         BDDQNlp6p1VAGi3SB2S+DXYPL3qBBcp3MHJNLz/dptML5A315+HwCpQNyL+LcvxOt3CK
         /oO3dEAlha4dbUHaXqoO8O+e99H24PogM+LW0+IHbgLyNVObXH92P2nPQQsP4UVmf7Vi
         Unl1mpIYG7MWuoWgzgtGr3Ok2cCwkwpVaeUoMSbZQGqrk9Vn4FgTTJYfHzC6OZqEl7T+
         +Jc6VM2ia5R7qrieRTx06elT7RKerd06hh5QqHbd/xhzdjaEM2MInObrxDOmVf84fQ6Z
         QMVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=A1b33ZVTzx0TaLrZ9DBFPPcv9iR1/Ri05N+1BlbpIlA=;
        fh=SFsOBoScVBwtTc0ttbIku8bKoSs9ZnTmc6EoTd0a5rk=;
        b=XtKivVd9s9Pb6C2Trm2+/EOYRVQknpz/00pTI8IIV6BeJPXvHxtopBQDZidNbmhQbw
         3yMzFpVqlRDpYXSgEi3zQ6hCWSwQ9u3+WEO5yntizkXW9/jImhCj0rxJC1iwNekEBlzA
         mD6w3AeWids6v4kAUsuZdgXE0XW+RdWvWRDVLLQ+F/25/9s9GJoMdQILCUs4d69XMyoI
         69MVCo2lyrOQfP8yrcC+Qq/wtJcj2nq6lVTtdhgU3BI9PCkFDHDYvWLkxWzzVt3JAMsd
         sdrdwFp1WEi1iEkdPlkMyTAeAmPoEIKcii5jNIP6OVhuGZ7v2sHzntIWPVzujSGIDElu
         Yu5A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793467399; x=1794072199; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=A1b33ZVTzx0TaLrZ9DBFPPcv9iR1/Ri05N+1BlbpIlA=;
        b=YUewY4e0Qg0Rp7kR3KGNUiVeh76yMG1j5TudZFun81QSfG2XXN/Y8/0AQ9X2nNlGs2
         amfuuxX7v82VU2tfMDe9st4x/fQFbFkomRwsRXo+Pmt1DQ2aTMlSETrFlVHoaQP2iOZ8
         QtrUZZkAlEXx4sThuQP6JMnurv5/Sw59n0m4A9OjqMduI41rTHybzBzrmcNFOOzFgMym
         3w51ULYFeWPlh2GKYgGt4BvqCIuU9GdzvDO4pgW48gT9boPXvbk38U+/1i9AaNK4ih1G
         MS3DfnNf/Amb7WzSfO9HCS6zTNfpQky1OrcKRz7ScGsuoXV4Rbycog2Jo82OabhkK5am
         EJ4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793467399; x=1794072199;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=A1b33ZVTzx0TaLrZ9DBFPPcv9iR1/Ri05N+1BlbpIlA=;
        b=YUwI20Ah6qwMY+44H2R+EZ3/Bc/T2tHMp0vbXVQ7dTjj74kthcqcb3Ey5z3rDq5vCD
         owHVx800j6ob7io28Yl1DC4e5RnuPKtFNug0S4r8t18lFpk07ZWrNdJ6oXxQnnWDtNp2
         887FaMnG97fz8Ns8U85VasCEaJc3L58EwEl7jh7oGRyN3sUzdk9PL+8/tvFNY8MiiKDV
         Ik2XeX1Zy1GBqHhiAWibJ4u3u2FvXogjoxmrBHU+73+GkiCQ2IfodBUwWV9ClWYBgXKB
         tVevcsVFMHMhKJOVFRRop+IKtPhaPVIxeVM9ifqjV3mRdJjlO9qy0+QB3EoVyMN6AXdv
         h8Kw==
X-Forwarded-Encrypted: i=1; AKwUvBwCVtoDdthKPyAHALx7jZ2fU14/1EfBXMaNii0ZMgOQN+Fdlm/y/XODQt3bD6Oj6MRCs37dqKw=@vger.kernel.org
X-Gm-Message-State: APuU4Z+vylK39E4z9G07pjINXlhctlSgUHHPAaH2xPDf7UxbbX9BMSez
	YUNPLhObj6EyrUawuFp3RiQ/5LtDGCw6JwxkxIpvYE2O3pUaOuru/w/oj1Gjbc4CyTrB+N5PDGV
	YIbLJndT5eKEiOeRBJ4FuTABBWR7zxxE=
X-Gm-Gg: AYBFou34km2MWiXFOfmBoT1xVHa8SfHcMCisDb8rWQz5E3LyqI9xDQBH4m0JmgLsjVX
	p3hMbu/gypBw71tI4QIANuWAlGikONPcyDmtkECvAfjDwWBs4GTrNJK99gTG5hm22qZDP+28tYw
	vgUFCrBmUkDlz+B9s6z+nTmjfmq4gzcAs2Otx262a6qL+h39LCIv+1WzjAHvHf/MMtv4/uJ6g2x
	xIGDuADyoY2AW64rtWzzNayXjHPFGIcTW2FQblopQ0zr1Eb1wrvdTSxLoeJGFB6nalzBLH85Bgd
	PBoTnJvnIHwvqf9btAlmfW1hOj0PjAgCU3lsJvrfGhvZWnLgPqGLZ1daRU9igqpsMK9YnaxroxS
	OMtLe9zpGXPB/KKeHBHUkbYSt1ZPVDoSGH5ENeqBVTzDcv/9WRY02J6QkgF7GEwhUhitgdw==
X-Received: by 2002:a05:690e:e8a:b0:679:a3bc:c23f with SMTP id
 956f58d0204a3-67ba4f6d59dmr2990826d50.39.1793467398729; Sat, 31 Oct 2026
 10:23:18 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <tencent_C2E4FE9B7C0A05615861782611715EAA9C0A@qq.com>
 <tencent_7A270291DDE5CD89DAFFE8A745D094D5BD06@qq.com> <20261030134342.GA36226@shredder>
In-Reply-To: <20261030134342.GA36226@shredder>
From: Alex Henrie <alexhenrie24@gmail.com>
Date: Sat, 31 Oct 2026 11:22:00 -0600
X-Gm-Features: AclHuK9DfpxrKQqMD1cAzl0D1-pn8G11KNdTNUdh2ruOzlesG9RpA1W1wo4hWEQ
Message-ID: <CAMMLpeRrZ_femp9zvB9wfrdJ+whOh_o91gQmG1nhxJ8PPXCoqg@mail.gmail.com>
Subject: Re: [PATCH net v3] ipv6: reject wrapped temporary address preferred lifetimes
To: Ido Schimmel <idosch@nvidia.com>
Cc: Yingjie Wang <1075151112@qq.com>, netdev@vger.kernel.org, dsahern@kernel.org, 
	davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, 
	horms@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 30, 2026 at 7:43=E2=80=AFAM Ido Schimmel <idosch@nvidia.com> wr=
ote:
>
> On Fri, Oct 30, 2026 at 03:30:56PM +0800, Yingjie Wang wrote:
> > ipv6_create_tempaddr() raises a temporary address's preferred lifetime =
to
> > regen_advance + age + 1 when the configured lifetime is too short. The
> > result is stored in a u32, while regen_advance and age are unsigned lon=
g.
> > If the sum wraps or is truncated, the stored lifetime can still be less
> > than or equal to regen_advance + age.
> >
> > addrconf_verify_rtnl() then sees the new address as due for regeneratio=
n
> > and creates another one. Temporary addresses are not limited by
> > max_addresses since commit 4b08a8f1bd8c ("ipv6: remove max_addresses
> > check from ipv6_create_tempaddr"), so this can cause unbounded address
> > growth. With dad_transmits set to -1, a baseline kernel reached 2859
> > loopback addresses in two seconds.
> >
> > After storing the adjusted lifetime, verify that it is still greater th=
an
> > regen_advance + age. Reject the new address if the check fails.
> >
> > On an x86-64 KASAN kernel, the normal configuration created three IPv6
> > addresses. The negative dad_transmits, positive multiplication overflow=
,
> > and large retransmission-time cases each left only the loopback and pub=
lic
> > addresses. An i386 defconfig and an x86-64 allmodconfig both built
> > addrconf.o with W=3D1.
> >
> > Fixes: f4bcbf360ac8 ("net: ipv6/addrconf: clamp preferred_lft to the mi=
nimum required")
> > Cc: stable@vger.kernel.org
> > Suggested-by: Ido Schimmel <idosch@nvidia.com>
> > Link: https://lore.kernel.org/netdev/20261029175827.GA1411453@shredder/
> > Signed-off-by: Yingjie Wang <1075151112@qq.com>
>
> Reviewed-by: Ido Schimmel <idosch@nvidia.com>

Reviewed-by: Alex Henrie <alexhenrie24@gmail.com>
