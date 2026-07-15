Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18D0846B5
	for <netdev@vger.kernel.org>; Wed, 15 Jul 2026 00:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784075857; cv=none; b=gDYIf+IpYTr1FW1cs94sz0HDykIM+5edLhLn2z3AJd3XbuCpqbC57mRf8oHt0O2C32FhrRlOGpuOATHp4YmZrGYAiboUIdeuld15gRiWCRw1YurTjGMU9jXrjIgHr7JKG7IShnifx2ngvQriafwl2mwPGpmdwi5/JK6PvUG6vUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784075857; c=relaxed/simple;
	bh=IJ7AzjNsrrCslcsIJirDHxjudI5A6H4ktWi4ni/KaBk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LPns8t7/RtpmQ6Lu3CyqsPAPNk4N5i+PjU3BGT8BJmW4QxY61+m3CjJb5vECgasBiMvBwc1qWP5DP2yIdwnlZP567SCi2DXqu7aTXMpqC7rkDzr0zZr4UhDSGJN9SR12Vtu0RwO2pXTbPBnUJaLLkOsfvTesbDJjD6pK/h6EEXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=ITlbFyM0; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="ITlbFyM0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1784075843;
	bh=2UQfdXNIkS9o5W58TEdPJFqO4/Osntw/5GbyaqsLFS4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ITlbFyM0qDa1vehlvsaT1bSEBsnQRzb8a0/NFYKhtH81n3aft4bHfgmC+PH1Z03Rf
	 v6l0ozcLfSR7jTOBDlDkjnJ6agD5gamWfP/lfY4Flec35vPN/Odf9XXF3pVi/IG0FT
	 Iv1mn763I/iKTnv0oc6KULlc+cTnpeSOpM6sJp/xrOJnjoG0wiwc/9Wj2df9VqK6MU
	 7xR0HZH5n3fUA7G7Vzrzyr780mPgRBaCqwinGf6iaWeGQrXd/3EPf3UyD0AUBzOKzQ
	 p/dsGfE5MXjSvvdFM+9Vzuc6u3eDBGZuzr4cNOPrE+1Sg4htGBsA2JotkgXBfO++xs
	 sz9cuxP3cO2Wg==
Received: from pecola.lan (unknown [159.196.93.152])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 07D5D655E5;
	Wed, 15 Jul 2026 08:37:22 +0800 (AWST)
Message-ID: <20d74693ac673ba1db0c0052a7236db777fc5ec5.camel@codeconstruct.com.au>
Subject: Re: [PATCH] mctp: check register_netdevice_notifier() error in
 mctp_device_init()
From: Jeremy Kerr <jk@codeconstruct.com.au>
To: Minhong He <heminhong@kylinos.cn>, netdev@vger.kernel.org
Cc: Matt Johnston <matt@codeconstruct.com.au>
Date: Wed, 15 Jul 2026 08:37:22 +0800
In-Reply-To: <20260713073918.419422-1-heminhong@kylinos.cn>
References: <20260713073918.419422-1-heminhong@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi,

> [PATCH] mctp: check register_netdevice_notifier() error in mctp_device_in=
it()

Please include the target tree in the subject prefix. SInce this is for
the net tree, you want something like:

  [PATCH net] mctp: check ...

> mctp_device_init() handles errors from rtnl_af_register() and
> rtnl_register_many(), but ignores the return value of
> register_netdevice_notifier(). If notifier registration fails, init
> can still return success while the module is only partially initialized.
>=20
> Check the notifier registration error and fail module init early.

The change itself looks good, thanks.

> Fixes: d51705614f66 ("mctp: Handle error of rtnl_register_module().")

... but no newline between the fixes and signed-off-by (and other tags).

Also, make sure you CC all the necessary maintainers; you're getting a
nipa CI failure due to that.

With those addressed:

Acked-by: Jeremy Kerr <jk@codeconstruct.com.au>

Cheers,


Jeremy
