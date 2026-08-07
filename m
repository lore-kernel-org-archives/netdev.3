Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE0443EDAC1
	for <netdev@vger.kernel.org>; Fri,  7 Aug 2026 10:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786096841; cv=none; b=jSziKS5A3BYzyq3EzNPmfiGrrcV9pNjPrUkq0m2/+L3fd281cu/sBs2UfMt3lQgNIWkZWKZ3nN6C+nnYbEcJ5E6fWDrYR7lMTER+6CzZdH1P/HUnCqyormPmT+l5f9hCfhDGARezwiTS+6+wHq9olKcgLwBoUFbIpQsYu/ITEAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786096841; c=relaxed/simple;
	bh=WE8i65b9LC7lL9iQ5/lEghqFQeb0neL/8MWHHX2SAPE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cm7LG1jKJg2n6gKSxwoZ3Q6ICq+jVhjtn1xCkhstDbkbJbHdB7aacCTUCJp/sLGIZbkFnPhIp7h+Iwzv/WE6U4aYldlmcw25+xhOycebQgWOF9xfcyGcPJlXFnYmbuZlQhbupRlNaGTdEoeGPFPGSaelsIjaxgT0WYKXNtxKEpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pm1SLs9V; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pm1SLs9V"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2cf52d15d88so29816745ad.2
        for <netdev@vger.kernel.org>; Fri, 07 Aug 2026 03:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786096839; x=1786701639; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=QQZgcdlI2EieaifCVQjJlrIUWRZzFN6DkbdW2khQ3hg=;
        b=Pm1SLs9Vov4ax6nEhgu4CzxOZs+MSR7P3WXTpdz1PFwe917a57sFkh67hXtDvoqJj7
         UiKLoOulcmT1bPsSkAhNOiNxPId7cRsPSg45sov5/hdJRxKZjLyClutI738g4XSwHSRM
         5Soudi7LnRXtX8zNHhcvU1On4RKmSFFiB9Oc1jLgpCGx6D4D4JxJ7cN8NGnW6w6GJ4cY
         mYpOpIYaAd7Nk1v0eHriKCW5pyfjewYHYunp96L5s8khxO3XCbtaG16xrxlDaSJzu+7q
         DGGNKtuDY2jbPKeSvgK1Po67J3CQmkF2WxirP7NhVC+9KGapmkpb4NUjvg4nLNGpJrgT
         oN+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786096839; x=1786701639;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QQZgcdlI2EieaifCVQjJlrIUWRZzFN6DkbdW2khQ3hg=;
        b=gwwb8tLLFurWuxKrAOrLXxHYcVl7LTGRiyZ9jxYTy1krlN96rvW6qHgLP/+COSOj8V
         PD+QbrF5g6SA8m25O3xE/QXUA/iuFrwrVVV8VqltMfzddeEd0hzmWkT1L2W2HsENpeOM
         pSjz7hxMfpeZf/Ol/1FnBQKnEkS2rwoxnTEJqcbgpupYsaRVHgU3XgkIeKtiZx7w/ziE
         eY8YoH3p3jN3LZp9FTgHDoJ+J+oiLxZO+yotzWQAbIygjSd9O3zzuP/Jum0zFciDl/fL
         wRIANDhNTX42HsetJgEjHTaacvTq5BcLbWcU1DIOlSiOqhDLnJFmt9Zp09OwBsOSIoDF
         0Wyg==
X-Forwarded-Encrypted: i=1; AHgh+RrkoahD1dlvSX1g3X3RQaQMQaBWjIioq8e1G266QNSi1s2sjKRtZdhLfErKOOxOtfl3/KYz234=@vger.kernel.org
X-Gm-Message-State: AOJu0YxT+15dmsGlZ9GvYq8214XJHmmDQ5Ji8WMbPIfnQfVJnAowdjzZ
	GKq1XbKhJHlhsJT4kkjYz056VHWRm2EvsoPMqLl/S1SspsK0ABzIYufc
X-Gm-Gg: AR+sD12HApZxOUKDjT34wZFZEJJ1KOILIAFiDlulQzTBWHIES1mtCzSaPYdrSkUacZo
	QUDrMk/lJIQgJDLEf9abtYs3xa3UMxBDmsnV0SNLM28Yd/k8FSY/6zfsDGUQqe3Z/fWnoj0GVG4
	fq/EZm55dp7l6zFOQKp0cxLVyl26J1H7CvwVz0xDv7jIxeumpxzIAqz9Pz7GL7C3c6PGATVJDpV
	NgnmWq/p2BWjm8nmmskVMEkdqlL/vgei+g0CeMRX7x+yISO2aXDKuTOpe3kB8Jb+jrLScjzWw4U
	KqEnRka3H0Acci4nrv5yKJXxUZM5N3JFaY/XcgkrW0hdKqGtK3BOtcW6qckyDuaxcgTLk6WTcT2
	92hJYF1II9sQVtgRTxMkhOl1pnl0sj4UVMKRfplpzrpplSCSHlHLqHue2XeO3KayS5Sy4Kvqzp1
	s05wQIgHaSOFtMzqirv5VXLkPl34WONd0x1rqstXt70TSsbj0fi1cNT6Yso2uCqgOP8MYUjfWBp
	XvVfOLs1sljdm5AiZ+ULtzSONrQAmnHsDkZ4mgUSGwOGdZkNOyE+5KM0KFMd56LvHw=
X-Received: by 2002:a17:902:f60c:b0:2cc:aa36:c04c with SMTP id d9443c01a7336-2d0ca7afcabmr254341645ad.1.1786096838646;
        Fri, 07 Aug 2026 03:00:38 -0700 (PDT)
Received: from EAIT-H54D9Q2FJQ.eait.uq.edu.au ([130.102.10.60])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d16c4a9f0fsm6500035ad.68.2026.08.07.03.00.32
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 07 Aug 2026 03:00:37 -0700 (PDT)
From: Yu Zhang <yuz08559@gmail.com>
To: mst@redhat.com,
	jasowangio@gmail.com
Cc: eperezma@redhat.com,
	kvm@vger.kernel.org,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yu Zhang <yuz08559@gmail.com>
Subject: [PATCH 0/2] vhost-vdpa: fix a use-after-free on the config eventfd
Date: Fri,  7 Aug 2026 20:00:23 +1000
Message-ID: <20260807100025.19750-1-yuz08559@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

vhost_vdpa_config_cb() reads v->config_ctx with no reference and no lock
while VHOST_VDPA_SET_CONFIG_CALL frees the old context, so a config
interrupt delivered at the wrong moment signals freed memory.

Patch 1 stops the fdget error value from ever being installed in
config_ctx.  It is a fix in its own right -- the callback tests only for
NULL and would signal the ERR_PTR -- and it is also what lets patch 2's
lock establish "non-NULL implies valid".

Patch 2 adds the lock that closes the use-after-free.

This is not the reopen refcount underflow fixed by f6bbf0010ba0
("vhost-vdpa: fix use-after-free of v->config_ctx"), and it is a
different bug from the vq call fd one I sent on Aug 6
(https://lore.kernel.org/all/20260806150323.2154-1-yuz08559@gmail.com/),
which is about the parent caching an eventfd_ctx it does not own.  The
three touch different functions.

Tested on v7.2-rc6 with KASAN under qemu, VDUSE as the parent: one thread
swaps the config call fd on the vhost-vdpa fd while another injects
VDUSE_DEV_INJECT_CONFIG_IRQ on the VDUSE fd.  9 of 10 30-second runs hit
the UAF; 0 of 5 with the series applied, with the workload counters
unchanged either way (~30k swaps and ~2.6M injects per run), so the race
is still being exercised rather than merely not reached.  Also clean over
5 runs with PROVE_LOCKING, and vdpa_sim shows no change on the shared
VHOST_VDPA_SET_CONFIG_CALL path (20000 install/unbind cycles plus the
bad-fd path, identical before and after).

For patch 1 specifically: with a working config fd installed, 250 injects
deliver 250 signals; after a VHOST_VDPA_SET_CONFIG_CALL with a bad fd,
delivery stops on an unpatched kernel and continues with the patch.

Yu Zhang (2):
  vhost-vdpa: don't install the eventfd_ctx_fdget() error in config_ctx
  vhost-vdpa: protect config_ctx from being freed under the config
    callback

 drivers/vhost/vdpa.c | 44 +++++++++++++++++++++++++++++---------------
 1 file changed, 29 insertions(+), 15 deletions(-)

-- 
2.43.0

