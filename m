Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AE492DB7B7
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 20:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781210174; cv=pass; b=pYb6xYsP9IQotXIpgW+uoQibm2gsApqeB3yJrJ7CQSLoJuXB03HjQRrfaNVFnPfZlLbtEsifqEylkjPSd7aQ9ridDczMF6ebtr/ETDmhICK4+wnnF8aO0Ajjq4lRVOCapAfMvhW4k7YWeeq1PdQXqWCvjthOZLuSRnuKuw1JCPo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781210174; c=relaxed/simple;
	bh=fHBU0IbhMdtCAj1nEhgINTHE+uyQRBUCmKIBL29z7N4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n/xa6AGhQKLRGR7xL9gAkJn7MMErmqug+tjF9DwQX2Zcj6hZiP4G1TJtUHeo//2O7xyPfUCrfV9y/N2jVFdZBya+VmKK9ojZ5XpWbgIVXEG+QhZATN2IwVrcvr3Gsp6E07TrwnE+i8Uv/8nX9i0Dn48LdzF8caYngxoH6Y7g9Cc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Mv7vp9iC; arc=pass smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Mv7vp9iC"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-51788280e71so2429451cf.0
        for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 13:36:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781210173; cv=none;
        d=google.com; s=arc-20240605;
        b=UrSu4ecOypSmU7YBYAJgKIvGfmqoN/rpPNi9r+XnUWsoXolFXIY9OYo7m7H7g8aGBK
         2+Jn1VPBEeo1V4V6As7ApXnfJfnZwhfih/TRwE2ozwgIJ3OhqSKW1ynbgA0st/kwlV0R
         glm09NVxIaCrPo/EKzFDKjVILVerbu4/+x4DJf8WRVFlhe9DLN4oxbKILUEN9Yku8yYQ
         OwpeuPE7CaHJvfaAJSAmZF6XtXAf5d7Xxnzep98ZC31T00Kv7eRenB2Q1nlyRwNirHYh
         5hXdvvwa/oJTF5PEYQL50849Fnka/Dzz4f7jpzH+eAdNhPuCWqbhAdJ2nuVFVZDwO5Sf
         Ekyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fHBU0IbhMdtCAj1nEhgINTHE+uyQRBUCmKIBL29z7N4=;
        fh=4QzQu2hvP6eVyKQ0khk/YewiNvshjPnjX1Nqza3aDek=;
        b=QzhAaILmHCQafHHQ2esOhn+Q5hgb7OVyTYSu0JA8rmFF6jG4l8jkRvneETlPXDnOEu
         JTVgF5dFx/OpS1fEKBlIfQagfMCBS8eEkZU0bjzfuzua/j42YVGAtglb/cf62viRAlTJ
         refAqoUG1WAJgB5JX4Nxgq19gkFoES2oL50UQpPtwzfgYyX9eTIaTRZRnDju9WGVC6eu
         Dz0udcGTsbKYR3p9cvGcIB+ut+HM+G2KzslAvdubLbH9Y0eAJ+vdtYVhBLjxa/WZnyc8
         GPiTbQjFKnbNjGZyrbPYIJLMyH+Zy0MwrKLJQiHsE2Uv9rs0GzCTZ4rodXZKlODHGdxu
         hGSw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781210173; x=1781814973; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fHBU0IbhMdtCAj1nEhgINTHE+uyQRBUCmKIBL29z7N4=;
        b=Mv7vp9iCEWiWYh3YQK1tyuh4ze2ZA7y5ZQefB0KfMYbm/cV5Va5Zv4+kZYJGu/qEIc
         VPfOlH82vJT4vds77JGM9o1lfs3iONjU2hMkVfs8iy7Qy9UJbj9UcTxMzjD7UmFxEI0x
         8M2+WbHjrySUFVQBh9DHOT9bfN42a3n85MGvC1tfn4Sw4ur0E1bUwqQP8Pm45rKvOaqI
         zgmY5gRP2zW+QfUSmQrr7TiRuEazp4x3b5KzoQjWP8pIgvRLFnr6bjSOvtAagnvXaL5E
         8DiTO30h8PknaF3kFXJd1EhdflqrqfoliLEmAQQ7dFBicd8pdeErQ67dYsLGx9QCy7Le
         GsIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781210173; x=1781814973;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fHBU0IbhMdtCAj1nEhgINTHE+uyQRBUCmKIBL29z7N4=;
        b=NI94DRLHvn2V/vP7Ts1DTA0ILQzExHnCeILxw7K5+Wrc0z4Nrs2c/3eaON/lDmyRS5
         VcMxZPCDZ9YzR5IsvvliqWGxiJ62V4dBXeoOQemyobPwIb6zWTl1TEOtgE3DNpSkU6vM
         cCTC3Q7Eh0oTWtF8eaPwk23rA0/hpy1YDNrCdsaTPP5mVIwXXpKVOUdAoc+Zt/UDgUWt
         FV/fEE/jol8NL7bNDo15Rxvny92kQYHsj0bAl1OD/ril7TkabeKRyS1rixrP6Zu4FzSz
         bmV5mrHoLW0x2eXz4mSjXEjs2HKunu5iVSmNsI4dOWlnCPd4/87V1yfpf5fj9HOmM1rO
         xUSg==
X-Forwarded-Encrypted: i=1; AFNElJ+AzqVufWy89tSehnVehc+JmW7+UHkeI7W5Cjb4zfUBq1SSfThQV9NDIUl12pTO7t4kZ3KVrCk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlAbQA8fjb3CMXxNsZNpBdKV/89HmIBLt380WjZxsaF1e/Xby3
	7SOoSghhidSdzezhfcYbcs42C7of3rDLU0rjYS4sfCdANyj+ljxAu7JWSEL5KvESpUkyMtVWLgn
	yw4alOlu97oujr/8ZgcLgglJZsxs1oWCDCkjR1MB0
X-Gm-Gg: Acq92OHaVHD54f8awhPZgEisoFNB5YBrt5tt5vbnt4dP1a8knFy2pbNdhFq2i54cSts
	TJOckvTrpZKcvykEK2ATHAxU8nw1ufjD7twqcKNAMTMwD8qPGoIVFBCd1wufxEwzf/k9iobd7bc
	I8XkPg8wASI5gO9myevqigFpAHEOAyciji5rs2M0fpQfnOmCQ7pUDxbthoabRiOX+p5G4Z86l6M
	CVk+tU+ZByP96HcJ0M1EozG8FiDoUYi+Am5zIRkM813S6J/NNRXbIVRVXM3KDi0neFuMK8Ry0Vz
	Mej2+SUvOMFXyHWXcvoAyUIO5o+1yE3MKpO8zSdviGrO/bybmK679cDRnqdYetnKe1oXPoeFVZk
	cEgrgTeV+YfgfzVQIoT0=
X-Received: by 2002:ac8:5d12:0:b0:517:a174:f419 with SMTP id
 d75a77b69052e-517edd1bbc9mr69665221cf.19.1781210171888; Thu, 11 Jun 2026
 13:36:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260611161504.228319-1-chia-yu.chang@nokia-bell-labs.com>
 <20260611161504.228319-4-chia-yu.chang@nokia-bell-labs.com>
 <CANn89iKkPJqOM=0KV8O8=2zWrZObj+E+VJoLztp4sUi7Vj0aQg@mail.gmail.com>
 <CADVnQyk+sOAKU_WtPja7_hgiXw8he9U1g6AY7iEm5q3F3R-Hag@mail.gmail.com>
 <PAXPR07MB7984D14DA66C0E4B89BA1D4BA31B2@PAXPR07MB7984.eurprd07.prod.outlook.com>
 <CANn89i+dS_h8_FH9KdO4NPu46VSi3uFZ3yGnA6AKD1UzMzySKg@mail.gmail.com> <PAXPR07MB79847E7E64F4ECFA0FC3A612A31B2@PAXPR07MB7984.eurprd07.prod.outlook.com>
In-Reply-To: <PAXPR07MB79847E7E64F4ECFA0FC3A612A31B2@PAXPR07MB7984.eurprd07.prod.outlook.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 11 Jun 2026 13:36:00 -0700
X-Gm-Features: AVVi8Cc1qElfZSwEp4ihq22L5tT5Xcq2RvWzms7w7c4PXXDizdUc9k1o8r1vTMc
Message-ID: <CANn89iJp3-EQaPcrFXs38t6yDO_p4BcSnsGR7FmOP6fRpoL8HA@mail.gmail.com>
Subject: Re: [PATCH v1 net-next 3/4] tcp: Add tso_segs() CC callback for TCP Prague
To: "Chia-Yu Chang (Nokia)" <chia-yu.chang@nokia-bell-labs.com>
Cc: Neal Cardwell <ncardwell@google.com>, "horms@kernel.org" <horms@kernel.org>, 
	"dsahern@kernel.org" <dsahern@kernel.org>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>, 
	"jhs@mojatatu.com" <jhs@mojatatu.com>, "kuba@kernel.org" <kuba@kernel.org>, 
	"stephen@networkplumber.org" <stephen@networkplumber.org>, "davem@davemloft.net" <davem@davemloft.net>, 
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "donald.hunter@gmail.com" <donald.hunter@gmail.com>, 
	"kuniyu@google.com" <kuniyu@google.com>, "ij@kernel.org" <ij@kernel.org>, 
	"Koen De Schepper (Nokia)" <koen.de_schepper@nokia-bell-labs.com>, 
	"g.white@cablelabs.com" <g.white@cablelabs.com>, 
	"ingemar.s.johansson@ericsson.com" <ingemar.s.johansson@ericsson.com>, 
	"mirja.kuehlewind@ericsson.com" <mirja.kuehlewind@ericsson.com>, "cheshire@apple.com" <cheshire@apple.com>, 
	"rs.ietf@gmx.at" <rs.ietf@gmx.at>, 
	"Jason_Livingood@comcast.com" <Jason_Livingood@comcast.com>, "vidhi_goel@apple.com" <vidhi_goel@apple.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 11, 2026 at 1:33=E2=80=AFPM Chia-Yu Chang (Nokia)
<chia-yu.chang@nokia-bell-labs.com> wrote:
>

> Hi Eric,
>
> Sure, in this case I will need to remove exisitng .min_tso_segs hooks and=
 replace them with new .tso_segs in the next version.
>

Please send a stand alone patch for this only, do not add it to a series.
