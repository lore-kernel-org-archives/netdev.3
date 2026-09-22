Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3EE9343883;
	Tue, 22 Sep 2026 19:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790104564; cv=none; b=juFLY63LM/edB9cChvyraGmIsB90iP/6PZuHp0XYddYc8a83oF14owXswpSUc0rEN/wIZ6OKutO3jcTcZJcd7awDeZD/Vj+K5FFTuSjcgS2/nXrQ1QoxaPzG/d/tYAM2q5j0UD+6OZKrzc6xKHWTWzBKcGQt2jeNYfSu5dNz51k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790104564; c=relaxed/simple;
	bh=72aIr9Zx6vLtwku5O3jGV65v8pQtUNBVCGT3Q5L/4n0=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:To:From:Subject:
	 References:In-Reply-To; b=KW4Lm48z/UKoumTI38G3TE6JCplOiYEczLfnRnM/q1YAPZT1cINOMxWn0NetA2wBay6SnMleDSfWVuP+tcyJcmNxp3Spspb4ubuG8HeX8l/JlY0SBiIVd59CItGYg7UnByWDXy16kg4p7PwV2qogj6VprAYs/6sVwdyE4GK15+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Ws9RNrI/; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Ws9RNrI/"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id ECBAA1A0FCD;
	Tue, 22 Sep 2026 19:15:59 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id B71BD60580;
	Tue, 22 Sep 2026 19:15:59 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7AF72103292DB;
	Tue, 22 Sep 2026 21:15:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1790104554; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=72aIr9Zx6vLtwku5O3jGV65v8pQtUNBVCGT3Q5L/4n0=;
	b=Ws9RNrI/IKUibip6ETGTBudhPWzC67ES3bfoex/mnMgUMjkCTG0e/JdMF4l+n965BM7SgP
	/GeigVvIkU6ij3Gpy9X6yW+qzqIDZA9a2SNOgsSy3RqrL3RZk5UfRh99zuZIOqkZiey57p
	795myaZi7eTCVPYexy8G637UhXbO3zS4H7oX3dRr1nmt53aHIGISkN5CRAwHqH3CtkqgOQ
	3N68NyILY9ThGmbU5Pksu71SeMaFVxSxEq4/vL3Ykx8SI86eDXbUeRq+l/FeIvhwdQ9zMz
	Gy5M2O+UtNm1UzIV52v+FLYUgOSahlLMOCCt/79FB3JxMf2xxpakuYhwU4RRKQ==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 22 Sep 2026 21:15:50 +0200
Message-Id: <DLM33PR7WZOY.317AY77DCHX1F@bootlin.com>
Cc: "Conor Dooley" <conor.dooley@microchip.com>, "Andrew Lunn"
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, "Richard Cochran" <richardcochran@gmail.com>,
 "Nicolai Buchwitz" <nb@tipi-net.de>, <linux-kernel@vger.kernel.org>
To: <5mghybrid@khu.ac.kr>, <netdev@vger.kernel.org>, "Rafal Ozieblo"
 <rafalo@cadence.com>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: Re: [PATCH net-next 3/4] net: macb: Disable one-step mode when TX
 timestamping is off
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260922-codex-macb-hwtstamp-submit-v1-0-9d1abaa53296@khu.ac.kr> <20260922-codex-macb-hwtstamp-submit-v1-3-9d1abaa53296@khu.ac.kr>
In-Reply-To: <20260922-codex-macb-hwtstamp-submit-v1-3-9d1abaa53296@khu.ac.kr>
X-Last-TLS-Session-Version: TLSv1.3

Hello Kim,

On Tue Sep 22, 2026 at 11:10 AM CEST, Kim Wooseok via B4 Relay wrote:
> From: Kim Wooseok <5mghybrid@khu.ac.kr>
>
> Switching from HWTSTAMP_TX_ONESTEP_SYNC to HWTSTAMP_TX_OFF turns off
> descriptor timestamping, but leaves NCR.OSSMODE set, so one-step mode
> remains enabled.
>
> Update OSSMODE for every accepted TX mode and set it only for
> HWTSTAMP_TX_ONESTEP_SYNC. This also clears the previous one-step setting
> when switching to OFF. Since the update mask now always includes
> OSSMODE, drop the check for an empty mask.
>
> Fixes: ab91f0a9b5f4 ("net: macb: Add hardware PTP support")
> Assisted-by: GPT-6 Astra
> Signed-off-by: Kim Wooseok <5mghybrid@khu.ac.kr>

I don't see the point in this commit. NCR.OSSMODE defines what value we
put in TX Sync messages. This register can be left alone when
HWTSTAMP_TX_OFF.

Thanks,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

