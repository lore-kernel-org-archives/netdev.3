Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A56723B6BF2
	for <netdev@vger.kernel.org>; Sun, 11 Oct 2026 13:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791726618; cv=none; b=s7eqB6RkHLSo39tWQPFZlBvC5z6+p/2cJAP/HcmjuXS4JEWw7181VbR9wA1k3gXQhwPkbX3BHPtX9+jJ8XY6Bjm3HQt1TcRCVqCmUumi/FR+RZpCq2apnPd5CJOyHIEnuhJIjvb18dahFt9HTFXc0YNxAPnYVvqGjwRi5jFwP0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791726618; c=relaxed/simple;
	bh=0v/kQeAmy4x+8XIOhQaHxvrM62/KclzeLGA+YUnlpDU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fwwHeJtuJQHCSXYUb98NDp6/sJwmHAUvd7AaLoPdoz7SbrRNIuDypV6rZwGiyoPCUFXxAoG5TQTZWZF0wgC6DzJg3sggH9GMQhSrhIn6joxvWxohol4lq26s20p6g8Bh2zQhvWx06c07PNzUIXlK+X4nRXlWUYSzafS8Rq1yrAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iWWLXuiP; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=AFDzhyKm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iWWLXuiP";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="AFDzhyKm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791726615;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=1N6bIdacRp0M0H1pJUiWwskkKxr0wGWO9NcWl5lfvN8=;
	b=iWWLXuiPwE2qmbf1692WZArjojlhVdxqCo2k/kC87pVJaUqjwcKlEYaNz8A8dFj6dyCwji
	biRS+rOSRRcUuhAMKSYayY1NCpuS8jqM1J1h1b0eEtriKzaxgE/dRe6U33lfHy+yCNRZRo
	O+sfiktdByj1rmQgTr8qtYmFm/12BiM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-570-qCEFdhrwNaiRXRzB5LucvA-1; Sun, 11 Oct 2026 13:50:14 +0000
X-MC-Unique: qCEFdhrwNaiRXRzB5LucvA-1
X-Mimecast-MFC-AGG-ID: qCEFdhrwNaiRXRzB5LucvA_1791726613
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4a013ea30c0so7017295e9.0
        for <netdev@vger.kernel.org>; Sun, 11 Oct 2026 06:50:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1791726613; x=1792331413; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=1N6bIdacRp0M0H1pJUiWwskkKxr0wGWO9NcWl5lfvN8=;
        b=AFDzhyKmFLRt18adImoq2M79fvff7dQGz4IF+bJlVVoRTxIl9k+mrqpqzjcI1z5kjl
         8l/q2pzJvNxMNDqXUR0Kgl3PS2NZofnJtjoJMMzi19AST2X6OdfjFU4Aso38FMOfApR6
         PqM/VhWkDmMUlGF59qhloXBrsU9YqQq/hjkryZtFSWwZdNJ7yDLdElXCSvrUlm24a4gj
         KMJbUeagOxnpgwwEAdsGXGSoTcBxMiDyjEwjZLqhvIyIT2l3n1uAlr5uuPr4e7GhhRwL
         BdnIYc/d6mCPIEvmGs9RDhpRoQ10oPMAiY0/gxQUNWk/h4SlE2OBpdt10DRqSQoPO3qL
         qbCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791726613; x=1792331413;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1N6bIdacRp0M0H1pJUiWwskkKxr0wGWO9NcWl5lfvN8=;
        b=nPuN+3HmFQWoUi3++cMv4ual4OT19/GC2t23tEu3Qr59vMfBhS+qkQT6nfAcdgrT1l
         Eu9OsJ8F4wtyJqAFvxr4ZBDJcZtv4p3qdjX+C2Oq5MheNYIguxYbF/xHwt0eFCEu/m3c
         7Sza9AB1jQ2T+Vpd6Wfh6ikMCe6kfyJJaX/IsrFjmer1KiGL/4zpC2iOIsPQVwYQac1D
         uOEgUTxFGu9CTR1NHWGMOaePjI/Ro5Hqql2Zfr+ca0hAlbNHNNhk8EoEl7QZn4WPMz0h
         dXclMZW8DdwAc2T8ghtCAliw7fWwaEuwsS0pv873lZRXjhUmM/9ITx3DcGdF7ZskD9sL
         88EQ==
X-Gm-Message-State: AFq9FYJXLR1RUS0uR7mz7Gpi0il5c0AeWhYd3MTuatuA2uraJHt7cCp7
	cWd+HG6yy4SrvpIRxr3iOjBSKID/yfu4Tr9cSVZ7p8ORdO4T1Bo8Hb7eEf2lXP3NSaBCfnnW/zk
	HOJ65NOtJyc1OOc2qA3IUS4E3EDCMULU7jE+lKpRwwHAIpfFER6gm9eh9tA==
X-Gm-Gg: AYBFou3LOY7D0VGaZr1SfSin9gJkLQoTekjz4j+j9WMGx8kUPn4s6YofJHvVWECvlNz
	89A72a0g69Wz0zKQ9s/qwPyIKYSOSr6bRyA7wKeap6OhAlAWO8gEc+YW9Qgmtjhj/oUAFYIiTX0
	yNKHjSDg8ddoUdmpHVrbWfeZhLV2F/Gknbs+cZAJk8tG+Mqmsz1MZgpI9K7CUaS08jmMpb1IVTO
	iFdyxAF4/7NncVhKvHYQAuRzUPmmpcVNLy3dpLGQyvRkdh70EtBPGhMDDJNiYG6ZHt5ZkxVht7+
	9Ft6yi83X388FG1erGTBE70kTtuYIxTIR0BL5Y6YqO0nhRJZ2QFyswHq6Na5ZrWe8Z0ANa12Msf
	AJqsTENpNL5/zvxHCi4YFvvWC39E6HmAF
X-Received: by 2002:a05:600c:19ca:b0:4a1:7e76:d02f with SMTP id 5b1f17b1804b1-4a18e4ac650mr128003455e9.14.1791726612852;
        Sun, 11 Oct 2026 06:50:12 -0700 (PDT)
X-Received: by 2002:a05:600c:19ca:b0:4a1:7e76:d02f with SMTP id 5b1f17b1804b1-4a18e4ac650mr128003135e9.14.1791726612398;
        Sun, 11 Oct 2026 06:50:12 -0700 (PDT)
Received: from mheib-thinkpadp16vgen1.rmtil.csb ([216.128.14.202])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a19f249692sm13334125e9.3.2026.10.11.06.50.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Oct 2026 06:50:11 -0700 (PDT)
From: mheib@redhat.com
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	jiri@resnulli.us,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Mohammad Heib <mheib@redhat.com>
Subject: [PATCH iwl-next v6 0/2] i40e: add runtime-tunable ATR sample rate
Date: Sun, 11 Oct 2026 16:49:50 +0300
Message-ID: <20261011134952.54887-1-mheib@redhat.com>
X-Mailer: git-send-email 2.56.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mohammad Heib <mheib@redhat.com>

This series makes the Flow Director ATR sample rate configurable at
runtime through a devlink parameter.

On systems with many queues and high-rate TCP workloads, the fixed
default sampling interval can cause frequent Flow Director
reprogramming and TCP packet reordering. The optimal interval depends
on the workload and system configuration.

Patch 1 moves atr_sample_rate from per-ring to PF level, since it is
a global policy. It also triggers a PF reset when re-enabling ATR via
ethtool private flags so that fd_ena is reprogrammed in the TX queue
HW context.

Patch 2 exposes atr_sample_rate as a devlink runtime parameter so
administrators can tune it without rebuilding the driver.

Testing with iperf3 -t 60 showed ~7k TCP reordering events at the
default sample rate (20). Setting atr_sample_rate to 10000 reduced
reordering to ~769 (~90% reduction).

Changes since v5:
- Use '|=' instead of '=' when setting reset_needed for the ATR
  re-enable path, to avoid overwriting unrelated reset requests
  (Sashiko)

Changes since v4:
- Folded the PF reset patch into patch 1 for bisect cleanliness
  (was patch 3/3 in v4)
- Skip PF reset when FD_SB (ntuple) already holds fd_ena high,
  avoiding unnecessary traffic disruption
- Fix LLDP EEXIST path to not drop unrelated reset requests
  (reset_needed &= ~REBUILD_FLAG instead of = 0)
- Flush existing ATR entries when setting atr_sample_rate to 0 via
  devlink, so stale filters do not persist on devices without HW
  ATR eviction
- Documentation: clarify that the sampling interval is per Tx queue
  and counts TCP packets only; fix formatting

Mohammad Heib (2):
  i40e: move ATR sample rate from ring to PF level
  i40e: add devlink parameter for Flow Director ATR sample rate

 Documentation/networking/devlink/i40e.rst     | 21 +++++++++
 drivers/net/ethernet/intel/i40e/i40e.h        |  1 +
 .../net/ethernet/intel/i40e/i40e_devlink.c    | 46 +++++++++++++++++++
 .../net/ethernet/intel/i40e/i40e_ethtool.c    | 12 ++++-
 drivers/net/ethernet/intel/i40e/i40e_main.c   |  9 ++--
 drivers/net/ethernet/intel/i40e/i40e_txrx.c   |  6 ++-
 drivers/net/ethernet/intel/i40e/i40e_txrx.h   |  3 +-
 7 files changed, 87 insertions(+), 11 deletions(-)

-- 
2.56.0

