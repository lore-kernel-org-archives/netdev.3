Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C2683B14C9
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 05:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791437697; cv=none; b=FQCbWcevN+FzW2+c567yNzjEMgaWdezjbGWVHI3JIQt0JNe8Nv4uDMGz3ge0IbYQgZN13zKbYpuEVgZtneZl4fBIYb8z2gqnY+GhR5SOE4ziwFASqlvFVY0NmJ6MuIWKb/V/k9CzRJMOS8OpyRPE2+jdvB4mbxObqHmQMUdHPE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791437697; c=relaxed/simple;
	bh=9N1Z0bSFRifTcCgGnAazgNApIoFDnssI5YGdBPcOh4k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=euZefruWCznXY+zpji0jk/FLRn9Q3uiPLqADvaEbGDNn1Ofh65AQ2RQ3+C4qF6BJ25O/b3qeGj6j4AJIV+KilRqJhqO8wN6f5ukduVal0/fa5KTHieAvktXdJILRR32dPVk+6LIeo+xuvrxBYnwsdxm6bFW6ndDjVdYE3y8xHMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fjv4Vzed; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fjv4Vzed"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED7331F00898
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 05:34:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791437696;
	bh=Ueg+nCAvFLpl6p6BjRN3zGaipJJqpL0in2iVc3G7fQQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=Fjv4Vzed0dr5apTanU1/roIEhw+rifdTe4GmSHRP9Zy/lGN/4XI+Tx2FauMx6xjy5
	 psO7Qfc09Gh4+7mbNn8t8x/Fcs+Y2y9KnW7WS2G17dU1DNEgZsZhmjXxISAs0YNFDt
	 bxmx3DVm+J9y0RNZxKvAuQMYW7i5j/3ffRmboPZCYCrFG1W6/4jYrBrdTGwaPHLUHq
	 IKFZWVSrTNTvasmfcMHxQESxHElAhGj1m9C2aOvI6PR1vH5uoVT0Z9kXN/AQxUxB2o
	 JEM0TXWwibEHioMiP5s//XFQEu6gXoXmwPWwbb9vC7PBGbhTxlupSjPNXdYv6zJs7z
	 B+9pGwLni8wVw==
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-48e9476e26aso848697fac.3
        for <netdev@vger.kernel.org>; Wed, 07 Oct 2026 22:34:55 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBzM7VGouanUyPYEd4ksTOM1AG6wv+cVHUdUBspLTlnDW4GbGg9Z1ebhtUqHwk7ys41oQvZIscM=@vger.kernel.org
X-Gm-Message-State: AFuF++m52jJlvkXV/d1pCypcMLUn5aviNSQorAOj2KY7dcHcxMCB6C3v
	MB6edd9dFaMrkQEzjgLOgPwavcrR/rqbkDMyWofSQnLLu5Z5VU04xpCJ+5oPBNwKQFvFV4Br8dT
	6qDemSdh7PEjOz81GYv2sOHuxIiPmswI=
X-Received: by 2002:a05:6871:3401:b0:48f:e116:db7a with SMTP id
 586e51a60fabf-4a259831150mr3956877fac.56.1791437695262; Wed, 07 Oct 2026
 22:34:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261007045616.445596-1-edumazet@kernel.org> <179134921160.2527009.6970913813334453403@kernel.org>
 <9f688c24-488a-4862-b8fa-7a34750285c5@kernel.org> <20261007175641.2fb7c38b@kernel.org>
In-Reply-To: <20261007175641.2fb7c38b@kernel.org>
From: Eric Dumazet <edumazet@kernel.org>
Date: Thu, 8 Oct 2026 07:34:43 +0200
X-Gmail-Original-Message-ID: <CAL4WiiomZCPT3dM5NO2FHQ5JRVcvAOOyCKSxc6kAWqe034V5zw@mail.gmail.com>
X-Gm-Features: AclHuK-c_3A9-WT6HHeRNgKT0ysMEondmr5PROAFy2NVne25GtSVuE83TIuOjKg
Message-ID: <CAL4WiiomZCPT3dM5NO2FHQ5JRVcvAOOyCKSxc6kAWqe034V5zw@mail.gmail.com>
Subject: Re: [PATCH net] flow_dissector: avoid u16 truncation of hlen in bpf_flow_dissect()
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev-bot+sinfo@kernel.org, "David S . Miller" <davem@davemloft.net>, 
	Paolo Abeni <pabeni@redhat.com>, Willem de Bruijn <willemb@google.com>, Simon Horman <horms@kernel.org>, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le jeu. 8 oct. 2026 =C3=A0 02:56, Jakub Kicinski <kuba@kernel.org> a =C3=A9=
crit :
>
> On Wed, 7 Oct 2026 07:03:16 +0200 Eric Dumazet wrote:
> > > This is an automated message. This series looks like a fix, but its
> > > commit messages seem to be missing some information:
> > >
> > >   - Whether the issue was actually triggered, or is only theoretical
> > >     (e.g. found by code inspection). If it was triggered please inclu=
de
> > >     the symptoms, like the stack trace or error messages.
> >
> > Changelog stated: Found by sashiko while reviewing the commit above.
>
> FWIW the AI is asking if PoC was constructed to validate that the issue
> can be triggered. I spent some time polishing this message but it's far
> from perfect. Not sure how to make it clear & concise :(

I was planning to extend the existing selftests in net-next, would it
help to mention
such a plan/followup in the future?

Thanks.
