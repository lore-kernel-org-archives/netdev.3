Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C5833909A5
	for <netdev@vger.kernel.org>; Thu,  6 Aug 2026 19:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786042948; cv=none; b=WdDiQeV3Ui1BfwlFME62Q5U3g8zL0A2enlj7BmETw/1ou+1dOtwQuuoge/2bDsDqPzskuFcbpRRIdlxHYSvmwIe2udvohIxV0hTop01aUSIdBsq60I+yREK0r3Xfw4WD9FvVyD3wYxBllfKUramHxU+0igokDjow7ZzLJHVS27w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786042948; c=relaxed/simple;
	bh=jD651pM+5FyNAOdnahyk4vcJZNzcbu+0YmQd1H4J2d4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gQ2hkw16rX1xD90WKOv62ChGgk4BJZ/atAvtzCZS/TvoR+ugr3PRKJPYBTeJhS1odutvZlM0eOUWy1S0nuu67A07VuEURUD5lfl+sigFkFwJ+KHCQQN55fiEpxBj+qg/nPuTSJ5MR3EezX1pWXEDb9dSJWJyTDHr+EKS7xJrdZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DVzkV3jD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DVzkV3jD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA5061F000E9;
	Thu,  6 Aug 2026 19:02:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786042947;
	bh=jD651pM+5FyNAOdnahyk4vcJZNzcbu+0YmQd1H4J2d4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=DVzkV3jDVZCj3/NlcrZ+9/JMwG7LArCyvTZcC7lPDFQDcUH0tsq64D2AzbRn4t1Ew
	 STpIi56zxiwGL67D372ltsYJnkR5Za56zlCwisbRwnmmmgVYg5IoADq6eS6464eNW/
	 rInLATZtCmE8XlKa5XJoN7vY/85fwTrAiU4Hdzx/HGea81yHQBh+cPsN/aH2eTiWA7
	 Tx5NkcLEUurxHC/kfHAtersWQ/oqHZoK2xQyQrxYb+JL4W07/RyZWE2ovL7ZE/Ty4+
	 JobI7iYHTCtUvz9++wqF7qnDs/99ZHLT3/T++1dS587D/3y7NAGU+PpFelRW6PY7iy
	 pyC0wgzHXX9Ow==
Date: Thu, 6 Aug 2026 12:02:26 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 horms@kernel.org, kuni1840@gmail.com, netdev@vger.kernel.org,
 kylebot@openai.com
Subject: Re: [PATCH v1 net-next] af_unix: Unlink scc_entry in
 unix_del_edge().
Message-ID: <20260806120226.7a7ca1ab@kernel.org>
In-Reply-To: <CAAVpQUBr7zgpPo9BsiDCfHo0sME5+SwYSLeCB7ESk=s8W5rcKA@mail.gmail.com>
References: <20260804002155.2233594-1-kuniyu@google.com>
	<20260806172900.2962014-1-kuba@kernel.org>
	<CAAVpQUACUFcdUV_TURigYp=-wDamvN2PBQ+c+njYxAyDvmq8cg@mail.gmail.com>
	<20260806113649.4d7f12b9@kernel.org>
	<CAAVpQUBr7zgpPo9BsiDCfHo0sME5+SwYSLeCB7ESk=s8W5rcKA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 6 Aug 2026 11:45:19 -0700 Kuniyuki Iwashima wrote:
> On Thu, Aug 6, 2026 at 11:36=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> =
wrote:
> >
> > On Thu, 6 Aug 2026 10:58:56 -0700 Kuniyuki Iwashima wrote: =20
> > > > This is an AI-generated review of your patch. The human sending this
> > > > email says "I meant to send this yesterday, damn. This is completely
> > > > separate right?" =20
> >
> > =F0=9F=91=86=EF=B8=8F =20
>=20
> Ah missed this, yes, it's a separate one.

Thanks :)
