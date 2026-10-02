Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 227D94F7CD4
	for <netdev@vger.kernel.org>; Fri,  2 Oct 2026 16:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.73.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790958927; cv=none; b=Tf2JIr8yHFr203nnKcI9EUx1nxOyCOzpRGs922Hs1Dmi21unsp3rVSnFVfsJI/0BKS81NpbfRopyTW5PmWdijStoVG9tAY4SADj7m77CCdXR2CYgtQeogGOz0VoLp0vHJZI1yN2WFB8jqHeR5na6Sch4rIkDjbhRfda71CobUh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790958927; c=relaxed/simple;
	bh=RwYE0SCzBqSuticJXTfDtb6eLegaZL+KrtElqlewFR0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dd/VouYOFJfYUeVx0ke6WZmhUUkCa2XvE5AtSYi2by0pcLWKh9C6LZDnTtGuA6+CdYlzufNGyixWt0yXB+C5a4RQnOtrBFEZr0qziPozfFWYKr2RsFQqf3Y3EhvS1Ag+hW7QOx90mfT3+c+3rLsE3DXJUaO4JycUrB93+AGB9BQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org; spf=pass smtp.mailfrom=narfation.org; dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b=nYgs5PCe; arc=none smtp.client-ip=213.160.73.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b="nYgs5PCe"
Received: by dvalin.narfation.org (Postfix) id 370EB20292;
	Fri, 02 Oct 2026 16:35:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1790958922;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6y85JcSQIdsP9psZ4BHpBLy4jt82ixcCTEhhUoi1EaE=;
	b=nYgs5PCeh1BpwoLaOP2A+qjQtpLCf6uxZHun+h7ZL+cylw2A9YHjFKxO7LiznpmmuiVqdl
	kKe96veQfknjtNh0DulsmWcpaepoKqrIy/0rjvsXN6vC1SgBGj4CNIHQ7cFk7wTQa4jgBh
	ma2Ke3qvz7mM67xwLWerGGcw5sSGY+Y=
From: Sven Eckelmann <sven@narfation.org>
To: sw@simonwunderlich.de, netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 b.a.t.m.a.n@lists.open-mesh.org, sashiko-bot@kernel.org
Subject:
 Re: [PATCH net-next 5/9] batman-adv: tt: only queue local del event after
 successful unlink
Date: Fri, 02 Oct 2026 18:35:19 +0200
Message-ID: <1871974.VLH7GnMWUR@sven-desktop>
In-Reply-To: <179084942832.434549.10138352246210429649@kernel.org>
References:
 <20260930094558.3723766-6-sw@simonwunderlich.de>
 <179084942832.434549.10138352246210429649@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart8783657.NyiUUSuA9g";
 micalg="pgp-sha512"; protocol="application/pgp-signature"

--nextPart8783657.NyiUUSuA9g
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: sw@simonwunderlich.de, netdev-bot+sashiko@kernel.org
Date: Fri, 02 Oct 2026 18:35:19 +0200
Message-ID: <1871974.VLH7GnMWUR@sven-desktop>
In-Reply-To: <179084942832.434549.10138352246210429649@kernel.org>
MIME-Version: 1.0

On Thursday, 1 October 2026 12:10:28 CEST netdev-bot+sashiko@kernel.org wrote:
[...]
> [Severity: Low]
> 
> This isn't a runtime bug, but should this have a Fixes: tag?
> 
> The problem seems to come from bbfb0d2cf035 ("batman-adv: tt: remove only
> the entry which was looked up from the hash"). That commit changed the
> unlink in batadv_tt_local_remove() from batadv_compare_tt to
> batadv_compare_tt_entry. It kept the unconditional delete event in front
> of the unlink.

No, this is not causing the "problem" and was there since a very long time. 
And the change is not suitable for stable backports. And since it is submitted 
for net-next, I am not allowed to add Fixes: or Cc: stable@ tags.

[...] 
> [Severity: High]
> 
> Does this reordering open a new window in which a replacement entry's add
> event gets dropped?
[...]
> 
> Could the delete event instead be queued inside the same bucket list_lock
> critical section as the unlink, and only when this exact object was
> found? batadv_tt_local_set_pending() in "batman-adv: tt: queue local DEL
> event under bucket lock" already takes list_lock and then
> changes_list_lock in that order.
> 
> [ ... ]
> 
> 

Noted in https://www.open-mesh.org/issues/475 as potential further work to 
harden the code path further.

Regards,
	Sven
--nextPart8783657.NyiUUSuA9g
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCar/dRwAKCRBND3cr0xT1
y2EzAQDmXdo+RAxmJzrMeTdH6auDbcFHkjbSGBnXQo4/y9ggqgD/ZHwBzUqI7/zX
mQc7ULoMCUvdgpueMxEdNM1CI4vyNwc=
=OUCj
-----END PGP SIGNATURE-----

--nextPart8783657.NyiUUSuA9g--



