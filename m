Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5568A2EC54A;
	Wed,  9 Sep 2026 03:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788923579; cv=none; b=mNNys7mO1/cd/ewwilrU4BoVYmq6HMwnshEadXHZHQUctbDJRT1tCTgQ/rIJpjkjVvt6vUNbWztwUBo4z2wWOCi7rY7U82zsyxxxZ06JRon/5KWsfWWQFbvBCnBdp4fsCrgkvOZeGBau1CleP4aOryQ5d+/dRjRIejpcBHC3mhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788923579; c=relaxed/simple;
	bh=tkUwBDLl1pphmVwoLRWKK2ZKL9nOCDOtewEZE1wKjzg=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=slS+pRfugmBWULXs4ANDHqBz1Rtvqnlx29L6kuTlZOpn4TW79lFeiem6YpMNRua+d+oFnAaqHnpSUfYPzFPybOCDXkPxY/z0GTx+vauyLa1enpYbDVbQH92a/xgcgn1bW3pwh72Tjo/0+8V97hAwhdPUzs83wcfCROFpI51vvcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=OeMatQIy; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="OeMatQIy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1788923575; x=1789182775;
	bh=tkUwBDLl1pphmVwoLRWKK2ZKL9nOCDOtewEZE1wKjzg=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=OeMatQIyaedjDkFPwplhgJcypFNuQmyUAkEEaJ1pX3Vabg2kwkxOcCblSUHY5xnxh
	 7Tg19dv5R1YehZKqSrzMmeC6cS17l/G94U+fmNGFB+JNT5+oYKjDevnJ4sEPrgNz0H
	 pL7mZhRtkcXpJKUBYZhzllRU85zEQ2ibJrulepV4y9DQiaFEPGh74UuoVHt4ZJIlGw
	 qSsyrTL9riPnj6vwJFPUSbuf9aSsorH569Oy8Gx0xj8cDA10gSGvSnrxCTDpPpnsOh
	 +BYtHmW4Qgo7rbuMmZlG/Uc6QVpFiQhCizw2o5HsHh2IPHfwmrbenEo0q1MuPrMPg0
	 Txef+190HSJww==
Date: Wed, 09 Sep 2026 03:12:51 +0000
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Alex Elder <elder@kernel.org>, Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>
From: Esteban Urrutia <esteuwu@proton.me>
Cc: Nazar Kompanets <xlie7669@gmail.com>, linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org, Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: Re: [PATCH v2 0/3] SM8450 IPA support
Message-ID: <fa9794e3-d79e-4d77-8166-492d992154b4@proton.me>
In-Reply-To: <20260909-sm8450-ipa-v2-0-2deb8b4e91a5@proton.me>
References: <20260909-sm8450-ipa-v2-0-2deb8b4e91a5@proton.me>
Feedback-ID: 147889766:user:proton
X-Pm-Message-ID: 2e84b6d89f5157f0eded2a3a156a9badf51a4f33
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 9/9/26 12:10 AM, Esteban Urrutia wrote:
> This series has been tested on the following SoCs:
> - SM7475
> - SM8450
> - SM8475
> In these the modem works as expected and no crashes occur.

I forgot to mention that this series depends on the following patch:
https://lore.kernel.org/all/20260909-ipa-modem-drop-v1-1-0c9664f09c4a@proto=
n.me/

Regards,
Esteban

