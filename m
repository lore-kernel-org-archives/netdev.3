Received: from out203-205-221-210.mail.qq.com (out203-205-221-210.mail.qq.com [203.205.221.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D7E2476055;
	Tue, 18 Aug 2026 12:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787056905; cv=none; b=MtxVm5T71bQkbvFTJVg2cu/deX4qZJJWLIavfIzX29+vQwP5EjmnvS0gBjibGqOhJVDvtImlYPaZQyleoytDpyDnKJjQSuTgWofQQ0kVIx0WA1LAZRLF/4PnJiPypDrQbycM3UR4vTQR4ALT7s3gunsd4IC0iZRjOZURLuRnCnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787056905; c=relaxed/simple;
	bh=EbrL2Y5vKDu6G/4izU+FnB/fDgKOnGUSm45oGNGj0js=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=ph/JBlJzMXBh/XREVRUixlx3zaZMMGejrq0zYp3Mgh7gkjaEA5GvuGP55NPjn4ZRANjT0alyRjOUmePCg+8ljk/qCFBYtRZ0kzbM25mbxeBhfG47bZ2UTa4TywPU+YEel8MO/vu8huvFVvXhBUiQSQzeWBoy5EC3TQcV+zGdCms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=NNRNxsv0; arc=none smtp.client-ip=203.205.221.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="NNRNxsv0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1787056899; bh=TT+HmnjhmWRn/wTjrVXy3m5zwdT8z/iTRPZLoKJ8C+c=;
	h=From:To:Cc:Subject:Date;
	b=NNRNxsv0ILaBYa7lrIeAs60NY6CSN/C2p86OKt2xs7xQq2rVr2IK+hARcJ2flaq2n
	 HsGBkpv3FdvNhWSpRAbr6lNiD4Eqve3G5pdyhXpyVjjRzNfdXOWRl7rH9Vr7d1Cz1z
	 Or7+pwaZU0J00OMXF5O3mHg0eh3qmoLsl0ujg3G4=
Received: from ws006419.mbzu.ae ([5.195.0.150])
	by newxmesmtplogicsvrszb51-0.qq.com (NewEsmtp) with SMTP
	id A6383A87; Tue, 18 Aug 2026 20:41:35 +0800
X-QQ-mid: xmsmtpt1787056895tabc86jo0
Message-ID: <tencent_2EBD0396FF7A54CAD61F16E942D2E8FA3A0A@qq.com>
X-QQ-XMAILINFO: MDbayGdXPuoeNTkQSZDA+JZ99L28yBMYjSNBElyAGWxn2liY8d6deo3tTC+oYf
	 FNpiW/2iUIKHnWvCpYmedMWb2EX1DPRivnqNyXADMwZHwhJ+ZQLtYLbQ7YLR1kkMFW4RUKdB670c
	 MJ9UNnpzNUKbAktTO5YFA3jrQeMTCo4qbrFmx33xR7oMf+BCurU/n5S2g+AjIGVZGAarpULHbBsR
	 cv6dyztKQg+AufiD3CU2gB1J6V0TSm22EF2z6dolZ/NuV7eWbXMknsaeX2Tdw84PzQjgVlpOHa+W
	 bCeBubko+FjmKXitezXMsdkL6SrQ/kHiiI7nmimO814yVuB4D1UFW82brL6CDQJSJZzlY70YIeJ1
	 GMd+Gwlyl4+1IH0X4q+8XzTxqwtDuZofAezp8dRGMS4iZMmpgNg/KrnGSHMb/qJqi9RThi4pjFmw
	 xY5JDGD3NUcyI7F0ReKyx5hB6+1ovRI2JuJPnw+o6kxpgTaRxoKrKLIEEqNvZepV8YYwftPiFzVx
	 yv2b7ZgMPMAmRlW4QZpVBXeVkvT2wSsLd19kEFMeLbeFqIl9voZT87AhzrFmbnDU95gV4XT/4VRh
	 W3bEpB0tag9/slctT4lhulMPhXsE4L33ZGRz//NVRrYDqItZR7koaZJwb386iD83fJN1tyMyR1wr
	 1rYfECirGKCgqRmSMmgyt3XXQ4BEo/qpz4eVGq3ur2sLzV2xeXZ73zfNY3gpiaZnPUC2A/uO0q9F
	 H1yyJDl8xKaQvOfbDDIloWcO6boT9o+nItGkfv4wAvi8LfXHVKKwbkdk4R1VMyqtOoU5WT/D0CFM
	 fzZRH4jqXIxh3zhWFuznbD0k+rbHeq/tAMxXDtFxaJgKxK+5fNe1gR/ESJHZI23LzpNxJdyRmyuc
	 T3vC1333iu9HeQavTZ0wzDsUekVcg4qEIiTKyq3mXBtnL+vT0LQz2zzERsEM/H/H2o8XaS8z5lh4
	 QfmxO1jM+UOSQcYIoas/eCdiT64w1uHvJa+2UqMye9jqX7GWOoTTsMDyD+jj+BeM9otgi2bE70zW
	 3QhXXPVMePTehYK0Sd5G1evc9yh3FJDtY0vm/uBU8uDSH64YezHD+YU9TXTf0gmP0aqV4FQ/wRHl
	 RjJU5V
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
From: Jiawen Liu <1298662399@qq.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	jiawen <1298662399@qq.com>
Subject: [PATCH] net: renesas: rswitch-main: fix runtime PM cleanup
Date: Tue, 18 Aug 2026 16:41:35 +0400
X-OQ-MSGID: <20260818124135.247069-1-1298662399@qq.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: jiawen <1298662399@qq.com>

Update renesas_eth_sw_probe() for the confirmed driver lifecycle defect.

Keep the change limited to the concrete operation shown in the final
patch.

Signed-off-by: jiawen <1298662399@qq.com>
---
diff --git a/drivers/net/ethernet/renesas/rswitch_main.c b/drivers/net/ethernet/renesas/rswitch_main.c
--- a/drivers/net/ethernet/renesas/rswitch_main.c
+++ b/drivers/net/ethernet/renesas/rswitch_main.c
@@ -2123,6 +2123,8 @@
 	{ /* Sentinel */ }
 };
 
+static void rswitch_deinit(struct rswitch_private *priv);
+
 static int renesas_eth_sw_probe(struct platform_device *pdev)
 {
 	const struct soc_device_attribute *attr;
@@ -2194,6 +2196,9 @@
 	ret = rswitch_register_notifiers();
 	if (ret) {
 		dev_err(&pdev->dev, "could not register notifiers\n");
+		rswitch_deinit(priv);
+		pm_runtime_put(&pdev->dev);
+		pm_runtime_disable(&pdev->dev);
 		return ret;
 	}
 

