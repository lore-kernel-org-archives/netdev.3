Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B334335B125
	for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 20:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786740073; cv=none; b=H5+G2v5IXS4bTxAF/bV+y2zf0Q4jjt+BTlPWSqTuUThdX7WFyWLDb0eiM/14sQ0jm4oprfxhjn5BOniZTlnfxalt4k5c0Xqx7v71s2oH2HMI2wgfKHqL2AHeEvQtCfrbvcGe2gJ4nnQbsikZyqm5BWLA0d6cAJ8Oz96QO0FXFSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786740073; c=relaxed/simple;
	bh=SJAoS9ocusgvQX/4DvZUikEEHKtvilOsfJar9k3uafY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n2B0QWPaUy2l8js5raDZsQJMsfxRT5lAV6hUlgQucg4rj4ZNEeATrllkZH5JoQX4CetF4MiLeLR4CFfATDA9WfSN+0aOU+NN3sIK9MN0s1xlfTkOw1ES2CcS5INrUg0urz7mizhAgsxTd+q6iU01+EoWK1fr6kt5nvLCjazI8Ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nZ6yOXHY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nZ6yOXHY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 191041F000E9;
	Fri, 14 Aug 2026 20:41:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786740072;
	bh=SJAoS9ocusgvQX/4DvZUikEEHKtvilOsfJar9k3uafY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=nZ6yOXHYWpL9TjpeEJ0dUVMSFCrgKXhXtKYBLkF3b9ERSzEzsaiHQrIWrhkOLKAju
	 CVTUcf1qp1Y0MAhaR357F/9knQA0FBV8Aoah6umw4oDkhJxVTWCbSk0FYmiHQAiMEq
	 4tQrkFNhfGWuc2HwovAcXe/QSgJYeHMP/6oFaizi0EC1C2YHcaItRFPUFOovW1XZ04
	 yepugovhbvUAuQpTsHT9SFkgcaXalcMPdhIFLDjpChR2Fg+7G+4EfyfNJQulgEmmd1
	 lY3ngzLaXCLs4GW0f+LuNX6igrRB8VqhHR7xTudU3d+ooQ+4nlDUp9VQ7Fr5eGtyAH
	 bfOPM+HHohJ+Q==
Date: Fri, 14 Aug 2026 13:41:11 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Eric Joyner <eric.joyner@amd.com>
Cc: netdev@vger.kernel.org, Brett Creeley <brett.creeley@amd.com>, Andrew
 Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, "Nikhil P .
 Rao" <nikhil.rao@amd.com>
Subject: Re: [PATCH net-next] ionic: Add .get_fec_stats ethtool handler
Message-ID: <20260814134111.7116cd4f@kernel.org>
In-Reply-To: <1ea0dd7d-2a61-4029-8e03-4751d53126bb@amd.com>
References: <20260731214021.15279-1-eric.joyner@amd.com>
	<20260814120520.11e24409@kernel.org>
	<1ea0dd7d-2a61-4029-8e03-4751d53126bb@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 14 Aug 2026 13:21:41 -0700 Eric Joyner wrote:
> But a couple questions: the Sashiko instance at this site looks like it's doing
> more review than what the Sashiko bot at sashiko.dev does; should I be checking
> this site for Sashiko reviews instead?

Probably as well more than instead

> As well, I don't think the upstream Sashiko repository has support
> for cross-reviewing; is this site running on a custom version or some
> early unreleased code?

Yes
