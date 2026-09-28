Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98C84376466
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 18:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790618473; cv=none; b=TUo7GJAal27Xvo5cmGMyQNmXq3kpW6wiBtdMK5nubY6Vc8QOh4xFd92rdcMVvC/ulJ6JfUkwoow7qd/auR6yxPx6EEK0V19uJQVF+aPaS5R61m31amR13qyFV0fuldfQ2VoL959WBAKOeaznJOhmQ6R+X67Tm50uDU2ggM1Mz1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790618473; c=relaxed/simple;
	bh=JtNlKuZX9/sU1bTMsVw4IAAFkE/YW1CXkk5G3Rh4M8I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LjWgnKbWQVX1TlV7132w2pW0sCi89kVNe3yH7zbOSG2NnyzXWZRz75ehA7qGqCwIPRnNmgjq+ZCazalo/hruJm8aLIJ3pjIuOWsjCNAKmh16m/CuTaCEd/4yrq0NHs2iwHEiJcmDu+uNtn2whe15Z2GUAkSzgEEdqLbCMfMNMaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P8QT1AAc; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P8QT1AAc"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-4843178b1c8so375991f8f.0
        for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 11:01:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790618470; x=1791223270; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nmpTVow7I5KawbWbjtXYLbBgNUQkJQlP4LemooUJQPE=;
        b=P8QT1AAcVWMeay1ltTYZ2pAaGyfYjiHAQe+xGTVP92qNHFhflp0nssY8Hg13sk1hMx
         X5AqN+kMJVBacOOl3t3zwYXSaj1cOTM56LWZnYa4pXZTDtz1VxVOtJOa4OgiKMbzIHCo
         1ksSkK51a+Z3GsM5Z5+0djS3eqoEv/b5tqm/5Z7z+DIpJuGiIH8Zx03stwoa2nuDYIoS
         xlz8n/p4GIFQjU6m9DAFET0WcYx8wWppzJKbjTkwrwgvLk2bt5PGNr3QMCUw+/mMDkj+
         GGWZTeBmkp3W/mQJ+TKa2v3W7Iz0mVLhlKXmvLh5tNuf9JjVmppQSWamLTjDLMEJcnxx
         T41Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790618470; x=1791223270;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nmpTVow7I5KawbWbjtXYLbBgNUQkJQlP4LemooUJQPE=;
        b=jKXtJ6HbScg1GfM1kego5TCsmw+5eTMv/HMOPFSefl5OPmA8/mB5qAFg51dZBAbAmf
         JwejFtw6Uoy88ArQ+3WkCo39rKuGN94mqkaLvQFCBAG49+0TXW8r9o9KVqFDE8DQeOoX
         1mnZfHvgC1ZDYwZwvSofjFpHMG8Awys75S+6UepP/7yf3IVGH7KiPHteqZOQnxWH5EYq
         XunG1LqSYTvQaSxgzX1JUl9U+WYYmLTlG6UE4Ws4dNkZQYDun052uFI5WWi/MNjycJA1
         edATMyNPA/ALdlDfI6PtsYx/DKCYMpxg08jMx+qJujHiFYcPn8VxJJGEW70N8XZ4E7ut
         KiDQ==
X-Gm-Message-State: AFq9FYI4hRYdotbbp8aW37/d9PUQGEQzeQOpw5vG9v1RqsylcpcBY1sP
	DgDtsZWIbxxjTkU4fvzupZTJUWCRmvk7tnMEqnO0TaJVMJCfQszJ1MvT
X-Gm-Gg: AYBFou2OjRhAs4q6r8yUgvl6C1WnTOV05TalALq+ygm4W6P7SBZNCUyhGLyZguEruFu
	hTVBsfjWYWkoJEMuXm1XoxFFIcxuYScw2qSemYBtXBaPOSX4pSUpxlg7hstERHqBh8nFWWfdv8X
	VyVu752+jhMJ8FXahGDeJpu8BW4cW0jFlqoLd6JYzkJoLtgQ7fGAm0JZDr2jwhzVIC2lQW6XYPy
	cereDp4sxNISqmU22gnvG3LBqmfsVE2Adq8RY7Xac/DkijQWwonSHTz0ldI4QqApwESjO7ItPaT
	oplIGNNEa9qvs1ABRb4acsLwz870D741JUUsg8eXBKAhm3slWw1+izjMqzxWQSqaUhXKpiHFdZF
	6HXQwnsGIkZEeyM366G7vrGj3dMczYKHunp/dsn+NC5t5UPehLkCvHnFtemQqqYJnRVSoB91z1h
	n8m9EaSzESMW6CNTeAl4UPUEUcOmz5NyDcZhFes8OwKPQrBJsKzFPL
X-Received: by 2002:a05:6000:2c11:b0:488:7787:4696 with SMTP id ffacd0b85a97d-4887abc29d8mr18917939f8f.5.1790618469651;
        Mon, 28 Sep 2026 11:01:09 -0700 (PDT)
Received: from localhost ([2620:10d:c092:500::5:c231])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48aecf40a8dsm4425649f8f.18.2026.09.28.11.01.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 11:01:09 -0700 (PDT)
From: Gustavo Luiz Duarte <gustavold@gmail.com>
Date: Mon, 28 Sep 2026 19:00:03 +0100
Subject: [PATCH net-next 1/4] netconsole: finish enabling the target before
 releasing RTNL
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260928-netcons-fixes-v1-1-bb5ffe5e698a@gmail.com>
References: <20260928-netcons-fixes-v1-0-bb5ffe5e698a@gmail.com>
In-Reply-To: <20260928-netcons-fixes-v1-0-bb5ffe5e698a@gmail.com>
To: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Matt Mackall <mpm@selenic.com>, 
 =?utf-8?q?Bruno_Pr=C3=A9mont?= <bonbons@linux-vserver.org>, 
 Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Gustavo Luiz Duarte <gustavold@gmail.com>
X-Mailer: b4 0.15.2

netcons_netpoll_setup() publishes nt->np.dev inside __netpoll_setup(),
then releases the RTNL and waits for an RCU grace period before
returning. Only after that does its caller store STATE_ENABLED:

A NETDEV_UNREGISTER event landing in that window tears the target down
and we end up storing STATE_ENABLED with a NULL np->dev, leading to a
null-ptr-deref in netconsole_write():

  BUG: KASAN: null-ptr-deref in netconsole_write+0xb9/0x7f0
  Read of size 8 at addr 00000000000000a8 by task pr/netcon_ext0/135
   netconsole_write+0xb9/0x7f0
   nbcon_emit_next_record+0x501/0x550
   nbcon_emit_one+0x10e/0x170
   nbcon_kthread_func+0x2ff/0x3b0
   kthread+0x199/0x1e0

Store STATE_ENABLED before dropping the RTNL lock to avoid racing with
netconsole_netdev_event().

Fixes: 2382b15bcc39 ("netconsole: take care of NETDEV_UNREGISTER event")
Signed-off-by: Gustavo Luiz Duarte <gustavold@gmail.com>
---
 drivers/net/netconsole.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index 267254f046de..7dde00eb8e98 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -552,13 +552,16 @@ static int netcons_netpoll_setup(struct netconsole_target *nt)
 	err = __netpoll_setup(np, ndev);
 	if (err)
 		goto put;
-	rtnl_unlock();
 
 	/* Make sure all NAPI polls which started before dev->npinfo
 	 * was visible have exited before we start calling NAPI poll.
 	 * NAPI skips locking if dev->npinfo is NULL.
+	 * Hold RTNL until enable is finished so we don't race with
+	 * netconsole_netdev_event()
 	 */
-	synchronize_rcu();
+	synchronize_net();
+	nt->state = STATE_ENABLED;
+	rtnl_unlock();
 
 	return 0;
 
@@ -589,7 +592,6 @@ static void resume_target(struct netconsole_target *nt)
 		return;
 	}
 
-	nt->state = STATE_ENABLED;
 	pr_info("network logging resumed on interface %s\n", nt->np.dev_name);
 }
 
@@ -1079,7 +1081,6 @@ static ssize_t enabled_store(struct config_item *item,
 			goto out_unlock;
 		}
 
-		nt->state = STATE_ENABLED;
 		pr_info("network logging started\n");
 	} else {	/* false */
 		/* We need to disable the netconsole before cleaning it up
@@ -2667,8 +2668,6 @@ static struct netconsole_target *alloc_param_target(char *target_config,
 			 * otherwise, keep the target in the list, but disabled.
 			 */
 			goto fail;
-	} else {
-		nt->state = STATE_ENABLED;
 	}
 	populate_configfs_item(nt, cmdline_count);
 

-- 
2.55.0

