Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4920426EC9
	for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 21:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769029673; cv=pass; b=JP4meTsnSPBiVJakXp6zbwVZXfMt3S5KUBO41vcIZANjKZHjMT1DJkZjOJR0faUHzreFUvi+XRYOdFA5PO0LbiCzrcJn1DBupWyDSZqnunlOE28VCIeowCh5nOUTpjI2C761Fz4eNjuir94Sj34NCbd5gf2XT2LHnGvPl6xysck=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769029673; c=relaxed/simple;
	bh=vIrtZLlR9y3VX65/B/Uk/Cvhdyt5IYMtPMqdkwsTUis=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=au5vrUPb3S4XMUQcsHkowoAL/8BGA7megQLcVGurjcuG0LQ12iAs4RbSOFAjGOJtDUyKFkOJ1L7sgg6zbAsCqvv3no/nu97qH7Kmejt/DYHoPjcxCsBCaFD/W/SQH29F9PIPVX6aLMyoK1EQGH27YQh0tGNx/e6IbO0xyfG/kgk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SQeqyJeM; arc=pass smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SQeqyJeM"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-50299648ae9so24821cf.1
        for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 13:07:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769029667; cv=none;
        d=google.com; s=arc-20240605;
        b=GoSHvTNb2XmAqjD+ljW7ZxAVn+VOOyBAn8tFKjQGZP8V3+B3Ug4q9/zyS5yS6qiiSt
         vuw2jVDHDtcs8WsglYovHL8sioE3lnnf5dS7lZLJupr7NIdzNB2GSBnKuY7US6pI7OQj
         UQfoatx4uJjnj3pkpBDkjN0PBS3GI6sY1smYRJw1YpPwKLO31t4+MabjOijjj1Bw6F2T
         rFGi8PcqoqCmFCX4vv7+lKZ1NzcIAX1yi6I/E5hS2pWlRqmbc6AtLVhUjfZI+Lm/EH+e
         QdQrr+C8ohll4i6XhR0FyMMohiCXNU+lvjqbhILz16xvtlaex1qGn7E1mfOf6jgonbEq
         QGBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vIrtZLlR9y3VX65/B/Uk/Cvhdyt5IYMtPMqdkwsTUis=;
        fh=Y4FzKJO6r3n7lpDaIqoPefam9ddU6ezeVhjFO/t5OYA=;
        b=hzPnmP27ouhwCEsfVAyv/5aekzjMs4+GaVWcd7HrUjrAFcAiC8/CiH7+uIqhkiGQA0
         ml9JwjU1oYtQzqVPneB1ULWr0uHz5Y+segGjLgWdLdg2DB6BGDHY6OiNgEFpFYJhcYqc
         s9stQ5wpwnjzO5eoBMOOgLgPdV1jn+f02AvOxoB75eCj60nXpYRbcrt5b8fEeUKBxn84
         iHm2CQ5pFSQQ2aTQLJccExlB7+9eMc4V/i4E0EBTCnk+9sD3l0NNVF7ze2uaW+V4XEJg
         MM2F2SFk3FTk8G6a4n0lHSZeRlJ7RGnVLFWPAub0MvS0Itd2MZEzs4hI/VKxFH2FecrT
         8x7w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769029667; x=1769634467; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vIrtZLlR9y3VX65/B/Uk/Cvhdyt5IYMtPMqdkwsTUis=;
        b=SQeqyJeMzhPwZVMwezMEbd/Zhg8Dp6ruPVSwYPG/XOz1e5uRFg4ksHfL9QtwxIXHfV
         ptsIQ574V8qsD33A49aSXeEswthUWZu5q6OQztfVTUw7XbIFmX846CwEnmrdARgi0BjU
         zW+RSaH54PmqgSyE94iTpD5KkQkJuB7dTvgCBAZrBsTukd0VDNS4AAz8vhsmKBCUi1w8
         1ifEVM2pldEUht8y33DONlblUvkvItE8LdsGiEAalcWBpOdcJwEgFFB1fPfsK9/Xauwa
         nLv/48DFgjdTL2tP+n9XWtHP7ZtH+5DEbrDkDmTKHv7LvY8Q/2pTKlCTs+gyEPbrygm/
         tJow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769029667; x=1769634467;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vIrtZLlR9y3VX65/B/Uk/Cvhdyt5IYMtPMqdkwsTUis=;
        b=uJfAHgl7rysHUWyP2tVr0CX/x8UIdMBQKTC1SPE2Ellw4d3qSU8JhOhvtPst3ZsF2i
         X8n/5JpFEYX7o1LiB8v0sO0nGnR/PZtwIpWsKUn72qLyPisfWhQ9e5uXvNDVMuTjkz3V
         hDNfX/kO0hvNXQGG8W1uBzRgqZMHrury8hARU7bc7OIxRT1LBTojr+EvC9QIXLCnGZH3
         /Syv21TxKLOTxVKwUMgN3rriETpxNo/VXzxyyV7Fu1hnOJlAfIZOEwRm7rquZKCD6446
         BgTrg9s/bF5mOwm18tqjd35J2ixjH8ltJrnQOZ8wBIiWnKsocS9PipmNhQDeieg8CLVA
         EUUA==
X-Forwarded-Encrypted: i=1; AJvYcCXny7+pmEaJFDHFIK9ABkRT7v235bfKtzOcCOHTZ/SMrZ01BoWSdcQRQ7l4ohV6d+ccExAx8bY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx17Ho4dcfDJ+e02Dv4lcNUBOT/8IzSBfzeEs62hkXWDVXhgpLF
	aZ9XjOdjrUsOq9UD82/C/LYzlCI52HDXLVvJ2ARxiu/+oDlt87o+JojwQEAVcH3iExHDzKcvoAn
	Yb8nzkCzl+Me48cx72OILnEv92d95nLFi/KII4rUf
X-Gm-Gg: AZuq6aIq5kCcMMbbOUlNHxY1g3+O5pv04HASKghIu5XPXRGQgdFMyawdlZ41hi5dYlH
	aEuyGRuMDFGJOFFQEIbj5vts9Bs+H7oYS+t+Qd34pA8QLD1kgFUrpMlu5tb6Om2KmCr0dsDN36M
	e8HqbzOyhaHInmTR0iAJXETO9Q6KR8ImGmn4Fwk6Z9znSULNrGjIhrMkKMtNdlTANiNPCGx2Ko6
	ASKcjHiR/AluP9EvpmXjzV8PtME1YSarm3YpwWfQZabHngKTjYTZQR0bE4dg6pNbPjWXDxL7d5d
	p7G3VWgINZyOLaC1ahPjJWOgaPZPJaXxxEgTS6rgADi3Z7ppAQLIbSllPpmr
X-Received: by 2002:a05:622a:10d:b0:4b7:9a9e:833f with SMTP id
 d75a77b69052e-502ece23329mr407501cf.7.1769029666268; Wed, 21 Jan 2026
 13:07:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260121143215.14717-1-chia-yu.chang@nokia-bell-labs.com> <20260121125504.32ea788c@kernel.org>
In-Reply-To: <20260121125504.32ea788c@kernel.org>
From: Neal Cardwell <ncardwell@google.com>
Date: Wed, 21 Jan 2026 16:07:29 -0500
X-Gm-Features: AZwV_QjMA9pxvIgwt5ruSX8S6CumDWx8tec6mJvW5t5NdsFW525cQ4qDlmi2IZ8
Message-ID: <CADVnQym58ujAwozxSgMNxcCBvTf5JVYrzEoDuBFTjheY-PoHHQ@mail.gmail.com>
Subject: Re: [PATCH v10 net-next 00/15] AccECN protocol case handling series
To: Jakub Kicinski <kuba@kernel.org>
Cc: chia-yu.chang@nokia-bell-labs.com, pabeni@redhat.com, edumazet@google.com, 
	parav@nvidia.com, linux-doc@vger.kernel.org, corbet@lwn.net, horms@kernel.org, 
	dsahern@kernel.org, kuniyu@google.com, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, dave.taht@gmail.com, jhs@mojatatu.com, 
	stephen@networkplumber.org, xiyou.wangcong@gmail.com, jiri@resnulli.us, 
	davem@davemloft.net, andrew+netdev@lunn.ch, donald.hunter@gmail.com, 
	ast@fiberby.net, liuhangbin@gmail.com, shuah@kernel.org, 
	linux-kselftest@vger.kernel.org, ij@kernel.org, 
	koen.de_schepper@nokia-bell-labs.com, g.white@cablelabs.com, 
	ingemar.s.johansson@ericsson.com, mirja.kuehlewind@ericsson.com, 
	cheshire@apple.com, rs.ietf@gmx.at, Jason_Livingood@comcast.com, 
	vidhi_goel@apple.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 21, 2026 at 3:55=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Wed, 21 Jan 2026 15:32:00 +0100 chia-yu.chang@nokia-bell-labs.com
> wrote:
> > From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> >
> > Hello,
> >
> > Plesae find the v10 AccECN case handling patch series, which covers
> > several excpetional case handling of Accurate ECN spec (RFC9768),
> > adds new identifiers to be used by CC modules, adds ecn_delta into
> > rate_sample, and keeps the ACE counter for computation, etc.
>
> Looks like we went in the wrong directions, multiple tests are failing
> now:
>
> https://netdev.bots.linux.dev/contest.html?branch=3Dnet-next-2026-01-21--=
18-00&executor=3Dvmksft-packetdrill&pw-n=3D0&pass=3D0

Looks like the first two are failing because the v10 series has a
different layout for tcp_info than what packetdrill currently expects:

https://netdev-ctrl.bots.linux.dev/logs/vmksft/packetdrill/results/483641/3=
0-tcp-accecn-delivered-updates-pkt/stdout
https://netdev-ctrl.bots.linux.dev/logs/vmksft/packetdrill/results/483641/5=
8-tcp-accecn-delivered-falseoverflow-detect-pkt/stdout

Chia-Yu, can you please post a patch for packetdrill to make it expect
the new layout from the v10 series?

For the third one:
https://netdev-ctrl.bots.linux.dev/logs/vmksft/packetdrill/results/483641/6=
9-tcp-accecn-client-accecn-options-lost-pkt/stdout

... it looks like the test line that says:

+.002 ... 0.052 connect(4, ..., ...) =3D 0

needs to be changed to:

+.002 ... 0.102 connect(4, ..., ...) =3D 0

It seems like running the tests before emailing the patches should
have caught these 3 issues?

Chia-Yu, can you please make sure you run all the AccECN packetdrill
tests with the latest kernel and latest packetdrill binary you are
proposing, before posting a v11 kernel patch series and packetdrill
patch?

Thanks,
neal
