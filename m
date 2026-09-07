Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C1D1231C91
	for <netdev@vger.kernel.org>; Mon,  7 Sep 2026 09:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788774896; cv=none; b=B5grsAa74G6MFZtoEgBxIfqlK6Ar3XMFkA5INgd5mfFSPb0nfxqkzrcP82v3U40HEuuCWEVLB57w+H1B9w7jPoXM/roRznrwns+6cmn9AMpBiiT7qMY7m4HXhD1l384oER49lHxToIB/CxG29YQOBzjutiwKwXsK/xmdfji+S5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788774896; c=relaxed/simple;
	bh=m1ip0be5p6K//25N2xI+s07kjlY0PpGTuRk26Ygx5rA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ctqt6Z9Aj53KM2xSOtQ3Sm9mEIV9biWuWiqI5Sh38ZVFsqKMNGMvgDBVUgoqXWieLEV35UkFiA21tOhRwOKopkTWEZ3LjYIQw8Zr9nBMQewdTllLNt5FXqwVLcVgvjozazxrvOj+i8I+o654JbY9Mv8sahwk/Tg2Zo+ohlG4l0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cmSsXUQp; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cmSsXUQp"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-cbe6295f05bso2973125a12.1
        for <netdev@vger.kernel.org>; Mon, 07 Sep 2026 02:54:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788774893; x=1789379693; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=tR97cmi0NkWDiEH0s6YYBJjyIYeR1zRd9pdLJfF85lM=;
        b=cmSsXUQpyoAx4etzE8XRFvUYbYy6oCmXSRHL8doQHGhWFwrXtoCXT3JAZG9sOXk8yO
         SCFsceMZbXcMCYUR5mT/+rwu/HiID52NodrCSjDLWKnbfSOTPDs7W0T/7t+NoVvAgwUK
         c1Blt7jkqGa47Kqrw+NSjQ1oUmyRdVRGpv9tI0FN60m/w6VAlGFEQ0dQiC0SaYjl3Hjl
         4KRc8O3ktxwTRz0eootcBGs50mXYo7WZfX3JmR1lizeN/Ocjaz/6g2HbFRJtW0DivuZV
         4daVyhqSyTB5QrzL3U3Bwv3RKLwZqVUyXX0L0wlOymvDIbPmtHUzBWOMosMRknMVWh7K
         pzdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788774893; x=1789379693;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tR97cmi0NkWDiEH0s6YYBJjyIYeR1zRd9pdLJfF85lM=;
        b=KLdHA6ZwU6XCbAe458XFWGycjOmqzKTDlrxAsnWxfy/E/S5khUZSubTbZx7bmJZDPe
         Eb7s/dijQ4v3nMO4oRsMcgipxxP+JQwI2DzeXSK2+88hl0WSaY35t1njNK7NtGUWU6wz
         jU7uu1UxHnoLQ+myeg0IKsTOAcef/yYH4CY6LH3gqSbq8HOJxjCtfxZuV7u/hFpx2AD1
         ulDhqTfB8QiCBU/9bitQBMicviefh5/EfyGUazJCUFzGIqV9TUsUFLCkGIQO/lsKNvXU
         sm+qLLV2eFNVHWJ8b5YSVT79EsP/R1zoi2P8z2tloX/37BFCY9zOzWR65234sz2GyqU3
         2GQA==
X-Gm-Message-State: AFuF++mhEmWKHVRhp3eTwfa+DmnFL0U+anRMoeddIHueZzb/7HHeygmF
	z6VWw+X4DCdkbgOsZac8dN7Fi18f7Ch8+aiHpoo/FqrD8Ixj0XLXFJH0
X-Gm-Gg: AYBFou0KvBjocjzDtAK1d0YeZQKfrrG1gUgaKLX3PWM9CCIqUfZlq1HUZF+DIzGk2zW
	h6hzFhxSgqM2KEYG4U9Lo+9iIHK9SFmGzYYb2JPzXZlnI5Fkfoig1EgEwIgS3FELGOYttDFVP4F
	dX4PdX2dBb5yOcOKe/uo9yBXhEWVRWZhw2n0hcE68X3WC0nVWTLeaX5sSoFLeKAdXDLQRxCThqH
	P59OPXRiXYIFvw7hFRaJJ/wxPgp3+Hbk/MifUAi2bDvLmWZ2Gyasa0m4hL/F2R4FhIyTp/3CQDO
	AiLv97wcpGCJ3YIRUnek88J4hrY3lqvGdEV8U6Nd9pg9M7YpQhx+lPYCfZ+zZRySbLS8HnPLlYW
	nAXcvMFaGt89/r2AOz3rKb2/lQ3L2pVrsxe4OLMNCoIzgBNIaTKcdulF0WthlB1Agrpk5/WLkp7
	5mvT+lnkwMppnL0A/yOA3vo2/FTv932GHwf/4FIgiIeDRhMed0BKYlTHLVih1YS6xgiLGk2OAsd
	9ZvANMkZ/95xQ==
X-Received: by 2002:a17:90b:3fd0:b0:36b:de66:92c3 with SMTP id 98e67ed59e1d1-39b07fed101mr30328985a91.10.1788774893379;
        Mon, 07 Sep 2026 02:54:53 -0700 (PDT)
Received: from volcano9f6e-hostos.amd.com ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1432424d27asm34831030c88.2.2026.09.07.02.54.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 02:54:53 -0700 (PDT)
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
Subject: [PATCH iwl-next v2 0/4] intel: fix typos in comments
Date: Mon,  7 Sep 2026 15:24:42 +0530
Message-ID: <20260907095446.27290-1-hemanth.selam@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Comment typos across the Intel ethernet drivers, split per driver.  Found with scripts/checkpatch.pl using the
misspelling list in scripts/spelling.txt.  Comments only, no code
changes.

v1 went out with a bare [PATCH] and a "net:" subject prefix.  As
maintainer-netdev.rst asks, v2 designates the patches to a tree, and
each subject now names the component it touches instead of "net:".  The
series is rebased onto that tree; the diff is unchanged.

v1: https://lore.kernel.org/all/20260907064528.6602-1-hemanth.selam@gmail.com/


Hemanth Selam (4):
  i40e: fix typos in comments
  ice: fix typos in comments
  ixgbevf: fix typo "enble" in comment
  Documentation/eth/intel: fix repeated words in comments

 Documentation/networking/device_drivers/ethernet/intel/i40e.rst | 2 +-
 Documentation/networking/device_drivers/ethernet/intel/iavf.rst | 2 +-
 drivers/net/ethernet/intel/i40e/i40e_common.c                   | 2 +-
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c                  | 2 +-
 drivers/net/ethernet/intel/ice/ice.h                            | 2 +-
 drivers/net/ethernet/intel/ice/ice_main.c                       | 2 +-
 drivers/net/ethernet/intel/ice/ice_sriov.c                      | 2 +-
 drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c               | 2 +-
 8 files changed, 8 insertions(+), 8 deletions(-)

