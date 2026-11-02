Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793617048;
	b=PSoYFnwrvEoKEgcO5s4EMF6pcBxZAE+saUTWCbaMoxuEBAb/lptKWzCBfhq2QSWVAQ5L
	 Sg8K3dXh7P6gVH3DuVhUtDm9LRg/wfaQsD9L7C3yfyImZsn8b+w+hx1Mq9kPwnklZVJgk
	 +w8sUUD7gPxtz4Se4Gc1ZFon0bTSbF3D3Xft125BEbNGBoNR1TN0oub7F/Bpw7gVPa3oD
	 Fao2j4z7Mj2FptJmjgImJIu/1QdpV3s+8re/leEvgAe8uR7XU4O+Hb5yk1RdQFuLivp45
	 7ZeQjqH/SV3dHG+Z+Fv56UP1XCtwR1TTro7Ia6XHKnYMgSR7u77TNBGHAGI0RUypqpA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793617048;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=VTSGFL/OuCHUOn2dSnsPuxyMOhqVaXG6DpAGnPdCD68=;
	b=wg6UxdwzATAVbZF4OFZZkIjzFSiW+3rJ9iqOEyH+HJSyI1+TjyeKl//Vk6ihVZCxKLty
	 l82RermszWzZc8hzOw6cIOB0ajzWUyOlaLlcPOWpwQuRf9yFdBirIGZUKHm9UA8/za5nq
	 n+Yq2oRYw+5r4vqNq+AJz0OOGbsEs9w7s6R3UEyeRIEoWvrlPyMgtfLGoRkmPFNPHCJCe
	 eS2sNlN6/EDqM/VK5tVD+t3Ffw1XRH+zYALCtc2n4BLguGgaplk8Scn4BAJ60lfEp+A9n
	 7F5pNiBY48b3+awKHyrCrfzDeBzOFx/QOZkat8NYh0saabt1mIjyTpWRBofYY+pcf5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.com;
	spf=pass smtp.mailfrom=suse.com;
	dkim=pass header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=FJMqbfoH;
	arc=none smtp.remote-ip=209.85.128.41
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B52560A380C
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 10:57:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5B52560A380C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=FJMqbfoH
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4a4dc547987so14485385e9.0
        for <netdev@vger.kernel.org>; Mon, 02 Nov 2026 02:57:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1793617047; x=1794221847; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=VTSGFL/OuCHUOn2dSnsPuxyMOhqVaXG6DpAGnPdCD68=;
        b=FJMqbfoHzmU9NBD5OFazlCTtXApiZl2pCDBFkJYEeWZp2zNjHrL8hIA+ErSrHlYIy3
         gPGruyieOAD6LhqwXujERZqWZBVFYI+UvIEOgn6cWVZbYyuuflU6FCmFyU1yzWUPK9F8
         k/638ZQuZvZ5yq9olZUMdCnfGbk4kN9pWZTyHVG1M3FzWjkjd8MXGQbAlNrpNkMzLkUe
         ExCh65HdON6dE/sKFRPxj88eHxM14/RiFdxDQ3UJDBTcccbtUquX1eBIQp6YsA2FkvVE
         jszA64F8slwC9nnNstEkvqCpiDgI/0l7pAZ5OtgdjF9wJO1Dg4uE51CBNQHYVaXtjutg
         EbCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793617047; x=1794221847;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VTSGFL/OuCHUOn2dSnsPuxyMOhqVaXG6DpAGnPdCD68=;
        b=zXWIsEtOE/QG/rD+O7nvGPtynJwl5uGwcoriklBZcHLhaSTduZpHw+s0//GuV6lIg+
         zQP57cyfZwHnvVY6wcVqOleBl2hxhyum7/VKnTkCLPp/sCnQ+Iwkzs6C49nU+x17rrC8
         T51O1MGEJ31Fe+GCOe1gNsnzQk76swuEULmwKl4dh3MI0VBpK59vEHSJkNHjW9mniA9k
         OflZiHHtQv7oHr8u8jNcYNfKDCKyLh5r1uwISZdfh0wED4hxfePXHwt2jEHuvSjymvgc
         QYIcZrPf7gG6bsUl0VtOosHjxWqX3d2b+FSeusV5kvQo42t2fk2YjcLg6oiQk32F+uo9
         GfNg==
X-Forwarded-Encrypted: i=1; AKwUvBz08Y0nf3dWze+q7gtUmeC8gBw1EuZ6TnrYyZChun1bdehkE+MXHmGEFeT6+vaNlaFndXr6gMs=@vger.kernel.org
X-Gm-Message-State: AFq9FYKMPV2427kiGhERtEqSzEZ0o+5UnxU7KcYYHMS/3xXnyYkv/nEW
	Sr3DtnDK30n5s9Ofq5Uxb3cNz8jUzSTHEsY+FH7WtetL02geVMYSNBVBjN/cf+NyfyY=
X-Gm-Gg: AYBFou1/BMsZcRg71aYirzx+TAd/FvNzqRP4NWn4DrkUanOtMyNTvzpzhnAKenygB8Y
	suDLuZaeZlaFWbSnP8ajXjzy41nrjgG12TU1RnvhAWj/4s1C3O2YN3MxlUXlji/oc0ZjmgwVHZG
	2H5B0/et0ViMIJJcJ/aid4dmMm1r/qnN9dUjUWJkgwEKGx2nOVpAppaRwHGCwvFROT613AA4rFd
	TCkMQnunxvogqWTudrJTGrVa3b0oEsFKUpj+p5mJWnpZa6QvxuBIYErgSs71rwa+KpUxfIjPROo
	txnzrWE5LzIJUrDbu2WT06+9N1tiOSUaFa6JZ0eRt5AO7naNdwtZpksrHbqXV5gp9nbsF/UyX4U
	jf++kZuaGb1aL5gQ0lhhY7yvQwgmiP8fKM932GvFIGRSiru04PcY6zXzsZGx167tt2lV6QnLgv2
	aHO6usVNb9h8LWmrTbze3QGJS9Go6JP0ispquHisOyr1LmoVqyAqFgpWefYeBn+/9cf/cfXtEXA
	Gb+E2WO1yiPpFruqauzKA7CWTYFpfTQI0QKa/JQlS8xA2diF3wLiGZSAnyP0ShR8UZrztdVMUPV
	e3t6Ev3V9NsZ6nKz6bwLssJdvCdtP9POFQ+5SXo7iCFxtOterc6q
X-Received: by 2002:a05:600c:a4d:b0:4a3:12fb:1ee7 with SMTP id 5b1f17b1804b1-4ac18c7388dmr247349255e9.25.1793617046786;
        Mon, 02 Nov 2026 02:57:26 -0800 (PST)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4abeb77af8csm363171175e9.1.2026.11.02.02.57.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 02:57:26 -0800 (PST)
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
Subject: [PATCH net-next v5 6/6] net: usb: r8152: Move long delayed work on system_dfl_long_wq
Date: Mon,  2 Nov 2026 11:56:56 +0100
Message-ID: <20261102105703.111844-7-marco.crivellari@suse.com>
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
index d3bb7ee9c9bf..4815235e8e73 100644
--- a/drivers/net/usb/r8152.c
+++ b/drivers/net/usb/r8152.c
@@ -7053,7 +7053,8 @@ static void rtl_hw_phy_work_func_t(struct work_struct *work)
 
 		/* Delay execution in case request_firmware() is not ready yet.
 		 */
-		queue_delayed_work(system_long_wq, &tp->hw_phy_work, HZ * 10);
+		queue_delayed_work(system_dfl_long_wq, &tp->hw_phy_work,
+				   HZ * 10);
 		goto ignore_once;
 	}
 
@@ -8821,7 +8822,7 @@ static int rtl8152_reset_resume(struct usb_interface *intf)
 	clear_bit(SELECTIVE_SUSPEND, &tp->flags);
 	rtl_reset_ocp_base(tp);
 	tp->rtl_ops.init(tp);
-	queue_delayed_work(system_long_wq, &tp->hw_phy_work, 0);
+	queue_delayed_work(system_dfl_long_wq, &tp->hw_phy_work, 0);
 	set_ethernet_addr(tp, true);
 	return rtl8152_resume(intf);
 }
@@ -10276,7 +10277,7 @@ static int rtl8152_probe_once(struct usb_interface *intf,
 	/* Retry in case request_firmware() is not ready yet. */
 	tp->rtl_fw.retry = true;
 #endif
-	queue_delayed_work(system_long_wq, &tp->hw_phy_work, 0);
+	queue_delayed_work(system_dfl_long_wq, &tp->hw_phy_work, 0);
 	set_ethernet_addr(tp, false);
 
 	usb_set_intfdata(intf, tp);
-- 
2.56.0

