Received: from mail-dy2-f43.google.com (mail-dy2-f43.google.com [74.125.229.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED68640DB27
	for <netdev@vger.kernel.org>; Fri,  2 Oct 2026 06:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790923979; cv=none; b=BlNAPM4IoQ/JnR5wd84Q+F+F1LrtJT95acP2KrW2rsTyIf5pYPumqaOUbVGRMFYqHFQGMS34mDyb8l5mLbXojsomJzUX6w/uhaHyOCmRYd2CCuPeES6csmdia4o3FukZxJwv2gn+CHGJMH/49QER5YgHN7X42Bi/esJiQ5TFJ0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790923979; c=relaxed/simple;
	bh=qGSXLJIpdkJs9oQnRTS0s0gNjId4sqoHPGUPrcLSvO0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ukYfUsmWleDUu0pFHstyUc6yzkdomsBrKDU+LBRemZfTYFxUzF8NOxx7L/RlE/v3g0JpsDjzIrxne1f8CvHTI/sqqt4M8XpT55WYC1Xj/tyObgME3Ht79oGr3WyMxaD2/ldues2s348+uphw+3IjwSFrHCPHepHvKebIlu7FHfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cWXyAo8w; arc=none smtp.client-ip=74.125.229.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cWXyAo8w"
Received: by mail-dy2-f43.google.com with SMTP id 5a478bee46e88-33bfb26865fso7222795eec.2
        for <netdev@vger.kernel.org>; Thu, 01 Oct 2026 23:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790923975; x=1791528775; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=yjwPvXel9UWguQCsnhPQwjYgbCzapnsN3TFfdt7dBwM=;
        b=cWXyAo8w+o6XjheKjYU7OBQtEbDkaEyYn96VfrHsKVYTsyENwia16OI2JjrAlA+qVz
         b6reFEGrsTsdetw27zuQs5Gc69PwTNhse2DV/+O2nvsc39X7w8kU6ihF0yNbec9M45ZE
         vTrGUHqtkt/fxlqdJiIa9ckwQpEev2jYg/bOBxEj5pwFTv5ZRF9ejq17oaeFzC6piuGL
         YrJJ0vYVCe1upS+FJosTYw/3IQyAV5i1fCKSKcIKRGBl0oluxEel/gWK8BRPcx5BpfUx
         7KK1lIL25uLHFVhtTTIiL2qSwaRE4Ju9xBPtWgslqXZuzjfk/8QnhX0nKccZLdSL4BiC
         Ku8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790923975; x=1791528775;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yjwPvXel9UWguQCsnhPQwjYgbCzapnsN3TFfdt7dBwM=;
        b=ipxGruY7OSydJzvU3OHfhORwybj5+seEl9EDvxwhz/PDXjwAmw68mFpF+zcERFgQ4e
         5W+oTIMpAuiwWiZhxpmA7Oj+9Xrqk24oUPg/VmbWK4q6Z/xp9L8bKTrLAyR5d5iRW3x1
         u/oAsWnzaijlgjS3wC+DTrWDHXFDKXBjHZDo6ZiQSK9Lgjwx+rYIxHXcuxK1Ai6H6aKd
         fQQkG5XAOGLO5gf2tKc2XJBYJ+bgdvBzJcZLHwBGurWlCWVBErDAb9RDouKPZRmiZtER
         nP8z1GxexltZXX+w6zfJPPIy88ZXhQCCZX7DSuvj/ytAegEmZub+OILMC9Y6No/scp58
         39Eg==
X-Forwarded-Encrypted: i=1; AKwUvBzCTMU/lb40vDDEB1oI76Gzrz1S2ZEvpHJpVXHnhxYm2VfwbJOsKkHc7bBI04Ykwz5phhjkRLQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYJd3un752Um5O6OFBK/2xASu+eGA2Ji+qUj6TEq2k474QsCPaDe
	GmA2Csds1a9OI2AIsSIIIoN3nOLAFYUgkcSzBzGn9H6PjClz1NrJEvnz
X-Gm-Gg: AYBFou2DR7ClkQdcOzFwDUwI2UHQ9QuW9gmW/p9bOFF6VTsGl1+NYXTb6OeYLKwGtNi
	T8AQ9JIvMZZv63QEgBY6JaI9nBu1nfXvhIoDAkTey2Ehuqg7onLG64M726fTZInE3nAPirTGpFL
	xOA2jTZjHnBzxH/4bSHwZLl7VNlL+HnwgQLuuu/2VkiqG5bN5FtZ5Ib6tnuxV+qTZNVt2jRHErT
	QSbPEGpq8qaEIWc4uV2ZAlXGE4i36cPIYazvv9Y558WTfewknAeuTzwI6lkk76eCcnvVlTYu9JA
	CNrBh0dBGzoniodPRxD1246sj/sD3nu0J5BwmC+W88lXfp2sStS++ME+TES74CbIWW5kc8EeoN5
	zu2M+IHE8LdXjqSgbHzN9A9CVsuMDuzq58A1QtWkwzGpCKUQPmExJkuG+l7AZPukT27aR3gOOs5
	fpl/AExL+odYKaFw+PlZdfB5CfyJ9VKX4ZWfp37k83quz61WKX0eBcpFbFarSurnz7b40kdSn/9
	RQ1yBC5
X-Received: by 2002:a05:7300:c38f:b0:34c:f181:85dc with SMTP id 5a478bee46e88-34f219cc55fmr1976751eec.41.1790923974964;
        Thu, 01 Oct 2026 23:52:54 -0700 (PDT)
Received: from kq.cs.ucr.edu (kq.cs.ucr.edu. [169.235.27.223])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34f0672c739sm4349453eec.3.2026.10.01.23.52.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 23:52:54 -0700 (PDT)
From: Zhengchuan Liang <zcliangcn@gmail.com>
To: "David S . Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zhengchuan Liang <zcliangcn@gmail.com>
Subject: [PATCH net 0/1] net: netdev name hash leaks kernel text base
Date: Thu,  1 Oct 2026 23:52:45 -0700
Message-Id: <cover.1790917676.git.zcliangcn@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

An unprivileged user can recover the kernel text base and defeat KASLR by
timing SIOCGIFINDEX lookups for attacker-chosen nonexistent interface
names. These lookups reach dev_get_by_name_rcu() and fail with ENODEV
without requiring capabilities or changes to network devices.

dev_name_hash() passes the struct net pointer to full_name_hash() as its
salt. A missing name that hashes to the same bucket as a resident name,
such as "lo", requires an extra chain traversal and takes measurably
longer to look up. For a known kernel image, the collision pattern across
possible KASLR slides identifies the runtime address of init_net and thus
the kernel text base.

I reproduced the issue as an unprivileged user on x86-64 and arm64.
A tested reproducer is available privately to maintainers on request.

Zhengchuan Liang (1):
  net: use random salt for netdev name hash to prevent text base leak

 net/core/dev.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

-- 
2.25.1
