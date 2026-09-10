Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 399CE257844;
	Thu, 10 Sep 2026 22:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789079438; cv=none; b=axB9HVoWFBSwtkHdfzVu9K+xnJSoKR1jMYA69jpbM8DhK1uSuU1OGgKQdY0LT+nsiuBtHhMxrhJri0F0ktA0B/iT6MGh4vw2wDnisPv5ymYPiiHWS1QkltmtHaQdcfv1HM1G/qKS+4HNxPs9EWANSJ3+NvijlRU6jQq5Sazlp1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789079438; c=relaxed/simple;
	bh=AoWvKjisLIiJf0U5M9MAJd7rMtD8WPpFHN+nd5P9bfs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ScJ02mzU4VRXBdiruf5yR+ZqKYu/vgw8VtiuYOqp98L7Bb6LNZS12AbQymxTA1ZvGEfqMJ7J7QChylE8ZubSfl5d43ELaJIOrbytV3dfRa+spSn1MfiJC4G849yrcjyXCiYiJXUzOdFrc6hm2SZcAAq0618X8+ZnFMFrhAHB2Aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=C1LiFC96; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="C1LiFC96"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68ALVfo83936979;
	Thu, 10 Sep 2026 22:30:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=AHqrWZ
	9Kyh82HxuHon8H8Cx4A1H5TtYfxnA98OPF5H0=; b=C1LiFC96/VYKQ+CekdKLAM
	ynISZd3szbP13NDU+FaJCiI74iN1znPeqmiC7+5sCDcwc7+RAWl2EbtML9iuwoIO
	UcqpbDq0x0NmmI+ISrhSTvizI9anIOZDZpGw+wsNogRXaklzqK59l9Edm57pVq5P
	zSDiu1NXGbWrglJ93uIduFMMElVVFQI3gtLhUEQPV/lQKa3Y22juZ0Q8yxf51UWx
	OpAzOwwGzAQgu8NskehT/5u1pRRS1IR58B8e6ciKVDKwN36XhK7fYOWJoESEEiX4
	yCJ0TpwMxDkeDKDnenp9tE06PrsWas7elGpfYK3hWP76yb0vodjAKXFR36kCfDZg
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gkd8s7u8n-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 10 Sep 2026 22:30:23 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68ALZ1H8654837;
	Thu, 10 Sep 2026 22:30:22 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gkvq2tyhq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Sep 2026 22:30:22 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68AMUMR529950650
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Sep 2026 22:30:22 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0D51E58054;
	Thu, 10 Sep 2026 22:30:22 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 415315803F;
	Thu, 10 Sep 2026 22:30:21 +0000 (GMT)
Received: from li-4c4c4544-004d-3310-8032-b2c04f503334.ibm.com (unknown [9.61.155.185])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 10 Sep 2026 22:30:21 +0000 (GMT)
Message-ID: <2fbb384517e3c4183bf571a1e79e6fd6460aa393.camel@linux.ibm.com>
Subject: Re: [PATCH 1/1] bonding: crypto offload enabled, non-offload slave
 failover, rekey failed
From: David Dai <zdai@linux.ibm.com>
To: netdev-bot+sashiko@kernel.org
Cc: jv@jvosburgh.net, andrew+netdev@lunn.ch, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        pradeeps@linux.ibm.com, hangbin.liu@linux.dev
Date: Thu, 10 Sep 2026 17:30:20 -0500
In-Reply-To: <178900217942.219967.7472232136755764721@kernel.org>
References: <20260903220123.475685-1-zdai@linux.ibm.com>
	 <178900217942.219967.7472232136755764721@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: PDOg6eVa6_DJGcC_mRxcWzghvZukMgkd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEwMDI3NiBTYWx0ZWRfX/dQl60eBDaI/
 cV7k6EM3fPOQrNtq+wZCKvtQ/NxdiqGgsX9FdrXF5dV1dwSG9RCa4WsS4LVGg4FaEJeiVZO7s7h
 aN6JJtaX8icqotfzc7mKP8OsfBVmS+U2AQDXJ2/rKlQmZDMMwT1R3fbEoJ8mS377yCedZcVVEOp
 rPfM1pr1nRvVI+8nKQ6bcH+ZKTOCFwdIw5etBuP/8xxA/ERfccZoaHnc8uTwRs7gAdElsCi7uRA
 SU2i8kHnyVq3EUFTHLlV+w03QtFXwHuOtQ+PUByW25zWigTn/IwoFNSFNk/1m2YT+tBH6aDynva
 tdb/X89RB+Lus73o6O7eeRlvklfHZ0lEzXYVKCiCmXEqLgIPaP7rOH1/AaTnQNfUjfXm/ir7UQe
 /qafmemej8s5iscTfewfIazQJPDTGu65u5TH6WpXxhX5bhGE6UmWsj4W7+v/oqV1zpJjiOYgp/i
 zuzoY/ulK+JGoLevkIQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEwMDI3NiBTYWx0ZWRfX5yy3DvXadc1P
 mIYF2AnImWqKVxQUJlnThIhq9CpxYoeL31UW2wMYKRnsxz4CfWUwe/XEG+KOnvWlKpeTQpvtfqG
 rm2GkVnk1fSVWvE603HZrI0kHyPQXT8=
X-Authority-Analysis: v=2.4 cv=MpXHeGae c=1 sm=1 tr=0 ts=6aa32f80 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=aV1o0kcCvRjV7lMpiWQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: qH2_rEvxOxihrWLzg3cnuTuxW0Owr0w9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-10_07,2026-09-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 priorityscore=1501 clxscore=1011 impostorscore=0
 adultscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609100276

On Thu, 2026-09-10 at 01:02 +0000, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential
> issue(s) to consider:
>=20
> Critical: 0 =C2=B7 High: 0 =C2=B7 Medium: 1 =C2=B7 Low: 2
>=20
> - [Medium] Incomplete error-code mapping in `bond_ipsec_add_sa()`:
> the
> =C2=A0 sibling failure path that fires when the bond has no current
> active=E2=80=A6
> - [Low] Missing `Fixes:` tag / unclear target tree for a user-visible
> =C2=A0 behaviour fix.
> - [Low] No in-tree test covers the behaviour this patch introduces.
>=20
> --
>=20
> bonding: crypto offload enabled, non-offload slave failover, rekey
> failed
>=20
> This changes bond_ipsec_add_sa() to return -EOPNOTSUPP instead of -
> EINVAL
> when the current active slave has no xdo_dev_state_add, so that xfrm
> falls
> back to a software SA instead of failing the SA add outright.=C2=A0 The
> reported
> symptom is a child SA rekey failing after failover from an offload
> capable
> slave to a non-offload capable one.
>=20
> No Link: tags were present in the commit header.
>=20
> > diff --git a/drivers/net/bonding/bond_main.c
> > b/drivers/net/bonding/bond_main.c
> > index a9bff7663eeca..de2489c3d9bf2 100644
> > --- a/drivers/net/bonding/bond_main.c
> > +++ b/drivers/net/bonding/bond_main.c
> > @@ -490,7 +490,7 @@ static int bond_ipsec_add_sa(struct net_device
> > *bond_dev,
> > =C2=A0	=C2=A0=C2=A0=C2=A0 !real_dev->xfrmdev_ops->xdo_dev_state_add ||
> > =C2=A0	=C2=A0=C2=A0=C2=A0 netif_is_bond_master(real_dev)) {
> > =C2=A0		NL_SET_ERR_MSG_MOD(extack, "Slave does not support
> > ipsec offload");
> > -		err =3D -EINVAL;
> > +		err =3D -EOPNOTSUPP;
> > =C2=A0		goto out;
> > =C2=A0	}
>=20
> [Severity: Low]
> Should this carry a Fixes: tag, and which tree does it target?

Yes, I need to add this line when I resubmit it in v2 with:
Fixes: 18cb261afd7b ("bonding: support hardware encryption offload to
slaves")

>=20
> The change fixes a user visible failure (child SA rekey is rejected
> while a
> non-offload slave is active), so it reads like a net fix rather than
> a
> net-next cleanup, but neither a Fixes: tag nor a [PATCH net] /
> [PATCH net-next] marker is present.
>=20
Yes, it's a net fix. I need to use this in the next submit:
[PATCH net v2 1/1] bonding: crypto offload enabled, non-offload slave
failover, rekey failed

> git blame on the changed line at the baseline points at
> 2aeeef906d5a52
> ("bonding: change ipsec_lock from spin lock to mutex"), which only
> moved the
> line.=C2=A0 The enclosing capability check goes back to 18cb261afd7bf5
> ("bonding: support hardware crypto offload") by way of
> 907ed83a7583e8.=C2=A0 Would
> one of those be the right anchor for stable backports?
>=20
> Also, the Tested-by: line names the same person as the Signed-off-
> by:.=C2=A0 Is
> that intentional?
>=20
My original intention is to imply this patch has been tested before
submission. So it was intentional. If it's redundant, I can remove it.

> [Severity: Medium]
> Should the sibling "no active slave" path in the same function be
> converted
> too?=C2=A0 Just above this hunk, bond_ipsec_add_sa() still returns a fata=
l
> errno
> when there is no current active slave:
>=20
> drivers/net/bonding/bond_main.c:bond_ipsec_add_sa() {
> 	slave =3D rcu_dereference(bond->curr_active_slave);
> 	real_dev =3D slave ? slave->dev : NULL;
> 	netdev_hold(real_dev, &tracker, GFP_ATOMIC);
> 	rcu_read_unlock();
> 	if (!real_dev) {
> 		err =3D -ENODEV;
> 		goto out;
> 	}
> 	...
> }
>=20
> The consumer only whitelists -EOPNOTSUPP for the silent software
> fallback:
>=20
> net/xfrm/xfrm_device.c:xfrm_dev_state_add() {
> 	...
> 	if ((err !=3D -EOPNOTSUPP && !is_packet_offload) ||
> is_packet_offload) {
> 		NL_SET_ERR_MSG_WEAK(extack, "Device failed to
> offload this state");
> 		return err;
> 	}
> 	...
> }
>=20
> and xfrm_state_construct() then kills the freshly allocated state:
>=20
> net/xfrm/xfrm_user.c:xfrm_state_construct() {
> 	...
> 	err =3D xfrm_dev_state_add(net, x,
> nla_data(attrs[XFRMA_OFFLOAD_DEV]), extack);
> 	if (err)
> 		goto error;
> 	...
> error:
> 	x->km.state =3D XFRM_STATE_DEAD;
> 	xfrm_state_put(x);
> }
>=20
> So with crypto offload requested and -ENODEV returned, the NEWSA
> still fails
> hard and no software SA is created.=C2=A0 That is reachable when every
> slave is
> down, in the window where bond_select_active_slave() has installed a
> NULL
> curr_active_slave, or trivially with a bond that has no slaves yet:
>=20
> 	ip link add bond0 type bond
> 	ip xfrm state add ... offload dev bond0 dir out
>=20
> Given the commit message says "network traffic is never interrupted,
> always
> keeps going", does the -ENODEV case leave the same failure mode
> reachable in
> a narrower window?
>=20
Before my patch, bond0 had ipsec crypto offload enabled,
non-offload capable eth2 failover to be active slave, the ipsec traffic
will use SW path, no interruption, no problem.
However when strongswan service, or swanctl tool does child SA rekey,
it failed.

My patch deals with the child SA rekey failure issue when non-offload
capable eth2 is active slave.
By changing return code from -EINVAL to -EOPNOTSUPP, xfrm will then
create a SA without crypto offload when non-offload capable eth2 is the
active slave.
To keep the traffic going, at any time, either one of the slave
(offload capable interface eth1 or non-offload capable interface eth2)
is up at any give time.
So real_dev is a valid pointer. Traffic is not interrupted.

I need to delete the last line in my v1 patch comment to avoid
confusion:
"This way, network traffic is never interrupted, always keeps going.".

W.r.t. "ip xfrm state add ... offload dev bond0 dir out",
my understanding is child SA created by ip xfrm command will never
expire. There is no need/way to do child SA rekey either.

W.r.t. the sibling check that real_slave is NULL condition,
If real_dev is NULL, no slave is available to handle traffic.
In my opinion, it's a fatal error. Setting err to -ENODEV is correct.
If it happens, child SA rekey should fail hard.

> [Severity: Low]
> Is there a plan to extend the existing selftest to cover the new
> fallback?
>=20
No, not in this patch submission.
The current bond_ipsec_offload.sh uses "ip xfrm state add ..." to set
child SA keys, which will never expire. ip command can't do child SA
reky.

This patch deals with child SA rekey when non-offload capable interface
eth2 is the active slave, which requires ipsec applications like
libreswan, strongswan, etc...
Different linux distros have different ipsec applications.
If I can find a universal way to be tested in the selftest later,
will address it in a separate patch.

> tools/testing/selftests/drivers/net/bonding/bond_ipsec_offload.sh
> enslaves
> two netdevsim ports in setup_bond():
>=20
> 	echo "0 2" | ip netns exec "$ns" tee
> /sys/bus/netdevsim/new_device >/dev/null
>=20
> Both provide xdo_dev_state_add, and the failover leg only moves the
> active
> slave between those two before re-running test_offload().=C2=A0 No leg
> enslaves a
> veth or dummy device, fails over to it, and then adds a new SA to
> check that
> it is accepted with software fallback.
>=20
> As it stands the script passes identically before and after this
> change, and
> would keep passing if the fallback later regressed back to a hard
> error.
