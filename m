Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 055D045198D;
	Thu, 20 Aug 2026 21:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787260496; cv=none; b=KNHsAYazG6DoSYUZ1vh2YmGgDAVm+imguUMlPZRCT2xgE3/TTT7Q1Kb65tUfy9FDdOLzBJ5EOjxmY4+dCfb0F1BaIllCYMW5OxszCZnQzf/X3Fl/p7I/X+xqYq6XTD2SUS4fZp7X5B08QruQxRthIj+S6uLNgc3NupMau/wHlmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787260496; c=relaxed/simple;
	bh=/rvFs4SfiX+kVrj9HRno0oEU5uswJ2+aXCx42//Qx/4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E84oaFBBgZZH42/9arvg5n5rBeQ6rfCeM+nM+rxqsUATrNXp8WLr6ziTUs40JymJ4hVjCefyTYjJgYeqdY7VDzm8PofHIVSkZi//PnvqMFYjWvZKKH02cCiZ2ZZjorA6cjB5vzVOcH8qw+7bOXdpAtJfBRl3wZn8jLZYZVRfL8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O3dG1WVd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O3dG1WVd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 935211F000E9;
	Thu, 20 Aug 2026 21:14:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787260492;
	bh=hVVXoNrYa4PYRVXGveIWJ21amnb24aro3iRIkgFpVE8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=O3dG1WVdoHi+R7FGmSi8S+TvANFNiYH6BcVEXKWaDGeUeVxHt0QhFUlHb9KPK69un
	 FPyRxS51EwlczAUuqyCIi+x3De0mzMvZtPmGEoW/QtaT89Ns8jLDgmbBGUTdatahpN
	 0fPvuWFVgtlo+GtCsSurLZW+X3XulS+YnZXthEHetBm7EIt6jE5V1N1PpBSHDaRZPi
	 bwS1I3msOo4vQS3skbEylSw4QGSNH+n1CTJQHh458KORUdIk4iq6b5JmlBjnzJ+cSs
	 nnHedcRTxUXwL0ixzABbwXtbvACMkmWtgKluPiLWCHxqNZfJSj/6jO+fzawdyD3C9o
	 RS7gcU2lKyzmg==
Date: Thu, 20 Aug 2026 14:14:52 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Michael Chan <michael.chan@broadcom.com>, Thomas Walsh
 <thwalsh@redhat.com>
Cc: Pavan Chebbi <pavan.chebbi@broadcom.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Michal Schmidt
 <mschmidt@redhat.com>
Subject: Re: [PATCH net] bnxt_en: Gate TPH enablement behind
 BNXT_SUPPORTS_QUEUE_API check
Message-ID: <20260820141452.2ed9ac1b@kernel.org>
In-Reply-To: <CACKFLi=6Pcynd2MR7apH8tTN3UVnzCcR0YuP7B5tgGRgtO_ttQ@mail.gmail.com>
References: <20260818141556.64303-1-thwalsh@redhat.com>
	<CALs4sv1zb7OemFcKRceoO49F8yPSOdZWSkomvU=mGmReR74=BA@mail.gmail.com>
	<20260820103950.5dfa2969@kernel.org>
	<CAD+aA83e_HP=Z0pXpcxW5j+TUXdgP3Dx8_LGxrMjdVwtERRCtg@mail.gmail.com>
	<20260820111557.49f658a4@kernel.org>
	<CAD+aA82ONaO+oNuX448ruJdLJ+ySvsnNwyCLYGGyDZfOA6U6cQ@mail.gmail.com>
	<CACKFLi=WPCW=G8nyFbZnRf2yFxrc6Qao4HnsQf3J10JG8rwQnw@mail.gmail.com>
	<CACKFLi=6Pcynd2MR7apH8tTN3UVnzCcR0YuP7B5tgGRgtO_ttQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 20 Aug 2026 12:16:07 -0700 Michael Chan wrote:
> On Thu, Aug 20, 2026 at 11:59=E2=80=AFAM Michael Chan <michael.chan@broad=
com.com> wrote:
> >
> > On Thu, Aug 20, 2026 at 11:30=E2=80=AFAM Thomas Walsh <thwalsh@redhat.c=
om> wrote: =20
> > > NIC is BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
> > > [14e4:16d7]
> > > FW version shared with us was 238.1.138.6 upgraded from 236.1.167.0 =
=20
> >
> > This NIC does not support queue management.  I think it also doesn't
> > support TPH, but I need to check and confirm. =20
>=20
> Confirmed.  Only Thor and newer (P5_PLUS) supports TPH.
>=20
> So the patch looks fine to me.  TPH requires queue management to
> restart the queue.  And NICs that support queue management (with
> updated FW) all support TPH.  Thanks.
>=20
> Reviewed-by: Michael Chan <michael.chan@broadcom.com>

Thanks!=20

Thomas, please update commit msg with the info from Michael, rebase on
up-to-date net/main and repost.
--=20
pw-bot: cr
