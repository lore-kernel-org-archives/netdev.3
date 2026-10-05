Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3F564A0F15
	for <netdev@vger.kernel.org>; Mon,  5 Oct 2026 14:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791211212; cv=none; b=nW6ojqtVXGKep+ZpGxpt7t2YijAcKwfqvZLaD8KpskWNCBSlAFdnpmfPynqnLQN75CNufEcWaXp8sEjhP7NyFsv4gUyf3SXFzlLKsNw92Uvcy03R81E3Ba1yr45BBCF94zTaHzlDKxhgTl2IDFVBJCYyUzLEgsNZzjzafnRBZdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791211212; c=relaxed/simple;
	bh=p0XxDjIkMow/otiJs/0jA2ZFfuycIzlWTB/nybIO7xw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Tl4t5XzrCGfjgh3QDP6Ocw3Tq+llldYFkHnhGmw/uNJ9xgjAMocqnxdfAFSPE9cKLBZIAvHvirFg1uJRWSICvjZYEV2C3KioYJm2tN/vJQPmIVDA1X3r3CSB66Zm/i2SfyixppDyjzk7KjTMNIsRyRjdAshIpWxb4kMTCKAe1xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=QhG4SAzv; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="QhG4SAzv"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-4a1722c37c9so8447525e9.3
        for <netdev@vger.kernel.org>; Mon, 05 Oct 2026 07:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1791211194; x=1791815994; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=qJyOJBzmps9x+F3wj+b0umWwMs4AcgWRN6f7/jPJhEA=;
        b=QhG4SAzv32By5xy/S9LJ+uC19u/pFZ4GWn2Ixn+tXVZxDlr9Yce6f1J72Q2CkaJ9Bi
         zK8Zsb03xreTDs14C+ztsXoueZjHHeBhJdVcibXLiVQUvk5gy5w1ssG+8MK62F4sUxni
         7tvCYeDAzsX4XHyqc2sOyw5IcIG34q1TE0dnBxtGpu7vjfvVFPJlv4A/F6Y7iroPJc4o
         q7sOvPDLBL+TWu9IvH+mSWJEWrgH0SbaX6X6z8PqVvOCAEsMMVmFz3Ev7DbM1XJmOaGz
         L22cE5t0eEbkau3Z7YLEoKKM3tpss0ROFS8bkIXcNfdi0wZcMnVujZgcE7X1K5BAr7hy
         +wyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791211194; x=1791815994;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qJyOJBzmps9x+F3wj+b0umWwMs4AcgWRN6f7/jPJhEA=;
        b=yF4RtPrnLnwyYGiU2z8YXFsoAtHaTvKmxLWslg22jUH4p0EB5BtxXqOnjVsWRDiqao
         i2p0HNtWBMgFmQx7fKtj7jv86Z/pzy9rwKhj2qknoPtPm9+zAfVWp+YubaO+IMhcT+pX
         eo1gD04EAVTanDLh/Si1Og3didaTCFVRYf7xUZVKvMKl62GavAw/Hae7NeSqz86+e0Ni
         lo495YLFw+XgKvcEi1JhaHfH6GzfI//D+lewSf3KZegG96ZBgWlFvmPuVaoHT41C6QcN
         mHVmKHuneKIfjpaPmw26VCeAZSXFQfERFHa0ASMQUElddRPkQRtUC70eZWXo7scI9UIp
         m3aw==
X-Gm-Message-State: AFuF++nafPmB71hWjQXAPjxQs5A/g4xBvHxSS1/LJU/7BdOzlT0wIi2F
	GepVMimA/DKT0wQx+7NSuM1wbBQGJDuAxdoFWACH5jQaGNQsBY34K8vXvT8ZUQf0+TzYJ/lqkXk
	frByo
X-Gm-Gg: AYBFou1OkJ6tH7lTpvHT4Ai8b4O1Iv2/ZjDis18CDeB86/YIBvDJWQ7LK+07yiUiFWs
	6y8mb9oT87pYQD/o1nR4kb2txDrQcbGzbvmaeSfatkpZZZ+2AD5R3k/vm7Xk+4nZEbvWdQwwkUK
	wfqiXSGoUO4a+1mQkM8Ni2MvzPRRE/C5TWLCTfGRyd938IUCmRobXjk0Xh51eaOURug7Bdk1uqP
	GUifpS+8lZp+GHKKogIFldqUz6D1qbzHO4Agf7gwChshOITqshuPDwjMplzPEH6we7XFcv0BTBw
	PR86qcvcnlINkph1psYz4cqfT8duFK/gOGVR5xkDOQMtwjRKNV8hINzyPzUVnNgtC2sVKBTmjGK
	rybsmxtaHPrGMID+8ZPr107cJ4MdGiTC45ir0wCfJjMR/FRqLcP9zQcBhTtnhcGQNZJRdIygj0l
	HxApTrXBeEpMhqKqplvre+enQHaWiyoDbkF0bXNKXPSz8bvH0AgkLBVoRMIsXUyUfRZvV6Z5rHv
	QpQw23jvvDTMKRPKA6S
X-Received: by 2002:a05:600c:46cd:b0:4a1:6992:f861 with SMTP id 5b1f17b1804b1-4a16992fb89mr118380335e9.1.1791211193895;
        Mon, 05 Oct 2026 07:39:53 -0700 (PDT)
Received: from localhost (78-154-14-127.ip.btc-net.bg. [78.154.14.127])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4a03ff20831sm219706445e9.4.2026.10.05.07.39.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 07:39:53 -0700 (PDT)
From: Nikolay Aleksandrov <razor@blackwall.org>
To: netdev@vger.kernel.org
Cc: idosch@nvidia.com,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	bridge@lists.linux.dev,
	Nikolay Aleksandrov <razor@blackwall.org>
Subject: [PATCH net-next 0/6] net: bridge: fwd optimization cleanups
Date: Mon,  5 Oct 2026 17:39:31 +0300
Message-ID: <20261005143937.877466-1-razor@blackwall.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,
This patch-set takes care of the review comments and also does some
additional cleanups after the recent forwarding optimizations. The first
patch and the fourth take care of Ido's comments[1]. I have folded his
suggestion with inlining the pvid helpers which aren't necessary anymore.
The second patch takes care of Sashiko's comment[2]. The rest are
additional cleanups. No functional changes intended by any of these.
For more information please check their commit messages.

I do have one more separate patch-set which removes more VLAN lookups,
this one is only about following up on comments and minor cleanups.

[1] https://lore.kernel.org/netdev/20260921134458.GA2199421@shredder/
[2] https://lore.kernel.org/netdev/179085595018.434549.16034696945314071975@kernel.org/

Thanks,
 Nik

Nikolay Aleksandrov (6):
  net: bridge: rename dst to fwd in br_flood_vlan
  net: bridge: fdb: update the comment for br_fdb_cleanup_by_dst
  net: bridge: vlan: share VLAN validation in br_should_learn
  net: bridge: vlan: inline pvid pointer updates
  net: bridge: fdb: factor out configured entry destination updates
  net: bridge: fdb: use the entry key in __fdb_update

 net/bridge/br_fdb.c     | 51 ++++++++++++++++++++++------------------
 net/bridge/br_forward.c | 14 +++++------
 net/bridge/br_vlan.c    | 52 +++++++++++++----------------------------
 3 files changed, 51 insertions(+), 66 deletions(-)

-- 
2.47.3

