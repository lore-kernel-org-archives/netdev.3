Received: from mail-dy2-f12.google.com (mail-dy2-f12.google.com [74.125.229.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF6DA5328C1
	for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 16:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.229.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790180609; cv=pass; b=Dqsq+P1FpS+Tqhpq8/5sC2JEQ2gokW52PWExt3m+eZVJM2tL0QlW7G1BeQVeVdmYeqY+KF9dvGg6VslKoSTRkQYJF2yyJAt9YtpJhORFFQdJDx6ghCh8CFJ0Bfo+9pk1f5EmWrJXVIdqC4mIV0BjNmbQDp+oETNhzUZ9bhnASqU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790180609; c=relaxed/simple;
	bh=vwFPNenlD2vZUkkMCjc8UFuJO/cF0xzireOhDjif8kw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bhRx/+Zznb5INVT3EvBdyI3Vhl6GSxNBHRXqOobKzkWfIEmYXfOAZ7I+fXhtEneugIregSu+aFE9aCV/nG/t/RUueoPX90z6X9+klEtzFagujGSMjEAns0n22oOmIkVqSEcDAAou4GIglvKKevgvX9Aom25ytMqODwlTu2F2n08=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ioy2mjYg; arc=pass smtp.client-ip=74.125.229.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ioy2mjYg"
Received: by mail-dy2-f12.google.com with SMTP id 5a478bee46e88-33175556ebbso671551eec.2
        for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 09:23:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790180607; cv=none;
        d=google.com; s=arc-20260327;
        b=NJoku0l/a886zFCQQDs9SbwnG5YJKplqeP1mY+rmBOVT8wo6l5JQXjRAmHWmntW9VC
         LlF3unv442ERJBPiRVKloVwyeWNz0WmtNJirssntpB/BZjERv5qqEGJe/SV6xAwIt1yP
         hRI3C6IyNdDaTjfHtIziLBiU9LH3WoBMvOzcCV2TV8JnBJ/ScCh1K+TFuMkBpzfFSE5W
         ttrvAjKfiAaqSpIT/6ZDsMSiTtIyrL6ZAhjHb02ieXLh83pM2FR/QYFzJOMnCwllWiWi
         KHj1BI6zcxn033KeIYyPHQJgwcdsTLaHnPKJWNbMgyKjois/bBuxV+FApjOuWTqWNLp7
         egYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vwFPNenlD2vZUkkMCjc8UFuJO/cF0xzireOhDjif8kw=;
        fh=4U49gkC7VXBmXk4yth+BfAOTI/R6cPwEWM4U/n+FAb4=;
        b=RXnkLh8/DleIBKt0jA4HCBgQluWq1BGdLn/N9ugy3mZ7n+PAq5ZGhXjeXSHIRuo8Sb
         BX10UsnHRnouJEYJm07gLgeWX3p0VbLViuZY4nRraB0MxcDiSf7WwDJDjvFD70EagWun
         5lCGIkYePc7OiBhqN++lFE+T/xquYICFYDtsmvpTRh7NT3N/2h7EBXKZlwxYJ8EBYmu9
         LFUxqLyrNIN/MolEUv+rcpyGvtFn7AqX9kbmjCo2Z5QcL6iDsFXxCAZozfwHPjkIt0pr
         ttN9/6lgcc3Oh6rh/0o3apSubIPX44XwLDY+ddGf440ZzF6Rbv9RNb2bsb184NzDcOEJ
         GISQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790180607; x=1790785407; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vwFPNenlD2vZUkkMCjc8UFuJO/cF0xzireOhDjif8kw=;
        b=Ioy2mjYgXsOKOftjhvkdnHm6meYtlO6HEwL8bhTRomSTnVJOj5EhELc+ZE4BWnI7sM
         66wk6GKrGd0sohohGJh/ZnX0TYBFCTkODFQPls9iPllmiIPoylH1WOX9oO5+V0p4YLwo
         RqK/nXrQhBfr93oyDGzR3ka4PCXdKZAjyr7S3Js2qIwTFaVqmCRoGSVE+RnplNaATSCe
         jPSNvtH3PEix2ioG9YDUNMx5aqLsx7u/MseYleyniLbAAwSQlt4WUF6X0U+vZJ/ne3f0
         BvGpWVct/LjkuPN8QI5QLgLe5nPe7f0VIZGLsAqKNClBA5e/RPxRfwQUPJTyhNPt06gD
         gH7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790180607; x=1790785407;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vwFPNenlD2vZUkkMCjc8UFuJO/cF0xzireOhDjif8kw=;
        b=BFWYEr3n3iyEOfpRP3oY5EWyruZOBeg6IoNPPSegPbcgIympwIpRdd9gBGrdBq0LRv
         wvpUNBJm+TqNrX/V77Rg83w6JGrK8NdML2TQ3Pcjsg4H4FSxuD8E9FMyRPUEcdpr+hPa
         1gfNdlL9MiUQo2mfrcKOt+6PH4CH7n+JXq0dHqs3KkIODwqx5nL4+Q5nf1O99bn2V5wS
         Ytdx7Ug9C7asdzmNzxKiDLdyFBDi1QCNzP4tj/6fm4/1YiSg9kel8XEKjsptMsk0TEo0
         7QCf5QHGh1/Uhi9PdVY7x+o19bZwJsTDaQYuPg/rK+SLi+1IypNUi9s+Q9SjwwG5rdTU
         mQAQ==
X-Forwarded-Encrypted: i=1; AKwUvBy3SDSz+8oCkhfm7CGYmd4bAYmjL1O5UXNcV+Nlt38zvJ7adOywAVN4x74OI5dIVG84MmnlbW4=@vger.kernel.org
X-Gm-Message-State: AFuF++ka05MPdImCBW1uuzZ+X44Xfk7xyLzmOuCG3xJP5KS9VwjFXsny
	pJOCw+MeV8dhfTFr0/NNP3ly6SITjLb/kQRpTtkIhUTLKJ6tqi2Yl87KeUqeWXA4x5Kp7yc+xdY
	1/QgOZN7XSLJMx8uVGxwt4yaBzzZgL4s=
X-Gm-Gg: AYBFou2rSxU5yRSjfHMq5HoA2YqgCpifBwhf8tNtZRzxC0FSfW5fS9SSkcxNOiZQkTA
	73+WM6nzXbpZuHfioTdVnqUdbozWAnTZUjuJX7Lx53zOH2VF2kt6B/HHzhSvYuPXs6FVRnVOQFj
	MqvwPzR+seQ/tYNBg+lgCRHZ9q3Ec0xbHUWUX0zhww2qeaFUTXgMXLaj6o77l6yQrB1aIynX75A
	e2z6cewF8AKeeZy7eBuIRHvUzfBHKBZXdbW+wxCDJUPsdDHyrxXUzHhXlxzxC5wsZNaiGcW/Kjb
	fehmHr0q6z2iggpWNI+Vjd+3eclBf86HgUZXNmppnCMcTPo00M/+bcTfLhApb8ecmqHvMn25RA6
	hLTjWCQISHxXJm94chTEA4luMR9SYU0+bdEFC3CaxWZOeJEfVXKSwZNS1W5YIUx7oL+nmAgNZ58
	/HZxKLhg==
X-Received: by 2002:a05:7300:56a4:b0:33b:e74c:e43e with SMTP id
 5a478bee46e88-33e8dcc6990mr3004307eec.19.1790180606510; Wed, 23 Sep 2026
 09:23:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260923-b4-fix-pcs-lynx-an-v4-1-3f7927606d12@gmail.com> <20260923161815.qakiviia7lxbu34r@skbuf>
In-Reply-To: <20260923161815.qakiviia7lxbu34r@skbuf>
From: Patryk Biel <pbiel7@gmail.com>
Date: Wed, 23 Sep 2026 18:23:14 +0200
X-Gm-Features: AclHuK-4CqNmQ3uz5wZ1gtFHH-5gwAJSHllM9xsvhEb1dBmioHG3CI6Fp9cWo0g
Message-ID: <CA+DkFDaDQkA1UG-5NMwPUUOxxgiOKGbe1YoFt10wT_207yRHeQ@mail.gmail.com>
Subject: Re: [PATCH net-next v4] net: pcs: lynx: enable autonegotiation for
 10g-qxgmii and usxgmii
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: Ioana Ciornei <ioana.ciornei@nxp.com>, Andrew Lunn <andrew@lunn.ch>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Sep 23, 2026 at 6:18=E2=80=AFPM Vladimir Oltean <vladimir.oltean@nx=
p.com> wrote:
> You are supposed to carry over the received tags from previous patch
> versions. In this case I'll just resend them myself to this version, so
> you need to do nothing further, just keep that in mind for the future.
>
> Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> Tested-by: Vladimir Oltean <vladimir.oltean@nxp.com>

Thanks for the patience. Upstreaming is still something relatively new
to me, and I guess it may take me a little while to get used to all
the conventions.
I'll keep this in mind for future submissions. Thanks again for the
review and testing.

Best regards
Patryk
