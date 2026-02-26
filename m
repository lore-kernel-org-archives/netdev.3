Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5668A30F80C
	for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 01:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772071023; cv=none; b=KwAQuRFsW6IUkb91BGzL0fm2xevzITsImTuxtvslnwhC/qb9of+/mCMYFnd8F6TWofdzrd79SArwhU0tNX7QXhxdexe93CRMpBzt74Z1cjZ0tHSYc+fmpo+OS+JIgNIEMPZHLnDotbC97dwNj7/EKtz/sVGJJ3mm5gNmm8sighw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772071023; c=relaxed/simple;
	bh=Fw1IjG9gOrdND9hvs6niCSf+eraOAVvcSu8q8TPCEDg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QBFqJBvBDr8nVHW9NEfKlpElN3F0EzUFjU8ZercjGWw4Pj2ewTI5pFQUki7D/NeQxCcPMuW5FKPWwGJe2pFCwauUYskmiBMdWWR42iCdtdHF/t6CbuU4sRYWMDdHV3a2TUnvjQAlBRQhOcalzlrkdIZ73KRGjukyBDClyulYgY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hLZM8Ryo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hLZM8Ryo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F080C116D0;
	Thu, 26 Feb 2026 01:57:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772071023;
	bh=Fw1IjG9gOrdND9hvs6niCSf+eraOAVvcSu8q8TPCEDg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hLZM8RyoyA5nvcII2m0CTdPA56E3xghDOEPVXoor1EyTxnJn6QHz/BZxX4vyVQVP0
	 YYxzfw+D6zJITQqE/T8786qkzwyaZ+2lmN1jbBR47NesPo4Xo0r2O+m8aDmYDlyjfF
	 pu2xczlxCkkmdTrHQUbYrrOZU5fshVeesI9GHuQ3GvDqm/EdvPbyBlO3U6gK7+DRZO
	 6VOo5pI2dfRx25cDaOtSjNKSXoDGxR748K5NbrlvJHhiiwj2PSsKHCnbDoL06o9zcX
	 iqwgzG8mcX841l2dfdx2uu3gKL9zznIHLNH7B//DTrx63chm6KelMkOEMoQNY10O3t
	 1w7nxOUW5wIOQ==
Date: Wed, 25 Feb 2026 17:57:01 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Maciek Machnikowski <maciek@machnikowski.net>
Cc: netdev@vger.kernel.org, richardcochran@gmail.com,
 milena.olech@intel.com, willemdebruijn.kernel@gmail.com, andrew@lunn.ch,
 vadim.fedorenko@linux.dev, horms@kernel.org
Subject: Re: [PATCH v3 net-next 1/3] ptp_mock: Expose ptp_clock_info to
 external drivers
Message-ID: <20260225175701.2bcc6395@kernel.org>
In-Reply-To: <20260225153858.29486-2-maciek@machnikowski.net>
References: <20260225153858.29486-1-maciek@machnikowski.net>
	<20260225153858.29486-2-maciek@machnikowski.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 25 Feb 2026 16:38:56 +0100 Maciek Machnikowski wrote:
> Allow exposing the ptp_clock_info of the ptp_mock to the external drivers.
> Convert spinlocks to SLIS to allow gettime to be called from the netdevsi=
m.
> This is a prerequisite for implementing ptp support on netdevsim.

Slight build error here:

drivers/ptp/ptp_mock.c:57:9: error: =E2=80=98spin_lock_irqsave=E2=80=99 und=
eclared (first use in this function); did you mean =E2=80=98ss_lock_irqsave=
=E2=80=99?
   57 |         spin_lock_irqsave(&phc->lock);
      |         ^~~~~~~~~~~~~~~~~
      |         ss_lock_irqsave
--=20
pw-bot: cr
