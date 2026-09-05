Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEFEA28690;
	Sat,  5 Sep 2026 01:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788572441; cv=none; b=tKbvQQwBCTyj63KLSaGf8adoz/P8J/Qr7zEtunsRhyUmBJ4Cwm3MD2gPVGOfT/04QofVN4AkzrrJgsz+iURmEU1D3ZYNp/qaYi2ulkJDthVNX/pPEohp73nN8kZdkq3KKRngxRR+nY/UO+J1R4NoC2FfALh0AMM2puori5pycBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788572441; c=relaxed/simple;
	bh=OWPRvLI6HbaMKUmln7N2q3JVQxGXT5/mHZCjkBP0icI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fOggfugy1dOFrB5uWYpNVANT0Ld624S2weUM2hYUb5GGjVlGxWbwZfJfirhmGQZh8Pbj7dHKDR2PUplPkBOSD4FnvSKpk6dskqMGuJrDCNwkfh89dWY9oscfLF0vYpKzZ6LKqSMyZdQF5deX+JikE9UTBEmu1vM6/j7y76UkIIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VzJVlzUN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VzJVlzUN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 285601F00A3D;
	Sat,  5 Sep 2026 01:40:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788572439;
	bh=zbhyHSsH0ZYYjgOOJWQuXogkQGEQro74ZKlP+VE/PLk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=VzJVlzUNJt+HsXkPCovtCSDjV3mgXCzLF9/55RWt7ll6tDfvR5c+ZEHWCTllcBWh/
	 +o3qvBJijkdm6tOzRNDTmIErrDsHleliF8RBVC/YvISn6V+HteTtx4ZwvDqkgU7jSm
	 +c5/3mgFwDLs00VHt+HXZHDH0jp3W5c0vxy+WZeVcXcokzaRQVwHv8EVFBfYYhdjdE
	 20vSwoVpPJA3OWNSOluNCks0iPVP8e3StPkkdegvsM5hBB0KL8eY1p+gLs5yLWQOdb
	 /7B3OcFljKbQX3XwLkRQOGcEWvke029r2VbOlD6aUMXM8Mz2KiFrecu3MCELL/roiT
	 xal2lx0Xm330g==
Date: Fri, 4 Sep 2026 18:40:38 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Juha-Matti Tilli <juha-matti.tilli@iki.fi>
Cc: linux-arm-msm@vger.kernel.org, Manivannan Sadhasivam <mani@kernel.org>,
 Eric Dumazet <edumazet@google.com>, Kuniyuki Iwashima <kuniyu@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Willem de Bruijn <willemb@google.com>,
 "David S . Miller" <davem@davemloft.net>, Simon Horman <horms@kernel.org>,
 Marcel Holtmann <marcel@holtmann.org>, Andy Gross <agross@kernel.org>,
 Mihai Moldovan <ionic@ionic.de>, Denis Kenzior <denkenz@gmail.com>,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v6 13/15] net: qrtr: limit endpoint range to 16 bits on
 32-bit machines
Message-ID: <20260904184038.5c1e673a@kernel.org>
In-Reply-To: <20260901131934.225991-14-juha-matti.tilli@iki.fi>
References: <20260901131934.225991-1-juha-matti.tilli@iki.fi>
	<20260901131934.225991-14-juha-matti.tilli@iki.fi>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue,  1 Sep 2026 16:19:32 +0300 Juha-Matti Tilli wrote:
> On 64-bit machines, use the full range for endpoint ids, but on 32-bit
> machines, use only 16 bits. This gives plenty of endpoints, 65534 to
> be specific, apart from the invalid zero value and the local endpoint.
>=20
> This should fix any issues where a long-running system with lots of
> allocations might allocate an endpoint id bigger than 65535 on a 32-bit
> system. The node id, the secondary part, is already combined with port
> id into a value that is potentially 32 bits in existing old code.
>=20
> NOTE: please don't merge yet. This commit will have to be either
> squashed or removed.

Doesn't build on 32bit x86:

../net/qrtr/af_qrtr.c: In function =E2=80=98qrtr_endpoint_register=E2=80=99:
../net/qrtr/af_qrtr.c:28:58: error: =E2=80=98UINT16_MAX=E2=80=99 undeclared=
 (first use in this function)
   28 | #define QRTR_ENDPOINT_RANGE XA_LIMIT(qrtr_local_nid + 1, UINT16_MAX)
      |                                                          ^~~~~~~~~~
../include/linux/xarray.h:248:70: note: in definition of macro =E2=80=98XA_=
LIMIT=E2=80=99
  248 | #define XA_LIMIT(_min, _max) (struct xa_limit) { .min =3D _min, .ma=
x =3D _max }
      |                                                                    =
  ^~~~
../net/qrtr/af_qrtr.c:746:30: note: in expansion of macro =E2=80=98QRTR_END=
POINT_RANGE=E2=80=99
  746 |                              QRTR_ENDPOINT_RANGE, &next_endpoint_id,
      |                              ^~~~~~~~~~~~~~~~~~~
../net/qrtr/af_qrtr.c:16:1: note: =E2=80=98UINT16_MAX=E2=80=99 is defined i=
n header =E2=80=98<stdint.h>=E2=80=99; this is probably fixable by adding =
=E2=80=98#include <stdint.h>=E2=80=99
   15 | #include "qrtr.h"
  +++ |+#include <stdint.h>
   16 |=20
../net/qrtr/af_qrtr.c:28:58: note: each undeclared identifier is reported o=
nly once for each function it appears in
   28 | #define QRTR_ENDPOINT_RANGE XA_LIMIT(qrtr_local_nid + 1, UINT16_MAX)
      |                                                          ^~~~~~~~~~
../include/linux/xarray.h:248:70: note: in definition of macro =E2=80=98XA_=
LIMIT=E2=80=99
  248 | #define XA_LIMIT(_min, _max) (struct xa_limit) { .min =3D _min, .ma=
x =3D _max }
      |                                                                    =
  ^~~~
../net/qrtr/af_qrtr.c:746:30: note: in expansion of macro =E2=80=98QRTR_END=
POINT_RANGE=E2=80=99
  746 |                              QRTR_ENDPOINT_RANGE, &next_endpoint_id,
      |                              ^~~~~~~~~~~~~~~~~~~
