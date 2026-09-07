Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54A784908BC
	for <netdev@vger.kernel.org>; Mon,  7 Sep 2026 12:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788783516; cv=none; b=Qd/Ho8K8mU/pS+hIl1loX5OCqxpFN3qwRC4Ykwg10ZJ2cTK+Ntwma+56olDVX1wRgu/3lai7y7CFAGEHQib6UCZj/AQ2wvySQs7VuRFBJ2QGGwDr5Nnq1NxhGongkhI6ar1wBYWIrRJTNRl7YZYHq2QF80ciAMAyby9jdcTUfkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788783516; c=relaxed/simple;
	bh=CcasSbXAfa4DfM6hENk/1QhC0O7DnAUmCxYFdyKRN14=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=np7qVwmprYBvrbtwUbY22mn3zwGmit1yHJt/Ve7bETsPpsg7+DLqycgfvxfMMD074zfjEYzBYMr9zdJZIZt8mpBN97k8IqNhqKmREcU+5bVoRkQ4ygVw8AP4/s2Y95rjWzN/F1hVRVcawKjZ49wuLmvcYRYd205/oWRN7KJgbmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YnkJY2oL; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YnkJY2oL"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-ca97d139d5fso3182851a12.0
        for <netdev@vger.kernel.org>; Mon, 07 Sep 2026 05:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788783514; x=1789388314; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MCqNc5TOpRye2fp14VARg3h/zUv18AYnd+sTa9Mn2uA=;
        b=YnkJY2oLuMqM9o12sp/S5QKUkjywE3vLVlB+rT8j0y/z144ciL+UtPcWaPWATPtHBH
         /85OidxIT33WofdU4nCIbAyJ63LO5tnDAHGPC13ENv3uEPrPWXlxbC9sk+TWr4DeKlid
         H1q0vTntaqrk9W0vH6VzxY9x4h5BRIh4Qd6T0rHubuGb8LbkuYQU/+BuzS/BV3fmB+PR
         ZUT2qyD5LZNwGrfyoJxyAzMshaOy4Ru57D3klElNo+JAipLf4McGU0k2H4EET09raGS/
         VdH87gvUWbiJstZk3f6gHjRWzPOlfE4fwXw9gmSER5c7B+cCmu3S1R5w2B16fKpNKnS9
         t9+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788783514; x=1789388314;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MCqNc5TOpRye2fp14VARg3h/zUv18AYnd+sTa9Mn2uA=;
        b=BEvt8IceTkLbWQwGRu5zNAdY8Tpoh4QpW8qQoKbZ+gO40wcsSB6oEUyM0nulZkJ1kD
         GR4iQCFvsUfA3A7C08jpm6wXMq1N1/7t3EwImDLk1Y+HMgR/AY3kteML7moC7C2qw2h8
         5rrHxEKI033X6kcAQrVUmazukd1X9zX7dhO3GpX9HwdyjGBX3Jg/i8DrhbxsHbTzQmFq
         oH599u93rhfjWfSmrZa7UTYDg/9jPu7VwHj+9LAK6adEy+BeR5pOb3hPuxWdZN/CHqda
         tBBpwUCBdkUPGKOQ00Q62PZZSZ9Yp/ni+JiTVCOcaoVKtnYXGBMIkJ7SyMfuG+BzS2M4
         A5qg==
X-Forwarded-Encrypted: i=1; AKwUvBxjhLtcOkKVFgpmdhGZlWHwC257aynVtyUIP72B5axG0GixoYmOvNlieHMLrQxrayUDzQh1XR0=@vger.kernel.org
X-Gm-Message-State: AFuF++lyuIu6JZJdc0jIKWjbAekmmc0wvgjAJymlMaMdu55MVtOBT4xR
	R4mmupU+ECz4sRNSfhoFxWOcggeNvJztfHvEC2gSDiZKazfKZF009A+O
X-Gm-Gg: AYBFou0zZW0W5tIi6R6Ab2bnrNRNeOyp66xYQJkavh0sC6LOpfBphARYRSo3BMS8Htm
	I8/tkDmVHUdN12yTebbRpYhI7HcamCg+dOx2l7geBxjXdRqngOUjPIeHPsOkHL7u/u3co3ePigt
	c08FaAziIIETclLEwDwLp4OeFrFwAhfeKIEtTKshgi6z+d3vVOhtI8FPIKG/+Z4CI62sSScdxOd
	aZBccdHV++R/1irPKCvIs/9I/F/XUOCk2K//MCjp+V2UPgdLIJldRw0eCQS0bXTH3mVOr9kZTCl
	Vsb0L8IgBxnFOpa8JoSfqUaxioNyiYoOVJj4aAQjojDv/87mPh7qeivxR/xu0xueAivUPZm+TXp
	2om9pD+UBmo5/j23cjDBDIm45KIFtCcXy5vKc9Dczqdz/BV0T9BJwYMImSxzp6H/MSpTQDACBhO
	9N2ruPHkn/htslHOhIfP7ZpiSu1skq6qlSWjao+Hk4NWh9N3mHOy2uTN5+wvL9QKyYa6xL6xg4A
	TuD1bVPp3bCVYdd0loPlpJYN9BlFeW4A8LFvhDv
X-Received: by 2002:a17:90a:164f:b0:39b:3510:49e7 with SMTP id 98e67ed59e1d1-39b35105b52mr17653094a91.0.1788783513565;
        Mon, 07 Sep 2026 05:18:33 -0700 (PDT)
Received: from [10.10.15.228] (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b083e4fafsm26350223a91.1.2026.09.07.05.18.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 05:18:33 -0700 (PDT)
From: Potin Lai <potin.lai.pt@gmail.com>
Date: Mon, 07 Sep 2026 20:15:56 +0800
Subject: [PATCH 2/2] net/ncsi: fix use-after-free in ncsi_unregister_dev()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260907-ncsi-over-usb-v1-2-6b74d2f1196c@gmail.com>
References: <20260907-ncsi-over-usb-v1-0-6b74d2f1196c@gmail.com>
In-Reply-To: <20260907-ncsi-over-usb-v1-0-6b74d2f1196c@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Oliver Neukum <oliver@neukum.org>, 
 Samuel Mendoza-Jonas <sam@mendozajonas.com>, 
 Paul Fertser <fercerpav@gmail.com>, Simon Horman <horms@kernel.org>
Cc: linux-usb@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Cosmo Chou <cosmo.chou@quantatw.com>, 
 Mike Hsieh <Mike_Hsieh@quantatw.com>, Mik Lin <Mik.Lin@quantatw.com>, 
 Potin Lai <potin.lai@quantatw.com>, Potin Lai <potin.lai.pt@gmail.com>, 
 Adrian Ambrozewicz <aambrozewicz@nvidia.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788783501; l=3955;
 i=potin.lai.pt@gmail.com; s=20260522; h=from:subject:message-id;
 bh=yZHToefB2J4gDdcqtGX3KbgxAzfg+MKJFuVi4HEdB4w=;
 b=ZDRSnx+CLa9vQppAxhLW4mwzQ0C64Hmz8qxYoj2NL0/N3XCxp+UUhT+4K8pCUYJml0ZkQZs1T
 phe+xI6OehLCfDrOrAB3pGWlKr8DLU/0B3zpOAadiwGvJm31hoTPGhs
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

  dev_remove_pack()        - stop packet reception
  del_timer_sync() x 256   - cancel all request timers
  cancel_work_sync()       - wait for workqueue to complete
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
    del_timer_sync() x 256      <- waits for timer handlers
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
index 54d0df0a9efe..dc5f2a76a0a5 100644
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
+	 * 1. del_timer_sync() - cancel timers, handlers may schedule work
+	 * 2. cancel_work_sync() - cancel work scheduled by timer handlers
+	 */
+	for (i = 0; i < ARRAY_SIZE(ndp->requests); i++)
+		del_timer_sync(&ndp->requests[i].timer);
+
+	cancel_work_sync(&ndp->work);
+
 	list_for_each_entry_safe(np, tmp, &ndp->packages, node)
 		ncsi_remove_package(np);
 

-- 
2.52.0

