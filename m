Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1C5B30DEB8;
	Thu, 13 Aug 2026 01:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786582873; cv=none; b=kZiR20paw3WOQ1U0nhPgD/NA0K31hsO8uJfGcy06DbSBON++DD17QPcs/Jo0eFSiVwzGhB44LpRV4qrtXF5sRqHWjw8pUhIcneBhTJieqwVxh78YUQnbvgiseQT7Ts8i8E2jro9X9tK3MPFU3qCWW03GCNIgbOwAl1+s7ChrrrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786582873; c=relaxed/simple;
	bh=PbgYrcKg9leEWlbXpeZXWHFCj1wF9VDh9cu0FdsX3dc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Zd6MXWBl9MxhDPVCate1Req2OV6J4TAPbVx0c1eiyeN6NLfTxzCKVMWneJ+ARxANxI1B8+gz66KCL1M82LbMaaKCpzKv6huvhiP4eDX4J97F0+7CCdjc0NBPc8OiQTYUyImNu03JvXye5Vluji9bEtzYmF2BeC2hiZ55rMs2F+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NLZvEfv6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NLZvEfv6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FCBC1F00A3A;
	Thu, 13 Aug 2026 01:01:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786582872;
	bh=23qWJPWUJcWMMuV7bdGgFVQ1ksa+LYNCOKi0qmBssDw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=NLZvEfv61To44BTmxlWEn7grD0AEB9VPNMFnybJ+6Tvy0Gu3ICQSS0HEEZptCCGYL
	 Ag6mEoZiZmE5BDnY041ftfnOzHzcEp/jHLupYznab8MpRsjW1x9LCUjtarPrzGtRnZ
	 b/JgtQQb+PJpw3Cy3xqcwr+OAvbEiGBQzn10beIk7H7EjTgpogO7ZiyhgiyYyaH9zq
	 ozIS+3DL2d++LOjijWDFeTNNfNSFa9H8FagQ7OmbWvVabtVkuFrLLNyf9oc8kkWzFM
	 r/FqI6+AqOuklpdcwvRL00oJj6Ttllu9vE9rD2nzQzfHzlSzEX6Bb0FCegM5UFh/A9
	 Conff9GWpnKMA==
Date: Wed, 12 Aug 2026 18:01:11 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: Jay Vosburgh <jv@jvosburgh.net>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Hangbin Liu
 <liuhangbin@kylinos.cn>
Subject: Re: [PATCH net] bonding: fix u32 overflow in compute_gap()
Message-ID: <20260812180111.76d0cece@kernel.org>
In-Reply-To: <20260810-bond_overflow-v1-1-c9ff29d76770@kylinos.cn>
References: <20260810-bond_overflow-v1-1-c9ff29d76770@kylinos.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 10 Aug 2026 10:38:23 +0800 Hangbin Liu wrote:
> From: Hangbin Liu <liuhangbin@kylinos.cn>
>=20
> compute_gap() computes the gap between a slave's link capacity and its
> current TLB load. Both terms use u32 left-shifts that overflow on modern
> hardware:
>=20
>   - slave->speed is u32 in Mbps; speed << 20 overflows at > 4Gbps.
>   - SLAVE_TLB_INFO(slave).load is u32; load << 3 overflows at > 512M.
>=20
> Cast both operands to s64 before shifting so the arithmetic is performed
> in 64 bits. Also update the comment to make it more clear.

Could you clarify the impact in the commit message a little more
explicitly? If the links are the same speed -- does this fix still
matter?

AI over here says:

  The fix is incomplete for very high loads: each hash bucket=E2=80=99s u32=
 tx_bytes
  already wraps above roughly 3.44 Gbit/s sustained over the 10-second inte=
rval,
  and aggregate u32 load wraps above roughly 34.4 Gbit/s.

While these are not exactly the same lines of code - I think it'd be
worth to address them all in one series.=20

> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Hangbin Liu <liuhangbin@kylinos.cn>

Oh, you work at KylinOS now -- please clearly state in the commit
message if the issue was seen in real life or AI-detected.
