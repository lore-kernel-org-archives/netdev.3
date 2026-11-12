Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794466580;
	b=4aV3ywAHTdLP+lvXkyPSxUYnEM6eel8f/VBJGwkrZ0MGNTDc4o7kHfZctFYSmeABKJ0T
	 dnohBNZniVFSNIUBj+35XLVZj1bfyRcMbLGSpfKM1hkY3Ex2Jpz/1369foq7D0xsX5Xyh
	 nM6N9Ok8u4a4BGp3vKw1lL8tcMzYnqsahG90lCxbxsKiN2lOxO2l+zdhBGu1l21/vc7tc
	 MrX2VN1EhoHr8l79C/5HhJUNVtHLvoWfmWAKdPbVfheOZI4dxWfF2Ufvv3z3ifLZAIg2S
	 h17KAJ8dkI6KXjoMwDJu7HXnDi+GY5htuXEvdy0NqA/vxPd4VrPl0ioosZiETpGzdjA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794466580;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ISyFWiqCRRUPMHI/QOqOoV6Eq81C65f9fR84q9yGmq4=;
	b=E53OfgrjbGiTMNfUuFLQX2VnWtxZJhQefHxjcksTUMl6lagkNy6mCP5jccCaxDvuSmb/
	 9f1OD+tH0gTEuZg15bhDf7iEiB1Y8y1aLHjQ39ZwelXeoY2cPRAq8ag8/0kjuMI3CxtuM
	 h1qQi64LNWS+r5lSLVx+e1Q2LXqn5IOBrgtAj1rahaT/UopBktZ04HCyCyg3v87A/X4Kh
	 i3LKxGPL8r7GvBDkF02u1r8K8g4xuvWhJVVUmOqWX+A07wCQc+vkuVI36TWfRnTJpujJU
	 5sB4gPkxalDSfRD4LCN9xBS16ZvNPGNq7cGxjVgsI4l5jBY+GzDyZ9W87ekP/93Mkkg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=odvJf4eh;
	arc=none smtp.remote-ip=209.85.160.180
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C21CB606A33E
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 06:56:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C21CB606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=odvJf4eh
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-5364042eecfso49554861cf.2
        for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 22:56:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794466579; x=1795071379; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ISyFWiqCRRUPMHI/QOqOoV6Eq81C65f9fR84q9yGmq4=;
        b=odvJf4ehN4ApwZaG7qInnaJeVXp00XWchW5Y8c0/6w7/MeOapSJXEGyKLrcXlLPC26
         ThAxZWjnXYDChcive0/WLAEML9ClSaf8uTU44FBNfw2unHz6hmTbPPVxmICioDDDwuHL
         YIV5nV58/M97KY+kL5GNcUARM8ArBz4EdewHvau3u621kjNhcFUXrPkhix6rBDUog7sY
         wXuNRvfDryBXC/56XRa9BlL7WW8dfziobpgJQ8grkbmmdmN5WkapYg6q+OHoHb/2e4za
         lk4IWaIH+8VIuda6tuK66xX8HKvrcQvboyqKBqx1o8hOwZHxL2UFoTPkL/56j3IAQ2fH
         D9QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794466579; x=1795071379;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ISyFWiqCRRUPMHI/QOqOoV6Eq81C65f9fR84q9yGmq4=;
        b=JmKEFqmJanNWIMNOYLd/M9hVLvYckSSRYcfYo1MMuR2J7tGwzXWt/IZhknsmLgU4KR
         +gmUYZdbVSEVWf+kHBQRRlT+dQxToGLKCK0EmuEgkRZjm6Ek4QsqhG/Y6Wb4WcMjEAUQ
         2R1jXU7Eh6audsMmKtYpgXAy5SdxZSs6C5Z8uMrncVQVWxjSABcM21CC4do2/uouBwZV
         e3YdMlOwRHiTTg1fncxfV3XdiJNKs9EYtzdh84yL1I0Tg/j4+yMIZ0FgX55cpoF96dZk
         RlJHT2R1pM0rFJqcphWMWcHRYl4VTHZ9NfoIdMefi4zIBomq8nFSu+J9YatBK5eLhIH6
         Xs9g==
X-Forwarded-Encrypted: i=1; AL+hErG6186fe/dNav8w4/kDug/+68kA/hFxUIyz9TTyrELzNfiKhyZ7UT24n1ek1hK38NMwZEP3nQk=@vger.kernel.org
X-Gm-Message-State: APuU4Z82BP4TIUNQCoNc4L16udNiiq5iS7EYj72cKR5AHRFG+JyGRZLQ
	mvPZ7jDU78k9QkCjCpqRVyz8uYjPA9eG3n6n+pSMrF+AWyKZPV/HzbU=
X-Gm-Gg: AYBFou0QTh6n3Ny8spBjMf/2pxwNUQQAeou+7UUi70C4foUcahHlAamRhWtjH2ekuDV
	7zwETlNYkFrg59N6gQqjKVFYf2Us0Hlr08ZfKks9hujULanx83AT8+ekFzs1HdtuvWvB3Xnf7b3
	GVoC8k3IWVmZXfVeuwOHDH6kLNeneK93AfJsXbHz/TixmyVCOvv53xI/mZsHRwMDHi+4Rwak+vp
	D4RgUM6WmmFCgIzgzqCNoM3UeQ4k0wY6gWF71dXIZ2omdbw8a4lfnIMFkzhCludwytXAcWAFeV2
	wulBIEE3QJQrsf4hwhrV+JZoL4U1UUGC8h0szVG5LxbT4sL0CatyYlLy7GMapDtD2XWvudfB6W9
	w7TXrbRMP8w7QeCipuxHZBO48cXDTysHkZ1loRuNHVw/8tAg5enlD8aWmXEYUdt38NNFEr82ZgF
	SwbfGH8qsJEvAz1jTiURR5pLG3WVZgUs/E2XMpCRUs+RoM53GvwXzRK/jclruXnN1/J25Y7qQ5l
	FVXn9tp37tusWlM2Q0AWq2/HJ34XWpzcnHU64iOZyFxIQvYf0S7rW5lj3v9Pc1Lns+J4YGy6Qbb
	bLme6s3pz02sa2cDG459HqJ/XSJJrWVruf3IWZzMnDttmWVlJKgMpjmFyokPQSktmSIcl3TGGgE
	xM7Qq9jnq6aZEk6bMsdKJtpep0htVeO9pB7tBWzF9rn5LwwyDr+IQMLyD8uNhNL/JBILdeteaz4
	53wYE0aoVKe6SVFyomB82GCm2I7SSwqbvR
X-Received: by 2002:a05:622a:c06:b0:535:1e4f:4ed2 with SMTP id d75a77b69052e-556bdfcf0e3mr75884541cf.11.1794466578580;
        Wed, 11 Nov 2026 22:56:18 -0800 (PST)
Received: from localhost.localdomain (h16.44.55.139.dynamic.ip.windstream.net. [139.55.44.16])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-556f374c4ccsm32807681cf.28.2026.11.11.22.56.17
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 11 Nov 2026 22:56:17 -0800 (PST)
From: Myeonghun Pak <mhun512@gmail.com>
To: Ioana Ciornei <ioana.ciornei@nxp.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Ioana Radulescu <ruxandra.radulescu@nxp.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ijae Kim <ae878000@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net] dpaa2-eth: free the DPNI interrupt before releasing its resources
Date: Thu, 12 Nov 2026 01:56:16 -0500
Message-ID: <20261112065616.34209-1-mhun512@gmail.com>
X-Mailer: git-send-email 2.47.1
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

dpaa2_eth_remove() and the probe error path call fsl_mc_free_irqs(),
which returns MC interrupt resources without removing the devm-managed
handler. Until devres runs, a link or endpoint change can race with MAC
disconnection or access the freed MC portal and net device.

Add dpaa2_eth_free_irqs() to release and synchronize the handler before
returning its MC resource. Use it before disconnecting the MAC and freeing
the portal and net device in both paths.

Found by a static analysis tool under development.
Not tested on hardware.

Fixes: 6e2387e8f19e ("staging: fsl-dpaa2/eth: Add Freescale DPAA2 Ethernet driver")
Cc: stable@vger.kernel.org
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---

 drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c
index 7227a35dfaf2..91462b88b34a 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c
@@ -4824,6 +4824,14 @@ static int dpaa2_eth_setup_irqs(struct fsl_mc_device *ls_dev)
 	return err;
 }
 
+static void dpaa2_eth_free_irqs(struct fsl_mc_device *ls_dev)
+{
+	struct fsl_mc_device_irq *irq = ls_dev->irqs[0];
+
+	devm_free_irq(&ls_dev->dev, irq->virq, &ls_dev->dev);
+	fsl_mc_free_irqs(ls_dev);
+}
+
 static void dpaa2_eth_add_ch_napi(struct dpaa2_eth_priv *priv)
 {
 	int i;
@@ -5044,7 +5052,7 @@ static int dpaa2_eth_probe(struct fsl_mc_device *dpni_dev)
 	if (priv->do_link_poll)
 		kthread_stop(priv->poll_thread);
 	else
-		fsl_mc_free_irqs(dpni_dev);
+		dpaa2_eth_free_irqs(dpni_dev);
 err_poll_thread:
 	dpaa2_eth_disconnect_mac(priv);
 err_connect_mac:
@@ -5104,7 +5112,7 @@ static void dpaa2_eth_remove(struct fsl_mc_device *ls_dev)
 	if (priv->do_link_poll)
 		kthread_stop(priv->poll_thread);
 	else
-		fsl_mc_free_irqs(ls_dev);
+		dpaa2_eth_free_irqs(ls_dev);
 
 	dpaa2_eth_disconnect_mac(priv);
 	dpaa2_eth_free_rings(priv);

base-commit: 0edbc945eb9edd0086f25b151a79cfe4adc0dfa8
-- 
2.43.0

