Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792660574;
	b=KL+Qg12xd2aT8MoBRSOVhs0HTygq4YlPeM1nAn6TSks3bR629mR5HrIzj+ff0TX8AvzG
	 BN9xqAsKVxfxcW1X6zr4kIMwQyFsgWDOXoTX2M2sXqNSrQVSYk1+miCbRT+jCSdUb9zcv
	 +3Y2+11XQe+lm+yUz6yRKvtMHBB2ucqJsdsSKb/L9n4ecfIsxWnIlUTHVK37nHDzSo0Tw
	 1mkRVpx3xVoCsAoezUsMtlsyxT42OhuxZx6WWBGIf+Rp7Y+ekL06ierArcFf2MPUgzTMw
	 LbExs4JqE1qozpfvXie7xvkpp5OWMkyN0Dbciwmfmmo+NNylXvYYsnC67DYxaR3gSGg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792660574;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=y4SBB/zAR7G8uWNCyu3PQ07icMwXcC5cIWOIKYHE0eo=;
	b=AfXQKFInGTXmW2EIei4ZIueTk/KofM8V4OiXwa8ImU+MSPp3rDCNqUD/rjOsyqglbtI9
	 OxbTolrkqmFyw82Y0OK5znUnKnf7jmVif1aYMrdkUwqp732LgeSFUAzYx7rnAX/7e3Be8
	 YsQbOFyuyqol1aL8TxXnhxSTS1whMbfaN/g+wU5cf3/NXDpCzwsjTJKW2idjR37Z2L0Y0
	 Ywtv3RB72plilcujBuqoYjWLG9skUJIp2TnNBgh7WYsNuem7RhrkN4sIyCtjqqs8q+YXU
	 Qykiet57Jdo1wmj8x5bH4LK4DXuYEfjGB2U8iZmZxRz/89hXXoFKelSfwARZzbalAdA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=njfsfwGl;
	arc=none smtp.remote-ip=74.125.82.176
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C755C606A336
	for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 09:16:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C755C606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=njfsfwGl
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-354ba08cfd1so2801956eec.1
        for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 02:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792660573; x=1793265373; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=y4SBB/zAR7G8uWNCyu3PQ07icMwXcC5cIWOIKYHE0eo=;
        b=njfsfwGljP6QQuLHug5er7AG833CMCr68NoapFg/Mj+WCZc3iA5mcyBMyeMgfTtJ1E
         KMV/SJiNUvQ+bbmiJ3FOEEIHdeLS532/abj90OawVjuFZCsQWI9yG8BOdX66MqHLh7NV
         n3xAfAqWbQm/emrl87wlKD/JQYtf9iwUCnA0lcOH/bRREk0mggYRKa0b879ApDfvr00Y
         YBprte0hGTQuYsB0ZXs+WO/QzLpKtsrwfUliG3MPdNp/3HJfOkrc2tsfvCPt/r8uINJu
         glcuVMJfi6nUPpK77x01GOkYDcE0EUU4jT9ZDxNoH/25mi2JJDTs22YWLmRs/zsr7WZP
         MDsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792660573; x=1793265373;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=y4SBB/zAR7G8uWNCyu3PQ07icMwXcC5cIWOIKYHE0eo=;
        b=G6Bf2EEUajPmELlldZoR/SEPvpXb2n2H9h9JUO9DoyT6IaJpGy1L0zAhKyYIZPJSb5
         xYkfmteryPbulrS90VjQkEmZi6AGrZBuv7TimeQaG8Y5lC4kIjRQiyaXAPxP9za/0GcL
         H7Wywk3kRCpZsRb/rHr6ygyxD1n01cGqZpYQ7Zwfs2z/cu5RHmNnCgYzOp+j/CAI5mDX
         1iNtHul2jn41RebBqXw8u0PkuqlZ5qLpGcy9pClTLSlO0waEeReuVjywmgudZ/2PCOwr
         VY0EfPtVTSJi+lUm2uvLlLXM/iyEzqUAlYrjwzGUNuGpkipAEJmE1yELbve3tkwVR48Q
         8xYA==
X-Forwarded-Encrypted: i=1; AKwUvByrqqDEyb8jIg3iUBRLL74y5pteNDzdJ64omedM4q+yneVD/VTuhnIeD3TKlft0A9Nfoi2k/0c=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ5NDU/1ruIim9WxNzJk46AM/hMuG+TOhk4WPCHjBzZV0Zlgjhl
	Vu9IVcHVrI7akXgk9pXmv613eUrflUeIr/HKsZyFdDph31x4osWX8ZQ0
X-Gm-Gg: AYBFou3byynp6OISaz7wbE9tbNZE3Lqr3b5fKDkK/QWQTKbE9crD9aELqHKMNOTS3y6
	L0eOXYTbRN2LQX05VIil6cIBuTg+JObQSZw6I1IWABL3IZ/c6uDywkSxqvA4ESF9bePPo88jBYv
	Qj1fW7ozwWFuO+WjeS0/80citp44hlW0LnQoSEMvq6DoPvmq/6LL+JXRFRzq6e1UZCR1oXa8H4O
	25dHHpVbk4lVv4XvdXc3XDP9V5lqUtoFNBHnwT3nNHl1etym/ewcv0ol2zCJ/rz2bgoMV30H0IF
	zsFwCnyNSXTDcIlVv619kW2/32I3DmvOqRpuoDjo2alziW1qXG+CHvMUoLpTru5N0yWL5CSy/RF
	5q3bdD7K7PgObZwr7pRPQYDCAfeQPEq5JK8bX0EqA+1WzYPbzfw2eO1AmihChdVPgzDtT6M5g6V
	V4t5BJGzhRk3K3o8agIBy5qMcHtSdFJSojdVn+9CtbZboJunniO3KeCaO4x9M2FzM10jQqwl5kY
	2zaqv8u0LYjQu3z6sV2uIXJ4qDcKqCMtknNpT0xqc34wx/5paVPc53Dw76tWTgrRVL43LYrx7Dc
	7Io3zc7jyXK+63WRONU=
X-Received: by 2002:a05:693c:20ce:10b0:366:9ac5:34fb with SMTP id 5a478bee46e88-3674c92e0f7mr6089640eec.13.1792660572901;
        Thu, 22 Oct 2026 02:16:12 -0700 (PDT)
Received: from youngkk-vm.localdomain (67.216.200.102.16clouds.com. [67.216.200.102])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-367411bc89fsm18131777eec.16.2026.10.22.02.16.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 02:16:12 -0700 (PDT)
From: Cheng Yongkang <teel4res@gmail.com>
To: Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	bridge@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [BUG] net: bridge: failed VLAN tunnel update suppresses state notification
Date: Thu, 22 Oct 2026 02:16:05 -0700
Message-Id: <20261022091605.3651677-1-teel4res@gmail.com>
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

br_vlan_process_one_opts() commits BRIDGE_VLANDB_ENTRY_STATE before it
attempts BRIDGE_VLANDB_ENTRY_TUNNEL_INFO.  If tunnel insertion fails,
the option loop exits before that VID's changed flag is included in the
notification range.

The new VLAN state remains active, the request returns an error, and no
RTM_NEWVLAN reports the state transition.  This makes netlink listeners
disagree with the kernel VLAN database.

Observed on Linux v7.3, commit
08ab31164c55f20c7a2653de3186ae333470e2c1.  A range request for
VID 10..12 set state BLOCKING and tunnel IDs starting at 100.  VID 11's
tunnel ID 101 collided with an existing mapping:

  request result:          -EEXIST
  VID 11 kernel state:     BLOCKING
  VID 11 tunnel mapping:   absent
  VID 12 kernel state:     FORWARDING
  RTM_NEWVLAN for VID 11:  absent
  RTM_NEWLINK for the port: absent

The listener was opened after setup and pre-existing multicast events
were drained.

Correct behavior is per-VID atomicity: validate/prepare all options
that can fail before committing state, and roll back any earlier
successful option writes on failure.  If partial commits are
intentional, the failing VID must still be notified before returning
the error.

CVE-2026-90114 covers a different defect in the same batched range code
(descending ranges and an uninitialized error value).  I found no
matching fix for this state/notification loss.

The PoC and two independent logs are available on request.

This was found with a multi-agent workflow; the exact
notification/state divergence was reproduced in QEMU/KVM.

Thanks,
Cheng Yongkang
