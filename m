Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF6B9390985;
	Sun,  2 Aug 2026 08:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.73.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785659970; cv=none; b=MCZDB8PXkOdPdXka38+vIooe3ZLTMuZhXdm3+RuxP/FRgtRCyCtmNZBk3EAmQYf8H6TiVH1qtzfBl1tm1exoSkzqWEepWRSZNn5OJmvvBvBBlWTuwpdAARLCdzi8MZRN+H3Z+wmVcRfq9lGUlR9WgQxK/ZYLDa1WS/BDToSS4Gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785659970; c=relaxed/simple;
	bh=O3uzuJ/nXwix+QM4FbsO6xYW8t/THu9Ke5AeuRkEDXI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jwaFtJOHgF7wk6lOot2flzOYmJww+v2n3BLmdf9gcnfVpJnbVGTptjYUw2ih+BsCb4tHLmLM3OWKb30JSvOb5WKrgIBvrTf6eGwjgChMwTdHisagGfsZy+mW+pnB1cykvF8y+6ym36xRGUSz5wLz/lNIehjQI3qQT5QnNV1Ucdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org; spf=pass smtp.mailfrom=narfation.org; dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b=FSy+HO8v; arc=none smtp.client-ip=213.160.73.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b="FSy+HO8v"
Received: by dvalin.narfation.org (Postfix) id 6082921AB2;
	Sun, 02 Aug 2026 08:39:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1785659960;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1piGW9sBUzSLLQkKuET0u0OXfDtZYnNgCKtciY/L0Vs=;
	b=FSy+HO8vs/at+cSRU5u2EZhcnHp/+U3cZ8IMWP6cC9lOnbGGOkbrcfaXy3rU4Hj2gqjd8v
	HUANbMO0s5HFQs0TXrX3YFORvI380d3uxfFZuJgio84d8qoeHg3xtFixXY/dGXEa4lAh5u
	iuM/u909rny8frUJQbgd9zRVnd8Z7h8=
From: Sven Eckelmann <sven@narfation.org>
To: dsahern@kernel.org, idosch@nvidia.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 David Lee <david.lee@trailofbits.com>
Cc: Kyle Zeng <kylebot@openai.com>,
 Dominik 'Disconnect3d' Czarnota <dominik.czarnota@trailofbits.com>,
 horms@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ipv6: prevent in6_dev_get() from resurrecting inet6_dev
Date: Sun, 02 Aug 2026 10:39:17 +0200
Message-ID: <2697080.ElGaqSPkdT@sven-desktop>
In-Reply-To: <20260731135202.566337-1-david.lee@trailofbits.com>
References: <20260731135202.566337-1-david.lee@trailofbits.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart5368111.GXAFRqVoOG";
 micalg="pgp-sha512"; protocol="application/pgp-signature"

--nextPart5368111.GXAFRqVoOG
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 02 Aug 2026 10:39:17 +0200
Message-ID: <2697080.ElGaqSPkdT@sven-desktop>
In-Reply-To: <20260731135202.566337-1-david.lee@trailofbits.com>
References: <20260731135202.566337-1-david.lee@trailofbits.com>
MIME-Version: 1.0

On Friday, 31 July 2026 15:52:01 CEST David Lee wrote:
> Fixes: 8814c4b53381 ("[IPV6] ADDRCONF: Convert addrconf_lock to RCU.")
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
--nextPart5368111.GXAFRqVoOG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCam8CNQAKCRBND3cr0xT1
yzfXAQCY4tkmBihXI2gSjfN2Sz12zkx+B9mKKJzoqfBIwlwBsAD9HIa/T/pkcQNs
aLgOR/p/EeNB5DeeU73e5sGU9vn4bAQ=
=l7mA
-----END PGP SIGNATURE-----

--nextPart5368111.GXAFRqVoOG--



