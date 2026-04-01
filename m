Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37135346AFB;
	Wed,  1 Apr 2026 03:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775012737; cv=none; b=FixbSD6Cw4SSw5FxLpWRZdVbkKIyUWN5gU/JRIQ4X2i3zX7a1NLa7Zoe9K8s0Xn7Oc7jdFN5TAp2lE65himBwAfpRUoafZiWNwnhnLhyeVw36M7kAKUBjnmw23b1/xXcK6Anwo9mJgGtyY1exuA4zE2eHhZQP2+6MZWJY70ou7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775012737; c=relaxed/simple;
	bh=gg1to1+5RzdPbkCG2pYIoC3T4U0q0nbWGexAVp7maFM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M4YRrlCy5a6xDENeiaCII+Jm+e3mwEqK4Yw8eTptkVSIxQ8ouD69FzhRYJWtG1sZBO+4bEnIyO1ZYmtTGnUwRjwV2vqDgmJcH6ekLrX7PwzHNo06Lzw3pemAgvZy6rkx5YeJpkURgbv1r5oMnFbQWCNvzwkuAhj1Oyg5PaXkbbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z4y1ftgp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z4y1ftgp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D871FC19423;
	Wed,  1 Apr 2026 03:05:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775012736;
	bh=gg1to1+5RzdPbkCG2pYIoC3T4U0q0nbWGexAVp7maFM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Z4y1ftgpzhkCyCiU3/KpVR7TKGJ/XYFfhTe3u/eiBVISj0byLdenBHoWTKQ3WXEbX
	 GDNtgmpWJz6NNVTJ67r1UPq7PzdGSf7Va8hIKt+fAMeCjGjGxcvEmTGhG4Y9HAX5zF
	 dwBbX7XWpb6aozJlTU6YmUQDc7eA8a9+g61wOmrtQ+ysPdC9mazG6aI0wdzPWUGVpC
	 /KLXgElg4pwKIca48YHS6DjgIc1kT5k2aAWtCKt62E3CgXFGA++ZX4qVuHTclkW3sG
	 NdlriySQxx5M0+2saUUo7nYSsNY1nYDpTc5/sjFTWsZYQ4dxJjfVWLooWZqCzJtxde
	 AUaJJeR2LnSFg==
Date: Tue, 31 Mar 2026 20:05:35 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ivan Vecera <ivecera@redhat.com>
Cc: netdev@vger.kernel.org, Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>, Jiri Pirko
 <jiri@resnulli.us>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
 <skhan@linuxfoundation.org>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Donald Hunter <donald.hunter@gmail.com>,
 Prathosh Satish <Prathosh.Satish@microchip.com>, Petr Oros
 <poros@redhat.com>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 1/3] dpll: add frequency monitoring to
 netlink spec
Message-ID: <20260331200535.6a73e940@kernel.org>
In-Reply-To: <20260330105505.715099-2-ivecera@redhat.com>
References: <20260330105505.715099-1-ivecera@redhat.com>
	<20260330105505.715099-2-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 30 Mar 2026 12:55:03 +0200 Ivan Vecera wrote:
> Add DPLL_A_FREQUENCY_MONITOR device attribute to allow control over
> the frequency monitor feature. The attribute uses the existing
> dpll_feature_state enum (enable/disable) and is present in both
> device-get reply and device-set request.
> 
> Add DPLL_A_PIN_MEASURED_FREQUENCY pin attribute to expose the measured
> input frequency in Hz. The attribute is present in the pin-get reply.


> +      -
> +        name: frequency-monitor
> +        type: u32
> +        enum: feature-state
> +        doc: Receive or request state of frequency monitor feature.

reads a bit clunkily - how about:

	Current or desired state of the frequency monitor feature.

?

> +          If enabled, dpll device shall measure all currently available
> +          inputs for their actual input frequency.
>    -
>      name: pin
>      enum-name: dpll_a_pin
> @@ -456,6 +463,13 @@ attribute-sets:
>            Value is in PPT (parts per trillion, 10^-12).
>            Note: This attribute provides higher resolution than the standard
>            fractional-frequency-offset (which is in PPM).
> +      -
> +        name: measured-frequency
> +        type: u64
> +        doc: |
> +          The measured frequency of the input pin in Hz.
> +          This is the actual frequency being received on the pin,
> +          as measured by the dpll device hardware.

If we make this a u64 should it be fixed point? Seems dubious that we'd
ever be able to measure >4Ghz frequencies, much more likely that we'd 
want sub-1 precision ? So let's say this is fixed point 34.30 ?
