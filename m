Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792900993;
	b=EpAkr+x34Lg4XD83Dz84ehUjF8TkHo9jt4C9MVruiHMlFeBc3jCuURQMswk1lGC1uyE7
	 shKxV3mxcvFB5HUWOspptp5F3hY2MJclqyBlmgNBxG7N6nhA5zCrOy8DTS0Dog/zied9N
	 Gt0l5HlD895MMNFYh11H/nBMIz9hwqlNjIiVcN8xJR8/O/pcjeU5mStmx9LEUYMASQXoM
	 WtPa4xZg5i/OLipKwohpjnwmuCJf2nchKkGYfBAiHjVfevaQ05MJUk4Hsy7WQTFoasY8k
	 su3vII6oy3XWJxLbBlJOk00ANzuA28OrmMoBoMxEBEo4mHdXKCNO+snRneIziLv4Now==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792900993;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=bXXWN0U2LwSgs5yFSiYomIOkF6F+3ijFGiBpJE+lZgY=;
	b=JNd2XNQh/M337zo/LJ1hanb4QrB3kdViCUDOvCoIh4H9NE5YI8DWyaa6x4i7uL+N8/3n
	 Aohl8WuhGMH5MamPLzHyhnfLGKs3BHpXzFT5vW9Uv3R2N5lJfgPQAYq1+cBcMJjkOFaXz
	 yfP3DXo8jvfpk3HmtdGIauHGaqsO2WVTZCXsEV1Xv7HxhyiwaUNCidaTZtewFojWqGRle
	 wJUjX9XLLd8WsEiCS7ydlTNqa4FOx/+PZ/m90iFYz94bBTa3M08PQUHg3O02rth5wE79V
	 AjMqzgVauKCe+3BbvR8DR5cto+OyVFl2geLJa3Vt2tsVa6TsV3JXBAawDxRjVpAv+VQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=DNKNW9T7;
	arc=none smtp.remote-ip=209.85.216.54
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 017C7606A31B
	for <netdev@vger.kernel.org>; Sun, 25 Oct 2026 04:03:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 017C7606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=DNKNW9T7
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3acb1224533so266561a91.2
        for <netdev@vger.kernel.org>; Sat, 24 Oct 2026 21:03:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792900992; x=1793505792; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bXXWN0U2LwSgs5yFSiYomIOkF6F+3ijFGiBpJE+lZgY=;
        b=DNKNW9T7kGfS78TEh9BVgxXbbjDsK7FmBqAhYSl/KQ+eTH7raGVvtdvg1NUc98VoRU
         K+t6Nc6VFF63JU0nm30Oaoo7PWDuZqaJa/VGdjf1oEl1vKQws6xUEHvpigr1aU8XJKW9
         ARzBEbRowo/1PB62yadC/gAYjKkjUksvUtAWL5KNMcmW0it4u1TdjgS9IKYCVSUT/B4B
         5LmSmhiSWh9nYee/Q8xH/mbjnKv05BsnHAXumcfsZ1MU10WIv7HErjsSADO0LjhEhqVG
         kuOy2JsugMVzT+/xQMFxDhtCn1QSY8Ludbs8xew8apip8FeKjXp7edLasQnaxkyYNus2
         mgQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792900992; x=1793505792;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bXXWN0U2LwSgs5yFSiYomIOkF6F+3ijFGiBpJE+lZgY=;
        b=ytffW0ujTelELjYS2vOKrzQg9RexB4xi6iazQ5VG5+H/PYFmWv7KaKH1r7D5hiW+Sz
         VKlPcyx9vkrhaw0fe6SuMZegHZtJCcr/o8KKRF08zxJ0zzBGmun+SG2CGqQjU2+qYo92
         4dL7UZWwXdt2xvgj6xEtjxpFN8VGnhnPVg0/MCGKUA68WIU8CnNlEvgRvt/2GsU7JiGL
         nvbLYwtzTZG1pntwObxduXWWkqhoZ616tY0FwdISjjvI/9x/8YUQBpa9m3tYMAnTQ95D
         QW8xpUx/XqLlGeUKKL8eOzXtUP5Iyii1o/JKJuQ/Kf4vEdt3VIEfvJq2xfuH4pZPNXBR
         SgFg==
X-Forwarded-Encrypted: i=1; AKwUvBzaDjEXJ3uRSXtr055FCz5uVip5Q5uqM38O3s1P2j6GThd2kB4pABZmvSfKV8eoWTZiddGbiL8=@vger.kernel.org
X-Gm-Message-State: AFq9FYLG5JcjnmkYjYnB9UiOBY29W2s/7GE/LYWjUxzpIQn53ksEIFyG
	NbJaf0FI5os1Eeap3WZMjKJG5NR612bHUQbpHmqOc2HMNfxlMv/kZNLO
X-Gm-Gg: AYBFou0vNZzSyDq9oNkwNerYLt5wsS0x+1R0ELCUIC5a+2eizOPYt0VVTEjxPDySu22
	5S0P/KmT/tCLNyI9TPE+R43WoxxMk+fYqXmQXOPkclBWCiLc18sahCb1TlKS8rY48ORehZbFnK7
	qZgR4qqNH4kqCODOdtqj26Xg+7Xgv9JvxmCUTbFcxv/8LGv2ofwBptaNf1j7MIB6KRIML6NOIah
	PyIwF5Bsjefl2x4yy2oKY36UvZoLqDt3SC2W/Q4TwmiPhuwaZSUIkUPjcNGm3TAjtwOmxXn79iF
	auC29nemckbX2G0lkC46vAu5dvugI2/aZw0SwXnGPlqs36HiENh5bjdKGiyy75nb46Esct9FJY+
	grMjKpJXlk8EvnKUFC68MXMaMvFersspvNMoGVgXhsCRLGNkThCDvLEEfKVNPlQGaIiEwFw0LfF
	8jGhMA6ndCqy8QgVgcfwW1lq7JDoHsUQHl+uTwtUzzuqVF/qGz0uOG/gl5bdIw8ofLlNTxvdne4
	wZ2TfrXUKbGRxStnr4LsAs/EKeTy5QD3AGXMtREuSh1dy9qhYadYDwnrYn1OQVOXKIyDE36g+6g
	79oM
X-Received: by 2002:a17:90b:3c0d:b0:3ac:a7ee:6785 with SMTP id 98e67ed59e1d1-3ade9b35f05mr4994498a91.1.1792900992309;
        Sat, 24 Oct 2026 21:03:12 -0700 (PDT)
Received: from melokc-laptop ([101.90.152.206])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3adeb82761esm2921587a91.0.2026.10.24.21.03.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 21:03:10 -0700 (PDT)
From: Anfernee Cao <anferneemelokc5@gmail.com>
To: D. Wythe <alibuda@linux.alibaba.com>, Dust Li <dust.li@linux.alibaba.com>, Sidraya Jayagond <sidraya@linux.ibm.com>, Mahanta Jambigi <mjambigi@linux.ibm.com>
Cc: Tony Lu <tonylu@linux.alibaba.com>, Wen Gu <guwen@linux.alibaba.com>, linux-rdma@vger.kernel.org, linux-s390@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH] net/smc: fix possible recursive locking in
 __smc_lgr_terminate()
Date: Sun, 25 Oct 2026 11:53:35 +0800
Message-ID: <179290097759.51540.15412712294727302463@gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit

syzbot reports a possible recursive locking in the SMC listen path:

  WARNING: possible recursive locking detected
    kworker/0:2 is trying to acquire lock: sk_lock-AF_SMC
      at __smc_lgr_terminate() (net/smc/smc_core.c:1580)
    but task is already holding lock: sk_lock-AF_SMC
      at smc_listen_work() (net/smc/af_smc.c:2463)

smc_listen_work() holds new_smc->sk while calling
smc_listen_decline() -> smc_conn_abort() -> smc_lgr_cleanup_early().
smc_conn_free() unregisters new_smc from lgr->conns_all before the
early cleanup, so __smc_lgr_terminate() walks the remaining
connections and locks another socket, not the one already held.

All sockets use the same sk_lock class, so lockdep cannot tell the
two instances apart and reports a possible recursive acquisition.
Annotate the per-connection lock as a nested acquisition, as
smc_listen_out() already does for the listener socket.

Reported-by: syzbot+7ea1f5efd5de7e24f1de@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=7ea1f5efd5de7e24f1de
Fixes: 2c7f14ed9c19 ("net/smc: fix LGR and link use-after-free issue")
Cc: stable@vger.kernel.org # v6.13+
Signed-off-by: Anfernee Cao <anferneemelokc5@gmail.com>
---
 net/smc/smc_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
index 9974149659c2..5911368ae520 100644
--- a/net/smc/smc_core.c
+++ b/net/smc/smc_core.c
@@ -1577,7 +1577,7 @@ static void __smc_lgr_terminate(struct smc_link_group *lgr, bool soft)
 		smc = container_of(conn, struct smc_sock, conn);
 		sock_hold(&smc->sk); /* sock_put below */
 		read_unlock_bh(&lgr->conns_lock);
-		lock_sock(&smc->sk);
+		lock_sock_nested(&smc->sk, SINGLE_DEPTH_NESTING);
 		smc_conn_kill(conn, soft);
 		release_sock(&smc->sk);
 		sock_put(&smc->sk); /* sock_hold above */
-- 
2.54.0.windows.1


