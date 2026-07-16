Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B1AB2F2914
	for <netdev@vger.kernel.org>; Thu, 16 Jul 2026 20:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784234107; cv=none; b=OMBCI61nBUwBXqM9A5TYrPMFmFrzZcmVJBKLpeYYwo3RwiSaR81GgV4vzFiZ2DB+ITl/XzFqGehQrf+cCgCxDKNVl64N1anRBmVLxnGik5YasMvImLI4uB+gYY2hNKipd159rwK5E3kz5cK/cjf1VHc9GYHbAwIbH9nc96lq3N0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784234107; c=relaxed/simple;
	bh=a2r3SaEcmo1vXRTikEb5mYwXGPxTs2s/FQ04pnJ5R5A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nRmr9CcikrGIc3MN1/WsmnhnaZd8d7hq09vIeYqu9jjjgxs7q0QQYTrfrPeBP2ho1NKJsTtR+fTCKmg/8NbWCv20Z+ZRQo3N7UibxkOJkBGwkRCPGAN7B+USayEsg8Z6ZOaxW33tz56x0JazQM6HkUMl1dQg/UntPJmHv6cynHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai; spf=pass smtp.mailfrom=0sec.ai; dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b=bWc2OLTl; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0sec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b="bWc2OLTl"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-493c19bad03so58671315e9.2
        for <netdev@vger.kernel.org>; Thu, 16 Jul 2026 13:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0sec.ai; s=google; t=1784234103; x=1784838903; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=EcO4tM1S3A4dsQuKJz/L4WTtHD8wctZEu5fpHjbBuSo=;
        b=bWc2OLTldqwUGev8rjSWlNyUzqyJXU1Pq239JOCc1yfyGWKGAUmP3mAue4vb5HkGAv
         koX7QJ1IieQWablWsRwCoyald4FSYej+qfk9iaZ9RDs/KFTa/ZPsawyew6HF52JaTIBr
         kknvAr4Tcu/VfF2WloiavqVI0NAfecO/4nufIPOTyI4yp1oDbDRpku29teH0KIn5C3cl
         XG1Q8KMr85c1Q3WR7B4BGPBfZnJeZuLCAiiTdam8dVDrLwWOGNQfCSW03Bn8s2oBjMBq
         YCofz7VfwHoKrg0rhJWRupc+8mqdnP0KDmoXf58xJa1PLSSnrvZBePG8t6rIkzQMZshd
         /bgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784234103; x=1784838903;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EcO4tM1S3A4dsQuKJz/L4WTtHD8wctZEu5fpHjbBuSo=;
        b=g30Z6PME4kQ61rI+eMHT+mJmPWtczrkqN/IOwOD1pZy/AXriWm1khY5jr3ls56a8v0
         N8f0CeeFMu+Vhe825RVmW4FKAOkU3rkHwWFwWRj5WzFnP4Z26MzxNZgh6omWG9uPKgj1
         XJEkP22Kt789p3Rzisw2wFRLLGIZ/bC8TAqUYS6MxLnzU0sQ9uVwJQIysMlcz/ajhVwq
         jseO9F9hOwag6PAtjZ3tWws/rp+LYR03HupP7z4YRsJdyXf3jAycO8F7jaI/Z6nQOUx/
         oskdlNs5XCSO8gjGJ+LMwsHJsbBlX5woQPSXVR6NesUZPFKkfXB2qgIj3H7JWKFD8Heb
         XwZw==
X-Forwarded-Encrypted: i=1; AHgh+RrCjXERLTbmJ2+ZdElCDSuuKAxGDNbRK47RGqfwFi3lG7lExif12RiwYCooLJP/MxtYXYx6hE8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywv19veYjy9g7zGrzbSLCdoxOqglW9q/qDd2KYwFUX9jRxagm8E
	4t6NAkCyqR3zSDsDSyFgwlOpi2CBxhd3hUozxSBsBS3DO111+seC1NyNh+dmsZcrZkwo
X-Gm-Gg: AfdE7cnv1XIY/DiVC4jG0QuB/YtpU3CkbUcpjRIa4EMnNOu9rOLlIGQ6vuwNNQYxKbh
	iOzy8r1C3VDiyB663udTrMUjusgJbNaMk8SuF+oR4yau2l9ePKHfcS8a5t82+EtaL1q+onIC9KP
	32GC8t1ryAp9gwuVj+MzFeLYf6LJa9d31yQdCIBymSzL5mMM+VUoJcy/cj5+psAXi3ejUyc1y4U
	JA9LaPUZBVQv2i1MSgQm/s2YRxmn482yvP7TPyMVivY+QSqc0FBnhi9V/ONH2Em+aXteisa4r8V
	yIU/ArtRyAvI8zF0rO2NwSZq8nIK3KrvXjHqragn2l0WFACgmrS6zTBd3FYT0Wc9dRnOv1DirIY
	c1fESCVlHit04Mc8x5n+ieqt6dI3NjXPP3Ldj9egMpwZmZ6NDn0kcj4JCgIMD8AJDDSdVZROnpb
	+K20W5t+rNSvYhKKdSTqRiEf66DXDYD3Foe69fBp3OIAbK8PQKgSsgu8FjUACopD0cMDKYelpxW
	ZxdD1b74NQV14FH09TAuWWR
X-Received: by 2002:a05:600c:6d4d:b0:493:f6f0:d66b with SMTP id 5b1f17b1804b1-4953c14f0a7mr76349675e9.1.1784234103380;
        Thu, 16 Jul 2026 13:35:03 -0700 (PDT)
Received: from PeakBook-Mini.tail8e484.ts.net ([178.197.218.188])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49548e075d4sm4602835e9.1.2026.07.16.13.35.01
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 16 Jul 2026 13:35:01 -0700 (PDT)
From: Doruk Tan Ozturk <doruk@0sec.ai>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch
Cc: fmancera@suse.de,
	sd@queasysnail.net,
	linville@tuxdriver.com,
	mschiffer@universe-factory.net,
	maoyixie.tju@gmail.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net v2 0/2] vxlan, geneve: require CAP_NET_ADMIN in the device netns for changelink
Date: Thu, 16 Jul 2026 22:34:58 +0200
Message-ID: <20260716203500.70573-1-doruk@0sec.ai>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The recent series "require CAP_NET_ADMIN in the device netns for
changelink" (8165f7ff57d9..27ccb68e7ccc) added rtnl_dev_link_net_capable()
and gated the eight IP tunnel drivers (ip_gre, ipip, ip_vti, ip6_tunnel,
ip6_gre, ip6_vti, sit, xfrm_interface). VXLAN and GENEVE share the exact
same shape but were not covered: both store the underlay netns sticky at
newlink (vxlan->net / geneve->net) and their changelink() operates on that
netns, while the generic RTM_NEWLINK path only checks CAP_NET_ADMIN against
dev_net(dev). Once such a device is created in or moved to another netns,
a caller privileged in dev_net(dev) but not in the underlay netns can
reconfigure the tunnel'"'"'s underlay.

This completes that series for the two UDP tunnel drivers that were left
out. Same helper, same placement (top of changelink, before any attribute
is parsed).

Verified on next-20260714 in QEMU with CONFIG_VXLAN=y + CONFIG_USER_NS=y:
an unprivileged user namespace holding CAP_NET_ADMIN only in a child netns
issues an IFLA_INFO_DATA changelink on a vxlan device whose underlay lives
in init_net. Before: returns 0 (reconfigures the init_net underlay).
After: returns -EPERM.

v2:
 - Correct the Fixes: tag on both patches to the commit that added
   changelink support (8bcdc4f3a20b for vxlan, 5b861f6baa3a for geneve),
   as pointed out by Fernando Mancera. No code changes.

Doruk Tan Ozturk (2):
  vxlan: require CAP_NET_ADMIN in the device netns for changelink
  geneve: require CAP_NET_ADMIN in the device netns for changelink

 drivers/net/geneve.c           | 3 +++
 drivers/net/vxlan/vxlan_core.c | 3 +++
 2 files changed, 6 insertions(+)


base-commit: cc2b5f627e8ccbae1188ef2d8be3e451d7f933a5
-- 
2.43.0
