Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97AD4476687
	for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 17:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784826875; cv=pass; b=YGFcTAYS4L+piY5sbEu5wf35PaN4EsXetweOezcMjm46fnQpDbluKhvjLJWg3ztO7qYtx+YdlSYtU/+Lmcc+VVA1p5fGFrfowrZYh3j4qytzM6rrKc2ENnfgB2hfRCvvxfN/fJpjaA38e/FLJ9olszdx3dnWh8ogUwd6kP7Bnks=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784826875; c=relaxed/simple;
	bh=7nOftCGmH3veduEUtm9vXqrJ4nYSbucD8lt5aifnmaE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ou4LHGgF2x12oCMVA5y7dArU7G+QiW1QfQ6Hp/HdCfYIu0Bpc6/XmVnotFiyR/R5NqrCxcsp7OfFhVTSFOMva7PfWXdHBzTdnDYSQncRgQziJs7V60S3/0CKJW7ZY16BaDeeIk7UJXR9XeeWYztYqQ8K1+nbD68NDKb5TYNSakI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XH/ZCEZk; arc=pass smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XH/ZCEZk"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4954afac04bso9426175e9.0
        for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 10:14:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784826872; cv=none;
        d=google.com; s=arc-20260327;
        b=OQSHY+ZtNAO07UbDlAOWlKYJP88S62DsOf088N4iyxMnKzOsZLqEgcgo50UR+x0M7q
         ggqBee6xRR8JjVFVio4hdePdIVhCUu0xJrQbL+P+yOvQm4ULz3d+EptCmXIqrP7vTamL
         C9IzjYFUC0VlkfUW0XmYFhwK9DegFXGmBMAVkTOSZtULiaUAasuYK0hGmgw3j6B151F/
         G23nGTVMoS90pYOOO0GQ+E8cAoStDbEPumpis3TOhoow+cOnTmly8/AkT/WnsKtsxE3Q
         PK0boCUPOMae+D4ryPaG/RLvyDjFiMPnc5bPL8HnggnRlkbkTbqet2rRL124Wdhod2RI
         QGIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7nOftCGmH3veduEUtm9vXqrJ4nYSbucD8lt5aifnmaE=;
        fh=PW/CZDkS3HCXJ3zzI/GB3yMgP3KLVyZayQQdfw2Gnpk=;
        b=guX+J6nwmDNiQgFHVpypI4JnNTi48NoeK+OgE680R7z5+EcPZPkNDoWp89RdAF+k3B
         x2Vz3m2UYcNZPxoWt+U/3urHMVy08HxD1lJ3i1R53DcN5UGlG7h4+qUBtO9LYgvx/ixq
         Ud6r/9WEBpIMsG4MJXsOJiL1UOsotofaE1kt1DpDCFQECu5s3NW9kfjvBHrVLN204RA3
         tvwtnxr5Sa31f6dOYf0k5ruv2ChtCd14zovBlAi36SYcRlIaHaDKQSECE1qMQnVObrfW
         8W8SUG4n3OZz4ugPR4edX0X1xA+Zf7J4I2ilutwON7g9qER4H5vkV811Rb9x0egTDarC
         qUfw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784826872; x=1785431672; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7nOftCGmH3veduEUtm9vXqrJ4nYSbucD8lt5aifnmaE=;
        b=XH/ZCEZkQ3m3CsG/CANhZcI815HKYiCo873r5gIKJJVdnD+6qk7av4Ze/q7SQBkQYa
         z4LjeSb0ges2NyUtMxLyO4itYRyW/ums7XBO4pv7A0kEIgfbDu7uueTRcoPQuEsKKI2Z
         b+IBOqw9xypT9gb1KkkTHaQB45wUJZZ6UUf0Kv0pqypCR5vS/5whD5Pcx7JfozANA2AH
         3WXj+xmLSmLWGQYml2MKZrl94yuidL3jV40cM7inpNsY+ov8NLNH2Xfj5nGa8rOg64L/
         4XtiNhO5g7i0DPhuuazYwDwW5Ua2Al4FSZBRCSmBJqAQcC5PvI86gqe9UB06CpriyOQ1
         OZsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784826872; x=1785431672;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7nOftCGmH3veduEUtm9vXqrJ4nYSbucD8lt5aifnmaE=;
        b=jH/Ax9iGmzb7dKJR57lIfWHstiosEZK6jphSMIg5+pzIHDiHIuFN9AuCWNkiJv70Ge
         hg954Z/18uEkYzv2ZWxdPoivoGzGFIEPqAnKgJ6WDJaIaGMFoiTn58NhWd3AQk197XIx
         JTkfwZvSGODOrn+IG39mdlRNTAugcbK44uApYX1jgLAZUgIK+EDmOs4L34TeJKh3AORP
         UXRSQi/SGAN65b3sW7Ir6te04RBX86WiMoDY+8BqqH53TcnH3zC1V32wXVbIZzTqxgPz
         FyJHuACtIlqpBqMjlAYh6PUYiLw/TK507xklNbBb6myRGcDOwXL2tqoCi73aOgahPSlx
         oHoA==
X-Forwarded-Encrypted: i=1; AHgh+RoIK9y49VKVTHx3dRAo6TtrSs+9ybQshz99MHy2XMRZD4s7mzzOjAPh2q85D0GMfK2/rCJ1Eks=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNzoSznCOjmz+pxFfHNCXevZb0BBspqfOlmdmnfGU9c5vR4tv0
	5GfDoDhGZIyls7xIjfNPLhYNKTLNeX+hRUHaDLizHuGSqDPcuv5i6LQf9Hv2YHYMIMumlNs/8am
	xpnvtN8GKu1mkGLBwJue0D26/6WoBUZxS4/eUORum
X-Gm-Gg: AR+sD11ylajWrRmHQ7A8xH4w3Qd81JgO9xZEMTZUX9QRK6lWbVfQE1jRLcOzi0bqFDG
	fgoYISJXJ5oQnAKGU9wcRPQy7HIvnL4sch4Vsp71tsOTtvcH3uMXyGgkyTmYah17f9Y3u3KLPgG
	9wDwgTyZA7n/NF+L0s4MHH8hh54mvDOBwZZlTwWi/a4tQ8nknfNAV1024gt5Dwt7Zb56lgnlfeh
	npF3rgANGXe73i1SvfZHiFaqqIlP3+fohHeASH7IF8P/bHL/4K85DhnXRrW
X-Received: by 2002:a05:600c:35d0:b0:493:f442:3dd4 with SMTP id
 5b1f17b1804b1-49573d3e4b3mr42328255e9.39.1784826871134; Thu, 23 Jul 2026
 10:14:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260721063829.7d9e6c7f@kernel.org>
In-Reply-To: <20260721063829.7d9e6c7f@kernel.org>
From: Sheena Mohan <sheenamo@google.com>
Date: Thu, 23 Jul 2026 10:14:20 -0700
X-Gm-Features: AUfX_mw6oYeEVx78N6GZW5TOPoBHvD7tiKjimYPo8mj9OVpLspel7Dc44UnlGCw
Message-ID: <CADWJPTsP=2=JFE9Oh5ym_wz4vROEFOCqa+dyCLRymyYLRB1BSg@mail.gmail.com>
Subject: Re: [TEST] google runner needs nested cases
To: Jakub Kicinski <kuba@kernel.org>
Cc: Harshitha Ramamurthy <hramamurthy@google.com>, netdev@vger.kernel.org, 
	Willem de Bruijn <willemb@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks, Jakub. We plan to merge the changes to support nested arrays
for sub-test results by next week.


On Tue, Jul 21, 2026 at 6:38=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> Hi!
>
> Another ask, please parse the TAP output of the tests and provide
> a nested array of results per-subcase, see:
>
> https://github.com/linux-netdev/nipa/wiki/Netdev-CI-system/#results
>
> right now you only seem to report top level pass/fail but most tests
> have at least one sub-case the driver doesn't support.
