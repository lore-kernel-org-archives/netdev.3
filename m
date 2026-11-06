Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793942397;
	b=HvXM+trLY2ai4Sx9XBu6dYhJZ0BFafnPs9UeoEUhscwPcGDwluB4wjXlYsx2O9NQQMtY
	 W8vGqN0maa8ULBrB3FSu5zQiMHFc8fUVF8qlpin+PJFAdrqPa30LCs3+rCa4Qmged0VtF
	 zZOTzfkQyJOXbVXh3q24v40cpFES+4JDnCdQplLzKzj4Vf/ch1akaHF7USRay5MDRjQ4Y
	 rmVWFgaA4CPVjIIqOJ9cW/mYQBJcKrSHW1dCYnLmOSFrndq+wdYIVn48hXXUv0faQVnkK
	 fBAKLMAWReu+n1W4xzj2T0Fhb4Xfz//aHfYKJ2bJH/VxHlw7T+09+mLrWBk4oF0lEOw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793942397;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=thIA+a4MIDQnMOr6nTyDyHd3MBhrUbqPQ16GG235Ges=;
	b=5tRMZq1NnUkt+UXjwgikc3BPl2D1zaffsghI8LzWRYj5zrAX0kg+57OfPC0OFIr6entc
	 osJOhTOJA18Hbi885grpj/1PYuEBiGMk0nksi38KraSd3PaHt0NXAtv/OtZ9NkrxMaXXq
	 LGLwgo1qHhZqGyVU4SqjS3nasvthNRnDRJH+3JFI8gQaP0cDy9aWcIBG7riZbzLJHMsVZ
	 mMRU5AI1eU1Pf90znvyy/AqxTWen0OEI+VTwiAO/L4Q22RiVbEEJGhDx7comRmXyfph9U
	 cRSbzxSEYvB4OgPsOH0KJviNEnyTtbshBsLiWUEw966NKG5PSv6MdF/7nwynBKqhL2w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eqZz6nYC;
	arc=none smtp.remote-ip=209.85.216.48
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9061D606A328
	for <netdev@vger.kernel.org>; Fri,  6 Nov 2026 05:19:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9061D606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eqZz6nYC
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3ae7626d14aso129119a91.2
        for <netdev@vger.kernel.org>; Thu, 05 Nov 2026 21:19:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793942396; x=1794547196; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=thIA+a4MIDQnMOr6nTyDyHd3MBhrUbqPQ16GG235Ges=;
        b=eqZz6nYCn9PVjvW6yBFagMYl08LpllPL0trgOTQ3WHfIsNe+Y3/2+c9C6h18C0RNgg
         jcERXhHYR2j4PoKgvkM1grKc5o+2PbWgwtCSHMNJwQzb4XvUs1QLlkxMNVJsq/GWuFUT
         s9h1cmrFSKEV7dPPJif7k8Q29+sSOxXEHiCW/1HNAcVB4xEWcERlp9ysXpPpYfQcSXMT
         yIa1DJOyKWCMCntBQS0TL3w+NtUTOJa3FmLKQJE1fsONpnQ7ap6O8tThBDnZ1j8EppoJ
         sv0gJ5YPX0wJBbWlpMAqrJ/HtJVjkCSrhJ/YrnFRT8frMY3n7cMxI0P6o4n+ujJVHd5o
         r5Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793942396; x=1794547196;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=thIA+a4MIDQnMOr6nTyDyHd3MBhrUbqPQ16GG235Ges=;
        b=QeyWOZmfRX6AvNvDI3dvEX/GkwV24g4i0bmVUX2naTw/W7iDWSL2xM8HOgsCfAJ8AW
         VNHoY1ExQKBiOQr9O0sayH9vwbxD3ZFeGzhdK7akwf94lqqutT4+FRB7y2S93gfh28dQ
         mPj6bz8oRxqgWL6NR9uiPVMi2C3KSJBVmsWnH98xvdHkhwdlJhOzWfjT5I2sAcSlgnZM
         7/gONyB5WrysDR2tP533+a3lLYcReI6KptU+ZY6GVSaZns5KQvq3Ow+k02J+AylUeWZ+
         5Kr5OgL4+HiLY8ZR8+53d/Pnx6Usl6vnlS8NQwQ3EDEFCot/hjPmW1NIIytO9AYH8X/B
         nYXQ==
X-Forwarded-Encrypted: i=1; AL+hErGTDA5quVJmB+Pkq/KLr1FRJqKeuy3loJuuVFMSkJ4iXRmzzPYscVO7WuNuLN/xwG1Uxr6Vfcc=@vger.kernel.org
X-Gm-Message-State: APuU4Z+OH+pS4Gh8fdmTG3VdHnyKT+42naO2ovc4Z5mznLZ9sqcEeNea
	XtdjBzoVL9qRIYnIUphBRiGY++5D63Y9Za2pw1EsJ3D+99maItKcaK4e
X-Gm-Gg: AYBFou3wSJsmhDIS/C+iv7kt5l3XSGeO9V3YaJlNj647zRG6jcYm3+b4+mGvSZlJRWY
	e+lbOikHQtR9lIclg5+ZaiZEfp+OqaEKUtPJYcDYnZs0QuXx7nxQIG/KWQ2DLpIpaE5LYPUEHv/
	Z0npxDwFs4GIW5NaO7IFDqJQ7TX8Eh87adwI6DZJxb9BGZzQbH/hSzLIQnj5puTz4EXXOgXi42x
	0Tl7XJRZn4x69ck+s1DDrq3AYmVjVC3YPQ2yheq46t6wysqVaikTOMtaVZZQ3fuLOjWB5a7VbDZ
	q27Hdwfb/SJJUFWP+n95T2iTnjpjFPnrpgL+F6T6vvsIJLXNFXq8Y4dkWrSVNiTJFRHSyluvneZ
	1lIdR70UfTX0xo5yL9vqaw0qGpsmLCzOUO12VT0WKSQeZvgih1bxIPLbxsEZGApA2Kbh8Ps/k+K
	45u3/F+j5SST7VVGEoIgvwFC4FBXX2qPH1TgaIXHS8Gjo3odyDid77sRcfqdv7nU0eU3nVTBr9F
	e9DEG38fVulFKd15W+K4TxCM1eDnGkEq+rWiSGviW623qnJpw44CzH8IM1UEtxgioi0AI3CcFHq
	+7u1Xyvqn2gU4ghvWwcOQ24TxX+QX3KS2uQ3NwVWStrWR6AYMVqgQS61svgKfqgKXTblmdL92da
	EBv4SBVNJj8vRlTzM/3hBsvkjnjMaBj7PiFlaoiTQgUaYiHV19JynXOt4Y+H2exYJgRQtUfnRdj
	YGDmJto99vUUK47B16pUqItBQJVp+1rCV0S3qSxr37
X-Received: by 2002:a17:90b:554d:b0:3ac:af8d:c839 with SMTP id 98e67ed59e1d1-3b0db6f7f23mr1414744a91.35.1793942395880;
        Thu, 05 Nov 2026 21:19:55 -0800 (PST)
Received: from sid-dev-env.cgrhrlrrq2nuffriizdlnb1x4b.xx.internal.cloudapp.net ([4.155.54.158])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ed47d7bd2esm1594465ad.56.2026.11.05.21.19.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 21:19:55 -0800 (PST)
From: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
To: Kuniyuki Iwashima <kuniyu@google.com>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Willem de Bruijn <willemb@google.com>,
	Jann Horn <jannh@google.com>,
	Kirill Tkhai <tkhai@ya.ru>,
	apais@microsoft.com,
	rlmenge@gmail.com,
	hargar@linux.microsoft.com,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Siddharth Chintamaneni <sidchintamaneni@gmail.com>
Subject: [PATCH net 0/4] af_unix: Fix inq_len and scm_stat.nr_fds accounting leaks
Date: Fri,  6 Nov 2026 05:19:01 +0000
Message-ID: <20261106051905.218638-1-sidchintamaneni@gmail.com>
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

This series fixes receive-queue accounting leaks of u->inq_len and
u->scm_stat.nr_fds in AF_UNIX sockets, along with selftests:

- Patch 1 fixes a u->inq_len leak in manage_oob() when an unconsumed
  out-of-band (MSG_OOB) skb is skipped and dropped during a normal read.
- Patch 2 fixes u->scm_stat.nr_fds leaks when an OOB skb is skipped or
  freed in manage_oob(), unix_stream_recv_urg(), and
  unix_stream_read_skb().
- Patch 3 fixes a u->scm_stat.nr_fds leak in unix_dgram_disconnected()
  when purging queued skbs from sk->sk_receive_queue on disconnect.
- Patch 4 adds SIOCINQ and scm_fds (/proc/self/fdinfo/<fd>) checks to
  the msg_oob and scm_rights selftests.

Siddharth Chintamaneni (4):
  af_unix: Fix inq_len leak when skipping unread OOB skb.
  af_unix: Fix scm_stat.nr_fds leaks for OOB skb.
  af_unix: Fix scm_stat.nr_fds leak in unix_dgram_disconnected().
  selftest: af_unix: Test SIOCINQ and scm_fds with OOB and dgram
    disconnect.

 net/unix/af_unix.c                            |  69 ++++++-----
 tools/testing/selftests/net/af_unix/msg_oob.c |  12 +-
 .../selftests/net/af_unix/scm_rights.c        | 108 ++++++++++++++++++
 3 files changed, 161 insertions(+), 28 deletions(-)

-- 
2.43.0

