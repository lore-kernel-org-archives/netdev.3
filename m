Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83753378D6B;
	Thu, 27 Aug 2026 19:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787858056; cv=none; b=g+pcFVz4rCVWHFtruEO7kjjRBJBVbNCmP93p2hNuu2qYU8jGALCoTTvQnwC3I+eFF3YmZiY+B9xKXIX6JWJ0q1uMPcGuuRTnnkLrNvXlsz2mPpqXQ8lwQHadpPI6k6CHBOBhmTLvJU7xSnNRDbYBz/onyS3hxx6v4B+N8OSb0m0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787858056; c=relaxed/simple;
	bh=ON3ozEPj6VPqr9MH1NdFS8n5MaotiwRL/tVsnWJL848=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NA904J1T93dx+U7qRZ1TFeGbYjUHzjf4YeWRWOWZn6PdPIoT7yk6kFU9zdvWgqBetRBqBkr5VhnyRmT+wkqUZWw6xvFT314Rh9HUV5edMFPeh+GIUjQvfBORCK8sGJbCYMtJny+NqTSxFBG5ql/Xw9InRT94lxjIOxmFGoVDVI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ik/+Zm7u; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ik/+Zm7u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E22161F000E9;
	Thu, 27 Aug 2026 19:14:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787858055;
	bh=ON3ozEPj6VPqr9MH1NdFS8n5MaotiwRL/tVsnWJL848=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Ik/+Zm7uSoD+2hWmBkhUaOXTZRvGANRu8iiQ1EcvYqG+XXri5fXlefD+XMxtLIPBj
	 TvqoKbm5fIHVGkMy0vsx9JChR7yBPN42y/oPs6I0EnDWu2dqqIRamKKGCzcyK/HsHd
	 L23jAtAbaJN+s8tNY4zCulUS82ds38ij3DRiihSw1iFMblIL4HDFM00ihyt1KKASw+
	 GOMfiofkTdQ+mhiNcwxaQQ4/0NHBF4Bkg9MEHyj26h39p+Prcm2t9UgQ+giUh6fnV2
	 4o+oJkPkDq/i9IeaulbabfXBiwtJf+BwcYhyA08WxHW6M0sMkbd5PsdtOIEf4BmnW2
	 mfpo6Kjaxottg==
Date: Thu, 27 Aug 2026 12:14:14 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Yang Zi <2959243019@qq.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH] niu: validate num_ports against NIU_MAX_PORTS
Message-ID: <20260827121414.3275d710@kernel.org>
In-Reply-To: <tencent_A16FB6B3A899F3D4CBEC0F2F5531DD502807@qq.com>
References: <tencent_A16FB6B3A899F3D4CBEC0F2F5531DD502807@qq.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 25 Aug 2026 17:42:42 +0800 Yang Zi wrote:
> niu_get_and_validate_port() obtains parent->num_ports from hardware
> (nr64(ESPC_NUM_PORTS_MACS) & ESPC_NUM_PORTS_MACS_VAL), an 8-bit value that
> can range from 0 to 255, with no upper-bound check.=C2=A0 The driver's pe=
r-port
> arrays (rxchan_per_port[], txchan_per_port[], rdc_group_cfg[]) are only
> NIU_MAX_PORTS (4) entries, so niu_divide_channels() and
> niu_divide_rdc_groups() iterate num_ports times and write out of bounds
> whenever num_ports is greater than 4.
>=20
> Reject num_ports > NIU_MAX_PORTS with -EINVAL so the probe aborts before =
any
> of these arrays are written.
>=20
> Covers fuzzing bug IDs 321, 322, 323 and 324 (same root cause).
>=20
> Signed-off-by: Yang Zi <2959243019@qq.com>

this is a waste of time, please don't send any more patches to linux
networking this year
