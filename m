Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B98531F936
	for <netdev@vger.kernel.org>; Sun, 18 Oct 2026 20:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792354049; cv=none; b=HLcKerFjSE4lNUeDX1GOpL5IxpETTeR7T4uEYjjtb6joB7jRp+D8UOfNQELwbvbMmE6H3IT4DcbrOd1gxpxf04CythNv0hT3JxcwMOIEl7caHhRcxOLIAhcU1kk4iG34HRGxXfaMUr/zO4ZUMvucnixm2UCll31gcaNbAfPpSbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792354049; c=relaxed/simple;
	bh=18+99T1qUb2FpUIRC28pBQCVrHScTY8gtn0xr1S+eP8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sSjd3+wKMieQTEvxJMPbDy3hncPlWYSS3uPfZGQd58HzQ0OdEpgB7/Nx+7s7iRoLD99Re/jApI0S0UfrCvAatjROTQNCqmhaobPilqsk+VLNJG2WfKt28Ix0t+ZbeQ+udkhSlD2MfDsvhoFFFSjnbcmSnPrnson849avJfmWxrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WsHu3VyE; arc=none smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WsHu3VyE"
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-35a31bb9fb6so3549959eec.1
        for <netdev@vger.kernel.org>; Sun, 18 Oct 2026 13:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792354048; x=1792958848; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Uv3MoYQpKa7w7+4Q5+kfm8SKN41PePsUtcz93EBelrw=;
        b=WsHu3VyEFtRtOdIFehghML90MX3LzMYR/xur3yPYTgBrpj/IP9gzmaAL2qz0Eh/g8W
         et75W6ORg3MobOZxlIM5ey1GIaitUI1InPHjESqBDzE7tMdDTtzNYmiC6ojFD+CfFl40
         D+2nrfCFe9o3BT4U0+0VVsOptkLEEOBVFSS7wG+fdIwQXY4CX82re7DcQhJS01vnqPou
         CczKZC82Df065oM5pa+3BVhZlD44YcwBol149LlNRHP0n60w+fLJC7CE6VzC+ljWMXwg
         sUZcPUgCNFIfMZ8Uipn4qYpwSKe3rSchjsqR/dUS3HWhRVnWy9DbU0Jaj2KYckW3AsR0
         5zAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792354048; x=1792958848;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Uv3MoYQpKa7w7+4Q5+kfm8SKN41PePsUtcz93EBelrw=;
        b=NGv77IN/vfxqingK15bY0HcOpscD+jSc3opCJOtBnWnbwlVhtmUcXtO7NRFBAxucGu
         QhU4VjlVui0Mi0F0oNAPWNJzuBXtc3yaxXrVZF7TiS0EdrghtlPFzcO4sQG2ikdZ6PVO
         wPpuRqB5tL4S03sOKqalr4wuFrOEoG+igcbq7zePuu7uUg2uDICSWfAapPDy1XJt+1HH
         nW2stt19jNuKaL/O0DSiYXkUojNCaulFDtYh02BGQ3Y0GyOsgYPfi11UJMEbPtaVe/oZ
         I7LTCkmFOYu4RZ/terCdLCGacDEohj4Gqcr83Dax+NUAieCNjnwzd8OgRg5jVqSKBnxP
         MIcA==
X-Gm-Message-State: AFq9FYJ8FIbODnXs6Eu7E5PeBweCUxu/xOuQ93eh3rfJFJBBhXq3nq+S
	NWFLxfPzeXb2nQkeV9XGwTAIlAgObkhtmecPdVXnJz8ZERsd+Lz/kEKF6uA9ZQ==
X-Gm-Gg: AYBFou1VZAXEA7HQc60Hl7D6202eCVpYxqAJH1XAPp8zYIFUHDyqQan0fOLHeGUE+v5
	QKOi1OaBG1QCGq116/RNklqx4Oais3DnX4z//BuQ4Lg0JXeKot+yDSMgcEX877dIpbbdg8SHXgw
	W130NYiwQc5LZTTfIVy5OZNggYiccV3vjVDM37pjNZTsj1zk93nIFfejSizQv2IJryhIj0h48Up
	eU3g9FfMUENN8F+Q32nndyqC2VqRZqs+UUuqAPCK7p/Lus4WDH6jNWhPCmPLDFQD+uIjt1eicG+
	rvZfEOY+ES0prvXLDDlfSBqOxQoLBks+x3JrYdBRwLWzj6paeTJlidM426K8u4Xxt1JMDjlmYRL
	EKXyxD5XXdlsbLKE/OLiiiFh9FTna7Mz6K3pExr1GPwCbbuwW4jG4TEN7NnWhnXYl8LequSi6Y8
	GdCmKs11P/iEUcAfmoa9uUqWyTGFnW3QLlZ3551MlUZsjOjiyXUYKmQf7QmCi4Iw4YTEuKZekST
	6AQmi4oy17T8jIC0C/z/Wgl0MWxutY=
X-Received: by 2002:a05:701b:2903:b0:177:9a5b:a89 with SMTP id a92af1059eb24-185134ddbd3mr9352797c88.29.1792354047613;
        Sun, 18 Oct 2026 13:07:27 -0700 (PDT)
Received: from LAPTOP-KD1TH5BD.tail375eb4.ts.net ([49.36.88.9])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-183190aa411sm26036273c88.4.2026.10.18.13.07.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 13:07:27 -0700 (PDT)
From: Gopal Malaviya <gopalmalaviya53@gmail.com>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org
Subject: Re: [RFC iproute2-next] ss: remove /proc fallback paths
Date: Sun, 18 Oct 2026 20:07:12 +0000
Message-ID: <20261018200712.389-1-gopalmalaviya53@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260901144034.437569-1-stephen@networkplumber.org>
References: <20260901144034.437569-1-stephen@networkplumber.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 1 Sep 2026 14:38 UTC, Stephen Hemminger wrote:
> This patch removes the old /proc/net fallback code in ss command.
> The sock_diag netlink interfaces were all in 3.10, over 13 years ago.
> No longer need to carry all the additional text parsing code.

I tested this on top of iproute2-next (204a7210). It builds with no new
warnings, testsuite/tests/ss/ssfilter.t passes, and on a WSL2 6.18
kernel the output of ss -tan, -uan, -xan, -s and -tanpie is identical
with and without the patch (ss -a -A netlink too, apart from the line
for ss's own netlink socket).

One concern: the diag interfaces are in the kernel, but each one is a
separate Kconfig option. INET_DIAG defaults to y, while UNIX_DIAG,
PACKET_DIAG, NETLINK_DIAG, INET_UDP_DIAG and INET_RAW_DIAG are all
"default n", and common configs leave some of them off:
x86_64_defconfig has "# CONFIG_INET_DIAG is not set", arm64 defconfig
sets none of the five, and Android's gki_defconfig enables only
INET_UDP_DIAG among them.

When the interface for a socket type is missing, ss currently falls
back to /proc/net/*. With this patch it prints only the header and
exits 0, so those sockets silently disappear. I reproduced this for
raw, unix and packet sockets (ss_before/ss_after are ss built
without/with this patch). Raw sockets, on a kernel without
INET_RAW_DIAG (the stock WSL2 kernel), with one ICMP and one ICMPv6 raw
socket open:

  # uname -r
  6.18.54.1-microsoft-standard-WSL2
  # zcat /proc/config.gz | grep INET_RAW_DIAG
  # CONFIG_INET_RAW_DIAG is not set
  # ss_before -wa
  State  Recv-Q Send-Q Local Address:Port      Peer Address:Port
  UNCONN 0      0            0.0.0.0:icmp           0.0.0.0:*
  UNCONN 0      0                  *:ipv6-icmp            *:*
  # ss_after -wa
  State Recv-Q Send-Q Local Address:Port Peer Address:Port
  # echo $?
  0

Unix and packet sockets, on a kernel where unix_diag and packet_diag
are modules that cannot be loaded (a WSL 6.6 kernel booted without its
modules), with one packet socket open:

  # zcat /proc/config.gz | grep -E 'CONFIG_(UNIX_DIAG|PACKET_DIAG)='
  CONFIG_PACKET_DIAG=m
  CONFIG_UNIX_DIAG=m
  # modprobe unix_diag
  modprobe: FATAL: Module unix_diag not found in directory /lib/modules/6.6.114.1-microsoft-standard-WSL2-destroy+
  # tail -n +2 /proc/net/unix | wc -l
  171
  # ss_before -xa | tail -n +2 | wc -l
  171
  # ss_after -xa | tail -n +2 | wc -l
  0
  # ss_before -0a
  Netid State  Recv-Q Send-Q Local Address:Port Peer Address:Port
  p_raw UNCONN 896    0                  *:*                *
  # ss_after -0a
  Netid State Recv-Q Send-Q Local Address:Port Peer Address:Port

Distribution kernels such as Ubuntu's 6.8.0-147-generic and Arch's
linux package build all of them as modules, so they are not affected.
I did not boot an x86_64_defconfig kernel; I would expect ss -t to
show nothing there for the same reason, since INET_DIAG is off.

I may be missing context on how much these configurations matter for
ss, so please take this only as a data point. If it is useful, I would
be glad to help test any further changes in this area.

Thanks,
Gopal Malaviya
