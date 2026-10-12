Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A0243D7D74
	for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 09:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791798922; cv=none; b=ZZhEqRBKKfBxepM0TG4XF7mUqV/7qFuuj5O27IJWhv2pCz/YXOiSK/iO4gbG5HrZm3gOzZ3fVXm9N/zji2Mhf9PCG7eKqTFSASZk+gAT1UOu5mtUTaEUA955SM54oGeLHQI0fCvlg0CzkfM7R6Fi/25z4i3eupSb/K+R6kVcCW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791798922; c=relaxed/simple;
	bh=ARn259GPopKaQ1nz80eSAsTTBgPnnvNnnQsFuBBTrVU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C3qZK82LG/uTvSTDwDnIm7pSHG1dh9T30yBhimzFsomgW32mJjonwjghBg9lCnZano2bs0APAQ8bVx7Rw1hfc7NmE4FppA8T7bVt98qsTp44ORDmqP0QfQC0fGWJ0qMSGDWsfkkFFrJxOCDvIbGd4ZH4y3GvrbKiYG88tdEXNfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=N5p/Z+jn; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="N5p/Z+jn"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-48af27fe287so1436000f8f.0
        for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 02:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1791798912; x=1792403712; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0CM5VfsqOao7iGtSvqmBNpy0L/RVrXCLn8weNJqgTC4=;
        b=N5p/Z+jn7o58pAAUKfKnEQgrV6Af09QVVRF1tv9/R0n0N+P9ywatrp8jSY8UqdnRV6
         CjCXD8ZnWiyK+3LcuyMb2OGn3fCMuCjijeWojZK7wgbt9n7cGEHszkcoSfhMQO9iNChu
         9/ejjevxQ739ofrj+v0S5JfndTavuoWD2g3RPiCAipt7m21DAOBZZcfVEli0/53kb8mt
         OFe2DKAEYBEqSp268EReC/DzFLnQV7ZKwUqHMdAI8xFeC2BHU5F2SAonTAfmfZ8xp158
         owZZ8k/rqBbStYzx/CDVTD7jpB4LqivZA2T3bSOG0n67+vLNZaJsmWLoa09x4rzaoSvW
         kmbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791798912; x=1792403712;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0CM5VfsqOao7iGtSvqmBNpy0L/RVrXCLn8weNJqgTC4=;
        b=hBd+i83Ao5DW6EY6ZoQQom3kw07N8KmZPIfFSHvy/rSSWcfGBNuwg/xRvr6VEDPQ/Y
         NUe69Ed3GXYWaP1lRAxqKdGCprVc/PPlMJcW10n0tE4uDzc7lQolGaqZSAw8OeMOFFdT
         NTS7eafTf6Rdq+lKsOTAqdD6O6J0++tSS/HjfP6bilQ1DjEXffd8LZ5vh6p0xGhhSaPH
         6Yhrc91jyQw0fGpwV9/n4SkOkK6BRgKC9rVLEla6+nX38xAUIdNd8rTKu6up/sWmd5O+
         Id3WhIHfxiif4ERX9FFb3jdD+52Rr+0Zp1YbAt/6yka0ErGLXeFYuAhauBSRQNgxcm4x
         WVbA==
X-Forwarded-Encrypted: i=1; AKwUvBzLHRN/QZcdy3wnXyjN4uTR3oOaFrHGsHOZgEdhNiEAhXK5E1F9Zl5u/JGujuvUoIqOIzBUpOY=@vger.kernel.org
X-Gm-Message-State: AFq9FYJUVwtCTTy+zqFp64x5BqM/G7yRnDdzmLMqka3Sl54xy25GQe0o
	QTRNMnWh6SBrXAADaKVn5QxPFM4P36TfnCKgbvizOz+afZCUV+cpp0kTnCjttmlUqm4=
X-Gm-Gg: AYBFou2lHd7OhJ8hfciqHBRxHJWAtE9CHGfctkKOY5p6QuLYh8oSo9/ud47a2KrdcAc
	EIUyVv9NsdiUNeq3rlimuxtJnbOwHsxjDQgcqpDzCwpMNJ/ZiOSnwvXv7ddHYBlh5IYkzMEbVsA
	HJ3Sr+qG8LJSbD8eNp+1McmdisMabsM1DEniS0S7iFBPDR35DmkE/uNOrsoAxfwH3KQBW4g+2R5
	HKTu3TBlaX9AK9WJo61zhAClUCnVTur9/eC0DW4Vr8VPy5QBmtQNgzvPEwp0RU4tPaJGn1+zrlf
	Sd5TeG8ovMvzSYGWH+7TuUp8q7jV1wQ5w/uerulJ5SJR5BIpxaIPhNwPy/gVLXvAZmRIYLTC5S8
	8RP25cV7xd7ew9daNO8YArAOVUTX5uHdwhm5pmQUBmPQgbJuo414tya0ybcgzsmb4wI8FE0WdOi
	tuVitMwy44ZeCWa/dpQJl8V8/calFL//nhrcIXsf6HewPxKfbmka2GNVxFvKUQ3vhPXMuvVFP4d
	NHMQzetodu6qSFFh80+JxGIvuBCLGq6Rw==
X-Received: by 2002:a05:6000:24c8:b0:48d:bb54:779d with SMTP id ffacd0b85a97d-48dbb547a7amr16282034f8f.9.1791798911237;
        Mon, 12 Oct 2026 02:55:11 -0700 (PDT)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48db98c2800sm18539103f8f.26.2026.10.12.02.55.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 02:55:10 -0700 (PDT)
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
Subject: [PATCH net-next v4 4/6] net: thunderbolt: Move long delayed work on system_dfl_long_wq
Date: Mon, 12 Oct 2026 11:54:43 +0200
Message-ID: <20261012095452.135828-5-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261012095452.135828-1-marco.crivellari@suse.com>
References: <20261012095452.135828-1-marco.crivellari@suse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Currently the code enqueue work items using {queue|mod}_delayed_work(),
using system_long_wq. This workqueue should be used when long works are
expected and it is a per-cpu workqueue.

The function(s) end up calling __queue_delayed_work(), which set a global
timer that could fire anywhere, enqueuing the work where the timer fired.

Unbound works could benefit from scheduler task placement, to optimize
performance and power consumption. Long work shouldn't stick to a single
CPU.

Recently, a new unbound workqueue specific for long running work has
been added:

    c116737e972e ("workqueue: Add system_dfl_long_wq for long unbound works")

Since the workqueue work doesn't rely on per-cpu variables, there is no
obvious reason that justify the use of a per-cpu workqueue. So change
system_long_wq with system_dfl_long_wq so that the work may benefit from
scheduler task placement.

Cc: Mika Westerberg <westeri@kernel.org>
Cc: Yehezkel Bernat <YehezkelShB@gmail.com>
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
Acked-by: Mika Westerberg <westeri@kernel.org>
---
 drivers/net/thunderbolt/main.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/thunderbolt/main.c b/drivers/net/thunderbolt/main.c
index d9fb587a62c5..59a4dcf719b8 100644
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
@@ -722,7 +722,8 @@ static void tbnet_login_work(struct work_struct *work)
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
2.55.0

