Received: from mail-yx2-f43.google.com (mail-yx2-f43.google.com [74.125.224.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D339154705C
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 19:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789673174; cv=none; b=GrgNLocwGCkthg3aHeH/nyYidKNclY11egndG4URqEWNF8nWAL9e9S7D+1hq6Ar16W06YMgeXqfOn3vQ7Sdp94agYBcz+3uQkDGvNajIRmoSAqZi41sRGD98eM/LVEb701fRPhjMJT9hmlRcFIBrVtYDZwwa6z4jCavb4R2K0+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789673174; c=relaxed/simple;
	bh=ZA4eQurhZTue/lbCbH0Y5YU902PcRfa2St/zYVv9wDg=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=taAJAcPBcsEbulr1q5njs94qy8uWTKA5OoJHCKxZ1JYCxUpKuaOm1GdvcSMhHlZCB/INr4V+Dg3n0qmndCh9xDFT7FYNXB3yCnFPVqxlW9AEbK/K1PjaK1qIY9S9ZU8llQS1cawSZ6UeEPMiU9mZ3vFXFhIox9PlQCajCs/IQLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pHRQiPkZ; arc=none smtp.client-ip=74.125.224.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pHRQiPkZ"
Received: by mail-yx2-f43.google.com with SMTP id 00721157ae682-85d46e4cdccso8812607b3.1
        for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 12:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789673172; x=1790277972; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ZA4eQurhZTue/lbCbH0Y5YU902PcRfa2St/zYVv9wDg=;
        b=pHRQiPkZU9zQqJ9UFKQ7jxuwdVQG/hMzGWA2CveN4ErSAYF9D1OHNOtc6fJvA6b4vn
         p2TDsIqLrc9KnuBp/tJY/e7aiX5MNzlEKfOS76y4TAvFUEuCRzDNTSAR+6TVt8C3o6Me
         15mFSuru7umZ8bRYwQdXhOWCvtJ8Jyx4PzbHa33trMIqlft+8GsIaZnLorbbEaTlqPyA
         Q6gWPkDh97gSEdXR5j0aw41EON/Yb1rrNqjNs3gBowlFG51udoagwqm4ejIPCKn36v6/
         nIBLYT55rhMD4z1CVQC455RvQAPZan+uvq/I5PjF/2a2MflgVwiA2/gucv4jePiO4umi
         uXdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789673172; x=1790277972;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZA4eQurhZTue/lbCbH0Y5YU902PcRfa2St/zYVv9wDg=;
        b=lIZyiasfz2N4UA3YLcrz4gyWeyzysuz+UVlh7FuxV5dPHlGlAmfFvQg3rZz5Yzqe8J
         ewrMgBgT52KZq1uNxRGSV4QBOtmNuXniBXuUAU6mLpFJs6AKGerGgKnEpqWkCq0MA5pT
         qePygLk/QIf8fLYCQ3aWNtX5gzeLggBFG4R0rCeCD8MDi6IOadlS0SoMr203QLVu9zjG
         YQZ+gQa/vXEY3RFWafIl+cu99/IxTX2HxxuWyJfZ9jcalihabgTgbjio1Be9BFdXaiqR
         u2lmgIZ5HpoujXc+9n+qIlaA/sOa2rkpf+pkBv25lCoyyZMC505OD4Q4I0c2YiYm8+3n
         G6kg==
X-Forwarded-Encrypted: i=1; AKwUvByMWyeFnjMgZOmJQXOnU+FjRNaOI/DFxpkppHlZoI7gsNULEjCc+69uc26DnfFP0+qCige4ogw=@vger.kernel.org
X-Gm-Message-State: AFuF++kxhGV65f7iLx4KC8JBlZmGsB0ngFkihUnc9s5Sx1l7j27lKI0E
	lrqAEaOadIAZ4u5UZRiM9RNApZYxHQ+3Tk2xFvodNJXCBGj12cdrYwOT
X-Gm-Gg: AYBFou2ok78HVlyN996v/ln+4Ym5PYRTpuYPoVLT16fXWXdawvbvJjqzGWOzKUKFMGy
	YJjU8rRSm+XpavDLR4WGXm43anjhWpQroqWzQUGQs8sImQxgDx7tRCe10qi04zLMScaeT1dk2Xl
	xvmL3DLNa/pNkdp3NoPVn7FtWykiTkzLyl3R3tHh4XFk7+k5ZFP+FVSUwHQjobynNBZQCqluSBK
	9FGSR2+NaSLefmXSCa5D8Za0l8/hYP+tNleq1ImNHloP4PD01C6eumNOD7gECCpXLK5qwppdnhn
	V7rdNUGydalinVl+DMU6BK96q+9ok9tOyzeMUe9fIfqAIT1Nol3BC6aPWrHKR+zx/C2f8wNTuXK
	fpaDMNIeiTUoW/IMxAsjRJI8NY1sXK0xahWvXBWVy4QYegBZ1mW8d1PGHUWE9T2ChZWNUAAL6fC
	A6R0pLFb9zj0NsW5bWm5BA5vUM1cecHlfxj+BCbu5ZTpFT3QDMNhbYOc72lA==
X-Received: by 2002:a05:690c:e3ef:b0:882:1d1e:d763 with SMTP id 00721157ae682-897318ac33bmr982787b3.9.1789673171679;
        Thu, 17 Sep 2026 12:26:11 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::4:5cf2])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-896c948150fsm2772037b3.10.2026.09.17.12.26.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Sep 2026 12:26:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 17 Sep 2026 15:26:09 -0400
Message-Id: <DLHU6VYMGPI0.GFOTZBK209C6@gmail.com>
From: "Daniel Zahka" <daniel.zahka@gmail.com>
To: "Kuniyuki Iwashima" <kuniyu@google.com>, "David S. Miller"
 <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>, "Neal
 Cardwell" <ncardwell@google.com>
Cc: "Simon Horman" <horms@kernel.org>, "Kuniyuki Iwashima"
 <kuni1840@gmail.com>, <netdev@vger.kernel.org>, "Daniel Zahka"
 <daniel.zahka@gmail.com>
Subject: Re: [PATCH v1 net-next] tcp: Set unhashed_state in
 inet_twsk_hashdance_schedule().
X-Mailer: aerc 0.21.0-threadmapfix
References: <20260917191554.1600494-1-kuniyu@google.com>
In-Reply-To: <20260917191554.1600494-1-kuniyu@google.com>

On Thu Sep 17, 2026 at 3:15 PM EDT, Kuniyuki Iwashima wrote:
> inet_unhash() sets inet_csk(sk)->unhashed_state only when the
> socket is hashed because tcp_set_state(sk, TCP_CLOSE) could be
> called multiple times, e.g. tcp_abort() calls it directly and
> tcp_done_with_error().
>
> However, inet_twsk_hashdance_schedule() also unhashes a socket
> when replacing it with twsk, allowing the socket to bypass
> checks for inet_csk(sk)->unhashed_state.
>
> Let's update inet_csk(sk)->unhashed_state there as well.
>
> Fixes: 8cc3aef0cb19 ("tcp: Do not allow buggy transitions between ehash a=
nd lhash2.")
> Reported-by: Daniel Zahka <daniel.zahka@gmail.com>
> Closes: https://lore.kernel.org/netdev/DLHLRA8GVI5B.2Q1IRQG5BVJNZ@gmail.c=
om/
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> ---

Reviewed-by: Daniel Zahka <daniel.zahka@gmail.com>
