Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=195.140.195.201
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792734716;
	b=oS61gEEm/wLhM1dESab+9kVk02TquoNCmA/xCO6hMW2KESwQmj1F2DTFC/0Of6eUKeB4
	 y04oTUUl6gTa9ySQ23SFbokv+/oCyuhFLcurFGqXruaABHzXngsW5UlfdfnwaEoSpa5tl
	 fRv6gMD6F0ctEXyfdJ1cxClmOSsrINyv5dAy8N2gsZOOxJmomGEf403Y/jKgKSqTlNgu9
	 pwNxWIjS6ha0E+iyirf0ZqLu9ZrHVioulZvJdCSEwSg37fvNHpt1eefs6oQk0Ha4lelDB
	 D5dhRJibp49oJtrwnVreA3xRqJEe+dFDsnPV+wOYbuKfQTKov0xfzQHsb81F0Nh/8qg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792734716;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:X-ME-Sender:
	 X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:X-Mailer:
	 MIME-Version:X-ThreadId:Date:From:To:Cc:Message-Id:In-Reply-To:
	 References:Subject:Content-Type:Content-Transfer-Encoding;
	bh=3s1r5gmalSPoDYnFT/d9Qqqf/FI59P/VjbJqXlAkQZY=;
	b=lfEF3xs9g1WvOmdN2OsScBI3Y4zUFk7vQm7vCyzupDJ6Es3wfS/JrXiS4fIhcU3KBrpi
	 L81+yFmKe7Fn6Il/FNeMKkJ79f1cBOVdxcykHQNibT/RNWvLLbBveh4nk3MSoo299IfeY
	 eU26PadzpYxxbLj0xSyt95X4PxA63H0uOZUkSx4YSZkW3q002nMCv0Nph+COIcR63VBXb
	 Jv9c89wn8wJ5wvgZymLLcMAia8CcASejaAH/LUUnZ+d/kCBRFNE8hsIKI/sUedasv2+hK
	 KDFwhl64KLP7q6oVFNP6DeGFbdV+8miIVpkROnRraXjznGZ94/9ImHGfFM7lZmrMazg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=iki.fi;
	spf=pass smtp.mailfrom=iki.fi;
	dkim=pass header.d=iki.fi header.i=@iki.fi header.a=rsa-sha256 header.s=meesny header.b=XjQt+Noj;
	arc=pass header.oldest-pass=0 smtp.remote-ip=195.140.195.201
Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8546D606A31B
	for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 05:51:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8546D606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=iki.fi header.i=@iki.fi header.a=rsa-sha256 header.s=meesny header.b=XjQt+Noj
Received: from fauth-c2-smtp.messagingengine.com (fauth-c2-smtp.messagingengine.com [204.75.18.201])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jmtilli)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4j9sbL4CGmzyQv;
	Fri, 23 Oct 2026 08:51:41 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1792734703;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3s1r5gmalSPoDYnFT/d9Qqqf/FI59P/VjbJqXlAkQZY=;
	b=XjQt+NojvA5vLZXlM6CafqE3OQNtzXVMQB9+lTfI4hXFu+ukmCz8JYXa9d9LWMCeQrH1sx
	PrExNO+u6vJP7AgFzKzZnwrS6fDaKgt5qh4xiqEwU3Yb17JMZRTAoNMTyuFo7Zje/WVrDP
	Mz9sidL6wtHyMjtD4nuplXCpZwh47po=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1792734703;
	b=xejW6Jrc8H+viRQd+M0WhQa4h9yvQQvT3BVNagdU6/v+uyUe07JyY6im34Sio0omdShKVf
	ebpAXso+5dSdxI9vpZKSvYN//rFIh3hwUwgANJIoQU9R/SRM5ZaJzvFxTfLNzBst62Rhja
	d2SKMd1R+/v02MR26LUuMH0XcxTXyrw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1792734703;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3s1r5gmalSPoDYnFT/d9Qqqf/FI59P/VjbJqXlAkQZY=;
	b=xBtgWaLkNBolpOnDpkKErDPXxxkitooOZsXQV0hb8sjFGpx9dPDK1doK4/xuskmCGr3TZy
	YL+KVmGreZOQrXtNkG0v9KWLkSHFfmuBwqXWzx81dpGVdyFgRHnr3PTJyNMcoqnFLsW3jr
	dhpw/6m+8uwBcUxusZoK6pfxB3T8g0k=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=jmtilli smtp.mailfrom=juha-matti.tilli@iki.fi
Received: from ams-compute-02.internal (ams-compute-02.internal [10.64.2.62])
	by mailfauth.ams.internal (Postfix) with ESMTP id 4D9A3198003A;
	Fri, 23 Oct 2026 01:51:41 -0400 (EDT)
Received: from ams-imap-13 ([10.64.2.33])
  by ams-compute-02.internal (MEProxy); Fri, 23 Oct 2026 01:51:41 -0400
X-ME-Sender: <xms:6vXaatT642KtAE2v1k4apwVm6NamCAP4qZad1MYMpBXOgct0ZHo5Vg>
    <xme:6vXaahkYa91a9gZcxJzj0c09mbJXjmINtL1EH_bTPfQaGg9gMal3MK-v-68Qj0pUw
    baOwpYwMlYTZa8-Fh_4aADHt2DMeZj3uNGakkgFats1Ksi7r2uEXY8>
X-ME-Proxy-Cause: dmFkZTEOAffXHrZ7qf6laLm8K4UbsibtaQ04Y9gn38XjIQYNxcrz1Fl3RLa0WvHT9IgL8f
    qdObnItt5VvnEY2RWOrGh2jX7lkuRrUqslrHFZNziA/waicBmBs/Hme0bulf+865fOwb4x
    9CBWLB9pEUueADEEuhQQZTCHZicvzh3QEYQgIojFmPRXbVpZMGPsP4hhdQnHnlwt/76gDq
    lvDkC0cycMGeRFvRBsLnLVifDAA8lkV/36iQIhdMaruHdM9MOUhvmBRwTxzagXmIj/mM/6
    p1sJB5qeUyCAnOAMvgYUgDQ7SViaOwtcMT39FBBgpxFr+Yvt3D5L6ockEezFFSFacCrBpk
    XIUDA7KyF22WlBmtpMfGZuNvzQ9w2WDJ1yRMgPpZmSHX+nQehY/UFMPx6cFDInfp9lSCWQ
    P26ZJdomAdRpVmSbDeIRINWnkYv6rZd0XYhMXqyT88pBHdZ0QnNNGSWfmEw5RXs21rJKbX
    NwazhetR1+6GCprg3W92qRBFlDiH1whcMpes+9BVaHjKlDtOGNtYIkBR44ph2RpYwXQz98
    vgfb9Sfz9ryDMcQsFcI/B8QUBwNLUVlCV6qXjAnEQN9M2vDFB/SAg1fagSxFb0pax8qC3c
    vb7YSMlJBRf3KiCx+HaZmbJwGBXVgnB/4ea4mwZsuxtysA0oFqL9uwi0wiWw
X-ME-Proxy: <xmx:7fXaasitCF0o1BqCXGpL7TphJjMJCnTKfuiOnHrxsaNaNq07zaplJA>
    <xmx:7fXaavhV77e16KeAxXc87D6Fm9oQJnEHNXwxxnfC-I-6HCcqE79RsQ>
    <xmx:7fXaahAI6u7cOzt30SlP5c-SlmBPzWtmu_hy-kBRPJeHhwQQ-tBlkA>
    <xmx:7fXaav-VEGeVbB1DbicfFvfSP2Euz0qAGE3w76yBkC-YvzVdVAbfKw>
    <xmx:7fXaaiA7pQZq931gK3K1yPjWGG-xF8S3qW0dlfRje9krjTn8YfVTsqiX>
Feedback-ID: i02414972:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 9A464F80098; Fri, 23 Oct 2026 01:51:38 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-ThreadId: AlBSNYy1g8DB
Date: Fri, 23 Oct 2026 08:51:17 +0300
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
 "Jeff Hugo" <jeff.hugo@oss.qualcomm.com>
Message-Id: <b9dc8c23-9c4e-448a-a159-434ccde72c78@app.fastmail.com>
In-Reply-To: <20261022-qrtr-multi-ep-v4-4-c6fdb75fcd3e@oss.qualcomm.com>
References: <20261022-qrtr-multi-ep-v4-0-c6fdb75fcd3e@oss.qualcomm.com>
 <20261022-qrtr-multi-ep-v4-4-c6fdb75fcd3e@oss.qualcomm.com>
Subject: Re: [PATCH v4 4/4] wifi: ath12k: Connect to the QMI server belonging to the
 device owned by this driver
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, Oct 22, 2026, at 20:43, Manivannan Sadhasivam via B4 Relay wrote:
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
> that do not assign one. In the new_server callback, reject any service
> whose node id does not match. A node id of zero disables the check, so
> transports that do not assign one keep their current behavior.

Tested-by: Juha-Matti Tilli <juha-matti.tilli@iki.fi>
Tested-on: 2x WCN7850 hw2.0 WLAN.IOE_HMT.1.1-00018-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1

As always, I took the entire state of the QRTR directory as of after
these changes, on top of 6.18.53 kernel, and with some trivial changes
like kzalloc_obj made it compile. Then I cherry-picked the ath11k/ath12k
changes, which had no conflicts now.

I have two ath12k access points on this router, both work 
simultaneously.

If somebody wants to test this backported variant, it's here:
https://github.com/jmtilli/linux/tree/6_18_multi_ath11k_ath12k_mani_v4

BR, Juha-Matti
