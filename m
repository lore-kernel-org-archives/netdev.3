Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49ECD516143
	for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 10:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790678080; cv=none; b=aYQCV3WOE4XRtcWk7M5wdCTz/WWzY3nvwY5oVKeJz499Gei1IcItdTx+oVbm0XItfjuonaXJ1kH/6wGpN20TwAarWHDuo+QPLmkY3AZIuiU1Zr+GwoaWGmg0XukFMoRC6BZZXnI+0sUqFuoxZ6C5YXqL03cA/qz6Y1gk9ljAjnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790678080; c=relaxed/simple;
	bh=7ySV2oQHEBfaHxfVu79Q6xWSXdgURVjGf5cziZzS1dQ=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=MeAyf+9xHFpvvrJxMd3snJw0OP4VhybU5ZZ+Vg5j5Fwss8vBvxRVn8alobeX7QOp6KOp4YTdNa5M5usty/PpN84eirTZLK1ZbVjUN8eKbYctZ2fNcU+7a+nqhHPwj9ZLoOy+WFqvW15P1mfKXu+cMhteHYc7bcEEY5obImjiQtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T6cY5l4a; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T6cY5l4a"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AE8C1F00893;
	Tue, 29 Sep 2026 10:34:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790678070;
	bh=mcxf8v7o5iLbos9So9B562NFNa476KHgTdF9c6dqqyQ=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=T6cY5l4acZeKh9WItxWoVIjjZjE2OU0QBTD32XwH8uxoofInyNd1qfvSk9u0PrR+/
	 J6FbgnzUywV5AA2ltE1HEEJuhH8epmnFTsLFlrDoRDY2d5T5dqEmAGwTAYCBeXnSe9
	 UOJ1eVj3774+u+gSzXamCAoYVAUWznyoDoWq8i2m+K0qd7ZhOzFvDXikNRUu3onoU7
	 jVE94niaFoHMWIBBpjWJR6vYwEJIzcx4KlgvwkXge/Mrz2Gw21JciKXwW9iY9lbQoh
	 bnyIdnq0UFqmddkjM2ZGqpsA7XVga4CzDK0yDfbKvmHDDwVr/o3xjqYNF9pLKpX25j
	 2dZB7I2KsJJ3Q==
Content-Type: multipart/mixed; boundary="===============2280520317892589087=="
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <e92415377895ae97294773add38549484b30c54f4b3e1e968fcfe89348ff6696@mail.kernel.org>
In-Reply-To: <20260929093712.131096-5-clementwei90@163.com>
References: <20260929093712.131096-5-clementwei90@163.com>
Subject: Re: [PATCH v2 4/4] selftests: net: add TAP socket filter attach tests
From: bot+bpf-ci@kernel.org
To: clementwei90@163.com,netdev@vger.kernel.org
Cc: willemdebruijn.kernel@gmail.com,jasowangio@gmail.com,andrew+netdev@lunn.ch,davem@davemloft.net,kuba@kernel.org,weirongguang@kylinos.cn,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Tue, 29 Sep 2026 10:34:30 +0000 (UTC)

--===============2280520317892589087==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/net/tun.c b/tools/testing/selftests/net/tun.c
> index abe488bac50b..bf8d4d6f21f7 100644
> --- a/tools/testing/selftests/net/tun.c
> +++ b/tools/testing/selftests/net/tun.c
> @@ -8,13 +8,19 @@
>  #include <stdlib.h>
>  #include <string.h>
>  #include <unistd.h>
> +#include <linux/filter.h>
>  #include <linux/if_tun.h>
>  #include <sys/ioctl.h>
> +#include <sys/mman.h>
>  #include <sys/socket.h>
>
>  #include "kselftest_harness.h"
>  #include "tuntap_helpers.h"
>
> +#ifndef ARRAY_SIZE
> +#define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
> +#endif

This isn't a bug, but kselftest.h already provides ARRAY_SIZE through
kselftest_harness.h. Is this #ifndef block needed, or can it be dropped?

Looking at the include chain: kselftest_harness.h includes kselftest.h,
and kselftest.h defines ARRAY_SIZE at line 63-65. kselftest_harness.h also
defines it again at line 749. Other harness-based tests in the same
directory (tls.c, ip_local_port_range.c) use ARRAY_SIZE without defining
it themselves.

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/36552651982
--===============2280520317892589087==--
