Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794333207;
	b=svGuYVVsPFWgXLBGzXxKLf96abK6akcMD6SK5JVfs99nSHYLzjyd+Bs4hwi/uXHOrmf/
	 O/jJWmrydmuBXk+TYnkuyVTDKqmx8IIJ5kNh5mBTOaCOMkI3xMnkh3zdVBkH5dLDLr6Xc
	 REgtoGAno/vQgwVs/9aZ7P5JAzjJBtH2Uu6pW3wDhbG7KB8sEd1ejYU1F+f+0NKEjIBDn
	 jvP99Ea8S8hFc8MXA6f/Ukoz1zOXZxkSPZUH7Dww54su0lFWreoSdMaCtNYdQ/VCUzllG
	 gORJFUlFIz5P6UrUBt2/C1CdRGO3LOKRjN0YcpfsmB2wpZNWbNBorWZa8FtQNhSVI3g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794333207;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=ebrgguzYZNPO98ahlAUGmK5SoDtGwXJz8Q3pxsxvEgw=;
	b=Jmhe+y/BBx7wKErlfOZJjg4b1WjAQkWnaCGUvtJflfDxJ9+syt/grBor0X3K7HZxUCCh
	 vG8n0BEn4hhROxZ8epyqhF3+pqZ4pBUa9X6wtBYpFz4QrPNy6Xi/5Xb24hysJgFVuzy+9
	 m+YUfsRJ4p1k6y/jJ8iTbtEgfvT3YV9WFLGZvGZ3qkJIkI4Nup74s7fCSf44WVy4lSm5h
	 6/VR/zlLkcR9pYO+ZHiR4+BPokIwH8f7/jUSrw0GuJNcz+A4NCr60XV1RMcnV9eZdqcn3
	 5AKSafWpOH5PLWG4rajnluY+Yeq21DAaaMh4+lUTx7G/e59kTIADCWl1YclYUaoU8/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Rpi8Epj2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B850860A262E;
	Tue, 10 Nov 2026 17:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Rpi8Epj2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CD211F008A6;
	Tue, 10 Nov 2026 17:53:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794333206;
	bh=ebrgguzYZNPO98ahlAUGmK5SoDtGwXJz8Q3pxsxvEgw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Rpi8Epj2hAbMGS9noZ90k0oah0cdappeJZcbQPqArf6F1P6oyjOuB9F19VFsQBRqI
	 BTDRBmrLMRK59Px5MifpXTi8+0nYI9q+6dud24HN6qd9SBTEYVCJB8VRdrioJdL3/J
	 m2TB8nqYGRQ8s+VhX2kSTnU6PP8CFdF2STZur3jU5W5CT1U9wYVnGBV6WS9AvinRf9
	 5iE0W4OQsMw7Nl3GYZnFsrHZZoOveKiMm5G0BqqOmxhegLnLSCRL7ok/Up0BuA3zGV
	 i6MhyM0WSzoHyek3oJXGyGAso/leIDGchY8lLvyzCsywGpY/hr6Qej17ir1eWmJdF5
	 X6HN1Av2KZCJQ==
Subject: Re: [PATCH net-next 05/10] dpll: convert dpll_lock to rwsem
From: netdev-bot+sashiko@kernel.org
To: ivecera@redhat.com
Cc: netdev@vger.kernel.org, vadim.fedorenko@linux.dev,
 arkadiusz.kubalewski@intel.com, jiri@resnulli.us, corbet@lwn.net,
 skhan@linuxfoundation.org, rdunlap@infradead.org, min.li@microchip.com,
 anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, richardcochran@gmail.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, grzegorz.nitka@intel.com,
 karol.kolacinski@intel.com, saeedm@nvidia.com, tariqt@nvidia.com,
 poros@redhat.com
Date: Tue, 10 Nov 2026 17:53:24 +0000
Message-ID: <179433320479.994134.13826920591104367019@kernel.org>
In-Reply-To: <20261106121005.1327603-6-ivecera@redhat.com>
References: <20261106121005.1327603-6-ivecera@redhat.com>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] This patch turns dpll_lock from a mutex into an rwsem.

--

dpll: convert dpll_lock to rwsem

This commit converts dpll_lock from a mutex to an rwsem. Core functions
that change the topology take it for write. Netlink requests, dump parts
and change notifications take it for read, so callbacks of different
domains can run concurrently.

> diff --git a/drivers/dpll/dpll_core.c b/drivers/dpll/dpll_core.c
> index dd09f52817099..8eb7468234315 100644
> --- a/drivers/dpll/dpll_core.c
> +++ b/drivers/dpll/dpll_core.c
> @@ -19,8 +19,12 @@
>  #include "dpll_core.h"
>  #include "dpll_netlink.h"
>  
> -/* Mutex lock to protect DPLL subsystem devices and pins */
> -DEFINE_MUTEX(dpll_lock);
> +/* Protects the topology and lifetime of DPLL devices and pins. Taken for write
> + * to change them and for read for the whole netlink request, part of a dump or
> + * change notification that uses them. Driver callbacks are serialized by domain
> + * locks, which are only taken under this lock.
> + */
> +DECLARE_RWSEM(dpll_lock);

[Severity: Low]
Should the assertions in dpll_domain_get() and dpll_domain_put() be changed
to lockdep_assert_held_write() along with this conversion?

Both helpers still use the plain form:

drivers/dpll/dpll_core.c:dpll_domain_get() {
	lockdep_assert_held(&dpll_lock);

	xa_for_each(&dpll_domain_xa, i, domain) {
		if (domain->clock_id == clock_id && domain->module == module) {
			refcount_inc(&domain->refcount);
			return domain;
		}
	}
	...
	ret = xa_alloc(&dpll_domain_xa, &domain->id, domain, xa_limit_32b,
		       GFP_KERNEL);
	...
}

drivers/dpll/dpll_core.c:dpll_domain_put() {
	lockdep_assert_held(&dpll_lock);

	if (refcount_dec_and_test(&domain->refcount)) {
		xa_erase(&dpll_domain_xa, domain->id);
		mutex_destroy(&domain->lock);
		kfree(domain);
	}
}

On the old mutex, lockdep_assert_held() checked for exclusive ownership. On
an rwsem it also passes when only the read lock is held.

Every current caller holds dpll_lock for write: dpll_device_get() and
dpll_pin_get() via the alloc helpers, and dpll_device_put(), dpll_pin_put()
and the register/unregister paths via the __put helpers. So this is not a
runtime problem today.

However, the read-side holders added here (dpll_pre_doit(),
dpll_pin_pre_doit(), the dumpits, dpll_device_change_ntf() and
dpll_pin_change_ntf()) can now run concurrently. If one of them reached a
domain lookup-or-create, or a final put, lockdep would no longer warn about
the race on dpll_domain_xa or on the domain refcount.

call_dpll_notifiers() can keep the plain lockdep_assert_held(), because it
legitimately runs under the read lock.

These assertions are still unchanged at the end of the series.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261106121005.1327603-1-ivecera%40redhat.com
