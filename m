Received: from aib29agb123.bom1.oracleemaildelivery.com (aib29agb123.bom1.oracleemaildelivery.com [192.29.172.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93A6933DEDD
	for <netdev@vger.kernel.org>; Tue,  7 Apr 2026 04:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.29.172.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775537601; cv=none; b=mHgRzCEYCGXgbc+FH+PjRyklfOAcIWVCkiBOVKDhEt7mvW1tF2E6HdzejkXjga/RyfM0J667WhaC1NgOFuaor18djSR+E0udYljCDdwRCS4HAqiXWf2jEaNjRJlUJ45B0bantCXgEFYSRgZ9R3TdWCfOSz07s9gQZKT8BxpA73U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775537601; c=relaxed/simple;
	bh=DOGNxOuGnChhZQLwlrQLOpL2pK7O5LofYIVDLE+YYWc=;
	h=From:To:Subject:Date:Message-id:MIME-version:Content-type; b=jnifdMaRFvszkxln4orAqqhxXwHvXqDSoFBGhKVimqwLy/mhqVTHKxGFs2wfGq1NDIiiIEFs2tM2ML7q+2PWPCZLKcvkBOIqg9o7uQgdyX4ylLfNW///6VHNiJ+0nRnRWAF2wHs7bKOBkRqEHtC58CtnDjEhs2WzW55jucvLx8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=linknsell.com; spf=pass smtp.mailfrom=bom1.rp.oracleemaildelivery.com; dkim=pass (2048-bit key) header.d=linknsell.com header.i=@linknsell.com header.b=HwxNa9UH; dkim=pass (2048-bit key) header.d=bom1.rp.oracleemaildelivery.com header.i=@bom1.rp.oracleemaildelivery.com header.b=egIcT8L9; arc=none smtp.client-ip=192.29.172.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=linknsell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bom1.rp.oracleemaildelivery.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linknsell.com header.i=@linknsell.com header.b="HwxNa9UH";
	dkim=pass (2048-bit key) header.d=bom1.rp.oracleemaildelivery.com header.i=@bom1.rp.oracleemaildelivery.com header.b="egIcT8L9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=smtp.linknsell.com.20250508;
 d=linknsell.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender:List-Unsubscribe:List-Unsubscribe-Post;
 bh=DOGNxOuGnChhZQLwlrQLOpL2pK7O5LofYIVDLE+YYWc=;
 b=HwxNa9UHBB5iah8v0tDkibBpo2M0QUKVWU6NEmTQVS5jlBAdMyYAwRiNyutQUm3vnmUeqabiFFGm
   cDAHkyjIlYLgA4CAWt10NvILo8x542FlPjLZQwgLmKuH7pQAhdUhchbLocaRXqGTMLWX1nBCd+bv
   0QiDLihxZS/VpIsCf/lqX9nkXJ+nbrxnAyaA1O/hVljwYMVO10sCMopjnuDJo+6tgAAjIJKFjlKA
   a6p+CkkZhwoPNZaJV9T3WrTUoQn9QaslAv5CP67fFi6dmgeJzodryULh1deYne+vdxx8aZp2UBaD
   Ybk17JdYiZ56uhST3x6G23cr6oa2CVUpyGjcHA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-bom-20200207;
 d=bom1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender:List-Unsubscribe:List-Unsubscribe-Post;
 bh=DOGNxOuGnChhZQLwlrQLOpL2pK7O5LofYIVDLE+YYWc=;
 b=egIcT8L9v6h2D763F1PgBLKJnOnv/eBUgiZtwxk578Eww9o++LPYUHHl7AdoaxWsfFbo/O48ThO3
   YINoopE+3ZubDwBu4ZEb91Owy1g3VKg+wVo1If7Ws84ilg9NYEvnRWmMFvMiWGBj+QSb3qpY+Qh9
   w/CS7d4I3508CRX7V0igFMJ/GSTSrmxp1baL0fBkAQIku6hPl+yL7xvEx0SaRue4Tmc7tsmWhTWQ
   RwN5w/9LJwW5BLYBJEFCBTtLCvJD9vXbVmMa+gc3zrY45tYtK2vG4TUeeh+k3E8OA5FSZV710i/y
   nBb5eyndnb33FqalRFDls3uHrglbVFqektVomw==
Received: by omta-ad1-fd1-402-ap-mumbai-1.omtaad1.vcndpbom.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20260212 64bit (built Feb 12
 2026))
 with ESMTPS id <0TD300EVGXKTO6A0@omta-ad1-fd1-402-ap-mumbai-1.omtaad1.vcndpbom.oraclevcn.com> for
 netdev@vger.kernel.org; Tue, 07 Apr 2026 04:53:17 +0000 (GMT)
List-Unsubscribe-Post: List-Unsubscribe=One-Click
Reply-to: jisunlee@gmilweb.com
From: Jisun Lee <NoReply@linknsell.com>
To: netdev@vger.kernel.org
Subject: I need your help
Date: 7 Apr 2026 05:53:14 +0100
Message-id: <20260407051725.A00AAA6B0435AA7A@linknsell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Content-type: text/plain;	charset="utf-8"
Content-transfer-encoding: quoted-printable
Reporting-Meta:
 AAGi5cWnrTT4y34B1qvDUxR1Rsnzi/bNdivngbcgnQHx1PzWyIJmi0ji+3UCCCnp
 D4cA0CnNMIO1lBduhQNyIeENYZguLw5sC/Fn4e1u3u+c0w88U2SjZNQMilaQpvFM
 cA5JSBo2NuZSBmv7hdoVVjoltNoK2kFGaBP9dK0JDB/VIdTPEk1V/9Nq6JeEqHDD
 TRyDl9hetGr+nW8bGpF5cYA0SfK0kYzMMYXIvvC3eel6lP9rJjyWzj/yXOkshkIe
 I0BZFlCbW8crZHcPj3LvZqYDpzDS0hpT8P/TwSOOc8mvlkYOmbe+Hvd6h+N018uc
 paRrzP0vmrUta8D7l6TjeKTYinQawYDjq1cTlJPzxr4Wtzk9rEBpAmkws0qxuAQZ
 D7CcKAgKMWdNsKcOX3agdj4hQ5nf25xbRuoGFFeSw0sF++7s2oSAnWoFHPd3tVko
 n6snGYkyks4/cdaRIn+zXGda8YPrIMyBqK3pXrOVMQdFPHvJPFyH6A==

Dear Beloved

My ex Husband Song Lee refuse to pay our divorce settlement
funds. =E2=80=8BI need your help to recover Assets from the bank for=20
healthcare and child support
=E2=80=8Bpurposes, diagnosed with (bladder cancer).

=E2=80=8BI need your advise and support

=E2=80=8BThank You
Jisun Lee
