Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3759C3AB279
	for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 07:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790667956; cv=none; b=c4N98xxjpoQBujI6FVJRBqLXgeYA7mUUOaQcJiq3M0tw6P+qmqXZ/79tRlCLm9K1jccu8XzrEhDluwTejaUZOOG/madlgBj64O1Br80rKtmm/cIGtiTGV7TuGusRoNPYnJV2vhmvq80QqlsOzuqMIsjVJgOSbPJrDK19cmRS30I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790667956; c=relaxed/simple;
	bh=LpYBFMiaqN05+X5Zp0dNTYPeY13d+CylOB/zbLHiluk=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:Subject:Cc:To:
	 References:In-Reply-To; b=WO2cnrn8xt0ZdP/C8iBrLaKQH8y/umQYZ8QFbUuHqnMxrrmm95CVZgghsPglPSKTODWjNYNhNPlRbI7VtrfrauYy/vPzfSEnS2P0OnxrcAdrCKvt6IWXFLIwDFCtMKKrbUJvNBt47Ut9EWL1fuWE8obaQqc4SCPuvSJ1yKvUSTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ebH/8xLk; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ebH/8xLk"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 6C3141A1058;
	Tue, 29 Sep 2026 07:45:52 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 3C570601BD;
	Tue, 29 Sep 2026 07:45:52 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C832C102F1E98;
	Tue, 29 Sep 2026 09:45:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1790667951; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=3qTkCUIU3+CnDdX3I+t/Z/6xzpLloXPPQTR1DecDEa8=;
	b=ebH/8xLkcfzzdsCCUyEDFqZyX+jvBfvXAJALis58m2dCw0DMJVhJpcYizDSVwCiEJ67XCr
	kbYCGM8hjU2wN/ZHiL/eVP9G7QayiScIIXuUcCRCyXsi5VuomJOD85kBv8/piQAgeH2Fav
	BWHToL+8oAJisdLucV30t2/x3AapBoVIravoSNzJnMBiTKfBWXlX5+0T68HG476EMjqe98
	PRj+SvuAV8WpNg6TdgeNfCissonWSaFhw9Oc/ayEqpSJnu/vQ2Yqrc3lMlCUbIT7jnMap5
	lVNjcPcg6ASPc/J2DKQ5bZN7+nvTid5wm50wE7k5TIkHwhhiRk2FJag6V+XZzw==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 29 Sep 2026 09:45:47 +0200
Message-Id: <DLRMT6RJRL7T.3TV4K49YWR7DL@bootlin.com>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: Re: [PATCH] net: macb: rate limit netdev error info print in the
 data path
Cc: <maintainer@kernel.org>, <linux-kernel@vger.kernel.org>,
 <conor.dooley@microchip.com>, <andrew+netdev@lunn.ch>,
 <netdev@vger.kernel.org>
To: "taozj888" <taozj888@163.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260920100920.65773-1-taozj888@163.com>
 <DLNFAUX8MFA1.3UMOGNLDKDRJM@bootlin.com>
 <45a98260.3bff.1a0eb4e2f51.Coremail.taozj888@163.com>
In-Reply-To: <45a98260.3bff.1a0eb4e2f51.Coremail.taozj888@163.com>
X-Last-TLS-Session-Version: TLSv1.3

Hello Zijin,

Please use interleaved posting for replies, not top posting.

https://docs.kernel.org/process/submitting-patches.html#use-trimmed-interle=
aved-replies-in-email-discussions

On Tue Sep 29, 2026 at 5:56 AM CEST, Zijin wrote:
> Thank you very much for your kindly reply.
>
> For all your concerns in this mail thread and [0][1], I try to give
> my answers here and hope it does not miss anything:
>
> 1. Yes, I missed the prefix [PATCH net], I will add it in my next
> commit; I would like to send it again as the 1st version
> since I missed this needed part [PATCH net];

If patch stays the same it is OK, if it changes (for example because you
add trailers) then you must iterate onto v2.

> 2. For the To/Cc list, I will use `git send-email --cc-cmd=3Dscripts/get_=
maintainer.pl` as you indicated;
>
> 3.=C2=A0This whole patch is  NOT LLM generated, it's really a bug hit in =
practice, the "PHYT0036:00"=20
> device name is the real name that showed in our console output, I can't j=
ust imagine or made this name and it's really of out of my imagination.
>  I think it may be related to a vendor with some of the PCI addr but I th=
ink it may not be polite to say it directly.=20
> Actually hallucinating a kernel log even a kernel patch is out of my know=
ledge, if you know to how and=20
> wish to tell me, I think it should be really interesting!

No I don't encourage you to hallucinate! It's what LLMs do sometimes
when you ask one to generate a commit message for a bug fix. They have
seen tons of commits with logs so they reproduce.

[...]

> 5. For the severity tag and should this carry a Fixes tag and name the
> intended tree,  please give out a clear indication from your
> experiences for what I described above. I really have not too much
> knowledge about that.

Yes. You put those two trailers:

   Fixes: 89e5785fc8a6 ("[PATCH] Atmel MACB ethernet driver")
   Cc: stable@vger.kernel.org

See documentation link below (or kernel git log for many examples).

In your case you want the oldest commit that introduced one of those
logs. The macb_start_xmit() one for example got introduced with the
first driver commit, so that's what you target.

https://docs.kernel.org/process/submitting-patches.html#describe-your-chang=
es

Thanks,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

