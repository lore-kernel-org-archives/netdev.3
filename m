Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792668230;
	b=QwfcoXnuFlHQIs1jeODu69EERQkeZhIrtlhXyBQc0Mj1O3HQgRb+O5sJNgWpaT/o2VEB
	 bxjwni3wwDvSXY7GiEco6pmTb13Mn+AiB+HhzaJzHCpZ3G/AHKEVoR+KyYUqvgEwoSwom
	 PxSHRGOi7dJNKEojqicYDZ3/cS0M89DXNeAyjZQ48yw9fwf2tFxov+4XQ9I/9ApjxSUhZ
	 QxPiFM/UmOW72Yg1/oXsbRpitypy9skNxeYZlhXCgMYqFjRnjPmzppX7tnRHziVQ2ChKw
	 eYlwhpGT/4SvNZp2+TEmos6Erwc5Q8jhcPqxeQW1l5QarOUwl7n9Y6p74XxjTNY+kDw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792668230;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=xPX5Pyvu3KPuA/BeOQ2DAl4emTBwilJ3yODW3aKnjPs=;
	b=MSgjCMK1buTpJQsrzNtiZVVwOoelAWdO64yENffw44A2o8BhLpSHjx7VGMvkISP3tYHo
	 j13BoPhsk1HY5hYZ0evyO/gk6yBWXddKorMiiG3BAB23v07j4aI6GCjm3mCmpKTtpBJ78
	 Pgf5qlswNSbBwNk+EMO574rKeEabNhuyGlCKRL4XcIATUGAviOyRMui7/6p/2GBFXDncF
	 t5H7XPKPNAuifDaTKAzNulNP6aR5E1BgUNIWWnYlIZycXfKxd7eO+muoVol55CUqwgxxT
	 xx8q0Dhg9l7AU2sxegaToDGtrnQ7000VyQTYEou8CWCsVP329N/uOM0ziXR8qK2NbyA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=qnMao6zB;
	arc=none smtp.remote-ip=74.125.82.53
Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B792606A31F
	for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 11:23:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4B792606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=qnMao6zB
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-15dd124bbe7so3239725c88.1
        for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 04:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792668228; x=1793273028; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=xPX5Pyvu3KPuA/BeOQ2DAl4emTBwilJ3yODW3aKnjPs=;
        b=qnMao6zBmkB8laPqkwE731uNdh2Rfbbc/wwRETP88zq+ppjznHTWEr74A9TFIiCXKs
         8QTyqZmT91XGxm47SdmAOIzeCMOFOlxkkg0GbWzlUDocTOnSqkK1gzuTirc/ts5/jfBg
         jrjSM5OdRHUF0wwJnas3KFENmnU0Dvz2EtprKgPTymzylLeVcq5wIKvVeUGRrdtYpRoY
         TdiyFajkatu7UxuFuOxvT3PVmTH+ErB4kS7LsXyIwale85eQm+5E8u1r3RbpYo++PQoR
         bguTebPwKYv7/iWhGZ8xFpD0xTGIgDf5do/g/wMJapjt+qG/8M4L5A0HTIP7ql+3dpw0
         qePA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792668228; x=1793273028;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xPX5Pyvu3KPuA/BeOQ2DAl4emTBwilJ3yODW3aKnjPs=;
        b=sn4CNdIGEcnP+8d0IwmM09pjxOXRVLKknBlT8iRuvjhD7ji6YeHK0T6dK8lrDmgSO1
         zRA/NyD6VevSf9ZsLcy0npqQAl++FIRCTdTjgQZLYjiuR48rjMUeCx27x5mNXWMDz5dM
         FGryts4m8czdYXoJGetQBMxVQQqFrJpRcB0h5mj+mSeUenScYOK7MNlmdpKctJJeLqqu
         gtEHzfIevrSEUNKmuLLAK15W6NzuDcveaJ3iBMOpHn2AnaPIRh7DorREjACJmZ99LhGg
         W4wXl33jP0IPZYWywVbBIF2bmINlHsP4bhZcRoZQs0FXwC4W3q7xoNVkuYV+RgJqhbAm
         Wo/A==
X-Forwarded-Encrypted: i=1; AKwUvBwLcoBZwCAivk9B9e9PrYXSzkS94dlYoGB1t+IKzF7xUWaVFb6O4MLso/kTbyesxx6TYANiZYM=@vger.kernel.org
X-Gm-Message-State: AFq9FYKiO1RdLpQIMQgYbD/HOEroOrDOFK7XGYOWeBkbvbMJHYTnyhiQ
	t0pZvXm395brL0AEyYy0VfVho1p1n7s55pB6jjvDs9JKTM6XW2VNhfRI
X-Gm-Gg: AYBFou0clFBVmXaUeJuX3mo1enjR5sxOQw/A38hqPUDHcMuiop7KlwPAv5IC/x9/Tuh
	cCWWLUiLAAMxACh9O1jRkaOXUhxxs6kY3hkk7L36lnowlHMSm/Jhy5tZzoeihdloifNqsSH1eis
	IwSardoif1c4PpXt7Nir3xQ6BQu8ohoa0lN6Fv9cgOjsK2hzDAvD907p4vUw782z10bxBZyh/+E
	9gUOiN+UHE6dqAvEGm4irs+rdl3JYetbVO+FN7U1qTMaoi3zItVRUopfLgqyrDuLSZUwoA4LDyx
	HoYUeHJI0Vu3WLNAZ6g/mNKKAR2keTzVM4sc9joFtMkfJc8LbPzdrkYubMi7RitIssqDeNlETO2
	JaB0jL8EFW+XkMn16nSLSXfS3rCZcJ3VH1kVgjKhTdYb1bnLWuWkGxxqgB0ZCf9BnZi5HzXMqsD
	CpH0nMNq42TQx0Cz8xllxQLHaUn4P0Js8SjffmzwukNym2Pmgx3XmONhXLTDf/3fMFDz1hrUFqN
	djJ+GUanNXIDQPzkOPF0wvfj8w1rlyRO5jqoDIXRr+YOh6rYgXfn3sMK9zGOshz11yEUwEu53kv
	WgVYU6qlQ/j4elugCSvDLEj2XrHb1uOSPoY6VMKS9mc50Czcci698yUHvf7a0jcBdOWM5kdHm0I
	=
X-Received: by 2002:a05:7022:1187:b0:194:3a84:e67d with SMTP id a92af1059eb24-1943a84ea04mr1111760c88.44.1792668228302;
        Thu, 22 Oct 2026 04:23:48 -0700 (PDT)
Received: from nixos ([2405:201:c40d:9039:d12e:70e6:689a:f754])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1903a275026sm21529104c88.5.2026.10.22.04.23.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 04:23:47 -0700 (PDT)
From: Ayushman Rout <ayushmanrout27@gmail.com>
To: bpf@vger.kernel.org
Cc: Ayushman Rout <ayushmanrout27@gmail.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Daniel Rosenberg <drosen@google.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v2] bpf: Use memmove() to load bytes from an skb and an xdp_buff
Date: Thu, 22 Oct 2026 16:53:11 +0530
Message-ID: <20261022112312.31563-1-ayushmanrout27@gmail.com>
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

bpf_dynptr_read() on an skb or xdp dynptr ends in bpf_skb_load_bytes()
or bpf_xdp_load_bytes(). The destination can be a slice of the same
packet, so it can overlap the source, which memcpy() does not allow.
On x86 with FSRM memcpy() copies forward, so a destination above the
source gets the first bytes repeated:

  p = bpf_dynptr_slice_rdwr(&ptr, 8, NULL, 64);
  bpf_dynptr_read(p, 64, &ptr, 0, 0);

leaves bytes 8-71 of the packet as bytes 0-7 repeated, not bytes 0-63.
Reproduced with BPF_PROG_TEST_RUN on both an xdp and a tc program.

Use memmove(), as the store side does since commit 1db084f42884
("bpf: Use memmove() to store bytes in an skb") and commit ab08863c58b1
("bpf: Use memmove() to store bytes in an xdp_buff"). A read that spans
xdp frags still goes through bpf_xdp_copy_buf() and is not changed
here.

bpf_skb_load_bytes_relative() has the same pattern and is reachable
from tc and sk_filter programs, so use memmove() there as well.
Reproduced with BPF_PROG_TEST_RUN on a tc program: loading into a
slice at offset 8 gave wrong bytes before the change and correct
bytes after.

Fixes: 2012c867c800 ("bpf: verifier: Accept dynptr mem as mem in helpers")
Signed-off-by: Ayushman Rout <ayushmanrout27@gmail.com>
Assisted-by: LLM
---
v1: https://lore.kernel.org/bpf/20261021103957.17532-1-ayushmanrout27@gmail.com/
v1 -> v2: also use memmove() in bpf_skb_load_bytes_relative() (review by bot and Alexei)

 net/core/filter.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index b7ac145b68b1..09c60a58c82a 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -1789,7 +1789,7 @@ BPF_CALL_4(bpf_skb_load_bytes, const struct sk_buff *, skb, u32, offset,
 	if (unlikely(!ptr))
 		goto err_clear;
 	if (ptr != to)
-		memcpy(to, ptr, len);
+		memmove(to, ptr, len);
 
 	return 0;
 err_clear:
@@ -1871,7 +1871,7 @@ BPF_CALL_5(bpf_skb_load_bytes_relative, const struct sk_buff *, skb,
 	ptr = start + offset;
 
 	if (likely(ptr + len <= end)) {
-		memcpy(to, ptr, len);
+		memmove(to, ptr, len);
 		return 0;
 	}
 
@@ -4298,7 +4298,7 @@ BPF_CALL_4(bpf_xdp_load_bytes, struct xdp_buff *, xdp, u32, offset,
 	if (!ptr)
 		bpf_xdp_copy_buf(xdp, offset, buf, len, false);
 	else
-		memcpy(buf, ptr, len);
+		memmove(buf, ptr, len);
 
 	return 0;
 }
-- 
2.54.0

