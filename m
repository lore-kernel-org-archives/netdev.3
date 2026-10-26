Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793032166;
	b=XjR9fgjwCwvHjQ/iSaQBzcGn4tZwCN9Wo54iUP/Gx5zGnISkzA7K9XnxB5gmNT9AjaX/
	 jtoaA9Vl/WQGsReGAAwdCMHqRyNXbteU0IOIA+ivI1T1JxhBdNtDw3wkuFQaMNATllQMc
	 8VDRFubVYC35tfWz9uYJB3yrhSE6gX0Cpzx0Vl8BftvDSZifG7mIld4VcfNUEIq2my1Dr
	 TLpmV71QQhUy94bCvQkJPJUL5TU0LlLxh9J+bb97uR2b0OBPS+YcYY8Lci+fvMiatyZG8
	 s1gVjLaqNbJTuWkoKN2Fw6fsM6iZ3cHKve8ycCpThBJRaJS6nWQVe4uFineaGkyDvtw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793032166;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=GdsDtNMuAKchgTKFVPQmSqRchOy9Cu80YvZfOAk+T+4=;
	b=SsY+gWW79GBwuFda+5M1VKKT8qsVVGYvY8+CLhk/FZsv/7eMtbuD0PLGNd8oV8KxfysO
	 q1sgOKFWZgvycUJ5Q+PGHGlM9YprVGO/0qOftHz08nqywM51qfzWFkhEM1aO5ElsbMuJN
	 a9Ju+DICjfYs+yWS5URv+H33K64DxsmX7Nf8O2iQczJwPJYccp0fFj0/wxcy3VW0SNW4S
	 bU/xILBktpJnOZZjBHnHHUSG5xdfA/xGbGRNBSnIeHz8vtMEli3Ku8ZCjIu9XSUWx1CK5
	 knX1KJaxKPz6lmlA4jQzdYAa+6EDt7tSEPfoDV6u4iOfC1iIwqnFOeqVlAQUO56/xaw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=s88r1f7r;
	arc=none smtp.remote-ip=74.125.82.181
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39D8E606A31F
	for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 16:29:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 39D8E606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=s88r1f7r
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-33fb4680717so5803358eec.1
        for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 09:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793032165; x=1793636965; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=GdsDtNMuAKchgTKFVPQmSqRchOy9Cu80YvZfOAk+T+4=;
        b=s88r1f7rBacXuje4OuI2O9BejlXwi39wsHSRSfqEXG6vDmeOBrNik+u18CpdbNpIjp
         LZeu8HDwQYSWjebKxy9MC1XVK5Jm0Dpp+Zz4ba8as7S66CyLnNAirt0ZAebK0YcT3jmQ
         4t7fgSo2uA4CIhF71ZiK3rp8v9iOuKlxG8a2Pqlxjk2J4/UEy0lOzrKbw1nWGNlrSNR8
         aY99L5mt8Tp+Sfeju/KLz4VU7TnYlGm6CXSWNCFLfgp4H97m9LF45zdwGDmdrZHGECEg
         xoAdGYqCRltg+i9cSz/xZ3G/daPGBryUPdhot2tMxAbTsVihBr1suYom5FXE6IYBvtT+
         n5PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793032165; x=1793636965;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GdsDtNMuAKchgTKFVPQmSqRchOy9Cu80YvZfOAk+T+4=;
        b=r5/ldk/xp8pdgCBp/dKhZZqqhxa/cfdTUX8RuAu+Q1Nj1TLXtIRozHkyCmd3pBS9L+
         +e/BW84iRQ0X7t3nw5CCAxR62pCYb95ulvfRGra5FM+4UqnVz+5D9x91GAcGKnQzuYGY
         dv0RnMMTMHCJ8Fy2FytHabsHEsR0f76rt72uXIf2qv7CILTZmgUbZZuPHy4VQkxccPh+
         3/yx8PBTsVDxa7KhAHcnKYKX8+s8cr7zBU0uf+oHVs4UN6Bfzq9+pFAZX4ngTNYEyeI/
         ZNx5t14f5GefiDwk/yFcIykCfI72vFLeugP+wQ/4xqDzim49wNAs1OxLllj8mK6w5EUg
         pGqA==
X-Forwarded-Encrypted: i=1; AKwUvBwhwBVhTTRaOPURA6XAmeHYmVTCW92QTJdiZgEs/PjPjE4qnqVFEI5/TYaMPGLgo3FJvn2jcHI=@vger.kernel.org
X-Gm-Message-State: AFq9FYKBuGaBdDV37YYL4+mEFMCdxf2fXC93A645cVPzO+1zekp3+KV7
	kaJ9Ekz9IseiAik9cjCcH7O3v5s2c20uLJ0YJW+9DEzKhE3/tc4FxzFy
X-Gm-Gg: AYBFou3qs7O2Gsm6Vd9UjYJaNGXpW6dIj+cg7QxoHT03QuW6FtV/y8XNE34Nc8SYyt7
	Njma1pPydULgsex1kgf4A3IOQaRdviWph29PyJSvyK666YNcggxzkwA4NOiU0dnUXymO24TDN/u
	x5DT+03QOPJy9xR79lh1X3N0uWSzr+uOQNAy79YY+NqDgfV5O4fey6nP9FSP5/YhHLqziI35d4W
	fMdghHhn7bXcs4C2B+fu6PhjTDx1FnQIHLRYPENHfnR17pkxkyNSnBES2Cki4fRXMoLzKPFBBMy
	Pvp7B0UfNgdl8jHx1MuUdtZE/ksuOFMYQtRdP754g7R0pNNks1WxDXmdPDnIZC/4EEHUXKismW2
	Ovv/rdeRl8MfvAWFmxaEnyGpz0nAgdGxdLtBxqr/Jeehil6C+tP5PKl/EVIH44UqRVX3SzzY0Wp
	Ys53z4JxCYMYweTsHcM4ntXNhCsRShkUT+Kl74CbcCxnqdHtAFjgdfv2BrtmtPyUUNu7cXo0UsZ
	f0F68/kjoWYcsTaES0GHswmVW1xwSHqmLPB4C05s78c+Ns1prwvmOYT+xRZnJbQaqkNiMuIYcjl
	8fZ6HUs35hu9evNzsKuIVYal7VrmCGluGEtAZPATkIX8rmS84SWlZ4EId6IjNFZh4prQCp8AudE
	=
X-Received: by 2002:a05:7300:8817:b0:369:9062:c392 with SMTP id 5a478bee46e88-369e8622976mr11796578eec.37.1793032164938;
        Mon, 26 Oct 2026 09:29:24 -0700 (PDT)
Received: from nixos ([2405:201:c40d:9039:f859:3f74:c064:3281])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-369e8db7b23sm36119014eec.19.2026.10.26.09.29.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 09:29:24 -0700 (PDT)
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
Subject: [PATCH bpf v2 0/2] bpf: Fix overlapping copies in bpf_dynptr_copy()
Date: Mon, 26 Oct 2026 21:58:07 +0530
Message-ID: <20261026162810.12862-1-ayushmanrout27@gmail.com>
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

bpf_dynptr_copy() can corrupt data when both ranges are in the same xdp
packet and overlap: a slice of one range is used as the buffer for
__bpf_dynptr_read() or __bpf_dynptr_write(), and the chunk loop always
copies forward.

Patch 1 does not use a slice as the buffer for a copy within one packet
and copies from the end when the destination is above the source.
Patch 2 adds selftests. They pass with the fix.

Changes in v2:
- Dropped the bpf_xdp_copy_buf() change and fixed everything in
  bpf_dynptr_copy(), as suggested by Alexei
- Reworked the tests into bpf_dynptr_copy() tests where only one of the
  ranges crosses into frag0

v1: https://lore.kernel.org/bpf/20261024092659.76422-1-ayushmanrout27@gmail.com/

Ayushman Rout (2):
  bpf: Fix bpf_dynptr_copy() for overlapping ranges in one packet
  selftests/bpf: Test overlapping dynptr copies on xdp frags

 kernel/bpf/helpers.c                          | 16 +++-
 .../testing/selftests/bpf/prog_tests/dynptr.c |  3 +
 .../selftests/bpf/progs/dynptr_success.c      | 90 +++++++++++++++++++
 3 files changed, 105 insertions(+), 4 deletions(-)

-- 
2.54.0

