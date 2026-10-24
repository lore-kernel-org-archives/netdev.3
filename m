Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792834083;
	b=vllIcXvMp9uWlqrOBa3kjNla9wFP4KUnHJ88r8ILn+MUjL8Ok6zuHvNLI6ydLZ8Yqba4
	 8acecUkiWFLh6tbTB2rDwSJaZQ6cW0e7D5E5T1qUkqcQh8J0wLWY6pkFF7xYyrL4sSZ1J
	 m8A3pkvTTLlHRWC//9yONvIr6+rUmN0AjAl2kMjebuLbelqQqm5v3j1e9bggEVEQs/ARt
	 ECr1A/X6Um6JvuAdBfd9hIKZTLS/xvhzcPDsQ4lsv9aP5iJeN+A/O98GU6A2z+M9FdI2s
	 BBrefEahjWQynI1C+23ySSTzRVF+SUpmWBz1gJQGL/SmUgqkZ1TQsgfZofEKpQGYvsA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792834083;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=j2rRh4N7cmK15/HNyDskN6MSE+BR1CVHfRqKHHQTGoM=;
	b=0D58JdwiqCywpTN8V2ab+AerOcX3Oe1AvZinMNsX3qOkcRcitC5GeQT/6Sgy8N/Yedhf
	 S3Jk0EZh42qks6mIng4Jo1tsmqbvjC2Yz7ER9uh5teWZcZY9ntdH1V5v5kwHVz1kt/zK3
	 Llsvag/cvk/yA8ByfEr1S0EboCtjk3pCSZ2GbxUi0N2TOWIoz3sw0rmajIRiYz2DK/H+x
	 5F8RMuXKwyyGT+gUgrEEr9bBX6hAL5jLmwIxPLYY4RYkybboCgHKHgrH0Qo1KvkZQZQqF
	 XP4akhn6fxSHZAoaNvA+HECzI9rTQ9tJcxtpxzRLSsn6i1XFZzfJJRbi0DQgtWqAcSQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=kt5wAM30;
	arc=none smtp.remote-ip=74.125.82.181
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 051C5606A31A
	for <netdev@vger.kernel.org>; Sat, 24 Oct 2026 09:28:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 051C5606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=kt5wAM30
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-35b2c599f43so135331eec.0
        for <netdev@vger.kernel.org>; Sat, 24 Oct 2026 02:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792834082; x=1793438882; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=j2rRh4N7cmK15/HNyDskN6MSE+BR1CVHfRqKHHQTGoM=;
        b=kt5wAM30en/eWwJ1xUWn1Q/+F9+W7xlIlkhPgwU8OW5vlcB+owd3ZNxVpig1TyYmrZ
         ODPxWvq77miY1Iw6X+fO8iZGu4ZaaRXIK+zq+xeqtYH3rQUCxQ6AqK6fOpJlAvb+Y7LH
         1IEfS25eMQ7xbwpurUIzgfgt8dYHEkilZSZ/y0KA5j3gfCsIChSX+TiCcCYZqp5Y3/td
         jVfE54k5ESPQ8jc6EW/P+Pqn91rbr97YG6BTJ2lbVxdtD1xvVUM0FZqckeM+MSZrb4zx
         UX5JtCLe09jvNpO29EikD+QGahnSji3o0o8F3Wyi7lFuECHa/4QjGTzvDxzgxK7PR84c
         WZ0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792834082; x=1793438882;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=j2rRh4N7cmK15/HNyDskN6MSE+BR1CVHfRqKHHQTGoM=;
        b=0B4RUuQvYHEWp3YiwzjsxrxrFAzSdH0IuNes5wz+S2ynStWx2Auv1J3YY2MdhqXmhe
         CV5vrzyHVINbXQPOjpcv1+BF15RIexdugfcU2rKjftbPLYnbdHtumRg72pURpRs8nhR6
         x6bzhs3ziCESYPsnuhMvRhBsINeeC0Eyn9Mk3fvNMGwlMpzTOvo8fvkKa9XGz10iMG/n
         TYGKbOYogaxnFXfWIkGLB8jdKzFzBXFLM8oxiosBjsGbKpXoxXXwvw09zjnqpwQVj4OO
         ysdKmZ6fyQ0CbecDUgG62RRLd0Z97bNDtVwNsURr7WITkpxCePQpiL9TTJGnPkGAbaRp
         USGg==
X-Forwarded-Encrypted: i=1; AKwUvBxzf4ClSe9OksPY4tSeVluXhqm/9Nq3T5qXgrhOIYdNqRCAXDStqh2cu3aSMop9L3VYpPZAKvg=@vger.kernel.org
X-Gm-Message-State: AFq9FYJplIYogcEzqGUS0qNL23F8KMsk6o11CCpo5sP3meEVmsoAIUex
	/n9Bo2gBUrl0fQK9Kt9Day7m3/pEc5byZVPZsosol8G0IcMY86CI27aY
X-Gm-Gg: AYBFou1vRWq9IZaDJkf06Skue+3wZYVqSWpLFM7mOIE7rtx880tURTfPsD7ChSBoirw
	M9D4ClARMn7X11VAcLD1AYVX2yH43qZNbhMSfZrP1Dcl+iWKMeU1EoaKRgfF/IuLGZrUPhbA2aP
	0kGxSB4vJzRQF6hEfU43xWViYQ/Q2WUc25zuSNx6v7JCJMj+DlTPioh7I+kc4Vd9XjjIObtJpcx
	EaTEV9A8iDTzVcxLtwqK2kprZgH7gqUR/z9uoR0cSxwsg+DBrWj1H9lcRy27OpltaKDG9dkHheo
	sDI0q+zUlUaoPZWpqFPsWtvR1EZR5oJqr7DVn6yv5pELc3gKtcv1p5QWuKtOt//vcK1DvUMTZx4
	3TpiSHPoa+X812i3MaDy3fveVY+lzoPtOjYWt5geOEVMcR8Aa1pqbWNh/4M3770YkRTYu8yEV2T
	NI6NG9L/EmdfISh4bzqfuvV173M5GqJSnU/6WgWaMw8SC3D+jKGhS/R9URHZ12rIhTjTiu4zpLQ
	Rqe9Q88QBbnUrDZf3D/EOVygJxSr/ouJXLKlqkGoD2cd189Cn4yjiBiWcegelcN2ckOctFFHTO7
	gFBpEVDF9wKkD7duE0MOLhFb4MTZOFF+FoMrMsoH6f8ErthXec/wcWR8LTYwbEPW6Kb6kIJnyA=
	=
X-Received: by 2002:a05:693c:415a:10b0:35a:7020:c08a with SMTP id 5a478bee46e88-369e846b175mr2885481eec.19.1792834082019;
        Sat, 24 Oct 2026 02:28:02 -0700 (PDT)
Received: from nixos ([2405:201:c40d:9039:e1f8:b9bb:b037:3cab])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-369e8daf444sm5236604eec.18.2026.10.24.02.27.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 02:28:01 -0700 (PDT)
From: Ayushman Rout <ayushmanrout27@gmail.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	Ayushman Rout <ayushmanrout27@gmail.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	netdev@vger.kernel.org
Subject: [PATCH bpf 0/3] bpf: Fix overlapping copies in xdp and dynptr helpers
Date: Sat, 24 Oct 2026 14:56:55 +0530
Message-ID: <20261024092659.76422-1-ayushmanrout27@gmail.com>
X-Mailer: git-send-email 2.54.0
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

My patch "bpf: Use memmove() to load bytes from an skb and an xdp_buff"
was applied as b93cf2c8a055. The AI review on it noted that the
multi-frag path of bpf_xdp_copy_buf() still copies forward with
memcpy() and breaks when the buffer is a slice of the same packet. This
series fixes that.

Commit ab08863c58b1 ("bpf: Use memmove() to store bytes in an xdp_buff") fixed the
single-segment store path and left the cross-fragment case open. Patch 1
fixes that case for both load and store.

Patch 1 fixes bpf_xdp_copy_buf().
Patch 2 fixes bpf_dynptr_copy(), which has the same problem when both
ranges overlap in one packet and cross a segment boundary.
Patch 3 adds selftests.

Testing: x86_64 QEMU VM, ./test_progs -t dynptr. With the fixes all
four new tests pass. Without them the three xdp tests fail and the skb
test passes.

I also read the other memcpy() calls that could touch packet memory.
I found no overlap path, but this is not proven, so I left them
unchanged: the sock_ops header option copies, bpf_file_fetch_bytes(),
bpf_flow_dissector_load_bytes() and bpf_lwt_seg6_store_bytes().

v2 of the earlier patch:
https://patch.msgid.link/20261022112312.31563-1-ayushmanrout27@gmail.com

Ayushman Rout (3):
  bpf: Fix bpf_xdp_copy_buf() when the buffer overlaps the packet
  bpf: Fix bpf_dynptr_copy() for overlapping ranges in one packet
  selftests/bpf: Test overlapping dynptr copies on xdp frags

 kernel/bpf/helpers.c                          |   7 +-
 net/core/filter.c                             |  59 ++++----
 .../testing/selftests/bpf/prog_tests/dynptr.c |   4 +
 .../selftests/bpf/progs/dynptr_success.c      | 128 ++++++++++++++++++
 4 files changed, 172 insertions(+), 26 deletions(-)

-- 
2.54.0

