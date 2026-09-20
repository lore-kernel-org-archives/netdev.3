Received: from mail-qv2-f12.google.com (mail-qv2-f12.google.com [74.125.230.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BB322EC083
	for <netdev@vger.kernel.org>; Sun, 20 Sep 2026 00:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789865269; cv=none; b=aMTFygogQX1uL7KZUE8szegGjnjEqcvzw5vW/eb46d2zdmx+ic4b1IImy563p+Lj8dDJw3WXUHK4Q9nyoGcDOIyJrglU/f7oqPt3qqzhPLLmxS4E7cLCuuFCX4h/H5Knu+3QVKD1oCfBUOW6fxcTIe5LPHLIjGWeMOf5m0NctDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789865269; c=relaxed/simple;
	bh=MJvGxSsNpYy/kU91KFXt9TSv8kDRgzqAw11+tcx0VCw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DJsrK5icV9zlBgwj1Aljr3u2EUUKZLpGninvmHndRCkQg3Uf80+iVxmWiB/ciCMVszrXQKc5tK75gnsKZ1QPZYeXHk0/S9iSLG3TF2jpqnU5mF7QJADKEUJUd6T4dZo1e0PUA+tnKK24ItfEXusRJTjqp+uDDYivy3KcLENHVpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bMNAj4RG; arc=none smtp.client-ip=74.125.230.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bMNAj4RG"
Received: by mail-qv2-f12.google.com with SMTP id 6a1803df08f44-90cdfc9b6ebso17921346d6.2
        for <netdev@vger.kernel.org>; Sat, 19 Sep 2026 17:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789865267; x=1790470067; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=X2mvB3CBHopypng5GIwWVc/CrGw3Rh9PvRGGQJXfiH0=;
        b=bMNAj4RGm8Akkz3eoQl6pOTon4FQJqNaIn2XPBfbHktbjewff+Z9Fxes3j0QESWkat
         3ggWuISwDzQcm1KMp91q2lmb9VTbXxgh3Fn1Q33yGMhwGAXnUcLXJa+y2k12Nctey+/l
         QNialvg4vWs7CRuji8KmLrG8Cdl1ds5Zi7/T2PJNUKcffmFNtWthVA+0ly/rH/r6apFn
         o5ZvqdRVA9ye+kK6SU1myidrMH3t9aVbCA6jbUltSRhiJJJ+HvWTHE70zdhvxst1pSlY
         6VXKt0V8BffHY2BSG4l08dWgSUp7Vt79ydwoUDUz2Jft7aOWJZb4zXKEwzz6qKRuGvUU
         EERQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789865267; x=1790470067;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=X2mvB3CBHopypng5GIwWVc/CrGw3Rh9PvRGGQJXfiH0=;
        b=cAfgaUS4JPJ1lFavG1LpY7GOxPQYXrFlp4a3QQamPw0Y8kQ5OLpVBhfpbvRGRDLiCl
         jPBJ+pAnH6/IjyulWQfRNl+QDwzF8gYTnCRHA9bMDWfx+b+p/Iwk/F4BH9Co1yZtR7wi
         yCCIQWiBT+5plz1Mh1KNUo3H+MEBCnVEk/5PD3VVPYJLBp95H8sJH7ZU90SoAvp043Me
         vlYquGbwVhQHHQJdN03Tp1jQRXA3A07XKW92BEruJgGcB843O1xx6mQJpYbdYzaDeyk6
         pgKpuS2dpFyCvqGwKUbUtF+NGvsNJuN7peqSYSptB5q/eMl9HNcPSp40g0Ce9PBXVNk3
         L9/w==
X-Gm-Message-State: AFuF++k370qKSlBSG33f3Y61duJU4SfqsK781zwFd3AOE8iqMzYsQYzf
	c34TfBoVEhpzeVVmV3K8FV4T7my0g+usKjBXz5yLPihsYXfdg3suJs1o+fXGJhuhlp0=
X-Gm-Gg: AYBFou2lyg2pjy3+YDAbqjuT0pST43fHrX2TkWcJfcCMAq1T4jqVQUAGHb7YWHqCZ+3
	wa4W01wk1lxKNVha5ErbAbizCHRmNvjTThhr/03JjLcSie5w/obZfjKpD0UnKH7E1XQEHQHZEPZ
	/qxb37QGjFF1hd29JodW8/vxrzkL/9D6OJMOfbYyK466i06suARGHKA+o7zxseSSYrPme4iHugq
	ymDrjucNAAI4UfySwlTv6G8pWYx+09kOpkQZ085EPwuxvQRCBLjLerWK3cxjRUkmh5r1jwZ6fih
	rYaA1GlXeJ74mko0XjnQxvsjp4QMmadJYNyHNFcMrqaQqIC2Ec8+Y8Z3Xzcvs+LRB+xPem7EBGB
	gaW+OSaciPV8MNmLeliRqGe+0qCpy4yAOCoSx1X5E/6R+1wKLshslS3+LDhJcHA9xePIqkuNcak
	hjHbpBOm5nyzUvHqLeYgpEbVCPKRK1dhJWBtW3bPXMACL3VfqAbKn6l0JvAA9E7G74REDG6SuGn
	i3M0tJr0Fw9iKW7yWgVYeXVjkShOV04bMkvVEV6nRdgbAQkPrWWDFfGruti4KxsmqV1w5IK
X-Received: by 2002:a05:6214:434a:b0:910:63c3:5c70 with SMTP id 6a1803df08f44-9129c780e53mr36692256d6.19.1789865267075;
        Sat, 19 Sep 2026 17:47:47 -0700 (PDT)
Received: from localhost.localdomain ([2601:155:4200:2c80:c8b1:39dc:7ddc:dd0c])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9126078cab2sm32122436d6.0.2026.09.19.17.47.46
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 19 Sep 2026 17:47:46 -0700 (PDT)
From: Paulos Yibelo <habte.yibelo@gmail.com>
To: netdev@vger.kernel.org
Cc: mst@redhat.com,
	jasowangio@gmail.com,
	eperezma@redhat.com,
	xuanzhuo@linux.alibaba.com,
	virtualization@lists.linux.dev,
	dsahern@kernel.org,
	idosch@nvidia.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	willemb@google.com,
	hannes@stressinduktion.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v4 0/2] net: prevent partial checksums from modifying IPv4 headers
Date: Sat, 19 Sep 2026 20:47:31 -0400
Message-ID: <20260920004733.6473-1-habte.yibelo@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A TUN or virtio-net user can supply CHECKSUM_PARTIAL metadata whose
checksum start resolves inside the IPv4 header after link-layer headers
are removed. On the IPv4 fragmentation path, skb_checksum_help() may then
modify an IHL which was already parsed and validated. ip_do_fragment()
subsequently trusts the changed IHL and can copy beyond the skb's logical
linear head into emitted IPv4 options.

Patch 1 validates the checksum start relative to skb_network_header().
Patch 2 independently validates and retains the IPv4 header length before
checksum completion.

The issue and this series were reviewed privately. The source reproducer
and complete runtime evidence remain available privately.

Validation included strict checkpatch, focused W=1 builds, a complete
build, two test boots, a legitimate fragmented CHECKSUM_PARTIAL control,
and both forged cases.

Paulos Yibelo (2):
  net: validate virtio checksum start after network header
  ipv4: reject partial checksums covering the IP header

 include/linux/virtio_net.h |  5 +++--
 net/ipv4/ip_output.c       | 23 +++++++++++++++++------
 2 files changed, 20 insertions(+), 8 deletions(-)

base-commit: 9d565b6b72fe3f41fd43636e143072848105189f
