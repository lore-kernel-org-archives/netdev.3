Received: from mail-oo2-f7.google.com (mail-oo2-f7.google.com [74.125.231.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 113ED204C31
	for <netdev@vger.kernel.org>; Sat, 10 Oct 2026 06:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791613855; cv=none; b=ZXF/lCPMeqO0OWSzbbHT6Bg6oZ7ICTNmKEFDMzjMwT3XcT3k2ZHF3C5DYlziRxkABE2lHFwbuBlnZxOONb0JDrgZ1H2luvfw6a3SQEaS+U2KV9t0gbyVPygk+y8E8WWqyk7u9QAq32B6s56d1/PJt1domtbdcllZ6NuroSM5YXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791613855; c=relaxed/simple;
	bh=UU9e/DIEZIoiwv6BQyhSYSDdVEcIQaOzjBs1CU/yQjM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MP83xvKBHKf4P0YtM3E7NbR4oUnL9h7s5iHRZsKqlNaaYWIP/M2DNA5bphE/NqbV6EQrCmmOh9w1fLkWEsW4T5CQrgPNyjbTqc9165MbfUBh7KHa+2G2lr/r4/3UhUcsfCKAulI0JpnEhcAGTVJTl7XTsYwC9IPDNPvYQoG6ZUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pH3kI7BF; arc=none smtp.client-ip=74.125.231.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pH3kI7BF"
Received: by mail-oo2-f7.google.com with SMTP id 46e09a7af769-8210db80578so173988a34.0
        for <netdev@vger.kernel.org>; Fri, 09 Oct 2026 23:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791613853; x=1792218653; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=2I0Ul8sPqzlVU5TVserEHspod34j/pr1dNRLi4dN0Ck=;
        b=pH3kI7BFeVA5H+GYQg8ysrhbUtIzrHJX1PbHbS4EFoSc2Lr3KKuxHX5+Qs432mKTVu
         zV6VgvHnABIlQoC2zrGMkL08j0AHvJwmDf2znz5CwLTsU5fqdNNM+YHx8ukl3THN+yiP
         LeFnugd3zVNcObeOgQsjJAeK1Oq6+TMCB59qUZJLjijHz0MbCRsROOmc+P3udQFKos81
         dZDeuxbltJh35bxDpff4puLluI3/ihEnrTAPdtzAWUpw+Y8aTKSE751nXM0+/57ofuYd
         Ue8HeT7QL7DwU2/JfWVuCeWJ3fdgGsCMreuUVJcOXYU7ghOSohrKTD3/H8mmbH32hAYS
         FiiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791613853; x=1792218653;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2I0Ul8sPqzlVU5TVserEHspod34j/pr1dNRLi4dN0Ck=;
        b=wU4A84z1pS36rdFwbY8jmJIGjrq1mZ8fFGmLJ3cDOhyiwoiUE2ybBCsNZ6bc3Qr+BY
         gxZqSIeqcfIgxD385JFeievKiuTS1J8S8aVmw4zUOWEaJWnhty0FSrp3llCH4/g3aRxU
         SdBwVAXdipVj4U7VnYv5HJTwwn1EjM462gcSxiQKkQdKEKRrNVeeLCQma2z+vgmHy/rZ
         4d/eDDRAmD2AIAVRd6uOEmLntxS8nXAJM4pKbyWcF1ipBWdWVkv9fVBCjeqZeM7Rusjr
         3hXApssGAQL/UBZkfSDc7nR1SIt88D6M2LwQrdcXe4NTopwfCI6HdlCsUw3kyfksU1sn
         VChA==
X-Gm-Message-State: AFq9FYIxDq2dVZokFiyKLrBRgSTTuTf8//RGV7IwhPV8LruAHa4dU6Wy
	xWc5tArBgSf0WDnK9pnxTRJnuqhsgKhYJ63P+wIn39bYrVjNblSk+sZQ
X-Gm-Gg: AYBFou2NE5z1Az7dKKQVYYhsMeZ0FVurJN15FzZjQbwPHpxPMQ68mt+X9cvr1NVaesI
	yEg+qYDA2bmQDq9tiPfLp7Lk7xpUAzfzMjijUbI1fb50BqiD3zb2gsA5OFKH7vjI/o27TUEkeWM
	gaff7Pe6yiDsOfB2PoTZfH+VYH9nDqKbx+anJ54/Ms5aMFCtF56ScfYtFQXkyU8pralnhuHNvv5
	mzJh1XkaoX92VEYeaixbXs+okP8G7yqdlK9eZqN4MsuWA5u6F3+p81WiomaQC01l68br18iOqzT
	//mhz92GcviJQernBTQGtJi0oQs7TTb2ra8G8aIDPpAvGY6GAMZ5yuVXvsZ7nDTvs3OkVY9nc1P
	/tX5cKz/TL/TASvHYWQSOjRc5TUNU5EvEzrw/QO+JjWfpOkbS5OlcCq4OgczXdQCHDazuNVEyvd
	1+hUObu7dmLfh/qXUyk9icwo7xhTMp8mVjOGIFjE7r9RzpxP4bMVyGl6chJ/tW3xsKk7R4sJPX/
	dLPp/Cau8oqtQopgN4iuAgBifiVxOkDsJcMrUGhsOISJh9a
X-Received: by 2002:a05:6820:16ac:b0:6be:354a:1cec with SMTP id 006d021491bc7-6ef0d333abdmr2941085eaf.27.1791613852696;
        Fri, 09 Oct 2026 23:30:52 -0700 (PDT)
Received: from localhost.localdomain ([14.116.239.38])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-8303a328da8sm3999286a34.24.2026.10.09.23.30.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 23:30:51 -0700 (PDT)
From: Henry Martin <bsdhenrymartin@gmail.com>
To: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Henry Martin <bsdhenrymartin@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net] macvlan: require lower-netns admin for IFLA_MACVLAN_FLAGS
Date: Sat, 10 Oct 2026 14:29:44 +0800
Message-ID: <20261010062944.2671656-1-bsdhenrymartin@gmail.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 5b782a811e73 ("macvlan: require lower-netns admin for shared
port settings") added a rtnl_dev_link_net_capable() guard to
macvlan_changelink(), but only covered IFLA_MACVLAN_BC_QUEUE_LEN and
IFLA_MACVLAN_BC_CUTOFF.  The IFLA_MACVLAN_FLAGS branch performs the
same class of cross-namespace operation: in passthru mode, toggling
MACVLAN_FLAG_NOPROMISC calls dev_set_promiscuity() on the lower
device, which lives in the parent netns.

A macvlan device can be moved into a child netns owned by a child
userns; root inside that child namespace (no CAP_NET_ADMIN in the
lower device's namespace) can then flip the parent namespace
lowerdev's promiscuity counter at will.

Extend the existing guard to IFLA_MACVLAN_FLAGS.

This issue was discovered by Tencent CodeBuddy Security.

Cc: stable@vger.kernel.org
Fixes: df8ef8f3aaa6 ("macvlan: add FDB bridge ops and macvlan flags")
Signed-off-by: Henry Martin <bsdhenrymartin@gmail.com>
---
 drivers/net/macvlan.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/macvlan.c b/drivers/net/macvlan.c
index afad90b9222a2..d30cffddb1e1b 100644
--- a/drivers/net/macvlan.c
+++ b/drivers/net/macvlan.c
@@ -1641,7 +1641,8 @@ static int macvlan_changelink(struct net_device *dev,
 	int ret;
 
 	if (data &&
-	    (data[IFLA_MACVLAN_BC_QUEUE_LEN] || data[IFLA_MACVLAN_BC_CUTOFF]) &&
+	    (data[IFLA_MACVLAN_BC_QUEUE_LEN] || data[IFLA_MACVLAN_BC_CUTOFF] ||
+	     data[IFLA_MACVLAN_FLAGS]) &&
 	    !rtnl_dev_link_net_capable(dev, dev_net(vlan->lowerdev))) {
 		NL_SET_ERR_MSG(extack,
 			       "Changing shared macvlan port settings requires CAP_NET_ADMIN in the lower device network namespace");
-- 
2.43.7

