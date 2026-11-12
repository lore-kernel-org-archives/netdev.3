Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794470670;
	b=nr7y6x6N36gBpmdZo07QV3X3ORFqYWZrVxBOEf/HJi/bQqd5OYfEeoIuK93Dzq6IGBZD
	 mvhg2W358TCY37shnaE3aKedhTOSv/P/modETUmeBqmdNpauP17AIbM4v7nq5sIs3lWml
	 ZRGSBmpofU2cU52lVPsFtQi4yMauvIg9qhME/s8W1HjsA24W8Yr+B4tcqLtTtmhVZ+phG
	 sHtu5UhAFXqz12X1C96BQBixEZstmcUpy7RtpMYYXd7fTJX0gSWcRNrLJBurOmw3y8pHB
	 Bv6+InIFed2LKIFVqxbc+mE+mWyB5pSl5PjI8/MRtA0c6WrLnNFBm6efsIIQVdk0MIA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794470670;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=FHdDkmm9qQ0sg08pi6fTx+CVVlQ6MmZ0qIxULw4ryr4=;
	b=wQ9AIKllTaEnHYNumma646asQlXbAEfOn7daORqP1plzjiGF7ieUaxtH7BiIyOwAE7jd
	 LY5gHiRkLr01kC7YsWsm1KHdryvNMBCw6TX6yr1vFKmeZw/7Mo7MC6j7topEd4bCbzkQz
	 LL8DLAXlBImLQqoq5bHKSvLKYSJBsWX8fyODOTCxibFYog2z5Opk+GEZc9nwst/zDWfoA
	 yLWe/U5GzuzyIIyP7Thd2lq8ifuS4VL7obX8ZBHnvw42A3QGl3M7ACaxBB8OZPkKctkIp
	 Qbx5QIf/lDQGtad+ra3GIj4i2Is+NXi5UAouU1BmHQFrijXxHsD8vX0XaKWdr0pavmA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b="dLgq8/0p";
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=CpqfoR36;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F65A606A31C
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 08:04:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0F65A606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=dLgq8/0p;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=CpqfoR36
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AC2ZhX83813258
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 08:04:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	FHdDkmm9qQ0sg08pi6fTx+CVVlQ6MmZ0qIxULw4ryr4=; b=dLgq8/0p1TeRQfqz
	aQablB4xWhDlJA86+7ncgunabxiAC77cnwbZBLuOhnjH6wjbpiENw5at63ktFsHM
	n8G0QoAh2QclxoWCxFTmML26ARntleTWTZnZsVSNyla/rQI/ABDZrmlVNjw2vapB
	tfg4HHUSvPLJPWp8aYGf6Duw798plsYL6b3Ca0s4BdrzvCkRHX0E9/45Z8AjGNMp
	NU+3iKJhurCWzNcGDoOjfS0IPCwhgG9mHYrXaM1kxfLXsvtK+ajV+Vrl3dSNeoF1
	RceIwJIZFLdKKhmGJf2T2jCSaDlsn1kHRd9ZvYqyI5GCpvBeiJ6/0HMgj/b63MCf
	yvZQUQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hvvw0jum3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 08:04:28 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93f2005ce21so75927185a.3
        for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 00:04:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794470668; cv=none;
        d=google.com; s=arc-20260327;
        b=TcarUZRv2yClt1wf4J2Kl9EYQQE3EjQiW66WNk2Fyc7AP+O6z0I88j76SLwAfNzgpG
         APR+cadt45TicGHqUHgKyb3cgXL8G8a/PYrzlOijHzeQy8Rv8cXVx8nUdNVg14UMM3rR
         d2r20veMzZ9x42nvSXs2NGsJaHaNcON2yq2CXaWJlGmPl3MDBSc7jB5eOpfSGRzsid46
         gk+wv2NAMGqhPQwgw31k40ttA+g+oOElAZWK0fPlhwlqn692j24Hy+4MV1rf1XCJZPbL
         ZPvPfDS7mCyT1jTGieQ9149shoMXPwVgcHsEW2K3hVYRxd5ysAmGZuE5y8kyiYB7mMB3
         PCLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FHdDkmm9qQ0sg08pi6fTx+CVVlQ6MmZ0qIxULw4ryr4=;
        fh=n1a33Lr2EAkk7MTMwRBwFlMO4Z0LkTQ74xs1Usi8uZo=;
        b=l46EV4+yir3SfEnX5/1w8+/AS4ds/PIAEpTJYRF2FzSwKMykJZQ3mB4VC69h3js4R8
         UyP2UmfJxUL8GMwwMFHCXgGoM6XyNVm9cMWIx5IHwJdJDMzMaljy7eFM83euIKc5sHin
         e4azvxxy9TZkKax2sPPdSqnHcFHkxkKmK3rgucLjEg8N34F5bMf4IgzbUnIEMBhOEk/d
         mAz/Y9oEiKaURL5At/VVQhzkXstyaJHd2eJ+jrjunG9IaHYyFA7JN+V8hYBnPwa+DwHX
         9DEhqfEm5nwPGRCSlJAqMOs18L40bYGutisXNwTd3E/91wTKVu4/NQtuDZ53hBXbIGNt
         6OpA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794470668; x=1795075468; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FHdDkmm9qQ0sg08pi6fTx+CVVlQ6MmZ0qIxULw4ryr4=;
        b=CpqfoR36InocL+dXtURO79yYV/G7f4D2RIZY5IWRqNFKT+JMxXlLFvezQUf4RIYMi3
         d5YiR4MYons3bEDzwiUY/E6DqDyOZb21/TYBi870TVpoNVaMekvS5mCX4z9VHGd6V96V
         n8MkrFhCm1GpbgPmCR7L/2u1sZ+1pGNrAOj/AelKZydaA9tPPMcoJAfo4BKWaIqoMyMJ
         Xck5U0wKX0rJ6UJ9maOGp9RN8O5FAJCQZcr5SwTu0kmQSBupCeUwVwxTPNcTj/5fKTWD
         VfB0QC10JTZCHZSg3BGyJTju3dUPTVgo8a3/aJD6167PR68zuNMiLgRbYeYpNqNpLy8g
         G2AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794470668; x=1795075468;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FHdDkmm9qQ0sg08pi6fTx+CVVlQ6MmZ0qIxULw4ryr4=;
        b=l6xYbATQowADWsGQb6DzSlS8N9+KNZ0RzlNOCbDbkorOt+t6VO8rrB/SvBz8MqcVt1
         TrcO3wjLBzTrVYXLKaJV5RR3xW677PmaSYX5TdiCvAaHbaF+JxwKsGCD41O3A993bBB1
         WMswRdX8VrV3sTm7/Dvg/4Pd2OmA0AlhaSkjTzwx7bJ5Bu7UEBkMjdc2C92wqoT5IqxK
         y4yb5pty3oxWuU8vGoR650H2/8p9HufKata+UlFwa4cp+DrLmZzpr8cDsDvUoqbU79pR
         vXR7t+OUfgkh5qk3bcr/ZVvKyl3S1wfWp/EzMmMHIlfQf6Lp4rUCpXrFZpd5N2IlFZBX
         Lsew==
X-Forwarded-Encrypted: i=1; AL+hErH9jSRV8LUDeWaIgRB6EKyPo27Z/v7oZ/uBoYYrkJJjBXSM4nQhX1QT4haXHL316xba0THYEYs=@vger.kernel.org
X-Gm-Message-State: APuU4Z9ZdJT1mc3333558SERJPo8rJCYaqvSEt1xTYrhPYWq8V+CNEJI
	+wf8f5Nq4KbQEl9J/U6TgNnrjJtZyBvym+xfk/+g52X33F+mjv/HBSLGirIGcrXiyn0emB5NSeP
	teotqUfrBFu4GbAK4A1XBPnR7Qpgz6Zn7iUUPW10NxU71fxjjxRI6aMFhW7rsl8q/7PAGhX2SLP
	Y2HS5g5O+Zo+s0y3HYcXdgCau3XCCe3nXUqw==
X-Gm-Gg: AYBFou0IjXSEc4GbgCMKYK5cqUOxWyzY3ue/fXVMt49FdXj2sZaV2Si0vD6zncIduIg
	c86WRLbmTvCuXOqEMcVYKoI0CSSzlV+134K/pDHcqv+8X3I15EXPbBtbp7CGn03sRfsMlu/u2db
	MG2wkKgJSk2BNzhT5FIxIOCdJdlf9UQ3M15fo7tboDSOPdSTspIr68xyaGfbDsD0rFohDs8QibP
	0Tqm753Cp3iqiYCHYjnb+ALhZlckv6HVAL8Y082+fuhJrwEdPBYiHEX+OARcmGzyzKJVOAzPcQ=
X-Received: by 2002:a05:620a:44c9:b0:93e:63fd:40a4 with SMTP id af79cd13be357-947affc0f53mr794132385a.55.1794470667741;
        Thu, 12 Nov 2026 00:04:27 -0800 (PST)
X-Received: by 2002:a05:620a:44c9:b0:93e:63fd:40a4 with SMTP id
 af79cd13be357-947affc0f53mr794127085a.55.1794470667208; Thu, 12 Nov 2026
 00:04:27 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261110043006.56681-1-mhun512@gmail.com> <20261111174106.09f639ca@kernel.org>
In-Reply-To: <20261111174106.09f639ca@kernel.org>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Thu, 12 Nov 2026 09:04:15 +0100
X-Gm-Features: AclHuK9VZabyLQbVKXJVYfq63j7iP9JQyT0QdrkFRZjz2E-OQ6UaYfMCOc0aFYE
Message-ID: <CAFEp6-1mdXkaH0gskH6VaW_xRjSPPP3VyfGbNpE1M3kDAbeDaw@mail.gmail.com>
Subject: Re: [PATCH net] net: wwan: mhi_wwan_mbim: disable rx_refill work on removal
To: Myeonghun Pak <mhun512@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Sergey Ryazanov <ryazanov.s.a@gmail.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        Johannes Berg <johannes@sipsolutions.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Ijae Kim <ae878000@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: e5bZrmDBFJFLpsFwFnjpCuKfwOMAmnas
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEyMDAzMSBTYWx0ZWRfXyBJmCOV7uDOH
 YT89o0K+zLRMAzSIKGjmaJLFuuqbIeIB0q/joRjzMA0g70gG/PgPKOnaeQMQm/3XSoEbYZzLDuc
 EuubYK0RPZV75t87q94OJatdrMpolSmQwBHRRi0TTKqXvieXRPh57suiyFLJY5tMPf8GJgbzLgW
 AHuyWAyZpxojCe5uz3M70J+jgG5QZAiWYt19BMM2x+VsuGcpazCQrP3t16js4X8wOHUytWseJjW
 rLTQH7937Ej/mby0UH9xGxFafyNM0AZy3zhsvAOPIVm7PW0QTdQ/PbGncCABDH71tRc+Ba/lpl6
 FZmViILIeu/dLQjGdWfWfU6bsFHYGfoHj1ar0v47+MXFfWUsWWoDfU+RHLdsXMvsEZS46h4Xhyf
 T/b/h8YLuhJwd5MhcP9dFtqiGt7dRt/tScuswHO7QxKNCZb+z1Pn5EVob0MA7Dn5xRLw0Jk33sJ
 BBVWGY3mSLrWyMvQXZw==
X-Proofpoint-ORIG-GUID: e5bZrmDBFJFLpsFwFnjpCuKfwOMAmnas
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEyMDAzMSBTYWx0ZWRfX+rhuB557f4JW
 rfVJGk7BZPuH9++Ky7Jilv4mFwH8fdp9jjBOAGyjgMwZf7hO8cXx/E/va9p23J02OEcirrVcFOu
 UQMBfOPDmvdndw5yIH1EcTVTx35Tl+A=
X-Authority-Analysis: v=2.4 cv=ct8OAF4i c=1 sm=1 tr=0 ts=6af5730c cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=ZpdpYltYx_vBUK5n70dp:22 a=9R54UkLUAAAA:8 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8
 a=r-nYRLqk3h2YVGBGkBAA:9 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
 a=YTcpBFlVQWkNscrzJ_Dz:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-12_01,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 clxscore=1015 phishscore=0 bulkscore=0
 malwarescore=0 impostorscore=0 priorityscore=1501 spamscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611120031

On Thu, Nov 12, 2026 at 2:41=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Mon,  9 Nov 2026 23:30:06 -0500 Myeonghun Pak wrote:
> > mhi_mbim_remove() cancels rx_refill before wwan_unregister_ops()
> > removes the links. Bringing a link up in between calls mhi_mbim_ndo_ope=
n()
> > and queues the work again. With the MHI channels already reset, the
> > work cannot refill RX buffers and keeps re-arming itself, eventually
> > running after devres frees the context.
> >
> > Use disable_delayed_work_sync() to drain the work and reject later
> > queueing. Probe initializes fresh work on rebind.
> >
> > Found by a static analysis tool under development.
> >
> > Fixes: aa730a9905b7 ("net: wwan: Add MHI MBIM network driver")
> > Cc: stable@vger.kernel.org # v6.10+
> > Co-developed-by: Ijae Kim <ae878000@gmail.com>
> > Signed-off-by: Ijae Kim <ae878000@gmail.com>
> > Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
> >
> > ---
> >
> > diff --git a/drivers/net/wwan/mhi_wwan_mbim.c b/drivers/net/wwan/mhi_ww=
an_mbim.c
> > index 336f89756f10..3b6b0066f673 100644
> > --- a/drivers/net/wwan/mhi_wwan_mbim.c
> > +++ b/drivers/net/wwan/mhi_wwan_mbim.c
> > @@ -650,7 +650,7 @@ static void mhi_mbim_remove(struct mhi_device *mhi_=
dev)
> >       struct mhi_controller *cntrl =3D mhi_dev->mhi_cntrl;
> >
> >       mhi_unprepare_from_transfer(mhi_dev);
> > -     cancel_delayed_work_sync(&mbim->rx_refill);
> > +     disable_delayed_work_sync(&mbim->rx_refill);
> >       wwan_unregister_ops(&cntrl->mhi_dev->dev);
> >       kfree_skb(mbim->skbagg_head);
> >       dev_set_drvdata(&mhi_dev->dev, NULL);
>
> AI says this is not enough for make the teardown correct:
>
> https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261110043006.56681-=
1-mhun512@gmail.com

Indeed, thank you.

Myeonghun, could you move the disable_delayed_work_sync() call to the
appropriate location, as described in the link above?

Thanks,
Loic
