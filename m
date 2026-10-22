Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=51.159.59.229
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792697690;
	b=WTTg744C7SCHtP7Bjra90XPJqC9sH6Uc+JGO/+mqUjy36/v9EJuw3bwSji03tFLbCeOU
	 IiVuFjjtdgm0KaqG3iz/sBPvJWg/3BTmeGdol++GI+2v/DYf8pB59KZm7lQGHqrM2BP/L
	 oXfAO/FoBp0RTW1iq/ClJLaKW30cZ72fzyWR0YdD7OEZUNQne7alJB8Sywi/U+nhi2cfL
	 NER3o+khQPgyvwPsGwfQGP9KFUy+1WQY2wZWUs53YDAYnjH0jtk+xHNt3226PmYv6NCbn
	 MwQbWAKl5dHsmH273WRsusnnkYrmIpnXtpuGjDi+KH6MjRd+DIobXV1v4JB6HAZxU3Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792697690;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=h1G85IXkfkVUZA/tNec504Gs/1liypAr+cP09b9m+ho=;
	b=L9/aqTxKZQgCNuFV1WjKuLNerDwtWjTzqB1TLa1QXAb+yP/AnNtsxlGAXb78ktmenFWD
	 ObY8+1idCGURpaxBE9o1Vu2VV4ydhyawHvmtZCQulEJ4htY0+uzf4iZSg7mim2yQ95KJP
	 qjrP1CvikLl+tBA/b8dL6R3vYPFd6WHfoLEnskvucIgOVAHZUIbrLH4gBCrskWESI7KD1
	 JdxREixX9GhNMECGZs9X9qE3gFA1dq047tRLEGIXHMI7Gd7SOPHjSVacCMqCXV3KbLR6q
	 vtHZ3eg5nU++ITFMFd8IDSyRApprOGg6L7XLJpGf4adlZuYqqNDYU7w6cZMwjQd6QBw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=1wt.eu;
	spf=pass smtp.mailfrom=1wt.eu;
	dkim=pass header.d=1wt.eu header.i=@1wt.eu header.a=rsa-sha256 header.s=mail header.b=aG6p4GxL;
	arc=none smtp.remote-ip=51.159.59.229
Received: from mta1.formilux.org (mta1.formilux.org [51.159.59.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0451606A31F;
	Thu, 22 Oct 2026 19:34:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A0451606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=1wt.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1wt.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=1wt.eu header.i=@1wt.eu header.a=rsa-sha256 header.s=mail header.b=aG6p4GxL
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=1wt.eu; s=mail;
	t=1792697686; bh=h1G85IXkfkVUZA/tNec504Gs/1liypAr+cP09b9m+ho=;
	h=From:Message-ID:From;
	b=aG6p4GxL8GZkdRGTMsVTYuby++dDxXIKXHepkMrLDapn43lfFkyYTiLfLGsXf/VVt
	 aA3WkUvNpmuqasDcbVGNm9ojF6sfOLd8HthO+aTitxX44s/I2Dv/iVZ9GvFFuLe1Ih
	 nPpUxuvRZwbaKCBQQpDKKZOcctHdYaIAkeq9brsg=
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by mta1.formilux.org (Postfix) with ESMTP id 47F58C0944;
	Thu, 22 Oct 2026 21:34:46 +0200 (CEST)
Date: Thu, 22 Oct 2026 21:34:45 +0200
From: Willy Tarreau <w@1wt.eu>
To: "zdi-disclosures@trendmicro.com" <zdi-disclosures@trendmicro.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Eric Dumazet <edumazet@kernel.org>,
        "security@kernel.org" <security@kernel.org>,
        "maintainer:NETWORKING [GENERAL" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        Simon Horman <horms@kernel.org>,
        "open list:NETWORKING [GENERAL" <netdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: ZDI-CAN-33367: New Vulnerability Report
Message-ID: <atplVXLEE_mNqhek@1wt.eu>
References: <BYAPR01MB3830CECF5D0871064C59BA0280662@BYAPR01MB3830.prod.exchangelabs.com>
 <CAL4WiipTihtytPEPj5cSY+=t9NwRwRTfUQ_efCSWPT7nQ=0K0Q@mail.gmail.com>
 <willemdebruijn.kernel.178cac71d218b@gmail.com>
 <20261022160251.GW2009045@noisy.programming.kicks-ass.net>
 <BYAPR01MB383065E105701C81A3D0472D80652@BYAPR01MB3830.prod.exchangelabs.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BYAPR01MB383065E105701C81A3D0472D80652@BYAPR01MB3830.prod.exchangelabs.com>

On Thu, Oct 22, 2026 at 06:51:09PM +0000, zdi-disclosures@trendmicro.com wrote:
> > > I had to cut this report. Way too long, I could not see a patch in it.
> >
> > Right. For future reports: please review the documentation on how to
> > share such findings:
> >
> > https://docs.kernel.org/process/security-bugs.html
> 
> We've probably submitted nearly 1000 cases to kernel over the last ten years.
> 
> How those cases are formatted today is essentially the same as the way they were
> formatted 10+ years ago aside from the changes you asked for in the past, but
> for the most part you've never had a problem with the way they were formatted
> until recently.
>
> I may be mistaken here, but I searched our mailbox and this is the first time
> I'm seeing the references to documentation on submitting findings to you.

As one having read many of them I'd say they're long but reasonably complete
in terms of descriptions, and barring the usual boring email-notice footer
etc they're not excessive.

What Willem's comment above translates however, is what we've been explaining
many times over the last months, which is that maintainers need a patch to
start from. Reading a patch is fast for a developer. Reading a convuluted
explanation of "if A does this while B does that then C might notice" is
much more difficult. Also keep in mind that not that many developers are
english natives, and code is much more universal than a given tongue. You
can more quickly think "ah OK I see what they're trying to do" while reading
an extra "if" block while a long description is much harder to grasp.

> We will have some discussions internally, but in the meantime, we will send the cases to you as we always have.
> If you don't want to do anything with it, that's fine too. We will release the findings at rejection, or 120 days.
> Whichever comes first.

The main problem we're having is that it's not possible to have anyone on
your side nor the reporter test a patch. But I won't rehash this, it's not
new, but *this* is what makes your reports way more painful to deal with
than many other ones. You (unvoluntarily it seems) act as an insulation
layer between reporters and develoeprs and that really doesn't help.

> Weird that Red Hat is on this email... Greg once told me he had no idea who those people
> were and asked that they be removed from security reports. I will probably get in touch with
> them again to discuss reporting.
> 
> We understand that your workflow has increased because of AI... and we are in the same boat.

Indeed but we also adapted our processes to scale better. You probably
underestimate the load here, just today we received more than 30 different
reports that need to be evaluated by people who also have a job and other
things to do, so it's understandable that they absolutely need to spend
the least possible time reading reports and exchanging with reporters.
While we're *reading* a report, others come.

That's also why we asked to systematically Cc maintainers (which you're
doing now, although I'm seeing public lists so s@k.o isn't needed in this
case, as documented), because we were spending 75% of our triage time
reading reports, calling get-maintainers, forwarding etc. We all need to
scale to adapt to the increased load caused by AI. And for maintainers,
many bugs look the same and there are many duplicates. Nothing more
frustrating than spending 10 minutes on a report to see that it describes
something fixed the week before, or that when they write a patch, they
get the usual "we can't test" response.

> The snide remarks and hostilities aren't new from your side, but we are doing
> our best with the people we have.

I personally have nothing against the persons we've been communicating
with, they seem restricted by bureaucratic processes they have no handle
on and are doing their best. However if you want to *really* help:
  - arrange your processes so that your reporters propose a tested patch,
    they're on the side where the code was analyzed and stressed ;

  - make it possible to exchange with the reporter. At least for some
    of them, maybe with a check box "Keep me CCed in communications
    with maintainers" and explain why we ask for this.

> I get the feeling that even if we were to update our report formatting to match your documentation
> It still wouldn't be enough because we aren't going to provide you with patches.

Sure ;-)

> That's just the way it is.
> It's not my call, and it's overhead we cannot support.

We're not asking you to write and test the patches yourself, just to at
least encourage reporters to do this and explain also why it's better
for the recognition of their work. We did it in our doc and it works.
The formatting is often wrong, etc but that's things we have to improve
on our side with better and clearer documentation about the various
possible options to submit a report. It just shows that when reporters
are asked to provide a fix, they're willing to do so. Please *try* on
your side. Even if only half of your reports came with a tested patch
from the reporter, it would be a nice improvement.

> In the same token, I know that you rely on a lot of contributors
> to get these bugs fixed... that's not lost on us.

Given the current load we have no other choice. Especially when many of
the reports are for drivers, protocols or file systems that maybe only
10 people use on the planet and cannot be triggered on any sanely managed
production system. Also with AI-based bug searching, it's very common to
see the LLM ditch its report when trying to write the patch because it
suddenly realizes how broken the report is, so that's a nice way to
filter on the reporter's side before initial submission.

So yes we're in the same boat in front of the AI cannon, but in the end
we have developers that are feeling that your service encourages incomplete
reports to be sent that do not follow our docuemnted rules and these
reports represent a huge overhead these days (but admittedly significantly
less for triage people than a few months ago, and I'm already grateful of
the progress you made in that direction).

Please try to push again to modernize your processes by involving the
reporter a bit more. You'll see that it will mostly be positively
received. Many of our first-time reporters come back with better
reports next times so I don't think we're asking too much.

Willy
