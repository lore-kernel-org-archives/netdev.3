Received: from mail-qv2-f12.google.com (mail-qv2-f12.google.com [74.125.230.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 268A655D886
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 23:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789602842; cv=pass; b=VhKEVzcKI20TUqNAlL8XOPjvcHexXSfiisaG7DT13OmVn2sJlWfjzcY3tyBlbcqeGZ0vDMsn5RjjMdf6MYG0mA+b6Fax+fgNjS7P22/J9hctQqW4uhShwRY1bSTUc9U+MTqeoXUVgEskangMuOwQKWR7sWswSls4gMk9/9fv460=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789602842; c=relaxed/simple;
	bh=Yl8nSjxuwI/LouP4WDHFD4P4zMMIU3JlJ+zSqw0WuNY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X5Lt4jBKUZuxfWBXDDZWJ2KT4D0WeVKyxDH0JdoNWdy9+WH+gTvG0QB8wdXWeJ/sQ2e82WhOaruRCRaGfhP3998Zz7FQdtfLsSVplSpORVaD927hawI8knDTGLvrfKZ8FkEkqfKF/kjaI8+lT8HP0kDhj2xxANaqCNmvs8kHIM0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ArOkzrg8; arc=pass smtp.client-ip=74.125.230.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ArOkzrg8"
Received: by mail-qv2-f12.google.com with SMTP id 6a1803df08f44-910399d8b09so1764316d6.2
        for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 16:53:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789602837; cv=none;
        d=google.com; s=arc-20260327;
        b=AyEgM1Lex1mmGXTwVI4n5NTNsbIWl+UYziO0wRIwG/sVnMRQ3wYGtxWnlBrI+qPnOM
         KKSqA0OxthE5v0oS2/vOqwAA5iIxYXJE2LIc4tnFbvfLVU/u+lw0uqjrvLwehx0wuqSq
         iCuu5INY2s99pXbxsP3S3D+PmFUT53EgrDURaJyQBHUSBqA3S3nEvDtYETb6Kohugl7i
         Qaykmk4ETOW/34PtJez92L0hZpEivcpyHxL/HTjGGI0AjUmohXPL9pvsIK81By8cntET
         hKslsfCgBOkia4l1uW5aQa7ayZNhMAacZtYaZfbLDiRgTzW0HempUWx6GlCFvBTQhVZf
         8l/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Yl8nSjxuwI/LouP4WDHFD4P4zMMIU3JlJ+zSqw0WuNY=;
        fh=36q1Lt8q3zfl7X3TkeWNwhUqUBBQFh+PEjaJgK+WfFQ=;
        b=md7NCWWzEzzixB5kAq+bBvXfKLld3dic718JzEPvV9G0AuheQqFlMV2/jSNyhzMtNN
         IvWXq18ciTcWVmz8vBAe+1SNANHSg1H7tFiQBdwOJK3KT2Kns7Be/4Lk+XGdlURJOkJA
         0G5Xp1sB4XfvSt8voxVZli7zSXIkMu9eoS12DbIhuEoCPYGd0uNvVjfS7QnDsxil2B8g
         XYI2o424CsIqRcZu2Cr981sJYOrBl1w1JatK9yw/e3byj47W9P3ZXrToWUYlTvuKVlkN
         EbHMx0Pb/F5DAh/tSJWYFRyVrbDSHD32WMK+Z848Viqi9PxWoGyp7C76TGcfPUx461Hs
         BV4g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789602837; x=1790207637; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Yl8nSjxuwI/LouP4WDHFD4P4zMMIU3JlJ+zSqw0WuNY=;
        b=ArOkzrg826arSO0VE1NlwbWu/vL5x0ReoqjRP8VxbLlXBDnsEsuU+pXazae/taCubh
         X5LqWj8yiH5a2WMQDp0lsLoarEtA1B50vqLDtT9LJ5D6RHafupLw6/8yEMNj1XD5B4Rw
         vXpGOsHrYHjj9zo0PGYT3hd2DcjLRnfCpWNzn5AYb2q+wdVKUaLnyNk+JTcgqb/tnQdH
         PgH8IqL5q8MXU8QJ8NJGK9bwSfaKLzLWUBLx/7UXOWiJpG/R8gPKUJGvXiTHIDSugIFT
         uvBHT6KqjBuqCp+qpri2oO5K+rmPhLLdhcMGcRGE2pj2aFwA7i8T/QBZj09J7bkjEEg+
         VRBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789602837; x=1790207637;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Yl8nSjxuwI/LouP4WDHFD4P4zMMIU3JlJ+zSqw0WuNY=;
        b=UraB9VBhWl4iRLqPhlBwnbWJzU+RTA4e436FFoz2ltTLda/2bjQkp9dilca9+cYo5r
         WqNuWwH+3EMn4+se2CSKzsNETnaRBv7RcBbDXHVdBl3tJANHUF29K0VNzDMcE397iIGu
         VKUH48y9jU0hieEqL+ZWy7UPQ7Uxc1BTQfBnrRv90wVYK3Pstz0gnFYZXyu0ihs+0q8s
         nxV6iFpcx7JdeWCkXt6iTgI/Vu5+tBqV/2znqRGQvNt6JNcG9Rmm2vDmdYwZm6qIzTDq
         CqgTTPKT3uPSB8yy4okFHHdBtoq6XxkfRkyQaNQ9XAiDGCZH/KgEjOQ5K5rwa9UdwZIb
         WV4g==
X-Forwarded-Encrypted: i=1; AKwUvBw4LgePkQVd8ezpv6U09/L8+5LhsIUPVyDX9SU23q2hGXJz/uKDb92P7yhe34Vfpw3A6tBm7DM=@vger.kernel.org
X-Gm-Message-State: AFuF++k2jaJHXqdOUDuPyRbxUD0nJnIpLePwrHwsGwE/f8rtEV40UMhY
	pOkCT9jEUiZoHh+RqsVtdp9AE4UPe8xGgIpV7+kdg/N9h2BEUvPJoAhjxEULcnFkbfr2lmQNCbg
	x69wk15S6c+sNK0MMPgaa19/sSmS4icw=
X-Gm-Gg: AYBFou2HxzQy7FJnqmsbYHmXEVC3PD+vmLrgXIKZIhJ3iDlCMk3HtJosva0mnM9GJq9
	YgEdnXYa4S/b7akDMRO/F/es0v1ypAsMoBV+GX11X7NDguzsbJyLUSkilzwngkw1C2yf1HoBuQ9
	utAzLFkXR2eW+wVybDJb2QLtOqPjcMx2v5/mfOeIsQK4R1QvX14mZJRNIk+VgkH6l6BeryN1jFT
	uW932fTWkNSxylFW5extRjvwAdDeR7a2ArkXrAv3+3rog6qulJc0y+ZP6N/JHuRY5ytxcH33D5E
	j7FtuXmqChBZn5st6TGlLZcyrACrBzTWKd+yy+abtRn4kA6RaCtaAcEvqCNv3ZAtaQ==
X-Received: by 2002:a05:6214:cce:b0:910:94c6:2ea1 with SMTP id
 6a1803df08f44-9123d7318a0mr91642006d6.12.1789602836616; Wed, 16 Sep 2026
 16:53:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260901083001.8044-1-ansuelsmth@gmail.com> <9609a821-c971-491c-9436-9346c48d2ee5@bootlin.com>
In-Reply-To: <9609a821-c971-491c-9436-9346c48d2ee5@bootlin.com>
From: "Christian Marangi (Ansuel)" <ansuelsmth@gmail.com>
Date: Thu, 17 Sep 2026 01:53:44 +0200
X-Gm-Features: AcwNN1XEi8i0bR0p6V2XML1oNL1EMS0XGZ-YJo8qlzp3ByfRA3buomyIp2Ok6rc
Message-ID: <CA+_ehUw0KK8mHDmaH7UBKxq-By7CvXCaWDUg9NvoMPzSe5cgHw@mail.gmail.com>
Subject: Re: [PATCH net-next v15 00/12] net: pcs: Introduce support for fwnode PCS
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Lorenzo Bianconi <lorenzo@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Russell King <linux@armlinux.org.uk>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, netdev@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Il giorno mer 16 set 2026 alle ore 18:20 Maxime Chevallier
<maxime.chevallier@bootlin.com> ha scritto:
>
> Hi Christian,
>
> On 9/1/26 10:29, Christian Marangi wrote:
> > This series introduce a most awaited feature that is correctly
> > provide PCS with fwnode without having to use specific export symbol
> > and additional handling of PCS in phylink.
>
> I tried to re-rerun the mvpp2 prototype conversion, but it looks like the
> series doesn't apply cleanly on net-next anymore :(
>

Hi Maxime,

yes the conflict was caused by LRO patch on the airoha ethernet driver.
I just sent v16 with the series rebased.

Also Andrew had something to say for the mvpp2 patch so maybe we
can discuss how to improve that.
