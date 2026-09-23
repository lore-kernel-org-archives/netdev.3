Received: from mail-ed2-f29.google.com (mail-ed2-f29.google.com [74.125.228.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A2F047ECFC
	for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 10:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790160437; cv=pass; b=LrTpqzcimvMpwNqFR9zq3yMpGxIOdDzgi8h69kH5RrMxUIW09q7vhU1tMumN2rRKUkbnbQMyGNPshO95vUHqZyiM/qf6trL2T+49ZMYqyXToVkpwdqX/LhmAyAq2rS9lfLTouRXEA1tnPkXcmFh8lDDfEkylajFTRNPj3OWkpi4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790160437; c=relaxed/simple;
	bh=msXNh2HdDF+Lcwkkg4QxTlZJD2r8Tk8OINy7Tsecn94=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GjdeNObcCR/baAi2YYgl3ikyN+Bxuua7JuqIjhj8RE7QWYl1kYqHxUstcigsoJYXWjD0bq93N+jhX062AVT7BPwrfH+Uncwo+j+OrLfJEEjWTnlYnlv6k2eyscNZDjPByeArsEAnlVDUT0KwRYi8YAGgGzrTvzAf4DW2m75LcTc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kQKdV6bs; arc=pass smtp.client-ip=74.125.228.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kQKdV6bs"
Received: by mail-ed2-f29.google.com with SMTP id 4fb4d7f45d1cf-6aa0ee64afdso940509a12.0
        for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 03:47:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790160420; cv=none;
        d=google.com; s=arc-20260327;
        b=sd3QDvDHZJyJkOHcCeQsi0ZSdShPs0LeabJGIArPG4eVoKXB0sd8atENJsA69mI8iD
         5tKc9LdhepsXHggdfvkcqRk7GjSj6c0vbCmcmed73dySIODquNqNZbYNkgRh9OgBscwx
         Ix0bvzhoxPb7PmRTD5c4YmnsnROMpchDgjzIQrFzGJbmk/X46qRcxm+vyQpZqfpy3tOv
         +voG0lbkMsFLJI/WAvLxwy4sZXqJJSNOkK8kSq3+gnQKb+78C3tS1reGCd511tJV0WnZ
         HFvjUV2axNjdySUvderSJRCO9MdU1nmUSMSl524w6fuK+K8iTdrW6RrJ+HioeGvp20NZ
         HAfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZfsSpgY3gPhyjK/RNnQXArXZalYQBWjirqT5uOX4kmA=;
        fh=QFrmrsvyM5V+QerEndTn4Qm1IcebA/SerBtZwQXyNPQ=;
        b=T4ejFTwvx671xObDaGSMU1odJhyF6gge/0BUtRCCNVhiaDtxUv/3wrbMvHcKpycZON
         Ik39c5KjFIi1ItVyRtt25knwxNxzEnvQYiRkM4e48wAs0FqGFpFfFvIKWWo8unRsePOL
         ZS0R20FqJZiLBd2oLP1LfqMyC0QJHghU11sPRrdnz242N81kJcmNGTQa5RqQuiu7a9ng
         +ei9fhXk2Idy1HpE2GbpxmpnrcsEjzE3eIUkUuAlF9gRgYRft5+JAoox/q88L05P/CCK
         w3aYvupcpTLhiw/gt8Y+LPAjhwZYZNHE5li5DeTVtGR0KmSnPDLl3+9KQc3HAz/knahR
         dZrw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790160420; x=1790765220; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZfsSpgY3gPhyjK/RNnQXArXZalYQBWjirqT5uOX4kmA=;
        b=kQKdV6bsRTYStFuf/sb79Isub1vuCfwAelGS0hl94Ce6A6jL3anYn8jCqVDqsJTyaG
         md20uE13i4YlLkvs1OweYMianRl7M3phDYCZynSXENITpM8+xExagUWdU6qAOflCu96M
         KtrC+gwjKDUCopNNle1RfezPBXB4rUI1ZPUPjjQdSgnZl5Ubzdh/DuqeUbgF+riUnb+N
         8U3HWt+lmOm68wBTDaFsA28iwbgYNLyHYKar7rSgbjnMAzwC/bmkBlrH6jbT7s8wAHQM
         6+8kegr/+Lbvei+3BtFQDE+/+lbsOiCQMJciEdE97VjC1Pb+YN3rtTMIiYao6JvSpwFf
         2yDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790160420; x=1790765220;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZfsSpgY3gPhyjK/RNnQXArXZalYQBWjirqT5uOX4kmA=;
        b=ZS1h72J6go+ypY2BZKTOvpq1c2Ox2XC8n/ZvxXwpi7FpJm8gSqnpag0lm1AcvElhZn
         SIXJJr7m1po4Qqyz0iyDsSLIRWeHbQEB2Ci87lLqT9zJpEppP4sAo3gwN9+2DM/KhZXB
         Nl3IxqfV89EuILRZ9mS9bW8R0Gi8R28cJYmPagHhnDpi27wzwAUuK+bUgR4dRtn/6AMN
         8R+wwGdwvPKrFVCbxoaa2jcG3VuHHtPpMmvHrUkXA58Oef0BD6g1/gEHD3WDfv/tZysE
         dKYJ61dX8dIGgOHTLHj8v5skAWIVf4Ou+c567vF44s1mvDqhlpdD3x3uziODckSuSPx8
         naMA==
X-Forwarded-Encrypted: i=1; AKwUvByKfSvp6dm26CgLzVUjVlIxVZVWJJRo67uxfsl/xEs1e4Hq92C45BtzI8Sx7nwOcchfz0ZJX9s=@vger.kernel.org
X-Gm-Message-State: AFuF++m9DtcelArSPdDxmQJXQ0+zM3I9HYP7RneHlZSuI3zZ7F/5qllB
	WWSo+vkRvkEjIpFI3lHgjUV9tx/IME/inYjfUrEHKhU4x4qv8uXXdRzKUK6yCnvrXdjlDSz3JQn
	jAX9G69Dggb3IQTBdfOqkySjN0D6Lm20=
X-Gm-Gg: AYBFou2WdAJZEGeW1ePLr9qtaWkD9SU0sCQ56Cg1rxpUW5eqLwhxE3USM8iuYN1H1dT
	jW2ylXJ69Qt+8IZ0Z+932Zj1JY6XP9w8h5Ad2pItfdoMcZGNzyn+F4ok1rV2Uifbhr5xO4nSdY9
	4A9z1eAwjetU2WndWuIXOsAfXGJalih8iZfspTm87Bebt7Sc+ziOTQl7yvSMDqK6iHNW/bi5kzY
	fkNJhlkIplZ9FIXAt9t3tHyS6btx7cJifQScPOrC+cMHuYindEWKQqB8YfCAGAh0FCQe5NSNh51
	sSfcQuoZEFYW2ovfK1J2Zr37WYuD+y34AhD8QDQ2QMI4KVzbbeDtGshRryw5fP5sT+M=
X-Received: by 2002:a05:6402:1ecc:b0:6aa:734b:1a28 with SMTP id
 4fb4d7f45d1cf-6aab3b6db15mr2109299a12.34.1790160419876; Wed, 23 Sep 2026
 03:46:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHeizqHDqx3ue1=0QL92ef+6C63Ur+v1Z=d93smgdD5zTj_-Pw@mail.gmail.com>
 <arORyXjxvZUoEAIw@chamomile>
In-Reply-To: <arORyXjxvZUoEAIw@chamomile>
From: Subham Pal <subhampal789@gmail.com>
Date: Wed, 23 Sep 2026 16:16:48 +0530
X-Gm-Features: AclHuK8mzFXFfzSoA9WshHACP17UijNZVLSKFGyP537HiCjWWOCf0JS5ZMRW6Fw
Message-ID: <CAHeizqF--yGMCLGBEv9f7Gs=dmbZO6+DwSh7KZjpDgbNonCotA@mail.gmail.com>
Subject: Re: [PATCH net 0/2] netfilter: nf_conntrack_h323: fixes for NAT
 bypass and ASN.1 decode
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: fw@strlen.de, phil@nwl.cc, kaber@trash.net, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	netfilter-devel@vger.kernel.org, netdev@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 23, 2026 at 2:16=E2=80=AFPM Pablo Neira Ayuso <pablo@netfilter.=
org> wrote:
> I understand these are correctness fixes.
> Do you have a reproducer/PoC? Do you tests for this?

Hi Pablo,

Both issues were found while testing a netfilter based linux
firewall with communicating devices from multiple vendors
(Panasonic, PeopleLink, YeaLink and Plycom).

1. For patch 1 (NAT expectation bypass)
- Environment & Setup
  Linux firewall performing NAT between internal and external
  network segment with Panasonic, PeopleLink, YeaLink
  and Polycom endpoints.
- Observation
  Call setup failing due to missing conntrack expectation from
  initial Q.931.

2. For patch 2 (Failed ASN.1 parsing)
- Environment & Setup
  The same setup but this problem happened particularly with
  Panasonic endpoint.
- Observation
  Panasonic endpoint advertises sequence extension with missing
  optional fields during call setup. Due to misaligned check for presence
  of field, I was getting H323_ERROR_BOUND error in dmesg.
