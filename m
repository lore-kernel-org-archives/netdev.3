Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9E5D1AA1D2
	for <netdev@vger.kernel.org>; Thu, 18 Jun 2026 12:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781786612; cv=none; b=ElKP/d0XOTRX0hIIGP3jsgGvkfMbLZ/E8Ke0riDpxMovag6hzI/XULsBeDLs+0xK/9LGh7fruh/41JOI3f1o1ujoot+dZ2XHxqOQLTvvnUnExYvXvfwXryT+/ZS35JOqUb3HEGQ2gJ/yvv6mASi2o97RLLg1Q01bkIXRtl/lWXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781786612; c=relaxed/simple;
	bh=0xOGb09rTuf9GPV/jBFAQS4RgTq69F7ydy3K5ixrwlU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E5GNFlvbuij2JKjWG2zxTZ/tzuOx/qREBQxwBTOVC34FOTiTZX385HuUZeo6AXZAQYCnNUMnjOmNMc1dLpHAs2D8+ObsuyuUSvEiRsjA/IJtvGeogwcFjb1bhaqpghjmDi/ylAyYh+4OHr2DM2g7qcsBTIQZ90C2TQRZfYj+f+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=b1n.io; spf=pass smtp.mailfrom=b1n.io; dkim=pass (2048-bit key) header.d=b1n.io header.i=@b1n.io header.b=RbabBeY2; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=b1n.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=b1n.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=b1n.io header.i=@b1n.io header.b="RbabBeY2"
Date: Thu, 18 Jun 2026 12:43:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=b1n.io; s=key1;
	t=1781786607;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0xOGb09rTuf9GPV/jBFAQS4RgTq69F7ydy3K5ixrwlU=;
	b=RbabBeY29BJbtGj5OwkpJedKIOYaDFFaGYzGpQK0f2k03ZQGocbG215y8oplEfd5lZQJBM
	k8AYSdY1Bq8vAEx73lFgO+Fv397I0mtRS9VPlpjqAUYskIrz+bC3cb/AyLhtVHcZx8eKtv
	hIvyLqI7uX//fNdlzmWNLy6PE0RAsMugzAHkPE1cql6ycNgU6nMhkC2lccODAYRjfgnw50
	E4g+jICYXFws2Bw7ZFy2ho42d2PAfcKKZBgsYr9fwNofdAaGI8CaMgZqC9LA8+HJ31bG1d
	dhdwMnQSvQH9iq0JEaPS3q0JiqQjDy2mwgE3YvJRmfyT0ke9U2539qVAC0WENA==
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Xingquan Liu <b1n@b1n.io>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>, 
	Victor Nogueira <victor@mojatatu.com>, stable@vger.kernel.org, 
	"Chia-Yu Chang (Nokia)" <chia-yu.chang@nokia-bell-labs.com>
Subject: Re: [PATCH] net/sched: dualpi2: fix GSO backlog accounting
Message-ID: <ajPndLsHz1-d76qj@fedora>
References: <20260616220303.31552-1-b1n@b1n.io>
 <CAM0EoM=o+kBQNND8ViMe8bZQmFAtATav+CFMmtp1udzu+tpTzA@mail.gmail.com>
 <CAM0EoMmXrZ5pUAkuVScgQjPFm3-dSC03mygDm3sAaFO=TQgvDw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="eb6zudvooesa7q7h"
Content-Disposition: inline
In-Reply-To: <CAM0EoMmXrZ5pUAkuVScgQjPFm3-dSC03mygDm3sAaFO=TQgvDw@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT


--eb6zudvooesa7q7h
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH] net/sched: dualpi2: fix GSO backlog accounting
MIME-Version: 1.0

On Wed, Jun 17, 2026 at 10:23:42AM -0400, Jamal Hadi Salim wrote:
> Do you know how to create a tdc test that will recreate this? If not
> either Victor or myself can help you create one.

Okay, I will try to create a tdc test.

--
Xingquan Liu

--eb6zudvooesa7q7h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iPcEABYKAJ8WIQRK8k7aQ0rr/Uwki+E2I1LDHPWnXgUCajPn4ygUgAAAAAAVAApw
a2EtYWRkcmVzc0BnbnVwZy5vcmdiMW5AYjFuLmlvWBhodHRwczovL2tleXMub3Bl
bnBncC5vcmcvdmtzL3YxL2J5LWZpbmdlcnByaW50LzMwQUYxQUMwNzMwODkzRURD
MTQ5Qjc5NUIwMDc5QjEyRTZDOThFQTYACgkQNiNSwxz1p17bDgEAwV1mMS0uKtA8
Z6fej+nWAlg2wf7S5/FFoCsDEoT55EgBAOMa2bgvVTtqFJwQSIZ+YxMIcA1vn+Rv
o1FDHyabauYL
=85ev
-----END PGP SIGNATURE-----

--eb6zudvooesa7q7h--
