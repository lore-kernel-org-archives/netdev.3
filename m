Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.36.163.20
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793339984;
	b=pLc/n/XCUKrYTYraY6oVipNbyqzp9prjdbR7ftMZlkNcNcc/eZOVTDuqNgNtkN18ycYf
	 /UshW770//L/bmuKPg5CZzQmh/+U/4Ul8vrcLTIiaWHKUfdB1z81Un52rsmDJm2wJg+bU
	 GX/cqEKEpWHxiXxfbftbkLlQwtZFYjC2HZY8w381hzbvSbz2cWLCZ0dIfA0LH2uGa2l/P
	 d/t1VYO4wuQ5f9Sj+pKcuxQc44VlTK9rZXhJJPawJSOXYqL+350bCHpXqRWzaj/mOwx4Y
	 MZthMDF8fgSWwFiY/asKSvJptFDnPPuHNYzErY5gWP1dxX/IB/FsLcV616w5eIJ3jfw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793339984;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:X-SEG-SpamProfiler-Analysis:
	 X-SEG-SpamProfiler-Score:x-atlnz-ls;
	bh=bh6EHZPrNyoS1HgK5A35tRQ4EcLKs/r7EsZvb82hyuA=;
	b=PbzihgCmW5nrZRd/dAeLIsFZHbImBMXULgerzNzE7ruFwXAjXh7qSimEipMDY/WaEQyn
	 pGx3thHPYQsKH/XlaQ8FH1KgVtXgq/mcv2r6Vn//Xq4tkZOGK8lkq2i+wLZYA7TaZcM1u
	 yY3QIhVlAocR4ECt6nSEEYTODEF4bmkYRqOeVxwWHV0clEjEQLwGGJFWCI8WX1T7D6VjC
	 38e0d4YQ4uXQaj+Mi0UZtmG6oCPhfh7CQH3sSGzsshfAldzytV4yra68f9UCX1jI+rGr6
	 LOSAdmgurcNFg7Va8GepfODCTdm+DtaqHdA3hXlPsm6DquL0dbiBil8jW3Jm4cpYrFA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=alliedtelesis.co.nz;
	spf=pass smtp.mailfrom=alliedtelesis.co.nz;
	dkim=pass header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.a=rsa-sha256 header.s=mail181024 header.b="M0bIC/5t";
	arc=none smtp.remote-ip=202.36.163.20
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45498606A31D
	for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 05:59:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 45498606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.a=rsa-sha256 header.s=mail181024 header.b=M0bIC/5t
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id EEF2A2C047F;
	Fri, 30 Oct 2026 18:59:40 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1793339980;
	bh=bh6EHZPrNyoS1HgK5A35tRQ4EcLKs/r7EsZvb82hyuA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=M0bIC/5tv7bJpFCnt8phIBeJ5c5Vo4CfnCvNQkfw3p11LuOcBESE56end89gq9uZu
	 zi7sOvnt7KZkESGdAClQkWzLZbLfGHliLlEfXU3beuCbNVmRqVr2WAkJUaIsibhVWY
	 Jri0LHEM/dgGphvnFdgirdk7BaJ55gql/X7TuX6AmCa/bYh5jNvgRKasoThmp8OFVr
	 iRbA+RdjAevctTNicVV0RkO02JiZvjGEvW4nYslqak99BEc/6HFMynrnRRpQ1C2uvx
	 /IS++TsGApwxBogvyy2SnKUVRrta7eWFlQv4+kQBtG5vwioBkNyK7DYFanVigkCzqS
	 7wYdzmdlftA0w==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B6ae4324c0000>; Fri, 30 Oct 2026 18:59:40 +1300
Received: from angga-dl.ws.atlnz.lc (angga-dl.ws.atlnz.lc [10.33.22.14])
	by pat.atlnz.lc (Postfix) with ESMTP id C696A13EE2B;
	Fri, 30 Oct 2026 18:59:40 +1300 (NZDT)
Received: by angga-dl.ws.atlnz.lc (Postfix, from userid 1025)
	id C4AE0564D90; Fri, 30 Oct 2026 18:59:40 +1300 (NZDT)
From: Hermin Anggawijaya <hermin.anggawijaya@alliedtelesis.co.nz>
To: dsahern@kernel.org,
	idosch@nvidia.com,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Hermin Anggawijaya <hermin.anggawijaya@alliedtelesis.co.nz>
Subject: [PATCH net-next 1/2] ipv6: addrconf: don't update lifetimes of manual addresses from RA
Date: Fri, 30 Oct 2026 18:57:56 +1300
Message-ID: <20261030055757.2094944-2-hermin.anggawijaya@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261030055757.2094944-1-hermin.anggawijaya@alliedtelesis.co.nz>
References: <20261030055757.2094944-1-hermin.anggawijaya@alliedtelesis.co.nz>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.4 cv=FJW4xPos c=1 sm=1 tr=0 ts=6ae4324c a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=660iZSQnnn4A:10 a=ez7XK7wUi3z0WCJNaL4A:9 a=3ZKOabzyN94A:10
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat

When a Router Advertisement carries a Prefix Information Option with
the autonomous flag set, addrconf_prefix_rcv_add_addr() looks up the
address that SLAAC would form from the prefix. If an address with that
value already exists on the interface, its valid and preferred
lifetimes are refreshed from the PIO, regardless of how the address
was created.

RFC 4862 Section 5.5.3 e) only requires this for "an address
configured by stateless autoconfiguration". A manually configured
address that happens to match the SLAAC-derived address, e.g. a static
EUI-64 address in an advertised prefix, has its infinite lifetimes
replaced with the finite ones from the RA. The address then expires
and is removed once the router stops advertising the prefix, even
though the administrator configured it as permanent.

This is easy to hit on a router that accepts RAs on an interface that
it also advertises a prefix on with an EUI-64 address configured from
that prefix: its own RAs turn the configured address into one with
finite lifetimes. If the RA daemon advertises the remaining lifetime
of the address (e.g. radvd with DecrementLifetimes), the advertised
lifetimes then count down on every RA.

Addresses created by SLAAC are marked with IFA_F_MANAGETEMPADDR, so
only refresh the lifetimes of addresses carrying that flag. A user
can still opt in to RA-driven lifetime management of a manually added
address by adding it with the mngtmpaddr flag.

Signed-off-by: Hermin Anggawijaya <hermin.anggawijaya@alliedtelesis.co.nz=
>
---
 net/ipv6/addrconf.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index c8c0dd04982d..43d80f09229b 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -2762,6 +2762,15 @@ int addrconf_prefix_rcv_add_addr(struct net *net, =
struct net_device *dev,
 		unsigned long now;
 		u32 stored_lft;
=20
+		/* RFC 4862 Section 5.5.3e only applies to addresses
+		 * configured by stateless autoconfiguration. Leave the
+		 * lifetimes of manually configured addresses alone.
+		 */
+		if (!(ifp->flags & IFA_F_MANAGETEMPADDR)) {
+			in6_ifa_put(ifp);
+			return 0;
+		}
+
 		/* update lifetime (RFC2462 5.5.3 e) */
 		spin_lock_bh(&ifp->lock);
 		now =3D jiffies;
--=20
2.56.0

