Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6725C330B07
	for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 23:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782863018; cv=none; b=ZJ1E98O88tBKcqWHcS7/MzeoJKohr4ByEYYnlQsWfEfPZ7m834DKgKyomAg0HOjQpBHTOCFXeQNiA7XgUoqzPnXHFJoYNMA43NJozdLAWDuxH6LU9JNRMXjW1hz5qy+hAQPItl+VRZ39bbR2kbpebdpTyR5KSNzuITgx6KbvvGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782863018; c=relaxed/simple;
	bh=uLkcBORwX/En4LH3Ln9K9b1Xmin/83LIRKrqFiSNz3Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LqEHKv4yvXGRbL358PiRhItnKWLiT2B75QzsJb88/HHPB67lAyRLAZLE5+bMaETVGiVldoedZDoyy21TzpuosvGx2MligoOc7FK3S1Qx2gxCNQulayuWeBFTOB68fiVwfn7o2qvvJTlhEwZqRCiLpMkYyaHLXCsfnZxjH4BLiMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FfqoVT4v; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FfqoVT4v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28BDB1F000E9;
	Tue, 30 Jun 2026 23:43:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782863017;
	bh=uLkcBORwX/En4LH3Ln9K9b1Xmin/83LIRKrqFiSNz3Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=FfqoVT4vU7+6hbTD4Vy7du7nemhTLuNKLmN1O/nUyvfMrXpdChflwgW4XXMmwNzgj
	 9t1ll/H8aNBjWnXaxuoUYL8gsYYK/pxtn4dLbSsOIqkFfFmeQ9xx5rK16RXpacclMF
	 NIr661tIJMW7LFayvAjnn071XdPD5NA1fhC/W127G3wkIVMphA89V4Guevdc6eUDxM
	 TS65/zJT4u7xqmIMEFWSAGJVrapclqHV+gE+cciNi5X3wVBVEdcWNDKWzHcV6nawM/
	 eNoHNfSxWDnhR6D4f66Gc77bSty3sxQ25y3WxEtjpxMfjCM3Mc2CYKxhbBrzb+QWcO
	 YJ763tPOqporQ==
Date: Tue, 30 Jun 2026 16:43:36 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Stanislav Fomichev <sdf.kernel@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com
Subject: Re: [PATCH net-next 6/6] net: document NETDEV_UNREGISTER unlocked
 rationale
Message-ID: <20260630164336.1350403f@kernel.org>
In-Reply-To: <20260630182129.1601784-7-sdf@fomichev.me>
References: <20260630182129.1601784-1-sdf@fomichev.me>
	<20260630182129.1601784-7-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 30 Jun 2026 11:21:29 -0700 Stanislav Fomichev wrote:
> +Many ``NETDEV_UNREGISTER`` handlers release their lowers with
> +``dev_close()``, which takes the instance lock itself. Holding
> +the lock across UNREGISTER would deadlock.
> +
> +Moving UNREGISTER under the lock is mechanical: switch those
> +callers to the ``netif_*()`` lock-held variants. Deferred to
> +limit churn.

Not following TBH. Let's say there's a UNREGISTER ntf for eth0.
Are you saying that eg. vlan which closes their own vlan0 devices
on top of eth0 needs to be switched to netif_ ? That wouldn't make
sense since the notification is holding netdev_lock(eth0) and
we're talking about netif_close(vlan0)?

Doing anything with the device that is sending the UNREGISTER
sounds odd, since it's going away..
