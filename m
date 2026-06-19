Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 798033BD643
	for <netdev@vger.kernel.org>; Fri, 19 Jun 2026 15:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.145.95.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781884605; cv=none; b=Kd8TLgSiLNofKTu/w7FHoThKeIiRbMagfEL+K8DRx/uq3l43IydAcGY4nKOhHi827XkMi/oG9GorH28lZ6TXfzZLtLFOO35LnrS/bW78OkNLV0aDExGaxyZRf+wuJqpxA0EUxY5bttYo04uFgwpPZIzVPySWPCb0WRHGbd/IyG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781884605; c=relaxed/simple;
	bh=pzzKtfaG7YGyh18+LJQ6NfX5mv4Fg7jnzEpEYIGQXYI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bkva2oD7UdCSkS4qOmKNfyjSCP3V9i4E0wat8FveXEdtkhxG3SV8SRrBOPvx9Znnrn7vCVMydVcn2QtTUAh5Hhjs6njPTHXGW3kgc5IDluIQBduI65XoM8YHIt7NPqGY7mPPELAZS5EABS3cb520+BPJpQPqZZbkZfBfwHBoJP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=toke.dk; spf=pass smtp.mailfrom=toke.dk; arc=none smtp.client-ip=45.145.95.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=toke.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toke.dk
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
Authentication-Results: mail.toke.dk; dkim=none
To: wireguard@lists.zx2c4.com
Cc: netdev@vger.kernel.org
Subject: Wireguard head of line blocking when CPUs saturate
Date: Fri, 19 Jun 2026 17:56:34 +0200
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <874iiyfrrh.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hey everyone

I'm running Wireguard on my main gateway, which is a not-super-high
powered ARM box with eight cores (based on the NXP LS1088A SoC). The box
does, however, also have eight hardware queues for its networking, which
means regular network traffic can be spread nicely across the cores.

However, the per-core performance is limited, making it pretty trivial
to saturate a single core by just running a fat TCP flow through it. And
when this happens, Wireguard traffic just... stalls. I.e., no traffic
gets through the Wireguard interface until the (unrelated) flow
saturating one of the cores subsides.

I suspect what happens is that Wireguard spreads out traffic to all
cores for encryption, but has to wait for the respective CPUs to finish
encrypting the packets in order before they can actually be transmitted.
And because one CPU is now suddenly saturated in softirq context, the
Wireguard work queue never gets a chance to run on that CPU, stalling TX
progress for the Wireguard device entirely.

I'm sending this message to (a) see if anyone else is seeing the same
kind of stalling, and (b) to get input on whether the explanation
outlined above seems plausible. And, in the case of affirmative answers
to both (a) and (b), to hopefully start a discussion on what to do about
this :)

-Toke
