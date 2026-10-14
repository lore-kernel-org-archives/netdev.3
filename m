Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A87B23E325
	for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 19:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792006790; cv=pass; b=J8GWQIUDLBbvIvNj8H6x4ETEIe1e2JDsK/fd+uRoQEMO1aIbBrUldc9lcLmCpBoYCPJr92h8wH5oShWykDqox7JvnTYrIIHB5H5jdsVeDNYlzfMTOngyMbQwfHMgdA/2N/APV9S379vDBDOdOrwPVMmV2+fIfW31EvGe0I8qVJo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792006790; c=relaxed/simple;
	bh=eJFElgSXUJujuFS4iSbIYgdO8yAQihmg+DEkh014jp4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rvwF0UsKa428YD97WnBSLCl2yZjmeWS94cmIZobhDSQDg31TVN9xGm94XpIguZd4HkF2f/rxCYOyJt5pzbOQr6CsXzEHhIINscbgpqKHhVr1LDbSfmsB5Cl+3Qwi5AGIgR4Y5Ys2GqfI5uq3BbkOsEB3TpxZxDfWlvLG7zS4HHw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VVUzKd6K; arc=pass smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VVUzKd6K"
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-67699afea08so3738239d50.3
        for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 12:39:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792006788; cv=none;
        d=google.com; s=arc-20260327;
        b=kKbcNLBgGEGN6y9DL6BottIci3zElePOyb6sFBzG7o9x2PFpsHqrojU2E+xhihNwum
         W6sHEwHdPJqWcEuSEUHryVmEnxEW5xMxcFxx8F9VM5KwVSi2HVjdU+GnFeBPxmWsGtXD
         Ufe8djul1K7+arpMEonJn+8K+qt6e28K+GImCxgirJF5XrY3G1do3KZiO3vR2vOYqIv+
         ujEbwMdHPN1z6hItgvWPPEWqcfjJAUIKXiqQcAy9eqXkZn3bG7t5ZRXvtH2b+JdrU80o
         kd5lsZEoxPOcJIHq29uN9M4TZi0W0kuFLHRZCZ2QMPqePc50eYhMJ/+7mVRU4ymFsnJr
         QViQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2IO0j046R1JBih2lmjNwdbOGe71mIwkZVC39lh+ufic=;
        fh=ihzOX9/cKy6D05lDTNzdl7qZU5Y3pEnKSy0BAtCDgcU=;
        b=PTchtGDSRT/6hUFKT3g/MrN0ei5k/L5ZYxB0069VrGFr2onpaNSefrY1+kmqmQvw0F
         f1w3i8uZ+tQFFJeBZF6YvXIk8SsEpsFhjh/a4f2AdMcmGY6snPqifweDOp747z1HCZ1x
         Z0/Q+AIJBYQZSrE6STfh/q8No7vxAFTTT9g4hnu6Y/wbALf1I7Eg7ys1/N7L8GM6tUm+
         850Yx8bQrlwNjZqJEQHbpZ3L6m1EjAa8nE2vCDU0XYaIl5croxPhFLZJUkqfz2VsdE5G
         AhX73gOgWlxV6NchS+pxIDUbUhde4O7dDlwMXzLLkfkLeb8HVeg3Qia0dj9J58BCBk5q
         mWig==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792006788; x=1792611588; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2IO0j046R1JBih2lmjNwdbOGe71mIwkZVC39lh+ufic=;
        b=VVUzKd6KIr/CGShJv9Y+pAV1+MY+HVsIW0ehxPdGfpSnozQA1bQQCCTZfBlI3DooPO
         RfSi9bke09gvoo3qjCA7IIZRpjD780POw2RJqqXDAVSsVOLFi7g/oVfpOuQyVysUSFtR
         v6GSiG3d0Hub7SnF4KR5XLlj+ak0euwcF6Ohz9W3McrciIPizb+AzFr0scGS1anELlpp
         U0MkQ7gk80RjNTGXI4zhWQJVtY1CWHMrUF/nyK5UUUuGjeTQbrs9rn7IsbvvKfAF1hmU
         eAImI6sYWal8m2mbgVUxaj3rhZdn93N5xVgYHqW7H0bDZNJa0VL0ZxDe8vZSt2+L1lAa
         4VKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792006788; x=1792611588;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2IO0j046R1JBih2lmjNwdbOGe71mIwkZVC39lh+ufic=;
        b=PMh72UwokrF9MCgZyqrqvw+TqL0gexEUYOBJqA0N85+kG6O1mgyBwENd/9EFun4S5G
         Obcrg0kwAYnCeZbtfJnWDpXfJCymlgaitgaboRc4wy/YpuwMSO9Tgee+q9aLi8T4ZQ/A
         jDb9Rck6g58ihwqTf6/ugUbEDMGrl/fWj1mM/tfTyLOqHGnmab/11+BmqCTfUVcFzFu3
         6FF5g44nbFfrcR/f17worFjDkHPseR7Tz0D+Y/yuZo9+V3o3L5s3KpH5gDyrIuS+KLIF
         BZwcx6xGmUw4C7VokpmaLmVsi9SR73hC8z8KuTcW9lxrhVD9k8eRFf3r6UOaw/LiMCV7
         A+vg==
X-Forwarded-Encrypted: i=1; AKwUvByLxt+XBBb/zAjqntQKVTn4aqEyjKQchj2ERwwoeuqukm+aAfzHqkViEZQN9w7FSq01oKEcOXI=@vger.kernel.org
X-Gm-Message-State: AFq9FYKrmwXBeBX5pkx9cmAGklSvrZvP6nLwTDUIWyYY0vmpQLe+bb3z
	LspokKya+18JrHyEcSZ/bzXrH0idpVUXc3lwoQZZa6SUy6jkdeAUFElZfVm/6GfZf1mqRAHKiaN
	EOCrraQ6PWJHhzu7EI3daw+OvJk8lvYJEJA==
X-Gm-Gg: AYBFou2wi7IV7bFeBg7hzXjszO7vF0Phdc0e1C8SuyRC3ICVB0Oq5D/qItS5o+uR+c3
	/8bCHTiAGxqI/i4PFcxghrm5Wfvgc2GnI53Gxdas6WV/b+t5GoZUgNl0D8Q2H+soLG0DTCvteUK
	z4uUwTPcsnIQiysUwEoIBaRU4nwYDeid1aJkJoxQjSIexN6EIxqcqKYhpAJ7cFLmyCbAq2Ru406
	lhcb8KUo6gR/dZtGQ94Jvc2rIFDU3dvk8OgvyvPSxyAlNsdp+OcgGS8I0xKRyzncQemCa5AIMpX
	FxQXIcgfQTolV6nFMcwrF3nZHlUFS4hvpCvW8HAWP1iNGjwpuD3X1/6oes+luXURU0EsKxyt7j5
	CKSN0q1OTud5MRuZWjp11H9iiq01JAXrldb3wAymVhg==
X-Received: by 2002:a05:690e:1381:b0:679:9c43:8599 with SMTP id
 956f58d0204a3-6799c4388aemr182026d50.8.1792006788093; Wed, 14 Oct 2026
 12:39:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6acf2628.2b8fbd69.39ddd4.b35fSMTPIN_ADDED_BROKEN@mx.google.com>
In-Reply-To: <6acf2628.2b8fbd69.39ddd4.b35fSMTPIN_ADDED_BROKEN@mx.google.com>
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Wed, 14 Oct 2026 13:39:09 -0600
X-Gm-Features: AclHuK9O9xEtfZovC2yI34auhWFegKToVu2t4FvHh9BK_VNnwm2BJWgX248YCOQ
Message-ID: <CAF=yD-+EF6OfMY9Fsvbm_wAHR8Do=EzgB_7aRRA=Zq8YzcjcjQ@mail.gmail.com>
Subject: Re: [PATCH] net: tcp: fix fraglist GRO flushing on alternating TCP
 PSH flag
To: =?UTF-8?B?U2hpbWluZyBDaGVuZyAo5oiQ6K+X5piOKQ==?= <Shiming.Cheng@mediatek.com>
Cc: "davem@davemloft.net" <davem@davemloft.net>, Network Development <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

+ netdev@vger.kernel.org

On Wed, Oct 14, 2026 at 12:50=E2=80=AFAM Shiming Cheng (=E6=88=90=E8=AF=97=
=E6=98=8E)
<Shiming.Cheng@mediatek.com> wrote:
>
> Dear Willem

Do not send emails off-list.

> The behavior differs depending on is_flist: when true, PUSH packets are
> not merged, whereas when false, they are merged.

That would be wrong. The rule is that in Linux software GRO, a large
GSO aggregate may end with a segment that has the PSH flag set, but
cannot aggregate subsequent segments.

We have a testcase for this in tools/testing/selftests/drivers/net/gro_lib.=
py:

  - flags_psh: Packets with PSH flag don't coalesce

FWIW I vibe coded a test flags_pshpsh that sends three segments {
no-psh, psh, psh }. As expected, both pass.


> When is_flist is false, the PUSH packets are merged into the first
> packet, and the GRO first packets's flag is modified to PUSH. If
> is_flist is true, besides merging into the first packet and modifying
> its PUSH flag, would splitting the packets cause every single packet to
> carry the PUSH flag? This seems unreasonable.
>
> Would it be better not to merge PUSH packets?
> Or is merging PUSH packets still acceptable, but we need a more
> comprehensive solution to handle it ?
