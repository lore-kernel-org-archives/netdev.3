Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793056812;
	b=1XtsnU9PBOG8rxkARXGJLJYaWBfve9LDwhgmFr4DDahlml4RIaN/Xgv1ZN9E3tbT61BX
	 2vsS4kWV/CdWj4b1IHysktmopjPTntyTDZB8csqJyBtLOPIWagruVSltgQ2kPlzNIpEiK
	 KYOJ9Gm19Lx7iW4g35mTnqR+ym38ptOkHyY2iAzCSbuyaP6ldRq1qtIpPLJ3l5NueLDh+
	 Q5dsTOs2DrfOs/aWlQY4TVIrukmds/USK0PaGpREdNz1iGYYxXkc1i8n2fj7qU7RdpxU3
	 CI0khqtKmDbE1plzjL1pB6VFU/gpYIGrse//nj1G4392wh4XrNRuc+NaHQrX+sEVB6g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793056812;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=qK8orpGRHyt5JGdpBcDNln9vD5jTuQ7vbz/Adt8JaA4=;
	b=OOOmBHipi+74MdEOZQi3SoLR+J/EXgNPbqM5Ce6NJnvKhhSDS2kS9GRqn1oYWH3j1T9k
	 Mh1Dspqp7OFK6gfKZh69qeb04SXfICPaYbtflGNjdoHGajnQ/fIofPmYVwhlwithgJoFs
	 3aZGx/g0cKeVDTtU61hZsQoLGh8RQab0zKBYfzA2Qbm9KG5b3HuIq1nHCv+d4X4dPTv0E
	 KeD2VB5rTOAxawsNe3wcj8oQK5gCNVb41foNuYPjXkQHH9rAbG5EpC6oRXtaPfl/MhNJH
	 1V/dUf4+DSm8np9rPtKDs3RnELcnQMZXKMFSGAcu1glrs59J/fchgL4urHKJfEsh8ug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DVWQcDdM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBF83606A31D;
	Mon, 26 Oct 2026 23:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DVWQcDdM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C898A1F01829;
	Mon, 26 Oct 2026 23:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793056806;
	bh=qK8orpGRHyt5JGdpBcDNln9vD5jTuQ7vbz/Adt8JaA4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=DVWQcDdMfVqS7suofjXK2rHjn0rdjtyg8P382+vW6a66vRkkg5GCPBvDdEjcb62Eu
	 3W6x9gnsHrDjIbWfSvhB5TZEbuYyzq3G8didoSKTNoGLkCwek4oqe3wceZf2YO196D
	 Ms0Y9FUm0MtZu/h355nHnYpOuZt5393cLzSy873Ik1K0TTDYyJqhW7RTekxgaplkbu
	 9aJl3BuwVBSMwT7zb8SkXT6Q5Wa853VokviulNj1NTHMnK9Cbzx3BxD1hJVDgxpH5L
	 sj4WkhZKvcx6UJu2eMJyVtRDR5w5UZr61cRcXymBsbzS5MEEmgLCiH/69Qex1hPlHB
	 M89C8aEna+5Ig==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id BE4D13AA80F0;
	Mon, 26 Oct 2026 23:20:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v4] net: usb: lan78xx: avoid NULL PHY dereference in
 WoL
 setup
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179305680557.3450824.4724998894519023097.git-patchwork-notify@kernel.org>
Date: Mon, 26 Oct 2026 23:20:05 +0000
References: <20261020201537.2465655-1-prashantsengar25031@gmail.com>
In-Reply-To: <20261020201537.2465655-1-prashantsengar25031@gmail.com>
To: Prashant Sengar <prashantsengar25031@gmail.com>
Cc: netdev@vger.kernel.org, Thangaraj.S@microchip.com,
 UNGLinuxDriver@microchip.com, andrew+netdev@lunn.ch,
 linux-usb@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 21 Oct 2026 01:45:37 +0530 you wrote:
> LAN7801 supports fixed-link configurations without an attached PHY.
> However, lan78xx_set_wol() unconditionally passes netdev->phydev
> to phy_ethtool_set_wol(), causing a NULL pointer dereference when
> a userspace WoL request reaches this path.
> 
> Report no WoL capabilities when no PHY is attached, and return
> -EOPNOTSUPP from lan78xx_set_wol() before modifying the wakeup
> configuration. Keep the existing phylib WoL handling for devices
> with an attached PHY.
> 
> [...]

Here is the summary with links:
  - [net,v4] net: usb: lan78xx: avoid NULL PHY dereference in WoL setup
    https://git.kernel.org/netdev/net/c/dacb77e32e2b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


