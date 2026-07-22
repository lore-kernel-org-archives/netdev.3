Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 800D53E4506;
	Wed, 22 Jul 2026 20:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784753935; cv=none; b=n/aewHfAHn0oIGgaPDTCYSZQtHIb5x1v3vMp5RLL93DX8pkJfnRBlOmBy1g21gogzInXqXHQ06ovPBZ10J+uzOYwKREMAFjgZHf3HimWAnmhs6CPrWXnfPSk55Wo50693E2Du3z8QgCAlxQ/0r6GVd7ltdR2kSFFFaUsDxha6Dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784753935; c=relaxed/simple;
	bh=b9p0ObpqzCX1kuKqtQU9bdq/OrgfVGVs0A4ejk2T16g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f4cm3EecGyjIGM4sG3VU4Pu4S+Xd5qwY54miVD8tKoSUHriqUJh9fd0xsjTbWobkasEj0edttgTBRbDx6GFoSXAsv8uqNJ8ev/UiM0DO1Fom7l0Fa5JIvGW9NX7cJchd5bcCZRzE44RWaQpUHliAwp+zKRVh198hJRcu6B4eXUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SZVitTeE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SZVitTeE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF8F71F000E9;
	Wed, 22 Jul 2026 20:58:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784753934;
	bh=Eme+F7fQo9yx69Hv8UZFUI6uYrS7GDsk5lz/TsUAj5s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=SZVitTeESMzAUmA2NXNaQxAXnzvbGmhPSmhAhMGVLptZ6o58qDq/vkO452P/f0fCq
	 hShycgsMwsHhM3Sd0ugP2dj3+QmqAViLzfgBry17JZqET6A8CxAtYh+S9XNqZkc6hC
	 Sgm5MtiUbPBce/pqB7FF838lM/kcXCFh6kuxi8sQJf26FVzD4t2pLrvrYdkOPqhVpU
	 hiYCjHHcGqnWwe/oAVOBXM4ovE9uclQYNjc77Ro1cfmE2yCIWYT6DtwXYmAsWnVhmb
	 1DwohylcLyn0xm3qaeeo76bjEbcHMl7ivkGizv+qhV/JmchTt7hKuRGFOZDimxOnZS
	 8uXmWqTX1r6sg==
Date: Wed, 22 Jul 2026 13:58:48 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ivan Vecera <ivecera@redhat.com>
Cc: netdev@vger.kernel.org, Chris du Quesnay
 <Chris.duQuesnay@microchip.com>, Arkadiusz Kubalewski
 <arkadiusz.kubalewski@intel.com>, "David S. Miller" <davem@davemloft.net>,
 Jiri Pirko <jiri@resnulli.us>, Michal Schmidt <mschmidt@redhat.com>, Paolo
 Abeni <pabeni@redhat.com>, Pasi Vaananen <pvaanane@redhat.com>, Petr Oros
 <poros@redhat.com>, Prathosh Satish <Prathosh.Satish@microchip.com>,
 Richard Cochran <richardcochran@gmail.com>, Simon Horman
 <horms@kernel.org>, Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 2/2] dpll: zl3073x: add PTP clock support
Message-ID: <20260722135848.2d401ada@kernel.org>
In-Reply-To: <20260713103739.1553284-3-ivecera@redhat.com>
References: <20260713103739.1553284-1-ivecera@redhat.com>
	<20260713103739.1553284-3-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 13 Jul 2026 12:37:39 +0200 Ivan Vecera wrote:
> diff --git a/drivers/dpll/zl3073x/Kconfig b/drivers/dpll/zl3073x/Kconfig
> index 5bbca14005813..d0574ad571d3f 100644
> --- a/drivers/dpll/zl3073x/Kconfig
> +++ b/drivers/dpll/zl3073x/Kconfig
> @@ -2,7 +2,7 @@
>  
>  config ZL3073X
>  	tristate "Microchip Azurite DPLL/PTP/SyncE devices" if COMPILE_TEST
> -	depends on NET
> +	depends on NET && PTP_1588_CLOCK_OPTIONAL

Real dependency is probably better here?
The Optional is meant for NICs for which PTP truly is a side-feature.

> +zl3073x_dpll_alloc(struct zl3073x_dev *zldev, u8 ch)

Would be nice to factor out the code movement to a separate commit to
make this diff easier to follow

>  #include <linux/dpll.h>
>  #include <linux/list.h>
> +#include <linux/mutex.h>

spurious include?

> +#include <linux/ptp_clock_kernel.h>
>  
>  #include "core.h"
>  
> @@ -22,6 +24,8 @@
>   * @type: DPLL type (PPS or EEC)
>   * @lock_status: last saved DPLL lock status
>   * @pins: list of pins
> + * @ptp_info: PTP clock info
> + * @ptp_clock: registered PTP clock (or NULL)
>   */
>  struct zl3073x_dpll {
>  	struct list_head		list;
> @@ -36,6 +40,8 @@ struct zl3073x_dpll {
>  	enum dpll_type			type;
>  	enum dpll_lock_status		lock_status;
>  	struct list_head		pins;
> +	struct ptp_clock_info		ptp_info;
> +	struct ptp_clock		*ptp_clock;
>  };
>  
>  struct zl3073x_dpll *zl3073x_dpll_alloc(struct zl3073x_dev *zldev, u8 ch);
-- 
pw-bot: cr
