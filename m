Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794333210;
	b=U+9qVhIU2QTEoK20ED11O95yoSMapKzs1MTeVUp6d6q4zy9gBTv9qMaj9j//82uG7QLt
	 7qVXvYJYBuB3FjWsJmpY2bBHxiBXncU1gQ7pU4L9/3/+t8BeC8YI+CFQhFXuDUIpnxP6N
	 DMHmKeonj8lnE6vFXYUEDiM74QQfMw/DYGTP/f9KI9n3Mnqgw+9p7MbV626sDS2t04I4L
	 R8BSfz3ONiuoNdYdBXnhrLzmVe0l/4u4qaEr7RLujFeJSp0vHlWUFjmg+VaGa/l9DPrZK
	 8PvPgwNeyT0DDy17+wd7uD2kYlEYPleUBYNA1BuN4nAolSLVyzF6Zw50rZ6FkrzM4NA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794333210;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=hI4Ha1kxt9IoMVYOSTGtQXQwpIXjsw2bWliwYAlRPPg=;
	b=Rf7txOcRwUcmP9eSGeb/or2gJ9cCfVmMz5V9UPzJhaHb1Z2yrhp+EWIA2JTHX71hk5Gq
	 /VSV44tHx29z4YKNi1zY9yo6Y8VvJEWsa6hzxS1XjCJbLodJQVqdY/IjjPLtNE6tDfGY6
	 vlV62qFrxWI9iBX3OUqyNkbMTxjPbZK0NOMSchaUo8rK0BRap+fMWdFMC5BFl9+9s6D4d
	 mYNp5ZZ9TiNchEn8yq8AX3TQnM2A5iQYOvnB3MVKjcN5pysDDxjmxF7S+3dLeQP1q/xKI
	 xliAO5fvx48NgL42i2xoL9vJjeZgmAEtY5HxCn5SBl5mcmhr9BhSvOsP/f+qr+Cr5GA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FydZvlHo;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F93260A3822;
	Tue, 10 Nov 2026 17:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FydZvlHo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07D971F008A1;
	Tue, 10 Nov 2026 17:53:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794333210;
	bh=hI4Ha1kxt9IoMVYOSTGtQXQwpIXjsw2bWliwYAlRPPg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=FydZvlHoIgAht0xMmulA4f5PoyF7lYoKg/cKKVcSunAa4QmK7nihh+MARdFVA02wW
	 WlckplXlmEZYnDfodWDl+qr5zExS8Pe/UJhDECYzExQp0pCQuUk1qbfSvL3plwmZBD
	 kbeXnsyWG9Q6MgtGvhf9uSqqRQGZpMEsHVvmy/eB4iP4HmkHBWF9FjptHJgLFkeF7c
	 PFBP4sN6bLvmhZI6KMjjdHcLjOJZdexUrk+k1sGrSfsmITUZSVmqkdmu6Tu/IPE9M3
	 KIeSR97nwg6F9hRdX/FCVEIcMZp5dtkADK7Qr7lgCXkBYSCgB9tNf/nJe8EmoRHCl8
	 k4Blb2juux4KA==
Subject: Re: [PATCH net-next 09/10] ice: dpll: update locking comments
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
Date: Tue, 10 Nov 2026 17:53:28 +0000
Message-ID: <179433320858.994134.3648996641880038315@kernel.org>
In-Reply-To: <20261106121005.1327603-10-ivecera@redhat.com>
References: <20261106121005.1327603-10-ivecera@redhat.com>
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

- [Low] The locking note this patch adds to the struct ice_dplls kernel-
  doc (drivers/net/ethernet/intel/ice/ice_dpll.h, lines 168-170) is…

--

ice: dpll: update locking comments

This commit updates the ice DPLL locking comments now that callbacks run
under the DPLL core domain locks instead of dpll_lock. It also adds a note
saying that callbacks of the external DPLL's pins run under that DPLL's
domain, so only pf->dplls.lock serializes them with the rest of the
driver.

> diff --git a/drivers/net/ethernet/intel/ice/ice_dpll.h b/drivers/net/ethernet/intel/ice/ice_dpll.h
> index 4ba76e2e2e0b0..39e041a30090d 100644
> --- a/drivers/net/ethernet/intel/ice/ice_dpll.h
> +++ b/drivers/net/ethernet/intel/ice/ice_dpll.h
> @@ -165,6 +165,9 @@ struct ice_dpll {
>   *     tx_refclks usage map), acquire pf->dplls.lock first, then
>   *     ctrl_pf->dplls.lock. Skip the second acquire when pf == ctrl_pf
>   *     to avoid recursive locking.
> + *   - Callbacks of the SYNCE and TIME_REF pins of an external DPLL run under
> + *     the DPLL core domain lock of that DPLL, not of the TXC and TSPLL DPLLs,
> + *     so only @lock serializes them with the callbacks of these DPLLs.

[Severity: Low]
Could this note be clearer that TXC and TSPLL are not in the same core
domain either?

As written, it presents the external fwnode pins as the special case. A
reader could take that to mean the other ice objects share one core
domain, which would serialize their callbacks against each other.

Looking at ice_generate_dpll_clock_id(), each PF gets three different
clock_ids:

drivers/net/ethernet/intel/ice/ice_dpll.c:ice_generate_dpll_clock_id() {
    ...
		if (d->dpll_idx >= E825_DPLL_TXCLK_BASE_IDX)
			return mac_clock_id;

		if (d->dpll_idx == E825_DPLL_TSPLL_BASE_IDX)
			return mac_clock_id | BIT_ULL(63);
	}

	return pf->dplls.clock_id;
}

dpll_domain_get() keys domains on (clock_id, module). That gives three
separate domains on one PF:

  - TXC, plus the EXT_EREF0 pin, which ice_dpll_init_txclk_pins() creates
    with the TXC clock_id
  - TSPLL
  - the DSN-based objects, such as the rclk pin

Each PF's TXC and TSPLL domains are also separate from those of other PFs.
The struct dpll_domain comment in dpll_core.h says only one domain lock is
held at a time.

So the core does not serialize TXC callbacks against TSPLL callbacks, or
either of them against rclk callbacks. pf->dplls.lock (with
ctrl_pf->dplls.lock and cgu_synce_lock) is what does that, and the fwnode
pins are one more case of the same thing.

The new sentence is accurate per DPLL, and the first bullet still says
@lock serializes all DPLL state mutations. Since this patch exists to
document the domain-lock rules, though, would it make sense to say that
TXC, TSPLL and the DSN-domain objects are each in their own domain?

>   *   - @txclk_notify_rwsem is held for read across
>   *     ice_txclk_update_and_notify(), including the out-of-lock
>   *     dpll_*_change_ntf() calls. ice_dpll_deinit() takes the write side

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261106121005.1327603-1-ivecera%40redhat.com
