Received: from mail-wr2-f26.google.com (mail-wr2-f26.google.com [74.125.225.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D6223B71DC
	for <netdev@vger.kernel.org>; Sun, 27 Sep 2026 19:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790535820; cv=none; b=im+hzGt038HlTmbRaHCCyqD+y6W9Mkv/O3LFjH1H64M46PAkA3WD2DQx+pxSNhtU2gYZPsTCAsf6hR2R+bazpC+tvUXVmbR/Y9EtqA+vCh9qjOW/UE03yIKX0euoHMeDZnKb+q68mB86/Ix5CjmaOdCCdRS9UAitBpzVmHT/Wr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790535820; c=relaxed/simple;
	bh=iww9Rrw/7xVmPZYqt+U+P9KcHpNhKk1XEZ9j0Zir8vA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jm9v/CSfYnFh6HCBwU4EwiZyLzm+Ka5kqJUA/1pe6GuMTpkCMsh4Xl1pJYDWGqTKGN3oM6oGviMyRaDrqh2XPLgrPKzs6lpTf53H6wj8iOW+rmKxl4iADnisDj0bnf1NybQR/xrjV6hVqCuS8Utct7jHkgzy4rnT/MQGOBakrN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=snNZyDmN; arc=none smtp.client-ip=74.125.225.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="snNZyDmN"
Received: by mail-wr2-f26.google.com with SMTP id ffacd0b85a97d-4843f22dc83so1968037f8f.1
        for <netdev@vger.kernel.org>; Sun, 27 Sep 2026 12:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790535816; x=1791140616; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hyA13uQBPobSZN7QEDfmz9E3dETz4qLP4md8sLtn8EE=;
        b=snNZyDmN31vH2iWiTXD1dogUrWuUcObLz/Egz0tuCZ42V76I5nrwJuAaE2Fw9R/89N
         FBDrSSBtHJcKk2ACMWA9bO3AYJ70k12dGtBIQW2ahbm3PgzLAyWWzGvZ3GJilIdVHgE6
         mQvBjppBfXrpHpAjzZXoWmyFUdfi+aDwYtYvRQEMzOTgIxJ5ygIVLmdi+b7IjpG6yy8p
         aGuObClTT/kPyCXoofYznF5SbSqh+5MfkGUfL++y4YqPCy6R5XjSGtb6Ufm8Fg8bTLu2
         VdFyOMKuCI81gHHxAXqE7Rm/Lzwt8CYssabJUX/bovswdrZ/8QPv2MZLpblR0QXtaVdJ
         tw7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790535816; x=1791140616;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hyA13uQBPobSZN7QEDfmz9E3dETz4qLP4md8sLtn8EE=;
        b=t3yiu1CllQfUHAPgd7AlIOSB/EGam1kzzMbg+5+8nz2WNnmi1FV2kd5PH3USPMyF44
         U2kHrmxPg8EEeckaV6LgsjuNVRYWO1o9DCJDfvl0yvF17dz2areobH3DJ1yfEZEC/c46
         jbzsTHpU8MmFbPqih2KaiZvSWwT9uEEd27BqUWDiuqRzRzR6StyvuMKHjjr+U9nue9zz
         SF/hKr+eLonV6f0bINMFwR3ZeYOBWaCjrEHaOCEQfCmP48lb1NCnNzZjx8BfzuagaoQd
         1U+cvL+Hw71RiSYZSePR8HWDkEuiNriFbEhuRlFwe0wJam/WkRObr+a8J42GzL67wZGa
         nhYQ==
X-Forwarded-Encrypted: i=1; AKwUvByik5bg0/nem3LPtV1/MlentynE9mXS2RRwur4bDFcIK5F9c+ttA66jKm4MQxdizG6O9fl7ERM=@vger.kernel.org
X-Gm-Message-State: AFq9FYLSf7rOvwmvliKv202mNzOu/touRvLaON3ExdHwHnTnBG8nGiYO
	aU1GRvL0Q4YqiSouHWysGBQc0V7jRzUk4JUuAjkoStApxSoujnxlJ26h
X-Gm-Gg: AYBFou2GCqaFDJ645tEjyCWiPqozpCmnGo51tLC02ULGvECf+lsOp1yey30KsUoAOJn
	GkHgLAii3GnGBnsVyaWtIhifLDb4udelzu3/2Q3zKxDJKwoC5TBAHxjEBxsSfdA72U/g1x/nYKL
	051RDN3urRf753cBm8XWpd+Vwa24v3/RQughB+r6i9cSlPDAO/k7ZYYbRD/5prk3smn77qbI0SH
	tfR1q6HkxBTsKbFMo222eyUqEEd56+zLQNYDHMUbvzMdF7mw+/69JmYFUA5RCWKum+iPSY3p5Tt
	Z6QpHOotG09w5OzesdA6a18szDzBs1lSHDOGHTT52oFzm+SyIE9zdLVNZgdHtIWkTU0uLppZg01
	cXRRRU8+CE8JnEmPR+dmPtnBpe80S3RRlHOO4jFpLQ3JnbhJzo+2bZatKg/DRxSfwiU7yyktZhd
	728jvvR2lh3glI963ti7wTaBPJXL1Jou5qiVlaRnIiJixzn0mJyFJ1zu2lMC2xwwVfe5sSLRRdx
	1xv3NSrvWLHJEgZsSkG7tgqdKUGXR382CDU2Yknw7Qg9MfRit5hMZteVf3N2GjK35mRuuSTdHDR
	HvzpFFrpe0UOSjESRxSztc1KCNXTeSR9eaDd/umPuiliOpMqTCpc0ZydaNk=
X-Received: by 2002:a5d:5f08:0:b0:488:89af:e95b with SMTP id ffacd0b85a97d-48889afec11mr7503670f8f.8.1790535816106;
        Sun, 27 Sep 2026 12:03:36 -0700 (PDT)
Received: from ?IPV6:2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c? ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4887a349a0esm30979151f8f.10.2026.09.27.12.03.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Sep 2026 12:03:35 -0700 (PDT)
Message-ID: <5b65f83b-d30b-414c-bb71-197f72feb367@gmail.com>
Date: Sun, 27 Sep 2026 20:03:34 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] io_uring/zcrx: requeue multishot receives stopped by a
 local resource
To: Junyuan Feng <a@lollipopkit.com>, axboe@kernel.dk
Cc: dw@davidwei.uk, io-uring@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <010001a0cd914529-23df2f94-bbe0-49cd-ae5d-05922356fa12-000000@email.amazonses.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <010001a0cd914529-23df2f94-bbe0-49cd-ae5d-05922356fa12-000000@email.amazonses.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/23/26 10:20, Junyuan Feng wrote:
> A multishot RECV_ZC can go idle with unread TCP data when a receiver-local
> resource runs out. An empty copy-fallback niov freelist returns -ENOMEM;
> a full CQ returns -ENOSPC. After partial progress the stop reason is
> lost: io_zcrx_copy_chunk() and io_zcrx_recv_skb() report the copied
> bytes, and tcp_read_sock() drops an error from a later call once earlier
> data was consumed. The edge-triggered request is then not requeued, so
> it cannot consume the remaining data until another socket event arrives.
> 
> Record in io_zcrx_recv_skb() when a walk stops before consuming the
> length it was offered, and requeue if the pass still returned data. The
> failed chunk is first on the next pass. The resource is usually still
> exhausted by then, so that pass fails at once and ends the request with
> an error CQE, which the application must handle by re-arming. The
> request does not spin, and the stall becomes a visible error. Keep the
> existing skb limit and SOCK_DONE handling.

Looks good

Reviewed-by: Pavel Begunkov <asml.silence@gmail.com>

-- 
Pavel Begunkov

