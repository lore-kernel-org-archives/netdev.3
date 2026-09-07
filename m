Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A40B337B402
	for <netdev@vger.kernel.org>; Mon,  7 Sep 2026 04:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788756422; cv=none; b=lvLXxY5PJ/u2p6C4wD+v7Jv2bA70zCVUJr13luxrOhxZrbAGR2R+ipo7kn/WtxFNnKVyMMoKJfsmk//kt6omu6oAgl1G3Lh5QSia191FoNZScy2Y9ysxzNoPuuNvKtwWiDT4pJun6tJK6dGICWUBWBiGRmzc+gjcSw0bMhA9lpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788756422; c=relaxed/simple;
	bh=Z06AU703GpEoGKRxtsmSf1YbAroc9JADJQ2ixTS8Gco=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EBUyjQAvVhwlHqNGFdyr+jfiuwnbTE/oCfUpAPHihZmxHE5v7ceNV8KET7Fa2k1wx0oKaxxrrju5s3fRrmhanjYnEK1Jd/3CYciiGSD9btVko2QKXQfD0vRof99sMgjDktT2H8NBZTPlxxXOvSDOtxUgGRe5610EfiypZrGXL6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lSi/9XQ7; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lSi/9XQ7"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2db59f54ccfso2546305ad.2
        for <netdev@vger.kernel.org>; Sun, 06 Sep 2026 21:47:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788756420; x=1789361220; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CUWvG334OUn3r/8S18NDwduytcXyDvAPPHJtvp6mqTs=;
        b=lSi/9XQ7/O5MzmTuGA+rJ2d0GWoIDo8lM18q0Mt206Gjh5MPADchmN83Pn0lu908wL
         OpKe/7b3IIQT1KEpdFm0V3U8pG1GkXppYHobXSubN4mdVjkI3Mnlmzzqg8OFzHJlY6hW
         Y8nkgVLlf7wLKHnSvq5/81jIr+wZQu2Zx7aIq2VIBDxcLJe6IFUBzfn4wbHIrXuL+ZVk
         J4idI275FjA2VjqTRxaXSd2fN5GsLQQ60bmU9ZRhnEewbTs78Nzlt1+17SchaKGmWUMm
         XMGJCUAIPQLmt9Tzyqi98Nj8Og/mY06ccayNjmhNB6qsdiHswKrCLevf2kAhr35GO2e1
         yVBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788756420; x=1789361220;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=CUWvG334OUn3r/8S18NDwduytcXyDvAPPHJtvp6mqTs=;
        b=r5aNqwDeTFjO/bq8EiCgtbEtAmXYE9ANpFikJmfA5PuN9QcVC8jAFu9FBkFHL9/qj6
         8Vu9zxD9jJcxUqLDgr2U8XdNIbif9B4KDZlVYqTX6fPQtxUnftWFMU1tRgHGl/OhQFKB
         D9EzWgQiIV3Nl0U9TkdYLnp2ST7ahjWHuELcz37Qvb15/wZ3ySjJHZ+TEKwuiEQidCIU
         yCuIZtx5AIj6vsbrVj8xYVuouTTF6OTLcRx0Z3wAN8V+TjWAfUTlovP009cZ2LIHR/Ie
         XA9WT/qKCJ4bpCDPiRrt3z7ut5NgB3ofWVdtF+IrYsJmqipZHBXI6VYptchsU8nW7F3v
         j+FA==
X-Gm-Message-State: AFuF++mhhwuhbxTTuxGiYcGXQQOmARaTfzphrrqakKkGN/7KFS54HkGf
	uQCEfj/I0syboNfyDP8gWrhDWkskqNWx2t+sKA412M+d6BUCN1WjUNk4
X-Gm-Gg: AYBFou3unM0PSzH5VuJGmKSjMBSq40yCm2QDmPdSirEjKTAy8IMgXfDA+6M0PfKrGSh
	z8zP4i9pH1v01ZSiGZcw8DNXb0RZxQImeGs0fY55M2+ZqSSpcadHiwCVwWeoHlrN808tFo1Zxfo
	L2y3yTMOTESCifzQKGlGipV/TbP2S+i7XsSgs9FMCL2pFiZQ52+d9CbWoxp3lfv2ppzRPssOQEO
	P57s8VWAQ8dWSGkeUDYzM/MjnrSStFC3v/G+/KG3P7AArGx9UrD0oEtxgAbfImyPHQ5QdVr+GyK
	QVSc2Z2c+/6k2jlRJXJdpfMJx7Ft7x4jKXW3HPLbkqr7aYQ0c1MG4sOomIMXnpGV+ckjxQyUS+e
	YnFooudCMevs5Sg/Uv1mk7BxnNVpQvL4jUqw4O3NZB+Qp9weLlaJNyc2z6Fzctj2G2UMoc7APXc
	BTdbpniHJA1MUI5c7nbrvbyJMoF0tydIQgolTbCAXREVLqAAEggWPaH5MUTHhU5W7r7JXgrjo0g
	ttqOCL6BZUpPA==
X-Received: by 2002:a17:902:f546:b0:2d3:7c58:b0e1 with SMTP id d9443c01a7336-2db1212aa5bmr305439335ad.0.1788756420050;
        Sun, 06 Sep 2026 21:47:00 -0700 (PDT)
Received: from volcano9f6e-hostos.amd.com ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339af25062sm37844565eec.16.2026.09.06.21.46.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2026 21:46:59 -0700 (PDT)
From: Hemanth Selam <hemanth.selam@gmail.com>
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Sudarsana Kalluru <skalluru@marvell.com>,
	Manish Chopra <manishc@marvell.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Simon Horman <horms@kernel.org>,
	Edward Cree <ecree.xilinx@gmail.com>,
	Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-net-drivers@amd.com,
	linux-kselftest@vger.kernel.org,
	linux-usb@vger.kernel.org
Subject: [PATCH v2 3/6] net: llc: fix repeated word 'all' in comment
Date: Mon,  7 Sep 2026 10:16:32 +0530
Message-ID: <20260907044635.7141-4-hemanth.selam@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260907044635.7141-1-hemanth.selam@gmail.com>
References: <20260907044635.7141-1-hemanth.selam@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Drop the second 'all', reported by checkpatch.pl as a possible repeated
word.  Only touches a comment, no code changes.

Assisted-by: Cursor:claude-opus-5
Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>
---
 net/llc/llc_conn.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/llc/llc_conn.c b/net/llc/llc_conn.c
index 260460d50f54..4b6fe9a473cb 100644
--- a/net/llc/llc_conn.c
+++ b/net/llc/llc_conn.c
@@ -193,7 +193,7 @@ void llc_conn_rtn_pdu(struct sock *sk, struct sk_buff *skb)
 }
 
 /**
- *	llc_conn_resend_i_pdu_as_cmd - resend all all unacknowledged I PDUs
+ *	llc_conn_resend_i_pdu_as_cmd - resend all unacknowledged I PDUs
  *	@sk: active connection
  *	@nr: NR
  *	@first_p_bit: p_bit value of first pdu
