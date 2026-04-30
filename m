Received: from mail-qv1-f73.google.com (mail-qv1-f73.google.com [209.85.219.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79BBA389469
	for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 20:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777579764; cv=none; b=cykFoYSBsJColJ5V35doV1kM47p8BG3x3wUqaKqxIrwj3Tw3AxCfY9WIGN8CSuiAWAh21atEKUI0YxaZYnORM14+2NbwcnYAv68+WYOU/QNjm27wn3ePfVreo/adQd5pv9ML96EDzQjDdLPx2Wmm88BvYpLdbI865NFYTKdClXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777579764; c=relaxed/simple;
	bh=GwvBeaYNVi9Vk7p6KWVQG2M66/GVwO6Wi01R9iGNdfs=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=ce7dqyGmZYfOLhd13jlEhTf2CIUzL5H7EXyDfpwAKYyHaDE/iY1z9u9cYG5HmWi9amdPQb+rkGgArRe+R8GOrG6sDfu6tg4kPuWy8k7EKWgFswTK1OQVpzxPX0fnY0QQIeGzQA7aak2y2OCw6VFOSCGliBrUb7Cm4otE5P9WuK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sharmasagarika.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qOo8uw9S; arc=none smtp.client-ip=209.85.219.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sharmasagarika.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qOo8uw9S"
Received: by mail-qv1-f73.google.com with SMTP id 6a1803df08f44-8b02af4345fso47146346d6.1
        for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 13:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777579762; x=1778184562; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=U3JbNeHZs2nqmGfKRlzFopk+R0yDvr5OmpdjEZK+dsE=;
        b=qOo8uw9Stc68ewtzyk2mql2j8jYbLe/J4SjxhggblmVH+X+HSIgd3Sggiv3Utks3Ku
         /ILc07kVmAULQUlYDQn9cn3pVBR3lZ+yWic53+IshhY+g7xOiotKcW27k0G2u2btlV7G
         Hi7U/4kvhlQEWLu2cw9EfRkCgn/pNO4y4Y9uurKFBCZftUYCgL7Gp+1kDhWZE8zDRprD
         OOe/fxmXZPUIov/FvjZBlozyK3Jhwm/e8NYCxZEfV1Yev2hNgkO/4x6JrHEeNVCdUU4t
         ouSVpq+xG9SfPqBvtEndWssVh3i1I51Zb+gpY05igbftG8l8PPfTxk6tuv+jykqV+Xm5
         D+YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777579762; x=1778184562;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U3JbNeHZs2nqmGfKRlzFopk+R0yDvr5OmpdjEZK+dsE=;
        b=Efk8EFSlmwar/1LCUlTlKH0oIp13GkEvG6UaAeOMMEhMcpUYB/wP3vPmAQEY+7AYA4
         UCoF6ww7ELfeZLcSvMyCGHvdVcuUl4ogp/A5+Ug+XxZaIzOKH4lzg41Pmm11yBvKujR4
         PE3CmeiPRIVvJO3cUlZf5xU22mZCbMULFSYU8hudJCjLmYjMgBi+6klpnU3cBdea4KqS
         LO4UnKvMwMxQYgQiHoM3MWKJGSDAuA9gRDsKJaLc3gaNA1gLBkbMwY3bEGPAsOiWo3Kl
         kHV8eTiy0qid+PUCKAFi5pF0DWpxcPaWw71koTXAOTbez13DgVLtzdd6/yg6jpHRxb+P
         FcFw==
X-Forwarded-Encrypted: i=1; AFNElJ9U2iCZtmx1kCLYNegf5cETHkMsXCMpUry3UIPl4CnTks001TXT+n2vzSjDasKpfROSHPAYgdE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhE9ymmXlp7iK+NQoLjvny52+/J2vJhGgzNLCeg5qZT58WmMmp
	qqt5rgUSFJu6Zg2qvDvGUAfEhxIaHvmxnFw8Y2HdOMeRnrh2rntVbPSjlPpL5mW5pXWgcJxmagn
	Ujrp6A9zwC1BRrmXmmbxhU6Rfn4VLuXjrpwXCdg==
X-Received: from qvbnw1.prod.google.com ([2002:a05:6214:3a01:b0:8a5:c5d:e50])
 (user=sharmasagarika job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6214:e62:b0:8b0:2f3a:964b with SMTP id 6a1803df08f44-8b3fe70d01amr67305896d6.17.1777579762353;
 Thu, 30 Apr 2026 13:09:22 -0700 (PDT)
Date: Thu, 30 Apr 2026 20:08:59 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260430200909.527827-1-sharmasagarika@google.com>
Subject: [PATCH net v2 0/2] ipv6: fix ECMP route failover on carrier loss
From: Sagarika Sharma <sharmasagarika@google.com>
To: "David S . Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Sagarika Sharma <sharmasagarika@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

This patchset resolves an issue where established IPv6 connections are
unable to transition to alternative ECMP nexthops upon carrier loss.

Unlike IPv4, the IPv6 routing subsystem does not actively invalidate
cached destinations during a NETDEV_CHANGE event. Sockets persist
with dead routes, leading to stalled traffic or connection drops.

This series introduces a fix to trigger route invalidation by
updating the route serial number on link carrier loss and provides
a corresponding selftest to validate the failover behavior for IPv4
and IPv6.

---
v2:
- Changes to selftest addressing Ido=E2=80=99s and sashiko=E2=80=99s sugges=
tions:
  require_command for socat and tcpdump, EXIT trap, lower threshold
  for test success, and fix exit code.
v1: https://lore.kernel.org/netdev/20260427224243.3499162-1-sharmasagarika@=
google.com/

Kuniyuki Iwashima (1):
  selftest: net: Add test for TCP flow failover with ECMP routes.

Sagarika Sharma (1):
  ipv6: update route serial number on NETDEV_CHANGE

 net/ipv6/route.c                              |   1 +
 tools/testing/selftests/net/Makefile          |   1 +
 .../selftests/net/tcp_ecmp_failover.sh        | 216 ++++++++++++++++++
 3 files changed, 218 insertions(+)
 create mode 100755 tools/testing/selftests/net/tcp_ecmp_failover.sh

--=20
2.54.0.545.g6539524ca2-goog

