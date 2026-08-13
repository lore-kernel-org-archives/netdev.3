Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F332447986F
	for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 15:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786634053; cv=none; b=bPqnZsW3ysomsQxErOOsBsbnOTKYdyrISN8FC8BlNOu9ejknYstlaMA+cjyFSHO3mQryO7sTfZB/ptHUwN5SPhA9hnUBxjpE8zDnZijJIh1YS1L4pPdlxWKfGYkugFyYdfOCdGOoHOSTRJFLtGl5w6Cf3Zka6uWkdIyhkvEqG6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786634053; c=relaxed/simple;
	bh=un88YKHcR53iGfBRG6dbnRWdPeUCwPjWKePHdc3weXE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mpXvjU4MZaYWWwlz1zDEX3ODl6ogzJESevmJHHMkHqTjWAEWRWbS2gMuiDtckFqD1wq1oT8tmSXujvtOlVrEAErLlY/lbkaDxzsgKr6g1Kh6xs1TMpZyYNQdLK4wNS+B0a1n+uTsSs7zKi43baQEcvgklPJIoDY5DJsXIo+jCG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D6qG3+mF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D6qG3+mF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DB2C1F000E9;
	Thu, 13 Aug 2026 15:14:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786634051;
	bh=un88YKHcR53iGfBRG6dbnRWdPeUCwPjWKePHdc3weXE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=D6qG3+mFksYYYixpg4zLdtmRqrY9VHcaFdRSXc5XKBXTwaSqGD/8Oab4aB993xRXn
	 i7fuTCXDKzevfa5t7RFqNqj3KGRIIXm//sDzp5ny17QTGyMEeu+rd6VBjsojbCyx4+
	 GQsFpdhgG5A7NBOjet9obwaLXNXxfMDu8h0uqEqux4qjxE0mhfu9Kl0Uy1obWSVxpd
	 sTR6n4CuS4OLwh+tsBd+UoFH00QwXM10E97aLZpdH7oTUNDA+R077P/TUgIjWrargo
	 60oBuknL+FqZqPj8g8HSoelySf3wbwTohNlocKUslRRm+L+f0qszhmuu1yo7iwvs5h
	 o4l89beeisqKg==
Date: Thu, 13 Aug 2026 08:14:10 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 ttoukan.linux@gmail.com
Subject: Re: MLX driver for host-to-ARM communication
Message-ID: <20260813081410.5fdeceb1@kernel.org>
In-Reply-To: <ba322fd3-9f91-4e2c-9000-12d473ecb249@nvidia.com>
References: <ba322fd3-9f91-4e2c-9000-12d473ecb249@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 13 Aug 2026 11:33:23 +0300 Tariq Toukan wrote:
> Hi,
>=20
> I plan to submit a patch series introducing a new minimalist MLX=20
> host-to-ARM communication driver.
>=20
> Could you confirm whether this series can be submitted in parallel with=20
> our regular mlx5 feature patches without conflicting with the 15-patch=20
> limit?

Not really - is there a vendor that's submitting more patches just
because they have more than one driver that you know of?
Doesn't matter how you slice your code.

If you have concerns about patch volume please me reminded that since
you don't review much your patches get the time penalty for coming
from a non-reviewer. Luckily Ido is reviewing a lot so at least you
don't get the company penalty any more.

> It is to be placed in its own new directory:
> drivers/net/ethernet/mellanox/mlx5/nodnic/
>=20
> Find more details below [1].
>=20
> Regards,
> Tariq
>=20
>=20
> [1]
> net/mlx5: Introduce mlx5_nodnic driver for BF4 management PF
>=20
> BlueField-4 no longer includes the RSHIM hardware that previous
> BlueField generations relied on for host-to-ARM communication. In its
> place, the firmware exposes two dedicated management PFs =E2=80=94 one fa=
cing
> the host side and one facing the ARM side =E2=80=94 and configures steeri=
ng
> rules to loop traffic between them, enabling host-to-ARM communication
> through standard networking interfaces.
>=20
> Add mlx5_nodnic, a lightweight driver for these management PFs.
> NODNIC (No DRAM NIC) is a lightweight interface intended to allow
> simple packet transmission for minimalistic drivers with a low memory
> footprint. The driver communicates with the firmware through PCI
> Vendor Specific Capability (VSC) =E2=80=94 reads and writes over PCI conf=
ig
> space, unlike mlx5_core which uses a DMA-based command interface.
>=20
> Each management PF exposes a single SQ and a single RQ that share
> one CQ. The interface configures two MSI-Xs: the data MSI-X fires
> on CQEs, driving both TX and RX completions; the event MSI-X notifies
> on port state changes, where the firmware brings the port up once both
> the host and ARM sides have gone up.

This will be nacked. We nacked multiple such drivers over the years.
Most recent one not more than a year ago.

If you model the device as a network node it should be reachable via
the normal networking path. If it's a control channel - explicit
control channel APIs should be built, rather than doing pretend
networking.

Every IPU vendor gets to this sort of design sooner or later because
it's an easy hack when running a user space SDK. nVidia has clearly
turned from upstream work to pushing your DOCA stack on all customers.
No matter how many shameful lies y'all told about fwctl not being DOCA
related. This is just a next step. But please commence your bullying
campaign. What do I know, right?
