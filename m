Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793801841;
	b=CaBRizqUdHkWa+03I00snOt8YG6JtAgvak6iW8raekh2ofq4VxVcBQmTzWapcRrBcpXv
	 R1z68hh0iQd17gzMgNmZrZ+rx+4AkaLFigJmaTuLllAdeNvdIpul7ohEGxmR6HSnRKTGa
	 EOeo8943utfg9oPV56Gi5tV/WyIU22tWLacY1NYnbil2QaU7iasdXnL67CRIMj85T9tJl
	 MO5nypsOt9orfS0hIX2TYVhrh5GeH+ReLMttHZsyxMvm1GJ5wefnRAZCf6eedN+aQ+zXr
	 mHRZKdalpNZfA02wLC6UE9B1dkM8WJ7KLOuK0VFxfDJsCobkmF7iKRLfGY7QSUzxJDA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793801841;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=pKzlEM7eLpAeI+xeRCLoKvbM3rxDxUKIyYaryyr6NqM=;
	b=WeV1QuAG2UsRKeXGOg2KwPqBmSGBA67xzoNryAYuCcxUGGBQkVk3UIC0XVJmlGnvi5lW
	 qSxSn1f7WVP9EupdGbQ5JgT6c+3vSQltf/2N7zRJ7YZkXrf323/m+bCNqIU2OJVDB7WjS
	 +1OjKm6LFKcDxRvreolUc9vBVu5i7yoAuGtMAaPhZYBMsNRdjfdYoQxBwTZlu+Gzf1cx/
	 aKVf72mRI+sHwku8Xl5DAR/5pp9fK+HCdNxERwpJ7ZE2B0PxrZoqf2oOqhkARreh5U7nb
	 g4STJ5W0SYcB3mxf9q74ak8qqZHoBrDfl6z8yJFCUoLQPn2hvQ9u35ISPkS2Pz3AJxA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=b8Zh1YAi;
	arc=none smtp.remote-ip=209.85.208.43
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03D57606A328
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 14:17:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 03D57606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=b8Zh1YAi
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6a642495d81so1123962a12.2
        for <netdev@vger.kernel.org>; Wed, 04 Nov 2026 06:17:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793801839; x=1794406639; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=pKzlEM7eLpAeI+xeRCLoKvbM3rxDxUKIyYaryyr6NqM=;
        b=b8Zh1YAifXedzqflRyMS/kHfSanHWuE6dFDkuFqlC8dSa0Ny+Qhp79AT4daFd3iRja
         jGiVFF9bLEtBetMU2iJGIR3QlOrE7FdNHkXKfTdr7elyVG1QJnTEf/dGjLCKc+ckZTnD
         nALFIROWpDnAeQeJaNT/rd/FekK7XLsiG/Ii95lXXQ5nPGYz80SGjtfQU0DxjD/pe8hw
         E+WqoZThpYcjl9xXNYq9cbE2b+fJ43F5UMp1hooUQslYOB+KbPHzTVjnTnEPLX4u5h7n
         xT9rLyLpalZNZ7ut7nYMrEeSSEhhZ+aY0MryOIBrO4K8mNuxNT0BUaNgAs+8tZnrj2l1
         QtWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793801839; x=1794406639;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pKzlEM7eLpAeI+xeRCLoKvbM3rxDxUKIyYaryyr6NqM=;
        b=o8ubyfz/VC8At9Gp1AYb5OpNr3A//tLdMg9TZ2IKc2Xm8swQ/cmdwWSyB8AP2tVZlL
         tG8g8jduQbS9z/wmL0iq0WDPkXj80sUbLy/ubANlGU8dZiovkE0cFg6OZIZImfINMlvg
         ub6QiBTPoV2OvLF/rHoGBcF2kqoOxsxf146YlV89elQ3yYoSu9q8Qlv7pmJWiNcrGGPx
         TbHQB7zamFvi47pkQkE4gkLhQDiN6aDTs1vSnCSDupi3f/m5FXyKMB247t3osS8NMan9
         HWuw3tTVJs8VY1l+0dZ33JXAeuoLWqivbDNHqixT1MQHD5DHVks+uRFCbeduWRHNp80t
         2Haw==
X-Forwarded-Encrypted: i=1; AKwUvBx6L9LZETmdeXKOfPYw9GlqfaoibQhLBTZ4hz547n6kTT4KbWH8GKdxkK49h5v/Fz+eSStSwe0=@vger.kernel.org
X-Gm-Message-State: APuU4Z8Go/GZttlyUcFN6YlaKvclUpVZ1+sHiQcV8bzkmfgo68wO4G10
	pYsnO+ynOLBugNAp0dA9xOu5wpKAM8/TNZYZO8K8PAaI7X3FSjsoOyd3
X-Gm-Gg: AYBFou2fksi4RsDXyxlFxADBuuhRb8SOYe1rB4OnJBLOQAfbb+JtXZ1CZDg4gJFBL4C
	PzGcCVfy7hFK8iFDG1rMHU6PncQAuzmq6Q55EPePq6avBoOJR/EyKJkZjrwoUqkyVOWt4Uv7seH
	rcIwIMharm2I1DcCMZEqZK+g4LdAjoaY+wUIdJR7KTvw4a2Egq4/kghDUhNJqzpNxywuWOuWMtX
	KERW1B/jCsdJmAVUJLHfoGsoaMvUbpMQ7vBKT0K/8LSBQH/JcOUIsmsJE5j3yC+Fl29fz5MRIPt
	m0njVj8jDvz3ULP1S0xndxWNTVsXKZrp4UDC3F0d6qE6YG7SKkiWdUrZdfeD17Ex2eztgpBj/WD
	aGVZ0y94+jU+jzgTZr9E1pv2kJi7blmrbIfuxDH2CvIK4QGdGVrrW6iYscE1UuZYCjziibXkmV7
	Ov7oSZNti1A35h1f/kaSYeuMisH9BpSxM+WkntyrPG9uZdtEMa2Dwr30pkX3bFsZbUC/3QV6p8x
	5XLj+xnvE0AbeWbC7m+9nRFSeg5yEKnnT/I84XhrlbcilDqoFtY1UrKRTWoez2+oWjx+cVcZ7s4
	6LmnqCYZr0Z6PdYtm/5ePi0CYdVumzMnFiX0BPaKmLA2Q7+fU0qbIPwa5YoB1CUXyNhwfTgcR5S
	yF2F5YuoEymZJYatlIHL6X+zeZKTN5TiQnu/KWTLjCpgYKaa9IYAS70pkCwurHX0OP2HZA74xFt
	iryKeTbHom9opofAbLy94xYUWehBzKkkeQYBzQH65thyX7jnNIOguX8VJ1w8MMMPWDTAbXef8DZ
	W3Y/nrW2bw/ILH5dEk+U9s=
X-Received: by 2002:a17:907:6ea4:b0:c3e:d2c7:c530 with SMTP id a640c23a62f3a-c4ca7a072d1mr1375241766b.12.1793801839040;
        Wed, 04 Nov 2026 06:17:19 -0800 (PST)
Received: from Ubuntu.tail0f733b.ts.net (87-205-15-91.static.ip.netia.com.pl. [87.205.15.91])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4d0e43e2eesm77311566b.31.2026.11.04.06.17.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 06:17:18 -0800 (PST)
From: Krystian Kaniewski <krystianmkaniewski@gmail.com>
To: Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Vedang Patel <vedang.patel@intel.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v3 0/3] net/sched: taprio: fix RCU stall from replayed schedule entries
Date: Wed,  4 Nov 2026 15:17:10 +0100
Message-ID: <20261104141713.355958-1-krystianmkaniewski@gmail.com>
X-Mailer: git-send-email 2.53.0
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

syzbot reported an RCU stall with a software taprio schedule made of a
single 127 ns entry. When advance_sched() falls behind, it replays every
missed entry inside the timer interrupt and the backlog only grows.
Patch 3 makes it continue from the entry in progress instead.

Patch 2 fixes a pre-existing wrap of the cycle-time-extension sum in the
software and txtime-assist paths. Patch 3 relies on it. Patch 1 prevents
a saturated extension from handing over to an admin schedule whose
software timestamps cannot be represented.

AI coding assistants helped with analysis, patch drafting and review.
The submitter reviewed the complete series and is responsible for it.

v3:
 - patch 2: split the cycle-time-extension overflow handling from patch 3
   as suggested by Vinicius, and use the same saturating helper in
   get_interval_end_time()
 - patch 3: return the cycle end from taprio_entry_at() and update
   cycle_end_time in advance_sched() (Vinicius)
 - patch 1: reword the range-check comment to describe only software
   timer timestamps (Vinicius)
 - all patches: add Acked-by from Vinicius, drop the obsolete
   Assisted-by trailers, and rebase onto current net/main
v2: https://lore.kernel.org/all/20261009123309.284193-1-krystianmkaniewski@gmail.com/
v1: https://lore.kernel.org/all/20261006113335.241564-1-krystianmkaniewski@gmail.com/

Krystian Kaniewski (3):
  net/sched: taprio: reject software schedules that overflow their
    timestamps
  net/sched: taprio: prevent cycle time extension overflow
  net/sched: taprio: do not replay missed entries in advance_sched()

 net/sched/sch_taprio.c | 191 ++++++++++++++++++++++++++++++++++++-----
 1 file changed, 168 insertions(+), 23 deletions(-)


base-commit: 241dec6f9ab74d8c3ef246764f3611666b96b9e1
-- 
2.53.0

