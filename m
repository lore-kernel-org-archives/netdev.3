Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 424B0418A28
	for <netdev@vger.kernel.org>; Wed,  2 Sep 2026 09:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788341704; cv=none; b=Flty+l/87bhWn4mtN3G/s2WdACdA0N3GEwV/diXr0kdqNbXTfbGiAbSlNG88RVIoxDALCD+gQ6CxDbq9vTwkfAsMRUNbczVpBryMKK2McyxL8ybkID/ShJEvv1pxDH+cjpu7wzSg0adIbarCp55GNYDxeiUd05DYXdxzLHKMNjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788341704; c=relaxed/simple;
	bh=F98I+6PXV1vvQ1nKs0VPO8GBAmIlCI/gbHFfFY6zo9M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Z5tiL9ZzD8Co8rgo+gCtI6smCZz3bkWUpLMVk3XYyql6GhrvvlCD5s+3KYsPdsYT/FUWJaEej1hd4sMN31ECakWQ7hIVLrzO0Vaiel35ojVqeho5Au+SHIB6ZnYPAaGGDo+6vpoXL5/i8eDcg2HzG63nW3jny/n6CsPy5Dc0wpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hGY3rKWw; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hGY3rKWw"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2d032846c95so9916185ad.1
        for <netdev@vger.kernel.org>; Wed, 02 Sep 2026 02:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788341702; x=1788946502; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=oncz24DQCI7h/SAy0ZeJzGJH6zM3Y5+xwZoSuFu7ZrM=;
        b=hGY3rKWwL+XDUlbhqP6UdfJPBO5/XUSsJSHE9tA58/Pqnm457pwqP+Ugk217QZcW8I
         an+5FJQ3sSkmU6nTgcVfV6FlDASPj6iQMDFuUKR8SFreNJRuerqv4mEpgiI4G0oIg1RR
         ex9DujBKIauxjrnGfp8EOUiCmBPQYWOmNbL1hRU/Sj6WVX04eNex6CoZv0szSjvwZBfD
         OLqYsH7RtR7k1sSCaBvFYMGIrHwOaxiUFhlPOH0cI2Y/PjuCqkGdBbzGzfqMOlHm+TY+
         lKjXex9wJZ/xQdgM0Qo238U+9SDI91qW6n+llc9xxdtr7u08UXRVg42xPy5fwV4Fw1+E
         g8Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788341702; x=1788946502;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oncz24DQCI7h/SAy0ZeJzGJH6zM3Y5+xwZoSuFu7ZrM=;
        b=JdvbHEBhjTWhlqAn7/VzolXnXRia4mq44oPqxgnUIiSGXBb70oFmdVe0shWFrc5gqo
         wupbByCImTnpgAfWRh9auVJHtc64eMi59Uh3o3nSWdtRXPo6yRD+bzMEQL8rDLi7ya/n
         +ZW7jYipZO68y4dTBDRbu/1o6DXF4l/Fg97tPAOQWcjuDAqeTU+6m/yxTM45m82JkL44
         BpPs/gXTHBevYyanxDdtS83c4qpzlfZlbr+hAX28C6ESD6f5le3V93bwDH6qw0M4CpDx
         bQvR5sbKCgB2T85zecDOi4zmMmfPCuNch6YSF/QkB1ycHuScTjviRY5ex5Mwq8HlyV8X
         KQcw==
X-Forwarded-Encrypted: i=1; AKwUvBxZe3ljRkml1iuXum6mQCQHUkcxdDSIFOzsmZDHR9jjV/+xjyxa55+QVtWR97MWD9P84AgW0zc=@vger.kernel.org
X-Gm-Message-State: AFuF++kGH5rtTAXqgrJPBk8CJeywSF6iJzh5pFZj7omiFnlsi1UERB++
	NumRmqEpt45e45vc+4E/4HMHtoLEb4jEYZl6YLoJqKAuRxQqduYKulK6
X-Gm-Gg: AR+sD11EbCH9hu6AwGA/QzRW5Ei2n5arGbJbjEDQWP9ZVQLHEUE/Nr9lxz0+Df4qwy2
	fukdM7MI2Zn7GEnuYJvVasc6nst+t3W9VUyfLuoKywbppgkruk0bAH91Hw50Bqk19ZNUCgImxTO
	+3Owvtlj0PJzDUEy3FvpLTdYaEJ9KcePKtXncgHFWTsS84D38xROA567wewzqnE02GQbGynodh8
	wrDr0CQCsC7plH0oM792ubEI/SpRov+pVTh+gv9+4osbp/0bWWhT9PHPiT6Ydr0z+G9cnVbonmU
	7r5sgwYXQE5wYrun8MD27QWtE/8SBN0+e0gP2MbIq7dNRoIENMQAiVV+u3RurJkgTsBLOjdn2Uc
	26sLWlM7k4HIbMlybbXpQwWRBn0Fuc4/20NknMw0EkjMhtI8gwfq+ZHj7N+046TWutBYq2MYS/5
	UnWOCxryyC8h+DffkmAPC3JGK/vSBX7lLblwnZM6DKV90GzNESGQnwV9+iMhttIPBNFkE6XpCW3
	+K97SiT3xfeuoNy1Vfil+qgYCzTikwRm/Q=
X-Received: by 2002:a17:903:1aab:b0:2da:f1b1:56c4 with SMTP id d9443c01a7336-2daf1b16445mr22990685ad.3.1788341702379;
        Wed, 02 Sep 2026 02:35:02 -0700 (PDT)
Received: from archlinux.domain.name ([103.97.242.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-32f07b7a175sm5257507eec.17.2026.09.02.02.34.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 02:35:01 -0700 (PDT)
From: Keshav Goyal <keshav74123@gmail.com>
To: anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Keshav Goyal <keshav74123@gmail.com>
Subject: [PATCH net-next] igc: remove unreachable break after return in XDP path
Date: Wed,  2 Sep 2026 15:04:43 +0530
Message-ID: <20260902093443.93466-1-keshav74123@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The break statement after "return IGC_XDP_REDIRECT" in the XDP
switch case is dead code since the return exits the function
unconditionally. All other return statements in this switch are
not followed by a break.

This was flagged by checkpatch.pl:
WARNING: break is not useful after a return

Signed-off-by: Keshav Goyal <keshav74123@gmail.com>
---
 drivers/net/ethernet/intel/igc/igc_main.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 1fb5f3cbe93c..3b7dd104d8d9 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -2525,7 +2525,6 @@ static int __igc_xdp_run_prog(struct igc_adapter *adapter,
 		if (xdp_do_redirect(adapter->netdev, xdp, prog) < 0)
 			goto out_failure;
 		return IGC_XDP_REDIRECT;
-		break;
 	default:
 		bpf_warn_invalid_xdp_action(adapter->netdev, prog, act);
 		fallthrough;
-- 
2.55.0

