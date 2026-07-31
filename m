Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 697853B0591
	for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 23:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785540990; cv=none; b=HdY2FDx+S/kvkmgb8XyF4/Uilg57pYjaZZhgXZyGZLSqBd/BuUUf30nVVr9qzm3tIn5bltxIf9BOuIbvjUR9/hEE5fXLd3+KAfAVaQYh5lnrqTujoQkZ3WF/c3K578KD8sKNGVCBvgdGxutLtpXqMI+myxiOWjijHb68z2EDCks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785540990; c=relaxed/simple;
	bh=QYK8WLkDehn0NGcwyXwvNHYq73sWHci4bNTcehdMdWk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ZhR+1QeEeksUILeQs4mGknfrrNaR3ld0mnxnwckeNwPVRzWLL8xNXZTd4+ALzQNWtgBFkse/LVpjtL5+eE4BG7HKJaz2qRUDTxB9ga5KV9VeOh0RAa/+bUwNcYpvpA+T9QpG1nerDrdqinuuqNpOX/NQghZGP9Bb0mtBhfwVb3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k/ZfGRJy; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k/ZfGRJy"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2cedda2ce6fso12799475ad.1
        for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 16:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785540989; x=1786145789; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=0SaMYRu6wc8EGbj4CgxV89pDWL6LLqMsE1gsbynFtMc=;
        b=k/ZfGRJyUZSsbA5z3z3wPDVHIlRl/kBaonJQP7y2I5m6cmLXvmz47a3h1IWj/sH771
         RHdXUhyptyZ63A/d6ftaHdvR+IfWeQIkPGs5/viRHnqrf10YbwSI66KvKLlmzMtie6un
         LRDJLQ+wcQcKijclP3Fm8GmWAnSYxe1Ihr8HHmfVrNY3lfqKAfC4blnZDpLvO5Bwm59+
         kriMG7w+TxZNSLmcifqSi2tYuKTZhISZ7HGvvKCZxDhugmIK7zU60BD6103iJZin2A/m
         xzEQYaLrzEa+vBSIdXJJHR0FxFsZcI+TLLiw01UeK0pR4dl75znSCDQeOOaAtTlrwAfy
         WOkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785540989; x=1786145789;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=0SaMYRu6wc8EGbj4CgxV89pDWL6LLqMsE1gsbynFtMc=;
        b=OK9mZD5GSQ5kdrO6Jl+DFr7djJavf8ZDfrep+JYOG8d7goqemLD8A4DrWmtuzyyBd8
         vnhYE2ExuxLmVkQv5UjaM5wHAqNtiveGUBn6lkU+YYBV6opBHw9MIo8q9EwsZlzSYtXS
         0eZbOWesSztk61CHsw6TzlOjgJAW9D0npntBhenp73Agwr9snVFS0dKej739cq7gzzVB
         viQqlWBzBA13GzCnM733ndUBhvjyAU6n7SdFMIveLwLE71Jqxom7Zw02QB6Z+c/U4OGz
         ncAQ1852BwQ7m0I0EYlcv3+q8G7noM+0qSlD5o4U72KUkIlmpN/Jp8v2M8apYhoPvuSe
         U7Pg==
X-Gm-Message-State: AOJu0YxIA4NB4d07ML5Ln1Ayet/dEY/KgMWPAiwkzHD/eHKXyd2zD9eS
	xXaCvk06c4oV8c9k6N0l3kIS3yif5PHoq95zCBALusAnvuAKBPCbaayXBFoV2LJ/
X-Gm-Gg: AR+sD10a8IEjwREH43sLdKfcQrBBFs2HhcurPKala5xWXERaccUb/CdgMKCn3RJcKma
	eVO1jetuEA3GXKfe4+iqaiBSVZAPUJtJYRn/IowphjWoxRX/Gon3KWYi2VUON8WVHHTuJRLkynM
	O8/viGNqBS5EhUEItj1Ur7DjFSKxiNs+riV1l5bYLlHfoj/yF8m5YQ+2jfVKfJtxCcablK56BVV
	3UlghLciEhtisJPP6WfFf30Fjx762gBDId4zVw6lKEex7UqBLXJwlDfQmUUv/QWQblnfBg1fqXh
	E0VTZ2euglJpqGHl3Ao8kGjvvFkyT+0PSXNY4HUkrmift61KobdNL1rR9AMJakN7OxYrK4Zbh7D
	/l2m3IVUBmwK2AlsHzohJBYE19snr8jWuxf+PvcWnfw0g1+vfCMs1kygknxq79CjvnhLh8pLIwI
	/vHBynH+4lEj6SFPS7+zQl0omdxXivoLSG+QlSVXidNt6jN7UD+d9v4Oiv0uMAAz7jNb9mbXsTZ
	QFwliI=
X-Received: by 2002:a17:903:fa6:b0:2cc:85a7:36ee with SMTP id d9443c01a7336-2d052462dc8mr17339815ad.32.1785540988695;
        Fri, 31 Jul 2026 16:36:28 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:41::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d04b120d98sm11355105ad.59.2026.07.31.16.36.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 16:36:28 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Fri, 31 Jul 2026 16:36:23 -0700
Subject: [PATCH net-next] selftests: drv-net: enable devmem TCP in the test
 config
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260731-selftests-devmem-config-v1-1-098014348d9d@meta.com>
X-B4-Tracking: v=1; b=H4sIAHYxbWoC/x3MWwqDMBAF0K2E++1AfNCWbKX0Q/SOHaixZIII4
 t4LPQs4J5zF6EjhROFubltGCm0TML3HvFBsRgroYneL974V50crvbrM3FeuMm1ZbREd9DH0GjW
 OM5qAb6Ha8Z+fyKySeVS8rusHlaTij3MAAAA=
X-Change-ID: 20260731-selftests-devmem-config-f4f843f0f0ad
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
 Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.14.3

From: Bobby Eshleman <bobbyeshleman@meta.com>

The config fragment already sets CONFIG_UDMABUF=y, but kconfig silently
drops it. UDMABUF/NET_DEVMEM both depend on DMA_SHARED_BUFFER, which we
can't enable directly, so we need to enable a config that selects it. We
use SYNC_FILE for that purpose here.

Additionally, we flip on CONFIG_NET_DEVMEM as well.

Suggested-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 tools/testing/selftests/drivers/net/hw/config | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/drivers/net/hw/config b/tools/testing/selftests/drivers/net/hw/config
index ed8642b68094..d89a9ba17655 100644
--- a/tools/testing/selftests/drivers/net/hw/config
+++ b/tools/testing/selftests/drivers/net/hw/config
@@ -15,11 +15,13 @@ CONFIG_IPV6_SIT=y
 CONFIG_IPV6_TUNNEL=y
 CONFIG_NET_CLS_ACT=y
 CONFIG_NET_CLS_BPF=y
+CONFIG_NET_DEVMEM=y
 CONFIG_NET_IPGRE=y
 CONFIG_NET_IPGRE_DEMUX=y
 CONFIG_NET_IPIP=y
 CONFIG_NETKIT=y
 CONFIG_NET_SCH_INGRESS=y
+CONFIG_SYNC_FILE=y
 CONFIG_UDMABUF=y
 CONFIG_USER_NS=y
 CONFIG_VXLAN=y

---
base-commit: 2fbade66245059c78daeaccfce13ecf499fffb51
change-id: 20260731-selftests-devmem-config-f4f843f0f0ad

Best regards,
-- 
Bobby Eshleman <bobbyeshleman@meta.com>

