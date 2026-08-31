Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C31B370AE1
	for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 18:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788199800; cv=none; b=Ixg8lLOcFEojcZNR853W2NkA/nkfOYlw67kozmyAyKb5dRtClSb3CQzT+kFozhs4Vm1ZESiAutuIxYov0+e3A7wSDZWy226xaNjn7TtUdCU2QhwYmQ/6vZ8c8il0Y8e9dZVANLClv/S0jH+mnpUze8MXGeQZL626GsdqmQJysV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788199800; c=relaxed/simple;
	bh=OUMY53HyrTCqQnkA8KrBjrrWVSQyECdBkTmSBNMfXJo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TeDi90TLxN4vvUiOay77iDcFMbPU08ggOHcMmtYC52eBdLDdED5+ipW+IgSCs8vbLOuSyv3mmiTq0Klt/vU4NTTmdGyyNK8Uuxp6kt/OPERyserlGUkvnf050My2n6gujprCPPSmx+aaOknFgkh6EuWVytlpxeZNl8aTUsgZ030=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20251104.gappssmtp.com header.i=@davidwei-uk.20251104.gappssmtp.com header.b=csx5e/cU; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20251104.gappssmtp.com header.i=@davidwei-uk.20251104.gappssmtp.com header.b="csx5e/cU"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-381b831d535so138525a91.0
        for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 11:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20251104.gappssmtp.com; s=20251104; t=1788199799; x=1788804599; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uFdfHylOXjETtPhdnLAsv7jcCEOZVeZCY1hqt4pQN3M=;
        b=csx5e/cUTC33Kr+U+h4jgBT5/yiteflcmuwWSHhkMWi9g0gM8tTHH9di6/lcLZYXkS
         I1zWbRAXjoYsNWWZ8jelrHZr/MgXrRG4T8DJHiafUft88BhbYF+x6onvy+nEAnQJCXWn
         IkNBv8kg5JcTux6hnulY8e+bNawzjj9xPJ+/0viInPRRzwsFqnrj5SYaYJob/PncA6o8
         NBZScSGfJrvzhglcfyCUGjvu0noBtYxBjziFAV4pY1aFUswElpSB3I9VIkgCorjtF8TN
         km+y1/Ma7dw1azRgBBjcPmsp0K/rfXGGYMnNDxAUFw/fK20avEGE0wMleTSBTu9Y1Rca
         r5LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788199799; x=1788804599;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uFdfHylOXjETtPhdnLAsv7jcCEOZVeZCY1hqt4pQN3M=;
        b=rl3GT0g5BDkwhEYV1wjyQXE22UVlv9+8qxsxbRAPKMywBpKCXaBmC2t6dAuQPr21Q8
         evxDESsQGi4mDzGt395yDWmz5+XTHbEaWdnYB5LYoUGZ4rJMav7bD70R2Rpcv54f93xH
         vdkDPK2FGIi9AN4A+D7/tTIF3LKd6Qk6le4opL6+ulqc0qLVovOQPX/b4oxCMgAZeBCJ
         Gs+C6mP5mdwl9FfrGdPVirVDYft1go4ln8QLBXB73pllwAIIqxkaW6oKshXlqKVbsrKI
         pCMlYLKogYuJUA5ck4fLIvz354pR8RQXIEe/nQjJ36sZQbn1mXGABArtRo94zpuRyZEq
         GEiQ==
X-Forwarded-Encrypted: i=1; AKwUvBxBrXd6RynV3119X+JGcq17CVP5vprQAXEOu9WDgX1tcbwjs8P827YAya469rvwuEEx6jG6lRA=@vger.kernel.org
X-Gm-Message-State: AFuF++kd1YvIsZRLHp0krmGvTezB6P2TR3QMF//GP2fPRwh+5vkUZ/iT
	hD8eIoMvbDFcC8tCcAa/iF4Jgj1F+zQ99xJVDyQZS3q8udlk4K0a5T9LW/5gQl3+aq4=
X-Gm-Gg: AYBFou0l5Cp18XCbp9T7xZLtA07BAhS+bvFjtE9ugRa4Ybs85ajpkG/vrBcs0M4TGym
	icE4pPbfSxH7qnTIiuAaIjFZwVrHk7hc/VMuO4EqgFhbuHvfJiFhmNZD40kQKPlAZ5VvQyPPvij
	F9DJrnTnvTi3UOjyiMZ0s5e/9LOMOB0nJhY/DsKEYbZj/a3uLSrCFw5eDDS+LWBIK3VuMaz9i0Q
	ruaittQeM5aUKuDCEVOjplK2+xD8W5wHHUVnbJJACK2vC2Mn6cIJSLrMS3CJ26pgLYLhE43Hsvw
	YcbyGLUwJxiuMeKFB8y4ysFtjdPjtkcTymU89w9oe6RiWsKgRltrEmm8Bbs8q8UAoMaKI7nVjv4
	mxkYnrfmIG5sQWQ04i8hpMlZskqy/b4gaaeAhm8rW5d8sgLkI7wffN3ifxrQTzUvE0os1O52HP0
	8lN5CtRNvvFohvRlmuCNwktHclOszEjtt6JfnQQDtip+j6EEKGmaKWfqmtMbBsKnas0MU3+X8EB
	8xbdx9FI4PYCPpkc6u1Ytm7N+KxS3lY8HZYVC7ixWSOqF1kyKT2ydk1pO2vCw==
X-Received: by 2002:a17:90b:5102:b0:38e:70d5:b12d with SMTP id 98e67ed59e1d1-396d0ea862fmr45975458a91.6.1788199798914;
        Mon, 31 Aug 2026 11:09:58 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1156:1:c8f:b917:4342:fa09? ([2620:10d:c090:500::7:1753])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-142e0de4de3sm41695477c88.12.2026.08.31.11.09.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Aug 2026 11:09:58 -0700 (PDT)
Message-ID: <4388edf9-7248-48e6-876d-daf3bff39e7c@davidwei.uk>
Date: Mon, 31 Aug 2026 11:09:57 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 2/6] selftests: net: remove unused variable in
 process_recvzc()
To: Juanlu Herrero <juanlu@fastmail.com>, netdev@vger.kernel.org
Cc: io-uring@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, kuba@kernel.org, asml.silence@gmail.com,
 pabeni@redhat.com, shuah@kernel.org
References: <20260831-iou-zcrx-v6-0-02d1d012f0fd@fastmail.com>
 <20260831-iou-zcrx-v6-2-02d1d012f0fd@fastmail.com>
Content-Language: en-US
From: David Wei <dw@davidwei.uk>
In-Reply-To: <20260831-iou-zcrx-v6-2-02d1d012f0fd@fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2026-08-31 10:34, Juanlu Herrero wrote:
> Remove the unused `sqe` variable in preparation for the multiqueue rss
> selftest changes to process_recvzc() in the following commits.
> 
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Juanlu Herrero <juanlu@fastmail.com>
> ---
>   tools/testing/selftests/drivers/net/hw/iou-zcrx.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/drivers/net/hw/iou-zcrx.c b/tools/testing/selftests/drivers/net/hw/iou-zcrx.c
> index df6b62204343..c6dbd0ad5368 100644
> --- a/tools/testing/selftests/drivers/net/hw/iou-zcrx.c
> +++ b/tools/testing/selftests/drivers/net/hw/iou-zcrx.c
> @@ -269,7 +269,6 @@ static void process_recvzc(struct io_uring *ring, struct io_uring_cqe *cqe)
>   	unsigned rq_mask = rq_ring.ring_entries - 1;
>   	struct io_uring_zcrx_cqe *rcqe;
>   	struct io_uring_zcrx_rqe *rqe;
> -	struct io_uring_sqe *sqe;
>   	uint64_t mask;
>   	char *data;
>   	ssize_t n;
> 

Reviewed-by: David Wei <dw@davidwei.uk>
