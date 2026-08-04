Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61235468C3A
	for <netdev@vger.kernel.org>; Tue,  4 Aug 2026 15:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785858457; cv=none; b=hHlCXl1T5Adc5xrkRQM5mcyHHavRAcSs3IJYT+Bh9sJXWUU5gDQRW43UsviIN4mOEPAG4/KdGc/T6aTwh0OJuyUEKAVXa3Km/+tr4Pujx468Ks8Go4aBSiZY5Si2jWYrLM8BlqZEFAZybSRE6Nkqeae9mcAGHjWN48Rl/riGMRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785858457; c=relaxed/simple;
	bh=GV/vJwLyZfDbVPdwZoqLIDkJT+JkjGOi4Xe9IARzrEo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UVQrEzBIZP2AmbQzUIySjkprB85MQwsv/LthsTJ4Cka+6Q7Tw5NQNWAuvwW3fOFQuGR7yr/HyDaK+j22vWjxImeYoNXr6sTsx4XDXLjscnHAZVIo/b4MwLW6PbIuO3KfCb5Ibg8isnU5vCVM+LEUQQoITT5TzCbUU3l5Aujx9nM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20251104.gappssmtp.com header.i=@davidwei-uk.20251104.gappssmtp.com header.b=UdtZA+lM; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20251104.gappssmtp.com header.i=@davidwei-uk.20251104.gappssmtp.com header.b="UdtZA+lM"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-38e041ea211so5053437a91.0
        for <netdev@vger.kernel.org>; Tue, 04 Aug 2026 08:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20251104.gappssmtp.com; s=20251104; t=1785858456; x=1786463256; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Fk9Cr9xtpHslxJSU4aHkyztI2mEYVVymr0eSwQARdWU=;
        b=UdtZA+lMlrZel5CPoxsif/isOYriZDS/DFHQ8IjdoqBJ1etK0m5qyFt9hh8Ru4vLox
         YyZDbLyatpdeRQz3WcxuIbdgQFgHPhQENE3sXJsQCMS0u/2nORsQEMajKzIC/teStWFR
         aE2Jz/MGgiyJ5lJk1NyhyktyIARPto8v9ue4yy9Iqqq49ePcUU+HCJx12EG72gGXF7vi
         8TFp5kYxTL0nMkVjJgA0g0j3LREBVNCaVgngV+ZPxgzM2SzNzeRytIbLcBs/ALlEFr4B
         kxHd+f4WV5dSSgoOCW7VRMhjNkpLs8tE291mqWWz9SFn1HPNrOKj01q9G0AJ0P4E3imC
         b4Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785858456; x=1786463256;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Fk9Cr9xtpHslxJSU4aHkyztI2mEYVVymr0eSwQARdWU=;
        b=H33e8t/fWrUVpw9TY3Rm7QqcjSMM0hBbErbygUGjbgCh6Lgdf2v0g96NnRy6X8NYUb
         EdfQly9/gwujaQAV/SdCWFLhp7beUsPyF6JN5unOv33V/yEyyB8yNFOJdVyA90jpO03Y
         mCp6wGDH7KGPhfBz8sIcdii+v/QEqzCnvtRztGr0M6diuNr5F0/qEoBgbYXs6wCWghhl
         CCEKGuN2hwREHFI2LOGAsXTsfZTI/Lk3s5zxkrpFi2gchAgT1XUnsJoWIyi5YNjznI16
         tFb8Mp9cPem4MJ2ESybT01RLIv5pjJTmBiHtFxaA2/2LnZc3geJ/tiIz7eec7cDhx7Xa
         fSQg==
X-Forwarded-Encrypted: i=1; AHgh+RpUgFzNmPB3zdCy2kSsrLpRposZ4qGwJkOvFqyfLC81lyS+EM+J/3DNuDRB070CakigQ4v++mw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTzB9FUGkKw4WLDys4hHLwiIWyDit2PqEXkSPejfrbDYZsyN4u
	vNVV7MX7wwEWRu62xeNGnfUyi/1a95mJ+iCyoiSMe3U+7dQJDYVC4V2KIguZcURYPcQ=
X-Gm-Gg: AR+sD11AmCyo3jte9wkVUp300D+vC6fI6zfyx6/xUdU5DjWRehMKQK5uasqaIXvq/sq
	ybjakb2A+0pygmPlZA1nvlTmftc3Msh5NG8+7TxBTUtwD1fYxnmRWei9mq32E6vLBHHYlDVAxvZ
	pg+DAML6ZMWXHjtmsMOR3KDDXFDrBqIW6CJ8BWY+0b50ODCji6Rl2KIcAZdkPCDB9513RADl23n
	x3XvUIh8iz2e6ZlqfluIwUiNZ/6gmHc6gTRdZ6HYkiwyfYbJ5QHlwdHA4e32s7WlZpOpPMeIlpD
	doV8vflvabdqBD5gV2011UiHJS4gOWKE16oD5uGkq5RO4xWivISy43YFa5RcrEnbEJkkiU14PNB
	FgUIxT2Qv9x9lbmEP4hAhn+Q+zl+BtC9ZP5hRjtDqPduSCCx8bAH2jL1v2fr0lEwPlLy+8NH6ns
	Z7HW4RJoLV0LvigoRIiwibS/5T9qTu7alZ5CLm7WGL9WbuPQmtTkfmjfavHshw6PjxEW+9VC2HN
	FvP7sHQgbm7SEw8IZ5ags3jUO79xzxHPJoYLm2cwVAHvBma5YSktCA8ethW73RyuyM0uvSSOHaZ
	JBxWkjY=
X-Received: by 2002:a17:90b:2f0d:b0:38e:76f8:fcb1 with SMTP id 98e67ed59e1d1-3903c70f4dcmr73072a91.32.1785858455657;
        Tue, 04 Aug 2026 08:47:35 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1156:a:73:30bd:a4b6:294c? ([2620:10d:c090:500::6:55a8])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13fca9111b6sm4615659c88.13.2026.08.04.08.47.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Aug 2026 08:47:35 -0700 (PDT)
Message-ID: <beb62270-ddb2-40d1-b03d-fd612073c4e7@davidwei.uk>
Date: Tue, 4 Aug 2026 08:47:33 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 4/6] selftests: net: add multithread client
 support to iou-zcrx
To: Juanlu Herrero <juanlu@fastmail.com>, netdev@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>, Pavel Begunkov <asml.silence@gmail.com>
References: <20260729221825.42773-1-juanlu@fastmail.com>
 <20260729221825.42773-5-juanlu@fastmail.com>
Content-Language: en-US
From: David Wei <dw@davidwei.uk>
In-Reply-To: <20260729221825.42773-5-juanlu@fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2026-07-29 15:18, Juanlu Herrero wrote:
> Add pthreads to the iou-zcrx client so that multiple connections can be
> established simultaneously. Each client thread connects to the server
> and sends its payload independently.
> 
> Introduce the -t option to control the number of threads (default 1),
> preserving backwards compatibility with existing tests.
> 
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Juanlu Herrero <juanlu@fastmail.com>
> ---
>   .../testing/selftests/drivers/net/hw/Makefile |  2 +-
>   .../selftests/drivers/net/hw/iou-zcrx.c       | 38 +++++++++++++++++--
>   2 files changed, 36 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/testing/selftests/drivers/net/hw/Makefile b/tools/testing/selftests/drivers/net/hw/Makefile
> index 234db5c2c90cc..3cab3b4adbb2e 100644
> --- a/tools/testing/selftests/drivers/net/hw/Makefile
> +++ b/tools/testing/selftests/drivers/net/hw/Makefile
> @@ -88,5 +88,5 @@ include ../../../net/ynl.mk
>   include ../../../net/bpf.mk
>   
>   ifeq ($(HAS_IOURING_ZCRX),y)
> -$(OUTPUT)/iou-zcrx: LDLIBS += -luring
> +$(OUTPUT)/iou-zcrx: LDLIBS += -luring -lpthread
>   endif
> diff --git a/tools/testing/selftests/drivers/net/hw/iou-zcrx.c b/tools/testing/selftests/drivers/net/hw/iou-zcrx.c
> index 9b62fd0703e61..7bc61f3b70ca6 100644
> --- a/tools/testing/selftests/drivers/net/hw/iou-zcrx.c
> +++ b/tools/testing/selftests/drivers/net/hw/iou-zcrx.c
> @@ -4,6 +4,7 @@
>   #include <error.h>
>   #include <fcntl.h>
>   #include <limits.h>
> +#include <pthread.h>
>   #include <stdbool.h>
>   #include <stdint.h>
>   #include <stdio.h>
> @@ -85,9 +86,12 @@ static int cfg_send_size = SEND_SIZE;
>   static struct sockaddr_in6 cfg_addr;
>   static unsigned int cfg_rx_buf_len;
>   static bool cfg_dry_run;
> +static int cfg_num_threads = 1;
>   
>   static char *payload;
>   
> +#define CONNS_PER_THREAD	4
> +
>   struct thread_ctx {
>   	struct io_uring		ring;
>   	void			*area_ptr;
> @@ -379,7 +383,7 @@ static void run_server(void)
>   		error(1, 0, "test failed\n");
>   }
>   
> -static void run_client(void)
> +static void *client_worker(void *arg)
>   {
>   	ssize_t to_send = cfg_send_size;
>   	ssize_t sent = 0;
> @@ -405,12 +409,37 @@ static void run_client(void)
>   	}
>   
>   	close(fd);
> +	return NULL;
> +}
> +
> +static void run_client(void)
> +{
> +	int conns_per_thread = cfg_num_threads > 1 ? CONNS_PER_THREAD : 1;

Make cfg_num_threads the default value you want, then you can remove
CONNS_PER_THREAD and this ternary.
