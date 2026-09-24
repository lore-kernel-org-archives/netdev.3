Received: from mail-yx2-f42.google.com (mail-yx2-f42.google.com [74.125.224.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6811E478875
	for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 11:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790249754; cv=pass; b=uSCGqrGB+Quq+OxoqQADv7hRdzgM6n3Q+wsM2hc5BqBMVktVJy2EBsYKlfsJgsy1g/aEgoT1utqLHg8PuVdQdt3wzPh595ClHpYFcdcOawn53kZper6rt4cOxt7CCMRhaoHmJaQQdwujxaFWEK6X/DR09N5ZC6g/7IrUV/pgI1Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790249754; c=relaxed/simple;
	bh=/ooIk1nkmMMbkU9zp/iQ51lU88j12gCHTiDNrvNK39M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aNGTGa4aQsc6q/R+551JW37cg1EjOV8/K+f8d+de26hF4hbmE1eJCapVpYR/dieZGGdIx4MBomUbI2dWV3nOUWjBytFeciIVFP0eMuHKb+efBbwZ89QIRC84HBemQwhrY4ynG/2FcL9ACc5QSmvvPRYfBVp3xABC6qSX4sAmvq8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=xK4h+BEG; arc=pass smtp.client-ip=74.125.224.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="xK4h+BEG"
Received: by mail-yx2-f42.google.com with SMTP id 956f58d0204a3-672f90fc533so276665d50.0
        for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 04:35:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790249746; cv=none;
        d=google.com; s=arc-20260327;
        b=Sm8Tyc6lReca2l6n3r9x4L9xhF/sHO4dwXngzdqQIJA7Zb/YOQz7/s9yphrptrnMRM
         jKqNzp1EHbw7qnZv9yqg1egp1j/akRIAsrntvGxCpRUkTYzUZ4xI9GDKkbUdW14zbtto
         BHReB8JZyHabnHouLF0P0tA2vsPl0BkiCtmYu+Vv7R+DtofuGn9tu5Fr+rN7x0gyiNlo
         mF/ZkAr8h6yx9SNBORhfe4T9hOzu2Ft9cJif+K28IO5S+N7BlJrYsT8hLVqNgdbm8VUk
         dJBlooMGgGXusdUpiQSsBS6dafowsagZimMTBdJnbos97+Bzd3E3iuLkDzq4g3zUbvDO
         Kigw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/ooIk1nkmMMbkU9zp/iQ51lU88j12gCHTiDNrvNK39M=;
        fh=v2wZNqi+rqpjYbJS0hr9dawMXozfibEyYOM08szNILA=;
        b=HFRYPjueiaeMN6YYX2suvvPvfriWkLWHGhEmY0+npF1hOSdszM3dNk69eHMgZtfraE
         U00uH4OTuJr87cZAMXYqXCz0RMXQ+SzDbFcNYig+tjVxpFm4Yk9lcjzjSSWZ3ZS4pfvN
         kVMoibJsA7KOc9Skxqb11Lt7jIj9hf9D7YJ4KZCmAfO6y28gIbVMgoA0EfsMyzzmfpbZ
         77dq+mZWphkEdLOxKBwpsW5VVGEFr603KU9qkY+F31eYVxEUS9L2FiZz4xM1wAqioH9t
         phGsrOCnIXR3cRkhkHcOynBRj60QJ6CPUVQ6hAF4nFni/yPMAFrvHzqW/MF/6nJp17AZ
         GcnQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1790249746; x=1790854546; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/ooIk1nkmMMbkU9zp/iQ51lU88j12gCHTiDNrvNK39M=;
        b=xK4h+BEGyL+E90xx9DgrNVsR6LX4UDsARJwaIBG2gY5vy4ER/CTK/f3S2qfBGCrrfe
         O38Od+Enb4Ma6/sVWoNVe2Sn992OWTCj1IgISGm1Q49BdmaRg+7GoeXgSaQt17sK3WBq
         I6Ytmj24dDQ9lXRtVNHbbyyPBGu2jEbqBscKU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790249746; x=1790854546;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/ooIk1nkmMMbkU9zp/iQ51lU88j12gCHTiDNrvNK39M=;
        b=Y1jgewdz4E7qROW4A/3D66cOjpAdC7h5wc0Ue+0n4FXyCGhEDkvA/pyMcZ9Zi/e2na
         kgGI+48WuUqDZhDm2o85c61oHh+I98A8AhjxRxfo0dCSVMudL/CscBWO+70mTMdyNXTj
         Xs5sxDbhRrVqETxZmFBvIYjO2nS1v6joCFwH5s+rjWu6uW46Z1iQ5nfPgQzcFe12nKtb
         EP+3FjUITEAyKeAxez4w8MADvK4OZGsO18roMPsbcMo4K/LGhPNTn+Ost/HxpFSw+uQH
         UAAxPM7gL0gH0YTAZtPl9e8AXfjwGo0+HEfrL9GmHMEpwmdF1CfhlDVA+PqWgRWRk73o
         EkRw==
X-Forwarded-Encrypted: i=1; AKwUvByAo0vCuXE2lZwJG0Y5VQJL2g3Ng1Dq26hZAOPd4bSRi2+kr7XF8DxTJoJ9CHvycwOqRny+aP4=@vger.kernel.org
X-Gm-Message-State: AFuF++lAfelHcqHGGSiOmwaTNYYRJv1zT0bjtoDm+ainWDADU2HcWhIh
	OZZ+oi+kH66p+4oRsszp7Ms6USigfCt8ju8bXRXDu3BXi3AWqDogwHYEzDjit8vT4HEdwmy/uLn
	toTkHnhtoCu4BZ+ag5OD7EBMIasRtN576erwS+01g8lc4WRdFmTk=
X-Gm-Gg: AYBFou2xLagszFlb+SAMgZDFdu9KT/2FdU9njwZz4cExfT+E1fOdb2ZSDPeEZGY7xaY
	wTjYsAkloSls0CG/Srfye18aNMRZdlEvLpB82rZVDXe93VSRsumz092PH1nsij1L6rSxAAjGpS6
	cyAQuJju+jNuGqp5D+dPxzHtT79FGep009zLDXhGzwEAEfwp0aefdT2py/408YUN/HN9j/LaMbx
	pAlTsCl3BGLLqVDYIMOAZe2NLI4gxd5Xmq6q+jgp2sY5mP5zb8iMp/GmT1cdPVRZjrLDcI7WhRb
	N2i8mvjjWZOH+7k7DKyAI4PHsUySYyVcaORL8hsYNl98dIp/QoEI2ScSEyGJrZJBfPeTAg==
X-Received: by 2002:a05:690e:d44:b0:66f:c1be:318d with SMTP id
 956f58d0204a3-672ed4db1a4mr713251d50.100.1790249746028; Thu, 24 Sep 2026
 04:35:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260922180458.5c54ebb8@kernel.org> <20260923040136.13432-1-hemendranaik@gmail.com>
 <20260923195323.5413f128@kernel.org>
In-Reply-To: <20260923195323.5413f128@kernel.org>
From: Victor Nogueira <victor@mojatatu.com>
Date: Thu, 24 Sep 2026 08:35:34 -0300
X-Gm-Features: AclHuK8W5cypXoOg5YOqWG1817rRnO3Ny_pZWJxth2uHtxKh-dQ0MfUQJ9PpABo
Message-ID: <CA+NMeC9CWgt9=0=_HjNH=Fsg7igmFqDS=VnqWh6tZBr98ZkPgQ@mail.gmail.com>
Subject: Re: [PATCH net-next v6 0/3] net/sched: sch_fq_pie: add per-flow class statistics
To: Jakub Kicinski <kuba@kernel.org>
Cc: "Hemendra M. Naik" <hemendranaik@gmail.com>, davem@davemloft.net, edumazet@google.com, 
	horms@kernel.org, jhs@mojatatu.com, jiri@resnulli.us, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, shuah@kernel.org, 
	tahiliani@nitk.edu.in, vishy0777@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 23, 2026 at 11:53=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> w=
rote:
>
> On Wed, 23 Sep 2026 09:31:36 +0530 Hemendra M. Naik wrote:
> > Hi Jakub,
> >
> > We have vendored the temporary UAPI header changes into the GitHub
> > development branch (https://github.com/H-N41K/iproute2-next/tree/fq_pie=
_class_stats/)
> > as requested, so it should now build standalone in your CI pipeline.
> >
> > Please note that this header sync commit is not present in the official
> > iproute2 patch submitted to the mailing list
> > (https://lore.kernel.org/netdev/20260922211139.38570-1-hemendranaik@gma=
il.com/).
> > It was added to the GitHub branch strictly for validation and testing p=
urposes.
>
> Thanks!
>
> Victor, could you pull this into tdc as well?

Done, it's in tdc.

cheers,
Victor
