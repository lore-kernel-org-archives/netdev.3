Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89CEC5616D3
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 15:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790092367; cv=none; b=DTgJh6UbF+b2LD6+kNOshVVTYHMSIkVcEEPtAIbAIT6JP8T0xjLpPnhZK/xuwbGHuGOVpwVm9JLnqxQSa0PzoZdykTk1Afrp+A3Gt4GFD1PWhv9lRFN75aWn8YlXTCyxzy5M+RlHTHkRHALIKcr3gEtjPqeD7HxfIdKBcggWtlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790092367; c=relaxed/simple;
	bh=nCTXi0QrphbUuOg5+DmqnjVX+1Bepe6BZKUN+z7NmgU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nV7PzlDuiZM+0VsLJywMEzUBrC7Oj0bLbqfGAUc7oN3L3Hb46+KU42d3cXw/3eXHrzs5U5tOljAHy/v2vQWhB9Na0RLAIS8C4GlyGoXr/FbF7Dp+lZD/NqQ6bjm7q9sUwMLX0UCMESmU9+l9UyPqqBUpFHrXWcFpD6gZQ3odLEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aQ3bg2ao; arc=none smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aQ3bg2ao"
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c254f55efe7so638057666b.3
        for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 08:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790092364; x=1790697164; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=nsDs23DcdYwkDSFn0tiJfOUbVshOv/zFLmietT3ibk8=;
        b=aQ3bg2aoQfVkcaZ0YhUXoMaXyfkbTN9PaIeJWwoQdGUPkKJT2T3aqxWA3nqZI5BszR
         +L80OZooJkPZFhwIRv3DY3Mp7lD6evmk3tTVpZY/x+IRnzvuGy8gK6rpptM6e2XW9v1F
         GHcSE1r7FBZ97MQhf74fst31BhQ9zZySegFyJXK30vfw7j+wpOKqLovkisCs3W4yQrAh
         64yoo4Is5W6uoZU1rkc7BrFpEajNcBrb4S7PqyGFvUA8NIyBlW4sxewLYboUQVGLZU7p
         Z2kl11gciK5NAEJkHKOXpKE7Z5Gl3+15z+gM6He6zPcWuDjieCNvk65/7/GHRx0IQkcf
         f0Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790092364; x=1790697164;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nsDs23DcdYwkDSFn0tiJfOUbVshOv/zFLmietT3ibk8=;
        b=B4ZXTuIzEyy5KLpHP9ZLZdSUfRs2s98rgXZHPgw1s4HegrXlI3l9EZlsORudsFoRnJ
         J5Mf3NENiuLkljHQIgFBNX6eAEQC8yV0k2cGvCj6oU/0vC8PusFdpNu66OLCnvK2UZMZ
         IX6/mW/cWeyAMETBTfZ7VY2uXyOd0Zd4a/b0PbNRKTW/sxR/a7fe5carudneWphdWqwe
         asxE592iFc06s4oQLaHEG5333SXI8O0OMgsvcvDx+8sru64bI3NTPEYapT7BLOtS4rv5
         ejmSJxAQpX8KViQ/UVKOI76TnGAsLL7Q2lCdpgliCXIXftO2LqU3a/sXOC4clYruqHLu
         CtBg==
X-Forwarded-Encrypted: i=1; AKwUvByeWkkXCPVNif3UzLWjm3NO5iBpwkx3cDlm8msbtaYktItlJoJX75rBmwZahOAyPZfXgGjWgJQ=@vger.kernel.org
X-Gm-Message-State: AFuF++n24GKqXsaXgIZ7Bgp4d1kl6BDXIKzBRDho7v+OFSrq9+ZCYOCd
	cM9Jn59UenPTWhHv4F7W4kXp5On7taPvXYzk4KQQ9RV6BvQ+eFnIVf41
X-Gm-Gg: AYBFou0untNoLb5uFAV07k5QsKpg7ZfscaISrHL2S85oCk7AN4XaYDqFujXZ346tjis
	Ec2kYrgaXi2QmYJh+hhsY2dv0gpDmnq0V8exIAPvgZG96ew+wDzszEBMwX5g7vRqQzjvzxbhXCa
	wYhNlL/BhmGIkgZfhFXQauCuKayBzsUrRocn8JSnhFRBwWhmUOyddUh1buMRt+ksSFoNrlWcBM4
	yUXtAVzfJJr1I4Rw2sP3almWqa6UJhEEoMA1Zty97iZyyVHrT1PUS/ruT5PdPw6UTw1maehU8hd
	qOflYL1E8vHt3mJoXKIUIwj4xg9+60WBqvl8S1TX1Pstna5R0VRLDaLO15e5RtAGzZ9czic6r34
	j3HpUYv+q6Bf1O9IDNYFZDP6L/7e5JvcnNBbtYmM8D3JyPqGKfVTWs/Pb++Js0WF6LOCqhTy+XP
	Q7/TUG+8s501qS8kCSJbOiqaYv0Gi70/pZom46vEYTiaGb9TQ8OFGdTxTA6cub2mc30jrpufGf9
	ixNm2a7lAmMKJoX
X-Received: by 2002:a17:906:c14e:b0:c29:5af0:3b44 with SMTP id a640c23a62f3a-c2a157fc26emr1145456766b.41.1790092363539;
        Tue, 22 Sep 2026 08:52:43 -0700 (PDT)
Received: from localhost.localdomain ([94.240.182.136])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2a9c628056sm109308666b.54.2026.09.22.08.52.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 08:52:43 -0700 (PDT)
From: Svyatoslav Nikolenko <nsvatoslav515@gmail.com>
To: kuba@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com
Cc: andrew+netdev@lunn.ch,
	ffainelli@freebox.fr,
	auke-jan.h.kok@intel.com,
	jgarzik@redhat.com,
	joe@perches.com,
	aleksandr.loktionov@intel.com,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+ca1ef9e2e234b8d3599b@syzkaller.appspotmail.com,
	Svyatoslav Nikolenko <nsvatoslav515@gmail.com>
Subject: [PATCH net v2] net: e1000: fix warning in iounmap on probe failure
Date: Tue, 22 Sep 2026 18:52:38 +0300
Message-ID: <20260922155238.67445-1-nsvatoslav515@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

During a probe failure, the e1000 driver error handling path calls
iounmap() on hw->ce4100_gbe_mdio_base_virt and hw->hw_addr without
checking if they were previously mapped. This triggers a kernel warning
(WARN) rather than a fatal crash when passed an uninitialized pointer.

This issue was found by Syzbot. The exact kernel configuration (.config)
and the C reproducer used to trigger this warning are available on the
Syzbot dashboard.

Fix this by adding NULL checks before calling iounmap().

Reported-by: syzbot+ca1ef9e2e234b8d3599b@syzkaller.appspotmail.com
Fixes: 13acde8fffc0a ("e1000: cleanup CE4100 MDIO registers access")
Fixes: 1dc329180fe22 ("e1000: Use hw, er32, and ew32")
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Svyatoslav Nikolenko <nsvatoslav515@gmail.com>
---
v2:
  - Expanded commit message to answer reviewer questions (reproduction details)
  - Added appropriate Fixes tags
  - Added Reviewed-by tag from Aleksandr Loktionov

 drivers/net/ethernet/intel/e1000/e1000_main.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/e1000/e1000_main.c b/drivers/net/ethernet/intel/e1000/e1000_main.c
index d7f5c6f16142..156903089fa6 100644
--- a/drivers/net/ethernet/intel/e1000/e1000_main.c
+++ b/drivers/net/ethernet/intel/e1000/e1000_main.c
@@ -1227,8 +1227,10 @@ static int e1000_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	kfree(adapter->rx_ring);
 err_dma:
 err_sw_init:
-	iounmap(hw->ce4100_gbe_mdio_base_virt);
-	iounmap(hw->hw_addr);
+	if (hw->ce4100_gbe_mdio_base_virt)
+		iounmap(hw->ce4100_gbe_mdio_base_virt);
+	if (hw->hw_addr)
+		iounmap(hw->hw_addr);
 err_ioremap:
 	disable_dev = !test_and_set_bit(__E1000_DISABLED, &adapter->flags);
 	free_netdev(netdev);
-- 
2.47.3

