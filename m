Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98861513545
	for <netdev@vger.kernel.org>; Fri, 18 Sep 2026 16:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789750328; cv=pass; b=lvHvcNDELXgWjoQwXgJRvuYA56IPGGqnhcJCm0LRuO3yE0+8Kin/FpoZx8HgK5c5KMUpKY7ggQfQOk9M/GNj5u04YcJX/vH5vDK7opwPzzVpe2JWO0xOhPbLmPaymrKmouW1yx7JWd/0EUWDqTGEcsP8yQDPfBg2gVNTZ0gWqWY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789750328; c=relaxed/simple;
	bh=ggW8CJoWtogF4vp7qmnYr+2cHYO378fD70zSL4eILSE=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=gpwA40261RqGi2pQDeeXP1QIRoyVqpmDW4/70+BksCh95gUmjiqgSik6fIlOQ9jIROdjeaRqlgvVm21mBBUQ9/yfmAzlHqlvuqLTSEd9RvJ0n0GX3BC/DYIdAJnOs/rMvMVSWmHbsErgoPoO5iM0IfzQ8VYkSGFnSdWecnGb9JQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=J5kMSY12; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="J5kMSY12"
Received: from fauth-c2-smtp.messagingengine.com (fauth-c2-smtp.messagingengine.com [204.75.18.201])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jmtilli)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4hmdvL4LkZz4BKJT;
	Fri, 18 Sep 2026 19:51:58 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1789750319;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CFniBaOSSNu6ZtH5eqeRT+EniF5CxizeWe0To5zvrfE=;
	b=J5kMSY12co01Hcn4ACcIDG8Mg9EoEPdTvjQ/558JWUKFjKh/Uuta4tJghFg09M3HHnEURK
	0mvn4LamLShyCNo3xps/5p8vXXWxZdH+fEavHZNFP+WN/RK8VE5fb1ECpm9Kix1GNCSgXK
	D9ZsMiqlc/emnen2OK68+haarXABu+62+2K2CZPXbndNg1yW2AqgDGveLoQXzRdgzGnodX
	jh3hh1aHZLd7UsNdf0znBHLDJqlsaJlO+YD/g1nSBKpD24sPAvxdN8X1oxu4wXHNrnDnX3
	q67eXWyFY13iZcfcERol4sgoPXYnsBa8bDBnl7YVtq6jnYpH1z4vg/nPkoYdsQ==
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=lahtoruutu; cv=none; t=1789750319;
	b=evN8vgjd8E0i4hQFFT5Qo8Zp5GZ8tB76mpjgGapxABRlOd/3ZyUNYt/KYFVtTLOFL5SnaJ
	EBFgEj2HB831IMm2xW7i2LSkvIrnYJRgGKittdQ3C18Gr6Oa4dprLblYdaDpqrxesJYOIo
	lFNsPyJmVGBdXCy5RVDdPMZDI+89m5hNVw4SsNn7xCGG4MWxfsoveFOjGLlcK1Wburk/aN
	Uq0npu/fEDgAls70QBpKAdjrkdtmgxtmrwwLhAXKEhx4fV6kmscNV8LcjZoXtcn5Vd1nZk
	kngfH9Wm07KUWZ4Nwpb7ndtBUM6Xuen40rdwa1DXM3E+J11LtYdVovO5F+WtFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1789750319;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CFniBaOSSNu6ZtH5eqeRT+EniF5CxizeWe0To5zvrfE=;
	b=wI83Qz+aoTI01KYFSfyAN26Nuk49iigwSW0RpR44CDhwJX1a1z9292hQB1mESLXJYmymyt
	ZyV+Pwa2QZEgCJJevybaBSgGKOz9UNoMXQeiRmlYSjSI0+TicLlMdK/OHRtHmQmmMpPFcX
	eu1D/yhW0AITN2eN/q7ev4VDxaeKbnVabhB+6xbIFrWB2/KVuEC0iN+wzWQLC+uK7oDOsR
	mkj30jX9cVH6+gNDk0tSSirt4jZz4bFX+5u7mLvd/FIFY1G8L7bun5IKZiNcD8W4wdGf6W
	QxEXsNpW28mg5HHSiz0LHEY2iaXhLcmLzxMJxPovdL1XvydCMzgHZNhJg515cg==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=jmtilli smtp.mailfrom=juha-matti.tilli@iki.fi
Received: from ams-compute-02.internal (ams-compute-02.internal [10.64.2.62])
	by mailfauth.ams.internal (Postfix) with ESMTP id B1C91198004A;
	Fri, 18 Sep 2026 12:51:57 -0400 (EDT)
Received: from ams-imap-13 ([10.64.2.33])
  by ams-compute-02.internal (MEProxy); Fri, 18 Sep 2026 12:51:57 -0400
X-ME-Sender: <xms:KmytapBsr5nVa4ZmIXQgAUHhnxcugE7AYvX-BVSdRtLb2oVUesP23w>
    <xme:KmytaiVtidsR99LVGcbNAtdXQAYhwkcUG4u0grycuuQ5FPvFVWSMTBGw4_ZU8T3fh
    HAkUljZQ7wbGcNEJyIUYUTqIkJt-xYLCBl6z2yXoGXwnFfDEO1ZH4it>
X-ME-Proxy-Cause: dmFkZTGNcKeUoS6p/UeL/gMh5UWUFiVWwbx7ey0te+Xw5EsHIe1Jj1XU6ZjsITNOQ19Y+i
    VO3vGx9rSUSiH+cpHXFrz3vu5iYTny/gJtxLwbH/A9AzR8Y28HIgvPhmGgZWvPjbakCjL2
    N/asmkHvVR55YKiLvZhYMa8ulw8RrSp1bwaZQ30gIZBNOnaBO72XfV+QAA8qyaai2JgJ6j
    v1WuIKrPMLrpJoYn143VO76r03KpZy6s4dklI1gj6XxQpxS3xtcj5UTJEoXyFvpBZHDbXa
    saeU1eyzCus1XNzSNAQA2h6HR/HsRioTLJRfR9X/K7Fq0YTCvlqOn8VfTbE6/UOJBs8fcv
    NIonDAHwo64bLyPRkOI1KQ3Elyb7xUBnKjpoOAB1+IXONZETBHmbVEJ0QTzk7jRt8qR8yQ
    Z+U9yeeqKDFVw28zEXiQZd6qMN/w2modqQAR1FbHCE+FhfALnZ1WhwIzLQlEeitZJ1019k
    Ei2/mry44zBMp0IhyvZw95OZZshGs5VmrpXbBEuOcmbhjvu8Dx4VN5LfsJaq2+foI6E6HN
    DRXvPJkx24Ux1HGcZLPYjw6cRrWCIMnpYoaY17rorTQQ5WNW55oWBw1er3EuiwsZLuuL86
    OkSR4QXXmiH/HG3sQA6sppP8DKHzFFSOKec3AO/BSFgp3+ZvqWbxmvdJhv/Q
X-ME-Proxy: <xmx:LWytatbbSBa4wPl4UqfeGYn_EY5mEACuxOWO7uyDWJQM8F1Nn23bSA>
    <xmx:LWytaggNcoj0hVvts8pFL-SuQYlbvb0qK--o2GnDbvFPgdccSR69wQ>
    <xmx:LWytarwI76vUO6slFD6xsrxkI9YGluJ7sKm9vpfcVGz8GcOf1N593g>
    <xmx:LWytak87TJ9aR6FgmiM4xxz-EUtbf1jjkplUArwf7nReTCSfdJA4Dg>
    <xmx:LWytaozrkHyLbHBVUwu8yvRvxRwP-4_cmsNp0JVTE5oTWW_uyvTY24GF>
Feedback-ID: i02414972:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 5863EF80089; Fri, 18 Sep 2026 12:51:54 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AbqzItSRZteg
Date: Fri, 18 Sep 2026 19:51:33 +0300
From: "Juha-Matti Tilli" <juha-matti.tilli@iki.fi>
To: "Manivannan Sadhasivam" <manivannan.sadhasivam@oss.qualcomm.com>,
 "Manivannan Sadhasivam" <mani@kernel.org>,
 "David S . Miller" <davem@davemloft.net>,
 "Eric Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>,
 "Paolo Abeni" <pabeni@redhat.com>, "Simon Horman" <horms@kernel.org>,
 "Jeff Johnson" <jjohnson@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
 ath11k@lists.infradead.org, ath12k@lists.infradead.org,
 "Bjorn Andersson" <andersson@kernel.org>,
 "Chris Lew" <christopher.lew@oss.qualcomm.com>,
 "Deepak Kumar Singh" <deepak.singh@oss.qualcomm.com>,
 "Raj Kumar Bhagat" <raj.bhagat@oss.qualcomm.com>,
 "Jeff Hugo" <jeff.hugo@oss.qualcomm.com>, "Mihai Moldovan" <ionic@ionic.de>,
 david@3adesign.co.uk, nakonechnij.sergsj@gmail.com
Message-Id: <cb6766f8-54b9-435f-a69a-e712727dabdb@app.fastmail.com>
In-Reply-To: <20260918-qrtr-multi-ep-v1-4-8a06caa368d3@oss.qualcomm.com>
References: <20260918-qrtr-multi-ep-v1-0-8a06caa368d3@oss.qualcomm.com>
 <20260918-qrtr-multi-ep-v1-4-8a06caa368d3@oss.qualcomm.com>
Subject: Re: [PATCH 4/4] wifi: ath12k: Connect to the QMI server belonging to the
 device owned by this driver
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, Sep 18, 2026, at 19:28, Manivannan Sadhasivam via B4 Relay wrote:
> From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> 
> When two identical ath12k PCIe devices are connected to the same host, both
> advertise the WLFW service with the same service and instance id. The QMI
> lookup reports both servers to each device, so a device may connect to the
> firmware running on the other device.
> 
> But now, QRTR provides each MHI endpoint a unique node id which is
> different from the node id announced by the device. So use the same id to
> pick the correct server. Add a get_qrtr_node_id() HIF callback that returns
> the node id derived from the MHI controller index and zero for transports
> that do not assign one. In the new_server callback, skip any service whose
> node id does not match. A node id of zero disables the check, so transports
> that do not assign one keep their current behavior.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

CC'ing Mihai. He is known to have a platform with two ath12k cards,
but he said he's been busy recently, so his testing input is uncertain.

Also David and Serhii have found the bug at Bugzilla and may
be able to help with testing. (CC'ing them too)

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=218480

Here's the patchset in an easier-to-access format:
https://github.com/Mani-Sadhasivam/linux/commits/qrtr-multi-ep/

Also, I have suggested that at $DAYJOB we'd switch to a newer LTS kernel
with better ath12k support. This may take some time, but there is a
possibility I'll be able to finally get ath12k cards working. This might
allow me to test this with ath12k cards, porting the patches to 6.12 or
6.18 kernel. But that will take time (the kernel switch; backporting is
easy for such simple patches).

BR, Juha-Matti
