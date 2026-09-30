Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60935EEC3
	for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 06:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790750267; cv=none; b=loqbHUpxK65f/p7G9yqbv9gps/qNpllOsNjydW051qmWonxMe6QUX0j0EU8kL2OygmSYiwT+E63lRCR3mtD7i380zY4hLzWTF0/X8qntAhtipMBpX5r/oZg+blwvFAQl9ZGJFh7NVeslYMDz8LGtFGTPtgNrEdzin3EfPQsAEgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790750267; c=relaxed/simple;
	bh=x5n0vHpNnN+5BDfoUxLD5HlEJGzYKfvyemZHZoGk3fM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OqdMdCOVIsQw8zEsX/RFppmGOTGd7lANzD8PxNs23Y7xqIJD9uwToa1VIJdxB9k5bHg27FFvCNEy0lNVCJR0HlBFJPPbuVtBCMcIZsgtUd6RorKxaDzlT7ZIjFabMCNYXObn523sUhrPGm7ccGcTKTfY7KbMuZEBpNSf7uncNKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P71swIW8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P71swIW8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D1F31F00893
	for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 06:37:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790750266;
	bh=x5n0vHpNnN+5BDfoUxLD5HlEJGzYKfvyemZHZoGk3fM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=P71swIW8tQjX+aLwAWdkr6Eq2C9BFL6ONuCrDnBVay2yfGJErg+sGWy4dUHbEygQf
	 rg1AfOuoQt573QHxwDUDJ+GsxZTsRxlY1R9VCOIDASO6rT526FiJZvAMzWupKOHYNS
	 MYHvbeTUi+ZkAy7gY9eYxE7rM0siNPwIEiCmnC92gJOwjvNC8/6qB0mwGArkG3AfQU
	 8gZXQkNuE8c8FxsGjFjZjd66olfjVKJ3XPqIQl+hjmFCQKPtiAYddlF9xIETW1mpYy
	 xjmtb3Ge/kf0Xao1trxomvgP2l4X1z0GTbtpeay4FsZSL9M0CvDECylJCnkb3V0ugS
	 eaLNNDSDnl3Pg==
Received: by mail-oa2-f34.google.com with SMTP id 586e51a60fabf-49de1e7af34so28481fac.1
        for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 23:37:46 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxEQwTqX2dI/XbL93enyCTPQEOHqiBYqshtfkZFm6oynho8CUhg6gOJqzZEr6RFVTfBqfrxIm4=@vger.kernel.org
X-Gm-Message-State: AFuF++kV0/kE8HGFBsGVeIA0RhGw9waXyzAIHu2rqGb0JCngJIATZN/I
	rAo6Q/z1FDQAjLWanDaV/6aHssqykjj30QUrYZCpu4WMdtIicJm7O52vK4yEYCri6ykol2VNny/
	JdHiRnEpm2SGhVu13cNKZxZeGvhEkoTc=
X-Received: by 2002:a05:6870:a106:b0:48f:e107:318b with SMTP id
 586e51a60fabf-49ddd5ff81bmr564352fac.43.1790750265323; Tue, 29 Sep 2026
 23:37:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260924152529.5689-1-kerneljasonxing@gmail.com>
 <20260929165318.6690d427@kernel.org> <20260929165425.53ee002c@kernel.org>
 <CAL+tcoD4MmRxD_5b06u5toAmBv=6HsbetEk3oZY337DjSS14sg@mail.gmail.com>
 <20260929191931.303d82ee@kernel.org> <CAL4Wiiqgg3ace_Xxx09EPYxYzeVnEbMGDjqpU6GH91zRY1h-kw@mail.gmail.com>
In-Reply-To: <CAL4Wiiqgg3ace_Xxx09EPYxYzeVnEbMGDjqpU6GH91zRY1h-kw@mail.gmail.com>
From: Eric Dumazet <edumazet@kernel.org>
Date: Wed, 30 Sep 2026 08:37:32 +0200
X-Gmail-Original-Message-ID: <CAL4Wiiph7iQjogj11Sgb_BCdvovyppUf+SGSQ=W9ysdvzeBW0w@mail.gmail.com>
X-Gm-Features: AclHuK_yzxuoFGfcHnUhHhVmJGKZ2jV8LvM_hVMUTXVmWBtay0YvbgyjAYfwa74
Message-ID: <CAL4Wiiph7iQjogj11Sgb_BCdvovyppUf+SGSQ=W9ysdvzeBW0w@mail.gmail.com>
Subject: Re: [PATCH v3 net] tcp: preserve timestamps across receive queue collapse
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jason Xing <kerneljasonxing@gmail.com>, davem@davemloft.net, pabeni@redhat.com, 
	horms@kernel.org, willemb@google.com, kuniyu@google.com, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 30, 2026 at 8:35=E2=80=AFAM Eric Dumazet <edumazet@kernel.org> =
wrote:

> Sorry for missing this v2, LGTM, thanks!

Well this was V3, and net-next is fine by me.

>
> Reviewed-by: Eric Dumazet <edumazet@kernel.org>
