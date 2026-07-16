Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 704023BB11C;
	Thu, 16 Jul 2026 07:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784187912; cv=none; b=ginvmqxlLByneO9OIaXFPiCOZbHELvY1+RJioftWz05Tiqjp9c4P/O1HB9LOekX1bIGIq5nq4Qu+wQfdxOGgjHbCjvcysZcnwbRgXqKvBtQqhwdxAsLKdrmfSuvl9nRWunK/92LB0oGXV0NFxQOUq8pG/sNmag4IeQoYs5H8cBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784187912; c=relaxed/simple;
	bh=ytuyIHSoxQrhmg+6du/FeHjEpxCwYa6CE3Nn3NUcn58=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oPFz229TzA8EMuvb3y8SWayz2OSenYNFnw3u/nP1TdMBD7F4epHACsTW+v9+YosXdzbtkgnjNtTuQ7s/nKTKLe1ltuKt9FpSTEpzSDHALOpRmrNBiZZX3ZHXITV82A6vD4oglmi5bxZavd/AFl0aF6DU4oGmI+BBJeXT3cMM9+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=TDp2kbth; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="TDp2kbth"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1784187900;
	bh=ytuyIHSoxQrhmg+6du/FeHjEpxCwYa6CE3Nn3NUcn58=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=TDp2kbthVCdnSzd8W2OJvFyagr3zyWLXgsMZwk8pwKo3JohdUgq0SYQLTULkkQRY/
	 bS/Q9U6OVmM/tf3pYxn3f10VNzfwr4U96skcyWAo0lEWmaxX58tD9YMef0Wy+mHP59
	 eMmNkQ8PzF1mS9tCCeAxIpvM/c+o9g+jxkoWUksLHsw1qypWCdkDxgiClJ034mWJ90
	 gdbKrP5GjTn2M9putW/cxYPYyGHtXYjz8VU/VFJaqzinK/fF8yQwLBA+cq1YT4bqd5
	 YLO7prUa6wQqqp9KHjH003CPq2dUT1rOtx1ky8nW3x+Ng55p9xqYROxyuoz9cUh2cZ
	 H7zF3WLm49Shg==
Received: from [192.168.72.161] (210-10-213-150.per.static-ipl.aapt.com.au [210.10.213.150])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 5F833656A0;
	Thu, 16 Jul 2026 15:44:59 +0800 (AWST)
Message-ID: <d7dced6243038fc6042b5e100d8e7ee20788c4b6.camel@codeconstruct.com.au>
Subject: Re: [PATCH net v2] net: mctp i3c: clean up notifier and buses if
 driver register fails
From: Jeremy Kerr <jk@codeconstruct.com.au>
To: Myeonghun Pak <mhun512@gmail.com>, Matt Johnston
 <matt@codeconstruct.com.au>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"	
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski	
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman	
 <horms@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Ijae Kim <ae878000@gmail.com>
Date: Thu, 16 Jul 2026 15:44:59 +0800
In-Reply-To: <20260715072517.13216-1-mhun512@gmail.com>
References: <20260715072517.13216-1-mhun512@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Myeonghun,

> mctp_i3c_mod_init() registers the I3C bus notifier and then walks the
> existing buses with i3c_for_each_bus_locked(mctp_i3c_bus_add_new, NULL)
> before registering the I3C device driver.=C2=A0 If i3c_driver_register()
> fails, the function returns the error directly, leaving the notifier
> registered and every mctp_i3c_bus object created for the existing buses
> allocated.=C2=A0 The notifier is left pointing into the module that faile=
d to
> load and the bus list is leaked.
>=20
> Mirror the module exit path on this failure: unregister the notifier and
> tear down the buses that were added before returning the error.

Looks good, thank you.

Acked-by: Jeremy Kerr <jk@codeconstruct.com.au>

Cheers,


Jeremy
