Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EB1F17A2EA
	for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 02:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772073662; cv=none; b=IX62LktMR8NP7T22p4fD5ac60bUXvtex6e/wXLaLppAj+lliMjMbSyIfIBYiR7xt9zbn98BdkTwU45WGKpPkdH2YKmHQqZfwh1/iZ3usIghlBMMsL4CxDPlrBQhHbWX9V8H9cpVRWXjhdgJY35ikF91SIuTF6yrnqAkTENqKr/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772073662; c=relaxed/simple;
	bh=JwaAH1xluNDP5xqR4iNFoknTLaz0nbcLbO//Isd0sIs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l0kDQmXqhxCnK6OHxqWi3SQEIs9AsmcfP0TH/VBJRirYOF+EQSlaBR5WHPXPxZ+UD9qTjNyCEmsAuIw66M6O3kvFEX6P92RDcHX/kGqWitwGvzCVXb5spquAoJrAyhzd+WHy0oadrIWacpVUogMFT4z44LdRC8PIwS5+OJxoat4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A4foUOLh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A4foUOLh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCBC9C116D0;
	Thu, 26 Feb 2026 02:41:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772073662;
	bh=JwaAH1xluNDP5xqR4iNFoknTLaz0nbcLbO//Isd0sIs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=A4foUOLh54EFOUzM/jNbwCMdcmeU4IIzfokxTawqcdV5IkTecf5KqUqTiWG/pRPHd
	 pFwoV+l0EOogwmHSBs/qSF16utHKcjp5ZGulJ31QoyeRmwBVcrcYvUSJq6iezAXcqU
	 060EBVNEhdZzTPP9Msz6XxSOPzwUfbcfL0+D3H/n19MZf1IuEkV8w4wuenIt0fjkuz
	 FVbZ2Sv2CMKlQcvxilp9Zpby8TUBzCEXm3Fd62OJMwS+ZPHvycfK4pnLLqq7XbDkms
	 umjrf8rWkdx4HvKdcPIdJA46UrOEzFWPbbryD7Mrb5VFVb9poYHY9DHZRXKlh9XWBm
	 mRxBWuEy1B3FA==
Date: Wed, 25 Feb 2026 18:41:00 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Maciek Machnikowski <maciek@machnikowski.net>
Cc: netdev@vger.kernel.org, richardcochran@gmail.com,
 milena.olech@intel.com, willemdebruijn.kernel@gmail.com, andrew@lunn.ch,
 vadim.fedorenko@linux.dev, horms@kernel.org
Subject: Re: [PATCH v3 net-next 3/3] selftests:net: Implement ptp4l sync
 test using netdevsim
Message-ID: <20260225184100.20b24179@kernel.org>
In-Reply-To: <20260225153858.29486-4-maciek@machnikowski.net>
References: <20260225153858.29486-1-maciek@machnikowski.net>
	<20260225153858.29486-4-maciek@machnikowski.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 25 Feb 2026 16:38:58 +0100 Maciek Machnikowski wrote:
> Add PTP synchronization test using ptp4l and netdevsim.
> 
> The test creates two netdevsim adapters, links them together
> and runs the ptp4l leader and ptp4l follower on two ends
> of the netdevsim link and waits for the follower to report the
> synchronized state (s2) in its output log.

Please make this a Python test using the wrappers we have so that
the test can run both against netdevsim and real devices.

Is ptp4l going to be stable as a selftest? And will it give us solid
coverage (vs doing some fallbacks and pass even for broken drivers)?
We generally test 

Vadim, WDYT?
