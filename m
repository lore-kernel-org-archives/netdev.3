Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E55238F935
	for <netdev@vger.kernel.org>; Mon,  7 Sep 2026 09:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788774910; cv=none; b=TY+D+LcQYt1ZJ2cBIsLg8ExVorcl8v56EDZ2R2Ooha9kr+sCQHiE7Hc9hxJR4ybKxFVRh1cNVWKKJxSZF4ihSDWYbeO+HrOOauRLywiXZa3jy6qluzp9Yrfgs0CJjQJFyXMFn/G5s2ZaoMJv1HJFNM67LwJV/N0Prf84o16go2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788774910; c=relaxed/simple;
	bh=GvzajizbOY90kaz3HZugV1nPa93/ZqnhoDEgNe4G3Jk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=euZc1k9uhU4q10YazauqZDGQAfmwL6BBmVW2rUW0TtOaBLBXsa6LNxXiLaksw3uYhUu6q4+U8u+wLHogU11j177MgEYPTqdttsRTz5eGrHhMHnW7I9jCy9tlr+wsfc/ocKaBAh2B1zLclH6CQwxcU5qYBuvDW/wXiMUl6cI3sDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EPe3KuMj; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EPe3KuMj"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-39b52169dacso1053080a91.3
        for <netdev@vger.kernel.org>; Mon, 07 Sep 2026 02:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788774908; x=1789379708; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Gm+TyPV1iDM9aVdXh0QUxUBtbEP62ax0fUff+nPkYjU=;
        b=EPe3KuMjUqln7ym73592bTp9gWYhAWm6jCk6skEJpytBoim75ycjRHIfxVIlzCIeZs
         sC8eahpT9JXSlpty9H40ZuJB/AE4xx/0Qp4johqb1XiKxxtt32hVhyPQY5PlxYOKoBan
         oLw8be/vEcULyd/PMASmFVV+iRhVPIvlQS26YqaSBonkhgW4dcFkIEFQMW+8hCImdaZ2
         AlrjaAry5J/H6hYJmQE6BZIIRGbkjQxFuE0h1hVn0i1Yk3jo4ptTAackIY2IEnD/H+qo
         pq3KdZQWGOghZjbnxoZN/qv+o3N4/iLXRlHOcD+dGZe1jGlf47kR+RteG/giTGW6XjZ0
         eVtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788774908; x=1789379708;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Gm+TyPV1iDM9aVdXh0QUxUBtbEP62ax0fUff+nPkYjU=;
        b=ceXIOiaWJUoqJbXV/CuO/tYiLwYefPLvav76ZrIkiSTiVMadSdcH9fvMrQqA8C4FK4
         amOjDGsk1nI5gDXABxVT+T/zT7xS05HUwfZRVkwx1e2XOcoWV4f+AjX4ZBBKgaxlY85l
         M1NhqgfpbI8KVSuxjKxAS6jvlVblEIHH6Z7baS6kinZVwreK0hnl0bX+K+N+QJl+HOmq
         tfsTAUFFsK9fur9WUMWv/yyg9wfg1nJ/CsL6DleHDBQtTLQRLX+VqLa2tSC9iQXVmkYW
         elXe0gmEObe8VmO2wc3tLqjAnEqaj65K+E6GijvPMJXKS8aUy5zT0AWJGut2y4kEPdIo
         08VA==
X-Gm-Message-State: AFuF++lgbVxvGarzxBM6s+oRfz1UvJv3a+sXIIIX7CgWYxjFM1WPclqG
	om40GB17HYzGmvBdZRaW7QFN1sKj9XyGXXFIvqbHgeXqBlx3u76g8D8s
X-Gm-Gg: AYBFou0G3PMUN9T9JajnrLwFA8buGXTrP7I9ARiWlaNYPODda/F6DpaR5pEsREYP2H+
	qzz4+qOtpdwjfm+IOEGkbYI0FlNtdyii2vLNGNY7hHWtddGnLazcD3kdahb++zwODCQiAqyiDBu
	GMWwsT7pjEEqcTqz1OOah3jRfl5JbUvBPEArsH9ZgLgSJAaPGneVYEYIbVKMQqQ7PjbzqZ0V9Gl
	rYHv75t6hcr7mXfIgqb3c1vJ/GuRMrbyl8VNzfwY/e8bwCn5B/Kaq6PXkXQ4Y0oldVZVMIQKXgo
	5roTvU/xJySYWnYmM54AFDEzM5iZKGQZFu/xrUhdzKO+wTh7mkRxjWLD5/B6HoE/t9qX1A9zZc5
	6S5DTm0OTfv3lel5sRdPpaRCFfwnXK6EKTU4I7g6Nf9k5zcL5qnEHc3RsYU2kNLHmlWQWwyC5g4
	IQ3IzpoLB+DKpDORkO8XCE85KZYQX3wspfpfmTQT0VD8C8JJDgwsdaGhGLipf5h3mbZTfX8GBH3
	Eu5lgWtIkFSdQ==
X-Received: by 2002:a17:90b:1c0a:b0:398:d132:ba76 with SMTP id 98e67ed59e1d1-39b2623abfemr31923733a91.21.1788774908390;
        Mon, 07 Sep 2026 02:55:08 -0700 (PDT)
Received: from volcano9f6e-hostos.amd.com ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1432424d27asm34831030c88.2.2026.09.07.02.55.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 02:55:08 -0700 (PDT)
From: Hemanth Selam <hemanth.selam@gmail.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [PATCH iwl-next v2 3/4] ixgbevf: fix typo "enble" in comment
Date: Mon,  7 Sep 2026 15:24:45 +0530
Message-ID: <20260907095446.27290-4-hemanth.selam@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260907095446.27290-1-hemanth.selam@gmail.com>
References: <20260907095446.27290-1-hemanth.selam@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix a typo in comments, found with scripts/checkpatch.pl using the
misspelling list in scripts/spelling.txt. Only touches comments, no code
changes.

Assisted-by: Cursor:claude-opus-5
Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>
---

Notes:
    v2: designate the patch to iwl-next and use a subject prefix naming the
    component, as maintainer-netdev.rst asks; v1 went out with a bare
    [PATCH] and a "net:" prefix. Rebased onto iwl-next, diff unchanged.
    
    v1: https://lore.kernel.org/all/20260907064528.6602-1-hemanth.selam@gmail.com/

 drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
index 7ce46b4b4821..7eb4acf59dab 100644
--- a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
+++ b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
@@ -3995,7 +3995,7 @@ static void ixgbevf_tx_olinfo_status(union ixgbe_adv_tx_desc *tx_desc,
 	if (tx_flags & IXGBE_TX_FLAGS_CSUM)
 		olinfo_status |= cpu_to_le32(IXGBE_ADVTXD_POPTS_TXSM);
 
-	/* enble IPv4 checksum for TSO */
+	/* enable IPv4 checksum for TSO */
 	if (tx_flags & IXGBE_TX_FLAGS_IPV4)
 		olinfo_status |= cpu_to_le32(IXGBE_ADVTXD_POPTS_IXSM);
 
