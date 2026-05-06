Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 563DB3ED5A4;
	Wed,  6 May 2026 16:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778084383; cv=none; b=JHWljbFaDOUKdDIdxnaTLUxv9f+rFpnnP/HegzAAlcgBKiU4TtfzeKOZTaZXZ31qXOW7ADT+GbW/VG7EbvJRMPW9TDYL5DpgX9rtEn0U4GQ4aGYWpkAwRofTlNq8+ycgP8elr314QI3T4W9BWEf3Bg0C3Gx66/V6chqtouLyEkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778084383; c=relaxed/simple;
	bh=KxrJo9HIKQ5v92YrAXsTCL1iGTqmCBCRvaj4KwvmXX4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WtskTIcvvhAMMaz3Xpc5AbP8MeVoSVbjXXOT5uYs/P2FQ4xdzrM6rvhHvdd9z9RRlIhYlPG//1xT1b/fbCDrccujYVNE9pwvpaFTtFW29l1crByaq1GQsfOLM4rSsaRIlTVC6l7iIw2YP0r01t83/EdeEfyEtMWTjTaKsOwhBGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gc7UH9QK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gc7UH9QK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48872C2BCC7;
	Wed,  6 May 2026 16:19:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778084383;
	bh=KxrJo9HIKQ5v92YrAXsTCL1iGTqmCBCRvaj4KwvmXX4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gc7UH9QKKiLcURFRJRwTGZyyLw7gU6wb5avu6ND3MiT+BSfR66hKp+VCWkRZPYX+U
	 2UTp9kWOEccsYKdTLGAfQu5jgPQsXaVvn++UJE8dpSGJWOwK0aAfH5Ljtm6kT/aEst
	 PkANt6zGoghF5DxRhKFR4e4ssUuE5Qrg3A8iVwPDuRq0MGhtCU1BL1QvCKCsVx6gM/
	 qyaNj/+FnycTOm0qHnkFyvKvYEgcciQldNqwl+PCuPQ4v0VQb9SVXpO7rqQvHAmeL6
	 PyPLCrhQxhYQhr98ysrPYt/ljf15Hjn7SR7MecpwBcKYhTq05ZpFGkdws3iNy1ZM0w
	 q+MdIhMGDkPGg==
Date: Wed, 6 May 2026 17:19:38 +0100
From: Simon Horman <horms@kernel.org>
To: Satish Kharat <satishkh@cisco.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Sesidhar Baddela <sebaddel@cisco.com>,
	Breno Leitao <leitao@debian.org>
Subject: Re: [PATCH net-next v6 00/10] enic: SR-IOV V2 admin channel and MBOX
 protocol
Message-ID: <20260506161938.GS15617@horms.kernel.org>
References: <20260503-enic-sriov-v2-admin-channel-v2-v6-0-0af4fbc2d86d@cisco.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260503-enic-sriov-v2-admin-channel-v2-v6-0-0af4fbc2d86d@cisco.com>

On Sun, May 03, 2026 at 04:22:37AM -0700, Satish Kharat wrote:
> This series adds the admin channel infrastructure and mailbox (MBOX)
> protocol needed for V2 SR-IOV support in the enic driver.
> 
> The V2 SR-IOV design uses a direct PF-VF communication channel built on
> dedicated WQ/RQ/CQ hardware resources and an MSI-X interrupt.
> 
> Firmware capability and admin channel infrastructure (patches 1-4):
>   - Probe-time firmware feature check for V2 SR-IOV support
>   - Admin channel open/close, RQ buffer management, CQ service
>     with MSI-X interrupt and NAPI polling
> 
> MBOX protocol and VF enable (patches 5-10):
>   - MBOX message types, core send/receive, PF and VF handlers
>   - V2 SR-IOV enable wiring with admin channel setup
>   - V2 VF probe with admin channel and PF registration
> 
> Signed-off-by: Satish Kharat <satishkh@cisco.com>

Hi Satish,

There is are AI-generated reviews of this patch available at both
https://netdev-ai.bots.linux.dev/sashiko/ and https://sashiko.dev/
And it seems to me that some of the issues raised there do warrant
investigation. I'd appreciate it if you could do so with
a view to addressing any issues that are not pre-existing in v7.

...
