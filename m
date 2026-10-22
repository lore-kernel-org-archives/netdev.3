Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792686752;
	b=0ivyRwL9blvIkmt16PluWf0k1yDsi60+ALiASZdBYzbdf7NOnYqT1r/6poLnGctquUZ2
	 sq5z3unxBzcmkyAdA1nsK37xSdksu3BYM/8/EM7pKVSqs0dJ7ddZtlzlUbX/DmNDiXuP8
	 vkmNn/+F9SMpkyQVLa0veO/qBB9vY+BKj2a/srpsdqNjkJooHj/lU5E9AL4k8CFDLz5hr
	 nQ0WQowc/CCugy9QQ3kojRNWceC+UI5N5gLdY5BYRC+YLU16G9fMvb80WJJqWFE22nv7K
	 NDRnui35jQU0MBqNhS9u4386mNF8ArWstKPWiFCHVqf8/AmSR4SMDCsLS9v+RunWOrw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792686752;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=dyDoCHAK3x3k2IkUzfNota+vU5adkAbdwanSXQJIy3c=;
	b=2VKPJ9zODLOso5CmpUmc6YFx3qj9Iuc4J+L/LgutE/mwek9TsQGN25RuvCyj1NK2Cz1B
	 rGc1d/a6CEZVzTPWjGxSusKL3v0WP2/CFCd3dUGqvomsVXuvhY8idrlLkuUBEwRU4foDi
	 pytgB1gw5J7VCOQL+xqEaLssyDE6Fku7O4Q+/jnokGQ8AB5CilVo0FiPmB/TG2fZZ1ysw
	 QOtIpUxgqjVr57F4p5fgjGXs0Gqv5pHmnOxSPcMsv65XRzIs+WkJO/P0ive132HIi7fil
	 P+4NjdnsoXppNhMPem8RrZeAHIZGCT82TTKJdBTY2LfivE280RKyvG2LFaLrHiWKPuA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=nlgT2q1R;
	arc=none smtp.remote-ip=74.125.82.172
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51252606A320
	for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 16:32:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 51252606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=nlgT2q1R
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-33fb4680717so4965520eec.1
        for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 09:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792686751; x=1793291551; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dyDoCHAK3x3k2IkUzfNota+vU5adkAbdwanSXQJIy3c=;
        b=nlgT2q1RTU0EH+YxL4z+hsL4T+7TlQvAkGhXm/A3gBiBq1OjpdykFD0p79P+2QHVXp
         rrRmUnE13x6JIjeqAVMN86RahXl7yQZrxVVvmdH/h3z701xAU3dJkZMO16qz1XzHWXwb
         yvWxB5Dz/qX8uF52sjXSeZYPJDeDbcgeZU1+MUNol869hzum1Olo40CBOrZyYUs873o1
         d2JfUi0Atheb1KdNQAd4ROzSnSe9hAl6UfeSPcuJai48Apf3no8HkCxQgOWlYtlUSBsd
         BQlVpeu2F6rRyR4+kHtPpl0iu72eMIo1cY+IV1lD/TqySeNzClg2LJWDXn8biN9HVq8N
         Px3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792686751; x=1793291551;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=dyDoCHAK3x3k2IkUzfNota+vU5adkAbdwanSXQJIy3c=;
        b=p5cpSubGB2ZrAaHNV0lszTJHCsdaIbNhO2Kczm6TLanwIwZxbfTyESt93Mlury059s
         9+bBo6hwXlpBDHm4veMeWlj4SsJLjO9fPBv6aj4H2OLgVhEQt+tifv6E+otFpNiXScKM
         WKMfyUO/NLRQYry+Xrrg5jfOm6W3ol8zDQIrQ3r511GISv5S6Mx/5wq+w1UZhx528xkv
         /WiRwMnKmJgl+wE80TatT3TpFk/KzgGKjJ1d4lAA1R/PwcWZ9PA/GyrNGpwnYZ3IZ8Q0
         kHxVYwsjpOAAId8UKrAynPb/POSchcAAed1tUha4R/LxNslp2H4gLpnAMERmknOqyS9R
         6W8Q==
X-Forwarded-Encrypted: i=1; AKwUvBytwoF87o1q/Gy6APFMhS+HMTdRpRPs2xpwycGS9s2L0Ur+/h+GUXC3bP0ZBMP6P+RJZ5gkRBo=@vger.kernel.org
X-Gm-Message-State: AFq9FYIaH0HHVRWZpD1OgOo2zSK0WoBULwinccCTlT4WuFiaIWT2QkjE
	9DcWmtAZdPEuxz+6/QzGKubNGDW7yewTuE/73Fpc4yJRPPQ2j8Fyp33p
X-Gm-Gg: AYBFou1Sx+xhF5EmEf2j7k/+vR7SLqm5sT38DsdG6mONXYDSo9ECxwKjCp8mCXu/emC
	9NjUpVIdmUGYbLoarKiC2+L7aiLIDY/uGqNFPZUx7eh+V63Ed5A9JscRWcSSegy5f/UxaPjPqVb
	AwtZtv+col+zAzxLaofWqW3eNmzqqwDig4pamtd1TrDbRNfoPDybLbY995jbDUQKawmAo5s0SQN
	sheje6M+8umDZO9sb3xLxymPnk0ycu9TvD5G1K39bv5e1go55CxoinfOpoU7jSSVRMecSUJnas/
	zg1GlQHfTloqhYxsv93+VBK2mlN5n/zezHKK1idlQrkl/fxEoGtevRTq/SvdZxxnx876pXAyMXl
	IHH0b7yB0bVflMu56xdFXr1SIKGscAheeyr4ZfmIrE6gui96FmuqtwviUJZBdPdePPLFQEWFE/Z
	1n8bjfGgVpK0JdYeiB5xGRIok5o8zhsVT3tT147SXZEkLmBgvrCI1++ABdWLu/YgqusPVrIsGwO
	sTVTC1U/6yXMtnf6mHGybrqcWPyykt+CZEHGWQnPIkUZbDKZybWe7An+3kVGv9gY0R53yYsONvv
	j8T+4AsPeY3YadrX
X-Received: by 2002:a05:7301:18a1:b0:359:9302:a526 with SMTP id 5a478bee46e88-3674c93ba42mr7166066eec.7.1792686751237;
        Thu, 22 Oct 2026 09:32:31 -0700 (PDT)
Received: from DESKTOP-NM9EKIA ([125.134.240.130])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36741e71eaesm37214243eec.26.2026.10.22.09.32.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 09:32:30 -0700 (PDT)
From: Joonhoe Kim <26rote@gmail.com>
To: netdev-bot+sashiko@kernel.org
Cc: mani@kernel.org,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	christopher.lew@oss.qualcomm.com,
	deepak.singh@oss.qualcomm.com,
	pranav.phansalkar@oss.qualcomm.com,
	andersson@kernel.org,
	linux-arm-msm@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	regressions@lists.linux.dev,
	stable@vger.kernel.org
Subject: Re: [PATCH net] net: qrtr: ns: retry service announcements on -EAGAIN
Date: Fri, 23 Oct 2026 01:32:23 +0900
Message-ID: <20261022163226.1091-1-26rote@gmail.com>
X-Mailer: git-send-email 2.55.0.windows.5
In-Reply-To: <179250109438.3135.5278679700614096504@kernel.org>
References: <20261016124600.31-1-26rote@gmail.com> <179250109438.3135.5278679700614096504@kernel.org>
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

On Tue, 20 Oct 2026 12:58:14 +0000, Sashiko AI review wrote:
> - [High] The fix only covers one of the two paths that send NEW_SERVER.

Agreed. A service registered after the remote's HELLO has been handled
but before our HELLO goes out is broadcast from ctrl_cmd_new_server(),
and qrtr_bcast_enqueue() drops it without telling the caller. If the
local node had no services when the HELLO was handled, v1 has nothing
to retry.

> Could this be handled in the core instead of by polling in one caller?
> For example, packets could be queued in qrtr_node_enqueue(), or the
> announcements replayed once hello_sent becomes true.

v2 does the second, as you suggested: the core records that the remote
has sent a HELLO, and when our HELLO has been sent to such a node, it
passes a HELLO from that node to the local name service again. The name
service then announces every service it has at that point, which also
covers the dropped NEW_SERVER broadcasts.

> The same window opens again after qrtr_endpoint_hello() clears hello_sent
> on resume, because the nid stays assigned.

The flag is not cleared on resume, so the replay also happens after the
HELLO that qrtr_endpoint_hello() schedules.

> DEL_SERVER broadcasts from
> server_del() are dropped the same way.

v2 does not replay these. A service that is removed before our HELLO
goes out has not been announced to the remote either, and on resume the
remote has been reset, so it has no entry to remove.

> - [Medium] The new retry loop in announce_servers() (ns.c:232-236) can
>   stall the whole name service for about 10 s per remote HELLO.

Agreed, this is the same problem Mani pointed out. Nothing sleeps in
the name service worker in v2.

> A HELLO that fails with -ETIMEDOUT or -ENOMEM leaves hello_sent false
> for good.

That is a separate issue in the core, and v2 does not change it. With
hello_sent false nothing but HELLO reaches the node, so the replay
would not help there.

> - [Medium] The NS side gives up after a fixed 10 s, but the core keeps
>   retrying our HELLO with no limit.

Agreed. Any limit in the name service can expire before the core gets
our HELLO out. v2 has no limit: the replay follows whenever our HELLO
is sent.

> - [Medium] A retry can re-advertise a service that was closed during the
>   retry window, and the remote then keeps the stale entry.

v2 has no retry window, but the replay is one more HELLO for the name
service to handle, and the ordering race you describe applies to it
too: a port closed after the replay is queued but before the name
service handles it is still announced. v2 does not fix that race.

v2: https://lore.kernel.org/all/20261022163116.1042-1-26rote@gmail.com/

pw-bot: cr

Thanks,
Joonhoe Kim
