Received: from mail-yx2-f12.google.com (mail-yx2-f12.google.com [74.125.224.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C14D038DC69
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 03:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790046412; cv=none; b=DK8dR5a/eh4s7RCRT20J2juM/sfDyzNuY6aWudfXtIIP+2wCYt/nXpiSWplpJI2BVme+LfAe2ekaUx1tLsKKjNt0l1edP+qxCeuJBLviLu+ZdB1T88djg2DK49tTBnc6YejlvaKikj5sqvkj54EZIfVYDbzYFyxQv4fsL5R9IM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790046412; c=relaxed/simple;
	bh=gKseP2UPem83UrKFMaWwniyYTAzvUEDYHT63VKc/kdM=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=n1t3CZ6+kiZRh1gmVBfo9snfNm6Ot51A4vdq2fs/Nw1iVoxDX5uU1Vir+Gme48kurqCP5S6afc1loiIQPVwBG8h9QfzqFM8bLkz2iRTKEgu5EMEX+6kxO38dIS65492wZdwwArMHVPsBL3zFk99NQuMBLS46cDlAvNVnWlTiP6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qFx5ek6X; arc=none smtp.client-ip=74.125.224.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qFx5ek6X"
Received: by mail-yx2-f12.google.com with SMTP id 00721157ae682-85d43f9b119so33405237b3.2
        for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 20:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790046409; x=1790651209; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=D4L3vIDsc7dnY0rPhCGADvH7oIEWEbf+uUvOLRnQTeQ=;
        b=qFx5ek6XsNw9i5j4jz8c5TXTZEeSc7WC9b1A1cf62OcojJmdAI/ig5JK/E90HBpL4m
         QPJAVd6o8Mhv6HFGBD5KwnLi2e63Yjfy7EykhJGZ7pBc5rYV81wGFEzjhOYzy+9uH5lQ
         Wx//0wkCijxOAdMpA9Bw4iQTuvGNiceowUIldhAkjHN/VLPlYX8a1pXUJI7WKNZStuxL
         dwLKLiXYs3lBcpirXVmlFTWUloWQD4uXBaNlCOxyu9GXJ602JemT86Qvkf+IeinWe2nF
         BVK4c0xMyWNQUUeo3v1DKiWj8bi6BaLaG7Qa3gZzJnV36Jlv5fkF2Pp/SUPdikHK5Rah
         rT9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790046410; x=1790651210;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=D4L3vIDsc7dnY0rPhCGADvH7oIEWEbf+uUvOLRnQTeQ=;
        b=U22sl46ZmumotAARQYIW1RUgKiePNUEQafLFkA4xrAyxaOyrwbSZbnfMKTQEAFODqN
         yIykFLOk6hCqX+SlpuPs/r3QRg8g0/tjn7e9CEa9hZS4BvtZUI4+i2K1bWWdbqhj/X3t
         eB5aoFz9fnQOsdqb2d2vhy5iNEgh9wFAPKNnpJDUM4BlElCdqHGu/HEVKwMGWlsXovKc
         av07WzuWqjRbhNIvWgrQWJ71/tP9VkwR0Yg1n3Q1Ja1SCtYNKdv1xizpQ4XdrAbKfWsm
         wKrMzsx6vHlRzN6zkz6e6IS3gl8lEWYR8t9jTBN03yoP3bmT3fGMIzJdjn6jc6OTfN22
         4mhA==
X-Forwarded-Encrypted: i=1; AKwUvBzOLJbljdVjLYbzxsD9lGdXx9YYmyHI7K98C+LMzS+BlUdqZtHRTmEKYjNuJdxiwKedDK8+zes=@vger.kernel.org
X-Gm-Message-State: AFuF++k4uLPLGKLS1CXBJX722jDBVxeI6k3P0BpS1LalmV+qvm0esD3T
	KZD2ocME82Ttio0wDpYAGy9CtjvxVKYtncTbfAErn05Zz+tAljNxptCL
X-Gm-Gg: AYBFou2YPb6TRhD/nboqKxHdanTv2A2LIYtV37IYepuP8aCOjvfvrtINJtd24VpSX6o
	LwdyOPZGqxBtymm8FnCo3H3hDN8IeRGR7+QkC6PS+MyDEzZzqRgOzBmd5234TdgJrFMrzKzZS+c
	x6FKhbxJOv/RQc228NDGsHeyy//kUwa/43IPaYyCk3qEkmnuX8oM+1RO/XpnR5Xkso1s7mq8PLZ
	Wg76uKKBH4+U83PfvNKPdGwOTlMZrxpopwvt13eF4iZqAJU3V+nns1X2T2KTq7WIcD/XruBryYa
	gIhaO3sQq5+LHvcX1RqLLnIB1yUickfNV5gYOnGLTQ8fgv7Q9ERLuDsg3qY3wEAVD3Vtr55r5Y+
	urcsZFJQqjp30rKfaE8M0W9eXt2pCDVn1fLzALozNBL/JWDBzeppF6GUfYKSKidHFSk4VJjhwYi
	FRb1cuJ9UoT0msHHhtegjFAsWUxv+1Xafo7q9o3fYeJ9Xxudl/mZfsAHk68/i6GJKyCEsu6uxG6
	ne6Km6KtwzbALr3J7qcbm5LCa3IrD4GIgZcE6CZh89aPNoea7uFSr8kVTuoytg=
X-Received: by 2002:a05:690c:39b:b0:89a:63da:fa95 with SMTP id 00721157ae682-89a63db043amr31355787b3.80.1790046409598;
        Mon, 21 Sep 2026 20:06:49 -0700 (PDT)
Received: from gmail.com (111.46.245.35.bc.googleusercontent.com. [35.245.46.111])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8a2c2f797c4sm1471287b3.32.2026.09.21.20.06.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 20:06:48 -0700 (PDT)
Date: Mon, 21 Sep 2026 23:06:48 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Dairui Zhang <zhangdairui@gmail.com>, 
 netdev@vger.kernel.org
Cc: Dairui Zhang <zhangdairui@gmail.com>, 
 Willem de Bruijn <willemb@google.com>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 stable@vger.kernel.org
Message-ID: <willemdebruijn.kernel.1b65de0a75434@gmail.com>
In-Reply-To: <20260921192608.1420047-1-zhangdairui@gmail.com>
References: <20260921192608.1420047-1-zhangdairui@gmail.com>
Subject: Re: [PATCH net] af_packet: fix integer overflow in
 prb_calc_retire_blk_tmo()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Dairui Zhang wrote:
> prb_calc_retire_blk_tmo() computes in 32-bit int arithmetic:
> 
>         mbits = (blk_size_in_bytes * 8) / (1024 * 1024);
> 
> If I'm reading the validation right, tp_block_size is user
> controlled and packet_set_ring() only rejects values that are <= 0
> as int or not page aligned, so a 256MiB block goes right through
> (and alloc_one_pg_vec_page() even has a vzalloc fallback for it).
> 0x10000000 * 8 wraps to INT_MIN, and on a NIC reporting 1 Gbps
> (div == 1) the function ends up returning -2047.
> 
> The condition is actually (8 * size) mod 2^32 >= 2^31 && div == 1,
> so the trigger set is [256,512), [768,1024), [1280,1536) and
> [1792,2048) MiB. Other sizes wrap to non-negative values and faster
> links divide the unsigned value back below 2^31, which is why this
> doesn't blow up for everyone.
> 
> What makes it fatal is what happens next in init_prb_bdqc():
> 
>         p1->interval_ktime = ms_to_ktime(prb_calc_retire_blk_tmo(...));
>         hrtimer_start(&p1->retire_blk_timer, p1->interval_ktime,
>                       HRTIMER_MODE_REL_SOFT);
> 
> A negative relative timeout expires immediately. The callback
> unconditionally returns HRTIMER_RESTART, and hrtimer_forward() turns
> the negative interval into hrtimer_resolution:
> 
>         if (interval < hrtimer_resolution)
>                 interval = hrtimer_resolution;
> 
> So the SOFT timer re-fires at the maximum rate forever, holding
> sk_receive_queue.lock each pass. One CPU spins in softirq until the
> socket is closed. Repeat with more rings and the machine is gone.
> 
> This is mostly a new problem: the overflow is ancient, but with
> msecs_to_jiffies() a negative timeout just got clamped to a huge
> unsigned value, i.e. the retire timer effectively never fired.
> f7460d2989fa ("net: af_packet: Use hrtimer to do the retire
> operation", v6.18) turned it into "fire immediately and spin".
> Still present in 7.2.6 and in current mainline as of this
> writing.
> 
> (Unrelated to CVE-2019-20812 - that one was the ethtool failure path
> returning 0, which now returns DEFAULT_PRB_RETIRE_TOV.)
> 
> Reproducer, needs CAP_NET_RAW (a --network host container has it by
> default) and a 1 Gbps NIC (QEMU e1000 works):
> 
>         int fd = socket(AF_PACKET, SOCK_RAW, htons(ETH_P_ALL));
>         bind(fd, ...);
>         int v = TPACKET_V3;
>         setsockopt(fd, SOL_PACKET, PACKET_VERSION, &v, sizeof(v));
>         struct tpacket_req3 req = {
>                 .tp_block_size = 0x10000000,
>                 .tp_block_nr = 1,
>                 .tp_frame_size = 2048,
>                 .tp_frame_nr = 0x10000000 / 2048,
>                 .tp_retire_blk_tov = 0,
>         };
>         setsockopt(fd, SOL_PACKET, PACKET_RX_RING, &req, sizeof(req));
> 
> Compute in 64 bits instead. The operands are already bounded by the
> existing validation, so nothing else changes. If you'd prefer a
> different fix, just say so and I'll respin.
> 
> Fixes: f7460d2989fa ("net: af_packet: Use hrtimer to do the retire operation")
> Cc: stable@vger.kernel.org
> Signed-off-by: Dairui Zhang <zhangdairui@gmail.com>
> ---
> First patch to netdev, and compile-tested only - I don't have a
> 1 Gbps setup to trigger it live. If I've misread the code, got the
> Fixes: tag wrong, or picked the wrong fix, please say so and I'll
> respin.

Code Looks good to me. Thanks.

As Fixes tag do prefer original commit f6fb8f100b80 ("af-packet:
TPACKET_V3 flexible buffer implementation.")

That is where the bug is introduced, and the effect of the bug prior
to the currenty blamed commit is not as clear-cut as described in the
commit message.

The return value of prb_calc_retire_blk_tmo() is stored into an
unsigned short retire_blk_tov then, so can be truncated. A 0-jiffy
delay loop can also be programmed. Though its effect is not nearly as
detrimental as from the blamed commit on.
