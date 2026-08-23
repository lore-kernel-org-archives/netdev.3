Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com [101.71.155.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 174EA30E0D5;
	Sun, 23 Aug 2026 15:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787500296; cv=none; b=IfkhINnDopZ31pz/x7bxxJ7yU2DpXUsyvVQow7jutTYFNz24+9sXLDS0MXjCt5k2Ja+XBzjPRrM0t5yAPKK1mY0y55596SlFmoO7pZnFDArO6SHdg2he/y2GwutVfAyj/R1+/al6Dxa6fGl1CFAty1ksS6CkwIPhM6tQ/6ZUmAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787500296; c=relaxed/simple;
	bh=30WvttQoB3i0gpuy7qAvCWivBdocv6gHBzg58zOrcdk=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=QIN2tga6S/xzLtn2bg+dTQ2X742i0jTfD7KcG9Wm3zXgqHSimP8IsCIv+AcITAh4HE0zCoSbTc+4c1iHzFD0IoOoIK+MaXn3zgK2q5BZHHswobdxaSnIYm1Pk2Wt9sU36CFeA00JhY56mgn29C52JNZayBHy8HcBB2fLNdEb2BA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.pku.edu.cn; spf=pass smtp.mailfrom=stu.pku.edu.cn; dkim=pass (1024-bit key) header.d=stu.pku.edu.cn header.i=@stu.pku.edu.cn header.b=e43ZwEfR; arc=none smtp.client-ip=101.71.155.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.pku.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.pku.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=stu.pku.edu.cn header.i=@stu.pku.edu.cn header.b="e43ZwEfR"
Received: from Breeze (unknown [106.120.124.108])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4afcc06b3;
	Sun, 23 Aug 2026 23:51:17 +0800 (GMT+08:00)
From: <springbreeze@stu.pku.edu.cn>
To: "'Andrew Lunn'" <andrew@lunn.ch>
Cc: "'Miguel Ojeda'" <miguel.ojeda.sandonis@gmail.com>,
	<rust-for-linux@vger.kernel.org>,
	<netdev@vger.kernel.org>,
	"'FUJITA Tomonori'" <fujita.tomonori@gmail.com>,
	"'Miguel Ojeda'" <ojeda@kernel.org>,
	"'Boqun Feng'" <boqun@kernel.org>
References: <20260823103644.342849-1-springbreeze@stu.pku.edu.cn> <CANiq72mUbkEcvffQV-mNLfCxGkgTqwq1qQLuWpENsUCCBAHOqw@mail.gmail.com> <AOUA5wCUK5sso-ea1NbU-4rk.2.1787484007018.Hmail.2401213299@stu.pku.edu.cn> <CANiq72mQ8bfEw-NM4phjgp-QxEP5RpqNTkXrjjGqkX+VukqkaQ@mail.gmail.com> <AHMAhwDwKw6suFf01VEIOqo9.2.1787486213219.Hmail.2401213299@stu.pku.edu.cn> <f4e5000a-8468-4172-b454-ac97f9ce759e@lunn.ch>
In-Reply-To: <f4e5000a-8468-4172-b454-ac97f9ce759e@lunn.ch>
Subject: RE: [PATCH] rust: net: phy: fix off-by-one bit positions in device status accessors
Date: Sun, 23 Aug 2026 23:51:16 +0800
Message-ID: <000d01dd3317$3d212670$b7637350$@stu.pku.edu.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQIj/MDoIzTklO+86dNHIO3dUcwGOQHg++cYAvJ2YLECMz5T/QIxbouWAnskybu1wJl1cA==
Content-Language: zh-cn
X-HM-Tid: 0aa02f51affb03a1kunm0b6cbcf61fd304
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlCQ0lDVhpCTUlJGUIdSUlJQlYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlKS01VSklLVUpJT1VKS0NZV1kWGg8SFR0UWUFZT0tIVUJCSU
	5LVUpLS1VKQktCWQY+
DKIM-Signature: a=rsa-sha256;
	b=e43ZwEfRONG0OpltaciRYryiL2M+QiAiSin/RUoKgfBNUjX0Xg5gq4y5vahHdt212xS9LFs1m8M1xvPVY02EyFYWVmEtWqWZqGvPkNqXpIMgOF56TMdVLAgEDe+q2FzSSurpdvWJRMbdVYeOjgQEKAramX9svxG5fKsBpkw+KzA=; c=relaxed/relaxed; s=default; d=stu.pku.edu.cn; v=1;
	bh=5cG/09CVGS06qoiFKwNKmeS3mwdE8B2Aw+fDgOfexUQ=;
	h=date:mime-version:subject:message-id:from;

I checked the history: it was the latter.=20

When the abstraction was merged (v6.8), autoneg, link, and =
autoneg_complete
were at bits 13, 14, and 15, and the hand-written numbers were correct.=20

Commit 2796ff1e3dca ("net: phy: add flag is_genphy_driven to struct
phy_device", merged in v6.17) inserted is_genphy_driven just before =
autoneg,
shifting the three fields up by one, and the Rust accessors were not
updated.

The v2 will use the bindgen-generated accessors (link(), autoneg(),
autoneg_complete()) instead of the hard-coded numbers, which also =
removes
the TODO comment that marked them as a stopgap.

I'll send it once the 24-hour resend window for v1 has passed.

	Thanks,
	Chunfeng

-----Original Message-----
From: Andrew Lunn <andrew@lunn.ch>=20
Sent: 2026=C4=EA8=D4=C223=C8=D5 23:27
To: springbreeze <springbreeze@stu.pku.edu.cn>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>;
rust-for-linux@vger.kernel.org; netdev@vger.kernel.org; FUJITA Tomonori
<fujita.tomonori@gmail.com>; Miguel Ojeda <ojeda@kernel.org>; Boqun Feng
<boqun@kernel.org>
Subject: Re: [PATCH] rust: net: phy: fix off-by-one bit positions in =
device
status accessors

On Sun, Aug 23, 2026 at 07:56:53PM +0800, springbreeze wrote:
> Thanks, that makes sense. I will keep v2 to the minimal bit-number fix =

> (with
> Cc: stable) and send the switch to the bindgen-generated accessors as=20
> a separate follow-up patch once the fix lands.

Did you look at the history. Was this always wrong? Or was a new bit =
added
at some point, moving them by one?

If it was always wrong, updating the hard coding is not so bad. But if a =
new
bit has been added, using bindgen would be a better fix, since it will
always be correct.

   Andrew



