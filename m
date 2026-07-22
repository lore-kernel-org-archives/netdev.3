Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 084113ACF05;
	Wed, 22 Jul 2026 19:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784749244; cv=none; b=FuO5jE2rWtOFEBzvY6aEGuIeM1C0V8L1fcYFblmAmD3lPjGM0PS/S741xVcgTtLGFGePaRILJySSBHVfCSpKeA/zSdZiZoVBUvibVhxlpSEK9NEBOdR+NuSumFqYl5HLF5wz+ChSaO40Dtzja0TQdXXMckgF5Y03u5G5kvPh8QU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784749244; c=relaxed/simple;
	bh=eibpEFizUa8br6UX2KpFThgG+lvm7x6DdnLc4VVwzpY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SLzPjfHeEuWYIOS9Dc6vfMaI0jlf9+2VHm+4mK9omuVVd+3nAfYWU7UPCH2MUFxQW15x8E/lWQX1vkzzD31/wf1Om8LCy6n8q4d70s9y8lYtk1ATokd4AxKgnw+4bVWVJFH1RgxoCM07evXEVJQUNZJiEE+ypvzICczgsdiEBT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=goetpW9c; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="goetpW9c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 455741F000E9;
	Wed, 22 Jul 2026 19:40:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784749242;
	bh=eibpEFizUa8br6UX2KpFThgG+lvm7x6DdnLc4VVwzpY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=goetpW9cpuiA2gI/5jLfMvdS9A9Ja/idNWh15BScbBiv1zSc0VyC5rlEdAiYo9f8F
	 eG4zIajEIjWhxwl3LSkx8Y3x9Lim3TBHQf5OJYTk4K5+KXKQnK5wSrrGoep3ZldmEK
	 NRwlDVWUpP7hcZY3DmM8N7wfFRqbdYdO+deO2Affqx0wkcIAS8C3c+SKfMcEryWxCc
	 h2sPxBoIUzAQNAimMmxeQ9PogZ9bxtHmkLU7XQylO/cK1G2zAO0M1fEaVAFhyVXTil
	 LNJmoAMBpcuaOoPMj1ZdL/R1YYLS71W1A0rvQ4LAJ4RmvmTHTkUCjolylfU0G09rl/
	 Vux1igzgdiSbg==
Date: Wed, 22 Jul 2026 12:40:41 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Julia
 Lawall <julia.lawall@inria.fr>, MD Danish Anwar <danishanwar@ti.com>,
 Michael Grzeschik <mgr@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Uwe
 =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <u.kleine-koenig@baylibre.com>, Vadim
 Fedorenko <vadim.fedorenko@linux.dev>, Yibo Dong <dong100@mucse.com>, LKML
 <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Dan
 Carpenter <error27@gmail.com>
Subject: Re: [PATCH v3 net-next] net: rnpgbe: Delete a null pointer check in
 rnpgbe_rm_adapter()
Message-ID: <20260722124041.126a7aa2@kernel.org>
In-Reply-To: <7a9ea765-2c75-4a16-aaf9-510f2450beb3@web.de>
References: <7a9ea765-2c75-4a16-aaf9-510f2450beb3@web.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 17 Jul 2026 10:38:32 +0200 Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Fri, 17 Jul 2026 10:20:15 +0200
>=20
> The check for the pointer =E2=80=9Cmucse=E2=80=9D was identified as redun=
dant because
> the relevant address information was preserved according to calls of
> the functions =E2=80=9Cpci_set_drvdata=E2=80=9D and =E2=80=9Cpci_get_drvd=
ata=E2=80=9D.
> Thus remove it.
>=20
> This issue was detected by using the Coccinelle software.

pointless churn, please don't waste our time
