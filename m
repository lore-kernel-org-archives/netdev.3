Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53341356772
	for <netdev@vger.kernel.org>; Mon, 14 Sep 2026 21:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789420194; cv=none; b=oVwg+SRaV4FJVZ2ZKqn8aei79Wo2xwvyNEVAxu0ilUe0v2J7qvYXxOwT34JppCkPij3tkXku8SNyTtzVf10LGf3llTZ3ieSsyT+iZKkWrHZjZxfFwT8+ns+4R3n+aheS2mqBdBFCPeTWZQKoJhJ4pPby8IPue4jPaUNvPbWelWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789420194; c=relaxed/simple;
	bh=GjQxOsPSyUySqxH18y/CsEMVrghRbc5YJqXcFJFHOtg=;
	h=Subject:From:To:Cc:Date:Message-ID:MIME-Version:Content-Type; b=sOD6aUpjJ82rNcYPaDufIoLCRNZpxFb52hAT4hQjLshwKAM8YqrrHmuNo9cCA0Mt3O4iPncRsRSj/MWKIf5J8o+Lciu4gu+GoEOCJ4WoPw8HdZHiKl8XuhUNO8uxGfbFNUA83kB5R+K9B00pc7JksjzKa04A091bolvStNUeKtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sR1I7spI; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sR1I7spI"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-8692be1cda4so3167347b3a.1
        for <netdev@vger.kernel.org>; Mon, 14 Sep 2026 14:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789420192; x=1790024992; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:user-agent
         :message-id:date:cc:to:from:subject:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2tpqNlN+sGapkZFucZV0VJwIxHfpmyTPyl+vaSCV5ik=;
        b=sR1I7spIVtVpmEB0/EnaQj5jsAolL8LXgbCGUfnPIkUAb03epVGjS/9R90zVlnaqci
         vin14/P2U+FEDcGW4QxeMUkF5HXkLQPfsg1e8X09bC1Bhx9lxLVNswTWQpUxsid5P4l3
         1xLsfIEO7OytMkLlgbiAbcoVfoL7hQ8m2zW2ApMo3qkj8sKVgJP7IyYOGgycWjwyzaCP
         d5zVm4Qp4TxjA1DJksXX7FwjEYYtOMMbv9YYLZVIcKfjOE0rZ+9z00edQyylvNgbeIa1
         fuQDehiGJcTnloHexugoxnQ1I6mYQRCNXcLGXEhAn0VDFUlru7yvRwJLpy7Yj/qQXpD4
         9rMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789420192; x=1790024992;
        h=content-transfer-encoding:content-type:mime-version:user-agent
         :message-id:date:cc:to:from:subject:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2tpqNlN+sGapkZFucZV0VJwIxHfpmyTPyl+vaSCV5ik=;
        b=G7ilJLtmT0ZMllDYUXQ5faRD74nVIHJxXZ4nMFPG7OEdAG7WxxfGdDwwbV+buFlDCt
         q5+p0YJ2Vk5SwK4WXSRfT06eahrXEE87/aksdBpIxADySdE8mCV6pStpgm3V4DbmbRkf
         YrwpcbbsGUQIhjydyxE4KVBgcdfsUnnWzp3J1xO0cAIA1pToA1C6aMdctjhSisATZMw+
         exQC6AQ2HfiQizH8JuvF8WGljbv3FqE89OzF4+0hl1rcSXZRxOMp4KRxELTfzHisfyGg
         N5ELBFbCO6gT2ieeAxUnMo6Lt61Vu2sf+7DWtHzQ8tL+XXUzWJsCYMiK32R043w2dGBO
         bi4w==
X-Gm-Message-State: AFuF++nE39fyFURap1fijoPnt2CnmDV7tUq4fauI+HKafQb1Eg5cHSwH
	u+E8wvjNW+N9F+wlHAWlvKdeAVw1f99WS/7rEunBMk7HC/zDJwU3i40t
X-Gm-Gg: AYBFou0dlCvd++ziNXbnBzTlCjx75h6bEy18N/NzLnEetRbgDOB4kwZS9NGq+gB3xyC
	mR5uYydIOeB8mUkGrQqQNf9oMwJ3uarq0XM1pLWnGBCAPrG3lpIpV14V09vCtmG+sGWdHKy9AAj
	Op4XIeUC9qaKTpsF9IKbzmvxo84XaWKE4QO6YPCNVmBiC7Hw9BkgfCLdkO1VDvMFO9/ZcBIaKsn
	NgyEo9xMKzbJe8+x+G8h+rvxcWhayyAurIKpP5h38LiVcLyNuf71XAX95pJQKy+AvGTHceRzyDl
	e/uh0gWVHFs3gQQv6qSqMcciBfmqICFctKgCRYb2NpvHOK3r/+NM0Ht4VRcutQS9c2dPsuUCq3+
	8G4YCOLkNk6ex4Oj8E525hTC/tPpJwCagTC/v48mQCFY9TJf/Yea9YDrFj3imSXCnc0ZbrQmDwL
	+N9WKAp3gihatqB20H0iSxaH+TtnfunaYeeTCNAywYzuyDoqYKEob6n8LlGuJyF9t38CKe6bYUr
	JvcL3pDHRHdGSm3SWyzWGqTxl7Djl+eGdqC/opteKGoDurEOMKnnng4dIXEoxHAs4aGelj+3OYW
	8aO5N32Mc6NArn00g3r3
X-Received: by 2002:a05:6a00:c1d4:10b0:870:c2db:da53 with SMTP id d2e1a72fcca58-870c2dbe08emr404008b3a.23.1789420192524;
        Mon, 14 Sep 2026 14:09:52 -0700 (PDT)
Received: from ahduyck-xeon-server.home.arpa ([2605:59c8:829:4c00:d680:cb2f:f831:8497])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc4c6549ec0sm5678774a12.15.2026.09.14.14.09.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 14:09:51 -0700 (PDT)
Subject: [net PATCH v2 0/6] eth: fbnic: a collection of fixes
From: Alexander Duyck <alexander.duyck@gmail.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 kernel-team@meta.com, Simon Horman <horms@kernel.org>
Date: Mon, 14 Sep 2026 14:09:48 -0700
Message-ID: 
 <178941996343.7700.9376081102002673062.stgit@ahduyck-xeon-server.home.arpa>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

This series collects a handful of independent fbnic fixes for issues on
released kernels, plus one core ethtool fix needed by the fbnic offline
self test.

The first patch keeps rtnl_lock held on the ethtool ioctl path for the self
test. Since the ioctl path became rtnl-optional for ops-locked drivers,
fbnic's offline self test (which brings the interface down and up via
netif_close()/netif_open()) runs holding only the instance lock, tripping a
lockdep splat / ASSERT_RTNL and reconfiguring the device without the lock
it requires. A similar issue was found with Broadcom drivers so we expanded
the scope for v2 to just have the rtnl lock held for all selftest calls.

The second addresses a comparison issue in that we were limiting the
maximum number of standalone Tx queues to one less than the maximum number
of Tx queues. To resolve this it was just a matter of replacing a "<" with
a "<=".

The third addresses an indexing issue with netdev queues on fbnic in which
the NAPI vector was assumed to be findable as the Rx index modulo the
number of NAPI vectors. However this is actually not the case for if Tx
only and Rx only queues are setup. To resolve this we make use of the
cached NAPI pointer in the netdev Rx queues themselves.

The fourth patch fixes a NULL pointer dereference on unbind after a failed
PCIe error recovery: fbnic_pm_suspend() frees the napi vectors via a direct
ndo_stop() while leaving netif_running() true, and when slot_reset ->
resume fails the data path is never re-allocated. To prevent the panic we
reset num_napi to 0 before we free the IRQs which prevents walking the
unallocated napi vectors when we unbind the interface later.

The last two patches address the FW mailbox. One sets AW_FLUSH_MODE
alongside AW_FLUSH when tearing down the Rx ring, so the write pipeline
actually drains the staged requests instead of hanging on the BME halt.
The other handles completions flagged with FW_ERR on both mailboxes, which
the driver previously ignored. This resulted in us parsing a stale Rx page,
and spinning the capabilities poll to a timeout on a healthy ring.

---

Alexander Duyck (5):
      net: ethtool: keep rtnl_lock for the ioctl self test
      eth: fbnic: use the Rx queue napi pointer to find the napi vector
      eth: fbnic: reset num_napi when the napi vectors are freed
      eth: fbnic: Set AW_FLUSH_MODE alongside AW_FLUSH when flushing the mailbox
      eth: fbnic: Handle FW mailbox completions flagged with an error

Björn Töpel' via fbnic (1):
      eth: fbnic: Handle maximum standalone channels


 .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c |  3 +-
 drivers/net/ethernet/meta/fbnic/fbnic_csr.h   |  5 ++
 .../net/ethernet/meta/fbnic/fbnic_debugfs.c   |  4 +-
 .../net/ethernet/meta/fbnic/fbnic_ethtool.c   |  3 +-
 drivers/net/ethernet/meta/fbnic/fbnic_fw.c    | 47 ++++++++++++++++++-
 drivers/net/ethernet/meta/fbnic/fbnic_fw.h    |  1 +
 drivers/net/ethernet/meta/fbnic/fbnic_pci.c   | 18 +++++--
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.c  | 28 +++++++++--
 include/linux/ethtool.h                       |  2 +
 net/ethtool/common.h                          |  2 +
 10 files changed, 99 insertions(+), 14 deletions(-)

--

