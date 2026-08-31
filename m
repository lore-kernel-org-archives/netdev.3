Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D077939A4DC
	for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 18:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788199791; cv=none; b=CDR67FenW+lX20Onfbel6Qtf34ExrdcuuGWfUdFgntGZo1aG9iicwlzPRvjI64QJzLXqJWwA0Vsbinkx9pXP6FkthtBooHJOmpEJVzTAvfegfd+vTC01/GdU0oO1EhynpXJ0Ora/red4WExrg3DgmTsXJjWqwasbKQ5eKXKKeJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788199791; c=relaxed/simple;
	bh=UJIjx7Nd6UnwIEMkfyx4MKf4iq09kir0HcuQtcBrn2c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pN41Y4yQ4azaO7/91DVI0YUFIhqiPNB4rOMtMKcX75KXQckxfClBbV+GyvwvlWsG1rm8MBDuTRgtLneT3yXwO8/Yt9VtK7jkNoI1TxF8OdgsU19poiJuoDiQTx4212V1J9g3i8bULIMqqqUP2qHF/mF55hR9wIrckFCwvzWuYfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20251104.gappssmtp.com header.i=@davidwei-uk.20251104.gappssmtp.com header.b=iVEvvpsU; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20251104.gappssmtp.com header.i=@davidwei-uk.20251104.gappssmtp.com header.b="iVEvvpsU"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-cc1c3d79b9bso3370494a12.3
        for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 11:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20251104.gappssmtp.com; s=20251104; t=1788199789; x=1788804589; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nC5kpux0BtJotabIv7/q6ESBCBij/ueWvvNCaE5KD0I=;
        b=iVEvvpsUvxnmcRK29ZjpZSEpPEm2vClhvxxeTzdnVeei7KCow9+0xf8/AZjeIDHqDr
         cLulgo2a4L0lBiTu7C0mdT7nnVVnnGI5Orp3ylhNsKQwwuHtfjEcfKaE1z91ACuS0V6P
         rJnCZwnmiVF4oMzr7w/hoAZ+OmaVWpvyfyRXI1bXINhuLhsySUWx4/s21KjMeqGYbgZ+
         I3OWQG+0HLe801ltuyrQAZr8dyJVrR/N2yU791z3NMzsFg69hfpIFFcs8NyQGxnDE0+Y
         V56ktEZuxcFtxkbqLFzJwWbBWE1bkrBxqpfagWnqQ6ueOKA/6flMppmw8aOBZr19DpGz
         tEuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788199789; x=1788804589;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nC5kpux0BtJotabIv7/q6ESBCBij/ueWvvNCaE5KD0I=;
        b=mzINnZ7BlWJoDhE+8UvnPy8XSNFxYsyOgGpMbFLzFrf9qp2Q1kvg4w4Xpk8FHwg48C
         z3H3KnSFN5ztVPbW5h/lx7ubGdeNmf0JUA6ybsAMJEePhuxkxJPOWCJ64QeRvvYr6PGT
         1UOVU2zNxITja93vS33tsqfHhnNsPnxsA0XgWISmqRqleYFzGcJJwvgAjdU4WcrCNHa3
         QzROTJ1h4PuZUypC2qmkDGF53gcZjNsKvDJoSE1GIWcC7WvXPOwOEJrEBPMjgPfKPPB/
         gQq2uhhu0qKo8q3sPv+qI2w9PO1d9WSqoEumAnNkgjBFUTV0L/ytkFZevEzf8OnOWksh
         ElfQ==
X-Forwarded-Encrypted: i=1; AKwUvBxz6aR0fHJdmeoP1RNaWSothiV1UGGY/tDmZum+gaEVokL3xy+X75USUe06vKDhWgQul0DWj2g=@vger.kernel.org
X-Gm-Message-State: AFuF++mPBAP/Hy7oH860hqOt1BUs3sezx76Hk5jn6FStqkpjZJCIb4E8
	KS0QrEZSLfddYDLlW+B5UhpsV0A0J5rWoJg5uDBA/zpcRlQHOFfpWnNFRO9BLBw/ZICAf3/aLA6
	qMiQbuh4=
X-Gm-Gg: AYBFou2P+a1JXNOBxOaOpHoY4GM3NQNf8ocuKkYpo0TllOaXHaLfkGs7DCm4V8bjbDN
	E4Empn3OmDecHRZFVMIbCSBL+ZYZlEdLH+02fKPtrafnt+kJyPbFloZDo3ZmxCXqgjTLs2cDNBb
	xNutlumSa24WpJXbns0X/j5kmj2VotE532TndQJ2I/2J8XvLlAUr1jy2UHAUYTCHozTAS1YCjCz
	OgISXZuG2bxt6sPUk2kxZc3xWq/4ZGZ89YtEmQ/WSlSC6xdl5PJIyNijFMGL7hh3U4wskBH0dQt
	fBonaTc9iSVVPdJ5m56Suz5SqNyIb0BcIu1QxDF47/UiGudk7XQ2fmDO1K42r+RItJhMwJNbSay
	iOnMF6BQeT6zdVtN6zYM/bbfN3yCG6ImmlHgh2iqzI3ednOOi+ip0DZyLqvbZqAiuIxZlI5RrQo
	6BNzZiy+jUUCowVCYOBklyVj7CfLq1UcamAOCd7zX464tx762ej0AXhraIKUVPI4s6uOd3uotWp
	l2VkurGgKBkTDGlO9BHuOB/BNwZnS6E75sjCG1Jb3MWEs1Hg1zLmPiw8TLpkA==
X-Received: by 2002:a17:90b:2f4b:b0:398:a486:81ec with SMTP id 98e67ed59e1d1-39907b77747mr3516597a91.11.1788199789044;
        Mon, 31 Aug 2026 11:09:49 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1156:1:c8f:b917:4342:fa09? ([2620:10d:c090:500::7:1753])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3286f9e2a95sm30252869eec.23.2026.08.31.11.09.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Aug 2026 11:09:48 -0700 (PDT)
Message-ID: <25f25b5c-fbdc-4bd5-ba97-85248ea8d421@davidwei.uk>
Date: Mon, 31 Aug 2026 11:09:47 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 1/6] selftests: net: fix
 get_refill_ring_size() to use its local variable
To: Juanlu Herrero <juanlu@fastmail.com>, netdev@vger.kernel.org
Cc: io-uring@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, kuba@kernel.org, asml.silence@gmail.com,
 pabeni@redhat.com, shuah@kernel.org
References: <20260831-iou-zcrx-v6-0-02d1d012f0fd@fastmail.com>
 <20260831-iou-zcrx-v6-1-02d1d012f0fd@fastmail.com>
Content-Language: en-US
From: David Wei <dw@davidwei.uk>
In-Reply-To: <20260831-iou-zcrx-v6-1-02d1d012f0fd@fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2026-08-31 10:34, Juanlu Herrero wrote:
> In preparation for multi-threaded rss selftests, fix
> get_refill_ring_size() to use its local `size` variable instead of
> assigning to the file-global `ring_size`.
> 
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Juanlu Herrero <juanlu@fastmail.com>
> ---
>   tools/testing/selftests/drivers/net/hw/iou-zcrx.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/testing/selftests/drivers/net/hw/iou-zcrx.c b/tools/testing/selftests/drivers/net/hw/iou-zcrx.c
> index f6a8fc5fac24..df6b62204343 100644
> --- a/tools/testing/selftests/drivers/net/hw/iou-zcrx.c
> +++ b/tools/testing/selftests/drivers/net/hw/iou-zcrx.c
> @@ -132,10 +132,10 @@ static inline size_t get_refill_ring_size(unsigned int rq_entries)
>   {
>   	size_t size;
>   
> -	ring_size = rq_entries * sizeof(struct io_uring_zcrx_rqe);
> +	size = rq_entries * sizeof(struct io_uring_zcrx_rqe);
>   	/* add space for the header (head/tail/etc.) */
> -	ring_size += page_size;
> -	return ALIGN_UP(ring_size, page_size);
> +	size += page_size;
> +	return ALIGN_UP(size, page_size);
>   }
>   
>   static void setup_zcrx(struct io_uring *ring)
> 

Reviewed-by: David Wei <dw@davidwei.uk>
