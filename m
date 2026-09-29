Received: from mail-dl2-f43.google.com (mail-dl2-f43.google.com [74.125.229.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 195404F4D07
	for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 10:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790677081; cv=none; b=bCeEuN16EQXW5RAsJTK5RJBkIoY6BpasNzt23QnX3+qDrH9bdxWLU6+2HBHKVDd+TbVrFN+JAVXu15Sy97OviApRiHtrWe8KnAnzzaQzIioVEfYLSaGyK0ipnarG3LZmq+xzvmFUx+weYKpzgQb/UzxIe0nrZeEp2k9Qn4IgRNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790677081; c=relaxed/simple;
	bh=An6mkPZDYZWrG8lcKKYm9brAuxjDgA3tyL1/ir2SVvM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=D2X7k18FYzqjwI/tGT3WhlEe3bOrgdZFLJMbsrVeQHWlLLNeamZwSvbiMoF0VP58NfFhNOfVj14f644/BqMbA9rMdJEKAA9sIeB16nrYU0Iy/E+OyyS3IBD72jw6hSN0ll0g/+pKRw6qexO0Cf9H/KyrRtcMfhpy8qi6ShfC9A0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KVNRMy1W; arc=none smtp.client-ip=74.125.229.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KVNRMy1W"
Received: by mail-dl2-f43.google.com with SMTP id a92af1059eb24-142dd046b87so2866840c88.2
        for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 03:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790677071; x=1791281871; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=BBxqqrX6VFrTTZg5kn1+eJIOqRCLIYMSYIE031U9CBQ=;
        b=KVNRMy1W82VMa6evEJQFwzBGvqNAdhkM9STuV5kF8qrXpCrnfcn9pb/HdkajfYbcDo
         1fSwlCWD+3WPj3JKwI4bHH5P5mmFlbDvzyGKe5eYQkggUtmRBY6o0Nvelcx/1bBUbZab
         7PDvyxXzVdpB524q5eqrYYpxQJ3ui2HfR1xwfUpQWhBL53x+YFgyo3+sDEp2BEyA9GHc
         SKwih4f+aF9w5JVd5yuO0v9Nqo4Zz6kfh6J5pi87Skj4rsK/Rug6xpHcJHFgRxNQrX45
         9EBod4pDP4PnCx5Bnghe3KC+OuUoSwo9P/KxfNS26LLyPEGNXTxZePvJelzN4MdU6KH9
         z9kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790677071; x=1791281871;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BBxqqrX6VFrTTZg5kn1+eJIOqRCLIYMSYIE031U9CBQ=;
        b=jGpFW6xv/JceLDAklar7ESeCEQfe2uXsapGqRWv+vPWp2Hp7NYkXX7ZEXuduOKBJlL
         rdsEXXSqgDfpPazBIdOkg8jxCYR3978mpyFBx05sAV8/tjtpLqa2WRUnGHiUZemIXbLQ
         N+4dWlTdEVx4YMmw4glafRjJIHs0stpKHDjkfWojsNjQ/7lWMtII8+cXMPrBf2GiE5BQ
         JbgXSf+wuM0KxybVK+moxIsFWU6OCt1KY+gJlmKBp1AE8cftFG5/kPW8B9Fov1+fcDR7
         cd557K8RA+XgyIT8o4bwDzoaGk2JKE0Eo/skDBkW4lTd/xuRH4IgdHqQhjHYY4hpPF8a
         o4oQ==
X-Gm-Message-State: AFuF++nHoxZl70r6aJAnCSzJIoiKXqXq6kHa+YuTiibVAg5sHqEZ/j/j
	TSstB/hVDQvDh724zhHgPc8lPO89o0eLbTmKG7lHeIPdpP1DMHGAfiW3
X-Gm-Gg: AYBFou2qrV7DjvI97eK7MiJdAPl9WVF+Bcc8YfGpxao0ye1ko7wA7SDjg37N2N14Knv
	VeOutJlotSFlRDMHKgIDB8Z7zyIy66Ov1o1hsHJWjRkiNiXgQpWM2WIhX4HC5ziBOPQA90FBV5O
	Kn6Ry1Kla+MeJu9OzRBB2SlxECvkpN61xhJPxq3AzZr0uGQIp6JzOHD+/cMx0l9COft7C/J6eb4
	LjUOVXVUm1KDrAECF0774truJjgCthuBRqjIKFW1F/3V3ENLceYGjSTpZ6KUP4rRFjQQ6LyPwQ7
	uDCBywTtwlhTc9MqT4snXg29mjQWbcRlpd4M335iYjHYj5YRI69K9qc81zW2f6LlM4S4HpLYA2e
	XIOLdrll7jgvcVEgxIWfKwMs5kEUfQZ+5MudiZ3WRyCfSZr+E4KmSHPVvqwnJHb9yt/ciu1zm1F
	GWg9JQHpAL+FojLOda1ecpiqofpLYJNOZUa5o1imtBZMl3enG2LceOiKn+Gg==
X-Received: by 2002:a05:701b:4344:b0:144:fc5b:2121 with SMTP id a92af1059eb24-146ce67fa31mr13579743c88.17.1790677071222;
        Tue, 29 Sep 2026 03:17:51 -0700 (PDT)
Received: from evangelion-g ([2a09:bac5:40e4:11cd::1c6:2])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-145ad9e097fsm34324648c88.13.2026.09.29.03.17.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 03:17:50 -0700 (PDT)
From: Ayush Yaduvanshi <ayush37735@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shuah Khan <skhan@linuxfoundation.org>,
	linux-kernel-mentees@lists.linux.dev,
	Ayush Yaduvanshi <ayush37735@gmail.com>
Subject: [PATCH net-next] atlx: fix kernel-doc description for atlx_tx_timeout
Date: Tue, 29 Sep 2026 15:47:13 +0530
Message-ID: <20260929101714.51579-1-ayush37735@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add missing @txqueue parameter description to atlx_tx_timeout

to eliminate kernel-doc warning.

Signed-off-by: Ayush Yaduvanshi <ayush37735@gmail.com>
---
 drivers/net/ethernet/atheros/atlx/atlx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/atheros/atlx/atlx.c b/drivers/net/ethernet/atheros/atlx/atlx.c
index e8cfbf4ff1b5..0a6205e5c19d 100644
--- a/drivers/net/ethernet/atheros/atlx/atlx.c
+++ b/drivers/net/ethernet/atheros/atlx/atlx.c
@@ -182,6 +182,7 @@ static void atlx_clear_phy_int(struct atlx_adapter *adapter)
 /**
  * atlx_tx_timeout - Respond to a Tx Hang
  * @netdev: network interface device structure
+ * @txqueue: transmit queue index
  */
 static void atlx_tx_timeout(struct net_device *netdev, unsigned int txqueue)
 {
-- 
2.53.0

