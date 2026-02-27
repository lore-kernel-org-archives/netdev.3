Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 417A52367D1;
	Fri, 27 Feb 2026 22:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772231468; cv=none; b=c6R4Q8JWzbVzX8jvOE81+alIGXUsJNjf8237rYXA0a3Mb5+HDr60YYxtjkj1QiThuwnzIQodoN9cL4cMxuulSGXrv8Esy9WLe5LWILJNu3TA+Qcz24vm6z5q/RmTBrLLvcrkdrC17F9KoBa3hmK+xgDBXMhHqU1nF5WDkrqXQuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772231468; c=relaxed/simple;
	bh=2PzeMzRuVINJ0Zw9aXx5pE9G3+CTlyLJ1h8m4nRCLio=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FAXfygCgzhfGu/Y+6diQ5cgAN7UYEOybLdqAoZG7A1kKo7uno8V3t9cwD4fysbX/ltbH4mM6WRyiq0JBom0K2H9fjLLKhpfJ5BFMBYXkRd83Iburk4HEynNCTJ+DBZhJAO9aZBY05bNZON8TRK+vFCfYaTiO2pVC1CvIDIKCOlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=gRRBHkXp; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="gRRBHkXp"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=rsw+T9TrFcAqwPsV8W5RmwKCGXejQJOSXFIth0r6+R4=; b=gRRBHkXpGyYcZlwrWgJjj0S81d
	dbvr5jM842OdRjhj6qpwI+f7wYo6TaOWP78/g8Si6cVYHisMGaQaA7ziOgSXMec5gSi3f4/9jFJLe
	gRW6XaY8Gg1SSweYE8ivq0FJ83fv3N9K+f8StbI5Yqjwi5AjtAS7YlOI9So8x8SPyw5Y=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vw6MD-0097s9-7C; Fri, 27 Feb 2026 23:30:49 +0100
Date: Fri, 27 Feb 2026 23:30:49 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: "illusion.wang" <illusion.wang@nebula-matrix.com>
Cc: dimon.zhao@nebula-matrix.com, alvin.wang@nebula-matrix.com,
	sam.chen@nebula-matrix.com, netdev@vger.kernel.org,
	andrew+netdev@lunn.ch, corbet@lwn.net, kuba@kernel.org,
	linux-doc@vger.kernel.org, lorenzo@kernel.org, pabeni@redhat.com,
	horms@kernel.org, vadim.fedorenko@linux.dev,
	lukas.bulwahn@redhat.com, edumazet@google.com,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 net-next 01/11] net/nebula-matrix: add minimum nbl
 build framework
Message-ID: <7f599faa-09ea-4642-a650-707a10252811@lunn.ch>
References: <20260226073840.3222-1-illusion.wang@nebula-matrix.com>
 <20260226073840.3222-2-illusion.wang@nebula-matrix.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260226073840.3222-2-illusion.wang@nebula-matrix.com>

> +ccflags-y += -I$(srctree)/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/
> +ccflags-y += -I$(srctree)/drivers/net/ethernet/nebula-matrix/nbl/
> diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core.h
> new file mode 100644
> index 000000000000..cf425dc8beb7
> --- /dev/null
> +++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core.h
> @@ -0,0 +1,20 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (c) 2025 Nebula Matrix Limited.
> + * Author:
> + */
> +
> +#ifndef _NBL_CORE_H_
> +#define _NBL_CORE_H_
> +
> +#include <linux/pci.h>

Please put all standard linux include files in the .c file which needs
it.

A large part of the build time with Linux is the C preprocessor. There
are lots of unneeded includes, or include files included multiple
times. It gets easier to see this happening when only .c files include
system includes. 

> +#include "nbl_include.h"

You might also want to flatten your own include files, don't have them
nested.

	Andrew
