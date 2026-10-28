Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.179
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793181420;
	b=Y2E9bt84ejaGBEKGXIx8d6DwRymcI2FnrvtkBWyR/ZekBQGDF4kOgNziAdnxSo6EtG3h
	 AIo6PUdDVNkmvnU6V/voql9WY3jc5Gnpq+1j4ArP0WiJm2Tpom0iz/WrZzD8lhZXKmJO1
	 gPR7HEzdr402NTNqP+xcMwrv1qrgFvAog2/toIFequvuNu/8J33H1jWz8yO1Pt9ldhrx9
	 EL6vAJxAujjWLMLFB51pvTTq4cmIQmDFzFk+97j+K0SF3xUEkuJrm3GFWdYo12jFvQ6I1
	 tz5jMpqrT257dApnJfAeKQSFDxQslYsQBMLc3fY7ZJQGwxAVSt5dZTHrH7eVY22sBkw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793181420;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=a6VquXVuy5Rn9GUpP2B3hYMvofEzquSuBwCkA3bH58M=;
	b=2u7wVjtiEAj4lNdeK9Bu8T8gEgFXdYBTYug9f484G//vhEerb41WelFtQQDICctYWoxm
	 Z+wTJ0pkofAWvp50Re2v3qGyJXWD7vRT9GbG2GQ3P4OOz+wqVo9Gf7JAl02TahSnWaQjj
	 ZPZ9q2/4YiviTwT26K24+CqHQ98vgSwfpUvHiWz3tY0zgW9OAEPy1aj9nKtJL326pUb7C
	 m4bIWxTXpXmEVnmUfRqBSpFKHI/LVuMGZRsoLT31JrUG3I1TmOCZyHq2SwKCyw60cEhyG
	 SXBd7p6Du2huUcQiaYI5kIglLCsEcZkiqFAA0nskNbu0wxf8/scQG+da0F4XQt+qfNQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CMLP3jdS;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.179
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51FB5606A32F
	for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 09:56:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 51FB5606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CMLP3jdS
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-8ab38a051aaso6939987b3.3
        for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 02:56:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793181418; cv=none;
        d=google.com; s=arc-20260327;
        b=po5u1ltZBo21ZTa64i/YyLIJE9cBKQzVjWs5qLEQx5ZXVf8wpI9yVHyGFIfUo1qqcf
         SQy7l1RjlNtAltXfuUN+B+ZhHNNsJBR0q/W7AwXoZXIHBy/rB7MNAbKHQSI78Bpfjf9e
         ZkLaCgZaB2WtEpr6Ayj+KTnv3PT4Gt0bSJWo7q10EUjjGYjYauk+qcxpkBOWokDLbaMm
         bDUrGE+v1OfejZHAtobzv+RzjXWzlprmpTJBaTkahWZ7xooV33FC+Et+71uZO6XyAMhi
         hVCdCnE4kyuOebuEe9KK36VsZh4T/hKqR8WFfr0N8fRpZBej149wuapwcnrqNHEpXLzH
         zKCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=a6VquXVuy5Rn9GUpP2B3hYMvofEzquSuBwCkA3bH58M=;
        fh=3rM+mk4x3Nd7dZrGPPzl8nXyUwXhAg6S1dYaTlDEkdw=;
        b=YJ2dIZYYWN3zjSdvX0uSHQ0Epo7rGDhP4d1Xfo2mDsm1/xHHShA9akWkJo3vGvnvlJ
         FiYfsoRz9OcquIFANFR7LjbDwvHpWTEzGEbuEWdx5tImM1ZAt2IltgjO3hbVKae/PzIX
         jvVblVKcTaWnxYZ3jXEn2stpLFBO0BqVTV7gXsmh6BKjNdxlFlZCUfyQI8R+hDvvekDG
         8HRV6AMsrDNv8655XUI1L9ZttXzrC21tKBX84hV57CCRaMWa8AEem3NrieJ7Hz9vLoJQ
         2bllyknM6iR+nlu6QbQnkda1rxx2tNgXGQwdAClpeLlDNfYLVPL2R1V8udpAsR1MMjmA
         3qow==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793181418; x=1793786218; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=a6VquXVuy5Rn9GUpP2B3hYMvofEzquSuBwCkA3bH58M=;
        b=CMLP3jdSANHWS50nZgDA+1WI/PAOcQyDpNF6QkdN+gmdfDVz6NU0mSpKiLoLJpK/M/
         o9eM7cEA19z9y9HnU3kL3roYfDQ0x7kshoW/Gqc+n5b+eDKpk23vndMOxiqDHEBcSNT4
         dC+/tToh0yS7EkbYtHO3SPeRL0oROZCponZ0S9nqNYAS8tqXxctEDjTE65L65B+mIr6v
         G281ujnLO0rZU+91WH3uffJGddKQiJx+z2TRcVnvFbMtW2aoapz8He58TSa4FKEwdZnZ
         ERb9JiG+XxDws3S/L5h4wX1blZwLpRNhJq5hP9JCLQTNolO4JyGWMuFiIrgzcMb7iN8/
         auGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793181418; x=1793786218;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=a6VquXVuy5Rn9GUpP2B3hYMvofEzquSuBwCkA3bH58M=;
        b=HFESRP74bdg1KNKAs2QkKDp257Px+AodWYehfQs0GOXqBwUS0mezxcExoIrcH74fpN
         8gRYe6E7NRvMb55+55LqA+2zHVIwzvxFWf9w73kPa1Hx9HPoJckfMdJQWT7jlwJ7TdK7
         7U8oeieNHP2sxPQ6bP2+rBiLW1nH1WzK2kWKHg+AZaojVMWi4d9scFaTd51N1Ysnv+N4
         ieagkEIa3XeiPhuJjqgaLZV4VhJ/ddQOT7zm1EGVFnVErFD0EHRLMS5GdH1/jMXB4TBF
         QT5kxxtd15Rviuj9UHRRPn54f2AyZjZF76kZz4Zz+ZRwqFp+gL5XG+m8AMXjMDL41NOX
         V7rA==
X-Gm-Message-State: AFq9FYLVIpPu55ToouMx+qf9mGGkQ4DGVZu5FhjTzf34ATJPTQni+tTR
	g05lKdZBwEo6NNDYreVyTTFaxQn+rl0ALQbzE6py42NNSloLcDyjAjGoD6CchBjAfqj8gHLIamr
	gNfoVWVudKBUx9mzCPIGPyGtZTZOE9CA=
X-Gm-Gg: AYBFou05c2wFZsKmYa5JpJ2b3WqtymysAfVyNMeIVXELELaejuWPWas/ZAY908iI9oL
	foRG0d3KRR3xKLHEt8n6FaWItFwLfFR7JPem0qlUhVDCtm4oQVGF6Trfll4eyV8nsQS7UMkCkpo
	AE1QEU7hCdd3/m8MINPx+gLvDRoLOCf4GdZiGiRJk2LsUkAv8uS98EM86FVZxhNEfaf/cpbJKSl
	ac/eVub9Kh8N05bl1OqBZixeB5gwsaFfChmkYBSPt06BSO5j3Zga0dGWMoHBUPWsbrt6xOA9K3p
	ZVDb9/j7jYr7WWWW8E36F9hLiLzyxiRMOKMu4t5CJjekkPh1AV2ZGtHBnu5zlONqBGisBlwlI/h
	ClGbQhc2DxZsa6BH8CW518PDs6SkQJ3Hjr4GkW64DvaemKxLK5fZIPGEXuYx10Er6BUrfUY/5FQ
	TIeBRwS5xxSVXy94ohJtcnF+SdI/SXAQbGVekZXq0IEB709kP5qwlnGMASKWqv52LQtldARb3yo
	7Vj
X-Received: by 2002:a05:690c:e04c:20b0:88f:73b0:fa87 with SMTP id
 00721157ae682-8b1b5a4cbd6mr10598727b3.11.1793181418386; Wed, 28 Oct 2026
 02:56:58 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261027202230.3539646-1-florian.fainelli@broadcom.com> <20261027202230.3539646-5-florian.fainelli@broadcom.com>
In-Reply-To: <20261027202230.3539646-5-florian.fainelli@broadcom.com>
From: Jonas Gorski <jonas.gorski@gmail.com>
Date: Wed, 28 Oct 2026 10:56:47 +0100
X-Gm-Features: AclHuK-sjCMqSTI129BU5xI2mRkdCU8HcsLbGdxa3fy32DUQkYzbgOpiZBy8qP8
Message-ID: <CAOiHx=kWKpYjZce3Ndo3ux8PHBKkZEop2bcBfCn04U8H5tx_ug@mail.gmail.com>
Subject: Re: [PATCH net 4/5] net: dsa: b53: reject conflicting mirror destinations
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>, 
	Vladimir Oltean <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Russell King <linux@armlinux.org.uk>, 
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 27, 2026 at 9:22=E2=80=AFPM Florian Fainelli
<florian.fainelli@broadcom.com> wrote:
>
> The mirror capture control register selects one destination for all
> ingress and egress mirror sources. Adding a rule for a different capture
> port currently overwrites that field and silently redirects all existing
> mirror rules.
>
> Read the capture control before changing any source masks and reject a
> different destination while mirroring is enabled. Return an extack which
> describes the hardware limitation, and propagate a failed capture-control
> read rather than making the decision from uninitialized data.
>
> Clear the capture-port field when the final source is removed so a later
> rule can select a new destination.
>
> Fixes: ed3af5fd08eb ("net: dsa: b53: Add support for port mirroring")
> Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>

Reviewed-by: Jonas Gorski <jonas.gorski@gmail.com>
