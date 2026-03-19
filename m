Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82D8F2DA749
	for <netdev@vger.kernel.org>; Thu, 19 Mar 2026 13:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773928767; cv=none; b=PXxgNwtLvrdYWiQZCh0c0hma0l5c9cMuwgF7Cl94BzwkUzwQCE4jCLx79Qt99VURugjjyYmU0JhScMdi3RbQw15gjRlsBKVNujBIqc+YWMRgCRHtRB9Y2VAte2AubTLREqM2RlMv9X0fDu9z4mu+hOwl9XNaOVvLaNvLU7KbRf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773928767; c=relaxed/simple;
	bh=rQv2vpKuDgBeqdlFp5TZxrVVv0oRHZC/jYJEf+oSJDk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=q9MTnsomxAR82BgdRsYXi+J+24Cya9OgfkqiP0OJyoF5ukQvQGuKJXNUtleXXeXBns9nGdr2HWblOlrRW540wLjSKyP2lGxjaGR+8LGO46cE2HmbLO3uKzfTv3pO8FJ1KH7vox0CgXAdfqa+h8oHWpowpibREO9pfRpV+lrNJmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HKmjUOl6; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HKmjUOl6"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-824c9da9928so756931b3a.3
        for <netdev@vger.kernel.org>; Thu, 19 Mar 2026 06:59:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773928766; x=1774533566; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FM5u2uHSz/VZ9Qz362czB/Bn/2senFQYOZTR+Pv+J5M=;
        b=HKmjUOl6448b4oWGENYCkOVpT+xqBBuzwUlsdYvVkvSqCb70AievInRTG4GnNDHIbz
         VCxZRdOkrdHUgbbzr9o443vsvQTSQ2RLRFQR+Xr4sFg+aDDi6l6PKgD3LWKItoR05xTd
         uCatJu/2CyVJbw5KWbpB25ZJcZl7nHMKeYyX7u87kgrYT3czfAzYYL50WIxzXRTcHXI6
         oAltAc+i5/ibkMOzAclcDRz+aX8OlNdGPlYZ+a8DJdrFfoEfVXUgNldOizfYG4J6RJwn
         2H+4dQcs+pjYDLlKRSOQoA1vamzjYbvIHlpLcTDUueR7ABBiFK7+DjhFf34rhJx1BzrS
         Fonw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773928766; x=1774533566;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FM5u2uHSz/VZ9Qz362czB/Bn/2senFQYOZTR+Pv+J5M=;
        b=Gw9eIQTFETy3q2wtv/PfhnejDkQT9EdxpqzWITniQdqD9IFebyIDwVKBlgMxeaQcS0
         7MNZjaGFTBlUbX9OjhIlK9OQTCKa0TbBo7QhiLNhMg2lBFM3uyapXJuXwCafbOaXCRdt
         r3m8rSpPa4qVUIzAxAymfhMR2jk4zp1VHVXDeZ1YlS6h9qvqT2I8JXhp7u3iVlXyJL6o
         Ka+Bfrv54JeBwJzrNQ7zcLKulkc8Y4ymjzUEWIC3VL/22XCf3mJoyVncHASba6Se8Ycu
         NoqM9id1HJC+gJXG9/SN5MNW41KpuAY75ujtjrGrWch+aETuTfkebcwIb7C4wFqhNaR9
         ik4A==
X-Forwarded-Encrypted: i=1; AJvYcCXDzMSEOsBOe3MhdWi87T1LFhbP3ipi7TreIeN/tVpBcVlrApmFa9+gU8qvdbpIyYjZeGp1YVE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKJvYAkJxOjcMY06DSQqkUt8NkCKN2gTLjFCUmKlZZClsE/4Rl
	+V5Nj+WtCjqjaOuGPBh6e+9yZ16PUbujjs6gvJX+BpPHQXUD6uaMFfO8
X-Gm-Gg: ATEYQzwcsgHVqsELTPuCbvJpSVvk9nEo391BtklQxfdXuUJQgOijoeP/E21nLfz+Qgg
	Itp15sl2+wlAAwT2KZjUyJqKaQBCEVj16Sq/ox4u6JNp9kRrgZcZG6yhQgi4W7nKBO3Wkqv7HOu
	EkKY45VKhscFrT12bYyEp5TU+CeAu2lnIG2qa269UdjDt7tqGioI223eN3AOBbx4IBrdrNdftqQ
	4Y1/W7ScpNMDxehnOnsPKVuIo9BRcO62FZlwdxJ1oSpxg7+o/rYIDjSbadfbmjjv4aFfTWIwTxp
	CUQg/gcWxLhdF18dvjy6vn7tOZk/UaoWH2DY5KCaVkgaRpclmPpraqy6QzrHphrQ3hOglZM0VLt
	is4WluFDwfZF/a4WFJ0VEcBKSvpkgra1nwxOMY14sXxnLVDsNxAeFZG7Mz3woJQWBAflA3EAAcY
	/tv5puZiFiN0DSRyl82jIZ
X-Received: by 2002:a05:6a00:3319:b0:82a:6255:247b with SMTP id d2e1a72fcca58-82a6ae78489mr6376248b3a.62.1773928765908;
        Thu, 19 Mar 2026 06:59:25 -0700 (PDT)
Received: from lgs.. ([223.80.110.53])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82a6b56df09sm6237700b3a.21.2026.03.19.06.59.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 06:59:25 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Piotr Raczynski <piotr.raczynski@intel.com>,
	Simon Horman <horms@kernel.org>,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: [PATCH v2] ice: fix double free in ice_sf_eth_activate() error path
Date: Thu, 19 Mar 2026 21:58:59 +0800
Message-ID: <20260319135859.690041-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When auxiliary_device_add() fails, ice_sf_eth_activate() jumps to
aux_dev_uninit and calls auxiliary_device_uninit(&sf_dev->adev).

The device release callback ice_sf_dev_release() frees sf_dev, but
the current error path falls through to sf_dev_free and calls
kfree(sf_dev) again, causing a double free.

Keep kfree(sf_dev) for the auxiliary_device_init() failure path, but
avoid falling through to sf_dev_free after auxiliary_device_uninit().

Fixes: 13acc5c4cdbe ("ice: subfunction activation and base devlink ops")
Cc: stable@vger.kernel.org
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
v2:
  - replace goto xa_erase with return err after auxiliary_device_uninit()
  - avoid xa_erase() in the auxiliary_device_uninit() path since it is already
    done in ice_sf_dev_release()

 drivers/net/ethernet/intel/ice/ice_sf_eth.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_sf_eth.c b/drivers/net/ethernet/intel/ice/ice_sf_eth.c
index 1a2c94375ca7..f7266d036815 100644
--- a/drivers/net/ethernet/intel/ice/ice_sf_eth.c
+++ b/drivers/net/ethernet/intel/ice/ice_sf_eth.c
@@ -305,6 +305,8 @@ ice_sf_eth_activate(struct ice_dynamic_port *dyn_port,
 
 aux_dev_uninit:
 	auxiliary_device_uninit(&sf_dev->adev);
+	return err;
+
 sf_dev_free:
 	kfree(sf_dev);
 xa_erase:
-- 
2.43.0

