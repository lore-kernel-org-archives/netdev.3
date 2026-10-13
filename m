Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D56C953ED0A
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 19:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791919193; cv=none; b=LQUushXC6XMGW9/uWDE0f/fnH+Ytcs1HjU05bnG1JZLeuW7lHGSgEh3JngOyd9IJuBx22mxQx1XRCSzTaLkmqH59vYl9P3XsCocKoXTnL0sG9lcEUMYc07fiMmnePFwUwweQjt+ichChYvXZ9yXXPm+R3SudfMa4ysXfo2yUqhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791919193; c=relaxed/simple;
	bh=GrTN2b5PpfqmbfLLMqSYA4B6Q1Ro+NBdw8xoIri7aK0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=n5lwQ9rqxxXrljIdHN8mRJO399FLbLI545mUk9w24AJ7HGyb+Y8Qf/XAU/RA+i+YziGw9MtjAfE9DTjrA1dtEd0t9slxNZxkCmfKql6yHYR1kdhR2ADuskOQZQsRfq4HKk/reVPUrymtqs0CWRPwsO7yxAiX8o3lm/ZK+pmWBdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VHQ1hF/z; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VHQ1hF/z"
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-7f84a55cc06so2101375a34.2
        for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 12:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791919190; x=1792523990; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dOGTVagpmg3SkovNg8gY9NJcdR0snicKiJ3IvwwYIZg=;
        b=VHQ1hF/zRIZ4Dxd+HW9fj0RsBDEf2Yj/qsFCSd1ZaOF20AQ0isCq6onoxmqIe2NgDh
         ioXt1BslTRYZqXIiEc2WeuRqHaf4T1gKlS8L8A58j9EJeksAg1w8Ws79FIEZ+rtpHJPJ
         tymI1qjzKgks5FNeDOhl2wpKzoLCvWQq+liIwtCS30DdMttS9tWbMdythyLk2r3NL2Xb
         jZp6y61lmqm2e2GwZgnAIgipGzgTsw1Ym6IOYATSHhqeegIi8hpJxKJQRnwgmSXRbNyc
         hZS2Cv81SNg8nGmN/AOFv8gAXgr17tqSYgd6VOvKgQ45QvDhHOPElWSEz0W7cWavT6NE
         bkSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791919190; x=1792523990;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dOGTVagpmg3SkovNg8gY9NJcdR0snicKiJ3IvwwYIZg=;
        b=QWkGtxEGWfb9La/mU9n06dWeAqpW/FJrNs6E104FAAQTjgb2YA6SEldcdjq/GLDDKG
         jofutv5LYshJcyK+px2vtPEAi1aOJ1jlotPCbUFaOVSF9aebqDnAIWii4n7hrmwo06Dt
         Ru3TwRawiPrA0odu8mjBwF4yvdU2484qZjRENBi6eXCj2M5pQ8faOTG3NAP6vmwWPvGh
         cm1d8G4oCpOSyRLCDMS+odntlA/EmKVzcpsdGosBWhuD6GRIDxM27eRzwB/iN+af0jfa
         JhtK6zZA9aL4jKW+cj6hVNZwP8mGxtaeyYyIFmPs4wpV8x7QXtRpBowjvt4+EZHmMzlp
         wtbA==
X-Gm-Message-State: AFq9FYJH8D+0Pnj8clAE6wGdrOofeWEyOX+kRdYpCf4LebqiH6wB5UyP
	54Q87yhyHlgeLyjY9oBB8pv01nhX0RJDhGB804zUEXkqh3l90J699/TI8m2u07Fb
X-Gm-Gg: AYBFou3zc7UvzLY7aQXKsuMz2nBDgjlBop2qAU/Ggs66sMpS9n/86aP7AVjuLM5HLYb
	9syYK8eQrfCa7bcA3rS0a5Fhm1HAsJySN9K2iwvF47irOz9WocViwbkasBbmBuQ/xJ2GJZ9TWum
	UJzOVhod1dbiEZtVVSAd4TVOoRmS49Zov7GUGboU2/3udR2dofRUaOPFDc0LuCTqsnt9iGxXBYN
	gWGVgiGsnD3C/8JZdgtuOeW4HthiMUpAEqYlYhjRo0yMptA/6giQXY6o5xjd1wAuaWhgdfinaht
	fcMdNM1yz4FYLTTzd8Y1z0RVSkkE62rX0sYDDLsdClRaIvgU/Q+dEqN1hOsbu9dMqZDUqEwAe12
	bT7Ga5CDxn4NVbFa4SILIZduR12uhs5tP16upy5Qj25y+VUZHNovWku2+0l22DNCQZx8RhtSDKV
	mzVB5W+x6O4dKfj6q1roErBlBy1iR3H8WbYMbaPtf6BOkYctn9wXvK2igIkO4jb1BScu4gdk7qb
	DDGzilwmq5bxi8zwza36i/QmfHcJXaDOsJZkUc9PeperM663Jd/LweXh5FnBa7c6VM/5yk0noeZ
	/9a4646XX/u/vbz3wTccEC/WrH3+GRUxiYzSLFmbiVBkPRScS70aokJIDImaVBZgP1femG0mTeu
	NBdDTbY43Vi5tGUur8ig+
X-Received: by 2002:a05:6830:449f:b0:815:40bf:e777 with SMTP id 46e09a7af769-83095d20990mr13053589a34.13.1791919190457;
        Tue, 13 Oct 2026 12:19:50 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-83039a3dfa1sm13280507a34.18.2026.10.13.12.19.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 12:19:50 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Tue, 13 Oct 2026 13:19:46 -0600
Subject: [PATCH net v3 2/5] ptp: unwind partially completed virtual clock
 creation
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261013-ptp-vclock-sampling-v3-2-d3ee4ea62fc6@gmail.com>
References: <20261013-ptp-vclock-sampling-v3-0-d3ee4ea62fc6@gmail.com>
In-Reply-To: <20261013-ptp-vclock-sampling-v3-0-d3ee4ea62fc6@gmail.com>
To: netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, Yangbo Lu <yangbo.lu@nxp.com>, 
 Miroslav Lichvar <mlichvar@redhat.com>
Cc: Eric Dumazet <edumazet@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org, 
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

