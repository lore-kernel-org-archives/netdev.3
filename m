Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 637F022F77B
	for <netdev@vger.kernel.org>; Tue,  7 Apr 2026 03:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775531994; cv=none; b=MchXCmoNW0Cvz4it0HQHzuSC6LNRfugiMzR86/Q68aG0iQ7H32xcZielGWKRZoZhNOwEecQCs0Z+suvJaqIdo4MtRUv+195gUnx+oITl+ZiyGUZyojhogRKM8R5/aAWGIuXb/pv6o5LTQmk0/StEOW3Ftsv9htXJu6d98xYZILQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775531994; c=relaxed/simple;
	bh=Qoc9FcsWY0971Mtxw9re92jKrcBSoFbO9WY3rC0dWAM=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=n/dmocY4dVTMe0HCB8jZNyY3TbFo4EdiA+T2WUW4AgR7c+KXBvuyhKMJo9WGX5l/5UrPB2DEeVI/FRZQG7Iykxa+JeRtInVIztpD2FNKCay/0tJJ1mu/TY5MaLBqKeTfB90VeEUzR54TYy7dQ+v9kWOPEfvXDNfB3vYt+Lq/BMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=U6yLraf8; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="U6yLraf8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1775531990;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q3AInkdi6HcxeRmbGw4wszTC0bpMLALoEye9TJbgSw4=;
	b=U6yLraf8ZRVDW9ugsvvSN+oW6/LAKe+N2WbcSslZPfUGjTdAmROE0d/BvsJpNoBgUYDC+R
	SKDeXyqLvaPE7bhHN463+P2ql1fb3ec8VfG1CCKZMkK73ZCiakwAXyL88MIp5kLnWyzUXG
	z7+Gyza4Vh11bKoA6Ski6dJcF0wbFxY=
Date: Tue, 07 Apr 2026 03:19:45 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: qingfang.deng@linux.dev
Message-ID: <e3ada3f0bb0c389d592657b37c462944e633a0d6@linux.dev>
TLS-Required: No
Subject: Re: [PATCH net-next] pppoe: drop PFC frames
To: "Simon Horman" <horms@kernel.org>
Cc: linux-ppp@vger.kernel.org, "Andrew Lunn" <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>,
 "Jakub Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, "Paul Mackerras"
 <paulus@ozlabs.org>, "Jaco Kroon" <jaco@uls.co.za>, "James Carlson"
 <carlsonj@workingcode.com>, "Wojciech Drewek"
 <wojciech.drewek@intel.com>, "Guillaume Nault" <gnault@redhat.com>
In-Reply-To: <20260406144828.GH395680@kernel.org>
References: <20260403083926.68320-1-qingfang.deng@linux.dev>
 <20260406144828.GH395680@kernel.org>
X-Migadu-Flow: FLOW_OUT

Hi,


April 6, 2026 at 10:48 PM, Simon Horman wrote:
>=20
>=20Hi,
>=20
>=20I think it would be best to add/use a #define rather than
> open coding the magic value 0x01. And perhaps expanding
> the comment to note that skb->data[0] is the first byte
> of the PPP protocol would be nice too.

The field does not have a canonical name. As per RFC1661, the LSB of the=
=20
first=20octet is used to test if the protocol field is compressed, and th=
e=20
same=20code snippet is used in ppp_generic.c.

I could instead add a helper function:

static inline bool ppp_skb_is_compressed_proto(const struct sk_buff *skb)
{
	return skb->data[0] & 0x01;
}

What do you think?

Regards,
Qingfang
