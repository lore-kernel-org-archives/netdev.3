Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFF91413D9C
	for <netdev@vger.kernel.org>; Fri, 15 May 2026 19:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778873399; cv=none; b=LTHUu0qcO3MvxLxLqDNPeDGrfe4bZxFW5/7nYVQ2u4ddnIA2SkFLKInYhj/vnzgoUJ6+txCGa4H+zBDGPybipd0unzmafulb7yN9k7VlkWKIj4Lcj+9/g5HvotOUgkZ4xJO4vdmbOBuhzMDhfWESmSCn5FQ6hcm5C/kog5x78Qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778873399; c=relaxed/simple;
	bh=2S/TiJJqmScwY2jPUxBtGE41co/LWT09Ij0hT28v8WI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Pt3xxP6fMsFMmEA1EJ45XmJZM5kevPKDLJizGkn99XMmhdt/3gE8BsvCeskgmdsuHRZ/fm8aAFV34YW5xDOaGA49I8jeu582F7Dpx7m+nEfHQHacNqxorzpONWB/ePELywAtB8vp6cHn7ByW4lYekK5EAVS8h6iSIT+01bpWZHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y9mcxaRt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y9mcxaRt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95859C2BCB3;
	Fri, 15 May 2026 19:29:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778873399;
	bh=2S/TiJJqmScwY2jPUxBtGE41co/LWT09Ij0hT28v8WI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Y9mcxaRt+OGDW7NOB6uFIzRKpkYdyktGguB4ezhRl2AODsfRlAQ2L1tIlKV3WndaL
	 lMKc3qB4r/LF5Jh4NWAeIqkQcMZxEwK3gc7qNSIgS5CQlTU3HAZy/xwA1MmeGUQgpX
	 Faxt8+xltcucapze9mtmU4AoYc9lE0hBWZdT3DxPq0O5AsJ7VNDeCmMsOsHVQw9peS
	 1nXC289/QR5vT5as/lCSTNuIQ08kW5rewgcxm5km4cjRUku+yxoZ2DVHVyQM7dtaC7
	 p0GERx2r9A76WHlJqyAz87GnainizCs4OfoooaeGdTPPzilN9Q8aTzQoTqPQQD7r8p
	 uYS4jHcotelGQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 197ED3930A06;
	Fri, 15 May 2026 19:30:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH iproute2-next 0/2] dpll: add pin operstate and fractional
 frequency offset to parent-device
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177887341263.127669.1029299613309497612.git-patchwork-notify@kernel.org>
Date: Fri, 15 May 2026 19:30:12 +0000
References: <20260513145115.174597-1-ivecera@redhat.com>
In-Reply-To: <20260513145115.174597-1-ivecera@redhat.com>
To: Ivan Vecera <ivecera@redhat.com>
Cc: netdev@vger.kernel.org, poros@redhat.com, dsahern@kernel.org,
 stephen@networkplumber.org

Hello:

This series was applied to iproute2/iproute2-next.git (main)
by David Ahern <dsahern@kernel.org>:

On Wed, 13 May 2026 16:51:13 +0200 you wrote:
> Add support for two new pin-parent-device nested attributes:
> 
> Patch 1 adds pin operstate attribute support with filtering.
> Patch 2 adds fractional-frequency-offset (PPM/PPT) display in the
> parent-device context alongside the existing top-level attributes.
> 
> Ivan Vecera (2):
>   dpll: add pin operstate attribute support
>   dpll: add fractional-frequency-offset to parent-device
> 
> [...]

Here is the summary with links:
  - [iproute2-next,1/2] dpll: add pin operstate attribute support
    https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=55cbf807b378
  - [iproute2-next,2/2] dpll: add fractional-frequency-offset to parent-device
    https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=dde3f17bc311

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


