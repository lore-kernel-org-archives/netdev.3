Received: from mail-pz2-f31.google.com (mail-pz2-f31.google.com [74.125.228.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E630481FCA
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 10:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789642360; cv=none; b=CYOlfyF/qj7mMmY6FgGl8I7y/LF7o8QYGwh9OTbGc4E8NoSuPvhQ0VWOTnspmd6kSvquYO4pRq8NJek3i0jOYbU9SWmEEhOzYMdiSG/oToJhuHIAjw531TCtxEiK9g9iu/l1fX3lQNviU/MYFJYGiEunfHb5fK3i9Z8WEM+gO5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789642360; c=relaxed/simple;
	bh=imAUhfjlbGbx9FgWluzbH/vR1GastyJyq52ZUxeXQ44=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LSnlu3REP8Kzl+iVESm0heZ/HxBVkdWV4bmODFroaa1BfSG6KOovATCWPU2Xnzw36ldPEmMmFGgGRwmpPNv03sh7t97WeEZPp0y6FGAgz5GpE97jB5g74mnAwEEfs2ZWwZ8e2yyyubdKJoeu3tLJVvkjkrKJhjMGXq1DZA6zFNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AdEApe+H; arc=none smtp.client-ip=74.125.228.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AdEApe+H"
Received: by mail-pz2-f31.google.com with SMTP id 41be03b00d2f7-cc1ceb47d55so111593a12.1
        for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 03:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789642341; x=1790247141; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7u6svTs4k5fVDk0RxXve6EP4/L0851Qdz0RFWFIyYB8=;
        b=AdEApe+HCZT298UxQrYcHkjxL9F9bjRCGL8WidtsYLx/YRxzE8PUfWSk/q75nRynKi
         EGZ6jImsSfquPYTbTy1UXiTlUn+YMrl+k0VIzDWa38+gYMdSV3fg9XfEdAYv7CCczM/f
         xUA4bNHTzm7Lq4dQdzfNfxaBpJccDQGGuM4hM1teoZBpTct88eLf+SUoLqhVpta/pTui
         cNnmRPZuSW4YB7mSPc8eqDc+pmXFlCtu9kN0bCML6Gi9ENmGiv6Hm2sKabo+4psqXnas
         ZQbXRQYD+vpq5Wdlz0ZejJzHQBbvajPuWKW6J5OeDMflRQ6qv4NT6v4kQMU853SM36xT
         Sc9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789642341; x=1790247141;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7u6svTs4k5fVDk0RxXve6EP4/L0851Qdz0RFWFIyYB8=;
        b=qh7UYax0Mf0Mnw09KmaRxtVraMEuR2F2nubhvEJ/R4dYMKzNccZPkuHo7Kxz8CzOyZ
         t7/qc/f1uNfPsx6x8Y/ufctjt3iwUroLhSG3NZk3TYRvM05HkurqjYoTVq4Zl6Ow96m+
         J2MYalXdxkpPH++rfyzfi1wj6QM1CXptHZOh6ah+7GhH7fHys/6Up8PeG+3ICvo+zAfZ
         pOK8CEyw2WbDhvCnugFhuWzVlr7IOwq3VJBBAr8qKYsoqUghhwl4hbdIMsoedNOyLgoW
         GIPoMD5R2kLu4BBdYhi9WjylZPFgAjCtGmL79mxhCdVwuAPnbx15xPFAQTKbNo+DPVGC
         9kgA==
X-Gm-Message-State: AFuF++mQu9I6F+hAqNJUhjbDcngHcsFVJkBq0jFh135+WdGUPqhLlXqX
	LJEIJzTvs60vvASZRhmH+Vfq8ltXa9GgfN2CpfYzuGoJh2/NmEF65HZf
X-Gm-Gg: AYBFou3A6k2q9t2zYtdpZyLzhNkbxvBV4JSeOM3Cxre5qCJV1Ud4cB0Avd50qaX4Irq
	cBInfinJgmbmVJbW82qdT7GziT7fSSh7Z544/wRViineF3mjO7AWSfg92glw0u14YfQCKzHKcI6
	Rts5vURoo4rJ2ETx2dQZ3EnXzBHZaVDkwgqUr30/g3w62zcBm9uyvkM59M7xGlhraiKOpgIxGUl
	XB37plABthzqmJ1b/vWoUrcVmwa9G2LA1BRqF4/w8yVEXMzDwoNMtMqxGcqnVASxMSTkCTzJY74
	nUhoojBfTuurt62ZRsYNZKowF1Xbv/5cO5uZ48gS1E2L/NNgkJ+klIw7xXCghi8RzS3yMhQhE6I
	PTUtZcDXQgOEgjBV68qqNNKLE7QdBjaqvKz2zn7ZtlQQ60NaT7F8w+arxx5o6THPFPmnv2PX4wt
	inoXHX1tG72+DM/7ienYPWsS2yy6b3Ht5SKKh2JBOqZSh22dNYVQB5Jev8LW1N5C05LTzqkIRNS
	blXUfnu5OoB1lD2fWEzTDmwP58jF8ovGnLJc3aqcjIkmReys2zusaRnOls3I3MCzNM15owQNn3p
	fxI=
X-Received: by 2002:a17:90b:1b06:b0:39e:429b:1e2c with SMTP id 98e67ed59e1d1-39e429b2135mr1226720a91.15.1789642341417;
        Thu, 17 Sep 2026 03:52:21 -0700 (PDT)
Received: from C9P9279WY4.bytedance.net (21.186.101.34.bc.googleusercontent.com. [34.101.186.21])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e361b8e1asm4486019a91.12.2026.09.17.03.52.17
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 17 Sep 2026 03:52:21 -0700 (PDT)
From: Tian Xun Ng <luckilystar08@gmail.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	aleksander.lobakin@intel.com,
	emil.s.tantilov@intel.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Tian Xun Ng <tianxun.ng@bytedance.com>
Subject: [PATCH iwl-net 2/2] idpf: reset the function on shutdown
Date: Thu, 17 Sep 2026 18:52:05 +0800
Message-ID: <20260917105205.37561-3-luckilystar08@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260917105205.37561-1-luckilystar08@gmail.com>
References: <20260917105205.37561-1-luckilystar08@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tian Xun Ng <tianxun.ng@bytedance.com>

idpf_remove() ends with a function reset to leave the device clean for
whoever binds it next. Commit 4c9106f4906a ("idpf: fix adapter NULL
pointer dereference on reboot") replaced the idpf_remove() call in
idpf_shutdown() with idpf_vc_core_deinit() and idpf_deinit_dflt_mbx(),
and the reset was lost along the way.

Restore it, so that the kernel started by a warm reboot or kexec finds
the device in the same state as after a module unload.

The reset alone does not stop the stray completion writes fixed by the
previous patch: the next kernel's load-time reset already performs a
reset and stale queue state was observed to survive it. It complements
the previous patch, which makes the device tear its queues down first.

Fixes: 4c9106f4906a ("idpf: fix adapter NULL pointer dereference on reboot")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Tian Xun Ng <tianxun.ng@bytedance.com>
---
 drivers/net/ethernet/intel/idpf/idpf_main.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_main.c b/drivers/net/ethernet/intel/idpf/idpf_main.c
index 129bccaa6..d7cd449fc 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_main.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_main.c
@@ -197,6 +197,9 @@ static void idpf_shutdown(struct pci_dev *pdev)
 	cancel_delayed_work_sync(&adapter->serv_task);
 	cancel_delayed_work_sync(&adapter->vc_event_task);
 	idpf_vc_core_deinit(adapter);
+
+	/* Leave the device clean for the next kernel, as idpf_remove() does */
+	adapter->dev_ops.reg_ops.trigger_reset(adapter, IDPF_HR_FUNC_RESET);
 	idpf_deinit_dflt_mbx(adapter);
 
 	if (system_state == SYSTEM_POWER_OFF)
-- 
2.50.1 (Apple Git-155)

