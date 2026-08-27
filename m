Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 730923921F0
	for <netdev@vger.kernel.org>; Thu, 27 Aug 2026 23:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787874644; cv=none; b=Yw6p+5eSvJB2Fthsp01wJYCu/12Lx+6d/Gih9xMGzFj4lH6UjSEsjpluMiU+V+0b/QCyiu/QnRj1v6JrWiimQdkJwva5wbIEzuo9uWximtBTondr2SinPassZyCN5xDLdphWpGl8h8sq/b0y+V+9Rur5ztledKG8N8Z1HXfreq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787874644; c=relaxed/simple;
	bh=I0w28eDwn55wNUcSFkFqUL0WZNi+JsnEzbOiyxoDOZA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T1SC4LLYvfbaV/XqcHsHmZCy6BOW7DZOR9sTX23t3AhXb92agkxP8cTODcWlXiZJ68fcPlDtkp03xXVmkQL+siVZxkumx37UL1iwxlbRdm8cMprDWpLy4378Yd1dkFs9EjMjEAdphGsr0Fe2/Bd2rYTSFMJ7K4CcqknyUA1RPLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i2m3tXfu; arc=none smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i2m3tXfu"
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-66d146f04cfso937924d50.0
        for <netdev@vger.kernel.org>; Thu, 27 Aug 2026 16:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787874642; x=1788479442; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oDf2cFz2MJ91PpGfYzlKTBbzHYxayWBZgz3Ltr8pzsg=;
        b=i2m3tXfuxbRtRkKd+HwICRWj6nH3W+zCDHcVezGriGsdAlrvO1A1fJ6YTqI1o2yxrM
         C16GJDvzrUcQMaZlGLLnIZfnSYibk/aH8hgXPLe9BlozfkuXFEMqwdt08THg5fJEtHbL
         hNlULDQ+pMNzCzO/jiJEHASN5qQu5oRA+BnooZTrRwSenGFbxV/Vs1mKuWEcxXYnKUw9
         TFhKJCIkdTD6IOn6MD92GvwehV9sioXVgOO4NFXq5/Ef3pNStymKNwx8zvb2qteAzD4z
         z5R0snxAVUeRzJaRJs8JRw9ko5HvkjTO3sVovTOhbj7FD7ogq+Bodnsouh2deSv39PmZ
         0ZFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787874642; x=1788479442;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=oDf2cFz2MJ91PpGfYzlKTBbzHYxayWBZgz3Ltr8pzsg=;
        b=aPjTYlT7s/rWBxIdZ4bzr9KOHQ00VMZecW/oyVZenlarCeuW8TyHCuYOZtawbI+xnr
         o2VKsPJKT5fBe3Czhf2MlLfaqn0D60uvi5laqF5aRYhnyoya311+UrGleqnm2boPQda5
         iczrYwtJMj47Ko8LSkfvIC7Y30sPd3Y9ZGUgqo25u5jwMK+/+1XtTmPrfxKGwh16CVLZ
         XyJfqPOu/att2DEN4Yi4JObrteXV/9b1b9Ci1kfRLBOvnuKraCTZP3/kWbPKUFU9Rl4m
         PsCuEsHy+IToZRksvEGUO4Z7SQxZOLuOHEZ9Pu/MhntkYKLWbUDt1eX0JYIWp659ufJr
         xCuQ==
X-Forwarded-Encrypted: i=1; AHgh+RpHU2QtD3bhQpnFFrV63D27l2mfbJmtwotePfb0FsNpUslGknDjCOXgMJM459xZX/vTWszV5tY=@vger.kernel.org
X-Gm-Message-State: AFuF++mwV3GouvBYxxqVTpvkDYXzE0Pq7U51w/HRh2BKXYhrH/cfRUpS
	Fih4/0gFThNAMQT4O4BLPL0bXs/+LGiYuVoXKmVXQDdw96Sja3D4jEnR
X-Gm-Gg: AR+sD11UkOw9/0ZVjB5CmdjoqPkrnKaFM2p8hPV3mY8PQNY+KFUifgp9cKJtsRT+hAO
	YkYb4/TwRdSLg3xtYuKMOrm42q0wjuUJHXdpA/fIVqQFfvlHCecP1fcR+UaMXWOqw7XBx0RcTaL
	mxvplZSEtzUP1jNsJFCgjHVwOe27pXYqUFGw48c5jKALFBmpN6BgBlFexSCM3M0jc8glLZo4BVv
	nn43w+CkmOh1lyggTxrCcoowqPyIvSpPLLdqu6C2Yv3UaQRNm2FUnJkBqdBBCYrgoUxt8rXXfpj
	r44XgHpUs3zEr6G8iz/4u54sAwfmm6PUPcXvU8sKwxHDS2YNKxV5TZqRoM2qZPvww+m10uj8Pzs
	q4lL0572dgS5jQjPg5FHiFD+TLXNv7/KPWht3KW7PxKE1gB95YRDWTbMu2g3kn1VQYSPc9a2lNh
	aIl8eK2+0fGAG1Kw5A+RAqIOIGpvr5kVhZZ7jnb3QyMnnC/Ri7/z8o+SQSVUyCWxuf/ATQip8uO
	bXsVw==
X-Received: by 2002:a53:bb4f:0:b0:668:43a3:9db2 with SMTP id 956f58d0204a3-66e4c522f11mr741772d50.32.1787874642003;
        Thu, 27 Aug 2026 16:50:42 -0700 (PDT)
Received: from mac.lan ([136.55.173.105])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66e4eb3de54sm51533d50.1.2026.08.27.16.50.41
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 27 Aug 2026 16:50:41 -0700 (PDT)
From: "Cen Zhang (Microsoft)" <blbllhy@gmail.com>
To: matttbe@kernel.org
Cc: AutonomousCodeSecurity@microsoft.com,
	andriin@fb.com,
	ast@kernel.org,
	blbllhy@gmail.com,
	bpf@vger.kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	geliang@kernel.org,
	horms@kernel.org,
	kafai@fb.com,
	kuba@kernel.org,
	kuniyu@google.com,
	kys@microsoft.com,
	linux-kernel@vger.kernel.org,
	martineau@kernel.org,
	mptcp@lists.linux.dev,
	ncardwell@google.com,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	stable@vger.kernel.org,
	tgopinath@linux.microsoft.com,
	xmei5@asu.edu,
	yhs@fb.com
Subject: Re: [PATCH net v2 1/2] tcp: fix use-after-free in do_tcp_getsockopt(TCP_CONGESTION)
Date: Thu, 27 Aug 2026 19:50:39 -0400
Message-ID: <20260827235039.82217-1-blbllhy@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <1db6cf46-c3cf-49e2-ad97-752afdd78c00@kernel.org>
References: <1db6cf46-c3cf-49e2-ad97-752afdd78c00@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, Aug 27, 2026 at 12:38:36PM +0200, Matthieu Baerts wrote:
> It looks like you (or your assistant) forgot to declare ca_ops:
>
>   const struct tcp_congestion_ops *ca_ops;
>
> Also, I *guess* a 'rcu_read_lock' is needed in mptcp_ca_reset() from
> net/mptcp/protocol.c, above the modification you did, to get the name, no?

Thanks for catching this. I messed up the local version and missed the
undeclared ca_ops. I will fix it in v3.

I also checked mptcp_ca_reset(). It is only called before the socket is
published (mptcp_init_sock) or with the socket lock held
(mptcp_disconnect). The ca_ops->name copy sits between
tcp_assign_congestion_control() and tcp_cleanup_congestion_control(), so
the ops object stays referenced and that read is already safe. The v2
WRITE_ONCE() on the subsequent NULL store is on the MPTCP meta socket,
not the TCP sockets these two UAFs race with, so I will drop it in v3.

Thanks,
Cen
