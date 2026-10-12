Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 314F43B5303;
	Mon, 12 Oct 2026 11:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791805865; cv=none; b=aIm0rFrmpH25+3olJwidME/iZea7AnRNWPSTdHMKaHk5VWUmLTN4rjYt5DXf9qZ8FRQHCUmlKjhR08SiI0d/W3MqaqKk+UTmdYSxIpBm0utuP+UUiZpWcALNX9B/b1bO/dMyiQ4Ea2X20VkcPdP8LtB7fP93vt3t1KYmoQymazw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791805865; c=relaxed/simple;
	bh=auwg9QgxLhnE1InTXXGJFHS16ZPGCnIel6Upaaciny4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jNd4mLCp7tgj0M1C41juowgRTbc/n1YtCqqIkIQ0Js8H0AFkeXq81ko1LNQMnCr8H/TZU72y0mzXdS6hnfr6YY+YmPPth5MTw0mBBPAqjIBARVRa4Itzfd1jnzuYXNlnLCvn0Oof17dRl+XU73savcHb3VOXUHXUOtH/dad3Eso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SU5mfdAz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SU5mfdAz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEDF01F0089B;
	Mon, 12 Oct 2026 11:51:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791805863;
	bh=ooyxWk2yObkRmeRDkrc6crB49O5NVRfnR1NX/ptc5P8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=SU5mfdAz6DvWVc+2DyuN7OaFoWw0TX5aDDkc6PJdUWrNuq90JuZe1ayynCgSMPidp
	 xBBi6OnUUqj1ly3lNO/qoFf7x/FQKh1t9wfkMxvxtKseDGJ19suNcGJeRgGWUKQu3M
	 hid3dwSx8rjRVNgF8UoSubXCLl/+VQfhpu7E4wH/Zj7ZbaV5bWXgYkkaVu9DWSlDnT
	 Z2GC4my/e1+hOWXQwu+Sf6aIwDQ+iW71uToKjQpjUiOK/ZAnxu7UEQvdoLGgj3d/b9
	 vm+5CKBl5fRBUc6QSY8GYd2Vpxb78XG1DjAOCD5g3pk+VcWhThkEOTUFikiv+HhQoD
	 9g9Io5yNKY8Gg==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Vikas Gupta <vikas.gupta@broadcom.com>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 bhargava.marreddy@broadcom.com, rahul-rg.gupta@broadcom.com,
 vsrama-krishna.nemani@broadcom.com, rajashekar.hudumula@broadcom.com,
 dharmender.garg@broadcom.com, ajit.khaparde@broadcom.com, Vikas Gupta
 <vikas.gupta@broadcom.com>
Subject: Re: [PATCH net 0/2] bnge fixes
In-Reply-To: <20261012054325.1782819-1-vikas.gupta@broadcom.com>
References: <20261012054325.1782819-1-vikas.gupta@broadcom.com>
Date: Mon, 12 Oct 2026 13:51:00 +0200
Message-ID: <87o6czcf2z.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Vikas Gupta <vikas.gupta@broadcom.com> writes:

> Hi,
>
> This series fixes RSS indirection table and context sizing for large RX
> ring counts. Patch 1 caps the hardware RSS context count and RX rings
> to the RSS table size, preventing out-of-bounds writes and an oversized
> memset(). Patch 2 fixes the indirection table sizing so rings above
> the table size still receive default RSS traffic.
>
> Thanks,
> Vikas
>
> Dharmender Garg (2):
>   bnge: fix RSS table sizing for large RX ring counts
>   bnge: cap RSS contexts and RX rings to the RSS table size

LGTM. Tiny nit: If you respin for some reason, the patch order should be
reversed -- capping before the rounding fix?

Reviewed-by: Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org>
