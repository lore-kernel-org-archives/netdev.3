Received: from mail-vs2-f43.google.com (mail-vs2-f43.google.com [74.125.227.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84DFD47F3DC
	for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 11:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789470870; cv=none; b=raDO0NEJVrsDlo5Z9ZG/NnA+O30jZTm48h82e/Bj0twJfOs2mJ92/0qfhEdh+wOZ32O0cd8vykRqaPWILvgTIsgKlxclSjksEMi91Fv3rEqWpoNqUmkzaGsUCI3igB7acW3c5vk7Hc5swz23T1Jpwwhhfx3L6LsmFL5a0mxtDlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789470870; c=relaxed/simple;
	bh=/oB6vaOXGg5+3zOLKgYNrRDA/rQtpvhIZtESt0iNrCU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bKsTs/NuIfSGdOj3nVtVvAC9DqL4MCETvrdLDFaY9ofaVYlcfDyqx5YGVXF5SEHttx9bxYysupR7tF/gYSKTS58ziBQuqLbdMhVoVw7k1Df93fwg9MdREuOgasK9I/n68Y0picL6ePGOHKrC6zcAqDVHVJyhgDf/PMGU4AVSTvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IrFmsY8V; arc=none smtp.client-ip=74.125.227.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IrFmsY8V"
Received: by mail-vs2-f43.google.com with SMTP id 71dfb90a1353d-5c83be8db39so2412192e0c.3
        for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 04:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789470866; x=1790075666; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=FAuAan9y645zprFQBzGcUeZpc28nMxYe+p5U/JKA+9w=;
        b=IrFmsY8Vm0oNl1Slv+vA+t2gkkYrXCSzo7+aq4bNg73a8fCBGC62P1o8bRgzt42PAA
         QfDAm3zXPzDF3CaKfFaL7eiB/gUD7fvfCWOMpxqSVRPHo597txkiRUOmb2XZpfEIN6PF
         giXqxEPkPfz2X7YqXc8XmAtZCJuTiuUDlJp8XCNz98vbTFEnHAkLHj9mEKUd6ZapdDX4
         5iDyMK+u+ZyZ2hgx8+mMhm3zHNCt7FWw629UZkpfU7zKt6MsZIbS6/o0YKzx72Y5wPLT
         zZCpuq7WXyOQPFTyE3iLd/QjUb6VOMyIdd41mVFcfXFS2+mzy7knUk0S6kz1HDiiisj8
         CAvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789470866; x=1790075666;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FAuAan9y645zprFQBzGcUeZpc28nMxYe+p5U/JKA+9w=;
        b=1C/NtopbUUJ81jdP7T5mjXtM/KzdcUhgIbVWHcKYJtrIkWaId+ZJYznMCpps0thU67
         dCRre0J+iTqqX+fLOCzrBKVi0ThOOS3sAFwU08qK6GIMAa89/iVss9KYEr5tZeMcaSrn
         2hbr9ITeA8p1LxuLM94VNv3Pr/moxJSsI++ARcmbwTsw3DO2VkntWk3RjRzUNUzug0Ru
         12o+O7O+jOf65dPKu9BMRpFH2gdgXMfmQQfi7MHmgXgndN89FL/GWqGf8NtaTStfvUQJ
         z2A7i4KzIngy7TMwiJ2w6pQ8IenMebSdlRg5OXno/F3gkAh5ZCseXtsMl9EbJmRObEPI
         bS1g==
X-Forwarded-Encrypted: i=1; AKwUvByFZeawp7IAfq+iO/h1jcJFoNmW8VGh09sQ8NbunVGDfOHDxtQQ/6KFj4LDbgRk2X8ciaJ6pCM=@vger.kernel.org
X-Gm-Message-State: AFuF++kSwcoik2oqx94mj9gl/rTR1bjh4N6qPYOKaR+650y14nHFQKU/
	5DKYwuI7NGtkNbLM06aT6aIjOscLR5A4e7p+8ShK6istRrm3eJbDSMLk
X-Gm-Gg: AYBFou11/dtkUS9Zib1oOj/MHIxo/4XvH61m167THcrjR9oTmbaSmBzxPf3FHMEJ7Bt
	3iE4NzvHCJA1wmyzoOVON4wtCd+29z66cFN7MBv+lyR7O/HlWt2Vs1hX7geY9PyRHCuvDWGJt8m
	ThCg+XTvC65nvAzTRerfFRnpuukD/g/1WGB8HiUoV8qKAPbgvrhyo5KBrCMXRgPuNQYNAxpF4Ss
	FfJYDWtZdQj9iJ8x7z3pMAz24Af0Lp2zoWQYU4WdDXBNuK5/eC5X5paZfjVsfgHAZS/HRsMfBTE
	4a61DUGE1kgbhjJ5HjLr0PPK8qcRuUtKy+lwHraRrP7wBxWFs+Qb903OugPxbPDvYRAMwB6lFH1
	uM50nh1JtuTFWBAFu6A7ei7LdiiebVrZ2u7MIlMWOsRF2m4L/9KI4pL/3jhwMnM9POUayUNS3z9
	+IJpJLALwpnAjDL7ySSCtyqfe0TS9vtRBcWCGLHUO+7Jtv9U2Ogpfk/PZxkrlHOWl6
X-Received: by 2002:a05:6122:894:b0:5c7:ebed:1018 with SMTP id 71dfb90a1353d-5c981d87e33mr4414877e0c.8.1789470866398;
        Tue, 15 Sep 2026 04:14:26 -0700 (PDT)
Received: from beelink.. ([187.13.206.89])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5c846f76238sm14577407e0c.2.2026.09.15.04.14.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 04:14:26 -0700 (PDT)
From: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Aldo Ariel Panzardo <qwe.aldo@gmail.com>
Subject: [PATCH] vsock: preserve child namespace mode on an empty write
Date: Tue, 15 Sep 2026 08:14:17 -0300
Message-ID: <20260915111417.2726515-1-qwe.aldo@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

__vsock_net_mode_string() returns success without updating new_mode when
the write length is zero. Its caller then reads the uninitialized enum and
may permanently store a stack-derived value in the write-once child mode.

Initialize new_mode from the current child mode so that an empty write is
a no-op.

Fixes: eafb64f40ca4 ("vsock: add netns to vsock core")
Cc: stable@vger.kernel.org
Signed-off-by: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
---
 net/vmw_vsock/af_vsock.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index 622dbd0467..61163357ae 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -2878,6 +2878,7 @@ static int vsock_net_child_mode_string(const struct ctl_table *table, int write,
 	int ret;
 
 	net = container_of(table->data, struct net, vsock.child_ns_mode);
+	new_mode = vsock_net_child_mode(net);
 
 	ret = __vsock_net_mode_string(table, write, buffer, lenp, ppos,
 				      vsock_net_child_mode(net), &new_mode);
-- 
2.43.0

