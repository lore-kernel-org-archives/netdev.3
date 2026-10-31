Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793425600;
	b=SzIEJ+BJiEdPO1rZK8Tq9Q3CWemGIrdq/iOBA+1yA/h8CDd1rCJrMtEsd1vhx1dGGwej
	 2c9zNL7SpXxws1EVbMQCUnfELwKtKx8CCb81wbEyX6XgBvI8DMpji33kZU+DJbtyonDk+
	 JdOdFZclH3a6W1GF4PWmyPLvno6J5yTrz9rKEO/dQfzRiB4DxnkaY+7SDOW3kZ4QkR3rg
	 doOHV1ySl5okeNzXul2fgaBWGlbwMVOH8cn65yH0/NtfkDthlna/A5ZoD0jG+Sta8wkbq
	 u5541/cIn8ruF+8ermGQT6NvRIQCJFR9Y8s3zCJwqltG/Ih5sQIg0dPLfFoA5RZyaQg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793425600;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=597SVjqFkP14STDOk7S4HpjKdXVmvh6EV5etFFqcGZ8=;
	b=NhWqaEpYiPnYeymu3E9VwLin/WfLVjIhfexkoN2Oaj5ZKdsnxN+cvu5lPBWA9Hmnq+bm
	 yfuw8nb0LnB03XoHQi7m1HNnMt14p8dgZk4L6F6WsCbKfLB+i5eN+9lMvLT97TqjlSGsE
	 oPGdBGr2IXtnCggOZQl1HjiiDoX1EwdCGkwwQ2S7CyLxq+8tH1ADMAAJWdI0NhXDv0Uf5
	 ilF/e3uiDre78HH9q919kIr2RLNLxa2LRfRGO1nTZcERutbOugSP0VH+Z0Y9RQG52GhRx
	 TZWKGy5ZcznLmKg1tfin+S9fh2qpC/EfvmbT0Xym4Ll/ZxfzvtpGCg5atwpVVrOb2wA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="ZUva/FSv";
	arc=none smtp.remote-ip=74.125.82.179
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F2B3606A31D
	for <netdev@vger.kernel.org>; Sat, 31 Oct 2026 05:46:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4F2B3606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZUva/FSv
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-33fb4680717so841706eec.1
        for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 22:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793425599; x=1794030399; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=597SVjqFkP14STDOk7S4HpjKdXVmvh6EV5etFFqcGZ8=;
        b=ZUva/FSvcdQ7XFNlXANdr8aIblbb/KkHwYHR0ob47Nqip05qx5UMuj634PMBdXmGDg
         VvNhT3GT+TPs9EqkHHIGh8TPTMdTkHv95G+7OEcx8eLom7RPmHzBnm7IF4G+3rwR0L29
         atW0lHww1byrkwPqMyHf9N1NFr/HLyqKNaGpU81C6h/Dobsmjy01f2FKEY4sy0O44hjv
         HWm8iGLcp84O0SrKBVpSmyEt7VNyVNysUbo2+GSFNNpUX6dfyrFWRrbgpk9onF08cFKx
         2idQlIM/mgOGTatN19cnx1PvwUJA4tMUEvbFh95UL+6O3TtjmCGVaEbeFVbIjTVUCjkk
         bsVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793425599; x=1794030399;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=597SVjqFkP14STDOk7S4HpjKdXVmvh6EV5etFFqcGZ8=;
        b=SRDmlNSNjdvlZRFFfrKyAua3CD1hRu+Xp0mMij6MARQRg+XKWd7xSODzyZt8CveIm6
         5QTtQyW0HHF7cq6bPc/b90r+QWGSSKctwvVM4FYRp7EZgj4vRO/ZKDcs3lJI5hB5gcnu
         BlRMTULCeVrvgRAaWy76hLkXV8MvWYEF+VnGQbAcljQF/bO46Q61S93aSEO0vpDfUA10
         0OPwxDFtamBA7LG6jf62Sf1zEwAc+qRWovG1YjNaAjQLjMbJsUp2Ok8bB1h/w1YYs7ny
         3mOfzSlrU/JPAYWWfk2HK11UewkVLr2LRoV+rOXU6thhgw5c75z67iocJaupmGz68RA0
         e4+Q==
X-Gm-Message-State: AFq9FYJWmWTS8YkHI3fbjdkh/D2rV6CyWC/wfiK8oU5MZ5ndw3xgAVw7
	dieIxyZ0kcfuuBR1NalEcygOhQB1lTSZsxFlVW1OSJ0dkVRA62mXYZ3XTEh9Gg==
X-Gm-Gg: AYBFou2RsNS41Op5Wbb6QrBSLjrrO5erHq5mLlTZ+nc1JLEM7SEJsPkdvb2sfeH4UCN
	QR1TxWgAwo14Er5iYAl0A0agqfpqfu9xch20FH3Z4n6ey8smqloYZrLNDddtJgz++ONIqX09fBg
	sP1EGB0KbYLJwfHhCVLXoO79ewXQPjofj5DkRQTyV5+GpoMDjmL6ERML54Cxf/d3fvxh/PmfPuH
	7x3+Jli4yK75XLIsYD578IGczGmqK3tJfSPPf66WLSN7R8MupBy8/tEPy3WeMbmULMFzqk5zEJS
	RD8UE6pD6PENHQtpx4JlSVsLWEtXMRLKStoImDJkKcLYvdLmW7KgeJsUbRxWLu3G+uz7hyDHlrc
	PpT5pdKUdunfT+fxSHDQyyKKDkDCsLnKwdo6hoM5ToTEJ2k2Io6CKfzbTGAvEzeSnT+4SBZlpqQ
	56+H1kULo45tlZyMPVczJ5NtifXv97ru5qxFR1clzwo5dHO9fAvURz5qipDQ/jeScx3YzC+Eh4w
	4hanrYsVgSslKlEU6RAAbmJG1rqVGjBjOE382lrSV9X48YJgvTmbb1LlIudo/ESiJX/otIIQ6MH
	sfpJNTxT7XrlvEN00gWpKeAbEr9Z/1RyfsWkt+Dncb85FAVmSGlmJu/D5Qs2OApDZX59eBa/THK
	zh2HKRiVndQAjIK0bY2TG3zlrqFAdcGCGtS6mglARph+UKI4/rtd8XaBqgsjPy9UrB75fwN8taQ
	==
X-Received: by 2002:a05:693c:8392:10b0:361:39c0:c393 with SMTP id 5a478bee46e88-36a42340afemr7113890eec.13.1793425599269;
        Fri, 30 Oct 2026 22:46:39 -0700 (PDT)
Received: from ramen-dev-security-2.asia-south1-c.c.ramen-dev-345017.internal (90.156.200.35.bc.googleusercontent.com. [35.200.156.90])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a429018casm11668877eec.14.2026.10.30.22.46.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 22:46:38 -0700 (PDT)
From: Anil Kaushik <anilkaushikwireless@gmail.com>
To: netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Nicolas Dichtel <nicolas.dichtel@6wind.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Jiri Pirko <jiri@resnulli.us>,
	XingWang Xiang <v3rdant.xiang@gmail.com>,
	Alice Ryhl <aliceryhl@google.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v2 0/2] genetlink: fix joining multicast groups no family owns
Date: Sat, 31 Oct 2026 05:46:30 +0000
Message-Id: <20261031054632.3697295-1-anilkaushikwireless@gmail.com>
X-Mailer: git-send-email 2.25.1
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

genl_bind() checks the GENL_MCAST_CAP_* flags of a group only when a
family owns it. A socket can join a free group ID and stay a member when
a family with those flags gets the ID later.

Patch 1 rejects joins to group IDs that no family owns. Patch 2 clears
the members of the group IDs when a family is given them. This covers
the race Sashiko found on v1, where the family is unregistered between
genl_bind() and the point where the membership bit is set.

One case is left. If the family is unregistered and a family with
GENL_MCAST_CAP_* flags gets the ID, both inside that window, the bit is
set after the clear. Closing it needs the check and the update under one
lock in af_netlink.c. I will send that separately.

Tested as an unprivileged user, with an msleep() added after the bind
callback in netlink_setsockopt() and a test family that registers again
with GENL_MCAST_CAP_NET_ADMIN:

                                         v1      v2
  unregister in the window,
  register later                         member  not member
  unregister and register in the window  member  member

The test from v1 (join all free IDs, then load gtp and drop_monitor)
gives the same result as before, and patch 2 alone also fixes it.

Changes in v2:
- New patch 2 (Sashiko).
- Patch 1: no change, added Reviewed-by tags.

v1: https://lore.kernel.org/netdev/20261029062214.3407223-1-anilkaushikwireless@gmail.com/

Anil Kaushik (2):
  genetlink: Reject joining multicast groups no family owns
  genetlink: Clear stale members when assigning multicast group IDs

 net/netlink/genetlink.c | 34 +++++++++++++++++++++++-----------
 1 file changed, 23 insertions(+), 11 deletions(-)

-- 
2.25.1

