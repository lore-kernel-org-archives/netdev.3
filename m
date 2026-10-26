Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793038298;
	b=dTfACmQkGfCRKRy0aeHGDkq9imE/82NmuzX5fHdrwregxgZdJtyEIov8kzmpOTO7CHbj
	 tCmgdLgNHD2F8sVmC1uDc3g/+RBkz90qxL/srKLbqC5hX8GSsuyQ6oBvjQcSn0OI+8Nsp
	 9GY50eTx3HVrmWnPDduOXLbtlyjgjNXhnsG8E9a37n4f+h8ejlHHhwirUHCzII65nOTwg
	 y0PFQw4YQevOv9xQJNGK9B/axP9uBo8XYBkGyPaFRpBpdmnxeSJkr9IwIW4AkGm4nZmLk
	 NGi3uIuJxN3yfe1Xuof5YNvq/g+T2phJ6MFQMUlWlLY5klnWlgu5A4LP9W4VOxfVTqw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793038298;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer;
	bh=dOGTVagpmg3SkovNg8gY9NJcdR0snicKiJ3IvwwYIZg=;
	b=ZRx9+IGaemrViIshNcurEQ3NMn+ihK1t++73BrTTdDsq8f4tk6uviM6PgRmTqQ+REsRQ
	 8DMqE9v1QEmNnQbxSKx+ljOXtvWta3UlXrXS2YEYMPKej+0Z3aQdTzS6EsuqsHfFds+j1
	 P6PkwTUiteaoHgK7n2wjfR3o8rOHGAxarJ6Ge11M0o+HhvTKo++USQ1zXVYqq924BSskQ
	 h6W9EO7VP9np9SZYR3ZXcLo+hk1ygHKEHJyKicLuPhnw1bfC37e5bNqirY2hNdSt9MZ2I
	 sll1Oh9gzSlUWgydLKKw3+NG1Op+K+eTtP61DKosl7waGTL6GA7vCQsSbD1dgbh8IXQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=cmObIIJ1;
	arc=none smtp.remote-ip=209.85.160.41
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E3B606A31D
	for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 18:11:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 97E3B606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=cmObIIJ1
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-48e94879f02so975146fac.0
        for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 11:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793038296; x=1793643096; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dOGTVagpmg3SkovNg8gY9NJcdR0snicKiJ3IvwwYIZg=;
        b=cmObIIJ1y5lLS+rOt1FJahAjY3FkSDXqyLEj08rkBVk/02Lg2RpA+LIB9s5doTjHP7
         sQ0accUQzwFFmiVjen6O89mfmJoBKgdr5jOUzqUS37vQBsT2j+HL9mRSX4Uean7WWMEm
         8oeNd6pUtZOdcnPMGxqIFfIesEX2xSIxnA96WxIIaS0Mw5+E+57V1N/aE/m+9bvkRK5/
         Webx4FIxOSHvthzyLx3P4Qt50w1GC8oiRoIW4U0ntfaBffBDret6RFfQa0wiacSy40Th
         X6jAScYzXyjLD0KYGrmympQ2WFiyw9E7vGI6ZnFhuPp2NfJe58rkhi9eSYOyspkhOOUz
         9rQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793038296; x=1793643096;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dOGTVagpmg3SkovNg8gY9NJcdR0snicKiJ3IvwwYIZg=;
        b=pPPsFy+jpfNd1IOLK0oeLZsIccE6UUWIHXaJdXmKoJY/3NyvMAT6H2eG+3EYboszQZ
         /8vWnYGNsaOEzNWITZjviKTYBoSBbfmqifaDGabTdKdCgJIXhG1Kzd+faZxhmfEW9c9G
         80Pu1yt6ftkJ4I1nDTO55kN6ukuyMUmFnAtvSYemdACNOi5wdAwo2ftR+i7O/YutyQB1
         ZnmmYmr+CKgab6r1FkgUusl7zU0MnKRZdleWAbqP6cATeSMbNFtU/ORE2kEp20YK2AzV
         G6eBCgKrszFxYl22YctKz2zun8qhRaUxqvfPYwG+QzNkqhf3yVK2SKZMLJc5R2LMCmVY
         WeqA==
X-Gm-Message-State: AFq9FYJjEkZ/ubOSIi1V+Eu9feRShfijSnAaXYIvYcpujK1AWAm7Q9Rb
	eW4BnAANJPMNlsTt95QPZyWgirlTrWai4xuJkA/o67ZG+p+Iopbu4+bU
X-Gm-Gg: AYBFou35nLIB0WWlKc/XmCxiz8ac0orPDQy4CiuC04vN8DgdLAaR6cN0KGLQA+AoySZ
	qjFmq9qQ9BXXunU9Tqqkn7/3bdA/sWNRhS7vXqSpTg6TAUM5d5ZntkW0B4Y96Z2VPLxzj2Ge1GA
	6jeJLEmp6VsYljzX0qROpDc+vbhlnKvGY9gl/ltQSgmmkLRIoiSBoaL84Ko2QCMtmYIaCclKyDS
	t1T9cf0RAMPwqG2ZsjlOg4SJKB5RCzgwVaTRUOR9Qf04OyjHSlVcIybfr3mYijbBQkHvUh9TVvZ
	pC0O1BDFjlyECmP7l8ZbHdBsgfU0SDskzUw6QnCKtIMfzOPF80jc+2q5kIu7HHbcqX9FK662RhB
	m078K16clQOWYzXSo9C/9aE4XUPIg6vRAlL3vNze8Bcwa1MP0DxaoQV1KUSS7JW7hVgP+8PZs+X
	2JZ+3yZ2dsl0eQL0vx4zgPYtt/BgFWHb0JQfd29CTMzE774zA+Cfi9SRim994GK1igo5tXX8tBr
	LI3zIWUFIZtYtuAnpiiYZFVioqOiv1IBkzl7bVd4CQv5O0FT5CiFwKSgFGPeXcN8OfeH0eto2yb
	6IGUijM2kqa5lETJy727uhJdE04953ug+keUwRstctqHALt2InsaFcZgdwiV3JO+BG4amAN4jKw
	fOWOos/h5/DSEuHxZjTppK84Y+D2z3/OCfjlC6pvZ/CRwwOEblYOknGqTrQ5pKaFzxG2TV0EyTJ
	zhoPCedECkerYopBfJZMfj8kegDvcx3s7IuIH79YfTXMpwPathz3o=
X-Received: by 2002:a05:6808:19a5:b0:4d6:90f3:74b1 with SMTP id 5614622812f47-55c003aceacmr5817075b6e.49.1793038296382;
        Mon, 26 Oct 2026 11:11:36 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-55c043115bcsm5795251b6e.15.2026.10.26.11.11.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 11:11:35 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Mon, 26 Oct 2026 12:11:28 -0600
Subject: [PATCH net v6 2/5] ptp: unwind partially completed virtual clock
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
Message-Id: <20261026-ptp-vclock-sampling-v6-2-e705612541f1@gmail.com>
References: <20261026-ptp-vclock-sampling-v6-0-e705612541f1@gmail.com>
In-Reply-To: <20261026-ptp-vclock-sampling-v6-0-e705612541f1@gmail.com>
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

