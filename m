Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794101394;
	b=Chw1GOaWRvXt5MMxerZtzMDYmUOPFPoYt8SIVkyCnVRou298RG1dL0RByKWHOEqL/tik
	 VCIVn2Z8MhOBtCuDJ39xeNm1nn2l8J86Gmv7BkwM89cEe1gR9DMvn/1vQkPvb1GdC1Ziv
	 2lfmOZHQA+RacfRm50oYf3XrkmzlVAyoipu7cWvq/i4eFMMU9Pn1B/Ea1jcdi+FH/EhW4
	 zxFb3eI6wkjigsKmY94oubOuVHqlRlPB8ly5ug3sbLdg1mG2yL29BqUnpczV1JXlgIuzY
	 QuuwlaQQeIOfPFb0NvjbYn1UUQNgGuw5e5KKhI1SyILCCDWc/x2RV4gPhOfS3WFrVsQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794101394;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:Mime-Version:
	 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=4nRaSYlSCufm8SEc5msE/ZDkolmqxTXglEJWMOXfXhk=;
	b=tHGG0uFC2iCDjl2fmjD2E1IHUfwikiR7QafZrdBH7IQ19PFhN51061vp53C/t5P3sbhn
	 iZNGRRqQ3ojoXDOvgcVhLIOvG8HBf+6LU1W+3/krJT9mCeDxyxcCVisXqh5UQ4ueSU+r2
	 c7XHDShgWNv19qfL+ab5odhpbl+mBZ4k8gfDaHtCOFlNT8VF7m85P1q/xL/tG8QXsMS6p
	 4k5LRqU4YG23ZsxNzGJU4NePpZh5ST5gdzQZtGaYG+IPvaTt2FnGLOPfeYe3/MczyveX6
	 Yq5G9yBxQ+drzFO7N8hJjvtXVorTz22J00JVH7a0PLS6jLqlMh2m2ggK16n3NjKywRg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--yuyanghuang.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=U5ux9NQx;
	arc=none smtp.remote-ip=209.85.215.199
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AC15606A326
	for <netdev@vger.kernel.org>; Sun,  8 Nov 2026 01:29:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7AC15606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yuyanghuang.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=U5ux9NQx
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cd66551e02cso128600a12.2
        for <netdev@vger.kernel.org>; Sat, 07 Nov 2026 17:29:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794101394; x=1794706194; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4nRaSYlSCufm8SEc5msE/ZDkolmqxTXglEJWMOXfXhk=;
        b=U5ux9NQxPJ2tfnrASHHJAe73/nym/ItbUAPXTW44vPeWiF8LBzZOD9PuLrCQp5Dggm
         7W7wsTz1LiKa/ZzThM7NPAzERVlS2FmSySi6K1IY2SJI6KVKBb9/Q6lUHQzz+Wf9ESwI
         Wu1anSJDwKlJJssUdefhT6ZfYuwIE9shp+uK4GyRVtsPDmZm8tSG8ynM1y1C32biD5ow
         07h8XgELV9wfqrj4/2Doi+/+viA1lkZtdrs94NYOotPNSg44oyblpQM0DRPDBECsSrHN
         Gy91Bt6iv3VJhNcbg7U4jrTa3lCpExbrlbZHAYNA9vAmMWkIqTnn5qRsu1nyXw/crC09
         uuVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794101394; x=1794706194;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4nRaSYlSCufm8SEc5msE/ZDkolmqxTXglEJWMOXfXhk=;
        b=j+gk6jrBq4KwvOw0dWzNyTgP8LLUSn42Khj2Pmi1YT711BR/GKxiCEhjzUNFqTafyh
         ioAOF9pSu0FhAJBxPE6mto8lLqntgLh8gTd2Y1DfOiOq3GR41HmD93UdNp6imzgmXJCG
         85PQZsgKZnieq05qDFb2pd2hX6ANP/HKl+oPPxMtTWHBTXTeWADmTkbFWCquT4ty4GI9
         jrDXs8FyKmlAiNd3MuFq6axMuduNLXffjk8YRNK9+NCOC5yBIaTJyYHLmqFefaH3gBdp
         qTSvN/jnN2kDDbsFPea4yGeAo/6JD0flLZJH2uF3vilmfoF47OQ/timEb8SEhdnN71Gf
         SljQ==
X-Forwarded-Encrypted: i=1; AKwUvBxcKsNPJaFyVkWzcac2lVv2r6vTUQQN4/oPckmtTQafNpf+CV/Ek5j5XqQCch6Ge6THiOV+enc=@vger.kernel.org
X-Gm-Message-State: APuU4Z9h+RI2x0mooCf9LU4hTPv/PfJt2t+32HclGhAUcois70g7r67a
	y4u9HkcoG4VSi/mDQ404eH+F6iTugB1GDwtlgVzmdbvrT09EEaWeLN2oMfSJFV1efo9ltvHGCjM
	D9RRoNXAoFJoYsR1JxvgpaaTK3Q==
X-Received: from pgbm5-n1.prod.google.com ([2002:a05:6a02:6185:10b0:cd8:ba74:813f])
 (user=yuyanghuang job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:730c:b0:3e0:f9da:3952 with SMTP id adf61e73a8af0-3eed58d7a20mr469878637.67.1794101393561;
 Sat, 07 Nov 2026 17:29:53 -0800 (PST)
Date: Sun,  8 Nov 2026 10:29:47 +0900
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.455.g6c5a503b38-goog
Message-ID: <20261108012949.3943642-1-yuyanghuang@google.com>
Subject: [PATCH iproute2-next 0/2] ipmaddr: read link-layer multicast
 addresses via netlink
From: Yuyang Huang <yuyanghuang@google.com>
To: Yuyang Huang <yuyanghuang@google.com>
Cc: David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

"ip maddr show" gets the IPv4 and IPv6 multicast addresses from
RTM_GETMULTICAST dumps, but it still parses /proc/net/dev_mcast for the
link-layer addresses. The kernel now also supports RTM_GETMULTICAST
dumps with ifa_family AF_PACKET, which report the device multicast list
with every column of /proc/net/dev_mcast. Patch 2 uses this dump. The
output does not change. Older kernels reject the AF_PACKET dump with
EOPNOTSUPP, and "ip maddr" then reads /proc/net/dev_mcast as before.

Patch 1 adds IFA_F_GLOBAL to include/uapi/linux/if_addr.h. It is only
there so that the series builds, and it should not be merged: the uapi
headers are synced into iproute2-next regularly, and the next sync
brings in IFA_F_GLOBAL.

The kernel side is the net-next series "rtnetlink: dump link-layer
multicast addresses":
https://patch.msgid.link/20261012011707.3378-1-sigefriedhyy@gmail.com

Testing:
- net-next kernel in vng: "ip maddr show" output is byte-identical to
  the current code for plain, -0/-4/-6, -o, -j, dev and -n <netns>, and
  /proc/net/dev_mcast is not read. This includes a multi-part dump with
  2000 entries on one device.
- 7.1 kernel without AF_PACKET support: falls back to
  /proc/net/dev_mcast, with the same output.

Yuyang Huang (2):
  uapi: update if_addr.h
  ipmaddr: read link-layer multicast addresses via netlink

 include/uapi/linux/if_addr.h |  1 +
 ip/ipmaddr.c                 | 10 ++++++++--
 2 files changed, 9 insertions(+), 2 deletions(-)

-- 
2.56.0.455.g6c5a503b38-goog

