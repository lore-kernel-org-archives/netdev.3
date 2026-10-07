Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0E94372B5A
	for <netdev@vger.kernel.org>; Wed,  7 Oct 2026 15:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791388352; cv=pass; b=jZmetezrzJTVIKTV/GFI+mEz4Qw0dWx75vHnjrnEaU9Vnv+stXZzN5IatcGqf8WsaydZ8riGSvQJCHT2BRvTA75YdkDjs6EiU7RoJZKTXHEb2FCCutQEmZuUwGtJGZ4chq59ACr/Ca1HhIWzPp6JYYrHAwPH5bKjuRRrCPt2gRM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791388352; c=relaxed/simple;
	bh=G5QAWNgkx7DW/w2sNZv58uxdaR8uMZDdjmra9Zc4X1I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Akja2SneZjPCUi5SwuUeu0UHjDK2asSI+9/lhHD4AB8vbxaqXaMUy146vS8MZM8bMNcAcRSbYLa8H+anqpC0mEqPqj+FwjZYmMeO2PBrr2VZwu4V/eTUPEyzKp6RnEPHdkNxZFUw5iK9z+IMvD30qZa3K0cbUciHdOKfphoHHMw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tDqdCqKa; arc=pass smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tDqdCqKa"
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-3282db206d3so11749272eec.0
        for <netdev@vger.kernel.org>; Wed, 07 Oct 2026 08:52:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791388351; cv=none;
        d=google.com; s=arc-20260327;
        b=lfcYgtXi+f4Pk2T0WP3m+fgLHqUOOvCiYHwxPHeHRqTra6yC3jpIkKYx6yJLJFm1Ep
         XIhsTs1369pa1+yl6z/BS/AMRlAiFH9/e3lr+H+tGOFg1UB3y5Um7hAnnL7azwA4mvvN
         EuKPjJpdbrM42PhDdqzmkuQ3c4ICsa/9GPEz3vZlZad08FEroO5NFvapXpt6hQeuBOLA
         1prCdZyOjo5ADq9NoEYliIOjHu0+9mYRH3R9Qt/MwPCMbvnjzhmceaQTbkgU1xICcIYW
         h+QjkApzq5svF3PlWn26RREkxXKElId7h7h25V9Mx6hjLwPpHV1LrHbbE23zje6J6IxI
         IBCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ddlJN96nno5/ia6Ry/GbBS7HZ/b+A+h0CpSQK5QF0U8=;
        fh=iBUmgi+b4Za6i/aiahl2xZsYqUPu6+V1oft4JwY0PTM=;
        b=kYeP4EX1fhmGP6lFTJ4bMOo5nL9g0tauZ+quEwwrxKOp4lNqEDrmvrlFMhbZTiGXZf
         LszH2wO/doyBOzsbcXdCS2gDGb9lHhCh/AclkrTHgOgjPLAr+s3mucJy0rqS5tckM44g
         QMa+rWnQn9e+CcgmnWseqH4eTxQzXq06WBWSklRRi2hPTGi9JBG3WU8oIMeO1teKkMHo
         X2B+62VXe0r4WD7/xp3/5ThkZ5OVzdt6nd72DsYIZ0ArClB8P8OyUk8L4E6/5jxB//Lb
         Juwf8MwJzMU6+kAkgcmTnSG3PmN9Qc3hRfwJwW2+rzoJH+tjWCBD5X8/1wHzoeHvfVYl
         lZPA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791388351; x=1791993151; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ddlJN96nno5/ia6Ry/GbBS7HZ/b+A+h0CpSQK5QF0U8=;
        b=tDqdCqKa3S69UtjqZ6M7NC+G4a7oz+glTXwNSOR4lN5r6NmgAlIp/+1534kwTYl+rV
         uAQ7FPt4z4iao2lGsFAf1t/YTzg9KGlxfj0do0BtjXQpr8pNhpdmWSdnZ/WaMTwrlH+G
         U6JvAa1qGLiFlcIjR8283sgXrqUFBvH1wPkBhLKyKsYi9Zwpf08Nxgs0wC0BtL7Pfcqx
         V/flqkTEw71X4koJSnePdwKlH2F9NTX6oXNZpkfmn8FhNVg3GDWjcax9QdlVJmFAj3+4
         eJUaoaqPqwWC8srJWV/Iea4Ag/pGzyKOwJydLs+z6XOd3h+1f2uX//PoMZMeyNH4JD1i
         Gytw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791388351; x=1791993151;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ddlJN96nno5/ia6Ry/GbBS7HZ/b+A+h0CpSQK5QF0U8=;
        b=UpetNunmu0LfmtAFccvJWcb+X8rggxMKEHWAl2zReWXBRH4uLf5PQWwZB+Vt12ywV8
         831Zxl+tpdF49ziITuwkTU88S/0VmPZf5k0eenOe/ukE+T7IKOfLU3RewwZMB3lzOPIG
         CdZEEXSBhkpolFFYIUDHFxvKSyutyZCuVGVcMost2qIuujmE2czCuN0hMp2V7QiWjziU
         z8xFE+OXpi1CSZHscXMWASvVm44PDneQk3/zylYxHPayXtlFD1Rbtcgh/DcTFnZ6JE55
         KaRInmPAgxDMwVQSaxPW4rPRwW15VvfM+2r7cZOY91t0TR3EF7DdhtDsa2EjvXoj9ru4
         vDcw==
X-Forwarded-Encrypted: i=1; AKwUvBx2hOysNRuE8VPrFImZDkJuH87MwpfJi+FKSW58PEiqwUoj74f6Yx40dDiTTBcBPL1cQ6Jfl18=@vger.kernel.org
X-Gm-Message-State: AFq9FYLT0ciPABJPsKA8eM3bOEztqE+GNgL1iTn6tn8ceFH6XH8z43Rq
	pwXsbtIpznn82ZlTLgoyiCemvauVwK31CtYt/d2CQarqlETXQthH+V6R+5o1ya2iaGkC2Z/Obl9
	Yd5POm1XILAYo78uClGOvF78Kd1TeKyk=
X-Gm-Gg: AYBFou0K1NsYfdLbxXdRAzCvVJcwsLFazt/itkW+3we2HF2ZBq9clj+8ZwWhFJwHkwd
	MvxD6rLVaRbtrDPfn3UlcfEAYbH5b6FQBA9YLx5lKoSaQdI+ZpzDeqHM9ZkJXsbZa3bpVIYaLsF
	TGgZetYPDEuWIwnZDNUMU7ScGQuf/OtJV16ElLf1TtCBVwt3KQ5oGDw/X6Gl6UF5gCtQKQ7RTn2
	Z6W73laFpmRnMMea+6KkKq/dJrdCmN4z4lXmqiG51zhad1g198n++rjZXDvqP5ZVqYpxE0YdmEA
	pMlhbQDtM0/2GZ6ZR3vHwfOgAFaofouq/5CDuoRT/Bq6zsPrrijeYluXwdObf3O9EdvU7FE9gOh
	BhcRGU7/v/OGNikmoPHuE6TA=
X-Received: by 2002:a05:7301:4208:b0:351:1b39:9e49 with SMTP id
 5a478bee46e88-3515dd83c6fmr2861584eec.8.1791388350571; Wed, 07 Oct 2026
 08:52:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <179138670045.80227.4002052840715926590@gmail.com> <179138703794.2527009.12321622169213831789@kernel.org>
In-Reply-To: <179138703794.2527009.12321622169213831789@kernel.org>
From: Joas Antonio <joasantonio108@gmail.com>
Date: Wed, 7 Oct 2026 12:52:19 -0300
X-Gm-Features: AclHuK-Khx-Zw915T81qHlg6B6H0bmWM95M5HnMxwh0PMIbv95UhhJY0UUwPEWk
Message-ID: <CAOCBhwE_JmVTmbuzJc8SEU1ROVyrat=7K-wqTQE=Er0gUy4fLA@mail.gmail.com>
Subject: Re: [PATCH nf] netfilter: nf_conntrack_sip: only honour Via: port in
 original direction
To: netdev-bot+sinfo@kernel.org
Cc: Pablo Neira Ayuso <pablo@netfilter.org>, Florian Westphal <fw@strlen.de>, Phil Sutter <phil@nwl.cc>, 
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

How the issue was discovered: manual code inspection of
nf_conntrack_sip.c / nf_nat_sip.c, assisted by an LLM (hence the
Assisted-by: tag), while auditing the conntrack helpers for
direction-handling issues.

I then confirmed it at runtime on 602042bf29f6 (QEMU, arm64) with
client -> router -> server network namespaces, the router running
nft masquerade and a "sip" ct helper on udp/5060. When the server
sends a request with "Via: SIP/2.0/UDP <server-ip>:4444", the client
behind the NAT receives that request and a following plain UDP payload
on port 4444; with the patch applied both arrive on 5060.

Thanks,
Joas


Em qua., 7 de out. de 2026 =C3=A0s 12:30, <netdev-bot+sinfo@kernel.org> esc=
reveu:
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
> Please do not repost the series just to address the above. Instead,
> reply to this email with the missing information, so that reviewers
> can take it into account. If the series needs another revision for
> other reasons, please include the information in the commit messages
> then.
>
> The evaluation is done by an LLM so it may be wrong, if you think
> that is the case please reply and explain.



--=20
Joas Antonio dos Santos
Cyber Security Specialist and Ethical Hacker
joasantonio108@gmail.com
LinkedIn
