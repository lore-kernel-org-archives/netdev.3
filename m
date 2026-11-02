Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793617046;
	b=Dc+T2B4V7V5u2RTKnetEvfoW6NoRm54lYElh9sXIQJ9ukR6nEekwT6TnGSKkcvn74AiW
	 jbMEJhpB35OJ1dg6XiEgXO9Llke73uRTkTvHVuS2BwpkSzLmzDyquJiRIkVrMxnArYpQK
	 V2P9BHLgQ3T3lv8Xe6Nj7cMs7N+00W/QH2S8pBkNyho9rW0ADoYVIke2l8u2iAJbhWlWL
	 QT15rO3NWbYBZQLI0Dp6FAZHVJiweqcr8Zvig+rhvF4zpSnMCw13wGVcSFuW9GASgx9j7
	 /Aensx5XrPXyPMRzzD+mHQ3iJH4QcVzIO2aYxodmxw4ogQJkxrAUMbSjgrySnUUCZ+w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793617046;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=stidbQEu/b8LEL0TyEMNxXUt/GPxYyfM90OUzht8BOA=;
	b=T3t8s/ebdPKxxnJ+DZbv2YfiAr6nq1g3bXlY0f5L4ZCPLtUn2ev+MdHFfIZLX/1yU/fl
	 DmPP5MxEnNEpmBAbm3ppb+O2X98rLbbPDlRLWO6MXyXjBMVIMMNty/b0AQ7eJXMLsbU9g
	 acOtiCjUnWXoXVpfwJXD41/X+eSYqHYmoGBE4poBEGWFRB/2ZPmEyW1+KhIm4nhpT5rJQ
	 lT6K4IbCxGElbdPzTiOuMLR+YZrnWVk9hSjYVezVshhFgMdCIlwduVo+sGIqxd0xtRbBr
	 14xwDEUW9btdLsP+R3qPb2ov9jY/dnpcgPQnE6iQeTUpoPwYibBed4hSM2ADIMmoO2g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.com;
	spf=pass smtp.mailfrom=suse.com;
	dkim=pass header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=RaxvoYKn;
	arc=none smtp.remote-ip=209.85.128.47
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44A8C606A32C
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 10:57:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 44A8C606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=RaxvoYKn
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4a35d5d4a20so32392285e9.2
        for <netdev@vger.kernel.org>; Mon, 02 Nov 2026 02:57:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1793617045; x=1794221845; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=stidbQEu/b8LEL0TyEMNxXUt/GPxYyfM90OUzht8BOA=;
        b=RaxvoYKnYtR2+CwR4nFSRn0rvyUjPA3n8mzJZ7FLNf4iniFp60DqhSsUgLv6lnZY7E
         1l8vJESyxl4ts4rFvJUyCQ71sHEpqnA6a6reLjhDpqMADZLjxX4ezomvutoVUwEv0/Rc
         brdz89jK3PUTPRJI89ornTXKbgzAxLPpx3OYgg+Xoqc12xI1XzlXlN5s73sFIq9fh3x9
         ofqpSscvYIWjnvsc9Y9IlyIjRmGGVC5gjH7mvql6IFeHEIPfj67FRumdn9MyWfdYpV+b
         2c9S8Ai5yoz1tkmWaEzegH0O7xwXUwgKT+5kc/0D60bJtRJoUWLWfH6Nj//NgPs+bEaG
         RRWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793617045; x=1794221845;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=stidbQEu/b8LEL0TyEMNxXUt/GPxYyfM90OUzht8BOA=;
        b=tu76wK1OjT6l8chwGBugmsRS/7xfxLle7FBOzDhJKguG3Koo8HoDlBG//RaV9NpNYE
         FqJqBu/KHLItFLj0kijT2/ejbG8uJQ46hIhBpujMiQmT04iSq97zVt54RRGjHNvErpjK
         9k6R+TEx/1jFvBcY4NSNfCp9wk8pU2qhl+AKMhGUw3Mbq0VnBqiXFqsj+LDvz2sErSyX
         xIMuIfho2MJGigNyBzJeSI4Ca1WuDPDUNmVI/0T3t/LJFnF39j1/uPBxm9p85Qo90X3q
         cVVZs+Du9sLCcn1HB6YnzvV8p73prf2SLZWHp5IRbHNljvpHJXkwPjEG5hF726WkhFwN
         8v1g==
X-Forwarded-Encrypted: i=1; AKwUvBzV2Dq82yp4uwYbOB3ylFt6LwGpZahPLB1hpFBvyFxspDxWnXbwzIRV+0AnIm89JQP31THqeLg=@vger.kernel.org
X-Gm-Message-State: AFq9FYLj27J/JhQCBJLqUTmLFuWB6WfH1d0trJwTjiw6XSHlOrLejHsK
	XNRG/3l3wL8SmuYi76oFJvsIO25rnU0wzQyH9RExVlElUibGgYWXFVbryLdEELQid3k=
X-Gm-Gg: AYBFou28MdPiyRHUPSL8+hNoBQY+SVi2PoWJBpv4bzRicrJ1NmFfpgoqAbFgYhbhlbI
	/pa3smZ69zBDHPwxbAeYylKP2JzRqxsXO2kyiliv2D/sQ5EPKlqmoIcUtZsPty+M6lIBDBjAsfG
	FTGP6LnJ9J3EtE//u6+QDMCPOMIDKjGFhEBMAtmfehdv0Lh5/uyo9qMZ6AazPptTPVXAKIkiqIe
	pIRFrg63Mvr82X8m5OXd7vwnXes993iqXCJ2zMgk1Vtb8jkA1gZiS5wiy3weoypAltYv0v1uvPo
	ihhDzwr2bfQLtnDt7lUb94Rkvj1HJLEQgae8BywnXhjEhEspx+D3HVdK6yJTHpwXGXQh9X6qR6H
	070ULz+Td+SdB/+qHKbqdxtbneqH+LOOvouVxH2hKlF3paRIPOaUnam/R1QLlDSDCdAYqb+MPgo
	Uz/vFzeYVabgZmHDju45XsTPAy5f1w9VGBzqZsvKbBMDvq/mJFAEC2bOUFB4hr3nGSWD6LTLyNL
	nujwuAcy8ymhb/M6PZdsU/XWl6WllBx/D87gHZI/27sPdoioM1ptFR5966a2gT9gPhP3Viwx64N
	i5sgWFUJZLtfVl22ef29jEzqivvnYTProBnDXQ63xepoGIA2HfhOkg==
X-Received: by 2002:a05:600c:6216:b0:4a3:5aea:21e5 with SMTP id 5b1f17b1804b1-4ac1737c533mr210391055e9.9.1793617044701;
        Mon, 02 Nov 2026 02:57:24 -0800 (PST)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4abeb77af8csm363171175e9.1.2026.11.02.02.57.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 02:57:24 -0800 (PST)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Mika Westerberg <westeri@kernel.org>,
	Yehezkel Bernat <YehezkelShB@gmail.com>
Subject: [PATCH net-next v5 4/6] net: thunderbolt: Move long delayed work on system_dfl_long_wq
Date: Mon,  2 Nov 2026 11:56:54 +0100
Message-ID: <20261102105703.111844-5-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261102105703.111844-1-marco.crivellari@suse.com>
References: <20261102105703.111844-1-marco.crivellari@suse.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently the code enqueues the login_work delayed work using
queue_delayed_work(), on system_long_wq. This workqueue should be used
when long works are expected and it is a per-cpu workqueue.

queue_delayed_work() ends up calling __queue_delayed_work(), which, for
a non-zero delay, sets a global timer that could fire anywhere, enqueuing
the work where the timer fired. With a zero delay, as in
tbnet_handle_packet(), no timer is armed and the work is enqueued
directly on the local CPU, i.e. the CPU that handled the TBIP_LOGIN
packet.

Unbound works could benefit from scheduler task placement, to optimize
performance and power consumption. Long work shouldn't stick to a single
CPU.

Recently, a new unbound workqueue specific for long running work has
been added:

    c116737e972e ("workqueue: Add system_dfl_long_wq for long unbound works")

Since login_work doesn't rely on per-cpu variables, there is no obvious
reason that justify the use of a per-cpu workqueue. So change
system_long_wq with system_dfl_long_wq for login_work, so that the work
may benefit from scheduler task placement.

Cc: Mika Westerberg <westeri@kernel.org>
Cc: Yehezkel Bernat <YehezkelShB@gmail.com>
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
Acked-by: Mika Westerberg <westeri@kernel.org>
---
 drivers/net/thunderbolt/main.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/thunderbolt/main.c b/drivers/net/thunderbolt/main.c
index cf51b9c39f4e..e36a4e1da05d 100644
--- a/drivers/net/thunderbolt/main.c
+++ b/drivers/net/thunderbolt/main.c
@@ -316,7 +316,7 @@ static void start_login(struct tbnet *net)
 	net->login_received = false;
 	mutex_unlock(&net->connection_lock);
 
-	queue_delayed_work(system_long_wq, &net->login_work,
+	queue_delayed_work(system_dfl_long_wq, &net->login_work,
 			   msecs_to_jiffies(1000));
 }
 
@@ -470,7 +470,7 @@ static int tbnet_handle_packet(const void *buf, size_t size, void *data)
 			if (net->login_retries >= TBNET_LOGIN_RETRIES ||
 			    !net->login_sent) {
 				net->login_retries = 0;
-				queue_delayed_work(system_long_wq,
+				queue_delayed_work(system_dfl_long_wq,
 						   &net->login_work, 0);
 			}
 			mutex_unlock(&net->connection_lock);
@@ -723,7 +723,8 @@ static void tbnet_login_work(struct work_struct *work)
 		netdev_dbg(net->dev, "sending login request failed, ret=%d\n",
 			   ret);
 		if (net->login_retries++ < TBNET_LOGIN_RETRIES) {
-			queue_delayed_work(system_long_wq, &net->login_work,
+			queue_delayed_work(system_dfl_long_wq,
+					   &net->login_work,
 					   delay);
 		} else {
 			netdev_info(net->dev, "ThunderboltIP login timed out\n");
-- 
2.56.0

