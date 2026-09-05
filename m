Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 014723C0A10
	for <netdev@vger.kernel.org>; Sat,  5 Sep 2026 10:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788602852; cv=none; b=ak5qPWeadngy7cvjdGlRRVrI5CLO5gLqUTNxQFDnPXbSwEVfDuQcaYGU4O3OKVW5bRYFZl21M12whL8pgYX/fVKkgusU3Yk8JXMoh7K6tmcUyi2himIDNtvtQb+3hke6UI49YiDFJJppjfFVA5yAwBcSSgZylv6GQW0AhILbWbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788602852; c=relaxed/simple;
	bh=UJ+PeLJm9zDp7TwZEFjU1S/JwDgXvCU0MH9YbOkfBZc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DQWATTeUsXoJiIqZPjknCX3iEzzlTglOlFhrDRXXI5YjimenPZc132eMmuPo/AngDEAH3wJyA/yWiqDpMGAdFnIEZH8m6exvEcPBMVY4CYnGMQZmQ1OEWYVi9JMSMOHLXaMmFm14baVRFcqqdAzhQ9r8wig1QI48QVDyUYkPy9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JUOfyOIi; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JUOfyOIi"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-49a97714f5dso16044875e9.0
        for <netdev@vger.kernel.org>; Sat, 05 Sep 2026 03:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788602849; x=1789207649; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qiBe8K5Xgjf4S8DRCYoQDAIximCj8Kb5WNdIyMRWLcs=;
        b=JUOfyOIi6/RQY4PEAAr8Q5vgWpKZR7knMxgp8K8mq3Q1JmirVwv0J5EYF0om7yWaTU
         QIKEF6fUHW9ijVguNLr1nvV41AgHSYdGd2zMdSBxh5hVESJ7eMhsPS62DdGc81uVVEKr
         giTDNrB97/riTgQRpOO//p45Z+xQpvDDtlHx5bEka1Qm8dFEqGhS33MAuELqe/POdQns
         eWWr+n15prS/jGhVLosUQz4KiYIc32NaNlfE5KgDw5GYJ+QQhdemA9qSaUYaZBI8j2rv
         cQuQ7vhZAFoAaj/m25jg0UHJvo9x7H3NMWj7YTsCzSiw1FCasfR1Bg0NZSkHCvVLZJze
         ifUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788602849; x=1789207649;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qiBe8K5Xgjf4S8DRCYoQDAIximCj8Kb5WNdIyMRWLcs=;
        b=dLOiHJdRSCINzlzPcq4B45RK2uCJFASFb5tBk91roi+HJ/YaYEGhmk1XmbHz5S+3sr
         8UUUgfpWdgGsNn/l7whTyi9JUVoSmDmbSoTYHGGZOVELKdC3WcnrEbSO+y/+ea+QVEtS
         8GXxE6DM1XdXr8wBMm6zjE9kcauDP0SUnppU8DHhMf7H6ZXb8h9Tz3fOdHU29/3Leibb
         TaUSarmQiXEVhcceG8VEBxc/RoSbnBOflkZx3zANUB7GRBHappRFUlx3cjQhkDl3kwpp
         keSEPiCFwYJcSB59viCqz5oS7zTpOUNpnGSOzoxoONZVvtz95niqRORTiVI4ODWHVekv
         z0sA==
X-Forwarded-Encrypted: i=1; AKwUvBw+56fYnHhOFBcSlReM6Xj6DB3JLC4SWjxrJyTgNNleLYZHISBVzCCGx04wvuR+qyG4sItExks=@vger.kernel.org
X-Gm-Message-State: AFuF++knw6Q864IbmJQ2su9n4NzpY8tIfukYmJ9VK7bncT8FocldOaMS
	rUMV4rKQLQ9O+2Kl3a5+8IOmRUp8uypABeJtDFFJBqMtOtoCmqIc2M5Y
X-Gm-Gg: AYBFou0kGb85HVJUQ8cfxGOnDkTGR62PWAthGCHK66ch/3UoMbNh9G0+Dw0fOKqfJui
	ULgLGXDPXFA50cHrehluAzPtw4MEk9YOq2X2wWoNinGw1vtkjx57hPML/Pp3GQqy2kv4IKcd4lC
	W0NzQd1FLyLuke1zmF7+hBUY20Uqvv9ETkgQE4O/xNcs1H2/9mR/1zjrOgu1H3x2Xhsv/CqCPcW
	Gblkd2f8fuFPpz2dzOJKlI2PRiaI8x6CkpatReUtTjWPjWcN00BK0iaMLzo23KO1aLaIFGBfejc
	shPSntFxjh4gSv2l7c3jvrLZr3vs1YUYEc+P60UPPw0ufHEkIO2AR1GzV2jm/ntYi6o+hnbWaSu
	xw2sa32FlquwdJq4c0GJ+JVbcUOSfCcnrzyldOWLDRns+oOVc4O7rBg7XhiqaMdn4SfnH1MtmSM
	4YGT1VvvyZQQzZ7ta7TScp/xanx2n4dKqWPJpKNNpaOJKBTuyGM/rc5M2B5SToO+7qmfrSsTDWV
	xOYoT0NZb+eYZybgQ6OavXu3tQVNTlG9hK1
X-Received: by 2002:a05:600c:5247:b0:493:aa0a:45ad with SMTP id 5b1f17b1804b1-49cf81dadcamr109034085e9.2.1788602848863;
        Sat, 05 Sep 2026 03:07:28 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49ce5941cb4sm119566385e9.4.2026.09.05.03.07.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2026 03:07:28 -0700 (PDT)
Date: Sat, 5 Sep 2026 11:07:27 +0100
From: David Laight <david.laight.linux@gmail.com>
To: "Juha-Matti Tilli" <juha-matti.tilli@iki.fi>
Cc: "Jakub Kicinski" <kuba@kernel.org>, linux-arm-msm@vger.kernel.org,
 "Manivannan Sadhasivam" <mani@kernel.org>, "Eric Dumazet"
 <edumazet@google.com>, "Kuniyuki Iwashima" <kuniyu@google.com>, "Paolo
 Abeni" <pabeni@redhat.com>, "Willem de Bruijn" <willemb@google.com>, "David
 S . Miller" <davem@davemloft.net>, "Simon Horman" <horms@kernel.org>,
 "Marcel Holtmann" <marcel@holtmann.org>, "Andy Gross" <agross@kernel.org>,
 "Mihai Moldovan" <ionic@ionic.de>, "Denis Kenzior" <denkenz@gmail.com>,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v6 13/15] net: qrtr: limit endpoint range to 16 bits on
 32-bit machines
Message-ID: <20260905110727.0ff502e4@pumpkin>
In-Reply-To: <0cc80b04-1bf0-419a-809c-e16be3f6a933@app.fastmail.com>
References: <20260901131934.225991-1-juha-matti.tilli@iki.fi>
	<20260901131934.225991-14-juha-matti.tilli@iki.fi>
	<20260904184038.5c1e673a@kernel.org>
	<0cc80b04-1bf0-419a-809c-e16be3f6a933@app.fastmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sat, 05 Sep 2026 07:21:33 +0300
"Juha-Matti Tilli" <juha-matti.tilli@iki.fi> wrote:

> On Sat, Sep 5, 2026, at 04:40, Jakub Kicinski wrote:
> > On Tue,  1 Sep 2026 16:19:32 +0300 Juha-Matti Tilli wrote: =20
> > > On 64-bit machines, use the full range for endpoint ids, but on 32-bit
> > > machines, use only 16 bits. This gives plenty of endpoints, 65534 to
> > > be specific, apart from the invalid zero value and the local endpoint.
> > >=20
> > > [snip] =20
> >=20
> > Doesn't build on 32bit x86:
> >=20
> > ../net/qrtr/af_qrtr.c: In function =E2=80=98qrtr_endpoint_register=E2=
=80=99:
> > ../net/qrtr/af_qrtr.c:28:58: error: =E2=80=98UINT16_MAX=E2=80=99 undecl=
ared (first use in this function)
> >    28 | #define QRTR_ENDPOINT_RANGE XA_LIMIT(qrtr_local_nid + 1, UINT16=
_MAX)
> > [snip] =20
>=20
> Indeed, I will later post a new version with UINT16_MAX replaced by
> 65535.

Makes more sense anyway because it is an arbitrary bound (rather than
ensuring the result will fit in 16 bits.
Indeed, it might be better to use a different limit.

David

>=20
> I thought I was careful testing these, but now I recall that the
> individual patches were test-compiled on 64-bit and only the branch
> head with all patches was tested on 32-bit.
>=20
> Thanks for noticing!
>=20
> BR, Juha-Matti
>=20

