Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08AF7352C28;
	Fri,  2 Oct 2026 11:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790940758; cv=none; b=KclEPG3WyjYBuGlQHcucN86K0fMi1USbvoHt00XCrcdTgVbpsQ1yLAJZJdKKsHIMEaEnvpvaxWdqn5IUF+5UtOd9iLrYKtWSN9n7S+eZVd7ItU2mI8GTDbG3mTKO6W3BcZAjVqDnIxjemTe5JsQdVBxUaMl0vjkYs+bhXTWSxjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790940758; c=relaxed/simple;
	bh=14UsSmiyWTCDvjVuMd1nzLyltr4kPjJ/IG243/tvoxE=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rvG1BvG+OCQ84XoSs62si6PPw6VH7gjxeGOMPfWWdRvG1lzZBcguolc4hUWxOU+3EYLYHi2DTOZbL6g9aYLsYWj1IZZ1jr9oD04xqukguDLkPSyqQvrtai5S9KyC/k7ctOkQ3qSGP6GF+TuAHoSv8Cj5EFQtnJbJ5Agg2J77cMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UbpTa8nj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UbpTa8nj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 385281F000FF;
	Fri,  2 Oct 2026 11:32:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790940756;
	bh=yG6hH6C8Dz8aO0wpzoeWQ7hoi43ThISRZ8lvIAOBTMM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=UbpTa8njIzEy3UDPMUex2QjfGsQiQulA7K1tE1aoBj5fI/oDK7pQ+Ig+K/v4y8Gum
	 +VGlF8UXAYNSnVF+DAnDqDIeAwT9+kTO9BoR8YI8I8LiMkoNDRPDCn4dCh49/iapEb
	 Lyj22Kx/tJxSDbRTDroCcyA5JNORjjWppaiOGtnt/7uaw1S4BufnOUnJ2KIgKDoUdz
	 mOwy5n5LXa9JYVV6nTkeql1mlmLBxT95cqZdOweCtG2/QmCKZn3Nv7d+Qyt9G3N0C4
	 CrLvN9pyxjx30/HQkcQseRZ8zkL858HgJFRMPY7ZUaEUUZ3m2excQtX3hljrzZ0CxM
	 ed6lrHo/CtKnQ==
Subject:
 Re: [PATCH net-next v2 2/3] tcp_hybla: fix divide by zero on rtt0 == 0
From: netdev-bot+sashiko@kernel.org
To: jiayuan.chen@linux.dev
Cc: netdev@vger.kernel.org, edumazet@kernel.org, edumazet@google.com,
 ncardwell@google.com, kuniyu@google.com, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, stephen@networkplumber.org,
 linux-kernel@vger.kernel.org
Date: Fri, 02 Oct 2026 11:32:35 +0000
Message-ID: <179094075572.434549.16857994786468388270@kernel.org>
In-Reply-To: <20261001112948.322463-3-jiayuan.chen@linux.dev>
References: <20261001112948.322463-3-jiayuan.chen@linux.dev>
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

- [Low] In net/ipv4/tcp_hybla.c, the patch replaces `module_param(rtt0,
  int, 0644)` with `module_param_cb(rtt0, &rtt0_ops, &rtt0, 0644)`.

--

tcp_hybla: fix divide by zero on rtt0 == 0

This commit changes the rtt0 module parameter from int to unsigned int.
It also registers rtt0 through module_param_cb() with a setter that only
accepts values from 1 to U32_MAX / USEC_PER_MSEC. That stops
hybla_recalc_param() from dividing by zero, and stops rtt0 * USEC_PER_MSEC
from wrapping on 32-bit.

> diff --git a/net/ipv4/tcp_hybla.c b/net/ipv4/tcp_hybla.c
> index abd7d91807e54..b9b482180d30b 100644
> --- a/net/ipv4/tcp_hybla.c
> +++ b/net/ipv4/tcp_hybla.c
> @@ -26,8 +26,20 @@ struct hybla {

[ ... ]

> +static const struct kernel_param_ops rtt0_ops = {
> +	.set = rtt0_set,
> +	.get = param_get_uint,
> +};
> +
> +module_param_cb(rtt0, &rtt0_ops, &rtt0, 0644);
>  MODULE_PARM_DESC(rtt0, "reference rout trip time (ms)");

[Severity: Low]
Does this drop the parmtype entry for rtt0 from the .modinfo section of
tcp_hybla.ko?

The old module_param() line expanded to module_param_named(), which emits
the type tag:

include/linux/moduleparam.h:
#define module_param_named(name, value, type, perm)			   \
	param_check_##type(name, &(value));				   \
	module_param_cb(name, &param_ops_##type, &value, perm);		   \
	__MODULE_PARM_TYPE(name, #type)

module_param_cb() only expands to __module_param_call():

#define module_param_cb(name, ops, arg, perm)				      \
	__module_param_call(MODULE_PARAM_PREFIX, name, ops, arg, perm, -1, 0)

MODULE_PARM_DESC(rtt0, ...) is still there, but nothing provides a type.
After this change, modinfo tcp_hybla would show a description for rtt0
with no type suffix.

Since the storage is now unsigned int and it is read back with
param_get_uint, could a line like this be added after module_param_cb()?

__MODULE_PARM_TYPE(rtt0, "uint");

Other module_param_cb() users already do this, for example
arch/x86/kvm/mmu/mmu.c, fs/fuse/inode.c and
drivers/scsi/fcoe/fcoe_transport.c.

>  
>  /* This is called to refresh values for hybla parameters */

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261001112948.322463-1-jiayuan.chen%40linux.dev
