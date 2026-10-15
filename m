Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 461BE4D9561
	for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 23:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792107225; cv=none; b=ExH0k1fCzoUEMUVd6MO7RIa03U/btMTCmM5Zqkz9wAXkVa0fOwnIE0dtP1JEXuNgKdVMHe9gFrMu/lVQ6d7Z+5//DaVHTzPT9CRM1TAileXuuJent3Bc7U175QKwdqwSwpKScU7aV31dXetoE1eyYRQ88lJS16h+IGeET2WmGe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792107225; c=relaxed/simple;
	bh=GrTN2b5PpfqmbfLLMqSYA4B6Q1Ro+NBdw8xoIri7aK0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uTLUg0VtGxqFn0hh2cMJL5qoBb3hNncIJAHRHEZsgVaTEumQ6FuMGQ1GzJrMQJpi9P5D4o25TLeXTfeqJMzvlvuxtpWhLZ7/41WtgVoGa3aQf5HwjFp2lVt9ZOuaAW20FdkDvZAK0CqyQrKdPcWh5tB8hROijq3z5PJSWZRLLPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BuJwfZa+; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BuJwfZa+"
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-6e560e00a86so4055413eaf.1
        for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 16:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792107221; x=1792712021; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dOGTVagpmg3SkovNg8gY9NJcdR0snicKiJ3IvwwYIZg=;
        b=BuJwfZa+frL9anoe1a/YGLllVJgn0irp7JXNwT/GqJa2xxm5jLJbQRK40MzM4/gKwt
         Wn+BDuWoNXAmyWouZMPgqqfKaqFpiBIsr0fWgVkqeMJXlCkgYhUBmzCXG6wlazTyjm0+
         hKyfs7HJDjYFOYqwm0VOmIKooUMR2e2HSdXVbiGG8keil9tWw4bNW1PmdLZZe7hWmWfx
         DaGNURWOSqNCLFD4ZdR78oJdxTDv84XLJ07EfAnn6n1UMcnrHsZT65B5W3zx270EvIDJ
         /MEtntWBw+H6wocoC+lOjQqdhmo8sn4AiqCIxExT++wyfbSYp0/AyFD536TYxi5M9X1d
         e8dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792107221; x=1792712021;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dOGTVagpmg3SkovNg8gY9NJcdR0snicKiJ3IvwwYIZg=;
        b=UgNq0mQYrqgxYDmRYTjYe1ZRtV1g+MGKAfQOnK1/97oc84/Qak2jaVQka6mwLlG2/H
         TisklB8DhatobKjXT2Yh/l6DZhMfEpSgKBeCH2jZnwvnsWZpNLLOU7HSZWkWjxkqpvGT
         1lsnB1Bm9Qzp3BDzWZKGkTKCdlB6jKfhEFT0rEEFsRF+2QVpjtxaAqeAPEzSAJW6RjmO
         3WoLaTpv0tpGYCY/mzny4BB9XMBvrkrGNzsW4YbqvTrn4q70i6eeDgfJ9/xqfk45j3+U
         kcCQWkvknWwNMt6qQcH099Bbw7ylvUp6y8Vh2cjdWRjRuHfG7+qFHEVN+2QVK6vdy+WI
         RiGQ==
X-Gm-Message-State: AFq9FYLAn2U/R1G/bGQvisETGfDrK+1uicaIdp3AcK721+vNO39dJkgn
	1JkMkdS+1dtq23Ceq/TN2e9Oynv04rfugfRXirWvQj5FJzDUCNobavSL
X-Gm-Gg: AYBFou2hfBJNgpozm1f8FB7CxX3ulyrWcW0t/yXvWgVmPm73JHofwysJ/uYQCx5i1yT
	hYq4CPdqDcj+LDPUXzyqv/zThRAeBNHjXZARJxHKB3l01z8cbsPmyYFcC6dQSdZ6CCk//+G5Je/
	8HZzXLYixEJKCdfKzO92un7EB0UfDn55LJ/J1PvuDuvWzTxCbagIUDReIdJbPmpzhkm4US1ORnw
	rFoUyw+BYWgBwOUWVn1fLp8uy+iczWjm5a38akKwIHaQbn2AoEJBf/nBrbsdKDtWo+CAbXVf0li
	Y447xTbuj/nOxWrI/+uoCbMtxrIamk9lHTuhmY8wTzb0a7+CZ753BAL1YHQ2ga1lPoGphUyeYgD
	QJOxL1nWJUixPH/CDb5+XgJuMjymYcBYHfTuH8jYmZKGq0m26ylJTtkKz4bBX1QP2Nzfx6dn0Xo
	ssoRcJ2V6wq1x9l/fPKQlUhSlvKmo5TVIcYuHZN1ITu5zjc0hD6RNp+pcupIY2P1yzeSUaSz9Y+
	06eb9WyLzRVzOnrAYVfAZeEwAi2vyXlG1lizgzpzwbQ0K4iao1eHEfNElQCujDBXDppYHb/m4Ci
	5AG+xGRVJQhplO7Agx45NS2ToabOX3KXH8Xc/mjO3fRlyf2J42u6zunpIJK9BV7ukEX3ET+dman
	JAc9OxdX3jjuUfAeazg5fOF68gFtqdlvm
X-Received: by 2002:a4a:e907:0:b0:6be:1570:73b6 with SMTP id 006d021491bc7-6ef0e9dac96mr13517324eaf.20.1792107221207;
        Thu, 15 Oct 2026 16:33:41 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-70188bd9ecdsm525519eaf.2.2026.10.15.16.33.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 16:33:40 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Thu, 15 Oct 2026 17:33:32 -0600
Subject: [PATCH net v4 2/5] ptp: unwind partially completed virtual clock
 creation
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261015-ptp-vclock-sampling-v4-2-cba6ffc8ceb6@gmail.com>
References: <20261015-ptp-vclock-sampling-v4-0-cba6ffc8ceb6@gmail.com>
In-Reply-To: <20261015-ptp-vclock-sampling-v4-0-cba6ffc8ceb6@gmail.com>
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

