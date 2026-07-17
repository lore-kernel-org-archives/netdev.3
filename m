Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27AC6221FCD;
	Fri, 17 Jul 2026 07:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.59.177.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784271839; cv=none; b=uKejoMXd+qasi1xVucrIwtf9CGrtUU1JwMRnqTMtpKGq6M80+NvRMi0+jJMk2FaQ37xQBw54oCHpVLinwj4Vl6OKq7R0hhb/RA5IbeXBPuICYbeIUmth9ipcN4X8TqYzaexc7BtsNKgpAbIojQ4CXuGgEAAl3CAAurh9ArMoH8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784271839; c=relaxed/simple;
	bh=pSnCaz9RCvX0fuz9OY7azdk2w53cF7Iiyc5zPTeU+s8=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=paicu50tV3l8y1GIAwjIKjgJhkuZagnB2BaKeHFZ7lTu1T5XYWWR7bdJfYkoTI4zdUeACaO1gLVGFjcdm1j9oQkBwLZXg296A/S9MhDljnEMh24LcSe18PfkE3X+lqsXkID9UxDKG3t0G9+AysfPhaqTfmysNYLVx5C61JHQb8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=52.59.177.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid:ivesync10t1784271797t5fd06b67
Received: from 3DB253DBDE8942B29385B9DFB0B7E889 (jiawenwu@trustnetic.com [115.200.247.46])
X-QQ-SSF:0000000000000000000000000000000
From: =?utf-8?b?Smlhd2VuIFd1?= <jiawenwu@trustnetic.com>
X-BIZMAIL-ID: 4188014338873093882
To: "'Coia Prant'" <coiaprant@gmail.com>
Cc: "'Andrew Lunn'" <andrew@lunn.ch>,
	<kuba@kernel.org>,
	<davem@davemloft.net>,
	<edumazet@google.com>,
	<pabeni@redhat.com>,
	<andrew+netdev@lunn.ch>,
	<robh@kernel.org>,
	<krzk+dt@kernel.org>,
	<heiko@sntech.de>,
	<netdev@vger.kernel.org>,
	<linux-rockchip@lists.infradead.org>,
	<devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	<linux-phy@lists.infradead.org>,
	"'Mengyuan Lou'" <mengyuanlou@net-swift.com>
References: <20260714191341.690906-1-coiaprant@gmail.com> <20260714191341.690906-7-coiaprant@gmail.com> <464cbdf3-2e9e-43ea-b30a-75b3d1b8a188@lunn.ch> <CALj3r0jdkDEjpO+7NOTGs+wgukKvD=fzFn4ewpurxxPswCE5GA@mail.gmail.com> <000c01dd1593$2ac0b0f0$804212d0$@trustnetic.com> <CALj3r0hH=mF+8oVbisoECYo6HRuSdfSt_nuhFunHowyPsw2srQ@mail.gmail.com>
In-Reply-To: <CALj3r0hH=mF+8oVbisoECYo6HRuSdfSt_nuhFunHowyPsw2srQ@mail.gmail.com>
Subject: RE: [RFC PATCH 06/10] net: pcs: xpcs: improve SGMII AN state handling for Rockchip RK3568
Date: Fri, 17 Jul 2026 15:03:16 +0800
Message-ID: <000d01dd15ba$574a4b50$05dee1f0$@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Content-Language: zh-cn
Thread-Index: AQLtuIytmYACIt0zp727MFXQnXwl3AG2MkWBAlDURYICTkKn3QKRc164Ap6/3qmz89AeoA==
X-QQ-SENDSIZE: 520
Feedback-ID: ivesync:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: NPoj0uw5JpnxntbZJX9gsDcTXDlzIBuDXxSu1uSICFWFCIpWNzrlh6LF
	tvW1sG3w8VGEqZ3dtgzpFHL01aVDQHMP/V/+6Aw2Ht7mPzdvJm/rr9iqsAVdi8+fBujcPbs
	H/r4o26fjNBHcHnh2SNpe6FnSjii/d9cMA/ZqKZhF2F0U8MsIK8wHnqDNcpJnQJW/OclYkR
	0iwVsl1bA5zgiOrCQNj4Y6c0fybD2DLU2yz2jrgY2cpwY9motJE30Dphs+fWC2T7pZdz127
	ts9rZsr9VA6NBGdCYD1hL00Rm6oalhh4RRMqhfaI3PwnPiWeNQQMldqiZPTbVEufNhHMNJ3
	xRbmlwA7ydgRfU5Lz7cp0nY1T4rpDxNYuSEVwoUFRYkvj2LhRR8iAET8oAclpnNXfj/HwjR
	eP5k200eYqICvnVV4QWOBza42UliaJl5R56JSC/p1ObKTGWCOo9f+JqQsSlnAGqxIS5hcS9
	t8TNnklrto2RPuoYLxECaaO+KIuh9gtVK+yBKe3facXI9SuXh9i7krDfGtFqGmQIv0b0jy4
	5AC8aPxlHwZj36BWnVA54L4jsOJ1DDG6tuIiUnt0aPObblpCKPg6KMQR1TF4GJoZXPvazs2
	FnHN2+qb0g1DLQZkf1teneaU+Fts8pz+6oeQmayn2S+M7tZpDnKI0Gifg8tJ3/lWjL/aqPV
	DTITrrYFz/0SefqO3XJ+d8hDZuVnJfZlsGJgU/Gb6LDEGn82xnKfRG7DAMPnncdEeh8Uxji
	FEtlYeBGbrGIu5Ty2QAN4r+MBUsNuQ70OCffAHcceh+NeFYvU+7gMxOxjK99rlvotk60Pe1
	/JYYmteiwS4fLX9P4XJitIS+Og1gxKjUFgZTCk/VJaDe9qZTn7DtsoAlgqSeH1BwQu3mF13
	bo35UfOrMAep+rCJrQbf3q8BTet1+sOPtHLaNkVAyDRMsvRR5TNZJSborty74TMR+RAs+Yw
	Qe05C4XbjG2h3SXk2JFBxkHIGTof2OTyzxXRXgEI0RAcqCfwL8FzMLUvcYQMXFYIPI5oidG
	AKLd7Yy5m4+drbL9rvaOePSxmUXbr+14sS087rRbmaSGEYxQi9J1uGfmsgwSwOGUHwPmajc
	SCPQIfDSvUjeVK/wPvcryLcaXqkklnXKj21EGTyyDXOefXIqiai92ceWmq75ZP1/NFW+DdS
	B/1V
X-QQ-XMRINFO: Nq+8W0+stu50sE7OtKTvKJq3Dewzic457g==
X-QQ-RECHKSPAM: 0

On Fri, Jul 17, 2026 2:29 PM, Coia Prant wrote:
> Jiawen Wu <jiawenwu@trustnetic.com> =
=E4=BA=8E2026=E5=B9=B47=E6=9C=8817=E6=97=A5=E5=91=A8=E4=BA=94 =
10:23=E5=86=99=E9=81=93=EF=BC=9A
> >
> > On Wed, Jul 15, 2026 7:05 AM, Coia Prant wrote:
> > > Andrew Lunn <andrew@lunn.ch> =
=E4=BA=8E2026=E5=B9=B47=E6=9C=8815=E6=97=A5=E5=91=A8=E4=B8=89 =
06:44=E5=86=99=E9=81=93=EF=BC=9A
> > > >
> > > > On Wed, Jul 15, 2026 at 03:08:34AM +0800, Coia Prant wrote:
> > > > > Commit 2a22b7ae2fa3 ("net: pcs: xpcs: adapt Wangxun NICs for =
SGMII mode")
> > > >
> > > > You do not appear to Cc: the Wangxun NIC people. It would be =
good to
> > > > have there comments on this change.
> > >
> > > I apologize; the output from get_maintainer.pl is very long. =
I=E2=80=99ve
> > > heard that having too many recipients can cause the PATCH to be
> > > rejected by the LKML mail server.
> > >
> > > I have added Wangxun maintainer (Jiawen Wu =
<jiawenwu@trustnetic.com>
> > > and Mengyuan Lou <mengyuanlou@net-swift.com>) to the CC list.
> > >
> > > > > Fixes: 2a22b7ae2fa3 ("net: pcs: xpcs: adapt Wangxun NICs for =
SGMII mode")
> > > > > Signed-off-by: Coia Prant <coiaprant@gmail.com>
> > > >
> > > > Please don't mix fixed and new code. Is this a real fix? Should =
it be
> > > > back ported to stable?
> > >
> > > I am not sure if this is a specific characteristic of Wangxun =
NICs, as
> > > I do not have any available for testing.
> > >
> > > The behavior of the Rockchip DW XPCS IP core matches what is =
described
> > > in the commit message (even though phylink brings the link to down
> > > based on the phydev link status).
> > >
> > > This appears to be a bug (at least on Rockchip platforms) or =
Wangxun
> > > NICs features.
> > >
> > > However, I cannot confirm whether Wangxun NICs behave the same =
way.
> > > Therefore, I have kept their code as is for now.
> > >
> > > Could a Wangxun NICs maintainer provide some feedback based on =
testing?
> > >
> > > If we can confirm that this is indeed a bug, I can submit a =
separate fix.
> > >
> > > I would greatly appreciate it.
> > >
> > > Thanks.
> >
> > Hi Coia,
> >
> > I have tested this patch and it works on Wangxun NICs, thanks.
> >
> > The commit 2a22b7ae2fa3 ("net: pcs: xpcs: adapt Wangxun NICs for =
SGMII mode")
> > is too long ago for me to recall exactly what that thought was.
> >
> > The log shows:
> >
> > "On this device, CL37_ANSGM_STS (bit[4:1] of VR_MII_AN_INTR_STS) =
indicates
> > the status received from remote link during the auto-negotiation, =
and
> > self-clear after the auto-negotiation is complete.
> > Meanwhile, CL37_ANCMPLT_INTR will be set to 1, to indicate CL37 AN =
is
> > complete. So add another way to get the state for CL37 SGMII."
> >
> > I tried to reproduce this issue, but it didn't seem to exist.
> > In the current logic:
> >
> > link up -> read status from CL37_ANSGM_STS -> CL37_ANCMPLT_INTR not =
clear
> > link down -> read status from BMCR -> CL37_ANCMPLT_INTR clear
> >
> > It also works, although CL37_ANCMPLT_INTR is not cleared every time, =
and AN
> > restart is absent. But BMCR looks like it only wants to be return as =
0, it is
> > weird.
> >
> > So I think Wangxun NICs also can be applied to general code as well, =
for
> > getting state in C37 SGMII mode.
>=20
> Hi Jiawen,
>=20
> Thanks so much for testing and confirming that the patch works on =
Wangxun
> NICs. That's a huge relief.
>=20
> You're right to ask about the CL37_ANCMPLT_INTR clear and ANRESTART. =
Let
> me explain what I observed on RK3568.
>=20
> The key difference is that on RK3568's XPCS, we're working in the MAC
> side (TX_CONFIG =3D 0), whereas on Wangxun it seems you're in the PHY =
side
> (TX_CONFIG =3D 1). This is based on the commit 2a22b7ae2fa3 where you =
set
> TX_CONFIG =3D 1.

Get it.

>=20
> > However, I am wondering whether CL37_ANCMPLT_INTR clear and =
ANRESTART are
> > necessary.
>=20
> On the RK3568 (MAC side), according to the DesignWare XPCS TRM, the
> hardware behavior is as follows:
>=20
> - After a software reset (BMCR_RESET), ANENABLE is automatically set =
to 1
>   (the hardware reset value). So auto-negotiation starts =
automatically.
>=20
> - When the link is up, CL37_ANSGM_STS contains the negotiated =
speed/duplex
>   and the link status.
>=20
> - When the link goes down, CL37_ANSGM_STS becomes all zero, but
>   CL37_ANCMPLT_INTR remains set to 1.
>=20
> - Crucially, the PCS does **not** automatically restart AN when the =
link
>   comes back up. Without an explicit ANRESTART, the link stays down
>   forever.
>=20
> So on RK3568, the ANRESTART is mandatory to recover from a link-down
> event. Without it, the link never comes back up after a cable =
disconnect.
>=20
> In my current logic:
>=20
> 1. If CL37_ANSGM_STS has valid speed/duplex bits, report the link as =
up
>    and return.
>=20
> 2. If CL37_ANSGM_STS is zero but CL37_ANCMPLT_INTR is set, the link is
>    down. We clear the interrupt and issue an ANRESTART to start a new
>    negotiation.
>=20
> This works reliably on RK3568 in SGMII MAC side mode.
>=20
> Since you confirmed that the general code path also works on Wangxun, =
I
> wonder: does the ANRESTART also work on your side? If yes, perhaps we =
can
> make this the common path for all hardware, not just RK3568.
>=20
> If you can test the ANRESTART logic on Wangxun and it works, I'd be =
happy
> to submit a standalone fix that makes this the common code path.

I've test this patch with removing the restriction on Wangxun PMA. At =
least
ANRESTART logic does not have a negative impact.

>=20
> Otherwise, the current approach (skipping the ANRESTART trigger on
> Wangxun NICs in c37_sgmii_get_state) remains safe.
>=20
> If you're comfortable with the change, I'd appreciate it if you could =
add
> your Tested-by tag to the commit. I'll also make sure to include you =
on
> the CC list for any future revisions or related fixes.
>=20
> Thanks again for testing!

Thanks for the improvements.
Tested-by: Jiawen Wu <jiawenwu@trustnetic.com>


