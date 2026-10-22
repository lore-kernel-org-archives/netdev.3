Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792660035;
	b=e0YnGxBPYzOJtyBrW0Ip7jriw1B+uOiCcsb2680nkE1FYrV4eXTdBHJzvsguRhx2vVX/
	 JKKk/TcqtxSNaQrSnkimc+/15zFzJclPUTAkNvaDOXGmQCyGNEchOIA2LcvKZQOn4twKE
	 hSH7pVA1N2tbZdmiRbE/nZinlQ3ky4AvEI/mg2Qbj36mdVb9iceMfu2URtaCX/IT2pKzS
	 Ssfn+b5fZmsf/5TuiQAoDkvDSn4GWTWLhskc0PaOFg9Y4HS/NQDmBRUfMHp+3S7ThdXU0
	 VMVY+3bAst33Ya/4f2Dg9LdtIpGNKNjR6uRZZtrbReQcYEjAs8v2RK8O7FzOhrAtomA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792660035;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=/tMNXcr5k0x0ZqGSCg5kBGjjTxYYU7yHe7YyZnPL11k=;
	b=vBM1obc223P0j3hpW6gYCU/yPt33I8D91Md0kZooLLxgcbOohoXjienNpaIj7zFauHz1
	 yMs/QAirb+83TgyIJKcNOu6yz8RBPH2+3woSMsRjiexRYQSNs40oaTQLZi52fR3pse9+u
	 J+kKcJG+msZD1ddcHyB3XGnoo2VxexOuGFFde/BKmMvwzQonljarMRZDN6ESFtlNLWHC+
	 0iz+o2PlqfRfmn6lybw6PHkAgh5MOD9xi72DCIt3DDMw6Dr8L2bv8JAm4tIrPatXuPXtY
	 +q7KRpVPLqsl5eEn1JgBQ7foUCX+wtw6A5lET5eiWYDcuAePzmX8mJUgzpJuEx5YKKQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ivk88Te7;
	arc=none smtp.remote-ip=74.125.82.173
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F89E606A31B
	for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 09:07:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1F89E606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ivk88Te7
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-3535a54bed9so2339260eec.1
        for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 02:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792660034; x=1793264834; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/tMNXcr5k0x0ZqGSCg5kBGjjTxYYU7yHe7YyZnPL11k=;
        b=ivk88Te7zDWhYHKP0dgOHMk3iS3TvXvGrKeg36/zHgisPZz8quTZr9nMXy5EKi4+77
         jXMxsnVxtLCxdAm2DHDlyI2UrPIgDZQBpCiNS+DE5WMKO8LlrA7dvAG1Nec1PF1euyzJ
         M4vzcHa79BincZAHG0Xi7zZzEyWmFB4KXUkN9fwahXLTemFr54mnBODAwV0hxRpCFwmi
         dMJi/IWqyShmqZFt8Nna74vMlLKCOpQwpUzaTMurIRopqIPWHEHcdikWmN/WD4+Pgws/
         bH5Jmo0bLDFj1NMpUCAPIpdVTZah4KYW9TfyLWx+DTEh/n9Q/6THjNUZYar2ncfMCgw8
         TFEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792660034; x=1793264834;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/tMNXcr5k0x0ZqGSCg5kBGjjTxYYU7yHe7YyZnPL11k=;
        b=UsUfo5m3Tt+VSRZz3W2ahGqAvU4g09dXENB8nfCmZGijTgdVQL9HeAyIDkwD99VujW
         tJUUIAySCuzqCuFKjoZXz3dxm80tjHuyvt52dmkYWp/euPl9S4bwyKyEtKJfBB3QZ1Bq
         S5f5CzFjrlvnxGuzndWcsIzxbN7Wu372UBGHN4OC8+8wrYlIUZJ7dB1TxG2vSYOrL6G3
         rO/nDw74yu6/uwmj4rgr/GsE9v/amQ/2bJt8ftdPSkVIleTcmecamfHRisA0I1oLtJQu
         +Q9ivpGxuO1+iDOre8PS2IxrDJs70mwvbTAX3N6HylyMhfbNt38uNRvRzsl0V4CNuoSc
         FyIw==
X-Forwarded-Encrypted: i=1; AKwUvByCUqqRE9+29Ge/L9EUuOpLxo8GCQdVld+zDlitnXYntSRl3eBA2Aq2f/Nojemd+nsEoUzXpMo=@vger.kernel.org
X-Gm-Message-State: AFq9FYL8tGesgeiKVr0SxQBkJId0eV5kKlC5HfnHtH+iEwCGxs3u4HNp
	eVv99yGp+XJlHqHR5UmvMoCRqxAbqgdDpQEATF+yhWYJMPNZe4gmPb+1
X-Gm-Gg: AYBFou3X0yyfktpONFft2/n2wwe7MKk/1QS/NoiPPjnTPzfjLcX4EAKXse/eM/EOjgO
	HCJpHJOorUTVhCcJyiu6KsYP+KZy2AZRcTi3RONqpMVbTlWT4cVuyk9DhHAALmortL7bbsHzzho
	CH5D4xFJbm4GNBE35lB1cIAgcVYQjVF9GM25RCxO0Xbx3ph47aU3ZxUab7YTTLD5MPPwMvY7xM5
	fiqZYTdvVagwfW+I2sFDSP7YFa/uKbj7zppxL+hBc5eKIlEL4d+xRAX5t7Z5D6zgUDuDkafhHbx
	IttBRLZMmcmMw0Ms2ln1sEkdUYXELYIgEpBGk3WPPwbIM3hYodCZjtPVCYCqMEJodus1y8PZ23a
	6T2l77K+C0LzPcn998mkD1e/64UMAlh+IcMU5DBkROE5IhMmbWzWvianLBl/5h3ZTZfoDLCdlAA
	ECy7q0wN2e/0jCOP8UgT61mxrReWsy/x3ze0yoT2NaA8QLw4/cb34tDRSKdbe6HCSsM2z44L/uZ
	fJWe7RPzoVUbCS2wLGdOGbUD3lnF7uaaJG9feg05VW8mUkThZqlFNQR03xlVgkah1dgDltkbZUd
	2/JH6XjUrusEaSBTDuo=
X-Received: by 2002:a05:7300:8a18:b0:35b:c1d2:eab9 with SMTP id 5a478bee46e88-3674df4ef40mr6319732eec.39.1792660033972;
        Thu, 22 Oct 2026 02:07:13 -0700 (PDT)
Received: from youngkk-vm.localdomain (67.216.200.102.16clouds.com. [67.216.200.102])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36741e71eaesm30337818eec.26.2026.10.22.02.07.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 02:07:13 -0700 (PDT)
From: Cheng Yongkang <teel4res@gmail.com>
To: Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>
Cc: Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	bridge@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [BUG] net: bridge: DSA LAG self-match leaves hwdom zero
Date: Thu, 22 Oct 2026 02:07:06 -0700
Message-Id: <20261022090706.3643840-1-teel4res@gmail.com>
X-Mailer: git-send-email 2.34.1
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi all,

When a DSA LAG member joins a bond that is already present in
br->port_list, nbp_switchdev_hwdom_set() can iterate over the joining
port itself.  The self-match leaves hwdom at the unassigned sentinel 0
while the port is marked offloaded and tx_fwd_offload is enabled.
No busy_hwdoms bit is reserved.

DSA frames may still carry offload_fwd_mark.  If another port also has
hwdom 0, nbp_switchdev_allowed_egress() treats the two ports as the
same hardware domain, so an otherwise valid forwarded frame is
suppressed at bridge egress.

Observed on Linux v7.3, commit
08ab31164c55f20c7a2653de3186ae333470e2c1.  The exact DSA LAG route ran:

  dsa_port_lag_join
  dsa_port_bridge_join
  switchdev_bridge_port_offload

After the join:

  offload_count=1 hwdom=0 busy_hwdoms=0 tx_fwd_offload=1

With a second port using a different switch parent ID and also left at
hwdom 0:

  unmarked control frame:                 delivered 8/8
  identical frame with offload_fwd_mark=1: delivered 0/8

The result repeated with two independent netdevsim switch IDs.  There
was no KASAN report, oops, or panic; the defect is packet suppression.

The target bridge and DSA core code were unchanged.  The test VM has no
physical DSA driver, so an in-tree dsa_loop build was exposed as an
external module with only port_lag_join/port_lag_leave and
tx_fwd_offload behavior.  A diagnostic hook set the same
offload_fwd_mark bit a hardware switch would set.

hwdom allocation must exclude the joining port, or publication must
occur only after a nonzero domain is reserved.  Candidate BR-031 is a
different error-path leak in the same bridge switchdev code, not a
duplicate of this packet path.

I found no matching self-match allocation fix.  A 2024 generic
offload_fwd_mark/hwdom-0 comparison patch is also absent from the target
source, but that patch does not fix the unassigned-domain state created
here.

The module sources, PoC, and full logs are available on request.

This was found with AI-assisted source analysis and fuzzing; the
packet-drop differential was reproduced in QEMU.

Thanks,
Cheng Yongkang
