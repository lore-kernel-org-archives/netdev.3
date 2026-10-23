Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792763282;
	b=Nvbod7/mlHzNJe03268Q2/Lyl8Kd98DOJXWVVwvkZkBAyzVUBO9+PgGJ/0dgSAGDvna5
	 EduV+KH18hx4PDNcD4Hh8gyhKIhOdQppsiCrZyHCUVLIScCKxXvedlplGquRCfKoSZjJe
	 AXZWgfir65lPHcUWTqpDOFljUoKn+FNxesBsWD+7+3d3P52Wo0h6RL2mKFVlNpUPD+dOX
	 Ia6jNiQOndc3qYvhUFaVKUnU5oV0CJvkLFgptU55bAla9RBbR2j+gBIMlSk1MN56gtGsI
	 +86OkV8KyPg6ZE7rniEypQj2FMrx60OrJVnj2qyjvIzSUyn6y81FIkwy/nwzVp+VBbA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792763282;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Subject:Date:
	 Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=yIZR3ga7Ca3D8L36KO+lWy8W/CjP1V8G2CgBGqUvU0o=;
	b=rgJ5zq+lA4gNt6R6EfN5Pnt5NnCug6yD+Lc/rWGWWRlyEgasvnUOQv16ofrReQPsNGom
	 oRMdvbT20xgF/yz2NG9tD0hOdrLtcMALodZL35WYpD35xIzktd8njiHP8hTlbC4wK2R/K
	 zEAjjaMnS/v1qYEBTf2nIr8bTbhLqSGok3lgQIIfJiBHqPBBul1HGBxGXqs2EWGRoEg1g
	 lC1b4MkeS3YRsZPfR4zvLdqGRXadCqCG3eRVpZQO8Lx5kMn0I7msF1LEZ5A9dDomqcLL2
	 xm+jfg7UBn8Q6pv4++y99wiRmooUPczEVWhhxPF99Vnodouz0xNSKIG6hHzM5vYxlbw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=i2tmZPwh;
	arc=none smtp.remote-ip=209.85.214.180
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD555606A327
	for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 13:48:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BD555606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=i2tmZPwh
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2e9eb579c0eso4413885ad.3
        for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 06:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792763281; x=1793368081; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=yIZR3ga7Ca3D8L36KO+lWy8W/CjP1V8G2CgBGqUvU0o=;
        b=i2tmZPwhyHLaYCJkgREaH1xGMupjwLOpb5DSU/B54X+WzDLrRxzWXgGSeoJMLvIPM7
         Icti/4hiLTj5TSbX8Rn2l1Ct0ii3tf6a8k/4LtGgwkiT/gN2mjUlvUyFJYHeeZu5J65d
         cJo04c8G5JY5RMAEhqck6YubIzbnJs3D+uVk9+wC+d8b89OGafx1lJs7vBUOMnnuKL/p
         soTNgcOA99cTcsiBRqc/OSLA2d4PVSSBH254dZx2GXUk/q45q5s/bznRqIWfUneN4Kfd
         Ez5u55LiVkM5WITO0clIYVNmnUPOmoLcHqAPzlo/DMqs4pxHSGSJuiOu/Avjj8ujD+oz
         M1+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792763281; x=1793368081;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=yIZR3ga7Ca3D8L36KO+lWy8W/CjP1V8G2CgBGqUvU0o=;
        b=CV5dhANQd84FaUmuZ0auqD26gckDeNLK403Z9C9htnAWOWjWRfzI8Y04r1yhh7stTw
         4OwIyrop0G/Eq3rW/Awd/cDTXFx8Gy81kdqPs93VneKtT7FDqLMAIxwZymTxz+ft256y
         xsFuwWbwhAl+AhGxi8Vs8z64u1ZV/YoGQJJEf4tDon1rcU0wdtXsL+2/rBzYwAU6shEQ
         /jNQe6BZgRV1B41ntzET04szH1w1fpXxO1FRjcUTcoWC56PwYGccUrhGiHDSt39X+xKe
         kCQko9pJvnELMSsRu4fAY1N2i2pimV1qE0fXodx8K1d5dZXTZuipCQ7LdcptJLELmfnv
         bbpA==
X-Gm-Message-State: AFq9FYLSnz8xdM4Y4Jm3zk4KfVqXGf2KrIWOm5fwDDszp4U1hg2hFyWu
	Ee+89VJLaY42K9NVAbp8kHgVdWx+rm8F3AG7ZsumXp7VIkqOAu9FZFX2rkcWgTzR
X-Gm-Gg: AYBFou0+B+BVbCi1v7D88kY3hqkK+9LplJ/2ZccHAKCEE/nNsMQ9cXP0I61xPd1s80k
	BbgrQ0bvtyMJUoDk9UrEIlsrtdMTc5XdSxABeL767exz7FxTJfNSwcpqCrgMluVUgyRd0rzcw5t
	mgC347SFa30zq//gIevacbG7zfLeVliztm+NuFGoWn/Vutwb49dpxqC/EI5NKorklqhwYn7s5VW
	jUnQ5tZVNNvnaIGBm6p3OgBIgK4yveemUP16sNBSpKnLwedkhgflK4rUNqyCi+AwwciQ4xoU85A
	Iqz+M4pgwHv+4qBeqk49owXCeteghNY6fY7Bb216woU8MujRfyrV5qnQCOKLAbC8FOFitcjFpyi
	6BcUQh9jFN6hXuHIshdPcxL+7TQFFIIOi6wI+fbpuv/Lzpwh3FBjpssATH8S+LpPknsJdUQWlUu
	Qt1bhhruyMN80HNCvLcpSshVsdVieA7tx1s+65V4zE5Ub7H0bawAkRnpm6J9u+ca9Qs1WIqECqT
	gykyDe4OBFEd1roIErHI/i/nhgOSer1+c/TZeN6Ni5PKUbEA1Qmf4KA49uJK36O6vdbQVZ0zMWn
	ig==
X-Received: by 2002:a17:902:f650:b0:2e9:492e:1688 with SMTP id d9443c01a7336-2ea7c1703a2mr20731635ad.8.1792763280851;
        Fri, 23 Oct 2026 06:48:00 -0700 (PDT)
Received: from dev.local ([163.43.243.221])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ea946778ccsm521295ad.9.2026.10.23.06.47.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 06:47:59 -0700 (PDT)
From: Yuya Kusakabe <yuya.kusakabe@gmail.com>
Subject: [PATCH net-next v4 0/2] seg6: skip route refcounts in seg6local
 lookups
Date: Fri, 23 Oct 2026 22:47:55 +0900
Message-Id: <20261023-seg6-lookup-noref-v4-0-0ad0a83960ef@gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAItl22oC/23OSw7CIBAG4KsY1mIGSmlx5T2Mi1rGilpoABuN6
 d1FdNGYLuf1/fMiAb3BQLarF/E4mmCcTYVYr0h7bmyH1OhUEw5cMgBBA3aS3py73gdqnccTRWB
 SqPIoATVJd0Nqmkc298RipBYfkRy+k3A/XrCNH/KzezYhOv/M8SPLF7+kciFpZBQoKI61qCqBN
 ey6vjG3Tev67I98JjBYEngSStaC0lrVTFX/QjEXFn8okiB1yRoJjax0MRemaXoDIA+TjVIBAAA
 =
X-Change-ID: 20261004-seg6-lookup-noref-e016495b60ed
To: Andrea Mayer <andrea.mayer@uniroma2.it>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Gabriel Goller <g.goller@proxmox.com>, 
 Yuya Kusakabe <yuya.kusakabe@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1947;
 i=yuya.kusakabe@gmail.com; h=from:subject:message-id;
 bh=0/pxtlgZhqaqTZMz2uAJviY3LaW2v/Vb+2RIONbeInE=;
 b=owEBbQKS/ZANAwAIASrX0XUqXRtNAcsmYgBq22WMu4lEPP95GNNAMvbMSFqvWCjVTzq1aJKGn
 wc76sQKiruJAjMEAAEIAB0WIQTaB7usAfxNKMeqa6Yq19F1Kl0bTQUCattljAAKCRAq19F1Kl0b
 TVOcEACBX3EdN8ehseJgKBCTUIWFuUvp/1HX+4wp+FRVgHVEtc8PxZk3TV7MK6LtGNr4Ra+TUC2
 GfaJ7dw05hVSvWnJQaGxc56YQKcqrNXMoYOrawof9DjLr0SLuPt+6y5hi25V22E9a3dfla5Rh6K
 ahL1wq/X+rzL5e+Bkxe6vsmHgo300mjOKkjDeA2ZQrgdiJeoWjZHA6d53d0quWI8wY1kMcJNww9
 yXbgdSnL4ar3duWUAXJG/qOoqRSmK/jJzvkoqCbnIvgeQJV7DBTvpbqBWVuoo18ZXUAZhxX1g4G
 TZKkHNgcgM8ZwGkqgpEt9McwTK3OCH+nPp1mGnyaxW3+rMzT7LAcx+yZkywz25smae8ldmugMbM
 D52wcrs+uwzgiB1RpkUD/xJ8373/CuOoXUP3O/hk+x66tUJSWOvqtdycC7Ec2C6wLIdx6SOF7fM
 gvlZEQbvuA27XRwtB8u+dMlUTIlqVakclGimtxthydk/Ulu5tRy8IVSjy5ui2uW6ukL3n8tC1u5
 I17dui775rlFZ28czjjrLEKX3KktlvbRZe76P8SG6f4Mk3A2my5kilBSpyS9kVx6DMe3IpAGkxT
 4GXQu7eXTW9/zwr3/PYC6CDxkQKluIUEljO1lCKwgMuC0G1ac2+AYwY9ggZGBSKNZO/T10i1HGU
 HqAnLWxjY/q1Y1A==
X-Developer-Key: i=yuya.kusakabe@gmail.com; a=openpgp;
 fpr=DA07BBAC01FC4D28C7AA6BA62AD7D1752A5D1B4D

seg6local looks up the nexthop of its IPv6 and IPv4 behaviors from the
RCU read-side section of the receive path, yet takes and drops a route
reference for every packet.  Skip the reference, as ip6_route_input()
and ip_rcv_finish() do.

An LLM coding assistant helped write and test this series.

---
Changes in v4:
- Take no reference on ip6_blk_hole_entry after a noref lookup,
  including for a missing table.  An End whose next segment is a local
  address took one for every packet (Andrea Mayer).
- Comment that the noref helpers need RCU held until dst_input()
  (Andrea Mayer, Sashiko).
- Link to v3: https://patch.msgid.link/20261015-seg6-lookup-noref-v3-0-6d51a60a67d3@gmail.com

Changes in v3:
- Keep the refcounted lookup in seg6_lookup_nexthop() and give
  seg6_lookup_any_nexthop() a noref argument instead, so the BPF LWT
  helpers see no change while a route is released (Andrea Mayer,
  Gabriel Goller, Sashiko).
- Mention NFQUEUE reinjection and the release race in the commit
  messages (Andrea Mayer).
- Link to v2: https://patch.msgid.link/20261010-seg6-lookup-noref-v2-0-51c09dd98197@gmail.com

Changes in v2:
- Split the lookup into a noref primitive for the seg6local input
  actions and a refcounted seg6_lookup_nexthop() wrapper, which the BPF
  LWT helpers also call (Andrea Mayer, Sashiko).
- Rebase onto net-next and re-measure.
- Link to v1: https://patch.msgid.link/20261005-seg6-lookup-noref-v1-0-092e84774e80@gmail.com

---
Yuya Kusakabe (2):
      seg6: skip the route refcount in seg6local IPv6 lookups
      seg6: skip the route refcount in seg6local IPv4 lookups

 net/ipv6/seg6_local.c | 59 +++++++++++++++++++++++++++++++++++----------------
 1 file changed, 41 insertions(+), 18 deletions(-)
---
base-commit: 758fe10f83a655bed0f7b98fcfacdfc3556fb9a1
change-id: 20261004-seg6-lookup-noref-e016495b60ed

Best regards,
--  
Yuya Kusakabe <yuya.kusakabe@gmail.com>

