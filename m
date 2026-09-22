Received: from mail-lf2-f12.google.com (mail-lf2-f12.google.com [74.125.229.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FE105304B9
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 08:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.229.204
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790066665; cv=pass; b=ky4lV68GPjPaHTQm92NF41aV75kvAnm+QOL/71pO4EzVCDBpTXzNbvcQD799hlZcqCIv3kxf+XuzX9lEkMaer4scBWAj0En0NoG9ibP81bJdwbHGF68VOa20WURXam7zZ5f8v3u9LSXj7MHECopIT/c/C+bHYrKZxGcsaAkR5oE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790066665; c=relaxed/simple;
	bh=u5qQmLy+pyZNGMwYq8Tx+105RlM9v+qgj/NhiJHu++8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BV8ckgnmTVaXsbOi49eWBAxz/ful4jtZxALZgCdhi2n7o4y5Cw85LCsdP/5y03Uo6phdIT39L/oqknJ/euVaxUHQhnHRyDHywmDtuD0et7IKEUTPePRLV5Ofb5ZUmc25ftKjCaKPSyyK4c4XEtqezQpjkGYOjGNAeJJKLD3glrQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SVpOLVjS; arc=pass smtp.client-ip=74.125.229.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SVpOLVjS"
Received: by mail-lf2-f12.google.com with SMTP id 2adb3069b0e04-5b5e4f1651bso3323554e87.3
        for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 01:44:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790066661; cv=none;
        d=google.com; s=arc-20260327;
        b=EOHTVOgchsKgcVKoYz3t/LLZnQcKZu1LpsvcObLs7lWdU17gluX50uID1ooGFMd9ml
         tBdUrD2OoOJO6cFRJx5YLV+f+rjp15xQX8VLDPuq6zpCF5qBGGL1XV+xvd5M3NbdTlAP
         osio7dsfwBgnhoyQeLc7ScIJtNdV+UehF+ECUTAHNYGU9JRSfS+20oP4EkLVzECv+esL
         WaI8AVFfOO50zFddnK3DK3hWgmLlXADiORT/73pnVU+R2KwUrGdfAAtBWK/YFrN2m55j
         Z06HDBhWxdE2u+k4SbXfTC7yrc8Gq9JmlT6z8Yn8iqLQ7FqtatoYiX7YpGw0oEyPhY9t
         AAzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WsVALZGvNuNx3Pr3M5+XTqulMSxCzM1LXdhBKksMaY0=;
        fh=ZGPrL+mHtxvFlmC7TzRBsn9pgkvUMeUVWfiptkrOupw=;
        b=sy7Qj8Orl52MXa4eKLI2f16kDqOtKBBkA0F4S7mJGi7BMslHNzoxv42F16wRNb3AFY
         W++eFDhxZxusvO1odXEGWKuTOWH9GNZ9ccaePqVKnhSNmhKOXEkPkaVUe3eT0z1EiRhb
         52JmH5Cwwv5d2mI0VKx38I3+WbSjYbU3TFrD+ePMD0fNcgqfE2RXuxMw1jzooisv57aG
         OhPX+Xx2l8SlB0fDau67AjcUgyyDKwZsnBTCtpD+6HGQGE5/SuPQEwbOOKUWWkaaZLka
         iV4b3UCQ0HazXztgB4C9wJuOz9VcheBG0Gcnj2/mQyc/Escx61DybRixYd/TmYgwvpvP
         kftw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790066661; x=1790671461; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WsVALZGvNuNx3Pr3M5+XTqulMSxCzM1LXdhBKksMaY0=;
        b=SVpOLVjSOXBsn3X5rkexY2ODuRiSuigeaafcuqg9cc0HEEB33C0aiJW+lazBFfuT4V
         CeT8vlWAhfevQG58IHZboFwmSizGlWIEpEbReSlUBkmLNC8PFqUP9gQ432RIvRPmKE/k
         ag0YN4WR88xDkzaMXHvCGCAjhrVP+DWfFz0F4PirVfThOy7ytCxggEjmnq5S9swoS3uY
         R++kyil7ZJUDyhyPsfDri1h42SlnYsN67fbdtXMkiCTZDzuQli5g3xkFijAQ+vMzJM1e
         nmPh9zpyKo7rUwH0AhPkrlA+qMRhKZVF14kWqH+OzH6UR2t2eO019tWDrAnMdZ5IGdS4
         f3ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790066661; x=1790671461;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WsVALZGvNuNx3Pr3M5+XTqulMSxCzM1LXdhBKksMaY0=;
        b=Z08SN2Whgq42WZLAu+oywRoYQBsJMm63es9c6qo9xIUSUDuQ9fvUx267CoO4C3HjH7
         6Rsdj4NzvykjZRBmFjHDlAIB7ksLelzf0++RPnyNtKtz/QeTxhiiKOFo/Yj9hQqneevW
         bgStu+HUBnBazJNnWgbepv2LnvTbjFRHr/o8c+4zAAWnL76x8VSuvzXyTUuUte4+yfm8
         rdRG1AqheUruZUPFK1Pswv9335oUMcYG5TI3V+xl0HUubZ4jmkKO8zlNnJaK2KYyUlW5
         mFWKYXqmpNBSbhbRgQBjg2gEodBJWoiDrQQYSimGKwlsq+M3szyvlv/72ejw+Fw89Ke2
         2rYQ==
X-Forwarded-Encrypted: i=1; AKwUvBydzVti3hlcUy7w6WLS9KmtmsOcYISkkFc1TDT7s0dLl7VZubsLKT7PVUTW8KiN7aUgnRQGQEQ=@vger.kernel.org
X-Gm-Message-State: AFuF++mbMHQTMcsJCMFQ7tSjoXLC0kdTtOsX/x/2uIBJUJUI7rj2f/hM
	XK47xLOLO1yrPDcU7Am4DRYX1k41RjiigxCGKeQ8xQ2Oruj3TNg4YsJny+Gt8cahd2tbnYXJjG+
	tvW4otGMJLXdSNtIwtJNyQAOrNG4vlK8=
X-Gm-Gg: AYBFou14PFplwsNqWwobPqSilFgioqUvXI6QE35CLJc4rU4N7jQC9i3bWtCvuxVKb9X
	rLsyXMyKCk9k0CnTfM96QOqH8H4RzmXgMpj6r3APZjGdFWzJGzOW2MVtluZo25bUP3M2jVFShEU
	upFmQtYf7kkWwuugVbTZRUVRrLphh6qp2vzJGhszrX0hyPwRWBeEoDP5bBn1opy/e1NXag6joRF
	702CbSLkOWf4bAgXLTN1Sc+9prAh6MMdzwFC7A1TD/r5e4djwpJmqsUpdR40aKl9Cnt8/RjwgTN
	qlpJmXDks4zXqjj2uIunpbDl1WBSZGcJnieiW8rTcGfJdXfLB1Zbc8tXWedvDb5JYLCIXX2tBo7
	dEHY2TRhyr6s+AseptNxKwOpGt7PUeY1qv6ggJwExv0PO
X-Received: by 2002:a05:6512:b9e:b0:5b6:1870:2689 with SMTP id
 2adb3069b0e04-5b8c1955f0emr3870626e87.58.1790066660778; Tue, 22 Sep 2026
 01:44:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260921235951.3214-1-sigefriedhyy@gmail.com> <20260921235951.3214-3-sigefriedhyy@gmail.com>
 <adc2bc61-d832-4e9d-818b-e5d03fed0fca@6wind.com>
In-Reply-To: <adc2bc61-d832-4e9d-818b-e5d03fed0fca@6wind.com>
From: Yuyang Huang <sigefriedhyy@gmail.com>
Date: Tue, 22 Sep 2026 17:44:07 +0900
X-Gm-Features: AcwNN1VJxh1M-j0f2S_sS1Tn5lZAUShRZrC3tTvY2gbK724PVnkPgKNJHtZU710
Message-ID: <CA+7S2v+CCVeVVCeF8_hxL=mya2pjrT9By6ey+kAkjRWG8xQ1hw@mail.gmail.com>
Subject: Re: [PATCH net-next v6 2/4] net: add AF_PACKET multicast dumps
To: nicolas.dichtel@6wind.com
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	David Ahern <dsahern@kernel.org>, Donald Hunter <donald.hunter@gmail.com>, 
	Eric Dumazet <edumazet@google.com>, Ido Schimmel <idosch@nvidia.com>, 
	Jacob Keller <jacob.e.keller@intel.com>, Jakub Kicinski <kuba@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Nikolaos Gkarlis <nickgarlis@gmail.com>, 
	Paolo Abeni <pabeni@redhat.com>, Sabrina Dubroca <sd@queasysnail.net>, Shuah Khan <shuah@kernel.org>, 
	Simon Horman <horms@kernel.org>, Stanislav Fomichev <sdf.kernel@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 22, 2026 at 4:20=E2=80=AFPM Nicolas Dichtel
<nicolas.dichtel@6wind.com> wrote:
> dev_base_seq only indicates whether the netdevice list has changed, not w=
hether
> the addr list has changed. It's only a partial consistency check.
> See inet_base_seq()/inet6_base_seq().
>
> I don't see an equivalent of dev_addr_genid for the L2 mcaddr list; it sh=
ould
> probably be added.

Thanks for the suggestion, I will fix this issue in v7: I think I need
to  add a per netns counter bumped on dev->mc changes and combine it
with dev_base_seq like inet_base_seq() does.

Thanks,

Yuyang
