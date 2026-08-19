Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FC9C3C3F71
	for <netdev@vger.kernel.org>; Wed, 19 Aug 2026 07:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787123214; cv=none; b=mOsTO/KpjrMxhh7mnKqSZW87rGQBVJsqnXFMAPPKsViH8LqaT1IihC5ZkkDL06EGS9Ii9xo01O7duiGGTPpVGgssT8GFZtBU/Hml3OOk9xln2PAxmHAz8QglnYVjYXsT/lAfy4TC62dQlQoJt02XfdqUW5G5ZMfr1Jw4+bPXrD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787123214; c=relaxed/simple;
	bh=t6oA0CEUigEp4+DNMmz4I3c0QDk3FhY9QHOgO0NLVQU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=TbCK1dKam5uFQSvs0spABGYJ2HN/tIw2CtVmENEZ0BZgzCSMrgZY5Y3NUctOHDYayGsEClfTF3wtXbS9iDK1s4HqjXMsobIhPCLZiCaKSIUfoAsu/ejpJN3aUDV8loHedweOYi5Sz5d2JmyKL4ae9ioGSbl2lNkp/PF0glWTL9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EdQcWTxK; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EdQcWTxK"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-493b966dd74so4218235e9.3
        for <netdev@vger.kernel.org>; Wed, 19 Aug 2026 00:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787123211; x=1787728011; darn=vger.kernel.org;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8GEPs1ElgBUjpIc6eAx+Z9OaSFbd0gNvPTGdbgW9h+I=;
        b=EdQcWTxKv8l1F2VOCmQ5XsuuAtdSP2CyfTyJtXuIcbydNndyV0Svv0cUECJzoIC/ts
         Imjfa2MmsfaG5jdpVP1/lZ8Uo0Iwv2O+7GrbaGySh27QBsCxTZqTwsyVhedmABkwWS2G
         B4Ldc3+Pm6weLjHMmN8SnSB1608dI/cHHaHvxRDcMiEN7UhXj1KdX4UfWiASxfkMxJLh
         2lt0q1/0RmeoDrHNzAr65TijI/5Fv6WkiXv5mTr8k2hzstIZQuJZiOJsgXqeEVgoCbqs
         H54Zq+mtctIt/dQYuknULWutqbOAbquSbNKQJje7RmFZonui4/JuA15sBpivyWAKjLLx
         /umg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787123211; x=1787728011;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8GEPs1ElgBUjpIc6eAx+Z9OaSFbd0gNvPTGdbgW9h+I=;
        b=qZCrqhPtnm0JYE38zol0lH7z4oh90t+MSm1NX7aEAmUCZ+OlBlwMJrg8UQIU5kNUh8
         klEuUg/QgfAJcgBRS9BDeS1jEzY1KHZX2+NYZPYBct37f7tynw129Mfdi+5k+R09iYmu
         2lpOzTnZMrPvDCqEzM4lEeQIYrFPOtVRSNHsnNxJ6K5199YN2N1LqEZs9i/BmPsWIv80
         Ahlr1NfpOcu4sBVwOEWtfvkld95QY7cbUvRBoLMDJkbk6gpUIxMrj4teSAEB6q37MXhc
         hm79Rn6UGUTYXX9i+w/U5wxo3WqS0RnI2n1CY1PtEwg0LqA7n5aWn13+7ZVJHWUZIMwK
         g9ig==
X-Gm-Message-State: AOJu0Yyn6uzpFqBDnxG2Wn4ZJpfskJvcSOVy0QLE88sCRdPvFtTUUkt7
	0YdeONQWQtMLnr0i7RlOT5Wbnqx8d2KlVYzmQ05vSCHMnvKY9eQ9mHZhyFjsX186ZT8unZ1T
X-Gm-Gg: AR+sD13urzfswMHU5sxySuF5iLjjOgLf4bJs5h8NDImSo4cAmgDNMrfaAC2TH7eSn7L
	TY65CZ2SOLVnfLLYTPmatJJUksEe/4Iu09IDZ+46JURFQPzeSYYXmn8yRBxAX/ToEc9iT4Lv8Ek
	JafcZug6yVDW+EZV+yqwyUkpZWBFzmWo/kz88pkYic54puazbHrPqK98Zy9AflzxZzfP0nHAFLr
	e+jvsRLE8w6jJF+FThRYOwHuhge6WOfRNv5mPnmDvD78ilMUvY2Cj3WepZwGAip91vLKmPtEJcZ
	LnEOYSaKYnfhqaDtYtFx+COFnvVRhqlNb1vIBk+6GecSx7np4O4hg8/jEHrX4yGmdqQ/cCtIUTg
	GO5uUfZLc0Q/eTbAvMpzDshDon8g8W4B99f8migW4z4YxY4YioUaqgNYgDBKFwvgRQa3ibDi9kJ
	RxxNU/9rlZOQWtYiyJWXW3V6u2HTnVUSjo0IMc2kYL8HMYsvRDdePj/Rj7
X-Received: by 2002:a05:600c:628c:b0:499:516b:83d5 with SMTP id 5b1f17b1804b1-499aa1dddc2mr41918005e9.11.1787123211200;
        Wed, 19 Aug 2026 00:06:51 -0700 (PDT)
Received: from localhost ([2c0f:3d00:6be:8900:ce5e:9212:ea4b:f30])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499aa0fda98sm59946575e9.1.2026.08.19.00.06.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 00:06:50 -0700 (PDT)
Date: Wed, 19 Aug 2026 10:06:47 +0300
From: Dan Carpenter <error27@gmail.com>
To: Michael Chan <michael.chan@broadcom.com>
Cc: netdev@vger.kernel.org
Subject: [bug report] bnxt_en: Handle firmware reset.
Message-ID: <aoVWB2bqd776g_KD@stanley.mountain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

[ This old code shows up as a new warning because it was reverted and
  then re-applied. ]

Hello Michael Chan,

Commit 230d1f0de754 ("bnxt_en: Handle firmware reset.") from Aug 29,
2019 (linux-next), leads to the following Smatch static checker
warning:

	drivers/net/ethernet/broadcom/bnxt/bnxt.c:15484 bnxt_fw_reset_task()
	warn: replace while loop with if statement?

drivers/net/ethernet/broadcom/bnxt/bnxt.c
    15481                 bp->fw_reset_state = BNXT_FW_RESET_STATE_OPENING;
    15482                 fallthrough;
    15483         case BNXT_FW_RESET_STATE_OPENING:
--> 15484                 while (!rtnl_trylock()) {

This while () would be more readabel as an if ().

    15485                         bnxt_queue_fw_reset_work(bp, HZ / 10);
    15486                         return;
                                  ^^^^^^^
Since it doesn't loop.

    15487                 }
    15488                 netdev_lock(bp->dev);
    15489                 rc = bnxt_open(bp->dev);
    15490                 if (rc) {
    15491                         netdev_err(bp->dev, "bnxt_open() failed during FW reset\n");

This email is a free service from the Smatch-CI project [smatch.sf.net].

regards,
dan carpenter
