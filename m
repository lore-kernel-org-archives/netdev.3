Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 575F838F252
	for <netdev@vger.kernel.org>; Mon,  4 May 2026 23:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777935820; cv=none; b=bDTyPQyArdROkuEYanZO2F4XZ4zW39bXIafihqbVEWXI47UhWTZOm+SDOdSTiehBSdGJBQzjtaM4jIzlqX6JRHMFbuHyzBsAPCokguQbBYFVfqV3MbTjvQibmpO3Nu5j3ZThEdulaO+sbw1s4AgjwYD/ZJuYySpzelPvZC5bM3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777935820; c=relaxed/simple;
	bh=Vu9HKZxizCJAisOFcUT+gCWJvIaKKdflj9Guih+yCfI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BkrORzE/OFygqzR/tCbWeV3uGqJovfONItkGUFtpeCqB7axCPOp3pSXMhiITPktyYZb1JDpRqo7mzjkdRvcXZujEgX/jln7M32/J2ybjgehDz3/hG7/kXM8RvTudWkUYMvLZuscj//JfMm6kyrYE56O5FZfgaY2ZhBm6ZLIVdv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=Wd+F9ik5; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="Wd+F9ik5"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4893940bb5eso23991575e9.3
        for <netdev@vger.kernel.org>; Mon, 04 May 2026 16:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1777935816; x=1778540616; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VOczcbAt2NKZI1gdXHBWjdfynCG2wrc/DPp9jjuyBGw=;
        b=Wd+F9ik5MUHhwMbYvZyq51DMQDxfAN7aJdY9u3hTn8LhS7xXZIoT/CDfhJC06t/I6F
         Zz9O1iabamReQd48prDIUaJtzrNqILD/ax35gCxzRUYQKUciN0VWeqRGsuBdNtRij84P
         zy1TPfSRN1dqSapWh4Ii8E7WQ0dNKvB4RjiRGjzL+CC0EJlnTNgDno9eeJ+8v6raUk23
         asTlsWpA3AsNrS8jxcCKiQAa79uf9QjHvPrARtzDtrod9xv/3q3YtYTqmgkbli8xEDVK
         lyLK6YcfJuhCZpttMWHdWrTbnKzSj4G2otDB+yXK9aaPIkf1FGiIxPqtp/MUwDSKVNyo
         V1Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777935816; x=1778540616;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VOczcbAt2NKZI1gdXHBWjdfynCG2wrc/DPp9jjuyBGw=;
        b=ZLCuKemy/ezwnJW9P8uc2JWlIwmMgRxwy0axGjWcAbZiTWlrMBzRXTaCzUEkQSZaY8
         P7Ss/z2BonNmXkpaJKFYUlfuBzET4oGG2KcOrPIE1sTi86e3Pqrn8KcCw8p68vkDbcLK
         PaTAsMilCwfGICUtY1U4jOrMztcFBBup46+bOLzuPM4qsnV+Pm5Xwt0YaKJQlplQTaX9
         UFnqBU1z8Vq3J4yEq0kJjG1GjQEu5zBDA/MGX59ffussbLXdZygi/A9McPnR4k3+eCAH
         h3S1wKLwJ8x2LQjSTDFGkA8x3UXDOLGdZnNm543ZJI9V4njvLKix/ZhRLmd0TgQs+upc
         gUUw==
X-Gm-Message-State: AOJu0YxTbeY8iuOY3aNvgiMO0gFIWTZeN9k1yTfPIS34i8f+PIGFriK/
	HKTw+Ic0jPz0+IdAzND6yTewOxXfWFZLYdATIKvzKQ6tywMSjLu+rqgdoeU2Cj9A5Z70q0csgBz
	AJylXMlkRdnUYg6Sf7m2Rb+CieKpWHcmJpbd8eVbLK20G4uPkGkmUrVc/exFku3GoT6Y=
X-Gm-Gg: AeBDieuUgOSl+88dC7kTdqzxCa+PRTSl4SlGWAnw5N8mZ1cjGB6USwsYLa+o0/PZIZB
	4uHLTRzdutngsL670VS/AtKz7VeTphHe2sgi+wamxxayPnJFDQPqnHU138EMNgeeVvt2+AWwio2
	erjg/9BK/UqrMRygvclBpx8dgMHEaYJ2aoyrT++UAyairsc/y5117RqEmJ4BTIwq9dP/IOpRdsq
	GQkEKGQyJqaYGukSkzrs0WZLQQD7byiUh20qk2yCmqP5XcaUCBncvbVUIp74CLkYwBBP4NZ5AEC
	4zuyQ07M8JkhW91b2/iIiFWd56Bp7HyPdCjwikTx7Obk9fZyRtcigL4cNHlQ15yW0jkfa5BnOLe
	DApj9R50lCgl6zdfscJibOWFVDJGaD4x94G8jbNRs31JiNPAAgxmloj6pyKwJ/WTEwBloQLn4CW
	U/0UMmu7hjX/YRHx8U86pPuVrTGJHQ2rbR245urzHdZN9MJ98=
X-Received: by 2002:a05:600c:46d1:b0:489:1d74:56d with SMTP id 5b1f17b1804b1-48a988ca441mr188663885e9.29.1777935816273;
        Mon, 04 May 2026 16:03:36 -0700 (PDT)
Received: from inifinity.mandelbit.com ([2001:67c:2fbc:1:1d7d:7ce5:717a:133e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a81ed6bafsm636149165e9.2.2026.05.04.16.03.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 16:03:35 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: edumazet@google.com,
	sd@queasysnail.net,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	ralf@mandelbit.com,
	Antonio Quartulli <antonio@openvpn.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>
Subject: [PATCH net 0/3] pull request: fixes for ovpn 2026-05-04
Date: Tue,  5 May 2026 01:03:02 +0200
Message-ID: <20260504230305.2681646-1-antonio@openvpn.net>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello netdev team,

Here is a respin of the previous PR, after gathering an extra review
from sashiko. This PR also includes an extra fix for the selftests.

Patch 1 is ensuring that the MAC header offset is reset before
deliering the packet to the upper layer. Not doing so could trick other
parts of the networking stack into wrong calculations.

Patch 1 fixes the inconsistent call context for gro_cells_receive() and
dev_dstats_rx_add().
On a TCP connection, we can end up calling gro_cells_receive() from
process context, which is unexpected (and could potentially trigger
deadlocks). At the same time, also dev_dstats_rx_add() should not be
invoked concurrently on the same CPU (i.e. from a softirq).
For this reason we're wrapping the aforementioned calls within
local_bh_disable/enable().


Ideally all selftests should always succeed now.

Please pull or let me know of any issue.

Thanks,
	Antonio


The following changes since commit bd3a4795d5744f59a1f485379f1303e5e606f377:

  selftests: tls: add test for data loss on small pipe (2026-05-02 18:27:14 -0700)

are available in the Git repository at:

  https://github.com/OpenVPN/ovpn-net-next.git tags/ovpn-net-20260504

for you to fetch changes up to 201ba706318d460a2ea660e3652610be62532a70:

  selftests: ovpn: reduce ping count in test.sh (2026-05-05 00:31:11 +0200)

----------------------------------------------------------------
Includes changes:
* ensure MAC header offset is reset before delivering packet
* ensure gro_cells_receive() and dstats_dev_add() are called with BH
  disabled
* reduce ping count in selftest to ensure it completes within
  timeout

----------------------------------------------------------------
Qingfang Deng (1):
      ovpn: reset MAC header before passing skb up

Ralf Lici (2):
      ovpn: ensure packet delivery happens with BH disabled
      selftests: ovpn: reduce ping count in test.sh

 drivers/net/ovpn/io.c                    | 7 +++++++
 tools/testing/selftests/net/ovpn/test.sh | 4 ++--
 2 files changed, 9 insertions(+), 2 deletions(-)
