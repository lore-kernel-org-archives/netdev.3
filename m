Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794574904;
	b=tn5UtFdM8DzSxFl+KGJO+FURyWPN0iUkYdiC05T616pr7w+j5C0KJuwTmasOv2lqbEOa
	 lIa0ciWxIXw4J0AOzqdRDEhFKV9kXxt/8ljB92AGqpSghllfQ3nHcNPxMFATqcs021x75
	 P+uWvPxtG2EWXWUrIIyX7csliWJFbx5lhGGRiuTxedBN968N4vbTlxVtZowTxrjjBuxHu
	 sKOT0ntHYi6YJ9b8e+w16eZCdrL7ojNtXgIa33ztaA7Bd75Xl4/WX/KWSjG6TNqq2mj3B
	 Qhrs4oSx2q90e4FhF0eQFdp1kRj2w7xlRsqdF6PLDBMmqbri9Kmz1TEndtQLr0zvLsw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794574904;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=dS9EyPR31sgD5ngavZ4avec13/Y4TPfrqwtVSgg1KpU=;
	b=euv8XvHmxptcDRrW6XdrPiZmxqEea0spP9hwalAjlNaM0KZqWfkvqM0p6X48opt6izdA
	 u9tRg7yG675l9k8CRSs4fSaB1yX4QLnwai/SmjJiYiOtOTQb4SkelpyMZ+GCVj5qOYMZK
	 EDRoLMbmcbfNekcZgV6de9xxwSydlaoxrwtaozUT5mE+XyRuDh2mEe8ZyVTPTgNedqHtn
	 AH64Wjj0/NACp3RF/cXUdDpNqVlDT3ZX/CzLIsoor2X538vWPKYrMKw1Cmycq+SBS3U/g
	 SEujlj54omL5+8XaXt1VcNixaCMvqhKGnOZWdHHSFouoEALp3I0NETgqj3BaWEazC7A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YII6ms0i;
	arc=none smtp.remote-ip=209.85.128.47
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13824606A327
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 13:01:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 13824606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YII6ms0i
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4a207b02a2cso4852025e9.1
        for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 05:01:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794574902; x=1795179702; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=dS9EyPR31sgD5ngavZ4avec13/Y4TPfrqwtVSgg1KpU=;
        b=YII6ms0iqpD4miklHj44JtXK6mRH8pZXnqxdSEJjbuMPQu5C8q6gUL/p6jdGyzbXMk
         JWx196u9vfQtd42MXsJz4wdmYrcW5655ftKKzJfhrPXsrhUk9Pdqx/0dotPXIruGzf3Y
         XBb4pf6ufxh4Ks34ywqGMlcZ5RjXkYOzjeCtxj5qrytRA10n2yNVw9ALYmxCccrcXY5K
         /bW6q3SBvwOCxdp4yDNfMPihR6fxSXs4uoS212hMg5YN8Dg/FZSHF7xl0U+KODeTRpJI
         ZLiFK7S2okiagl2ghkX5/YPO4uUHziNA51uo+FXimlpVxRR4Wr4Lwj9iGd9xWMwjG2lM
         Owxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794574902; x=1795179702;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=dS9EyPR31sgD5ngavZ4avec13/Y4TPfrqwtVSgg1KpU=;
        b=drYjjWMgjRPD70IeTZAP1JmKZMjVoQ6Zi884TkP/Q7wlia0GHITSnXqpWtgUg0LSaP
         aTSyPMfWjw8yMKsYKhiwifU6FVn8SSsNSr/xsnjD5nk7i61TIOvCGTvPkIR5Zgi/BVk3
         3v2JUGylDMpTGLmnoD1nain/naZUJlahkUdGTjicld2jM1K2SE5avr8QDLluS/tY8zIR
         3s+yhvOcmdoQBQzwl34V39QOHXQJVBEI2V26XZtib/90U+DkC5xb2+/XSdsqi7hbSrlF
         9lUyPFwd8+VYuYobxDVaOujp9C8sQVtdiljNWY6uACsaAl8j8MhtAjZ7CnKdc/8d5Kpm
         C5wg==
X-Gm-Message-State: APuU4Z/6d5EU8mxgn64lapiUyxgIog/tHTOnXQfCvGd3pdEDx+rasfoY
	SGqtD7Vw1GxGesAQeQKEItxrRy4V4+nRJaPA3ZVh4uPaSWzurZJPgX1WpBSJlq3o7iEaEQ==
X-Gm-Gg: AYBFou3rCP8eufIQM1o6Fz2U2WTbNH1JmwtzdhrEBympntdI/DAWPb8Gs1QkJ98mNs4
	dGzPEQyl9LXLMVU5HU9b7Cholmd3KEM6wszoSbkvo88iO9RJaJQdWydGpgvFmawN+iANz5ESM0V
	mrq7icGDFwB+mCVQOLZO8vnuDmkR8L6Din1Jnr8d/x6qB8TOZrsWm7MU9n7OsJoi8vzceBnDoSN
	RDkfB9d8lBT6o1wW2KL/cGdx1Xrhrgkn2gaKucjDeujzeM+Y+UHKxqJQvOLbFUc+9xnjcrtJVM+
	ao1q/xnGIWcGz3fmGrMfT5ThQq53bo/D2rDCvhPetUyd9qN85zy208+IoGsB4uvMGrOmyeL0Dt/
	9cU0qXCFQhaeyLjVX26xvTSya+KQranHypvke1xBbfByRBsmwqXmJuTfoqzTCJiRvnthMCHQrlQ
	ftsEbOWYjtfHsgAR+h04WrzY7lUN/Pf+4+806otbVH8yUeu+2Hs9rDEa8eW4tOT/9AiqOaSIlYR
	7jj69kcwOY/YJLVTCzOFlyt6f1dBERpPry3pl//zfRMrpWVsOyTYD8iX25EwOBFMf9bYpmqFBhW
	rWBcSLc/UlwnXWi2vngwQoqBC8NBskS5yqSeCWjM5Ref8sfMsvZWlSzeKpKBSanFYVkW5dB75qU
	SanD2k+4=
X-Received: by 2002:a05:600c:c05a:b0:4aa:1527:659 with SMTP id 5b1f17b1804b1-4bb55a50e9fmr40374425e9.17.1794574901964;
        Fri, 13 Nov 2026 05:01:41 -0800 (PST)
Received: from alchark-surface.localdomain (bba-86-98-194-229.alshamil.net.ae. [86.98.194.229])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb566cec2esm40477495e9.1.2026.11.13.05.01.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 05:01:41 -0800 (PST)
From: Alexey Charkov <alchark@gmail.com>
Date: Fri, 13 Nov 2026 17:01:05 +0400
Subject: [PATCH net] net: via-rhine: Stop the NIC on platform device
 shutdown
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261113-vt8500-rhine-shutdown-v1-1-9448ea9548ec@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWMSw7CMAwFr1J5XUtJKiDiKohFmhpiFi6K049U9
 e4NdDlPb2YDpcykcG82yDSz8igVbNtATEHehDxUBmfc1Vrb4Vz8xRjMiYVQ01SGcRHsXYg+3Or
 Je6juN9OL13/3AUIFnueoU/+hWH5F2PcDcA2ain4AAAA=
X-Change-ID: 20261113-vt8500-rhine-shutdown-b2ac8a702688
To: Kevin Brace <kevinbrace@bracecomputerlab.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Alexey Charkov <alchark@gmail.com>, Rob Herring <robh@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2049; i=alchark@gmail.com;
 h=from:subject:message-id; bh=slih1j7uIKXNSsFl43FCfxGqI1wEAtZXMRnxWUVycdI=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWR95zI24fh6/PurCQZM3rqeYVafV6etKM6PvVt4g/vlw
 bgrsk3yHRNZGMS4GCzFFFnmfltiO9WIb9YuD4+vMHNYmUCGSIs0MAABCwNfbmJeqZGOkZ6ptqGe
 oZGOsY4RAxenAEx1YjHD/6QO/+/uExfOUOCYFRS8UTZEtfP6+pucQlfuHo5YtT6ZbTbDf7+tjnt
 U4u4833uWL/LTYlXDlF8LPLznXM8IFnR2sQ2N5wUA
X-Developer-Key: i=alchark@gmail.com; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5

Close a running interface on platform device shutdown, so that the chip
stops its receive DMA before kexec hands its memory to the next kernel.
Do it in the driver, as the platform (OF) variant lacks a .shutdown
callback and nothing else stops it, unlike for PCI, where the core
clears bus mastering ahead of kexec.

Keep incoming frames from landing in receive buffers the old kernel had
allocated: on a WonderMedia WM8950 board, broadcast traffic alone
corrupts the next kernel at random points as it decompresses and boots,
hanging about a third of kexec attempts early on, e.g. with
"unrecognized/unsupported processor variant".

Fixes: 2d283862dc62 ("net: via-rhine: add OF bus binding")
Signed-off-by: Alexey Charkov <alchark@gmail.com>
---
 drivers/net/ethernet/via/via-rhine.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/net/ethernet/via/via-rhine.c b/drivers/net/ethernet/via/via-rhine.c
index e56ebbdd428d..dbbbaf7f20ac 100644
--- a/drivers/net/ethernet/via/via-rhine.c
+++ b/drivers/net/ethernet/via/via-rhine.c
@@ -2461,6 +2461,17 @@ static void rhine_remove_one_platform(struct platform_device *pdev)
 	free_netdev(dev);
 }
 
+static void rhine_shutdown_platform(struct platform_device *pdev)
+{
+	struct net_device *dev = platform_get_drvdata(pdev);
+
+	rtnl_lock();
+	netif_device_detach(dev);
+	if (netif_running(dev))
+		dev_close(dev);
+	rtnl_unlock();
+}
+
 static void rhine_shutdown_pci(struct pci_dev *pdev)
 {
 	struct net_device *dev = pci_get_drvdata(pdev);
@@ -2580,6 +2591,7 @@ static struct pci_driver rhine_driver_pci = {
 static struct platform_driver rhine_driver_platform = {
 	.probe		= rhine_init_one_platform,
 	.remove		= rhine_remove_one_platform,
+	.shutdown	= rhine_shutdown_platform,
 	.driver = {
 		.name	= DRV_NAME,
 		.of_match_table	= rhine_of_tbl,

---
base-commit: ead6fa9a0ab194f02a2f36d634b193e9c5f9a1c6
change-id: 20261113-vt8500-rhine-shutdown-b2ac8a702688

Best regards,
--  
Alexey Charkov <alchark@gmail.com>

