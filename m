Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F81251A72F
	for <netdev@vger.kernel.org>; Tue,  8 Sep 2026 10:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788861779; cv=none; b=j4yAgJOkN84MggnodmarCsxz/3deU2qzfHVdFOcRghUlG0Cdawp0F62N0tHt4BlCHcWIdL6J68D0R1QPfqtmDxhHxrAxflI4zGfQOQ6X5tw9tSEGx3JT1Kei+hxZeOvQEBl6uaqVswORHTDS0UpxrBQ6vMw9xNh9Wumgoi/QnTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788861779; c=relaxed/simple;
	bh=nu66mMKWC73o/vxB4qVjJ6LaMbWAWzdLBk2oam+8eO8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V06stTTbDbZ4K9HgcVHlrUU2EDvLkwXQYJyaQ7SI48N6z3K4eEsYdRi1P2uPW7MArBx9fD+JcSmraUp4yQFCaxHI8iUnWzObqEEeP5fgWuN4F4YASiTPeFcQnPbXDQQnIiWZXnz5ooL8SEkAnMhl6JK44gIaWw5FdyMbLCiIbCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=htKLF1O1; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=KaSLhDGa; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="htKLF1O1";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KaSLhDGa"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6886LixZ1645920
	for <netdev@vger.kernel.org>; Tue, 8 Sep 2026 10:02:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=hRAvu4aI94s4uQ+esf+PyyrN
	kw8w71mQnH/4hgf3JqA=; b=htKLF1O13lOBNYC6cLwdnixMeOgCvTL+5V/epkaV
	blUgbw7g7doZydVZpM4KVw3uJKruk8AbYYE5RKFaiLZwVnwMsSRGUhKsGUcL+b2R
	9GcA9S6Y17bEk/OKoDusc2nDfnKUEIpqdS7qdJAyr0RIRHbXER8T6r9Q9H3yxMDZ
	6KZ6pBtfCKY94KpNl+GA5HPD/EtLeOT2RqrAuMuJ45xWKVqj14c7lQRDCdLpg9dx
	/kIERbObmdi/mR4OQsaigY0jk4tJq+uBGCTZaFE7GVFWr5j6NoekeOf1yllT54VM
	KXaI2dT3zOaQQXM3c/qyPfqRf84qRcXlZqkVX3auoAusaw==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gjcvugxu2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 08 Sep 2026 10:02:57 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-398d0010cfaso8533877a91.3
        for <netdev@vger.kernel.org>; Tue, 08 Sep 2026 03:02:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788861777; x=1789466577; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hRAvu4aI94s4uQ+esf+PyyrNkw8w71mQnH/4hgf3JqA=;
        b=KaSLhDGabWOML6vZnXzB6G8FL36NWKnbz/uFkPQnc2BgFqJLIgyEXQePXnTA8SZSrf
         3zx6mvLAJBDXt88E/5ob7TaW4zpgDXDIAEkC+gXzr1EignaJkI9gEhUYrWqbAEmE3DIH
         KjeXyiH5tEl5gB1Ylcie3WwqxoLajwJwTu0Qt154o89H62wK8M/9+izZbM0+3DBY+T3Q
         qlUYc4ySAv3s4N83u1OzGHGr9gvD9vvpulRHQ7Oad7iPgyLtgSBx3g2bwT67crdcm04Y
         Clwyi/MbEk8y+k8R2ivQkkFuCObR/h/l2Dei5LQlU9CmLegCg7zPfACx1IK78Pci7Y5N
         JK+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788861777; x=1789466577;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hRAvu4aI94s4uQ+esf+PyyrNkw8w71mQnH/4hgf3JqA=;
        b=EnpZfSxrtU5Dx1B8qMf2UCo5hJdGsfBy+sIJt5pB+TF8wDI0L7U/UPvBMXLvb4A6lI
         aC9yZH97BSqB1pHCma3IbsMyszUwlNWSIXGe77K5fIvP5U3/mKG7t5ydbwWiubkxfc5Z
         98fR4cQQupGUe7W3LWYf+qW5ElcqywlbQ1yTzDHlndOOAyr6JmKAiiI4+A0aL9bmKPuC
         vEeV03S/3b/rtcwhi5mE6nlZO0wVxDM4RQ34U/CfKq+3iZzWw5xu+f+6yvue+zL2xlQm
         6ln3aMxjBlZ1mL7E8nkkAAW4CQuWvnT49eIARrkKIIm0eBIq85shlHBnap0e3sSm11kH
         MofQ==
X-Forwarded-Encrypted: i=1; AKwUvBxxpwVwXJY2+3N31gCa4ELWRmPMmTi7xennbsjPbND5zL1RhwTxCaZQ9brgVkHzZ/0jTtrekyI=@vger.kernel.org
X-Gm-Message-State: AFuF++mHkXURHwDKsjJRlgFLeGEKqI2X13fuPy4wLJC+IwITVeBP1btX
	UVXu9M6muyFx1qiJPeaH4MaF4uoZIPRv3B0/NZy2ok9GIn1yW7a9BOVu/1MVRgpYRIbY0OS98ZA
	pbYxCwJbi7sHTRc0MBSVZ2iMvx0bknhL9GJ03viWCS2l6CDeINMZLG7hs2q4=
X-Gm-Gg: AYBFou3ig1YXE+wgIYTZ9LdvEzbbMv91nqG9i/ZnmvSqPqNqN5lvtCCrgkYwrYu9Umx
	psI2kOZmUeeBetPUXWWhc5KyN/EyjhBguFEl3xilrS8ziSAvaZgVUPkKkHlEYqJzjMZ5z1hkwXV
	7BSCJW03v7o5Lj0c6bFGZgWnHJBBrQL/FHFHR25ep+sexkLKCB9+Y6bqW4C2n27apWIcGuXyBTu
	0LVVhYWOJJdqSKVbZBWtLIASLuEp50Cw6uRXtR8UrEKqs4eOKrddjCT+0tgbSRqNbEXCtD9VRQ3
	wLWuaJXAbWib3MxE9Rh8rRfPgdjbjKgItKkG5+rtqlgKU1GVU888+IK2Y8zfYkyCxjol+y5jiVK
	CnMSx9WP/LfLcnA==
X-Received: by 2002:a17:90b:39ab:b0:398:9be8:ea68 with SMTP id 98e67ed59e1d1-39b261da75cmr43496176a91.21.1788861775470;
        Tue, 08 Sep 2026 03:02:55 -0700 (PDT)
X-Received: by 2002:a17:90b:39ab:b0:398:9be8:ea68 with SMTP id 98e67ed59e1d1-39b261da75cmr43496037a91.21.1788861774900;
        Tue, 08 Sep 2026 03:02:54 -0700 (PDT)
Received: from oss.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1434c745a09sm3818443c88.7.2026.09.08.03.02.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 03:02:54 -0700 (PDT)
Date: Tue, 8 Sep 2026 15:32:47 +0530
From: Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Komal Bajaj <komal.bajaj@oss.qualcomm.com>,
        Anurag Pateriya <apateriy@qti.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH PRELIMINARY 0/5] arm64: dts: qcom: shikra: add Ethernet
 support
Message-ID: <ap/dR6Wn6IhdROZK@oss.qualcomm.com>
References: <20260908-shikra_ethernet_dts-v1-0-69c0c5c7c124@oss.qualcomm.com>
 <e9388ffc-ddc8-456f-ad7f-1d185d35ab69@kernel.org>
 <ap+zd/2QmerMwi0o@oss.qualcomm.com>
 <c23369fc-84ff-4881-8327-c18fc3692306@kernel.org>
 <ap+3+Xhq6ygnPzQ7@oss.qualcomm.com>
 <ap+7oEcW6GONVdEk@oss.qualcomm.com>
 <c0e617f9-202a-4786-8383-2ce7567b7d29@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c0e617f9-202a-4786-8383-2ce7567b7d29@kernel.org>
X-Authority-Analysis: v=2.4 cv=ePkjSnp1 c=1 sm=1 tr=0 ts=6a9fdd51 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=2Yymz3qdJ2OcZe8EWdwA:9 a=CjuIK1q_8ugA:10 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-GUID: GPr1QWWTiE6D5tXuGT2GiygE9Ym8mO8C
X-Proofpoint-ORIG-GUID: GPr1QWWTiE6D5tXuGT2GiygE9Ym8mO8C
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA4MDEwNiBTYWx0ZWRfX/m58noV1Wn1q
 D6LqDbdZk6TU2PiyaODB0BYLuzV4guvmAKE8R7fvyHp0WTnz3FwLcKULuHJIqSnqrTdhHIxfi47
 ZXQNrlqgRJWBlN3UweLRNr3uDrGxjc0+rXqBpAC4lqJojqUeLhXDK1SUJBhagPnrASjRsZng/ai
 SatCRzTSUxrJBR+3raS9i3rX+RikDQftCXkmlMaQ4AmkLDnP2xxHA7DioTmG2IyU5+B2oS1MyQD
 aDFiOGOl+qlhgszHd63l6tDAb/BYbuwAHFTbzYyxHdzSdAybH2FKaPQM/Bu/wNkzIsh53dU8QmZ
 r+pGE+10bNUyY7DuO+qIjEUZuPvfcucodF3IUS7IjuVeyESe/voedzQC+dhUH/zpvZfiufjTWb4
 W1QYZoxAXF1dBcsMzO0tvW22fjQy6oxBLB/g8hhoXnKlA5Jtm1Jk7pZmR07OwBmdKctHIy/zmA/
 eRP3sUvIv4osETIUCAg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA4MDEwNiBTYWx0ZWRfX3SIBTPNb7O9T
 GTg+ineggpZhV1os2nqorjhdSPNBwnWqxG68vshZLz+vJhqg/dXSdFXpjTohRokIgV5RfQ7o3m/
 yx54aQLXBLMJK2GUQjoaijEQuXjOenk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_01,2026-09-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 clxscore=1015 suspectscore=0 priorityscore=1501
 impostorscore=0 phishscore=0 adultscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609080106

On Tue, Sep 08, 2026 at 10:42:40AM +0200, Krzysztof Kozlowski wrote:
> On 08/09/2026 09:39, Mohd Ayaan Anwar wrote:
> > On Tue, Sep 08, 2026 at 12:53:46PM +0530, Mohd Ayaan Anwar wrote:
> >> On Tue, Sep 08, 2026 at 09:14:45AM +0200, Krzysztof Kozlowski wrote:
> >>> On 08/09/2026 09:04, Mohd Ayaan Anwar wrote:
> >>>> The only reason I added a PRELIMINARY tag was because these DTS changes
> >>>> should go in after the driver changes and dt-bindings.
> >>>>
> >>>
> >>> DTS cannot go after the driver changes. If that is your requirement,
> >>> then original work is broken and needs to be fixed.
> >>>
> >>
> >> I should have worded it better. I am only worried about the dt-bindings
> >> going in before this DTS. The driver changes just add support for
> >> whatever we are desribing in this series, they can go in after
> >> dt-bindings and DTS without any issues.
> >>
> > 
> > ...would it be preferable to instead have the split like this?
> > 
> >   - This series + dt-bindings (on top of linux-next)
> >   - Only driver changes from [1] (for net-next)
> 
> No, because it would be against explicit documented rules in the kernel
> and against clear guidelines and recent discussions within Qualcomm. I
> wonder why did we have these long discussions about Shikra if only a few
> people were listening and the rest will be repeating the same broken
> process as before?
> 

Understood, thanks. I'll keep the current split (bindings + driver to
net-next, DTS separate for the SoC tree).

	Ayaan
