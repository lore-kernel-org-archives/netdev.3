Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793860630;
	b=wFjDAYtmLkENuRIBr5GgaxsG/f5ecUoL3WZEFaHmCgDoDUrFEMjahfKNjA8OTN3YsD6f
	 K9GnRZClB+MbpI2yqNyDngXI4bcw1DgOpo6xtk/ia5RPCgUFSFwPLMPjMmvXZFEq7VEnG
	 ADf4Rh/k01pCRmcr8UKHKxUafLX+ovMTTEpFAnTjKWkJ/jh415z2kvGsMUqMEQle19SYe
	 ToQxuKEpfRNND4pKH0kCxrCEjk61QVrAtmcp9zJ0rYGzmZYnEvKvxds8pDjqv6kZm2prZ
	 dUM+ZuFBegS8XB0388GN/Kx03h7/lQsNvCQTUTkZRGBZhYlAs2N7ALBczpbohPIXAWQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793860630;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=PgBKQLIR6mQBdDXOIGUuD/EXxFIBtVanX8mMwu7/ytQ=;
	b=AjDGE+KyD+CIUE8ZEOy/zb9dz9oQ4zl098H8NH7k1XEs0LUoaoLhs1ZKMeg2iRPLSed2
	 5XnvonZhx1nD6wL6Qv1a0p3KDizdGI0D8IwHB7tyapzNBDDGTEQFE/2LUP7bVyDnVcXO8
	 SYVrouNOQJ6kHUpd2bbNM+MmJRpAzVyFoBr9zSgQd1DrRQOurPOdx42jFV2UCGN851OoA
	 0asU9kG3cw2GZ9YslyYl1LI78E672VYOn6ar9djzvgwsSo+vWUyPk+uGc6xRYQ+LbUJ4q
	 IUjHZQH8bYuKFfgVzOxqgDVexEJawESAekh3NhrRP4A6rX/St/vl2I4Na6EjWWhuNNA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sr8rGKVI;
	arc=none smtp.remote-ip=74.125.82.171
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EE6C606A329
	for <netdev@vger.kernel.org>; Thu,  5 Nov 2026 06:37:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9EE6C606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sr8rGKVI
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-3645f0f3fcdso2639860eec.0
        for <netdev@vger.kernel.org>; Wed, 04 Nov 2026 22:37:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793860629; x=1794465429; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PgBKQLIR6mQBdDXOIGUuD/EXxFIBtVanX8mMwu7/ytQ=;
        b=sr8rGKVIa167qXWPurxWL2C1cOVTsS5Q7rwhiGgnnunPMztjUAVMDJZcCoWIWfJuYH
         o8744xSGd+iUefH2C3BRF9SPm3EQ9hBOZwcl13C7iV6ltiOcuZ6VgyoJJOXoUDrJc/LY
         tChDKpsvzNfgq3AxYQFDV1WBI2davXMxW9gU4LE8GaUmesJ13KleXd44JF6wmmq/STN5
         4dmkmMmZMWNBwmkRofsAeVLAZJTxwU4lrNTr7p0KLFFRA5xV+vGsrIz0Tctue7WRKgZE
         FB4J+rmQGmUdeYh8r8wMgp1eGvYc1TTRcBaRiIwUTdqU+R50Xl7r52PiXT4ZOaKbsZNF
         f95w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793860629; x=1794465429;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=PgBKQLIR6mQBdDXOIGUuD/EXxFIBtVanX8mMwu7/ytQ=;
        b=bcHaykyDtzi/s/2ODSJPGC5rTGtXvWI6fHHa7xGpa24fcsFCR1avsgkHnqb1YbWzTO
         KGF+hrvcY2vds4U8TbNDta9r0tiWxauFSMLIpi1WddSvfZqRruf51YnHVEKO6ocjW1Gy
         0Zlezxt8R9DaOZjhR7gYXU3kB4Zt92nsA9RcSH8vDGfmxYIvU9Gj3HarYVprnxvfzTb2
         GOBVclkYPHZvnYXgJeLXlpHkgUpuRlExe2gN+SiZr7ZpktnfGXJOelxOzqM84XyioAYg
         5buTqD5y4ypOHPv439EcDpHrIOlhPGHNBMtxY2g1FipU5rmn3Hrxy1699nfuQJTEB0si
         RXUA==
X-Forwarded-Encrypted: i=1; AKwUvByvV/6+k8sKwRcWxHbUpKGPnX1NpHJKVjvfGH38DHxksfGmXTnO/3YD8CU0VdbhqlUbG/BTrRg=@vger.kernel.org
X-Gm-Message-State: APuU4Z8pvWiFgamUl/2vRDhNJaZH0CUrDb4ziNPRX9Rx9MZArj/qFq7j
	Dg+mE4zlCdiibZEUHH6KWAxVZJdaYci8d/3AzuSpSZfezXIEpQgO2e2a
X-Gm-Gg: AYBFou2qD0gsexels5J/vN8qFyvvwdu+yqJKpyRrKRhqhCQPNHqots9u3t2Yj1U2MxA
	L+/pZvJO8i/Bo1a88I6ZD/zQESjdTp/zy2SEXKX3LP7U8i0N2rjIkCx+R3JAV5nUHfvQLjdBdx/
	90YdOkXFr5nLUfulBqDloffoxdP+4HNbiVN1WhNwgwNDovzhFjBX4tROjLXaWyG7NlJfjzEGD8E
	JWl2V4zZSHp00+gRAjLymmyhw48tY5FgSbNPyIxfBUwvM6vi8Sr0QHMhS+7G/Ucu6hdNPWPHCd6
	qH+JwWzLaHK97oXV2aF+rEzvnem9Ztq6v1POKywO1sUQSphfo9iYVDEXkPVri6bw1H8dFq7hBRd
	AYcRURHt1iM8TyNevdml9nx47YMTJHZuAu3AUWXXwe9xwHLeh9pyCpppn/aw+HEYjO5X2QYUsY7
	xPLI77+ObBYcUatOClNVsyckiUQxi9KgDhmX/OUtC63Mj+0xS/QgWLW5l+o5ot0ttEZ6xvV8aUI
	wz25pJmY5AFkQACSZ5bI0v2aAkMeaDYGRiMVRk389hKOrkZOwl4aAOjJ1iSUDIco6nWDqW9NwWI
	NvBvxnjaD8FHIMBi3V/qXsCYCb0+nRZOnbZCjuTbRpw0WpEtfUjOIA==
X-Received: by 2002:a05:693c:88d2:20b0:36a:6d52:e16c with SMTP id 5a478bee46e88-36a6d52e261mr15954485eec.12.1793860628633;
        Wed, 04 Nov 2026 22:37:08 -0800 (PST)
Received: from volcano9f6e-hostos.amd.com ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36d34d5960esm13148900eec.5.2026.11.04.22.37.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 22:37:08 -0800 (PST)
From: Hemanth Selam <hemanth.selam@gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
	Xiong Weimin <xiongweimin@kylinos.cn>
Cc: virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] virtio_net: fix typo in the ANNOUNCE_ACK comment
Date: Thu,  5 Nov 2026 12:06:54 +0530
Message-ID: <181e5d6e056f326b8531f17bac7f4e138812c540.1793860522.git.hemanth.selam@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1793860522.git.hemanth.selam@gmail.com>
References: <20261102043526-mutt-send-email-mst@kernel.org> <cover.1793860522.git.hemanth.selam@gmail.com>
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

The comment describing VIRTIO_NET_CTRL_ANNOUNCE_ACK misspells
"received".

Link: https://lore.kernel.org/all/20261102043526-mutt-send-email-mst@kernel.org/
Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>
---
 include/uapi/linux/virtio_net.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/linux/virtio_net.h b/include/uapi/linux/virtio_net.h
index 1db45b01532b..4a458ebb2567 100644
--- a/include/uapi/linux/virtio_net.h
+++ b/include/uapi/linux/virtio_net.h
@@ -316,7 +316,7 @@ struct virtio_net_ctrl_mac {
  * Control link announce acknowledgement
  *
  * The command VIRTIO_NET_CTRL_ANNOUNCE_ACK is used to indicate that
- * driver has recevied the notification; device would clear the
+ * driver has received the notification; device would clear the
  * VIRTIO_NET_S_ANNOUNCE bit in the status field after it receives
  * this command.
  */
-- 
2.48.1

