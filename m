Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C76C13859E2;
	Thu, 15 Oct 2026 22:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792102929; cv=none; b=Xpka/53t96jmnKlgeDisZ2pcVLTCBmQ/DguvBwGwJWfMpLWpupx23/mVvlZYobqJSH9DErFDDCxtEbfLmA+eK8a9Oot88n6W7Ve8d7yspmbAOjVNY+LfRBAF3f2vmHpzNRfT3VpDd5vtodhibwa1bGlRHLACk/odlH8dNwoIuQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792102929; c=relaxed/simple;
	bh=CGF6gjYDx0HWXrMYtaZcHl4A6c9k/zsBHEN7ag7RRZI=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ik32XcD9Gr9YJ2KoeswAn1DZPJ4V7qd7LXAf/u1MXq2CDRd5BDYlHK+V5Zg7Shr95OHllDX4ibtGG5zNPndkB0xoPIbO5jrLwhO+EbDF6riwHQfv2QSLe41lNxP1cQ+MORBcsNtLIgVqQoD4Ka6n5vHXVt56Xq/ftPdgy5BDglg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V0o0vib3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V0o0vib3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 037F21F000C5;
	Thu, 15 Oct 2026 22:22:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792102928;
	bh=fPD2nEI7t4cycmEl5v5zBx4KzV5gWyQpBBlGVu7uwtI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=V0o0vib3vbQa5MZ8ZSCvC/y/LSnkA+mykWmNgl9MARRXB2i9uHMSOd2CzNSQB4Qcb
	 e7dKxDzAfItIDTPxHS8RCi0hnOs3LAN5B3xm/EeW1PfJ6eLuMTcztt1g8Nr8xJsAcp
	 s3KazcxC1akZx3RDN5jWLsHlpkfx42Nql8ioGUuwNhes5zsjw6vg8q5jmjJ2hsTKE1
	 sDI4oO5Z/2BRUUeoBA+a8zp3CjVNkDJ0ShHM11+4r9CQHJhSQpB/ggRclR5yU1JYL4
	 XskbzBCahGGdNrFXrwZALuJkIbzyjJefJnxHccx2BtrPufnHkWWaCR1ZmGaWKcXkmK
	 gSUXagNMKoetw==
Subject:
 Re: [PATCH net v3 5/5] ptp: vclock: preserve missing hardware timestamps
From: netdev-bot+sashiko@kernel.org
To: james.hilliard1@gmail.com
Cc: netdev@vger.kernel.org, pabeni@redhat.com, kuba@kernel.org,
 richardcochran@gmail.com, andrew+netdev@lunn.ch, yangbo.lu@nxp.com,
 mlichvar@redhat.com, edumazet@kernel.org, davem@davemloft.net,
 linux-kernel@vger.kernel.org
Date: Thu, 15 Oct 2026 22:22:07 +0000
Message-ID: <179210292756.434549.32365876445256361@kernel.org>
In-Reply-To: <20261013-ptp-vclock-sampling-v3-5-d3ee4ea62fc6@gmail.com>
References: <20261013-ptp-vclock-sampling-v3-5-d3ee4ea62fc6@gmail.com>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The patch adds a new early return to ptp_convert_timestamp() in
  drivers/ptp/ptp_vclock.c: when the input hardware timestamp is zero…

--

ptp: vclock: preserve missing hardware timestamps

Socket timestamp delivery converts hardware timestamps to a vclock time
before it checks whether a hardware timestamp is present. With a zero
input, timecounter_cyc2time() can return a nonzero value. This patch
makes ptp_convert_timestamp() return 0 without converting when the input
timestamp is zero.

> diff --git a/drivers/ptp/ptp_vclock.c b/drivers/ptp/ptp_vclock.c
> index 6675466bc3074..4a62047f0ce0f 100644
> --- a/drivers/ptp/ptp_vclock.c
> +++ b/drivers/ptp/ptp_vclock.c
> @@ -307,6 +307,8 @@ ktime_t ptp_convert_timestamp(const ktime_t *hwtstamp, int vclock_index)
>  	u64 ns;
>  
>  	ns = ktime_to_ns(*hwtstamp);
> +	if (!ns)
> +		return 0;

[Severity: Low]

This isn't a bug, but should the kernel-doc for ptp_convert_timestamp()
in include/linux/ptp_clock_kernel.h be updated as well? It still says:

 * Returns: converted timestamp, or 0 on error.

The new early return gives 0 on a path that is not an error. It passes
through the "no hardware timestamp" case. After this patch, a 0 return
means either a failed lookup or conversion, or a zero @hwtstamp.

Both callers in net/socket.c already treat 0 as "no timestamp", so
nothing changes at runtime. A wording such as "converted timestamp, or 0
if @hwtstamp is zero or on error" would match the new behaviour.

>  
>  	srcu_idx = srcu_read_lock(&vclock_srcu);
>

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261013-ptp-vclock-sampling-v3-0-d3ee4ea62fc6%40gmail.com
