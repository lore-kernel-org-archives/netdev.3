Received: from mail-4325.protonmail.ch (mail-4325.protonmail.ch [185.70.43.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18BDD286419
	for <netdev@vger.kernel.org>; Thu,  5 Mar 2026 17:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772733592; cv=none; b=NAlX0Nmo1ROybl4YROZ5wvH/1z6hDWJRpBzl+Y8FqqSH7UNoE0vka/UOhL3q9yL8yZvky3X0ZA85sQbWOCwMP4UiT43c9DSD6f6B1LVNQmLlvnnkQ8jUAktBMYMfgHloR+4tjkSgfb0aIAw2eHaax+a2knYvxqoDfk1DRZcVtE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772733592; c=relaxed/simple;
	bh=jcs41+98bcUSMRnHBBS7tcFWPW6Jhbtq/KIyPgtM5LQ=;
	h=Date:To:From:Subject:Message-ID:MIME-Version:Content-Type; b=T0iD8ZJkyxtjoPgFgUBY77ALfd8kkWHgOV1C4fd+sCR2Sth4ht9K1LT+B7KyWJ6Wxe6OcERhLW4TzNmtQXffEb8VWH+ku+0LZ5kziki/H975IVs7elyIQxxwYtxzH64dom/MJ1vrzlDX+/z04GAAsTmshjFCvDdqQUaz6E/uM6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=yvb02oVy; arc=none smtp.client-ip=185.70.43.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="yvb02oVy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1772733588; x=1772992788;
	bh=jcs41+98bcUSMRnHBBS7tcFWPW6Jhbtq/KIyPgtM5LQ=;
	h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=yvb02oVyY+TOctxRrs6qh4Lk1SgcI8LKEAXS6OrEIrE5IF6swQWDePDb02psAcL8m
	 PUinzd8Catq8TXB9DW7/S8Wwo4WOe9cEaqJIoO50mSxzB5Pg/afiZxR8qUhDq4TOTG
	 5Z0H82iSsz0F7bRT5rmzl0Sl3funafkj4n4JybY2DPkBztTUmRegCVr5gMBlDXL62Q
	 7a/jqPjbgUcfXxSLxntQukrw6StVWmLGBUdeKzGVCiBROwsWcrPDqWmgMi4XnEJPHh
	 KegJLTKBPf3YgZuOr0+b27MShcS8wCpPtl9/XbBQSCXPwDmMjas3K92KouNNeWIBqG
	 UrdCGPL89M3pQ==
Date: Thu, 05 Mar 2026 17:59:42 +0000
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
From: Tcll5850 <Tcll5850@protonmail.com>
Subject: nothing critical, just someone who's looking to explore
Message-ID: <KwsyGNmgMH5lcxLiTWhIbe0XX7-kiztsgncHINm7rfJM4vxOYl-CVD28EneJkMjg7PKhb1q-O38AyLO8qzOklEu9EUH-JJV9NCY0c0_dqnI=@protonmail.com>
Feedback-ID: 25435554:user:proton
X-Pm-Message-ID: bf2f037521e8146a1fdac3cbe2bbb1c8f6d5e57b
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

hey, since I can't find any sort of information anywhere about this topic..=
.

I'm a bit interested in digging below userland to figure out core informati=
on about modding firmware (may as well call it hacking)

now this isn't the same stuff you see everywhere on Invidious or Startpage =
or whatever where you LZMA/b43-fwcutter extract some *.fw/bin image from so=
me common modem/router/IOT device backup or whatever, and then uses tools I=
 don't have such as binwalk/Ghidra/IDAPro to crack the contents

... no this is something nobody talks about instead, I'd like to extract th=
e contents of a *.fw/bin image from /lib/firmware using what's listed via m=
odinfo and figure out how things tick from there...

I do have the source for my kernel, but I kinda would just prefer to go in =
semi-blindly (following the kernel sources for docs) while hacking via the =
reverse-end (modifying what's already built) depending on how viable that r=
eally is :P

so my question is... what would I expect to be starting with when approachi=
ng/RE-ing things from this angle rather than compiling a firmware source ed=
it via GCC or whatever?

thanks :)
