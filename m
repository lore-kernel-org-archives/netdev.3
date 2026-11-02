Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793635107;
	b=k3CzawyYcHSudrrWa+mdtGfvEPqY2YNXnnj3uFm6sOl82YdmRnCJcDFSZAh2ZVO3RV6n
	 Ezgmflh19FkEXcoLlZcnvka8fY4N7+ImU1QjXc7CaBfJMf5RlmxXOlkBfdnxiR8m5Phze
	 0Z956OTMmcSRtCGgcDTG0b/r9PnpxRHmPW8EwxX7J5Vt3bTpZ7zYOex4CmYEG1f+ER/iU
	 zIIPfyOWG8/WBRerQVuAVOadyF7vHTQKvs2D/4Nm8bkEb4q08QtL2/V7r8xFM4tyq9GEY
	 WbR4p0eL3/U5Sq9gO9RuknQBhP3nVxLRe5e6U9MSMuaOOZo6R/LFxmbdoMvYZJ8WO1g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793635107;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=ZLAdr+wJraqBBQJZMLxL2JwKTZnl1MAf4rmeB7WLuOw=;
	b=PT8OMqwGh0poR6jucr427eugmI9BUD1vVjeBKPn5uxRhq2CCvSbGbQ5GwouG5EgXIP3V
	 FwlUjAzHcI13HMR2wYxFA6wwbWIQ5SLLC1BL1Gb3f/hPdqE82U4kh9lDrFsY4krFxk5xz
	 pUsnjsiyi3JIKpwQ+twyGNRP1wGefL14R9bEUW2IowH8xfebg9vhqA+yy6wopC3bm69cZ
	 blf5rTj7iJelFMsokMlZYOXLkn+RMStBp1zpdfntwn/ystb8WlYdKZwBtfIbZicV1+lRz
	 c2Ddc8Trz4HYHKOdQd5Sw/OZvaU+tCokhl/atabg3BG1Bb/0pnbDvz/EGnyayAyl8Tw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=plb0ZRPL;
	arc=none smtp.remote-ip=74.125.82.50
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BDC6606EEBB
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 15:58:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8BDC6606EEBB
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=plb0ZRPL
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-1b1ce85287aso1100796c88.0
        for <netdev@vger.kernel.org>; Mon, 02 Nov 2026 07:58:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793635107; x=1794239907; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZLAdr+wJraqBBQJZMLxL2JwKTZnl1MAf4rmeB7WLuOw=;
        b=plb0ZRPLqV81cehr7hYrsYdNFFdgIQVNIOqv5zHeb8a8/h7pC0RbmcVgQhQ6fbeeUC
         AiPWqyk0hlWsBwhg/vheb9hRcgvln+MCwnzrFiPMTXhGoceORTBGjAtMDdE7Pl1tSM/f
         c0eV0zT6tq5ajsmY/5cEpqf2m6gNmQVsI/I3bgUS3SCOPkZ3o2NPm3LQpgMEqiAvRPLt
         SJgmX9Zw08kjNoIiM3cncQ01tEmpA9iKrJ7qymvvZlYgsH/x65kB9xlMrQQ+LRWXFv+H
         7QHya6c35uvD4ufukQKjNHGi6hCJo0va8FVrMd28hsWh1ZSXq9QLU/tCe77JW4GbV0Rx
         RFxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793635107; x=1794239907;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZLAdr+wJraqBBQJZMLxL2JwKTZnl1MAf4rmeB7WLuOw=;
        b=J017V5RDWFTiZyUCiwhNhxU9pIpqcGlKUdnOqz+bEH+gROuHbCOyYDKiobIUOcS8Xo
         UJr/gEDa0NsJ/8HiJfN4fIo93y1uwb6hYSrMSVLbc1NJP+nlbybwGc5pcn8sGd/5WZRu
         j/IHl1PA1da/OE8uOwZ/tzPKYvF9NUm6TSwk1O7kidA59uYss6LY/pBnytw0QvirYAFU
         8LPpJMRuoZG1oABLOOHQV6vJcEmQqMsnqW+xtyOl8BBoRFkVbPxkFpG3+2A47/v38I8k
         +VBK595v2tSpeXDUCPqet4UzIDKDb9FI7uA1jG0FPFcaMWJxQ68v2kdbtzoVTJeyp138
         a3TA==
X-Gm-Message-State: AFq9FYLjJONV2SP1KMmLKVZcTM9VjQM3AqiPeBZWp0DKGkSJxg9oZC4y
	lJulT/VBBvHcoaetAkO4M1G/2VvPAmjLxD5EdZ5MesoIxR9TMpW7k9dtWJdBUg==
X-Gm-Gg: AYBFou328XU8pZcW9ILE+SrDL3hwPalUGhL2HsIWHmf8d/4OXg67wGY4oFtnk/KOmhF
	GcJmcT4Yh08XRvtrs2tf1c4x38LcTVBIyZnfpgxtuYJRUsK+Y7mKbq7ih04C4unoinTYVfS4SV5
	XlnTYCZXgYlyL6VmZQALrIrX0XyyBzprcfYboU4LfErtYXnj4EXR1Gjg0BXZ73QyWx6HLnoRuTs
	fSL2OMpzSCxwo8C5p78Josa2nOchaGSeODxGSNzZmO3QBTX2VGBjx2tQSh2hkJCVSMm5GjSTfEV
	DHzCXR2qMkQ6gH7y0HMZ/2Ltw/evgaxnafspcI6U5kXdghprMzN6Ot/I+bsWuYLeC1ncuhsrcoH
	n/s6T9+qnqPhz23vctKaWQG4UdLQ+9//EpalQ+bOBJbfvehj0OEYhu37L4kPKqPOTZxzcYQgqWl
	CWGgI/0LiYAeD3r2KzSiWLa1IWP/bhEqC6arLMZz+NnZjVeXRs11yWIGca2EEb3rRv8WHjQzq+c
	ef21h01UNuYVdU9GkEJ4cuVBvzYm6Qxmm16+Azv6XznsFNplKxce0Q6OC4FZaIF7hcxbqeN66DC
	c9L69ioI+kzJD61vLEHCJKMW4zBrxrMqxvx3wTKvk+lNnufOm1VGTbRiRToFeYXw8TwAHjAGtQP
	fySuHtKS1ZtxRMESJmQWJWucxEbYXfZNq3UjXDPxnJjElO/hPvI9aP8Eio7Qm36+owOM2MQhj5w
	==
X-Received: by 2002:a05:7022:4392:b0:1a4:c892:b14f with SMTP id a92af1059eb24-1ac5de53bc8mr25736739c88.29.1793635106285;
        Mon, 02 Nov 2026 07:58:26 -0800 (PST)
Received: from ramen-dev-security-2.asia-south1-c.c.ramen-dev-345017.internal (90.156.200.35.bc.googleusercontent.com. [35.200.156.90])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1aed79b3dfcsm35115869c88.12.2026.11.02.07.58.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 07:58:25 -0800 (PST)
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
	Florian Westphal <fw@strlen.de>,
	Mat Martineau <martineau@kernel.org>,
	XingWang Xiang <v3rdant.xiang@gmail.com>,
	Alice Ryhl <aliceryhl@google.com>,
	linux-kernel@vger.kernel.org,
	Anil Kaushik <anilkaushikwireless@gmail.com>
Subject: [PATCH net v4 0/2] genetlink: fix joining multicast groups no family owns
Date: Mon,  2 Nov 2026 15:58:17 +0000
Message-Id: <20261102155819.4100930-1-anilkaushikwireless@gmail.com>
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

genl_bind() checks the GENL_MCAST_CAP_* flags of a group, but the
membership bit is set later, after the lock is dropped. A socket can end
up a member of a group whose flags were never checked for it: when it
joins a group ID that no family owns, or when the family of the group is
unregistered between the check and the point where the bit is set.

Patch 1 rejects joins to group IDs that no family owns. Patch 2 counts,
per group, how many times its members were cleared, which genetlink does
when a family is unregistered. If the count changed after the check, the
group is checked again against its current owner, after the bind
callback is undone if that owner is the one it reached. The core cannot
always tell, see patch 2.

Tested as an unprivileged user, with an msleep() added after the bind
callback in netlink_setsockopt() and netlink_bind(), and a test family
that registers again with GENL_MCAST_CAP_NET_ADMIN:

                                         patch 1 only   v4
  setsockopt:
  unregister in the window,
  register later                         member         not member
  unregister and register in the window  member         not member
  another family unregistered
  (must still join)                      member         member
  bind():
  unregister and register in the window  member         not member

With the msleep() before the bind callback instead, and a test family
that registers again without the flag, the family is bound once, and not
twice as with v3:

                                         v3             v4
  binds while a member, setsockopt/bind  2              1
  binds once the socket is closed        1              0

The test family counts its bind and unbind callbacks: they stay
balanced in all these cases. If the family is replaced just after the
bind callback returned, and before the second read, with an msleep()
there, it gets one unbind too many. The socket is still rejected or
checked against the new family. Normal joins and rtnetlink bind() show
no change.

The test from v1 (join all free IDs, then load gtp and drop_monitor)
gives the same result as before.

I used an LLM to help write and review the code, the tests and the
commit messages of this series. I checked and tested every change
myself.

Changes in v4:
- Patch 2: read the count after ->netlink_bind() too, and call
  ->netlink_unbind() before checking again if the count had already
  changed: ->netlink_bind() can have reached the new owner, which was
  then bound twice (netdev Sashiko). The commit message says what the
  core still cannot tell.
- Patch 1: no change. It does not close the window on its own, patch 2
  does, and it keeps its tags (netdev Sashiko asked about the order).
- The deadlock netdev Sashiko found on the insert failure path of
  netlink_bind() exists without this series, it has its own patch:
  https://lore.kernel.org/netdev/20261102120929.4077030-1-anilkaushikwireless@gmail.com/

Changes in v3:
- Patch 2: check the group again in af_netlink.c instead of clearing
  the members when a family registers. This also covers the case where
  the family is unregistered and another one registers, both in the
  window, does not walk the sockets on every registration, and does not
  touch the members of a group another family still owns (Sashiko).
- Fixes: tag of both patches: the race exists since genl_bind() first
  checked a capability, in 4d54cc32112d (Sashiko).

Changes in v2:
- New patch 2 (Sashiko).
- Patch 1: no change, added Reviewed-by tags.

v3: https://lore.kernel.org/netdev/20261101101347.3910654-1-anilkaushikwireless@gmail.com/
v2: https://lore.kernel.org/netdev/20261031054632.3697295-1-anilkaushikwireless@gmail.com/
v1: https://lore.kernel.org/netdev/20261029062214.3407223-1-anilkaushikwireless@gmail.com/

Anil Kaushik (2):
  genetlink: Reject joining multicast groups no family owns
  netlink: Check a group again if it was released while joining it

 net/netlink/af_netlink.c | 79 +++++++++++++++++++++++++++++++++++++++-
 net/netlink/af_netlink.h |  1 +
 net/netlink/genetlink.c  |  3 +-
 3 files changed, 81 insertions(+), 2 deletions(-)

-- 
2.25.1

