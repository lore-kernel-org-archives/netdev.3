Received: from mail-pz2-f37.google.com (mail-pz2-f37.google.com [74.125.228.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6019245560D
	for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 08:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790671353; cv=pass; b=LG/+LsmO88Si2gznB0pqanapKD9YvfgJGaHeGSpsF+cg17o3pZZR1th6xRJ+aG+sYobnBxK5FQlM1ucEKEyyT25WxW7Fbss05yyuA8/xP0R2aCfBeN42BpfpNfj/bV0kPt00dfhlB3QOUYxuGg8xhXx5SRqAGOFPyE+Z456Cj8M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790671353; c=relaxed/simple;
	bh=cq7rlocm9HRXN1IEydAK9bOdaq/peVOU2getKJLN7Kw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IimlcKaugRMD2Sxx5NXnSU/Tt+wBPDGZ0f9wbVUEkecH1/uIFVN6fkiBkHEHA8hXllQJRY5SR+ZuJvHX0Qk2/Rjz+Gb+jWUTKm/oY2QzmoovD8jXhhA+rarVKaQLbMGKFW6WSV5Ycwd/0ndsO1pRdU2WFbo7gaX76e3Q9H4nN8I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=eEMrJF6e; arc=pass smtp.client-ip=74.125.228.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="eEMrJF6e"
Received: by mail-pz2-f37.google.com with SMTP id 41be03b00d2f7-cc7cadbe09cso107408a12.1
        for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 01:42:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790671351; cv=none;
        d=google.com; s=arc-20260327;
        b=NiFmpw60mKE2V/VgigVNPLgWIMKdGwwozi1AeqK9Z9WR2+1NCfkx469/f5fTpU/ziy
         Eqtf3l4mfRkN965ZyVjMxLwsfBNXtHotdqGr03xISUPimD4IG+YMWx3CTj6nx5pXBqYo
         d1Ujed0UnyOzvn727p6os0vXNps1dCQ5OR1ZW9qAFI/6TTg3GI8UVWMFFzZmS+Swhp6M
         UVhsgyZabf6mqM/E+qCvXdB1LMkXBO5bp5d4bYrHHS06RWSzor+iyBIupgccG8sw1rzW
         puCuTVu/slSkmfmRZeR22Ute/SfnFQCgzucEalgZio21Hwa4ztYvIe7FMwlRYcvfqLUD
         nVIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cq7rlocm9HRXN1IEydAK9bOdaq/peVOU2getKJLN7Kw=;
        fh=iaTtnU9RpKwtOuepknJN0ZLCFPOnM+r/fWSzo2OXjCE=;
        b=kM0NyAuHTHTKroAPOn4rzk8aeJfh+qzdwyU8vXlJ3BAEmzVxoUOFY4EE4FenaxciKh
         YW9CSz8aYzIYqiWYduaJfM3EEAJV/VTTgSBzE5jTClqXxQdJGK6sdVQHHeR7ys+aaPeu
         6wMbCdXIh9a/COMTlGBddAFZ4oM1JyrJ3SE+UCw+XX7HQm3QU2C+Btj1GFutdEwepdyx
         3BmZKj8MDQZRJIKH4W4SsvPgoqkcE60EAh+/iRVPhJgG1fexJwbPE2x9PWTUJTNvcuHz
         68opOmy7D9L99JL4uliYbGaHuuj1TFmjt6kaYVfqd1aFOGsY+Usnb/mJ07G9xn2SHMQn
         Q7mg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1790671351; x=1791276151; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=cq7rlocm9HRXN1IEydAK9bOdaq/peVOU2getKJLN7Kw=;
        b=eEMrJF6eBn3mLB0JLeJrZJGysrjBDHsAXVJp2n9NxYOSwRyreWRQErMoFjrRngE8la
         LgUxmZKKxDPpZeEj14if1Z08DTwVKvIjoo+IjE751eUyjSDHoCBUcz28T+1klfd6P+iM
         9Q6ebo3HtK4YfzmyedUpVUe1BwXzO8CT/IMfI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790671351; x=1791276151;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cq7rlocm9HRXN1IEydAK9bOdaq/peVOU2getKJLN7Kw=;
        b=b8nzZmqufXiHWkd1csMkWZFuy/2ArqyIA4+3xp+kvT7c0PW4s8MjfRsoiHJyGObG34
         /5GZw0iqHK35Op6px+kBKpfOZIabS+r+07UdTMzprTNou6l92mvGWjDumPcwFc74suMY
         DNrRb3C7DwhGCGJcQDPyCTpRDbDysPhij8qL3B9/R/DW5nH7bOMWZjy347KIXGpnPQBe
         l/KXj2Djqfvno9YiFI+FSAaVBgK6SGH2+XvXzLj0YGT1yr+3SRP1WAeRwkuoB/Ox2uJS
         cORxU3VGPW1sEPXdAd9EHaiu1AKviWeEZYvIPIB+WorOKca5iWPx/q7TjgeSnVsE9uG6
         cvXw==
X-Forwarded-Encrypted: i=1; AKwUvByfIN93N5bDw7Qulx/3gp6Efwyf7opPEpq94bcDwXnykJhCfRxgLaIBQn5g4qv8QGjhwztob+E=@vger.kernel.org
X-Gm-Message-State: AFuF++lW4xHCKUiUvuM269gFm+C67lmdzN/Qa3SOyEP/sx0HNo2yQqV7
	3kh1ZX7+BqqbRALuyj3eCqCynVUejCiJmIhZGnG+4IjPeUMikvq0hVfh3Xo3RJn9kaVX2N4oJ2x
	kv9T06jGIC7wfBEBAIJd2+CVJLfKprTm20I/wC6Gd
X-Gm-Gg: AYBFou0GK+37f9CF5e1owSnQ3MHNwCxicJVPsfEiiv2zO68hZSGILb9jDmyOTwDF1Xk
	NrYTmpuVrll9pLyQ1op88qzAIzE2oJ5Al/nrAQaw4Z4QqcKo4VBsYoC3xFpAJmCHGRyTaxSgScx
	LDtEfc/GTEG7smO2Y5QGM3jg4L4MB2o2RYdyyQLDI/h4KULMxrIwt5zM5o0jqNBXF26IKflq3lj
	wpJdQRoKDtm57eCxUFAEbPHBHx3o7jnryGZukSIhse4zLDTLfSI+pM+TWY58CvnW31lSMURJlq5
	qKZmrd8ZKy4WODIoo4qQLeXOvK9kosz39/WwdaJ1BXB9489UKb0p3o/2RGZBETlNmEKMi/KhzpR
	lz+janR397cJbfEHHkMAgOrW2UZ9X86pSjQ==
X-Received: by 2002:a05:6a21:e44b:b0:3de:48ca:c565 with SMTP id
 adf61e73a8af0-3de48cacb7dmr5733871637.35.1790671351647; Tue, 29 Sep 2026
 01:42:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <QDISC-JCOT.v1.20260910090924@mojatatu.com> <20260925171834.73b5b367@kernel.org>
 <CAAFAkD80zx12Cskdf8NaF1pkSbLUiYSeTEmvpSR8o6P2d-JEOg@mail.gmail.com> <20260928174738.139f1365@kernel.org>
In-Reply-To: <20260928174738.139f1365@kernel.org>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Tue, 29 Sep 2026 04:42:19 -0400
X-Gm-Features: AclHuK9fNJKv-Iie2v3MeKnPc47Kd4hGdm_wSNDWT2mtNgLBv9kBpPijpby1J_Y
Message-ID: <CAM0EoMnqa-K+jR9S7Y7o6PpEnQubOPWqqkxB9qVsTBhHPb5qAg@mail.gmail.com>
Subject: Re: [PATCH net] net/sched: cls_api: reclaim an empty proto on the
 error path
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jamal Hadi Salim <hadi@mojatatu.com>, netdev@vger.kernel.org, 
	Jiri Pirko <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Victor Nogueira <victor@mojatatu.com>, stable@vger.kernel.org, 
	Sashiko <sashiko-bot@kernel.org>, hybris <hybris@mojatatu.ai>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 28, 2026 at 8:47=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Sat, 26 Sep 2026 05:49:57 -0400 Jamal Hadi Salim wrote:
> > On Fri, Sep 25, 2026 at 8:18=E2=80=AFPM 'Jakub Kicinski' via Hyper-Yiel=
ding
> > Back-end Review & Insight System <hybris@mojatatu.com> wrote:
> > >
> > > On Thu, 24 Sep 2026 04:32:49 -0400 Jamal Hadi Salim wrote:
> > > > Tested-by: hybris <hybris@mojatatu.ai>
> > >
> > > Please stop adding these tags, they tell us absolutely nothing.
> >
> > This says that our _automated_ bot tested and it adds the tag before
> > we send the patch.
> > It does more than tdc for a specific patch set (e.g., PoCs for code
> > paths not reachable via tdc) and it does find issues sometimes before
> > we send out.
>
> My main point is what I said - it tells us nothing upstream.
> It's like a gerrit change-id tag, internal to mojatatu.
>

Fair enough. The idea was to provide confidence that what we post is
going through some serious testing.
A couple of times in this flood something slipped through that missed
a subtle test (which resulted in a Vx) which this bot doesnt miss.
So implicitly i suppose it means if we dont say "tested-by" it means
we hae tested it?

> > If a human had done the same, wouldn't the protocol be for us to add th=
is tag?
>
> LLM !=3D human.

Well.. this specific bot is mostly muscle (scripts) than brain. But
let's see how long that " LLM !=3D human" inequality lasts ;->

cheers,
jamal
