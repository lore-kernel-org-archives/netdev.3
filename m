Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D928838B7BD
	for <netdev@vger.kernel.org>; Tue,  1 Sep 2026 08:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788252443; cv=none; b=eYmW6QSFk75NpZv0cyJjEotD/k2Xj/iQGVSAgWYtVnZrrR9aJm8B3Uo5kkVKsdR9uG/nbvf6JRfKgLMcAeGOUcQpJ8KZSOlsmdCzrw2GDryuXoPATlOiLwWyXagSsqe0XPQaFdcVsXOyCgc38f5ySonRXDxRbYEYHRx+iWCf2uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788252443; c=relaxed/simple;
	bh=vEYWpDRYJlt/x20Qp2NH2lICQ3CeU+BjrZBkfkO170Q=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=rcsUX6YzvC+FIkbdp37xLhsHBkYgKlUyXIy0kRcqeAK9DD3RHJnKj7llOa3ZcvhMLTs3xdl5Z2TNbPybHl1fp2E1MuH54LwlqvKwPbBd/yx4NlqxZVgJ69PINs+dbPo09y4k0JWMpLzJCb3EClodn9giICkeJbqyoI7hXYuipL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BM8dD6Z3; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=FfH8F/BZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BM8dD6Z3";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="FfH8F/BZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788252440;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=z8ov4fvu3pyuSUdXNf/YgYYE8zswwHkIX6MWfjo8QZI=;
	b=BM8dD6Z3i856XT/4xU5uWD1MRsxeufj4nIRTfGgM48ihBZ0bMEoSlDV6B5wuKzwcSNaDAj
	H3NAIzlRqI5woiPJAJOzoPkH6FwpeaRY1kLZl/acNHNL0GIxnauQ9YFixlK4b2JWVRIT5p
	Nddcf2mGeagifXj05LU+xr13oJAg4WI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-628-06xcRCjlMJSkdmACoTWJaA-1; Tue, 01 Sept 2026 04:47:13 -0400
X-MC-Unique: 06xcRCjlMJSkdmACoTWJaA-1
X-Mimecast-MFC-AGG-ID: 06xcRCjlMJSkdmACoTWJaA_1788252433
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-493fa6e28a7so30816105e9.1
        for <netdev@vger.kernel.org>; Tue, 01 Sep 2026 01:47:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1788252433; x=1788857233; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=z8ov4fvu3pyuSUdXNf/YgYYE8zswwHkIX6MWfjo8QZI=;
        b=FfH8F/BZWZqmgZiMcmUJHpFgmrvecpttBGmws6M2lTb7IZbIZo9izZxkfcMCDuKhco
         3WVRegqG91CC2KR1nAZyvi53PrQy8ibPfXBkezZAbmAbickrVyfro9drfFUlBpOxeWHS
         e7D6LYLIfOiP1No48qshXJi6f3ysxsHeId3HUfCDfLAhlmEEba0uBkBkwgunRlvj/i9w
         jvIqWgtpCqqPYnHUh3NBhrrr0o1EWe/HYZ3XuV4bnGR1yCVanPH1C8KApMATuT0onwqm
         bs7dmiRZ69zNAreNsBsEM0GWDKgv3TguSGDakG+EGtz4qyzBXCCmxf2kSqxuGs2t+uqo
         +ZaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788252433; x=1788857233;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=z8ov4fvu3pyuSUdXNf/YgYYE8zswwHkIX6MWfjo8QZI=;
        b=meZ6YKG1HybtEMis1u8lnFqtXwRkfG4SPR7ZwxzFRQStNRh0xddhyGCwlb5pgAXpYj
         GNQdwIH9pvTUIOcbAIe7yKPJ6W72vSgYRmCqgHSkpAb6r1iW8Ra6UZznYPl15wrjo4p2
         FoQAcEa0I/3qHybT2MVmrW5wZO40H3DJEmHQFlGfk8NqbImQCGR8rhwYsvN9DKADVIh5
         pT9RKpiwZTEHcp+Urejn5MjxQpVsDfo28GcgLZHlDCo36pxbwAlxR49RDPc4fstz7Vbs
         W6Drxe4UB7sz6n5vrpUqdaxEFypWMwcrvIVd6rEMCSPoGfBoFLfcq4GoG1bTqkVSrw5V
         u36A==
X-Forwarded-Encrypted: i=1; AHgh+Rr8ygjuiPsNZwoomMat+jXTmZin1xtWbo42o0N/s7wjqYMsfnjhk56HWRUD5ZAEH8yMyOCNUqg=@vger.kernel.org
X-Gm-Message-State: AFuF++lji0Lf8jJBfxq/0X8dfyWPiV/sf+/CuQJGCoEC7FQl3/ViR8BZ
	M314YdX+Uf3UjNqK6IVD9I5kbtmV1qerkzCywHsxJSwMxrZQ2KuxDTBERKFTPuxqgX2RrFLLTNP
	JXKGaF3uhs2jbGWg3ja4hhjkIewIRUubqfOpO4INso/z/1X1l28FgCUTNhw==
X-Gm-Gg: AR+sD10WxqjUwPblzemhwWOQF0ALfoRplLGMoH10UxO81EkhqDqMYmk74A7xw1afGeZ
	m1ms2YwEODNGqBPyXoT/sQ/z8JteYdNaEUSoqTt/g/uBVwWG7QKSDtJlaWoF+qviwN3r4udC8WS
	miYMRIDYqyKysdMIHihUFUrHz00bzjN7GEdzusFosGMO5ZB+VIEDmXJoA28AnUDpEG33YY6sQ6a
	ZciLjZdLWevTbEvlhX/0oqiB6W56w9+EqSP0gETVJQmI8rtEcwHq8S+a+ZhPd64E+NqpEf6hNMZ
	k+xe2+LPMLXBIC59ANz37fDbajQqbYF2zhjwfVjFT50T0CkneW9vRzdDStRzgopL5IF2X2DOJiL
	b7cblAVsQQU9lIn4Ms5UHuS/f
X-Received: by 2002:a05:600c:81ca:b0:49b:47b3:d6d with SMTP id 5b1f17b1804b1-49b91c3b7c4mr553882315e9.10.1788252432554;
        Tue, 01 Sep 2026 01:47:12 -0700 (PDT)
X-Received: by 2002:a05:600c:81ca:b0:49b:47b3:d6d with SMTP id 5b1f17b1804b1-49b91c3b7c4mr553881435e9.10.1788252432157;
        Tue, 01 Sep 2026 01:47:12 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49c5a903eebsm220814965e9.4.2026.09.01.01.47.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 01:47:11 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 8AD2497C51E; Tue, 01 Sep 2026 10:47:07 +0200 (CEST)
From: =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Subject: [PATCH bpf-next v3 0/4] libbpf: Move section-defined program flags
 to prog_flags
Date: Tue, 01 Sep 2026 10:46:53 +0200
Message-Id: <20260901-libbpf-frags-flags-v3-0-4eb6f14968b0@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWMQQqDMBREryKzbiDREtCrlC5M8mO/SCr5tgji3
 U3azcBjZt4BocwkGJoDmb4s/E4FulsD/xrTRIpDYbS6tbrXRi3s3BpVzOMkKi41rQtEPvTWmDv
 Kcc0Uef9JH6jjRPuG57+Rj5vJb9WJ87wAtz1/IYAAAAA=
X-Change-ID: 20260901-libbpf-frags-flags-6bdeecd96114
To: Quentin Monnet <qmo@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Emil Tsalapatis <emil@etsalapatis.com>, 
 Ihor Solodrai <ihor.solodrai@linux.dev>, 
 Larysa Zaremba <larysa.zaremba@intel.com>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, Lorenzo Bianconi <lorenzo@kernel.org>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, 
 =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
X-Mailer: b4 0.15.2

This series moves the libbpf section-defined program flags into
bpf_program->prog_flags, thereby making them available for applications
to inspect and modify before loading the program into the kernel. See
patch 3 in the series for details.

Setting program flags with bpf_program__set_flags() was always
potentially a destructive action, as it clobbers any existing flags.
Since this changes the flags value to be pre-populated at
initialisation, this clobbering can be visible in cases it wasn't
before. To prevent any fallout, the first two commits fixes up existing
in-tree users of bpf_program__set_flags() to be non-destructive.

v3:
 - Also fix destructive flag setting in bpf_verif_scale.c
 - Reorder patches so fixups precede the libbpf change.
v2:
  - Use a generic section setup function that also applies to BPF_F_SLEEPABLE

Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
Toke Høiland-Jørgensen (4):
      bpftool: Set BPF_F_XDP_DEV_BOUND_ONLY flag non-destructively
      selftests/bpf: Set BPF program flags non-destructively
      libbpf: Move section-defined program flags to prog_flags
      selftests/bpf: Check for flag presence in bpf_program__flags()

 tools/bpf/bpftool/prog.c                             |  2 +-
 tools/lib/bpf/libbpf.c                               | 20 ++++++++++++++------
 .../testing/selftests/bpf/prog_tests/attach_probe.c  |  6 ++++--
 .../selftests/bpf/prog_tests/bpf_verif_scale.c       |  2 +-
 tools/testing/selftests/bpf/prog_tests/kernel_flag.c |  3 +++
 .../selftests/bpf/prog_tests/kprobe_multi_test.c     |  2 +-
 .../selftests/bpf/prog_tests/xdp_adjust_frags.c      |  3 +++
 .../selftests/bpf/prog_tests/xdp_devmap_attach.c     |  5 +++++
 .../testing/selftests/bpf/prog_tests/xdp_metadata.c  |  4 ++--
 tools/testing/selftests/bpf/xdp_hw_metadata.c        |  2 +-
 10 files changed, 35 insertions(+), 14 deletions(-)
---
base-commit: 1555de33018fad06ca5dfa2fad5d3d1c6a6eb2fe
change-id: 20260901-libbpf-frags-flags-6bdeecd96114

