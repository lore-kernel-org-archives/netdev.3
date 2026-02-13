Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7C3E214204
	for <netdev@vger.kernel.org>; Fri, 13 Feb 2026 01:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770947526; cv=none; b=JGpCPn8hrSY58i9EyuzZ83GYi3ylQincitMxDwQZWN44M+I6p8MlbpldoYqJan2uem/SbXjs8iBrNuw1FqW7U3lIaRhxr9PvvztZV8fXKeEGQUBVeoL6GDXI3t59qtd7zYC7cR1zvD6QT3plpLIldOrP2gPoUfuvdn6Ik7OHKR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770947526; c=relaxed/simple;
	bh=gSq9SN/QGb4zuDM73pjz0wF96/gGTG4RHMLgmi3XhU8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RZMss2rHZzQwAe2OXt1w9D0GjWaWS8ylI4+/4bjjioUj4ljg4Kt51QYcfu5e+qs6wV4Utnv9BZQ49H/f64tB5d3QMtBYpO/vI2SWHsrnUOhl9dl3obXjhJN8Rp2Burmmuaa4v5vG21voBLkVPBq99B4EQ5nnL6fiVEcIX34z/BA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D6hpb4Ui; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D6hpb4Ui"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7FF1C4CEF7;
	Fri, 13 Feb 2026 01:52:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770947526;
	bh=gSq9SN/QGb4zuDM73pjz0wF96/gGTG4RHMLgmi3XhU8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=D6hpb4Ui8Q0PD5kt9NsNqfO+YfQIS0VwHXE9c9BAYhjISb1AhNsJpPEjUOtoNaeK7
	 Kx4PEcyKIPiyjm5CLcmEV/OYQhGv+pyzeAEu4pgQKboR9jxSIzLutp7GC1P3VTAi8f
	 LIiYrrOkt6EbNSC46HSWatcDsgQ1Qt9OA+KW7NkCvPJxg5iYariht+q3+Fy5zdQPRQ
	 ML8kPrPU8knJbH1HE5iqgwYQ7Bg4A5VG5IJKAz7FfyR47cipXfxEsf7gZQJa31FU6i
	 IGGqUr8cW+WYrCeSfmXwCjBfODJ2wmYUMij21k4KZ9eoxdwhhSKZ17LCL9SZdPGGTI
	 b7KIkd0YMVd+w==
Date: Thu, 12 Feb 2026 17:52:04 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Pavan Chebbi <pavan.chebbi@broadcom.com>
Cc: andrew+netdev@lunn.ch, andrew.gospodarek@broadcom.com,
 bobbyeshleman@gmail.com, davem@davemloft.net, edumazet@google.com,
 michael.chan@broadcom.com, netdev@vger.kernel.org, pabeni@redhat.com
Subject: Re: [PATCH 1/1] Re: [PATCH net v2 4/4] selftests: drv-net: rss_ctx:
 test RSS contexts persist after ifdown/up
Message-ID: <20260212175204.5b467f67@kernel.org>
In-Reply-To: <20260212081250.4088970-1-pavan.chebbi@broadcom.com>
References: <20260211085822.184f85c2@kernel.org>
	<20260212081250.4088970-1-pavan.chebbi@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 12 Feb 2026 00:12:50 -0800 Pavan Chebbi wrote:
> +    if not pre_down:
> +        ip(f"link set dev {cfg.ifname} down")
> +    ifup.exec()
> +
> +    wait_file(f"/sys/class/net/{cfg.ifname}/carrier",
> +        lambda x: x.strip() == "1", deadline=20)
> +
> +    remote_addr = cfg.remote_addr_v[cfg.addr_ipver]

I don't see anything wrong here :(

The diff I shared to re-open the carrier file instead of using seek()
doesn't make a difference?

If it doesn't please use the version you shared here, even if it's
unstable right now. I'll try to find the time to investigate what's
wrong with the test infra. Better that than accumulating workarounds.
