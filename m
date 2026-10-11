Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A241E18FDBD
	for <netdev@vger.kernel.org>; Sun, 11 Oct 2026 11:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791717375; cv=none; b=h/8VXXx+YmeMlSQP0CGfWh4F55VLiD9M/b8bSkst6aLyITkvgKNbVbyuLFesmj2OsAYAQplA+uUGMlzOWNjM1qL+gwIyTD39rgFLHDPZVQRx2A8r0U47FMj4rYIpPpUg5Awpc/vdB44cOX2kTumZkU5U3iinczh3fGuZNhu8nnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791717375; c=relaxed/simple;
	bh=5n2fjF0VbSmI6/85OVGLV52tja4i00OrgxTy09Gvdc8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uXJaK7VZj5gzIhgjc+B4WvYypv2ZjqBu4z0cw1tdywa19kpfDQJxgUKbfRpSsizrz2NSEc37skURv31AZnKjoXRpPaJPylRXy4Q3ZXlCbNc18tHDmJjD+Do0wMVgy38dmOcHZEyVZD/6GTQPfOHQRlWHzK0Z93MpV7xkacW7+gY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=abh822HC; arc=none smtp.client-ip=74.125.82.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="abh822HC"
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-15354aa70e8so65657c88.1
        for <netdev@vger.kernel.org>; Sun, 11 Oct 2026 04:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791717374; x=1792322174; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=hwfQOboJrE1I9YMyi9xdPhuJ4m7VM518y+XKlBP1o8Q=;
        b=abh822HCl4O1ZJZh9w1kQWDsGNTdmgVoM8l64QDlRJhzy5nxkHRDixh7QBVCWefxkE
         hkyiHciDpK7p1g6weKgjwa31NuGh6Aox3YadA8K2IBfcYwP2Og0fVtJ2ak0EEyncQDNR
         ND5Q3sgArh8I/jW1f64yu0pVMQOyIddhxNaz48VoRnB6BNqe+Zb4/QcZCBk8+LkDX00m
         2S1RCC91vRw29lPKdKBZ516jvwMj9dF+8mrLzLXmJ66ygswpiyIQLXy6oiVGbUrQeYEF
         intz7SngZE0kX0KKQOhLZLujL0M+yE1KVRhmbRE8hqaUReQhB2dLYpatY1optBFGvp+I
         2Qeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791717374; x=1792322174;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hwfQOboJrE1I9YMyi9xdPhuJ4m7VM518y+XKlBP1o8Q=;
        b=adjeCMzzvZVHIQy8IRT85rX8VhKnvdiO3H16U1YS5Yn6Y+rItvn7pgOXXgYtn2326i
         /ZVVOIQ5fB115CSGOUYS2NiK+fG2YKKWC4VRZoIXeNOrmHcuHYkNLLAAWLRrRByomDXZ
         F19I9ENRgO1kQL4rHO39V6UYQcmB0T6T6LE9gCs89yPtp4WBToNtCz5+uNxdndYEJPvu
         ewaMt+jwCo9wzKlJbjoo/6CKwctD6SepMifABT2O27TVxk2FTNpGx9Ct16C17JRe0vH1
         HmufZLEZnK5ZgsHCTMpj/n7Lc7QNXoOYssvC6uK34mWXkfn58C97qiBCB3ZKgpA0LWl0
         0/Vw==
X-Forwarded-Encrypted: i=1; AKwUvBxNFewBnnb3ABNkNI28RcY4McKxWN35lUb5lI1HuU2+anbpSYX01MiCUnsg51cF1mHAcuOVimw=@vger.kernel.org
X-Gm-Message-State: AFq9FYLZhiGK9cD5sPsC3+NSjgsoX9l2Z/CQqNd2X2Mwa2X7GGYCUT7G
	eqeY4RNWIpIRR57lhDwF1cks741bpcQkxnSZJr9xahU9KZdHCJjYv4se
X-Gm-Gg: AYBFou0oTE2gND7YvH5Req7HbCrGo96TmwGo+VsMF0lTN4HzDCZm+IgVNp2Dm8Mb2AK
	MaTQiXUBNRwv1zqfx4jgK/Hf1ixCk6s9d31MTYMuKQhHqfmttjFlsEaZCwRKZ+mly880jLYakZ9
	VnwHUFUeDl1q3kxiUVFfeVdxznSh8JThYGUisTto/RrdBYsBEaa9HjYniR1iN5KQPLHvLD2Hyao
	9deRRr+ZL4WWcT3C+dXtMiUiA3diLcrwFz0vPV063eKYSIF9Wr9KdUkNs0rTowU2THC+b1ZrlYc
	r/M/FsomLZf7v4i/KFbw2jydN4A1fUn5E1JGWYkMD328HHOEuR8b3uRBlKoSi9ZbFe9nDk1btfb
	qeoNxy0Ky3abN975EA6zz9RPQrIaQ00QYERgaDqOqzFdmhtZLz8ujzfFVdlnn+SmS0RyGyvShCH
	CDuanvHVoGuHpfc915q1tCACaFPzYUedYUxnalJs457UxrCnayZZSMpJ9vO7I5GrO74la7maDxO
	4Xfi3iTKKviN78eLi4IyUotE7r0Zd4HAoyX8W8E4MyJ03V3mVol8hnLxbj8E7d9ObC+Ke5MyaQv
	6+yUg1ezUz/QEV95k572+COLFjIORmkY8rdMmB26RqnLnu2bDvGllrPmejdSE9gG1HheWboL1vN
	TO21dvOXlw0g+piWOS/A5S9Esh7mWcSKOX/1agYOFAX6N+a8UAbV+DYIKKj+hMPOMzw==
X-Received: by 2002:a05:701b:240d:b0:144:eb46:c3f with SMTP id a92af1059eb24-16a572659bamr10847616c88.2.1791717373401;
        Sun, 11 Oct 2026 04:16:13 -0700 (PDT)
Received: from FT6N242TWK ([223.181.119.248])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-169a6021e49sm20851347c88.20.2026.10.11.04.16.09
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 11 Oct 2026 04:16:12 -0700 (PDT)
From: Shashank Mohan Jain <jain.sm@gmail.com>
To: Eric Dumazet <edumazet@kernel.org>,
	Neal Cardwell <ncardwell@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>
Cc: Kuniyuki Iwashima <kuniyu@google.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 0/2] tcp: keep the route window on the SYN when SO_RCVBUF is set before connect
Date: Sun, 11 Oct 2026 16:46:04 +0530
Message-ID: <20261011111606.14753-1-jain.sm@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v1 was a single [PATCH net] with only the fix. Eric Dumazet pointed out
that the changelog overstated the effect (TCP_WINDOW_CLAMP does not
persist past the first data segments), that "no window scaling" was
inaccurate (the option is still sent, with a shift of 0), and asked for
a packetdrill test and for the series to target net-next. This v2
rewrites the changelog accordingly, leads with the common
SO_RCVBUF-before-connect / listener case, adds a packetdrill test, and
is based on net-next.

Patch 1 is the fix: setsockopt(SO_RCVBUF) must not write tp->window_clamp
while the socket is in TCP_CLOSE or TCP_LISTEN, so that
tcp_connect_init() and tcp_openreq_init_rwin() still apply the route
window metric (RTAX_WINDOW) and the defaults to the SYN / SYN-ACK window
and window scale.

Patch 2 adds a packetdrill test: with "window 4096" on the route to the
peer and SO_RCVBUF set before connect(), the SYN must advertise the
route-clamped window and window scale 0. On an unpatched net-next kernel
the SYN carries win 65535, wscale 5; with patch 1 it carries win 2920,
wscale 0.

Changes since v1 (single [PATCH net]):
 - changelog: say the patch restores the SYN/SYN-ACK window and window
   scale, not a persistent clamp; note that since a2cbb1603943
   tcp_measure_rcv_mss() recomputes window_clamp from sk_rcvbuf anyway.
 - changelog: "wscale 0 (option still sent, shift 0)" instead of "no
   window scaling"; lead with the SO_RCVBUF-before-connect / listener
   case.
 - add the packetdrill selftest (patch 2).
 - retarget from net to net-next.

Shashank Mohan Jain (2):
  tcp: don't set window_clamp from SO_RCVBUF before the socket is
    connected
  selftests/net/packetdrill: test SO_RCVBUF before connect keeps route
    window

 net/ipv4/tcp.c                                |  8 ++++++
 .../tcp_rcvbuf_before_connect_window.pkt      | 27 +++++++++++++++++++
 2 files changed, 35 insertions(+)
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_rcvbuf_before_connect_window.pkt


base-commit: d8674294aefef02266c4d47ad10131f1bffbe534
-- 
2.43.0

