Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.44
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793288021;
	b=xgM5OraE4uIGIhuM9KooaUUf1vh2EX9cOCJPWxTjea1XShMF5s6pzYRBiS4KVH84s/sL
	 bXD2pML3n2IxTY9RZVWY1GAqyt5VK8fVfS5gcNQqVMC8AyYm+uKU4m5lwzkJzkUP7dGnG
	 Qlm5hcQk5c6JWjTBHjeoDKo6h99wvw5nl0L7mRgT33HS4Dc0/2rqpNNpSfq1WWs6JdXbQ
	 W4DC14Sa59EtgXG9qdwKhCir5DfczWMv+Z+tyilYryg9+C/S7Gz8t3KBdkG0Jp5FzfBPJ
	 mq/6BEPzRwVANceiRsqx7CC22VG6vVphRZPMgCWf5bAuDVDOqZC2yHMkelEOsL+Ltpg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793288021;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=qnsOQOH+MJS4dgeIIgkZpo0rIQQtq+mlOBdV2ECKIcs=;
	b=A9ZTIPXUgp6/oVkQzb+VOszLuenZDz7i7zuZqTC3Fe1qayVhMxJNktfPUfK8LibbS6la
	 V/7iarlWd2xV3HYLixoDzU/KBS8G19hwMjzedHWIiwhZxkcWSuUdquNBnmhmsWmo8i9te
	 u0wL9uv8sucb5V7u7VEJHmTzMUzTtFfXnui2R+qNdKKKcpkKNM63FZ5NsTBPxCl9WL6uG
	 aouLGy8aeXmx/oitP5HhnZ034+iLI9HnW4ctVQbyr2Fu8/lCxc0B8aMwN7WPAS/QhiQTJ
	 wZH30iK7pMS6NLi4OEpTEt2XN0p4DRY77roTGp/btIIkOvNiQHpsY+4d9pG173NqaFQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DU2MrwIA;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.44
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64581606A31D
	for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 15:33:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 64581606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DU2MrwIA
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-48c45111bebso1086705f8f.0
        for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 08:33:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793288020; cv=none;
        d=google.com; s=arc-20260327;
        b=HUS9CJniitxLNT4EzEx3r8mbLxrj+ZZU34IQAAu0JvpamGyj6W8wvexYxm09ABzdq7
         e3JIteWceyJHNrXJu3vGxXEaBPU21ZCnPfHbP31eWyIvR4xC4Dbffg5u97Dy++J5fBiR
         0fNAioR3tCNvwt55DUMCU134aAiik0/0yOeEXBxq3h3LZ5ekwp7x73tW9jw5cpl0pZqo
         G/R0bGUXfmctBDX1UBoKJU8wOhQXDOVylfbhEwUovOc2izV5GSuxzv54iTb+mTgZdk1W
         ArxeQacUL9YSMZFA/9fHPREKn2vxi4lJfzKC179tRTvbPJjimIDobDJ+biGE0kMjVDjC
         U/rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qnsOQOH+MJS4dgeIIgkZpo0rIQQtq+mlOBdV2ECKIcs=;
        fh=sv6dzx/OIk7BpYXa0WnuZFJcwMoDm1KsoaTzLkpWbMs=;
        b=RIQyn8MajmjYw2NAzmyderhA2hVPY0FvbcqJ+N2uEqHpgwljtAMffHq1G1DzKzOqNJ
         R95ib79PYInzsnSf8GKnZyr4j1CpZdGVambRnlA1Jrq80znG177Pk4iK9RNZab6qcyPG
         SRbU11hyUk3mPHAczXg2NnV9lDvHCiJmOL1E/ppgoLMhRLFyGTxE5UACso52Q0e4aiJx
         WbHSrLU+NBxWHLyWKQ+xjfnJ+pUN5uoDSjhVjhewWqCephaJgxwbt0pb7PaE0vi6wgmJ
         91a14jK89mXu/3D9sMYop+fghTJ+1J4BFR8RvYgRKKhrueOZFLRRudYotOPLS6j45her
         FOXw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793288020; x=1793892820; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qnsOQOH+MJS4dgeIIgkZpo0rIQQtq+mlOBdV2ECKIcs=;
        b=DU2MrwIABYt/QrdlPzXpAbHNPqL/qnAOu2OgJtbT+jAs8WSu7Njpo/WS5kMmyHXyDt
         qDENUwJLwgV35cLiSsaA3ktDFs5yj4ZIfUsq1cj80C1OspjwpPDCXVmoo0jfbvE4iomK
         ltG1MakzYajnDCQIuFWtQWu9XGBIKp8eRAQFLi4W6TJ9qMH3HbKJD7LHsrVbcedUVsWO
         zpgwkpYxIbkvvUPdN/TcVUDamq6Dz/9g3yJQPFErTtwVc7Xdt99+MaFoByTcx5j+tmOR
         MhI9LlIOl08HFr+6pLT67osqTSSeO4r0Sp3KeeoMKGIwB+IFeH0yscDXGhbEWPYOhadI
         md7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793288020; x=1793892820;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qnsOQOH+MJS4dgeIIgkZpo0rIQQtq+mlOBdV2ECKIcs=;
        b=aCBl/JHlVMjYuWRqMwzmC/a14m1qdHyOLJbukWlmoB4HlnG6lkonmtvGdCmPPECPu+
         wrctL3tdkAOFNiAdpLaPZs+Y7V1P0QOVZtbx4OJyASo+YHNa9xMdccMpPo2iahlnMBYW
         KYOcLtX8M0ng3eEKYO9WDB1g7BXZkIQoAFf6vdTAdA47LNeCRKZq0JofJYYzanPGkuVQ
         VoH6H5BuZ3yOqp912cTUZ7iQdZ1mtaxkaoHe7Uiekd/ZO4XZo5q+1qzMp7rkpH0m0+IU
         eMK/zpKgRZPmXbwCcHlLiAyjO9yYHDwlMKwOPEM1lQuhK59tXtUMLwq4Fkz5wxD/+Swg
         Ht0Q==
X-Gm-Message-State: AFq9FYIgkpdb8DH4Gt2bDFPL93ZD3pTu5R5/mzja2kN1q3ue4W1HYLYr
	VPC/VmJr/tYDeO8ZfWe8kVhct2UORWGjD1Zr5smm5j0P2U+a4u3+1vMxhZEukNNp4iZuxnIt3FQ
	q1Ze4HOefYpKO6pLHWKarXjLOrY5MmJ8=
X-Gm-Gg: AYBFou3r8G/rwanR5S34IIsvhvkPP5NYDalEVNMdxmofRcJrJozummiL1okWZO6UCKZ
	zgBPnY1Isv9uRJWXyhtWCe85ogA5P0s8Gb9qnMHxMaVPTBAcCQEfbi+8J3DqbBqrWhOfhYAN6Bh
	HC9Rtu1/f+UjNg3tLDe68Kl6ZPdsfTgROtKL8ID5OnRUXk/5Gx0Ar1cNA/nLeoDkA46I4hBvyX3
	DG0zGwivCCSCLiZGKZIYkTiM/CahSq2tPbVWNbBnpVsuG3dKBBAmh+4a4jgZWCIP1JD0AnPiTb5
	2MLuEuaz8vPynnBRUDsUGi24CkHmV2u2mcBbw1RX3nyWZrT7nhlfQLloh3vqTCbWhlADfmLH1Zr
	JKY91X3zTPpWZ9Kpp8DlGCGvh/EwCNawBXH7r6pKlXqnp6TEEPmA0nldw0foOlDbn1U+ww7HNhk
	+FBMflTH8ECo5opdE8xPWM
X-Received: by 2002:a5d:5e08:0:b0:48d:f53e:6000 with SMTP id
 ffacd0b85a97d-48e5d3187f0mr13862431f8f.56.1793288019566; Thu, 29 Oct 2026
 08:33:39 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <179322311834.40667.5383039334126572422.stgit@ahduyck-xeon-server.home.arpa>
 <179322372169.3327.17262999729300923799@kernel.org>
In-Reply-To: <179322372169.3327.17262999729300923799@kernel.org>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Thu, 29 Oct 2026 08:33:02 -0700
X-Gm-Features: AclHuK8p72sjoXc6gkma4PdxPHY4hqA8uhAe3oLx16EaTVoSgPtb5LVArBSD1Do
Message-ID: <CAKgT0Udib6rwF5AeLtrv4eA3i6c3gPGTayEh29UnN1dU5nOjGw@mail.gmail.com>
Subject: Re: [net PATCH 00/13] fbnic: Fix BMC filter, FW crash restore,
 teardown and Tx flush bugs
To: netdev-bot+sinfo@kernel.org
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, horms@kernel.org, kernel-team@meta.com, kuba@kernel.org, 
	pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 28, 2026 at 2:42=E2=80=AFPM <netdev-bot+sinfo@kernel.org> wrote=
:
>
> Hi!
>
> This is an automated message. This series looks like a fix, but its
> commit messages seem to be missing some information:
>
>  - Whether the issue was actually triggered, or is only theoretical
>    (e.g. found by code inspection). If it was triggered please include
>    the symptoms, like the stack trace or error messages.
>
>  - What hardware the change was tested on. For driver fixes please
>    mention the device (and if relevant firmware version) used for
>    testing, or say that the change was not tested on real hardware.
>
> Please do not repost the series just to address the above. Instead,
> reply to this email with the missing information, so that reviewers
> can take it into account. If the series needs another revision for
> other reasons, please include the information in the commit messages
> then.

Patches 1-10 were found by code inspection while reviewing
d261a371e3b7 ("fbnic: Rework the BMC state pulled from the
capabilities message") and db99b6fae21c ("fbnic: Remove BMC routing
rules when the BMC channel is disabled"). They were not triggered in
practice.

Patches 11 and 12 come from a hang we hit on hardware. A test loop
injects a PCIe error, which triggers DPC containment and driver
recovery, while timestamped Tx traffic is running. Over many
iterations the device's PTP in-flight counter climbed until the PTP
request FIFO filled. After that, Tx timestamp requests never completed.
There was no kernel splat; the symptom is the stuck counter and Tx
timestamping stopping. With both patches applied the hang has not
reproduced in over 10,000 iterations of the same loop.

Patch 13 was found by inspection. It targets the "Tx timestamp without
matching packet" message from fbnic_clean_tsq(). We do see that
message on hardware after the recovery cycles above, but we have not
seen the Tx force-flush path it changes actually run, and the message
still shows up with the patch applied. So this fixes a real gap in the
flush, but it is not the whole story for that message.

Testing: the full series was run on an fbnic NIC with a BMC attached
(firmware 26.09.14-017_h7ab84d2ef68f), using the recovery loop above.
It was also tested in QEMU, using an emulated fbnic paired with a
second QEMU instance running the device firmware. That covered link
bring-up, BMC NC-SI channel enable, disable and re-enable, and a
reproducer for the multicast table exhaustion case handled in patch 8.
