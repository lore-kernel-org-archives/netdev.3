Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4435E390610;
	Sun,  2 Aug 2026 08:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.73.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785660076; cv=none; b=g3EZpwtXGKDR2N+W+OVzj/xTm/WDFchL2XJm/A4MXg7QcjSdm8iqAcKQ4dTwaTlBADUYaaqqP4uteBAlNj07U6VjXudYsP/l9so8PxrYicKTjXwqAYYEMii3zJQTxk4twRNOnw8VV3bRpgVxn9wbt4/NEWlxZt3drW/C4MBO9B8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785660076; c=relaxed/simple;
	bh=p0HwN4A/ORP61ZRsf6KHBx2XmfDWnGI8g3UBBswDrSE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ex+dEA7ljIMBGwTbqIuchHapojeNAozO30wjKPIu1XQr82q4hUIZW0qMJdg/sX3iysshTUBeqH5WsUzGUqfVHmsr+OeVkvTKqf+1I1lvk2w51r5tcpeQC87IOgRqu/SKH0P1WNwsL/EQDZH6DsJMePdhGzhyCDlNPNUY0u0g3Pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org; spf=pass smtp.mailfrom=narfation.org; dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b=BLXvzTxX; arc=none smtp.client-ip=213.160.73.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b="BLXvzTxX"
Received: by dvalin.narfation.org (Postfix) id F2ABC1FFF2;
	Sun, 02 Aug 2026 08:41:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1785660069;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rM1aeNZMyQRpF4jiSBs0VLi6i20VrJER8mp6wrtcKUE=;
	b=BLXvzTxXH3cOzGOq74EotgsZotLb/DSaRv8A11bOodA/Ls43o3cuN2lRljwX8fUvhFZ9HY
	7eq89qLgBepeIABBdRen8rCKpcaRRFgwYFo/U45GbYN1ajdRNvRo41hh129WInlznQ21fd
	JDLrv5WnpqwzU8eLKQ2dVM50k7FMKBI=
From: Sven Eckelmann <sven@narfation.org>
To: jhs@mojatatu.com, jiri@resnulli.us, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 David Lee <david.lee@trailofbits.com>, Kyle Zeng <kylebot@openai.com>
Cc: Dominik 'Disconnect3d' Czarnota <dominik.czarnota@trailofbits.com>,
 horms@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net/sched: sch_qfq: prevent aggregate self-replacement
Date: Sun, 02 Aug 2026 10:41:06 +0200
Message-ID: <3701565.aeNJFYEL58@sven-desktop>
In-Reply-To: <20260731140533.566493-1-david.lee@trailofbits.com>
References: <20260731140533.566493-1-david.lee@trailofbits.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3708131.44csPzL39Z";
 micalg="pgp-sha512"; protocol="application/pgp-signature"

--nextPart3708131.44csPzL39Z
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 02 Aug 2026 10:41:06 +0200
Message-ID: <3701565.aeNJFYEL58@sven-desktop>
In-Reply-To: <20260731140533.566493-1-david.lee@trailofbits.com>
References: <20260731140533.566493-1-david.lee@trailofbits.com>
MIME-Version: 1.0

On Friday, 31 July 2026 16:05:32 CEST David Lee wrote:
> Fixes: 462dbc9101ac ("pkt_sched: QFQ Plus: fair-queueing service at DRR cost")
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
--nextPart3708131.44csPzL39Z
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCam8CogAKCRBND3cr0xT1
y/WOAQCD5oxnOiko7omA94ZMcx43V8fYncLriBumWMuOD6igJQEAsVgOK0HUZFsz
MeZm/MKeNUUDM3BCJEnU9My6SGIo1wY=
=5BTr
-----END PGP SIGNATURE-----

--nextPart3708131.44csPzL39Z--



