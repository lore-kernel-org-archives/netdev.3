Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792604292;
	b=Xf+3RLRKlSXgMrOFispuyesmfGCUMabfa08dokoTPDBz1bXv9hP+0ZgM0hwxKakioUc9
	 Lwy7H2qug3NE0hW9kY5fFfcDVPBdYAZ+pkXkjI6eNWP8JXae3lTDJnpv5Umg0ykk+Amii
	 b4T0DwgevcoThn0Ur+X//P2iZcsFIrRAdSrGPjz45MLsY5265RoMK1q+mJEml6F9aCwQQ
	 TsO5UIdEm6CnVxopNkx06WmRi+NdAl7C4ca1QkBz/IHiAQMxJuJ4yU2PJdSENJAY2Ht3r
	 56h2/W4IGWbZIimtXXBT1FZDop0q7oe9g8P+xQEt6BZu+4GGUguerrNKBbMA9lFyoKQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792604292;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=ZpL07KDDvB0JLojCSM2iYx41Asq0nHhWJ0VD/dVjgwU=;
	b=codC1a141cejIrVnQbjyxaAk060fkLfZpS8L+C4HrpEJ7O0c9hPlK3nOKjmaslpjXAyp
	 4yKEaM2rzHmx0GYVB9+wCh2codLqQtqkKpE3roBJGZu/5yeqx5ALVWN3jy5GkEYPSYS5x
	 1T7p04nGM4QxqrhguqE0WgQKCt5iBMTkrtu19WZiBa7SIdnI6F1s5Hx3kqUAeka6lqrBh
	 ZiNrRZK6yqDueosXPUzZ0JlCfQPCqBFjB+Oz78bWLNOEdlzNTP34GAMVSOYPok/9d/oF2
	 gWRL541HlQtRvTWMfZSUA5QiMpJzsdcMLysxHBRmma/poJCQlmfqUjOwVhe/LFQKj+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=mMiOgPrg;
	arc=none smtp.remote-ip=209.85.219.54
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D540606A31A
	for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 17:38:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2D540606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=mMiOgPrg
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-917a6dccc60so1203156d6.0
        for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 10:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1792604291; x=1793209091; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ZpL07KDDvB0JLojCSM2iYx41Asq0nHhWJ0VD/dVjgwU=;
        b=mMiOgPrgNzqKNXmYt8A83QEFWXZOMSxa18d4faFbG7kl3lGzDx/C71M0pWmnWIYuzg
         a7Zpc+eHncuWDIJKhjdz7xlpwBKCm8lXGEFOUio2lhgwW/pIL9sSGkHErWdyttr3f5eY
         wXSAKCMLO6SXGO/F8kNtreUlCIonTxXIyxoESqR4EGuLg3Sh9IwCu/gh+PGClITYNQHe
         sB05LRiQ3IYBrl8jlDVADHq04tWSHo4X2PTxCQ5BMPHomjDt9lkDAgkMbdGqNE3umb/a
         BeVC77pIT/PXcxLzhyj6oLfgdBHBJG4XtAXZawY9Ui9dxU8L2MX8H6W6NuquZPuLbiST
         cyhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792604291; x=1793209091;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=ZpL07KDDvB0JLojCSM2iYx41Asq0nHhWJ0VD/dVjgwU=;
        b=biUc0iTRfxzDVkGMkkfEy3XVxP0m3WMvEEw+xDc9AAS0bnIeR65OdS9a+VQ6anbkmV
         vfGb2/85EVNCTvEMVPGocLRGFNU7g1VTVladNgQTFtKWAq38RscNdpFyWBJ3LwL/9t2L
         bWzTtr2ILpsOdGQTCBQYnmkJmoh8i5AdbyTTU+oOw4Mnprx8aoBX4AEuCBxyQpFiP1pq
         5LwmCEBc9fHA8BVmOyUHsicDRZR/kKDkrU6UpA2N7uiiHUubwkKdpDiy65EYDyzIsVj9
         Oo4Idnek8QFP0a08KIt1hfz12iRkGjiZZaYiVOs4/9yFClLM8uCtm3Aw2fA73ceXPxKH
         n54w==
X-Gm-Message-State: AFq9FYJ/qFigMGx1YqPrciacjjii3C9fclYrKTAY7FyWgCqIFf3jbZsg
	8BD1LqTtJFBzXhePpL6bi2IVrcNmTeKCmH5//m8pnnotzXX0XA4Y4ixHTpWrD23LUag=
X-Gm-Gg: AYBFou0m/PgG2xrAY/dkk6RHvjxOJ299n76BVdGasTU5/Bugp7slltzMrAQlR5GJC65
	zzG3UcU2+LroitiBbAlQSkpyloBWV6gzBk+2VIWCOm4j7chMZN+6tXPxm+CV5KvqN3T3wloSVo8
	tjL8ayEq/xAl2c66rlcLbeBKJwp9cjP1vksJJ7e/9TKiYOP/CeaJThKe40bOTLVHKaU56GUsI7g
	3kqK5ohHyrDD8TivK7+Tp+1IXoOgrVYRO3/uJQ8A9Hx1ORhdt4MsoL92vsM+h2bdukf9fv+pdfM
	LHh/u97BTRk33hzZCBj7hCFcUmOHHFmAhVANcbnXF7R/e4rn9LmqvXueJ4ztYJFdtWG9cPdAeEd
	p0iFd3pxIfVt7EvHpMXZcGuJ1GQV9XQn0ojHMEWY5rEJyj4iz31UgJKq1gOWwXTIkiW0Iromtoe
	bSijdxzOyx3I3fWB3XYz0fEzBNBy0CogcLSh1uAu/eMEZktwuROdGu4udjVa1eYNB9rBZu2IlEl
	HeRU908i3cSJNhvbJKxYRjaMFAdtKcJ9zAygOg9oDm7WtSGgTz69iqufiJ4+LFFT5kB0XgmXipC
	JuGD7kVyBgav7iUN1Q==
X-Received: by 2002:ad4:5d6c:0:b0:914:40f4:d4b9 with SMTP id 6a1803df08f44-91c23247957mr871416d6.12.1792604290972;
        Wed, 21 Oct 2026 10:38:10 -0700 (PDT)
Received: from toxicpanda.com ([153.61.196.250])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91c18d79a36sm15125286d6.44.2026.10.21.10.38.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 10:38:07 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Date: Wed, 21 Oct 2026 17:37:24 +0000
Subject: [PATCH net] net/mlx5e: Fix stalled channels with threaded NAPI
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261021-b4-mlx5e-threaded-napi-stall-v1-1-d719c17b3ec4@toxicpanda.com>
X-B4-Tracking: v=1; b=H4sIAFP42GoC/3WNQQ7CIBBFr9LM2omFYEm8inExwCgYxAaoadL07
 oKuXb6Xn/c3KJwDFzgPG2R+hxJeqYE4DGA9pTtjcI1BjnISoxRoFD7jemKsPjM5dphoDlgqxYj
 ajSSU1ZNWDlpiznwL6zd/gcQVrj9ZFvNgW3u4zwwVRpMpWd9Vx+PfE9j3DzT0O9m2AAAA
X-Change-ID: 20261021-b4-mlx5e-threaded-napi-stall-7d0a14c7674d
To: Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, 
 Mark Bloch <mbloch@nvidia.com>, Leon Romanovsky <leon@kernel.org>, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: netdev@vger.kernel.org, linux-rdma@vger.kernel.org, 
 Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1792604274; l=3889;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=qElMGrxeAGeukURkquwi/PR2v1Qn9tNPTt6tEdR0tHI=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QC0vkVXx9j9CX12TOZHH20weU7r3Ab2olSeV8e7W0srpTDnyOKmO9p1mltiRKVxjHlIzAgkO0aH
 zT4FoaFoKKgQ=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

With threaded NAPI an mlx5e channel can stop receiving when a burst of
traffic ends. It stays dead for minutes on an idle machine, while the
connections hashed to it time out.

When mlx5e_napi_poll() has more to do, it checks that it runs on a CPU of
its interrupt's affinity mask. If it does not, it takes the affinity to
have been changed: it completes the NAPI after at most budget - 1 packets
and arms the CQs, so that the next interrupt moves the poll to the new CPU.

A NAPI thread runs wherever the scheduler puts it, so with threaded NAPI a
busy queue takes this path at nearly every poll. That costs an interrupt
for every 64 packets. Worse, it counts on an interrupt for the CQEs that
are still in the CQ when it is armed, and none comes: the next event is
raised by the next new completion. While packets keep arriving this goes
unnoticed. When a flood stops, what is in the CQ stays there, and is worked
off one poll of 64 packets per new arrival. If the RQ has run dry as well,
arrivals are dropped (rx_out_of_buffer) and bring no completion either.

Seen on a 50 Gbit/s port (firmware 22.47.1088) with 63 channels, threaded
NAPI and rx-usecs 64: a CPU-bound task bound to each of the 128 CPUs and
32 Gbit/s of UDP in 8 flows for 7 seconds, then both stopped. After the
second round one channel had 0 polls and 0 events for 150 seconds on an
idle machine, while TCP connections hashed to it timed out and
rx_out_of_buffer counted their SYNs. Later arrivals took it 16 polls and
1018 packets further, it stood still again for 14 seconds, and another 93
polls and 5917 packets emptied it. In a longer test 22 of 48 iperf3 runs
failed with "unable to connect stream: Connection timed out", with no ping
to the same address lost.

i40e and iavf force an interrupt at this point, and mlx5e does for XSK.
Doing that here would cure the stall and keep the interrupt per 64 packets.

Fix by going on polling when the NAPI is threaded. With that, 8 of 8
rounds leave every channel alive, ch_aff_change stays 0, rx_out_of_buffer
does not move once the flood is over, none of the 48 runs fails, and the
interrupts taken during the flood halve.

Fixes: 29863d41bb6e ("net: implement threaded-able napi poll loop support")
Assisted-by: LLM
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
I hit this while comparing threaded NAPI with softirq on two bare metal
machines.  The runs in the changelog are from a 7.3-rc5 based kernel, with
and without this change.  The patch applies to net unchanged, there I've
only compiled it.

I don't have the PRM, so "arming the CQ raises no event for the CQEs that
are already there" is what the counters showed and not something I checked
against the documentation.
---
 drivers/net/ethernet/mellanox/mlx5/core/en_txrx.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_txrx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_txrx.c
index 185105606469..3142e90e68ce 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_txrx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_txrx.c
@@ -207,7 +207,14 @@ int mlx5e_napi_poll(struct napi_struct *napi, int budget)
 				rq);
 
 	if (busy) {
-		if (likely(mlx5e_channel_no_affinity_change(c))) {
+		/* A NAPI thread runs where the scheduler puts it, which says
+		 * nothing about the affinity of the interrupt. Completing here
+		 * would leave the CQEs that are pending to the next interrupt,
+		 * and arming the CQs raises none for those, only for a new
+		 * completion.
+		 */
+		if (likely(mlx5e_channel_no_affinity_change(c)) ||
+		    test_bit(NAPI_STATE_THREADED, &napi->state)) {
 			work_done = budget;
 			goto out;
 		}

---
base-commit: abeacca61eea4f6803df4a595b656ea45c2d3249
change-id: 20261021-b4-mlx5e-threaded-napi-stall-7d0a14c7674d

