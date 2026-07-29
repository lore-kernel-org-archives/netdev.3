Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 413C4432BF4
	for <netdev@vger.kernel.org>; Wed, 29 Jul 2026 22:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785362497; cv=none; b=F22FEUFLnekX3lqLgVVjM3aq2TuU4ZMr5BIty+jnvYHUcw3g1lZlmgZp+KFwAeve0JFSrf+e5jJlu9pDcuuFbM9dBRfm+VD41iRfD880nNhgGBfaNHmEK/VO4DlmOqTtB7b7Iy317+wz6uTYm0XC4X7DRtkGUHiMbqe9/R9sl6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785362497; c=relaxed/simple;
	bh=ji8FZ9urZ20Ho55aJON/fjdEMmdDiQK30uPh3CF44LU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k50jTiyO5jdlZ0eO/WmzLSskWRh09snA3gSCJD7MPOAaEVD97Ypq5yUVA7SWAco4nMX4QkSFHh/73jkp4PajcaZT9c2kdhckCdf8DX10kq2aQq0Kq41wKYwE3Cf8+X8TOvHNHUaIo6YbsTMzHtzb2amvxaDCOlztz3d77CwfgE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hwnQVV8M; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hwnQVV8M"
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-6aae4369c87so738292eaf.1
        for <netdev@vger.kernel.org>; Wed, 29 Jul 2026 15:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785362495; x=1785967295; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=6HV4CsRpdcvPXPl8KcDyJEkKf2eqDuNJhemFCyQyOzw=;
        b=hwnQVV8MA/OMsAIQuo0OgGQ/8Ek/jJrGjJ9zQMQo/cNY/845EnMNclpzStT30jqIXV
         R2Xo0HmqZPoW11DcHUX9iSO5eWdidnX0A3XIWyUERBoNcFi6JBIJ2LZSC+wvFdMdMupk
         NmByg0sF1uY550XkpOVoQsg8aYJuJIY7Dmk/nrGgzrYVE2v7u5kLondrGZvjLe4BGyPg
         bxmVQ5NFRqbRtfmshAzdmQdwq+1ZyyTP3kk+pnQiP5zoqViRHg+qGttaFh7NI9dxtvIw
         OT8gUbWKVnf6MzqKd2WXc5O4mzXZba8yvDfX0oPQX51opCZJ3J8rZS9EpJhMHJmnJYpw
         KFNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785362495; x=1785967295;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6HV4CsRpdcvPXPl8KcDyJEkKf2eqDuNJhemFCyQyOzw=;
        b=LfamoAf7x717oO6YNOIk7xf61n/D32gy4nXI1eZgFH3QG0B3kUFjXDRvacjQRDDSKK
         Ze+Pxj7mSxaFyQLFPcifgDidvikurjbRzUJGUGELI7gu10kHP1FPB6wlm6WdmwMTKOFc
         zyZxLjR9Kce/N3EVo6HAXvUhWc2q8Kk+stpJEGskwddswWg27tt9lq7MvmZgMXoSjbLo
         TIhR2IQVfhAfzvcVkIvHsKuY36I4Rz4wbjrNRfA0vOLHpoYhCHgTyrDAQVk1wdfUdI8F
         sLxycVNmyHWIGlY6bdPkAlAYflS9Hl9pieLKBFh8ENx9sB+Fc+LrS9UR5AsfV2P65IO+
         rEFA==
X-Forwarded-Encrypted: i=1; AHgh+RqbTklA3FFaP93mnyRORMm9LWCFzNEUL2eZ5PrQcFrK39TUBFtB3HXWtyjw9GXh4/ECqSPD22g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNCtZkzXvJwOcfjhW7nVEyVP5a2gjlvNGr5hEG7HfcjAqLuHvc
	D6ZeWHsgUQbdjtGsBAlBzpkt0ZhACP6kd2EUrOVQib9beokQ16zmCoYq
X-Gm-Gg: AR+sD10puvRTYrC7VYkV9zPiuT3+OfeI6bVFFjTgcnB/fSQJH3JWHu2suuMT1INJQTs
	gtH9UFCPTfbJJbWNTU32eCDrwcts4W0YDrpc0YWUYbNHO/1Bv/C53Kds33AynlYgUaSWF8HgA9K
	cuUPBxQ6QrXHCsoj8pnwwxAsn8ZFRA2XjNw7Fp6GofuAORDsZ79EJfCOe4J1mj00blWniWUu6Cs
	cZOZhLDI7Sdv/yXNHY21M668g4lJqANJl6j7de7YdsP6f3Cyflua5HBcdXf9WPOnoMSdY6urZ9x
	NONwDHkzHEYIBm4yxJnmKUuU12sUZ17JGCkzcIT2TCnPgHp3d766nVGlpj1jG5qkQTi0DrOBHNT
	70/6jQgh1lADOBXsPIxX0dVRIYN/3lZY9A3pSzEMQcywkzl0739OkbwssVx7w+pX8bBfzomFyOl
	9khU3r7/wCZMFjgnZyJN9cuj89GVkoiYCDDBHRzDOf8H/Hdrwvu7CUo9x0HvI=
X-Received: by 2002:a05:6820:201b:b0:6a1:50eb:210d with SMTP id 006d021491bc7-6acbc1610eemr123907eaf.66.1785362495073;
        Wed, 29 Jul 2026 15:01:35 -0700 (PDT)
Received: from localhost ([2a03:2880:12ff:74::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-458c2947cecsm12095fac.12.2026.07.29.15.01.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 15:01:34 -0700 (PDT)
From: Will Chen <will.chen.tty@gmail.com>
To: Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	David Wei <dw@davidwei.uk>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Joe Damato <joe@dama.to>
Subject: [PATCH net v2] bnxt: fix memory leak in bnxt_queue_mem_alloc error cases
Date: Wed, 29 Jul 2026 15:01:31 -0700
Message-ID: <20260729220132.1256924-1-will.chen.tty@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is a small memory leak in bnxt_queue_mem_alloc:
when bnxt_alloc_rx_agg_bmap() succeeds
but bnxt_alloc_one_tpa_info() later fails,
the rx_agg_bmap allocated by bnxt_alloc_rx_agg_bmap()
is not freed in the fallthrough cleanup cases.

Free the rx_agg_bmap in the err_free_rx_agg_ring case
and initialize clone->rx_agg_bmap = NULL earlier in the function
to allow for safe fallthrough.

Fixes: bd649c5cc958 ("bnxt_en: handle tpa_info in queue API implementation")
Signed-off-by: Will Chen <will.chen.tty@gmail.com>
Reviewed-by: Joe Damato <joe@dama.to>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 3 +++
 1 file changed, 3 insertions(+)

 v2:
   - Rearrange the order of the frees as suggested by Michael

 v1: https://lore.kernel.org/netdev/20260728191146.1744825-1-will.chen.tty@gmail.com/

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 7513618793da..004ef99f4530 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -16217,6 +16217,7 @@ static int bnxt_queue_mem_alloc(struct net_device *dev,
 	clone->rx_next_cons = 0;
 	clone->need_head_pool = false;
 	clone->rx_page_size = qcfg->rx_page_size;
+	clone->rx_agg_bmap = NULL;
 
 	rc = bnxt_alloc_rx_page_pool(bp, clone, rxr->page_pool->p.nid);
 	if (rc)
@@ -16269,6 +16270,8 @@ static int bnxt_queue_mem_alloc(struct net_device *dev,
 	bnxt_free_one_tpa_info(bp, clone);
 err_free_rx_agg_ring:
 	bnxt_free_ring(bp, &clone->rx_agg_ring_struct.ring_mem);
+	kfree(clone->rx_agg_bmap);
+	clone->rx_agg_bmap = NULL;
 err_free_rx_ring:
 	bnxt_free_ring(bp, &clone->rx_ring_struct.ring_mem);
 err_rxq_info_unreg:

base-commit: 3f1f755366687d051174739fb99f7d560202f60b
-- 
2.53.0-Meta

