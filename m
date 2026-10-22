Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792660626;
	b=0h3fGPIKWZPsX8jw1pyAHQn/gE/HaU26I5HL4yPWJ3yts5WhaP+YOs5F5mBw5PuA30c7
	 iP+PYqFoviIuiBk/AYwpoC1VnyWu+ibEQiF4ShULWDtrvf8ZSjymVJD5CP/Fx8bIpTspK
	 sBTGV50esy6vcyG+S5ESApKEgnNHe9+uEpvVIG5HSnAta35GiWEkaXF4T+Y+olgn9eFNY
	 O0MTSwjwjZNqmqUwxxtnnfKgYaHD996NfdHKqVYHD/x1SKB0fZxOE4w8IcppQpGlhE4XM
	 nQZrBDly7syX1cPnkHpliqkGC7UN+++v7tgs3dMI6KLarqfSXaV81i+fQkwD0kX9X7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792660626;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=74Vw0j5rE4cQu4U2NNcGbj29GdZNeea1qUhNAa2u8VA=;
	b=XqbHIKtfOks7urSNyaacKFKRDURo17J8TYeOWdZm5t3VxXvTEl0IIzSMgf3HLUUQtB9H
	 VAm4JAae+1CIHrGkVV65q3RpImwFzG3DheE1IApjSJMfIQffzWkHDonYjTsAMSCF4hfAG
	 XwFcSLPuI3jX2DUm4cimHJQX0xwaVKFAvH75s+yBm0BFL8cV2OYRtqEft1O0nMMJQX410
	 nqRuz0wrU7sayL/RDvkc3d+PzB3V+Haj8r7JvUWmT88zxQlhlcILE0q3OuLBZWQpBACUt
	 ttVSSmRY8g7hSs3UJuhMkS2jjhRfznLauCOTNgAVIl/Sn3tB3lVygcQREwL8YZ95jaw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=hBhy5ypY;
	arc=none smtp.remote-ip=74.125.82.179
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C22B7606A31E
	for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 09:17:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C22B7606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=hBhy5ypY
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-35943f55c06so916696eec.0
        for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 02:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792660620; x=1793265420; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=74Vw0j5rE4cQu4U2NNcGbj29GdZNeea1qUhNAa2u8VA=;
        b=hBhy5ypYXncRiYmIbapRlcQE46DIqBPNYMXjj0YperJhiElOGSByawpFQkZOhrd7ZF
         raidv5wjumP0e+/xF4C8bKZMhpNOKrzmgJIThRFLCzjxuNiW00QPwAvaOC9ISYsNS9uH
         wef0d8VmA/Adb3Oz3F5S6EwsxwXPxemesi7Ni4pMdinKMOdZhmXh8c9u7EV3Equ0qz7c
         ey2HLceyg8SmILm64uEFz6DdoAAiggL9yJz5RlNSoGX2IebOli46rAstSdLDm/bwhi1K
         JE1KuJQtwDh40tlsY8ZlERp8KTqHrlU9d4oyvcEoFbXnow72bOPtpW8JzihTBqwy4xqt
         FF0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792660620; x=1793265420;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=74Vw0j5rE4cQu4U2NNcGbj29GdZNeea1qUhNAa2u8VA=;
        b=tCazHbQaWd9wEKnvWBiUb4cO7vtkEfsNgF4NaSxR4f4O8Sm4vyLFm0fzvS2RA42vL5
         M6Sr5DI54Dzs5HGA1QSy0sPTJtk0wMDdKTqtqSnUcKSzwx9QsR881anK6Q+3kKpJo8zk
         V5TOVldAm4i8Nb8teHr4edoAkAjw2P5AjDisW1JqcND4xA/wvkdyNKmPoriP4OcXFDPQ
         yguIyHJRf3t1qw/4Yde30ALaJDJuoQkyg5Ok8TdAH+d8l8u6CqOzQ2B/f3MmpwbuZBy9
         RNMd6CPrGleM9x/B1fNZInRW1OIVqM/T86eO1VnC9sns8ZrP9AtYw5KThVOTRmDI9ihR
         f4Rg==
X-Forwarded-Encrypted: i=1; AKwUvByejKMzyipGLOHUoxSCMgoqjSub+lHgryQEMdEyR93ZV3nLIbDDP8nNf/6bc6Klu0oCfHm9nqc=@vger.kernel.org
X-Gm-Message-State: AFq9FYLwPK4I8gYb/CR8hHtLBGl4P7Faf12hdpZ4lsr9coD1k97/MkvQ
	ih5I6vMspR+oQwjc6X1kLrvCi0QwcI+/kJezIeK7J9xqUN97mQVlnhZ7
X-Gm-Gg: AYBFou0utRbgUqIspK7e6ijj9uh7IYP3zyBn9dFOuuNNj6/2PYbfqOJ1QVQZcETPk+b
	BSIxvY3ZevR1sNDCnsr75IIm5oO/B0rWQ+0Gz/SwWL8FrG6W8zM9xTjm2w8gj4ICppA1MDbEc8P
	KweOBp+4F8TAwBfgeZ72FpAEdkuj2r9FgobjtgRQNQfgfbMpWm/9B3em5vFUdKWWk6X36VIW1S5
	SJo0JvkG0t0jGKkZFIUC6OprvclN78BpFWT/kYmk+a5ElZTyGODWvsmFTak6cCCZWGuB9u2F8Ru
	MMv9RT1X6Xui7Hkx+oT+Mg7bY0QqwnTyYtJEf9gAkdw095p6f7v4KBYnW4X7nWxauumoDZ+slGh
	rr48nlXIJO9a51TUIu49XlPIBwbJHyQurPI8xHjhvIKVrnxcmGFj0r+LcFOSc749h1jyVYpJZmB
	h8N3+skJ4MYbmtO36kjyAu6HRIvNv8k6DCcIXGtGBrytd+idr5K5xXKMNs+Mnr4gxR5rG/Bncgs
	4EomZM8BpvJgXJROuVQMo4v41FZqrqSJXb5NiRCqhb8qAL9ba/0gAOeQ0UrvOC44j+3WjbXZd+h
	UVK/13lerIWg6+RKLac=
X-Received: by 2002:a05:7301:7e17:b0:366:6c79:212b with SMTP id 5a478bee46e88-368b122ff22mr2280564eec.25.1792660619861;
        Thu, 22 Oct 2026 02:16:59 -0700 (PDT)
Received: from youngkk-vm.localdomain (67.216.200.102.16clouds.com. [67.216.200.102])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36740cc8439sm15295791eec.11.2026.10.22.02.16.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 02:16:59 -0700 (PDT)
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
Subject: [BUG] net: bridge: CFM CCM transmission state races with delayed work
Date: Thu, 22 Oct 2026 02:16:53 -0700
Message-Id: <20261022091653.3652341-1-teel4res@gmail.com>
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

br_cfm_cc_ccm_tx() and ccm_tx_work_expired() mutate
mep->ccm_tx_end and mep->cc_ccm_tx_info.period without a common lock.
The start path also queues ccm_tx_dwork before saving the new
cc_ccm_tx_info.

One reachable interleaving is:

  writer: store ccm_tx_end
  writer: queue ccm_tx_dwork
  worker: observe an expired end, store period = 0, do not requeue
  writer: store the requested nonzero period

The final state reports an active nonzero CCM period, but no delayed
work remains and no CCM frames are sent.  The keep-alive branch has the
mirror interleaving: it can update ccm_tx_end and return success while
the worker subsequently clears period and stops transmitting.

Observed on Linux v7.3, commit
08ab31164c55f20c7a2653de3186ae333470e2c1.  A self-checking userspace
program exercised the start-path ordering and found six phantom states
in 384 attempts:

  start_period=67108864
  probe_period=12738873
  two readbacks remained 12738873
  keepalive returned success
  final period remained 12738873 with no pending work

Four independent snapshot-VM boots produced 98 explicit confirmations
in total.  KASAN and UBSAN were clean, as expected for a control-plane
liveness defect.  The target lacked KCSAN, so the report does not rely
on a KCSAN warning: the queue-before-save ordering is directly visible
in source and the inconsistent externally visible state was observed.

The worker and configuration path need serialization, and the new CCM
state should be stored before the delayed work can execute.

This is distinct from candidate BR-038, which reports the 32-bit period
conversion overflow in the same state fields; that arithmetic bug needs
a separate fix.

I found no matching upstream fix or CVE.

The self-contained reproducer and complete logs are available on
request.

This was found with a multi-agent workflow; the state
mismatch was reproduced in QEMU.

Thanks,
Cheng Yongkang
