Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6852847D461
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 02:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791859172; cv=pass; b=UhDD72me5IslQ15Wg7ustHG58/KFHJGgX9fyTKcAb/as3HEEVVjN2CwIwjFJ6RP2KR+PXF7IilZhQchw4Q/TqvGFE0TwDbWLKX7AHe2FnUtmFvnxh/TiUWMdEYY7DJiwmYbqDQhGLL9nahfo1wsGaV1oNZiZl6rv6Vw7SK86wJo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791859172; c=relaxed/simple;
	bh=gzXA6CNU+k9d2IxL5fmb2DOWkaxNeeHPWD5KYocup94=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TKqUYkh2w89IJaK4B0cBacmQzuuMvW3fBOm84Wa+UD0h4pIhD8gqxmJAtPrGMdhkl87HFRi8mHq8XII2Oa6YMPizfcYnXR/3LdJDEq92yzINnwf+YCu96o+vjqrI4SRfPZKUl9VwVha0ImCmNHvjYKIG74CRUIS1A6qOCArvEFI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JwjDts44; arc=pass smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JwjDts44"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c2acc1e170cso397153766b.1
        for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 19:39:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791859170; cv=none;
        d=google.com; s=arc-20260327;
        b=CC1kebfhcUTs8Dq9U1CZlFOgeKYfq/fWUbm6/vTl8/0l+0rnp4EXqx0HmYajvACW3+
         4XdeM8h9D/8d6ZzhNJQ3k3rvWbeRb6Kqr3jPgHvGpAx1wHswj/uSlaZbZggUadYUewan
         oy+E0S6lQ2jctkq9oSsVD+r0nDGg+tPNHsQWJkJFDxk236iRjcLdDecKcx1rBDePSAvi
         lPCalsX71Zdf+S2oJAlVMgGodgQ49kVdixk7bl4hIrlH/oRUUMRnugjLj/KEZPfQgupL
         HzU5W7k7JKOo8URcDKJ+nPqQGsuf8Ee/5QZTPqE2tRPDNlPBrY3aJxELLhFAMPoRl0MU
         AhOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=trPoqfxmlP55z6YJqls3af+YQEmGNS6JcpIVYqWD4sI=;
        fh=UVDOfwpWAnJ0aPPLRogQXaN8cbA5blTzsnHbDZB+TFQ=;
        b=BGfl8CBOX6nTlSetzgEL0TGR8E51P0GD5VL7FhKO18/sEGP/8VhB0QLkDtb0zBzAy6
         jHKDATdkChMd/cmWnc1/bU3An1RZhIXUlfxUjisxFcfcezh5DeQbvzeOQCTSeT0HLvOT
         /AjVRBc7y9Z6jVuB0Wjo+LnKTt85qrak4DSGzID8kr3SQ5GRHXEV28Q6JHnPvZnJPuNH
         0TXt5erJW8Vsa9ZCGKLCnpKtiVm/cBxSle0hjtqBQ5xKDO743wpe9IuAtglKCQwuPG0C
         Bz3jron9URK7ndgDL5rFs/RpKnNHYVVPPsQXJtOYvjtMxra1KgpaHy2/JbfhJZ/4vgG7
         uJxQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791859170; x=1792463970; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=trPoqfxmlP55z6YJqls3af+YQEmGNS6JcpIVYqWD4sI=;
        b=JwjDts44C89wohQ5rAdzehpXtC6MaZojhR2nsbkxz7aE3A5JglMxf3uGOLwWeeILFv
         6j2PU5Ljs5kQ8uSVp58t3ZkCOQIPtwczlExu0Kk+HH4Vvnpk+OlQ/FD7eERA11oZ3UMR
         4G2DjLTvlmL0wGqG9MUgQdxkR8y++oi+lbJhb3sSU4loQtkn7JNA6rAd1D4hDGdJYBkC
         e6amYkK+Ud7ga1ZwtOXnOHUWDkPMxtM1CrfO/5ws+jR4w5wVq41byQTaWnocQ/utHA7s
         /F1lgUDN/V7bhueS7+hivMnIZRmhI/j89qjsrxJv4rd7ok6Ay/vC/fkw6lxtcPCgMytR
         3QxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791859170; x=1792463970;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=trPoqfxmlP55z6YJqls3af+YQEmGNS6JcpIVYqWD4sI=;
        b=rDG8sGaIrct0O7kU2VzewpP6hVCJxTU1m9L/n1mfCBcdW0eiM31urCEMO8QkQtYuCP
         Ig7biTN7cvhmB2hzgArceRj/fPDw4S7Bqf/DB1CpFy9jbyEtTLQVyzvPEIf6VOp7yijh
         gJtTmZu9H0NX1o0DHsW/DdaE6HJJ9dBVD+7wfJzE9G5wtx6P2yMcrm9N8X6WAI0JWMqU
         2EvpLvGuH6QAJrtgUla8bkxNEb1OUoAhRkK4j3Av9kYDOL0Ga3+qzey0FCPZdHKat8Lm
         fQGYLpF5nIRGDSpDaw2DtgwIS8ssaZraEzxnC9SO/SyNGNgGQ4R/6y+YoE23yw7s0CKj
         x4/A==
X-Forwarded-Encrypted: i=1; AKwUvBxtb+GNIaNmr3ZdU7m2kV1oAz3IsRuLungOwh4a3AJ1jlP7vCWolxak3EDZwa5mLLYuSL0+R8k=@vger.kernel.org
X-Gm-Message-State: AFq9FYIVk968qjUSDHUNGph2IzDi8njLhBIk7QO3dUiK8jZZXKRNSlIG
	sUml587JfXj/TxNIUNSHH25aSdtqYK/jlNuzXgHO4js743HE1FVg3mewFg5C3Gdpg7QahHgZfUk
	eXZW5MGbvS4MDxafCEva55T37OM+Iqs4=
X-Gm-Gg: AYBFou2f5ymG3RJC42/gs4vCx60ZZ5SlcWoFlVSku8omYIooBJVBCmlC+2Ohw3vY5Eg
	Uhj2HXtN7s+cfQeKHiszhkBrQap5Vp6K8FsemJNsH46XK3Sf43F6oNvwXIdzYFLk7RpDaYzOf0F
	NtYPp2ZTsRyiIS+nZO+vL+ewE0VC6HozS59ceSbw8dAg+pd44vy0gfZa4onZWbLFCBGmkBdK+gR
	nuCsEMaoaj4vg6+XMRYWlrKRgw3vQWs/FyA+HXnAZ53Dy1GB5cK2vojQcMZM99Pl+EN7Whz4Gxw
	N1QvJJfc6tMn9AzKZ3BLv5q3weJTHGSjZobc6M7yJdtjHxuSF4+44Wc0xQ==
X-Received: by 2002:a17:907:7b8a:b0:c2e:855:3375 with SMTP id
 a640c23a62f3a-c31aa05d48dmr1080401166b.30.1791859169505; Mon, 12 Oct 2026
 19:39:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pm-ip-core-objects-candidate-0001-v2-efc0e8a00d4f22c36ab8@gmail.com>
 <CAAVpQUAHHZS+NyXwtc8z2TGVUDJvC23JCrY9ghvwzqOw6ZYzxQ@mail.gmail.com>
In-Reply-To: <CAAVpQUAHHZS+NyXwtc8z2TGVUDJvC23JCrY9ghvwzqOw6ZYzxQ@mail.gmail.com>
From: Cen Zhang <zzzccc427@gmail.com>
Date: Tue, 13 Oct 2026 10:39:16 +0800
X-Gm-Features: AclHuK-sGRZ1hQB0kHvHlB9caNiz5uUG_1Nu9jnfxdc4tGlcqZWirQdd16j0dEg
Message-ID: <CAFRLqsULj3wvDpL6V5EzRAq2buezS19pZtgRjMs7HXb+k-eV2A@mail.gmail.com>
Subject: Re: [PATCH net] ipv6: Keep the SCTP provider alive through socket allocation
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, fmancera@suse.de, willemb@google.com, 
	kees@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	baijiaju1990@gmail.com, jjzuming@gmail.com, 
	Chengfeng Ye <nicoyip.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Hi  Kuniyuki,

>
> Chengfeng Ye is working on the same issue, and this is not limited to sctp.
> (see v3 for sctp)
> https://lore.kernel.org/netdev/20261002173844.3537111-1-nicoyip.dev@gmail.com/
>

Thanks for the review and pointer.

Best regards,
Cen Zhang
