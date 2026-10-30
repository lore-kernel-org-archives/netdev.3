Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793371878;
	b=Pz1CG2eaj6SNtdS+Q8YZpbVy29SpBdIiwHD5g7mA/hIanbVvGCEQhb0VTxko8OjEQDin
	 dZNYuwxV5qAn05XIb9uPjmY1jGEgjG48B0AsM7OmP4OpWU+f+YQ569VDmBNjTOrpzKb7J
	 244FWJPYhelSEf5nw5BE+E3ZkqDE4P6CVXHE9AoFBuKY7iO7DzFBLc5XXQT1dm+N+uDFY
	 pG7IzAfq/miJrmTqffs0x68cAsOXQAUL+llC9VdfhwZJyBX6GsoOX69zJlnTgKX17Kiwp
	 wfVjAszhPa8poqT2rUpzxsKs6inJT50XI3WleMs4MvOVwRdmRGY6JAiMmbDAdWWJl/w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793371878;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=kTNKMRgD6VzzUEFGclRk4teYR/w2kpaalYljeMm93Do=;
	b=P7MnjXOM6w7PIYofATKqBTzUnBAId5smCtQCVr19EWSoj/9P8ygujNjHaGy1x1GP6LH4
	 Lyny6IAq2l/9tjnRbKXzAWjoxBozh4B/wMRitC5bAWT1dSMb1/X4HOStZuaROIh8L5WNV
	 FYBgn9kEIf9hgDjJKA+yotdeYfey7vYGtBmdYmZp5FTdBxQPvYVEEFtbCmZO1DGgW0h2J
	 duRnfxx4/tLqElQzk7RzeRrRz9w/a9ZMZQyVyWMOHbWlrSnxLpM7YASP4D4Wc7akmRbjG
	 7AOmbOI2hvtg8wJto3QYUEQ9/0QwGvdB5mnTjyYjmXqroU4YXKPAzzS5a1xNd49guEQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=O7zHzp06;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84551606A31A;
	Fri, 30 Oct 2026 14:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=O7zHzp06
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793371878;
	b=c68xaOmflaeFL8+svJ6xgVNXpi6tXi0PmHQPgmnQjLEqkrP3eTR0ojGTjPibXsQEAlYN
	 7GgB0N5ZFI199UeKhItgbZcbuxDaiC4/RAKw5INnjqGsT8E01WTOnuM3l9TJMiYqg8DHo
	 1lE+xMLHWN0uhLYBGyQt41Bq5Q/TmObNgqvbyCcHsA06HU0P5y026KSw+EJIWXLWzYTbM
	 sWZCHLKhgIPvuuelP2OCl21Y6V788GrKkMXPxWj7wgofvg8Pd4d6jxhLKt1SZNrvGZGzr
	 P/5sKoVDfx2ppct5iBsDGQfspLcoKOU3lSAqeqoRZUC3qWKcLWQpbTIH00M14APoAMw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793371878;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=kTNKMRgD6VzzUEFGclRk4teYR/w2kpaalYljeMm93Do=;
	b=l/u/9xMBp17SBLzMgEEE5aoPs0WgX/ZX7k0MrFZgPplvZHeRuSfJwr5haV2W1WaSGQ50
	 ab6j/X5KwDhrHL9ecAer2Ki5xAdcr7YKCEaMh28jWqHx1Gblvpbf9f9GFGtQNDcRv4ISU
	 Jn+bTW0J82bSkxivm22pNqbfLNm7iwV5hlO1HhwS2i0oPMYjn8kor6ncuLZjSC7+6O7ev
	 DBf28hz4q/AmJDYnhcQ6UpEpTRON8cTdnxbB2jH/SyW7tXf3IgdSGhW/EBvvc55HXymU0
	 eMbWwZmg0md45doFwQVp3niIsvfpX6qipTSvdmovpfpZQ+OwFJvETs9vWF04RFksoFw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id D11C81F0093A;
	Fri, 30 Oct 2026 14:51:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793371878;
	bh=kTNKMRgD6VzzUEFGclRk4teYR/w2kpaalYljeMm93Do=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=O7zHzp066hwyF0Eum5Eb2c4HqiVp6DQWrO0nFj72fAtn8EUqaKd4tfmwVQRYDIpsL
	 UX/EwRnemRzyR15ERqCwuyhs4JGdiQucr89D+aUTy78kYR2DveACqq8y9XdqKf2ULB
	 GTiBJzm4qztmg4awatWHh+bVVWqX3DvWUIUsHgqjcubwRi5fxJydfrWlWZxY6RWzgX
	 tu/jedD6le1snREZvllhgDol6h63v+DFRxJkEnkW4SuG1TYoqiHZFRUWlz8gy60Mmv
	 9WK4hA0Ja7ekVYOoKHWLvtCHZsEz42IGp3ZPdHqEblC5Kdgz2w66Ei0n388L90xnyi
	 iWSzMTZhSfQqw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 57EDE4380C;
	Fri, 30 Oct 2026 14:51:17 +0000 (UTC)
From: Ramses de Norre via B4 Relay <devnull+ramses.well-founded.dev@kernel.org>
Date: Fri, 30 Oct 2026 15:51:16 +0100
Subject: [PATCH net v5 2/2] bonding: give a slave that starts UP a full
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
Message-Id: <20261030-bonding-last-rx-v5-2-0b9b653f2f94@well-founded.dev>
References: <20261030-bonding-last-rx-v5-0-0b9b653f2f94@well-founded.dev>
In-Reply-To: <20261030-bonding-last-rx-v5-0-0b9b653f2f94@well-founded.dev>
To: Jay Vosburgh <jv@jvosburgh.net>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Jiri Bohac <jbohac@suse.cz>, 
 Eric Dumazet <edumazet@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Nikolay Aleksandrov <razor@blackwall.org>, 
 Hangbin Liu <hangbin.liu@linux.dev>, 
 Ramses de Norre <ramses@well-founded.dev>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793371876; l=2527;
 i=ramses@well-founded.dev; s=20260817; h=from:subject:message-id;
 bh=Jz6XOf8wK/vTGG6FZBTatFH3vzBsN5U/CtOmPMLqDGk=;
 b=ud5UqZ2PLRoXHmclyAZZgFGIviPMEZlhFDBxo3uAxdNCzS98Svhl/pTlmP6yrpxt29Y9qiksT
 dbIMi1U6s/fAHsNXkverOD/afPHF/CnkXgtyU04JK6SzZpMnAoyhgKi
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

This only covers a slave enslaved while the ARP monitor is running.
When the monitor starts later, from bond_open() or when arp_interval is
set at runtime, the seed is still as old as the time since enslavement,
as it was before this patch.

Fixes: 5944b5abd864 ("Bonding: add arp_missed_max option")
Signed-off-by: Ramses de Norre <ramses@well-founded.dev>
---
 drivers/net/bonding/bond_main.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 2f5638f4d3a78..84eafb607c370 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -2158,9 +2158,13 @@ int bond_enslave(struct net_device *bond_dev, struct net_device *slave_dev,
 		new_slave->last_rx = jiffies -
 			(2 * msecs_to_jiffies(bond->params.arp_interval) + 1);
 	} else {
+		/* Give a slave that starts UP a full arp_missed_max window.
+		 * Not seeding it later than last_link_up keeps bond_arp_rcv()
+		 * from trusting ARPs on backup slaves before the active one
+		 * got a reply.
+		 */
 		new_slave->last_link_up = jiffies;
-		new_slave->last_rx = jiffies -
-			(msecs_to_jiffies(bond->params.arp_interval) + 1);
+		new_slave->last_rx = new_slave->last_link_up;
 	}
 	for (i = 0; i < BOND_MAX_ARP_TARGETS; i++)
 		new_slave->target_last_arp_rx[i] = new_slave->last_rx;

-- 
2.56.0


