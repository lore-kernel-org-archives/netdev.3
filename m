Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40CE93C870D
	for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 15:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773328352; cv=none; b=hp8E8QEIi9/UJ8Jw8PCV5l7COqPABoOcj6LCX11ysNYyOHPusTmMisPt+XGVhbCXweqWtISTQyEPBFOz0PcfCHHyEZ4clxmt7pBub3kytOEZQeS0AqpbN6CnxjHEmCVlMWeM9HPMqEK4U8u9XB6iWjsiT1HHFIh0VNZe5fxeY3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773328352; c=relaxed/simple;
	bh=JF3xHNGa8r6OMmdSsEx9P1AFHuB41PNGGUONR/PstEg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UPi3IK9PYXGHrUS/2hqNQ18a+StnM2K4zHa089HZ/fuHI+xjeyfZNt+rYXiD0gnF8DVKmZ1Y6nF07UIBdRx/TW/Ihs4HHMNmwDAR1cp7scUgY0VR1su7cSdA1YHcqxtBcGsXI2nzLaKhGTtPMdEFg/87LQw7BjrnrL904n8dsH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bV1ESFfY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bV1ESFfY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61B30C19424;
	Thu, 12 Mar 2026 15:12:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773328351;
	bh=JF3xHNGa8r6OMmdSsEx9P1AFHuB41PNGGUONR/PstEg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bV1ESFfYvLaau6l8TShDGHClmcS5KVjKrZ8DxVT7rx0Ba4eFXIYzujp0cLKyS2m6Q
	 vbIaQjGkMeROoUp5Omwz0/zMwp6vxsGH7e+UdeT5sGFh9JDJnMVqcWvkgVD4xooEEi
	 WFgd6DXuFRe9NZsy0Gcp/Yv0lak1XcvNxnrv0+GlA29QJWwto93NnHV3SpSk1XKP6h
	 YeC/L+sl0dWbmLjlA6E4ulteXtUmz2y91DehOEdXc/0mo1qndBhrXhBfypPCwAnmtB
	 Y5uvM90gl/zMM8XfMc+hS4+naxYikaIXaQr4K1ELe2zSU2LrXNZAZubosfle1m0pnR
	 cfLldCd/FtHBw==
Date: Thu, 12 Mar 2026 08:12:30 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org, eric.dumazet@gmail.com, Guillaume Nault
 <gnault@redhat.com>
Subject: Re: [PATCH net] ip_tunnel: adapt iptunnel_xmit_stats() to
 NETDEV_PCPU_STAT_DSTATS
Message-ID: <20260312081230.1540a7d9@kernel.org>
In-Reply-To: <CANn89iJbfsT5-j0iPWpCSsoDuOF-PmfbE9hL4YpEU7ucT8ipxQ@mail.gmail.com>
References: <20260311123110.1471930-1-edumazet@google.com>
	<20260312074630.52e7a311@kernel.org>
	<CANn89iJbfsT5-j0iPWpCSsoDuOF-PmfbE9hL4YpEU7ucT8ipxQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 12 Mar 2026 15:53:02 +0100 Eric Dumazet wrote:
> On Thu, Mar 12, 2026 at 3:46=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> =
wrote:
> >
> > On Wed, 11 Mar 2026 12:31:10 +0000 Eric Dumazet wrote: =20
> > > @syncp offset in pcpu_sw_netstats and pcpu_dstats is different.
> > >
> > > 32bit kernels would either have corruptions or freezes if the syncp
> > > sequence was overwritten. =20
> >
> > And moving syncp would be too much of a hack? =20
>=20
> I thought about this, I prefer doing such work in net-next.

SG

Acked-by: Jakub Kicinski <kuba@kernel.org>
