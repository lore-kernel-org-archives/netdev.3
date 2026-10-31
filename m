Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793440770;
	b=ReyaQVvcbhAl1n3fWZ2O7/WyYXRF2SOnRLbvpmNglLiTyeElTBnFpoo1uYFcjZ3ONWqJ
	 Nsv7RBDqeNJsopkhdYcsmDksNMcgGb2P5Uq/3X5Tka+a1115oYwdjnKNWT/MtASvfjoxt
	 R4o7sXjhCTQ63VN1YMRo6tiD6/jQfhWAa2UYXCORSOukHmqkgSvg+4AaERPCkEmyd30nt
	 mc4DZqBZDyIVtS4C1LY+fiMb7A0XYFx3EzvAL6qt/p+skd++3rx8NyuEjRQ82iDGsSXlW
	 tlhmcGZfKPFi2X5HH0oUU7VHphX+IljatfrJCPFxuCA2szqRawOUyiF2sw8l/Uao6SA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793440770;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=lrg91VXppCw++dPJi09YCHr1ozvZZtqaDezxwuYyj1c=;
	b=qOy79Sjvcxkgvkf3UB4OqIs0aGcEDNXt4JLF0X0vOXA9UzgIqx5PwoeoT0gp1bk/xa0e
	 yKdxsLe77XkcW8UOKRA2j4Z3X4jOCwGxfiUK/WwBzkjxo0nljjlE34kAL8SXO16COrGtM
	 AqNy0bx47ZJOXtplA+i+IOfBfsVn8OmrF736S9VMiLPb10T5ZSLz2PH/2vQkoKn96LOoc
	 p/f2m2AyHYxVgcJP5ivmAS1APpoKKJ+AO67mx9RkQfBawrnS3BRDvVUNzZoC+rlDSv3m9
	 JdqWjyZx4LyjzHrpul8GeIYLOPxlZT14bJv39Kxk8rgsJ/Pg1vTyqOD223jwwfgBvsw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VJCloE6b;
	arc=none smtp.remote-ip=209.85.128.47
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07727606A31D
	for <netdev@vger.kernel.org>; Sat, 31 Oct 2026 09:59:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 07727606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VJCloE6b
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4a2153c8525so9456155e9.3
        for <netdev@vger.kernel.org>; Sat, 31 Oct 2026 02:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793440768; x=1794045568; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=lrg91VXppCw++dPJi09YCHr1ozvZZtqaDezxwuYyj1c=;
        b=VJCloE6b86yvWABy075rF+peJ+s9iHi9Oj8A8xN3AKg90+d9lov+D2SVeH1MIqS5U1
         fZMPNtsj1CDhKMGFKUhX/Y7SioiFJHDFZxK1BxSniSDdO6XkDzaNITmT2/EfHCNE/VCu
         EEp1yBILY8uUu/44qbbq0HxUgf1g8gKaFstU+2foeow9x0g5wfA98wGXpn83HWo/jveg
         kibon7+vRr0Od96+ZX/Uzr5kKCEc3JBcwuMkag/EL2OvqxbAlZU9AdfjPuK2nNyWgA9H
         33vDNRwhXbsSV/htjoVhUdVWpO/imuheL2Z2PUKcle3/hLWR08BQO1L5n0lsoWKiy37T
         nb+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793440768; x=1794045568;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lrg91VXppCw++dPJi09YCHr1ozvZZtqaDezxwuYyj1c=;
        b=pVQOZ0ilAHCQDPrpRCc9cwoYNkCH6qxSwJYNFRlU7wS46Af/WfeSglN8ugY8ZtqjVH
         2VqrovgAcASstV3vAuucH9GnUIrhPEXEbAZ9nbak6sOFsU1tUFUBEmzebLJIEH/HuQxW
         CaMmFBgSuR3YxGDElllln8IsrzWZ5LQOUTdPvj+jdRF3YaC2uvQCHZxJygugnrWL9rMK
         vyrq/ayIekaLaA2D9Cj13QI+7X0qnxkTq+/Khs/XBMh9OMzIRWvBYnUVECiMV8O5HiON
         /HbDOV67fs2HWzYAZxcVhY7kN8MIaMbSoZsoLMuQpjhp1x/hiTeOuvR/0BuwVBahaf9Y
         IYkA==
X-Forwarded-Encrypted: i=1; AKwUvBzPgjmAaMjusFch3RzvMn/PHK65nFAV9CSSvVe7p6czRdh/tlJaVKEI608REIrCfANvDGJNvyI=@vger.kernel.org
X-Gm-Message-State: AFq9FYJjlpMx+pdyywwZGlF8thtmLvX/2F9nEnGrt552Iu5M8dC5W7Xu
	6uPVqo2lMD23OauUUOGbhhCZrY0G4A/WvqrW68WxMCs7p80pQXTEgkcp
X-Gm-Gg: AYBFou3yvRyxg6iPJCFBcPg1d5dui37aY9UcdbagUb2lgLkaz7xPxAA37pdLz0921ym
	E/JI0iO5oocD9eg+Wr+Ex75/r6AElLd38EBzpAz75XrVe9wDqzo7x8oxR04kFvVnUvfP9suo71r
	yxUG09qMKL77V0mWNtdBbLHCe6kiKtc4fKi6cGyisy9oE1HJGe1rwAMu2AAcZuEjWWoSlni457X
	BGzCdK9o1IQ/aAL4eVcfmyVcOV5W7TMRpE91W5TO7T/9Q9sLlf8dcnE5kaTOaAEXRb0/msumFrZ
	mnYMXwqcsKvbArKvT3oyda+Rx7EckYhuClv7WEpazpHEblF/yQYIAPoBWAFiWAb/pawBbAcRGPm
	DmFsvdqdO0xF/zxR76Ax4l54yuJzksTANk1kbaJ2wBxeHfmcBWAPDRjQt5rsBIkygDhAGOxsvzP
	bkGyKkHpKyRnl/AmlHnDIR8u6D2NPNUIf8Y9wzrKrMLKbwJtXoK6iTspTOS3xA+i1+cawoai+et
	NtvhHdnNe7N1ybyn4sxMxRGmHph93F9+1g/dXwAElXErM+DpVKxE5w7jIKTBvlR4/uQrtnJaYWV
	CZvoMb2HSqElKTJ4oqK8sC18lQCz/jfqraME7FacW/rE
X-Received: by 2002:a05:600c:8b4c:b0:4a5:1cf1:b7b8 with SMTP id 5b1f17b1804b1-4ac17b2cf8amr106495125e9.28.1793440768232;
        Sat, 31 Oct 2026 02:59:28 -0700 (PDT)
Received: from localhost.localdomain ([2a06:c701:4773:6f00:c8d4:ec29:293e:f39])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4abe77053fesm55354435e9.0.2026.10.31.02.59.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 02:59:27 -0700 (PDT)
From: Avi Weiss <thnkslprpt@gmail.com>
To: brauner@kernel.org,
	viro@zeniv.linux.org.uk
Cc: jack@suse.cz,
	linux-fsdevel@vger.kernel.org,
	dhowells@redhat.com,
	kuba@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Avi Weiss <thnkslprpt@gmail.com>
Subject: [PATCH] splice, net: avoid MSG_MORE when the bvec array fills
Date: Sat, 31 Oct 2026 11:59:23 +0200
Message-ID: <20261031095922.3577591-2-thnkslprpt@gmail.com>
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

splice_to_socket() leaves tail at the last included pipe buffer when
its 16-entry bvec array fills. If the requested length exceeds the
available pipe data, pipe_occupancy() counts that buffer again and sets
MSG_MORE even though the pipe is empty. Small TCP transfers can then be
delayed until the cork timeout expires.

Advance tail before checking the array limit so the occupancy test
counts only pipe buffers that have not been included in the send.

Fixes: ca2d49f77ce4 ("splice, net: Fix splice_to_socket() to handle pipe bufs larger than a page")
Signed-off-by: Avi Weiss <thnkslprpt@gmail.com>
---
 fs/splice.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/splice.c b/fs/splice.c
index bc243ab8dc43..7c67e0375ae2 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -863,9 +863,9 @@ ssize_t splice_to_socket(struct pipe_inode_info *pipe, struct file *out,
 
 			bvec_set_page(&bvec[bc++], buf->page, seg, buf->offset);
 			remain -= seg;
+			tail++;
 			if (remain == 0 || bc >= ARRAY_SIZE(bvec))
 				break;
-			tail++;
 		}
 
 		if (!bc)
-- 
2.43.0

