Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE162486640
	for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 15:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786722637; cv=none; b=rs5gYMqp3KDjbAJHC5yWHQ/8QVSGC3B1mx3S/eWmz3uaKipvYNWkPOMw4fegPbxTRdbqF2caTE0dOcxhYzdBNrYx8lbirsl1sqviOsurizosXleNIN0I+XuhalLuk5de5bKRbU55Kx6V7Q4HYRVnnQLuPwSLBC/Lg8uycVNw/fU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786722637; c=relaxed/simple;
	bh=fylv9N5GG8WON01Ni6+SzdlApu1Tt/sl3B5ACfe67+w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U6cg8u3k5MpjJFIfwl9h2zkyzE+YzD8I/cxLAlwfJBrrpgdnDPVXNSyXEXHO0NYVZbwaHtapxzvtZf9z+FRkwU3gQbluceVqUF0G3+cU8icrG8H69e9/Ji5SM6bBmSEJ9D9y/qGQqiEQ/ncpCTtE7wvALdqtG8xCY2FgtDzn7V4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20251104.gappssmtp.com header.i=@davidwei-uk.20251104.gappssmtp.com header.b=zf0BWdEK; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20251104.gappssmtp.com header.i=@davidwei-uk.20251104.gappssmtp.com header.b="zf0BWdEK"
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-7f3a9779782so764287a34.1
        for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 08:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20251104.gappssmtp.com; s=20251104; t=1786722631; x=1787327431; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6UWw9B4B1zgG/vzwCp5+dWn0TyEBoX3jbzAzU/meOxQ=;
        b=zf0BWdEKWohUmZqlM6WENFM9JEYKZCwoHQ401UYB397JJj6/YYKeEIub5DeiVL2gr/
         +vK/AuedxQMlETT76QI7gwpJtC5NWuSmXT0AkEkDZSE1smdoVr7PxBo1E0PQmGAPg7EJ
         8XOYG/tK9Ih71CzwMziU0AnAhlYs+SF6lLfYQbR7dqECNLXWUqxlOf+M04xckYHX4hLr
         O0smXHtPXPsPpXNPAiRtQ+2XNyjABnwK5YSaxfzIwjMjKN+Jp2iWvLmXXYnX/2mP77CF
         1SbEq5Zcs7cwdjC5HHAjx31szpYb2alBJMCAj+UZ2BPUQsObRahDMpnbQcsfLQq8hEKe
         cyDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786722631; x=1787327431;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6UWw9B4B1zgG/vzwCp5+dWn0TyEBoX3jbzAzU/meOxQ=;
        b=UnmFmrevwq3caKSb43CEQ169s72iZd20HYWZf1ODzdDR7oerlcYmCo2ZsyHtN7wtQa
         J2IHhOS+CkDYBdvDIW8ssXUVRs4zUwUSeVHzErclyHDIeM8Zag9G3LMh91t068L40U+L
         t89pYIEoCXlGTIZs+YiXoz55znKd9NhtxlC5QkgHl7v4sbEQjntUQONCGKQ5W3EpbBkT
         urSpy0sg5ZCwgxHSUmPOPtG/IRLRUqz9Q5d2o9ke/edisQdDQURc5y27E1qJ1/DayyAJ
         4D4/oCYpaxktHMudNN1DCaepqhiQ5hS3kNLdfs+fpaSFhQwRBLxCcDwO6HL44nI1XNOP
         ot1w==
X-Forwarded-Encrypted: i=1; AHgh+RplLgrwn7yfT/ZYGbZt8yEzSYN24sAamqfI9KsoNH+jdafPdGHZPEy1k0ZyLsUCTBvwXhgqBs4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwstMJpJXZMoR+7hv225qAcoq66UWJzSBhqFWptaBZF7ACtcA9l
	53GPqgzp3NMY+DKkwB3V5Wv2AdTQ5Hxw2Y2I/QmLTIdpUVbsgcJdcghB+NZCjXYE5RA=
X-Gm-Gg: AR+sD109bpkmOHmkOUcwk/MAcQdZXqqZXnFXKmMqRCYSA8k8Z37Tqk69wXom5pJCqJi
	AgyMaqZ9Ncv2xp5YqaeH2khYZMwF4qf1QKibAZrP3N20ku5sdK+i0l8lUYvbXPoGG94TO/sg0PH
	V8FyEA69Spn2rDnt7TWnVyBg3P8jJGLLCnstiYGK5Tfof9Bd5iTBKBShHnk98kIC8p2UQ45Thyc
	kJ1HSu73eku8vqbGiZej08/T/kSf8GnwlMaHLvlrHiBwV72ljP/IJFYYTp6yTfkJNVYoWP2TLwl
	ifkFM67T9vAknbhytM+hJqJbMcCZg39gEOSCENfoMqImcc/jC4bKOk41BZknH4ocIfQLkiv7Qvi
	yvB2dFPno3BL63M1GHYbJgza+s+nq9krxPsfKqQ+khoGzZx/Wi9kX6qVzwnTh1PRVPxDibpLUK2
	UTMMQShD0jWEGl67rO4/1rxocYWyVlqJJapRQSJ0Q0DMeD7Z0dsc968o8Cn0mBwp9KfPu4rULV6
	iKbm11v7ICOkDEm9ddBTbXa/DqAE3mDNQ11GoT1Y1l+d0W4Uy4ggGsep9tpvA==
X-Received: by 2002:a05:6830:3692:b0:7e7:8dc0:3951 with SMTP id 46e09a7af769-7f3de51da19mr5494859a34.8.1786722631567;
        Fri, 14 Aug 2026 08:50:31 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1156:1:c8f:b917:4342:fa09? ([2620:10d:c090:500::4:a11e])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f3e849478esm1158487a34.6.2026.08.14.08.50.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Aug 2026 08:50:31 -0700 (PDT)
Message-ID: <34915029-869a-4a5a-9bde-060a9a6eec20@davidwei.uk>
Date: Fri, 14 Aug 2026 08:50:29 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 5/6] selftests: net: add multithread server
 support to iou-zcrx
To: Juanlu Herrero <juanlu@fastmail.com>, netdev@vger.kernel.org
Cc: io-uring@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, kuba@kernel.org, asml.silence@gmail.com,
 pabeni@redhat.com, shuah@kernel.org
References: <20260814012348.46958-1-juanlu@fastmail.com>
 <20260814012348.46958-6-juanlu@fastmail.com>
Content-Language: en-US
From: David Wei <dw@davidwei.uk>
In-Reply-To: <20260814012348.46958-6-juanlu@fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2026-08-13 18:23, Juanlu Herrero wrote:
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
>   .../testing/selftests/drivers/net/hw/Makefile |   5 +-
>   .../selftests/drivers/net/hw/iou-zcrx.c       | 262 +++++++++++++-----
>   2 files changed, 195 insertions(+), 72 deletions(-)
> 
[...]
> diff --git a/tools/testing/selftests/drivers/net/hw/iou-zcrx.c b/tools/testing/selftests/drivers/net/hw/iou-zcrx.c
> index f793a6c04e412..008d3f4b76263 100644
> --- a/tools/testing/selftests/drivers/net/hw/iou-zcrx.c
> +++ b/tools/testing/selftests/drivers/net/hw/iou-zcrx.c
[...]
> @@ -289,12 +279,13 @@ static void process_recvzc(struct thread_ctx *ctx, struct io_uring_cqe *cqe)
>   		error(1, 0, "recvzc(): %d", cqe->res);
>   
>   	if (cfg_oneshot) {
> -		if (cqe->res == 0 && cqe->flags == 0 && cfg_oneshot_recvs) {
> -			add_recvzc_oneshot(ctx, ctx->connfd, page_size);
> -			cfg_oneshot_recvs--;
> +		if (cqe->res == 0 && cqe->flags == 0 &&
> +		    ctx->oneshot_recvs[conn_idx]) {
> +			add_recvzc_oneshot(ctx, conn_idx, page_size);
> +			ctx->oneshot_recvs[conn_idx]--;

This needs an early return. Sorry the bug was pre-existing but I just
noticed it.
