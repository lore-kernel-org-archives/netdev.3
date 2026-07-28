Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA36E2EC57C
	for <netdev@vger.kernel.org>; Tue, 28 Jul 2026 23:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785280681; cv=none; b=VnjH9Kgz/+T088+TgAQHwxRVsWZJtsVgiStmfxEyNjoSuamHJXtNob21Yu6XTASHECeaaHFc7Qx38OrlFFV866PNCiB7GtlHajWfqwrp2evHfvq1+E/VoHRqkofcjZdpz0OyYR5Sy3re7EO5BJOsLmpf3SRe1V7Hayj/QKD8I2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785280681; c=relaxed/simple;
	bh=KR4iXBDsUdxCThw39w6TYatK7Sww5gDOqxDrgeycYJk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IMMrGIKbFoWAI30+tihfuHie7C4WfAnbhgfZKC9MMaFCUIWcwi4SNLsI75XjhvZMsuiAsh/VeY0rdZaWbk9+ILiRlJ2GeXmcywgSPIDlpTDPPTA6xZx4hqG2SW4Ca63+x/VbwN2PMUbOlkh9FV7Ftm0+zoFLPYQiPc9sr3fAa1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NkdrsLB7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NkdrsLB7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D61DD1F000E9;
	Tue, 28 Jul 2026 23:17:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785280680;
	bh=PmQmZWbeNMpBu7nD5r13js2ygroWf2HkZ78+aiPO0QY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=NkdrsLB7fxioKHUvv8L7Dd0gHn2g+qzZSdJAO13ShtEf1vsT5lO5cetKDcohbkRT0
	 DsuVm4rel0uFoJXpzT4X8rg0C7kDVbWQcvnLf3vTTvju1CmxEhKAPDhJhQeX5RcUVc
	 XKlJU1mHEn0jJpnAKe/xcYud8ISsQ30VvYJonGcSV7iEEHDenhZxVC+DtAfx8eXSip
	 Xsv4E7cPoyttCGHWZzDjQ5FYx96gAQ3wGAfA8Av0QaSG3BbcMJ+o6dnQyQxVa1pTFC
	 qZFyiWZ05Xsoyl39MzMve/J5GceXPl6V080b473ijXKFVzLLigp/ZMA3dJxar1OJSR
	 0bpxlouRQc0GA==
Date: Tue, 28 Jul 2026 16:17:59 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Rao, Nikhil" <nikhirao@amd.com>
Cc: netdev@vger.kernel.org, Brett Creeley <brett.creeley@amd.com>, Eric
 Joyner <eric.joyner@amd.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Jacob Keller <jacob.e.keller@intel.com>, Simon
 Horman <horms@kernel.org>, Vamsi Atluri <Vamsi.Atluri@amd.com>, "Nikhil P.
 Rao" <nikhil.rao@amd.com>
Subject: Re: [PATCH net-next v10 0/6] pds_core: Add PLDM firmware update and
 host backed memory support
Message-ID: <20260728161759.65d0bf76@kernel.org>
In-Reply-To: <50a63b4b-ba5e-4acf-bda8-5aa488c81794@amd.com>
References: <20260728-upstream_v8-v10-0-46dafbd74571@amd.com>
	<50a63b4b-ba5e-4acf-bda8-5aa488c81794@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 28 Jul 2026 15:52:55 -0700 Rao, Nikhil wrote:
> Self-NAK for v10 -- per-component update is broken.
> 
> Patch 3 filters the package by a single device-side identifier
> (PLDMFW_UPDATE_MODE_SINGLE_COMPONENT), but the same component type can
> have different identifiers in the standard vs gold firmware packages, so
> that identifier may be absent from the package and the update fails with
> -ENOENT.
> 
> I will send a v11 that matches by component type against the
> package contents, as in earlier versions.

Thanks for the note. FWIW v10 never made it to the list?
v9 was still in patchwork so I tossed that out.
