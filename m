Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D36F1DDFE
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 05:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791437586; cv=none; b=Y+4ScukHfePub3gCi+j98hCK0yelg26WNQaOqYH6eYQfZL5bFHyIPDjZKC5okBM5PodYjc+qdix8e1SJ93Ae9Zkrz8s7XyhrGhtS/EKGvmXWZuenMmYOa+tGJzsSULYofBBry5Fw3eBvz6GxoU0XnHSpQ+gkczaQY788Snxl7Yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791437586; c=relaxed/simple;
	bh=JHL4uUbSQFdeWU8mzd4tfg7TVFKGMQ5a/+Ceb+bSvOI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=F5NL/jCojVRB+BHBNw8uqMvBwQ+yNl8H3ruOmgnMfYpOOUazydNtUq4+89HlB2UOwSNSClBzx6qyDQj4E9sYIcqlzgTU1vTUS0ZUCBiXqtdC6p4zsb9lwXk0e8ee2wTUx2dFm4xguflolaO9P3TiNxu9jVnkK43q9gcvP4O6hiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=eKNvW1Qf; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="eKNvW1Qf"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-88a627ce016so1305174b3a.0
        for <netdev@vger.kernel.org>; Wed, 07 Oct 2026 22:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1791437584; x=1792042384; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Yq3pkVG1Ysjl1NXZm8QEP86qL4DV82htKjCsk23AFNo=;
        b=eKNvW1Qf4Q2tH+noLaooV3FejJNcClEv9sdiQW8AwrzI01OJkxg7YV/FIyCioxP90g
         KAKVWuQ6F0KZWma1gJpdmkwhvqneXL/JTFV1jQUjwXRoZ1K8itn72n7dtOVRwz0gRB/w
         OF6dIduIPQr4vpH5YhruFTCbkw2MnGPdkZGmHKkz2sw9x0KCnqBXQoSa+vg+R23gWPHr
         8chnAZzOXlvp6+gI98QtmIXbIC353cRe7eG/+VRuYaM782yM+hiWLowDrSXyz6cOxEDa
         /P0pEAButfDNLxxf4wdUnygKYdpfXoryVld6RAvrf7xn8ijRbJ9E6qptC0qK7sReipSt
         Fsqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791437584; x=1792042384;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Yq3pkVG1Ysjl1NXZm8QEP86qL4DV82htKjCsk23AFNo=;
        b=U4+IuG+bmulqkTD5sNRcXL/8oK3ivt+HYlDqbfVvid38PEzf6jWH2oDcK/uO2q8gpQ
         u6vt3+VHmuQ5mIGQNpfx4/O/+71cdbSY6wG2XZBGZC6yL+fye82Bl3/9na61ddbsTU3d
         RwblpYAnUUuyUYbYYVZpCVYocyBgEbnIIvzasaJyl82q4IMU1jhfgqNDclxrKMz7I/QQ
         oKrLW1r8XKATGFH0R528iVlHFXLUdW2ru4U7H5IHvjEwTFDMJeHKww2+3aFxHlGjecrV
         qhDXNchZmGVQ5ajfmiN6ESL3AcNzflCSDhx3rkEYE2q3KRIeqzCg8l88kiNPexK9d7ke
         z1iQ==
X-Forwarded-Encrypted: i=1; AKwUvBy8+HiAVrlzZ3p0MwKGpwZIqbJsJp9tDe55gtLZtdrXmSMJ5A+shypCsMEhrc2PlUQAlm7geTo=@vger.kernel.org
X-Gm-Message-State: AFuF++k/E1tz0ZXRvsoukOxiOwrC0u9+hqqEad7IuaO7aPfEjS2NW2q2
	IrNg1Bk1q4nZR5g+hpc0CrxdmvmcYb1gnuHL8PB4GN4L1qPG9IEJo57zQMtip9+m97SM
X-Gm-Gg: AYBFou0sPtrie2nqGloNjnWla1Ea1l2eX7HnjclhThe9quo2Ucxg/emZjnY1nZVyk1P
	opVvstB+Yo2cJOJzR1EnaTyBxUFy7yNaflFA51MmDuWnyeKYQhFkAQ1zdGhlQOBNKY+Zbi3RZvj
	5JSL1sBQ0U4tJDVjnsr6NGWVpzSmKBGWQWH2tXxXU8o4Y5XKiahIH5+su78KzomeJVQ8eiXgHjM
	0ZBC4zUHLZ2AglU9SFuGBEAkVF6elOO1URk9Xnd2P5X80kzhWkrvnoy8h7/efhVr36usvn2DZE9
	56FLOdbmGn2yJLRvtzA5CTk4ZD0CbKBgfS3sh7iukn6nUDJLX5DkDZqHDOOu3XivY6wQdmtYIWy
	HRWbnnBpAkSTqRFYgWZ8a5pWnvIE47N3uaKiAwhj/6eaQ8+mbLDkWsQLF1yERXxsDANUER/xYBk
	zUqWRs2KAk6rrHSHmrF/VKxuEloJb8aaiTCo51ObplH3tscIaw3ioeamMNkCxAsGI3ZgN4B9MJW
	X8XCp6k8fF49cNlu/kndEioEPmA/Q==
X-Received: by 2002:a05:6a00:4f96:b0:878:3830:a48a with SMTP id d2e1a72fcca58-891b2b66d6amr3918568b3a.58.1791437584394;
        Wed, 07 Oct 2026 22:33:04 -0700 (PDT)
Received: from 954df21a5119.. ([122.51.212.64])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-892bb7a6d70sm1025773b3a.45.2026.10.07.22.33.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 22:33:03 -0700 (PDT)
From: Zihan Xi <zihanx@nebusec.ai>
To: linux-afs@lists.infradead.org,
	netdev@vger.kernel.org
Cc: dhowells@redhat.com,
	marc.dionne@auristor.com,
	davem@davemloft.net,
	edumazet@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	vega@nebusec.ai,
	root@tr0jan.top,
	zihanx@nebusec.ai
Subject: [PATCH net v8 0/1] rxrpc: fix encap_rcv skb accounting exhaustion
Date: Thu,  8 Oct 2026 05:32:52 +0000
Message-ID: <cover.1791428529.git.zihanx@nebusec.ai>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This resubmission rebases the RxRPC receive-buffer accounting fix
onto net/main at 6d25ffca055a.

v7 Link: https://lore.kernel.org/all/cover.1790427022.git.zihanx@nebusec.ai/
v6 Link: https://lore.kernel.org/all/cover.1789608557.git.zihanx@nebusec.ai/

Zihan Xi (1):
  rxrpc: fix encap_rcv skb accounting exhaustion

 net/rxrpc/ar-internal.h  |  1 +
 net/rxrpc/io_thread.c    | 77 ++++++++++++++++++++++++++++++++++++++--
 net/rxrpc/local_object.c | 24 +++++++++++--
 3 files changed, 98 insertions(+), 4 deletions(-)

-- 
2.43.0

