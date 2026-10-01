Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7BAA40B38D
	for <netdev@vger.kernel.org>; Thu,  1 Oct 2026 12:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790856894; cv=pass; b=QaJqENCw9+R4UEsZvZjQgMquIHTkgR0F+jDRQcLprerKwJZS2zALwIDjVWUpxBqY81EyYYlCG7HMYCsij79m2/81NTghPCIh9OGA98jfIqQAm/SNSBMLze5HkGmCYetbQ/asVnn1cgoQ2ChZhbgEWGUbzM2xcD2PNckO58kkFBs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790856894; c=relaxed/simple;
	bh=t80nhwRApDWZA93DyMsDHi8I1BEwRmnmkFQwG4H1QEQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Baq7OOEEZea64p+pG2QfSYV2ZexpJ2CggzLTICtm2tv/0WmdKLQiUG0GSyoxouPvFlgfPNQYyvpFTn5MQ4BNajWoGB+lG8ArXQk+M2BZndc9Mvnc8dVfrsns0aRz9YDKe/Lk5B0IKiEyGDj/aPMC4/kbvWud9zrdzp68PX/ozEw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=CX9q+Ujc; arc=pass smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="CX9q+Ujc"
Received: by mail-pz2-f12.google.com with SMTP id d2e1a72fcca58-85469f204f6so3136424b3a.2
        for <netdev@vger.kernel.org>; Thu, 01 Oct 2026 05:14:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790856890; cv=none;
        d=google.com; s=arc-20260327;
        b=IKZd5o26i5Y7QUjTglz/iGJlqsirCYoSp9RD7O4D2aV2o6kmq0mKoha/Kq5ecN1xn8
         mjyq+lHGDCnLYbFZUV03/hXDeU5UAAP94DjYZBpS1vRztsXrasR2m7QUzlb4CYm/Dnjz
         aU+fv337YXPW3qB28/ECfLTcW7y36jBr+TFrQWcpK8NPCKtg4LuE4kvd2VbP+IRhlOlm
         QLMKrydFn2S/uI0aFTDLgoUubQ8O1QCtfBYwsk3RRnosk+HlRCtzu+65U64uK9mWjQuw
         p6PjRiWE/HK3lLmoIS/ERDcFn6nmcT23bK0g4zzfV37lNQTq8/3oBnwHfkiTTCy2zJkw
         Blxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YpU0f3NtjRyuzMkIqJCo4gz/bCKyWtpvBq9HB+O7ccE=;
        fh=rkPNzA2uYb5DnKfda6qgTIa1hzRDElhl47CrI7ydp3M=;
        b=cs+LAbbDo/r7IEGPRG81xg8SyViNJtCovk3oc04OHgwil/VX2ETFqut+EEi8t2l0h+
         Og4SiVgHbZgQ+pnNZu8ZG8HGFSGk+Rnv67SICLDW1gOU3Z+Hs+IuNnrjwZMUoT2usj1u
         a2iS/T6VrPHKWIaek3pBl9dJUTCBoVueURkH2FJ8ZA7FFSJUlpIP3J4AYOHMFw76XTEt
         DDwv3g3+/OSpthBa0si4anmb98NFcYwL6na0XOJBQFm7j0NLL05l1XXfL2jNj6iVws0U
         yHrJzyev6eGq0taPJ3Fvtv6murJ63SIR/FGX6rz77YuZHPiB/W3oVzUE/iqHqSWsHbih
         ZPIg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1790856890; x=1791461690; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=YpU0f3NtjRyuzMkIqJCo4gz/bCKyWtpvBq9HB+O7ccE=;
        b=CX9q+Ujc+9ijyP+hjLjhQHKOA1Ajp3s5G8hxo2Q49I1ChcSodIObiGY3k+tCZ5fhuE
         cKEaci8lNfwxR2JAtFk0QBxmt7cgJFJTegk9HhVcQeuKddj5zMxJGIDM1W7F+PhLb0eb
         QDCbD0DNBN4+IPyhdOVdwwwIklPpDB/SkU/tNYh9CMETu2vE05c6pFIgMMHKHSg79Xco
         JNS/Dw/fG0w/wM6YBf4voHLb+o1QiI/Q6kRouSgQFePjoz38ejkkf+97oFnva09nQyBz
         B0q7tjHJNzfe5ocPl79T04rA6IgNw8RdiGfnYcj+CyD7mbw1nKLyVeL1cg2A4zu7FHvR
         jYiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790856890; x=1791461690;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YpU0f3NtjRyuzMkIqJCo4gz/bCKyWtpvBq9HB+O7ccE=;
        b=Zfnbpv73+szTuZUifLZWZfOyF1Dvo1bva0SwrrxVB9DElGzy9Wh16Ml+Q3nZs2WNUz
         OcLAXxtAHfmnFiM54mRn/3eShrrTg+ByOc3PDXZMfbTjGCVVna43nRlNfI258AfQfPQ9
         i/uUr0wGB76MLUxhRF/Vld9uCTW8apLWcvXTDrNOCtgvcR9nzLv6O5SUktKl95pcecEv
         AIItG4pRPZx5UbwMosA276LuOllGoGoANxAmlkXTbw74FZD9RYyC9ZYtIHCAcw/sGA+i
         F1ZDhPGZIMXevatqISpjQ/7UAtG1iK0Pr64li5ZXwm+Q51TgmgqpkqwmsOP0i3v9bbt9
         dTxA==
X-Forwarded-Encrypted: i=1; AKwUvBxYXU2FJnwp7ExG0NH9ahVInnxcgBD8OpGsrchGgkU2keVgNCvZPa8PHo4G/mYv3yYJyVgJbKE=@vger.kernel.org
X-Gm-Message-State: AFuF++k8aiVV22CzvLE6djFimOAh6i5RZ0/grCX+pMyuy5f2RpLvbiZH
	nMCKFPVy3KYWo9iHljdkgs9SKiuEeSNSyxeJKQKK/FKHEe6C72njDOkw1LpQ3epp6B/S1snzCCQ
	XSVEb4SCNBCr1+MF+/tbgbrI4gufeDZR18SLMxDZmWg==
X-Gm-Gg: AYBFou0aTF3mnmB1COnJzkU89hpxUGftU7YSiLyuh3rEhViiDrT9aPH7C35yYF45CPz
	Lq2NrT4wVjr1g2HnExUQ9YEtclKWnlq5hrqCdOXV56SZ8x2zib4wiCeyRKUojs13ZWMXs3w0m7a
	k/Fvd0xGVroOwm0SPZsnfTikeGloWU7J2bYXmUWcawMI4XE4Bxhcrr391bw+qiXIl78AzTKJIz0
	fifmxQ8EXGMaBOZU/8D9td2zwyDQJ22iyP49bjpBbXsn/ur5P4Yg/aTE+0F8pMhZRs1EyML+lHb
	aEokZv3/SrOcXNJOX2Zl71Fg+OWlhCb07a06jIknwzXCOG2dWDj9So210QsxsmRk7YctYScUDlp
	HMujzVgiHTNIv7CJW2CJXOik0ZMZ/XUAg3YI=
X-Received: by 2002:a05:6a00:99b:b0:880:78ca:8408 with SMTP id
 d2e1a72fcca58-887498020a8mr4062364b3a.7.1790856890524; Thu, 01 Oct 2026
 05:14:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260930122305.293686-1-robert.marko@sartura.hr>
 <20260930122305.293686-4-robert.marko@sartura.hr> <20261001-splendid-athletic-coot-1bbbb6@quoll>
In-Reply-To: <20261001-splendid-athletic-coot-1bbbb6@quoll>
From: Robert Marko <robert.marko@sartura.hr>
Date: Thu, 1 Oct 2026 14:14:39 +0200
X-Gm-Features: AclHuK_WE9ut5IG7WpoJ3i8LiSUCQkUGd-Zayy7qamfoOiiMgfWXeX1Yay2v7OY
Message-ID: <CA+HBbNEOiAw+_zzQco13nNzUPdGUgo+kjcRzLFEA4LmnzF8_=A@mail.gmail.com>
Subject: Re: [PATCH 4/5] dt-bindings: net: maxlinear: add MxL86211C lane
 mapping support
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org, 
	kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, hkallweit1@gmail.com, lxu@maxlinear.com, 
	michael@walle.cc, netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, luka.perkov@sartura.hr
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 1, 2026 at 7:55=E2=80=AFAM Krzysztof Kozlowski <krzk@kernel.org=
> wrote:
>
> On Wed, Sep 30, 2026 at 02:22:16PM +0200, Robert Marko wrote:
> > Describe the optional lane-to-ASP mapping for the MxL86211C PHY.
> >
> > The mapping accounts for board-level swaps between its physical TPI
> > lanes and analog signal processing lanes.
> >
> > MxL86211C supports per lane mapping.
> >
> > Signed-off-by: Robert Marko <robert.marko@sartura.hr>
> > ---
> >  .../bindings/net/maxlinear,gpy2xx.yaml        | 19 +++++++++++++++++++
> >  1 file changed, 19 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/net/maxlinear,gpy2xx.yam=
l b/Documentation/devicetree/bindings/net/maxlinear,gpy2xx.yaml
> > index 0645e885f1747..b98cb3c3e6d49 100644
> > --- a/Documentation/devicetree/bindings/net/maxlinear,gpy2xx.yaml
> > +++ b/Documentation/devicetree/bindings/net/maxlinear,gpy2xx.yaml
> > @@ -22,6 +22,21 @@ allOf:
> >
> >      then:
> >        properties:
> > +        maxlinear,lane-asp-map:
> > +          description: |
> > +            Mapping of the physical TPI lanes A through D to the PHY's
> > +            analog signal processing lanes (ASPs). The array index ide=
ntifies
>
> Are there other lanes as well? Not ASP? What sort? data-lanes does not
> fit here?

Hi,
I tried to keep it similar to the datasheet, but looking back, a more
appropriate
name would be ASP instances instead of lanes.

I am not sure if data-lanes describe what it is fully but I am open to idea=
s.

Regards,
Robert

>
> > +            physical lane A, B, C, or D, while its value identifies AS=
P A, B,
> > +            C, or D, encoded as 0 through 3. Each ASP must be mapped e=
xactly
> > +            once. Omit the property to retain the hardware reset mappi=
ng.
> > +          $ref: /schemas/types.yaml#/definitions/uint32-array
>
> Best regards,
> Krzysztof
>


--=20
Robert Marko
Staff Embedded Linux Engineer
Sartura d.d.
Lendavska ulica 16a
10000 Zagreb, Croatia
Email: robert.marko@sartura.hr
Web: www.sartura.hr
