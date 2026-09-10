Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79B2748CD54;
	Thu, 10 Sep 2026 14:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789050239; cv=none; b=jaeQVgOMHeh9Z+U/cugLR3LxxyrR29S7R3aFLwnPb2t9doRQjy8SZfTjjVMqbizV22HIQXE78PLwq3Q9EM+9+k+a8LyHZAVbs6cqDtwXCXNoipGWi4/NJvswztBv8GXfMFBMNWYQM6hwQGEYb+/jFY2cqMnxA8gVFql8qsxTkUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789050239; c=relaxed/simple;
	bh=M/qvUC17dZYh3NA7ctB7iGR4URUPLBoli4cyAFwHf/U=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=baLZXzEB9dlCMKCkj+0i/igZ0P9jonqQYK0TziXL7eXE4kwOBDOq5ClIy9v5hX1T1C8NgI3VO7N8sWicdrHEGRFiQ6nSPK5ixe86kJUbn7JxwxgOGsWBGh2NlFyw6UxX0n9FkgknZpU+/s5PRWll1+1qFizliRuD3OZutavXWd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=r+8TxNQ2; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="r+8TxNQ2"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68ACVbVu2925749;
	Thu, 10 Sep 2026 14:23:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=OHNPGY
	GWxh+3J5U8VFWodv4712DQuRsZ8pLXZk91/oI=; b=r+8TxNQ2BcAomOfs452OYZ
	/V7WFS81TldNEIjZE4z73q/Ot2bhwpARpnDt53owV2Ba4fd9fJ7SYfKwnrf0+Q/S
	FvJiZ2fBm7vI0/DZqM8Lq+azM+WrPgk+lxaEHbz/uBb5OH/Dtb6HaesjKhC7cTa2
	/4DRo5W/TFiuGah6DlghQAUhk3MZcNmJMuFWAtGyA0MG8bm6M9LBnOT4QvnE3VPy
	6xvAYUR9VFn7XPHvQnaptrA95i4FaRyQVrg71wNZ8fRrtPE46VTU7pKGN8Cj8XTk
	XI8hfD8cnn5cus9xqymVd6PF43Bm0WOgL8TRfy7aWL8o/b5XXaZZSX8al6gzJ8SQ
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gkd8sw3jp-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 10 Sep 2026 14:23:46 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68ADAQHq072089;
	Thu, 10 Sep 2026 14:23:46 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gkvnrgfub-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Sep 2026 14:23:46 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68AENjiT34276008
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Sep 2026 14:23:45 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 56B515805F;
	Thu, 10 Sep 2026 14:23:45 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A8D205805A;
	Thu, 10 Sep 2026 14:23:44 +0000 (GMT)
Received: from li-4c4c4544-004d-3310-8032-b2c04f503334.ibm.com (unknown [9.61.100.247])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 10 Sep 2026 14:23:44 +0000 (GMT)
Message-ID: <9d0cb973a47adc14ff7b248ea8fe58a735b8cd11.camel@linux.ibm.com>
Subject: Re: [PATCH 1/1] bonding: crypto offload enabled, non-offload slave
 failover, rekey failed
From: David Dai <zdai@linux.ibm.com>
To: Hangbin Liu <hangbin.liu@linux.dev>
Cc: jv@jvosburgh.net, andrew+netdev@lunn.ch, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        pradeeps@linux.ibm.com
Date: Thu, 10 Sep 2026 09:23:44 -0500
In-Reply-To: <aqJkO4-49YtW4NxF@fedora>
References: <20260903220123.475685-1-zdai@linux.ibm.com>
	 <apphLbjfmRYknVNh@fedora> <aqJkO4-49YtW4NxF@fedora>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEwMDE2OSBTYWx0ZWRfXx2DZMemcb9iI
 o0C7VTvogwjexgvaHO8WkcYylQVn0od1KG2KvoxZVaaoHjMfI5mqQtz2JfTrZMbro29sGs50pZh
 b0Q+YQBPM9mVlJdUpZLK+3ayqZ8AIog=
X-Proofpoint-ORIG-GUID: Kw6Q0KM8dwkd40g2RR2qopdclGJKrxep
X-Proofpoint-GUID: -lG-uQA9_Nz0jY5a33JJ9yBCB9o1H-TF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEwMDE2OSBTYWx0ZWRfX5n6xGycp/4E/
 c0k469REYE9P0asNKMUgESPa+tt7PQb8U0jAF5TheK53jfMj1PAm3lFmmD18xEz4TciJsmoy+dt
 nHvtpC55sBlfirXDZCGBsI0e+sNfbJXyjTPbojx1y9wOKdZqiE2mHVqwqZYelOWC7cakcHIX3hu
 mk/9WeD/MkRcl5hIBXAWy3s9UmAFWy8iLllXryXbvrKfIRB3CuU7cbLKHw0yVu0KNB7AELxCWhI
 RYw6CHiQfO4po9derlDMVn2nuah2N751A44nzj4GaXDKG+KsyDFyXKkHrYl+wfrYuhlhzalGkHC
 b34MbZy2s5ouMUVC+xGV5zTJjC7rOiVSlSxpkrQHgNtxexC+ljFjG+dwDBzI0zhhH0fSk1FC0mA
 F8JZ5PWyJoulCfAu2t+nbNiZBd1tz4PyB381YKZpNblBYGc0+21HZMYe7sWhUX29Fu9N/JYfhRO
 ZWF9viNtArBKsXiQEeA==
X-Authority-Analysis: v=2.4 cv=PIGaavqC c=1 sm=1 tr=0 ts=6aa2bd73 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=QA8Y5dmSeMjSImS8ZE0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-10_04,2026-09-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 bulkscore=0 adultscore=0 suspectscore=0
 lowpriorityscore=0 impostorscore=0 clxscore=1011 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609100169

On Thu, 2026-09-10 at 16:03 +0800, Hangbin Liu wrote:
> On Fri, Sep 04, 2026 at 02:11:57PM +0800, Hangbin Liu wrote:
> > On Thu, Sep 03, 2026 at 05:01:23PM -0500, David Dai wrote:
> > > Create a bonding device (i.e. bond0) in active-backup mode, 2
> > > slaves.
> > > Active slave: offload capable interface (i.e. eth1), primary
> > > interface.
> > > Backup slave: non-offload capable interface(i.e. eth2).
> > > Configure strongswan service swantl.conf child SA "hw_offload =3D
> > > crypto"
> > > Start strongswan service
> > > IPSec Crytpo Offload is enabled on top of bond0. i.e.=20
> > > ip xfrm state |grep offload
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 crypto offload parameters:=
 dev bond0 dir out mode crypto
> > > 	crypto offload parameters: dev bond0 dir in mode crypto
> > >=20
> > > Active slave eth1 takes adavantage of IPSec Crypto Offload
> > > capability.=20
> > >=20
> > > If active slave eth1 is down for any reason (i.e. eth1 link
> > > down):
> > > ip link set down dev eth1
> > > non-offload capable interface eth2 failover to becomes active
> > > slave.=20
> > > The existing SAs can continue use software IPsec after failover.
> > > Traffic still keeps going properly.
> > >=20
> > > However if eth1 link had not recovered yet, strongswan service
> > > does
> > > new child SA rekey, or uses swanctl command to do new child SA
> > > rekey,=20
> > > it will fail because active slave eth2 doesn't support crypto
> > > offload.
> > > In bond_ipsec_add_sa routine, it returns -EINVAL now, which is=20
> > > treated as fatal error by xfrm_dev_state_add routine in kernel
> > > xfrm.
> > >=20
> > > To make the non-offload active slave survive the child SA rekey,
> > > need=20
> > > to make bond_ipsec_add_sa routine returns -EOPNOTSUPP instead
> > > when=20
> > > active slave doesn't support IPsec Crypto offload, the xfrm will=20
> > > gracefully fallback to create new SA using Software IPsec.=20
> > > Network traffic can keep going.
> > >=20
> > > After offload capable interface eth1 link is up, becomes active
> > > slave,
> > > next time strongswan child SA rekey will create a new SA which
> > > enables
> > > crypto offload again.
> > >=20
> > > This way, network traffic is never interrupted, always keeps
> > > going.
> > >=20
> > > Signed-off-by: David Dai <zdai@linux.ibm.com>
> > > Tested-by: David Dai <zdai@linux.ibm.com>
> > > ---
> > > =C2=A0drivers/net/bonding/bond_main.c | 2 +-
> > > =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
> > >=20
> > > diff --git a/drivers/net/bonding/bond_main.c
> > > b/drivers/net/bonding/bond_main.c
> > > index ef9eb0c53c66..79fc892dab07 100644
> > > --- a/drivers/net/bonding/bond_main.c
> > > +++ b/drivers/net/bonding/bond_main.c
> > > @@ -490,7 +490,7 @@ static int bond_ipsec_add_sa(struct
> > > net_device *bond_dev,
> > > =C2=A0	=C2=A0=C2=A0=C2=A0 !real_dev->xfrmdev_ops->xdo_dev_state_add |=
|
> > > =C2=A0	=C2=A0=C2=A0=C2=A0 netif_is_bond_master(real_dev)) {
> > > =C2=A0		NL_SET_ERR_MSG_MOD(extack, "Slave does not
> > > support ipsec offload");
> > > -		err =3D -EINVAL;
> > > +		err =3D -EOPNOTSUPP;
> > > =C2=A0		goto out;
> > > =C2=A0	}
> > > =C2=A0
> > > --=20
> > > 2.55.0
> > >=20
> >=20
> > The patch looks good to me. I am just not sure whether we should
> > shorten
> > the description. Let's wait for others' opinions.
> >=20
>=20
> BTW, please add
>=20
> Fixes: 18cb261afd7b ("bonding: support hardware encryption offload to
> slaves")
>=20
> if there is a next version.
Thanks for your comment!
I'll add the Fixes line in my next v2 patch submission.
