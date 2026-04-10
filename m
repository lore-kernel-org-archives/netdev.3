Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B10F18C332;
	Fri, 10 Apr 2026 00:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775780040; cv=none; b=XsgILt8WNze75puCyuk5Y/o3jM2sImQFnXKWw89ay1DzIIC8v7w39DAEnSATdkgGMPUL6sjo17OwfVXP6JdMm/qyfDzo4dYe4uw9vYosQIhKPW6npGAkENwhGkp8G8KcAo4BditXLI1jjQUH0Ezf+oVQHZunYwZzZsqHeZpUqhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775780040; c=relaxed/simple;
	bh=zGzuYm4bMNio2DckbGEIyCib6paQJ0JkF4fC60Q9rCE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KJOmgVMyTYbqSMzGb72ZEnOASwU2cG49ZSlxUP0jfDe+jpPJd3IBeuLtAvnuqPQzsJcWbUq6ezis+eMOJe7lXExjczLozyJv9E3wLW9BAOM80kJjjupqNC1srlRkkkd/QVSspedFnG+YzKv+bW1ajQiekGQmRCpCCGTgNbZ/qIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=ZWxoxqn2; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="ZWxoxqn2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1775780030;
	bh=zGzuYm4bMNio2DckbGEIyCib6paQJ0JkF4fC60Q9rCE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ZWxoxqn2G+NHrQxEBq402ljhFgoimECID6L7UcG3Thp5xBYYg1KpwRl97G6TQ6YrA
	 qlDTo5wFCk1oDmM86LwQHbdVYkCFacgCAiGvL86sDwG//xqR1yiVwkC5T+Bs5EpuBS
	 de9bHsQ/LWyjjTTPw2MR0+6buwx4PB35It0MmNNGnc8v2EofTWXAachTDh1YLoLSbf
	 IFYcpmDw4AvcgdAGWFZZp+GEwReQU62OZmcsCeF3FJFGl2Yh8r6PDfxh7JINI4a6vX
	 XE4LLsRHivZR2g+q0iDFxzmiYX26WjTtFkMHMBsvEOAzO5iD7Go0O9CmaJ6VCO2JPk
	 xOAxxg0e7K57A==
Received: from pecola.lan (unknown [159.196.93.152])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 1FC89651D5;
	Fri, 10 Apr 2026 08:13:48 +0800 (AWST)
Message-ID: <ff147a3f0d27ef2aa6026cc86f9113d56a8c61ac.camel@codeconstruct.com.au>
Subject: Re: [PATCH] net:mctp: split mctp hdr version to ver and rsvd
From: Jeremy Kerr <jk@codeconstruct.com.au>
To: wit_yuan <yuanzhaoming901030@126.com>
Cc: yuanzm2@lenovo.com, matt@codeconstruct.com.au, davem@davemloft.net, 
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org,  linux-kernel@vger.kernel.org
Date: Fri, 10 Apr 2026 08:13:48 +0800
In-Reply-To: <20260409125129.9210-1-yuanzhaoming901030@126.com>
References: <20260409125129.9210-1-yuanzhaoming901030@126.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2+deb12u1 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi yuanxhaoming,

> from spec dsp0236_1.2.1.pdf page 26, the mctp header contains the
> RSVD(4bit) and Hdr version(4 bit).
>=20
> mctp_pkttype_receive invoke mctp_hdr, and get mh->ver whole byte=20
> compare the MCTP_VER_MIN, MCTP_VER_MAX. the reserver bits may be
> by misleading used.
>=20
> Signed-off-by: yuanzhaoming <yuanzm2@lenovo.com>
> ---
> =C2=A0include/net/mctp.h | 9 ++++++++-
> =C2=A01 file changed, 8 insertions(+), 1 deletion(-)
>=20
> diff --git a/include/net/mctp.h b/include/net/mctp.h
> index e1e0a69afdce..80cc9c63f6ba 100644
> --- a/include/net/mctp.h
> +++ b/include/net/mctp.h
> @@ -14,10 +14,17 @@
> =C2=A0#include <linux/netdevice.h>
> =C2=A0#include <net/net_namespace.h>
> =C2=A0#include <net/sock.h>
> +#include <asm/byteorder.h>
> =C2=A0
> =C2=A0/* MCTP packet definitions */
> =C2=A0struct mctp_hdr {
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0u8=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0ver;
> +#if defined(__LITTLE_ENDIAN_BITFIELD)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0u8=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0ver:4, rsvd: 4;
> +#elif defined(__BIG_ENDIAN_BITFIELD)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0u8=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0rsvd:4, ver: 4;
> +#else
> +#error=C2=A0"Please fix <asm/byteorder.h>"
> +#endif

I would strongly prefer that we do not use C bitfields for a wire
format. The existing flags_seq_tag member contains three fields, which
we use with a couple of helpers to extract the flag, sequence number or
tag values - please follow that convention if we need changes here.

Also, this introduces a few subtle bugs in that we are no longer setting
the reserved bits to zero when preparing an outgoing TX packet header.

What is the underlying issue are you fixing here? Are you seeing a peer
that is sending us packets with bits set in the reserved field?

(if so, that would also be handy information to include in the commit
message)

> From: yuanzhaoming <yuanzm2@lenovo.com>

Is this the preferred format of your name? These are generally in
a full-name format, or a known identity. There's no particular issue
with what you're using there, if that's what you prefer.

Cheers,


Jeremy
