Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.133
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793646882;
	b=BQN5DY2ianSdCbUgpztGU+8n5Akvm94PbrPEc4EHfJrmHeBzEnNBZZVaEeP6esLJ6AJK
	 SSkrY4W4oP4JvxFYms4RnIZV6KUMyip6mu4mktQme9x72BFlwiwYYN9cbdE0DOBLAiUQH
	 7CDHjsvl5dFL+g/4zITl4paqzs6I5gISIhDba4kn5GwjrlcCrJFvXuAY/YAwJTfnUFQov
	 h5IjfUILqVuC4TVG+/hG5d3BiomB22zF3llKbyxrXYB0xiIzWwmknJ44f6LOd7SmuIHch
	 YP/CtRNgB7hTs7yYg0ouoFyhZmFt0reDwRVqYImjzbnGuPTCCMoMoST4ajqLKIvBWFA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793646882;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:
	 X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=8mRY0dC3iNi2EAcGRxVrgoSrZHfhv1W7z/F4/S56g4Q=;
	b=qbOlCYlFXAaj2+CAg1jRTms3QBXHV7+FExssREFl5au2Ibnky11UbChzRsMIPdvz04z3
	 zXXohyYzIWBz2smJMLJFvjpyM+YMWw5ihh4QS2DOcDfGan4A1wCnlri3ypyxW+Ctj3vUu
	 Yti7Qm16RrQZqhHzNBkHzNHRtryMFoW6Jk+L0FJohfseguUpqj3FuRemQx4l+Csl80Ab9
	 6UAZNRP7QulvxBU/PjD3+pilXmnUDtiUt8bkwAHzzG+a4u43V0d6B4dTbtcYKqjKk7c3H
	 P2QV3PhxbG6+e3LqNSu/g6iBB6m1vlRKGORpvMCr3JYe6H179OAFDXQFKkmUWZGahmA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SDDON54F;
	arc=none smtp.remote-ip=74.125.229.133
Received: from mail-dl2-f5.google.com (mail-dl2-f5.google.com [74.125.229.133])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CC51606D80D
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 19:14:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6CC51606D80D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SDDON54F
Received: by mail-dl2-f5.google.com with SMTP id a92af1059eb24-1ac216daf7dso1360832c88.1
        for <netdev@vger.kernel.org>; Mon, 02 Nov 2026 11:14:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793646882; x=1794251682; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8mRY0dC3iNi2EAcGRxVrgoSrZHfhv1W7z/F4/S56g4Q=;
        b=SDDON54Fyhv73iNsVlFcX6vkzj1Rcqv82e8IHNU2a9H2pE7/NUK+8QmuBhS/KW9bia
         Zj+q5+Bg2h+pm91gZhtPSRaKl9cb5II1TdTvAZVuFY3LNv8pk/I+TblRU/ufynzkWtk5
         VVv1ZM6i5z3mHDgCxVk9BfgaG5WEEDx/rABAA3+Dl0OMmJNNeUN8Hw4GGw8pdaC6fsWK
         GlkTIuLe0Ax9uMdRZhd6RT9tFbdU/pZdXv8HigKnphgjNsJA1+TNO7F/yfw43naSeJIz
         4idQqPyETGY+ma9czrAsaGDP9RZs2ND6WUFkk3vmHYhiOPWz3GkuVqIeOI9uA37DYnTy
         whaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793646882; x=1794251682;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8mRY0dC3iNi2EAcGRxVrgoSrZHfhv1W7z/F4/S56g4Q=;
        b=AEMQmCAMQjFbBm6SYroAi7n21H/d/sci5Wsx51BY5bf0B9jyeCyaBx9BMzXDVKn199
         YyZW1BKcgFUFqC4wUllaQutn8Jy/QsJEkDIwoJ7s/2pdzV7Rld3VrAvsDWBZPa9W2UaA
         0lWk1lnWGo7FQpkkc5o5arAG+YdMzBo4KthwyqGGI6cYrG9FkBIN7BcsW32GHm6cLofY
         2GlcY8IC+o5Nz2XN1HqxDIx0XL0hf73Bh19oiQLrr7s6LjsLL4eIrDpifpnVHBaac82J
         P8l/AzIjcVRx2BO6IWmo69es34hAzmjruVhg5uMSFk7ZNX73wVTaZuNPqIT5aOyVImTp
         XDcg==
X-Gm-Message-State: AFq9FYKmb69rciqPhqMWSKFxU3QBxojrXwY4FW6rC4dRcFRy/aUbIMQU
	vbt+p58uyGyqI8iy4EnJsZYjyeTsWL36zS/0IDuUZHZ9HiL73AY0E/X+dnzX5C4l
X-Gm-Gg: AYBFou2b/qHfWARvSe2NCFRx6M/ZS4dtKZutz4Zgg0cdIKEEkh1mR+NHP225eCiyzqz
	KKTdOUZJL7ehzOUhWTJIlRv194yKSWz4WndBbFwrdvsEa2OZDDoYZ3/q+8aUqLyAkLh7VKSwNN9
	Z0DjpyKmhay13tqZUKNU+STlEovdnDKdiD/s2mqyV8okhHKfPk253xGRHqaHRjrUs1nuPIP8R1y
	r6Rhg/KVX/NhItZzBaufCSV/ea8moMIZMfK+sK2w0/n5lDfOL54QpyGfWE8bCxPeS1cxJqdcPTf
	JS5qQVmycuFhyD/msXhV9sAWGNh8ElXlvEbT7jKzy84MMTT0FV/zTVtUfXzKKIPq0uM7dTIgc/A
	+SV+vDa/GD3Cku+9y1saskdQLNax5xHotqCwnfbSHm4aw/gKecPXS2zIIkwRuwLzHewVcgtWA6/
	zn+G78g54tGkIgrSMWugoFyHD7YYlbdx8LEU60/haDtVkMbthGK0i8EZjoHsEfpT6aJjKtdBoSW
	I+sjuXru8Ww7+FdxqfwHXT6n0GeeppwAUbGWdOyVd+GQOmlzfZ1DBRTXOc/McWHDmrc65cq3d6S
	rn2G1EEZO/vTxdehm+sXvgQ=
X-Received: by 2002:a05:7300:2442:b0:36a:2059:6c85 with SMTP id 5a478bee46e88-36a42454b4dmr18746729eec.34.1793646881637;
        Mon, 02 Nov 2026 11:14:41 -0800 (PST)
Received: from localhost ([2a03:2880:9ff:60::])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a42a504c6sm40157681eec.21.2026.11.02.11.14.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 11:14:41 -0800 (PST)
From: Stanislav Fomichev <sdf.kernel@gmail.com>
X-Google-Original-From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	edumazet@kernel.org,
	horms@kernel.org,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	rdunlap@infradead.org,
	michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	sdf@fomichev.me,
	almasrymina@google.com,
	bobbyeshleman@meta.com,
	asml.silence@gmail.com,
	daniel@iogearbox.net,
	razor@blackwall.org,
	leitao@debian.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net-next 2/7] net: devmem: charge the frag length to TX skb truesize
Date: Mon,  2 Nov 2026 11:14:33 -0800
Message-ID: <20261102191438.1059771-3-sdf@fomichev.me>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261102191438.1059771-1-sdf@fomichev.me>
References: <20261102191438.1059771-1-sdf@fomichev.me>
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

truesize isn't well defined for devmem TX frags: they point into a
dmabuf which stays mapped for the lifetime of the binding, and freeing
the skb releases no memory. The charge only feeds sk_sndbuf and TSQ,
which limit queued bytes.

Charge the frag length instead of PAGE_SIZE:
- TCP uncharges in bytes (tcp_trim_head(), tcp_fragment(),
  tso_fragment()), so the charge must not be smaller than the frag.
  PAGE_SIZE only guarantees that while net_iovs are PAGE_SIZE.
- Frags shorter than a page now count their length, not a page.

Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 net/core/datagram.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/datagram.c b/net/core/datagram.c
index ecc30a6f8302..489d92fe6dae 100644
--- a/net/core/datagram.c
+++ b/net/core/datagram.c
@@ -737,7 +737,7 @@ zerocopy_fill_skb_from_devmem(struct sk_buff *skb, struct iov_iter *from,
 
 		netmem_inc_ref(net_iov_to_netmem(niov));
 		skb_add_rx_frag_netmem(skb, i, net_iov_to_netmem(niov), off,
-				       size, PAGE_SIZE);
+				       size, size);
 		iov_iter_advance(from, size);
 		length -= size;
 		i++;
-- 
2.53.0-Meta

