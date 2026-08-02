Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5FAB390613;
	Sun,  2 Aug 2026 08:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.73.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785660015; cv=none; b=CXkijgar9eW2BGsml+r9FrsmAAOdv4ghi9NpiqAeWkNmUvG3cDHV3RelP4kEWKUhbDx97I9r6zON2w+v73+GyFnaC/R9PtWNxqlfcmfYwmRAV0KoB4JN5c+3Q71EcH2R6rgauIk8dqnh9lu6CjvIOX+5ZggYXgo3XQcXQ/x2eMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785660015; c=relaxed/simple;
	bh=B4oSW0+aFH2TYkFzG+zf+CXc+/DylHWeVGsJ9OsJlzs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d2t4EsCILcJzEucvcNZ7b3sgJuic9fBECEtGJ6L6cUHMfFlOQOcXL+ntY3zPvP+afcf5dbIe5XI6wrMzid4H/I7aBe5aBP1gzJbVl7yCY2P2SUKtbGsggVOCtJbBiiwGfislgh9pJL94yuPrxhG3r1xECD+Qm2+3rWVKbDPFZes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org; spf=pass smtp.mailfrom=narfation.org; dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b=r1HtCvcU; arc=none smtp.client-ip=213.160.73.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b="r1HtCvcU"
Received: by dvalin.narfation.org (Postfix) id 738921FFF2;
	Sun, 02 Aug 2026 08:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1785660008;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hvhU5sAz6cMtVXpWPWNXHtK5nHtehW2ESCRRnI+XHM8=;
	b=r1HtCvcUfts40KxIENnTrN1IpW/1oyG4mt0Nb/CPFF/x5oCHNMnId7BZ7Wpemngr1Wsl6G
	5gOm5rKQTOCcQnoHxmyQynasukhBxlZuMN7/CHCk9iIsxpLzJCIsqimSSZTjzw9mt7dTQE
	O0vdsxclL9Ma3NW6fiW3b6ZUBULWAno=
From: Sven Eckelmann <sven@narfation.org>
To: edumazet@google.com, ncardwell@google.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, David Lee <david.lee@trailofbits.com>
Cc: Kyle Zeng <kylebot@openai.com>,
 Dominik 'Disconnect3d' Czarnota <dominik.czarnota@trailofbits.com>,
 kuniyu@google.com, horms@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH] net: inet: prevent lhash2 lookups from escaping into ehash
Date: Sun, 02 Aug 2026 10:40:06 +0200
Message-ID: <2549706.irdbgypaU6@sven-desktop>
In-Reply-To: <20260731140512.566464-1-david.lee@trailofbits.com>
References: <20260731140512.566464-1-david.lee@trailofbits.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart14341076.uLZWGnKmhe";
 micalg="pgp-sha512"; protocol="application/pgp-signature"

--nextPart14341076.uLZWGnKmhe
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 02 Aug 2026 10:40:06 +0200
Message-ID: <2549706.irdbgypaU6@sven-desktop>
In-Reply-To: <20260731140512.566464-1-david.lee@trailofbits.com>
References: <20260731140512.566464-1-david.lee@trailofbits.com>
MIME-Version: 1.0

On Friday, 31 July 2026 16:05:12 CEST David Lee wrote:
> Fixes: cae3873c5b3a ("net: inet: Retire port only listening_hash")
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
--nextPart14341076.uLZWGnKmhe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCam8CZgAKCRBND3cr0xT1
y37VAP98KN2wVjbADKjPlOPIuSRo6suqfQdiN3qvCuztIkFxrAEAqEUxkJrpKdeG
cLKgiCVbbPLWBZs0V+3Emp8soWnu8Ac=
=BHo8
-----END PGP SIGNATURE-----

--nextPart14341076.uLZWGnKmhe--



