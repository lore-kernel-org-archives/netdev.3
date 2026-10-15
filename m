Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C74838E5DC
	for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 16:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792082258; cv=none; b=o3Jgc+uQH29J8ex9Hi9aUPC8yUPNP94tqIjhUMP1lo6ubLAqnYh5O51DkEG4+hK6JAWlvBWTDTf2wQgLQj21yo59422u0knFIqp9xq0g/aGUP4nQHyvyto6BU196euZMS49ynNVGNIlI3WKaj01iCF63Mu7IucuQK9PbRt6UC+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792082258; c=relaxed/simple;
	bh=ztVNH4vuSfVR3gj8fZ0vViL22IF/85VKkTRz2Wc8cYE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k6moIzKrM3BFVGoFi3dTHEL9F+GJYQ09zMrR+86dttWzhTK0wkcJzIHcWja7PZBGYUc21lnUvh/9stMJZowyolBYHZsSvl7p4O2MhnF+zbich8zc7lGM3/N5Sgiqqa/JAnNGpeqXA35x4l126Lbe9yaBtBDmOdXH+Emfui6dVhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RWgIntcf; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ADh8Qzgj; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RWgIntcf";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ADh8Qzgj"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69FFGWBA4077467
	for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 16:37:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=ZEBnHRPWcaOA/9dLapYt18AI
	Vs57G9ViDn2EaeI+nYI=; b=RWgIntcfs59WN3QZtzbBmBmwUKj6VRbjd1/aj50m
	BwVcHSlvviaL3CbhMRjymP70WkaCAyDvJgxFu9gfKAQT+yBgsdyTVxGhZhoW7lUn
	WrwtJ/IdJs+GyKzFhHgtWTzxJnZG2KYlg4bhRZeQvVqE5KbrBigmOfZoBn34YnZ4
	tImZalj+Cvq7NZEfEORYouxOHMO5RfGxBVLKJW8sGPQLQ9XpqTTHWdegvq+yi97P
	oQNNi7xW9BfarxLd4sM5Ub8VGm7Edn1KZpnIIEHJmfmeRMZzXnHeaeT/K2yNF2YM
	qedjggLhMttrn3MRABMJHL/dWThbXxva6DGxGb6Uho/USA==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4havbc1rh4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 16:37:28 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id a92af1059eb24-139b62317d0so20279767c88.0
        for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 09:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792082247; x=1792687047; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZEBnHRPWcaOA/9dLapYt18AIVs57G9ViDn2EaeI+nYI=;
        b=ADh8QzgjlByxyTn+u902jtgIjeYJ4mOYFESSVe5I3IiaWI+nI+s+F3EH4eeRA2ExRP
         /MWBmDAc2i45aN6tHQYB7HpkkVVg9cdY2ldSNQV4Vtw9nU617gvy5xuNG6kv4zIFRIWt
         ToAcx0hTkwuD7/RKA4nzTCAb1T1ivMgQofLtXZWxtYlcY6tJQR2BRhDtOv6P7IdePYP4
         hn+uOe+BpWjFVruBzzS7a0wCrcPuTvE/Lm1F4aCbfG654yCtj7hwcGH9GzRzjgAD9vkg
         IA1TDcaVp24yLxS2zJvfweRDEnS5p9hUQ97MjZhyR6FQRpvy/GF7x5Kz8A9cv09ipQd0
         JG+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792082247; x=1792687047;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZEBnHRPWcaOA/9dLapYt18AIVs57G9ViDn2EaeI+nYI=;
        b=2oLX9+hi+JHZAT9hF8l0yLUguGPnl7/1XKsrNEPsUH1qc2MHX9zuIU+hF2RgNJf1Lm
         yW0VFjxas7M8zfrFjtoNWmDsUd/f5+Fo5ovL4THpwyB6KRQ9Kvnz1Onb1TFqGSoOGhAP
         aRH9UCezCO8khzQw9l8JyyvOn1R4b9BNNp2XXY02c2Nq0JEjI18wXSFrE+f14fmmMIxh
         4WPg/jdnnDgo79vESXl0ld75E22i81jZOIQuPd+W1Io/GY2dz1ItM6XGaMjyKW9kfzjW
         vfF160rz4n3xKLIUaSyKNrQIT6BvwfjGX5xEbLL4/NTUAsn5npNzlbj57e62glW/9qfC
         /xCQ==
X-Forwarded-Encrypted: i=1; AKwUvBwN5d71aE0QxrY+ILyCrewonIFpIg3kTpZpB6jL86Ug6eLBCTZaToOmyMUC8px1g5zUbFiGFAg=@vger.kernel.org
X-Gm-Message-State: AFq9FYKUuRkY5Vp4XgkFWpdOsmuixjeNkwthSN/bLkx1HaNXk16IT7iU
	VzHhpxmFN7LeGH53lzz0yPtI01gSxwJsZabhoT7aEd02ooRROlWCAEQ8g301XXywmJG3IucNeff
	iKsB/ib03ypxY75QlDPb1nGL7w4YrdXhXjKaH6FP5i+qh7v2stqgHiQA1/nw=
X-Gm-Gg: AYBFou2HhIjbtTNC2wcV/V808puwYKDjbRhESyGUOa3BHh5ngUtwVlA/XJU8X09/ZNJ
	MBPjhDvOgw2KJqLav8m0+MUSjdzpFGguP5Dau8zJzkOprOZRunqQM9AX3CSnHqIPBHEJtVHJDmL
	m3V9aKJoBhWVCI5sxWZung0MkPAviyKgxnrJXIkEhV+jmB8CTz320j2el1ACwKv9qjUtoDyIp3q
	tmQwesAkHYemEHD3tsExxySFhIYD3XBYc/ctS2oTFma0lrxqMpbWhivuehIvcI1tG2iaUMsKjeH
	mxrBWwiLlpZ0nuQmWMa7bSQoXM/aymbBqXR8X7T0XcwL1LP8PyFkX8DaJ0E5YJaejTZmzHafc6O
	9hBOQYU0yHyWf
X-Received: by 2002:a05:7022:3b85:b0:163:cc63:ecee with SMTP id a92af1059eb24-16a65c03d19mr29504832c88.45.1792082247068;
        Thu, 15 Oct 2026 09:37:27 -0700 (PDT)
X-Received: by 2002:a05:7022:3b85:b0:163:cc63:ecee with SMTP id a92af1059eb24-16a65c03d19mr29504789c88.45.1792082246332;
        Thu, 15 Oct 2026 09:37:26 -0700 (PDT)
Received: from oss.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-182a5a2fb99sm116946c88.5.2026.10.15.09.37.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 09:37:25 -0700 (PDT)
Date: Thu, 15 Oct 2026 22:07:17 +0530
From: Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Alex Elder <elder@riscstar.com>,
        Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>,
        andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
        kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, hkallweit1@gmail.com,
        linux@armlinux.org.uk, Daniel Thompson <daniel@riscstar.com>,
        ansuelsmth@gmail.com, donggeunyoo.kernel@gmail.com,
        devicetree@vger.kernel.org, netdev@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 2/2] net: phy: qcom: qca808x: Add regulator
 management
Message-ID: <atEBPbpMtlmG+Mxe@oss.qualcomm.com>
References: <20261015143849.483339-1-elder@riscstar.com>
 <20261015143849.483339-3-elder@riscstar.com>
 <atDz2hJ6xpA3p5y7@lore-desk>
 <4fc165eb-b57d-41f8-b7b9-c9fe433d866c@riscstar.com>
 <1af4e7a8-adb9-41bd-8841-61180b284470@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1af4e7a8-adb9-41bd-8841-61180b284470@lunn.ch>
X-Authority-Analysis: v=2.4 cv=QbvzLcbv c=1 sm=1 tr=0 ts=6ad10148 cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=kj9zAlcOel0A:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=XObs8swggq2u4OB2KFAA:9 a=CjuIK1q_8ugA:10 a=vr4QvYf-bLy2KjpDp97w:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDA2NiBTYWx0ZWRfX8GE9njlHJ9QR
 iw3fmf49Lc7vx00tqcy7pIBeVCrz3D5gw67m5h2H4ZA+d9wX3hDiqbC9FFxDeALUXArQEWUjm4J
 Ar6aspjQuGtwWqw2ixjarmDZpAXmj8k=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDA2NiBTYWx0ZWRfX0cS659FY0Ktj
 tV0ILhNXgXfo5RIJrJU4Uk9Ucckp/uZU5H2f+1UVyVKO+VzwTqYvM/3uQ3lDWd6jdLEARGvD1/9
 MZsImMMKk88mtDpNtEJF8cgAcbzG45XZzk/Fp6eqqg/j6m872CI9JwF7qCXX7I3D18Oa77ZczEX
 3r3IbsGdWS01Fa1VIEvrzOQWrX+eNxId63hDbbG343Ntb/lhdpVRNhcuRfJ2p9D4n1ICSbtuxlu
 bOCZSI4iclW0oYthTLShbvrfvv8ZqXjZHSVoKksAVzLt6DYeCvXh+hX51TZqZDiK84cwIRYOyj+
 f4+vbA7lN4GUBae0///9+LxFsYs+Uf49KID4OJFgtj81NxGdubY9DXi6xOVTjfsyME7VeGj2HVo
 PDegzkl3pg3VAhwO7EKR1mjri/DS/PZqufZP6tyG2yfKFYnpLKqQz4xHmo/NpEHIWnmJ3cODBgq
 lXtzQU2S6a0s1bD0HPQ==
X-Proofpoint-ORIG-GUID: XkcBgq4Z02_Vsr0WsP60zRlWcX9qENBy
X-Proofpoint-GUID: XkcBgq4Z02_Vsr0WsP60zRlWcX9qENBy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-14_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 spamscore=0 bulkscore=0 phishscore=0 suspectscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610150066

On Thu, Oct 15, 2026 at 06:27:01PM +0200, Andrew Lunn wrote:
> On Thu, Oct 15, 2026 at 11:01:43AM -0500, Alex Elder wrote:
> > On 10/15/26 10:40 AM, Lorenzo Bianconi wrote:
> > > > +	if (count)
> > > > +		fsleep(phydev->mdio.reset_assert_delay);
> > > nit: should we check reset_assert_delay field is actually set?
> > 
> > Are you saying there should be an alternative delay used
> > if it is not set?  Do you have a suggestion for what to
> > use in that case?
> 
> Does the binding require the value is set?
> 
> What happens it if is 0? I think fsleep() is happy to delay for 0 uS,
> but does the hardware still work? Does the datasheet say anything
> about power on delays?
> 

I was going to share a text version of the power-up diagram given in
this PHY's datasheet. This might help.

Power-Up Sequence

1. DVDD asserted
   |
   |<-------- 10 ms -------->|   (required for external power)
   |
2. DVDD18 / AVDD18 asserted

3. VDD1P25 asserted
   |
   |<-------- 0.2 ms ------->|   (required for LDO to settle)
   |
4. VDD_LDO asserted

5. AVDD asserted
   |
   |<--------- 2 ms -------->|   (required for XTL to oscillate)
   |
6. Crystal 50 MHz starts oscillating

7. PAD reset deasserted
   |
   |<------- 10 ms --------->|   (deglitch time)


So, maybe just fsleep(22200) or something a bit higher?

	Ayaan

