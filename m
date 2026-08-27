Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D410B37EFFB;
	Thu, 27 Aug 2026 16:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787848979; cv=none; b=sXezEpaKQ2C/YuB0FqsplisRc2VOU6WX1mfdc7BY03XvwcvaRxs2Xrys9Ku+0D4NfsPL1ch7bqcOQVDX4BvohIzQ5keb4ojB3397wUb58uCDfhizThXurj3UTTc6li/32EU26oQkd+nW+PAuUFkSecWp+TsU0IJov+cmZRC5OO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787848979; c=relaxed/simple;
	bh=fGI2MpVCodiuZVXvHnbYkTw2oowxTlHHdU8F4xi60p0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tpQKmUft0sGYlSynAOGla4vjqxZK8bH4gyCnALRD4gWp6Sev6VHoxR5gCuaRq+QFpJc+HPS8bufh1oIwvBa7DB1y4MGZrWPILKwykBK3Yr7cAvnX0HDqBFeY5YVoWqNcnCE9MyIn4qObJr1BffdP16P0NFeclMjRgJ7FUeSm5mE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bxu7og+F; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bxu7og+F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17C161F000E9;
	Thu, 27 Aug 2026 16:42:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787848978;
	bh=P1YoYWCEFcjtKC/P86efzHKVbvarMBWFO1WdX4/Sngk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Bxu7og+F94vw2jvWVNt+CwdBQHlA7cmlo8+w8Hlj9gSC+8oUzcXujR8vAno0WjTLg
	 xE/E0CkjQSDbUNHYa8QN04mv/gdbVewmBCX3AGbAhyBlARNTV6mnh8eeOkbKlc7iMb
	 yRDNCZJMEm0oMmvSlrBW3Ow4k/lt/j3VHXziTQ2dE1Lnwi5ZR0bKEMo2Jt4+Lp8wOs
	 st02cITr8XqMZCdZg1yN+aV1TkIH0Z9jqP05zhELjKnf1GjF/B3cyWEfh0dncTI3Jv
	 dkgybZHXJb2OS5PdtauaVc/KlSlNpyRECTLmjAnfwLwrDuOQvHLwkOGQjIZBJWSGeg
	 sF3GQQ7gKQ5wg==
Date: Thu, 27 Aug 2026 09:42:57 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Vikas Gupta <vikas.gupta@broadcom.com>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, bhargava.marreddy@broadcom.com,
 rahul-rg.gupta@broadcom.com, vsrama-krishna.nemani@broadcom.com,
 rajashekar.hudumula@broadcom.com, dharmender.garg@broadcom.com,
 ajit.khaparde@broadcom.com
Subject: Re: [PATCH net v2] bnge: add missing ndo_set_features
Message-ID: <20260827094257.610ece67@kernel.org>
In-Reply-To: <20260827161230.1724658-1-vikas.gupta@broadcom.com>
References: <20260827161230.1724658-1-vikas.gupta@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 27 Aug 2026 21:42:30 +0530 Vikas Gupta wrote:
> +	bnge_close_core(bn);
> +	bn->priv_flags = flags;
> +	bnge_set_ring_params(bd);
> +
> +	rc = bnge_open_core(bn);
> +	if (rc) {
> +		netdev_err(dev, "bnge_open_core err: %d\n", rc);
> +		bn->priv_flags = old_flags;
> +		bnge_set_ring_params(bd);
> +		netif_close(dev);

We have been requiring NIC reconfiguration to be resilient against
OOM conditions for years now. bnxt is even older so it got
grandfathered in, but bnge has to do it right. So we will reject
any patch that tries to close / reopen and hope for the best.

If you want a net fix - you should reflect current operation
of the driver - meaning make GRO-HW either forced on or forced off.
(Forced on by leaving it in the netdev->features but not in
->hw_features). Or reject changes while the device is UP
-- 
pw-bot: cr
