Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793188092;
	b=hpuN/J7C9czN8WwVB6IzODfjM9Bo7adGeHaK7OMJsFwR05LRR7XRCl/wwVmpAnvFAVqC
	 LFDCK0/mB0FFRHJt/JQL/Mn4tMifN/scjvri7PZmTx3hsKm3p0ZK8a1C/KYl0/GIJ5EWQ
	 Yz7YTROhYq+CPLBWNSjnMePvTKz1jxRcwBAtSi7bAR1GItY/tcFlqmW5Q7jH23tybA+9x
	 kH8UBYvmg3hHPx7Q8XY65oEG5yHDCe0DK8NG6ga44O7t5X8DeuRWUaay0SCC+2+Hs5gJ9
	 Ze3yyZ3ZZGrllxi/pHnQ5UcWMiktK2TPrOfNySEST0+Qycfcje9oAweQVWQHHlaxdxg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793188092;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=KFtszsXuoP4pItqFkMJuIDA/NfOGaX+MFZQfZgHtuXo=;
	b=h8HbeUcFuJc5PkTGHwPlgxKJSfmiWqPzCKTKRB7v0jcLGHtXUDRI5vFlxXJqBNLNr52y
	 FmReOxiLZLVz4XGR9zxXlIMWwafVCauPKpUqtMMxzKtl7uYd+v0inCXJBlqDWv8SWTG8R
	 QZq/qaf/qrl6kioQH5/qR45AIKCt9MMDrWaWxg36l+PEHqfxSswwO0PY35zF1Ustmek46
	 R8Vijc1b6buQNToNFR8mRBmwc4vRXfHBnIN37/ONUUF9Xgq7mgHTCNTrd1HdXDu+ow/6T
	 Zc78wvDLuuYPCxDh2xR8lUv3MyGEbgihWrokgM+bZcNdkNL+XLpybfi7PYyo56XYPAQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gL9Am+Vq;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 157A3606A31C;
	Wed, 28 Oct 2026 11:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gL9Am+Vq
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793188091;
	b=gEHEh4oJ0g7wLBDMoHI38lCULaSKWk3wgdpIwJPAIcDjkaBNad/5sCea3Bmi/YsL7MMf
	 Kmm/4rlXBv9mro7pBKOxV9K5emGzXM5d8r2KbXgQk832iCvNQYkfzmGWyvawM4Aj7v08N
	 m6SAuoeoXXJJksQIiXgRA1LxhmlMqadPFxOZB6y5wEFZuc7gltejPuI1nXL6/YKcHOlN7
	 6iq6Yw58B9mNTC/XqCR8IEuCj5TC3n/I1EEnatTHryT+CAAkd6MfaziZXojHqTh4tMnkY
	 VHKFHk9n35yfKILrPl64IYw0u16wHb2mb461CmPEFxYtOoV+e8q7y2uwNiyLTqdhweA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793188091;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=KFtszsXuoP4pItqFkMJuIDA/NfOGaX+MFZQfZgHtuXo=;
	b=GZW78LvQWj0tqq6n+SVnINESrsPKHMXs2u793MKoeJC61cX9vDDd1acoEi9F7bbcVK6v
	 skn9A4kTDToRiYCYxISqRSk2MEWxz40YsPPwCo3K2k3dwXkZ+tWq9Ehnzs9Gp7vVrZPMp
	 Hu15Vnx1sDVp3RgYA66OAycdj17BC+bE2fVEP8svend541OlGVg/dwlUSxyzPNiFBdTRr
	 sLeqPXou2njcC/Hyl8YQLef1rqbcTHjcRm092PjUYDAVLKdJcG/51FInaQalgcmprhDet
	 5lnhmJJUoPVnAxCB0HCFwHwEfd1b9yE8Cq+JEHTy4iEsXYvJ06BCYLF6UaoOxa9vH9Q==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id E107C1F031E8;
	Wed, 28 Oct 2026 11:48:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793188091;
	bh=KFtszsXuoP4pItqFkMJuIDA/NfOGaX+MFZQfZgHtuXo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=gL9Am+VqyzohFX4uw0hIb1/UlmmWWXeU4F1N2OdR9Jow5nh0viWP+HGD9Wvz64jVV
	 u/pElNWRYXKWtIp1GKg/lge+Xy4R0b79SVN2fo7lh9JlBzfORXNNspWonAVc0Vqigu
	 6bB3Qn1carirg8qj3whtPx0O9wOu0JHLXWjQmRF21JZnffdgxL3Lyk0beZdWr7fesA
	 8gigJvHTmk1FlnHOjysk/+yQx/+72EJnfNUkjoIn2YEQT2mEqIvuOijx/qpAMzqc9/
	 f/ME8wxCHNsf59h4SEFK5rUz/uOCbm8fwypwuVrw9+YeLcybD8d0YfbnRwdi1Y9xYQ
	 MqzXnnM6i14yQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 5446C4544E;
	Wed, 28 Oct 2026 11:48:10 +0000 (UTC)
From: Ramses de Norre via B4 Relay <devnull+ramses.well-founded.dev@kernel.org>
Date: Wed, 28 Oct 2026 12:48:08 +0100
Subject: [PATCH net v4 2/2] bonding: give a slave that starts UP a full
 arp_missed_max window
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
Message-Id: <20261028-bonding-last-rx-v4-2-4d8e4cd47467@well-founded.dev>
References: <20261028-bonding-last-rx-v4-0-4d8e4cd47467@well-founded.dev>
In-Reply-To: <20261028-bonding-last-rx-v4-0-4d8e4cd47467@well-founded.dev>
To: Jay Vosburgh <jv@jvosburgh.net>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Jiri Bohac <jbohac@suse.cz>, 
 Eric Dumazet <edumazet@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Nikolay Aleksandrov <razor@blackwall.org>, 
 Hangbin Liu <hangbin.liu@linux.dev>, 
 Ramses de Norre <ramses@well-founded.dev>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793188089; l=2265;
 i=ramses@well-founded.dev; s=20260817; h=from:subject:message-id;
 bh=jXnai77FahX09fOtY6Rp21l2WpqSYi/O/ZmzYrJWvMs=;
 b=U5R6R30n2YS166qbGZnnwdsJawdGkfiO85aLqHD+vTbIYY2cxRR+aLMD+AVYrDChKyI6ZQF7D
 lttVjGTPwTUB0frPT+bYmWCLlInw3wxKaTUR7hUKZ4fAlFkJ5wToByX
X-Developer-Key: i=ramses@well-founded.dev; a=ed25519;
 pk=1vBXHBVeJBMaC+2Zuonl0QQhEgGIQHERyF5RZNnrCmw=
X-Endpoint-Received: by B4 Relay for ramses@well-founded.dev/20260817 with
 auth_id=957
X-Original-From: Ramses de Norre <ramses@well-founded.dev>
Reply-To: ramses@well-founded.dev
Content-Transfer-Encoding: 7bit

From: Ramses de Norre <ramses@well-founded.dev>

The ARP monitor marks an UP slave DOWN once jiffies passes
last_rx + arp_missed_max * arp_interval + arp_interval/2. bond_enslave()
seeds last_rx one arp_interval (plus a tick) in the past, which brings
the down deadline of a slave that starts UP forward by one interval
compared to what arp_missed_max promises.

Active-backup mode hides this with a grace period after enslavement in
bond_ab_arp_inspect(). Load-balance mode has no grace period after
enslavement. With arp_missed_max=1 the deadline is half an interval
after enslavement, and the first monitor run checks the slave before it
sends the first probe. If that run lands in the second half of the
interval, a healthy slave is reported "interface is now down" and comes
back UP on the next run.

Seed a slave that starts UP with last_link_up instead, so it gets a full
arp_missed_max window for its first reply. bond_arp_rcv() and
bond_na_rcv() only trust ARPs seen on backup slaves once the active
slave's last_rx is after its last_link_up. A seed equal to last_link_up
keeps that check false until a real reply arrives, as it is today.

Fixes: 5944b5abd864 ("Bonding: add arp_missed_max option")
Signed-off-by: Ramses de Norre <ramses@well-founded.dev>
---
 drivers/net/bonding/bond_main.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index bfa4cb97e647c..de5b196f4a1ee 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -2160,9 +2160,12 @@ int bond_enslave(struct net_device *bond_dev, struct net_device *slave_dev,
 	if (new_slave->link == BOND_LINK_DOWN)
 		new_slave->last_rx = jiffies -
 			(2 * msecs_to_jiffies(bond->params.arp_interval) + 1);
+	/* Give a slave that starts UP a full arp_missed_max window. Not
+	 * seeding it later than last_link_up keeps bond_arp_rcv() from
+	 * trusting ARPs on backup slaves before the active one got a reply.
+	 */
 	else
-		new_slave->last_rx = jiffies -
-			(msecs_to_jiffies(bond->params.arp_interval) + 1);
+		new_slave->last_rx = new_slave->last_link_up;
 	for (i = 0; i < BOND_MAX_ARP_TARGETS; i++)
 		new_slave->target_last_arp_rx[i] = new_slave->last_rx;
 

-- 
2.56.0


