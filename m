Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6900B345ED3
	for <netdev@vger.kernel.org>; Wed,  9 Sep 2026 06:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788934938; cv=pass; b=o9tamKZH9oQGYHcXbKU/K/yu7XspI4LNBj7626UMrmSBDMBMnRMrRT6/ICLZnjw8mAfKDLHakakklbZg3Rb5sPeDA7Y86RukyT6symaTBgUZcJMS50xrR3IoOAKhk5qjVhGcelUWmOJFdFMgt11C83DBk5T2cVsxHdjiuA0TyFg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788934938; c=relaxed/simple;
	bh=ZUMAL4Md/OW/2i7TX6skK5sRb7fbFz1d/4ElfK5ssWM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L1BY9WIav+WHdCcxvyxR9IpI23cs3xEoHL2TXevhhPtaVjGsCklI3jcTcq32OnrNMlOOwtoUEe9HyyMVGMeNfLq/rtVxcAAnuQQiESKFYshbXGWWA0UflBhe1XzZeRE3Eex6nH1aOfFhADP6jG88EwEEHGhBX4i1pk/XNmDAttA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ql0FwmNg; arc=pass smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ql0FwmNg"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2ceab75934dso52357305ad.2
        for <netdev@vger.kernel.org>; Tue, 08 Sep 2026 23:22:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788934937; cv=none;
        d=google.com; s=arc-20260327;
        b=BxZ+VBE0UhhqLNmXUYtL6rOEOBx3WTMEN7k8yUg6NuwDXLR3lSb82nQa31nsaCTVIY
         RkDXxCN1+X9Jedn/0wLIzlsNJIW1Brcu6c5L4+z4co5Rjc0jbksnDkAUz0aTq60QdouA
         719ti13eCRL8o2guocSLWp1k7hWrKzEm6DcEfGOgV/XOMVb5Un1yFY92qvztM1U65HO2
         RgJgsQSozxi7A3c6SlK8gYaZAIWCwSLnpAuTCW/EvrsOZhsZ4oH5hi8Dx2kLXHsBUx5w
         qANQAPFwLvVCzBz8l2fHHa5FM18PYGZFvxeuHvNhFblU2p6MvSHGyBnBQrp7QSDIcGy5
         eLyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=VWM6CeHEk1aJXSMMdnevLIa5hIVREi7SkJQJU6C6uoA=;
        fh=88yR79IrtKyJHapnfETH8VFsRmUzB8wd+vhYJuKFIno=;
        b=AYL2TkMjBRUfqUERRI2YVlTbbfwInJMzyxeJohg4PqOizlY67NfsxRCrXQ6Ykuw+Q0
         89SUtHfd2c4j1ndjEPgTy12lQz3zPjrdqGSFCI4gxtK/jDjDJIWgeXQMBV8z7ag8lbxj
         bcWQPsZSLacnxUzQyLqfU3/R6qOdkrYPFEROv/xRWbE9dd7azG/EqA2te8uYm4GvZ8ZE
         S3a9DvQetjaBMtgq8Tux/XxQMAMKIFEXyGnL40gBCClbYFfmUYAW9mzCFDQhXtSyMzBb
         V8OG8ag7LRJs1I9TcamQij+9pp8Fb9oceLigG4wG2+B0k/yyIUYz1HJ7TlQHt3EjfyhF
         7TBQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788934937; x=1789539737; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VWM6CeHEk1aJXSMMdnevLIa5hIVREi7SkJQJU6C6uoA=;
        b=ql0FwmNgoGsS6mrohJjP4yNIQW5HMfiy6B1gImcGcd+aIII2jfSaO+P1VZmGm7Q4w+
         C8qOQoMqviiO7gJswGseYyNA0Bdg+5yyJP+NSMKo3r4Vs0RwQG7YYiryRmm3sLHXPOli
         wKMbUYiYdrldUwJhWeUdObJZYZorC2A/mrDOvA4r7/UOAku4U/CdrCwJDClt5RDg748m
         7PJ1iHJKDg1xgzOhkZ5aXcfcRYpv2Y8LIBccXebKARO/+uUnOXmdZNc9b1/NGv93k1cJ
         2wy1y3wvAFq4DSfkwcZuD7dn6XDIdtyheOAHtm7S+moO0qdO1DSIUYzig3Wp45kVgfyo
         mqDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788934937; x=1789539737;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=VWM6CeHEk1aJXSMMdnevLIa5hIVREi7SkJQJU6C6uoA=;
        b=cMPbl9263gxSJ9pVoom5xbd9e5SzPuFsj9gatfJ0zNuRwvNCJnVvKKgecAiyyMEVIW
         sjFnRdWcmGmQsDuogeNabzig/rIEWYzYz8KTUt0XqyJKXCScSgZrgDkZsDchGl0niNVn
         hAN0WcnLdJVK5HdimzBlKasb2LffhFWd+FMW2+qBD+QdEuGQKAx5t1QFlwlEBF4dr09r
         QApDR7PabxgwiyRZNk9M5pitFSXK5mApr7mcWcpdRRMMqhDvfrCp0oB2tYiITsd6y5DG
         8wroPE0r1SQ0Od1/BPJrUd2hIx/CQhkiqfjhBJK8WQG7VOZQ+FBLY78LV9x0nz6KEZh4
         kXMQ==
X-Forwarded-Encrypted: i=1; AKwUvBxXC91F8/7c2XVL8jJwsalqWJLOLBqy7tcztXDHYEtmFmGsvIbf/xuARt62kc7LGgzVxEaxqZM=@vger.kernel.org
X-Gm-Message-State: AFuF++mjRaTCZSC5mFOlrLBEPCfbJocDV/uobH/Nvf6rernVuZCh0k1b
	0zjHRwPotYmxoh/i0DvGk8mDQzq/2RfPeSZO34vKtZEqB4UB6vEw1X1F3UihGrP/C1Bv+dbuljh
	bXNrSrxgPqz9yXePSeQ49V6xNJ2JFJQc=
X-Gm-Gg: AYBFou3nk1JPFTTLlpyYziKL0Vv4KTRx4YVxdcB//9OAWz4C0GO3rJ0j+8Jw49vX+3G
	evgqV69PpM5wbFnW+YNn1WtvJ6lCjWnIzdjm/Bx1NfINuP0gUbhi7aHCPVvYQf2ckPaTnfUMbZD
	4SVEOscek/tuu1OTm2gAnXrgOZcZGhCLyPhTkreu3VV5t9Hv1yr33upKWZcT+NwmG4GOfQ2FQQl
	xvty12GGnLzwJM/1jvJVuT85rfwMhHS1WTMiw4ugje4ThYumzZ8MXM2ymnXS38Aqtv6U3WFIeEg
	gZIqThvn0FfAmBwbw8uzKUeURKG5ZRIOjxvIuUoM00tG4WjMzo5nbIeO/3++kGIDiiK4jVc3jif
	6PdEBYX1YoNRYizQLlVekvCCUgjwUZV39FTVWa3Ez24d5OM2w/o6/mXf8yJZSiDA4p/U=
X-Received: by 2002:a17:903:4687:b0:2db:733c:fd1f with SMTP id
 d9443c01a7336-2db733d01b1mr147964695ad.8.1788934936683; Tue, 08 Sep 2026
 23:22:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260909-fec-ptp-pps-event-uaf-v3-0-bead12c29a16@cherr.cc> <20260909-fec-ptp-pps-event-uaf-v3-2-bead12c29a16@cherr.cc>
In-Reply-To: <20260909-fec-ptp-pps-event-uaf-v3-2-bead12c29a16@cherr.cc>
From: Bui Duc Phuc <phucduc.bui@gmail.com>
Date: Wed, 9 Sep 2026 13:22:03 +0700
X-Gm-Features: AcwNN1UJle0sVjQuUbKVCU6-l0sg65xDQ67_7YzJFG8LlrYIbdhc6pOpj-B036Y
Message-ID: <CAABR9nGshJE96aCZVriQeMd+7Zjua5n+EKpUTN=953sowUL0Tg@mail.gmail.com>
Subject: Re: [PATCH net v3 2/2] net: fec: free the PPS interrupt before
 tearing down the PHC and netdev
To: Shengzhuo Wei <me@cherr.cc>
Cc: Wei Fang <wei.fang@nxp.com>, Frank Li <frank.li@nxp.com>, 
	Shenwei Wang <shenwei.wang@nxp.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Richard Cochran <richardcochran@gmail.com>, Troy Kisky <troy.kisky@boundarydevices.com>, 
	Fugang Duan <fugang.duan@nxp.com>, Lucas Stach <l.stach@pengutronix.de>, 
	Simon Horman <horms@kernel.org>, imx@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> +
> +       if (fep->pps_irq >= 0) {
> +               free_irq(fep->pps_irq, ndev);
> +               fep->pps_irq = -1;
> +       }
> +

I think fep->pps_irq > 0 would be more appropriate here,
since the IRQ returned by platform_get_irq_byname_optional() or
platform_get_irq_optional() cannot be 0.
