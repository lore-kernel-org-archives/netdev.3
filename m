Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BA69427FA8
	for <netdev@vger.kernel.org>; Thu,  6 Aug 2026 09:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786007375; cv=pass; b=Qewt0GkvmmNzcvlwG87D1whnzPjXbXji75tPFI4jNIcQiGRNRxPPw7IkWtm1nTKKL5gjzmxaD7gWEF8BYG5aCA36DYXPVWcTmZlkb1dx7wqAbSVgwMo7MB1FtbKrsC/kgjaaJ2zLqPd2K6tpJ/cJj2L7fFjDlrldZ6RYCjh9TTg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786007375; c=relaxed/simple;
	bh=hNBBlHDP4IyrGb/3Zb0p9LdULHZUo8UTCuh8b32cQww=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jEHrfvzI4DyP/TpCd6f8i4SsFNnJWLhI7h7IB+euir0lcz5BzKfwwRiD4Xt6t0PR5Qjn09QpxM8YL8aM9OitZBGhoenunFw1UXF9A+qHu8tvmGqo54oaVBG9Q4mXE1Kv3zoD7nqq1V+ikkmTKupSt6FKn98NVZ8qLUo+8gVHv1M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oSJG9sHp; arc=pass smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oSJG9sHp"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c2022323c37so256303066b.0
        for <netdev@vger.kernel.org>; Thu, 06 Aug 2026 02:09:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786007371; cv=none;
        d=google.com; s=arc-20260327;
        b=GJ35FlHEuEiEBW4jM1YZ744pifDYox7HjElJUx1uUKmNkuQgFasXpadoBKKOg/1Dhi
         aVd/xA8dGb4N+iGfBv30m+M/c5B+Ap+Fm4dddwGk9UTremgc5y63j1RoxCB8fHVMrsig
         28HLty5Rdv57tBD1/o41KDLgqfbcmhVzUjb5TwsDTsLQFBchUF6e53d3QaXO626er4t1
         nBFbAn6vVewWQyjpht3PAZD4OIvhl6IYtP2h7p2TPeIb/x8aT42INFlwzyoGj3CmgJQ0
         jaZ8fZRL4Vtr3fufJ4IHyOvDXwmlzQOdCqGPySH6gGrjWROU3w8Y3lKKyUZOGrWZL94r
         78Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hNBBlHDP4IyrGb/3Zb0p9LdULHZUo8UTCuh8b32cQww=;
        fh=QPOUND/uVXplYCsrGmL2GNW815I5zpWOlcfrdt7yIfM=;
        b=fWL6eI9UYcUElX74+cLr/a/CEqb9Pbkp97vi5Z94cLQ6DVtTAQTtWkR3ep39DZw7Xm
         8EUakRuYXJP01OcxvtGIu7ilNnf32ccFq2wL8J62m+88j9/no1GI+RUGU7MPOrldfeZx
         AclOtpjzZt03bZWrJfJ/DJAhhTwAilueWB+IdQbMSWFKIAce4YxtwgoURzIc9UPF3nCm
         9qQB5MY4XpGnrnEUem6A+fRHbaqWns1Mi/o+ekbh6f4TCmrk0OGawLdL8tr6kTauurmW
         XPZ3ST1BF81R+WNqta2ktkAn534EYUe3FLz52lD2rkXR4wVzg5bQnQGaNWVamG60Juag
         nj9Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786007371; x=1786612171; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hNBBlHDP4IyrGb/3Zb0p9LdULHZUo8UTCuh8b32cQww=;
        b=oSJG9sHparpCV6HoQVWtoA7/ejfzkgwBopefYOETyTOnCrFeHgjrsjkqaTwEU9RqLW
         YqJRwiEexmsq9rmzKUAxKRi9TZltUnxrR6htIYI5Vc9zyusO3mKV/ThL3vQOluYBdvk0
         B+CmhOPCV3eN9ZGfzrludeNPEbokHM+rG7RRBqGzTJnMd9TOifN9tZf0l1cYfyJ9OyXP
         DvjuVWZ/2E7qQybg9kyPUvTPH7zXRuULvHfGOHE7YClcgyBSuva1YGwMb9iFjBq046mc
         M7ycSJ7gZEeSqnByhi65IsC14wDTBOWuZzZNT7Aff8cLr1IpFN9BIdNcYw3V5KjD+4KI
         z2bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786007371; x=1786612171;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hNBBlHDP4IyrGb/3Zb0p9LdULHZUo8UTCuh8b32cQww=;
        b=lBVbGCTOzY4c/dX7ouhVX2iztOeLOwNnO2WqlFm+5/dbb5vWD2UawQS0g88EGhzjv8
         on+ZTzz2MNDOncrNPuLXIdFV6b4/Hh/OSiXFwg+zNM13IJF6LXITqYlX+LPj0yQMJzoj
         UZP6UshezYH6mZFDipVMB7q3UNKXnh5kbj1YLwwIXY25JRHuSub5YW5gQdVyI1iwJycO
         ezIkhYH2C8ekmQH10r9oTZLXwVoiimnDcXK6T4EniMP7dO1/6irF+9OFY0nAgAGaoGwz
         R7XMilElNenef5OCE4kWYn7hFQk65iCnAZUmMUDUWEp/QVcGITKFqOkf/eN0g8nH2hKE
         yeNA==
X-Gm-Message-State: AOJu0YyOHdua7EBgXB5hiY0eW1kfjP7QwJoF/lqD8EhscrWgfXFgu2f0
	WjlWd3DrO0eMgwzp3AMGlMq62+2fmMknLcseh/yVNVlfnQ9GcfMTH2BV/vK8CKX6UsR09H+Ou3L
	in4adjSZfmOErFebwVSMmW68aDNwGtho=
X-Gm-Gg: AR+sD10oldVFqqXiiaMVT7QlhmFVcZpHI4/uiv9UzBJTk5C3hok4vdh+Avd8NUIqYqi
	KViV9ZxhPn/MWfheIrzJ0K1q+xo1dcBX5zi7rmtAxxNLPRSaS1M4yH2Tsh1dx/GVQmdHQgypWeR
	bx9xWrkjC50zCvSe+cUDvV7np2sIuYzt1QugabBxyXAREwqXOScRzXgp5h8OsQDXx0v44WJW8HX
	RciiqlHOrfhX2pGA5wi8Vh9XgQQaxInEyH13tnLEjt3fQxhPcSfURHpaKltgYSrJln97+Qlgmi9
	eiunaRncPXSjAC7oo8EJmhYkEQd5whJnG1tPvqYlYSQ4xWGzInJVWmya
X-Received: by 2002:a17:906:fd8c:b0:c20:33db:41d3 with SMTP id
 a640c23a62f3a-c2039d7f746mr698347966b.11.1786007371049; Thu, 06 Aug 2026
 02:09:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260805085540.452260-1-a.shimko.dev@gmail.com>
 <20260805085540.452260-3-a.shimko.dev@gmail.com> <20260806-witty-apricot-condor-efe3ac@quoll>
In-Reply-To: <20260806-witty-apricot-condor-efe3ac@quoll>
From: Artem Shimko <a.shimko.dev@gmail.com>
Date: Thu, 6 Aug 2026 12:09:19 +0300
X-Gm-Features: AUfX_mwF0Srsl4ymYSotEHs3H5sN16G_bkaftmzPkFk0pSw0EIRwuU5M2LapBow
Message-ID: <CAOPX745Zm-YcJcS0_KcSrJUR-V-U-ZDYqqxdmrO5gmEZAm8PMA@mail.gmail.com>
Subject: Re: [PATCH net-next v6 2/3] dt-bindings: net: add DAPU Telecom
 DAP8211R(I) PHY binding
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Maxime Chevallier <maxime.chevallier@bootlin.com>, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Krzysztof,

On Thu, Aug 6, 2026 at 10:22=E2=80=AFAM Krzysztof Kozlowski <krzk@kernel.or=
g> wrote:

> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Thank you for your review =3D)

--
Best regards,
Artem
