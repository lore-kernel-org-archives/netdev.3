Received: from oak.phenome.org (oak.phenome.org [193.110.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1FC83D9DA2
	for <netdev@vger.kernel.org>; Wed, 24 Jun 2026 15:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.110.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782314197; cv=none; b=t3BSKXf1Vl0f8p/8rKw0IpuVKMGTaS3tiTcHqJTq7SgKLZJknT7PM+dg7L4M9R1Y4nv6qeV02Q/5msJgzugB5ryjt7hkwRdgaEozQ5q6I5AvrMcJ/fIcs8g7Ikqmt81vdHXfvCIeQRrpk7Lg/OsRgZr1ubpjsjwmdKN4+eksYyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782314197; c=relaxed/simple;
	bh=oNnWWmtYtfPBPdcL8G/M5Jk6XVhkKurLK11Wz2xbYFg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XeCXMCkGXTLPwSFiNxe/HhvhqLxbZbKShOX4kTcrg8d+cNZVYxVyJSf3Hh3zHptttl8dsdfcjQ+CiY+MLlN6wugyG8Gp4BVRy+4UpnXtPhGAGiotxbXUSGQduh0W2cX8ShjnXLdNaztbr3KIIi9XqwejHyzzqzAy+B9/Ribleyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=phenome.org; spf=pass smtp.mailfrom=phenome.org; dkim=pass (2048-bit key) header.d=phenome.org header.i=@phenome.org header.b=iyRuS3yB; arc=none smtp.client-ip=193.110.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=phenome.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phenome.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=phenome.org header.i=@phenome.org header.b="iyRuS3yB"
Authentication-Results: oak.phenome.org (amavisd); dkim=pass (2048-bit key)
 reason="pass (just generated, assumed good)" header.d=phenome.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=phenome.org; h=
	in-reply-to:content-transfer-encoding:content-disposition
	:content-type:content-type:mime-version:references:message-id
	:subject:subject:from:from:date:date:received; s=oak1; t=
	1782313860; x=1783177861; bh=oNnWWmtYtfPBPdcL8G/M5Jk6XVhkKurLK11
	Wz2xbYFg=; b=iyRuS3yB0IBXNdqAaAAeS2PAlPV9f5+Gf3ZKR4TSweJ8ldQjsoP
	7TSdT4bQKF3ieOfM3YAOvLkdS2PrzntAvB2+VQJZqgu6NO/q32TydTSPQv5pJBqa
	iMRcPVt0tmwPx6WZs8sdXiNWtfJ1amxs4PHPNTWKpkL4ZAF9f4tCSu49cJkph0Gu
	Za8gAVdJ27PUBV9DCLcgTnzHOb1gOaZsKAiZxuFNTYG2rFe0EuXcDd5K9X4oros4
	01MMJDEUlKmDp0Czh4hb3d4MzBMevADb70zMGv9XMgZmVzkMohBhkAkPCu6NV6hu
	fq8tLaxQlD2Ue+U/gc0dWoCuRgge1Eldk8g==
X-Virus-Scanned: amavisd at oak.phenome.org
Received: by oak.phenome.org (Postfix);
	Wed, 24 Jun 2026 17:10:56 +0200 (CEST)
Date: Wed, 24 Jun 2026 17:10:37 +0200
From: Antony Antony <antony@phenome.org>
To: Jakub Kicinski <kuba@kernel.org>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Nathan Harold <nharold@google.com>, Yan Yan <evitayan@google.com>
Cc: Antony Antony <antony.antony@secunet.com>,
	David Miller <davem@davemloft.net>,
	Herbert Xu <herbert@gondor.apana.org.au>, netdev@vger.kernel.org,
	Tobias Brunner <tobias@strongswan.org>,
	Sabrina Dubroca <sd@queasysnail.net>
Subject: Re: [PATCH 0/18] pull request (net-next): ipsec-next 2026-06-12
Message-ID: <ajvzbVLCce1p86i6@Antony2201.local>
References: <20260612074725.1760473-1-steffen.klassert@secunet.com>
 <20260613131552.2562d433@kernel.org>
 <ajDlFUhMfJP36qA8@Antony2201.local>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ajDlFUhMfJP36qA8@Antony2201.local>

On Tue, Jun 16, 2026 at 07:54:29AM +0200, Antony Antony wrote:
> On Sat, Jun 13, 2026 at 01:15:52PM -0700, Jakub Kicinski wrote:
> > On Fri, 12 Jun 2026 09:46:16 +0200 Steffen Klassert wrote:
> > > 3) Add a new netlink message XFRM_MSG_MIGRATE_STATE that
> > >    allows migrating individual IPsec SAs independently of
> > >    their policies. The existing XFRM_MSG_MIGRATE is tightly coupled
> > >    to policy+SA migration, lacks SPI for unique SA identification,
> > >    and cannot express reqid changes or migrate Transport mode
> > >    selectors. The new interface identifies the SA via SPI and mark,
> > >    supports reqid changes, address family changes, encap removal,
> > >    and uses an atomic create+install flow under x->lock to prevent
> > >    SN/IV reuse during AEAD SA migration.
> > >    From Antony Antony.
> > 
> > Hi! There are some Sashiko comments here, please follow up:
> > 
> > https://sashiko.dev/#/patchset/20260612074725.1760473-8-steffen.klassert@secunet.com
> > 
> 
> Thanks Jakub. I have fixes and testing them now. And I will send fixes soon.
> 
> The comments didn't click until I realized xfrm_user_state_lookup() only
> keys on mark.v & mark.m, so distinct (v, m) pairs collapse to the same
> masked value. A lookup key of {0, 0} matches a source SA with mark
> {0, 0xffffff} (both mask to 0), but reusing {0, 0} as the migrated mark 
> turns "match only mark 0x00" into "match all traffic".
> 
> Fix is copy from old SA than from old_mark passed along. This also pointed 
> more issues.

I have fixes queued up for the issues Sashiko found, to send once the
ipsec tree has net-next. What Sashiko pointed are corner cases. IMO
a typical IKE/IPsec daemon would not trigger, but worth fixing. 

The fixes address all four High findings and the Medium in patch 16/18.
Finding 6 (patch 05/18, encap removal) was determined to be a false
positive — already reviewed.

One tricky part worth noting: xfrm allows two SAs with the same SPI,
src, dst, and proto, however different mark:

  ip xfrm state add src 10.1.1.1 dst 10.1.1.2 spi 0x1000 .. mark 0x1 mask 0xff
  ip xfrm state add src 10.1.1.1 dst 10.1.1.2 spi 0x1000 .. mark 0x2 mask 0xff

  ip x s
  src 10.1.1.1 dst 10.1.1.2
      proto esp spi 0x00001000 reqid 100 mode tunnel
      replay-window 0
      mark 0x2/0xff
      aead rfc4106(gcm(aes)) 0x1111111111111111111111111111111111111111 96
      anti-replay context: seq 0x0, oseq 0x0, bitmap 0x00000000
      sel src 0.0.0.0/0 dst 0.0.0.0/0
  src 10.1.1.1 dst 10.1.1.2
      proto esp spi 0x00001000 reqid 100 mode tunnel
      replay-window 0
      mark 0x1/0xff
      aead rfc4106(gcm(aes)) 0x1111111111111111111111111111111111111111 96
      anti-replay context: seq 0x0, oseq 0x0, bitmap 0x00000000
      sel src 0.0.0.0/0 dst 0.0.0.0/0

Both are accepted: same SPI 0x1000, two distinct SAs with diffrent
mark. Note that both SAs share the same key material and their
independent oseq counters both start at 0 - the encrypted packets
from each produces an identical AES-GCM IV.

Does anyone know whether this is intentional or accidental? Is there a
use case that requires two SAs with identical crypto and replay counter,
however, different marks?

This is also what makes state migration with Mark complex. Since xfrm
permits two SAs to share the same SPI with different marks, migrating
a mark must check whether the target slot is already occupied.
The fix "xfrm: check mark changes for SA tuple collisions in XFRM_MSG_MIGRATE_STATE" does
exactly that, using the effective lookup key m->v & m->m to detect a
collision before proceeding.

Kernel selftests for this series are included in the tree. However,
extensive testing is difficult on my end — *swan cannot easily create
these cases.

Yan/Nathan,
would you be able to run the Android test suite against this branch? to
test migrating SA with mark set.

https://github.com/antonyantony/linux/tree/migrate-state-fixes-v0

-antony
