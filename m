Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4149B38F945;
	Sun,  2 Aug 2026 08:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.73.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785660178; cv=none; b=Wz2xxkpMxqIyUPT9x5J4xsw4ml1BoMC9mMAyYPGie2nO16QMNEJR2o8o7sljqNPWhn8wH1ypsvXyr6G+uIBW3xrVhXTOR14hQpKZR2XaTVYjpLYz2gWvhcC3hrMOLUfr/QndkiAoXhPIW38rOz5IhCxzYUn5bT3JxIpoIrkZ1xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785660178; c=relaxed/simple;
	bh=3M51gc6qCRa99YvvJxWueYddN4rw9/gTqLqkQahXRzs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K1N1aaEhBLEuezV3EMbYVgnIgVxTs5ZkVGHNYQ7cwulLSDRNGgdAscR0/DEqcOdpGNoji0D8gnULzk5eOuBaNFi0cRr2vu+r5QHoNjtB1TXDiHsz9cLMobK3fpWRvdA2Tv64gCdo5w6V+YyetB+SUjBoPVxxgUTMgG4zuL33/WA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org; spf=pass smtp.mailfrom=narfation.org; dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b=qN1N1bUX; arc=none smtp.client-ip=213.160.73.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b="qN1N1bUX"
Received: by dvalin.narfation.org (Postfix) id 914B52005E;
	Sun, 02 Aug 2026 08:42:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1785660170;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8IfXAcZc/A5eGeTv1rmvwNggWI4WyWJy25fjMtADMZE=;
	b=qN1N1bUXTzMpAkeH6Lg0psY7+nbSAHnvvmYOjjvxS67g91G9eXnjiaIkDtLZ99RdIz6xB9
	Zexq/RWVCgVUBjlsZzMZ3A5dnzpxPjwoUd3kzT04QSf6y/rac/Z2vhWEQLRY4Hvfrnoctm
	DrqZcQMdiuunsTUQp8JohWGez2PCtPw=
From: Sven Eckelmann <sven@narfation.org>
To: steffen.klassert@secunet.com, herbert@gondor.apana.org.au,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 David Lee <david.lee@trailofbits.com>
Cc: Kyle Zeng <kylebot@openai.com>,
 Dominik 'Disconnect3d' Czarnota <dominik.czarnota@trailofbits.com>,
 horms@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] xfrm: fix compat ALLOCSPI request use-after-free
Date: Sun, 02 Aug 2026 10:42:47 +0200
Message-ID: <11168932.nUPlyArG6x@sven-desktop>
In-Reply-To: <20260731140658.566571-1-david.lee@trailofbits.com>
References: <20260731140658.566571-1-david.lee@trailofbits.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2636513.iZASKD2KPV";
 micalg="pgp-sha512"; protocol="application/pgp-signature"

--nextPart2636513.iZASKD2KPV
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
Subject: Re: [PATCH] xfrm: fix compat ALLOCSPI request use-after-free
Date: Sun, 02 Aug 2026 10:42:47 +0200
Message-ID: <11168932.nUPlyArG6x@sven-desktop>
In-Reply-To: <20260731140658.566571-1-david.lee@trailofbits.com>
References: <20260731140658.566571-1-david.lee@trailofbits.com>
MIME-Version: 1.0

On Friday, 31 July 2026 16:06:57 CEST David Lee wrote:
> Fixes: 5f3eea6b7e8f ("xfrm/compat: Attach xfrm dumps to 64=>32 bit translator")
> Bug found and triaged by OpenAI Security Research and 
> validated by Trail of Bits.
> 
> Assisted-by: Codex:gpt-5.6-sol gpt-5.5-cyber
> Signed-off-by: Kyle Zeng <kylebot@openai.com>

1. weird text (advertisement) + newlines in the tags section which shouldn't be there
   https://docs.kernel.org/process/submitting-patches.html#sign-your-work-the-developer-s-certificate-of-origin
   (and all these tag/format related sections below)

2. author didn't sign off the patch (see below)

3. odd unrelated Signed-off-by without any obvious connection to 
   the patch

   - I actually would guess that Kyle Zeng <kylebot@openai.com> is the author 
     and David Lee removed its authorship (From: ) before sending the patch.
     But in its current form, David is claiming to be the author. And even
     when it is the case, David must still add the the non-Author SoB at the
     end.

Regards,
	Sven
--nextPart2636513.iZASKD2KPV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCam8DCAAKCRBND3cr0xT1
y91dAQDvPb6JBZpaHddJ/QYP1mO0t96i3WLQqDkS6hRf1MxyUwD/f8Dvrs4TgkL1
icTUX6rP7Aw8r29QU2faE1BDzdc1gQ0=
=M6ZE
-----END PGP SIGNATURE-----

--nextPart2636513.iZASKD2KPV--



