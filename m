Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06AF3344DA0
	for <netdev@vger.kernel.org>; Mon, 24 Aug 2026 13:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787578734; cv=pass; b=DZ+e9gaoFRf7bv3+aL5cdTeIXV9FmPgWGsUP8RwZ2kQ+daVKwZGKEteZ6HD4mp03tEZRgt/frnHxhjBpnMkqHnRxIbv6hEORrUJJd0yQ/QMM1fNXafPKL93SvcoOwRklQ3PjJgo0poZ1IXH9dYuu82S5LBu8tNdV29quD7Cs84w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787578734; c=relaxed/simple;
	bh=mx0KOi+weQiY7kc5hNoEAZSp64A9icInZaz4gW9IUhc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LHToQbglxsVUVvb04YfONsNErGWRhfMRaOlCCSzMgg2cKSaodDsj6f8zwtjW5mUsp7FzC47lTzfyoBOsqGBeR9kiZFnErCzftwX9/mOJgrYWNz2EuxqsQzML/lv4UqQLRx07BnFdOYeCpWGXzjsf1oE27dgQLDC+dQtxpXDkPKo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=B+m9BKjD; arc=pass smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="B+m9BKjD"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-7dbcb505578so39966547b3.3
        for <netdev@vger.kernel.org>; Mon, 24 Aug 2026 06:38:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787578729; cv=none;
        d=google.com; s=arc-20260327;
        b=i0gOf18fNRAKjkCE7nWtuymw9Vfnbf6kg9SUfeqkI2ZTXGqv9+vKoyUwm1UigV9Qkz
         a90U9HoFM59Sapzh1swl7LHdfw6eWRYRgtecNT3e18ohXxq90vwGDCfmsAhqV+70Rnfn
         n82B7va0mhvPWFxXktG2VeW+dbtlHwE86qSiMLt1jk1FFD/Ydr/zAPh98nJwd64G4ApB
         WcWoRnjQBDnVPsDs5fB7Az8RdLQbw/G7Aw/vKiVnlKgUBPz6ndS7N42EBq8i4ghBoDRg
         X/QN1j/7OCn1MyWFnV8xKGOJ3oR3xkglaFBOcfUGAee0uVmWAWUPkSLEoI717uhn9lWT
         5Kcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mx0KOi+weQiY7kc5hNoEAZSp64A9icInZaz4gW9IUhc=;
        fh=m0kPnEn3kjSnYuv5V+QiSsl1nRF3hk5wibiYKX+0rDU=;
        b=TbSX/h9+DVAWW4TuWDBccDK/18q1vlOc7ljJYDXI/oZrvusMcB0t8sx7NmU0m/bPsi
         QKMLzUcxvgCRk/cnzmQHikaZlB69ugq4mcCLx4SCcwWGJOitaJ27hM00Cf5oIlBz5YEn
         ISXRahM6Mzr4Ujj+ucV2buBJoiE9nkqFzC19NdbAfQU3PasANG8WRt37moU/X6d4bc2S
         KiYCZclbeBksPXvW/pfGNYk7nr5wK3hUFLufJIos0Ohbp2kzCpiPpzw7/ffh5rOV8jEW
         Ao2cjEeHwFiSUl8pTlTPISnfBL1ANwoE8VJGxZnJ+5q465UOK8i83wNUTFPVAk0fkbBe
         dLcA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787578729; x=1788183529; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mx0KOi+weQiY7kc5hNoEAZSp64A9icInZaz4gW9IUhc=;
        b=B+m9BKjDvaoPxabDnOwVXwkpEj2/UtVQ8SAJcKbJSbOjW8loUNi8beTDSWIMlh5/Vo
         Cgov5NivN6GYDpKT2oohbsav07iybaPFNDtCHqUAWT8h8IXyw4JCwYbHKUzfGPzjamSf
         YzHimpL67PMuU8Q9f7sSrlRflSYskwKymwauMoYcSGWDyMrNwZWOZ/DSDziPppAEpcAg
         Mjj28rURpp9KzY+l01frqcr6g8RDOYntDyX5s5gcmQLaLfEn/3Y11Yhp/nmMdLIeeMpw
         kqNqtvz4GGh/TRZjKzM79HkppU3llblbYh96CUUaU6BKBxULyKrlCaWLw/zIA1kAH9R0
         FTtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787578729; x=1788183529;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mx0KOi+weQiY7kc5hNoEAZSp64A9icInZaz4gW9IUhc=;
        b=EM+PDoKrj9NV0WgiHEnFTYJIm+jb2odBg9QZL09pKgvu6mvx82Z6HLvcuFASvAdTgV
         v/mjmb6Z+UcXM+LGl+vajMzeEA8TwesLV76DT3H2Y/75rsOwr1gJGx0uc3wyWI2cAIjE
         E9YHzmF2C7lsV2cb9NfgP01Wljii6fMd5nVUSS3iJ41Fec0MPjSB8/Duw1ih3tyMGRPs
         aiIWn9IAdYto4OhI59F3eJBy/S4Tlal5UyEZMAieA8jmSDgr4xbDyjrT2dvTfK6P7zp8
         8/akv+qn2E96BJxBOPoMWC4OSyRYhbfsHKLrjbPHrzuF6ypNYIKzyiho3/4sHQkKjU1c
         N9Dw==
X-Forwarded-Encrypted: i=1; AHgh+RoxZacxYRLA9FZeO7SuANglpFHkF5bMG0feIpgv1RiUVDflbbXcIbXrfABstl6try8UgyM5xqI=@vger.kernel.org
X-Gm-Message-State: AFuF++kHk1gMNE9R91pjXFCRK8cyS5K5OIiCPJ9wy+1TONF1GM3gKSu3
	M2UHbGbDnO/nMnwXd1HAIN0e2tgz2AD9M1czpyGu0r0LvsWcct5/wWP0cUcJ6U8wyMME0EIBhGQ
	O5lRGCiyGOjBBbXOYFkLEFgCj/VhsuhisrXgfbCMn
X-Gm-Gg: AR+sD11JJWPFjLbbGh1BVtxpYRa1Qk858xhUK3rFB92eKoOOijgMqF80h6TqtOgpGIy
	CUdU1nbHjyDzHeLjkjWSh05mD63trUE/JYizofMDIMNLTjWJcle3pdLYQCEWOIk1xGMH4Lh+0JE
	fQI+IEqdTxGXR/tIw23GOY93DMCQeRxr/yjofDlnPGPmYyAP9Mt3pRkv0e9MqctxZEdlnglyTCu
	BNsQ1BdjbXnFp1J1YKmS449kLhOPnPWbvLHpyvOjJktIRSK5BC33t1LXN8PmAZz5QGwZTXcyIdP
	/owqgmgGBeGeYOkSV/9cwCct+PhmrdMSBg1H742aSLmHJFhB+R0EGV8Wt6wacU3qM6vBxQyp/pk
	BhAd5hh2iyH7XUKnna9aqYQAloqmV11ncJk3ffqEBisHh3P/jIqlWg5B2
X-Received: by 2002:a05:690c:e188:10b0:821:2f24:5a42 with SMTP id
 00721157ae682-849f782f130mr62895847b3.25.1787578728765; Mon, 24 Aug 2026
 06:38:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260820220210.3122690-2-Jeremy.Jean@oss.cyber.gouv.fr> <20260824122706.GR265046@horms.kernel.org>
In-Reply-To: <20260824122706.GR265046@horms.kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 24 Aug 2026 15:38:37 +0200
X-Gm-Features: AcwNN1V6t--ufb5SOU1mwTwG8o3UkknUrnFTGC33fAAW3Me0847rV0DjJB36GWI
Message-ID: <CANn89iK3kYytLOn+RkxsCsdwC+GxTGgDeyhhZ230jMSeyhXr1w@mail.gmail.com>
Subject: Re: [PATCH] net: gue: reject invalid REMCSUM offsets
To: Simon Horman <horms@kernel.org>
Cc: =?UTF-8?B?SsOpcsOpbXkgSmVhbg==?= <Jeremy.Jean@oss.cyber.gouv.fr>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 24, 2026 at 2:27=E2=80=AFPM Simon Horman <horms@kernel.org> wro=
te:
>
> On Thu, Aug 20, 2026 at 10:02:10PM +0000, J=C3=A9r=C3=A9my Jean wrote:
> > The REMCSUM option carries an absolute checksum start and checksum fiel=
d
> > offset. gue_remcsum() passes them to skb_remcsum_process(), whose
> > partial path stores offset - start in the u16 skb->csum_offset. If
> > offset is less than start, this underflows (for example, 1/0 becomes
> > 0xffff).
> >
> > A forwarded packet can retain CHECKSUM_PARTIAL and reach a
> > NETIF_F_HW_CSUM driver which trusts the metadata, leading
> > skb_copy_and_csum_dev() to write two bytes about 64 KiB beyond the
> > destination buffer.
> >
> > Reject reversed tuples in both normal and GRO receive paths.
> >
> > Fixes: fe881ef11cf0 ("gue: Use checksum partial with remote checksum of=
fload")
> > Assisted-by: Codex:gpt-5
> > Signed-off-by: J=C3=A9r=C3=A9my Jean <Jeremy.Jean@oss.cyber.gouv.fr>
>
> Reviewed-by: Simon Horman <horms@kernel.org>

Patch looks fine. I wonder if it would make sense to catch the issue earlie=
r in
a single place ( validate_gue_flags())
