Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794333212;
	b=bmGFqXh65PheQe86Pl5HREUmtvjqCuRM9Cp+z9YpJeZffs2jTrJa4YHcVta4zsAuHGXV
	 p4eB1Dmxsf23X+gEXVOVt24EABtsrZ2KVrWVjNNubCiAg03yn30bisnY1kVzib9WqN42F
	 sapnZPxPihF7bBLWc4LSHd7aCU9avTuz7VBBP7xx4YSQGZsHnMw4zM2Ta+l1f+q+NAEly
	 fPa/g6dFs2iHR/srPBG5EzYELySvbmgEHNn/3Z0JzkdYMWUiVx4sQlVr48U3TwCrQpMxp
	 9HqRhLEcJzFLb0miz7VV5OPbjGEk+00h25OOlquaxIniOCxbGTUqcV6G9cYwnVFFEEA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794333212;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=prM24RVAgH9/rVvP/UPAQ2Jyid3RkVoNiG2WeGLgs8I=;
	b=m9jBjFw74yIHLs8eZOIGqweZJK/sXj6GqF1yrklhJqX3t/oeyCFni2VAh49pC5IpIddL
	 Tye7n8xmmL/HNywRSz4MKkd3t95aRGaq0GaOkMJfWDFI5cpU1HktmO3Yp6DQpuLRlcX/A
	 xyc+5MYycGQAN6r9TsQsJdH9ajzEi9snPig6MnzZ7g9+rImEcxxt5kUptuA2HlSsZT4zI
	 XhH/O+rfZuOq7isN4o9dRWKqrLcL4ul6O7RzO8FOesfQVJYrFw7NXiY5UBmtSDNC4lBIa
	 +AxFF8sL59WHL8WQO6poplDzIgVMaDD9qKyFRZxtIqQJBHxY5QDvKgtQCJjeedkrz0g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Chjelwlj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C02D60A3832;
	Tue, 10 Nov 2026 17:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Chjelwlj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E887E1F0089F;
	Tue, 10 Nov 2026 17:53:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794333212;
	bh=prM24RVAgH9/rVvP/UPAQ2Jyid3RkVoNiG2WeGLgs8I=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ChjelwljJAkJ1/9aGT22N16FIq+Jf78o76D140u1tvzYzqM675Fahto8yBlaEvdJd
	 1Y9IJjlQlMkmfN5eo1N7GtynfgR7MmxEpbdr0ll1CA0ZIFrgysb2ApioDNYrYzq18w
	 UNo4DK3l8JONLlFUN6PWnNbyKQgZDKu+mxwt4R3UvIf1x3ogHnps46CPxQh0BaY8wB
	 34XZIJYyF6qgHIUpjSmojjQyDNdtay97TeYCTWhJHnAIXx01TZK91CCoLiG0LWezs/
	 vTmOrHWIth0FN5xPey5o2QLBH59p++jfYpPeduH2rGkOumAbFvLnBuXuW3SA9tb/H+
	 /75vSIjFyX3cA==
Subject: Re: [PATCH net-next 10/10] dpll: document locking rules
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
Date: Tue, 10 Nov 2026 17:53:30 +0000
Message-ID: <179433321053.994134.15233379643090486121@kernel.org>
In-Reply-To: <20261106121005.1327603-11-ivecera@redhat.com>
References: <20261106121005.1327603-11-ivecera@redhat.com>
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

- [Low] The new Locking section in Documentation/driver-api/dpll.rst
  covers three cases where a pin callback reaches private data owned by…
- [Low] The new driver rule in Documentation/driver-api/dpll.rst (lines
  716-718) says notifications for objects outside the callback's domain…

--

dpll: document locking rules

This commit adds a Locking section to the dpll driver API documentation.
The section describes the dpll_lock and per-domain lock levels, the domain
each driver callback runs under, and the rules drivers have to follow. It
also adds matching notes to the kernel-doc of dpll_pin_register() and
dpll_pin_on_pin_register().

> diff --git a/Documentation/driver-api/dpll.rst b/Documentation/driver-api/dpll.rst
> index 7c117ae37cc1b..40d5037ff3bb0 100644
> --- a/Documentation/driver-api/dpll.rst
> +++ b/Documentation/driver-api/dpll.rst
> @@ -675,6 +675,50 @@ In the error path we have to rewind every allocation in the reverse order:

[ ... ]

> +Callbacks of a dpll device run under the domain of the device. Callbacks of a
> +pin run under the domain of the pin, whichever driver registered them:
> +
> +- A driver registering a pin of another driver with its dpll device has these
> +  callbacks serialized with the driver that created the pin, not with the other
> +  callbacks of its device, so it has to protect the state they share by itself.
> +  A callback stuck in such a registration stops the domain of the pin.
> +- The parent pin of a pin registered with dpll_pin_on_pin_register() and its
> +  dpll devices can belong to another driver, so the callback must not
> +  dereference their private data.
> +- The frequency monitor belongs to the dpll device, so only callbacks of a pin
> +  of the same domain registered with dpll_pin_register() can include
> +  ``.measured_freq_get``.

[Severity: Low]
Should reference-sync pairs be in this list too?

dpll_pin_ref_sync_pair_add() only does an xa_insert() into
pin->ref_sync_pins. It never checks that pin->domain matches
ref_sync_pin->domain, so a pair can span two domains.

When the ref-sync callbacks run, only the domain lock of the pin is held,
but they get the private data of the paired pin:

drivers/dpll/dpll_netlink.c:dpll_msg_add_pin_ref_sync() {
    ...
	ref_sync_pin_priv = dpll_pin_on_dpll_priv(dpll, ref_sync_pin);
    ...
	ret = ops->ref_sync_get(pin, pin_priv, ref_sync_pin,
				ref_sync_pin_priv, &state, extack);
    ...
}

dpll_pin_ref_sync_state_set() does the same for ref_sync_get() and
ref_sync_set(). It then calls __dpll_pin_change_ntf() only for the pin, not
for ref_sync_pin.

Under the rules above, the callbacks from ref_sync_pin's own registration
run under ref_sync_pin's domain. If the two domains differ, nothing
serializes these two sets of callbacks.

The in-tree implementers zl3073x_dpll_input_pin_ref_sync_get() and
zl3073x_dpll_input_pin_ref_sync_set() do dereference this data:

	struct zl3073x_dpll_pin *sync_pin = ref_sync_pin_priv;

No in-tree driver creates a cross-domain pair today, since zl3073x
registers only its own chip's pins. The first bullet partly covers the case
where one driver registered both pins. It does not cover pins that
different drivers registered on one dpll.

Could the documentation say whether a ref-sync pair may cross domains, and
whether ref_sync_pin_priv may be dereferenced? The parent pin case in the
dpll_pin_on_pin_register() bullet already has an explicit rule like this.

> +
> +Device drivers have to follow these rules:
> +
> +- A callback must not call dpll_device_change_ntf(), dpll_pin_change_ntf() or
> +  any function changing the topology.
> +- A callback notifies about objects of the domain it runs under with
> +  __dpll_device_change_ntf() or __dpll_pin_change_ntf(). Other objects have to
> +  be notified from a context that holds no domain lock, for example a work item.
> +- A driver must not call dpll_device_change_ntf(), dpll_pin_change_ntf() or any
> +  function changing the topology while holding a lock that its callbacks take.

[Severity: Low]
Can a driver follow the work item suggestion safely without two more rules?

The first rule is about waiting on the work. The deferred work ends up in
dpll_pin_change_ntf() or dpll_device_change_ntf(). Both take dpll_lock for
read and then the domain mutex:

drivers/dpll/dpll_netlink.c:dpll_pin_change_ntf() {
    ...
	down_read(&dpll_lock);
	mutex_lock(&pin->domain->lock);
	ret = __dpll_pin_change_ntf(pin);
    ...
}

Callbacks already run with dpll_lock held for read, for example from
dpll_pin_pre_doit() or dpll_pre_doit(). A callback, or code holding a lock
the callbacks take, might wait for the work with flush_work() or
cancel_work_sync() while a writer is queued on dpll_lock. Could that
deadlock?

callback                  writer                  work
down_read(&dpll_lock)
                          dpll_pin_register()
                            down_write(&dpll_lock)
                                                  dpll_pin_change_ntf()
                                                    down_read(&dpll_lock)
flush_work()

Here the writer waits for the callback's read hold. The work's down_read()
blocks behind the queued writer, and the callback waits for the work.

The last rule above only bans direct calls to dpll_device_change_ntf() and
dpll_pin_change_ntf() while holding such a lock. It does not cover waiting
for a work item that makes those calls.

The second rule is about lifetime. The text does not say that the work has
to be cancelled or flushed before the target pin or device is unregistered
and released with dpll_pin_put() or dpll_device_put(). __dpll_device_put()
ends in kfree(dpll). A work item that keeps a struct dpll_device or struct
dpll_pin pointer and runs after the final put would touch freed memory.

Would it make sense to add both rules next to the work item suggestion?

> +
>  SyncE enablement
>  ================
>  For SyncE enablement it is required to allow control over dpll device

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261106121005.1327603-1-ivecera%40redhat.com
