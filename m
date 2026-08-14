Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E90AA486BB6
	for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 16:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786723482; cv=none; b=t9OQfhidVTc9Nws6AicH1pOoI8BSh4A47EkOCmaMZGC7bpUlLVAW2EbEZEgNyGYoORf997vRcZc/pdT3JlYbj4L/p/tOylw1V6fOWpWHDbm6kGpPIfLw3oUrfFrS/gYnAZyvtK41HyEgB6puhjrhCZlrJs/PXsLVmgPVihKXwdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786723482; c=relaxed/simple;
	bh=52qCRrZb2SMRCcmFeD6ZAbxvhqKc5jQN4x92ylGefnE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YliT/tLTwR3JdHhXx5W1DZZerri3BmEBhJ4NpAWhCIyNoVUOKkLheKrqhjNV08XIIBIBnflgo5ddBbanZ0HPa6uaSz2RvgEcYJK2d7FQKntvP+Jp8FyaPPd3o8VW0pkHK3q3NcIf7Rjs46Ap22ssUI4SCDMY91SaUf92GMPTyB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20251104.gappssmtp.com header.i=@davidwei-uk.20251104.gappssmtp.com header.b=RNqflWah; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20251104.gappssmtp.com header.i=@davidwei-uk.20251104.gappssmtp.com header.b="RNqflWah"
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-7eb29ed2bbdso610490a34.2
        for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 09:04:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20251104.gappssmtp.com; s=20251104; t=1786723478; x=1787328278; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eZdEAU+RA4hG/xm/Q4y+B1YPvOJHTrAQedhhdFxab1c=;
        b=RNqflWahBCsLWj3fGqUb+K1nVtQHHr9HkS9nM46NhzOtrQyR0qyOGvp8zeOtClpOJS
         e29CEzcZ6WYvAXBfD2Q4qmam0srSrHzIo2pxywSrm5cCPU+8FX+kARdtBdJQ+SCNVh7p
         uw+bFzySZAd3HWHshPgl+Jf/pyfMvZ/FN32SEWjpxeZCpSE34OyqQtjqVyJAgC4s0Qth
         qO0K8VqxrIPxz0qCmjatWqLsjfj9MKQ9m3aVVkN7uywSLGvdUmE4ze3/85Bw7Cc5avub
         C2JrBVEOK29yRU7Gse0dS2ATFVgSda+nTkZ71sgp08JZCiQ8urEZla9J+ZPQgQYILFUT
         HPEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786723478; x=1787328278;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eZdEAU+RA4hG/xm/Q4y+B1YPvOJHTrAQedhhdFxab1c=;
        b=DDZUURUv/o4QPM8a367MAcGjo82BB+83XW1kGFAhuj4KTUgadwFL96tRHGYozX0EOw
         8mWDIXiEhHNJmBbjZ3/xtOTJQ/MZuVK2GEYXE7KCUeKp5eC0E1wnOo+k2vFjrYfzkZgD
         phi2Eish80JOJocYTX1bjkRkYRYACopDjZzY+1UDbOdR/IjKiyPb4KO/u23xrkHOsSuf
         p57av1Peho10eL7Wz0itMaXcLx+girUsWR7n7PUHrw2G3rDCh2M2KecSpZgnpjS037J2
         pEXx+QZoQyzROCEsMIFedDf4aDiOf50w6r9eSK49HVcCPK8wIPy3QyhBlXOIQ0+mIyEe
         EmkQ==
X-Forwarded-Encrypted: i=1; AHgh+Rqt7jqTfCvyFMXkxtXDrdazYGlGgcvcxKEIBVeRJ0gKtiNxU33eI6BtpyiU5N3c8IqVtEsrUMQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPaBi4sNMl+ZN+1mxSC5auGRYr0RUI790BujTt2fGnc3rOUleu
	Tny4PDY0g4W2Ncib7Vf7n0B8dBWkQJVhhb+CFtl/G5ZL5P9s19onvTdGOhjq5dAz0Xw=
X-Gm-Gg: AR+sD122Zel9BW+aTNy2tr+n5CioMOEQDEpwkj0X1cGNyOIvm5CiXH20Ba8a6r1sQEj
	rIwKPWVNIfryVpOW+npfs6mH5t8CcJQnS5/UVtcB2+qV4fLSfD5lzqFKpERyebE4cOk10zezl+i
	cUpBR02iWuPhpmjN5iq/eWOtIehqUvhq7byTMtZ1R0vKxDHyWUUHEFemBAZbwhjoRJ6AU6P3113
	wOQDjEfp71ZnhROWpHqNpDCgE4qHLTpF2cMWwMMqv/7rrgaXbNwN0Om/MNeHabrZ/csai+HsE2i
	cixk3PpNVj/cA1VkN7zEKDbcEe9VzJenohhxYJfQs1IDSETtgcEPnQL760dOxdjfMQ8pz2QlhFE
	nDpfMrPzxjkMpNSzDYwNleq1YEtfuRLPZe32AWspA9HysuSQqeBCtQhYcC2ZutdzfjMywftsqiX
	rrlcGl3AeCBX/jMn1ShIdSmtEdZZda23xCeOZ/WrJ5pIv3y+W6nV8udtJFX5+Kuh+4qRpKj97k+
	9fD7tZBNNR9cPWjL1zEejBc1mQuva7hcRi6KXBc87uFQS4+t3M0UBk+OlzrrDcbg6Bp6xZk
X-Received: by 2002:a05:6820:1513:b0:6b0:ac70:f741 with SMTP id 006d021491bc7-6b0d690bfc2mr5364333eaf.28.1786723478104;
        Fri, 14 Aug 2026 09:04:38 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1156:1:c8f:b917:4342:fa09? ([2620:10d:c090:500::4:a11e])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6b0db240128sm2104198eaf.13.2026.08.14.09.04.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Aug 2026 09:04:37 -0700 (PDT)
Message-ID: <7e1a7fab-ea77-4373-ba7d-a3ce5aa73ba1@davidwei.uk>
Date: Fri, 14 Aug 2026 09:04:35 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 4/6] selftests: net: add multithread client
 support to iou-zcrx
To: Juanlu Herrero <juanlu@fastmail.com>, netdev@vger.kernel.org
Cc: io-uring@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, kuba@kernel.org, asml.silence@gmail.com,
 pabeni@redhat.com, shuah@kernel.org
References: <20260814012348.46958-1-juanlu@fastmail.com>
 <20260814012348.46958-5-juanlu@fastmail.com>
Content-Language: en-US
From: David Wei <dw@davidwei.uk>
In-Reply-To: <20260814012348.46958-5-juanlu@fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2026-08-13 18:23, Juanlu Herrero wrote:
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
>   .../selftests/drivers/net/hw/iou-zcrx.c       | 35 +++++++++++++++++--
>   2 files changed, 33 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/testing/selftests/drivers/net/hw/Makefile b/tools/testing/selftests/drivers/net/hw/Makefile
> index 78bb0169350b2..37023ba580de7 100644
> --- a/tools/testing/selftests/drivers/net/hw/Makefile
> +++ b/tools/testing/selftests/drivers/net/hw/Makefile
> @@ -91,5 +91,5 @@ include ../../../net/ynl.mk
>   include ../../../net/bpf.mk
>   
>   ifeq ($(HAS_IOURING_ZCRX),y)
> -$(OUTPUT)/iou-zcrx: LDLIBS += -luring
> +$(OUTPUT)/iou-zcrx: LDLIBS += -luring -lpthread
>   endif
> diff --git a/tools/testing/selftests/drivers/net/hw/iou-zcrx.c b/tools/testing/selftests/drivers/net/hw/iou-zcrx.c
> index 9b62fd0703e61..f793a6c04e412 100644
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
> @@ -85,6 +86,7 @@ static int cfg_send_size = SEND_SIZE;
>   static struct sockaddr_in6 cfg_addr;
>   static unsigned int cfg_rx_buf_len;
>   static bool cfg_dry_run;
> +static int cfg_num_threads = 1;
>   
>   static char *payload;
>   
> @@ -379,7 +381,7 @@ static void run_server(void)
>   		error(1, 0, "test failed\n");
>   }
>   
> -static void run_client(void)
> +static void *client_worker(void *arg)
>   {
>   	ssize_t to_send = cfg_send_size;
>   	ssize_t sent = 0;
> @@ -405,12 +407,36 @@ static void run_client(void)
>   	}
>   
>   	close(fd);
> +	return NULL;
> +}
> +
> +static void run_client(void)
> +{
> +	int total_conns = cfg_num_threads * cfg_num_threads;
> +	pthread_t *threads;
> +	int i, ret;
> +
> +	threads = calloc(total_conns, sizeof(*threads));
> +	if (!threads)
> +		error(1, 0, "calloc()");
> +
> +	for (i = 0; i < total_conns; i++) {
> +		ret = pthread_create(&threads[i], NULL, client_worker, NULL);
> +		if (ret)
> +			error(1, ret, "pthread_create()");
> +	}
> +
> +	for (i = 0; i < total_conns; i++)
> +		pthread_join(threads[i], NULL);
> +
> +	free(threads);
>   }
>   
>   static void usage(const char *filepath)
>   {
>   	error(1, 0, "Usage: %s (-4|-6) (-s|-c) -h<server_ip> -p<port> "
> -		    "-l<payload_size> -i<ifname> -q<rxq_id>", filepath);
> +		    "-l<payload_size> -i<ifname> -q<rxq_id> -t<num_threads>",
> +		    filepath);
>   }
>   
>   static void parse_opts(int argc, char **argv)
> @@ -428,7 +454,7 @@ static void parse_opts(int argc, char **argv)
>   		usage(argv[0]);
>   	cfg_payload_len = max_payload_len;
>   
> -	while ((c = getopt(argc, argv, "sch:p:l:i:q:o:z:x:d")) != -1) {
> +	while ((c = getopt(argc, argv, "sch:p:l:i:q:o:z:x:dt:")) != -1) {
>   		switch (c) {
>   		case 's':
>   			if (cfg_client)
> @@ -469,6 +495,9 @@ static void parse_opts(int argc, char **argv)
>   		case 'd':
>   			cfg_dry_run = true;
>   			break;
> +		case 't':
> +			cfg_num_threads = strtoul(optarg, NULL, 0);
> +			break;
>   		}
>   	}
>   

Reviewed-by: David Wei <dw@davidwei.uk>
