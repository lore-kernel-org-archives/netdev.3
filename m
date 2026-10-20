Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.182
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792504349;
	b=1nKaH4HAoYsYIvf7y+L9o77yFyyRUV0Do4HtTUpTC79lwm+d4uldoyGzFUWHffY6ahiU
	 f9Pa51Ddslt/ISuYibleijCHgUMiUNNV2x3z/mYMWuv0lTSzRer4noIt/+qkiFB1mJ1gw
	 xqtimoyXsim5N+VRSHAxcGT/PWJeRW1DmUN7HNaSCR3Jt8M9XQGnMCTAKjJ8vZPs3lenM
	 eqTiZHnpw8iyg23e/gczMECzJ/s2700NwYWcn5ltPi3Lw/N5PsZxdx/MCR2WtFI5knqP3
	 VARMGCpSyJQRo8dyg22FyZ+/wDikxtWqPBj0S+9vTtAuo0wNbDz6nzgG7PDhkdfcx6A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792504349;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=k/hbwlcYMnNfV2mBX84KMoYZ1kQ82mEtSuTGwp2XYJ0=;
	b=Th/y3F2Sj2ECUE7apx+h56N7WcalCgU1Os7cujtqdd+BEmZDWHKqMlYZrnYTe7ZSfmu/
	 v+ZsYFfhs60FRmoHAnNcL8dSFHvR1/3PMX1xY1cSmDwwv+81qeRFcocGJsMuW3/1C0Uac
	 CuytTUOsC8KntG2MWuCpNcXwpWa+k1/Ng96JzyTzD/XRIddpVxMwbClDhE6ayhil5xesz
	 WzGm2YKHtAY8EYM6wOakUNJHSzK4sXpgGksBl+RE4Mm9n/L9TQIu7lej18RH1MBhp8vxy
	 RxvEO9FaEc+Px2417mTKUsdGbTFk1ilFDGUFxeNDCjKKQcjcLH171Ftd6iuMMLcF6Tw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=IV2bjblS;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.182
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28B0B606A320
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 13:52:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 28B0B606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=IV2bjblS
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-8a064dcfcfdso597561b3a.2
        for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 06:52:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792504348; cv=none;
        d=google.com; s=arc-20260327;
        b=kGRxH0B98vCIPoKVsOWwVcuibdrdUwWH5gj7IFWo6QSJ7jaV6jCpRErBnTj7o8j0l3
         twa4xIBLHqYcsjlGn3IRcMzisflPqJt8VYT+YoQC3zV9r4UodOrGEs3sRgK2fS2lGtC3
         q5YTRQBmtMAdnoV0HhB6Ugt5TF0cyXrmo9AhyDz3GscsKZhERMDPn87hnNoJ7WYT3Hw7
         VfgV2yA0ZWmLtOK+oKZvXxgQET0RbM+/hLcZxQKSieytC7JsZoj+mBYkQSbOrjxB9a7O
         EWzmDAgZJSUkF/kh3Nq93+LdprePoKkQl4cVnoak0T8u4jy/IGRXaYfn/6O8Ld+DaBnt
         9rwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=k/hbwlcYMnNfV2mBX84KMoYZ1kQ82mEtSuTGwp2XYJ0=;
        fh=FPxBST2WYYXjpjgO5N+O61dd8G4nUuqOmz28f+gpAm4=;
        b=Yixu0XRESFJeao0k4uR/4rNmPMJE4OTfQiEtgeIFhj05rdDazgyiDJZvx9CLIWQKOd
         5B1CZzyPqxPSWQFIdJiYfoFLRNxtzl6N95VBXGx6KkSlcqBFoTLu8jjXdmd7oXNXRNZD
         H6cK6sCWGbySo6l3CYPGoC3Y2jCKW8P3K3hzT/eOravXmoqsTyrdsVGeM3EodfuuMlEv
         XYbCIELrHMZHO/7Xoxq2eR9XNGvuFx974qM9DKbweoIV4YWlLE2/L9Q5cUzNGktDzTbE
         QXRh6Ut9Nrs5H3z+B7MwMKoXNw8lEg3TZUNfPWBn3XWxFiPNyNFlRGRNbsms39yZVIix
         ufXA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792504348; x=1793109148; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=k/hbwlcYMnNfV2mBX84KMoYZ1kQ82mEtSuTGwp2XYJ0=;
        b=IV2bjblS35z+WtRmdC+d2NdVsRgCEc2iwHZCl7nN04NO7e2vjqFjw+Kx6HSekD8k2E
         /NPZRHZ2d9c1Lug7zCFOG0L68NjXSPPtKPzbZDrCoc8aYx91Wv0bQUQUtgRqVZulPYqu
         1syNEVnV219YTcsBqwsBTN8OTqFxpdGQxQXvZjeKMq+Ep4Z1SjPPQ2wtKwOxkoh5zuly
         P4+EdYiXsq+MlyOJePp6ZT18lccIxbzkqhPTQ/AorTqz9PdbsZePwazefSSyjIBhqVlp
         rbcM+9y4QEhyT9xZ5apQ6lMNz3ew0gGjIvKSy+Cg69b03SN4ZpNYRn/LcJvQzq+77ydf
         +7KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792504348; x=1793109148;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=k/hbwlcYMnNfV2mBX84KMoYZ1kQ82mEtSuTGwp2XYJ0=;
        b=krYQO94T7Xzj8zReNXbXb4qgNljMjXOi8HkyGzhy2P4Ik9A1yTeAGQBW5e5a6AmesL
         KbbSiw0OL1j0A0oGwDzqeVlXqJDQ5NX+NGCG4r/ZZILl1F2vdScJbZuRiS11eZB8MgFw
         kljhXNx0vbgdaLCqpYxD4PMdgbj/Q4NEeQOlnmG876W8tlT5kgWmtTZmQqBc38Np+ULv
         xwgLsJTk6/uY/3C+QqJfLBIXWYH6pciQyz87US69NiUyJw5dqPW6YKwsFhUvI1ZRjr5m
         ZK8z980fTkKr6H7BatnwQplz6FwP6hUePyBwMHodemqekK1a7fq6oJDcDGMliblvIMQT
         3zVw==
X-Forwarded-Encrypted: i=1; AKwUvBya8DeMDbxRy0GnivaiS8OO+VEkksNR7zGupTEdAfPDlWOLHmDekhq5gkx11+zExPyTz27r9uM=@vger.kernel.org
X-Gm-Message-State: AFq9FYJJWsyTXhMHgAfhpXhkfID5b7Mfcg9sjX+UFrp9uIyGuvafFeHl
	g1JgxRoykJmuAP4Jsrj7Td5nEl7bm0odfWG4BpETga1fOdbTb79IpQvsAQDvsfXIqsFQXrt5vtH
	WQegLNrH5ngW8+ix4yv1ggGqdRbQ3i1Y=
X-Gm-Gg: AYBFou3PAAU6Bfow32CA40rTWtj3PCipCj2rZTUK85iT/ylU25Mbh628oF49YVE1jT1
	7GtmffTW0EGLHyvOYxkJcAW4E3R4LPr94qrSf9DYlNRpfc+1GfSbbfXyjXqV/qCuADiT/+7uVYx
	jgVIY/1ULdCr5Ue1aHzh7pV2fSfNILL5SCjOqaypIsZwiXxbSYj1Fpwif4FkI3oX4/H+Hd1lYFl
	PiasqwJPU8KbdIEtpCIDubn4CEJ2x7EqvH6HWQ8BnniXicRvTXsqqPt7QCLe1V9TAhYI4tsOKMQ
	5LAoyE+0LxOW85peDm2brYMTMRmwrcTnFnV4aGmmbWXjc8hwFQqxwV8NsZsC0uRNzRvdQyezPMT
	XE0jFOqeXles8uYY8jQgvihzQ9Qg+7coQnzAq95TIdxzBAj2uwWvA0ZAvW/xpwztGuC+xNwC5Kx
	cnWghitHOPmuOjpqMrBw/zcK8fMzbknUDFKzcPHw==
X-Received: by 2002:a05:6a00:2343:b0:89e:9c7e:fd51 with SMTP id
 d2e1a72fcca58-8a04ba30b92mr8261328b3a.10.1792504348492; Tue, 20 Oct 2026
 06:52:28 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261019135441.1420968-1-sashal@kernel.org> <20261019135441.1420968-252-sashal@kernel.org>
 <20261019172836.GA1885@quark>
In-Reply-To: <20261019172836.GA1885@quark>
From: Xin Long <lucien.xin@gmail.com>
Date: Tue, 20 Oct 2026 09:52:16 -0400
X-Gm-Features: AclHuK-B306P9cHCODywZCNc6I1CxZirkEbtUGcvZRPSRQ2med4P2bdTR4gz54A
Message-ID: <CADvbK_d3hcGcP21Fy_z9hkoSuQT0Bg7111Ejns_WxOYfCCGFHw@mail.gmail.com>
Subject: Re: [PATCH AUTOSEL 6.18-5.10] sctp: auth: propagate HMAC calculation
 errors to callers
To: Eric Biggers <ebiggers@kernel.org>
Cc: Sasha Levin <sashal@kernel.org>, patches@lists.linux.dev, stable@vger.kernel.org, 
	Qing Luo <luoqing@kylinos.cn>, Paolo Abeni <pabeni@redhat.com>, marcelo.leitner@gmail.com, 
	davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, 
	linux-sctp@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 19, 2026 at 1:28=E2=80=AFPM Eric Biggers <ebiggers@kernel.org> =
wrote:
>
> On Mon, Oct 19, 2026 at 09:49:03AM -0400, Sasha Levin wrote:
> > - Residual in this tree: `crypto_shash_setkey()` failure still `goto
> >   free` without an error (mainline HMAC helpers no longer have that
> >   path). That is preexisting and outside this commit.
>
> I don't think this backport can be considered complete without handling
> that case.
>

Agreed. We should return the error from crypto_shash_setkey() when
it fails in sctp_auth_calculate_hmac().

Thanks.
