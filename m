Received: from out203-205-221-202.mail.qq.com (out203-205-221-202.mail.qq.com [203.205.221.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0F9040242B;
	Tue, 25 Aug 2026 12:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787659714; cv=none; b=oGwUewUg+wp2ljU8PyKsBVpkfAwU1vvtX35pfaWKL8HvznIdTdBVBJQ/ycaICjR3fx+HSrAgL+9u38ljuQxuRJhGhD0LPl9jTSzUYpPuFWR4Wk304yZOlzxCC+a4+muFHp4GC6ZFOqhpjbAPPM7+olANSZhmo4yDwZNmcBdITRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787659714; c=relaxed/simple;
	bh=ZeNPcdIZB8aABEzJy+zIE7FYEyPIEZuqGORtabxw9Kk=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=tHPMXvxvliiISv1ZGZmUv32WiJUYUqLDohk6Y5uMc0JDITOrenHO47kQOkE8JeTS2IT467Z5YQbx9IBQdD938nDHLvWOOxgUerad7S52FsuKick3cCYXdfOy+cVY0p3IbQkiNDt4d3OICn9xsq5d0R8gVZS/JpOSWACuew7kHOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=MAYP3Xs9; arc=none smtp.client-ip=203.205.221.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="MAYP3Xs9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1787659707; bh=0cFDTSJaMeIviR0aR+tPxXkINCW+v1H/8v4vWD+Xnm4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MAYP3Xs9rcVQEM8Ugyo6j5GmPu/YLtqhZ5FeztL81H0BsEYayRU026BLFrpVQpAgf
	 hj8PCwiuUy2KDcNLvDpV/2UfyP0T1Z8m18DMbc9HH+hp+32VPRkwmS/fDlmaycB96P
	 nmJcOZ+ZvudXgiS4oMe6UkW9JISqlBnDpJMjNpLg=
Received: from lxu-ped-host.. ([111.198.231.89])
	by newxmesmtplogicsvrszc56-0.qq.com (NewEsmtp) with SMTP
	id 2173B26D; Tue, 25 Aug 2026 20:08:23 +0800
X-QQ-mid: xmsmtpt1787659703t2d03nyko
Message-ID: <tencent_9E794E6CE82D396E9894ECEBFAEDE6CE7C0A@qq.com>
X-QQ-XMAILINFO: Nmowf1D3R0DyPDXCWkfiMxGs0ROOBujguCzlc5VUhOImgpdt7Q3QoqWQE9OQw0
	 OdIDxS7BOCjENpCgyo2z0gDsCCKuTEXLyFLdQWB8dJQhl/pLXhfN3F9aCqPowRb1QQ94CbekZxdK
	 E1sHDVxrypcxI5XmVsZn1+Cu4yf8Nd/nX+AWYBCxtrIM2Xt2tjiLePYoCWXceJOBc8WmYt/De7i7
	 Qcpv2Pct+K1bT2VSpmwW85+x1YFwT4bxp7bKmcTdnTXYijAMSGtTmKhxy5ifzAc3Xj9WhRJtF3qo
	 7NxP2Osm8NckOkBhH26h5CCRZJe207aVgfdPR/WFPDKpHKHJ1LECH+k/9rUs13OkvxSsOk3GvbON
	 ZfrrUksS/7/CdB2C/GtnB7p/cnhyC382+9CROINChfFJ6TkiXrhYge7PyqiEyIMV6HWCYGmzSdDP
	 RnM3bj1j3FxzKpiOe6I37SeMikVEGSf1YhOfPw68zeB6jS7iTEydJex0aqV3MooZQJIYfxHJi4Pv
	 AfhbXXMGDM3m/gT3Oo+kDRlvju6s6c84IO4tYm/+cVzBeXI4yF+GtHubekjdMemUy26LM4eGIFqb
	 zLrUTp0IVtqDd4vF4ZAMp7M6wEJw6bdNcwxSlf2/v3W1CX1+c5rEHi6dzNVnPZaxxEjzD+zzQISW
	 5rjJKiAel84nAuk/opngsvG0lvs/Kw62j3GypZnwFxPKNpxV/Jsx5MV6wwLUK7gyApQPdLVqsUsK
	 bsuVQJX8ICcsVS/tNotILR7q395AirUmKenB4ssUPDKQmSTW3Fr3jxvCZUTvjZz7S9FDzH3EOBm8
	 FDHHTi4P2zmASCv9pAQQJZ0xuGc86thUeAkgTVftilwdpXfx+a+m0lYNk1zTZkV0kf5Ya3fsFM4H
	 ZylvYg2cuyQS5dcCEU6alBFAE+r61ciaN0eBiev1Rh96KGUL6D6oNES8i0GOzN6RVCDahAoWBlad
	 vCLZrvu1X0WHTIx3rPD9d82a6AG+pR30Le7CIvexkN7VuM59UD+ddLWzd1LIII1TfU7scJXADDEK
	 iB1eKZDHMAVO1NzPhWsBNxtD6AznqoolKkYlvCHPXTpASnZYtpfXQLlYxQezyqaGnReUBm8phOkZ
	 QaGD5SKZ86UGAR2+E=
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
From: Edward Adam Davis <eadavis@qq.com>
To: jhs@mojatatu.com
Cc: Po.Liu@nxp.com,
	davem@davemloft.net,
	eadavis@qq.com,
	edumazet@google.com,
	horms@kernel.org,
	jiri@resnulli.us,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	syzbot+0054fed3dc9085390f51@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH v2] net/sched: act_gate: Limit the max value for cycletime
Date: Tue, 25 Aug 2026 20:08:23 +0800
X-OQ-MSGID: <20260825120822.64825-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CAM0EoM=+X_aiWqmfOETA+NJr1kT8_T6rK1_dj-topdzxRAS6+g@mail.gmail.com>
References: <CAM0EoM=+X_aiWqmfOETA+NJr1kT8_T6rK1_dj-topdzxRAS6+g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 25 Aug 2026 05:31:28 -0400, Jamal Hadi Salim <jhs@mojatatu.com> wrote:
> On Tue, Aug 25, 2026 at 5:01 AM Edward Adam Davis <eadavis@qq.com> wrote:
> >
> > On Tue, 25 Aug 2026 04:25:04 -0400, Jamal Hadi Salim <jhs@mojatatu.com> wrote:
> > > On Sun, Aug 23, 2026 at 12:07 AM Edward Adam Davis <eadavis@qq.com> wrote:
> > > >
> > > > If the user passes a cycletime value of 0xFFFFFFFFFFFFFFFFULL,
> > > > an overflow occurs during the assignment of cycle in gate_timer_func():
> > > >
> > > > cycle = p->tcfg_cycletime; // overflow, cycle = -1
> > > >
> > > > Since the local variable cycle is declared as ktime_t (i.e., s64),
> > > > the assignment overflows.
> > > >
> > >
> > > Review the sashiko feedback. At least two of those concerns look legit
> > > and need to be addressed:
> > > 1) complaint about timer disarm on replace 2) INT_MAX being too narrow
> > I haven't received any feedback regarding sashiko, and I didn't quite
> > understand the points made in item 1); could you please provide more
> > details?
> 
> You should always look at patchwork for reviews from the AIs - i just
> happened to have cycles and peeked and even my responses are best
> effort. Some maintainers forward AI reviews on a best-effort basis
> (Jakub forwarded you the v1 review), so you may end up getting radio
> silence if nobody has time. So, going forward, the first line of
> defense is to look at patchwork 24 hours + after you post your patch.
> Address those by sending a new version or rebut them on the list.
> > Regarding item 2), if INT_MAX is too narrow, do you have a suitable value
> > to recommend? S64_MAX?
> 
> Handwave: The safe bound is one that keeps base + cycletime <= KTIME_MAX.
> To be verbose per sashiko:
> cycletime is an unrestricted NLA_U64 consumed as ktime_t (s64). A 200
> s cycle time does not overflow any s64 arithmetic, but your v2 rejects
> it. tdc test a721
> (tools/testing/selftests/tc-testing/tc-tests/actions/gate.json) uses
> cycle-time 200000000000ns and expects success; your v2 breaks it.
> sch_taprio uses INT_MAX but its semantics/tests differ. S64_MAX is the
> actual overflow boundary (U64_MAX is what makes the s64 go negative);
> but even S64_MAX + a non-zero basetime wraps in base + (n+1)*cycle
Got it, thanks.

BR,
Edward

