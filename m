Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2438E3A7F47
	for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 21:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786570895; cv=none; b=nQ+9vZeEWV4qJNKymolwxJXEDkYlW6p3CcGS93g7UBWmz6PSbbVhzYGw/yuBK6b7+eM265ZbfhlCXdLfTE4FX4RPgTBZxZtiSwXvC7qjALz+gHpRtUsGE4GjhKn0bOf7u75UbvfGuYAjBhqCtToEZMW+86XzBaoOsvtvBdCeMZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786570895; c=relaxed/simple;
	bh=Myn0f5PoONuBeSnhGPwFLjCEATkMK/fQIXssiOVSNy0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E/fBsEXkYVwURdQweBvJGtEYguLV1VjEeshYmrjZVvNZ9hAkxCV7tF8YMIKx+X0xtIs1LVIcEDNB6LEdsy4Sndt7cIKgHpn9UVbKfCUKqi1CIAvQDOvVtnWxy8AIOx/UJGymTNGnTLLz8RRSpN78+FSEKf1iIApNwaNkNlekfQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=choYcLMz; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="choYcLMz"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-38e3efab7e0so299775a91.0
        for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 14:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786570893; x=1787175693; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NPvoXejEXMCOLtks/4P44XseBHeJ9j+rFY5G6V1i118=;
        b=choYcLMzzYt+EkneTOegz0/c40LRIGJvd4bO/SM6+11qBRjCZHyFmO+vsdAOFxsS1w
         EiFXkb4eR8TjF0JQdMn3RBqgg/nXvx0gBedu1SzsFJcl4U6vYEWZrfNp0A8MWJF8Fx2/
         U/UEgb/kTjJEUR07MFRmoWAoNe5HDnLansO0wH3tlYyq/revCNq39mFPtxb0TpoqM9vH
         AYgxFm1KNabjVNnER7ZHZyUWclO/RwYCg7CeFztB5IgHuTbR+T3tUVfm1rzd+UDr7OXz
         v5dMxhIf8DGqcZlN39Hv939A46x5dcPthyVGFAW/Zn2jBSNQUufxPVWtYQkniVf/Dpus
         kAiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786570893; x=1787175693;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NPvoXejEXMCOLtks/4P44XseBHeJ9j+rFY5G6V1i118=;
        b=QUUaU9nBL0swkTRbH5kDh2v7s2q6v39Ma8BrS73XugiZvoT/QxKmjwg2eQZxyxQ57I
         I11a+4Krxf9AfT9bOw0sDjKZ4ApkFizbidSayfH+1WdnxvZjO4FeX1C5/rJ/7aNu2UbP
         zK8+D++bhOnK+uj8stGX467obXJqd7uRGnDTBoXxk3GLXENUQ1CdqSvFcBYBwI39PkO5
         b4gR4YCpT981t9WNNpkqgCxWDgw7l9yz6A8pIK/y4hktYkNAxp2YrndVF0cFzvkK1H59
         a2E4s7rB1V64QxYDsGk5X3+s3y3rJEE8hGGzTon4ecRYCkc88x8GAQzZ9dOQ2+wrOzTS
         Dfog==
X-Forwarded-Encrypted: i=1; AHgh+Rpx/htLLhTgK9NMQL44VQuKAcJl+Az/2+MD8YEwAk7enKylt9LcR8u/dsQPysLjowe8N7dWZkc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdEPlzHTa7pnRfWYY3Qq2jn9kHd7s4HnEjztkTixpObgEvzxxO
	WdX5ZABXzXfh+hgVjIcesBnzIFP6P2KWZ+3keO1OaL8K5juY+f+z9s8CP1N785kGdA==
X-Gm-Gg: AR+sD1314FQLIjx/P/5ycDE9EN0Qsb7MYak9296s/2/Ynj4RRiMOz8Z4HAO529aq0dl
	FZlr/J7sUrCcs0K/WxbkdOhhHNrY3ZjnY9GdOvYPb0vqiK0l1/mw6ceZapg9iAapHx+ItZNJotj
	D2SPksvVvuo5dGrp98zA2U3F0hpNymEZihXTnwGb1V8I2i9hPrkrTd7HPIwSHHtiGwCzOR1r9K7
	Pv+dLzdMkDEDVbi6QsJYYgG56nHxNyNSeAmyVo1lzt4fTFuPFbImnhVO+SbM6pW/pIzmg4+mFQK
	NRtx2ovN9/+ksx7WUCBOWnGP47yLpj7BgYe6SNjxGWBs6EcqYoMzSqT0b5I3hhKkR2dA9wCU9xj
	JosGu5Yuwrlf9k9iIMyCkHrTyM1qZI1oWwIOcPbUWEfQPaeJOjwr7Edp+usRJvZasGbLed4NvFU
	ts4uTUyYI6bwlcD7WdAeqZolV+Y5MIKOQA2eVRV2OYYEY9X/a0STAITlsm9vX8SsSrT9KTz4KpM
	cx13YCzlnnvYDey5uBx4idthMF7Tg==
X-Received: by 2002:a17:90b:274c:b0:36b:de66:92c3 with SMTP id 98e67ed59e1d1-3931f583a5amr478962a91.10.1786570892837;
        Wed, 12 Aug 2026 14:41:32 -0700 (PDT)
Received: from google.com (132.200.185.35.bc.googleusercontent.com. [35.185.200.132])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3931ced0781sm878738a91.11.2026.08.12.14.41.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 14:41:32 -0700 (PDT)
Date: Wed, 12 Aug 2026 21:41:28 +0000
From: David Matlack <dmatlack@google.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Alex Williamson <alex@shazbot.org>, kvm@vger.kernel.org,
	Leon Romanovsky <leon@kernel.org>, linux-kselftest@vger.kernel.org,
	linux-rdma@vger.kernel.org, Mark Bloch <mbloch@nvidia.com>,
	netdev@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>,
	Shuah Khan <shuah@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
	patches@lists.linux.dev
Subject: Re: [PATCH v4 08/10] vfio: selftests: Add mlx5 driver - HW init and
 command interface
Message-ID: <anzoiALsjiWrsZtl@google.com>
References: <0-v4-021df3fb5a3f+98e-mlx5st_jgg@nvidia.com>
 <8-v4-021df3fb5a3f+98e-mlx5st_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8-v4-021df3fb5a3f+98e-mlx5st_jgg@nvidia.com>

On 2026-08-12 11:59 AM, Jason Gunthorpe wrote:

> diff --git a/tools/testing/selftests/vfio/lib/drivers/mlx5/mlx5_hw.h b/tools/testing/selftests/vfio/lib/drivers/mlx5/mlx5_hw.h
> new file mode 100644
> index 00000000000000..a2506ec8a19523
> --- /dev/null
> +++ b/tools/testing/selftests/vfio/lib/drivers/mlx5/mlx5_hw.h
> @@ -0,0 +1,108 @@
> +/* SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB */
> +/*
> + * mlx5 VFIO selftest driver - HW definitions
> + *
> + * Typed wrappers, constants, and helpers for programming mlx5 hardware
> + * via the VFIO selftest framework.  Most HW constants and all MLX5_SET/GET
> + * macros come from the kernel headers (mlx5_ifc.h, mlx5_ifc_macros.h).
> + */
> +#ifndef SELFTESTS_VFIO_MLX5_HW_H
> +#define SELFTESTS_VFIO_MLX5_HW_H
> +
> +#include <linux/io.h>
> +#include <linux/build_bug.h>
> +#include <vdso/bits.h>
> +
> +#include "mlx5_ifc.h"
> +#include "mlx5_ifc_macros.h"

I'm getting a compiler warning here when building with clang which is
getting upgraded to error from -Werror.

  /usr/local/google/home/dmatlack/kernel/trees/review/tools/testing/selftests/vfio/lib/drivers/mlx5/mlx5_ifc.h:2706:50: error: field 'menu'
  with variable sized type 'struct mlx5_ifc_resource_dump_menu_segment_bits' not at the end of a struct or class is a GNU
        extension [-Werror,-Wgnu-variable-sized-type-not-at-end]
         2706 |         struct mlx5_ifc_resource_dump_menu_segment_bits menu;
               |                                                         ^
           1 error generated.
           make: *** [lib/libvfio.mk:36:

I assume the mlx5 header needs to be fixed... But we can also work
around it in VFIO selftests if that turns out to be a can of worms:

diff --git a/tools/testing/selftests/vfio/lib/drivers/mlx5/mlx5_hw.h b/tools/testing/selftests/vfio/lib/drivers/mlx5/mlx5_hw.h
index 2c451e411ec1..b9fad2b722a0 100644
--- a/tools/testing/selftests/vfio/lib/drivers/mlx5/mlx5_hw.h
+++ b/tools/testing/selftests/vfio/lib/drivers/mlx5/mlx5_hw.h
@@ -13,9 +13,18 @@
 #include <linux/build_bug.h>
 #include <vdso/bits.h>

+#ifdef __clang__
+#pragma clang diagnostic push
+#pragma clang diagnostic ignored "-Wgnu-variable-sized-type-not-at-end"
+#endif
+
 #include "mlx5_ifc.h"
 #include "mlx5_ifc_macros.h"

+#ifdef __clang__
+#pragma clang diagnostic pop
+#endif
+
 /*
  * Typed HW object wrappers for driver region arrays.
  *

