Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B155F4DA553
	for <netdev@vger.kernel.org>; Fri,  2 Oct 2026 17:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790961847; cv=none; b=AtnnkBuBNlQmQD+KWLnEHY9E0Cp8ymM64lUk9q57NYLWrFMI1Pqbix9j5VxWtYX2PPIwE2A8KVf8EEg+rMSYYqNaWyv+mtnqgFrN7M3RJUR4ZD15YufuV2xaAQwxzR2qhbgJcq1vqVF+p7lk5L9zAcVUh9I1LmisSnYUN2IvBko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790961847; c=relaxed/simple;
	bh=FPYQuISaMky7YLIaiiNz5QfpvTQtPSB1hoAf3xcFbyE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dru6UY6n+BiOQeooWAmQSrz9zMf0H87aum7dCnePNpx0dKl1ZS1lsdR7osyt6YvrDWJs6YPR+uyN+F9As++MTo/2DVg0peecG5dG+3bjz9dYV6DFNjN9LBfPwt0W/ZB2PaxuXvFJdMVy531qZ+bIHPxVhSvBX0qSAkm54qOidFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BvWPCxuT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BvWPCxuT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C16B41F000FF;
	Fri,  2 Oct 2026 17:24:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790961843;
	bh=cPLUYYNFS1X341oiXPuNF8Ei+13R9WpmxANX1nIR6tA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=BvWPCxuTsPLwMw9Rq0j9h8JrtQ3h/tjrkICZDMP0y812qQ0IsrG0xOV4BRZH83Zxr
	 dYipEIIrJ6bnrxxJIzEZsYQoLgreUekrgWfYPg3s2Qkq+ksbb0lLHe+CcLSqorYoTC
	 bIAirAoOzgztl52/tqWm+D6jHt0bFKRtTt1wb2hi0USRtxsX2cPkmkOHp2rU53fH8n
	 uRjuPgAIF48CSldL2j8p+Al0glv5PNbFccgIgD7oYr5LBVg1N5WSj+eopffrsO4nzR
	 gzKbFL1F1xH3W8at4KphXW28jrDJrRZK8Bo4J0DgAxqxBiV+rflkPCnchEaO/AX0M6
	 OOn3KrvlUcJ0A==
Date: Fri, 2 Oct 2026 10:24:02 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Michael Chan <michael.chan@broadcom.com>
Cc: netdev-bot+sinfo@kernel.org, davem@davemloft.net,
 netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, pavan.chebbi@broadcom.com,
 andrew.gospodarek@broadcom.com, joe@dama.to
Subject: Re: [PATCH net v2 0/9] bnxt_en: Bug fixes
Message-ID: <20261002102402.37c89967@kernel.org>
In-Reply-To: <CACKFLimaQ93kqXsKn=VhaByUfsi51HEqjVmteNyPA0z4uj-4Og@mail.gmail.com>
References: <20260928041712.3467803-1-michael.chan@broadcom.com>
	<179056950861.31693.11019543022435274443@kernel.org>
	<CACKFLimaQ93kqXsKn=VhaByUfsi51HEqjVmteNyPA0z4uj-4Og@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 1 Oct 2026 12:22:38 -0700 Michael Chan wrote:
> > This is an automated message. This series looks like a fix, but its
> > commit messages seem to be missing some information:
> >
> >  - How the issue was discovered, e.g. hit in production, hit during
> >    development, syzbot report, manual code inspection, LLM or static
> >    analysis tool scan.
> >
> >  - Whether the issue was actually triggered, or is only theoretical
> >    (e.g. found by code inspection). If it was triggered please include
> >    the symptoms, like the stack trace or error messages.  
> 
> The ring accounting bugs fixed by the 1st 6 patches were originally
> reported by Sashiko while posting the kTLS patches to net-next:
> 
> https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260810051358.1244418-7-michael.chan@broadcom.com
> 
> kTLS needs to use the new MPC rings, so the ring accounting logic is
> touched, exposing the issues to Sashiko.  These are pre-existing bugs
> that affect normal RX/TX rings when FW is running short on rings.  The
> issues are real, but not likely unless many VFs cause ring shortages.
> Patches 7, 8, 9 are real issues found in the lab or by partners.
> 
> >
> >  - What hardware the change was tested on. For driver fixes please
> >    mention the device (and if relevant firmware version) used for
> >    testing, or say that the change was not tested on real hardware.
> >  
> 
> The changes were regression tested on the 5760X and 5750X chips (the 2
> latest chip generations) using production FW (237.x.x.x).

Hm, someone set this to changes requested.

Can we split this series in two? Let's take the last 3 via net and the
AI-discovered, un-proven (meaning - I'm assuming you haven't actually
triggered the issue) 6 via net-next?

Hopefully Pavan can adjust the net patches according to the AI review
while at it, at least the suggestion to explicitly remember state on
patch 9 looks trivial, on a quick read?
