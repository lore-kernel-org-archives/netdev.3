Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793371880;
	b=WqJUr9Vz0HzVAMchCW947BbiQErawuU1NauZMUPuB8725WP0skmFTkSsHhq5p3bKvDlN
	 Oig5J2Q0EdjcGBxO+ncarZ9Im3DgEanspOttsguRskfqVH9IkwTBLQui+rWrTLBYZhHVr
	 JUyYAkoCk2GJks3JZ8Ow/DlsQB6NCbkMrfVQ4ndUjBvqymSUt98hm6+Wgo0Ofslq1zUcH
	 G6QAvDoYRxLw0LEs7tVLxvAm12tYnY0TBYnF23CMflkVWJBO3mUy54NJByIWf32z4PcWn
	 2Dfo3Q0Iai59MEl5Fek3lvrEn+GOZ//wnkcPCW4O1VawouQ4SqomzWlt0xCe+Pc5YgQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793371880;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=R8urE/MblH81futfpbrrueHST0lxA1KUo7S3ldW3HX0=;
	b=TreAxh/rZZQreUorWVXIT3DEm4Y1DH+e7dU7qnpKnwbaRYiwe7PdJM8ar0HL+lrUGFVG
	 0fRg8tKXHqOIIgSl+hKWsvsGTVVSfxgy9TaJeNwtV1f/rggQk/vnCMRqi7z9f/o1tLg8y
	 RRSUqzSO8qaciGvfxu4+V/Nr5XuTeW4slLyketrcQxtsCbR6joVoVhuAllRkiDTF0B6qX
	 SbeEVcJmaWqiPG9bvRmM5NF0qLskMPK2/sNGns8cZBJWg49T3L2tgxt8J5bRKjZKtyeez
	 RsrX/OtjOMiEpkuKGdOC8oWzmNi8ZQKDUhPMsoBoakLHtQXj/bUC0Uo6xBoBGxjMrkg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="X/M+iKt2";
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C312606A320;
	Fri, 30 Oct 2026 14:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X/M+iKt2
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793371878;
	b=UEGGPnmGEH3U7jM+c3pI6RxWcUYo+gb4oJZ+54qw8sGGoh8kA9oESkjNpP+zM2cjyhRv
	 ky6Axn8/k3H01zwzs6TukbdgX+U+7YCYXEOH0poxv2rhcp77SeHuIXNX/VYQhA7DP3xzv
	 iE4k5j0HA12RfpEx+qae8IY3rzuTsakEKSdLz2lnDIt5wPmf+po5xtkZmgQ+CIfaaA58Q
	 WFFai3UgftT9BqtIgpSm0hFDNXx3jNVpCr/14Dh55m+r9id5nmGJPWMe7xDM9lRUiGkVc
	 f2CjK4eyH+rX+7zTgpGeFVY4Vsf03PmR7rRhHt6gd947c+fSGe2OO/uo/2vk+VKzJ4Q==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793371878;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=R8urE/MblH81futfpbrrueHST0lxA1KUo7S3ldW3HX0=;
	b=PtaQruyNVVoD9MdV8jeUIkfHMUwpEG18pJGqjqMvs9C+lhlKvQR0+pPAJwAdYwR814fF
	 rcqPAN0B3BfgCXFk1pbdzo2Bb3vg2APOdvmK5KvasvDAH4LptvD0V8HJkHy/vmbF2wAQa
	 mtRa+zFTSh/z39IagQq9V7RAlRXi9W1Z4FN15+jyOpbNWVykHpDUafFzH+/7L67Ad35Tk
	 wBB4nfkpdwgJh6R7eTe8P5eFkO2ZI4BUASHzm6hmnDh7jJptV2Ggq7fP92iTbMeLCmGUD
	 BD3owr9KepSufu9PYYHXpl7BnMRWEJPnmdE0iCTg0uzPe1tkf3Nqaqa98S05Fctdn0A==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id C2A6A1F000C1;
	Fri, 30 Oct 2026 14:51:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793371878;
	bh=R8urE/MblH81futfpbrrueHST0lxA1KUo7S3ldW3HX0=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=X/M+iKt2QKvw1Z8X1i4C4tZxrKi62wsK3XpjvKeC8Bz462eNKX4m7/cs6BTRjUtOs
	 ncTrK0Vzn/fh4VmpNzwCL/GIfMaDXR9EDcOp6k5cZ1ieEN2tH138JU4xQXzvFUuiHu
	 uq4hl5ydUWT/zqed6W08Vq8R6aHJ3CLdm1PTTJejbiOdKHyvcbJAOkgGbkIfxFnCt2
	 Xx//rdnWcB8mh47Y+PHNHt6M3KZf0eARypl9Jq3zflZ5IZ4wWkvxcWm8EQyRVQeRkI
	 ONZaWvXxHnGqSUtSB+lNfIb1DgtZd85Xz23zDY9WSS2+Rjwi+x9eTRnHVkCG14A51r
	 z5bkbocfL3P7g==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 3F12343808;
	Fri, 30 Oct 2026 14:51:17 +0000 (UTC)
From: Ramses de Norre via B4 Relay <devnull+ramses.well-founded.dev@kernel.org>
Subject: [PATCH net v5 0/2] bonding: fix the initial last_rx seed for the
 ARP monitor
Date: Fri, 30 Oct 2026 15:51:14 +0100
Message-Id: <20261030-bonding-last-rx-v5-0-0b9b653f2f94@well-founded.dev>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3XOTWrDMBAF4KsErTtBf7HkrnKP0IWtGSUqRi6So
 6YE372KAyVQeznDm+/NnWVKgTJ7391ZohJyGGMdDm875i5dPBMErDOTXDbcCgP9GDHEMwxdniD
 dgCuufMe19S2yevWVyIfbIp5YpIl9PJf52n+Smx7WI3YJeRrTz9JbxBLerCgCBLTYNd549FbI4
 zcNA/jxGpFwj1SWkiJfGLnCyMoYp6xSVkon1Qaj/hjB1xhVmYNuufHC91xvfaNfGfuf0cBBoyX
 tUBvdmBVmnudfjBRj6aEBAAA=
X-Change-ID: 20260817-bonding-last-rx-0303fa048f9d
To: Jay Vosburgh <jv@jvosburgh.net>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Jiri Bohac <jbohac@suse.cz>, 
 Eric Dumazet <edumazet@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Nikolay Aleksandrov <razor@blackwall.org>, 
 Hangbin Liu <hangbin.liu@linux.dev>, 
 Ramses de Norre <ramses@well-founded.dev>, 
 Hangbin Liu <liuhangbin@kylinos.cn>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793371876; l=3283;
 i=ramses@well-founded.dev; s=20260817; h=from:subject:message-id;
 bh=HIYn8VwTx+6igHuhnbuF729ujWFvIM7B9ubzvtMtSVU=;
 b=dKgrrTRXVX1LGHd/1hXgQbbC6jlNaF6io2ZkQA5Ul1o2bp9ql2X86sRUwplQbl8lsCyUKgz4s
 5rzT2ZrMllwBmYltcG6737wS3gXdiGUIIINevh+NdQ9I3aitYrj81PA
X-Developer-Key: i=ramses@well-founded.dev; a=ed25519;
 pk=1vBXHBVeJBMaC+2Zuonl0QQhEgGIQHERyF5RZNnrCmw=
X-Endpoint-Received: by B4 Relay for ramses@well-founded.dev/20260817 with
 auth_id=957
X-Original-From: Ramses de Norre <ramses@well-founded.dev>
Reply-To: ramses@well-founded.dev

bond_enslave() seeds a new slave's last_rx before it has received
anything. The ARP monitor checks that seed with an up test for a slave
that starts DOWN, and with a down test for a slave that starts UP. The
seed is wrong for both.

Patch 1 fixes a slave that starts DOWN. Since the up test gained
arp_interval/2 of slack, the seed falls inside the up window, so the
slave is reported UP for half an interval without having received
anything.

Patch 2 fixes a slave that starts UP. The seed brings its down deadline
forward by one interval compared to what arp_missed_max implies. In
load-balance mode, which has no grace period after enslavement, a
healthy slave can flap DOWN with arp_missed_max=1.

Both patches only cover a slave enslaved while the ARP monitor is
running. The seed is not refreshed when the monitor starts later, from
bond_open() or when arp_interval is set at runtime. That predates this
series, I will address it in a separate follow-up.

Signed-off-by: Ramses de Norre <ramses@well-founded.dev>
---
Changes in v5:
- Patch 1: set last_link_up in the UP branch of the seed (Hangbin).
- Patch 1: say "until it receives traffic" instead of "until a real
  reply arrives", any frame updates last_rx with arp_validate=none
  (Sashiko).
- Patch 2: say that it only covers a slave enslaved while the ARP
  monitor is running (Sashiko).
- Pick up Hangbin's Reviewed-by on patch 1.
- Link to v4: https://patch.msgid.link/20261028-bonding-last-rx-v4-0-4d8e4cd47467@well-founded.dev

Changes in v4:
- Patch 1: only use the older seed for a slave that starts DOWN. v3
  also applied it to a slave that starts UP, which brought its down
  deadline forward by one interval (Jay).
- New patch 2: seed a slave that starts UP with last_link_up, giving it
  a full arp_missed_max window. Fixes an existing flap in load-balance
  mode with arp_missed_max=1.
- Drop Hangbin's Reviewed-by, patch 1 changed.
- Link to v3: https://patch.msgid.link/20261027-bonding-last-rx-v3-1-54907f1fb042@well-founded.dev

Changes in v3:
- No code changes. Rebase on current net.
- Reword the commit message along the lines of the v2 discussion: lead
  with what the last_rx seed is for, state that the false UP happens
  independent of primary_reselect, and that the initial link state is
  unchanged.
- Pick up Reviewed-by from Hangbin.
- Cc Nikolay. Hangbin asked for a second review, Jay or Nikolay, would
  you have a look?
- Link to v2: https://patch.msgid.link/20260827-bonding-last-rx-v2-1-7c3833822c23@well-founded.dev

Changes in v2:
- No code changes. Resend with my personal name in the From and
  Signed-off-by lines instead of my handle, as requested for the DCO.
- Link to v1: https://patch.msgid.link/20260817-bonding-last-rx-v1-1-9da6f7fdf812@well-founded.dev

---
Ramses de Norre (2):
      bonding: fix initial last_rx vs ARP-monitor slack window
      bonding: give a slave that starts UP a full arp_missed_max window

 drivers/net/bonding/bond_main.c | 28 ++++++++++++++++++++--------
 1 file changed, 20 insertions(+), 8 deletions(-)
---
base-commit: f75062536e2d45ee182828f0e47e0124be2fdc8d
change-id: 20260817-bonding-last-rx-0303fa048f9d

Best regards,
--  
Ramses de Norre <ramses@well-founded.dev>


