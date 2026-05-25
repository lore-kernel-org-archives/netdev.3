Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 824CA388396;
	Mon, 25 May 2026 20:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779739203; cv=none; b=FAnGCcryUAL2hAdVfY0+qq+YOFRAlMB9z/ZrBCBRr+u3mQhnGLjwjWtb49j2ucGaM2iAG9by3uv/MnwdDUT0P7i90Aun+WaAOPmhUcfpaJ3kzabLftVSQEPKobsU37CnSGTtvbyWDcTNt4Fsba1MKSQ90v7WHJx/Wh4nnJAsDdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779739203; c=relaxed/simple;
	bh=ZPFIPDzEcv9wCHFOa5+QxzXXniwaSfr0AReixAZV09E=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=usEL34abTgItwMMVJlO/P5tA3dD7BKlwo4WMtXpI40xIZEhu/Doa+y0J3Ue9ukqzYwv+a1gju1bVfJsb1wUiRRLXYRRo7kT3WpywGyY9nvbqmod+3YwNooMoKKugbrm5thch5DF6TJnPW8+xCP7mqbHFlPRek5WMAx0e6jrDkNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RhOSa7wu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RhOSa7wu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CBDB1F00A3A;
	Mon, 25 May 2026 20:00:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779739202;
	bh=1/oC8rZvSb0/58rjVfNg3qIosXAwNMulf1db0rnZnrs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=RhOSa7wu3zzCdSmYcgXeQfgPLGu2Ssydk1HMfETUvCErawiZ7DYS0OB+CaxCVTO5m
	 Va9zv+NYuwSwDbciB81ThJ/CbBlhPFwvLPtvKQtb+JNFGVuer1Yvx4U+foT0ZhraC8
	 CqXh9RbH/idDKBgRDI7WsDfc1b/WfJ9a8VfAy4FVPOxSFR2dCusSL9+ZGo5ZSIobre
	 o+Cwif+5lTFmQdK2vB4FhxwFuTqPEGFeO77HNPi/tszqnMtKFJXzioZb1/6g1wyu2S
	 AZ+mRwO9fBifYTntKFQn4layBHvaYNCN/+UNQbMTsitL1/zdEWbASa+8+87RakFxyk
	 1Zee27BimZKJg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 19BD4380AA76;
	Mon, 25 May 2026 20:00:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] macsec: fix replay protection at XPN lower-PN wrap
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177973920864.3098866.2633413254433514434.git-patchwork-notify@kernel.org>
Date: Mon, 25 May 2026 20:00:08 +0000
References: 
 <SYBPR01MB78813FD49E58F253B989F197AF012@SYBPR01MB7881.ausprd01.prod.outlook.com>
In-Reply-To: 
 <SYBPR01MB78813FD49E58F253B989F197AF012@SYBPR01MB7881.ausprd01.prod.outlook.com>
To: Junrui Luo <moonafterrain@outlook.com>
Cc: sd@queasysnail.net, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 mayflowerera@gmail.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 danisjiang@gmail.com, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 20 May 2026 11:47:55 +0800 you wrote:
> In macsec_post_decrypt(), when pn is U32_MAX, pn + 1 overflows u32 to 0
> and the first branch never fires. If next_pn_halves.lower is also in the
> upper half, pn_same_half(pn, lower) is true and the XPN else-if does not
> fire either, leaving next_pn_halves unchanged. An attacker that captures
> the legitimate frame carrying pn == 0xFFFFFFFF on an XPN association
> can then replay it indefinitely, since lowest_pn never rises above
> the captured pn and macsec_decrypt() reconstructs the same IV.
> 
> [...]

Here is the summary with links:
  - [net] macsec: fix replay protection at XPN lower-PN wrap
    https://git.kernel.org/netdev/net/c/e68842b33564

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


