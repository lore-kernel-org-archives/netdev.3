Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793528037;
	b=25CT150gQvDfQD7L4RfFWBTJx2GaqYx+1D5hwAylj5GVR7MIryJviAhoslJbppXJRniP
	 wxADtNEKRvreVFCEsMj4fQ34sAxvgISrgvlgHWr53GOI6cAlOOodmGg6IyLF+IGzv5WYZ
	 E3/EtLrQ9nrdYejkwCWAyIo8JqnR1oJUlsLPrqD3A5BqaDp9/xDGWCbLiDVScNoDaFSpq
	 CnRjHINMF8EiyKvOhys0VfvFckyigO2kb7fUWO7htx/6yDRQYplhMN/gYgO9On6montAY
	 xaXpw92UL0lr+cPpX9uvsMC//TQXUEkKCSdfdOtiLsbqMux+PsFd4bsRJE1sI4YPbnw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793528037;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=oUfwpBkFzgWbXZ3OGl55vqxu+rm3oEmMdWSQQc845j4=;
	b=SMOd+kMWSzp4kLzlKUHGFtgElzhbSUbM6NuF7HErpCP0PYiHvFhpzuDoSDZN7HFgSx+O
	 mVMDB8Ev99L3VWUQ1CBZ1x+ANbge6DF8Hr+9bwcuShox0aUvFiNCl9om3Iul1inrUGwDd
	 Dt9nxXEX2Q7355Z1QEWXo8pQrMhGdbM0pYygtcsjqwi4y8q88sSCwMg5ZzTdlESNlMipH
	 C+Q9VLC2qNuekDKVKClyGId2OkbQbzS5ImjLF0vM6Oxo5YlVKhnBH2wNe9uyLUluzMeTF
	 u8d8itc4pu8fWP88u1hTFDyzfEsMpM+mrzegNNDzWEMjFj7Jyf6H6ykpk27F1oCmroQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AvtRaWpz;
	arc=none smtp.remote-ip=74.125.82.181
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5445C606A325
	for <netdev@vger.kernel.org>; Sun,  1 Nov 2026 10:13:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5445C606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AvtRaWpz
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-353804b591eso3623251eec.0
        for <netdev@vger.kernel.org>; Sun, 01 Nov 2026 02:13:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793528035; x=1794132835; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=oUfwpBkFzgWbXZ3OGl55vqxu+rm3oEmMdWSQQc845j4=;
        b=AvtRaWpzrSLSE8iiskXZs7831rIAmvR3q7WLdW3gRLNC4dcC8ZCOHFsSpkDtORgH4s
         SGBHq81AESbJGyRl7IvnTcwDpwgq0YsOOP8D/y6Y/rTSH2vRZRKQ633T1Gz8505tmWaZ
         7kefy0TLXoXgdu621M2bjoA0srhdzx4vYWbrJhVgDMhkOfrGBETO+6v63sfTLOKUp2N0
         lACg8xeJ7+SYzWyqroN/nyyevnXdIF3FDnsxb1bChgnQw+5CFg7WNXnfGe5Zl3OwS6VO
         F7fDxuVY+Z6pPv/xAJ6g35nS/RS5YfaCHSUbDcvvEemTYVmUJcUh4KQTBKcQQJfacxNY
         ZZYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793528035; x=1794132835;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oUfwpBkFzgWbXZ3OGl55vqxu+rm3oEmMdWSQQc845j4=;
        b=x+ob5R8dyUhPHVnrPxTRREdgTodVA7oLvmfU5m6oxYDfkPNVRqk2pZZyrRJ8+ysVQS
         FnBDTp+dX3ZeTP0i0Dkk7D2lo/bUoH6Ch0FLjVZu8/UQ3BGbfjwJF5fWwWx7Q0pf2E6J
         LtwcczHHuhiBZsS2ZkXyWxoP0H/O93rKrmp2CXO77NTdSNfRT24azRg+an5GVjeUfF0V
         ax3V8GRfAAmHQq9HtVQ72JyMGANUAHDflPSvxF/tAxUQt9gJknLX1ITFWX7bmU41EScr
         +ibW8IN7wzDe9/A2S0se8ARA8h2ozVPQwlrzi2cU+X3yxknMzborE5452+wNkqNnJlgQ
         gjcQ==
X-Gm-Message-State: AFq9FYJ3niSk8XdAvvgiSFccRIHTNPiRFQ6TDmvw2NKQFK50olAnwGn5
	HFjEuOdF/YmfVeEhnFCJ/MvQxwrlC6CT8+n3DDms2CMHouuNh3f3poJY1mi+4Q==
X-Gm-Gg: AYBFou1CaDsIyBAW1FLrp47FUAe9kWZa3XQqe4eL0akl6Z/idSXTWcWG330J71gJK7M
	Zd5yHYPqZnLk/pBOgo70+2nFiL3TXmTpulTn/ktNB/8HXhVo81KHSZgu/XlRu5Hx4DGS1HOFLtS
	eJm5kCgBghL2btVD9MATDG+1yZ9Wk5MLUfFhWPp682nSTNzon2+OTEIXqF8SqvTumAwB6hlj1vR
	BfgoBZwIRjz2gTrsSBE3QOzBmYC4oMEhcjlQqCIoWbbG17odbMOY65GwGc3hJZB/XiQInbp5cfd
	N1fGn3r/9+AA0HtjB6WXu82jF7D9lt99b8q6CLi757UDUR6eKTX5bpvEyaPDA7ufpIrs6CC2new
	k4IfvYoGxGGITW2h8V24JmlyNgLQrNZNffdEEOU/sENCpmhj9K1am+NLl1jxaSaJtYaOBCzjKpz
	gDtRJTd86eu07XUx9V2RdnueFHYT4VZfzICP6zT+fY7I2KxKFCjaZXrT9z6WmhgLS37O9ffFo9s
	1lqpXwQWLDS84GsgyxccoIaEHX51570zKr+Wc0FbV8NOAmxWmxPwgkmkx+Ntj7DkaLzNR5qeZWs
	IzWGJLiVY5JZHlIsDgtNl6SoVo7kvl1i/ig8sEbPieqJL9XWXrPT+8Oqv9El+cIGhP7zV2Kybpy
	XtuSOBVpBmQckKs8bhPRMDuJqK8PY7FgWcs5nvuhBLr2qso34jOm5lPweifeo4BT66Bzfaz2Jtw
	==
X-Received: by 2002:a05:693c:87ce:10b0:36a:1fa2:fbbe with SMTP id 5a478bee46e88-36a424658edmr10939415eec.41.1793528035020;
        Sun, 01 Nov 2026 02:13:55 -0800 (PST)
Received: from ramen-dev-security-2.asia-south1-c.c.ramen-dev-345017.internal (90.156.200.35.bc.googleusercontent.com. [35.200.156.90])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a42662f23sm29799664eec.2.2026.11.01.02.13.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 02:13:54 -0800 (PST)
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
Subject: [PATCH net v3 0/2] genetlink: fix joining multicast groups no family owns
Date: Sun,  1 Nov 2026 10:13:45 +0000
Message-Id: <20261101101347.3910654-1-anilkaushikwireless@gmail.com>
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
group is checked again against its current owner.

Tested as an unprivileged user, with an msleep() added after the bind
callback in netlink_setsockopt() and netlink_bind(), and a test family
that registers again with GENL_MCAST_CAP_NET_ADMIN:

                                         patch 1 only   v3
  setsockopt:
  unregister in the window,
  register later                         member         not member
  unregister and register in the window  member         not member
  another family unregistered
  (must still join)                      member         member
  bind():
  unregister and register in the window  member         not member

The test family counts its bind and unbind callbacks: they stay
balanced with v3. Normal joins, rtnetlink bind() and lockdep show no
change.

The test from v1 (join all free IDs, then load gtp and drop_monitor)
gives the same result as before.

I used an LLM to help write and review the code, the tests and the
commit messages of this series. I checked and tested every change
myself.

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

v2: https://lore.kernel.org/netdev/20261031054632.3697295-1-anilkaushikwireless@gmail.com/
v1: https://lore.kernel.org/netdev/20261029062214.3407223-1-anilkaushikwireless@gmail.com/

Anil Kaushik (2):
  genetlink: Reject joining multicast groups no family owns
  netlink: Check a group again if it was released while joining it

 net/netlink/af_netlink.c | 61 +++++++++++++++++++++++++++++++++++++++-
 net/netlink/af_netlink.h |  1 +
 net/netlink/genetlink.c  |  3 +-
 3 files changed, 63 insertions(+), 2 deletions(-)

-- 
2.25.1

