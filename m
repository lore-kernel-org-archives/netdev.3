Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A3523368B2
	for <netdev@vger.kernel.org>; Fri, 18 Sep 2026 00:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789692393; cv=none; b=bDzcADFqyF4dyWLLOBPt/uy/kF2UD+5YWgk/EnXdF+v0HcNzwy+F/PY4zMTcPk90M5iU30oZejXmpwQM3x6peT9CfDkS8TdTZuEF9przd4MlIRAsB34YoUWqt0NXkCCPQQkPCS1AkaLTFnkAX+wWZa+asUL6vN2bwOgD1gEM6V4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789692393; c=relaxed/simple;
	bh=y+KcGmpG4eIc5iIo0u/HkKgmSBIqucSdI/8b1DL2VLU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V3R5+32hMokUbnpdSSvsGCQMjv8fFLriaNMGejCFhg9/HUN6ZnIVpYyPyaGHDAKDiygclD5OstY+LZsMY2joQB3FKBeN8rV9OcK78gat7b0jAVSER8xRG5lU4adoZnrP29bx0DlBM1v1ZEsn7OQUnlQCXv7M3Ash0apKnY7CiBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j03VaKIH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j03VaKIH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB9111F000FF;
	Fri, 18 Sep 2026 00:46:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789692392;
	bh=y+KcGmpG4eIc5iIo0u/HkKgmSBIqucSdI/8b1DL2VLU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=j03VaKIHynUwjYg2Df2jGjP+Uf0e6NR5oUx4wpOh2+RW2sGXqcMiQGh1KfTo7Tw4w
	 uXbn72igD+0apTEK9YW4thnCqNSLcRuz95A/0KohSg2I6oX40Nex2DVhSnu4rylkal
	 tGyem2chyQiejadx7g12fkn3wNesT8sg7gZS9k3210Bkwzi7SW+YEvfGPTAUbbEgHI
	 sOgReamtGnUROH2a8SgyiJ1aOpd1XydiqCYuHEcXVORq8oU07sMhT1u/f5VZad3SUE
	 xnRl0eYJAnB8o+7zUv4qWriu8Miz+IgP0l+M60ZAu2cnTNYG0mqaCuefhV9SlM/MrM
	 rMvo8XnUcSLrw==
Date: Thu, 17 Sep 2026 17:46:31 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: Victor Nogueira <victor@mojatatu.com>, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, jiri@resnulli.us, horms@kernel.org,
 vega@nebusec.ai, netdev@vger.kernel.org, Yuan Tan <yuantan098@gmail.com>
Subject: Re: [PATCH net] net/sched: Avoid quadratic handle scan in
 qdisc_alloc_handle
Message-ID: <20260917174631.66cee526@kernel.org>
In-Reply-To: <CAM0EoMn1SkkC0goKD3-OreQtEwYbfr3zYJdmfrDf8HTdHWrNjg@mail.gmail.com>
References: <20260911133146.3440982-1-victor@mojatatu.com>
	<20260914191108.55a1a4f1@kernel.org>
	<CAM0EoMk7CZA2qAPEfvZ_+tUDkcUYF5nanaxER1soLJQZqMuXxQ@mail.gmail.com>
	<20260915085304.775a829a@kernel.org>
	<CAM0EoMmiw_kVnK4RjTT_dkquw0YLSB5VgO_7EoV2WT_pQXbCYw@mail.gmail.com>
	<20260916170425.1c7a7cbe@kernel.org>
	<CAM0EoMn1SkkC0goKD3-OreQtEwYbfr3zYJdmfrDf8HTdHWrNjg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 17 Sep 2026 07:24:05 -0400 Jamal Hadi Salim wrote:
> On Wed, Sep 16, 2026 at 8:04=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> =
wrote:
> > > Given the flood, here are the priority rules we are using:
> > > 1) submit net before net-next
> > > 2) All bugs must be reproducible by our (semi-automated) system
> > > (hybris). I dont even look at issues unless they are reproducible
> > > (hence my nagging "do you have a PoC?" ;->)
> > > 3) Assign a priority to each bug and submit the highest priority ones
> > > first. The priorities are assigned as follows:
> > > - base (reproduced, ACCURATE) +1
> > > - Crash (oops/panic/NULL-deref/OOM/corruption) +2
> > > - UAF +2
> > > - Lockup (soft lockup/livelock/infinite loop) +1
> > > - leak +1
> > > - simple-trigger (plain tc/tdc, no special PoC) +1
> > > - privilege required: (root) +1 / (unshare -Urn) +2
> >
> > nice system :)
> > no distinction between control path-trigger an packet trigger?
>
> At the moment we dont make a distinction - the existing point system
> would still work, I think. Do you see it differently?

Right, a bit of a murky call. In abstract packet trigger could mean
remote attacker can crash a middlebox, that's _so_ much more serious.
But in practice most of our packet level attacks are for some insanely
pre-cooked skbs from AF_PACKET and such :/

It was just a thought.=20
