Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AEB254A7E8
	for <netdev@vger.kernel.org>; Tue,  8 Sep 2026 13:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788872661; cv=none; b=Ng/W6a1+i1CSp5ZMyHGQ4WR6i7NjF6UTtxcpi3pZvD8TKaiEkZ5EHARzghnNx2oSQ5xVYvrIeMb2goGrzrpbMGdWVGApsSbN1ae/u7sc4wCXJ5kyWTGrsVM4+efdNmDshcveDx9Xz5+9jJu+DvRTVLfjwAsGXZ+LHQeS1VIxffQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788872661; c=relaxed/simple;
	bh=/aCr8hgeVMYJ3KiqUNQsu2gK8nS3HDQMoxXqYTGMnYo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=L3+zyT14RhoIJKaI9WzZOXKO9kbooNgy427hflWqhRc4DcHrLE2tol5ayjJN7l2GCp8HWCoFMLkKZrhpwYfDi0r8ep5RTDmQmJ6Inc3SQAfA6F4HTLhmGskTBHcMfWM9xxZzCdVg+Su99dcI6k6+rlwALnbRDFyYmULUvtK7HkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jGWAbDew; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jGWAbDew"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-853c947bfefso3307817b3a.0
        for <netdev@vger.kernel.org>; Tue, 08 Sep 2026 06:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788872653; x=1789477453; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vu62D3vv0YYC5WBDVTSBuHunsO24noZas55Sfn0ORyc=;
        b=jGWAbDew/9C4ntzHTKiEA4Jfgy5TZI9/+w2iobKSmsiBuYPy7ArgOHQYUQ7dty7e+m
         1SNSU2cC1lGG8h3nFVCPA6v3iZe8mNBc1gumwRATZwg1PYcXI2SqZBlbXF0GL5cjijeX
         qBig2Zc9j5Ya1hzjC0svme++z19I3/l8+K5yNy3d3kFobVRRWakNLOfngmMef8u2zwPS
         Y5m/qUqFP2Mn5eGFzlD54aUR0+/BAKg+bNAXJxc5ZRmh1yV75XFBlbZ7pgnolaONCtUE
         Kx4uB4uWeEGcB8GI7N5KmSkFWBMI4C05oHKtN3gKetSCYoxN7mmXoUEoD3+hkfI9cnK/
         CqCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788872653; x=1789477453;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vu62D3vv0YYC5WBDVTSBuHunsO24noZas55Sfn0ORyc=;
        b=WIVfHDr7ASh6tNlzIybDrn+hORYeb5TQjZuQQ+/7H25g3OSIdgFNy9OWlnXqLGNYAx
         MKVDYKe5+seqTZOoOG/sk5NwsDYE0aNcasuLSTX/rKhSSkK4mRH2zmUGrtiMXbG1taXW
         PhqzZNuHcLkbi4Cxom6pvsh33VPLdTS0P2FZvfOD+xwBKqKbKRZMhwgEIPHzMpz37KrH
         832z0BBhJFl+Mma+92Gr1gFnS2VjwrEjYkCKgJwl6E7mq9rqlaWsHjLREERJXmfU0uDY
         KNIrDkg9Xswb/ROjCSQ9J8Z1SGg0DrBiFbmovQZ4Uf8ouHJO0llvtiAAoHSzDk6N6QWf
         JGUA==
X-Forwarded-Encrypted: i=1; AKwUvByz2vuKvPASBR2u28Iac57kTuEuUdO49sa/UbTnqmg7gRLnlFDPHdfjns4LPBzcLJAMwF7sVYI=@vger.kernel.org
X-Gm-Message-State: AFuF++nRmvSWNuKi+Ika4oj2LlFpX3NaIlDPrzJyB6XDkoc2YevpNYBP
	BJM9stWa7K8e+CdKroIDD1t4VBRIDki7rNorJMM4pO+o94vEuacZLdc7
X-Gm-Gg: AYBFou39GZ7yip4f+kAi476+8iK8XS0nvmCVWZ3OlA/S4l3jT44DznLbvDXLse5jeJc
	m5fQEscfEII/V/ME4GfAPQHqm1YJtmyZIk594Uzx0av+P/FrBQxl0s/uavWOEK1HfOV22chGoOU
	/mCOTuJlcCY572qOZUOXe/A29IjudKhOhvimwwNLfRWmRSAaIoDVdkFXWfw8/pVpYSK7ktSvYvt
	1THg3GxTHDd9p5WBJFD23yYoL5oT/vQT2WfBbLScHWWZbJyhVNhNkpYWj8O1wnu3NaKJf7WgZci
	+dAhxO19rm5PIGGcBiqgrrnenfio5LqxxqWWQZZpsMLDb1UmTC4pXT7XkzQZtdSSdK5Kxk/Xrum
	LsMQ6pUzZ+7SgDQDeSxg+lFMGrublvBYp5dA+uWlU48xoCOXbKgjlRf5jVqR3pWSWk3IMM9+F4I
	ekpW/RspJEvsJhOrOTaL8ePYbjKqNj7Q74cxJ+7kzN+g3anVcI87NwLcWH8eD/dl1HM8oTjL40G
	c7+aOpgToA6186yWVeITtNNaYvDOw==
X-Received: by 2002:a05:6a00:987:b0:857:73c3:446c with SMTP id d2e1a72fcca58-85fff3c461fmr31073167b3a.27.1788872652526;
        Tue, 08 Sep 2026 06:04:12 -0700 (PDT)
Received: from [10.10.15.228] (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8614f874e9csm5652398b3a.8.2026.09.08.06.04.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 06:04:12 -0700 (PDT)
From: Potin Lai <potin.lai.pt@gmail.com>
Date: Tue, 08 Sep 2026 21:01:32 +0800
Subject: [PATCH v2 2/2] net/ncsi: fix use-after-free in
 ncsi_unregister_dev()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260908-ncsi-over-usb-v2-2-92dd78272fbd@gmail.com>
References: <20260908-ncsi-over-usb-v2-0-92dd78272fbd@gmail.com>
In-Reply-To: <20260908-ncsi-over-usb-v2-0-92dd78272fbd@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Oliver Neukum <oliver@neukum.org>, 
 Samuel Mendoza-Jonas <sam@mendozajonas.com>, 
 Paul Fertser <fercerpav@gmail.com>, Simon Horman <horms@kernel.org>
Cc: Potin Lai <potin.lai.pt@gmail.com>, linux-usb@vger.kernel.org, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Cosmo Chou <cosmo.chou@quantatw.com>, Mike Hsieh <Mike_Hsieh@quantatw.com>, 
 Mik Lin <Mik.Lin@quantatw.com>, Potin Lai <potin.lai@quantatw.com>, 
 Adrian Ambrozewicz <aambrozewicz@nvidia.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788872639; l=3964;
 i=potin.lai.pt@gmail.com; s=20260522; h=from:subject:message-id;
 bh=bKp+fXghJ6cQJaZb9/dKdTBINAk3RYvGYETZo/GwPjY=;
 b=zdJASea/GkvdKgFd9ycSXVpHjAiOck4Qf6FmC5wriN7PkcPVxeK0Of7uZPoxbxIv9lDiuHaMb
 bpOB7UgUOsMBEZNJ8JbUC7iTw3mBtga44fuYe9Mf5IH7tK/XUP9JmwV
X-Developer-Key: i=potin.lai.pt@gmail.com; a=ed25519;
 pk=j3/nMxzz1ZPpp1revghyZ8IqOnwi6RWfuxXN2XrNMRE=

From: Adrian Ambrozewicz <aambrozewicz@nvidia.com>

ncsi_unregister_dev() frees the ncsi_dev_priv structure while timers
and workqueue may still be accessing it, causing use-after-free.

The problem involves two async mechanisms:
1. Request timers (ncsi_request_timeout) - fire when NCSI responses
   are not received in time
2. Workqueue (ncsi_dev_work) - processes NCSI state machine

These can cascade: timer handlers call ncsi_free_request() which may
call schedule_work(), and work can send commands that arm new timers.

The fix adds proper synchronization before kfree():

  dev_remove_pack()         - stop packet reception
  timer_delete_sync() x 256 - cancel all request timers
  cancel_work_sync()        - wait for workqueue to complete
  kfree(ndp)

Order matters: timers must be cancelled before work because timer
handlers may schedule new work via ncsi_free_request().

Note: ncsi_dev_work() is non-blocking - it sends a command, arms a
timer, and returns immediately. It does not wait for timer completion.
The timer firing later triggers schedule_work() for the next state.
So cancel_work_sync() will not hang waiting for cancelled timers.

This relies on ncsi_stop_dev() being called first (guaranteed by the
network device lifecycle). ncsi_stop_dev() sets state to
ncsi_dev_state_functional, which causes ncsi_dev_work() to exit
immediately without sending commands or arming timers. This breaks
the timer<->work cycle and ensures the synchronization terminates.

Timeline showing the race (without fix):

  CPU 0 (unregister)            CPU 1 (async)
  ------------------            -------------
  ncsi_unregister_dev()
    dev_remove_pack()
                                ncsi_request_timeout()
                                  ncsi_free_request()
                                    schedule_work()
    kfree(ndp)
                                ncsi_dev_work()
                                  ndp->...         <- UAF!

With fix:

  CPU 0 (unregister)            CPU 1 (async)
  ------------------            -------------
  ncsi_unregister_dev()
    dev_remove_pack()
    timer_delete_sync() x 256   <- waits for timer handlers
                                ncsi_request_timeout()
                                  ncsi_free_request()
                                    schedule_work()
    cancel_work_sync()          <- waits for work
                                ncsi_dev_work()
                                  state=0x100, exits immediately
    kfree(ndp)                  <- safe

Signed-off-by: Adrian Ambrozewicz <aambrozewicz@nvidia.com>
Signed-off-by: Potin Lai <potin.lai.pt@gmail.com>
---
 net/ncsi/ncsi-manage.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/net/ncsi/ncsi-manage.c b/net/ncsi/ncsi-manage.c
index 54d0df0a9efe..15d7e4cabf4f 100644
--- a/net/ncsi/ncsi-manage.c
+++ b/net/ncsi/ncsi-manage.c
@@ -1957,9 +1957,28 @@ void ncsi_unregister_dev(struct ncsi_dev *nd)
 	struct ncsi_dev_priv *ndp = TO_NCSI_DEV_PRIV(nd);
 	struct ncsi_package *np, *tmp;
 	unsigned long flags;
+	int i;
 
 	dev_remove_pack(&ndp->ptype);
 
+	/*
+	 * Synchronize with async operations before freeing ndp.
+	 *
+	 * Note: The caller must have called ncsi_stop_dev() first, which
+	 * sets nd->state to ncsi_dev_state_functional (0x100). This causes
+	 * any running or scheduled ncsi_dev_work() to exit immediately
+	 * without sending commands or arming new timers, breaking the
+	 * potential cycle of: work -> arm timer -> timer -> schedule work.
+	 *
+	 * Order matters:
+	 * 1. timer_delete_sync() - cancel timers, handlers may schedule work
+	 * 2. cancel_work_sync() - cancel work scheduled by timer handlers
+	 */
+	for (i = 0; i < ARRAY_SIZE(ndp->requests); i++)
+		timer_delete_sync(&ndp->requests[i].timer);
+
+	cancel_work_sync(&ndp->work);
+
 	list_for_each_entry_safe(np, tmp, &ndp->packages, node)
 		ncsi_remove_package(np);
 

-- 
2.52.0

