Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AB8D420469
	for <netdev@vger.kernel.org>; Thu, 27 Aug 2026 17:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787850858; cv=none; b=LO0VEEg1w4LtRAStoa0MZEs+dth1jHLsMpQ0wmcCKmVO+TRsqhTRzczbXi9rvbh3dYBXFSXBgjjhjoE5ruoz1l8eI15d8uIwFMSv2Oisy8OAbcG6jg8MtzHfT4xik0s72/cbc1GX+oTGy3spmUI4HSh+72KjzBlx24togJ9d9a0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787850858; c=relaxed/simple;
	bh=6AQe1RWM3YPSf+I7XOUqo3G3tpNWG2wEUUBvMuDg62c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s2UrZ6Sy7kCtIIToD1kU0snt8IGfuCqpOrtvW96mrbprdbDMdxadNelld/fQo1CiArfurrnTFO1PWGwxx5dNJBX9z0lL3LAkxQiaMh80IdPIFS+RuIXykTMz5ERNGhY9VL+3XcoxAjlJFegqEQ64OxW3tXu+i/xlqsfrZWTpngY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PvbYNXAy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PvbYNXAy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE5E31F000E9;
	Thu, 27 Aug 2026 17:14:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787850856;
	bh=czkjFd/SdRwb06IXweqxtPxMXr/1OJMMl4tYd/7Ns78=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=PvbYNXAyY7LE3455ipFvwWi9Bu0SQ+ZgntoE7bvJGCGkY85M7qv/wsccbEZTKyhIe
	 IAoa75m2XSCjzaTXMSjLa0/FytdvzWcoQcIuW5M7EHT5o/UdwbjCvO2LI0r+ICmcrR
	 EjMm3aVpRNiS3B2sLqU/pdFSfhOjnfV5/81KulWpMmfPzNMUqsS77w0+/wf1VtO1V7
	 GY8yJgm7sJW1geBDO0QdhVwHud9Z3KsvOEprNGeBguP3eGMBS3jB0EvNVK4GEe8xpt
	 Tn/rgW52ecP5UKAtxFhLrZMGzvpmUwwsvg2uKl/0NJnsEzOztdzfkEj5jzZFEmK04B
	 MJwWxg/NzQQqQ==
Date: Thu, 27 Aug 2026 10:14:16 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Hangbin Liu <hangbin.liu@linux.dev>
Cc: Donald Hunter <donald.hunter@gmail.com>, netdev@vger.kernel.org
Subject: Re: [ynl] how to fix the order of selector and `_decode_sub_msg`
Message-ID: <20260827101416.44f53ba5@kernel.org>
In-Reply-To: <ao2PN6wp9A2SjRar@fedora>
References: <ao2PN6wp9A2SjRar@fedora>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 25 Aug 2026 20:48:55 +0800 Hangbin Liu wrote:
> Hi Donald, Jakub,
>=20
> Recently I have been trying to add encap decoding support for `rt=E2=80=
=91route.yaml`,
> with formats similar to:
>=20
>       -
>         name: encap-type
>         type: u16
>         enum: encap-type
>       -
>         name: encap
>         type: sub-message
>         sub-message: encap-data
>         selector: encap-type
>=20
> However, sub=E2=80=91message decoding is broken inside `ynl.py`. The root=
 cause is
> that `lwtunnel_fill_encap()` sets the encap=E2=80=91type *after* the enca=
p payload
> data.
>=20
> In iproute2, `parse_rtattr()` extracts all attributes together. In contra=
st,
> `ynl.py` stores attributes one=E2=80=91by=E2=80=91one into `search_attrs`=
 after they get
> decoded (_decode() -> self._rsp_add()). As a result, we cannot locate the
> `selector` while decoding the "encap" payload.
>=20
> Should we decode sub=E2=80=91messages after finishing first=E2=80=91level=
 attribute decoding?
> Do you have any suggestions on how we can fix this?

I'd change the kernel to output the type before the data.
The code seems to be trying to cancel out cleanly on EOPNOTSUPP.
Which is a good code pattern in principle but I don't think it makes
sense for dump / get. And no existing ->fill_encap can return EOPNOTSUPP
so instead of complicating things we should just move the type before
the data in the kernel.
