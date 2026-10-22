Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792660558;
	b=K6zN9mVk0EUTgES4nLJEQUgaPu8jPcjB8UbZ2o0LkdlBhZdppaGTjozf7lbkkVLqwP7y
	 qHQzN6OSiiEoHkfoUAppQtfDY2gMS4+4TD4wHOvbVrtUq9PEnQZ7Y/uJ1FyjlPENZmnOZ
	 4WdJG9n063TwfOJC7a1m/xrjoo1z1R7+qIV04vVfPf+enNs1VWT9ugzQ+MZDbsBi1yh3m
	 9zniPB0uSqYvaww0DymmeSK55FMSwM5V63qs9FEiSDfE/sj5Mf8zWDSOH1czf9P0vHcF+
	 u/OuVe3OWH6lCmF4Wu20n1zIWM7/x6GpoYA79+fPupbMDXMia7XNbny1JMoIL1CJS3g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792660558;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=0DnBewpAT9Tp8HPHEGwu8TFrPEm2oKGIa0lEEldW23A=;
	b=ic0UQGmG5BJXaSqb9BXdnwKPFgpssp4HWLRS3VYhsRDQB+9lQzBfydaArzYbPsSXQBof
	 ti88bJ5bvBw9uQT8v5gtY0fsktZwLQ9SSRzOIuJHKy9ML344HytfezsVMpzvrnYLJQq61
	 G/Oqj6kfAh1V05luFwXYlSqgFFs26AYL72KuF48XZIUrSr6bnWrfD9s2UTToEtWV+lpUx
	 aD+j2ifILLfb6/yNTJ5KQcrMEohOAVkxQSGyML6//4y4SWhKcYG+ZvjBlT9fy50ykn8Bj
	 HmBMvnRfT+68NO2vdJvMUE9BqKaIqyJiFrYFPaKuc0s9Dt1+YsqF4sUtgmSL3WcxIew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=f2R6lhfN;
	arc=none smtp.remote-ip=74.125.82.171
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD088606A32D
	for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 09:15:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AD088606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=f2R6lhfN
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-353804b591eso2971266eec.0
        for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 02:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792660557; x=1793265357; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0DnBewpAT9Tp8HPHEGwu8TFrPEm2oKGIa0lEEldW23A=;
        b=f2R6lhfNbpSMOlA4eijeSjxfPGs/IagN2sLt+URzwd0T2IAl6CIabS/oH7qRCwZiYa
         SN2ahkwMHKFUjeq1wi3WLd2M4Ah6FfG9xJ30JKIgPskN+JeXIHwI5p1/p+2zp+O+AGIi
         t7agmkDWnSH/YBgg6vYyr4V91iDmWNC49HMhmPSGQUCAyvRDuBnDuxMyj5S8gWpxAuUu
         Kp9fn/5PUeWBvSxd/CwsTRHtdn/9hlZa6qy6L7aTERr68+MyZR+i5fUA66eH2rWQNMAP
         2QdrpXVOTN6uE40v5L7oCMu0R8M0/UWEXTL8dfyBS9bXU1x3MsEdUnm5MrWYuBMKCzME
         VEEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792660557; x=1793265357;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0DnBewpAT9Tp8HPHEGwu8TFrPEm2oKGIa0lEEldW23A=;
        b=W7kTsybZ4fyhxOaKgkBlIV7NfA9KFVXUnanYOW5Ub8rd0Z6d8cNpn3gPid3L7v0BB8
         D6hTb40IWOTRoUxokoFG6VgZr7LvpUI7hi+z5W9ZrgTjbdwwnAyi7BWCIhT649NKOye/
         4szCHKa99a38ruK50gnj2EggbZ5Yy0sw47GqwrKT5+CvoLBdRjlgDiirRaJwG+paxOcP
         L4qj0HwUNjHaQAMvlb0BooJ3YbI1ilmqPycprm4U+uHsX4el8REB5koPhjb2wL5WGz0R
         ELxAe4vYctfA3PPHuJNuYBZ2RoBgrvlSwvmCkEXKv+DEcJsMtyhU1fV1jhYnSqhX5cuo
         yPqA==
X-Forwarded-Encrypted: i=1; AKwUvBwafKRpys+kNAyU6X09AdD/ndeCaVeYeqI+tnO/6HfvPWJ40GWD2K+MoNtI2PxcxLqyp5Upy+k=@vger.kernel.org
X-Gm-Message-State: AFq9FYIlZ8wuj5lH8m38OZ/DthrlS2tdJFZ0IV9x7lEa6adU+CyQUBxV
	2NJAeDK1b2tjkaXSSGP4C77dK/+haxONRYy3SwUFGCm+nPt6sQgkelG2
X-Gm-Gg: AYBFou1G/9onxwo5oPYZOWNIB2b1OTtWwaor7whPu48ormLf8jRjlHNhuUfzVOxj/4K
	IRbj2wBpAALJSqn3IpIKZahXhWTuyfhPdQ0Um8XMYHdJShlRZiXIJzR5WdESlUYyUWnzp7eVdwa
	FwqyBH5t1/GQbkOqzimjM2fYmYQrc4x0vYWbz8s2AED9hYfWF1wQrpPsnu0SgnVf2nWC/bhZ9Qt
	Ou+mzD5pnqDNYz0Yt8F7MXGODNp8z3OJXANQbB1tzuCe2uSeRQHPzNfRu4+2ucyfPsxnGOTfPQi
	M89bqNBXWV9Vs9qK6faVepIgSa6fRVhk6U2OyK3RJFo842ijIr0IhaNocJ1pmxTk+14o3OqclAu
	QTBX3yiwPof80bHB9C5NVOLJiK4vqvbbOm33gOP/zAUtaZpndkOSYfjnEidmBbzPW316ljF/ooW
	JwFXzCoRX8xb8hHgEHw92HX4Gahn0j6GK5Rq7fD0aNmhX8EstjChCx0cKy+zNNUDgrrQnJ0Qwmd
	/eaEMkWqbGUGIt4vtJlTudAVVyaqC4AB30cdQxcSCqZcjegyrPZ2OXUQ3KRDWiNzBuC//6MJviM
	/SDJDK0f+BKF4caTE8I=
X-Received: by 2002:a05:7301:dd90:b0:35d:2633:ff79 with SMTP id 5a478bee46e88-3674e64b5b0mr6323161eec.40.1792660556817;
        Thu, 22 Oct 2026 02:15:56 -0700 (PDT)
Received: from youngkk-vm.localdomain (67.216.200.102.16clouds.com. [67.216.200.102])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-367411bd2a6sm22187442eec.18.2026.10.22.02.15.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 02:15:56 -0700 (PDT)
From: Cheng Yongkang <teel4res@gmail.com>
To: Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	bridge@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [BUG] net: bridge: CFM period conversion overflows 32 bits
Date: Thu, 22 Oct 2026 02:15:50 -0700
Message-Id: <20261022091550.3651455-1-teel4res@gmail.com>
X-Mailer: git-send-email 2.34.1
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi all,

The unrestricted IFLA_BRIDGE_CFM_CC_CCM_TX_PERIOD u32 is multiplied by
1000000 in 32-bit arithmetic before conversion to jiffies.  The same
expression is used for start, update and keep-alive.

On a HZ=100 build this produces:

  requested 4295 s      -> about 40 ms
  requested 2^26 s      -> zero
  requested 54369991 s  -> effectively non-expiring saturation

The netlink request succeeds, and RTM_GETLINK reports the requested
period rather than the encoded duration.  CCM transmission can therefore
stop after one frame, stop before emitting any frame, or continue far
longer than requested.

Observed on Linux v7.3, commit
08ab31164c55f20c7a2653de3186ae333470e2c1, CONFIG_HZ=100:

  period 10:       3 frames, active for the control interval
  period 4295:     1 frame, cleared after 1115 ms
  period 2^26:     0 frames, cleared after 1 ms
  period 54369991: 4 frames, still active after 3507 ms

All four requests returned success.

The conversion needs a 64-bit intermediate or an explicit bounded
duration check before storing the CCM end time.

An October 2026 iproute2 CFM discussion notes that the CCM-TX period
overflows above 4294 seconds, but I found no corresponding kernel patch
or CVE.  Candidate BR-009 is a separate queue/save synchronization race
in the same state fields.

The reproducer and full logs are available on request.

This was found with a multi-agent workflow; the
overflow signatures were reproduced in QEMU.

Thanks,
Cheng Yongkang
