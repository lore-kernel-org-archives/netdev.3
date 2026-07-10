Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DB5D40912B
	for <netdev@vger.kernel.org>; Fri, 10 Jul 2026 22:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783724244; cv=none; b=r1lptao9mMjliA00G2V2jJ0HsvVhgvu6MgVy1iFiy9zXLF1yfvbjqSZgzoMnSRK9iUKjX7XpOMvHBdFKKb6qUmLT/zaJv2Ux7d1OaLniXohnpUGOe6nEmF/qmui7sab/c/G/bbE15PmcpinAsSbaGpNMHyCirQ+c1ApuK2rDeMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783724244; c=relaxed/simple;
	bh=Bh7slvYsSbYuWHBXJEdYMQfxd/TywiWv0sFj8regivI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h+ZisY5cH1sVd8nBl0aS8TKExX0CRw6H0YaB4ZQO5UufZp4lfnNZ9Kp9XCMbgfR2K0NLNm76sCFgAa+zD26LVj1vw3GVEaH//iGx8FTzW817R60Sf75xMuIXfGgVNdgSuA2IpOwLUJqL2x1ZRpHFlg3uuN0qpoaSf9QWtlNZd/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=DJbALGPY; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="DJbALGPY"
Message-ID: <02bbd5c1-3cd8-4e70-adda-94f5d9bafac2@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783724230;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B2nZGd4IyEPxjt0SQ0xbjh+Yz54eGjdtToqJP5YAQPM=;
	b=DJbALGPYMI0IufykG3jtGkOC9Z8RIVD6xv+OkGLdAX/khqZVzFIIaHHB2kKL4PIKP5C1j/
	lASMbFjdPQ60fQAetftqLvJfWaDhy9c7VKi77zjLubT/dqvFREZoV+OGmmaEeeXpPT8ctK
	wykH0XV+DoeLSw2Z3zLtk+BWSx+zZ7s=
Date: Fri, 10 Jul 2026 23:56:49 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net] dpll: fix NULL pointer dereference in
 dpll_msg_add_pin_ref_sync()
To: Ivan Vecera <ivecera@redhat.com>, netdev@vger.kernel.org
Cc: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Jiri Pirko <jiri@resnulli.us>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>, Milena Olech <milena.olech@intel.com>,
 Jakub Kicinski <kuba@kernel.org>, open list <linux-kernel@vger.kernel.org>
References: <20260710193625.1378822-1-ivecera@redhat.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20260710193625.1378822-1-ivecera@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 10/07/2026 20:36, Ivan Vecera wrote:
> When a dpll_pin is shared across multiple dpll_device instances and
> those devices are being unregistered (e.g. during driver module removal),
> a NULL pointer dereference can occur in dpll_msg_add_pin_ref_sync().
> 
> This happens under the following conditions:
>   - A pin is registered with two or more dpll devices (dpll_A, dpll_B)
>   - The pin has ref_sync pairs with other pins
>   - During unregistration of dpll_A's pins, a ref_sync partner pin is
>     unregistered first, removing it from dpll_A->pin_refs
>   - But since the partner pin is still registered with dpll_B, its
>     dpll_refs is not empty, so dpll_pin_ref_sync_pair_del() does NOT
>     run and the partner stays in the pin's ref_sync_pins xarray
>   - When the pin itself is then unregistered from dpll_A, the delete
>     notification calls dpll_msg_add_pin_ref_sync() which finds the
>     partner in ref_sync_pins, passes dpll_pin_available() (partner is
>     still registered with dpll_B), but dpll_pin_on_dpll_priv(dpll_A,
>     partner) returns NULL because partner was already removed from
>     dpll_A->pin_refs
>   - The NULL priv pointer is passed to the driver's ref_sync_get
>     callback, which dereferences it
> 
>   BUG: kernel NULL pointer dereference, address: 0000000000000034
>   Oops: Oops: 0000 [#1] SMP NOPTI
>   RIP: 0010:zl3073x_dpll_input_pin_ref_sync_get+0x73/0x80 [zl3073x]
>   Call Trace:
>    dpll_msg_add_pin_ref_sync+0xb8/0x200
>    dpll_cmd_pin_get_one+0x3b6/0x4b0
>    dpll_pin_event_send+0x72/0x140
>    __dpll_pin_unregister+0x5a/0x2b0
>    dpll_pin_unregister+0x49/0x70
> 
> Fix this by skipping ref_sync pins whose priv pointer cannot be resolved
> for the current dpll device.
> 
> Fixes: 58256a26bfb3 ("dpll: add reference sync get/set")
> Signed-off-by: Ivan Vecera <ivecera@redhat.com>
> ---
>   drivers/dpll/dpll_netlink.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/dpll/dpll_netlink.c b/drivers/dpll/dpll_netlink.c
> index bf729cde796a7..5703667593a7c 100644
> --- a/drivers/dpll/dpll_netlink.c
> +++ b/drivers/dpll/dpll_netlink.c
> @@ -567,6 +567,9 @@ dpll_msg_add_pin_ref_sync(struct sk_buff *msg, struct dpll_pin *pin,
>   		if (!dpll_pin_available(ref_sync_pin))
>   			continue;
>   		ref_sync_pin_priv = dpll_pin_on_dpll_priv(dpll, ref_sync_pin);
> +		/* Pin may have been unregistered from this dpll already */
> +		if (!ref_sync_pin_priv)
> +			continue;
>   		if (WARN_ON(!ops->ref_sync_get))
>   			return -EOPNOTSUPP;
>   		ret = ops->ref_sync_get(pin, pin_priv, ref_sync_pin,

well, a bit strange, but if you can hit this issue, we have to fix it.

Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
