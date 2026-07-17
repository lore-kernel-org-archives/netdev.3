Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C5853EDE4A
	for <netdev@vger.kernel.org>; Fri, 17 Jul 2026 10:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784285514; cv=pass; b=X3SfWjywGB306oS83On0pSrp5FaGxujaB0HTsKkW0go3XOmDZOGH2QCcIpnm5W4tSIeNkuecxEScXcaQLZs6jL7WH1KBBI64olG42XHyFlTt0p0YF5pmKWLiO1aU9OAl9sO92oTmzirLpq56aYW2LjmdxP5oKkksXfZMto3ghOg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784285514; c=relaxed/simple;
	bh=vQplzCRPmrlbx+b3iFM8q56R2Z6YLNw+7G55zXBLBms=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kIfTEOhvlWajiqU+PqJBLOFjpepbACLECzYybS6aSH6cOUQJVI/MCwoFCAhCe6r6Emqa3eula5ti2y1sARy8mE/Zuevk1IYsJWym1/kx8zOr/XJjff436SDlbM++d6Q30LemLPOOq5iVa7VVIfrUGSGEQH8WMbS4HWxFgbvApsk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nesowRCx; arc=pass smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nesowRCx"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-c15c7d22070so1006197966b.2
        for <netdev@vger.kernel.org>; Fri, 17 Jul 2026 03:51:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784285508; cv=none;
        d=google.com; s=arc-20260327;
        b=myjSn9gYhVMth4WHYc6sT9x6GJxBZr5PWVv4ncMDfpoFGdKc8HUseY2LGlwYSmgvPM
         y16MRchVx7OO1GkWvX6Jb98C0s9ThXWnyIw2Lvn/5BBsuWwu6bovqYmcXUWA4eeqyMZt
         snnwwklWGJwkltZ79nD8WyikSfHLRopgQ12bEMQEav0zMqZt+rMNW8V0HuSRix+cTQfE
         9yROlbzfeaDTZZHDc/ccQFZ6FAAve47cUgsnl+OupJklpZ0MuHsz7kxUEs0l8TykExVL
         y8/iD7SOiaLBCO4XshUgTj/3U6vMHo1sClNAy38Ee9hCaPTMhH8XxeuqSp0SbFODb+5V
         5M2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vQplzCRPmrlbx+b3iFM8q56R2Z6YLNw+7G55zXBLBms=;
        fh=kexc97SlzOR1V5wLThV1mhffVEHgilzutOD//Gz0HGo=;
        b=IALO7EvkkoEe58zzXahOS4rN0iirkIk6vzsztTUQsGNTqz+LnzHxqdEVQujI/YFQP9
         52QOQQ9cfqp2fTp9J+aVhbvYGnHECydl9LqrYGu+a4rTCsecskzcp0gvddTZORriaDjc
         fYCy1JsimB0U1pQIt5R/ajo/c5yaSAM235uJ/vZPHGVIs8Q6pSNnns0Y9mS/i4/j78D4
         o5VGiFBJNXlOEegTP026p+BN18K7IPy5W8qbv9HbvuHcZzpdkppMjfXTDY9LkEpgj0w8
         ukKT7TqlKj6z1h5rTxQa+ZS7Iwvwu43EV4+zZhJQx0cm8QGvHW4rXBa7zo1wuutXaAS/
         yZ0w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784285508; x=1784890308; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vQplzCRPmrlbx+b3iFM8q56R2Z6YLNw+7G55zXBLBms=;
        b=nesowRCxAPFbOCI0ijOqY2zvhvEkM0oPnaGDleR5O6BeNPNP8w7FJA+9sKpu4l4l+2
         5Yv/ygxhvTPqp3DJyYr6bY1adgTZXPSiXcnwleCl10pwAyzipOaaXgScvqKkZj4jIB+h
         kjsHYd88+jqoq2IRWjsyUtbGfFFo47K1mGL+Iv/30D9GfYTNWDDfjKZZkS9r2jtn8fAR
         v8iCfUpTOrRtJTsK0Um2q7dWiTO+SoxJm/+G/wum/KEOQuUimmkYLqbADCypeEXiicph
         RUntlPEMqLKEWAhV6R1yk6Q0QUriKyP1c3XEFlPyNTS+qv2lAGlJ6JeZcZ4iYiAQwwAs
         7mxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784285508; x=1784890308;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vQplzCRPmrlbx+b3iFM8q56R2Z6YLNw+7G55zXBLBms=;
        b=GxPWk6d3rrxHAzdEpi0zswox1Ou55UPCHNrHdKt5BgVfT1pcpkzP66HXrND36NDYjV
         Qs4Ml26TuZo02klHqm86IfP04NGN66owa2NSUGRmUOvgr3VqCT4GpEh7maDsY37i6cpz
         eRAlFJuEGaDSqNgxA0ug0FlC2soIfJT84k/BDEEg+NhEOTRkA1TGovZHxr8AORssWRni
         c7V66CxDE1MkVy2baus9o5UDFCgCWSVtzLPeWUtSdOHxFZ7Oo0vackW6ntQQFgiPQ7pV
         gBq83pE4oWqTVTI9oL5H9CIbVIGmzMTn/K6lw4IyT12IupNI42qxc0q6cD2wSiRvUY17
         /A3A==
X-Forwarded-Encrypted: i=1; AHgh+RoqFLYn+Ht1sIMxNyBSj1Zz64LLgYKCrYCp8DQAwVkdHAdvOZLnjK8X5UG6j7idDTK18f8OCUk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXUlKO0JBH/owm3r/J3LqCUQkKPdZnGYJin4Pw1tmT6QZrU/8K
	yFnrUveaa8CxfeSeOdX116ew+OBWTIMEUOLuqPNvJTwc+03gKxfz2AghUa9JSdiFXZQXnrhXRnL
	6deNIEYVwJsiMDyF+1G0vIjYdqQG+Quo=
X-Gm-Gg: AfdE7clQBQWzPnP5xnUXKUe7u7ncDe8+5x0ZjBni+K6pTCtLTTmOudgaYtxOvmqMmYL
	MLGRLO+4vh0HWBiXe1nS6pSv9dDmcKY0CFWkes+cvvKFYiaMCDVdn47uuZqdHMXAnI8baF/52dY
	azb+7QUWnNUg5kC5+YNUolq8g3XPkZJKFSPKL3Ki5ck2eK1APRI9rkBHEuwh49s7XnDMiBKp6fs
	EUg9YfT/oYLykexOPehN8Nh4GtJvh5m9Gt91CLPxXv9Pm+H6S+0SWnKEYRbZ4U=
X-Received: by 2002:a17:907:c70c:b0:c15:c1ad:36dd with SMTP id
 a640c23a62f3a-c16b45724eemr92901366b.6.1784285508018; Fri, 17 Jul 2026
 03:51:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260716173325.653164-1-a.shimko.dev@gmail.com>
 <77f1cc14-cc5f-4f32-a972-f0350a60931b@bootlin.com> <05bbadc9-95b0-421e-9c5a-8223a891cb5d@lunn.ch>
In-Reply-To: <05bbadc9-95b0-421e-9c5a-8223a891cb5d@lunn.ch>
From: Artem Shimko <a.shimko.dev@gmail.com>
Date: Fri, 17 Jul 2026 13:51:36 +0300
X-Gm-Features: AUfX_mwM6QF-cVSBrgjxB3MqPlPRTL1soPgqjPUucWdn7x2xpIl-dWiq_De26nk
Message-ID: <CAOPX7455qXddUEo9fd3JpYu5H3t8eb1jvNcDq81292C67uSs8w@mail.gmail.com>
Subject: Re: [PATCH net-next v3 0/2] Add DAPU Telecom DAP8211R(I) Gigabit
 Ethernet PHY driver
To: Andrew Lunn <andrew@lunn.ch>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>, netdev@vger.kernel.org, 
	Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Zhi Li <lizhi2@eswincomputing.com>, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On Thu, Jul 16, 2026 at 9:32=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:

> Adding to that, there is no version history. How does v3 differ to
> v2.

My apologies, I will fix it.
--
Best regards,
Artem
