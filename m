Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AE171A681E
	for <netdev@vger.kernel.org>; Tue, 28 Jul 2026 01:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785202576; cv=none; b=o65gagiMlHqH7hxF15c4qFs9j4WAoL/9+/NU7Ln0N92LbqPLuVsNjUUzxr1fu2WoqBchbZ717jyY6yTerf+tUCSGVNVjcZO5WrMY+sxVPpbl2hLlhVRiD9kgCp5Dw9eiQ6jjSiLp6r8jsBqOOUda4fEhrAee8SxjWeLQC5xy9+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785202576; c=relaxed/simple;
	bh=6rX4WFeQEHGnscTyERlQFU8CdsEMVNgtrPU4t0Fwem4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=USKsul0r80IQHKIYvxVl/IpnmG9Eal+Zkuu1Uszr6wSUGPKlDxK0y4amNvy/Cf085cUWa/mhd6Gc0pS/zkNorbnvhd6ObkpOkQiY4HQrWpFmXA/NuyUbWrdJAwt4JlgodGEoeo1WzoDlowImYDeqhVI4VVo6m65e8J2I/buvu0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BIC+nLBD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BIC+nLBD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 682011F000E9;
	Tue, 28 Jul 2026 01:36:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785202574;
	bh=rl3RU1qfkcjyRTgbTEVZf+DVOhKxRhpgk60mSo9PWW0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=BIC+nLBDaCUYxgFHHt11Js/K73nPxZXYxIwBn+RJo/coQc8vqVPBZFDF9vGwwKtYw
	 k11sPkJljg+VMsPJs4HyEaQeGzGzn0laM0BGm/xu2IojGHRT05sNPiR3d0gC2UuXMM
	 ELbRv0jjpCElzCvd8NbnceGedYfJ7FloaClNn2etxloODBgybH1Ew4Q4qaP3CHgAHX
	 ON5AJD6/5bD9jfFRpjH4lOmh2xfqOPbCbNeAqQ+eGvKh+CJ+Dt1sIpkhJlCQdXIKF5
	 ldZ6KMtKe+wIJa3MdgGJY6szB2WV3s1s4+kfYTYFDDEBWT5gPi8A1/IRz/uI3R91lL
	 7yhJd9GakxB7Q==
Date: Mon, 27 Jul 2026 18:36:13 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Juanlu Herrero <juanlu@fastmail.com>
Cc: David Wei <dw@davidwei.uk>, netdev@vger.kernel.org, Pavel Begunkov
 <asml.silence@gmail.com>
Subject: Re: [PATCH net-next v3 5/6] selftests: net: add multithread server
 support to iou-zcrx
Message-ID: <20260727183613.2775fc23@kernel.org>
In-Reply-To: <20260722203950.58550-6-juanlu@fastmail.com>
References: <20260722203950.58550-1-juanlu@fastmail.com>
	<20260722203950.58550-6-juanlu@fastmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 22 Jul 2026 15:39:49 -0500 Juanlu Herrero wrote:
> Run the iou-zcrx server as N worker threads, each owning one receive
> queue with its own io_uring and zero-copy receive (zcrx) ifq, so the
> test can exercise multi-queue zero-copy receive.
> 
> The main thread owns the listening socket, accepts connections, and
> dispatches each to the worker owning the queue it landed on by matching
> SO_INCOMING_NAPI_ID against per-queue NAPI IDs.
> 
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Juanlu Herrero <juanlu@fastmail.com>
> ---
>  .../testing/selftests/drivers/net/hw/Makefile |   8 +-
>  .../selftests/drivers/net/hw/iou-zcrx.c       | 297 ++++++++++++++----
>  2 files changed, 237 insertions(+), 68 deletions(-)
> 
> diff --git a/tools/testing/selftests/drivers/net/hw/Makefile b/tools/testing/selftests/drivers/net/hw/Makefile
> index 3cab3b4adbb2e..946938371c763 100644
> --- a/tools/testing/selftests/drivers/net/hw/Makefile
> +++ b/tools/testing/selftests/drivers/net/hw/Makefile
> @@ -7,14 +7,11 @@ HAS_IOURING_ZCRX := $(shell \
>  	     'int main() {return 0;}' | \
>  	$(CC) -luring -x c - -o /dev/null 2>&1 && echo y)
>  
> -ifeq ($(HAS_IOURING_ZCRX),y)
> -COND_GEN_FILES += iou-zcrx
> -else
> +ifneq ($(HAS_IOURING_ZCRX),y)
>  $(warning excluding iouring tests, liburing not installed or too old)
>  endif

why not move this down together with the if condition?

>  TEST_GEN_FILES := \
> -	$(COND_GEN_FILES) \
>  # end of TEST_GEN_FILES

This is now empty, why keep it?

>  TEST_PROGS = \
> @@ -72,6 +69,9 @@ YNL_GEN_FILES := \
>  	ncdevmem \
>  	toeplitz \
>  # end of YNL_GEN_FILES
> +ifeq ($(HAS_IOURING_ZCRX),y)
> +YNL_GEN_FILES += iou-zcrx

Follow the 

BLA := \
	something \
# end of BLA

formatting for the variables, please

> +endif
>  TEST_GEN_FILES += $(YNL_GEN_FILES)
>  TEST_GEN_FILES += $(patsubst %.c,%.o,$(wildcard *.bpf.c))
>  

> +	{
> +		int conns_per_thread = cfg_num_threads > 1 ?
> +				       CONNS_PER_THREAD : 1;
> +		int total_conns = conns_per_thread * cfg_num_threads;
> +		int accepted = 0;
> +		int connfd;

Floating code blocks like this are considered poor coding style in the
kernel.
