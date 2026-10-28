Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793206505;
	b=mCMFaG3irrYhcpc8g9EGfvvKvoT9mtnJbSMT+IYXpsMoqC0Vs0uTVbVxItyAjvlBtQMj
	 uAfPdqyROw7+cpV0uZujrzvuPJAtjCX3Jmz2vG0C9UKTQeiEpxGEd6RGUpSGrZDp0dbYz
	 tSu2RmQDjP9EhyxdFLYXBRPdjI0o1g4OlBibhYUU8M/Pl3LOCPq7zBMnwY4dyv03s7Hte
	 iU8pItfCHW2cvMwnX4dioxaztx8uwQftdcX+6wMqUmOmYmIEsN/DhS8N/QK7Kisv6Klhz
	 wi26V8tLsgSxa+FPnRt2F/Uw2fPfr4btTh76nMfO030nzZwyFyYTj1CijeFGSbz0Ejg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793206505;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=W+LCJYqpb1jh4biWPzp+yPqPTS1QJK29Y+x/nsyx6zk=;
	b=pMgKmU5+jCug6ZUCJG+WBchsVG3ndE4PMraKO7aBbvjBVS+PEcNakKz4wj3i3YFrEJPw
	 TIpbOEeI7mEb+yrLI2TeplbSipa1KrpIbRg+JriPju7H+jwKPEApwAqNm7VS76Ie2ymmx
	 IUSATcPWGutWTC/Moo97hORmrw9DwjfbYByNDZldqlH7c4AfeQdAEHre8ZZ0DgGwVwQbZ
	 62os0eGM6xX0xLUmBaAeg52pI2fFDr9x1RCwa261J6GSQnDrCp4TcZEQkOUUg4HB+bMHr
	 i5k2QW8FzUAOuOq2h5cmgF2H22LxTRdm+trpGRPaUeINDuRT9I0AZlrdjhiNKDEbWDA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=smartx.com;
	spf=pass smtp.mailfrom=smartx.com;
	dkim=pass header.d=smartx-com.20260707.gappssmtp.com header.i=@smartx-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=c5vSMU4O;
	arc=none smtp.remote-ip=74.125.82.181
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ED17606A332
	for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 16:55:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5ED17606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=smartx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smartx.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=smartx-com.20260707.gappssmtp.com header.i=@smartx-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=c5vSMU4O
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-36a17a332ecso1641909eec.1
        for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 09:55:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smartx-com.20260707.gappssmtp.com; s=20260707; t=1793206503; x=1793811303; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=W+LCJYqpb1jh4biWPzp+yPqPTS1QJK29Y+x/nsyx6zk=;
        b=c5vSMU4OlFpJofx8pyh53OYoKfiY201bp+bkEJXfqn7e+hktJysWEkZucR6HjEPfBB
         LDhg+3CBKTEqrpKe0VQPdo4WxW4U+n39wNy2ru5bquFNadzoWRfv182qfvJWGxU/OvIZ
         Vlhp2/P2q8Ljb/HU5UwFLFl4gmfZ5zEcABDGS/p0ws+ULgk7GO4NX4vn8H2AYSvd29Zs
         NXpI+6s24H6auqF5CJaqN32/AbZ4vmJcySvMQndnUHPoouAxBLXAs6QwEua6iarUbB3v
         XK+zJ3YN9uqzQhZVCkV798LASYaWoLBTboPr79DJqitpYzdW9NJx5kIyyZ8lqwjqNQtz
         VogA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793206503; x=1793811303;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=W+LCJYqpb1jh4biWPzp+yPqPTS1QJK29Y+x/nsyx6zk=;
        b=Y8VuircAbve6uCJIrjg2fule5pa2aVM9e5Ei9sqXi9ejMfIgChsWqal8u1b3QKnvs9
         ObiJcLiAQiJLDfkjjVLJlrVgrTdIMniiRKbJQNyUUtJym3/4ne6P35Dku27+pNhazlI0
         VDfGWhJRIT6lzNHYscGDsbqkFC51N3zVuXrD/eT6aNetUXSdvCa9WnflONzZpE9FE6Ei
         wbxY1AwAEFS7AU29/JeWXVg1xHkk2lQSnjh2pvphjxvfELXMaPp2Y144LrzhJXxyQ9Ok
         hUjKsX9gjSLPEhwZtRLJhfc5AFBALvLRLlXK5gybdmB+dLRPu+cwSPun+PWyW2A5BjgT
         KT2g==
X-Gm-Message-State: AFq9FYKN9bNGUw/EWkiz+zvMYrEr7Zlc2i7NeTieDI5T0X47lQ+g6Jlp
	AdHg2NIe53475mKQwj2iX/nbTHQ4XOqSHWLTRKuFdm2FfGEfxKvdJny7gQjtv9Log2Xxn7sxwJr
	0twyORYEt9TX6BzoRJ32FQfgg8oYrWSMKYCg31iSlX42E6mfr95B82R/qXAqZC3FPCRIcIiQW
X-Gm-Gg: AYBFou3ATKwKYhkwdReXP2CU5EFd6FC5XgRq2Tn1bD/bX+2Y/zg0267kSydXQm3DToe
	G6VddfauOOnLPgshDOiBoR+JynTzRzghyie6rPya02qnUKrZLlbe4z8TQhekMZR+KK1tII6kGzz
	a58SpBmp/6aJELNHKkTvAK5wHDyqGswgwiUS+wy2RziRNxkwd4MtxJgVmoLY3PHZ/gW+LqrdFeH
	ZaeF9J+eEPoWZLGPEGg/XfGpYzeC7ns3rkYGZ3YzOi28YEQK97hnjAhsoMqq6PyyQqMNjlj9Bcy
	B8xEP6Yi7/0AFfC4g9k4jMLv9J4avc+Sus/JnHaSgn+3n5CvCwrcViN2KVX3nnzxcNw+0RG9GcC
	5BPbBk6FuOcDLU5xZyk14ALLs0XTpgFbtU/HDlHj/9aVDvME/cwCxovMIOqcEqfYITpyQnK4kpK
	5dFwCLKGLuNLFwZ0sO4RLYaS7R6RJw7MuWyCa01N8xiVb0OkISH6O6HJl9NLrj/RHEz+GGGKYUn
	5/9JkNGrnyTonhEkbXcVri0CHrDUjPTaVdP12JyiQMArKU2csh3XTDIdJ1rKeKh/wTaLhoqgQiu
	3kklyjKCnc/NWG1vnRMDJsxXHYrgojPRrGKAmdxOjbs=
X-Received: by 2002:a05:7300:a210:b0:366:83dd:4704 with SMTP id 5a478bee46e88-36a2014b145mr4102794eec.17.1793206502537;
        Wed, 28 Oct 2026 09:55:02 -0700 (PDT)
Received: from localhost.localdomain ([23.148.204.240])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a238d9a21sm8603125eec.4.2026.10.28.09.54.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 09:55:01 -0700 (PDT)
From: Wang Zhan <wang.zhan@smartx.com>
To: netdev@vger.kernel.org,
	Yingjie Wang <x-professor@outlook.com>
Cc: Wang Zhan <wang.zhan@smartx.com>,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 1/2] net: preserve rps_default_mask on failed writes
Date: Thu, 29 Oct 2026 00:54:40 +0800
Message-ID: <20261028165440.1093223-1-wang.zhan@smartx.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <7fc32d133404c078352f0b8fbcc80a67861bf2c3.1793199118.git.x-professor@outlook.com>
References: <cover.1793199118.git.x-professor@outlook.com> <7fc32d133404c078352f0b8fbcc80a67861bf2c3.1793199118.git.x-professor@outlook.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 28 Oct 2026 14:52:09 +0000 Yingjie Wang wrote:
> rps_default_mask_sysctl() passes the live per-netns mask to
> cpumask_parse(). bitmap_parse() stores chunks as it scans from right to
> left, so a later error can leave lower chunks changed.
> rps_cpumask_housekeeping() also intersects its input in place before
> returning -EINVAL when no housekeeping CPUs remain.
>
> Consequently, a failed write changes both the value read from the sysctl
> and the default copied to RX queues created later. On a four-CPU VM,
> after setting the mask to 1, writing zz,00000003 failed with EOVERFLOW
> but changed the mask to 3. Writing a mask containing only isolated CPUs
> failed with EINVAL but changed it to 0. No kernel modification or error
> injection was needed to reproduce either case.
>
> Parse and validate a temporary mask, then replace the live pointer only
> after both steps succeed. Readers access and consume the pointer while
> holding the same mutex, so the replaced mask can be freed after dropping
> the mutex.
>
> The rps_default_mask selftest failed on the base kernel and passed with
> the fix. The fixed kernel also kept the mask at 1 for the overflow and
> housekeeping failure cases, while valid writes of 2 and 0 still
> succeeded.
>
> The issue was found while fuzzing sysctl write error paths.
>
> Fixes: 605cfa1b1090 ("net: introduce default_rps_mask netns attribute")
> Signed-off-by: Yingjie Wang <x-professor@outlook.com>

Reviewed-by: Wang Zhan <wang.zhan@smartx.com>
Tested-by: Wang Zhan <wang.zhan@smartx.com>
