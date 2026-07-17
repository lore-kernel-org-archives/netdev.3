Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F7E23CAA30
	for <netdev@vger.kernel.org>; Fri, 17 Jul 2026 10:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784285672; cv=pass; b=lxMLRB131BesQMVgG5n7ayKMI+xwXf/YrNVsG7QaPxVZ27H91HmVHt6dwt46WZRHz/F6yzKXSDsGsfo1Apst27vZPoq9CZSwbFvZ4iRYWOaBA+Voi7oMgsvqQh4j2iBfPKHuL/hFuXZd9GtNhz5qEkU0bseQjMRHc5gihry0l+M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784285672; c=relaxed/simple;
	bh=nrUOAzZP+2PovXelAOxDB+zIxV92Uw5aftCZN9sCZRo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e5cS2+851/KeEN+jpLr7O/Rz5Jpopyy54lD9PgJtXw+Ac2/NT4Jxu6i67vBNfIzjBq6zCI/nZ+Unr74XicPuhJeka84YBatE14Rtxcf8CG4Irbwboxz59+zecW5b1/Gil2XZVcRoEgjJaGhNMdqc++0HEIn58kdCithNUi0lP6s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KT6sTnVB; arc=pass smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KT6sTnVB"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-c15cb6f5c12so1340808466b.0
        for <netdev@vger.kernel.org>; Fri, 17 Jul 2026 03:54:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784285669; cv=none;
        d=google.com; s=arc-20260327;
        b=g9/V0VytsnTKHxEB52ivBgJKKTEqFvcAhXhWUsq9kRWSJeUKiyjEgdbH2jGRwfzOUD
         g37Wea5Xde9zdZkN7pbOEmRJDuYlVdHXHNtMOpnX6YHXXbI0E/jhWNMJ4oThMtk3QJbk
         2/cJ0Vk+UkA3Dcfc+x+sntnLB4ymdZ+1TQclBvMhcCKIa2yYzvVp7F4cBrDKIyyqQUZB
         UfRazhsLs8QhLv2R6ZxaHQG/e8mVu6l25iETleilmZdT75SXhzkiiy6dcJdEL/RLsTO9
         rMXw+AZMqtVMRhwqDe+EtkGLQRKdaE46jFCtUVAxqowkcZuUvzIArylLgtzlaTFvrqHx
         kqGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nrUOAzZP+2PovXelAOxDB+zIxV92Uw5aftCZN9sCZRo=;
        fh=0k6ClmQ7ebdjHUFYoeHuN0SNtuYTErN8yXx6AVT1E0A=;
        b=FZjgCa0qBivKd9Y5WVDpissHa0vJvMwZCkrSOhOHa6sa1ecDAff4EsFd5VCSMccAte
         UMHSBbcIpdXEcph5KSFcm38zZOQuqqy+wU/lB8zap+tmKGkVReGCl8XB6KrRYgBBOkvD
         mjLMvrYynMkjefG4RZqkp2VSCIEwkSui+yGYMR75zEJ/nbTX3yh+lSKBHPKr8YU7sUFF
         t5umDUCCX76e9Yp9bRa0tDELcRbaJY8A9SMU/l2AFXP2Sv7jPlpPeEuxAQUFYEONOi36
         WUkru7wHdtv+6zKLx4lKThwkb8iqAzBQBKK6ncoA28N52k6gnkhlCTILI4+beMCvljvn
         bHrg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784285669; x=1784890469; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=nrUOAzZP+2PovXelAOxDB+zIxV92Uw5aftCZN9sCZRo=;
        b=KT6sTnVBbr+LRGt99Z4DtIUdyXuId7DARTg0iHwVDGrN5Irv1lv1SMMxJgb+1sgcAX
         PGfK+GGomZIblZtvvbX0GsJkyiIrKi9DqqWYy3FApy+5QRr+ZhY4cltnnFljS3cpuYAc
         uwySH4tXyu6ngffucwwQIpA1UQC5S8jWJjiaiRdFW/UYgLzRTut/3HT44UFu6tdbzdst
         HhgvS2/zCKG8YFQQKEWAub3SSbYbg/iNxGTgqtUYJLcUglONHSFoy6GnWohQLlPgxBBJ
         vdarJYomLSKBrhNRXTGFxj+U3UdneDl08B1EdlUDYyM4undQr7Ra29x0wxaaMZ/8j0HS
         x9HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784285669; x=1784890469;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nrUOAzZP+2PovXelAOxDB+zIxV92Uw5aftCZN9sCZRo=;
        b=p9UtwRGHIsEjuRbRMLhTSUC2d0Ycg2yzCzYWVQl6bC+oijiEv5Tti8hHxsttd4z8av
         kbz30XpN/x+2GzzbtwcTVtiQl5aeKbLu241HaL16Lq31c7PA5HwxUPd9vVJ7pFJMo0h5
         pwrc3Jqs9GpAMqPi9zlRkKVWXUIigxyY7MKRX5A/C8Sn9Vr8gdymoNV1FknV9gHqCtZ4
         2jr6CeeYBE/Lb/p4Kg6VhPZYook/s6xn/1G/HROmqYFjbBJb/ithr12p2Vxsaf8St4um
         n+jvwKe3CFYiauhez8Svx/56jSWH9D3jy/gcYvg/VSwsK9NN/URZtuaAcNEFm36A5L6q
         Of7A==
X-Forwarded-Encrypted: i=1; AHgh+RoX6XEnL+i9Gpv86kTDkN8t85n9CyvwsoLXt2IYinDyeAAJhyuH6gnjzCQpPGodgpbXq4tQNz4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQyvBgkpuTGfyVr0AG3FB3TOnKoGhrKk6RVOuHKAccjDHhLHuK
	l8X2y7DyQYENc60bm2yC1xtPqy6rHpAMkJT4/kmzulm7zrcq9gjT2YbiEguu4PXsDevzQLNNa+P
	9IrbIczgu12+Uk4Xp8EnuDETmHCcuwKc=
X-Gm-Gg: AfdE7cnmc2unI/AxD/uFY2zy8Xpjsj0eHdBoqnGGaa2sNdJKmAkq7o65Yrbh//rdq9z
	xH6VbALDSAX1TmpfDRMqNK0Pl1QaQ00fFrzIxRzFOJL18MT6v3QqDZcoy9J67E1rn+nWO5AHNup
	6coZZJDXypzjprxdrq74OQkFPXDZQfzRaRiMD8HYb4sjU5a1EvaUGBDP6fSnO7PkDBy0db3Ru9y
	K7Vs3NArY6IQHR4gwgP/dNpOViIz/VxLqrug8A/eVDtBLptlu1hlu/TKXh3+8WkgRIDxrUUqQ==
X-Received: by 2002:a17:907:3d4e:b0:c15:feeb:3e45 with SMTP id
 a640c23a62f3a-c16b4837b8bmr90457866b.52.1784285668347; Fri, 17 Jul 2026
 03:54:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260716173325.653164-1-a.shimko.dev@gmail.com>
 <20260716173325.653164-2-a.shimko.dev@gmail.com> <178422864835.973481.10210790720231842764.robh@kernel.org>
In-Reply-To: <178422864835.973481.10210790720231842764.robh@kernel.org>
From: Artem Shimko <a.shimko.dev@gmail.com>
Date: Fri, 17 Jul 2026 13:54:14 +0300
X-Gm-Features: AUfX_myeFyDWKB8pzxvQLcYhFuIzm8JDbRrBR034Mt1Z7dCwsamuZ-myBwWoMsQ
Message-ID: <CAOPX745M-8_oCC+OSi3AQE1gfNmqndXW-eVHzeSO3dbgN-uy-w@mail.gmail.com>
Subject: Re: [PATCH net-next v3 1/2] dt-bindings: net: add DAPU Telecom
 DAP8211R(I) PHY binding
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>, Maxime Chevallier <maxime.chevallier@bootlin.com>, 
	linux-kernel@vger.kernel.org, Heiner Kallweit <hkallweit1@gmail.com>, netdev@vger.kernel.org, 
	"David S . Miller" <davem@davemloft.net>, devicetree@vger.kernel.org, 
	Conor Dooley <conor+dt@kernel.org>, Russell King <linux@armlinux.org.uk>, 
	Jakub Kicinski <kuba@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Rob,
On Thu, Jul 16, 2026 at 10:04=E2=80=AFPM Rob Herring (Arm) <robh@kernel.org=
> wrote:

> My bot found errors running 'make dt_binding_check' on your patch:

Oh, thank you, I will try to fix it.
--
Best regards,
Artem
