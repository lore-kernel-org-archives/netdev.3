Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F004F3839BA
	for <netdev@vger.kernel.org>; Mon, 24 Aug 2026 18:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787596169; cv=none; b=jR/gYrKdVPP4IrNTvLL4etTSdvWwgiE2i6X3zU9wse5yD0BTFEJM3iTShDUv8f2MQijrpo0OfRQCASZYmUwiOAAjibiptmXyYB3q5NtwCWyGriEdiUP3VrAxJ8iyXdUTxVxU7j11+blC+iS/V7WsumhEYDYS/p/8mOfwNZq5GOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787596169; c=relaxed/simple;
	bh=vneEVqbupcQabJxu8kWTwHb6ra6+uyN8D1N8WTAPuQc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fmVJNHSqDibmLqo7CkfikmM/YAB/BrF/bKxWHQH4b+2h1KH/lC+4dYXr/J/XX6+RxpYSra8EmvfT4kSQQucniUj9ShEw47QFJw895EUT59Cc+m75xR8zG9OGJZl05FMlrIHQHXy3OuzSmiS732YiCPba6Zd/+DpuSzyMUPc4VMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=TmS/iezu; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="TmS/iezu"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-c1f758014b8so420715866b.3
        for <netdev@vger.kernel.org>; Mon, 24 Aug 2026 11:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1787596166; x=1788200966; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vneEVqbupcQabJxu8kWTwHb6ra6+uyN8D1N8WTAPuQc=;
        b=TmS/iezuqyGJ/j874tAS+6xx3BTol9hlHLHxcO6OCLVGYlB5ScEFz8Q0wns6zojcZY
         YHm4LSa2N+jG14Ie1ZEIiUFvQDyqCAauxnVVhEZyUl7TvkgoxedL0Mr6cXWy39PaCLC2
         NI+LA5G+NyGJz0Ka47WmxX5JaL3cHF7TdTw0frDl60EbALTxC9pdJd6o0Fct5teoTQ8G
         arn8uZmu/2EJyGDDTEyoS6m5+WeGcbhhFZ0MAY7kDnr6Oa7qFCg8Tj8XhZ69pq0PwKyF
         Jci/imSEaRmRrQNzS8SCpXR92YNO5tyIAboLNlrSZ77wBSGcXzk6W1Oqgd4GJ237+wZK
         M27w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787596166; x=1788200966;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vneEVqbupcQabJxu8kWTwHb6ra6+uyN8D1N8WTAPuQc=;
        b=i5t2+PqSnynmC06uphgbrx5lmrk7lPC0rbBRbON+PYjImBXwe5eVuJZad0wBOJtTC4
         8X/FdHeoMplV4uaRKExHiq9WABqA7ZH30OueMxE0Qn/HqwVB6+Xuiz35K2soVWlEpNLM
         YD6bGsr/Xo7FnLZAiL2mubP2sVAr3WL4nCC11AEnsg+dvzrD+9GlvOcoc7i4FKvwMsCd
         W2zm7SRT2Z5bh8+503ZCSD9ZhW3+mAiGUG9VNofvTo/TXpp/Rvz5PZR/jyB6FVNUKvXP
         g083iCZTfR9sd3yC8+WAeEWp5yX3l89+rgXcqBikxFy0K/U8IwC+JwSvKLQnkwBvZNGS
         AAmQ==
X-Forwarded-Encrypted: i=1; AHgh+Ro5zsBgzQViNG0tOLlJsFIKLg03J4NGiOgO1Xeu6B5HOWJdgBAOROj+c6arlmC6Vfl2442U1e8=@vger.kernel.org
X-Gm-Message-State: AFuF++kodtoQ4JxhC7KTFV+cAW/ehfz7UDw03YlMGBMBpCsEzbcY7p2z
	kHZqr8gta8HTms57qLZizi3Amdo6N81P4UrDpX9W9sDN7GifewG+LKCUviH4Ri4Oypg=
X-Gm-Gg: AR+sD11hHF46FGXpdm1q6zEohh9j+WZ25W6rrl2VdCkGVwq/ahUcLO3z073pN0G4s4u
	HGDV7p04nkm5EEKY00fzt8NpubJYNzzSzi8KLQBP2qROvOqi+xxBvisEsS0xT8ynY/IJoeL6+Xr
	IEm5HqNmcniQJHNzGmfqDPAENdS9mvjqo9ONiHWGQKo/POCfzFovRACyLYkCX6tJ3itXiAwb/KI
	/bbcLOVrBzwpbNeuF2xF1RGsRo2FeaSgrOtdihkiP3xmrWlov5eGexqy8adkycqITfKb51dl5Yr
	R8rf6xJDbQnLKVag71iSOqKpMGDSVHqUXMMzQr2VM4kJkCumhJCtPwRqzXrnc851n7efmhJLagP
	pX5JrL0J+iOf74u4l8pX7nB6bGc0Rx/zctRBmvQ9wGaiy0P9OP3wHISzVkYdHQrhMH1+bF1tqOV
	xG5/odxK0Cr763bErIKq0yXkVpAK4pA4L/KREfye3aeG2dXAxv0JOzc0T5v6W6lUQ=
X-Received: by 2002:a17:906:fe48:b0:c15:fc59:cdf3 with SMTP id a640c23a62f3a-c24b3ebee48mr1527958466b.12.1787596166247;
        Mon, 24 Aug 2026 11:29:26 -0700 (PDT)
Received: from localhost.localdomain ([2001:af0:8000:1409:193:86:92:181])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c24d8375776sm315993966b.31.2026.08.24.11.29.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 11:29:25 -0700 (PDT)
Date: Mon, 24 Aug 2026 20:29:23 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Jiri Pirko <jiri@resnulli.us>
Cc: linux-rdma@vger.kernel.org, cgroups@vger.kernel.org, 
	netdev@vger.kernel.org, linux-s390@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	jgg@ziepe.ca, leon@kernel.org, parav@nvidia.com, mbloch@nvidia.com, 
	cmeiohas@nvidia.com, roman.gushchin@linux.dev, bvanassche@acm.org, 
	zyjzyj2000@gmail.com, shuah@kernel.org, tj@kernel.org, hannes@cmpxchg.org, 
	alibuda@linux.alibaba.com, dust.li@linux.alibaba.com, sidraya@linux.ibm.com, 
	wenjia@linux.ibm.com, yanjun.zhu@linux.dev, cui.tao@linux.dev
Subject: Re: [PATCH rdma-next v3 08/14] RDMA/cgroup: Disambiguate devices
 across net namespaces
Message-ID: <aoyNXoZ4K2i_TNi-@localhost.localdomain>
References: <20260716132316.1495242-1-jiri@resnulli.us>
 <20260716132316.1495242-9-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="cxu7rzeeuvesxlev"
Content-Disposition: inline
In-Reply-To: <20260716132316.1495242-9-jiri@resnulli.us>


--cxu7rzeeuvesxlev
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH rdma-next v3 08/14] RDMA/cgroup: Disambiguate devices
 across net namespaces
MIME-Version: 1.0

Hello Jiri.

On Thu, Jul 16, 2026 at 03:23:09PM +0200, Jiri Pirko <jiri@resnulli.us> wro=
te:
> From: Jiri Pirko <jiri@nvidia.com>
>=20
> RDMA device names are unique only within a network namespace, but an
> RDMA cgroup can account resources for devices from multiple namespaces.
> Duplicate names therefore make cgroup output ambiguous and can cause
> limit writes to select the wrong device.

=46rom the cover letter:
| A device in one network namespace therefore cannot use a name already
| taken in another, even in exclusive netns mode (netns_mode=3D0) where
| the two are otherwise isolated. Net devices have no such restriction -
| their names only need to be unique within a network namespace.

If this is modelled after net devices, why not make the visibility netns
based?
I.e. only list (write to) devices of the caller's netns.

>=20
> Use the system-wide RDMA device index to distinguish duplicate names
> while preserving the existing UAPI for unique names. Reject ambiguous
> name-only writes with -ENOTUNIQ and expose a complete device view to
> administrators.

I admit, the administrators won't get the full view but that's no
different from the netns devices situation.

Regards,
Michal

--cxu7rzeeuvesxlev
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaoyNfxsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMiwyLDIACgkQfj0C55Tb+Ag9cgEAmqyg7SX/4xxY6jGBQ6Ho
ldb//2ddSquKpPFaT3oiD/8BAOPzNVL2AFncp/3gajGpePR8JfvA8gWP67r2kNjr
koMD
=6AcV
-----END PGP SIGNATURE-----

--cxu7rzeeuvesxlev--
