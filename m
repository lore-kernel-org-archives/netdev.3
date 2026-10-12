Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1D4F47CC6B
	for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 09:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791798925; cv=none; b=sDBAtruFP/f9i59LoLb7LyQvoQ+ZnD5iQJU6KaUbwYjdxhPah75eoq8ri4nhkEZmEs2P7Pxu+T68RRqRApUDYPcuw4XNH3Dm1bsICNQsmUtSnVq2VdbmdND/+O6dTj/P1OlsNTY6sKCx/Ox1taHbDgiZBEuw3/8tmbGOcvxDG+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791798925; c=relaxed/simple;
	bh=BnrYo/A6G2OaUvK9kvg2KfCzfxVlIgzJGfpX6upOnUk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=szng5wi1gcB7PvmWPCvnw6FoJBWLHr53HwOFPeYaOrxsGrCtjNiNEsufPAkqvPGtjXvICLf/clMNSClDuWCA5rSNuM5cEwpgYN/tnBoCZgsoSgtOEvUxEFjSn71SN+eTEA8K+MkJ/DTGlXMse/p9lOqs5LK7CgjRKuO0iVNhiU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=OCErpna2; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="OCErpna2"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-48c4be28b82so1617111f8f.2
        for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 02:55:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1791798917; x=1792403717; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=YT1SExoYLuIMwneaSCPvUsBJ4hnC+2ocE7ZXG4QBttQ=;
        b=OCErpna2ECroNC3rlatBilK0R68Ons075WiIqwHU2rgk8R0PvF+wRB68DlPzgFh4wu
         7fvA+Dbr1kVuw/3FkIfYOl8h2claD6YsU7iOSK9pju6WbpjpAWX19gfetwA2tW7F0NPW
         mxpQ47LeJjjR+flJ8W2JBSVe1RBuZaAsh8ErYMqzgYkMme2WuuQv64OtZF3E1iSaAMNS
         IC3h7vE5d7ji2K9cFsqdD/bwa6pvpmgQQqu0zJ5gBoaOyN+pKLRx6zyRs+/VPC48UuPD
         eWfIwq5w+x+bg+lKK20uv0gxcCoXa5D92Ub7ivWHuH8mW2IPMoFToUFpJYPiEfh0ZUxN
         rkCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791798917; x=1792403717;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YT1SExoYLuIMwneaSCPvUsBJ4hnC+2ocE7ZXG4QBttQ=;
        b=R2BtOiT3fZmFbFtTB1XXF+9JYFMd1mp6fnlzY2CNTWiW4ouBkMCgCtfsE1PaPsAwOq
         u5UnfyF8F/f5oUvkFnD60OvDiHyLkuGyk563OeImt1oEmhZbLLovmfNENdGEy8kqKPzf
         YdXTALODUdg/3U7UKKPdgmgZxnLYFPETlDCxs0TgroVvvK15F4da3wqaH4/905ckuFM0
         i/o8KXdztwFV11B8DC63glpcGd4RuRRZTfhZxTn0959RBSPqXm36vKWn3INNmwcCqjYe
         b+T/E8Sb1RTEQEnOgBHWDdZlz8TDcCsqgohEdtWFZe04tmF/C92QBlJwX4lvPGPj8Mxo
         9cKg==
X-Forwarded-Encrypted: i=1; AKwUvBxnRh9fByzezA25s2t6sDJU8XuKPp/0hon7eGv2nsSNt7p/4v2QyVMX4KH/61nE1mwl8Y0oTLo=@vger.kernel.org
X-Gm-Message-State: AFq9FYK6ETPsLifUHyaUdBWdkfCEKKiZxQx7gw6WWo6fkoU+s+GJ3ysQ
	MN3B2pzFD251yV3Dnt8tG749FEsNBXUeYVVQKBh/5n5luTjxhStGJ+B3+52crMnQkqo=
X-Gm-Gg: AYBFou10FzJTMOPAXqqou3VwKeI+ax6OhmE+3vvP/YoMUGh+KMeeTiMLudZrF2MwVEO
	Fi2SecEB2CaLaBjYD/I0ic3Krl+iNq5wgAcmhMduuaIwGVzhwV09Ggd0mVC6mPA6AxUCkFfaHUm
	WPZ62gJRCSHYuK6Ltj4o9gu/fu3o5F2SfGozgC3TEKD15f9B8C/+RKzcaz1kLXj76VjyZ3sMaus
	NZL2RSK9wOhyWAI0ZumqNECh7NCzT/LmzlL9T7rzipL+Bt0UWxt5PIowgtj0butwuaVMeKmI+vV
	mC/fSGYGSNbtQznhmNWZsd+s1VB9AdeddfBT0jeRPM5LC8QEnveNlYBqfMGw8KV0PkKgOxsIp7y
	DfkqChDrp0LqKwXXmjDaNNzhpD0IEvtK1NcwfILsg/2jdLnes6s5a5V+iOqeF1U2ljeZlkr+c5y
	BzswHMsplEjrmNueF3zkrjLffR+s/3zvp84l8n4hu0KUZZ6njxGMDeLNsarGKpycLQQcbCoQcqm
	jzWJufRJFXGB9PuLjCYUw==
X-Received: by 2002:a05:6000:2505:b0:487:27f9:840 with SMTP id ffacd0b85a97d-48dbace65bcmr17485319f8f.53.1791798916694;
        Mon, 12 Oct 2026 02:55:16 -0700 (PDT)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48db98c2800sm18539103f8f.26.2026.10.12.02.55.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 02:55:15 -0700 (PDT)
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
	Ethan Nelson-Moore <enelsonmoore@gmail.com>,
	linux-usb@vger.kernel.org
Subject: [PATCH net-next v4 6/6] net: usb: r8152: Move long delayed work on system_dfl_long_wq
Date: Mon, 12 Oct 2026 11:54:45 +0200
Message-ID: <20261012095452.135828-7-marco.crivellari@suse.com>
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

Cc: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Cc: linux-usb@vger.kernel.org
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
---
 drivers/net/usb/r8152.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
index f61686433031..f6af66f294db 100644
--- a/drivers/net/usb/r8152.c
+++ b/drivers/net/usb/r8152.c
@@ -7072,7 +7072,8 @@ static void rtl_hw_phy_work_func_t(struct work_struct *work)
 
 		/* Delay execution in case request_firmware() is not ready yet.
 		 */
-		queue_delayed_work(system_long_wq, &tp->hw_phy_work, HZ * 10);
+		queue_delayed_work(system_dfl_long_wq, &tp->hw_phy_work,
+				   HZ * 10);
 		goto ignore_once;
 	}
 
@@ -8840,7 +8841,7 @@ static int rtl8152_reset_resume(struct usb_interface *intf)
 	clear_bit(SELECTIVE_SUSPEND, &tp->flags);
 	rtl_reset_ocp_base(tp);
 	tp->rtl_ops.init(tp);
-	queue_delayed_work(system_long_wq, &tp->hw_phy_work, 0);
+	queue_delayed_work(system_dfl_long_wq, &tp->hw_phy_work, 0);
 	set_ethernet_addr(tp, true);
 	return rtl8152_resume(intf);
 }
@@ -10295,7 +10296,7 @@ static int rtl8152_probe_once(struct usb_interface *intf,
 	/* Retry in case request_firmware() is not ready yet. */
 	tp->rtl_fw.retry = true;
 #endif
-	queue_delayed_work(system_long_wq, &tp->hw_phy_work, 0);
+	queue_delayed_work(system_dfl_long_wq, &tp->hw_phy_work, 0);
 	set_ethernet_addr(tp, false);
 
 	usb_set_intfdata(intf, tp);
-- 
2.55.0

