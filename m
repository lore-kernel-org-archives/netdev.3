Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792579234;
	b=2Ok0UOWqmO4qoUvQbuPLbldFeT+quCChxxXv90YAUxSVWMblh4C+yTrKRK0BtD8cwwH1
	 fVIczEvB+hfwPNKqBS+//L2FqI3Sx5kKaW54Wy7Icg+prXsE9Uool9tpQh0H/Nt0iWYKW
	 BoNAPxLF7SUVdHG1SaOs7i5ua9IbdzzKATNLv4efifnmgFiBftIz3VcNLTcN6zflL28Dc
	 Y9E6f5nTTiSVvMkKEXcq07GrAKNhlBEcwwGeTZXp1YIsUlQrdgM5ODO3TnHq+x4jmVjbk
	 Vn1WorMzgSVEL9Oj6kj0Vc2xvF07TuFOQc1Bs/VRbQ/M8o5f0WGPESIUtZOGGTtKqpg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792579234;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=xoyujad1pnAtgsjpNYpF5h6AG9Uxc92FFpX4Fpj1onk=;
	b=0Q1IOA/T9lM5EUX/wFVvPyIQLibuXwW4uMKXLZetHTQyU6OUoR4sBeFph2Pvsmtx/U6Z
	 i3zCihuT1q/od8l2hX3Qm0vTa/N/Zz3Rn/aPTkg5i1cYywl9rerpBpBXCM+VOCIsvxJsw
	 O0O8lm2r+Z5+hTVUtbEfszzZ05c09ZABAOJpROGBUiwfu57wtG6Wl9uWu6SToTIrHNC2O
	 +n9ixQMSUg8SvioOSw9Z9AmBRkRCIDADpEox+etixv0EwZ/IJXiFNP+5yv4LOA77UTzuN
	 8v9//KwG8ezOf/075K0cPDvwpzRoZQ6WyY3r9mEDzX6v+E8UE7hCeD+bFLeftWH1QlQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=g6ZKHQUB;
	arc=none smtp.remote-ip=74.125.82.169
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EC90606A31A
	for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 10:40:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5EC90606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=g6ZKHQUB
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-35cd4e8bdbdso1092975eec.1
        for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 03:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792579233; x=1793184033; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=xoyujad1pnAtgsjpNYpF5h6AG9Uxc92FFpX4Fpj1onk=;
        b=g6ZKHQUBu2X6mfrG0PI64doqcpJVyn5zswlzh4Wn/wKt+qR5tZYZRw2DdCAkFrmy5D
         JhBW4SnGcTrrU73C7N5WBKrIlZMGdabXqri47yxoTefBdSF/RrFkTljs71b0kwJr8ws5
         inYITblh1DsVIST4KNdlqmTff4sjCGtpLI46Q3kQDMSByPMqnsD41R0LD39+vGni2oIH
         qlbESQky05tN3SqaOhjCjiVU9VICCwNOPrFEKtx+/YJusLn24sfmjuD7Nj8ZOMN6YM0u
         TsMz5A4o/NrJLyh1XHkMV/kBx6Sh2N6uVS6PkoHKGZMhVSfZhlU9U0rKSbwkBLt+ivEE
         E4cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792579233; x=1793184033;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xoyujad1pnAtgsjpNYpF5h6AG9Uxc92FFpX4Fpj1onk=;
        b=riwvH3s/K4REF+Y5bl9oBSwxkntaDpRex7J0rfsV9iB7r03Z82FDGA9cgGOd8LmyJ5
         iozIY97CMFqEFPvAmriW8aZ8dsJ6LRjhWMfi8yGQvV04Z1C9TVQKrkOXhoIWrc4eEQQP
         IFqWYOsUHc6AULjron5FcAAsX3uO5YaeSPNRgj1qc0lBA7Nymhb1l7QM/NJmstt17FcS
         U7XTIGgpLbMGWBaoVZmxZc9gI4wokalXe+537c6Vt4v2p2gJ/7toJvpx3laR1zENFVFc
         i27u/KsSfScbcfUaGNSxCS1u0khmqTP68EQvRPYr7ELmMgixMXGp0vug4Une2VKN2Llb
         o55g==
X-Forwarded-Encrypted: i=1; AKwUvBxSqa5onGtkPQVdgU6f2cSO5uVrX3fmllSK40L8xEFoxNEc1eVljOZUazJMiIweJPKYxWkJs4w=@vger.kernel.org
X-Gm-Message-State: AFq9FYIwd5IjLk/Srx+tz8yfx1rfTGQmotcvsamKVGLdEuy/hW1QvAjD
	9a8nmZnUVhJeCKXQXomcFdVCKHSFaisQ72aHcoaWitf+zftd1rRbWUKn
X-Gm-Gg: AYBFou2ZXjgHxETcRICVMqT2BfIzZS4p7f5wfQN4sFeVWjuGeEtz+11MiZKTqf/dJRc
	0b2VLSC2sDG2iwXXWneGdfcO0QOqizre5he21/mY++GYjyjan8Op9vfot8cYA7kSm1l5NeFAdGi
	ufxRlITZ+9HmoygUX5DntaNGpp2j4D5IuEgmyC9VZzpfJWivwQiSNjjL9piWoTdF1Y0YbzCkXmC
	YVptf4m/XV9J8bEP1i9to5VTKct6rri1jCGA6dWx8QqvrmDZ+4yVImsIIAnabEFNKV/KvlyP2bM
	Z5rUOeYV+F2UYYBE1GvI73RAG1vah6Lxlie8IHRJ7k3bi5lW8KUyDoe71FGixuU6rqDtVP43PB4
	ldCc2ghYYdSLxD3k1qLD9oCym7YTF8dn8fCKxI+Ag5N/2lFTIW7684c9g7wsJiIGYjguHxEt1un
	hmWdTQAoKtCUy43/XMUdLWO7dO22iQwgnBz9HO2TitHoWdCUHglNHj/kpakSzXuMboDQOigIPOD
	UZ2l4BZK4N1ijXrx3c8YmvmUBD6c72bKsAcF7Dq8i+LF5Dz3FGEx2t/HGm8eHUuy2dROM1luuw/
	u5aFJDVLTXrBbHu7VaAisnju74etRVtqlrbDWrKkxp8i9nOTbnWA9lJ0E2ZtCWsgen4BkxKe
X-Received: by 2002:a05:7301:da06:b0:351:8cc4:e18b with SMTP id 5a478bee46e88-3674df50b8dmr2692342eec.20.1792579233319;
        Wed, 21 Oct 2026 03:40:33 -0700 (PDT)
Received: from nixos ([2405:201:c40d:9039:5209:19f3:3930:87a])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3673e24933csm6096611eec.1.2026.10.21.03.40.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 03:40:32 -0700 (PDT)
From: Ayushman Rout <ayushmanrout27@gmail.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	memxor@gmail.com,
	hawk@kernel.org,
	drosen@google.com,
	netdev@vger.kernel.org,
	Ayushman Rout <ayushmanrout27@gmail.com>
Subject: [PATCH bpf-next] bpf: Use memmove() to load bytes from an skb and an xdp_buff
Date: Wed, 21 Oct 2026 16:09:57 +0530
Message-ID: <20261021103957.17532-1-ayushmanrout27@gmail.com>
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

Fixes: 2012c867c800 ("bpf: verifier: Accept dynptr mem as mem in helpers")
Signed-off-by: Ayushman Rout <ayushmanrout27@gmail.com>
Assisted-by: LLM
---
 net/core/filter.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index b7ac145b68b1..35d38e02fc1e 100644
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

