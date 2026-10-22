Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792660541;
	b=wSNscdB8dZklnKASIRn+vH+nr42xja66a8mnqYoouYM+UVCuiLE09v9TorRPUiaTZozW
	 BLJbMD+LYj7kyEc4PHIng9hDM2jz2l0FYLqPeocotE33OSP+YuAfQQ/5yLHEw+jon5sm+
	 aqevNYx19NzynfyAK+s8RZiElGkrpSkmS6OzYHVdbUjPH/lcTZ8Ygk7cTqVYdKUSnULnR
	 0y0jfdZ5IhAJPVEKUhMSE5hOPMJH39fAZCN9Z1U6VU1sRPz2CXq49VRav5hTTkuC25/HD
	 zavVCdOMdX9/ZFWxi64IOf1VJF5MlThUCPsRzXz108gORCF0jN1bJNcKVDrDmARf1VA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792660541;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=cE1oRv74Uai/JOHCCDXA2NxiKeZ88D+LuOVAazAETn0=;
	b=FMH5lXz/ZQo14/I84yUtbhl4150rIHrbGkcTwWrLSUSEMz9dZX6IZZ7Qa0Kcp0iv8PAX
	 mb9y3woRYaJ3qoe5BArdTiwWblmsscZxoQV1IMRhFNdXo8oPvx5Vc1WOZZ+dXBjRYFX59
	 CzTpo1m7ypt0lYipM9wKT0EI3E59JVCvG3aa562dfo/+6aFSklNyFKvXs9EKF4lL0I3Gi
	 +WIKhP6PAWi5prO3vHsn3EitQ9WyfUMsrWlkIv/7g7YtUlTSK7pi6hmDSy/uDiGTJwRNK
	 kLtxSxEiplTTwlJ0kJGgZftl8vtiak+Eh/i4kAcIWFq+lPNafZn09JJH90K55QiuEWw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ctoFSPwT;
	arc=none smtp.remote-ip=74.125.82.47
Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F7BB606A32A
	for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 09:15:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0F7BB606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ctoFSPwT
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-15ea896ddc8so2344326c88.0
        for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 02:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792660540; x=1793265340; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cE1oRv74Uai/JOHCCDXA2NxiKeZ88D+LuOVAazAETn0=;
        b=ctoFSPwTjH0ky2ufMCJVPj+xC7/Sn80GpTiwP8zYpEz1pj0aU2Erbm2DXYb8go1oqt
         qYo4U6smceLyUQOH8vd18IkxK0l1gqyQkUyODOpZ7IUmxC/4BHAP5j5fzqxzEAZ+g0vo
         Mr45+LZdY+iSjt3EXKdpFKZxrJtePP4KmIp43xB33nkhasUFln5D0ibn7qdRYm/4IeFC
         DwECnZyBzquvxGWJjT7NjeqgNIRqE7yWAzPmIeDRNyWaOT5PDbnwSuGrc5kFS/KK9RJg
         l5mw3XH+iJ2uAAFSzuMMT8d/43+I7sp88MlqcoZiK5EStFdNxJPtW2TXioEv03RGEipf
         8iAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792660540; x=1793265340;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=cE1oRv74Uai/JOHCCDXA2NxiKeZ88D+LuOVAazAETn0=;
        b=fD0BrlSLfjhJKurC2ZpnhRzGKroLNJIEFjr2DK7Y3YEFbrqpsly9T8VOLk2N0yqWaf
         ZPEt1x/Bhh9A7t7WGKpZYiC0+YgTgEQT6g3oO6hVW0Tq1NFwiFh1dLIhU3ARa12oH2t9
         U9lqFV6vbtBkkuF29ZKevaYhK74FdCyFpmZhFeKnjMik9Ps5MnMUopg5ykZiXcFCLvD6
         LvZZkcteAiUYXHOKcbDm+87th1Z2RUJSOStLQTENZxq+KeHYGxh/JWTRwSCUD65vzVwI
         oPqmIktc+BQyVUNo9mgRnYpGMN7HfOzYKqbEPZbBj5AT9M43DUYnCha4NZhtU7YFQZ64
         NHWA==
X-Forwarded-Encrypted: i=1; AKwUvBzJCapljb5kv6W61zUPfHvszIOxGRSHx06xfp10j2I9GcxqwoHOxScoU7MJxbovLVWg3wfe+GI=@vger.kernel.org
X-Gm-Message-State: AFq9FYKtiKmjVQbIu32lrmaPTrllX61LI3QXpVba7vR7tjpf4KNqs3NQ
	1NsFyOF79f4vzryQKXZPD0l99Zt3LmlR3wkZ3qzVg8/2QPl7o4U1vlBq
X-Gm-Gg: AYBFou0SSAA5nHlESzJYo6+8exXTk7aWfCmwKW1K/5aqE1geTn5LuYcJ97TQHH8YPzG
	6OTRejA8K2am2ApOTcf6xtZknol9pdZJmDGTH0/Bd0xAYhXKTWGdwBObJZA2+GtRkF/4TGrrbT9
	lyFmeGh5MseMmcgPRFeBr2O0gsbstk7AMheupCtMpZSthqABVWqwzsGm2OlpoxtOmvenf3P5826
	l98Mm0zgs9yYixLSwFbMlazjEMXteUG2+SyJcXdkGDT7HiH70/LPycPT/amPiZRy4d4lQ3M8wU/
	8jNP+terYkJhlxjiquFBWlh6MXJHDOfwgW091xYQoEB1adp6ByoDxalbxmJLbydeYqyYvV8hwV1
	HSuAcnQk5Pcuki2A9ncoh0/MNu+fpgRBmGDAQNFtC5eDKgz0PnqpL0boFDWaH7UKBeRgjK6qi8A
	EVAkZlhj/IGeTKUA1geBbr0DjCgvBu0VkHzFHKGmRCe5lR04v1C1U9APQlvJoqccUehzu3x/2/z
	fmXzRi5ZnemHtY0jxIoTb75pcyh1Lh9Dd81uI6q8vEt50q4iNalfXkunm/1asgFW9AH0Q1MiSgE
	0lBthacq+RpnC64pJ+E=
X-Received: by 2002:a05:7023:c018:b0:144:fa57:c617 with SMTP id a92af1059eb24-190a756bfcdmr5268242c88.34.1792660539942;
        Thu, 22 Oct 2026 02:15:39 -0700 (PDT)
Received: from youngkk-vm.localdomain (67.216.200.102.16clouds.com. [67.216.200.102])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1903bf5d0a1sm13415991c88.14.2026.10.22.02.15.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 02:15:39 -0700 (PDT)
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
Subject: [BUG] net: bridge: received STP timer fields need range validation
Date: Thu, 22 Oct 2026 02:15:33 -0700
Message-Id: <20261022091533.3651250-1-teel4res@gmail.com>
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

br_stp_rcv() copies peer-controlled max_age, hello_time and
forward_delay after checking only message_age <= max_age.  It does not
apply the ranges enforced by br_set_max_age(), br_set_hello_time() and
br_set_forward_delay().

Zero and oversized values have several externally visible consequences:

  max_age=0: br_transmit_config() cannot emit configuration BPDUs while
             non-root, while a zero-delay message-age timer forces rapid
             root/designated-port recomputation

  forward_delay=0: a later BLOCKING-port transition uses the zero
                   shortcut and skips LISTENING/LEARNING

  hello_time=0: once the non-root retained value becomes active, the
                hello timer repeatedly re-arms at the rounded minimum
                interval

Observed on Linux v7.3, commit
08ab31164c55f20c7a2653de3186ae333470e2c1.  A superior-BPDU flood with
max_age=0 and message_age=0 produced:

  max_age=0 in 904/1000 sampled intervals
  attacker root_id in 897/1000 intervals
  68 non-root-to-root restorations
  122 message-age timer expiries

The bridge returned to its configured 600 jiffy max_age and own root ID
after the flood; the impact is rapid flapping and transient suppression
of valid configuration BPDUs, not a permanent takeover.

Received timer fields should be range-checked before they become bridge
or port state.  Candidate BR-035 is canonical; BR-036, BR-037 and
BR-041 are different consequences of the same missing validation.

I found no matching upstream validation patch or CVE.

The BPDU reproducer, verifier, and complete serial log are available on
request.

This was found with a multi-agent workflow; the full
state transition pattern was reproduced in QEMU.

Thanks,
Cheng Yongkang
