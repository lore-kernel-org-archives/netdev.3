Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF048366057
	for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 11:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785153501; cv=none; b=aBLP7p3ned7Yswt8N+VHGwaTcYxXdXHOll0VHNa9aMGkbZToGmGz7/8v7VxkMQKZUpkyjinVC+SzxQE+uI+ItexXr/tTRAdHIZJzI0dNRlEJsQRSildoj68a2Xn9UIdJTjE/Hqaans0mRUtO/bqkBZ41YJMUtSjTDQOHfx+99Xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785153501; c=relaxed/simple;
	bh=jksedIuDwBqrUn1g+sUCJMfrbna1gPVbMoxSomrh6c4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=q6/vYMTdpu+H3INgxCsc23l5hKNi7/S3LeeN7wWDWWdfzk2rZrsnJrppmBRhiFz+ywXZz4F3cEAx9r0Oxnzo/kjt3dd/+lbPQE/qDQOcEwY1egvU2fU2Wm4VsoQIsKsRxmDZDLqabcHdJNXdqWGcEvC/ilyUyyDWRLu25dTWs1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U9/bt12A; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=AHAuUQp1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U9/bt12A";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="AHAuUQp1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785153498;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=a57vSMFq6QWWBI84IcyNzkcoKvzeM6bUbIgH5iMpCrE=;
	b=U9/bt12AG1M83AGRYSqla1c0ZXcXv+NtepWt+0XRnQFTZQxWagyuG9uK6hhCIRdU3z9JZ6
	+Tx5V8K7r3WTj5ZBSL8SDeGu6bT3+8rF4yZ1focCgddyb5A/V3CE8Q4yNTaJpj7EYAw0LQ
	DuslVtFsLIpxREHW040TcUU1TisuGGo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-263-2469aURtPUefIsxxi_8kjQ-1; Mon, 27 Jul 2026 07:58:17 -0400
X-MC-Unique: 2469aURtPUefIsxxi_8kjQ-1
X-Mimecast-MFC-AGG-ID: 2469aURtPUefIsxxi_8kjQ_1785153496
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-493bfc3b84aso15216815e9.0
        for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 04:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1785153496; x=1785758296; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=a57vSMFq6QWWBI84IcyNzkcoKvzeM6bUbIgH5iMpCrE=;
        b=AHAuUQp1POKzceyHcIMxBTJboC69MW0ZNSso9XdG/cP53aKEEUK8IJdscBoK3DEDus
         mUMfY/Fg5FJqGwmUysi2olshuFdhS/INA/LHMbb6O0BvdG8rFtNgwNvMmMyg8aXEZprD
         4PTyMP2UnlkOTI4GGXeAPU6NDfvTiK0Y2s+mwd9dozRdPOMPBhhFSv2TKUunltqn9RrP
         c0sWtUPnae9GegDiAqilqwfU12Sp6MwqzV5HnFUSF8aNa/VXsV0IXSrSvO7oXzJ7xA0P
         30ZsyfIhgN5dNrNSMjxTbO9DvLLmLsCm5/2RWIFri5w0Xxlj2xj7VCXELhDnRO+pjZkK
         wh9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785153496; x=1785758296;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=a57vSMFq6QWWBI84IcyNzkcoKvzeM6bUbIgH5iMpCrE=;
        b=epFOKLiPwEadgVDggxkONglLS9dyoO2vdYHTvPZv/v8lPkz2d+ztNSX2Hr2iIo7O6q
         gNKa4F/qsrj7U9btby/r9jzgwXzjjJWeSOX9Id+JcQd9EENeyPvxwk8Wln7c6OVfDEUo
         NLi81tR1qacMHsfRM1k7aT6bkdsEC0spuZjimXFTluCo3Lpkk6BCwbyLCcE/M+xfRH2o
         M4GoWXKEYSI2RBjXC31yDGHzeb4PfDvvqA2bIcLvLmxMab54cEc5X/oVVs9U+U/H4vT1
         bPrS0hQtQOmMySKM3csia0aii1qw/gZGaNL5xQ8gHQUQH/GODZ3PLfBhE6F7t/N5Ahbh
         WdcQ==
X-Gm-Message-State: AOJu0Yx2KWzUZVNnZKBGM6oWqtFWorNtljFRdsBvnTkS1btcE0Jpw7UU
	6hj6BH7B9853xjAVqs/vpquLZ88aCRkj/2uj+5IsXfumkZg9ohmfh2kFX70spbbD7kBq3ugW72D
	9EcHlniD5TuL7yC/VJoGOg4r0xVFRn/q2t3w0qdhj83qMvW2RR9nOsLKhiQ==
X-Gm-Gg: AR+sD11no2y03cGBko35lZ/oQp8icGNlUDyNOnRpVgs3IzeHQc/z5NtQq6bJDsuZgud
	NUCsD5v7v7U3oeacqAj87/g9ucUYDzoWoX0jPK1s4WBqaanK10MHdVBrV2KrsbFLkDWoI5xCDPa
	P1nDQUBDPWRjMqatgeyKyLC8YPnADJl1ku4uDVAQVQnMc1pFzV95Hsdn7DDiphoQjZcyf/bWNrJ
	GixowiDbt1XT7yf4kFO20ULeWQR1l5QzyAiLKOu/ERUNvVbPDKwiSze1d4ENPGo+08bbT/kQ3yf
	9DI8iugRtDqSOZUQae8wgY8rYKgFQ9MVzZUlNZFOWuulGfo4Zgj7htTT8vlMA/jqCMOU+ZyXWpR
	tlyYNiWqZPe13LA==
X-Received: by 2002:a05:600c:1d0d:b0:493:c194:4e7a with SMTP id 5b1f17b1804b1-496b56da6d6mr96685635e9.3.1785153496212;
        Mon, 27 Jul 2026 04:58:16 -0700 (PDT)
X-Received: by 2002:a05:600c:1d0d:b0:493:c194:4e7a with SMTP id 5b1f17b1804b1-496b56da6d6mr96685235e9.3.1785153495810;
        Mon, 27 Jul 2026 04:58:15 -0700 (PDT)
Received: from fedora.redhat.com ([216.128.14.178])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4957f9b8b67sm262590285e9.4.2026.07.27.04.58.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 04:58:14 -0700 (PDT)
From: mheib@redhat.com
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	sln@onemain.com,
	jbrandeb@kernel.org,
	Mohammad Heib <mheib@redhat.com>
Subject: [PATCH iwl-net] i40e: fix napi_disable hang in i40e_down() during firmware update
Date: Mon, 27 Jul 2026 14:57:56 +0300
Message-ID: <20260727115756.105038-1-mheib@redhat.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mohammad Heib <mheib@redhat.com>

i40e_down() expects its caller to set __I40E_VSI_DOWN before calling it,
as noted in the comment at the top of the function. All callers do this
except i40e_vsi_reinit_locked(), which calls i40e_down() directly
without setting the flag.

Normally this doesn't cause problems because NAPI drains cleanly on its
own. But when the hardware is in a bad state, like during an NVM
firmware update, the ring descriptors can contain garbage that
i40e_napi_poll() sees as real work. Since __I40E_VSI_DOWN isn't set, the
poll function has no reason to bail out. It keeps returning budget,
napi_disable() keeps waiting, and the whole thing hangs. The thread
stuck in napi_disable() is usually NetworkManager, and because it holds
the RTNL lock, the system can end up completely frozen.

Set __I40E_VSI_DOWN in i40e_vsi_reinit_locked() before calling
i40e_down(). i40e_up_complete() already clears the flag when the VSI
comes back up, so no additional cleanup is needed.

Fixes: 41c445ff0f48 ("i40e: main driver core")
Signed-off-by: Mohammad Heib <mheib@redhat.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 878e0c46e5bb..78f95f63b588 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -7463,6 +7463,8 @@ static void i40e_vsi_reinit_locked(struct i40e_vsi *vsi)
 
 	while (test_and_set_bit(__I40E_CONFIG_BUSY, pf->state))
 		usleep_range(1000, 2000);
+	/* required by i40e_down() */
+	set_bit(__I40E_VSI_DOWN, vsi->state);
 	i40e_down(vsi);
 
 	i40e_up(vsi);
-- 
2.53.0

