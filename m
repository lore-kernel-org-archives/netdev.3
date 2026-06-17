Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 763233B14B8;
	Wed, 17 Jun 2026 22:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781734067; cv=none; b=Qr6RTaT/C+4W+sFXq1DqjYvgmk1LECeI3iR8eQQluRrZRTgahHSB+RBdwL4duYKtzBlJDZBBMTj3KR/Hq9ljbIjb9UL3BDhuw3roCK+pwhjiq27kxB51Z6gqspabzNpOF8AZ1hCMeYm0sDyl0GfnoHBtp0nMHZ5KMsDB8/d6fpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781734067; c=relaxed/simple;
	bh=QD9+BuX8vNnlpmK7MBUF8BffYmSDp+kgIN1GCWUfQ4c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k4PkSoSFXIkf7geygyDP3b898ZXPygrC2mhuqUbGl7OZpTwKfSwghq/sEKNv955i9tEMlPrk2K8ozrjyL0SWTNcTdjgwGuUhbjdlVCnPWLoh8qZsJcdJdkKuQbhV2iHCzCF1mAKIiyQpttZrZFSnlCTU8wRMIj5eji4is4cbQ/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XNxowSn0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XNxowSn0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BE301F000E9;
	Wed, 17 Jun 2026 22:07:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781734066;
	bh=CqN76L0GmoGTlUxyqmYpYwkQVk5OIJLansyMs93EdPk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=XNxowSn0OJP7I2CIW2JV0Oo+0Rb+Kin3QNSOcQuHP6QKaSXwJYNG4kFgHdWzc6Kdf
	 2pVYVBMVbEft9I+hqRuLM45mXxtDKkIrE16UXxKkNjSPtiG0cNyVdWldzciE/3B/Lg
	 dxmDRcDjInvW5G/O+L5ZZ2G8zkczw4R31UbnwJ/UclDCiyAl0ng5d7bpd777pgunfq
	 wEI2dW2j+0XDGEpTVhUup+ZP8N7/EzprERi1gqb9r29KVHngQmWAiFWLOLK0y/EQo+
	 sQc92qNEXX27qZIhquXOuI/QZ49TFfmsRnXHvh5qclJjht0ry/VefZz5qfZQLLtCR2
	 qWca2TTAx2Y6A==
Date: Wed, 17 Jun 2026 15:07:44 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: <keguang.zhang@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 "Paolo Abeni" <pabeni@redhat.com>, Maxime Coquelin
 <mcoquelin.stm32@gmail.com>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, <linux-mips@vger.kernel.org>,
 <netdev@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
 <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] net: stmmac: loongson1: Use dev_err_probe()
Message-ID: <20260617150744.05756f0b@kernel.org>
In-Reply-To: <6b8db599-5bb2-47f9-ab53-a0b5141af2e5@intel.com>
References: <20260615-dwmac-loongson1-v1-1-cbcf5bc01d9b@gmail.com>
	<31630db0-85cb-421b-8ebe-bbae07521533@intel.com>
	<20260617135407.6ff54e27@kernel.org>
	<6b8db599-5bb2-47f9-ab53-a0b5141af2e5@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 17 Jun 2026 14:26:25 -0700 Jacob Keller wrote:
> It does claim that it has benefit since you get the error code emitted
> symbolically. But we have %pe for that. I wonder if dev_err_probe
> predates %pe?

I'd argue

  No of match data provided: -EINVAL

is more confusing than just:

  No of match data provided

the EINVAL is meaningless and hardcoded in this case?
