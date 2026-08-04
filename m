Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F59546D08C
	for <netdev@vger.kernel.org>; Tue,  4 Aug 2026 14:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785852544; cv=pass; b=mIy3bsWeZQNVRDXRLoWaMVnUvwqlFvBG46p56bN8HVczkS5gz9yL5xXXXB8W9fp5BOm/lag4KLDMWX4+n1+66cJD31C+pdt/Kaih+9Tfz5vL971MQ5rzz3ZAPnBKjooparL8n90mRW6F8iP9cxLbvZdj7/Fj0b+hFXFG/0RRQHg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785852544; c=relaxed/simple;
	bh=OVz3aJdetdn61+k9d771XNPFWGPWiQFw+i+T9Ou0l8c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JGOhJYm3G+CZG8Gj+KkytWCtIE7uLeKsM3GRAP2W6BOZXDkjtRLTWtIbGS6fxXBmO6ijKkkhsZvPerjRYwfGeVScaNbXcdIIgdxWhcSRhpG0HEVJspLY7qzIYaHYjuuE2x58vsgihPmLf46meM8+UhUU3nyl5VmK4NUh7jbQnlY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QgOLty83; arc=pass smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QgOLty83"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-c1600d040e4so150997466b.1
        for <netdev@vger.kernel.org>; Tue, 04 Aug 2026 07:09:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785852541; cv=none;
        d=google.com; s=arc-20260327;
        b=Gp/iGsEIku88vDmDBGXLsIsb5rRvePy4uAH6EuZfI567oUJFfDtGDO0o19/9ng8f0Y
         yeG8PRs3cLJD174lwz3+D23lKzXcAPC15PPCO3a335f5DRWibJmiwTUQ2i/ixfyyauYn
         bIQHA5SY9YiJY2wNpfNNWmmk/C8b4918wo0kDz8obhStnUDSVIOci/o96f45SNzdL85Q
         Q7HDDQDa+2xWQQbfht4mxQAG71HkaPkpFQqj5SOcCDbz6efycDE47h/56vGEujMOTJaa
         nNRuxcrfBHmzpDQ7zWuHlMO8nWbNXF4jdvNdVNJZxZdvgezctghG8dWmiRXPWGy9AtbG
         Z8oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OVz3aJdetdn61+k9d771XNPFWGPWiQFw+i+T9Ou0l8c=;
        fh=Vld2zxj/xZjnE3RLNH/H4EIU4fJXydtO/ZAYYhaOfNE=;
        b=Bt/rTdYf3QVONCjdkC99nbtR3XkKNZQ6odTs5jAxWxH7WSUmM4FRsrJHyJwQ+krB/h
         I9/Mq94xoP/kiHCKB4wSRVN63S8EwbGOl4gYI9bK/2AMxrHE4bA/KUF+TomRPy8kOFmt
         OlJeGbeXFMtpkieMDCollmHaFQtCPN2MkKtQa1um39hGmUH6vManheDUg8K2MMoKRyor
         JaevJcW7+zmnhARrNe1pewzojMuR/+wUOQOWY4HgRlNDWA+eJoCxzVq0iv0Qb6sPtzdq
         s+iUceKw1NM2qDWZBe4d9OCkm+zOBr8saVm2vRDvbfFGMUuKSG4QB2Twr8VqoJ9u9lUK
         WM1w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785852541; x=1786457341; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=OVz3aJdetdn61+k9d771XNPFWGPWiQFw+i+T9Ou0l8c=;
        b=QgOLty83XmYrUl+6JD4O7tVgepvDOqXwJlg0qGEuRss/UMFrMbrFoOfFOptjS63qop
         pWq7Y3LLW2vncApdEaZJNmZAnPbf9uQi4Twdb5IT9V6j+dQIkB1pSWrTQSo7CSSJnkOl
         I/ryp6Jax70PcLrkKDnxom0DvdtPO3ndP5GHk0ZWg3zOATVre+YGXz3rswQaeW6iPFls
         /MegQPftG+iF/X3ehgA4nSUWkPRHz7q7Xb2ocazUhXrgenUi3AgESb2J66YZa98BaItk
         GOGAqX1DBDl+uzZWkS6mWrhD5mVaxmzemxyU1fq8Sm54UYFJPcWjAZz+4Dl8kE+LmEH8
         Nufg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785852541; x=1786457341;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OVz3aJdetdn61+k9d771XNPFWGPWiQFw+i+T9Ou0l8c=;
        b=Q80evbZE0GvuIrrjAQa4fCbFo9mPm+iy9PJI1aTx6pHyDH1MT+SJTuXboU9El5jroT
         tTSgk3IrmmS/fdfJZmISjGP+zdmzgb2w9rUm0FPjs2k/OmHIDdWzAWoqIkKe5TMnVnZs
         TOx6ZawIWJjs+U8+DQZJAzaSgWqXBdlJMkXKzo+p2wa54OAxQn7MbuKsS/pbvsLMVK23
         P0kfAAdJttzKtiKmHSQFZxoBJaYDvq9tzn6pHk3Fd+5IU6hFPuMX/7p1ADmuaLCN+KRB
         Mfln1tY+ljOYDSIy9bbHLo0rGeoxbFrruC+DiQZPENi/SgIegOCReplUswBVJEXxa/e1
         jevg==
X-Gm-Message-State: AOJu0YxdaWZd90xY4iKa3t1EZxw4KRN9s5WjvAONYXFn7jNMXT3lJGOq
	E5Tbh0DNOOZ25xsUByeAuHto6eLRZNyuFteO+sCBVe2hidzQ85lohICyIWyT3RpMdjibT0Lxwhl
	d+lJDAzYeIs3sC5w+Wz0WJ1osGUUP0Hc=
X-Gm-Gg: AR+sD13fLoyueNxIBD2Pm3F9Zl0VCS/MbEWAls0d7Y4al3NmiI9sBHY7WEHjxu36CdS
	1pWaZUC1tPnJ7gfIQxwgUp9BUUW3SIbqf1osVWI0z5809r0UP2VJWyxwqwiYuVYW9IkXLIAhMxl
	eqocBXJJ0jZQc2e8H0VosRDnA+qUIVHdbdZUpf/pNa3qdwVddXbDo9bqrjrYEQIkzOjWPEhPsCV
	UmgW64dfLwPUjXMb9/H+mKw11gUZzMtMkpE/1FlEuHU2BoOliYAxa/TGz90Z8mG8M4raq2TUgLc
	G3tvPKadWDYaBjWh+3cmX5ZigSKkXz4efkBe7t1GKC9FGA==
X-Received: by 2002:a17:907:160f:b0:c1a:25cc:e585 with SMTP id
 a640c23a62f3a-c20245623e7mr494139966b.5.1785852540857; Tue, 04 Aug 2026
 07:09:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260803101734.270821-1-a.shimko.dev@gmail.com>
 <94fb1a6e-71d6-42ae-b221-cc03a820d2e0@lunn.ch> <CAOPX746ZFCE1XwXJ1H0gEaBvdvq-4GAiPTKkT-3XvZi0n_f73A@mail.gmail.com>
 <2ccd6223-dd40-406b-8869-021881755f72@lunn.ch>
In-Reply-To: <2ccd6223-dd40-406b-8869-021881755f72@lunn.ch>
From: Artem Shimko <a.shimko.dev@gmail.com>
Date: Tue, 4 Aug 2026 17:08:49 +0300
X-Gm-Features: AUfX_mxDY7sXytTFSAWz_x_NZFD_dH7t1f1ZrDXWbqz-dV13YleIrcOEvAZi7nY
Message-ID: <CAOPX745w-Hfq1k+H0qLWQjsjY-5bb_9N9sw5LBJ0QM-n4j+D+g@mail.gmail.com>
Subject: Re: [PATCH net-next v5 0/3] Add DAPU Telecom DAP8211R(I) Gigabit
 Ethernet PHY driver
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, Heiner Kallweit <hkallweit1@gmail.com>, 
	Russell King <linux@armlinux.org.uk>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Maxime Chevallier <maxime.chevallier@bootlin.com>, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On Tue, Aug 4, 2026 at 4:32=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
> That is a very odd setup, half the 2ns delay the RGMII standard asks
> for? Do you have an explanation for this?
I think this is a poor example, as the delay is due to clock inversion
due to a mismatch in the PCB parameters.
Perhaps I should use a more standard delay as an example as <1950>.

> Have you verified the writing of the delays in the PHY register don't
> have a 1 bit shift error?

I verified them by reading back the RGMII_CON register (0xA003) after
configuration,
and the values are being applied correctly with no bit-shift error.
Just my failed in example value =3D)

Thank you for your time and review.

--
Best regards,
Artem
