Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AAED31A56D
	for <netdev@vger.kernel.org>; Tue,  3 Feb 2026 22:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770159451; cv=none; b=kG9SZBdYXb7dFnkd4qRk6Mfly2sMniXiRmMoej2Z+5JVfCOQZYHJOia+xZpAxAf+uQ2GMt4WC/BVraR5dloLzj+MJlL8h0jXBHqCdEDDFOt+jBAERwa3eU6P4Nw0cYXY2rFlU2P3fkzthqqx9rf0cWES0Qemi5FzbwB0wdaSdyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770159451; c=relaxed/simple;
	bh=ZPGoWml9B3CG2RjjvCfS1WHH5jV05Cb3Z1s+Ti229NI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=meTVMIJXkx9e7X39cxKzRzNT+EyLyJSc6JuprtnUl4AyL90B84wrGM8E2302BxITO4nLrRKmL483YXS/G7riZuBiMpGCnXnQJCBrA13PQmyaeaRbyTiBkSSAjD8c2H32S3FiAwRBLzz44tLal51Z15vyeW+4GYa7saq3c8XjY1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TVqMCQtE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TVqMCQtE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8926CC116D0;
	Tue,  3 Feb 2026 22:57:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770159450;
	bh=ZPGoWml9B3CG2RjjvCfS1WHH5jV05Cb3Z1s+Ti229NI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TVqMCQtEHpNRZz3Vftt1TqWdpwfDGJle98LWBbUkP2/dF6FpHMlE9hY9dk30NKcqs
	 6jdiW2H1oEnWNXtCZi5Mmd7TfoUqkiUktRvR6MK7JuKIkJhLYAiVo+csm0YEGvFE90
	 /i7xDbqlYRLAp/ydXirmN7xPnhCAc3Ecu3uR+2LDpXjvakFQudgQf9W/XbQbQDSx79
	 5ElpkmEfOQpz/Zv0IHjPOdCT2plMpRqsFCisdDwDyZDbyfcWmNHJP9DMpjpuAEWXji
	 u/UUU8rdYL3YTEOYzQ6S1so2lbSSOK/68LhiPRa2QNKL5NqDgig2wtRPkGBSKuwY6u
	 ozzmfUeGta62w==
Date: Tue, 3 Feb 2026 14:57:29 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Cc: netdev@vger.kernel.org, Don Fry <pcnet32@frontier.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next v2] net: ethernet: pcnet32: remove VLB support
Message-ID: <20260203145729.5c491d71@kernel.org>
In-Reply-To: <CADkSEUiAvv6eHEcLBkHRW8KFqSgcxg46+1BE25T50hT6ZkGbbA@mail.gmail.com>
References: <20260131012119.25863-1-enelsonmoore@gmail.com>
	<20260202182054.0a755aea@kernel.org>
	<CADkSEUiAvv6eHEcLBkHRW8KFqSgcxg46+1BE25T50hT6ZkGbbA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 2 Feb 2026 21:32:13 -0800 Ethan Nelson-Moore wrote:
> On Mon, Feb 2, 2026 at 6:20=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> w=
rote:
> > On Fri, 30 Jan 2026 17:21:19 -0800 Ethan Nelson-Moore wrote:
> > Unless the maintainers acks this I think we should just wait until
> > we can delete this driver completely. Unless this unblocks removal
> > of some VLB-related APIs (which I wasn't able to spot..) =20
>=20
> I don't think that's going to happen anytime soon, given what people
> have said about its uses.
>=20
> FYI, as of 6.19-rc8, the driver works with KVM's emulated device
> (Advanced Micro Devices, Inc. [AMD] 79C97x [PCnet32 LANCE] [1022:2000]
> (rev 10)), well enough that web browsing works fine and it can
> download at several MB per second (multiple large files at once). It
> has random short stalls (of a half second or less), but that could be
> due to QEMU emulation issues.

IMHO we should probably start deleting the "QEMU emulation uses this"
toys, too. virtio existed for long enough.=20

But let's wait for 7.x with that, we deleted a bunch of drivers in=20
the past few weeks. Let's see how many of those we need to revert
and whether any lessons need to be applied to next removals :)
