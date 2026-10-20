Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792511941;
	b=XViBnU/u76bwr+KWivabJZKHhisEYrYU9TLOSvFWQp/wIP4P97nxghIxGxZgUckp3HJn
	 MyEmW5OIkQlGkd/LoEVN6broFgZybjsZYQL1fvgj4PPzy5Xr2i2No2ryaVMwv+W1RNcYL
	 et5fWRS6AdIvpYPG3aObc+ooRPX2xJlZgoS/fDf/E/EpouPK5wE8r4CyVd5fXee/JQa4U
	 LR7b5LZvhfe69Akgj51Oex3fMa95HQaMn9bgNm7AX1ZFgRDuS1ch3YdEymiiqMAyttfZ2
	 onaegkdtsyEYhHfIRf1UX3gC0Jqprl4MQoDGa9jQvP7M3NvkfsszmUmzLwjPp3U8JcQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792511941;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=H4H7iRSUlsSj9ifdlVtDp+ziRohA+ewp4DyoXrJPO6Q=;
	b=UKkrKp+bENbQWDRvRxru0yhDQlSLRV2uwP1ymu8SXYPGG104E7U4iZmrVXTuptoMX5XL
	 IGLdu7MCLNROaUgwNkDUEwvoZVwklZt9MABDPRQ+TPE1+yXeXurZj+Ofl1s5McTgAq8Mg
	 hJ1FKU3tem4anjq/pY62eI45GXAKvdcti+m7Qtpkz1KY+baJf9ek1fIvZj5jHCxCGhox4
	 akfZqU20HIbwuKA4kCUDgE/elJfXw7galRR0VCEn8XRvlYIQGrlafT6013Ner8ftCERRA
	 k+aBESiac8f1P1WYvo+188SDB6atINQTwfiBWQsGdmES/V1vOyFvYqMJgwvaNRWR9lg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=R8iBNnGY;
	arc=none smtp.remote-ip=209.85.128.44
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DB97606A327
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 15:58:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1DB97606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=R8iBNnGY
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4a1e2957d7eso24580215e9.2
        for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 08:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792511938; x=1793116738; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=H4H7iRSUlsSj9ifdlVtDp+ziRohA+ewp4DyoXrJPO6Q=;
        b=R8iBNnGYaqT/wGTjR7wkqrvY+S3fvytGSkjEUzOmFr8dCGfdqjyLMjhUjrzdLPNQar
         Qly8fNmIxnutCyFiTuBB9EZMl/5V3qTDS/UzBpZtriUgp1ryjFgaA1xM5JEXXSKPz+6W
         Iy6REj4P5u+N+0MX1VxxtNtesU9/+cTibZixvOYM5tawFdR8NuBDGj1lahLxq61D/Pte
         MkG4RP71Ysjh4yQoLQ07bDUCbEmbTQZYvRnvLzlEq3mGWa5E76ZUKrgA20C605xF1hjF
         3SOI5B7T4BIv0zDBqTa8WOHDjqQ0NiMNNuoLirHSLMmrKGL/VqmA5DSrxfChWBGkJXtQ
         x61Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792511938; x=1793116738;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=H4H7iRSUlsSj9ifdlVtDp+ziRohA+ewp4DyoXrJPO6Q=;
        b=jwk873c3Q7jx/OGdRjIIbmrGVEjATUHnDOA7THmCXwRwtGusl//9hydwHb7PeccqgS
         wNKd6tokY73C1jQtDEQQjxyXwAwYGx/oo5Hihz/0oGLMStQ3xShEn1sTQtbYXioUWL/p
         9lkO/HZ4727Oet7rKNm54UL8Cy6zUVKr/WNlZqBbZTH+LMpdNuMkVhlvOrqTwREbRX/0
         04S8ucZ+UzmYjF74GED9WKL5DnXvqwWuLwEwV0SpYwahEw9fsSZ0XtailiDSvhsDU+r2
         mhfABpad79QKjSY0RrpHp9U2dOAgA4PYTIjlvkVaMWZkwZ53iz+TTjn52WYM/dZ5CBED
         BweQ==
X-Forwarded-Encrypted: i=1; AKwUvBx5BRuddXtFbx4rKQ99Kd7fkjFrE926ZQAfe7Zujf6a8h8kP/XdL22UepFMIbnStAvKItJsAMA=@vger.kernel.org
X-Gm-Message-State: AFq9FYK+/Xmk529S+IPl337JF199gEsR9P+P+vRio5wKQB1DqAb7yXGX
	RNshaBUEajUqkkTRB0AGQxlMbfqRhuUANrDo4K+vrLfSyj8bN3DoLeg7
X-Gm-Gg: AYBFou0iG0YuVHlE24u6wfAal9rMjM0Urzp6vHfzg8R4JIiLziqQ3nV25IQ3mtTYxni
	Ei5MD7hjdLWCw2ZTXP3qYNRSx/FiZfFsJnekAmwDQlRzgMcjT5OXsrijvBFb/GByR0CgRIDqZJz
	mfTXfhsZmjr1zQsEWvyT5C1a02WhFoVvY6FChgtYzjE8vf/soSw6DfZX0SA4++4ob9iFYTgnnLP
	mGLLaL5FUsxzWmExov9u2FjaQLiWsvynWPD2i/Sqa9/+XWS/eW66YvU+GugW6m8kB9RVQ2QREpt
	kpPHIS4sFq4BMRMTDhedO2GWxEC87Bpygjx4HV8m+xMmCwhWlC5rclY8tBM2qzVnv2m9h0tHm+B
	FIBpFZWAe+J/aF3e1l2nsvknQdM7GAJoAz4mRJ6xyFws9xh2JhFPP+XKtZH8mwkKVDMxLy91V4Z
	K9sfTzYMg2glTW6udXYpVKOiLx5T3b53Paf2wMeqPDPBXbb06IVgWelgLGHDbdpW2qVQBcsqcyM
	caJZE+q8kf1VBofSPk8KIgNFMBTkA9YtHhdz7hZKPIAyA==
X-Received: by 2002:a05:600c:4fd4:b0:4a1:cd83:f027 with SMTP id 5b1f17b1804b1-4a1d7634bf5mr214566405e9.27.1792511938310;
        Tue, 20 Oct 2026 08:58:58 -0700 (PDT)
Received: from mtardy-friendly-lvh-runner.europe-west1-c.c.cilium-dev.internal ([2600:1900:4010:1a8::])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4a1fb83ff02sm5627335e9.6.2026.10.20.08.58.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 08:58:57 -0700 (PDT)
From: Mahe Tardy <mahe.tardy@gmail.com>
To: bpf@vger.kernel.org
Cc: andrii@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	davem@davemloft.net,
	willemb@google.com,
	eddyz87@gmail.com,
	edumazet@google.com,
	john.fastabend@gmail.com,
	kuba@kernel.org,
	horms@kernel.org,
	liamwisehart@meta.com,
	martin.lau@linux.dev,
	pabeni@redhat.com,
	song@kernel.org,
	netdev@vger.kernel.org,
	sdf.kernel@gmail.com,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	kuniyu@google.com,
	memxor@gmail.com,
	emil@etsalapatis.com,
	almagui@kernel.org,
	Mahe Tardy <mahe.tardy@gmail.com>
Subject: [PATCH bpf-next v2 0/3] bpf: Add bpf_ksock_sendto() kfunc
Date: Tue, 20 Oct 2026 15:58:45 +0000
Message-ID: <20261020155848.75711-1-mahe.tardy@gmail.com>
X-Mailer: git-send-email 2.43.0
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

This patch series improves the bpf_ksock infrastructure in line with the
work proposed during Prague Plumbers 2026 presentation[^1] by adding
the bpf_ksock_sendto() kfunc to complement the bpf_ksock_send().

This is useful when using ksock to reply to differents peers while
reusing the same UDP socket and generally works toward the goal of ksock
to support the basic socket operations.

[^1]: https://lpc.events/event/20/contributions/2430/

v2 updates:
- remove the LSM verifier filter refinements (alexei)
- remove allowing calling connect() from the send path (alexei)
- change order of the tests patches for signature definition (sashiko)

v1: https://lore.kernel.org/bpf/DM9RCU3BDWEG.1C32ZIVU95S76@gmail.com/

Mahe Tardy (3):
  bpf: add bpf_ksock_sendto() kfunc
  selftests/bpf: Test ksock sendto()
  selftests/bpf: Test forbidden bpf_ksock_sendto() LSM attach

 net/core/bpf_ksock.c                          |  96 +++++++++++-----
 .../selftests/bpf/prog_tests/ksock_sendto.c   | 108 ++++++++++++++++++
 .../selftests/bpf/progs/ksock_common.h        |   2 +
 .../selftests/bpf/progs/ksock_lsm_verifier.c  |  25 +++-
 .../selftests/bpf/progs/ksock_sendto.c        |  59 ++++++++++
 5 files changed, 262 insertions(+), 28 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/ksock_sendto.c
 create mode 100644 tools/testing/selftests/bpf/progs/ksock_sendto.c

--
2.43.0

