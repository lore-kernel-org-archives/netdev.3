Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E77C348C78
	for <netdev@vger.kernel.org>; Fri,  3 Jul 2026 05:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783055029; cv=none; b=sqPT8w00mE+mxJycRDZZxfmElK8imT98Q3H9gbnTTXHDPlDKW/CqIbLm85zAC05fukCoNRDiPf6YAJiRcKg1AgnY5ebl0Mvau2KFnElrMmUHZZrtvkKqN89d8VXWKmfnzcmo5NdY2UEGZ2jnf9kYKzRX/7pUZYcatGKxAnMa1Dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783055029; c=relaxed/simple;
	bh=TuAAEPv2FnYqfxCkiAndHbEEgXy00kllWlsTVXvwO0A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uv0f66MweNvH6sstyUbdQYnyEGAiqC8Z+3in4mFqRcTriZOCble27dzrmCckVkkMCcpw3XadvBEE+wewfWvizjU4nM8W5vCSMEq/DdHmkE/lDwfQILEvHNG9LPEqY/QydNUizBUKhkbzWk2D9fuOh0c5b2a4MsluwyF884x5Mbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tJl/oIGT; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tJl/oIGT"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-8efcfdb2b43so1038316d6.3
        for <netdev@vger.kernel.org>; Thu, 02 Jul 2026 22:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783055017; x=1783659817; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4mjd3S3mD4H3ly0J/O0woiYTVd9pmAc7B7F5gVF6+rg=;
        b=tJl/oIGTGD+lO0KDWPtrlFYl6y4dGEv0kDXOjHu4LH2NE9lhmcYe0MlJncT4LKPO5c
         bPBdrzBe88tsjqUu0gc1KZ43fTyYzkzoCRde8pMyt7gOCaIKVTwKNS4rSpqTnUmzBUdR
         nw6C8e+1FbY7qdhE4NrUtzLzSu9UuxJM+NbAVHM/2T60byP606fD9UVR+sHAkiAnc9/k
         Goq/kPgDkXCSMG49hPfgGSrOakQt1X4iawgWICVzXsgRjzgGNQ0tNoGkAoTaxd0Jvcey
         7eaSL3IRmwOHEwgKq1eQuEt7YbTgegTanxL6mRgcLt0w0IPtPZQ0HBKBNY/49xpXwqVK
         3pyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783055017; x=1783659817;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4mjd3S3mD4H3ly0J/O0woiYTVd9pmAc7B7F5gVF6+rg=;
        b=Zc+M4Pohk0EOumX/z0mc8heLan5n7cHAHqupa/fGUteJltH/Muj1tiUjx0iEWQnes7
         WLGfzcVO4KI1b1CHfp7+9mdNBKx8+rl+dlMFWjExzeu6HeRe4DZrTSV45XDMyvLOd0j2
         7owJuwmQKPHckZyLHd/LsibSVXexD2nMxrIe+Z91s1XcNmYjDyJxg2F2JqrAAqQ+QK4X
         gaukPVqTR65nwOzZRSvUbB6k30BORn67kc0/+i6Qi9gGdWv2yoMDp0/JkUwA8NW7H8Sf
         TuokejRhUba08/ZsJvxAdFukdrVFqDhmXAN7H8DpW+Esd4rWYj5wIa3thDyZhH+AYynz
         yECQ==
X-Forwarded-Encrypted: i=1; AHgh+RqOihDWVtp+EKsvXu4PM3E2jWy0ugHEAScEQNKbdAyXZ4y6yxLjEVSJF7YA4AaS462aADAHjGM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSLVYbznS7G49EWEIIn6coAP2Y4tmdS6NOs1bvVP6sKeRaFxXT
	80V6ddN+D2O1HDBrT7hue+bsHBsM9CuxlzduX+NqUwboN9jCTiaz77+I
X-Gm-Gg: AfdE7cmUjpMSBeZ1IBWnG52/GJcxe4YNjDsFpC5b0+0tuJoYZYSbBjijVPhzCAqjri9
	DFaqkhYVOZYB56R3G2pJVhUobRVqt5pjwjVry0oAQKi3msBgaui4b0imhIDxZe2ZUMxIi2u+j8n
	NEYY+tRlA9U9IJHPWlWas5AVOM9s6ebh5csH7+YiJN/yhLdArPsu04MfNpY7tIdpqr8E30PcNp8
	OUBGMj2UciHK7pUaD7Lo4RQYsbO8+lvwUTBAmTrjzpPt9//fiekZEOTgDFY+zoSxlMPT3K6MU/a
	MBfpUy8xmAdvtY337+0/H71DLa10OCjSRN0Fb4E0KBOBEX5u9wc/UPfrttVIok1KAvkARrwKWn9
	D+rpcHzz1gGEcOMbdnaclBqNS13MnZLlB+32HX/vrhRgRlnGJlI8ydb7aQ2/umRxVGDRmUorvl/
	bFK2lpQNfc0TmhJX2EV9ouF4MO+SmiRl7fBOkgqDlTSzOMz6eb/Bdvlpc+Zx5uYhJLGSjvnqaQ/
	n4N1LjTKZoVwjM=
X-Received: by 2002:a05:6214:4302:b0:8e7:d752:ab34 with SMTP id 6a1803df08f44-8f3c66c558amr133708806d6.12.1783055017034;
        Thu, 02 Jul 2026 22:03:37 -0700 (PDT)
Received: from i4-gl-tmk5904.ad.psu.edu ([130.203.156.186])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8f46e27d53fsm46576866d6.5.2026.07.02.22.03.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 22:03:36 -0700 (PDT)
From: Yuho Choi <dbgh9129@gmail.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yuho Choi <dbgh9129@gmail.com>
Subject: [PATCH net v2] idpf: Fix mailbox IRQ name leak on request failure
Date: Fri,  3 Jul 2026 01:03:32 -0400
Message-ID: <20260703050332.121551-1-dbgh9129@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

idpf_mb_intr_req_irq() allocates the mailbox IRQ name before calling
request_irq(). On success, the name is released later through
kfree(free_irq()), but request_irq() failure returns without freeing it.

Free the allocated name on the request_irq() failure path.

Fixes: 4930fbf419a7 ("idpf: add core init and interrupt request")
Signed-off-by: Yuho Choi <dbgh9129@gmail.com>
---
Changes in v2:
- Add net tag for the patch subject line.
 drivers/net/ethernet/intel/idpf/idpf_lib.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_lib.c b/drivers/net/ethernet/intel/idpf/idpf_lib.c
index cf966fe6c759..bb81e620c5c8 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_lib.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_lib.c
@@ -139,7 +139,7 @@ static int idpf_mb_intr_req_irq(struct idpf_adapter *adapter)
 	if (err) {
 		dev_err(&adapter->pdev->dev,
 			"IRQ request for mailbox failed, error: %d\n", err);
-
+		kfree(name);
 		return err;
 	}
 
-- 
2.43.0

