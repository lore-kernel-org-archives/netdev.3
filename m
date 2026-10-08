Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B19848032C
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 12:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791463643; cv=none; b=UCW2tyr0vZJbkLkCKII6RAmQ6JfKcF1i3xXXNwKDYJpzSfFt0lbYxPUKBzJLzoh6KdPMCmETopqV8/FiEncJnqnT83bUYdUbbGSukQXPKi7FQqCpgfuaLV4Ss04dE3YYyih7d8Rnpd4Qv57iosss5JhJBpQctNd4E2RBPajouuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791463643; c=relaxed/simple;
	bh=LlMO6iQODPUl//akDACh6iLTLYAzcsIkYiJxJNtBM6Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YEpseqzNE1z1QbN5fyOritV3OGBOv1TzaZuGjc6aKq0tupzaq+aoC4gxBnIzWfC97QDR/fxQADpeiY8ujvcqOfOFTxeu75VV3TH3VnB3KABNodUXNzQ8PWHb/3N5i2TrS13f40bdjIwqXiU/s7jvafskZiPeF1w1bN2CoOZJ7aI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=KhzO33ny; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="KhzO33ny"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A692A1F00899
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 12:47:21 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=zx2c4.com header.i=@zx2c4.com header.a=rsa-sha256 header.s=20210105 header.b=KhzO33ny
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1791463638;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oxDOQiXRdTnPHTu6HRM1AHIJABx+3lat/A0hYbuPbLI=;
	b=KhzO33nybonBlNRJLBIBENyzXSq++HOjT7obPD9vEDGQThqzbzUGjpGRvYNkkXR5DVmM0f
	nys1Dfo6vMrUzBQJStS7drTEvh16xEXLR81plcmv3/uoHV2BKtwIkLFQnPtfprZm+sMfvQ
	lNZmLxKUdmFOCgX3Phoz8sGUavIgGPU=
Received: 
	by mail.zx2c4.com (OpenSMTPD) with ESMTPSA id 8e64cadd (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <netdev@vger.kernel.org>;
	Thu, 8 Oct 2026 12:47:18 +0000 (UTC)
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-c3156e7705cso608596766b.1
        for <netdev@vger.kernel.org>; Thu, 08 Oct 2026 05:47:18 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBzwzMG7339f1R8erLAMcYTuX5Promh/NO2WkLbbob8BCflnd8Q9kb6Z5XQm0ARG7ehyIeRwnXg=@vger.kernel.org
X-Gm-Message-State: AFuF++naP/bHjaEi1+hL6Fx3H6CtPxXIEplrHB+LbUO9TNdFa3jZeo7n
	BJo6QeRrUG2LHIy20GoqftLdE97VjieFwgY8+/dAZ0FiIP99hRyP33tmRMA98fvC5+5RzxJt2HL
	lMRacM7gORBgyKCVTLb7eXTwERlM7tWk=
X-Received: by 2002:a17:907:6ea8:b0:c2a:704c:8c8e with SMTP id
 a640c23a62f3a-c317bd901cdmr531801466b.11.1791463636243; Thu, 08 Oct 2026
 05:47:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261008124106.665014-1-Jason@zx2c4.com> <179146356621.2527009.11001901701574636880@kernel.org>
In-Reply-To: <179146356621.2527009.11001901701574636880@kernel.org>
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
Date: Thu, 8 Oct 2026 14:47:04 +0200
X-Gmail-Original-Message-ID: <CAHmME9rypRmL0tA-20vJumRBckpbzEaBXdE+xhMqi5M5OKPFhg@mail.gmail.com>
X-Gm-Features: AclHuK96wsj5ZjuVQ3gcwk4j3i0Tl8rQf2A9V50RB91AIzVaSRqAPpdX4EdBA54
Message-ID: <CAHmME9rypRmL0tA-20vJumRBckpbzEaBXdE+xhMqi5M5OKPFhg@mail.gmail.com>
Subject: Re: [PATCH net] udp_tunnel: drop packets when hibernating
To: netdev-bot+sinfo@kernel.org
Cc: rafael@kernel.org, lenb@kernel.org, pavel@kernel.org, 
	willemdebruijn.kernel@gmail.com, kuba@kernel.org, pabeni@redhat.com, 
	linux-pm@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	=?UTF-8?B?SsOpcsOpbXkgSmVhbg==?= <jeremy.jean@oss.cyber.gouv.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 8, 2026 at 2:46=E2=80=AFPM <netdev-bot+sinfo@kernel.org> wrote:
> This is an automated message. This series looks like a fix, but its
> commit messages seem to be missing some information:
>
>  - Whether the issue was actually triggered, or is only theoretical
>    (e.g. found by code inspection). If it was triggered please include
>    the symptoms, like the stack trace or error messages.

Yea, I really have no idea. That's for J=C3=A9r=C3=A9my to elucidate.

Jason
