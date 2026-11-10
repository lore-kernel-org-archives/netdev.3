Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794333205;
	b=yqxNMgDGfSePGV9DA1X34goilgZ2wixMUV0jC434/FE6yfd/4Abc82fNl2TRXfMb/1NG
	 rKIdZnu0r1Z/gOIUIo3MOsuvUadPCfURMaba/rRiKDk3uhGx+Eca3aa5GCKMY5cQyryoS
	 LsnlmD5CsNbuw9ot/m13HmQOFrbfPXFYQapsW76uB7LJDX2RbsXpVE2Sfos/eL6YIQx1X
	 6vVKAazz0/0xBFtmiHdsKhvjoH/q5Y6HIdry3DzOcHD1P7PZfiod1813yWDcRs+EW1Bti
	 YTslw8IrMhKAbKnOW3iF3gKpcto2qCtSQZgGwADO1EzL8FNjeHgmuF6s7bnouNV93Gw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794333205;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=ab568wwvPbStL1asXtzTrQ7hg5GKYsBt/+WIszdq9+A=;
	b=auvAXNspw3kqXUOaPb6+eiZKsUB7sdvTgL5WW4jIc/woHoArsdXnFzE1YZGFCwM9kRVV
	 fHKonuYNHISv6hKhxeNg42aQpF3htk8vFsMxie4KP54aL0EVfstKWs6EU4GARru0Z0Bf9
	 V2hXyyr17LNsBhr/I/G/XzN+Q7/yIDY83vnkwX8sJiYnXQKho0eHgIBCWj0y8atjwCOAi
	 e6FqBrmyvSDV2j8H4PWf3p6gglGbY2oTvQJx2rlgX0yGyKu9tl10BraphHxyO6r76Qrjr
	 +3tZkfEwZlv8wo8y8lAqd2Mh7YxtZBN4HOFhvu9ZTVuoCPyvCaWAbsMBEjJ+S+lCgYA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ruy9uac3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E81D1606A327;
	Tue, 10 Nov 2026 17:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ruy9uac3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F0991F008A2;
	Tue, 10 Nov 2026 17:53:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794333204;
	bh=ab568wwvPbStL1asXtzTrQ7hg5GKYsBt/+WIszdq9+A=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Ruy9uac35FNa/e9uIlj/CahwSyVHIhN0Ge8tMfWIqfdFhU3vJHMU1iZafxswC2obp
	 N0isaOWEzLOhw3RCcWyrbI+izQTsqlALDv/G+/rlZNJdGj3EP1fYMzV8XwYyVicf3s
	 DE+r414viPj+mUlqRj/5LlE+SAJ5Ac8yStGxLSJO/VlgiJxlKQDUHMq7qN6jNObrTo
	 u23b1GglHX+rTp7fdfsyMGD9P1pv7w0JU6Ga8wzjVK1ZliyY5OwuDbGywnpM+gIuoM
	 Ai6p5y2qWK+LmV6W0FJ/NBtw+yYQIL/QgBj9ReYwpr2f55trxItPQhi9Ee2eooI8Xq
	 fqhEH+KU0CYVg==
Subject: Re: [PATCH net-next 03/10] dpll: add domain object
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
Date: Tue, 10 Nov 2026 17:53:22 +0000
Message-ID: <179433320288.994134.11961533455589849486@kernel.org>
In-Reply-To: <20261106121005.1327603-4-ivecera@redhat.com>
References: <20261106121005.1327603-4-ivecera@redhat.com>
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

- [Low] The comment on `lock` in the new struct dpll_domain
  (drivers/dpll/dpll_core.h) says it "Serializes the driver callbacks of…

--

dpll: add domain object

This commit adds struct dpll_domain, which groups all dpll devices and
pins created with the same (module, clock_id) pair. Domains are
refcounted, stored in an xarray and freed along with their last object.
It prepares for serializing driver callbacks per driver instance instead
of under the global dpll_lock, and states no functional change.

> diff --git a/drivers/dpll/dpll_core.h b/drivers/dpll/dpll_core.h
> index da8a369556ed1..6705e81bc11de 100644
> --- a/drivers/dpll/dpll_core.h
> +++ b/drivers/dpll/dpll_core.h

[ ... ]

> +struct dpll_domain {
> +	u32 id;
> +	u64 clock_id;
> +	struct module *module;
> +	refcount_t refcount;
> +	/* Serializes the driver callbacks of all DPLL devices and pins
> +	 * that share one (module, clock_id) pair.
> +	 */
> +	struct mutex lock;

[Severity: Low]
This isn't a bug, but is this comment accurate at this point in the
series?

In this commit, domain->lock is only set up and torn down:
dpll_domain_get() calls mutex_init(), and its error path and
dpll_domain_put() call mutex_destroy(). Nothing acquires it, so driver
callbacks are still serialized only by the global dpll_lock.

The later patch "dpll: take domain locks around driver callbacks" adds
the mutex_lock() calls on dpll->domain->lock and pin->domain->lock that
make the comment true. So the mismatch exists only in this intermediate
commit.

Could the comment say the lock will serialize the callbacks, or could it
be added in the patch that starts taking the lock?

> +};

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261106121005.1327603-1-ivecera%40redhat.com
