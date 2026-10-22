Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792682214;
	b=i1z5elNWBm8GLYMkaJe7hSybDhhUUNUckmgUdJ6UECjiL/oUqdnKcpLf3NqG4LGMSUnk
	 0CaXq2+tbhOxSNhjejbRGzZqy8pzsFIMoKiwN0K0Aiaq8ZxFFFhuhYkhOg75luXNuN0am
	 0f6PDkdDvj+So54ijCJnz1ZPB/mCxFPutCK7qQNtmsckK2knadlqmBY1ITQ1g9fax+Clh
	 JvJp6BiO/nz4IBaKAVhvs5QZd61NMbIGDa7QW8okILgw4T0dbziX4aCUDI0uAzV5jOS05
	 KOFAzsrQLSPGHJ1MjS5+QvYsf+ziYISPlVUClqed9Wo0/AVIurdg7rR4fh3c+jUgRxg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792682214;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer;
	bh=dOGTVagpmg3SkovNg8gY9NJcdR0snicKiJ3IvwwYIZg=;
	b=plXjYoYGehjSTrQ6P4q/+6A3LEGXqgn9KMwv3eamZdFasowanffwsUoSFDvLag5JGIXP
	 1gbvrhBbsqv0D89e7XSU8hVK4lM66WCLb6U0jODq+gtF7jWYaii1t4lg+HzAnANYQ7ZPu
	 nDY6k4dhfUoZ7xtzGpqbXsS9/9fK2x78MH+PPJeRlkJtsfyq1O7xFr/LrfBUEroilZ6as
	 JlVRIkVs81lKhKUQnJPH5FBYyeneNZKxxSJ0ryYVHSRVHyt6l41m+Ha3C8NwxEEcnAVWG
	 gVe5vj9ci6X6c+TiF9nuXxfD7eMtoHt+jj+ANUpGMjvf86Ya3Ex4drFtlhTOalztxjA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=gmBMmMgI;
	arc=none smtp.remote-ip=209.85.160.44
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77C07606B384
	for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 15:16:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 77C07606B384
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=gmBMmMgI
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-4911df1e196so980606fac.1
        for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 08:16:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792682213; x=1793287013; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dOGTVagpmg3SkovNg8gY9NJcdR0snicKiJ3IvwwYIZg=;
        b=gmBMmMgIv4ChXTLyXqT937GGjYbZfczKHrXmdNzdGzgWcCdX672S2Av+RP7IvBbpoW
         P+oSJBLvyK7sqC/Wj4736VDoy4ySLsvfgnQ5Oo4la5n5Ox/E9GPWxTYc9TfKoBVg/AnS
         e06cNuJW9GME9Cnb53Imly4VcE9Huc+iC1a0MkyGZSJli0EzifEs1b0yDCDcc1UydBbr
         6QEsdEFCVS55JVEDjgO/ZH0M7TYCOw5ZDAQuvwzbKkF4ExYHuJ6ee30qmP/0Vn0eT1mT
         3xHAQio+la6q2KCYUDiwb4JwHrlgbgtZN1DEXXafy5A47BcPQM8AHr76vIdtX+CpKS/f
         z+Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792682213; x=1793287013;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dOGTVagpmg3SkovNg8gY9NJcdR0snicKiJ3IvwwYIZg=;
        b=rk3n1L/+MPRHrYoVZvd5JyvNxKI96xUwlcFvtCWirHy93wOt04qoD6iDjJxCUURSMh
         7Go9s4nvAdj1YRiDtG7RlBSjglbK2Ph7eTd71YdQf1i22y1bYoQYivcqHllpRIlVpCVN
         6Wzhql7IHHxNoRy2BBwj76crxWeg3pVq1h99ZQRznyQzWVazVZl9kLAuyIXhePzjMUxR
         tIFVjHI5FXhBfdw6wXL9DURVAKQK5Cg79q0OaLlvBVPXec7NJWEW3eGPZhlIG1AjWiz8
         VTubVjdWrJGgDzIsUj+w/NjDs0O2729UXpimP38q4UUBIDW/jc8NG9ZNtuqdnKeIuXod
         idBA==
X-Gm-Message-State: AFq9FYIh0lxoRII3e0JYcYKbA8SW2Je3OlS3CgdZoAYbQdTHKF9d7aN3
	ije5xPqAa0yEqO7ea5rVHZbuwJzMjZtE4aRisJ1HA0amdSd+odyHqtdC
X-Gm-Gg: AYBFou2Al2rm34FuJuX+4iAliuxeVeOiEk5yujHfFrowwzcWRyUPbGQDbw5Asngv7zX
	93wHa1aQ5PbuqOiAdDvoFVAwjHxGgiSFPjWq968bI+9Qzs6hm/8wDcamY90IszFXUHG3Nx775GQ
	8o5CIHV31rE8or3cQCNMk4C7DB9YKz3lQ1NJnPxnZLOP48cx3D/9JEk0WHYnz4xjW+v6TYBYZGW
	Yx5a+bN94cL8fq4K5srimgHwuRQmydTtkDNOLg05v0GIP37nzSrmZjykHAhPL8L9dkb1PzLak1n
	2MYn8eVz5sXSBXgHBaxcZNBsQoMUKzfpDN5Og9cq1x6UGH5OEZeHovmxnILdq5IZ+q+m5msxRUI
	eCOSroZe8RGKUcuPjoU814BxTbWXPGSs4lLrckDfUbfJUSK/HvrGYCMkxwuiED5hNWXEntNqLyv
	oLIBGFSHiLyHHJ2hyTvxJ9CYXUXagUZscD0t0JygBadJHmUqK8tsfeGn5+XEGpvn3/Pu9sG5jUU
	fApdNCaXAbmXXA5l9DhqTqOiGD2/Lb7/YR4v6TNQ9y1EQZPLAqqfD2RUeUZ8YcR9tjuNWdpMtLz
	H+FnK7Iz6p2jDqTcVEhUZpvkRYcn3oYkLgADQE8/DBJM9pcULqMkBeH8DyyjpiuaM8FGtoQSZzG
	J0S2De/p4igM1rwpH40pBWzapD9SzQBlCwMeUHsXWYtZcatGW73JKD552WYYqAntnbImlvGb439
	klPZu8
X-Received: by 2002:a05:6871:78c:b0:447:1ceb:7cc6 with SMTP id 586e51a60fabf-4a7dc1b02bemr3328201fac.15.1792682213322;
        Thu, 22 Oct 2026 08:16:53 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4a7d5eb8fc0sm4685631fac.1.2026.10.22.08.16.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 08:16:49 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Thu, 22 Oct 2026 09:16:42 -0600
Subject: [PATCH net v5 2/5] ptp: unwind partially completed virtual clock
 creation
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
Message-Id: <20261022-ptp-vclock-sampling-v5-2-06ceace17bac@gmail.com>
References: <20261022-ptp-vclock-sampling-v5-0-06ceace17bac@gmail.com>
In-Reply-To: <20261022-ptp-vclock-sampling-v5-0-06ceace17bac@gmail.com>
To: netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, Yangbo Lu <yangbo.lu@nxp.com>, 
 Miroslav Lichvar <mlichvar@redhat.com>
Cc: Eric Dumazet <edumazet@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org, 
 Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
 James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.15.2

n_vclocks_store() publishes the new clock count only after every child
has been registered. If a later registration fails, it returns without
unregistering the children already created by that request. Those clocks
are left out of n_vclocks, and a subsequent request can overwrite their
index entries without removing them.

Unregister the newly created children in reverse order and clear their
index entries on failure. Leave the previously installed clocks and
their count unchanged. The n_vclocks mutex serializes this rollback with
other sysfs changes, and parent removal drains the store before walking
the children.

This was found by code inspection while adding initial PHC sample error
handling to virtual clock registration.

Fixes: 73f37068d540 ("ptp: support ptp physical/virtual clocks conversion")
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/ptp/ptp_sysfs.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/ptp/ptp_sysfs.c b/drivers/ptp/ptp_sysfs.c
index 53388b123198..fabc1c9b1752 100644
--- a/drivers/ptp/ptp_sysfs.c
+++ b/drivers/ptp/ptp_sysfs.c
@@ -225,7 +225,7 @@ static ssize_t n_vclocks_store(struct device *dev,
 		for (i = 0; i < num - ptp->n_vclocks; i++) {
 			vclock = ptp_vclock_register(ptp);
 			if (!vclock)
-				goto out;
+				goto err_register;
 
 			*(ptp->vclock_index + ptp->n_vclocks + i) =
 				vclock->clock->index;
@@ -257,6 +257,12 @@ static ssize_t n_vclocks_store(struct device *dev,
 	mutex_unlock(&ptp->n_vclocks_mux);
 
 	return count;
+err_register:
+	num = i;
+	if (num)
+		device_for_each_child_reverse(dev, &num, unregister_vclock);
+	for (num = 0; num < i; num++)
+		ptp->vclock_index[ptp->n_vclocks + num] = -1;
 out:
 	mutex_unlock(&ptp->n_vclocks_mux);
 	return err;

-- 
2.53.0

