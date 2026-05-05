Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 864DE3D410E;
	Tue,  5 May 2026 12:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777985461; cv=none; b=IObMogH05TQiOy4uULNRbyj+VtmWinbzjA1bZS/DTRPmmDvTEVy0uXLZovsU8QzR7M/nqaJs0vgidsQPmU+WsotQ3dgZFFB6wtV6ZvzvCD56zlK41DKwjPNjxMK6TfvtdDWjLdDVg337vccGTZw/y1FKAaWhGdq2uk8vvhkFhoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777985461; c=relaxed/simple;
	bh=pJNbmKHCaj8LcOcRSjtCvgXxOxTJESXcM4AFbuAbqrc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=mvXHZocX53zYY4GAzhItM5Aaijz2kvQWAPwW/OvG9MS8gq5sFK6zIdnfRqxwtmtfL/erzpT7QxJwvrML7m4/FGSJf2WkKPSqIE7LwtxHViM55RZZoIjx06VVrpgvZdNhEt3HBU/DzPbq+kJYQT6xzPEjDfNkum66kXUZR2+/WEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ebdyFDWE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ebdyFDWE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4483DC2BCB4;
	Tue,  5 May 2026 12:51:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777985461;
	bh=pJNbmKHCaj8LcOcRSjtCvgXxOxTJESXcM4AFbuAbqrc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ebdyFDWEMWhRBhPQA5a3Bz6R16ViMLFMx8UN7G+t0/Z0lCCRc2eJ0K+AtE5Bt1Vpj
	 jbcYeqjLehbyNkDwdaAhaR8rTFhsgdi3QVVX1HJW7IZ6KQ3pMlSFDKWbEvaHmgptff
	 Kp0vuwgksScEZ0/yRj6iEiTbjZ/8TWbo6+QFN7g77MZ797GUxovd2CXOvRwsPoPf/y
	 VesTXnMHFlbO2wSADC1sQ/vScYXY5noyQWymhgERFMvzhMYmq22Xce7FYqgFah09/f
	 +qCmbRtz66STtsTzJTr+8WIDd4XT6/ee87QtRRVycp8syaVa9L3HxHHIvRJSLmfXEw
	 M3Juawyf/qZJQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02D183930229;
	Tue,  5 May 2026 12:50:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/3] first series for xpcs based rsfec
 configuration
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177798541179.1614648.4121624195025939421.git-patchwork-notify@kernel.org>
Date: Tue, 05 May 2026 12:50:11 +0000
References: <20260430150802.3521-1-mike.marciniszyn@gmail.com>
In-Reply-To: <20260430150802.3521-1-mike.marciniszyn@gmail.com>
To: Mike Marciniszyn <mike.marciniszyn@gmail.com>
Cc: alexanderduyck@fb.com, kuba@kernel.org, kernel-team@meta.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, hkallweit1@gmail.com, linux@armlinux.org.uk,
 jacob.e.keller@intel.com, mohsin.bashr@gmail.com, lee@trager.us,
 andrew@lunn.ch, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu, 30 Apr 2026 11:07:59 -0400 you wrote:
> From: "Mike Marciniszyn (Meta)" <mike.marciniszyn@gmail.com>
> 
> The series:
> - Fixes an addr validation error
> - Adds MDIO defines associated with RS-FEC
> - consolidates the handling of the boilerplat ID registers
>   into a routine to report id'ish registers and reduces the lines
>   of code across the entire set of c45 routines.
> - adds PMA read/write routines
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/3] net: mdio: Add support for RSFEC Control register for PMA
    https://git.kernel.org/netdev/net-next/c/ca283942e5b9
  - [net-next,v2,2/3] net: eth: fbnic: Consolidate register reads for ids and devs
    (no matching commit)
  - [net-next,v2,3/3] net: eth: fbnic: Add pma read and write access
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


