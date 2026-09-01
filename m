Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5B213438A0
	for <netdev@vger.kernel.org>; Tue,  1 Sep 2026 23:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788305927; cv=none; b=fKGAdE6dXS7fR4G5rFmWW4pL7QRSS3FhxctbRnBiCcPCnKurhYRJcv+YZiWUOVYY9XU1FFQs4ImmgTvAqOYjQFrisVOGttiPhuBpjHPtkfxFOM23B/6MhITajnicDBC6bQjLz5Opt0F/qO7dS+HDhFTxXdYyx802myhpBSiwRn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788305927; c=relaxed/simple;
	bh=cGvE5vL7ZOo0oM5hRftmWcAR6gasWX104/vhHVUE1J8=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=PJUB05x2ZJUbZgEbnsj0CnLJXIC8hrFqabhtMx5t964ol+lLzNqUrbPwPDvKAess894viOIWCMd6zn0QxtrKiEC5TLccj6PfZSMHUcDU+tkrQ54/clVidURV827TCV1HmN2vY8N9mbkGfWIsuN+1s9aQssJz1hVbFqQn+og8qWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hEDGtvqe; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hEDGtvqe"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-51c0006ea8eso5093151cf.1
        for <netdev@vger.kernel.org>; Tue, 01 Sep 2026 16:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788305925; x=1788910725; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=b0zXX73cnLrFK6+woSudd179mzXIH5/+9TezRmmSs5A=;
        b=hEDGtvqe8NDBE60gYzCI0ZkKK1IOV2Azcv7Ht/4d+F8Vwbbt7s/DDTPhvXBWjNawme
         8/7wv1xSSwfRiwYK0snw/pIvtSmbFVcHo/Uv40PXgGNJv5qmc6p66vT7jMrfJnzHVxX3
         J2frS2r/Gz0+ZxwTeJl6c+B12fU61pd8eZWLMfq/ILB4hOLNMALNNON4QdDBgrEgc0ir
         L8NvDCnm3TwgA4vdVNaji4yKCYVqk7C/UBK95MRlCkJsCk84pFEUpwV3DhRikSpILbam
         YOr6MLWuIEHPkgkxRFj5TBuQ4EUtDKT2Hh5BQScvV9coZLt4lnBxJ2dM9np4ifSgkhyk
         vIJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788305925; x=1788910725;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=b0zXX73cnLrFK6+woSudd179mzXIH5/+9TezRmmSs5A=;
        b=TA3fNTVsnsuF1Fcd1c0aPI+X9NUbcsza6Bn30Q4XSUwUcoXmpnH0Nha3awedvQgE6M
         WzplmpPTF8H/jpfCqTPGaqLfky/WPH3LP8RZgL73EgESTgz4fyVl6Br0YqqcoZAzWXhY
         lWaH459KMQXfjBB4w02/eVPWmDd2JUUvXSGYMPyirQ9W1bJz6tHBusZ7M02pE93Hgkk8
         dZ/U8/lVzgUp0Q5odMLkcb0DeQKXlyBJwn8DT0YL/EPFx70kSii7+paBJP8Ap3ZW/LVD
         Yqq1T75vf/qpCTHWlQhg/FrWFubAc7cilhZACCzne+6HapNoHkbi1drlZlA+nldcFP4b
         Xv1Q==
X-Forwarded-Encrypted: i=1; AHgh+RoxjUCT6yasKRBima69VEsFgnthU/EuesVJwfDCP0YU4XFfsEvCFejpSSr0gce3a8P+KAfhbLE=@vger.kernel.org
X-Gm-Message-State: AFuF++mu+A6LXVCoyjEsE0XrSxc+cjV29uQFRWqksLHsb0kk2yvuYj1W
	GuFivladDWjyRjLfcABGQBtMvsPHFBRYOooOpT7LVCnTaYMj6ddg/rSu
X-Gm-Gg: AR+sD13/O2hegEd+lfp1IzuZeqNvYs8Yqs+iiVAeEPoClg519LaZpQCWNT8MGRUOK/N
	gwqZHZ30VZeyvNpZ+6UHZMZY5zE6mgqkFMKdn/ECQW0olBYPk9+T+3Rz43Fw7lPLyXd0qxdlzhs
	xV+ikaKk2eqiQ0rF6Bl48/R3fV9GwqVaoDII2akGHKu+18OzOaHC4FkWWdq7+umZolHQsHsvlKR
	91erU2O7LnqiAQVA1vbzwsL6lS6Ucgm6AHAIGVX2e2DFcP46EbkbI/YNK4rkecARLPlC7Kof2Y9
	Xa8bvFXC1DVQlQ+lyLMthsDGnA/9wB0cMUXZcUNdfRgzr9iNn12Fvrmd+Bj47n0oeBEj3U8c/zE
	+NAILrb3BZIhglonbFKtpMug6S2e+w+l8GPj10b+bhUk6QMs8bu8mzxe27qDMyzAxCJn+7iweOv
	XdCsMhQDBMae8uq6hRWo2iou5XcIe/WPm5tLTQA3ukwjJzI5q6TqMgCbXIrnVfIR5skzI=
X-Received: by 2002:a05:622a:22aa:b0:52e:4831:cdc4 with SMTP id d75a77b69052e-53036b93345mr8598201cf.7.1788305919934;
        Tue, 01 Sep 2026 16:38:39 -0700 (PDT)
Received: from localhost ([2600:4040:9399:4000:e553:72e5:7d37:c7ef])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5303323faddsm7251121cf.25.2026.09.01.16.38.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Sep 2026 16:38:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 01 Sep 2026 19:38:38 -0400
Message-Id: <DL4DJHDX94CE.2NZOCOIS69901@gmail.com>
Cc: "Andrew Lunn" <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>, "Shuah
 Khan" <shuah@kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH net-next v1 1/2] netdevsim: add TLS device offload
 emulation
From: "Daniel Zahka" <daniel.zahka@gmail.com>
To: "Jiayuan Chen" <jiayuan.chen@linux.dev>, <netdev@vger.kernel.org>
X-Mailer: aerc 0.21.0-threadmapfix
References: <20260901154914.11637-1-jiayuan.chen@linux.dev>
 <20260901154914.11637-2-jiayuan.chen@linux.dev>
In-Reply-To: <20260901154914.11637-2-jiayuan.chen@linux.dev>

On Tue Sep 1, 2026 at 11:48 AM EDT, Jiayuan Chen wrote:
> @@ -1068,6 +1070,7 @@ static int nsim_init_netdevsim(struct netdevsim *ns=
)
> =20
>  	nsim_macsec_init(ns);
>  	nsim_ipsec_init(ns);
> +	nsim_tls_init(ns);
> =20
>  	err =3D register_netdevice(ns->netdev);
>  	if (err)
> @@ -1095,6 +1098,7 @@ static int nsim_init_netdevsim(struct netdevsim *ns=
)
>  	RCU_INIT_POINTER(ns->peer, NULL);
>  	unregister_netdevice(ns->netdev);
>  err_ipsec_teardown:
> +	nsim_tls_teardown(ns);

nit: label name drifts a bit with this inserted here.

>  	nsim_ipsec_teardown(ns);
>  	nsim_macsec_teardown(ns);
>  	nsim_bpf_uninit(ns);
