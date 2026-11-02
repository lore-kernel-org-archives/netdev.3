Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793617047;
	b=JrkXmRR95rCA7y8wY48FAftvDeHY67zK/o/c1aMDO8m3zGBneh+wI01K8pmz4DhqvztS
	 AIAkpRQXARTKMhLuPRMXDecn4ESAD/1/L4idKAM0qZ+ldnHZ8d/LilTtXY0cd8RyEQraz
	 SjrIp+YU7f0oGk8dWjQ8pzX3w3HvH56mOntvMhVYeKxLB4jBVUHCWghiZj1bqiOPTmq64
	 uJ319Q3whP/L++MlGHW4PxtLnZj5lbXhVksyHXsIu4P0jP8geVMCYUMPGp6OsJ4SAezGN
	 gVfoBFU+4XRhwbI1X3HiZ27GwHxFBty0L5KVQStyXtulC9Z2rAiZye+y9EQj4vb+XBA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793617047;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=MEFT/ALM9DZEMfY5C0sSExRjEKJeRSawG9RBT+Nn+N0=;
	b=HubfPMZoOyJ2gBZQXLMl/8KzOXv/dZJCXHdzLjO/Qce2PZucu4WIrhb9p/AxwCVFQGJ0
	 EysCUmezmguPDezkT57pcxVFt11zs3KldmhYBPwHa2tGco1+wZ58rOa8jiuaYXKhxFmxP
	 UHpBlGWnQhOmWeTOktxLWbLSqDUoHnH+jpDrNd7RqJVrIIra0+cXVbEn1W89rUGEBudNN
	 FPXI18EFEWjr6FG90kCuMwdIgMORidLO6HfB8YiYxmIsTxkaTb9MjdDbKMg7t0qW3eV4L
	 A2BYyrrtU/RBMgrVl7/CQkcLsjCa2gYLlmwQaRpPtk1Hwc3Awb5iqiyCOXubFVngavQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.com;
	spf=pass smtp.mailfrom=suse.com;
	dkim=pass header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=GjvqH4h9;
	arc=none smtp.remote-ip=209.85.128.42
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 567E160A2639
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 10:57:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 567E160A2639
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=GjvqH4h9
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4a9a8d6cea8so36860875e9.1
        for <netdev@vger.kernel.org>; Mon, 02 Nov 2026 02:57:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1793617046; x=1794221846; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MEFT/ALM9DZEMfY5C0sSExRjEKJeRSawG9RBT+Nn+N0=;
        b=GjvqH4h9aGhgAoSu7Hb2JUpF6QSASqEQeq+hwqNF8rAdi4B1RGuYmTBOGlZaFM5lbb
         eZFlEKQ/Qc1bcKDNlP2XZ4KuWSH1kJJNmz3SJ0QbRgZ07MSeI9XX5vBeaxXV654ohujB
         B9C+DZ7RmSPqHVbWhoLWUJfcNThQnV/zCNq83jMLQXrhcI7+HmBeTuJ2onsCu/EvcfzV
         ZCdvzy1/n2iXENo9S7ydG3iGzMFSm0hC+p0++qyHZpXvYtvzLHYZ700+VMdttyQzDYFg
         KEflxHKonheMJhbqaiaAdaWrnEwK1hTdkgPSMJpfrvB7VV4kR6/6SIyh87R8AQPyFQFE
         ceYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793617046; x=1794221846;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MEFT/ALM9DZEMfY5C0sSExRjEKJeRSawG9RBT+Nn+N0=;
        b=1/F3YqdZyhgyQs1pVrbvspj/L5jWlMxoH3EUiEbAUqll3HX1cpzICmL17EE2IbYy/i
         jKM7hzvHyxIbxnhJPa/NE485EFKySJ8bp26bSJm1saJMc0AAGbBUeYdKclN+tkcO6+R4
         0xpIRMDgeuJ9emDM3cmAz2AnwfwSSs3SaD1QvFWBFLWL19vHAmRCMPcmN1r1OnLUTWiy
         24YQ0rf03E7TlW9JKTTcc7pckGjbwDzL9+OOelk34SNvGGhOPv5R0QW9k3J4PqxyTI8W
         ijWOvM0yjrTCelPo45C320PmFjIctXyxUJsMnaJSznWepQCaxRoiPtFSpRtfAu7iYQYR
         HB4Q==
X-Forwarded-Encrypted: i=1; AKwUvByWrlNhlKDpyMcfRlMaC7lvL9TOxgqQSxQp25j+t0wpo0xCpR7TNYDZmJOchHjIHtX7Kg5hIYE=@vger.kernel.org
X-Gm-Message-State: AFq9FYJmwcHInDxtBAy8nOFRo9U1Hbo9WUr8lkzQs9mmgCf1f1re8mUm
	NvkLEWAXAD6JE3GXzAMjdqRHFDDLB9u2wRB3mAiNP+tjR+nBf2cwGbpCkrVKfKCOAwY0+7yyfW/
	IZxECtA4=
X-Gm-Gg: AYBFou2FJ2XdlxfhVHtPy2uY4VwoA8ezcn9gJiA1EqomwgCgIhoIClSJ8LAh0BTHWO2
	twh2xLZtAplbBvHpW4LsqJIlqzs+9Y/iuIk9LroSMjGP0lJhNhRwf1Eu/4dws5DTsx13otraX5O
	nTbuRsTpb1cQODtEpTtB+AXwq/sCVdxOZCu4acBol8BlaYYUmBGNCgbUMJZ9tux13DPoK2Mn96C
	uL6b9t2woi75nVx4t4RgecVWsyUaNzzgIctafqhd2VosYbeUa/dWlLPNbEfNau4TUnFMb6wvMW7
	/WMfJBeEeVoaoGNe7ngXqf18QPXwIKgUJw7/sgIJ86ssyWjvJezxJwTcGncnZncuDKe23D0oAOm
	pYxtuJAwWs35UBP/buXUBiU/n6YPIM9QY7QPGCDFfVobjQVNdyV2KE1HW7hMZyy6N9jtsoIRhrH
	P8Fl9hWTv2kfoEYoHaQNW3/s0iQMFILkPR8rgtEIP8d7EiKLv40DqEC5GRwOhC00sTN/5VHlEeh
	oBX0JaLBSWv6xD4cv0RamQ89hRgnSol0xTC9G6uEnIhqJegCZLdS4snUtW3jecZeXx2qlUiQheh
	dKpVZue/PHT1KAr70dHSfITY7tNRvsw4TOup43PSpL6N0PNpqRLI
X-Received: by 2002:a05:600c:8b01:b0:49f:c5aa:9ef4 with SMTP id 5b1f17b1804b1-4ac16fa4f73mr235301845e9.8.1793617045755;
        Mon, 02 Nov 2026 02:57:25 -0800 (PST)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4abeb77af8csm363171175e9.1.2026.11.02.02.57.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 02:57:25 -0800 (PST)
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
	Petko Manolov <petkan@nucleusys.com>,
	linux-usb@vger.kernel.org
Subject: [PATCH net-next v5 5/6] net: usb: pegasus: Move long delayed work on system_dfl_long_wq
Date: Mon,  2 Nov 2026 11:56:55 +0100
Message-ID: <20261102105703.111844-6-marco.crivellari@suse.com>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Currently the code enqueues the carrier_check delayed work using
queue_delayed_work(), on system_long_wq. This workqueue should be used
when long works are expected and it is a per-cpu workqueue.

queue_delayed_work() ends up calling __queue_delayed_work(), which, since
the work is always queued with CARRIER_CHECK_DELAY, sets a global timer
that could fire anywhere, enqueuing the work where the timer fired.

Unbound works could benefit from scheduler task placement, to optimize
performance and power consumption. Long work shouldn't stick to a single
CPU.

Recently, a new unbound workqueue specific for long running work has
been added:

    c116737e972e ("workqueue: Add system_dfl_long_wq for long unbound works")

Since carrier_check doesn't rely on per-cpu variables, there is no
obvious reason that justify the use of a per-cpu workqueue. So change
system_long_wq with system_dfl_long_wq so that the work may benefit from
scheduler task placement.

Cc: Petko Manolov <petkan@nucleusys.com>
Cc: linux-usb@vger.kernel.org
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/net/usb/pegasus.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/net/usb/pegasus.c b/drivers/net/usb/pegasus.c
index 68e4b6658dd2..a4ecfec290b6 100644
--- a/drivers/net/usb/pegasus.c
+++ b/drivers/net/usb/pegasus.c
@@ -1126,8 +1126,9 @@ static void check_carrier(struct work_struct *work)
 	pegasus_t *pegasus = container_of(work, pegasus_t, carrier_check.work);
 	set_carrier(pegasus->net);
 	if (!(pegasus->flags & PEGASUS_UNPLUG)) {
-		queue_delayed_work(system_long_wq, &pegasus->carrier_check,
-			CARRIER_CHECK_DELAY);
+		queue_delayed_work(system_dfl_long_wq,
+				   &pegasus->carrier_check,
+				   CARRIER_CHECK_DELAY);
 	}
 }
 
@@ -1231,7 +1232,7 @@ static int pegasus_probe(struct usb_interface *intf,
 	res = register_netdev(net);
 	if (res)
 		goto out3;
-	queue_delayed_work(system_long_wq, &pegasus->carrier_check,
+	queue_delayed_work(system_dfl_long_wq, &pegasus->carrier_check,
 			   CARRIER_CHECK_DELAY);
 	dev_info(&intf->dev, "%s, %s, %pM\n", net->name,
 		 info ? info->name : "(unknown)", net->dev_addr);
@@ -1296,7 +1297,7 @@ static int pegasus_resume(struct usb_interface *intf)
 		pegasus->intr_urb->actual_length = 0;
 		intr_callback(pegasus->intr_urb);
 	}
-	queue_delayed_work(system_long_wq, &pegasus->carrier_check,
+	queue_delayed_work(system_dfl_long_wq, &pegasus->carrier_check,
 				CARRIER_CHECK_DELAY);
 	return 0;
 }
-- 
2.56.0

