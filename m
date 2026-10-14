Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A741923E325
	for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 19:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792005464; cv=none; b=VZh3pbVZYQ9HHbH4GEcfNBHz419gueJr0UGtZdmNrCzYLixaxiZw6LdRd41Sgov+l/ZE8NixkqZKrVXxPnq1fyRARzBuGNfoxUIOLBvBnMp8gi50u6CwekgKHRwyRwyWlrY9B4Doqg6X2WSglqAZEjokagBGHg+60ShvWrMDefw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792005464; c=relaxed/simple;
	bh=Dry7BOloPec2zHiaJVfGwIFIpZZUOGvDPbabm8O3efk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cdR8TQ+PHhv08tdt+JRenGvTpa5+s/7xXb9dbYRMYh2+cyYYUcsO8RmCjTyeELQ6fGOFgjCkQLJZjiCaHwHhxK7IiLtw6CH78s+08iwjjRGZE6idWmka40c16wRYzVDX0Df7q/Z5wBPkZel7Q5g3ErKxPYRpZzYeTQsuGzwghJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=Antj8T69; arc=none smtp.client-ip=74.125.82.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b="Antj8T69"
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-141395927feso8686594c88.0
        for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 12:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1792005463; x=1792610263; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Dry7BOloPec2zHiaJVfGwIFIpZZUOGvDPbabm8O3efk=;
        b=Antj8T698Uu8KnoVQxLBNxgUEgu/rx6XfUjDg1Q3Lw7ycXakzrb/b5k9kpyAkjYWrR
         bYiiTPW4q7fjAQcjnqtEq+nOFs6W4q9fv+5OdSE171nsZqfGWhCzsDkY9QmQnnVFZs0V
         aP27KKgUyaTQLt4X4VU1jzlSSHXVlXMiisOmGkjyP1tGjW1/UAvHc2hIhwhHG/x3gIya
         1IlcVhZxe2ejNGWP+J8CZkBTGEYFJrRhe/J8yBFdEuOrETbG4mBi2B3sqC4eFgW/YKIr
         AewNxP3197uNcVJFMCYLhFjUlut/wYyG0/pFnbsfi0PLFKWW8xRweMM598WpC09qMlEq
         0ZEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792005463; x=1792610263;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Dry7BOloPec2zHiaJVfGwIFIpZZUOGvDPbabm8O3efk=;
        b=Y5C6wPWQ8lbqX/THQwAxlPCfHTfp51eWGRY6YHTzdJdOB6HgvG3V9Ha0UgL8I2LQqC
         gFTxsDL3Gv4kZOmoRP+KLL9Z9EKGMx8faMIOjxU4kvGpgn2Nsy4KOC6Z+fKFOrxkmXl3
         84ZWdC9PGR82SHMH9AQ8RgzE7ZuK+Apvr6GBlWiJqbRNIeiJTSaxCjU4QpIgLidpw+eK
         CaMjNEctrhIIrl+MWik6bcabz6vZBtj8AfM94YFDers8Pu2dvZC0qNu6mOQlkv+dcrpN
         DARUpR8rZ26wL+jm1PpFq9yMnCUf5CUaQAS5a33ufHg66wq4ZFwB8FMVBV6N6Aqbdg3e
         VH6A==
X-Forwarded-Encrypted: i=1; AKwUvBy1m1JK+Hs4msZSPvbL8Jss1nFTa4ITKb4NH98+9APpXeaVeE7JZPs38MMvjF5u1jqR1Z3YQJM=@vger.kernel.org
X-Gm-Message-State: AFq9FYJZKcx22NFTzbkuY8ef+7Izqcc2WnDbVdW6PTeQRgnbTqvLj13S
	OMOgDVBJJ1n0RM6ebxhUkG0JzvWSPNcOYG1mSk86NpbgJFbYDM9BIeOBF0dKy2PlrcQ=
X-Gm-Gg: AYBFou2Kmw/LQPs1MOZADJMD2v90LkF0F2NEtuf2wwwHD6AsSfaP3lkq8F1HyExKeQB
	yZrRBf1E3DmB9R+j4MEdlJJJdATikD5lci6ApKVEvGvT2dQqWr6Mq8rP4p9JX9SkgxERoSj5lg1
	mid7oV/dkFFj03pWFUjDoo1nykidyANyWUfbz+IVBt4Cx0q5+/Oc0ZijhMjXoc/MAK1mtoUNXqh
	mvlyfERaX3LdvTEetSa4LRTHDbDtp8w+T2HZHKcD4JyCxjRtTaEqIqnN9U7CEpy++rQQgiUfrpA
	sMcuogdkLyokGRPUJMTv/fmBlbMqC6XKU07opNYLYfTQ1kdA10tahwI731HPgxgbDUXfRipcRTB
	EmD196FqMAVOYzjZQUpd6iL1LZXW2/peYQ5J1Jw4V7m0KELbxUevoo+phGUdlHExxfUN+FmkTbZ
	oxamV8PouNrGsb6Sog6kM6qhC4yXldDc9+tSM7o6/PDvKyH/sGJRqjYoUKB8skyIHTcYTL/tf59
	oXvwtNn9fWA3XogeXZfviCDBJrjlSkaukaBApi/Cd8IdKca0jjLa7bta30kwFbV9yVKAw+Pn7hF
	wRrNUg==
X-Received: by 2002:a05:7022:ea8a:b0:165:1f2c:5c1b with SMTP id a92af1059eb24-16a57b0c43cmr23608713c88.4.1792005462662;
        Wed, 14 Oct 2026 12:17:42 -0700 (PDT)
Received: from localhost.localdomain ([2603:8001:5f01:8bab:39d1:d8de:aae7:23dd])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1746482c978sm28966433c88.13.2026.10.14.12.17.40
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 14 Oct 2026 12:17:41 -0700 (PDT)
From: Artem Dinaburg <artem@trailofbits.com>
To: stable@vger.kernel.org
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	leon@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	mbloch@nvidia.com,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	saeedm@nvidia.com,
	shayd@nvidia.com,
	tariqt@nvidia.com
Subject: [PATCH 6.6.y 0/2] CVE-2026-22996, CVE-2026-23035: backport fix series
Date: Wed, 14 Oct 2026 15:17:35 -0400
Message-ID: <20261014191738.24034-1-artem@trailofbits.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

Please consider this backport series for CVE-2026-22996, CVE-2026-23035 to
6.6.y.

Apply the patches in this order:
1. net/mlx5e: Don't store mlx5e_priv in mlx5e_dev devlink priv (fix)
2. net/mlx5e: Pass netdev to mlx5e_destroy_netdev instead of priv (fix)

Patch 1 stores the netdev for suspend, resume and removal so cleanup
survives a cleared private-state pointer. The older removal path obtains
the hardware device from the auxiliary device and unregisters once:
binding follows successful registration, and the target profile changes
keep that registration.

Patch 2 destroys the stored netdev without relying on priv->netdev, which
profile rollback can clear. Its code changes are identical to upstream.
Apply both patches after the pending 6.6.y backport of 3d5918477f94
(net/mlx5e: Fix netif state handling), which fixes registration-failure
cleanup.

The complete fix is already present in 6.12.y, 6.18.y and 7.2.y.

Build-tested only as part of a cumulative 6.6.y series on x86_64
(allmodconfig, CONFIG_WERROR=y), changed objects only; no runtime testing.

An LLM assisted with preparing these backports.

Thanks,
Artem Dinaburg
